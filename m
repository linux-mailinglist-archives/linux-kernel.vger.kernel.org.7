Return-Path: <linux-kernel+bounces-749512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9727FB14F49
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936A618A26DF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3061DC994;
	Tue, 29 Jul 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mMcBUAsf"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2519B5B1
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799623; cv=none; b=SRcIdeBM3eogX1ZAle+2nsawJevsYqObQck/Pb6JtVBkG4FShc2lZ50NP2TgfF0BGAn+vj3n0PkjVurlBu4U/+Ge42Ms/ALIKAwpaDqmVYAUoBhlaFdrnnaRCz+cVGhJmCoDQxy1CfcIvujkBlieDEjAjtaqOHd5Yg9613STDLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799623; c=relaxed/simple;
	bh=ojv5Z7THW8JfrqGJ4bInzPOYWW8IoCSNM6sPyk5dgw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtJaniEhFdVDjpi1Ai5mb7ZM5yeEZJy1i2Qcf4CkBzI1BVMXXiYtxioPqTWTe7rmn/jwuFcZYByNzvyWh0eHnXNiF3LqzstU9+r8mlqOIWs/7gifI5Ztyy1kf/bojPu/yvWiCTGQxGvIHlmDgR4Y5oHShC1wTFxzAKFeNNdzY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mMcBUAsf; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e62a1cbf81so792433285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1753799621; x=1754404421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zc+uyc/10nytSXi8WQLd6ot7w8SU7ZrDrS30Eiz0b4M=;
        b=mMcBUAsfjb+4KE9ZnowUGY8EjE28l49CbF/BuvTRGWAzmIA0Qc56/t3AguhJMNbNVF
         1wWFuIoFdOOP+KXyAxSU66sjM/J3MOvQPa4GcYJSHCXLPtT2FO88GbKfvYk0aBGaO8SP
         7wyEmZJImzxE+U9ttLdCsEUkKv7uM1kCoSe4rtG+nqHKeq2jaRTKLkHEuK2lOSrBtdpc
         iJGisdlVFnKRu400tLbePCdcRY4Tj6I2b+XQXNL9WzO+PDKdREhTv3fUUvqI4iEJFNx7
         egTwl0F5L5kc+QqnDh95OQ0XtOTkgGawrWjdAHT7S85/8T8UXJCjoNS/YUBqLfcOrjkQ
         2bGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753799621; x=1754404421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc+uyc/10nytSXi8WQLd6ot7w8SU7ZrDrS30Eiz0b4M=;
        b=pYGc3QTugseol7JqnwUxGVwUrlFNuUDDXGGGuO1DvWABR7hscU18vZpyTRu7n+X0aA
         6uemFJ6QEj3U3qxeMGfDWvK1KxqhtI5gubB7NRsLJYG1u/hqQL9JgBp3fcDg8FzLx80m
         yE5seD4Aw6lPbN+sd9aCw5UzGx9o6sYCEXx3QyVJF3J/X37B/oxm9bZCSMhx9mqlX0eG
         VIqAaWW80XtP/zP3g8EBGGsL0Cbpnf/QanHo3MsYZMxikUBDyj8B74Z1fsizmkdh839s
         xnOTNZ5B69pDufXCycBZ50GiuI2IiR6UIktNEqJKOoCbrgi5GPXBHI2cJSdRWLYbpQJq
         RUoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPjjb6aMd1pEIToSevchhRjo/O2ODdK649MxcqJ6OYCcQsV57iQBM/z4FTF+fR+88X2quTEKKmO9V7z7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywom9UtIWiWiYT9Ud7otZT1kdD8hw8jmkijtdo+AcZMfEF6zNW0
	eA5PKBulpHSA10xhnhEHWL9B0pbCAL2agHBvtD2CrXwJHUrBHUddEIXSBI395W9a0D0=
X-Gm-Gg: ASbGnctc703hB3XDxBIBtthRuymIe4RJ+fi8zVMcZJ33Z9d/GfbDT5l6jNnIow5/2c2
	fiTXdlp66bF7wwcA2Lm25nV8KXPnECKs8TEQ/7ZJRG/v7AVDe5DNbvs4jH16OnX0soWjUZb8Rr8
	snhexpdmHQ1dK0BvjAfELNKhJTV3Nk7pXXZz3BJ9GlXDsU2P5/hVjMOXYMyei7SdM0WoAbDjcHR
	faAFbyLX79EqHo2oo8GncZp2gBdlhbYs6brDfgHEz9eBV++mCCNb/rekqrEQv7kJ+ZN0e4bcvCb
	RVcdFqV0P2dBCROqPds4vuoiI2T0q+JHB4/S5XEGFGSB5qFBF4cMDUOZQDMXVVhdmJ4NOfaQ7WJ
	Tum3//Um5MHax1EyqbA0x3HCCUfjzhOJcZNRfQ+qKCoXS9E6H53bwZ4NzPsxL4x0WEK5o
X-Google-Smtp-Source: AGHT+IHlakacjzSc6HrtkoDQ+47XGGqWamMHvLTjn6gOzXHOqB44DtAdNM0WnIqA8RXRkWmuxkK6+g==
X-Received: by 2002:a05:620a:a509:b0:7e3:3da8:1d06 with SMTP id af79cd13be357-7e63c1bc55bmr1839986885a.54.1753799620968;
        Tue, 29 Jul 2025 07:33:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e64388f28asm436155985a.66.2025.07.29.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:33:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uglOd-00000000JId-3w7n;
	Tue, 29 Jul 2025 11:33:39 -0300
Date: Tue, 29 Jul 2025 11:33:39 -0300
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
Message-ID: <20250729143339.GH26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
 <yq5a5xfbbe35.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a5xfbbe35.fsf@kernel.org>

On Tue, Jul 29, 2025 at 01:53:10PM +0530, Aneesh Kumar K.V wrote:
> Jason Gunthorpe <jgg@ziepe.ca> writes:
> 
> > On Mon, Jul 28, 2025 at 07:21:41PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> @@ -48,3 +49,12 @@ int set_memory_decrypted(unsigned long addr, int numpages)
> >>  	return crypt_ops->decrypt(addr, numpages);
> >>  }
> >>  EXPORT_SYMBOL_GPL(set_memory_decrypted);
> >> +
> >> +bool force_dma_unencrypted(struct device *dev)
> >> +{
> >> +	if (dev->tdi_enabled)
> >> +		return false;
> >
> > Is this OK? I see code like this:
> >
> > static inline dma_addr_t phys_to_dma_direct(struct device *dev,
> > 		phys_addr_t phys)
> > {
> > 	if (force_dma_unencrypted(dev))
> > 		return phys_to_dma_unencrypted(dev, phys);
> > 	return phys_to_dma(dev, phys);
> >
> > What are the ARM rules for generating dma addreses?
> >
> > 1) Device is T=0, memory is unencrypted, call dma_addr_unencrypted()
> >    and do "top bit IBA set"
> >
> > 2) Device is T=1, memory is encrypted, use the phys_to_dma() normally
> >
> > 3) Device it T=1, memory is uncrypted, use the phys_to_dma()
> >    normally??? Seems odd, I would have guessed the DMA address sould
> >    be the same as case #1?
> >
> > Can you document this in a comment?
> >
> 
> If a device is operating in secure mode (T=1), it is currently assumed
> that only access to private (encrypted) memory is supported.

No, this is no how the PCI specs were written as far as I
understand. The XT bit thing is supposed to add more fine grained
device side control over what memory the DMA can target. T alone does
not do that.

> It is unclear whether devices would need to perform DMA to shared
> (unencrypted) memory while operating in this mode, as TLPs with T=1
> are generally expected to target private memory.

PCI SIG supports it, kernel should support it.

Jason

