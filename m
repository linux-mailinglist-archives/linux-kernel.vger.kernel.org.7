Return-Path: <linux-kernel+bounces-851680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4C1BD70BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 297684EC493
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9655303A3B;
	Tue, 14 Oct 2025 02:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S0UmOpC/"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3D0283FDB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407685; cv=none; b=E/QVzt5pVJoelUwWcl6RLjE+zJUiIfQVBUThzsqIvf1f+QkqJnEZI57F3aJeDa4eTpxX8Yuxo7mbz93Ro6ZhcfFT1c9q2wVO/tHOqmLyzKzfn2f7cKUiauOLYAzUgfbw3mAOf/3mCIFZATT8NwRQqNEw5pQR7VIUDvdfkJjnbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407685; c=relaxed/simple;
	bh=GVmWmAUxoc3GMB0goZ7ZAh1CvmMdEi4g2yYfoGMvQrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5D6WsQ+EkM6s5jpKwEE+ZfAy5P5PS75tguAeCW4Khqmtf8wQarjeH2ZTen2eL3Rqx0sfjoCMo1XGvUylsEydP35JYnwTkJko0kRBTVht+AKksr+7+qmfeuWn/Q7sv5+KY4RJ+EsU1ukSW4R3biskBD4R1WNHCEVBW4UZdTd0gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S0UmOpC/; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760407673; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=l1e4yHys0usVOjKdbyGgqRdrFgCWnc4S7nXC1/DNEPU=;
	b=S0UmOpC/+2qy8arzslMr9gCT9t70yfufkKxh6LfgewSUaILq4tP1rQrMMwC2x9mLd7RYChu/3f68qEOMAIk1ZyIzo5mPK1faUA1Ji376hSy4YA+EmurBgL6JIU1tFlGqESlrdiA0Yq+kasIkw7/v29Ce0qXxpt4ayzfsJCZ7OmU=
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqA-OlU_1760407671 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 10:07:51 +0800
Message-ID: <125ee0cc-fb37-4c7c-8d2d-ac37bdd0317b@linux.alibaba.com>
Date: Tue, 14 Oct 2025 10:07:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: Consistently use current->mm in
 mm_get_unmapped_area()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251003155306.2147572-1-ryan.roberts@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251003155306.2147572-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/3 23:53, Ryan Roberts wrote:
> mm_get_unmapped_area() is a wrapper around arch_get_unmapped_area() /
> arch_get_unmapped_area_topdown(), both of which search current->mm for
> some free space. Neither take an mm_struct - they implicitly operate on
> current->mm.
> 
> But the wrapper takes an mm_struct and uses it to decide whether to
> search bottom up or top down. All callers pass in current->mm for this,
> so everything is working consistently. But it feels like an accident
> waiting to happen; eventually someone will call that function with a
> different mm, expecting to find free space in it, but what gets returned
> is free space in the current mm.
> 
> So let's simplify by removing the parameter and have the wrapper use
> current->mm to decide which end to start at. Now everything is
> consistent and self-documenting.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---

Nice cleanup. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

