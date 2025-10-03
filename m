Return-Path: <linux-kernel+bounces-841186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A4BB6711
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 12:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67A814E5222
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 10:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BCD2E8E11;
	Fri,  3 Oct 2025 10:25:50 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C752773D9
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759487150; cv=none; b=q80p2f0UYocNNQCxOHNi/ZZxA300SJgg5f9SD8Fo8yaGoCdfDHm70mlHJMo5ZWorfsWAYkbu5uTS5GGpRblTTIqA7JhMJUxmn/1uZvljJwDYoUKhlYF4eASQS28v4UEhE8kByX3g+ET/VwiYbicgFkWwZxY8d+hNLl4FJTm4/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759487150; c=relaxed/simple;
	bh=jcJasMt5PJkqSrsbntNtsJVY5qe4dSw0FFNXgjMyP3s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=knSNBlNmwSa8P3IjQHPvZ0x9rka4E1J/wO1eyTAoZctLh4Z9Rb9oKlFX0jmligBw5Q7W97FJQnInSQiWWnw1SMixJH57d4Bgg0Tsnqna/slAT6Ft57Ab2Ya2yDDMUbksOsEIQXDRKa1r9pVoUz4R1wtNqCl8DZeyMbBTFdIGngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdPtn18BNz6L4wF;
	Fri,  3 Oct 2025 18:25:21 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 635E11402F6;
	Fri,  3 Oct 2025 18:25:44 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 11:25:42 +0100
Date: Fri, 3 Oct 2025 11:25:40 +0100
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
Subject: Re: [RFC PATCH V3 12/17] sysfs: Add sysfs support to tune scanning
Message-ID: <20251003112540.00002cf7@huawei.com>
In-Reply-To: <20250814153307.1553061-13-raghavendra.kt@amd.com>
References: <20250814153307.1553061-1-raghavendra.kt@amd.com>
	<20250814153307.1553061-13-raghavendra.kt@amd.com>
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

On Thu, 14 Aug 2025 15:33:02 +0000
Raghavendra K T <raghavendra.kt@amd.com> wrote:

> Support below tunables:
> scan_enable: turn on or turn off mm_struct scanning
> scan_period: initial scan_period (default: 2sec)
> scan_sleep_ms: sleep time between two successive round of scanning and
> migration.
> mms_to_scan: total mm_struct to scan before taking a pause.
> target_node: default regular node to which migration of accessed pages
> is done (this is only fall back mechnism, otherwise target_node
> heuristic is used).
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>

I'd suggest writing
Documentation/ABI/testing/sysfs-...
doc for this as you'll need it in the end and it tends to be easier to review
a doc for this stuff than the code + figuring out where the entrees end up.

Various comments inline.

J
> ---
>  mm/kscand.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 205 insertions(+)
> 
> diff --git a/mm/kscand.c b/mm/kscand.c
> index 41321d373be7..a73606f7ca3c 100644
> --- a/mm/kscand.c
> +++ b/mm/kscand.c
> @@ -21,6 +21,7 @@
>  #include <linux/delay.h>
>  #include <linux/cleanup.h>
>  #include <linux/minmax.h>
> +#include <trace/events/kmem.h>
>  
>  #include <asm/pgalloc.h>
>  #include "internal.h"
> @@ -173,6 +174,171 @@ static bool kscand_eligible_srcnid(int nid)
>  	return  !node_is_toptier(nid);
>  }
>  
> +#ifdef CONFIG_SYSFS

See below. Should not be necessary - the compiler should be able to
see these are unused after it squashes the stubs for sysfs calls
in and hence remove this for us.


> +
> +static struct kobj_attribute scan_sleep_ms_attr =
> +	__ATTR_RW(scan_sleep_ms);

Fits on one line under 80 chars.

> +
> +static ssize_t mm_scan_period_ms_show(struct kobject *kobj,
> +					 struct kobj_attribute *attr,
> +					 char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", kscand_mm_scan_period_ms);
> +}


> +
> +static struct kobj_attribute mms_to_scan_attr =
> +	__ATTR_RW(mms_to_scan);

Fits on one line.

> +
> +static ssize_t scan_enabled_show(struct kobject *kobj,
> +					 struct kobj_attribute *attr,
> +					 char *buf)

Odd indent.

> +{
> +	return sysfs_emit(buf, "%u\n", kscand_scan_enabled ? 1 : 0);
> +}
> +
> +static ssize_t scan_enabled_store(struct kobject *kobj,
> +					  struct kobj_attribute *attr,
> +					  const char *buf, size_t count)

Another odd looking indent.

> +{
> +	unsigned int val;
> +	int err;
> +
> +	err = kstrtouint(buf, 10, &val);

Maybe use kstrtobool

> +	if (err || val > 1)
> +		return -EINVAL;
> +
> +	if (val) {
> +		kscand_scan_enabled = true;
> +		need_wakeup = true;
> +	} else
> +		kscand_scan_enabled = false;
> +
> +	kscand_sleep_expire = 0;
> +	wake_up_interruptible(&kscand_wait);
> +
> +	return count;
> +}
> +
> +static struct kobj_attribute scan_enabled_attr =
> +	__ATTR_RW(scan_enabled);
One line.

> +

> +}
> +static struct kobj_attribute target_node_attr =
> +	__ATTR_RW(target_node);
One line.
> +
> +static struct attribute *kscand_attr[] = {
> +	&scan_sleep_ms_attr.attr,
> +	&mm_scan_period_ms_attr.attr,
> +	&mms_to_scan_attr.attr,
> +	&scan_enabled_attr.attr,
> +	&target_node_attr.attr,
> +	NULL,

No comma for terminating entries as we don't want to add anything
after this.

> +};
> +
> +struct attribute_group kscand_attr_group = {
> +	.attrs = kscand_attr,
> +	.name = "kscand",
> +};
> +#endif
> +
>  static inline int kscand_has_work(void)
>  {
>  	return !list_empty(&kscand_scan.mm_head);
> @@ -1231,11 +1397,45 @@ static int kscand(void *none)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_SYSFS

The functions used have stubs in sysfs.h so no need
to make these conditional on CONFIG_SYSFS.

Let the compilers dead code removal get rid of the structures
above etc as well.

> +extern struct kobject *mm_kobj;
> +static int __init kscand_init_sysfs(struct kobject **kobj)
> +{
> +	int err;
> +
> +	err = sysfs_create_group(*kobj, &kscand_attr_group);
> +	if (err) {
> +		pr_err("failed to register kscand group\n");
> +		goto err_kscand_attr;
> +	}
> +
> +	return 0;
> +
> +err_kscand_attr:
If create group failed, you shouldn't have anything to remove.



> +	sysfs_remove_group(*kobj, &kscand_attr_group);
> +	return err;
> +}
> +
> +static void __init kscand_exit_sysfs(struct kobject *kobj)
> +{
> +		sysfs_remove_group(kobj, &kscand_attr_group);

Odd indent.

> +}
> +#else
> +static inline int __init kscand_init_sysfs(struct kobject **kobj)
> +{
> +	return 0;
> +}
> +static inline void __init kscand_exit_sysfs(struct kobject *kobj)
> +{
> +}
> +#endif
> +
>  static inline void kscand_destroy(void)
>  {
>  	kmem_cache_destroy(kscand_slot_cache);
>  	/* XXX: move below to kmigrated thread */
>  	kmem_cache_destroy(kmigrated_slot_cache);
> +	kscand_exit_sysfs(mm_kobj);

As it's separate setup step, I'd expect to see this called directly
in error paths in kscand_init() rather than via this helper function.
That way it is easy to see it is only called in paths where it is
appropriate.


>  }
>  
>  void __kscand_enter(struct mm_struct *mm)
> @@ -1421,6 +1621,10 @@ static int __init kscand_init(void)
>  		return -ENOMEM;
>  	}
>  
> +	err = kscand_init_sysfs(&mm_kobj);
> +	if (err)
> +		goto err_init_sysfs;
> +
>  	init_list();
>  	err = start_kscand();
>  	if (err)
> @@ -1437,6 +1641,7 @@ static int __init kscand_init(void)
>  
>  err_kscand:
>  	stop_kscand();
> +err_init_sysfs:
>  	kscand_destroy();
>  
>  	return err;


