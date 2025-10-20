Return-Path: <linux-kernel+bounces-860253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FABBEFAF7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B14904E97DB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EBA2C0F7D;
	Mon, 20 Oct 2025 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GQjT+IJn"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF41AF0AF
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760945714; cv=none; b=bsYNIkuBLGcgbqXHdnvXA+fPudq9IExtlVK1Uk7JjxeC9PTstEBkhpfmZX4/32oo1+ExkhEs2eDcALkr8TvZpVRTgKao9CQ645yBIh9y+2mV9+z1z3+ozCP9nfjcAlkJcF2y7RqTeqI6sua4qauTlWLt5HehtfDFaG2f3ZyYePI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760945714; c=relaxed/simple;
	bh=ddVseWF9wQK0aQ/axKkSo+bl6HJqhAU/ZYADvrnJO7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOAgfMrznCBE7Co7fy0wIjs6dmtvsUw25FRb1Pbico4DAcHMd+LAjCDorhlCpkReULwmuNuvpwuCxtnbh2VZVjY2F174WmkhEspRC5mYTtnMVosqiPO8GpGbyno+J1+tldbuerZ1Qdacnxi3jTWymvZYyjU9v818OnaDGS6C9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GQjT+IJn; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760945702; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FwY4Mw2Hsvl9+mXWTXLCL2RzlZKdk8AHQMi9pCkPNSQ=;
	b=GQjT+IJn5MfdcJUkx2qgILGqWnY7HETF0rAoWz+iuoZNGDJHJr8/PMZs8qVtO5XWsDmaRWzsTy2vnnvkIAF3BHcgSO1lmvu1g5FczC4hqRBV86LavwnB5Z5iSKTJSlGxPU0AuWkRoU/IZC8aAOVFl/ANp9uKirGO1FbilKvtZYI=
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqXxQTq_1760945699 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Oct 2025 15:35:00 +0800
Message-ID: <3971f97e-399c-425b-979f-55334eacd925@linux.alibaba.com>
Date: Mon, 20 Oct 2025 15:34:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: vmscan: simplify the logic for activating
 dirty file folios
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, david@redhat.com,
 zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1760687075.git.baolin.wang@linux.alibaba.com>
 <ba5c49955fd93c6850bcc19abf0e02e1573768aa.1760687075.git.baolin.wang@linux.alibaba.com>
 <aPIwafJOKUh3N4zX@tiehlicka>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <aPIwafJOKUh3N4zX@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/17 20:02, Michal Hocko wrote:
> On Fri 17-10-25 15:53:07, Baolin Wang wrote:
>> After commit 6b0dfabb3555 ("fs: Remove aops->writepage"), we no longer
>> attempt to write back filesystem folios through reclaim.
>>
>> However, in the shrink_folio_list() function, there still remains some
>> logic related to writeback control of dirty file folios. The original
>> logic was that, for direct reclaim, or when folio_test_reclaim() is false,
>> or the PGDAT_DIRTY flag is not set, the dirty file folios would be directly
>> activated to avoid being scanned again; otherwise, it will try to writeback
>> the dirty file folios. However, since we can no longer perform writeback on
>> dirty folios, the dirty file folios will still be activated.
>>
>> Additionally, under the original logic, if we continue to try writeback dirty
>> file folios, we will also check the references flag, sc->may_writepage, and
>> may_enter_fs(), which may result in dirty file folios being left in the inactive
>> list. This is unreasonable. Even if these dirty folios are scanned again, we
>> still cannot clean them.
>>
>> Therefore, the checks on these dirty file folios appear to be redundant and can
>> be removed. Dirty file folios should be directly moved to the active list to
>> avoid being scanned again. Since we set the PG_reclaim flag for the dirty folios,
>> once the writeback is completed, they will be moved back to the tail of the
>> inactive list to be retried for quick reclaim.
> 
> Is there any actual problem you are trying to address or is this a code
> clean up? How have you evaluated this change?

This patch is more of a cleanup patch, since dirty file folios are also 
activated in pageout(), so there are essentially no significant logical 
changes. Moreover, this patch set is a continuation of the previous 
cleanup work[1] for dirty file folios, and further cleanup and 
optimization work for file folios reclamation is still ongoing.

I conducted some evaluations (such as building the kernel in memcg to 
reclaim file folios and running thpcompact to reclaim file folios), and 
I did not observe any obvious changes in reclaim efficiency.

[1] 
https://lore.kernel.org/all/cover.1758166683.git.baolin.wang@linux.alibaba.com/T/#u

