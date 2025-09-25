Return-Path: <linux-kernel+bounces-832946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99384BA0D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0531BC7F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEFC30E823;
	Thu, 25 Sep 2025 17:23:18 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C254F30CD95
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820998; cv=none; b=LKRK2NEBjeP3DCrE0lvjeusrTRSLuWkFPbkixLocbAT43CWQ86U3OlSAxaLfKqTybuJG7SnjZHGLCEO1kf6IiZ56I368FSYNNDSkyIXNby2zhsCzxWNVvvJ3W81jFUE/5lv+q9MZw7MuGXE07XVWjfSbKf7652ZI1Of/uyzApk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820998; c=relaxed/simple;
	bh=hV7kWSbUXgR4pgG8d1HMAVkG/Zftdd5SK/3zrvWp1cM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mviYbpIeERSwVTafKSwZj3u/B1A3qpkmiSLDhWyCmdH6Mbtk+bsQKP36/UBL2mHMicgLy1HEGBNJROHoSjG7u6YuiiX/jBZRfUxq4Cf/12425bP59cs78qcrWcER+oFUMoXgHvMnbN3H52jL8ydfc01pgBKuNE1NLzfPlMw4rpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cXgVL4L9xz67j73;
	Fri, 26 Sep 2025 01:21:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 21E7F1402F0;
	Fri, 26 Sep 2025 01:23:11 +0800 (CST)
Received: from localhost (10.47.28.112) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Sep
 2025 18:23:09 +0100
Date: Thu, 25 Sep 2025 18:23:08 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Gregory Price <gourry@gourry.net>
CC: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>, Wei Xu
	<weixugc@google.com>, David Rientjes <rientjes@google.com>, Matthew Wilcox
	<willy@infradead.org>, Bharata B Rao <bharata@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <hannes@cmpxchg.org>, <mgorman@techsingularity.net>,
	<mingo@redhat.com>, <peterz@infradead.org>, <raghavendra.kt@amd.com>,
	<riel@surriel.com>, <sj@kernel.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <nifan.cxl@gmail.com>,
	<xuezhengchu@huawei.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<byungchul@sk.com>, <kinseyho@google.com>, <joshua.hahnjy@gmail.com>,
	<yuanchu@google.com>, <balbirs@nvidia.com>, <alok.rathore@samsung.com>,
	<yiannis@zptcorp.com>, "Adam Manzanares" <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <20250925182308.00001be4@huawei.com>
In-Reply-To: <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
References: <20250910144653.212066-1-bharata@amd.com>
	<aMGbpDJhOx7wHqpo@casper.infradead.org>
	<aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
	<7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
	<CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
	<20250917174941.000061d3@huawei.com>
	<5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
	<20250925160058.00002645@huawei.com>
	<aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
	<20250925162426.00007474@huawei.com>
	<aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 12:06:28 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Sep 25, 2025 at 04:24:26PM +0100, Jonathan Cameron wrote:
> > The CoW thing only works because it's a permissions fault at point of
> > asking for permission to write (so way before it goes into the cache).
> > Then you can check margins to make sure you can still sink all outstanding
> > writes if they become uncompressible and only let the write through if safe
> > - if not promote some stuff before letting it proceed.
> > Or you just promote on write and rely on the demotion path performing those
> > careful checks later.
> >  
> 
> Agreed.  The question is now whether you can actually enforce page table
> bits not changing.  I think you'd need your own fault handling
> infrastructure / driver for these pages.
> 
> This does smell a lot like a kernel-internal dax allocation interface.
> There was a bunch of talk about virtualizing zswap backends, so that
> might be a nice place to look to insert this kind of hook.
> 
> Then the device driver (which it will definitely need) would have to
> field page faults accordingly.
> 
> It feels much more natural to put this as a zswap/zram backend.
> 
Agreed.  I currently see two paths that are generic (ish).

1. zswap route - faulting as you describe on writes.
2. Fail safe route - Map compressible memory it into a VM (or application)
   you don't mind killing if we loose that promotion race due to
   pathological application.  The attacker only disturbs memory allocated
   to that application / VM so the blast radius is contained.

Jonathan

> ~Gregory


