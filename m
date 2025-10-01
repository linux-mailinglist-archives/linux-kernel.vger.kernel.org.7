Return-Path: <linux-kernel+bounces-838830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C16BB03C0
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED453BDB84
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3270B2E229C;
	Wed,  1 Oct 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eU6B1ivO"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A9C2E1F02
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319266; cv=none; b=rU9o2asstMJwdxPNJkS12KsnkNkTeq16yTWsLeFkzKURdfAOy1XpineWrGKuPOnrk9GKko+oHzLrw8Ot+iTabYXuaxBdHonAz7ZHOQJ3LKNhBPtRxTmxtOhRpM1KjQYrm5MhX+Axc+IEn6Tg7qA6ELRqQRHVv5gMS20hgPjDOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319266; c=relaxed/simple;
	bh=Kym2K7zv6YgSbvtfYDjPoU8YAALp29UxTohwMy3Spj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kokZBNOOv0KZA7fehRQ/ghW9mec6c/59ZKwqX82Sv4Qbn7uN90KoyrJSpa8HKrApD+11JvLDvTzcjdp+BM5kUEwxw8Hax36OXBsDrkAr4OAe/kTDbtCpKwLa+uCAPv0CDFbFbhUtFMrBYqFvNPoFd8Ijeb8ugNCr+fu5scrkfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eU6B1ivO; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4df2911ac5aso28198581cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759319263; x=1759924063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjfKbtWhsLucd83rhK1I64ABwmN4n30TmWSDIMpSYU4=;
        b=eU6B1ivOQAbDSJzthcFzYo+bTXwRvvoLEwvvX3MyoE61wbgREl0ap09xDl1aolj436
         x3h3m7qxQ0ApRpyelOsdD4zRvrQHW/yV3iVZ3rubxdXbOuYxaIshJ9osJz/URrLxVmLu
         GKoIyWkYcB1iCPBuuLKhd2+CzeLzTi9sRuPf35UIEKHYc/3m9Oo+LWdAl3IydxGPMq0B
         PTI8g8/uDC51injyGyeZzOvzTgNiIlo8/LnU/kqIJDcUZUJVCsKN9WIT0Dft88efrR1X
         6MWnFhYpSJa7sP5pNxtTgVr5eUW+gkMiK0yfSxNlBF8dDc7x1m3elH5FTdW3bKyd0pTk
         tC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759319264; x=1759924064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjfKbtWhsLucd83rhK1I64ABwmN4n30TmWSDIMpSYU4=;
        b=LFfbtxY7pc2V7ubmeLz+1g3B0Y1i8WJF4uRlXYOCzNRaaxgV1gFaDgarLMDE+zx6JM
         NyCeO05SJxsO9Vtk7GozVsKX9E1ufWuNwdf/HviMtIzkdce9/ELq3jwkMcF6Q7DT4o/y
         YYnpOEaWh0vTUIbcGAXzeJF5RZM8kesF33R70i0UN3pbYWenqE3B4OGvrDVDXkE6EGIW
         mZQxCqnRsXOLubT3+qh5Af2RoYBNOt5sKZXYfHLMOgubp1S8nPDPbVsKks4td+RIIJtT
         aIPt+RmereE/I90cTLJhu18ni+K0UKjP0GcdH8900lR0eR8yWekRoV6bC7ZziH5qIanL
         DSug==
X-Forwarded-Encrypted: i=1; AJvYcCVXwyZEpZAXD4Yz9dO/lnU3hqiqu7OOY3z4LISYpM9amy3DIdTWSqi3nn1gBls/9cG98svs392U5RKwI9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHwM7rM+oYP28YVd3ti5KbSp8aYdA6UdpY/Jkh+Xz+ILU1yA/
	pFrA9ihe4GFk8QZIg1IOj5otuniiTD9Uuu2vBDy+porBM94l85YauCDuzqAa5CHko+Q=
X-Gm-Gg: ASbGncsN2hsNk0ZIIi6uQrd4QoN78f0iq+vhkV5RwsXuF+hAdav/zGwCxgX9iGOGsNr
	RB2M1bkaYxGE3pyNzyV+yTSvRwyWGrHGTB9qCVyVDb2O5QdtE/JyOKZQzc4HD3rxqgzUrsVbbyH
	nEZWw13qOZDr6IveeanNWcwLNWciZhZZdofSrISHhILh0eHhlOVmrquA/4s6TOXEcNa20ACkJr+
	CNVa2+i95r5qBEkiAtVkjBOj+sPsbPGJiatUWXX5kfLsRDN34dUJVKmxeR2lGozP+LugUGa60qa
	q9CXEYWMSSOSwacLkhHNB+1YBwrNNvubM2r8mTrFx3s+GCqApEHjxMozJ+8DdCjnuKQgGLPFLSJ
	3a7FYRST+lkHWDS8dVdJ1
X-Google-Smtp-Source: AGHT+IExJR6eyJW/ikE5CVaFn5cEfc1pD9t1SxPLHxqTb+4f95a8pqcY5akCVVkUlNL9iNQo56Ln/g==
X-Received: by 2002:a05:622a:411b:b0:4b3:214:1eb2 with SMTP id d75a77b69052e-4e41de72e4fmr41343891cf.47.1759319263539;
        Wed, 01 Oct 2025 04:47:43 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b94599esm113778621cf.16.2025.10.01.04.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:47:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3vJ8-0000000Co9H-0LuM;
	Wed, 01 Oct 2025 08:47:42 -0300
Date: Wed, 1 Oct 2025 08:47:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
	YiFei Zhu <zhuyifei@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com,
	Chris Li <chrisl@kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
Message-ID: <20251001114742.GV2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>

On Tue, Sep 30, 2025 at 04:15:43PM -0700, Samiullah Khawaja wrote:

> > The iommu core code should be restoring the iommu_domain as soon as
> > the attached device is plugged in and attaching the preserved domain
> > instead of something else during the device probe sequence
> >
> > This logic should not be in drivers.
> >
> > From there you either put the hwpt back into iommufd and have it free
> > the iommu_domain when it destroys the hwpt
> >
> > Or you have the iommu core code free the iommu_domain at some point
> > after iommufd has replaced the attachment with a new iommu_domain?
> 
> But we cannot do the replacement during domain attachment because
> userspace might not have fully prepared the new domain with all the
> required DMA mappings. Replace during LUO finish?

The idea is the kernel will restore the iommu_domain during early boot
in the iommu_core and then attach it. This should "rewrite" the IOMMU
HW context for that device with identical content. Drivers must be
enhanced to support this hitless rewrite (AMD and ARM are already
done).

At this point the kernel is operating normally with a normal domain
and a normal driver, no special luo stuff.

Later iommufd will come along and establish a HWPT that has an
identical translation. Then we replace the luo domain with the new
HWPT and free the luo domain.

> 1. During boot, the IOMMU core sets up a default domain but doesn't
> program the context entries for the preserved device. The hardware
> keeps on using the old preserved tables.

When the iommu driver first starts up it can take over the context
memory from the predecessor kernel. But it has to go through it and
clear out most of the context entries.

Only context entries belonging to devices marked for preservation
should be kept unchanged.

Later we probe the struct device to the iommu and do as I said above
to restore consistency.

> 2. Userspace restores the iommufd, creates a new HWPT/domain and
> populates mappings.

Yes

> 3. On FINISH, the IOMMU core updates the context entries of preserved
> devices to point to the new domain.

No, finish should never do anything on the restore path, IMHO. User
should directly attach the newly created HWPT when it is ready.

> I understand the desire to have the preserved iommu domain be restored
> during boot so the device has a default domain and there is an owner
> of the attached restored domain, but that would prevent the iommfud
> from cooking a clean new domain.

The "default domain" is the "DMA API domain" and it has to be created
and setup always. The change here is instead of attaching the default
domain we attach the luo restored domain at early boot.

This sets the device into an "owned" mode but vfio can still attach
and nothing prevents iommufd from building a new hwpt and attaching
it.

> Maybe we can refine the "Hotswap" model I had in mind. Basically on
> boot the core restores the preserved iommu domain, but core lets
> iommufd attach a new domain with preserved devices without replacing
> the underlying context entries? 

Replace the context entries. If everything is working properly the
preserved domain should compute an identical context entry, so no
reason to not just "replace" it which should be a NOP.

> > Also there is an interesting behavior to note that if the iommu driver
> > restores a domain then it will also prevent a non-vfio driver from
> > binding to that device.
> 
> Agreed. I think in the "Hotswap" approach I discussed above, if we
> don't restore the domain, the core can just commit the context entries
> of the new default domain if a non-vfio driver is bound to the device.

As I said, the owned nature of the device will prevent attaching a
non-vfio driver in the first place.

So the only path forward for userspace is to attach vfio, and then
iommufd should take over that luo restored iommu_domain and eventually
free it.

You might consider that finish should de-own the device if vfio didn't
claim it. But that is a bit tricky since it needs a FLR before the
domains can be switched around.

Jason

