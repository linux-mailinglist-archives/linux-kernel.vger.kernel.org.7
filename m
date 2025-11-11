Return-Path: <linux-kernel+bounces-895280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6A1C4D68B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EB7189877D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69B3570C5;
	Tue, 11 Nov 2025 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="oCcHtpJ6"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE00B34A794
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860664; cv=none; b=r1RSHVL/+nUdn6xoyxKyiYwuRtQu9IYQfBa8EpFJGKxA2KnL6c3V6W7Dj0YTA8L7ZVgAmfzFea2VMpuMtl80y3jwmsg8w2j3h/DkR1CciHjpSBR4MnpxR3ybD0d8QVvqz2x+ZlZbgjnYCC8d1EO+H1eBWTst0L15E8iD3TcwQ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860664; c=relaxed/simple;
	bh=oGk/zlDW8GMau27Eh++Wjt6SdcJwmeKA0N5l5WwtFRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3kjIu4rjLas/LXHOztlKm4AwF0XT+gfy+j/N+4BS4gZhtnovbeINQSsRK7na1O1jRNmQ4BRVitTaPc3aGqeYDXP4YCD+evt5qI1eZHZzr3Zpe2fjdUKdyVGzLINkAipA2xHD08TnG+Nh9oIwC8h/YrCVW6EeouL0WzUaSUU2UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=oCcHtpJ6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-295247a814bso53749525ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1762860662; x=1763465462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buuCBtLu5sjBaUd1cQkdvhP5ydCgS09SCl514m5o+t8=;
        b=oCcHtpJ6T2/59bt7pig+DXIewO+kSjPsY72ixsHcyKayTISwvoaocEJkLodp01Npko
         hHfIuwPnUPs9cCa8cUHOkf9x/xSodiM7A7jJNhJZfgnGQO66LkUrsDgw+ULPq9fSDVou
         sja0i7WozvhMiI9pOxTtu9mA7TwPRebDRDsCMMCZK2GkED3CoLmtIh6GK0T0CIoaxbo1
         nopUEuz+Z0X6JJM1i3PFyENguIYnlHntHbRTPYeWIc3QId/g8shANvntlcg9vPMSYgPQ
         OY6tw29QWcdGgjzldz+qEz83YU1Gsf+dfIpR7d4h/S6KhrviJ07chLG0xL+dULviaqMb
         Nu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762860662; x=1763465462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=buuCBtLu5sjBaUd1cQkdvhP5ydCgS09SCl514m5o+t8=;
        b=a81CjksmcOnSt0zhdhlE2PXRsj7A3ryLEfqgIcgmjk8kOyX/2hXsiwsGC3AWmqCXWZ
         JSyoA4xyddcpctKLfDBpP7z/4HVKXORjOGKPjgzRB5j/thFiGmoqlU3iahxO3DVPJYdy
         bSfMKz1LF+SalYsKlgapDUDJhDGXuQ+pssJahwMC/A5XOXqYBvlVjdkVU/7U3b8kZmBc
         55Agd2aiKyd9Pt0cLDo7GYCcUaMa1XzI06hapnoCnVHxzjfg06xhG0GE/KyON0YmvCIg
         Uk258vwrb8Vn1WqbpFgUIsNvjACHHt4IY9KLbLn7A7j3iFNT4qD9zoY5l62z0Jlj708O
         EZHg==
X-Forwarded-Encrypted: i=1; AJvYcCXSY4PH8XIoLSAj8pH4qQAGLKFykg1tkGlq5x5OZAGcd+tm/LXDD5ijhQm/GC6KdNmBoAMnfCVjn691zwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiaUG9/myAzgD81JYrHZaWKwIA4w3DsbyTnGaJQE9MxiEhDXBZ
	MBMHWG+2e1AVZ1kxFmcWSr7K6BcPCw4hUkMN989Zw0TlyXIM5x+n3kYnhZ/Xlb9/sIquLELXzsb
	yN+dC0DW+QBcYStRQofSlxIFv8WjFvxaK8EE59GcYtQ==
X-Gm-Gg: ASbGncsPy0g6neVwTCqhH83bkC4G0rH94luHop5Ho/OnUhyZoLUVs/N3BJHMr1QR1J9
	yOtSL2X7u0AShDJAxLvNHpKOTVbJD66jTi7MgLogKJl65tk4JArS36CZCu32XBFPZs5EtI8yUAA
	J7eavbdB0NTpyEbFOSMumIVRU4vc6V/qAN0guv8EYE6k5V8FuHV8ovInC8XPtnvNhLjsicBoOG5
	Rmns+Xz7pGkKMDbjaxjO9//c0Fbr0nGlZRKnvOjk+xemqGtj+fvCf1F4yhstTI=
X-Google-Smtp-Source: AGHT+IHUdTUrobfYmqXo6iySsvYGHYHvfn+aYtawmVY7dBCZg8aZm/C88dV8apc+dpmQBFkcG8hKPnDtE6uO7icYMik=
X-Received: by 2002:a17:902:f702:b0:297:d777:a2d4 with SMTP id
 d9443c01a7336-297e570dd5cmr115319535ad.46.1762860662025; Tue, 11 Nov 2025
 03:31:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111004536.460310036@linuxfoundation.org>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 11 Nov 2025 20:30:44 +0900
X-Gm-Features: AWmQ_bnVvBCJCVRVuQAMNfJ_GsU_ylMILLdsbbKVvbUi6q-EDqMxAg2oZ8sVGHY
Message-ID: <CAKL4bV53PARj8x8zWf=h0MRg4yidX2SX0wH88fDHMGvC1GLuKA@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Nov 11, 2025 at 9:47=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.17.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.17.8-rc1rv-ga0476dc10cb1
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Nov 11 19:30:54 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

