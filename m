Return-Path: <linux-kernel+bounces-764965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8FB2298F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3384A5640A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6490283FFA;
	Tue, 12 Aug 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pU3/iCO0"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C912B9A5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755006492; cv=none; b=cO8v3C7lssRv+a2az0eorLg3+NZ9FrIlmaJxHAtdKYrwyp8/UmM2Nhr5t7mVdHRDwdX+ce4NQb+kdPw/1HBTsH9apQvmXf5Q5T2U+45wkm/2HLlGMpEvYRgorJDreOD8fNY5NHO0pfuwBrH0nr77To0xKcPFXVV1cpH0jsWy27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755006492; c=relaxed/simple;
	bh=8w8dsb/uFPEAy0xmEBycHMX3X/m+wobouE+WgPVe6Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6weyiLEjhDmUGCRC8NU34lKhqswTWC0HcSBvcqwKyrxvO6kZBihKtBxe/6Zk27Fx87hDlnZGVkx+8ogQtENwxjfXRWQ1q3ekEJi93THVX+gj5J53Iu9Y5Wwjw5bkpaNehXE74oer3DFMO8SYK5zKu2wYUTIYj9rfOn2pYZSzNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=pU3/iCO0; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b070b3b7adso95293061cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1755006489; x=1755611289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FR8GU0OhyrXp1118wyyWRxkyUnIP7crv/d61bMyXgwE=;
        b=pU3/iCO0orWZpodk8GAif6sbT/DPRpN21ZyQDvFPR+GIdyTBYjXKtHkYLmsC+9b35x
         4foLpqTx5HyPZmoTy/PxjGC7s3EilbwE08YyyxYhteNaaM5J3hgbYqwysPLPaPiDc9oM
         wYqkFLmeNXAjfaE2wnNHyfmSJb4NzuqASZPURRADPE6dBx9o75nTz5piF2dCX2xaoJja
         I8MKlJGvIcb7HuesRHK+O9DI1itd0kaUYNI9bFA8S+/n1rjid42Bqh515+wR2owc2YRj
         QvDhEUs5Aghi40LPcOMBt/lemJefFMC0kB3927XCKAQYbb4TYzrBkAGR4QoosD702Pw2
         QMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755006489; x=1755611289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FR8GU0OhyrXp1118wyyWRxkyUnIP7crv/d61bMyXgwE=;
        b=fa/rVyNsHaNx1JaPZFd53hKAIdCPmVIbv9Pa4p0tKuUPFgE5D2AmPgyknle2edoHx5
         5jU23/wbHgfxQTtOcDdV/fvLJO58XfiMa/QT8BC/oRaQIeH/9t9E/GvNXeouLFRny1EW
         cc6imbSRZNnjepEspFPxPKNTqkrajtuA38+Iex3vKo9RFhLQ2K0sqF7FBY5YhO6h8cWD
         wiJ+533sIi9fq+AqCLoymcYoIODV0VwOq4JpaJoIuKtsMnxPyqDKECMKodcy1hFGkzxx
         1ooq1svhDr7aCLAMBEgHBcYT3OUAxy1l69IZpXwJixg6vdRULwtkfUgBtqyx/4CGoxay
         AdzQ==
X-Gm-Message-State: AOJu0Yz0dFJrcWJv+JEVY0cRXsOryPhGBnA/KVwiqL793pyZAky6zKiQ
	48fadr3pTbSpgZTSEDgnYJ2m7AoSvr4hUcCFAkIuvM5MkJchHdEM2CoRaKW75s2ZTeM=
X-Gm-Gg: ASbGnctjFHgVu+Ot1HqfCewK3xNRDOEJs1hjrZUVfO261/Hmd8VtmLBwosj8J1X3Iz+
	28JETZSoaf1aSIscSIWyDZC8IOZDZHd07S9T3QZL05u3Z9Blvt/OXoTliIk08dUI53Gz92GoaUv
	tM2Dv6up4QMc7QA9N51VyqQ53MJ+Ubg8XXzseAGfND1XEx082oGDYKyVB5/3/J0I3GAjSq9iHA7
	6oyPFUfMtvnpevUesTJ7yI+so+mExL/VTn7/BthQ8vdbSZxbTKJRF9dJ2tNpdArUtLIPUG7X+y8
	h8kYrUVUoK655MH53nllh4R4XrhXTQRpT9rCsriYE98gzpyLegEq9X5WSUdwPhIJrWk0eVP5DGv
	rB6lMfH7Fs6Osc/IwvGwU33JMCiKSKzX933Apw7vgS9y9vKv6M94vsatGGVnPKg84qRgn
X-Google-Smtp-Source: AGHT+IHI6EhFhIRzAESYthEtnG0baUD5Q9gVXq2RPFWP9iicVSAJltUOiMffIa1QwE25DHjgtqhMEw==
X-Received: by 2002:a05:622a:6:b0:4b0:86b4:2520 with SMTP id d75a77b69052e-4b0ecbe5777mr52212061cf.22.1755006489353;
        Tue, 12 Aug 2025 06:48:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b09c11bf8bsm83500631cf.20.2025.08.12.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 06:48:08 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ulpMG-00000002cyr-0e38;
	Tue, 12 Aug 2025 10:48:08 -0300
Date: Tue, 12 Aug 2025 10:48:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <20250812134808.GC599331@ziepe.ca>
References: <20250731165757.GZ26511@ziepe.ca>
 <aIurlx5QzEtjpFLd@google.com>
 <20250801185930.GH26511@ziepe.ca>
 <aJDGm02ihZyrBalY@google.com>
 <20250805175753.GY26511@ziepe.ca>
 <aJNiW48DdXIAFz8r@google.com>
 <20250811185523.GG377696@ziepe.ca>
 <aJsXkidmcSl3jUJP@google.com>
 <20250812121056.GB599331@ziepe.ca>
 <aJs1dMiomjtxVwl4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJs1dMiomjtxVwl4@google.com>

On Tue, Aug 12, 2025 at 12:37:08PM +0000, Mostafa Saleh wrote:
> I see, but most of the code in KVM mode is exactly the same as in the
> current driver, as the driver is not HW agnostic (unlike virtio-iommu).
> In fact it does almost everything, and just delegates
> attach_identity/blocked to the hypervisor.

How is that possible? the kvm driver for smmuv3 should be very
different than the iommu subsystem driver. That seemed to be what this
series was showing.. Even the memory allocations and page table code
were all modified?

This delta seems to only get bigger as you move on toward having full
emulation in the hypervisor.

So, I'm confused what is being shared here and why are we trying so
hard to force two different things to share some unclear amount of
code?

> In addition, with no standard iommu-binding, this driver has to be
> enlightened somehow about how to deal with device operations.
> 
> As mentioned before, when nesting is added, many of the hooks will be
> removed anyway as KVM would rely on trap and emulate instead of HVCs.
> 
> Otherwise, we can skip this series and I can post nesting directly
> (which would be a relatively bigger one), that probably would rely
> on the same concept of the driver bootstrapping the hypervisor driver.

I think you end up with the same design I am suggesting here, it is
nonsense to have one smmu driver when it is actually split into two
instances where one is running inside the protected world and one is
the normal iommu subsystem driver. That's not just bootstrapping, that
is two full instances running in parallel that are really very
different things.

> I am generally open to any path to move this forward, as Robin and
> Will originally suggested the KVM mode in the upstream driver approach,
> what do you think?

Well, I'd like to see you succeed here too, but it these series are
very big and seem a pretty invasive. I'm very keen we are still able
to support the smmuv3 driver in all the non-pkvm configurations
without hassle, and I don't want to become blocked on inscrutible pkvm
problems because we have decided to share a few lines of code..

Are you sure there isn't some inbetween you can do that allows getting
to the full emulation of smmuv3 without so much churn to existing
code?

This is why I prefer adding new stuff that you then just erase vs
mangling the existing drivers potentially forever..

Jason

