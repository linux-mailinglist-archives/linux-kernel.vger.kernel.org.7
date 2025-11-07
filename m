Return-Path: <linux-kernel+bounces-889593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 836F3C3DFD5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 08A86344BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3177F2D94B9;
	Fri,  7 Nov 2025 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fZTwWyy/"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD462D948D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475745; cv=none; b=j6XJql+mZbNBtgJMqyP86ZzHtvtpDDn7fN4QCGuqpWGipLtly+jm4DStvTK1/vDaMXBhQXZSF/297R8afIR9UE68C6lba9/047tNG0InVnThmD4blqaE1MQlYQwWKTzyZe2jKbprNSeH65RcsBAePbFaTSH1YWGsyKpN0uLwBI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475745; c=relaxed/simple;
	bh=26mhvWfpyqxVsoR6ouyViiXyO86XybPyAuTZV75c/PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXOoFaFbC92/ySSqg+6o0Yb6emPQUa/sGldTmAP45il0aASRsqZMUKQoJ/rIGBEJeHjGlWwhesGRuvzkb2IQIrWFvDd0oN7UWDGi3k7z1UOwwt9yJ5qgDnaWuE4vbYS+Xae+7CCe1LM+ERJbOMs+MZ+irutUWAQh3BhsEQEn9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fZTwWyy/; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-880438a762cso1471056d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762475743; x=1763080543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vFuvWNdBF6vFEowrW3WFaNnkoxz6xkvGAkNcwr5uLg=;
        b=fZTwWyy/e9P480wxHvIYKeew97hdz0sWGfT/mbtUkuRZgXj55ebZ04gQRkNkM4lBqJ
         bZyoGDT0TotJ0iiN9/eLk+G13KiLnOh2gYsydiHpJSi/eDLU3rSMg97ClfrWqs5KH5iw
         8SJaeeqIxWjdbdEZwJ1T9WbRPdHRS2EsroD8+6k7o1s3w7YkkVWnuQz5eBlw949sByzQ
         m2SwowhV9+Z8mh8U1mgxYrffbAN7LSLGsUNStvYJhfggszInETW6NvP0y/r3VVYZAFvh
         0ZvorHdzABjeZdT/VeqmC7tm9gp1FD06LDYcNxBEtV4/ugC9ueTQjRAT6NMv8QEiQqob
         LS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762475743; x=1763080543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2vFuvWNdBF6vFEowrW3WFaNnkoxz6xkvGAkNcwr5uLg=;
        b=PbjWbW3kDsDJcolGaYZCfG5Vk8TAFL1Zvtysh4ZuMNj3Fz0uUeq4oBoSubIuCdRKcz
         w0FB/KnOU24Q7iEXXKFc+iZbdiZkx+xNRQZxfRiqKneFnOeuk6NSXyk3gG94ILWS/xPW
         cJguadenzNkkjv/d4iA/6+h05A0Neo8/CaowPBlw2mojk38tfsdjcjuO6D89RFRiO4u6
         1XlP9j5FVsokV1pj0f4Uv+/rRKtKADY2ANjd2148CSm6DTFju8Wl225pK3NQTvN9H7Pg
         CX1aYfkgwDN69mOL7MdRqSTzfruYaIW2lEXQHRBUn68Ex56cKceIyXoeJ8h8UF1Lb2Yn
         TDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhr+igvXo1pz5nH4KwnCShbhCI8FPEr5TExICYbTgfnpB0syeoFr/L/cZAP2f5CrUKEWpGBsrX5ZFYtqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2j9jy4sPNRMJ7MSiBnp6mAjg/Mm418sLa2aSgFrZfThXZbDHR
	y1A3WY9GmL1UvlSJzbAq9PVPB+MHXogoauXb2jAb/yMNPxnDFtNhFbPU/XEBn/sQ11I=
X-Gm-Gg: ASbGnctHLS1Yv0QkDgiGMBoNVewSbRozrTyLib4I9oPrPlRLjskurglW72TblZJ6S3N
	oLZBUhuiabWU2DMEvCOLBDV+XRsjmpqd1cDYCEBreBHIO1RphoA+TEydMInEAl6K2//e9NVH1TR
	1ZnaoJ5aUnynhUDc/4IR0gWFgi0feXbi4V7BLC21QaKEjgQ/Hh2qKK5gha9NeE4g4C+U3gUyEWD
	spt82jJ0KHf2qZ8AjOJYtVP7YZRIxkg4zXT0DFWGjHtjc7IMYkkKYCbRQoG5uB9JDj/62ERz0Zp
	7RXHmAA23CVAdMVsn0KSqQzW37WQwxrqxvnllmsi4wH4TnFpaJCUHTTu76MH/ksin9djrgOZMmH
	k5YQ7qqMCYLvGH+P1nelfzU9odplDRStBPGM2YpXcsj5LgFYo4l8ckf6DgttK2/nE8ohYY8q8NF
	SsNw/HO0QdtBtotgRWc4TOuDKtBFWW5WiziBXzJB2GfNdW4Q==
X-Google-Smtp-Source: AGHT+IFi5H/5K1qU/qTfa8zVHoasmFdiSIPqdCmrIYTpSC/tr3U2fbrwxyPtE8hN3rVdSnFiBHg67w==
X-Received: by 2002:a05:6214:2627:b0:880:5edf:d135 with SMTP id 6a1803df08f44-88176760434mr19773456d6.53.1762475742503;
        Thu, 06 Nov 2025 16:35:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828f5b1csm29528776d6.21.2025.11.06.16.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 16:35:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vHAS5-00000007WOg-0nM1;
	Thu, 06 Nov 2025 20:35:41 -0400
Date: Thu, 6 Nov 2025 20:35:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH 2/2] iommupt: Describe @bitnr parameter
Message-ID: <20251107003541.GA1792527@ziepe.ca>
References: <20251106073845.36445-1-bagasdotme@gmail.com>
 <20251106073845.36445-3-bagasdotme@gmail.com>
 <9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dba0eb7-6f32-41b7-b70b-12379364585f@infradead.org>

On Thu, Nov 06, 2025 at 03:48:10PM -0800, Randy Dunlap wrote:
> > diff --git a/drivers/iommu/generic_pt/pt_common.h b/drivers/iommu/generic_pt/pt_common.h
> > index b5628f47e0db40..54c16355be2842 100644
> > --- a/drivers/iommu/generic_pt/pt_common.h
> > +++ b/drivers/iommu/generic_pt/pt_common.h
> > @@ -354,6 +354,7 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common);
> >  /**
> >   * pt_test_sw_bit_acquire() - Read a software bit in an item
> >   * @pts: Entry to set
> > + * @bitnr: Bit to set
> 
> Shouldn't both of these (above) to "to read" instead of "to set"?

Yes, that's right, Bagas could you fold that into a v2?

Jason

