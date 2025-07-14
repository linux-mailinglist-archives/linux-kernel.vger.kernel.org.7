Return-Path: <linux-kernel+bounces-730617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB7EB046FF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6837C17763B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A1B26A0DD;
	Mon, 14 Jul 2025 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wkiFqcKG"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E24A26A08E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515996; cv=none; b=h7h9iaHLatk61qraONbFPd3I+1SJfF9Vptqu4/U+3pydKu6TLC0iJA2NsvzXIZxe2PEfE4Cg8mZEqZA+nkEKRc6nRp+jzzIO9CXiU8bpYMjfUNPw6upXAjukIPJCiOdCghhKxtKUbhl+WmjMdOTeK8OiT1kWZite53Ra/owIY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515996; c=relaxed/simple;
	bh=SZFexhWICXysOWlWHdh6ixYjyof5pLMjjC8i83fGviQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PFOaV2loqW/rqc13oKNG7c9UjezFvq8xveUwjd3crYE2fIyctUlg0ee4rm1Rm2uzlFDnxu1kegaP++QB5nMjmIewl4af0Mbvvo8YJk0ok5DoH/GGJaYQO3Jg38QIlXbO0v9uPKROxlAR2r0YYjAG+Upjf98nQ/3Px0jXgqPD4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wkiFqcKG; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752515991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wB95BviQqkbgDYRbFJTZzuB7lkYloJSHBXsqNvJjNw=;
	b=wkiFqcKGJXXvzgTTJcb8BqQVT/NWaQp//L9NZ8DURWu3DS70htzRhHBxTX+5rl3ZGYpafk
	ILZhcfJqDQ0Hc7iAvIUzbsahAjY3mxPjSfa4pE3iELRuVXOO1Hn44HpNMrx9OprXwsjxry
	dl7m2QWbjrJoFbZ9EFUXo4WNWyT7/+c=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>,  Michal Hocko <mhocko@kernel.org>,
  David Hildenbrand <david@redhat.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip lru_note_cost() when scanning only file or anon
In-Reply-To: <21100102-51b6-79d5-03db-1bb7f97fa94c@google.com> (Hugh Dickins's
	message of "Sun, 13 Jul 2025 12:57:18 -0700 (PDT)")
References: <20250711155044.137652-1-roman.gushchin@linux.dev>
	<8734b21tie.fsf@linux.dev>
	<21100102-51b6-79d5-03db-1bb7f97fa94c@google.com>
Date: Mon, 14 Jul 2025 10:59:45 -0700
Message-ID: <878qkqslf2.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hugh Dickins <hughd@google.com> writes:

> Roman, I'm expressing no opinion on your patch above, but please may I
> throw the patch below (against 6.16-rc) over the wall to you, to add as a
> 1/2 or 2/2 to yours (as it stands, it does conflict slightly with yours).
>
> My attention needs to be on other things; but five years ago in
> https://lore.kernel.org/linux-mm/alpine.LSU.2.11.2009211440570.5214@eggly.anvils/
> I noted how lru_note_cost() became more costly with per-memcg lru_lock,
> but did nothing about it at the time.  Apparently now is the time.
>
> Thanks,
> Hugh
>
> [PATCH] mm: lru_note_cost_unlock_irq()
>
> Dropping a lock, just to demand it again for an afterthought, cannot be
> good if contended: convert lru_note_cost() to lru_note_cost_unlock_irq().
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Tested-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks, Hugh!

Actually your patch helps quite a lot with the lruvec lock contention
in my test, so I think we can stop looking at my change from the
performance point of view.

