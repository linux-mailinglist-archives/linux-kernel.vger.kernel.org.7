Return-Path: <linux-kernel+bounces-838868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FACBB0504
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 672904E1081
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9332D0634;
	Wed,  1 Oct 2025 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhAQPDxD"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870522868AD
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321385; cv=none; b=H1VM8c5pcT50fzkLyP+J6PbtG0w09hRzXAGBIDTQP4nzJQp8karDOCzv+vZBqfpKp+dv48hOyAkcHf+b9c6jImhcHj2S5W1hU6PbUoxb67coZWqR1oT3JzwYQExsOmzCQEX+xR7Y7E76rMi3NnniglsXhJcO3yZA+Q2ewc9NVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321385; c=relaxed/simple;
	bh=jm7QjsEYN3o9NREvDIVoGhoSvlRo/JHErcAuGoWOiRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MK4JH3WwQXs0DFQEwpbPSMb/li6AY7j02nYshhTMGlSuQk6CsQTLEImPLKm4AdZia6atjsk38aTFt0ko3eAw8WRnnSzacvfJewLjPQVEhNQGljwdRvo9LHB+xX2u1tbXSFh1KZ/KTOkd8lw6ZMJMv4s9jM+ShB+DUHvFnuDQC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dhAQPDxD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27eceb38eb1so85102785ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759321383; x=1759926183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G6ekdHDmWVv9FcHQZlrQj5iI/vOkg8zYvOska5GK10c=;
        b=dhAQPDxDfgnqpA2S01DC+hFkGDJRYz3maVwiXV/VKcI5p+YhACTvwHXZLyb5sCHB0I
         up1nksKL+rcClHSn+vb7AVgYcGHNcYgEI3/cBU959c7+XgA/+yCCoQSyYp/LAVTUExus
         NsitKrWlltZd/w8x/BnWkyd9a9O+0jgAdpcWeeBdt/lZilo4RZGic1umn6IsN6gnbB7W
         MWTKrA96PgPf3iSkUWbW8Hz5kNiahCigYvLlU0BTAduyrZXo9sNhPgXTKqhTAoAn6ESY
         iM/g38tSRaBgdii0dTbqux3RpNyFBQ1cOE0mNh3ki2DAVPS7mbBpVzY3YQNcPs9GTY63
         0Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759321383; x=1759926183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6ekdHDmWVv9FcHQZlrQj5iI/vOkg8zYvOska5GK10c=;
        b=YJVzox9vXMiVd4bz5SdhkHoMSMdSWieTY7Mf5CHSs/rFkvfHKGD4pGUWd4XMIOyCoi
         KuEQK1KhgjaKbkny1URY2F2sT3U/RNMVmal/QtO+bFeZ8rIZkge/31S/AR0lSjvdnU2h
         +Bfv1iC7WLfVpMq5iSQEP6TB0PXdr2+oxItieJfUNBaYhOAD2WvwHEUCsVOX3xNqJ64U
         7p45G5oLXXxhMSCqgHgoqqgbxf/FBnHJqPLGmU4TsoGtWq3WWMOtgEmtnGwUjWIGeBue
         yxoRM4ZUkb9+oEen0DSrD7yAA66OjbykkVwySQt7K3bzdpFiMS9DBgj8S0PmRdXxHZsS
         wIKg==
X-Forwarded-Encrypted: i=1; AJvYcCVh9pd0EPR64s6U/PHpmd8mC2WPCPY+bvxr3BJQ5Ua046BJzQemg13dYKd6phLuWwoDOCLcvXl8zB9XBnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxONjUi+DQFEp4QEBhOTn0LcvIGH9PtrY3ocxTZxroIb54vIZAG
	+8YTb8jlQ821iZdLVriSBBYhVsciGtli24L7fD35wrImtdmBwRMMKc08E5fSyZ7YR4rOeUw0pA5
	yGMs6KIP67XK7aaN//BF0APCnjG9qABwP8zl8/b7uuQ==
X-Gm-Gg: ASbGncsYMyFU0mu5apWs7w3xUMf2Nav38rKcqsH3uuaO6ezyadmJUVfuTD86yxpmxBB
	+7ASmBWOt4VhIw2cxeH8wvAudGTS+m9yX5hnONy3c63i2g+udkL73FgQBVBrf2Kkwe6gc62T0xq
	YfXTQEzgNzx2iNp9x4QsVcdDBGKTYANgMlQxkOe3XbGHDBSoqB6rhPPE+XdE8aouR9ZdqV9iTZT
	VuL9ApRrbhb02A58SjtYdEO+bn/EPoamRh28wAoi30zXimBZYvjXeYL/JJ/rV3qJxZ6O9bauCDU
	i4DjUl6tvi67LAGy/0jb
X-Google-Smtp-Source: AGHT+IG3y0LpyILSJk25wSg4EzJQnje8BCP0qYej1zbXdtuiF/6h3Ys2FwvbgoPmiH3pc5MHl/M3OJoRN2I5jM7mBd8=
X-Received: by 2002:a17:903:1b2c:b0:27e:f018:d2fb with SMTP id
 d9443c01a7336-28e7f27db93mr43354285ad.6.1759321382673; Wed, 01 Oct 2025
 05:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930143822.939301999@linuxfoundation.org> <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
 <2025100105-strewn-waving-35de@gregkh> <aN0aMyU1D3N4WQy4@stanley.mountain>
In-Reply-To: <aN0aMyU1D3N4WQy4@stanley.mountain>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 1 Oct 2025 17:52:51 +0530
X-Gm-Features: AS18NWA6cyT7LVY1PGpPsb3wxOlSJ03i0aRVQJ0RG446XB-O0skidiXBbZlceZU
Message-ID: <CA+G9fYsRCN8f5n4dsbQAq73t7f5pzbHVT5Hp1rxYQzpxqvLWXA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org, 
	linux-block <linux-block@vger.kernel.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Oct 2025 at 17:40, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Wed, Oct 01, 2025 at 12:50:13PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 01, 2025 at 12:57:27AM +0530, Naresh Kamboju wrote:
> > > On Tue, 30 Sept 2025 at 20:24, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > This is the start of the stable review cycle for the 5.10.245 release.
> > > > There are 122 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> > > > Anything received after that time might be too late.
> > > >
> > > > The whole patch series can be found in one patch at:
> > > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> > > > or in the git tree and branch at:
> > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > > > and the diffstat can be found below.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > The following LTP syscalls failed on stable-rc 5.10.
> > > Noticed on both 5.10.243-rc1 and 5.10.245-rc1
> > >
> > > First seen on 5.10.243-rc1.
> > >
> > >  ltp-syscalls
> > >   - fanotify13
> > >   - fanotify14
> > >   - fanotify15
> > >   - fanotify16
> > >   - fanotify21
> > >   - landlock04
> > >   - ioctl_ficlone02
> > >
> > > Test regression: LTP syscalls fanotify13/14/15/16/21 TBROK: mkfs.vfat
> > > failed with exit code 1

I have re-tested for 12 times and reported test failures are getting
passed 12 times.
However, I will keep monitoring test results.

 - Naresh

