Return-Path: <linux-kernel+bounces-851735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A671BBD728E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 967B84EE829
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E350C307AD5;
	Tue, 14 Oct 2025 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qb4rHwcd"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B45307ACE
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411562; cv=none; b=K7LOdhOfcXaob0Xe+4bsZiKUTE3lX8iUA0w0vH+iWqOyp0c+UAEC9W5PRuhA7S08s/z+HjsiofMtWuttjlXSKPmhRp43d0Nd1kai/l6x0Q6ByhadWj7nsxGAi3DGQ14t1S+bDg61sN9elahXETjknB/LbYE1+YSWh3vYHvcQxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411562; c=relaxed/simple;
	bh=4pyR2bqlIYwuDmHZEIgkP+ruhjU+ZDXAIvPQnJmBz/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKCBMRe9G8L2gomzEvnjHZEEbB2gY2ZrRzGpHDHjqmn9wMVVBwMT9llskSduHHf4X5VlapIw8zWvCR7VbQl1V2PqaOFPpPktT15zNIej2yUmMN0cbk6Ki8eYcatd9Sw3+j+dhJ8J4Ym4ot+HpNXKoAf0dQVVTcF/GZdizZTxu4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qb4rHwcd; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760411556; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CBWGup56mF4O5M0pZnQX21SFhdfJU3QS5w5Qz5xEMdQ=;
	b=qb4rHwcd/xAj3P54CnldZQyjia4fxyrWziJXcnWbQJMwPF5G2HqhMVEAoT1p3Q7VjE5fsgWLSWCU+5CvV2J3JBxOvM5SeNCrQ0kebVY4bXGy2dHcqU8b7NSGTUYrv6TnuvwsZrqWX3hk1j8GGChFEZrad3LkSwvoW8gF+SbWz3U=
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqA2qf7_1760411555 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 11:12:35 +0800
Message-ID: <e8002ad7-e24a-4d85-bce0-1eb5d265a8a8@linux.alibaba.com>
Date: Tue, 14 Oct 2025 11:12:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mm, swap: cleanup swap entry allocation parameter
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ying Huang <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-3-74860ef8ba74@tencent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-3-74860ef8ba74@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/7 04:02, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> We no longer need this GFP parameter after commit 8578e0c00dcf ("mm, swap:
> use the swap table for the swap cache and switch API"). Before that
> commit the GFP parameter is already almost identical for all callers, so
> nothing changed by that commit. Swap table just moved the GFP to lower
> layer and make it more defined and changes depend on atomic or sleep
> allocation.
> 
> Now this parameter is no longer used, just remove it. No behavior
> change.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

