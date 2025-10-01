Return-Path: <linux-kernel+bounces-838856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9EABB0487
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF453B2C89
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EE02E972B;
	Wed,  1 Oct 2025 12:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxmtHI7Y"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4152E5B1D
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759320634; cv=none; b=L/vcLZiNCWsewdxn634mvzijipppQGX5vBYY714S+FFU9VgwP39hokpmDGcftWI3mHM9My7Op6WCxIIcTkdj4yeqA/mhYCdRnZ6pG7Q+yo8sorXSdvc+fBKJg+c0tI/YZkU137/gHcLx5GkLl5ZPfgj6lODJIWgt/PewCPY4EL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759320634; c=relaxed/simple;
	bh=pvMGaqY63vMpQ2YYUKa3njQxeuJ6aYGwkhm8mUrKcsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk+FxsJR9OxkJuPoiBFpy+bPqipV6J2PSF+zMz8mD2XE3D0GCnmlaO+ReYdRd51676bWaYJsfGmI9uWfhYM9rSGxBevVQo6zfukzOZANdO0+M/xnDB6gDjeUGIti1ohTxZLi9orjpg0L9/MatlQ0BmG97/5FGjbKsXKSX7/Sz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IxmtHI7Y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso45430955e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759320631; x=1759925431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yt2/RiqsQaPl/L3x5B+o48QDSFj5vHrC7SC05R42/Fw=;
        b=IxmtHI7Y69zAjJ/ziiSmBhgdrCkeVRXMqEXyJy2a/Ix8jn1NlGTTQRWSKvc0MnQzC2
         cLtCM559tjNu2ckFN/xBUiBzhD5QQThxV7HwGUFDwrn0GPhE+kCJNBjvH62sJUBtuhDi
         YbN/4dx9pSOPIb/P+G2iYvnLn3fEVx59So7sMeiH/INXclr8csTh/IB/GwsoUAq5XTDt
         59D0p/liLSCx32xAXIBK7vqanTk5f2OunXaOHeMaiGItIgq7UDx9UlHe4KY3n2aY1s/R
         DZcBFsBIa1t1HWuTJZ1lNk+xsfve+rG6IXpClj513KxKybUHANqI9wgL5yrthLhsiTKS
         DLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759320631; x=1759925431;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yt2/RiqsQaPl/L3x5B+o48QDSFj5vHrC7SC05R42/Fw=;
        b=DVnehNgEPMC76Rw6QfkIPDc5w0f32NEIt3NQrN0JRDEFZrdSwh/QF77fFSSf/j9zpz
         dhL+JN0IHxZuyjaDXOYOHpf6blzr34ibnb7Js9MMUe8EdBnv3Z0ESrwtmGi4WGPmtv2J
         BUvyp8J2XrqGDMezZRIjz7dB83esatL2aUIFGSvTe3irCzRcIO5dISZMHiINURUpdEwf
         wikJGAcqfq5B74osFitq9e55oMDih7VcEeJZAih98pM40LGi/FPKPHbbKAPf+Xr8zLlb
         BCJUn283Hjn3LzpAthP5EyYEufyOEnzNrRnNoUlsWDx0n4VdRsqMf3UbldINTlbPOXOd
         4HVA==
X-Forwarded-Encrypted: i=1; AJvYcCUMilfqB/YudIn/8+wpzkICnfzLJ8lTUwQLsUsVQAipJbSthHLOakEK+KujpkgOkzEXbeK6r2xsl9d2E6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLm4NyvMBXds3qzzLpXC6XLGpIE76ZFui3r9sLV+kgwznf4ESQ
	OodirX6Flcy9y6Om2x6JngC+Ou5R31FVHSjeT96q0PRUftZ7G2mPGioybx8m/BTqZVo=
X-Gm-Gg: ASbGncubVW0jFazsOlz6KQfpeWvOjLyl7FZ8YlMlPsXLL1l96635HFG67WfRVcszShK
	RWFE/MOBSqF3ycdpadbaF0sie5CY+zFFzBvgBh2ph7fNC9Ohj2eGN+p+QF9QCwmyazRfkJ3x3yD
	lrG8iC4MenoEXfXPeSlfVzQVWBU6P6HOVwPGUKS0iqLD6V7ZdOtcvAePDi8gtC03Qhzy4dh/Rhx
	kQZDJ4Y5D9MZm1HRnntsYLP/S0Mk09JxOrIVv/nYtGZqLHyFMhY8IdbGGXigPTKbc5mbbmlYG/m
	I2Mf1dvSqwXzw3t04UL9Fl8ECrKVdRK1t8hO4kA/ITcnUsoEVEcciRXtkaXkWx32NfKK8kdy/6F
	ZWCYkadzzuAoLhWZ5+IjQk6NT58MgbV+4Nfo5g9dxOCB7VIimKgl4LIynLffsINQ=
X-Google-Smtp-Source: AGHT+IG4Fv3Ws0T0hfn9FRi9J8Hy8qhXiWqsQ+7mqBAvBUVbcM7w8H1ZOknsFTXOA3cvm76Wrim5lg==
X-Received: by 2002:a05:600c:8206:b0:45b:88d6:8db5 with SMTP id 5b1f17b1804b1-46e612192d5mr31099915e9.12.1759320630850;
        Wed, 01 Oct 2025 05:10:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fb72fb21esm26937295f8f.7.2025.10.01.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:10:30 -0700 (PDT)
Date: Wed, 1 Oct 2025 15:10:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org, Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org,
	linux-block <linux-block@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 5.10 000/122] 5.10.245-rc1 review
Message-ID: <aN0aMyU1D3N4WQy4@stanley.mountain>
References: <20250930143822.939301999@linuxfoundation.org>
 <CA+G9fYvhoeNWOsYMvWRh+BA5dKDkoSRRGBuw5aeFTRzR_ofCvg@mail.gmail.com>
 <2025100105-strewn-waving-35de@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025100105-strewn-waving-35de@gregkh>

On Wed, Oct 01, 2025 at 12:50:13PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 01, 2025 at 12:57:27AM +0530, Naresh Kamboju wrote:
> > On Tue, 30 Sept 2025 at 20:24, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.10.245 release.
> > > There are 122 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.245-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > The following LTP syscalls failed on stable-rc 5.10.
> > Noticed on both 5.10.243-rc1 and 5.10.245-rc1
> > 
> > First seen on 5.10.243-rc1.
> > 
> >  ltp-syscalls
> >   - fanotify13
> >   - fanotify14
> >   - fanotify15
> >   - fanotify16
> >   - fanotify21
> >   - landlock04
> >   - ioctl_ficlone02
> > 
> > Test regression: LTP syscalls fanotify13/14/15/16/21 TBROK: mkfs.vfat
> > failed with exit code 1
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > We are investigating and running bisections.
> > 
> > ### Test log
> > tst_test.c:1888: TINFO: === Testing on vfat ===
> > tst_test.c:1217: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > mkfs.vfat: Partitions or virtual mappings on device '/dev/loop0', not
> > making filesystem (use -I to override)
> > tst_test.c:1217: TBROK: mkfs.vfat failed with exit code 1
> > HINT: You _MAY_ be missing kernel fixes:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c285a2f01d69
> 
> You are not missing this "fix".
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc2473c90fca
> 
> You are missing that one, but why is a overlayfs commit being cared
> about for vfat?
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c45beebfde34a
> 
> Another overlayfs patch that is not backported that far.  Again, why is
> this a hint for vfat?

That's test output, not something we added.  LTP tests can have a list
of suggested commits.  LTP doesn't know what kernel you're running, it
just prints out the list of commits.

https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fanotify/fanotify13.c#L436

regards,
dan carpenter


