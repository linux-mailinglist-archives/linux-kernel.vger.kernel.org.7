Return-Path: <linux-kernel+bounces-805004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F55AB482E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17620173E4B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867C0212FAA;
	Mon,  8 Sep 2025 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AmLgdfRf"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB791D63F0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 03:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757302147; cv=none; b=mud/nVuMmn9OvpI/R8boLb8NZVvL4ykNKqEvY2m+gwHSN9WdcxAnLafomU9Z/L8y378FnXT7wp2O2v2l7dQ1PCyJ9GqQ0/Nidg5TCy23qsluE/trYyVStRjS2fDFSXagPWr5czmdvGsWUyRNar1scy+a7sL3e6LfXKAAeewik/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757302147; c=relaxed/simple;
	bh=8udS7dlzBVyTQoMWKuEwVG5aAPc5VdRwLh7VzfB4WZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nv5dd09h0TL9XkCUAsDzXqtd/RNkOazV2DpBGgsHuyFv+CyRE4UJoqZhArZlnOw10Jz1pEZCvS8yn3Y1WdLxdHS3hxWKbS1aINz638IW1E4c+slDJGhBG7n3pf/ZOuNU3Vo9T6bZPPgrrv+x20c4FbXukeScI+aq8Kfw49aozo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AmLgdfRf; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757302136; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lfmam1n7TdC8vpNeNDuwecMrTMDdFYZ9Uj7AdA9Dih0=;
	b=AmLgdfRf4gi4rGud/sO8y4rL5jJT3SydLhBxvSjaneP2lWqc1NcrGlAdNYyYYvPgJ5C8Xc/o09gbflvJKusRnbeBUEhnnqHP6HwLEklqvD9h+QqaZm3+lZItxTe9fk7qlrBFzX8yWD/EzUr4vLqDCwB9WxT6mtL5N7+fRCU8Ahc=
Received: from 30.74.144.132(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnQYNOE_1757301815 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 11:23:36 +0800
Message-ID: <73120e6d-0856-4ded-af87-1455c554bfe0@linux.alibaba.com>
Date: Mon, 8 Sep 2025 11:23:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] mm, swap: cleanup swap cache API and add
 kerneldoc
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
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-10-ryncsn@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250905191357.78298-10-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/6 03:13, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> In preparation for replacing the swap cache backend with the swap table,
> clean up and add proper kernel doc for all swap cache APIs. Now all swap
> cache APIs are well-defined with consistent names.
> 
> No feature change, only renaming and documenting.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

With the shmem parts cleanup moved into this patch:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

