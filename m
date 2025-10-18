Return-Path: <linux-kernel+bounces-858979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0ADBBEC660
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60DD3B7ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93146280325;
	Sat, 18 Oct 2025 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="khUUExDv"
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491AF248891
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760757181; cv=none; b=UfT1qlUInqSHOZUD2mKMDjv+JoAXIrOCXKu6eUZ79Ksj+xP/FdI/qpFTvdl/LBiQIMfg7fmOd8kNjilyojFKC9DFOyVu1IGklfF/YGJUKEtjCYpLlDM6jwRfRFZZV6hKhqQmvgV6KpSiLjEqtVOWt92Rb/bASMMtqTmZmd+BlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760757181; c=relaxed/simple;
	bh=5rzr00uwyR4ooN4NZ8/VDK13rjZN2mbrdnh0GcuAnQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BynYo9Wtv/c5MfLRrYv4qawbsO65xkkT9d9oW/a0EzQJR5Ni5BmQ38KBgxKowXZ/itjjVZSXE3XlxlQUqnf0ZeiNnHojYC2I0VeUSJpqnQ6gbIiMCP0UAAM50VV2iyQ9/MYVFv4qnWRK6M1KZyDPrMEoAv+j+ot1FotN2AlHJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=khUUExDv; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6JLd3+7eItXpa6oD4S9fDPBUWfNqHNd7yVeROhoYzhk=;
	b=khUUExDvT3R13J+zlBDtTRqcrQXBaFr90ZDcRlnEcMH/93u0p26NoIbqZWt53NL4czY+SQBdo
	/OxEI0osb2yjgBCfCnle2Lszklq7b1TG2qRs3Ddkv2OFUvMv1V1DKYJFPSvhpEzZnt+OXMf3+KZ
	xaS7JvFzR4Tfv6rrLRXuY2U=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cpRZM2kr5zmV6y;
	Sat, 18 Oct 2025 11:12:27 +0800 (CST)
Received: from kwepemr500001.china.huawei.com (unknown [7.202.194.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C2671A016C;
	Sat, 18 Oct 2025 11:12:49 +0800 (CST)
Received: from [10.174.179.35] (10.174.179.35) by
 kwepemr500001.china.huawei.com (7.202.194.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 18 Oct 2025 11:12:47 +0800
Message-ID: <c91878d6-f645-4fc0-abd3-f1ba4aef47cd@huawei.com>
Date: Sat, 18 Oct 2025 11:12:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] pgtable: add pte_clrhuge() implementation for
 arm64 and riscv
To: Matthew Wilcox <willy@infradead.org>
CC: <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <npache@redhat.com>, <ryan.roberts@arm.com>,
	<dev.jain@arm.com>, <baohua@kernel.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <anshuman.khandual@arm.com>,
	<yangyicong@hisilicon.com>, <ardb@kernel.org>, <apopple@nvidia.com>,
	<samuel.holland@sifive.com>, <luxu.kernel@bytedance.com>,
	<abrestic@rivosinc.com>, <yongxuan.wang@sifive.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <wangkefeng.wang@huawei.com>,
	<chenjun102@huawei.com>
References: <20251016112704.179280-1-yintirui@huawei.com>
 <20251016112704.179280-2-yintirui@huawei.com>
 <aPE36PlriswJWSKD@casper.infradead.org>
From: Yin Tirui <yintirui@huawei.com>
In-Reply-To: <aPE36PlriswJWSKD@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500001.china.huawei.com (7.202.194.229)



On 10/17/2025 2:22 AM, Matthew Wilcox wrote:
> On Thu, Oct 16, 2025 at 07:27:03PM +0800, Yin Tirui wrote:
>> Add pte_clrhuge() helper function for architectures that enable
>> ARCH_SUPPORTS_HUGE_PFNMAP to clear huge page attributes from PTE
>> entries.
> 
> I really would prefer to see pte_clrhuge() removed first.  Otherwise
> this just goes onto the long list of "somebody should clean this up some
> day" and nobody ever will.
> 

Understood. I'm working on it.
-- 
Best regards,
Yin Tirui


