Return-Path: <linux-kernel+bounces-816731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 725B5B577B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BC1189F911
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174C52FC011;
	Mon, 15 Sep 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o04K+d7R"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC772EA720
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934653; cv=none; b=JoJRqb9flqw8MxwYC3uHN/jbcYVHJTaGasE2tlL4KuAebpMBh7f25dtNazdogP4nZGxGFu4hR7SzcL2eny2z8D0tgxs1o05aIyin4SBmn2+j9PspcVQkZadVJkvLnvqdgs4bfMa6IL5cHL5sJEsCzaT7mypn/6YekwWvxcSOJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934653; c=relaxed/simple;
	bh=UHoIfOvz+vIBIU0zeRizh5s/hNzNrzFEeDKSaEZGi+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWfnlt9eP+MluDx7jlHXbbaREiD+dI7qO5zzId4TXhR/5oBPlcWadY/zyJHECOKoaRFNJbFJ8Rtu7f1uffUsHZuGh3JTK54SPFZtRgSYiZ0VmsQtVInRmCPv9UhDG6bCYWsIsfEg+YCpTwF/kIgw3l1q/W2geSzlDBF/TAoaKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o04K+d7R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24cca557085so344765ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757934651; x=1758539451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yGVw+dkj5nfYxmjH5LY4ZgVFCM7KXPpME6hBvdzBkGc=;
        b=o04K+d7RLmi16Z+ZDOxxOmRLzUvhplsaPT4W/8GdxsRtNQ5yqLIfEAL9Q2h8o4oqQ6
         OHfb8uWHrq1Pgftg0JgoBqxd8TuIsncrOyB1+1vGgspzmOCmROcqN57l+YvM3Nbw1HC+
         3JB2h/oqJsFL/sKiuhyY2BHYWugqCJnMHliR7Nih7CNCY9c/anRO6azSjQasdytWdRbL
         6TC9VWre4uLIGFdK7YJ3xnfP5IuX4BLkxF6B77I3iC/uFhbjatu4dRmwLkNeCeMse6Xf
         Gy06sj/9TzfMbF8H+nfQL6Qe7acMPG4t9kd8TQF/umqjEJEuUMqYhjD7g8CCKdUgWYTt
         BLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757934651; x=1758539451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGVw+dkj5nfYxmjH5LY4ZgVFCM7KXPpME6hBvdzBkGc=;
        b=eAeTNXr/VvVIglST5vfVdgwep+4wkO65s2nFaIWiXjz3Q5cjPzM3yQo6j9T23YXIoh
         DdVDEKFkX002eKN98YCLYMSblvHEneTYrU+xHZXbGcCUWtaBOHXp97S+zR8gej6NmRsz
         tn/Ouq3t2QXTrzGDv8wfgHa/EUboWInygzL1KzkHXxxJEvtxlLUjIKPm23BMhFVMNnMD
         L78rcaMesd9mvciUF2P9kMtlvSYmgYeUELTrwfIllHtt7NIWwU5DWJmaZg5Cx6szc1K6
         6dubE5J0LugOlMdE31fWV7WaeoQO95JeMMvMAnKhaQEqxomCtZDaRamYvVO1Tb7/mTCJ
         U2zA==
X-Forwarded-Encrypted: i=1; AJvYcCVzyMA+H3LY/OZrTeKtY6uG3UvH8dJL42/2RqX20zgISZC7iOn9CS07aQ0mRWJmAxpfRwSF+zQ1dPu52Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfQYqzToZbNp1EWqMWp7d4woeHYdOJXWol4qVONG04F3OIy2xa
	nkXsFE5qTnGSB7Q0f2RzSu4l6f6/iWlLW4T98OhBK0Fh2wkk042q0K2IHH256TleDA==
X-Gm-Gg: ASbGnctOV7BwT4haucmFVjy9orZJUqX+ihDV00JURB/LVypbtN8nzMfBINH9WdoINYQ
	lERdfZrvrc97cwXK86mJEVlGs3+xkUvswOy12v2dZOXn0B7iNuaD82v1jyEyNYZgzJXy3E9Rxo1
	TRMXxCqRiYEpEviR57iQgBBrgxZATRmL5VFaR2rLH5V21Fsnfag8P412YzjG57/bJKTUBRj2gjk
	eykZYxk4aFiRcA+3VO4UMkRpKq7dTJJkgkTbdHm8eTXFpuaZKkoy3CZm84e5XNtCFLFeBreSCOE
	9KfQKyC38uQZTIzDRHyT4AGR0VNazX4BGXxx6nt4/6wfo22Dsj6VbWKIz25PbUJILYxLaKwn+r9
	mRj1FLWg2HMbUs3jemFVHL56hlc1HaSvUCWOYME6kF0+5j8gzzumxbfrldKmp08TIN4INzkzVGA
	==
X-Google-Smtp-Source: AGHT+IGldm5kVklLwWI+W0luGJJTP/Fy8rtLyArOHHmGPz2Td1ttKApb5Hb7I95Cb8Bwiryv5S6sUQ==
X-Received: by 2002:a17:903:1b08:b0:24b:1b9d:58f1 with SMTP id d9443c01a7336-260a27af356mr6498255ad.17.1757934650882;
        Mon, 15 Sep 2025 04:10:50 -0700 (PDT)
Received: from google.com (23.178.142.34.bc.googleusercontent.com. [34.142.178.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26175efc667sm64942635ad.112.2025.09.15.04.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:10:50 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:10:43 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com
Subject: Re: [PATCH v4 03/28] KVM: arm64: pkvm: Add pkvm_time_get()
Message-ID: <aMf0M72p8AEEoTny@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-4-smostafa@google.com>
 <aMA2ugNakqrA1Pg0@willie-the-truck>
 <86frcvd3hb.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86frcvd3hb.wl-maz@kernel.org>

On Tue, Sep 09, 2025 at 04:56:16PM +0100, Marc Zyngier wrote:
> On Tue, 09 Sep 2025 15:16:26 +0100,
> Will Deacon <will@kernel.org> wrote:
> > 
> > On Tue, Aug 19, 2025 at 09:51:31PM +0000, Mostafa Saleh wrote:
> > > Add a function to return time in us.
> > > 
> > > This can be used from IOMMU drivers while waiting for conditions as
> > > for SMMUv3 TLB invalidation waiting for sync.
> > > 
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > >  arch/arm64/kvm/hyp/include/nvhe/pkvm.h |  2 ++
> > >  arch/arm64/kvm/hyp/nvhe/setup.c        |  4 ++++
> > >  arch/arm64/kvm/hyp/nvhe/timer-sr.c     | 33 ++++++++++++++++++++++++++
> > >  3 files changed, 39 insertions(+)
> 
> [...]
> 
> > > +#define SEC_TO_US 1000000
> > > +
> > > +int pkvm_timer_init(void)
> > > +{
> > > +	timer_freq = read_sysreg(cntfrq_el0);
> > > +	/*
> > > +	 * TODO: The highest privileged level is supposed to initialize this
> > > +	 * register. But on some systems (which?), this information is only
> > > +	 * contained in the device-tree, so we'll need to find it out some other
> > > +	 * way.
> > > +	 */
> > > +	if (!timer_freq || timer_freq < SEC_TO_US)
> > > +		return -ENODEV;
> > > +	return 0;
> > > +}
> > 
> > Right, I think the frequency should be provided by the host once the arch
> > timer driver has probed successfully. Relying on CNTFRQ isn't viable imo.
> 

Are platforms are using DT to change this value?
Because I think TF-A mandates [1] this value to be set, from the docs:

BL31 programs the CNTFRQ_EL0 register with the clock frequency of the
system counter, which is provided by the platform. 

Even the TF-A porting guide [2] mandates it to be set.

> We can always patch the value in, à la kimage_voffset. But it really
> begs the question: who is their right mind doesn't set CNTFRQ_EL0 to
> something sensible? Why should we care about supporting such
> contraption?
> 
> I'd be happy to simply disable KVM when CNTFRQ_EL0 is misprogrammed,
> or that the device tree provides a clock frequency. Because there is
> no good way to support a guest in that case.
> 

And even if someone choses not to use TF-A, IIUC, doesn't the aarch64
linux boot protocol[3] mandate CNTFRQ must be programmed with the timer
frequency? As per the doc:

Before jumping into the kernel, the following conditions must be met:

[...]

- Architected timers
  CNTFRQ must be programmed with the timer frequency and CNTVOFF must
  be programmed with a consistent value on all CPUs.

Thanks,
Praan

[1] https://trustedfirmware-a.readthedocs.io/en/latest/design/firmware-design.html
[2] https://trustedfirmware-a.readthedocs.io/en/latest/porting-guide.html#function-plat-get-syscnt-freq2-mandatory
[3] https://www.kernel.org/doc/Documentation/arm64/booting.txt

