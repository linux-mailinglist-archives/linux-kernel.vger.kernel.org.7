Return-Path: <linux-kernel+bounces-745277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F3FB117CB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A663A9130
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C61241CB6;
	Fri, 25 Jul 2025 05:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXz67ofj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8223E324
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753420275; cv=none; b=FjLtLfhqtmmaERkk44Pcn7k/OQX5QB7d5EeavsOtzjfbPt5cmIiBh5LSQbRCuqGw5fc3jA6AvACJJrGvxYpS+J9GxhNc3lMZrg+b4dj/OUv4SS3jPgtMUrojXi+7LNU6T0+w+dk232RG3MtKzkxH5FyX9u7hSnLckni00uXtMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753420275; c=relaxed/simple;
	bh=l6dE3XVGUiPeU5nmiSZ0jJ0PyvZFUH2gVZbYvaYkIbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COeSGdOaga9UufjeYhm8RADwxHu013pFy7Kuz44HqYhuzigbjCbtdcmuZYwRWmZI2AmfOYPd0teSgPuNn25zwigLdWGMERnSfqVFSZIc2O3Hqr8nS1riy6aMFUDMxFCx18RFB5cVgkGbuT3ov2zW/87OO6OEo2/NZ+BAfK0XSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AXz67ofj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-237f18108d2so115655ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753420273; x=1754025073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJRrie+evisFjv3ojJcmxiW8N4BF+TiSqioS6un+K1k=;
        b=AXz67ofji4koAOoffe/yR3VwC7lQ4AsY2gMIsQ0iJdIyniGhjgNJiC9VCWhScLsWtP
         7ljKodmaGva5+0VupP9FgBfNnAskdnt1L+Hbfz425MUFj+j5GU2SMZ0GwZ0XJm/blWJO
         oUknWLosuIIKbJ4AZdFBo6T0IW/p5EAHvCi4MySRaqabItzhRD8glBKW5Jw+KAz5rAc2
         MdljBYmEaWYoReDfm2mB8hIv5AWJF6qJs0TqjfXiSQnrwMq13VbAnPy4AyoVazHVmi58
         qLSAKtCfHhL7Y/yHqFOt415/qKh7tITlVUH2ooHv6Tr5VxlZatFiZX8WkVmg3c8v8V3H
         RbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753420273; x=1754025073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJRrie+evisFjv3ojJcmxiW8N4BF+TiSqioS6un+K1k=;
        b=YvzQAISWO9XtvGoP3oOXawEmooUUxUs+cC/srxr7YRPJcNmU6WHzF7W5g1cBChRcda
         Z3yej/ZKkheXjMLPR+EmuZX1xybUTF9x3XdCIJGZ0LNi0+7GMv1VKwTKqkVwJI3hIGzt
         jcAPjIDcNfZy+ALQBRD9L5uuk1fQDenK9al1s6A5zSNg2anMvtKn+uUAyvKc75nMGa+h
         HbCiBIiOjAh4o7exqKoqfYA5nHzLiIpiw9TDNgM3P8HVztQa+kMOXDP0mRuP1/dUJT/C
         LQTvS3aXqoOYuuw1dku6wt1T6E2H71KwhUD+zwak3mQkjVY4PspRkIEOvJLUIbCP5utS
         QZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXpahFAYiVyX39fyCiu+dyiXE/ig/GgE6Sr1SiAdz/9tLz5oOqyEJ4PWZBvtTciS8/F1xQKDNC2ZgFh8ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8GNdluYM1cNf+kqpUz+kStSeubDZ+KNjDjn+PNllcYrhjCig
	+P9YsSdaeLM+6bgwtUqTDNBDVpaLP6s1E9tMcchb8xx8MQh4TVHlySEMoWF6Hqz9b/KyNQ3S8LD
	Xk/g2Ow==
X-Gm-Gg: ASbGncvvoI3mli+ofmb50fJhQN/NZHQHAGwMJs0+5Tn9/9/8wmImevNfbXH17hr8xxK
	mkmAdMoXRhmk9m/fVK8XsfENarLmpLFmQ2pKwn1uKeANFhZCOjdyZt+9Y+uXFwKRxgDqMYO3K4q
	lHZVwfH9ag2Mrj1qNR0mVFbs++8467U7Nmn1kCCwwkHsr1uONz5sf6Gh5T0h6bQtEkJS0PV+rJF
	U3BDvq4Sjsal18wsiveSOR0CNs9GJXMYu7YwkIgv0IXivuAR9P+hI9k484vrjQnvjMMtVs8iiXL
	GIZxlBQJOeP/0sQxNl5npn7FpcWSn+1t2Pv7Lk65Jvm0de5n2Fv16o0DuH4dL//kIKx2hF5GEIb
	FAIuZY0vzFfNd/md3x39bQn/TpO5Hv45MygAPB6Yc/6JuybmoN8hiLZJAxE/aze4wqJ0=
X-Google-Smtp-Source: AGHT+IGG4QZQwavYhcLFszK2mSaWOfTBLnCc2XFKEIjBG7genN2zVTCSUApFR5trIV9DREmiDkhIQw==
X-Received: by 2002:a17:903:4b04:b0:23c:8f12:7c4b with SMTP id d9443c01a7336-23fada582fcmr1953485ad.10.1753420272915;
        Thu, 24 Jul 2025 22:11:12 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7630c947b6fsm575750b3a.33.2025.07.24.22.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:11:12 -0700 (PDT)
Date: Fri, 25 Jul 2025 05:11:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, joro@8bytes.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIMR6xxR3Jdpy8kX@google.com>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIKqaGMMpsIuAVab@Asurada-Nvidia>

On Thu, Jul 24, 2025 at 02:49:28PM -0700, Nicolin Chen wrote:
> On Thu, Jul 24, 2025 at 08:55:50PM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jul 23, 2025 at 06:58:20PM +0000, Pranjal Shrivastava wrote:
> > > On Wed, Jul 23, 2025 at 11:05:26AM -0700, Nicolin Chen wrote:
> > > > On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> > > > > On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > > > > > @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
> > > > > >  	phys_addr_t page0_base;
> > > > > >  	int ret;
> > > > > >  
> > > > > > +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
> > 
> > Sorry, if this wasn't clear in the previous comment. I meant this
> > comment must be updated, the "unsupported type" wasn't rejected in
> > vintf_size, rather the type got corrupted which brought us here.
> 
> Any unsupported type would be indeed rejected by the init op
> callback. There is nothing wrong with that statement.

The comment mentioned tegra241_cmdqv_get_vintf_size() which isn't the
init op. The statement: 

"unsupported type would be indeed rejected by the init op" 

isn't the same as:

"Unsupported type was rejected in tegra241_cmdqv_get_vintf_size()"

> 
> It indicates that we shouldn't see an unsupported type here,
> unless some serious kernel bug like data corruption happens,
> which is implied by the WARN_ON itself.
> 
> > Had the
> > vintf_size rejected it, we wouldn't be calling the init op.
> 
> A data corruption could happen any time, not related to the
> init op. A concurrent buggy thread can overwrite the vIOMMU
> object when a write access to its adjacent memory overflows.
> 

I'm agreeing with all of it, it's just that the comment says something 
was rejected in by the size op, which raises confusion as to why we're
in the init op. The init op rejecting something due to data corruption
is a different thing..

I totally get the point about data corruption, i.e.:

size op -> returned something valid
<data corruption>
init op -> rejecting corrupted type

Wheras I was just trying to understand a case where as per the comment:
"Unsupported type was rejected in tegra241_cmdqv_get_vintf_size()", 
i.e. ->size op returned 0, yet we ended up calling the init op

I guess I should've been more clear. Sorry for all the confusion.

> Nicolin

Praan

