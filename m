Return-Path: <linux-kernel+bounces-840174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7644DBB3BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 243EC16C7A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3646230FC07;
	Thu,  2 Oct 2025 11:29:37 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723652E0935
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759404576; cv=none; b=uzvADtCJB/NYVYw4BiTbxtSM7icc8T6iS8yAPekAL+jFQxw89hbR+7SNyKEvC3wBVaWv28ZaXanq+27wvWE7oWTn34LLXtd6cCNclchHDAr9gFSDRie1xn7/fs5/l5b42VU0G2Gc4GSiPVgOgPW0Vg728ulFFVX8vJyySgv90WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759404576; c=relaxed/simple;
	bh=0p1iCvUZU2MVevusoquPN/vDux/1sdoQPSrrN7qWCME=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MF2SnwEnlUa/oPVO1y8b62RV51Il6NeOrNr8nO+aSufDg0vzeATd3YMvBYkYzmNzX3vx+WP64GNF9IXqdMrjRqLKcr4xG5NU3pXNrMU4EdFqcpWDm9oumR2weO/JBx35zfwBlgSkEFpynyoscB1eT3CGpjdLPQjFuGDQ3RPlPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccqHc6cckz67FbS;
	Thu,  2 Oct 2025 19:26:20 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id ABDE7140144;
	Thu,  2 Oct 2025 19:29:30 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 12:29:28 +0100
Date: Thu, 2 Oct 2025 12:29:27 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Shivank Garg <shivankg@amd.com>
CC: <akpm@linux-foundation.org>, <david@redhat.com>, <ziy@nvidia.com>,
	<willy@infradead.org>, <matthew.brost@intel.com>, <joshua.hahnjy@gmail.com>,
	<rakie.kim@sk.com>, <byungchul@sk.com>, <gourry@gourry.net>,
	<ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<vkoul@kernel.org>, <lucas.demarchi@intel.com>, <rdunlap@infradead.org>,
	<jgg@ziepe.ca>, <kuba@kernel.org>, <justonli@chromium.org>,
	<ivecera@redhat.com>, <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<rientjes@google.com>, <Raghavendra.KodsaraThimmappa@amd.com>,
	<bharata@amd.com>, <alirad.malek@zptcorp.com>, <yiannis@zptcorp.com>,
	<weixugc@google.com>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC V3 6/9] mtcopy: introduce multi-threaded page copy routine
Message-ID: <20251002122927.000039e5@huawei.com>
In-Reply-To: <20250923174752.35701-7-shivankg@amd.com>
References: <20250923174752.35701-1-shivankg@amd.com>
	<20250923174752.35701-7-shivankg@amd.com>
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

On Tue, 23 Sep 2025 17:47:41 +0000
Shivank Garg <shivankg@amd.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> Now page copies are batched, multi-threaded page copy can be used to
> increase page copy throughput.
> 
> Enable using:
> echo 1 >  /sys/kernel/cpu_mt/offloading
> echo NR_THREADS >  /sys/kernel/cpu_mt/threads

I guess this order is to show that you can update threads with it on
as system load changes.

Maybe call this out explicitly?

> 
> Disable:
> echo 0 >  /sys/kernel/cpu_mt/offloading
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Co-developed-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Various other things inline.

Thanks,

Jonathan

> diff --git a/drivers/migoffcopy/Kconfig b/drivers/migoffcopy/Kconfig
> new file mode 100644
> index 000000000000..e73698af3e72
> --- /dev/null
> +++ b/drivers/migoffcopy/Kconfig
> @@ -0,0 +1,9 @@
> +config MTCOPY_CPU
> +       bool "Multi-Threaded Copy with CPU"
> +       depends on OFFC_MIGRATION
> +       default n
> +       help
> +         Interface MT COPY CPU driver for batch page migration
> +         offloading. Say Y if you want to try offloading with
> +         MultiThreaded CPU copy APIs.
Try?  I'd be more positive in the help text :)

> +

> diff --git a/drivers/migoffcopy/mtcopy/copy_pages.c b/drivers/migoffcopy/mtcopy/copy_pages.c
> new file mode 100644
> index 000000000000..68e50de602d6
> --- /dev/null
> +++ b/drivers/migoffcopy/mtcopy/copy_pages.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Parallel page copy routine.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
Generally we are trying to get away from anything including kernel.h
directly.  There is relatively little still in there, so maybe check
you actually need it here.

> +#include <linux/printk.h>
> +#include <linux/init.h>
> +#include <linux/sysctl.h>
> +#include <linux/sysfs.h>
> +#include <linux/highmem.h>
> +#include <linux/workqueue.h>
> +#include <linux/slab.h>
> +#include <linux/migrate.h>
> +#include <linux/migrate_offc.h>
> +
> +#define MAX_NUM_COPY_THREADS 64
Add a comment on why this number.

> +
> +struct copy_page_info {
> +	struct work_struct copy_page_work;
> +	int ret;
> +	unsigned long num_items;
> +	struct copy_item item_list[];
__counted_by

> +};
> +
> +static unsigned long copy_page_routine(char *vto, char *vfrom,
> +	unsigned long chunk_size)
> +{
> +	return copy_mc_to_kernel(vto, vfrom, chunk_size);
> +}
> +
> +static void copy_page_work_queue_thread(struct work_struct *work)
> +{
> +	struct copy_page_info *my_work = (struct copy_page_info *)work;

container_of()

> +	int i;
> +
> +	my_work->ret = 0;
> +	for (i = 0; i < my_work->num_items; ++i)
> +		my_work->ret |= !!copy_page_routine(my_work->item_list[i].to,
> +					my_work->item_list[i].from,
> +					my_work->item_list[i].chunk_size);
> +}
> +
> +static ssize_t mt_offloading_set(struct kobject *kobj, struct kobj_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	int ccode;
> +	int action;
> +
> +	ccode = kstrtoint(buf, 0, &action);
> +	if (ccode) {
> +		pr_debug("(%s:) error parsing input %s\n", __func__, buf);
> +		return ccode;
> +	}
> +
> +	/*
> +	 * action is 0: User wants to disable MT offloading.
> +	 * action is 1: User wants to enable MT offloading.
> +	 */
> +	switch (action) {
> +	case 0:
> +		mutex_lock(&migratecfg_mutex);
> +		if (is_dispatching == 1) {
> +			stop_offloading();
> +			is_dispatching = 0;
> +		} else
> +			pr_debug("MT migration offloading is already OFF\n");
> +		mutex_unlock(&migratecfg_mutex);
> +		break;
> +	case 1:
> +		mutex_lock(&migratecfg_mutex);
> +		if (is_dispatching == 0) {
> +			start_offloading(&cpu_migrator);
> +			is_dispatching = 1;
> +		} else
> +			pr_debug("MT migration offloading is already ON\n");
> +		mutex_unlock(&migratecfg_mutex);
> +		break;
> +	default:
> +		pr_debug("input should be zero or one, parsed as %d\n", action);
> +	}
> +	return sizeof(action);
> +}
> +
> +static ssize_t mt_offloading_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", is_dispatching);
> +}
> +
> +static ssize_t mt_threads_set(struct kobject *kobj, struct kobj_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	int ccode;
> +	unsigned int threads;
> +
> +	ccode = kstrtouint(buf, 0, &threads);
> +	if (ccode) {
> +		pr_debug("(%s:) error parsing input %s\n", __func__, buf);

I'm fairly sure you can use dynamic debug here to add the __func__ so no need
to do it by hand.

> +		return ccode;
> +	}
> +
> +	if (threads > 0 && threads <= MAX_NUM_COPY_THREADS) {
> +		mutex_lock(&migratecfg_mutex);
> +		limit_mt_num = threads;
> +		mutex_unlock(&migratecfg_mutex);
> +		pr_debug("MT threads set to %u\n", limit_mt_num);
> +	} else {

I'd flip the logic to test first for in range and exit if not. Then
no indent on the good path.

> +		pr_debug("Invalid thread count. Must be between 1 and %d\n", MAX_NUM_COPY_THREADS);
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}

> +int copy_page_lists_mt(struct list_head *dst_folios,
> +		struct list_head *src_folios, unsigned int nr_items)
> +{
> +	struct copy_page_info *work_items[MAX_NUM_COPY_THREADS] = {0};

{} or { NULL } perhaps given it's an array of pointers.

> +	unsigned int total_mt_num = limit_mt_num;
> +	struct folio *src, *src2, *dst, *dst2;
> +	int max_items_per_thread;
> +	int item_idx;
> +	int err = 0;
> +	int cpu;
> +	int i;
> +
> +	if (IS_ENABLED(CONFIG_HIGHMEM))
> +		return -EOPNOTSUPP;
> +
> +	/* Each threads get part of each page, if nr_items < totla_mt_num */
Each thread gets part of each page

total_mt_num  Though isn't the comment talking about when it's greater than or equal?


> +	if (nr_items < total_mt_num)
> +		max_items_per_thread = nr_items;
> +	else
> +		max_items_per_thread = (nr_items / total_mt_num) +
> +				((nr_items % total_mt_num) ? 1 : 0);
> +
> +
> +	for (cpu = 0; cpu < total_mt_num; ++cpu) {
> +		work_items[cpu] = kzalloc(sizeof(struct copy_page_info) +
> +						sizeof(struct copy_item) *
> +							max_items_per_thread,

struct_size() looks appropriate here.

> +					  GFP_NOWAIT);
> +		if (!work_items[cpu]) {
> +			err = -ENOMEM;
> +			goto free_work_items;
> +		}
> +	}
> +
> +	if (nr_items < total_mt_num) {
> +		for (cpu = 0; cpu < total_mt_num; ++cpu) {
> +			INIT_WORK((struct work_struct *)work_items[cpu],
Why not avoid having to know it is at start of structure by using
work_items[cpu]->copy_page_work instead.

> +					  copy_page_work_queue_thread);
> +			work_items[cpu]->num_items = max_items_per_thread;
> +		}
> +
> +		item_idx = 0;
> +		dst = list_first_entry(dst_folios, struct folio, lru);
> +		dst2 = list_next_entry(dst, lru);
> +		list_for_each_entry_safe(src, src2, src_folios, lru) {
> +			unsigned long chunk_size = PAGE_SIZE * folio_nr_pages(src) / total_mt_num;
> +			char *vfrom = page_address(&src->page);
> +			char *vto = page_address(&dst->page);
> +
> +			VM_WARN_ON(PAGE_SIZE * folio_nr_pages(src) % total_mt_num);
> +			VM_WARN_ON(folio_nr_pages(dst) != folio_nr_pages(src));
> +
> +			for (cpu = 0; cpu < total_mt_num; ++cpu) {
> +				work_items[cpu]->item_list[item_idx].to =
> +					vto + chunk_size * cpu;
> +				work_items[cpu]->item_list[item_idx].from =
> +					vfrom + chunk_size * cpu;
> +				work_items[cpu]->item_list[item_idx].chunk_size =
> +					chunk_size;
> +			}
> +
> +			item_idx++;
> +			dst = dst2;
> +			dst2 = list_next_entry(dst, lru);
> +		}
> +
> +		for (cpu = 0; cpu < total_mt_num; ++cpu)
> +			queue_work(system_unbound_wq,
> +				   (struct work_struct *)work_items[cpu]);

As above. If you want the work struct, using the member that is the right type.

> +	} else {
> +		int num_xfer_per_thread = nr_items / total_mt_num;
> +		int per_cpu_item_idx;
> +
> +
> +		for (cpu = 0; cpu < total_mt_num; ++cpu) {
> +			INIT_WORK((struct work_struct *)work_items[cpu],

Same again.

> +					  copy_page_work_queue_thread);
> +
> +			work_items[cpu]->num_items = num_xfer_per_thread +
> +					(cpu < (nr_items % total_mt_num));
> +		}
> +
> +		cpu = 0;
> +		per_cpu_item_idx = 0;
> +		item_idx = 0;
> +		dst = list_first_entry(dst_folios, struct folio, lru);
> +		dst2 = list_next_entry(dst, lru);
> +		list_for_each_entry_safe(src, src2, src_folios, lru) {
> +			work_items[cpu]->item_list[per_cpu_item_idx].to =
> +				page_address(&dst->page);
> +			work_items[cpu]->item_list[per_cpu_item_idx].from =
> +				page_address(&src->page);
> +			work_items[cpu]->item_list[per_cpu_item_idx].chunk_size =
> +				PAGE_SIZE * folio_nr_pages(src);
> +
> +			VM_WARN_ON(folio_nr_pages(dst) !=
> +				   folio_nr_pages(src));
> +
> +			per_cpu_item_idx++;
> +			item_idx++;
> +			dst = dst2;
> +			dst2 = list_next_entry(dst, lru);
> +
> +			if (per_cpu_item_idx == work_items[cpu]->num_items) {
> +				queue_work(system_unbound_wq,
> +					(struct work_struct *)work_items[cpu]);
and one more.
> +				per_cpu_item_idx = 0;
> +				cpu++;
> +			}
> +		}
> +		if (item_idx != nr_items)
> +			pr_warn("%s: only %d out of %d pages are transferred\n",
> +				__func__, item_idx - 1, nr_items);
> +	}
> +
> +	/* Wait until it finishes  */
> +	for (i = 0; i < total_mt_num; ++i) {
> +		flush_work((struct work_struct *)work_items[i]);
> +		/* retry if any copy fails */
> +		if (work_items[i]->ret)
> +			err = -EAGAIN;
> +	}
> +
> +free_work_items:
> +	for (cpu = 0; cpu < total_mt_num; ++cpu)
> +		kfree(work_items[cpu]);
> +
> +	return err;
> +}
> +
> +static struct kobject *mt_kobj_ref;
> +static struct kobj_attribute mt_offloading_attribute = __ATTR(offloading, 0664,
> +		mt_offloading_show, mt_offloading_set);
> +static struct kobj_attribute mt_threads_attribute = __ATTR(threads, 0664,
> +		mt_threads_show, mt_threads_set);
> +
> +static int __init cpu_mt_module_init(void)
> +{
> +	int ret = 0;

Always set before use so don't init here.

> +
> +	mt_kobj_ref = kobject_create_and_add("cpu_mt", kernel_kobj);
> +	if (!mt_kobj_ref)
> +		return -ENOMEM;
> +
> +	ret = sysfs_create_file(mt_kobj_ref, &mt_offloading_attribute.attr);
> +	if (ret)
> +		goto out_offloading;
> +
> +	ret = sysfs_create_file(mt_kobj_ref, &mt_threads_attribute.attr);
> +	if (ret)
> +		goto out_threads;
> +
> +	is_dispatching = 0;
> +
> +	return 0;
> +
> +out_threads:
> +	sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
> +out_offloading:
> +	kobject_put(mt_kobj_ref);
> +	return ret;
> +}

> +module_init(cpu_mt_module_init);
> +module_exit(cpu_mt_module_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zi Yan");
> +MODULE_DESCRIPTION("CPU_MT_COPY"); /* CPU Multithreaded Batch Migrator */

If a module description needs a comment after it I'd rewrite that description!



