Return-Path: <linux-kernel+bounces-782704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54320B323E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E95AC81DF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE22274FDE;
	Fri, 22 Aug 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="H73mXS3h"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DA81E501C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755896459; cv=none; b=C6CQTEy4P7gmdi7yYgJFP9z9CW4QGepRPrLIc1/LItDpDNOwbFlH8BTRUe3len9EpBpdIckwBZ7TSu7ItraJw1IfjWLmudxByh4FxDjXheO4dziAxpX5IX8vtlbPU1sgse7pXI0oKtVE1mJPGZ05kzo/A5a1F4Wv81OJGjlb8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755896459; c=relaxed/simple;
	bh=dc0BRlBhZJ6Pbxv14syasrosEBaUEOhVgP0tc9NoHLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQV/OS0X6S2aTy+tJL/UCFY6UYruFBp4cgfx8y5SEbuLyhrFE34j9EijeWPx1hjCbMlngj5GvOQUuuUP3MKMQNgWBuq6dajxs+IOzGyLGHanAHw6n0TUS203KpQ8gLxjlOzzEJDmQ4YMr0WyHZTHqK7+t3Nl5pau417e1n/tg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=H73mXS3h; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b476cfc2670so1749890a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1755896458; x=1756501258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSm2pjQXpxCPM50Nuau91slBvEI2srYL3KvYFnBQXAo=;
        b=H73mXS3hop0KpzFO2a2dYccTVXmsA993jHRb7pisYjpLuEBUryJ3zwTQFdloihl47d
         X2zPJpqRsLEo2yBm3D9EFuQCsLjyHhyLZUS44z0+2W3/wFy5z1A25C3OX6prpwqIN+DS
         eJaX+X7tZVv1Fl7hkesviYXXHxZttjp0kd4XJMS4uQlBgRa2Zvc5GuPJiU9ox8jp00Of
         rDlSRSEJ6g9a1NjGzPqQznxa0f5cJCgf/33PLt25E6vKYg1ntMw3nXHx7AlSJmR6cSXW
         Irana3f1sBQU1vjOTbeuG9vkYqiyYCl8Qprk7MmxIFGV3qKgcazUJun64NP339uzOCd7
         +V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755896458; x=1756501258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSm2pjQXpxCPM50Nuau91slBvEI2srYL3KvYFnBQXAo=;
        b=qtpuXcaoo0eYzClyYnIFZg5SOJQPki1ifGGpoLWqDIFsX0FKhwXWNMm1rB4jGPwagD
         cQiBela3DrNnmo/TZRwkRDERSFG3FoNJTTMPzkKSBr48Re1p95/LtWRi6qBR5SKTWOWF
         xx2oskBbExP8uGwEi0H0pzei8zeJHF6LF/nuqVX/6s+TaEM4Geme9d6xtic7KwVdP27G
         taGtOJV4SpWRNT5JgK7zUvJahUTL8brRWjh8st+uerAnkj0MOKVPrXuhiFT3NbNDCGkD
         LgeMAHhoDTJyfyJsxSLQiT36BOpxInR3ibQ5DJSsbj7AG2StZXYEFMPCnfSVv/XtCJIp
         ZIow==
X-Forwarded-Encrypted: i=1; AJvYcCWD3KwFaaFMXwrABmvHAkesSl9lzjxLhOKG3RmIrfF06h20DxdtJ0TaGv4tMSBnDADMQZzzZFr/Ks3RbYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxubhuUgCWHy2ShXQ2fk3elv+d2BHGGyMvH5st1QVR+FMCkUwXS
	/LQy+0TD8jsr0gTbZTEm+78ClpElyPrrYTyECZeEcYWkeKYxt7oUf1Slfzj5lVV9Yo1JDPtJ+q0
	sbfHMboa4Tf5W1QSXxos2UglbpWnNcJAWK3psdKzffg==
X-Gm-Gg: ASbGncsfz0wGFtdohXOgGNR7B8liCnKEwApWojbH21yh6+vJP+gG1TOXiMIaWr8pQr+
	7cioxwr6EnLjXtOFHroiE+ag4Oy1CCbtuect50AwCHGVp/ZSjuF01fX8Spy09LA0lQrnlx4MNnV
	/g1x7OuHN2uADW6GHPbWVRWgxiSpVLBDnnHA8e3kgwx6ueE3IFIbyuU6vyJP6YVTwgJEfpPXXOp
	M1GrgQ=
X-Google-Smtp-Source: AGHT+IEK4BjS16HtEyFxN/8dn0Ogc8AzIY+cgBAZsXdJAbzTtuUSyKBmNNJr870kG/3FIaY8i4pndkzgJyPfrJt6lxw=
X-Received: by 2002:a17:903:32cb:b0:245:f7b9:3895 with SMTP id
 d9443c01a7336-2462edc449emr66279955ad.12.1755896457518; Fri, 22 Aug 2025
 14:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822123516.780248736@linuxfoundation.org>
In-Reply-To: <20250822123516.780248736@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 23 Aug 2025 06:00:41 +0900
X-Gm-Features: Ac12FXwOc1JOogbAORWWqhBQKksDiytp0VNRRIlI972IFt1EZD8UcTM1-UoNzCM
Message-ID: <CAKL4bV71GshkgN94LL55NCiDiXD-obrpzVoz4EkPRyP9paG-Lw@mail.gmail.com>
Subject: Re: [PATCH 6.16 0/9] 6.16.3-rc1 review
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

On Fri, Aug 22, 2025 at 9:39=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.3 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 24 Aug 2025 12:35:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.16.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.3-rc1rv-g3fb8628191b4
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Fri Aug 22 23:37:39 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

