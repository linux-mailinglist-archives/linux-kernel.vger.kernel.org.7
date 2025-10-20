Return-Path: <linux-kernel+bounces-860360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0AABEFF37
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97250189EDC7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F404E2ECE91;
	Mon, 20 Oct 2025 08:28:21 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332982ECE90
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948900; cv=none; b=jgqmGkxfj4+Eu+QODoMphq9GmDZahI2xHoWvL9fUUsG7Qe/gkQyA8891sXZsuit0kihpjqy6Y/qSGFPKkEq21LPQTUNLRO4VypyHad8iynbtjuQVtV0j/jFM1JyXbOhgNr0toP4lnnwn0SVNbhZNlG1e58Dc3vf//LRn+2HSu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948900; c=relaxed/simple;
	bh=uEbB3koidgu4NzoxpR8xbsfi/njw+D1m6dkyG5YWP4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMUxN8A4THetHER5cUHiPOW/uPgqTt+W8Q75+86erPHCuaxH6Y5R0nGVvSSn4RoxBGsf9so8kij7yB+/Y1Ebq+xdDoG7cHxjrmsayWB2Q1Q29EkVyjEUgNLYhH1Af+cejefgj5bVJ86VyruQfbcwbr0S/lSQYvGxTHfYeW+Fufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-37-68f5f29562fd
Date: Mon, 20 Oct 2025 17:28:00 +0900
From: Byungchul Park <byungchul@sk.com>
To: Shivank Garg <shivankg@amd.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
	willy@infradead.org, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, gourry@gourry.net,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	vkoul@kernel.org, lucas.demarchi@intel.com, rdunlap@infradead.org,
	jgg@ziepe.ca, kuba@kernel.org, justonli@chromium.org,
	ivecera@redhat.com, dave.jiang@intel.com,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rientjes@google.com, Raghavendra.KodsaraThimmappa@amd.com,
	bharata@amd.com, alirad.malek@zptcorp.com, yiannis@zptcorp.com,
	weixugc@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, kernel_team@skhynix.com
Subject: Re: [RFC V3 6/9] mtcopy: introduce multi-threaded page copy routine
Message-ID: <20251020082800.GA28427@system.software.com>
References: <20250923174752.35701-1-shivankg@amd.com>
 <20250923174752.35701-7-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923174752.35701-7-shivankg@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH973nued5Ot32OOFLDNewMlFr9klm/cH2+Jmhrfkxnrknd7qu
	dillsy6SybrEUq7StX7nSBf9WlEtq1BLrVxKJCGTI/1QiLsz47/X3p/35/X5/vFlCFmSeDGj
	0pwUtBpeLackpGTUOWdt6tiEcv2Vzg2QWWqi4FneMAE1lv2Qn/KJgLTUDgQtvXEUTJTOEDD9
	opmGe+kxcD29BUFJTg8Fzfdu0PD5QzB0VOjFUKl7RUNXTSYFA6ZfYmg1FJMwPFRAwaTeFV7q
	/SE1cYSA0f40EhLyykTQVFopgnbTVxqudhopyIjTI6jubyHA2vOFhu/fbKKJfr0IbpqUkPFw
	gPaXc+c7f1Jchu4pyVUbXtCc0RzJXUroorn4plExV17kweXWjog4c8lFijOPXaG5lvTvtuqg
	L5d07hPFfRl+TnLW+90UV3q3m9zjckCySSGoVVGCdt3moxLl2SftdPiF2OjmeAulQwN7E5ET
	g1kf3DPTR/7l121ZDibZlfhdWQ5hZ4pdjS2WaQe7sG44Lr3W1pEwBJtP4YJHyY6FeexOfCn7
	ttjOUhZwR9F7ZGcZy+O3bUP0n3wubr3+xtEnWA9smR0RJSLGxq64cJaxx07sBhxf99ihmW+7
	VV/RLLLfwmwxg++MZxJ/HroINxRZyMuINfynNfynNfzTGhFRgmQqTVQor1L7eCpjNKpoz2Nh
	oWZk+yQFZ34crEJjHfsaEcsgubPU8m5cKRPzURExoY0IM4TcRdqksEVSBR9zWtCGHdFGqoWI
	RuTKkPKFUu/JUwoZe5w/KYQIQrig/TsVMU6LdWh7hcIQtCOr0MtrgbGr4dfHaeo8ozOa3Fcn
	TS3ftTSWqtsyJy3WN8dtlsitWuEnCaz3SzkRvHuL/xJvXz7g5sGj/p07Emp7TdfWjGzLbZ2y
	bkx0XZYtmwgYT7kwpXE7tDWwPPrWqqAHgcl+hwfNV+/QiiXP3BlrVkDywwUhwXFlfQlyMkLJ
	e3kQ2gj+N9yAqIkgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOzjmORsdldXJIOItilBalPWmZHyJfIiokECrQQ57acN42
	HRqEM61IaWkirqk1qdRMEldqhUVeQq28k668dLW1yPuF7KJtRtS3H//n/3ueLw9DyKZIT0Yd
	myhoY3mNgpKQkgNB6ZvyJmdUm4vqNkBhZQUFfTeGCXhoOww3c0YJyM/rRNDyKo2CmcrvBMwN
	NtNQbUqBK6YWBOXFvRQ0V1+lYfzLCWgsahVDZ41RDLWGtzT0PCykYKhiQQyt5lskDH8ooWDW
	KIc3xhDIy3QQ0NBrF8PIQD4J525UiaCpslYE7RVTNOR2WygoSDMieDDQQsBY7wQNP745t80M
	GEVwu0IFBU+H6JC1+Gz3LwoXGLpI/MA8SGOLNQlnneuhcUbTiBjfLVPi63UOEbaWX6CwdfIy
	jVtMP5zVdzvwxfRRCk8Mvybx2OOXFJ7tx4dWHpHsjBI0ar2g9QuOlKjOvGin48+nJjdn2CgD
	GgrLRG4Mx27j3rcVkS4m2XWcvaqYcDHFrudstrlF9mB9uDRTnbMjYQj2JsWVPLu0KCxn93NZ
	1+6IXSxlgess+4xcLGN57lPbB/pP7s61Xvm42CdYJWebd4gyEeNkOVc6z7hiNzaAy3j0fHHN
	CuetJzXNomwkNf9nm/+zzf9sCyLKkYc6Vh/DqzX+vrpoVUqsOtn3eFyMFTlfoeT0z5z7aLon
	tAGxDFIsldrs0yqZmNfrUmIaEMcQCg9pU5QzkkbxKacEbVyENkkj6BqQnCEVq6T7woVIGXuS
	TxSiBSFe0P6dihg3TwMqSDh+NWgs1V+5LHlyV7wjeLzH/V6U99xXq6JPJJNtlbsFFZaM5e5O
	WFLqpT/YEeAIDJ89mr7R0v+2PMkvg1vjHhqyN6x+IbTUpKHqowOxZRw9svOr45F8Sue9cKGm
	I2z7nlq5T5x8Sa7nsmP26GyvCMO8ly7Iu6tfMtFoVzIKUqfitygJrY7/DSXPOQEGAwAA
X-CFilter-Loop: Reflected

On Tue, Sep 23, 2025 at 05:47:41PM +0000, Shivank Garg wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Now page copies are batched, multi-threaded page copy can be used to
> increase page copy throughput.
> 
> Enable using:
> echo 1 >  /sys/kernel/cpu_mt/offloading
> echo NR_THREADS >  /sys/kernel/cpu_mt/threads
> 
> Disable:
> echo 0 >  /sys/kernel/cpu_mt/offloading
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Co-developed-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  drivers/Kconfig                        |   2 +
>  drivers/Makefile                       |   3 +
>  drivers/migoffcopy/Kconfig             |   9 +
>  drivers/migoffcopy/Makefile            |   1 +
>  drivers/migoffcopy/mtcopy/Makefile     |   1 +
>  drivers/migoffcopy/mtcopy/copy_pages.c | 327 +++++++++++++++++++++++++
>  6 files changed, 343 insertions(+)
>  create mode 100644 drivers/migoffcopy/Kconfig
>  create mode 100644 drivers/migoffcopy/Makefile
>  create mode 100644 drivers/migoffcopy/mtcopy/Makefile
>  create mode 100644 drivers/migoffcopy/mtcopy/copy_pages.c
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 4915a63866b0..d2cbc97a7683 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -251,4 +251,6 @@ source "drivers/hte/Kconfig"
> 
>  source "drivers/cdx/Kconfig"
> 
> +source "drivers/migoffcopy/Kconfig"
> +
>  endmenu
> diff --git a/drivers/Makefile b/drivers/Makefile
> index b5749cf67044..5326d88cf31c 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -42,6 +42,9 @@ obj-y                         += clk/
>  # really early.
>  obj-$(CONFIG_DMADEVICES)       += dma/
> 
> +# Migration copy Offload
> +obj-$(CONFIG_OFFC_MIGRATION)   += migoffcopy/
> +
>  # SOC specific infrastructure drivers.
>  obj-y                          += soc/
>  obj-$(CONFIG_PM_GENERIC_DOMAINS)       += pmdomain/
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
> +
> diff --git a/drivers/migoffcopy/Makefile b/drivers/migoffcopy/Makefile
> new file mode 100644
> index 000000000000..0a3c356d67e6
> --- /dev/null
> +++ b/drivers/migoffcopy/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_MTCOPY_CPU) += mtcopy/
> diff --git a/drivers/migoffcopy/mtcopy/Makefile b/drivers/migoffcopy/mtcopy/Makefile
> new file mode 100644
> index 000000000000..b4d7da85eda9
> --- /dev/null
> +++ b/drivers/migoffcopy/mtcopy/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_MTCOPY_CPU) += copy_pages.o
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
> +
> +unsigned int limit_mt_num = 4;
> +static int is_dispatching;
> +
> +static int copy_page_lists_mt(struct list_head *dst_folios,
> +               struct list_head *src_folios, unsigned int nr_items);
> +
> +static DEFINE_MUTEX(migratecfg_mutex);
> +
> +/* CPU Multithreaded Batch Migrator */
> +struct migrator cpu_migrator = {
> +       .name = "CPU_MT_COPY\0",
> +       .migrate_offc = copy_page_lists_mt,
> +       .owner = THIS_MODULE,
> +};
> +
> +struct copy_item {
> +       char *to;
> +       char *from;
> +       unsigned long chunk_size;
> +};
> +
> +struct copy_page_info {
> +       struct work_struct copy_page_work;
> +       int ret;
> +       unsigned long num_items;
> +       struct copy_item item_list[];
> +};
> +
> +static unsigned long copy_page_routine(char *vto, char *vfrom,
> +       unsigned long chunk_size)
> +{
> +       return copy_mc_to_kernel(vto, vfrom, chunk_size);
> +}
> +
> +static void copy_page_work_queue_thread(struct work_struct *work)
> +{
> +       struct copy_page_info *my_work = (struct copy_page_info *)work;
> +       int i;
> +
> +       my_work->ret = 0;
> +       for (i = 0; i < my_work->num_items; ++i)
> +               my_work->ret |= !!copy_page_routine(my_work->item_list[i].to,
> +                                       my_work->item_list[i].from,
> +                                       my_work->item_list[i].chunk_size);
> +}
> +
> +static ssize_t mt_offloading_set(struct kobject *kobj, struct kobj_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +       int ccode;
> +       int action;
> +
> +       ccode = kstrtoint(buf, 0, &action);
> +       if (ccode) {
> +               pr_debug("(%s:) error parsing input %s\n", __func__, buf);
> +               return ccode;
> +       }
> +
> +       /*
> +        * action is 0: User wants to disable MT offloading.
> +        * action is 1: User wants to enable MT offloading.
> +        */
> +       switch (action) {
> +       case 0:
> +               mutex_lock(&migratecfg_mutex);
> +               if (is_dispatching == 1) {
> +                       stop_offloading();
> +                       is_dispatching = 0;
> +               } else
> +                       pr_debug("MT migration offloading is already OFF\n");
> +               mutex_unlock(&migratecfg_mutex);
> +               break;
> +       case 1:
> +               mutex_lock(&migratecfg_mutex);
> +               if (is_dispatching == 0) {
> +                       start_offloading(&cpu_migrator);
> +                       is_dispatching = 1;
> +               } else
> +                       pr_debug("MT migration offloading is already ON\n");
> +               mutex_unlock(&migratecfg_mutex);
> +               break;
> +       default:
> +               pr_debug("input should be zero or one, parsed as %d\n", action);
> +       }
> +       return sizeof(action);
> +}
> +
> +static ssize_t mt_offloading_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", is_dispatching);
> +}
> +
> +static ssize_t mt_threads_set(struct kobject *kobj, struct kobj_attribute *attr,
> +               const char *buf, size_t count)
> +{
> +       int ccode;
> +       unsigned int threads;
> +
> +       ccode = kstrtouint(buf, 0, &threads);
> +       if (ccode) {
> +               pr_debug("(%s:) error parsing input %s\n", __func__, buf);
> +               return ccode;
> +       }
> +
> +       if (threads > 0 && threads <= MAX_NUM_COPY_THREADS) {
> +               mutex_lock(&migratecfg_mutex);
> +               limit_mt_num = threads;
> +               mutex_unlock(&migratecfg_mutex);
> +               pr_debug("MT threads set to %u\n", limit_mt_num);
> +       } else {
> +               pr_debug("Invalid thread count. Must be between 1 and %d\n", MAX_NUM_COPY_THREADS);
> +               return -EINVAL;
> +       }
> +
> +       return count;
> +}
> +
> +static ssize_t mt_threads_show(struct kobject *kobj,
> +               struct kobj_attribute *attr, char *buf)
> +{
> +       return sysfs_emit(buf, "%u\n", limit_mt_num);
> +}
> +
> +int copy_page_lists_mt(struct list_head *dst_folios,
> +               struct list_head *src_folios, unsigned int nr_items)
> +{
> +       struct copy_page_info *work_items[MAX_NUM_COPY_THREADS] = {0};
> +       unsigned int total_mt_num = limit_mt_num;
> +       struct folio *src, *src2, *dst, *dst2;
> +       int max_items_per_thread;
> +       int item_idx;
> +       int err = 0;
> +       int cpu;
> +       int i;
> +
> +       if (IS_ENABLED(CONFIG_HIGHMEM))
> +               return -EOPNOTSUPP;
> +
> +       /* Each threads get part of each page, if nr_items < totla_mt_num */
> +       if (nr_items < total_mt_num)
> +               max_items_per_thread = nr_items;
> +       else
> +               max_items_per_thread = (nr_items / total_mt_num) +
> +                               ((nr_items % total_mt_num) ? 1 : 0);
> +
> +
> +       for (cpu = 0; cpu < total_mt_num; ++cpu) {
> +               work_items[cpu] = kzalloc(sizeof(struct copy_page_info) +
> +                                               sizeof(struct copy_item) *
> +                                                       max_items_per_thread,
> +                                         GFP_NOWAIT);
> +               if (!work_items[cpu]) {
> +                       err = -ENOMEM;
> +                       goto free_work_items;
> +               }
> +       }
> +
> +       if (nr_items < total_mt_num) {
> +               for (cpu = 0; cpu < total_mt_num; ++cpu) {
> +                       INIT_WORK((struct work_struct *)work_items[cpu],
> +                                         copy_page_work_queue_thread);
> +                       work_items[cpu]->num_items = max_items_per_thread;
> +               }
> +
> +               item_idx = 0;
> +               dst = list_first_entry(dst_folios, struct folio, lru);
> +               dst2 = list_next_entry(dst, lru);
> +               list_for_each_entry_safe(src, src2, src_folios, lru) {
> +                       unsigned long chunk_size = PAGE_SIZE * folio_nr_pages(src) / total_mt_num;
> +                       char *vfrom = page_address(&src->page);
> +                       char *vto = page_address(&dst->page);
> +
> +                       VM_WARN_ON(PAGE_SIZE * folio_nr_pages(src) % total_mt_num);
> +                       VM_WARN_ON(folio_nr_pages(dst) != folio_nr_pages(src));
> +
> +                       for (cpu = 0; cpu < total_mt_num; ++cpu) {
> +                               work_items[cpu]->item_list[item_idx].to =
> +                                       vto + chunk_size * cpu;
> +                               work_items[cpu]->item_list[item_idx].from =
> +                                       vfrom + chunk_size * cpu;
> +                               work_items[cpu]->item_list[item_idx].chunk_size =
> +                                       chunk_size;
> +                       }
> +
> +                       item_idx++;
> +                       dst = dst2;
> +                       dst2 = list_next_entry(dst, lru);
> +               }
> +
> +               for (cpu = 0; cpu < total_mt_num; ++cpu)
> +                       queue_work(system_unbound_wq,
> +                                  (struct work_struct *)work_items[cpu]);
> +       } else {
> +               int num_xfer_per_thread = nr_items / total_mt_num;
> +               int per_cpu_item_idx;
> +
> +
> +               for (cpu = 0; cpu < total_mt_num; ++cpu) {
> +                       INIT_WORK((struct work_struct *)work_items[cpu],
> +                                         copy_page_work_queue_thread);
> +
> +                       work_items[cpu]->num_items = num_xfer_per_thread +
> +                                       (cpu < (nr_items % total_mt_num));
> +               }
> +
> +               cpu = 0;
> +               per_cpu_item_idx = 0;
> +               item_idx = 0;
> +               dst = list_first_entry(dst_folios, struct folio, lru);
> +               dst2 = list_next_entry(dst, lru);
> +               list_for_each_entry_safe(src, src2, src_folios, lru) {
> +                       work_items[cpu]->item_list[per_cpu_item_idx].to =
> +                               page_address(&dst->page);
> +                       work_items[cpu]->item_list[per_cpu_item_idx].from =
> +                               page_address(&src->page);
> +                       work_items[cpu]->item_list[per_cpu_item_idx].chunk_size =
> +                               PAGE_SIZE * folio_nr_pages(src);
> +
> +                       VM_WARN_ON(folio_nr_pages(dst) !=
> +                                  folio_nr_pages(src));
> +
> +                       per_cpu_item_idx++;
> +                       item_idx++;
> +                       dst = dst2;
> +                       dst2 = list_next_entry(dst, lru);
> +
> +                       if (per_cpu_item_idx == work_items[cpu]->num_items) {
> +                               queue_work(system_unbound_wq,
> +                                       (struct work_struct *)work_items[cpu]);

Thanks for the great work.

By the way, is it okay to use work queue?  When the system is idle, this
patch will improve the migration performance, but when there are a lot
of other runnable tasks in the system, it might be worse than the
current one.  That's gonna be even worse if there are some other tasks
that wait for the migration to end.  It's worth noting that
padata_do_multithreaded() also uses work queue internally.

I think, at worst, the performance should be same as is.  Or am I
missing something?

	Byungchul

> +                               per_cpu_item_idx = 0;
> +                               cpu++;
> +                       }
> +               }
> +               if (item_idx != nr_items)
> +                       pr_warn("%s: only %d out of %d pages are transferred\n",
> +                               __func__, item_idx - 1, nr_items);
> +       }
> +
> +       /* Wait until it finishes  */
> +       for (i = 0; i < total_mt_num; ++i) {
> +               flush_work((struct work_struct *)work_items[i]);
> +               /* retry if any copy fails */
> +               if (work_items[i]->ret)
> +                       err = -EAGAIN;
> +       }
> +
> +free_work_items:
> +       for (cpu = 0; cpu < total_mt_num; ++cpu)
> +               kfree(work_items[cpu]);
> +
> +       return err;
> +}
> +
> +static struct kobject *mt_kobj_ref;
> +static struct kobj_attribute mt_offloading_attribute = __ATTR(offloading, 0664,
> +               mt_offloading_show, mt_offloading_set);
> +static struct kobj_attribute mt_threads_attribute = __ATTR(threads, 0664,
> +               mt_threads_show, mt_threads_set);
> +
> +static int __init cpu_mt_module_init(void)
> +{
> +       int ret = 0;
> +
> +       mt_kobj_ref = kobject_create_and_add("cpu_mt", kernel_kobj);
> +       if (!mt_kobj_ref)
> +               return -ENOMEM;
> +
> +       ret = sysfs_create_file(mt_kobj_ref, &mt_offloading_attribute.attr);
> +       if (ret)
> +               goto out_offloading;
> +
> +       ret = sysfs_create_file(mt_kobj_ref, &mt_threads_attribute.attr);
> +       if (ret)
> +               goto out_threads;
> +
> +       is_dispatching = 0;
> +
> +       return 0;
> +
> +out_threads:
> +       sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
> +out_offloading:
> +       kobject_put(mt_kobj_ref);
> +       return ret;
> +}
> +
> +static void __exit cpu_mt_module_exit(void)
> +{
> +       /* Stop the MT offloading to unload the module */
> +       mutex_lock(&migratecfg_mutex);
> +       if (is_dispatching == 1) {
> +               stop_offloading();
> +               is_dispatching = 0;
> +       }
> +       mutex_unlock(&migratecfg_mutex);
> +
> +       sysfs_remove_file(mt_kobj_ref, &mt_threads_attribute.attr);
> +       sysfs_remove_file(mt_kobj_ref, &mt_offloading_attribute.attr);
> +       kobject_put(mt_kobj_ref);
> +}
> +
> +module_init(cpu_mt_module_init);
> +module_exit(cpu_mt_module_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zi Yan");
> +MODULE_DESCRIPTION("CPU_MT_COPY"); /* CPU Multithreaded Batch Migrator */
> --
> 2.43.0

