Return-Path: <linux-kernel+bounces-726951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA570B01356
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21611CA04DA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03261D5ABF;
	Fri, 11 Jul 2025 06:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sbquC2wX"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B091D54FE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214216; cv=none; b=X4QkOeV12WeACSbGN9nZefSpPe9aptAW7yGCQbUcVW/f757TsTZTZB4el9EoyjwUGfELfJ0cDHKs36w/Ho7HUn7uPrYl96L/Y1a17gZRWFWbaYvNU+mgJB+kX5iKXzRcr7mWJ5bNKhLt26sFbGoSM6jLhF9uT59N84QURnHzWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214216; c=relaxed/simple;
	bh=MxK4UIQDMHRZzOzYbMfO57exppis0GDO31/E3L0QhYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JS8Beh56PTcqFmbajSjldevN+OsMrI/5IQ2QPqkMUhIw30wTJjjbytJqTOYdJsjF58WYXlvELE1m11WFW9uhINcOhqM8+/DAMyOej3TVHQuurwowAMJQWWcIS4ZvZmjNC1l7pcTK/GyS0NoUsNKEuRRh3hFbegQ/FUglflLWw9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sbquC2wX; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752214203; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GviDtt0HM/H/nsHgI4GLwCPioqjPub/0QBTaXoqCufk=;
	b=sbquC2wXrOYC1Ddcq4iguxQOZusYoRS+zo2fBN91WaBK2nS6nlbBJDc7bBB583d09Lyud+mfcif0TRGPQtCBRMckk9jJUik1jmff7wAoZNzcOPyIh5H3JM4ZvFxByWsowJ/NKkfSnD15MJTQYlIf1Ku+x36ZnyjXiRExldHQiec=
Received: from 30.74.144.131(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WifmNlO_1752214200 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Jul 2025 14:10:01 +0800
Message-ID: <1fe97413-03eb-433a-91b3-b53e58c65622@linux.alibaba.com>
Date: Fri, 11 Jul 2025 14:10:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] mm/shmem, swap: never use swap cache and readahead
 for SWP_SYNCHRONOUS_IO
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Matthew Wilcox <willy@infradead.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Chris Li <chrisl@kernel.org>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250710033706.71042-1-ryncsn@gmail.com>
 <20250710033706.71042-6-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250710033706.71042-6-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/10 11:37, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> For SWP_SYNCHRONOUS_IO devices, if a cache bypassing THP swapin failed
> due to reasons like memory pressure, partially conflicting swap cache
> or ZSWAP enabled, shmem will fallback to cached order 0 swapin.
> 
> Right now the swap cache still has a non-trivial overhead, and readahead
> is not helpful for SWP_SYNCHRONOUS_IO devices, so we should always skip
> the readahead and swap cache even if the swapin falls back to order 0.
> 
> So handle the fallback logic without falling back to the cached read.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

