Return-Path: <linux-kernel+bounces-583469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 312FEA77B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 14:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62D737A3DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 12:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1FD202F99;
	Tue,  1 Apr 2025 12:47:11 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA08F1E47A9
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743511630; cv=none; b=OVJ5E2kuE7qTjPlOi+RuRwwNbmk6rJNVXs6fGeVm+xKR7cEp7bN7dswKT1LGs8ASeybnBxWXxIin8E0n+uEM6cviyWe5RiVv69p736bRbL8iYoR9mkYD5+D8YNTNUXNosklYwHq/5PZfuRlvZ/Yeb0NoeltLCEJAaH9mrJ/RCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743511630; c=relaxed/simple;
	bh=dryMZnB6g2dRgy/Y+FJB0nWKQS12ye+lj4Pjro8/8nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a7+JKxwBJwKidySsggnsBTnq6dPCtTjs+LQY+t/PA2U3qAGqUxyJCR0ABdJN2sUDBjuL8e0q/buJO3o99x4wqb6yKeTHh947jdgIw5tbOcRyKeJbxx5LQcqyYwd0hSvo0I5gDKL4I492PlWFrhEku9JGCTtENjAaTdxy6dMuLnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZRnh43bXqz1dyxY;
	Tue,  1 Apr 2025 20:42:12 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 42946180042;
	Tue,  1 Apr 2025 20:47:00 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Apr 2025 20:46:59 +0800
Message-ID: <8ce18336-0bd8-4c6f-8c34-4496c76351ac@huawei.com>
Date: Tue, 1 Apr 2025 20:46:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma-mapping: benchmark: add support for dma_map_sg
To: Barry Song <21cnbao@gmail.com>
CC: yangyicong <yangyicong@huawei.com>, "hch@lst.de" <hch@lst.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"fanghao (A)" <fanghao11@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20250212022718.1995504-1-xiaqinxin@huawei.com>
 <20250212022718.1995504-3-xiaqinxin@huawei.com>
 <CAGsJ_4yDBT4rJyG4-Ow4T3xLq8VujBjG+-uxjnWUm_vW1nzT_A@mail.gmail.com>
 <43618c9167654c68945ec5e7d9bf69d5@huawei.com>
 <CAGsJ_4zNTYsMkeBav7z=AKdm5CjB=Y73P1QBzq+9FS--z9t9Cw@mail.gmail.com>
 <66470ea1-668a-418a-bcf6-c8702be799ce@huawei.com>
 <CAGsJ_4wavUq2y1TXAqKE3_paSDnTRdTyJ_j6LmHcjymm4Y-3mA@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4wavUq2y1TXAqKE3_paSDnTRdTyJ_j6LmHcjymm4Y-3mA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/3/6 17:28, Barry Song 写道:
> On Wed, Mar 5, 2025 at 2:49 AM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> 在 2025/2/22 14:36, Barry Song 写道:
>>> On Fri, Feb 21, 2025 at 4:16 PM xiaqinxin <xiaqinxin@huawei.com> wrote:
>>>>
>>>> -----邮件原件-----
>>>> 发件人: Barry Song <21cnbao@gmail.com>
>>>> 发送时间: 2025年2月18日 4:59
>>>> 收件人: xiaqinxin <xiaqinxin@huawei.com>
>>>> 抄送: chenxiang66@hisilicon.com; yangyicong <yangyicong@huawei.com>; hch@lst.de; iommu@lists.linux.dev; Jonathan Cameron <jonathan.cameron@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; fanghao (A) <fanghao11@huawei.com>; linux-kernel@vger.kernel.org
>>>> 主题: Re: [PATCH 2/3] dma-mapping: benchmark: add support for dma_map_sg
>>>>
>>>> On Wed, Feb 12, 2025 at 3:27 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>>>> Support for dma scatter-gather mapping and is intended for testing
>>>>> mapping performance. It achieves by introducing the dma_sg_map_param
>>>>> structure and related functions, which enable the implementation of
>>>>> scatter-gather mapping preparation, mapping, and unmapping operations.
>>>>> Additionally, the dma_map_benchmark_ops array is updated to include
>>>>> operations for scatter-gather mapping. This commit aims to provide a
>>>>> wider range of mapping performance test  to cater to different scenarios.
>>>> This benchmark is mainly designed to debug contention issues, such as IOMMU TLB flushes or IOMMU driver bottlenecks. I don't fully understand how SG or single will impact the evaluation of the IOMMU driver, making it unclear if the added complexity is justified.
>>>>
>>>> Can you add some explanation on why single mode is not sufficient for profiling and improving IOMMU drivers?
>>>>
>>>> Hello Barry ! 😊
>>>> Currently, the HiSilicon accelerator service uses the dma_map_sg interface. We want to evaluate the performance of the entire DMA map process. (including not only the iommu, but also the map framework). In addition, for scatterlist, __iommu_map is executed for each nent. This increases the complexity and time overhead of mapping. The effect of this fragmentation is not obvious in dma_map_single, which only handles a single contiguous block of memory.
>>>>
>>> Thanks!
>>> Please update your editor to ensure it doesn't respond with such long sentences
>>> without line breaks in the future :-)
>> Hello Barry !
>>
>> Thank you for your advice, I will I'll pay attention. Leon
>>
>>> Can you provide concrete examples or data showing how the newly added mode
>>> improves profiling of the entire DMA map process? For instance, what limitations
>>> exist without this mode? What performance issues cannot be identified without
>>> it?
>> You can see this patch
>> :https://lore.kernel.org/all/cover.1738765879.git.leonro@nvidia.com/
>>
>> Leon provides new interface for scatterlist scenarios to improve
>> performance and gives some
>>
>> application instance in rdma and vfio. Users can use dma_map_sg
>> benchmark to measure
>>
>> the performance improvement of the optimized interface compared with the
>> previous one.
> I’m not quite sure how this patchset helps compare the new interfaces—
> dma_iova_try_alloc(), dma_iova_link(), dma_iova_destroy()—with
> dma_map_sg(), dma_unmap_sg(), etc. Does this mean you also plan
> to include these new interfaces in the benchmark?
>
> However, I agree that this patchset could be useful for evaluating cases
> where we are optimizing dma_map_sg itself for A/B side testing. Do we
> have such a case?
Hello Barry !

I'm sorry, I haven't responded for so long, something urgent took up my 
time,
and we've had some discussion about the requirement scenario.
CCA precision computing calls dma_map_sg and reuses the swiotlb process.
Our team and HUAWEI CLOUD are trying to optimize this process, such as 
this patch:
https://lwn.net/ml/linux-kernel/cover.1690871004.git.petr.tesarik.ext@huawei.com/, 


dma_map_sg benchmark provides a test method to evaluate performance results.

Thank you !
>> Thanks!
>>
>>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>>>>> ---
>>>>>    include/linux/map_benchmark.h |   1 +
>>>>>    kernel/dma/map_benchmark.c    | 102 ++++++++++++++++++++++++++++++++++
>>>>>    2 files changed, 103 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/map_benchmark.h
>>>>> b/include/linux/map_benchmark.h index 054db02a03a7..a9c1a104ba4f
>>>>> 100644
>>>>> --- a/include/linux/map_benchmark.h
>>>>> +++ b/include/linux/map_benchmark.h
>>>>> @@ -17,6 +17,7 @@
>>>>>
>>>>>    enum {
>>>>>           DMA_MAP_SINGLE_MODE,
>>>>> +       DMA_MAP_SG_MODE,
>>>>>           DMA_MAP_MODE_MAX
>>>>>    };
>>>>>
>>>>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>>>>> index d8ec0ce058d8..b5828eeb3db7 100644
>>>>> --- a/kernel/dma/map_benchmark.c
>>>>> +++ b/kernel/dma/map_benchmark.c
>>>>> @@ -17,6 +17,7 @@
>>>>>    #include <linux/module.h>
>>>>>    #include <linux/pci.h>
>>>>>    #include <linux/platform_device.h>
>>>>> +#include <linux/scatterlist.h>
>>>>>    #include <linux/slab.h>
>>>>>    #include <linux/timekeeping.h>
>>>>>
>>>>> @@ -111,8 +112,109 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
>>>>>           .do_unmap = dma_single_map_benchmark_do_unmap,
>>>>>    };
>>>>>
>>>>> +struct dma_sg_map_param {
>>>>> +       struct sg_table sgt;
>>>>> +       struct device *dev;
>>>>> +       void **buf;
>>>>> +       u32 npages;
>>>>> +       u32 dma_dir;
>>>>> +};
>>>>> +
>>>>> +static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data
>>>>> +*map) {
>>>>> +       struct scatterlist *sg;
>>>>> +       int i = 0;
>>>>> +
>>>>> +       struct dma_sg_map_param *mparam __free(kfree) = kzalloc(sizeof(*mparam), GFP_KERNEL);
>>>>> +       if (!mparam)
>>>>> +               return NULL;
>>>>> +
>>>>> +       mparam->npages = map->bparam.granule;
>>>>> +       mparam->dma_dir = map->bparam.dma_dir;
>>>>> +       mparam->dev = map->dev;
>>>>> +       mparam->buf = kmalloc_array(mparam->npages, sizeof(*mparam->buf),
>>>>> +                                   GFP_KERNEL);
>>>>> +       if (!mparam->buf)
>>>>> +               goto err1;
>>>>> +
>>>>> +       if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
>>>>> +               goto err2;
>>>>> +
>>>>> +       for_each_sgtable_sg(&mparam->sgt, sg, i) {
>>>>> +               mparam->buf[i] = (void *)__get_free_page(GFP_KERNEL);
>>>>> +               if (!mparam->buf[i])
>>>>> +                       goto err3;
>>>>> +
>>>>> +               if (mparam->dma_dir != DMA_FROM_DEVICE)
>>>>> +                       memset(mparam->buf[i], 0x66, PAGE_SIZE);
>>>>> +
>>>>> +               sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
>>>>> +       }
>>>>> +
>>>>> +       return_ptr(mparam);
>>>>> +
>>>>> +err3:
>>>>> +       while (i-- > 0)
>>>>> +               free_page((unsigned long)mparam->buf[i]);
>>>>> +
>>>>> +       pr_err("dma_map_sg failed get free page on %s\n", dev_name(mparam->dev));
>>>>> +       sg_free_table(&mparam->sgt);
>>>>> +err2:
>>>>> +       pr_err("dma_map_sg failed alloc sg table on %s\n", dev_name(mparam->dev));
>>>>> +       kfree(mparam->buf);
>>>>> +err1:
>>>>> +       pr_err("dma_map_sg failed alloc mparam buf on %s\n", dev_name(mparam->dev));
>>>>> +       return NULL;
>>>>> +}
>>>>> +
>>>>> +static void dma_sg_map_benchmark_unprepare(void *arg) {
>>>>> +       struct dma_sg_map_param *mparam = arg;
>>>>> +       int i;
>>>>> +
>>>>> +       for (i = 0; i < mparam->npages; i++)
>>>>> +               free_page((unsigned long)mparam->buf[i]);
>>>>> +
>>>>> +       sg_free_table(&mparam->sgt);
>>>>> +
>>>>> +       kfree(mparam->buf);
>>>>> +       kfree(mparam);
>>>>> +}
>>>>> +
>>>>> +static int dma_sg_map_benchmark_do_map(void *arg) {
>>>>> +       struct dma_sg_map_param *mparam = arg;
>>>>> +
>>>>> +       int sg_mapped = dma_map_sg(mparam->dev, mparam->sgt.sgl,
>>>>> +                                  mparam->npages, mparam->dma_dir);
>>>>> +       if (!sg_mapped) {
>>>>> +               pr_err("dma_map_sg failed on %s\n", dev_name(mparam->dev));
>>>>> +               return -ENOMEM;
>>>>> +       }
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>> +static int dma_sg_map_benchmark_do_unmap(void *arg) {
>>>>> +       struct dma_sg_map_param *mparam = arg;
>>>>> +
>>>>> +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
>>>>> +                    mparam->dma_dir);
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>> +static struct map_benchmark_ops dma_sg_map_benchmark_ops = {
>>>>> +       .prepare = dma_sg_map_benchmark_prepare,
>>>>> +       .unprepare = dma_sg_map_benchmark_unprepare,
>>>>> +       .do_map = dma_sg_map_benchmark_do_map,
>>>>> +       .do_unmap = dma_sg_map_benchmark_do_unmap, };
>>>>> +
>>>>>    static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX] = {
>>>>>           [DMA_MAP_SINGLE_MODE] = &dma_single_map_benchmark_ops,
>>>>> +       [DMA_MAP_SG_MODE] = &dma_sg_map_benchmark_ops,
>>>>>    };
>>>>>
>>>>>    static int map_benchmark_thread(void *data)
>>>>> --
>>>>> 2.33.0
>>>>>
> Thanks
> Barry

