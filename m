Return-Path: <linux-kernel+bounces-769011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FEB26907
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DD4AA1738
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB1E1A5B84;
	Thu, 14 Aug 2025 14:07:20 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98A717A318
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180440; cv=none; b=WI0kp4Cj2tOwK2eQsVdjkjTWF8Yiff8N2lbjIHqJIHA0TQR0esb6V0qOhGc/bEGmEHH4jcr3ftt3OQVwp9bpxXpPsRBC9wghgeyUC5GOIE+ZPsjEht5PQABqcb61jLCZnOdHi2VT9a1BNGvE2a1v4tXipUeo49zyZXlP4+xfOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180440; c=relaxed/simple;
	bh=J+z3Q/Ta1L7bZn5a+jyN7+K/TabGM5ub8Fzy5FMgPAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fu2oO0mzDCy/8hmBBPZSDfAsSB53bbMUbbj5pudtuuMk/b8yNwZxOfS1ryiMCl2ZAuHU8rHGpbbHt6A+CoLlm2dzL5Wr8cONV/rta59Wga0epfV+UayyyjO46HIrg8CVXlXSLJA4Yr79pmdr9HFuhsNjizR0DMsiNtCFCgEce6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c2n8k1zdTztTJm;
	Thu, 14 Aug 2025 22:06:14 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 43150180B54;
	Thu, 14 Aug 2025 22:07:14 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 22:07:13 +0800
Message-ID: <ee37ea36-7298-4174-b146-fd62b24ef345@huawei.com>
Date: Thu, 14 Aug 2025 22:07:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH -next 00/16] mm/damon: support ARM32 with LPAE
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>
References: <20250814005738.52844-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250814005738.52844-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200018.china.huawei.com (7.185.36.31)


在 2025/8/14 8:57, SeongJae Park 写道:
> On Wed, 13 Aug 2025 10:25:44 -0700 SeongJae Park <sj@kernel.org> wrote:
>
>> Hello Quanmin,
>>
>> On Wed, 13 Aug 2025 13:06:50 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>>
>>> Previously, DAMON's physical address space monitoring only supported
>>> memory ranges below 4GB on LPAE-enabled systems. This was due to
>>> the use of 'unsigned long' in 'struct damon_addr_range', which is
>>> 32-bit on ARM32 even with LPAE enabled.
>>>
>>> Implements DAMON compatibility for ARM32 with LPAE enabled.
>> Thank you for working on this, Quanmin!
>>
>>> Patches 01/16 through 10/16 are from the mailing list[1], add a new core
>>> layer parameter called 'addr_unit'. Operations set layer can translate a
>>> core layer address to the real address by multiplying the parameter value
>>> to the core layer address.
>>>
>>> Patches 11/16 through 14/16 extend and complement patches 01~10, addressing
>>> various issues introduced by the addr_unit implementation.
>>>
>>> Patches 15/16 and 16/16 complete native DAMON support for 32-bit systems.
>> Overall, looks good to me.  I have a few change requests including below major
>> ones, though.
>>
>> First, let's squash patches for fixing problems made with patches 1-10 into
>> patches 1-10.  If you don't mind, I will post RFC v2 of those so that you can
>> pick into your series.
>>
>> Second, let's keep DAMOS stats in 'unsigned long' type.  This require fixups of
>> patches 1-10.  If you don't mind, I will also do this in RFC v2 of those.
> Instead of posting completely new RFC v2 of the ten patches, I think posting
> fixup patches as replies to this thread might be a better approach.  I will
> make fixups first, see what looks easier for working together with you, and
> either post entirely new version of the patch series, or send individual fixups
> as replies to each patch of this thread.
>
> And one more questions.  What is the baseline if this series?  I cannot simply
> apply these patches on mm-unstable or mm-new.  It would be nice if you could
> share a git tree having these patches fully applied, since 'cherry-pick' is
> easier than 'am' for me.

Hi SJ,

Thank you for your detailed suggestions on the patch series. Please allow me
some time to thoroughly review each of your recommendations. I haven’t responded
to every point immediately because I’d like to first attempt updating the patches
accordingly. If I encounter any questions or issues during the process, I’ll promptly
reach out to discuss them with you, very appreciate your patience and guidance.

By the way, this patch series is based on linux-next(commit:2674d1eadaa2).

Thanks,
Quanmin Yan

>
> Thanks,
> SJ
>
> [...]
>

