Return-Path: <linux-kernel+bounces-840442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946A3BB46F7
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7833B6D81
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567A122759C;
	Thu,  2 Oct 2025 16:03:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F534221269
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421029; cv=none; b=iEN71nNEXKXRpuE+8Jx+ZvzY0eaXv5qviQ8418PYIVMgiY/tjqE5jD86jBQxiLE+xYZznJ6nje+TbX/xJHJWybKvuTfzJTgIgWWTuQvngdM8p2uHnsBxQnmD5JWK/xNTbhl/JMGE6pZOIJjPlj1Py/bV15h8UdPL2zRm1LEPh1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421029; c=relaxed/simple;
	bh=TSPJuYW9Rxla+eUTZ8lxJM5w7towuX1oN/I2xQrgZyQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CuhM5yv+/Rpc0x1OqtDVYraw2h3FSSkPjO5/JGbYhqk08sNJnsXJofju43+ElsWznN9Je+Gl4S4md4uQvCFB96n6tWgwAgDECzqb4MbcF82Y39zkB979mCFuy5aWUsz1lPqE/CE7hum9L8jp5MoiNnZ6/Yq6iyDPgEqRoCcwWuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccxRG3rQDz67ww1;
	Fri,  3 Oct 2025 00:03:22 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 59FAD1400D7;
	Fri,  3 Oct 2025 00:03:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 17:03:41 +0100
Date: Thu, 2 Oct 2025 17:03:40 +0100
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
Subject: Re: [RFC PATCH V3 05/17] mm: Create a separate kthread for
 migration
Message-ID: <20251002170340.00005ccc@huawei.com>
In-Reply-To: <20250814153307.1553061-6-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-6-raghavendra.kt@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 14 Aug 2025 15:32:55 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Having independent thread helps in:
>  - Alleviating the need for multiple scanning threads
>  - Aids to control batch migration (TBD)
>  - Migration throttling (TBD)
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
A few superficial things inline.

> ---
>  mm/kscand.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/mm/kscand.c b/mm/kscand.c
> index 7552ce32beea..55efd0a6e5ba 100644
> --- a/mm/kscand.c
> +++ b/mm/kscand.c
> @@ -4,6 +4,7 @@
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/migrate.h>
>  #include <linux/rmap.h>
>  #include <linux/pagewalk.h>
>  #include <linux/page_ext.h>
> @@ -41,6 +42,15 @@ static unsigned long kscand_mms_to_scan __read_mostly = KSCAND_MMS_TO_SCAN;
>  
>  bool kscand_scan_enabled = true;
>  static bool need_wakeup;
> +static bool migrated_need_wakeup;
> +
> +/* How long to pause between two migration cycles */
> +static unsigned int kmigrate_sleep_ms __read_mostly = 20;
> +
> +static struct task_struct *kmigrated_thread __read_mostly;
> +static DEFINE_MUTEX(kmigrated_mutex);
> +static DECLARE_WAIT_QUEUE_HEAD(kmigrated_wait);
> +static unsigned long kmigrated_sleep_expire;
>  
>  static unsigned long kscand_sleep_expire;
>  
> @@ -79,6 +89,7 @@ struct kscand_scanctrl {
>  };
>  
>  struct kscand_scanctrl kscand_scanctrl;
> +
Unrelated change. If you want it make sure to push back to earlier patch.


>  /* Per folio information used for migration */
>  struct kscand_migrate_info {
>  	struct list_head migrate_node;
> @@ -134,6 +145,19 @@ static inline bool is_valid_folio(struct folio *folio)
>  	return true;
>  }
>  
> +static inline void kmigrated_wait_work(void)
> +{
> +	const unsigned long migrate_sleep_jiffies =
> +		msecs_to_jiffies(kmigrate_sleep_ms);
> +
> +	if (!migrate_sleep_jiffies)
> +		return;
> +
> +	kmigrated_sleep_expire = jiffies + migrate_sleep_jiffies;
> +	wait_event_timeout(kmigrated_wait,
> +			true,
> +			migrate_sleep_jiffies);

Unusual line wrapping.  I'd go nearer to 80 chars and put at least
some paramters on same line.

> +}

>  static inline void init_list(void)
>  {
>  	INIT_LIST_HEAD(&kscand_scanctrl.scan_list);
> @@ -559,8 +626,15 @@ static int __init kscand_init(void)
>  	if (err)
>  		goto err_kscand;
>  
> +	err = start_kmigrated();
> +	if (err)
> +		goto err_kmigrated;

Similar comment to earlier on not expecting side effects of a thread to stop
if the start failed.

> +
>  	return 0;
>  
> +err_kmigrated:
> +	stop_kmigrated();
> +
>  err_kscand:
>  	stop_kscand();
>  	kscand_destroy();


