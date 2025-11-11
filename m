Return-Path: <linux-kernel+bounces-896310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08FC50153
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82440189BCEE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E220C2F39B1;
	Tue, 11 Nov 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HF3ngo4x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444322BCF6C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762904608; cv=none; b=abtQ8+RUV3fqwvbrSB2ahf28x+jbBnLH7+zzzv7mwBDyZ0ffVefbKWnDWYoqWi67y7QWfNRj2vXYG6agEB5NZOihBj9IY8uRdYhgTtWrXfxbX5h2sn1rBr2MZPAwFYNkh/N/7xCBBFk6SMcj0kuf9hCWHQTZJb7+Vjnzd2Ts5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762904608; c=relaxed/simple;
	bh=c3fLwfJTq1n2GtFdAVnfh0T8tKEokN21QIA5d7iz358=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=U73SeVbmTFcoXgKMBD1DPSTlB0SSBPl4OO+RZph8l6e8hCiifU1Xc5v0Qs9csSNSYXt90EGzh76jSFjL9hpI2UjRUzjwSxqN/e/uHwJkp5iEJh5bOEm56lfwgiuCmiDDfONkJm75z8TWpikZXyVV2ObcXKrBfxpKbz0WE6JTWF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HF3ngo4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C72C19422;
	Tue, 11 Nov 2025 23:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762904607;
	bh=c3fLwfJTq1n2GtFdAVnfh0T8tKEokN21QIA5d7iz358=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HF3ngo4xe0iumt88R1t4nAN+WeQ2VhpOaG+3VZOoCtTa4uEQ/kf6VEv+hfKGX3f8x
	 ai8B+G7DQYNv38p/UOhfW5rmYAkybgew/tYS6CqvVnNvRGIXWolhZN3w517JWybj9F
	 FOeEn9JgFBbA0YWRAddwZl6fLZkH0QEN22DCyi/U=
Date: Tue, 11 Nov 2025 15:43:26 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Balbir Singh <balbirs@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-mm@kvack.org>, David Hildenbrand
 <david@redhat.com>, Zi Yan <ziy@nvidia.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
 <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 "Oscar Salvador" <osalvador@suse.de>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain
 <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, Lyude Paul
 <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ralph Campbell
 <rcampbell@nvidia.com>, Mika =?ISO-8859-1?Q?Penttil=E4?=
 <mpenttil@redhat.com>, Francois Dugast <francois.dugast@intel.com>
Subject: Re: [v7 00/16] mm: support device-private THP
Message-Id: <20251111154326.bc48466a6962fbbffd8ebdd0@linux-foundation.org>
In-Reply-To: <aOePfeoDuRW+prFq@lstrano-desk.jf.intel.com>
References: <20251001065707.920170-1-balbirs@nvidia.com>
	<20251008201740.d9507f4807a73058d4da23a8@linux-foundation.org>
	<a5992f11-5841-4bbf-b190-b5df41b68b0c@nvidia.com>
	<aOePfeoDuRW+prFq@lstrano-desk.jf.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 9 Oct 2025 03:33:33 -0700 Matthew Brost <matthew.brost@intel.com> wrote:

> > >> This patch series introduces support for Transparent Huge Page
> > >> (THP) migration in zone device-private memory. The implementation enables
> > >> efficient migration of large folios between system memory and
> > >> device-private memory
> > > 
> > > Lots of chatter for the v6 series, but none for v7.  I hope that's a
> > > good sign.
> > > 
> > 
> > I hope so too, I've tried to address the comments in v6.
> > 
> 
> Circling back to this series, we will itegrate and test this version.

How'd it go?

Balbir, what's the status here?  It's been a month and this series
still has a "needs a new version" feeling to it.  If so, very soon
please.

TODOs which I have noted are

https://lkml.kernel.org/r/aOePfeoDuRW+prFq@lstrano-desk.jf.intel.com
https://lkml.kernel.org/r/CABzRoyZZ8QLF5PSeDCVxgcnQmF9kFQ3RZdNq0Deik3o9OrK+BQ@mail.gmail.com
https://lkml.kernel.org/r/D2A4B724-E5EF-46D3-9D3F-EBAD9B22371E@nvidia.com
https://lkml.kernel.org/r/62073ca1-5bb6-49e8-b8d4-447c5e0e582e@

plus a general re-read of the
mm-migrate_device-add-thp-splitting-during-migration.patch review
discussion.


