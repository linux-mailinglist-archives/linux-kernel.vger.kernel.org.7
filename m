Return-Path: <linux-kernel+bounces-756706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C22A8B1B801
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A94818A7022
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5A291C36;
	Tue,  5 Aug 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jlZcSp/0"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087D291C0C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410137; cv=none; b=ZHNrIvZP69RSosajF//PHOByKh127tdlHIyjkfbq120/ajQywUK+SYX1U+ZMRqXEngAn4V3wACKxSREj4FEooSBzBUiKF1J6Kbof8AuA9h9RE3FWAwlulPypYwVOLsXb83scHz/kIw1/FdqRfwey/xbzlVO+JYIJGFfRF7AqLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410137; c=relaxed/simple;
	bh=kTcaW0q5ivmzGd4QOSXd/nHt7wH8yPYPEOgv2LKOSjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZASaPhS3oRmEW4/vFvNN7JgcNtnkRcSpWQnb0fWdbSiDW1MbTGRImDUk1tcA+FtLaMLJhwAR9Io+Ou4AmH9Uw6LwvkMRhl841E5Nfcaw29DK/r168QBrx19C7q6m2XtJBCBs6gKc7iavs1m1zmogj9KPo6PadUvcQ5Y8SbiLzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jlZcSp/0; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70740598a9dso39858266d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754410134; x=1755014934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3h4Juy631wFFbv9pOrZ90ugfOmUc0F+qy1FlObvh3I4=;
        b=jlZcSp/0DB0BLBDSof6DaXxjFAzb/iwwHDvApe8DXducC+eFBhToPGHfd7IKlYhJdh
         kEXnDKr/uuXO6nqTe92BkjqZAguYGvSCMd+XgvBl3eUo0xWdHXIwumrCVITG2pM+qU0v
         ttpPLJZACl6xvwvcJKvSCsPLLTEuNisFksLBGbONMttsJzWxBVqYslzOIW0YJCUIxvDG
         2+BOnqqlFdNLN1lQVNySU2vY3uD7qNgzbY17RVTwt+IFN+B/7duojNEjzuwTr5fRbMzA
         1CqfQwNACas3JeTuRB4zZ0vwxQhAferusCHh0p0vGbK21hrgqNiNz7DXIxDgTdzGVqoT
         pOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410134; x=1755014934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h4Juy631wFFbv9pOrZ90ugfOmUc0F+qy1FlObvh3I4=;
        b=bK2KhRUbBrv5dI67EUMIg4a7VP2Wju+Xt8MPQBjxlJmyRQwgu/JqLnRYiKTI4y+YcP
         BndMacadleTiwla/yhMcxOkJxbwnEcEvqBUXPbVDqJxV48EFbZu3DC+jhxWnjeMR8Oii
         tHyoyAZop/BDgcYnggWK0SwH5IM1x/OKqOmgTHtx7c6LLcor/mveyjhUj1jfeEwzUYC6
         M3XpDCU6Kyi77LLEbZRihSUXNGd95jy3NtZuCtSSoQ72og9rc/zrnYjhFqVJhmnsPg48
         SDrDCYE17v56/onv7iEncJJRxw6lb0FOlU8UFuJAr8NQxOp28ycBAmqUMzf0IKAUdfSk
         2+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzxQP793nlkIhOxUv0EGx3VJubYg3WAv7gzK/vmtJSXUN0+izfrEEnrjLhuI98VJkKDD472r4VQwrDqzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDyiz76ZCyzr66tpt9xvY8/Ce+sYShP+tGnYOLTKBAjt3E4Ryg
	9SdYWbB7MpY7iOA67x6ghMeWHmx4mkvbgkl6NZdAzPAg/EV/5hDqbbNvb68eOXn7R4l9O6dcH9A
	Uyr/g
X-Gm-Gg: ASbGncsG3nJThedcSyOKK9usZ2HXfAN+d53PLA45YyZlcTfheA++yG98dmltI+xIdKa
	EXvADSGLWlc/jx63RuHjHP+DAzqGrI9Xu9AxR3zV/Fu6pumFqT4gRZvy+N90Nz+iCX4nFa1dKFA
	qN4/Q5o5TA88rQxwT4s9TiYneHM8ZOa31BLhO1OinajTvHzdZFCAtKNJfuMEvCtj+DfxHVx6CBR
	PvxHylMthOIBQmHU6+HBKtrPUAyqjr5r2/X/qnMEprfPeC1lTd/xT7VPuDzVqF2yAMEje/54Sau
	LuGuPpKT5owwCwXG6Jt3mFepy9LdfwMzGwj+9WKOCKXvGdbowEm3vwNa4YeEcGNalUEm7IE5RTo
	FBRYqmgSIXRJVYfce09XCisned1WsKGxA1BWJH8StDCWaazdQ1t999A+JoTifOBERl7My
X-Google-Smtp-Source: AGHT+IHZ3PopPeTcQC5Nnc3xOLSRL4WyZRPVraWd7MpQSpA1ulubjE2uvQ7HveFIT+qKiSlQ1vJvtQ==
X-Received: by 2002:ad4:5fc5:0:b0:707:228e:40b9 with SMTP id 6a1803df08f44-70936287ad8mr236610866d6.23.1754410134379;
        Tue, 05 Aug 2025 09:08:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde8d56sm73667086d6.73.2025.08.05.09.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:08:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujKDd-00000001YvV-1cIz;
	Tue, 05 Aug 2025 13:08:53 -0300
Date: Tue, 5 Aug 2025 13:08:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 04/38] tsm: Support DMA Allocation from private
 memory
Message-ID: <20250805160853.GV26511@ziepe.ca>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-5-aneesh.kumar@kernel.org>
 <20250728143318.GD26511@ziepe.ca>
 <a22a1ab7-95c1-41be-b33b-a4009b55631c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a22a1ab7-95c1-41be-b33b-a4009b55631c@amd.com>

On Tue, Aug 05, 2025 at 08:22:10PM +1000, Alexey Kardashevskiy wrote:

>> static inline dma_addr_t phys_to_dma_direct(struct device *dev,
>>               phys_addr_t phys)
>> {
>>       if (force_dma_unencrypted(dev))
>>               return phys_to_dma_unencrypted(dev, phys);
>>       return phys_to_dma(dev, phys);

On AMD what is the force_dma_unencrypted() for?

I thought AMD had only one IOMMU and effectively one S2 mapping. Why
does it need to change the phys depending on it being shared or private?

> On AMD, T=1 only encrypts the PCIe trafic, when a DMA request hits
> the IOMMU, the IOMMU decrypts it and then decides whether to encrypt
> it with a memory key: if there is secure vIOMMU - it will do what
> Cbit says in the guest IOMMU table (this is in the works) oooor just
> always set Cbit without guest vIOMMU (which is a big knob per a
> device and this is what my patches do now).

AMD doesn't have the split IOMMU design that something like ARM has,
so it is bit different..

On ARM the T=1 IOMMU should map the entire CPU address space, so any
IOVA with any address should just work. So I'd expect AMD and ARM to
be the same here.

For the T=0 iommu ARM (I think) will only map the shared pages to the
shared IPA alias, so the guest VM has to ensure the shared physical
alias is used. Then it sounds like the CPU will sometimes accept the
private physical alias, and linus will sometimes prefer the physical
alias, for the shared memory too so Linux gets things muddled.

IMHO ARM probably should fix this much higher up the stack when it has
more information to tell if the phys_addr is actualy the private alias
a shared page.

> > > +	bool			tdi_enabled:1;
> > >   };
> > 
> > I would give the dev->tdi_enabled a clearer name, maybe
> > dev->encrypted_dma_supported ?
> 
> 
> May be but "_enabled", not "_supported". And, ideally, with vIOMMU, at least AMD won't be needing it.

Yes

Jason

