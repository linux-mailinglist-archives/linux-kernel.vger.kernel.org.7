Return-Path: <linux-kernel+bounces-846955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C495BC9824
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CED74F65DA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821EB19FA93;
	Thu,  9 Oct 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="BOkzVqFH"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6C1A9F96
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020219; cv=none; b=dmHJmX+J3C0TzSz+Ecb3tHodkoSadRk8jc+M6lXqsmXzmTt7z+yQpJSp4Vc9hWDPtttB/FNVNiDR4ge4UUpPp0C9nKP4dpuCGEDIrBuocOUJlZRP7k0VpXEcn9L+q1KZ+jAsagk5KwNL30wxzcIz1HHz5Zx4splfguNYNCcga/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020219; c=relaxed/simple;
	bh=MbAn6IxXoYCyZexFvoEXvgKWUGG3Aew40oi74OvfjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWHjOJHZsSgxSKnKnz/M4ZIci7TngnvRtLCW2jHe9xQq3tDHewYJtISMx3SbEMD4YLiSNcqDnNvYU3TAS828fX14SP7ACf9hDPuce7puHDhK/IX0oD0Ul7EFa+zF2mT6fvvM3Jjt0f9q9iIl6Kp5w0Vdp4VEw+Eohf/updIQCfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=BOkzVqFH; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4dfb1f481ecso13387911cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760020216; x=1760625016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e09H8JuVw4CGVu4LXKpckxUyqmwU5fhDRfovcXXQuDM=;
        b=BOkzVqFHxBDiA5B0s0XrbYRIfIs3hMDIUxv0Sybl8y4n2B8DcePA27hNQgrqXTj2zt
         0DSpSWD9cnmfrAdN5QX/5yGNHk7hBf+DDAJmo0B+4vuIMNUj/DRdsXC4PAQ5dGpEcHYf
         F6MGf3+s2lx41xJtXjHeCOtIABWiHUaSWpRJ+79n6Mkowu54MBferX6uOOLrM6kqdgxt
         idp46Xbl72Y/STWAy0GWt+QRAYUpOb73rodLXBR8A6cPk0A7obPUy+GliGxBujiCVZIx
         2TiHqHoC+sAYG9cfUUl7B6jSQcM4oB3v32ErSnYeCxh10kRbxJn+FEI7iTZWDTLo1TyG
         qZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020216; x=1760625016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e09H8JuVw4CGVu4LXKpckxUyqmwU5fhDRfovcXXQuDM=;
        b=uH56QyIo3xbRnjc+lkn6iNl+cV8NCIQvoqpz89h8/2vs55dw4Z8bf0JQ0wYDNtsEcX
         rwGvHV+ETMjT86e1nRQS2nRUqkyRliYLjdSSMGnyTTA2feIYHjz5QEVw7D7XL9bKlkL8
         yzLbeSuFP+BBlQVVuwJpr+tFISCzuzTwVga/KGHk/SgTH8Wv/Ep/MiR930f4TXhMpR5w
         vdxe4Sq6b99BxZBqT2/Cue9puIWXMD9lznTG5G0ysjznemPioZGPE6Bys0soa4kveTKV
         f95GPV4/l8Oyi5nj3HbNg705R0lKvFxrBFsyBlrvb2UA6PZlQCxapgvhRtTkxUQ6zu0V
         Zh/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSufedcoeKYSWhvJImxfZBDjlUfPgEXF2tNw7PAyiy8D5OCXJuoV4YsvUyilnkaeSqY7Bxq3JIRNML3bE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Hh3tFEqOboOrqy2r/RyWuTvWtIdAtqbi8IP/me/QFMh5VQio
	zGNiK3zedi2GygOpu04+YQqvrUV0eozcGbjnnKtjdRiPXIHw4jqwUO5uYzaFkUNCasg=
X-Gm-Gg: ASbGncvT7FDEBI16m7kANpVrUWRAyJNDl2a/5gj4/13QOZwmj0Fq6Wq601lFV2vTzS3
	Sq/emPYFEiq9GtB76pyQ0JKltsBLFhMCiIzfQVw7yU07N5PL+289xzzq+MDXys2246r22nM4lpv
	BoDiLkV9fC8kH9u3Q9rc4OQguNdjZ3jBeDbRx4DDM7TBK5Ji0B6oC1lSyBuybsajqL6xu2HRaNp
	9WPGLXFZAYz5fZ8/fF3cvS6FDr7NcLiy+XN8nRv2xKQJQUL+UgY6mlX93IY/IuK+rpxT9F9ecBm
	/GWo7raHBmbkdVkCkH/qCw+E7trnEHY5LKd0M0/3iHlJe/7r+c71tceG4sekZdEjFnn4jFBfB1G
	V5xK/KUEcC5tkM43w7n9QhXclqLITw+8dEt5eqzdDBG78XMS85HQl+haLhDuJWddZejDBJlZkJI
	48GmRQpZgnlpIq4PZ/0McADBdwBTYzlznk9gUBNa8L
X-Google-Smtp-Source: AGHT+IEuLK9K8/tHFdY+GPJPmi23LKwWmvNrqeBvd0kYXhrW7D0oKUmleIkRDgwlwwcejqyQl94Zlg==
X-Received: by 2002:a05:622a:5889:b0:4e4:5f64:b61d with SMTP id d75a77b69052e-4e6eace67eemr119642921cf.19.1760020216302;
        Thu, 09 Oct 2025 07:30:16 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e6e7c88cb2sm46457091cf.26.2025.10.09.07.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:30:15 -0700 (PDT)
Date: Thu, 9 Oct 2025 10:30:13 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 3/4 v5] cxl/core: Enable Region creation on x86 with LMH
Message-ID: <aOfG9XKnGRrzxad8@gourry-fedora-PF4VCD3F>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>
 <aOQAb9H-wIxc6j31@gourry-fedora-PF4VCD3F>
 <ed390a72-2470-4e09-8fbe-56915d619dfa@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed390a72-2470-4e09-8fbe-56915d619dfa@intel.com>

On Tue, Oct 07, 2025 at 01:25:11PM -0700, Dave Jiang wrote:
> On 10/6/25 10:46 AM, Gregory Price wrote:
> >> @@ -1779,8 +1788,13 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
> >>  	r1 = &cxlsd->cxld.hpa_range;
> >>  	r2 = &cxled->cxld.hpa_range;
> >>  
> >> -	if (is_root_decoder(dev))
> >> -		return range_contains(r1, r2);
> >> +	if (is_root_decoder(dev)) {
> >> +		if (range_contains(r1, r2))
> >> +			return 1;
> >> +		cxlrd = to_cxl_root_decoder(dev);
> >> +		if (platform_cxlrd_matches_cxled(cxlrd, cxled))
> >> +			return 1;
> >> +	}
> > 
> > Is there any concern for longer term maintainability if addition
> > match_*() functions are added?  Or is this upkeep just the unfortunate
> > maintenance cost of supportering the quirk?
> 
> Suggestions welcome. Would be nice if we have cleaner ways of dealing with this.
>

Had a bit of a think about it, but nothing immediately pops out
that doesn't just end with more obfuscation.  It is what it is.

~Gregory

