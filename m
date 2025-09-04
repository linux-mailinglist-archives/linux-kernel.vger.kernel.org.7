Return-Path: <linux-kernel+bounces-800023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D14B43293
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A4C7B19F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAD7275B1F;
	Thu,  4 Sep 2025 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rYnNUfie"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867F2750E1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967865; cv=none; b=SC9kQOprZIYmsdPFY990v4c8rPjm5VuLE1OUVh1cv1GM07Ohbrm2OkROohId4UCpAfNLVKHjrw0qD3E1zp6dLhm5MM7I5HQZs2COqrH3eKJrLbZNx8ll0buZFd6Da2A6u8eEj7uVN1vPXkLqLwZnmQ3nTfi1fTl8qbAh4km4BVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967865; c=relaxed/simple;
	bh=4G9E878SIS/wbuyZyR8KFsHh8YP6quGk35BoPlc/5o0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=GTYhtEX5Fnqef5rlemMwIBbdBxR9XumpYFZ6KsObc4+qI1h88QSxEm157pO31nBOGhKKJlsCRa0Ti+ebbAMJXCgsHZatO6zXY9E73sFtuZtSq+eixg4rHIXaFxXlzs0QaYFf0NS+VlarBQHJ+1bYDF3QdEVPAXeoqcyp0oJgFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rYnNUfie; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250904063740epoutp04c398124beca7d495e840ceca49beef0b~iAPXQfedB3191131911epoutp04N
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:37:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250904063740epoutp04c398124beca7d495e840ceca49beef0b~iAPXQfedB3191131911epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756967860;
	bh=L7d+FR1/8tzMMzgyBtzSiqeqlPWmljT4OodjD28MEuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYnNUfieCPp1two5PYM4yfmwkEP5UrJka+GQycWZGrula6GFRqwzXYDzLC1560hgW
	 yYs/zyxj0peIaR/sRVFZ9oaPwQL/SzRbd5uNpdDhZ0Ivj2fzSozf4x/L1d0FWHknCL
	 jM28GCeU7AHEV9RNmRyWJKItiNkNHyTc1IpjO884=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250904063740epcas5p46e506f80abbf698a49575878c2fd3dc1~iAPW97Ib01444614446epcas5p4c;
	Thu,  4 Sep 2025 06:37:40 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.87]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cHVCQ6wY7z6B9mB; Thu,  4 Sep
	2025 06:37:38 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250904063643epcas5p3a831ee47fb91bae02b07dfe398b77dd8~iAOibCy-J0506205062epcas5p3A;
	Thu,  4 Sep 2025 06:36:43 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250904063642epsmtip249667dfd8f792ee479b5833d10408d3d~iAOhnvQLo1627016270epsmtip2u;
	Thu,  4 Sep 2025 06:36:42 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai1@huaweicloud.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
Date: Thu,  4 Sep 2025 06:32:09 +0000
Message-Id: <20250904063209.12586-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <bfc12406-e608-b3fa-45e7-2105d9cc15bf@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250904063643epcas5p3a831ee47fb91bae02b07dfe398b77dd8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250904063643epcas5p3a831ee47fb91bae02b07dfe398b77dd8
References: <bfc12406-e608-b3fa-45e7-2105d9cc15bf@huaweicloud.com>
	<CGME20250904063643epcas5p3a831ee47fb91bae02b07dfe398b77dd8@epcas5p3.samsung.com>

On 2025/09/03/18:35PM, Yu Kuai wrote:
>On 2025/09/03 16:41 PM, Xue He wrote:
>> On 2025/09/02 08:47 AM, Yu Kuai wrote:
>>> On 2025/09/01 16:22 PM, Xue He wrote:
>> ......
>> 
>> the information of my nvme like this:
>> number of CPU: 16
>> memory: 16G
>> nvme nvme0: 16/0/16 default/read/poll queue
>> cat /sys/class/nvme/nvme0/nvme0n1/queue/nr_requests
>> 1023
>> 
>> In more precise terms, I think it is not that the tags are fully exhausted,
>> but rather that after scanning the bitmap for free bits, the remaining
>> contiguous bits are nsufficient to meet the requirement (have but not enough).
>> The specific function involved is __sbitmap_queue_get_batch in lib/sbitmap.c.
>>                      get_mask = ((1UL << nr_tags) - 1) << nr;
>>                      if (nr_tags > 1) {
>>                              printk("before %ld\n", get_mask);
>>                      }
>>                      while (!atomic_long_try_cmpxchg(ptr, &val,
>>                                                        get_mask | val))
>>                              ;
>>                      get_mask = (get_mask & ~val) >> nr;
>> 
>> where during the batch acquisition of contiguous free bits, an atomic operation
>> is performed, resulting in the actual tag_mask obtained differing from the
>> originally requested one.
>
>Yes, so this function will likely to obtain less tags than nr_tags,the
>mask is always start from first zero bit with nr_tags bit, and
>sbitmap_deferred_clear() is called uncondionally, it's likely there are
>non-zero bits within this range.
>
>Just wonder, do you consider fixing this directly in
>__blk_mq_alloc_requests_batch()?
>
>  - call sbitmap_deferred_clear() and retry on allocation failure, so
>that the whole word can be used even if previous allocated request are
>done, especially for nvme with huge tag depths;
>  - retry blk_mq_get_tags() until data->nr_tags is zero;
>

I haven't tried this yet, as I'm concerned that if it spin here, it might
introduce more latency. Anyway, I may try to implement this idea and do some
tests to observe the results.

Thanks.

