Return-Path: <linux-kernel+bounces-832773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC79BA059E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A945E8387
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E62E2296;
	Thu, 25 Sep 2025 15:24:37 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557921B4224
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813877; cv=none; b=IzmofeWSZsKZ8wyA2XbE6SJwJmYBQX0PjrJTsJm2JxQTjia/ItsD2W7A82RK4x1zJWUUa35nAmfII2P7u+Aot3JScCyBdDD96YOiK+djkwLvxjIEetIe4oNPZYJmN9nspVrcVAsJQ9rtm6H1Cqh50wzh1qHy0A7iW76vayFYx7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813877; c=relaxed/simple;
	bh=hIt0vwu3Nu8YyO8YCFblJQVsN8dOVGMFr5fV1ki1sNo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYTNg+FF4soe5vp9oauR5ePwP+La9XFZymHAk8YiV0pvrZ/x8VCk2RAkldJmjn3LbvjIitTQEQPWRyKlgglGqUZ0XadSuKSdFvMxu8H0OXQf8m5JxDzZEr82URG1STEx0JTY3nMr1AiFiFB8S9R07lZd+RQU5Ym9LWvRTX3jZZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cXcnx1bPbz6L5pY;
	Thu, 25 Sep 2025 23:19:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D1D71400CB;
	Thu, 25 Sep 2025 23:24:31 +0800 (CST)
Received: from localhost (10.47.28.112) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Sep
 2025 16:24:29 +0100
Date: Thu, 25 Sep 2025 16:24:26 +0100
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
Message-ID: <20250925162426.00007474@huawei.com>
In-Reply-To: <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
References: <20250910144653.212066-1-bharata@amd.com>
	<aMGbpDJhOx7wHqpo@casper.infradead.org>
	<aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
	<7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
	<CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
	<20250917174941.000061d3@huawei.com>
	<5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
	<20250925160058.00002645@huawei.com>
	<aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 25 Sep 2025 11:08:59 -0400
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Sep 25, 2025 at 04:00:58PM +0100, Jonathan Cameron wrote:
> > Now, if we can put this into a special pool where it is acceptable to drop the writes
> > and return poison (so the application crashes) then that may be fine.
> > 
> > Or block writes.   Running compressed memory as read only CoW is one way to
> > avoid this problem.
> >  
> 
> This is an interesting thought.  If you drop a write and return poison,
> can you instead handle the poison message as a fault and promote on
> fault?  Then you might just be able to turn this whole thing into a
> zswap backend that promotes on write.

Poison only comes on subsequent read so you don't see anything
at write (which are inherently asynchronous due to cache write back).
There are only few ways to do writes that are allowed to fail (the 64 byte
atomic deferrable write stuff) and I think on all architectures where
they can even be pointed at main memory, they only defer if on uncacheable
memory.

Seeing poison on subsequent read is far too late to promote the page,
you've lost the data.  The poison only works as ultimate safety gate. Also
once you've tripped it the device probably needs to drop all write
and return poison on all reads, not just the problem one (otherwise
things might fail much later).

The CoW thing only works because it's a permissions fault at point of
asking for permission to write (so way before it goes into the cache).
Then you can check margins to make sure you can still sink all outstanding
writes if they become uncompressible and only let the write through if safe
- if not promote some stuff before letting it proceed.
Or you just promote on write and rely on the demotion path performing those
careful checks later.

Jonathan


> 
> Then you don't particular care about stronger isolation controls
> (except maybe keeping kernel memory out of those regions).
> 
> ~Gregory


