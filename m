Return-Path: <linux-kernel+bounces-777780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC30B2DDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85CCB7B2D46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165992D3231;
	Wed, 20 Aug 2025 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="pOdG4z51"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ACA299ABD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696403; cv=none; b=KsxMpyazqFAb9RD1xjIL7JuI5LuxDqvzJJL9whH4qeCU4dmIAmkkFcBjgAC159WMvAcf9EyE8cpT5V7rnLM7+mfqnKqcpt6dKWQFKDzgTwn79V5whBZyWMGYDXpUddzPgUfTsdSalDRxl5vXLSFXttVE2Xe3cDoeaXeoaLJjFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696403; c=relaxed/simple;
	bh=0uRCBa5DuHokeAP8b7en3IxnvVTDcb0IQO3SjWgln30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDJx59sQHIrnQO3XCONk7gEzVYT5bePp0rxSgxZfxDKu27ncRDI1w/9k7Sj9OvkctaKRQTytTLLNftPsrQ/izlRCKjCD18tXv3fT5eP7ipmMUh7+hqsOx9FIgnrhHwObkbSZejs360oX2AvXgT/vKSdD/0Nd3a9KgCgyS0Rrwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=pOdG4z51; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7e86faa158fso126700685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1755696401; x=1756301201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pduMkEptKdLVMmJZmH218CFcitvFhjXDFeo33s0r6g0=;
        b=pOdG4z51maqCFMr0MGgLrkmLFuX4Kh1avl6nMKVdnASKJNgcoQnWPYbavRxB1ZvxPG
         I54hOE3R7wtVuSVuHGdxNIe2ugEzeeS+Wsl+DjUtFyTFlF8MJX4R3B0p/TzLxbDLpl1R
         3M/rAE3OpXth6bdLMJR5fJIIcr+6biAWoGNZ2cg+AkW6F5wpZEaoYiTov4mPBZ+uAeJf
         qpovgPSDqkB9VWdvZKXu6l0HMC8ypu65xsTQGbI6wTlePw8wO24G3ST9AT8lTKI7e8R4
         +H2IsfLb1hLoreZMQmi84KRed/orLpleyWmuY2Mxw2BxEyJT3T93rHqMd+LHcUD7z+A3
         g7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755696401; x=1756301201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pduMkEptKdLVMmJZmH218CFcitvFhjXDFeo33s0r6g0=;
        b=FXLli6GtOUoqf6i5pMajXw1Jq81ef9ymIqM2wJaKY1NYCdSgSb9hrelbqLq5uWKIZG
         s4xJtrV/uS1+3/klid4k5LJaItfhfDD8dJ1MyHtYrq+/0qzc6rG76qoU3ICrdaD0DjIm
         4/xvEqylA/ak88GqI/wHJyoruCrmsUu2vVAC1tTfwCVmv7Sq5iMSjO964Xv/eX/dVsk+
         ALde2Z0nogWHj+EduVVC+624UDdVaUm6IMRNCivb8toBQWjrGdA6/WMbFjv4hrZePKSw
         u78vbY3pVeDiQXGDEY9RJdEPSsAdI+okuHCNhYxEEi5tBg3LDzz0Wg51E4jM1M3kzQwT
         xWLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO5+kYayU966w8NExWFonN782pqgopnv7ENKidNogH9NC9ikRYMvlY2nAA1DLH9Tw1F9WoR2zs2nddnVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9StC8D1h31/icRZTsVEHHYrr4Uo6TpDSzCzwjT+o2GoiodMq
	mmEy9c3IB1fp4qS/thXEC/V7RnZ9IcGYDP7YgCXXC1upDZ5JU/KHNUNaoBZWjEQef/DZXBDM21Z
	IfXFMzWruqonAsHpon9wrnVFokFQKZdS1+RKB4NS3og==
X-Gm-Gg: ASbGncsMfLuLD6jmxIJ/PLBqJDVTTQ5gG4yc3PbwrEBs2kf7r3hpIJi0OS/2OaDJsQv
	FkpYBiv4mLK38tVlUm2TmpguJzI9/u+TEydKbsj+D0nrMuCzusIRSBiLhRK+kWOrNFJDJYQiAjm
	VTjmFc0LxTw5jkVoiwlTvvSBlKPG1dNyLfCs1JMAeGlLUqHHoSfeOfG3VygQ/UscSuXo5Xz5fgp
	t0L/cWFJCM3mRnZydU=
X-Google-Smtp-Source: AGHT+IEFuP7zEWHJoh21HjBk2ylXFPhv4P+z+9swFEB6pv8mUDeiqmBE0z39lKhQPdd5eiXvNYtv0J4LLfK1tyaY6YI=
X-Received: by 2002:a05:620a:4105:b0:7e3:2c53:b28a with SMTP id
 af79cd13be357-7e9fc7585acmr318667185a.16.1755696400716; Wed, 20 Aug 2025
 06:26:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819122820.553053307@linuxfoundation.org>
In-Reply-To: <20250819122820.553053307@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 20 Aug 2025 09:26:29 -0400
X-Gm-Features: Ac12FXzu8URN-aar7Ixa8xJWtMgHFMvicrS2nfeoiQQtmUGUKz6HliO5RbQkSeU
Message-ID: <CAOBMUvjakzTF63pwX0_GGswgKR+0TT=V4gPVZOOBuBbESqsbpw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/438] 6.12.43-rc2 review
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

On Tue, Aug 19, 2025 at 8:35=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 438 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 21 Aug 2025 12:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.43-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

-rc1 and -rc2 build successfully.  Boot and work on qemu and Dell XPS 15 95=
20 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

