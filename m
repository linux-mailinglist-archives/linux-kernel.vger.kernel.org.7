Return-Path: <linux-kernel+bounces-824251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA1B8880F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748C01C82527
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8604E2EB853;
	Fri, 19 Sep 2025 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ctz5uZb/"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B81C6FE5
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272620; cv=none; b=QMrNvT3jFeXA9NXSIc+ANK1SlBZskvqrwzqHg62EZGGU5KTujHGcWSWaRU0sQTKhzmQJLlY5NMkTRycAobEgUao5L2DzYYjvXiAqmBtmSBBgbCAqT/1Wz66jfDaD0zwoPeXTvvB+nc/QkqCaYdvNsiTBqquzS7oPKaa2n/4tN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272620; c=relaxed/simple;
	bh=/zFGQSJGjXBfZZHUWA4hiGJJM03abUh83rPusSSSU8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tK3oUWaMKBPfHU6gGUvqnv9juBpwdQ29Ig0otoAM1wKAAEzkwHf+lDczRuLY8uJlTiQFKc8e+215FnVrPRHxALmjNj8K1m5DGVJWPVvQT1SlRKULV+F3D75ny8uQGle4aV4CO6p2Tq1HnnoO2g2kRqJ7SxAOJxXUau30HlLjhUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ctz5uZb/; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758272615; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ejv4+a1Szt6NXcbVGJywclqiPFjJOmBuKdS8czeKkZw=;
	b=ctz5uZb/4wfA1BZXdAdFcq0aqhC5/rrbk/e5iRUv3Tun7BPkA3NmccnN81BxQFCwWiumiFyTLKwQRhzGw9f2n1bldMR8maT1RmcLQFugXGA56SdAg8dz5k6k832oqLE2UBwYPNTtHFqZxlPICHQJql5tWclxsgsBUPoO+3JH2Bw=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WoJInQG_1758272600 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 17:03:33 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Will Deacon <will@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
  Vlastimil Babka <vbabka@suse.cz>,  Zi Yan <ziy@nvidia.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Yang Shi <yang@os.amperecomputing.com>,
  "Christoph Lameter (Ampere)" <cl@gentwo.org>,  Dev Jain
 <dev.jain@arm.com>,  Barry Song <baohua@kernel.org>,  Anshuman Khandual
 <anshuman.khandual@arm.com>,  Yicong Yang <yangyicong@hisilicon.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Kevin Brodsky
 <kevin.brodsky@arm.com>,  Yin Fengwei <fengwei_yin@linux.alibaba.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
In-Reply-To: <aMvbNvCsSxQjA2rq@arm.com> (Catalin Marinas's message of "Thu, 18
	Sep 2025 11:13:10 +0100")
References: <20250915032946.33203-1-ying.huang@linux.alibaba.com>
	<20250915032946.33203-3-ying.huang@linux.alibaba.com>
	<46dcddec-88a9-4b22-920c-8a3edeb2f027@arm.com>
	<87o6r833li.fsf@DESKTOP-5N7EMDA> <aMvbNvCsSxQjA2rq@arm.com>
Date: Fri, 19 Sep 2025 17:03:17 +0800
Message-ID: <87wm5uizl6.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Sep 18, 2025 at 10:18:49AM +0800, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> > contpte_ptep_set_access_flags() currently does a (broadcast) __flush_tlb_range()
>> > on the (pte_write(orig_pte) == pte_write(entry)) path. I think that should be
>> > changed to a local range invalidation to be consistent with this change.
>> 
>> Yes.  This should be changed too.  However, it means we need a local
>> variant of __flush_tlb_range() and flush_tlb_mm().  Is it OK to
>> introduce them first and tidy up later?
>
> If it's just for contpte, we'd never take the flush_tlb_mm() path. So we
> could instead add a specific local_flush_tlb_contpte_range().

Sure.

---
Best Regards,
Huang, Ying

