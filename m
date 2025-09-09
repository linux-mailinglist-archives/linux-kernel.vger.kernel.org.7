Return-Path: <linux-kernel+bounces-808566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C833B5019C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBBE1C64551
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FB35337B;
	Tue,  9 Sep 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oR+AWC4t"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86BF352FE0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432127; cv=none; b=h9iO3e56/WKlA2zZH4V6yxZFZzQIzBEQmGp4nbDWPYVmqLTzEU/cq1KcbTY0zr4/KnUWsHAEF4VBUe7+LquTdHNRicOxmBYYrK39oUyQSGACP15CEoF8+ir02JRT66647LsgF2wGEQe6q3/hMYdTRnoP1yJpv/iJ1vGvZxmwVds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432127; c=relaxed/simple;
	bh=w4vgOObZw3YYbVIKYEvDXnCr95k+9nhWh3AEGiV+pkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1rPPPJBlO0P+Z5dytGxStdnm3xMvtG7RL2S5Xo83iKjVxdmuGn8W10kuk5ejbUBIOMG1pU9QVzFzyWhy/e2FyrvzpIRQFSf5DHeuk/6SbpLNpocesyW5m8EGjH/R0OyX9lnJZIMYG2sp69slZg57SeBBSxuX5S2msErMfNwPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oR+AWC4t; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso609807766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757432124; x=1758036924; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6rLLgpVdsegGOz+EoupeAx36VHy3lWka2XxE7GCX/E=;
        b=oR+AWC4tCPxc7EjZgtsJSIhr/VlUCo4o9Cth70xCN6zLAfnMXcwE1UWpKBIIdVIu+m
         zteHOYyvthZKZizUI9JGDRtH2pqAI9Z/HiQBEikGurXmYjDe6I2Buc7lrbQ/gS9xpyCF
         5rIGWYMBoEIQdd3zO1xvgW2NAg+0a03K+GZTs4QDKclau3QyKXa3zKu9b+eUhkh8yNIJ
         PKoZLl3NHqs4XIz9uqONX9JnmYVBFsjgOdjaN1JROGdTLbDa/kTI8li5trZqaORufjNQ
         USFzD/BcZDL5n5XFfJDYm3ZLb+HjQKzMCvo1mw67jt6uFEZuGquxsYIvrMawpbzEoU+h
         QTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432124; x=1758036924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6rLLgpVdsegGOz+EoupeAx36VHy3lWka2XxE7GCX/E=;
        b=Ws/ayyJjXPAsuHdiGEDaxvAmW2XEpAHpGfkUy4eHuVuSY9fN3/lj9rc/Jm/S3CYssg
         AENosp4QkokdVcqFDilNY2e5YACHT73KlyGtkNe0HXFYXkZlOCFmrs9NLpyl5xclSkBk
         dTZ7uXAsuxikukFAI4/VLdCxSI80vFD1pQPoPt0pU5hlT9yWl3mP/Gb1kRgE+kSmMNFA
         i8Jp+oZykkj8a4Af+i4EWWiC30jn/3ffpKAm9tb38AAnULO8yxwsNVSM7ahcJ+SH1bVh
         Z6/gRtc5v/uY/QPmofdrURYixr8rDWD91UfCX2g5wvo95Z04iOTECH/3V6RjbDYZ3rlD
         GC9A==
X-Forwarded-Encrypted: i=1; AJvYcCU8CK39WsoSMprHOHsymBDvaSbfPsv/ALITCY1372sUmZBsF25yLMg7tUn8IB8MGO4J/sUKpHFgOOyxGPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPE2OEC2hmNngdXx91a03/0nzjxvbNA3cdvj+ttv93R7CyPrIU
	nnq42dZEZSYTeLb9d6zOhxTWVcd1jr8TxqVyCscX3lnbyEhy8Z+ZE9Suq3CMshKBNzw=
X-Gm-Gg: ASbGncs2iMn9jLZ4itKTvVakxqBBqMWR41bM7P1DWr0byEVUmjhlBzBjPSnRY6k0nCB
	XqzAc2L/5DtUegw+RVVRiM554Mexu3brjrhxSOUMTQL77u1XVRNr7/h5AfbmU6C2Pcatjvcn6Q8
	l0RJ+NWTot8CwZBOOw5DpRD2m9Ljffmb6Nz9LitKyyzkYJkO07H4gODMTaYMxBvM+loPAnklFjs
	WgCwPGnplTdhvudsajx6iQEVjeI1adORIayyJ05ICHbc8EwHWYBqrpLjz16vCeYtwid7oWuDNos
	kJG5caLUJXaKwoSNaGtHyrb4WyQsE4LsEE3f/4B6zCq7Qq3cVO8PlecvQOQ0PtiLsZdNCLa8DmT
	MNE7tGKrtwXxaF9JeR87xUQpSnGg4gVcQ
X-Google-Smtp-Source: AGHT+IHff9nCiQdFMDLMJ/hlSIro/R7UZcyBEWyHkdL401b61b17TqRRFBH3ULGPy356DE8iv2CdnA==
X-Received: by 2002:a17:907:9707:b0:b04:95cf:a39a with SMTP id a640c23a62f3a-b04b1714554mr1300624066b.52.1757432124140;
        Tue, 09 Sep 2025 08:35:24 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:30:cfb9:1327:6099:9e75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07830e613csm8636466b.46.2025.09.09.08.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:35:23 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:35:19 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Enable use of all SMR groups when
 running bare-metal
Message-ID: <aMBJNzXpQTMg4Ncs@linaro.org>
References: <20250821-arm-smmu-qcom-all-smr-v1-1-7f5cbbceac3e@linaro.org>
 <aMAkJ7CfPQuhvhfm@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMAkJ7CfPQuhvhfm@willie-the-truck>

On Tue, Sep 09, 2025 at 01:57:11PM +0100, Will Deacon wrote:
> On Thu, Aug 21, 2025 at 10:33:53AM +0200, Stephan Gerhold wrote:
> > Some platforms (e.g. SC8280XP and X1E) support more than 128 stream
> > matching groups. This is more than what is defined as maximum by the ARM
> > SMMU architecture specification. Commit 122611347326 ("iommu/arm-smmu-qcom:
> > Limit the SMR groups to 128") disabled use of the additional groups because
> > they don't exhibit the same behavior as the architecture supported ones.
> > 
> > It seems like this is just another quirk of the hypervisor: When running
> > bare-metal without the hypervisor, the additional groups appear to behave
> > just like all others. The boot firmware uses some of the additional groups,
> > so ignoring them in this situation leads to stream match conflicts whenever
> > we allocate a new SMR group for the same SID.
> > 
> > The workaround exists primarily because the bypass quirk detection fails
> > when using a S2CR register from the additional matching groups, so let's
> > perform the test with the last reliable S2CR (127) and then limit the
> > number of SMR groups only if we detect that we are running below the
> > hypervisor (because of the bypass quirk).
> > 
> > Fixes: 122611347326 ("iommu/arm-smmu-qcom: Limit the SMR groups to 128")
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> > I modified arm_smmu_find_sme() to prefer allocating from the SMR groups
> > above 128 (until they are all used). I did not see any issues, so I don't
> > see any indication that they behave any different from the others.
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> 
> Is the existing workaround causing you problems somehow? Limiting the SMR
> groups to what the architecture allows still seems like the best bet to
> me unless there's a compelling reason to do something else.
> 

Yes, the problem is the following (copied from commit message above):

> The boot firmware uses some of the additional groups, so ignoring them
> in this situation leads to stream match conflicts whenever we allocate
> a new SMR group for the same SID.

This happens e.g. in the following situation on SC8280XP when enabling
video decoding acceleration bare-metal without the hypervisor:

 1. The SMMU is already set up by the boot firmware before Linux is
    started, so some SMRs are already in use during boot. I added some
    code to dump them:

     arm-smmu 15000000.iommu: Found SMR0 <0xe0 0x0>
      ...
     arm-smmu 15000000.iommu: Found SMR8 <0x800 0x0>
     <unused>
     arm-smmu 15000000.iommu: Found SMR170 <0x2a22 0x400>
     arm-smmu 15000000.iommu: Found SMR171 <0x2a02 0x400>
      ...
     arm-smmu 15000000.iommu: Found SMR211 <0x400 0x3>

 2. We limit the SMRs to 128, so all the ones >= 170 just stay as-is.
    Only the ones < 128 are considered when allocating SMRs.

 3. We need to configure the following IOMMU for video acceleration:

	video-firmware {
		iommus = <&apps_smmu 0x2a02 0x400>;
	};

 4. arm-smmu 15000000.iommu: Picked SMR 14 for SID 0x2a02 mask 0x400
    ... but SMR170 already uses that SID+mask!

 5. arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
    arm-smmu 15000000.iommu: GFSR 0x80000004, GFSYNR0 0x0000000c, GFSYNR1 0x00002a02, GFSYNR2 0x00000000

    SMCF, bit[2] is set -> Stream match conflict fault
    caused by SID GFSYNR1 0x00002a02

With my patch this does not happen anymore. As I wrote, so far I have
seen no indication that the extra groups behave any different from the
standard ones defined by the architecture. I don't know why it was done
this way (rather than e.g. implementing the Extended Stream Matching
Extension), but we definitely need to do something with the extra SMRs
to avoid stream match conflicts.

Thanks,
Stephan

