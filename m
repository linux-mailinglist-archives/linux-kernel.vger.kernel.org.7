Return-Path: <linux-kernel+bounces-768349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D04B2602A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F4F3B0FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F10303CB1;
	Thu, 14 Aug 2025 08:57:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060CE2FD7C8;
	Thu, 14 Aug 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161848; cv=none; b=rZ0UOLG0wlPpP+CQWZYVMC3wOO4pxKiekI7vW4D+LLkcsDjRiGsazuc2dZIP6WdwS7qG4NgRiKcIrnaKNm/i019CEWC7A283jZ2oBwLYtOus3Lz2P1vsUztXbbF6fqmYz4p7+p8UsHTdM3GGZcD0ZGx1abTBCxfPv8ezUSEeldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161848; c=relaxed/simple;
	bh=IyKSZjc3st7LAyMi4A/QhQBQYrwsTS/FsLwk99CX1e0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CW9C2rZs2vqkC7r+FB1+nYQ4MnJRyBVbihSCcMxTP3hi80nw4IcKrKBpkoG0DmLkrtPpa7ezd2cumtySp9luSWrOhGEKB+ttz7uL4bEFMofPbjnnu6y6eR4DMA9RCyw5QAvJJB3qycB9nYZ06mFdWanW9mytEv3h7AWB5c7aykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2fJM6YD9zYQtHc;
	Thu, 14 Aug 2025 16:57:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 83CC51A0842;
	Thu, 14 Aug 2025 16:57:22 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxTxpJ1oI+6QDg--.19948S3;
	Thu, 14 Aug 2025 16:57:22 +0800 (CST)
Subject: Re: [PATCH 00/16] blk-mq: introduce new queue attribute asyc_dpeth
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, bvanassche@acm.org, nilay@linux.ibm.com, hare@suse.de,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250814033522.770575-1-yukuai1@huaweicloud.com>
 <aJ2WH_RAMPQ9sd6r@fedora>
 <b6587204-9798-fcb0-c4b7-f00d5979d243@huaweicloud.com>
 <aJ2d3gtfi0aEaeEc@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8ff85b30-27c5-c980-a1fb-fdbe18329594@huaweicloud.com>
Date: Thu, 14 Aug 2025 16:57:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aJ2d3gtfi0aEaeEc@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxTxpJ1oI+6QDg--.19948S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWkuFyrCry7Cw43urW3Jrb_yoW8Zr1Up3
	y3t3WSyr4DJry8Cw4xt3WrXry0kw1vgrZxXrs0gr17Gas0q3W0vF1fGF1F9F9rWrn8Gr4a
	gF4qqa93Xa1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/14 16:27, Ming Lei 写道:
> On Thu, Aug 14, 2025 at 04:22:27PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/14 15:54, Ming Lei 写道:
>>> On Thu, Aug 14, 2025 at 11:35:06AM +0800, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Backgroud and motivation:
>>>>
>>>> At first, we test a performance regression from 5.10 to 6.6 in
>>>> downstream kernel(described in patch 13), the regression is related to
>>>> async_depth in mq-dealine.
>>>>
>>>> While trying to fix this regression, Bart suggests add a new attribute
>>>> to request_queue, and I think this is a good idea because all elevators
>>>> have similar logical, however only mq-deadline allow user to configure
>>>> async_depth. And this is patch 9-16, where the performance problem is
>>>> fixed in patch 13;
>>>>
>>>> Because async_depth is related to nr_requests, while reviewing related
>>>> code, patch 2-7 are cleanups and fixes to nr_reqeusts.
>>>>
>>>> I was planning to send this set for the next merge window, however,
>>>> during test I found the last block pr(6.17-rc1) introduce a regression
>>>> if nr_reqeusts grows, exit elevator will panic, and I fix this by
>>>> patch 1,8.
>>>
>>> Please split the patchset into two:
>>>
>>> - one is for fixing recent regression on updating 'nr_requests', so this
>>>     can be merged to v6.17, and be backport easily for stable & downstream
>>
>> There are actually two regressions, as fixed by patch 5 and patch 8, how
>> about the first patchset for patch 1-8? Are you good with those minor
>> prep cleanup patches?
> 
> Then probably you need to make it into three by adding one extra bug fix for
> `fix elevator depth_updated method`, which follows the philosophy of
> "do one thing, do it better", also helps people to review.

Ok, I'll send patch 5 seperatly since it can solve problem
independently, and then a patchset for nr_requests regression.

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> 
> .
> 


