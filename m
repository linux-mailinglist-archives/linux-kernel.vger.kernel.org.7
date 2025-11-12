Return-Path: <linux-kernel+bounces-896331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784FDC501FC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB9C61899B80
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5A1AF0AF;
	Wed, 12 Nov 2025 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aCl3JADm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205712F5A5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762907049; cv=none; b=EMxlzhRC1/oNCRZOv/qZ9EVsc/eI7w0+C/eYaEiFW9NU52Z29jyhfRLTfpQ0og3VujsSFvEaFxt6KMd/quRNvqH00bFIpxk5YkWQ1QPVqEU8GeQnAsDNVBEpKHiOuYjRb8WeXRpkeKhpanXfE/9Dh66eJHcPYHVk6NB+q1DT0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762907049; c=relaxed/simple;
	bh=SHwmfGeuGTjCUqCzSp5HwAAZr/itWc/JkKrfpclEo40=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J9JILD+m/Ri7/iTQiC6sYut5zkv40CTcaagVOkWxI/srmn/vvDJ7mssR8Z+LxQyIikJ2RVoEIgNHTC671z/Mc37ctsZtxfLk8ak+7J4bU5jo86yGbA2wF1Th+PL21jtBi1lFIpUDVr0Hxz0PdYuJ0n20bNqoOTNOgpo/BsGEbVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aCl3JADm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55E0C16AAE;
	Wed, 12 Nov 2025 00:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762907044;
	bh=SHwmfGeuGTjCUqCzSp5HwAAZr/itWc/JkKrfpclEo40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aCl3JADmSiSYrQdxI6LUzS6jyRDkraXKUYntUlJPwUFYa2P+RhU8DMwHIHx+t45yP
	 +yDYuI/RUCe5K1vYGZfphEVAMJd+hTGzRYC61rQOdjWrosqxViCOddNINFluErlfEj
	 8VlvR09zzuLOqrClaxzL69YE/LcNqQC2QlS1sSDM=
Date: Tue, 11 Nov 2025 16:24:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org, David Hildenbrand
 <david@redhat.com>, Zi Yan <ziy@nvidia.com>, Joshua Hahn
 <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park
 <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, Oscar
 Salvador <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>, Danilo Krummrich
 <dakr@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>, Mika
 =?ISO-8859-1?Q?Penttil=E4?= <mpenttil@redhat.com>, Francois Dugast
 <francois.dugast@intel.com>
Subject: Re: [v7 00/16] mm: support device-private THP
Message-Id: <20251111162403.709f37d86b67254765c7846b@linux-foundation.org>
In-Reply-To: <7a0f2704-80b5-4cbd-8f3b-ac03692eefd3@nvidia.com>
References: <20251001065707.920170-1-balbirs@nvidia.com>
	<20251008201740.d9507f4807a73058d4da23a8@linux-foundation.org>
	<a5992f11-5841-4bbf-b190-b5df41b68b0c@nvidia.com>
	<aOePfeoDuRW+prFq@lstrano-desk.jf.intel.com>
	<20251111154326.bc48466a6962fbbffd8ebdd0@linux-foundation.org>
	<7a0f2704-80b5-4cbd-8f3b-ac03692eefd3@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 10:52:43 +1100 Balbir Singh <balbirs@nvidia.com> wrote:

> > https://lkml.kernel.org/r/62073ca1-5bb6-49e8-b8d4-447c5e0e582e@
> > 
> 
> I can't seem to open this

https://lore.kernel.org/all/62073ca1-5bb6-49e8-b8d4-447c5e0e582e@nvidia.com/T/#u

> > plus a general re-read of the
> > mm-migrate_device-add-thp-splitting-during-migration.patch review
> > discussion.
> > 
> That's the patch I have
> 

What I meant was - please re-read the review against that patch (it was
fairly long) and double-check that everything was addressed.


