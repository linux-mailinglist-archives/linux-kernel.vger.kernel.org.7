Return-Path: <linux-kernel+bounces-796526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C74DB40211
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50A85442E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE792D9EEC;
	Tue,  2 Sep 2025 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="LdjTe6eQ"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AB2D2493
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818161; cv=none; b=FWvwesPXtmTeSwGW3LLbUYZ5kSIpCSu2A7wQWYnRaIdi1sTrobIsraKOkP+Lcb+c8Bg3fGw4PvRR63AAyBVEl/okRsxxp8mEXdukoq5szqwihXNgiu0Ys2ykfZCmdR6iNieHh7/Ab4m3YJCnKr+lamHzViWc3SdbAxsqLOrkH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818161; c=relaxed/simple;
	bh=FjwqKpEpIWy7Qc4Lc40FJA8QF2k2WKD68fXOWMSkVIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbE8/dSRKxcrijqg7q9nq4BUP2dSG8En6ZBLSe+POzUJoYEss9KAummNtG6RXOXRzz3lBB7cEay0CyE8yfGP7fOuBt9UyodS3f8sfqLjbe+ujRj9whsCvD6Fq4lrL1nu1ihVmw9pzpwS88WNx+RDtry9znwUUFzHT1j4MZnpz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=LdjTe6eQ; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cGQrQ2xXhz9srN;
	Tue,  2 Sep 2025 15:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1756818150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wFPOiy5SLaPexjP9wqrJNssj3bczB/SHav2Qw3Gd9Hc=;
	b=LdjTe6eQ/u+OEbOVF2aqH1cKrwUrAA+xgHssRPvaT+dh79FXdjoHji5UbdnAVZPSVPRZpZ
	ErlmF/YLUSmclpw58SsKbH5lWamMhVsALOWeAbMMzXyy3jTRfaLEqj9Qaax06kfyo3IXwd
	ibQ0Kq9VtqPWVptBVb+/IziMhlMhtADe4eYv0T8vWJ2CLvhyFYYZn6kOpxHiz1NT7/m5Ex
	JfHVPUPlRxWD99Jl0OliufXS+hW99o7Rprmmga93tOQg14SbS4fQ+l3jXjUopzuiU3b3HO
	p2aPac5RnXGsCw6rO8rAHYy8y+R39jVP5ylxCi56vqaPE2yM0lWYF23nhzS3KQ==
Message-ID: <519df8fd-b02d-4b4b-bf47-79070e3d2c9e@pankajraghav.com>
Date: Tue, 2 Sep 2025 15:02:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] huge_memory: return -EINVAL in folio split functions when
 THP is disabled
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, mcgrof@kernel.org,
 gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20250902084036.208921-1-kernel@pankajraghav.com>
 <qh7s3j26aac3hyzgnr2ee6byjenstxhjnlwn4qxbvz2l32ohqc@qbhdxvpnuhtp>
 <90cd5be7-cbe6-42c5-b0eb-bf9613047097@pankajraghav.com>
 <6l6f5idkqebpai6qn6n3phbnydz55typdwmvp3eexwnhk4qr54@otcgssegyqke>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <6l6f5idkqebpai6qn6n3phbnydz55typdwmvp3eexwnhk4qr54@otcgssegyqke>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>> I was hitting a weird stale content read error and finally ended up with this fix.
>>
>> I thought this is a self-contained patch that can already be upstream. My argument is not that this
>> should not be reachable, but returning -EINVAL will do the right thing instead of returning 0, which
>> means success.
> 
> Okay, makes sense.
> 
> In THP=y case, __folio_split() also returns -EINVAL for !large folios,
> but it is not very explicit:
> 
> 	if (new_order >= folio_order(folio))
> 		return -EINVAL;
> 
> In THP=y, we also issue warning:
> 
> 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> 
You mean:

VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);

> Makes sense to do the same here for THP=n. It might help to catch cases
> we do not see with THP=y, like getting non-THP large folios here.
> 

Yeah, I think that is a good idea. Something like this:

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 48c4f91c5b13..4ddf9e87db91 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -588,21 +588,29 @@ static inline int
 split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
                unsigned int new_order)
 {
+       struct folio *folio = page_folio(page);
+
+       VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
        return -EINVAL;
 }
 static inline int split_huge_page(struct page *page)
 {
+       struct folio *folio = page_folio(page);
+
+       VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
        return -EINVAL;
 }

 static inline int split_folio_to_list(struct folio *folio, struct list_head *list)
 {
+       VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
        return -EINVAL;
 }

 static inline int try_folio_split(struct folio *folio, struct page *page,
                struct list_head *list)
 {
+       VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
        return -EINVAL;
 }

--
Pankaj



