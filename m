Return-Path: <linux-kernel+bounces-813504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670ABB5466A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 294833AA9E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783927587C;
	Fri, 12 Sep 2025 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c/A6kOn5"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369F26E16C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667839; cv=none; b=pS15pE6okr4sXTDS9eVpR0tAif590lNTJqKROlds8M90vprnI+8NOeHX0V7V/pZizv/bBcOUx5zrGVAIB7Q7q40hbm9l3cQiqk7FCNyFGNqP4udM7j5HwYo5On6Yqavr2+NkdLo1v650Fn46trHEPb8Zz3E++6Ba1ZnDtmQEz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667839; c=relaxed/simple;
	bh=CpRmjPjyNdyKtdaQmmChVNUaTy25t/wkmdHNNmEDngc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRjcUBNYAx6O2F2ng769CcKiRhfcDxynydIZUvYzCI2CF4GlaSZFAVy+yHtWOxcD5kM9CR4LXvD3g7k/+mF+zaNoP98AkqJbcBTfq3o+ZUR2IRvfcVvAF+eTY/xkuF0Gk/Ay4qYFl4VgK80gjj7C+64H8Ad2i7/ZSsCv7Akn5YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c/A6kOn5; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757667835; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fMMbX3eaxkeyTCfLPJZNMZKbSbY1DgP1Yv67tu9qpZs=;
	b=c/A6kOn5yRLoWelPiBiyOPOsBdI0227/qsYgjajHoCilpiZWr28VVU0KWYheHuEK9u321b4pcvjTwFKwxWyShrBZatGn0rk3X1j6JwyCiipXK1+wgFzrNwUlgqxJ7rzsbxevmUP4aaRFqktI5lAu/0QuVcwnecqTQuLPlBKict0=
Received: from 30.74.144.122(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnqkMQK_1757667833 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 17:03:54 +0800
Message-ID: <5cf89ea9-91b0-4795-bcd7-d896d4c367b6@linux.alibaba.com>
Date: Fri, 12 Sep 2025 17:03:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com>
 <e6fc05fa-a622-47fc-acf4-9a5be98032aa@redhat.com>
 <94cfb423-1dc5-43e1-bd1f-75b8d43fdc1a@redhat.com>
 <b6fa0add-e739-499d-9fbf-32454b5e137a@linux.alibaba.com>
 <65a84778-b329-457b-a834-aa823f7db29b@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <65a84778-b329-457b-a834-aa823f7db29b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/12 16:57, David Hildenbrand wrote:
> On 12.09.25 10:31, Baolin Wang wrote:
>>
>>
>> On 2025/9/12 16:24, David Hildenbrand wrote:
>>> On 12.09.25 10:24, David Hildenbrand wrote:
>>>> On 12.09.25 05:45, Baolin Wang wrote:
>>>>> Currently, we no longer attempt to write back filesystem folios in
>>>>> pageout(),
>>>>> and only tmpfs/shmem folios and anonymous swapcache folios can be
>>>>> written back.
>>>>
>>>> Can you point me at the code where that is fenced off?
>>
>> Please see the following check in pageout():
>>
>> if (!shmem_mapping(mapping) && !folio_test_anon(folio))
>>     return PAGE_ACTIVATE;
>>
> 
> Oh! I was assuming that we had an earlier check for that, not a check 
> afterwards. It would be worth spelling that out in the patch description.

Sure. I'll mention that if I need a respin. Thanks for reviewing.

