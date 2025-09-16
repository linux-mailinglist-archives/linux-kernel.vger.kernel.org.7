Return-Path: <linux-kernel+bounces-818967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0306B5990C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CC1188F578
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD92532F764;
	Tue, 16 Sep 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X1jki0wj"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C13E33EB1C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031463; cv=none; b=N1ZuiyzN3nup6lkKgQGrkXyDZ+JTa2DwnlChWvV/k6AWOe648lBjjadhmBZtbai3jV29XlIu15/MAD8KjhCGR5dMHPY5/NWuKnkFO6Do4lLR5l2fpdI5UXaQ8jYgr/K1hUb4rsJjJpMKY8jzBpmy5E2cgGr9NHynXRT0Y9cMi1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031463; c=relaxed/simple;
	bh=Mj2uch2k7gnXMgjun6OnhPHWnFGJa3Fum6oHaYqsUBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bThso0rHfZDmsxWTm1Mlo1yxzSpedBu2H70WKAO4rnLvNP18U1+f/eJ/7WB+0NVflPcP85teZbPq1G5tD8ybTi5tkuMyEo/UdAkQ7nS8MbHzkscPvneKvG5Z5kz1OJIL6AkDKeo/q79Vi27HoGUkd4t/ju3Zws4RTNUSaFeit2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X1jki0wj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2f894632so54675e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 07:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758031458; x=1758636258; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2KMOMO3XHmFOxVaDXop6w1+ZPJDKNJK8AZpmO1KEadE=;
        b=X1jki0wjc7mY9ZC6ZGexTDFLKkxtur/tDE7sbiBgo/D7VrqGCe7shSuvbKDU9VXs+X
         HnXBiU7U3QWGvu3S2mOXrnaL8m1XIFut8T5Ejoh6YtRFCT2kt4jQpjYswVuvHvvKIjS9
         +jQYfyEy1rguw3W37qiZPBiWy7aw9QAjd1AE1WFVwzCLMAbFk2SxyaF98fpWJaUa8Sd1
         3GjY0f4N6S4izGypHqM54148X1Fdnp2MwqVXY0y5K58kCpDQ/MS71KAK1OC86xmfNeOR
         qviRzK6fkD1+Fev3pwoJiNeUS00HvDjq+YftpOMjgGNXiPDqy10LyxvuAuvOMoyXjpIR
         397w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758031458; x=1758636258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KMOMO3XHmFOxVaDXop6w1+ZPJDKNJK8AZpmO1KEadE=;
        b=aysu+jZsARISwbEWEYyS7HIyJoLvOpgSVQMShGJKbgY6XZsCFhiiAZHS7bRKi1M2hV
         0xVzY5Di28/OP9wg1ZbG5GltxAWc9krRw9/shmkX56AkMQ+zAVJ/y9+xOYnlyOom/qUL
         7/Awq1wC+4eV2ZBbOjly1V263k/6DTP2dvc8zY5SrB/3M0wesEkQ//OOqeVLLDUnvY5p
         G5Nv3eyY3RmRIIaLNQm6GBrhW+w3EJjhz7E+AwpwNs62/Kp6KFp55wc17jmnjJJeeWfw
         AfngUWoPj3b6kBQNLTgQ7oHq6BXudkZSizHtYuPgBEgMFdzLtO7ktFMJ0tvy97stLKjt
         QBqw==
X-Forwarded-Encrypted: i=1; AJvYcCW/vKWFMKyaF1EpDwmEdX3FbMTMT64hHg6v99OCiLuEoEaS1sY2xtQl6fpAzWpYOBgmfCxKnkKmWT5Foqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwUFTL6J2ay/h4PqMTMkCZR8Nt6rsDAEpwCbrlf8S6fxY6m4qt
	PFJl+5po8dBVW8C7SACkdxcxlgWKjM512RgmW455BmAGDKd6Z6rg4IIeG47M7WBfWQ==
X-Gm-Gg: ASbGncvG5+zLoUlGUPUzeCW4X5SGMP+XLO5jwkuaOmmpl2Qp+QcG+20GuhgVe+B+vdD
	X618+emgGqF/2wcQ1BGKa8rD5ucWDCCR3LCo/bRRjTGL8FeYStnxamBT+7eXS/g/nbLHGmX4pPm
	g3jyI7Khrl7L6V+di41brEYAOZY9SmMfm/DrbShWKKCV+E9XR+OrTFHr3BVxqXK9s3Vj1vfJyTQ
	eZbCkMC/juS+kqgwC6Hf5eEPZPTBm8dHunVpvxDkpbbYzWtbde44tQspOoBoxrCF+v5XpJY8QwS
	1bGX8cf9LDGUQuxuh5+LhpZGQvpyJIKOgZI7wjSyKt9IRl4d7whd1WZBPHgaq2NZCofsER2YdtZ
	oZMrr1ZBd5OHtX3RdS/IUe8RJwPPNuzWomj+H4OOMa1lkXuNNgNDAwPXfc8+o7Qtu+pElFA==
X-Google-Smtp-Source: AGHT+IHnm9FwdHAPOXF/eEjid/iWJ/+0RKN/ZPnistvH7jALBPjgIBevgkp2XifrX2DSJ35JmAkJcQ==
X-Received: by 2002:a05:600c:a10d:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-4601d6b4da8mr561855e9.2.1758031458150;
        Tue, 16 Sep 2025 07:04:18 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372aea2sm233815705e9.7.2025.09.16.07.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:04:17 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:04:13 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 03/28] KVM: arm64: pkvm: Add pkvm_time_get()
Message-ID: <aMluXZfrvg_-fhMN@google.com>
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
> We can always patch the value in, à la kimage_voffset. But it really
> begs the question: who is their right mind doesn't set CNTFRQ_EL0 to
> something sensible? Why should we care about supporting such
> contraption?
> 
> I'd be happy to simply disable KVM when CNTFRQ_EL0 is misprogrammed,
> or that the device tree provides a clock frequency. Because there is
> no good way to support a guest in that case.
> 

I can make "arch_timer_rate" available to the hypervisor, but I'd rather
just to fail in that case as Marc suggested to avoid complexity (and due
to the lack HW on my end to test this) even if we check this only for
protected mode.

Thanks,
Mostafa

> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

