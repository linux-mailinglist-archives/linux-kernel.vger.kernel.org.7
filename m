Return-Path: <linux-kernel+bounces-698245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C3AE3F24
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 14:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3162D1899295
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B125C70D;
	Mon, 23 Jun 2025 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="J3KThsGO"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC6B25B69D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680089; cv=none; b=Zi8OIBasCJBnMPmGuXW7wELE9o9hx2G4/Q0Lh1FF2qETSXHR/Z1jR5Bg+2/EEzbR1CRR+IqLWOdmbwGO5FZOcyciniXnlSIRaU4yEPXwyokDLfyhakDY5hbgpjLVd5EMvBWt7/zft0LXcDP34cVIvqaxXBkuIhc3zkRA+6uA6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680089; c=relaxed/simple;
	bh=BKnx4RIjek7E/rOPu3UOodiyY/m4uTgXkFgE5y0mRIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ZFBdKCY2YTRf3OIO71CT9LMnz0PQq/FHBajbe8Ioq/93ezmy3tZGHdW5ZGhqSDd6X5dbyZ8C51l1biAcsuDvBOXIqSt8evHjntTy/QZdqfqtTYGfTZ6f8riM1sn6Rt4DVY0mkjuMzIYQQt480qjMrn6PrxuAiSpb9FOf9YrPAPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=J3KThsGO; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250623120124euoutp02acb9d5636a52126f16ba6aafcf6ffc52~LqkL7tj260180501805euoutp02N
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 12:01:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250623120124euoutp02acb9d5636a52126f16ba6aafcf6ffc52~LqkL7tj260180501805euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750680084;
	bh=QmswFbqzDq4XOvS740eYk+68L2oNBkefGQTaJgQK+NY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=J3KThsGOubEgfg0IwfVOeEA0quwMGx4pOLWaqXWJysp0fJTqskxNJWJ5sIhvynS+I
	 QKhL+ARVFJFgTl6yg8dSnhSN78CVSoAUvvNLEsPFxm/G3AWi66CtR5/ui3XMpmZc0o
	 sfBOoArXI1Cn8047YyJrRVU1IirsQxU/jVhdUnXg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250623120124eucas1p2441d1be7176d61d849aea1bd1b892b8e~LqkLj4zVB1744517445eucas1p2Y;
	Mon, 23 Jun 2025 12:01:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250623120123eusmtip20dfa1daf0bd30559e6dac8b8c2bf818b~LqkKytaR50067700677eusmtip21;
	Mon, 23 Jun 2025 12:01:23 +0000 (GMT)
Message-ID: <ed07e57d-00e0-44b3-b53e-b5295aee8561@samsung.com>
Date: Mon, 23 Jun 2025 14:01:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 1/4] dma-mapping: benchmark: Add padding to
 ensure uABI remained consistent
To: Barry Song <21cnbao@gmail.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Cc: Qinxin Xia <xiaqinxin@huawei.com>, robin.murphy@arm.com,
	yangyicong@huawei.com, hch@lst.de, iommu@lists.linux.dev,
	prime.zeng@huawei.com, fanghao11@huawei.com, linux-kernel@vger.kernel.org,
	linuxarm@huawei.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGsJ_4wOB+cmGzuzzacwJGeUYgGLuKg94wuWC+mA-_=r0TVuhQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250623120124eucas1p2441d1be7176d61d849aea1bd1b892b8e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250616104053eucas1p1017f1af71a338aed4cbdf61930f79e0c
X-EPHeader: CA
X-CMS-RootMailID: 20250616104053eucas1p1017f1af71a338aed4cbdf61930f79e0c
References: <20250614143454.2927363-1-xiaqinxin@huawei.com>
	<20250614143454.2927363-2-xiaqinxin@huawei.com>
	<20250616105318.00001132@huawei.com>
	<CGME20250616104053eucas1p1017f1af71a338aed4cbdf61930f79e0c@eucas1p1.samsung.com>
	<CAGsJ_4wOB+cmGzuzzacwJGeUYgGLuKg94wuWC+mA-_=r0TVuhQ@mail.gmail.com>

On 16.06.2025 12:40, Barry Song wrote:
> On Mon, Jun 16, 2025 at 9:53 PM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
>> On Sat, 14 Jun 2025 22:34:51 +0800
>> Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>> The padding field in the structure was previously reserved to
>>> maintain a stable interface for potential new fields, ensuring
>>> compatibility with user-space shared data structures.
>>> However,it was accidentally removed by tiantao in a prior commit,
>>> which may lead to incompatibility between user space and the kernel.
>>>
>>> This patch reinstates the padding to restore the original structure
>>> layout and preserve compatibility.
>>>
>>> Fixes: 8ddde07a3d28 ("dma-mapping: benchmark: extract a common header file for map_benchmark definition")
>>> Cc: stable@vger.kernel.org
>>> Acked-by: Barry Song <baohua@kernel.org>
>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> FWIW I checked the patch above indeed accidentally dropped the padding and the structure
>> is copied to userspace so this fix is correct.  Given it's not in a uapi header this
>> only really affects the selftest I think this is mostly a case of there possibly being
>> out of tree tools with a local copy of this structure definition.
> Somehow, I feel we have placed
> tools/testing/selftests/dma/dma_map_benchmark.c in the wrong location.
> As a selftest, it should have a mechanism to check kernel dependencies,
> start properly and automatically, and report pass or fail.
>
> dma_map_benchmark.c seems more like a tool that belongs in tools/dma,
> rather than a test.

Indeed imho it would be better to move it out of selftests directory.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


