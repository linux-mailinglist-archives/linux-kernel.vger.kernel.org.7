Return-Path: <linux-kernel+bounces-754151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D04B18EBA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 15:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FDA7B36C3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 13:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E2123BCE7;
	Sat,  2 Aug 2025 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZQXwn5TI"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736FB2367A8
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754142119; cv=none; b=RYCr7eQK50vOBFmGoE9agF2ZTdxIq2ANLeE6RIOc9PtAc01FATPPH4vUvNT8AT9dZ1d3pOiK8dKIPMtbYGNhSStk42Va4SA56IUiuzBlS12Tu67Cp+puii9Fk6hOcBFxfWmb36Y5uSc79i4Lz594zOiAc/gxWXrUqfZjZYa/yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754142119; c=relaxed/simple;
	bh=A3twgw+3GWVYYFsSIocE5ftAItdu/FBceRJG47y6ZNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAq3RHCj9j+F2gNNbrwiPH/zCB0D1a0YnNnXP6cmzzvdwYWc0QY9zPPcXBgeSl7pGpmk8xmYAnSKuxnBdwWPtTFwy64TE9v0RSWNF8341rR8GkEZPgMDglO+k2LtA+/XuPvh5tZTnA8A7GAv8Y81NfrwRFQKmcIxL8xOro+VT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZQXwn5TI; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4af1c1b5b38so3660031cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754142116; x=1754746916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQYB2j5N3eZBI44lsWtNzt2CVeD9f75v+QDgKG5n1yk=;
        b=ZQXwn5TI8p/3tm7KwnZaRPnTNlFMU6H+VTv1MjXYry1WiLTk7pTQ9fhvXdi2RiUYBc
         Eu6PZrLOY4bV46DB16UVqiowN/EQ/we/Z2aBk0jDZH8nYhrrat3lu84SVK3avWxeWWlI
         TLpySF67LTZXokBTwBs4bmdo9WJBvZwKitZCssFT07Xe6V19gQK4OFYp6TnazkVAkq2k
         pnhKppekngzvHezleBBBuxAy5gh530ihwB7/e4Scb2k32dIUqqP/ncnMGc/6sZjMI7e8
         h/VgCWWV88hsV2VgcqjWaYQ3TXTuvF6/NniFsWg26XjNy9NzjGZhnABgErjIy6FaDn6E
         kWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754142116; x=1754746916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQYB2j5N3eZBI44lsWtNzt2CVeD9f75v+QDgKG5n1yk=;
        b=BTtXTkSMQiEwuC2DpJeRnvosShQjz++Z2SFK2rTw3CBH5qIwMVCJ+9b+v4tOTq7n1A
         xjzcKpYDDN4kULnh6qpzxgdilYpdMvYIcTxhm8m7W7yWAUhL4hHdT4BmYnbanKIqhfKS
         vUVPr9KQHY6feNS49H9Eoj3zzY+Bu2jkgtNPPy/VpYbjlbqgaGWTwiaXobUdItAJoNK6
         77+BUddxuXzKbRNFvGrypz9BTBXQ5F+3T5xOwWNHti2Vb5xATJ1m4QaQlfFlIAW0jr4+
         dzFTnodZBuwzwpA8uLEeI73xM+ZSjsdYjNDpPZH0V0XWZFUCTR0paEWHJfCgeNglJcpJ
         evzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8/h8jYNS4tSAiWZrLUjDQ9WUEHSfM/pUoQ3BEJFsbtfI4qv6oTYNj2wvHTW34G92/qnGFsuWCirX1Uu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVqX3Zh1as652oASqs7vB1IcUpLBTK7k4eSF/PEVjpa8+jJsx
	B+u6ZC2r9l15BtSTUt9niaTwBymGFjvI33pdAJT7eWTnlOApjatGUSMyv3qtSTaejLw=
X-Gm-Gg: ASbGncumNZsHEH0GRcWABn43GOnpPVXAPjgnJ5KAhYYqJpGVJBPAsyTg77iEoZXN/q1
	jSzaddlpKk5kB1FEY89HYdbiXgvKk1Lqm7kou7Gyr95KpEo3gDMjeGmsWjATsoH8DrQiWYAtqML
	RHPE7vCzGLDT961Yf3DnJLUuGk9HWbHb+notVBs4YmUeZ7zsK16Y+4eaNG2FeNXY2RbZQsiS51n
	xapKhi6fK/fcYcAOSeQVsaRk8/en8tl11unbdpH0YHayV0ZqmI8z8DfCebt7VLKJDCGRssjLpBB
	dx5AHtaurHV9RFcVHPnClioQ3fhE0NBD6eJJ2O+DMmda+0icjpz7Z2gbMYeGuIRBeU3PXv0ywL8
	qJRgwYH4zQVA33D1WA5E5x4/lbAXcyONgFe85uhhYv0V8xNBisVhwsaTTfA5jJn71WKHuJf17oT
	RyG2w=
X-Google-Smtp-Source: AGHT+IH9zuh0IwBkoewvGIgO8/CED1zpnPpU3SJpI3mT+2sTUv+6/McJoV9dw9ylKlFlqAeQzA5i+Q==
X-Received: by 2002:ac8:5a86:0:b0:4ab:5c2d:fb25 with SMTP id d75a77b69052e-4af109b48d1mr49979041cf.19.1754142116061;
        Sat, 02 Aug 2025 06:41:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4aeeedb0403sm30889761cf.47.2025.08.02.06.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 06:41:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uiCUk-00000001A2v-3YjF;
	Sat, 02 Aug 2025 10:41:54 -0300
Date: Sat, 2 Aug 2025 10:41:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250802134154.GI26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
 <yq5a5xfbbe35.fsf@kernel.org>
 <20250729143339.GH26511@ziepe.ca>
 <yq5aikj69kpn.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aikj69kpn.fsf@kernel.org>

On Sat, Aug 02, 2025 at 02:14:20PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Tue, Jul 29, 2025 at 01:53:10PM +0530, Aneesh Kumar K.V wrote:
> >> Jason Gunthorpe <jgg@ziepe.ca> writes:
> >> 
> >> > On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> >> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
> >> >>  	return crypt_ops->decrypt(addr, numpages);
> >> >>  }
> >> >>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
> >> >> +
> >> >> +bool force_dma_unencrypted(struct device *dev)
> >> >> +{
> >> >> +	if (dev->tdi_enabled)
> >> >> +		return false;
> >> >
> >> > Is this OK? I see code like this:
> >> >
> >> > static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> >> > 		phys_addr_t phys)
> >> > {
> >> > 	if (force_dma_unencrypted(dev))
> >> > 		return phys_to_dma_unencrypted(dev, phys);
> >> > 	return phys_to_dma(dev, phys);
> >> >
> >> > What are the ARM rules for generating dma addreses?
> >> >
> >> > 1) Device is T=0, memory is unencrypted, call dma_addr_unencrypted()
> >> >    and do "top bit IBA set"
> >> >
> >> > 2) Device is T=1, memory is encrypted, use the phys_to_dma() normally
> >> >
> >> > 3) Device it T=1, memory is uncrypted, use the phys_to_dma()
> >> >    normally??? Seems odd, I would have guessed the DMA address sould
> >> >    be the same as case #1?
> >> >
> >> > Can you document this in a comment?
> >> >
> >> 
> >> If a device is operating in secure mode (T=1), it is currently assumed
> >> that only access to private (encrypted) memory is supported.
> >
> > No, this is no how the PCI specs were written as far as I
> > understand. The XT bit thing is supposed to add more fine grained
> > device side control over what memory the DMA can target. T alone does
> > not do that.
> >
> >> It is unclear whether devices would need to perform DMA to shared
> >> (unencrypted) memory while operating in this mode, as TLPs with T=1
> >> are generally expected to target private memory.
> >
> > PCI SIG supports it, kernel should support it.
> >
> 
> Would we also need a separate DMA allocation API for allocating
> addresses intended to be shared with the non-secure hypervisor?
> 
> Are there any existing drivers in the kernel that already require such
> shared allocations, which I could use as a reference?

The most likely case in the near term is PCI P2P to shared MMIO.

I don't know any way to allocate shared memory in a driver??

At the bare minimum this patch should be documenting the correct
architecture and outlining any gaps in the current implementation.

I also don't really understand what the above code is even
doing.. Isn't the design on ARM that the IPA always encodes the
shared/private in the top bit?

How do we get a shared page that does not already have a phys_addr_t
in the shared IPA? Shouldn't the kernel have switched to the shared
IPA alias when it returned the swiotlb buffer? eg why do we need to do:

#define dma_addr_unencrypted(x)		((x) | PROT_NS_SHARED)

At all?

Suzuki ?

Jason

