Return-Path: <linux-kernel+bounces-796395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC02EB3FFE5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BA81B27CE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F6D1ACECE;
	Tue,  2 Sep 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="bJ7BFzoS"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662511A08A4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815357; cv=none; b=NX4d/SEuG3AmY6K2IUTHnWyaYFGcNZVfFvRehAyyyxYghuwv2SVlHUlZZ38Rr9hGY07dNvHTQbh78S490GXOleYf0t9ahV0wc0PuRg7eFSm+cA0laJwa952F7F1jfrdS6Ttm6q8FJTpZbKnyDTwExSeAUMrfJDAR0RD5uvwkFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815357; c=relaxed/simple;
	bh=h74inSWf+5MkQxxBHG2+/mAP2BznY7GSHYbKLV6VLdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6NT/9PFtpEwTqZ1mHI6Wn6CxPfifa8E6F6ppVg6lLT4VN5vp0lwCGS5r957/iUAf3TgvarSo1Igy6osgckicuIiS9qgkuPPZtkzGO3l6l6t6ftAW46WoqCq0/ApdcA9oBnkRflrWiSgrLMZ2zBvrBuQcPb+D/zDwJJBYu9gcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=bJ7BFzoS; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cGPpZ3Ht5z9t74;
	Tue,  2 Sep 2025 14:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1756815350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SseA8gH1Kt5WU32TGkwvv/o/YEcElQ+UmctNRMOZbf4=;
	b=bJ7BFzoSsug4kI4qguV4eSNmegRBgMhTFTaDePTehN1gBpxgKpl3Yqwh72c4wseMXxTsRv
	/cHuMiaNZVt20b7YlCLUUyWGX1DrBAlOLdDoWOwD+gXTLpvChtQWzzy03D5SpOBmYIVarb
	F/CTivV/oy2RlB8jndZ2JM9sDj4nWZ5hbonUl5mKFZ8pFgZpaqEg7b+VfNo+pjzcx7UhNK
	inW+W8vW0CbdzSDhPcfeAcmxDOzpfyPIpGDrs/Ezav5MmCAqbe/ET7yx4Nnll8pGeqO1zW
	VScd3ZCRmZFzOndRzdn4cMstxSp9Fj8mqJ7A8JD4wU/q/wfnHg2h9MZaJ2WuQg==
Message-ID: <90cd5be7-cbe6-42c5-b0eb-bf9613047097@pankajraghav.com>
Date: Tue, 2 Sep 2025 14:15:42 +0200
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
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <qh7s3j26aac3hyzgnr2ee6byjenstxhjnlwn4qxbvz2l32ohqc@qbhdxvpnuhtp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/2/25 13:22, Kiryl Shutsemau wrote:
> On Tue, Sep 02, 2025 at 10:40:36AM +0200, Pankaj Raghav (Samsung) wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> split_huge_page_to_list_[to_order](), split_huge_page() and
>> try_folio_split() return 0 on success and error codes on failure.
>>
>> When THP is disabled, these functions return 0 indicating success even
>> though an error code should be returned as it is not possible to split a
>> folio when THP is disabled.
> 
> Other view is that the page is already split therefore nop.
> 
>> Make all these functions return -EINVAL to indicate failure instead of
>> 0.
>>
>> This issue was discovered while experimenting enabling large folios
>> without THP and found that returning 0 in these functions is resulting in
>> undefined behavior in truncate operations. This change fixes the issue.
> 
> Could you elaborate on the undefined behaviour? I don't see it.
> 
> If you argue that this code should not be reachable on !THP config, add
> WARN() there. But I don't see a value.

Little bit of context:

I started investigating what it takes to remove large folio dependency on THP[1][2]

I have some non-upstream changes which enables Large block size (therefore it uses large folios) on
systems with !CONFIG_THP.

I was hitting a weird stale content read error and finally ended up with this fix.

I thought this is a self-contained patch that can already be upstream. My argument is not that this
should not be reachable, but returning -EINVAL will do the right thing instead of returning 0, which
means success.

I hope it clarifies a bit. Let me know what you think.

[1] https://lore.kernel.org/linux-mm/731d8b44-1a45-40bc-a274-8f39a7ae0f7f@lucifer.local/
[2] https://lore.kernel.org/all/aGfNKGBz9lhuK1AF@casper.infradead.org/
--
Pankaj


