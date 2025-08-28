Return-Path: <linux-kernel+bounces-789196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49FDB39225
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDEA464C70
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6476324729A;
	Thu, 28 Aug 2025 03:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EleL2s1M"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6030921CC47
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756351216; cv=none; b=GjwsxGY5CGjEhb5ylYdKehx0OISVOKt5Zu+3Y8Dd5pOPRem55hDiOk4Z4mmJ27kXSrJS0jqmwC0aUEUMyWJDcykPgpdzm7EWm7kjiFbPQXKOuJnRKrUhked/lZ1kBumvgpIwqh089uP8329EXr3SeREboTHuPnJkzwhFlQo0SUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756351216; c=relaxed/simple;
	bh=fLMPUKobAQgQx1jJOBXp15N51JUjlldS717z0V6AcXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKNVMNj/u+sY6BSS23Qk68kOWffu9pC+3r9xlYCfUsP1uVpmLAk5psJr4oHXNMnpwJRakLoHJvfJcVdxAJD5GrkzEJYWvh60glsu/B71d+gWro4+m0uFLofURIRpULM9Ar/beW0n1AmPWuFpkmkgT9zbX4LQtpZ+nACnVSsXE4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EleL2s1M; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756351205; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Xzu8+xsZjYSLmXizNts9wj9/0I/vHYewdZb5tT9jxWY=;
	b=EleL2s1MuYm6GbsYZrpfGoJhZjROG3VlCKLEy50GsPlNcP5JFJVH2X/DE/CmjWBmXC7jni70Ut1/x2CwVhkjTCH7ZB9ameOF/G9OLjo/wTNxWGzC1blUzXPQE+SUE8NIVBF1+M3Ft3eeX7thO1RitZtBD8h0lC9VB3u6CB7/Ld8=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmlD5lW_1756351202 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 28 Aug 2025 11:20:03 +0800
Message-ID: <105cda02-e433-4b28-ab61-7b63115e694f@linux.alibaba.com>
Date: Thu, 28 Aug 2025 11:20:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] mm, swap: use unified helper for swap cache look up
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-2-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250822192023.13477-2-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/23 03:20, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> Always use swap_cache_get_folio for swap cache folio look up. The reason
> we are not using it in all places is that it also updates the readahead
> info, and some callsites want to avoid that.
> 
> So decouple readahead update with swap cache lookup into a standalone
> helper, let the caller call the readahead update helper if that's
> needed. And convert all swap cache lookups to use swap_cache_get_folio.
> 
> After this commit, there are only three special cases for accessing swap
> cache space now: huge memory splitting, migration and shmem replacing,
> because they need to lock the Xarray. Following commits will wrap their
> accesses to the swap cache too with special helpers.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>

LGTM. With the commit message updated:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

