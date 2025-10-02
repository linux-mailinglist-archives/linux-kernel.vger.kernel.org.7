Return-Path: <linux-kernel+bounces-840188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51971BB3C8B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 13:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CF3A51A4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A463093BF;
	Thu,  2 Oct 2025 11:38:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC21F582B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405121; cv=none; b=kMDZ27w0jzHFxCvOX+7VY3fZAV9ZFzCF/VWEG6R6xyJdMX86Ww2Qb1HA5ZVN42s4XuiuJo8qPLiE5/Lh0mV4VNLU4+X8/EeyRfyvknmZnp3UpLewPL5Ihtk+PfpvWRD/Rhs8JtT5+0i3rrMKHVvOPmiPc0Af1J+GUzHkAHqempw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405121; c=relaxed/simple;
	bh=tA3J+jY6rqTQOYyd4U4NZCqUutgnqiO3w8QVoNtlLyE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H3N94oz8wt3TdX6SmXMCWDl5qUlRj4botvp+Pagp8/BOYpQPGOCuYUegzssDI1iSvIw3b33HJq5lCFpqHVrlMG/Isr849aySHzcVQ/UIA1IKK5TxYhKboooBelWr7bsMX7nncXJEIAJbL1fDqndmWfA57PcD8WD1I4sbpspbt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ccqYL6mBGz6K5kg;
	Thu,  2 Oct 2025 19:38:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3030914038F;
	Thu,  2 Oct 2025 19:38:35 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 2 Oct
 2025 12:38:33 +0100
Date: Thu, 2 Oct 2025 12:38:31 +0100
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
Subject: Re: [RFC V3 7/9] dcbm: add dma core batch migrator for batch page
 offloading
Message-ID: <20251002123831.000000f9@huawei.com>
In-Reply-To: <20250923174752.35701-8-shivankg@amd.com>
References: <20250923174752.35701-1-shivankg@amd.com>
	<20250923174752.35701-8-shivankg@amd.com>
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

On Tue, 23 Sep 2025 17:47:42 +0000
Shivank Garg <shivankg@amd.com> wrote:

> The dcbm (DMA core batch migrator) provides a generic interface using
> DMAEngine for end-to-end testing of the batch page migration offload
> feature.
> 
> Enable DCBM offload:
> echo 1 > /sys/kernel/dcbm/offloading
> echo NR_DMA_CHAN_TO_USE > /sys/kernel/dcbm/nr_dma_chan
> 
> Disable DCBM offload:
> echo 0 > /sys/kernel/dcbm/offloading
> 
> Signed-off-by: Shivank Garg <shivankg@amd.com>
Hi Shivank,

Some minor comments inline.

J
> ---
>  drivers/migoffcopy/Kconfig       |   8 +
>  drivers/migoffcopy/Makefile      |   1 +
>  drivers/migoffcopy/dcbm/Makefile |   1 +
>  drivers/migoffcopy/dcbm/dcbm.c   | 415 +++++++++++++++++++++++++++++++
>  4 files changed, 425 insertions(+)
>  create mode 100644 drivers/migoffcopy/dcbm/Makefile
>  create mode 100644 drivers/migoffcopy/dcbm/dcbm.c
> 
> diff --git a/drivers/migoffcopy/Kconfig b/drivers/migoffcopy/Kconfig
> index e73698af3e72..c1b2eff7650d 100644
> --- a/drivers/migoffcopy/Kconfig
> +++ b/drivers/migoffcopy/Kconfig
> @@ -6,4 +6,12 @@ config MTCOPY_CPU
>           Interface MT COPY CPU driver for batch page migration
>           offloading. Say Y if you want to try offloading with
>           MultiThreaded CPU copy APIs.

I'd put a blank line here.

> +config DCBM_DMA
> +       bool "DMA Core Batch Migrator"
> +       depends on OFFC_MIGRATION && DMA_ENGINE
> +       default n

no need to say this. Everything is default n.

> +       help
> +         Interface DMA driver for batch page migration offloading.
> +         Say Y if you want to try offloading with DMAEngine APIs
> +         based driver.

Similar comment on the 'try'

>  
> diff --git a/drivers/migoffcopy/Makefile b/drivers/migoffcopy/Makefile
> index 0a3c356d67e6..dedc86ff54c1 100644
> --- a/drivers/migoffcopy/Makefile
> +++ b/drivers/migoffcopy/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_MTCOPY_CPU) += mtcopy/
> +obj-$(CONFIG_DCBM_DMA)		+= dcbm/
> diff --git a/drivers/migoffcopy/dcbm/Makefile b/drivers/migoffcopy/dcbm/Makefile
> new file mode 100644
> index 000000000000..56ba47cce0f1
> --- /dev/null
> +++ b/drivers/migoffcopy/dcbm/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_DCBM_DMA) += dcbm.o
> diff --git a/drivers/migoffcopy/dcbm/dcbm.c b/drivers/migoffcopy/dcbm/dcbm.c
> new file mode 100644
> index 000000000000..87a58c0c3b9b
> --- /dev/null
> +++ b/drivers/migoffcopy/dcbm/dcbm.c


> +/**
> + * folios_copy_dma - Copy folios using DMA engine
> + * @dst_list: Destination folio list
> + * @src_list: Source folio list
> + * @nr_folios: Number of folios to copy
> + *
> + * Return: 0. Fallback to CPU copy on any error.
> + */
> +static int folios_copy_dma(struct list_head *dst_list,
> +			   struct list_head *src_list,
> +			   unsigned int nr_folios)
> +{
> +	struct dma_work *works;
> +	struct list_head *src_pos = src_list->next;
> +	struct list_head *dst_pos = dst_list->next;
> +	int i, folios_per_chan, ret = 0;
> +	dma_cap_mask_t mask;
> +	int actual_channels = 0;
> +	int max_channels;
> +
> +	max_channels = min3(nr_dma_channels, nr_folios, MAX_DMA_CHANNELS);
> +
> +	works = kcalloc(max_channels, sizeof(*works), GFP_KERNEL);
> +	if (!works)
> +		goto fallback;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_MEMCPY, mask);
> +
> +	for (i = 0; i < max_channels; i++) {
> +		works[actual_channels].chan = dma_request_chan_by_mask(&mask);
> +		if (IS_ERR(works[actual_channels].chan))
> +			break;
> +		init_completion(&works[actual_channels].done);
> +		actual_channels++;
> +	}
> +
> +	if (actual_channels == 0) {
> +		kfree(works);
> +		goto fallback;
> +	}
> +
> +	for (i = 0; i < actual_channels; i++) {
> +		folios_per_chan = nr_folios * (i + 1) / actual_channels -
> +					(nr_folios * i) / actual_channels;
> +		if (folios_per_chan == 0)
> +			continue;
> +
> +		ret = setup_sg_tables(&works[i], &src_pos, &dst_pos, folios_per_chan);
> +	if (ret)
> +		goto cleanup;
> +	}

Indent issues here.

> +
> +	for (i = 0; i < actual_channels; i++) {
> +		ret = submit_dma_transfers(&works[i]);
> +		if (ret) {
> +			dev_err(dmaengine_get_dma_device(works[i].chan),
> +				"Failed to submit transfers for channel %d\n", i);
> +			goto cleanup;
> +		}
> +	}
> +
> +	for (i = 0; i < actual_channels; i++) {
> +		if (atomic_read(&works[i].pending) > 0)
> +			dma_async_issue_pending(works[i].chan);
> +	}
> +
> +	for (i = 0; i < actual_channels; i++) {
> +		if (atomic_read(&works[i].pending) > 0) {
I'd flip logic to something like.
		if (!atomic_read(&works[i].pending)
			continue;

		if (!wait_for_...

Just to reduce the deep indent.

> +			if (!wait_for_completion_timeout(&works[i].done, msecs_to_jiffies(10000))) {
> +				dev_err(dmaengine_get_dma_device(works[i].chan),
> +					"DMA timeout on channel %d\n", i);
> +				ret = -ETIMEDOUT;
> +				goto cleanup;
> +			}
> +		}
> +	}
> +
> +cleanup:
> +	cleanup_dma_work(works, actual_channels);
> +	if (ret)
> +		goto fallback;

This goto goto dance is probably not worth it.  I'd just duplicate the
cleanup_dma_work() call to have a copy in the error path and one in the non error
path.  Then you just end up with a conventional error block of labels + stuff to do.

> +	return 0;
> +fallback:
> +	/* Fall back to CPU copy */
> +	pr_err("DCBM: Falling back to CPU copy\n");
> +	folios_mc_copy(dst_list, src_list, nr_folios);
> +	return 0;
> +}

> +static ssize_t offloading_store(struct kobject *kobj,
> +				struct kobj_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&dcbm_mutex);
> +
> +	if (enable == offloading_enabled) {
> +		pr_err("migration offloading is already %s\n",
> +			 enable ? "ON" : "OFF");

To me that's not an error. Pointless, but not worth moaning about.
Just exit saying nothing.

> +		goto out;
> +	}
> +
> +	if (enable) {
> +		start_offloading(&dma_migrator);
> +		offloading_enabled = true;
> +		pr_info("migration offloading is now ON\n");
> +	} else {
> +		stop_offloading();
> +		offloading_enabled = false;
> +		pr_info("migration offloading is now OFF\n");
> +	}
> +out:
> +	mutex_unlock(&dcbm_mutex);

Perhaps guard and direct return above


> +	return count;
> +}

> +static struct kobj_attribute offloading_attr = __ATTR_RW(offloading);
> +static struct kobj_attribute nr_dma_chan_attr = __ATTR_RW(nr_dma_chan);
> +
> +static struct attribute *dcbm_attrs[] = {
> +	&offloading_attr.attr,
> +	&nr_dma_chan_attr.attr,
> +	NULL,
Trivial but doesn't need a trailing comma given this is a terminating entry
and nothing should ever come after it.

> +};
> +ATTRIBUTE_GROUPS(dcbm);
> +
> +static struct kobject *dcbm_kobj;
> +
> +static int __init dcbm_init(void)
> +{
> +	int ret;
> +
> +	dcbm_kobj = kobject_create_and_add("dcbm", kernel_kobj);
> +	if (!dcbm_kobj)
> +		return -ENOMEM;
> +
> +	ret = sysfs_create_groups(dcbm_kobj, dcbm_groups);
Why use a group here and separate files in the CPU thread one?

I'd prefer a group there as well given slightly simpler error
handling as seen here.


> +	if (ret) {
> +		kobject_put(dcbm_kobj);
> +		return ret;
> +	}
> +
> +	pr_info("DMA Core Batch Migrator initialized\n");
> +	return 0;
> +}
> +


