Return-Path: <linux-kernel+bounces-851748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A337BD72BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6C33E0ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910AA3081A2;
	Tue, 14 Oct 2025 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DKKLGgE4"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0873307499
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411763; cv=none; b=UdAWyxAQ9+1pqoy/w1S7xEWhesT+EaPPg9g8qVXMSTFXlSgifcM/oRb+UesQ+T8nr40UxlvmKgdDGC/xTXzHv9HWkFpJh1pVOoAUImq093/IJr0i9azGI+DlWD7tqj/ypD07IMgjMMygP1NG1USrZpCg5kJor2fve+/k0cYjZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411763; c=relaxed/simple;
	bh=WT18i8rqJ6qGBlHiJQzatHRQKEfv+K+Xgr6J7+6OZ04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GKKN4wsyONGjB2Q8KUb0HGdAVtPk2/Y+lZn8shgP4xQgYumUlKqc+YVWW6Q48ozwjek78v5rGV3Cn8Pzzs3PqDelbgrK0kUl9ZhYwe+i2PlUd8KmdtTVcfPzbiA8jATsDYQrS4/vndYgYv24wHfhchIHkuYQ2a26UBIlxstxANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DKKLGgE4; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760411751; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LiV6b7SrtuoVZx67W0BalusG8NaB9Pi8HQ4FuVqaPtA=;
	b=DKKLGgE4q4rdFqpI8kuUC1pbl10cCWyiMeBFdtc47J+NSMynG7T0Yk0ULi5fYjR24+sCoVBX3yFYgPwqprIRUX0CpGeud74IiawcoBZthSxkUpEi7x5u7a5GS3+MdPFygmpnI5H/P3QC32aveW9wBvuQhBafknydVo5Z7+XzbQg=
Received: from 30.74.144.134(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WqA1jiw_1760411750 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 11:15:50 +0800
Message-ID: <35e79f7f-5197-44fe-93f6-f172a95e0906@linux.alibaba.com>
Date: Tue, 14 Oct 2025 11:15:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm/migrate, swap: drop usage of folio_index
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ying Huang <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-4-74860ef8ba74@tencent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-4-74860ef8ba74@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/7 04:02, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> This helper was used when swap cache was mixed with swap cache. Now they
> are completely separate from each other, access to the swap cache is all
> wrapped by the swap_cache_* helpers, which expect the folio's swap entry
> as a parameter.
> 
> This helper is no longer used, remove the last redundant user and drop it.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

With the commit message fixed, LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>


