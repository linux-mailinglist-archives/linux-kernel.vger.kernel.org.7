Return-Path: <linux-kernel+bounces-838174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2B8BAE97B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF271945D78
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117F228D836;
	Tue, 30 Sep 2025 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VYi1WeRn"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA3242910
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759266309; cv=none; b=LQdCOvABDPFVG6Re9njSg1FrjzVnOMbg0pf3VfwClGaitGGAjVREIyo/0G8yw8IQVUAMtteJ0hc7bFMRFGVCSealpiBwpZkmGZleu4JmKdCrALFq0t7TuaAeVsnxZa6Sbu3IyPjFJK8dUEqp6HWOWSRoWgZXyMUiDAG2I6SqBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759266309; c=relaxed/simple;
	bh=lEGDXr0OSsJFsEaYVFe7+rsm4OTGb1tv7ozhbvoTJ2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awXjgs/BckXMXAIHaz+iVKLuKBL5jnnFLsxITw19DXkb9lIut5gQKw08Apv02unLoEUbGu1VnoJvbIuHmeJJ3XZi7qmOukZh7zsekFJRX5usSU+Blh5Rba/inLYAFSPpM/487m9A2Rd/WhIrh72MzrMt5oSP2ZsQEGa0jhJ+aWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VYi1WeRn; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so6206315a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759266307; x=1759871107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql1Q7wmWT9QRnmXaB5Vhny8NzT+Ua/Ks+K1EVPAtCvw=;
        b=VYi1WeRnq/g2h9HnBB2vI9iiDRWs51Sl5uiPaS4j0hyjckb0JEEdZ+uG3a8JTw2gzY
         xxo9TD5jBeiaafgNabziWsewGhsgz7RkoUi1VIpw2M+q25B2KXEhPMS4FknZ8OStLbV9
         rE7txmx1Zh1kSSmikiZGP/0cZOf7Dc1EZtk1408wB0KachOg57V0m1nwUYxRw85b1BqY
         2xstKiqetZmbHqEi9CKCYtdyb5lqDzZFk1Ee0SmvtpRs2CDP7d0injLnnnnb6weTAQ5u
         nBEO4R75XAQp612MgMnuG5nw/ZsixAjolJusr32u/1uYee/rWnxefxDJZGd2B5QAVD1l
         2elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759266307; x=1759871107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql1Q7wmWT9QRnmXaB5Vhny8NzT+Ua/Ks+K1EVPAtCvw=;
        b=b1l/y3r5G7CJ6Z9J6mwI/5kFfB8nVLFHaANSf0P6ObL1k9C87Rwo+dm6tC6e04qUyG
         AZ4RjXBg0YcI1ELv4XJWbyTeCN4qP5X0HFUtHT+v5R5vYFb7qiHZ1mXFHIp0/pfoIw61
         E7LafPiVCKYbFyQCwrTnKrUoCyUm9q3ebOni4mE8VNKsGgqp1PLUS+6c9x23Vybw5Ysv
         q3q8Ffl8MBpY5/xflwtTO1Q1x3kDDVf5RZrOn/L04CRAygkRFDBEqe81gvd8J18YdZFF
         xqYmZb9Bo7RmF7Ntr4Y1cU+wgRTLc/LhYAjtWkbQAXt9h51k39H1MA0d+9mGIpTz+TPC
         8r2g==
X-Forwarded-Encrypted: i=1; AJvYcCXqKV7aT6rdVxnODYgUJSRNnAscoOeczJCavF/DgSOaWNv6QeeFuCRcbiRUReKXG31zlL2z804ttn2fKcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtE/dIcvYQP4FSkHSjDrUbB0x3qmjYHLu3usGPguzMLugysWP
	HMR2m38ajJUnem312KCJYCtZ0pgQQfNi6hgbBASTd4T7jciESeThwyfknIl7jdCUcIE=
X-Gm-Gg: ASbGncvCkWl6TUImszzEfRgDBW4TMel84aXe2clQXdolIlvoOP5pYUW/9gl+vXhe4jr
	oF0CYi0WO3WUFOmn8rkWT4HoLBGFyADNW3hUU/UQkOEwhm4lLYsnT+e9UckovK+VhZyf3YmGr5W
	RSzdxQF5FAsgCRFMl3pFdfKcH1FpKC1hfhOvknVzJvkhsjqZd/neF+R7CaNn3xzBlDD12aL5uLH
	6k164HJ6J8wIWO2jwM7YzmNj1BXseOM4HT8Z3yiL1RhdPyeTwTF5S7c9CxaxQE7i3dmVi146sQ+
	XUncsDKzNlV6c+yz1Z1jY7VNy3cGFC3Zj/EOeqaKwFmvymmp0uhZ19zhc6fTRxLIxdibgFgNpZU
	cgkjurWaU7Gzwm5CZOgO0
X-Google-Smtp-Source: AGHT+IHn9B4YPhcXSlM98kFJ+ee5CCn30TAdf9k2oVDRoOfjvEqnxoeTEITK+r+k1FFQmfJz5mJuvw==
X-Received: by 2002:a17:90b:33ce:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-339a6e9d33fmr988326a91.12.1759266306958;
        Tue, 30 Sep 2025 14:05:06 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6effe77sm493824a91.17.2025.09.30.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 14:05:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v3hWy-0000000Chej-3Vt2;
	Tue, 30 Sep 2025 18:05:04 -0300
Date: Tue, 30 Sep 2025 18:05:04 -0300
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
Message-ID: <20250930210504.GU2695987@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>

On Tue, Sep 30, 2025 at 01:02:31PM -0700, Samiullah Khawaja wrote:
> > There are HWPTs outside the IOAS so it is inconsisent.
> 
> This makes sense. But if I understand correctly a HWPT should be
> associated one way or another to a preserved device or IOAS. Also the
> nested ones will have parent HWPT. Can we not look at the dependencies
> here and find the HWPTs that need to preserved.

Maybe in some capacity, but I would say more of don't allow preserving
things that depend on things not already preserved somehow.

> > Finally we expect to discard the preserved HWPTs and replace them we
> > rebuilt ones at least as a first step. Userspace needs to sequence all
> > of this..
> 
> But if we discard the old HWPTs and replace them with the new ones, we
> shouldn't need labeling of the old HWPTs? We would definitely need to
> sequence the replacement and discard of the old ones, but that can
> also be inferred through the dependencies between the new HWPTs?

It depends how this ends up being designed and who is responsible to
free the restored iommu_domain.

The iommu core code should be restoring the iommu_domain as soon as
the attached device is plugged in and attaching the preserved domain
instead of something else during the device probe sequence

This logic should not be in drivers.

From there you either put the hwpt back into iommufd and have it free
the iommu_domain when it destroys the hwpt

Or you have the iommu core code free the iommu_domain at some point
after iommufd has replaced the attachment with a new iommu_domain?

I'm not sure which is a better option..

Also there is an interesting behavior to note that if the iommu driver
restores a domain then it will also prevent a non-vfio driver from
binding to that device.

Jason

