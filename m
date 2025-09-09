Return-Path: <linux-kernel+bounces-808390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3F7B4FF26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901B1171BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C15345727;
	Tue,  9 Sep 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xh1Vgjf+"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D334164A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427512; cv=none; b=SKxgRoS7Mlc3uksnB9db4rBEDSuOOrqTzXGXcSBWI/zstC6HHoLfD/d3JmRvDIsrEdz1ODViTNY3feTD30sa7WBtCiXMmaR2T8G9EE1EUaYmwc981QQy1AoqmNw+d4O8tNIrRhOvu7uavuKZo7Xgbn6BdbiBk+zd4UmTlHbkUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427512; c=relaxed/simple;
	bh=VwaGSalmTnd9X03Tr6wOBFfCuOTcCNXRJiR2HIPuqsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4HTzd3qLDPY3p4ko2Fs3tBrk2KkxXy5nxw1U8ZCxEhvqezhi0aNbljxFfAUC+vyFk4JDgVCqzCmRb4gA04orH0Myw3m42opD/s6aBEC5AmWpYggFds87q+P36uV81irHLH0zYBUEcNQplOjoJ2DVQ9ggKFsxORYGvygOtx6PQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xh1Vgjf+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24b21006804so60966725ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757427510; x=1758032310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zoeLKoDwjK6xqBtfTeAvIy0pYPkAc80c1vYBt2cZKrE=;
        b=xh1Vgjf+NbtbDO0fjTB5rs5XFdKUDOFSlJ3uMXWcR6F7qCXb3nlgN+NVnfOKfwmGSu
         ktQAX4IZ4HtMODKp35aqQojNe8pqkjijjn3kx1LZyP80JcmpWxa07ESqoKfEGWD/6E6K
         gyuoQ4WzZrVSiUbOPWU4VFBQdZVLA3UT0nZZjIvRiaXcuCRSOrtpDqqZHcCYduhHeLoJ
         tPJbXZ1lVYiLCsAXvzktK1DWRlHSG9aARr8oFgkUUpHXknCayu2QTwQqt7lCjPHefKeu
         BPwWJWLwSjcmqKM5EYBeMK266GKUsCimsaz+/nNmc7uRdBE3eNza53dEPpnDF9ldP1rv
         uO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427510; x=1758032310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoeLKoDwjK6xqBtfTeAvIy0pYPkAc80c1vYBt2cZKrE=;
        b=FdJxIGvVZUEB2LE1rJENVuYrHpIMlAqMimAlnvjsGnqnnF7ihYwc24xpl+tb8IGyR9
         YNCVnc4dilBdf2rlGoXgFBvBzGzfN1rBVO4SNyv+yonAQMtRRdhxA6Qa3W2gY9+qdSms
         kK1U3FesIy0YarXe4iQ8LMwj8pR6JIKASWN5T99iQtv/VTILRwDg9kjttmImkbaE1ysM
         gytG8LvuULVQk4Yl76xCAjcfLXca9MJ0nFmvGsH+n2du2WQU6UQGtWSLV34ow+PRhux1
         RNvLWA6TER5W6LKJmLcGCOduC2HxNzCWmmRYeIuFLZJ/W3QTqKx/UQJILnHzSIoxIXmP
         LQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCW/yqTyDtpNxiNtkQbYko4lQK5SuCjSaWAEpA8xYVBm86kI7y5pED1K5KpmCyWkwx18yguGlMOGxK9xqC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrD2oP6A8QFyIKJgJ3qNKpcEYPkr9MabE8/NQ/FNiSlJt+ZboI
	DknXy+vDmOFytiz1uqMkZa5QYdai/6eh0iYNalDu8yJn6IRgDUQMfcYMaVZ+h7r2debgqZTxKlH
	FFjqEBucCgulqKJLukCOD6pifpvbTDjo0iq7d+BuAbA==
X-Gm-Gg: ASbGncsi50zyujz/XRddLtYopU7uks+iVPv3j9Vb7sWxr1n35jEu1cwwg/bEjMvCSjY
	8B2E4UUX4AcPnZ497fHv2yMCfygg3Z60sThHvClpRLM/6Q9x2YSA/wnIzlQ+k2qjJA7KSxlj1bq
	/2i0NhK8EQtK5KvZorYaUZZElUUudnznNAt7ClkWoTy6meDvLkGxrZVykw7ruiVf7GPSXm7HBdC
	3nnbUuw5J7pRRTgJ+Wo7wcGdYYjGKegT1YgE0pFwc8SO0D21k4hG++DpsWd3uwIY4ltqqITTCoQ
	bXStLJc=
X-Google-Smtp-Source: AGHT+IHh4HOPmijlA/45Ds82kWFJee3dfMdyV+TppiDj9iodQ/RUx1HwiEqgdvNxgEwgPGcnXfLB9BNxwH16jvQOjmI=
X-Received: by 2002:a17:902:f78f:b0:248:ff5a:b768 with SMTP id
 d9443c01a7336-2516f05021amr131781565ad.10.1757427510278; Tue, 09 Sep 2025
 07:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195603.394640159@linuxfoundation.org> <CA+G9fYvQw_pdKz73GRytQas+ysZzRRu7u3dRHMcOhutvcE4rHA@mail.gmail.com>
 <2025090948-excuse-rebate-e496@gregkh>
In-Reply-To: <2025090948-excuse-rebate-e496@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 9 Sep 2025 19:48:18 +0530
X-Gm-Features: AS18NWC7gkmQdU-chaPVM86yKMvcaA9k41BDjODWDxD3Fa_J7L_tblddsNpoFN4
Message-ID: <CA+G9fYvXsG1veoK-i93J2BgymNauvOU_FpO6d7BhUBnMkuZVCA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/64] 5.15.192-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 15:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 08, 2025 at 11:54:56PM +0530, Naresh Kamboju wrote:
> > On Mon, 8 Sept 2025 at 01:43, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.15.192 release.
> > > There are 64 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.192-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > While building Linux stable-rc 5.15.192-rc1 the arm64 allyesconfig
> > builds failed.
> >
> > * arm64, build
> >   - gcc-12-allyesconfig
> >
> > Regression Analysis:
> > - New regression? yes
> > - Reproducibility? yes
> >
> > Build regression: stable-rc 5.15.192-rc1 arm64 allyesconfig
> > qede_main.c:199:35: error: initialization of void from incompatible
> > pointer
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ### build log
> > drivers/net/ethernet/qlogic/qede/qede_main.c:199:35: error:
> > initialization of 'void (*)(void *, u16,  u16)' {aka 'void (*)(void *,
> > short unsigned int,  short unsigned int)'} from incompatible pointer
> > type 'void (*)(void *, void *, u8)' {aka 'void (*)(void *, void *,
> > unsigned char)'} [-Werror=incompatible-pointer-types]
> >   199 |                 .arfs_filter_op = qede_arfs_filter_op,
> >       |                                   ^~~~~~~~~~~~~~~~~~~
> >
> > This was reported on the Linux next-20250428 tag,
> > https://lore.kernel.org/all/CA+G9fYs+7-Jut2PM1Z8fXOkBaBuGt0WwTUvU=4cu2O8iQdwUYw@mail.gmail.com/
>
> Odd, I can't reproduce this here, and nothing has changed in this driver
> at all for this -rc cycle.  I see no one responded to the linux-next
> issue either, so any hints?

Please ignore this allyesconfig build failure for now on 5.15 and 5.10.
Seems like it is my local builder issue.

 - Naresh

