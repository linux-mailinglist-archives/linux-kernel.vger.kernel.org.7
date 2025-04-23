Return-Path: <linux-kernel+bounces-615282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B25A97B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 01:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559CD7A217D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 23:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60470215773;
	Tue, 22 Apr 2025 23:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zu90Bv1D"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B220C460
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745365389; cv=none; b=RQNQxtl65uV2vfiN3n20CKsxMDbB9wq+N5E6wDI3erIliwlm20zFR3jr98ik2XFO78fndKzFl9myoqRhn4Ghnb7HGw5X+qorXBS0kGFXrPWIWKk+nF+v7t/0aNHMMnM3ay++/WrGZkCY1leeYj/OPUqIjRuonJ4oe/hZ059vPRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745365389; c=relaxed/simple;
	bh=v0cCoG4hu0MAdn8PJxhcSn+lcyGfNDP9cmZ8UNW+RxE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf+wxSvAwZdhVfllUiXHlYAvZGEvJnj3/LY2RzLzx/1NzQmC7Q8DhQCEO2aKcZxz0bDl/yYmvu+PwuCmUTlv9+/yh7AMKcOvF8jb9tshxhs8bCsPEi+/PO6KmQNOR7LJc3PHXYyng+35COjbal8YiErp5R7P8DKYpPw2FsXeJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zu90Bv1D; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c7913bab2cso553594685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745365387; x=1745970187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H8Zxh8t9YCpxlI0ZgT0ViWXKWEXuTyrLctSuix77HrU=;
        b=Zu90Bv1DdgtfACpGthVqCjW8fargz3qcxn5cRlKl/8vuS6I6cf//pSMQWBHZ8hWBR7
         Z6ev0NxfvMjh+xTxw3dUDMuJBr5G8zC1p54HLUb4IqmVELy2ExnFz3atim70DaSxAdMd
         wbJHUIWcJk3Aqn2Y5aAqOscOGAfrJpMfFbpCkuJ5/TFo0wvVtPQV2lhONuHDgUb7hp41
         rk1vZx8KfVp5T4u7xtJn1WxkeSf8+UqZ6zhmtNNZqiUd9uZ+nGrKHzOtrxIqUjEHzdds
         Xg+Rl75gRqCdZDZ4EcBLwGfgPLxOSg0rBTJe+F3/ik0+T1DDFaM5V/sCfumYnGlicPIC
         tmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745365387; x=1745970187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8Zxh8t9YCpxlI0ZgT0ViWXKWEXuTyrLctSuix77HrU=;
        b=Y415cWT8gUx3UC2ZzpcUHwlvqnkpVCRZpWEmVHP1I3O2WtB0FBKL9ynHB2x3D0o05U
         exTb4tH89dguecni8ZlPyHnggoPua4ppu/fwmJAXt4sreIrDFHggDddRzN+kFJUsnoud
         LmfvBjZYv/ig5LQJFI18wbmXjOeP0HYwVlxtLVdQao0tj0Eb/tqkdiS8AvyhaRA8XWOm
         2b7Fg1PVSnunrKEzNI+t86kZmk3hta8E2Kx6eKw3k2fWtSWbPa8gvXGeDBcTKXkQbjVe
         6iEPvcH9xKx9/NBU2ho7QXfOR8afXu3ieLnAwwRvR6qQsBeduUHFg8/vv6jQvzQ6Ruym
         bm1w==
X-Forwarded-Encrypted: i=1; AJvYcCV61F3R8N+lUUPezJzAJRfNsSKBPG3qbdZDd4f3vKh4HL8M2Uy+u1Y8NABMYYfNNY25oaBq0tHTOehjXZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fu/8TT3IghnsHkQKWjAJvF3hbRSM/hoM75M5Cd+p8i1/HvZN
	Ff0WIsz1te2IUKGTjMT7qLimyVcz2/4kG39CTMXNGYJd9m/g9Yzf+rPkHMrqYFw=
X-Gm-Gg: ASbGncvBic3RisNBfrWpsG8KbT4iar6kw9Je3OhwUvp10cZonaA2OTvQCxJTURFW+7k
	Kbx77SvFAr8S2HX89Ic33FW0x6A6/TjXF0g4FnUK0uc6IYmAECvnPXMICcTyVcrn2lGrxa/7SVY
	z4XY78paJdrkiX+qHIvi5LEez4zaxztud4Kboa5lw4waMAdW66q8x4oTjPasZLXuZBvoASOB+u+
	ObpjUZV/OJmAztUp8llc3p16ZoH6GDnA3wjxXMxaHe9UUyqjO+pMXkyOmXF5lL3pEoM4kjwF5Qj
	jjRHiKTEDcjtnJT8WVb+68FVDE0d3TzHRLRGrzU5zAk9vTs/Um++nVjqesu6PJVEHIN7HaJd3Ye
	zaHEwqsCYRzw+VNZd4Cw=
X-Google-Smtp-Source: AGHT+IF0d7xIg/JkBNfKB1dvFEqi+nm6q/lLlUP8QDJzin7elXIwVxFKdmisgA6rLVL2E6mqGZK00Q==
X-Received: by 2002:a05:620a:44d6:b0:7c7:a5cb:2b65 with SMTP id af79cd13be357-7c927fb2214mr2562644385a.26.1745365387014;
        Tue, 22 Apr 2025 16:43:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b69579sm611812185a.91.2025.04.22.16.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 16:43:06 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7NGb-00000006xvD-2euk;
	Tue, 22 Apr 2025 20:43:05 -0300
Date: Tue, 22 Apr 2025 20:43:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] fsl_pamu: Use 40-bits for addressing where appropriate
Message-ID: <20250422234305.GE1213339@ziepe.ca>
References: <2025042122-prudent-dogfish-eac6bf@boujee-and-buff>
 <20250422190921.GB1213339@ziepe.ca>
 <2025042218-beneficial-wildcat-77dd3e@boujee-and-buff>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042218-beneficial-wildcat-77dd3e@boujee-and-buff>

On Tue, Apr 22, 2025 at 06:21:32PM -0400, Ben Collins wrote:
> On Tue, Apr 22, 2025 at 04:09:21PM -0500, Jason Gunthorpe wrote:
> > On Mon, Apr 21, 2025 at 10:46:19PM -0400, Ben Collins wrote:
> > > diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> > > index 30be786bff11e..a4bc6482a00f7 100644
> > > --- a/drivers/iommu/fsl_pamu_domain.c
> > > +++ b/drivers/iommu/fsl_pamu_domain.c
> > > @@ -214,9 +214,10 @@ static struct iommu_domain *fsl_pamu_domain_alloc(unsigned type)
> > >  	INIT_LIST_HEAD(&dma_domain->devices);
> > >  	spin_lock_init(&dma_domain->domain_lock);
> > >  
> > > -	/* default geometry 64 GB i.e. maximum system address */
> > > +	/* Set default geometry based on physical address limit. */
> > >  	dma_domain->iommu_domain. geometry.aperture_start = 0;
> > > -	dma_domain->iommu_domain.geometry.aperture_end = (1ULL << 36) - 1;
> > > +	dma_domain->iommu_domain.geometry.aperture_end =
> > > +		(1ULL << PAMU_MAX_PHYS_BITS) - 1;
> > >  	dma_domain->iommu_domain.geometry.force_aperture = true;
> > 
> > What on earth does this even do? There is no map_range() callback in
> > this driver, so nothing should be reading geometry..
> 
> I dunno, but your "FIXME this is broken" comments are all over it from a
> year and a half ago:

Yes, I know, but you are changing this - are you changing it because
something is broken without making this change, if so what, or are you
changing it because it looked like it needed changing?

> The logic hasn't really been touched in 10 years.

Yeah, so I'm surprised someone still cares about it :)

Jason

