Return-Path: <linux-kernel+bounces-827197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96304B9120C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB142A222C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C632FD1AB;
	Mon, 22 Sep 2025 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CDSS6oW6"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1802302748
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544084; cv=none; b=LZl5VTbLrH7nVquCfze74DE0MrvZI3LqXIFrrtdl96sY8JgR2gulngxAdI/2kEYQeuHdMc4b/r1z8PjRENCQhL4hqVlFLWtbyAQeUc3WmGF61B92ErLmLUFwoHz3JjFCU2NY1EPfRnCqMEsFv6COHXsHpvkxERWJtvJB8TOfF4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544084; c=relaxed/simple;
	bh=kL9UJpl+ZheBgmNbIpGnOZSP9GYC1h7+d2TTAFExKSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=RYmSWXOBCc8idxleiVvaYNFlcgI8QAOAteLXyCATCUuoITSMCAdumYnMQi9i7UPJNGO7PJ4XayUwbphMsRtSiFj5p4wXef1phTMZVYuB8DjuNoAGhuGCLBnGcOL0WRVlJqioP1ux+f+tkEbARcVb88do3YQ+DAYvEQCmtneOH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CDSS6oW6; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250922122041euoutp015188d030407485e6dcec6e7ffddbd395~nmh-cojCc2811328113euoutp01p
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:20:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250922122041euoutp015188d030407485e6dcec6e7ffddbd395~nmh-cojCc2811328113euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758543641;
	bh=1sZ8Q9Ocpkk2vOGGwT9iZnSQWL1t7EjbORIITDq2gd8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CDSS6oW6mzeeXA+rcA/5AMlAZiGT7Whi5sjCPnsV+zlnmj2kgyvCGsNTMk9EhtkE7
	 /Sz6Ek92meFvTWKGJ5V9S9LXaQg+4OSUpjLXT/sJGkymVwQvAFgJeOPJhUqKGgHNCb
	 l2TjXTIr/55I5xQrS/my/e7CjMwDMGrGjHa6wTrU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250922122040eucas1p1493b6de9a099bd72ae3ba430cb300a3c~nmh-Gk0IR2796127961eucas1p1S;
	Mon, 22 Sep 2025 12:20:40 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250922122040eusmtip1ed3bfc78352c6db65e35a531ae8866fb~nmh_mn3YU1754317543eusmtip1U;
	Mon, 22 Sep 2025 12:20:40 +0000 (GMT)
Message-ID: <0c59d099-4844-4fb2-80e0-6d3fc0077985@samsung.com>
Date: Mon, 22 Sep 2025 14:20:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] MAINTAINERS: add myself and Barry to dma_map_benchmark
 maintainers
To: Barry Song <21cnbao@gmail.com>, shuah@kernel.org
Cc: Qinxin Xia <xiaqinxin@huawei.com>, robin.murphy@arm.com,
	jonathan.cameron@huawei.com, prime.zeng@huawei.com, fanghao11@huawei.com,
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, yangyicong@huawei.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAGsJ_4yno_a2vD9OHhruXbNOXuVKg97NcOdFHpe283FJ9hXL7Q@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250922122040eucas1p1493b6de9a099bd72ae3ba430cb300a3c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161
X-EPHeader: CA
X-CMS-RootMailID: 20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161
References: <CGME20250917011807eucas1p2dc0c24ef4ad8effcc1a2174d54cf4161@eucas1p2.samsung.com>
	<20250917011759.2228019-1-xiaqinxin@huawei.com>
	<11183850-d6d6-46c9-8079-330bf4c541e3@samsung.com>
	<CAGsJ_4yno_a2vD9OHhruXbNOXuVKg97NcOdFHpe283FJ9hXL7Q@mail.gmail.com>

On 22.09.2025 01:50, Barry Song wrote:
> On Fri, Sep 19, 2025 at 2:17 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 17.09.2025 03:17, Qinxin Xia wrote:
>>> Since Chenxiang has left HiSilicon, Barry and I will jointly
>>> maintain this module.
>>>
>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Thanks!
> Marek, would you rather merge this into the dma-mapping tree
> instead of ACKing it, or would you prefer it to go through
> a different tree?

I expected it to be taken by Shuah, as she is responsible for the 
tools/testing/selftests/ directory, where the dma tests are still placed.


Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


