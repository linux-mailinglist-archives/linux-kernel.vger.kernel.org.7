Return-Path: <linux-kernel+bounces-840389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC0FBB4464
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01E3E7AB994
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF1318DB26;
	Thu,  2 Oct 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O7OQi6VK"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB517A2EA
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417818; cv=none; b=eTtWC92JbrDoLqJjTkBpcFLT9yYDWO1J9AHzlWn4EUMzATZZ0g4eBbDPbaB0xi82UbhKXQaHPA73fhtzfzMfgpzsAuuRo6VaRqNymw7p+yKiuvi1dma0hII8w8PMBL/Ax6bGcCMOkyJBhEXF87EZ7TSo98pd6R6rDsC8EMdGSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417818; c=relaxed/simple;
	bh=b3b0GgTGV6Hmr+OJGvLRHfofff0kuMaSa1ZnGyJX+WU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teAquhle38NFFXKDy9YwPEtOeBgnz++N5u/vFMGUsncxblpjjSJJx0DCUhSOtMyBwB3bZHsudLSZ6RsQdBviU6Y69AqZKWWrNvr+e68SfKOBACuDoUaKRmxIE22oe0J3AF+9KlA82n9ozq87isMGcyslktGeC5aMqLYecCFZLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O7OQi6VK; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87745ca6cc5so16574906d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 08:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759417814; x=1760022614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwVQnMIQJRoqf6cZxOx8gI2Zws34ldaT5+3ZuE4JgCY=;
        b=O7OQi6VKSMx209JQtJVfmK/4fHwkcDFYS3dZbXrpQt9mreS9WH2TRWG41sZRf53qv6
         fdcSGKA7Az3Y42ajnK0kMYUMC7xis5QgwnIE5wXCcubBoUzzUlGxXAa4mAEvvSYjs81i
         xLciD+7fj+9G4/2whCAe1Id5I4IAL+7LJAjhslEEMXRE//kgVgZAUlBazctQc0ydR9TH
         jETi97Ot917pdAcdWUmD8RobXFWQ9ubIDZmCKnpKprCvRjPiVVmlk2xcg9ZT87CVP0jd
         h4G7qf9dtZohiNnVRelNvpWPkPGgtJc9OCROkP0pnO7Bz46BdtCKEAfQZVCKOC6egXlT
         qZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759417814; x=1760022614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwVQnMIQJRoqf6cZxOx8gI2Zws34ldaT5+3ZuE4JgCY=;
        b=XCClfbLWG0DARPEpSo/pND4zy6DIm4xKr7mkMz//2DtWjv6gxKnSCnfOqcLppblCCr
         19K3PkMbByWoVNwvT8rRG2awhmyKiYQzo5bSf4s5mCFackpgUigTS3Fm2SJlTk9c5Sei
         nBAsrYtYwmILfu+jASsFETF6B43Ujdli6HEGb0YOamE70DrBtraYA6svcZfDlTucbI98
         9y63rn3jJ/memZmQLK1QbHHgAqaFnjr7ExcCiGEs+846FqnFhZPFvOyaNlV8OyY8dFi0
         fG+91HO4VLQ8nPPPgLfPMnB5Ugz1GDwGodDwV5gN8Ly7MAINt9NA7WMim9pHTnRr5CQ9
         EOfw==
X-Forwarded-Encrypted: i=1; AJvYcCX6+bRXT/s0ghnXR1n0win7jZMLMHft8arGpC0MUcBEyS2f3tk/4ys+qZbicjvSTiwRHpqgB4mm6fcREwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyd2DYOqCam4dWTMj8/Q+kfcgLcAmNgJvFkZcaLU97/poTJjEU
	6DnYqSZXG4bmVPWnW61pO771OIlZ9e+jaRx2HyYBWCACLEw8sbi8Xnk/HATxdIhzMqU=
X-Gm-Gg: ASbGncuck/PuNI7fn4uIXYt79srnzwwf8tupAaE+GpWI5SqigVcq5/ri29/x0fQFGDZ
	yPlNzsNGEphJ6m/jNqH8FGCsOFelg8WbmWpyUuf91Zw3cznMNZuL+bP6XAM9pqcxPiclWPZMnoV
	EACwDH5CnQsy9rSAMVimERX5ToEkBLTOtvtGJLD9mkkJRginn3VKLl+F6AhRZDUGE0WCJk/X7bk
	dzMr+eX+MLmUm/4UUW5GrKtgIIsebHO5/950f+3T6d3K4EvA1jjZGj5I0H3W3lD8tA8kHuh3mdR
	2cp5wF4cjLbNMQU6qlWYaQVf2OBP/RZ8ovcFR6tyF07CH0rA1AewOSEKHMejnEFXtp4hw5WXypJ
	y5hjeQXGdjTjS0nVr8wLRAOSvnMkkXa4jGqku9KvILcOwY6MxI1GnZkyU70WXGJDKqoaJGs/NzQ
	LzLl6wuN7VXNUOGvJy
X-Google-Smtp-Source: AGHT+IF4uLyOJyU+FQkG7ZTwurw1/BBZxzwtU1q+E5QaCkyyuySCOBbJTUQR1yA4rk8aOhvuD+eTdA==
X-Received: by 2002:ad4:5946:0:b0:70d:cef4:ea42 with SMTP id 6a1803df08f44-878b94ffb45mr54873466d6.1.1759417814221;
        Thu, 02 Oct 2025 08:10:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd87b40esm20126476d6.32.2025.10.02.08.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 08:10:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4Kwe-0000000DqC9-2iPI;
	Thu, 02 Oct 2025 12:10:12 -0300
Date: Thu, 2 Oct 2025 12:10:12 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
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
Message-ID: <20251002151012.GF3195829@ziepe.ca>
References: <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca>
 <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>

On Thu, Oct 02, 2025 at 10:43:45AM -0400, Pasha Tatashin wrote:
> > Finish on resume shouldn't indicate anything specific beyond the luo
> > should be empty and everything should have been restored. It isn't
> > like finish on pre-kexec.
> >
> > Userspace decides how it sequences things and what steps it takes
> > before ending blackout and resuming the VM.
> 
> This is a fair statement: userspace knows when vCPUs are resumed and
> can decide when to do the HWPT swap. Following that logic, what if we
> provide a specific ioctl() to perform the swap?

Yeah, that is what I've been talking about. The ioctl already exists
in iommufd..

> What do we do if the user reclaimed iommufd but did not swap HWPT or
> did not perform some other ioctl() before finish(), simply print a
> kernel warnings and let it be, or force swapping during finish before
> going into normal mode?

The problem we haven't discussed how to solve is the linkage between
the iommu_domain and the memfd.

Since the preserved iommu_domain is referring to memory owned by the
memfd and the pins don't get restored until the iommufd starts and
generates new pins. Thus we need to keep the memfd in a frozen state.

Maybe that is the real use case for finish - things like memfd remain
frozen until finish concludes.

However, keeping with the keep it simple theme, finish can just not
succeed if there are stray objects that userspace has not cleaned up
floating around. Eg a simple refcount and iommu_domain decrs it when
it is destroyed.

Jason

