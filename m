Return-Path: <linux-kernel+bounces-840206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91944BB3D42
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8F73B9F68
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9230AD08;
	Thu,  2 Oct 2025 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Scivlv5T"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ABF2D062A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759406238; cv=none; b=eHdLrX28/4kOkb86NCUEwEbotRdAM6iYVaO/nIHRxQ+ex+ZDt44svt3cNYSy3DC+IAIxRsnVfXfTwm/WH0xyBklRmQXSvyz/niY8prmjvotzXOOLSuInJX/JS9UXXU6SZFlS/y36yeyqVwtXCpHEHrHbCSKPc7K4rCvfYcx7Vjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759406238; c=relaxed/simple;
	bh=hzlW48U3p27HalC0zjHa19nIsygs8guIlr4gM2QtnRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eq4beZ9qXMWO95vHnHIj/1ojqn+MN+tvIPj3c4dxApdFlhe5hFu5RS+7fuKyCwGJ1GN31xL2G+Um6hAzWB6zRGVP5DZSM6skBmqeD+bNNGTxG/tebxPniSQGfw3k3HPL/yr0ApntKG7Ki6499wmjye4OP56MuFrPY9v2YaxVSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Scivlv5T; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-43fac2df7d4so442088b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759406235; x=1760011035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lypYEd3l4ejDslQUD2xntmHuywWs1a99Jd+mtc30NnI=;
        b=Scivlv5TlCa3zRV/Z5impE6yOLW0ijzavzwg7XUSqZ4OEqQ8XTGSRg98BPsgaN9YFj
         o7RLaqABTbro4kAZRgl5STa1zSS06izq7ZjcoAzsefGY4le50LqGcWcob9c2QkcJokWx
         yNtTH8k/DaHXGvfCpS+DaOy/QHO+H6A6LpbvvPifDrwGmxyYs6opSTOhWxuwPbp/E/oj
         nwuK5VXUqOgtt2lDmnJWl8+H/W7GkVs3ZfrG1EyHJ8qX/kmfhnjWdAx/SytOkwdHn6mE
         jLafejZmzc0zdUu9Jo0K1rL7wAsRufasQ3pVTYUViyaWHdnXMXHvs3jFmOv1J9KANDPn
         PSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759406235; x=1760011035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lypYEd3l4ejDslQUD2xntmHuywWs1a99Jd+mtc30NnI=;
        b=FOEDIhDUIhVPZ68NqtllSoltkW2QxVWfLes9A5AhUsw9WaNQ0cuH4u/7RzY+fq9ina
         tCo0JvH3G3qFtVT/vBdYhTIYg7Gu0YMbqJrMtr91CQOle44BgM5A47/b+aUIO8yHjSl0
         irAbjpHo4+tM7RU8GD5w93CPPSRZv2DvwrrxXZVe+6H4Ucr5OHA924XksCXLqCKh8MBA
         1nRyunzn3AGbcl+jVmSDXhS6TGLhtf4dzNnX5gwHNT43W6RsSXiXujuZzW2U8irsZyPU
         1jpTudkM0dbLg/cLPl7QzmT+Kf1USCZfEQF4Q5vMO9Pgf7nPKgAjjkI86WMGBVWSFvVP
         hOCg==
X-Forwarded-Encrypted: i=1; AJvYcCWCXfjIMbfHJlt01Lr5QdG0Sho/wfy/V4db0sXB0N601dQ8FOyAn/Xh3c2tbhlsi5sJywsSdZz5aVswqUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH+vheZvXQZ/UPEsN98H8U5rLOSdbOMoyWZxHl3cyfSWNqB88l
	btBkGBCfuLYCVsKj3njPnBbKAmtcHf9JEIVx3iNRHwG2rFvYv74pNBjRlOlF9gaFiMg=
X-Gm-Gg: ASbGncsTqJThlbu9WQ9R/iRdfhVSZ5a5kSI3icmYaiVsbi/vbqS2bTBGdVIQJyZBm80
	I0mYXTKzn6TFJziCTJkCVDWb5Qfr3Oi73CERmX2b+U5ogvKDFdbsAhlGdcwT1i1l8MIHKun8LEd
	P4Rlvkab2Ya9xuwOuA5mpLchGyHDwiGCCThpLUtHzoBRcmR61Vq3eEXAwlqKfH34A0Adp8QNs7b
	HFyya3AqWYbA0YR947ObALKQVayc06k5gN+j8AhDripXVlnSmAlyYpa5BQZEh3MSktzDcont7Ok
	4kEsSEGxBYGzgOzPYZejUF3wAGEUNPcEo6X5Mm0PfyNkmwcdFC0nU4nTcj6TdyTfMbfAJKsotwb
	8pFzOPMFddVsMxf1UVUDN
X-Google-Smtp-Source: AGHT+IE1srVbckOdMIlenVgAWZmXaZ17xCibMpNXp1sus8P4KPWibOXVJIJ+3ZlJ9dMn/d1vo7M2dA==
X-Received: by 2002:a05:6808:4f29:b0:43b:91b7:cc2d with SMTP id 5614622812f47-43fa40d79aamr2956448b6e.18.1759406235399;
        Thu, 02 Oct 2025 04:57:15 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-64e1b7a8842sm423034eaf.12.2025.10.02.04.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:57:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4Hvs-0000000Dh2T-2nRE;
	Thu, 02 Oct 2025 08:57:12 -0300
Date: Thu, 2 Oct 2025 08:57:12 -0300
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
Message-ID: <20251002115712.GA3195829@ziepe.ca>
References: <20250928190624.3735830-1-skhawaja@google.com>
 <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca>
 <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca>
 <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
 <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca>
 <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>

On Wed, Oct 01, 2025 at 03:28:56PM -0400, Pasha Tatashin wrote:
> > > 3. On FINISH, the IOMMU core updates the context entries of preserved
> > > devices to point to the new domain.
> >
> > No, finish should never do anything on the restore path, IMHO. User
> > should directly attach the newly created HWPT when it is ready.
> 
> But, finish is our indicator that a particular session (VM) is out of
> blackout, and now we are free to do slow things, such as
> re-allocating/recreating page tables. Why start it before a VM is out
> of blackout?

Things should be paired.. The suspend side is

 start luo - "brown out" - kernel does basically nothing as the luo is empty
 add all sorts of things to sessions
 finish - kernel does last minute things

While the resume is the symmetric opposite:

 kexec boot - kernel restores the critical stuff it needs to boot to
               userspace
 userspace does all sorts of stuff and gets things out of the sessions
 finish - luo should be empty now as everything was taken out by
          userspace

I think when things come out of luo they should be fully operational
immediately.

Finish on resume shouldn't indicate anything specific beyond the luo
should be empty and everything should have been restored. It isn't
like finish on pre-kexec.

Userspace decides how it sequences things and what steps it takes
before ending blackout and resuming the VM.

Jason

