Return-Path: <linux-kernel+bounces-841163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA891BB662E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB64E1AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584728643E;
	Fri,  3 Oct 2025 09:36:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3C1B4248
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759484166; cv=none; b=a1wRJgsFM1cOSx48EByxc1BbzgtVQ6ps4oX5MAnIJD4aUvhHtGC+aXz1yp/eeyZWlDdynJ1UZwiQxUAu7AVtkI3wiIGWb0AtfcxtNckaZqNyZmTlsl08JRjOapWb4IvMK2r8MWuaKLt5iNyQekUzJTQzfvyi/W73u8AeggaMBE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759484166; c=relaxed/simple;
	bh=L8kpsni/nnzjEOqNMvlyijH6FVkm5rOdANG0pYRwOBs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYLriRn+jjWttAExBYtrz9eXZdh49P2Hy8QqUpFF0j5zJJmOCtX+PjqqFUeVbdoWerHP1OlbONBBCJUAO4hnqZwPsttUMgmRpR1DO29ycsR/CXexR1FrYFiAPuGxlqjAXX+M6frVWvOj4tRYDpcL1nxtdk2qUQg/bEFoboB8y3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdNk85Vn6z6K8gH;
	Fri,  3 Oct 2025 17:32:48 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E30771402EF;
	Fri,  3 Oct 2025 17:35:59 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 10:35:57 +0100
Date: Fri, 3 Oct 2025 10:35:56 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Raghavendra K T <raghavendra.kt@amd.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <Michael.Day@amd.com>,
	<akpm@linux-foundation.org>, <bharata@amd.com>, <dave.hansen@intel.com>,
	<david@redhat.com>, <dongjoo.linux.dev@gmail.com>, <feng.tang@intel.com>,
	<gourry@gourry.net>, <hannes@cmpxchg.org>, <honggyu.kim@sk.com>,
	<hughd@google.com>, <jhubbard@nvidia.com>, <jon.grimm@amd.com>,
	<k.shutemov@gmail.com>, <kbusch@meta.com>, <kmanaouil.dev@gmail.com>,
	<leesuyeon0506@gmail.com>, <leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <nadav.amit@gmail.com>,
	<nphamcs@gmail.com>, <peterz@infradead.org>, <riel@surriel.com>,
	<rientjes@google.com>, <rppt@kernel.org>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>, <vbabka@suse.cz>,
	<weixugc@google.com>, <willy@infradead.org>, <ying.huang@linux.alibaba.com>,
	<ziy@nvidia.com>, <dave@stgolabs.net>, <yuanchu@google.com>,
	<kinseyho@google.com>, <hdanton@sina.com>, <harry.yoo@oracle.com>
Subject: Re: [RFC PATCH V3 08/17] mm: Add throttling of mm scanning using
 scan_size
Message-ID: <20251003103556.00006e3c@huawei.com>
In-Reply-To: <20250814153307.1553061-9-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-9-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 14 Aug 2025 15:32:58 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Before this patch, scanning is done on entire virtual address space
> of all the tasks. Now the scan size is shrunk or expanded based on the
> useful pages found in the last scan.
> 
> This helps to quickly get out of unnecessary scanning thus burning
> lesser CPU.
> 
> Drawback: If a useful chunk is at the other end of the VMA space, it
> will delay scanning and migration.
> 
> Shrink/expand algorithm for scan_size:
> X : Number of useful pages in the last scan.
> Y : Number of useful pages found in current scan.
> Initial scan_size is 1GB
>  case 1: (X = 0, Y = 0)
>   Decrease scan_size by 2
>  case 2: (X = 0, Y > 0)
>   Aggressively change to MAX (4GB)
>  case 3: (X > 0, Y = 0 )
>    No change
>  case 4: (X > 0, Y > 0)
>    Increase scan_size by 2
> 
> Scan size is clamped between MIN (256MB) and MAX (4GB)).
> TBD:  Tuning based on real workloads

Seems like a reasonable thing to do, but as you say tuning
data needed to justify how aggressive this should be and
those size limits.

Trivial stuff inline.

> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> ---
>  mm/kscand.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/mm/kscand.c b/mm/kscand.c
> index 843069048c61..39a7fcef7de8 100644
> --- a/mm/kscand.c
> +++ b/mm/kscand.c
> @@ -28,10 +28,15 @@
>  
>  static struct task_struct *kscand_thread __read_mostly;
>  static DEFINE_MUTEX(kscand_mutex);
> +

Push that into earlier patch to cut down on churn / noise.


>  /*
>   * Total VMA size to cover during scan.
> + * Min: 256MB default: 1GB max: 4GB
>   */
> +#define KSCAND_SCAN_SIZE_MIN	(256 * 1024 * 1024UL)
> +#define KSCAND_SCAN_SIZE_MAX	(4 * 1024 * 1024 * 1024UL)
>  #define KSCAND_SCAN_SIZE	(1 * 1024 * 1024 * 1024UL)
> +

Likewise.

>  static unsigned long kscand_scan_size __read_mostly = KSCAND_SCAN_SIZE;
>  
>  /*
> @@ -94,6 +99,8 @@ struct kscand_mm_slot {
>  	unsigned long next_scan;
>  	/* Tracks how many useful pages obtained for migration in the last scan */
>  	unsigned long scan_delta;
> +	/* Determines how much VMA address space to be covered in the scanning */
> +	unsigned long scan_size;
>  	long address;
>  	bool is_scanned;
>  };

>  static inline void kscand_update_mmslot_info(struct kscand_mm_slot *mm_slot,
>  				unsigned long total)
>  {
>  	unsigned int scan_period;
>  	unsigned long now;
> +	unsigned long scan_size;

Combining a few of these or assigning at declaration will reduce the code size a bit
which is always nice to have if it doesn't hurt readability.

>  	unsigned long old_scan_delta;
>  
> +	scan_size = mm_slot->scan_size;
>  	scan_period = mm_slot->scan_period;
>  	old_scan_delta = mm_slot->scan_delta;


