Return-Path: <linux-kernel+bounces-863555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 398B9BF8267
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 081EE4E3EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7238C34C14C;
	Tue, 21 Oct 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="V9sl1dPE"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1034C81F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072766; cv=none; b=c38w7a835y5W30WV6FM6v51iStUPj8UbY/m4qmjy0dRWh4bnHbiGygyEfP+4cWmy00xMZdfRWGAyIpp2YlnRwG0KAJqkYfgrdzlwePHB5Nz8TVP6kyPcCT3ikiLOf3JTO9jp+618qgBgtdSWjpGrNSclXpwhFDiRnqX74qZebBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072766; c=relaxed/simple;
	bh=pxQiDnHtizoBQiDjU1ip0uPJ1qtkmU7KJE8IzqDdS3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBBwJMKSoNASBv6DziIKdnZ0Mjd4kTjYphed09exnGX5obWAoSpraHdhSWvkJooiAEnOJ7dDgnkyy9U4cxNBCiNLa5TZxJFZFATKCTFpPzm5dij0Ml4e4GxH8R+ilmYAJ5MTa58DdXqf3icYb99isF4AAtEOEua97izFzjXFbrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=V9sl1dPE; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so2056696d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761072763; x=1761677563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLvUWCk0Mz4Y0PzOoaEb6Yq0ejoswRanjDyfbct8ulk=;
        b=V9sl1dPEqCdGYwdFCA63bs03gQBEpsxMpluJbakUuyGM1lZ5m9QJffDqbPpNxZlgWV
         ZvfjLgP8t7Muq7Dirbcgb5gzP2baJpIQuH7M/j7GSq75wmFg7o5XJQsB6EUh+HTtgx+Q
         dh8Y74IAU3r3vyKIyKFcFNImNAxZxxtzbtVdO1nXl6ktCYFD0SLLDW/eGd9tZLp2Oju6
         S78+eWkPjbNapUEg/CrmjCQpxa1pM8fJXn5OPbgfPdbre5RgWAce2+6cKxAWRzaGNDnC
         W2GHlIl7EDE5DXifz+zOZc1TmwfkJtOYUkcpCoE2xTRN44SCGG4LeGBfGRwM00U6n20U
         ZY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761072763; x=1761677563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLvUWCk0Mz4Y0PzOoaEb6Yq0ejoswRanjDyfbct8ulk=;
        b=cQHfGN/mtIjXS2mBSFkTYe/VrhStdTCj8rkDM77stvxUzhNPiMpdJciTGv1/vO7lq8
         GUHO7n1Q5LwlooBwwRyG/mg5kL43sDogAfM2bYYeYi8vXVAtfORImSz1waPE9vJ1/dVG
         ja5YNmRbtHvN0AmjCEkkJ8xb4tQuV2pqpXj2D1QH+elUYmQiZaHWpI/jEfrOLxlJTA9n
         XsUE+Z6PZfM0nwtA/jIYxPcvl8vMAfsf/rwvJP0CSjPVBmRGYe0gnQYZpVjkQ7Q1HfHA
         jzu/GrNuBVBbQRWNkPDxI9P0e6ULxrqR+nzJQ6W5ZxZJtDqPoMNmQvxlolaO5lYPVBfS
         geJg==
X-Forwarded-Encrypted: i=1; AJvYcCWkGsvFN749k+JQznnyUrMmluJNCmkTM9RMZusXqigSU6KJUV6ckwuV5yExEHv3OX6UjdkhdNPHiOJiQPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWiKZU07z8qHFdQQCy7AvfE9A4LiWjGiFsA0oyLes7vDfYSpo
	ljXHgIwL+NhO8aHhPhNYXEAJ9GFvY9HIBROh7TKRGYv7cey1WMx1w22qHwvPrwsMAzU=
X-Gm-Gg: ASbGncv8n2rGAbr2MXS8kCjn12JxbXoayNrZBOGSL2QKSWQ77r1ofT0TntQP/vwJRZ2
	gKZNaf8/zf9UnxcvtMb1/DrqpY9iLALmeJdV9pyAAI3jxNfpcltEc3hXO53ZyCqRiZdvpBxVkJZ
	fj5VeQKsFauJGyQn1sgx+vk0qO6BJvB64f4LusXGUJK8E/YVv3W+FDHbzN+C+xxfffHzXW9OMb3
	xxvGD/BDFoWcVmuDeblZ+njGe2IWzO1VzA2tZaTDP44zZJI+NJMv5i4hHTHk2QtNbNB5Y524Xn0
	ESpnS6LiApXOFVGNMpaWnmqaTozoVPZNZyow8EuqDxPskeGRfOB4OXlCSts7bJf7Gb5Lf41IiTs
	RggynZvFkFPLi1Fy86XIV2oe+u3WX89yt2nvWjC5rd6HqupdhNOD2gLN5Bv0VggBagbXnBplp6a
	bupWFn4rdnlwHD+LoSJcXe61fh/7KRcAbIsaI2wsB35pEg63djuN3miOFQdRc=
X-Google-Smtp-Source: AGHT+IECNSsoqasWHr7E4/BHoh0FWWJN2h6QnlVVo6n6s/g3DObB3176YMdFgdU0/Gh837/Hks5Q1w==
X-Received: by 2002:a05:6214:e8e:b0:87a:97f:de8c with SMTP id 6a1803df08f44-87df6760e0dmr10210096d6.28.1761072762996;
        Tue, 21 Oct 2025 11:52:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87cf521bf8esm73053056d6.22.2025.10.21.11.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:52:42 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:52:40 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>,
	Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, dave.hansen@intel.com, hannes@cmpxchg.org,
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org,
	raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
	nifan.cxl@gmail.com, xuezhengchu@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
	balbirs@nvidia.com, alok.rathore@samsung.com, yiannis@zptcorp.com,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aPfWePBq8d3v979f@gourry-fedora-PF4VCD3F>
References: <20250925162426.00007474@huawei.com>
 <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
 <20250925182308.00001be4@huawei.com>
 <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
 <aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
 <CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
 <aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
 <20251017153613.00004940@huawei.com>
 <aPJZtQS4wJ1fkJq-@gourry-fedora-PF4VCD3F>
 <20251020150526.000078b6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020150526.000078b6@huawei.com>

On Mon, Oct 20, 2025 at 03:05:26PM +0100, Jonathan Cameron wrote:
> > More generally could have a "Not-for-general-consumption bit" instead
> > of specifically a compressed bit.  Maybe both a "No-Consume" and a
> > "Special Node" bit would be useful separately.
> > 
> > Of course then platforms need to be made to understand all these:
> > 
> > "No-Consume" -> force EFI_MEMORY_SP or leave it reserved
> > "Special Node" -> allocate its own PXM / Provide discrete CFMWS
> > 
> > Naming obviously non-instructive here, may as well call them Nancy and
> > Bob bits.
> 
> For compression specifically I think there is value in making it
> explicitly compression because the host hardware might handle that
> differently. The other bits might be worth having as well
> though. SPM was all about 'you could' use it as normal memory but
> someone put it there for something else. This more a case of
> SPOM. Specific Purpose Only Memory - eats babies if you don't know
> the extra rules for each instance of that.
> 

This is a fair point.  Something like a SPOM bit that says some other
bit-field is valid and you get to add new extensions about how the
memory should be used?  :shrug: probably sufficiently extensible but
maybe never used for anything more than compression.

> Maybe the BIOS would have a look at devices and decide to enable a
> compressed memory CFMWS if it finds devices that need it and not do
> so otherwise, though not doing so breaks hotplug of compressed memory devices.
> 
> So my guess is either we need to fix Linux to allow splitting a fixed
> memory window up into multiple NUMA nodes, or platforms have to spin
> extra fixed memory windows (host side PA ranges with a NUMA node for each).
> 

I don't think splitting a CFMW into multiple nodes is feasible, but I
also haven't looked at that region of ACPI code since i finished the
docs.  I can look into that.

I would prefer the former, since this is already what's done for
hostbridge interleave vs non-interleave setups, where the host may
expose multiple CFMW for the same devices depending on how the OS.

> Which option depends a bit on whether we expect host hardware to either
> handle compressed differently from normal ram, or at least separate it
> for QoS reasons.
> 

There's only a handful of folks discussing this at the moment, but so
far we've all be consistent in our gut telling us it should be handled
differently for reliability reasons.  But also, more opinions always
welcome :]

~Gregory

