Return-Path: <linux-kernel+bounces-752066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 587ABB170F2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD1F175C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973C42264AE;
	Thu, 31 Jul 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q+Vkw9QJ"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632F922B8CF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964265; cv=none; b=r0KvtWEPhGrMUQmSs94uWxneREJrwLMD6U2d7OoS+bupprjBjK2eLFV64TQVYwqe1kY4uai/l2SSl88MMDFdgdBaEJLPH5VcD10k4jB7OiWdPmWKgCvuPcHRTrStsuUc6dqruW2Di4n+35Xh8jlXNHwKnVwUhfxUQADHdwwJCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964265; c=relaxed/simple;
	bh=lgkxQThTtfZZSUnIFCf5fUKUIMl2aWvIb0b/yw6y6ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8YOaL/YiYMnsObOOu4h1SvJalA0mtRBRP28Xrz72D7rFwRbRVG4tvltIAnUmn8yhOmqmd4BnM44NocOkfH/eXHjq7LOfPbJs22ZBidjOURfsKEKaSvHbtUR2QZ+rLruwlUdel6Y4P7n0W7+glVZe4V9Y/jVtdWWvFdQZ7AUFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q+Vkw9QJ; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-707453b0306so9249866d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753964262; x=1754569062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=32tD2N96Q6MQNin9/Lb0EqTq3IigVZXvJ6wxZCRCR/8=;
        b=Q+Vkw9QJozJhao4ea5k5AvrX9mMf1tm7HmZZxTlPUVTTq9fBgsZb+MhzE34iJiOWyS
         9lGX8N7+szXq83MR3Fqv8WPLshc39fF36OYQ+nk8Ewz5n/p1C8tv38kZ8bZ/dpegwhOi
         NxHkAyINfONzZ8GApEohSIGORWwAOaY1Eju4boORtkm+f8hlp4tRtl35fzBLZtl5KBuo
         s3G4ZZH7AOfAgYLo3ki24flzf//2mj6xXE+bwTkNZocigRy97XLcIFUSbHfOODC3r5Cu
         LSUDv7ZwEDMda6V4M4y0SFuFgLWU1zgd3G9Epv14J4K+HHRcb6ywaORLaBJHoDAMRvL8
         M/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753964262; x=1754569062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32tD2N96Q6MQNin9/Lb0EqTq3IigVZXvJ6wxZCRCR/8=;
        b=CqM3I4Nk5y4mTCEwUOOP9VP3V+S2QxEk2YLB+S5qKxco8xflIgfFNTRPXoX4qLC0ou
         hf8vA97ps6z1kO4Dx4jng02aPUbNBLQmNtnvLiO6H2K98RSIgU/LKnqQHTxOZSCZ1oHq
         BZKH//0Hgp0VYWT7YmHTeNTTdlM+yzbJCE5DuUTw1RY8CXRrkcafvqOGwqoQV2RKIDU4
         QUHKj+/G0QnxPlwQOPbzMO0ljLQnOa5HjRfwmycb0yPUofi8dlyY6xjP6JXIjRpv2J0/
         6n59VDvRRnae+dPcSFPRIPNWdZXqqv3ujyO0cea8fr+zaqCnDVUZJc59p7JGdEnbp3mM
         oM7g==
X-Forwarded-Encrypted: i=1; AJvYcCWj8R/rJYf1W25eZAyGUra2HOLHaNhVctY1QCM3oQxHO2/oMO6MyE5CQtS7VBcmbPeAveeOLlcvjl4eYM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkDE2jd3TcjfBjPyweqcc6uep7EFKiE9cODRnkw9eeIQYZUo0D
	IyCBSShnLgHDir7ZW8l/rV59z1qFauPzBGhDDJ2pcKCmozozwfu4ELlY33UlE89mjCc=
X-Gm-Gg: ASbGnctqbODmv5SQF30JpgSmY1w1N+w0soVe0oBaNIFHx0KiDEOoWvbWfExqrW+/MET
	cAowEb0ykz832uQB2lDZ2ECX27IPrDr3IDVp6jgzAVXUMHGDcd40QJDj47pHJl9hYysxp4tXLix
	0lfGUdG/P5iW06CdWzqV8kXRfE1o2br7ZHEpRV2Eg9GVyOBOT8ylLHIRnx3eUVgGZ1Eg0kRwTmz
	tJ1vG8DgwQJUKYX/DRv7TyciM+a5sScZNSgEjqiv0p+TIj1Jnu+KYQ5TnXsjq3GczeqafR9q5m3
	cq6bZ8ABRx4S+sDKpNZ8F+aZr+SVge98aWNLu2CZTbo5tbiFDzr4vL6GHYDu0ub04DepqhB2Lqn
	ofJxWXnLHvQsL4wT2cDcy8ssf/WTTjdXqBMqQ9QpWixS2KRrfj/V6k8PKWiMfJfeOUCVd
X-Google-Smtp-Source: AGHT+IGlDd7T/UCTYlC3jJ27LG/kD/8HSLFnnlHhhhTVJjke6DkBwfMlPtU4g+DEqonThAsKUvPm4g==
X-Received: by 2002:a05:6214:c62:b0:707:62c5:9768 with SMTP id 6a1803df08f44-707670aa577mr86346366d6.26.1753964261687;
        Thu, 31 Jul 2025 05:17:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ca58d36sm6577016d6.38.2025.07.31.05.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 05:17:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uhSE8-00000000oWW-2X84;
	Thu, 31 Jul 2025 09:17:40 -0300
Date: Thu, 31 Jul 2025 09:17:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250731121740.GQ26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
 <yq5a5xfbbe35.fsf@kernel.org>
 <20250729143339.GH26511@ziepe.ca>
 <bbe2a41a-8f72-4224-a0bc-225c1e35a180@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbe2a41a-8f72-4224-a0bc-225c1e35a180@arm.com>

On Wed, Jul 30, 2025 at 11:09:35AM +0100, Suzuki K Poulose wrote:
> > > It is unclear whether devices would need to perform DMA to shared
> > > (unencrypted) memory while operating in this mode, as TLPs with T=1
> > > are generally expected to target private memory.
> > 
> > PCI SIG supports it, kernel should support it.
> 
> ACK. On Arm CCA, the device can access shared IPA, with T=1 transaction
> as long as the mapping is active in the Stage2 managed by RMM.

Right, I expect that the T=0 SMMU S2 translation is a perfect subset of
the T=1 S2 rmm translation. At most pages that are not available to
T=0 should be removed when making the subset.

I'm not sure what the plan is here on ARM though, do you expect to
pre-load the entire T=0 SMMU S2 with the shared IPA aliases and rely
on the GPT for protection or will the hypervisor dynamically change
the T=0 SMMU S2 after each shared/private change? Same question for
the RMM S2?

The first option sounds fairly appealing, IMHO

> Rather than mapping the entire memory from the host, it would be ideal
> if the Coco vms have some sort of a callback to "make sure the DMA
> wouldn't fault for a device". 

Isn't that a different topic? For right now we expect that all pages
are pinned and loaded into both S2s. Upon any private/shared
conversion the pages should be reloaded into the appropriate S2s if
required. The VM never needs to tell the hypervisor that it wants to
do DMA.

There are all sorts of options here to relax this but exploring them
it an entirely different project that CCA, IMHO.

Jason

