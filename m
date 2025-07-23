Return-Path: <linux-kernel+bounces-742095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920DBB0ED1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1053A6104
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49899279DCA;
	Wed, 23 Jul 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5JChJ7B"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227721E5B70
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259082; cv=none; b=MAai834q4Fn0qovdLKpN1+44acPvW4jceu/oX62CbDL5aKBk/aTeDzsJoKp8NcyTGA9F9bcLw0M5gts7Cy8O9yUrvmjUUddwZNM/sWrTVi3bnf9ryDssFGmbCTm09TVJYE1Cp6pS5cP30H1BsaSbz3ExxFIYPNkfpcsnp6LgE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259082; c=relaxed/simple;
	bh=Mr0qHL9KpQwF09w9ztSBy+NLBFb2ElbAskGKav9TAPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0fXkJZvhBfj+h8hBimrmViMvPttEQBMMOApOS3Q8GhSFuVCTInb8uLR3Vym8u080NFcT9azggze5FFbnCunY23FNc/EJC/ls31u7CvLttmSYkcpxLPLWSvoGmrWXF+d6ZnqYRt/TPDR6k/8eO+1liIbTkvyf4kHtUJZm7gNBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5JChJ7B; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70478ba562aso7188326d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753259080; x=1753863880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=89/h4s3KwNEdLTnh5DbgusESMCzq1wEubarwC8onohY=;
        b=I5JChJ7Bl7UZ8McKO35TwkBTfpaJ572EJOPbHldSIYa8C8SP91gGBjSBHNQ+W1ffi5
         jf9toHA1S8HBPrIdjyVgGaNq2uHe3fwSbrSPpdXjqwED/1PUVtDxf8ADlJSMRGUWXRLk
         bx0TzkFBwihHjzvXebNXoiIpVPHACf02NkiplW2OM/Gb0vnXSkXlXKt47ulTNht7WCnk
         GqJg6QQH4e74kizCxIRazE9LmqXcJL5E+To3NJrGYAiM+glJHAzFSpJ3k47GUKhf3ZB7
         lwADCwWcIXpco0sUyB7/ytQrJRvLdet8E6iKQow71PUvUvWRPusXGSER1jqeaqfbHFWA
         kK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753259080; x=1753863880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89/h4s3KwNEdLTnh5DbgusESMCzq1wEubarwC8onohY=;
        b=bIDGzEyCHbw/eqSbr/q7lkSQXYgbikGbnlN3waVr63AzlQkv3k1ndNmhXyiAF32e26
         tYCM7+jJRnOmo2gIYd3KItkqtb+Qvw6Qoz7JS2d54PRWNuw0mcIC2QiasXLGq6VuehJk
         ZWagQvY3wUrjgGCqIBRxZBHBD5uZ6dtrnvABUk5XCwyMzBQtdAUv7wHM03cmptqXwrS8
         FK0n47dtG+ctmfwHitryTI3bnUDYsWlOLTYFJvFpSxmDIOo83ARfE1/1dHV6UpDLujkm
         xcjN9GLXIdi536Qrn8MV9XAsS2mh8ra2jXxW2MjU0SV3yv2wFnKUB2x94KqVZ9yEikVR
         rYUg==
X-Forwarded-Encrypted: i=1; AJvYcCVAE3I6IZ+euixRMDKij4N8N6K5zlF7RDPSmQIGgxxCRJP4BZMBjwl/LGz7Y/T3W7dtbtDCAlkJx6A+O4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPArfGkwxY82DdfyWePFuG7lLwKdUZj13slDxp38AY3y4hW3ZN
	KH8pRXeAysuxmfGYIu2QNZFH1ypvwWQe4jT/cqjTcqpPfY8YReuNaqMP
X-Gm-Gg: ASbGncvvNVj0uxNZ4kzhqOf0V/xAWln+FksodyzOwvIJrVidJ5+EQ8unWU/Y1rn+9dZ
	6g+ZjaCg7Nn2U/BM8ZpuXPzKJXlepX4JNpTTarj0Uzc2V+OgwZqrbHZ2SKaKJS+RRLeR0zUndhM
	Cb7fXHImlF+/1WyEj46h9wljm+gah9XNGrPUWy5/y4Me+1p6P565O8S1eUXdEFeqxYKpv7K5FqR
	QJJdoj/vAs6E/l/YeaCl+eze79PzvnY2/7ueFd9vqgwleSTwqxsJ8OrLHqMPibA3B4qToG2cJ2U
	VC0XXA7yTtaUorS0jI/mUYIngj3vlsT5ZKqOJ6hnunf+gNPMCdw2Erex5y0KPExbf5wiF74EGlh
	DFjzd9s89Jnj01GsJ3qKbhg3c7Mbd
X-Google-Smtp-Source: AGHT+IEjvslnuRIBwqLZ2HqQamNAjCpDe5qjUokTuj+aDnpNGUI4s1/MFxsZ9p9Ovo3Ar38t9vY07Q==
X-Received: by 2002:a05:6214:e6d:b0:6fa:9ca1:c520 with SMTP id 6a1803df08f44-70701135fd2mr25368546d6.16.1753259080033;
        Wed, 23 Jul 2025 01:24:40 -0700 (PDT)
Received: from localhost ([142.186.9.88])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70707ed62e8sm1744456d6.109.2025.07.23.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 01:24:39 -0700 (PDT)
Date: Wed, 23 Jul 2025 04:28:54 -0400
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Will Deacon <will@kernel.org>
Cc: dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org, 
	robin.murphy@arm.com, skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: replace snprintf with scnprintf in
 dmar_latency_snapshot()
Message-ID: <fvq3h4mbms64vzyqssy4xli2sudzpyimbacg74lkdgrzi77oqy@4yywt5fav7wi>
References: <20250722131117.2739-1-ImanDevel@gmail.com>
 <aH_RWQ_YqlydOkKH@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH_RWQ_YqlydOkKH@willie-the-truck>

On 25/07/22 06:58PM, Will Deacon wrote:
> On Tue, Jul 22, 2025 at 09:11:17AM -0400, Seyediman Seyedarab wrote:
> > snprintf returns the number of bytes that would have been written,
> > not the number actually written to the buffer. When accumulating
> > the byte count with the return value of snprintf, this can cause
> > the offset to exceed the actual buffer size if truncation occurs.
> > 
> > The byte count is passed to seq_puts() in latency_show_one() with-
> > out checking for truncation.
> > 
> > Replace snprintf with scnprintf, ensuring the buffer offset stays
> > within bound.
> > 
> > Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> > ---
> >  drivers/iommu/intel/perf.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
> > index adc4de6bb..cee4821f4 100644
> > --- a/drivers/iommu/intel/perf.c
> > +++ b/drivers/iommu/intel/perf.c
> > @@ -122,7 +122,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
> >  	memset(str, 0, size);
> >  
> >  	for (i = 0; i < COUNTS_NUM; i++)
> > -		bytes += snprintf(str + bytes, size - bytes,
> > +		bytes += scnprintf(str + bytes, size - bytes,
> >  				  "%s", latency_counter_names[i]);
> >  
> >  	spin_lock_irqsave(&latency_lock, flags);
> > @@ -130,7 +130,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
> >  		if (!dmar_latency_enabled(iommu, i))
> >  			continue;
> >  
> > -		bytes += snprintf(str + bytes, size - bytes,
> > +		bytes += scnprintf(str + bytes, size - bytes,
> >  				  "\n%s", latency_type_names[i]);
> >  
> >  		for (j = 0; j < COUNTS_NUM; j++) {
> > @@ -156,7 +156,7 @@ int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
> >  				break;
> >  			}
> >  
> > -			bytes += snprintf(str + bytes, size - bytes,
> > +			bytes += scnprintf(str + bytes, size - bytes,
> >  					  "%12lld", val);
> 
> Should the check of the return value in latency_show_one() also be
> adjusted so that 'ret <= 0' is an error? I couldn't convince myself
> that the string in 'debug_buf' is always null-terminated if ret == 0.
> 
> Will

IMO, that's not necessary. 'bytes' can't be less than zero that's
for sure (AFAIK, scnprintf() doesn't have any case where it returns
a negative number).
As for being zero, in every scnprintf() call, 'size - bytes' would
have to be == 0. (or size > INT_MAX, but still you get zero, not a
negative number as an error)

In latency_show_one(), the 'size' is DEBUG_BUFFER_SIZE, and
'bytes' in the first run is 0. So, 'size - bytes' == DEBUG_BUFFER_SIZE.
Since 'latency_counter_names' and 'latency_type_names' are arrays of
string literals, 'bytes' is guaranteed to be increased in the first
iteration, even if the rest become zero (which won't happen, since
they are smaller than DEBUG_BUFFER_SIZE).

So, the case of zero is impossible, unless you want a bulletproof
check for future implementations where the function might be rewritten.

Seyediman

