Return-Path: <linux-kernel+bounces-766796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E3B24B46
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD09D18820D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7EF2EAB8A;
	Wed, 13 Aug 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ik4O2ccn"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE4C2EAB93
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093169; cv=none; b=NiVqrRQJVr/c4QDtxJ0ugXFcjTmbTfBiNo5X+L3NF1cRIkB0wX3g0pNLNPoFshdkWc3o4tC1HrSMiXIDG6rkkF4A8AQ/m0Dl5bb7orCnRFHHDFzdN/Iegtgq81UjOACF+piOcbICk5iaQFI8D7CQt5eWWniQtwv2N8eC5IPocRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093169; c=relaxed/simple;
	bh=6A5JsvcYaRafCCx67GMvT6tCp9o44qh5Djgvwpo+HDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijKUKsGwuPILVJcQ9iy3U+WzH2EnXTI5og8mYdWyqYMKQv3AD5eEV42f2RtaRvB7QZYJDF56Ox3gkbPByioBTtZ+Zh+FmBz5816wZxOBNQ47fZ+TuTXKILAvMXtYqfJo1Oz77V0l42ONh22jqHOcGYHDOznADL+La8i3jC9PJvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ik4O2ccn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-459fc675d11so56755e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755093166; x=1755697966; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yRh53LhwzwIVu2CoRYc8EdlqoIGtiq5RV6ngg5LPmCE=;
        b=Ik4O2ccnHb5ELFnuSXeRcMFUwlQVpsnMZ08XH9Kn+rSPkfg/j5fun+waeHcBPXyxsH
         MRSSquPu0X964MzvRbbW7Qd29guEsXWX1oX/tyUefaVm4HwML2Cp5IPMdwWApPaoPQoQ
         zPFSwY+0HrooOOoCTsAN0cAHI714TTolqnUv4VXOtnCvD6LMp858mJttXgHk0/2JdCMa
         OGVrZQ5Kouhqf4hQeRmMbZr9dsRFadwb9nywbis6OK8kBKSk9eSADdSk0dvF/d5nSy4H
         Bx9AOc13d5GErWVcgaYVQ3nKRaCl05fQTpt6AjNcI97Jm5WcN60tbz48qtMZZbNNl4t+
         a1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755093166; x=1755697966;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRh53LhwzwIVu2CoRYc8EdlqoIGtiq5RV6ngg5LPmCE=;
        b=ur/A+ASTIWB3hLAo4NOSgpWNf4TFFVLxiVPJg6tqq9lFe0Sgvz+SIm+vYoTE8wUHQw
         gN8JjAHILY+BmBRXJfqLN60egOjK3/0pe59krmlCy4NhjVVYWNuqKhEOz7hZOyy/o5qi
         c56JfGQZy4Rko4kzrYm4Mw11V4schedqCqEbWrkPABc+tgd/q/VuHdkr2is7L/2xhShq
         l72KG8eCTnvdj/t0A01nB1TjmiTHg9Eic+PgRYNIlNM5AJpz/Gs5eP27TrIjeqcnFEoN
         i+cCVfzPm6yUOSvrOjikhLbPRS6kpqOt31Y5ToOpNI1wJE9sOgoHbdSAEgSwkB+KuXz/
         A0gg==
X-Gm-Message-State: AOJu0YxC5xZLQiOKrvaFszIm7u2lyFqCdGNwdbDPQYBXwokWZnJnNyZQ
	aR4yKr2Sw0TipI5DFAy93ZxQJDdqa/l+dGM1iM5KmgJ0GilfarOBVpJO7QQpwLC2/A==
X-Gm-Gg: ASbGnctB40SRfJnoXZ/T/OjxQXf8xfJHjiLdX4+QitANidsVX296vhCi3ZI2G0TH/LE
	yDDCAd3kHZ4FMXHnmy9yptsrZo1xH3ir5cEMMm6dPjm2ZQYiLHdooTkeMSHfEGTJ2CWqpmjWHib
	q/4DwOLWtxrM7nLYeinTbF0ai/PJLzGhhJPhI7JTyOLRAS632frNMaPiuKh8xl9nTpAe5+8W4UL
	N6a5Rc5taU3tFte2FSoFzR9YHZsRrF2yjrJq/679Ihr+D8Or1kyYEuuRHaUoacN6ePOUxbWxHh4
	eSWepKEJCMCfAKyiwESirsYgaZYSHsA8IisYX9Kj2M6HLYG00t9d98YshHdwAL+3Ajgk1WQOESo
	PoPicLTWztDcjNelu/FwgUa0fbrTsOB64P9Il5tIJqIm/mQrztpfCeG5+t28h+nQZ0G+AF9CSWS
	uA
X-Google-Smtp-Source: AGHT+IFChMgXbcY7CfRuwbBbzu+f+Z+kFs7pTSJpSto9E0MCkZ9ZxRMPiVmiGbuQ06PfA2dGw4w1jg==
X-Received: by 2002:a05:600c:4e53:b0:450:cb25:ead with SMTP id 5b1f17b1804b1-45a16e80868mr1336535e9.7.1755093166147;
        Wed, 13 Aug 2025 06:52:46 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a537193sm3359695e9.21.2025.08.13.06.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:52:45 -0700 (PDT)
Date: Wed, 13 Aug 2025 13:52:42 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <aJyYquSQl_OfNDA-@google.com>
References: <aIurlx5QzEtjpFLd@google.com>
 <20250801185930.GH26511@ziepe.ca>
 <aJDGm02ihZyrBalY@google.com>
 <20250805175753.GY26511@ziepe.ca>
 <aJNiW48DdXIAFz8r@google.com>
 <20250811185523.GG377696@ziepe.ca>
 <aJsXkidmcSl3jUJP@google.com>
 <20250812121056.GB599331@ziepe.ca>
 <aJs1dMiomjtxVwl4@google.com>
 <20250812134808.GC599331@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250812134808.GC599331@ziepe.ca>

On Tue, Aug 12, 2025 at 10:48:08AM -0300, Jason Gunthorpe wrote:
> On Tue, Aug 12, 2025 at 12:37:08PM +0000, Mostafa Saleh wrote:
> > I see, but most of the code in KVM mode is exactly the same as in the
> > current driver, as the driver is not HW agnostic (unlike virtio-iommu).
> > In fact it does almost everything, and just delegates
> > attach_identity/blocked to the hypervisor.
> 
> How is that possible? the kvm driver for smmuv3 should be very
> different than the iommu subsystem driver. That seemed to be what this
> series was showing.. Even the memory allocations and page table code
> were all modified?
> 
> This delta seems to only get bigger as you move on toward having full
> emulation in the hypervisor.
> 
> So, I'm confused what is being shared here and why are we trying so
> hard to force two different things to share some unclear amount of
> code?
> 

Originally, this series from v1-v3(currently), just split the common
code (SMMUv3 and io-pgtable) to separate files and added a new driver
so it was a clear boundary.

But, I started re-working the series as I mentioned based on the feedback
to have KVM as mode in the driver.

IMO, there is a value in either approaches (single or 2 drivers), a
single driver is less intrusive to the current driver as it doesn't do
any splitting, and just add few hooks.

As I mentioned I open to both, not trying to force anything :)

> > In addition, with no standard iommu-binding, this driver has to be
> > enlightened somehow about how to deal with device operations.
> > 
> > As mentioned before, when nesting is added, many of the hooks will be
> > removed anyway as KVM would rely on trap and emulate instead of HVCs.
> > 
> > Otherwise, we can skip this series and I can post nesting directly
> > (which would be a relatively bigger one), that probably would rely
> > on the same concept of the driver bootstrapping the hypervisor driver.
> 
> I think you end up with the same design I am suggesting here, it is
> nonsense to have one smmu driver when it is actually split into two
> instances where one is running inside the protected world and one is
> the normal iommu subsystem driver. That's not just bootstrapping, that
> is two full instances running in parallel that are really very
> different things.

But they don’t do the same thing? they collaborate to configure the IOMMUs.
That’s how the kernel boots, it starts as one object then splits between
EL1 and EL2, which runs in parallel. At run time KVM will decide if it
runs fully in EL2 or in split mode and either do function calls or
hypercalls. It makes sense for KVM drivers to follow the same model.
See kvm_call_* for example.

> 
> > I am generally open to any path to move this forward, as Robin and
> > Will originally suggested the KVM mode in the upstream driver approach,
> > what do you think?
> 
> Well, I'd like to see you succeed here too, but it these series are
> very big and seem a pretty invasive. I'm very keen we are still able
> to support the smmuv3 driver in all the non-pkvm configurations
> without hassle, and I don't want to become blocked on inscrutible pkvm
> problems because we have decided to share a few lines of code..

Makes sense, but making changes is part of evolving the driver, for
example attaching devices looks nothing at the moment as 3 years ago
when I started working on this.
Many of the cmdq code has been reworked for tegra which is not part of
the SMMUv3 architecture.

IMHO, we can’t just reject changes because it’s invasive, or some people
doesn't care about it.

Instead based on maintainability of new changes and whether it makes
sense or not.

> 
> Are you sure there isn't some inbetween you can do that allows getting
> to the full emulation of smmuv3 without so much churn to existing
> code?
> 
> This is why I prefer adding new stuff that you then just erase vs
> mangling the existing drivers potentially forever..
> 

What I can do is to hold back v4, and I can revive my nesting patches,
it doesn’t need any hooks in iommu_ops nor hypercalls.

However, the tricky part would be the probe, as the hypervisor has to know
about the SMMUs before the kernel doesn’t any anything significant with,
but the same time we don't to repeat the probe path.

If that goes well, I can post something next week with nesting instead
of the current approach.

Thanks,
Mostafa

> Jason

