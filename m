Return-Path: <linux-kernel+bounces-858250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0AABE96C5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC86E568C85
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCA933711A;
	Fri, 17 Oct 2025 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="G5YhWziU"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BADD3370F8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713147; cv=none; b=W8soO4iEkcYAdyh9pP5T7Q1w/gUPnZBKsXtI+koCIAEmpUatjNGT9gN5+aZYkq4V6Pv9gZx1HhvF1TZ2Gj4PmostwouUG1qw20t8sDXD08znBqXzDuX2n7McDBYjuYxknUNNv4nnxTyJR5URztclED09AbcfHkh2530QaCoXT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713147; c=relaxed/simple;
	bh=iCksKHNBBIozNtAECo3P6GzknnoPgq/5bUs3WaoCqpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okfDbKFCh5E7InAaENZ0UFYgnzx2Qocjfhd25RvXpSjuzsCoA8FZ4LjiePNTCDLlw+rw0BLyf59fa305oB9uFRV2iihBMJ3SZ+24o92zYKtLYFSBfIgPQOAWnt8WOJPvkrbnUQxXgzUsAHs/5BVbhutJ6HBjY9BG9rGtrYqLyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=G5YhWziU; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7f7835f4478so22690766d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1760713144; x=1761317944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TTA2mSeVwafy9i2CstFmFNoFIIutQdKDJAn1493tDAM=;
        b=G5YhWziUrL1d/YQ8gy8YZg/I1mH1BTRkVnUrZ4fLv936HPIqNNa1YaFPNfq9OYI7wJ
         eli6NbJy69a3fOGSgHJcba5sQYVpgBsuefJRNrQFwVt1jrSJ93qzBCQ86l6YERNOiZhY
         brKzGmvBCbOGRy2Td5nuHsA7SfC5sgxXt0HeMg5QdkOfWQCKTW/cLU1t4M3kko1tWvXf
         nlFIgUpwTv4aFQhbBMENgiFy9149tNnu3nfyFGsWwHb/utj6WD5weuiQ3p4LH//ksDmv
         xtrIiqWdyRFAXnhW8qL1XtoVjQgfS5NL+Z2rBZHMzW28W/ES0FFrOXW3yRG/6Q4xookX
         Fwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760713144; x=1761317944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTA2mSeVwafy9i2CstFmFNoFIIutQdKDJAn1493tDAM=;
        b=JL126cLgrw7aM2zTVDbMhl6dlMQiqffRO7wSBxFPPVuxLu8eF++LNB1IaJddXuDmJe
         ih6MRLMucETdVS99zaaSHn8BEQZ872g1gp1zzVxgXFGUmBF6P1EOMqYfa88VBuLrGvV+
         HtSx55n2feLXmVaGwgO7eqAHUvCv49FG/Fz+20hUnrxmnXuRN9vUmfuYk9u3X7CFu7hD
         KQnIom766jAo5uwsFtNuRO99/zrOlQgedjwwVgTmSym9ABJXhtfsbpglM1MtoqbpCJQW
         p/MsVymDXevJFHPRfDbBESmroQyNHMOg5l4zax70gUJp9rOLfJ6sl+ofhIwtO/qmcyGG
         PBqw==
X-Forwarded-Encrypted: i=1; AJvYcCUNAQWE10EcW/CAsj0aIRdNhuyJPIwhAir4+0ZOa8F/1Jsn14atUCIPpTXiNnMcmjoHAx82Cu0JqnQZhjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmNcxNQNMYY63rvPD5s+7rekBG0dWZb17CD5Oj2zz0Xsi9Gvn/
	teSj80JlJ/uI60Qioq8w9P/9yqLgy0PaOGq1E/E9f9qecAJvgsqP47BZcZiuTsqkdYU=
X-Gm-Gg: ASbGncuxQNp5CUBLrcuZWj00lPfdPCwe4nWwGabSqRXdJfMlo5nntap6HZbOrLEGD7S
	wFfKYW9JDO4UWTGi7s9/zMDOeQdMYWCrsh8AuF3oNi/qSFH1Gg0kusXMwshxZRlonMFA9Kur+tf
	ESfMaxATv1C8rU2yzBd3IcgcdXdc+NnEci9KB2sxIjGPDpSDY80Kf5XA2UEbX2D55bShtUjkI9/
	dY+TOCleVkvm3fbsdB3ReswYRVHCSYUET7rnqv+/u61JT6sGj86gaaMsZN+ZLSNK8OGqZfh+O/F
	5DbGGnq/JTanDk/HH6MgXp9bsk5uJmDtO+RXFJ7ez/+HsRRF3DUYS947pw+lBNkYfz/4dB+e4hZ
	Qc51P0vS836x7J1/zVw2nawG3AC8Nb5GdYfEU7FWnRpNklNzlJ3LE7Yh5feRrMveeMwOHIKVFaR
	6hAM6jBPOAW4/H/XPaYdxll8jI+a28dvc/we0kJ219WqijKQXRji9SJ5zaWi5zIKH7wUoXJg==
X-Google-Smtp-Source: AGHT+IHd9zHjRIZf+Fc4DlDtuF/M9TYVelSUZFnURBj2UkXNmjzNYhJQmkX3naUgJtLXTWc6eW6+Zw==
X-Received: by 2002:ad4:5e88:0:b0:786:2d5e:fdf1 with SMTP id 6a1803df08f44-87c2054aef1mr69129376d6.2.1760713144231;
        Fri, 17 Oct 2025 07:59:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028af525sm59946d6.51.2025.10.17.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:59:03 -0700 (PDT)
Date: Fri, 17 Oct 2025 10:59:01 -0400
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
Message-ID: <aPJZtQS4wJ1fkJq-@gourry-fedora-PF4VCD3F>
References: <20250925160058.00002645@huawei.com>
 <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
 <20250925162426.00007474@huawei.com>
 <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
 <20250925182308.00001be4@huawei.com>
 <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
 <aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
 <CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
 <aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
 <20251017153613.00004940@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017153613.00004940@huawei.com>

On Fri, Oct 17, 2025 at 03:36:13PM +0100, Jonathan Cameron wrote:
> On Fri, 17 Oct 2025 10:15:57 -0400
> Gregory Price <gourry@gourry.net> wrote:
> > 
> > Essentially the platform needs to allow a single device to expose
> > multiple numa nodes based on different expected performance.  From
> > those ranges.  Then software needs to program the HDM decoders
> > appropriately.
> 
> It's a bit 'fuzzy' to justify but maybe (for CXL) a CFWMS flag (so CEDT
> as you mention) to say this host memory region may be backed by
> compressed memory?
>
> Might be able to justify it from spec point of view by arguing that
> compression is a QoS related characteristic. Always possible host
> hardware will want to handle it differently before it even hits the
> bus even if it's just a case throttling writing differently.
>

That's a Consortium discussion to have (and I am not of the
consortium :P), but yeah you could do it that way.

More generally could have a "Not-for-general-consumption bit" instead
of specifically a compressed bit.  Maybe both a "No-Consume" and a
"Special Node" bit would be useful separately.

Of course then platforms need to be made to understand all these:

"No-Consume" -> force EFI_MEMORY_SP or leave it reserved
"Special Node" -> allocate its own PXM / Provide discrete CFMWS

Naming obviously non-instructive here, may as well call them Nancy and
Bob bits.

> That then ends up in it's own NUMA node.  Whether we take on the
> splitting CFMWS entries into multiple NUMA nodes depending on what
> backing devices end up in them is something we kicked into the long
> grass originally, but that can definitely be revisited.  That
> doesn't matter for initial support of compressed memory though if
> we can do it via a seperate CXL Fixed Memory Window Structure (CFMWS)
> in CEDT.
>

This is the way I would initially approach it tbh - but i'm also not a
hardware/firmware person, so i don't know exactly what bits a device
would set to tell BIOS/EFI "Hey, give this chunk its own CFMWS", or if
that lies solely with BIOS/EFI.

~Gregory

