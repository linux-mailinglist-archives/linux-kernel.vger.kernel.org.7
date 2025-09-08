Return-Path: <linux-kernel+bounces-805007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69279B482EC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A1D3AC9A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEFB215075;
	Mon,  8 Sep 2025 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="FhL8Ol9d"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F8319E7F7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 03:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757302895; cv=none; b=U1Lg6LdHT8q43JXBXfwcErWNnyqd/aisdO9CNPC91t7HRVcqeL+GLGhFnNRW7x++CeXFhFWQUoQU0blto2o5kxbX5yv4KBz+lHLvxMjc4eT1plbZ6N1jK9GZlypgTSMJY0rHwDwtRHb+swRjdhZRwVu5B5AxL4wUEVD+ejqccnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757302895; c=relaxed/simple;
	bh=FlRezqGlNzRwo/eQaMve/P6wVjIVJ17qa7oQA0cRpLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxttU+6ssZGTx+49AX6bOtnRb54FqQIBeSLjCJ26xiUftLzdhg/6OmO+TskxhTxc+2BgFosXIcf5oMHi6PE0lb8Q4ZyMGfiv7zqKXnUIqape7mqsnk2m8tJo8gaFn/OGW3dhUO8VzASCusmZxUijMj3ZunuY/egQYQQ6cV/35jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=FhL8Ol9d; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4fa6cd2377so2530978a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 20:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1757302893; x=1757907693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6Z8zaRh25HsvwFwmLDi9HGVEV4yypZcSaE2HnnfjeM=;
        b=FhL8Ol9dM+ZIgGmMwuzsP4Tv8qIVwya7JHjIx1nZyQQKKJZh8mDGOlxNc3i5kxXgdr
         XJmYG9X8kT5KIWMaIUmCfOZlfsfP0//JwfY4aHFAjCyKXkKg4x8WvPYvYnj9ONEu4+xL
         X+hjjhyUSZaVMmTdlorIXD+oowhrT7Nxjcb8bY0Ag+72W67gBc89jZP27Lew4cxj6LgU
         JVk4hcFSAHwq5hdm2AyB5lDMJNb6bYbUGgR1friiNw55oD4h4LHDReZSVLZ4QxYOqDCP
         +KWDmR6D+cAKJQNoBG/U4SLGLczu2NqQS2EjYeZUVYhvslBx+R66zlrkNA8L7Nil98RF
         2x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757302893; x=1757907693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6Z8zaRh25HsvwFwmLDi9HGVEV4yypZcSaE2HnnfjeM=;
        b=NdJTQcb8/0jinKcLGmiOm88K22Ab+nfbcf1IJaayYKMTBbkYWhNwAtviRDxBjTwf9s
         vk7cMgelPsTAzOOviYhYd15t6jxqkNsVaTIPhotQfCI586rjORg1DNBXPNMQgpfdfN1d
         etOxxI5CJ4XPVm5TLf8Og7BThokUvIuehcMU7YuASp1hJXsf9oa5vCgz+OZaQ1Zh37mr
         UaZI3pbhpGiwIObF3rsaXn68k48Q/qfToLl8hOcauG3qa7n1rumq65jh6C5jWLRSi4nk
         53KAY6DJ+ZqBkWUzDbT+5RfBiN1AaGDkFH0KqjSLl90PLoVJ7k6plN9DnQJuLXKrSOIv
         o+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMWQ2E/vcKm/A7JeOLfzeY/Q7rkDhOFW4omM1IrsEFx+kfoAnfg/QgKFmq+V6FVMw+QtwszF4CY6dhPD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJVPl+3pD5JvWK3pLV1MflBqSn6hUMJ08z508wWpGb8T/RzK04
	g/xMP72GyblwXKMtNLcA53WuKHp4ZykfN9VKutBPVXSJjjFuoBHgGxwEzePRkP1T4TOVsy5eP58
	R+kAfMwMze1DM1Saa7I4B5v5QQuxOIScsfWC2lRjcpBVTJWJPPmdjlYg=
X-Gm-Gg: ASbGnctaEY5azmScoj+RS1NUjtQcS6Jtxb72mS5Lgnj/vRHthpn5BLmnL2Uf4l0OLjh
	E9XWlV9zOjbjdw2WVf16lcNze4boIrfN3yuX8r8qrSxnrXG18VZPWTt4z6ckBSisjorTK4DTVNe
	vwM4rWEqD8SPd/oalXEd6La7Oy7Vxbl+gsrJrOydrs7OEjCNp3Djh/twUAILUY48i7N706BSzhP
	UQqsM3O
X-Google-Smtp-Source: AGHT+IFEijA1F2cyMlEG8dJZx0or8k5xZbxobkL5zQPTFxwayqkrYZYJ+tsFu455csFDZ1bmP4sWayZ0f0NIhk8/C3s=
X-Received: by 2002:a17:902:ebd2:b0:248:fbc1:daf6 with SMTP id
 d9443c01a7336-25174c1a946mr92202915ad.43.1757302893478; Sun, 07 Sep 2025
 20:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195615.802693401@linuxfoundation.org>
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Mon, 8 Sep 2025 12:41:17 +0900
X-Gm-Features: Ac12FXw1Y1FbZHyIhDFMEyNA6f0UWtK_eXEwjIPuuju3SYeQdj5KpDMQrKsENTM
Message-ID: <CAKL4bV7O=GXXAujmwHXPFuBBd32Vc38n528qCNGshFQUHzHK9Q@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Mon, Sep 8, 2025 at 5:37=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.6-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.6-rc1rv-g665877a17a1b
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Mon Sep  8 11:19:48 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

