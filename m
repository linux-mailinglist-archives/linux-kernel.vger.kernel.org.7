Return-Path: <linux-kernel+bounces-701511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 832FFAE75DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 06:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5CB7A2249
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 04:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367801991DD;
	Wed, 25 Jun 2025 04:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkphe7Gt"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED015A86B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826017; cv=none; b=M4VND+DqfOOqQmRW4NV6Jl6upRWnkHJDXYTFyQbZtE2qxUsnVa9Vriu+JBWx9DKhHvDx7kx2OMQoZ3BRqqsSR55RCVuT5tJ+Pd9WOk1LgIevITjAB2WefVsiem1urJPvBSB7MJmVe6XZKp8jwWU1CdJGP4matSeR3CcQXfjh8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826017; c=relaxed/simple;
	bh=suGpKOxJrw/x+Qw34YH9Wq5C5aeu6ITuVv0x3tIR8QU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqkB4JVvTyvpIRFlEsTm4wf5MneTA7iswx0f2HmTqHOzHVn1NThji30e+us2W7gSUxsDj4dgQLOcWu18j8utCh7+apgx5/XgvYwgAS5MkMVO/mhgmDJRiDUYzwqHWzlYhYUCGtpj6JsqGqkldStInhd6F2WQYJs1eHbJx/Pgaz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkphe7Gt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234c5b57557so67596535ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 21:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750826014; x=1751430814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+gxLtLJHJekP2m5RDJO4GtXWgXu8wxWquk/PnbuibIg=;
        b=wkphe7GtVKXlZEf4dSRQ6JoNnkFUNGpSRmwQZzciM0mL9BsFQIwloPQgPuvyRnCy8h
         706+QFk2DWUHzeDqb+PbEgHGi6HhHzabyXif2IjGVba1HRBi9GDaBBW43/6IWUX4VsFH
         Fg1wlkL93rEe8+vAlU/KQP6f2UzQvT2uMM5hp7OII0f2L/BzwpS2/UsnrfOm3ATCRdr1
         LdmqqWBOUISQDoN9Ng+aG9jyPAt67U+S0syDqFFfoa/iC4vY+Hp07H/cQgOoqMXuTIoF
         ARMlUckqHcsqcQwXQvywXj3428KP0lBhMe5Jeqbs1zT9gNp+jqXalZeJ6/KB+KSDvByk
         14MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750826014; x=1751430814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gxLtLJHJekP2m5RDJO4GtXWgXu8wxWquk/PnbuibIg=;
        b=GIoRyz00HuejjqbEi/LtPo5Og6IQAA1nbtSEeMWSW5bo6ycUfhRbG5faPEqbf4c1MQ
         PJfyjNN/juJEHzUJstUk7LMmsd2fZlls9XzLwbDcgkN6UY00qiGWFW1WYSIEjTJ0sizS
         8Qqv8T75kHQlQu8Nsg6W1PRvgtx8Ef+AQo9xMEPPEMSqNUKU+BUrPlHcbYvPAAcMwE2J
         ynw2Jfhdd2NYEr2O22hHoBXyNVKItT2zib0WzLb2jf1LVzWBjLg7gkzuY3AcLybBjE28
         ErjzeAdYylIMvyzEITJfrKHG8GOWgElG+CejCv3DwSHjpwf/lNjzKcYqdner9yr4HG8A
         AAfw==
X-Forwarded-Encrypted: i=1; AJvYcCWcfVDbxTYHEK6vPJ87REE1qlyBbDC3peOdFTY8x/PLxU4Yub8MpdCffd9pdcQRA9TperyCcpOXT+QsSrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Y/+GSBcSbmAVHAdoHhu6rLGYFvzA2N17jKilzKkvlQ/hsLdr
	/dv7JEtytutripG9KkPkV0+hfGkA7ut36rs3T8ZjZDAFf2lzK8WGaH8hcnKtu9VUgh7WS9SFvIJ
	xfhZBVpfVdtfn0sr50hitSj4p6dow1R4XeNDB7S5ABw==
X-Gm-Gg: ASbGncvLOHDR6PzkQAuMeBPXN9qzt1isF/piy3j6ANEQJL98LoVGbWckH7/oAxnANcX
	53NbcweADbEmTer7O11fAbTMtz2jYu2Pk0xIOpTJNoOz6mVP6RNj5hhPLqxqhg/mL8qXnfWSZI0
	4SojjKJwXOPn3M0q/lOA+LiLzoJ7oM6Dp54mvqG2D+U8LvL3wZRZyIV9MSTUKVSQ9wgEk2Qcwwh
	sPp
X-Google-Smtp-Source: AGHT+IGtaQJcYYKVhLp/50lPmuB48IV2mPVXAbLY+hiIPV/anQZIZHdY1a23C23NRxSz7f54xc9tE/nROguaPMm8/Tw=
X-Received: by 2002:a17:902:ec91:b0:235:7c6:ebbf with SMTP id
 d9443c01a7336-23824047541mr35763975ad.35.1750826014327; Tue, 24 Jun 2025
 21:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623130611.896514667@linuxfoundation.org> <CA+G9fYvpJjhNDS1Knh0YLeZSXawx-F4LPM-0fMrPiVkyE=yjFw@mail.gmail.com>
 <2025062425-waggle-jaybird-ef83@gregkh>
In-Reply-To: <2025062425-waggle-jaybird-ef83@gregkh>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 25 Jun 2025 10:03:22 +0530
X-Gm-Features: Ac12FXyd0V9F7KS0Td9Q-UYWV_cQw3EQwUvR1Vc5-PgNTQkt74Bhnhzxgl5WlkY
Message-ID: <CA+G9fYvNTO2kObFG9RcOOAkGrRa7rgTw+5P3gmbfzuodVj6owQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/222] 5.4.295-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	kvmarm@lists.cs.columbia.edu, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, 
	Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Russell King <linux@armlinux.org.uk>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 15:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 24, 2025 at 12:46:15AM +0530, Naresh Kamboju wrote:
> > On Mon, 23 Jun 2025 at 18:40, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.4.295 release.
> > > There are 222 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 25 Jun 2025 13:05:50 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.295-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Regressions on arm defconfig builds with gcc-12 and clang failed on
> > the Linux stable-rc 5.4.295-rc1.
> >
> > Regressions found on arm
> > * arm, build
> >   - clang-20-axm55xx_defconfig
> >   - clang-20-defconfig
> >   - clang-20-lkftconfig
> >   - clang-20-lkftconfig-no-kselftest-frag
> >   - clang-nightly-axm55xx_defconfig
> >   - clang-nightly-defconfig
> >   - clang-nightly-lkftconfig
> >   - gcc-12-axm55xx_defconfig
> >   - gcc-12-defconfig
> >   - gcc-12-lkftconfig
> >   - gcc-12-lkftconfig-debug
> >   - gcc-12-lkftconfig-kasan
> >   - gcc-12-lkftconfig-kunit
> >   - gcc-12-lkftconfig-libgpiod
> >   - gcc-12-lkftconfig-no-kselftest-frag
> >   - gcc-12-lkftconfig-perf
> >   - gcc-12-lkftconfig-rcutorture
> >   - gcc-8-axm55xx_defconfig
> >   - gcc-8-defconfig
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducibility? Yes
> >
> > Build regression: stable-rc 5.4.295-rc1 arm kvm init.S Error selected
> > processor does not support `eret' in ARM mode
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> >
> > ## Build errors
> > arch/arm/kvm/init.S: Assembler messages:
> > arch/arm/kvm/init.S:109: Error: selected processor does not support
> > `eret' in ARM mode
> > arch/arm/kvm/init.S:116: Error: Banked registers are not available
> > with this architecture. -- `msr ELR_hyp,r1'
> > arch/arm/kvm/init.S:145: Error: selected processor does not support
> > `eret' in ARM mode
> > arch/arm/kvm/init.S:149: Error: selected processor does not support
> > `eret' in ARM mode
> > make[2]: *** [scripts/Makefile.build:345: arch/arm/kvm/init.o] Error 1
> >
> > and
> > /tmp/cc0RDxs9.s: Assembler messages:
> > /tmp/cc0RDxs9.s:45: Error: selected processor does not support `smc
> > #0' in ARM mode
> > /tmp/cc0RDxs9.s:94: Error: selected processor does not support `smc
> > #0' in ARM mode
> > /tmp/cc0RDxs9.s:160: Error: selected processor does not support `smc
> > #0' in ARM mode
> > /tmp/cc0RDxs9.s:296: Error: selected processor does not support `smc
> > #0' in ARM mode
> > make[3]: *** [/builds/linux/scripts/Makefile.build:262:
> > drivers/firmware/qcom_scm-32.o] Error 1
>
> That's odd, both clang and gcc don't like this?  Any chance you can do
> 'git bisect' to track down the offending commit?

The git bisection pointing to,

  kbuild: Update assembler calls to use proper flags and language target
  commit d5c8d6e0fa61401a729e9eb6a9c7077b2d3aebb0 upstream.

- Naresh

>
> thanks,
>
> greg k-h

