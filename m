Return-Path: <linux-kernel+bounces-861179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C2BF1FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41D5A34CE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D7A234964;
	Mon, 20 Oct 2025 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pqn/fnM0"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B446123E320
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972795; cv=none; b=salppPQRg36zixmDcmRFFAns31o0GwGYPXdHf48Ee0naHe7g3bcKn9u05Phz1y57Rf6gHhskmKKP/yK4ZK3+9DwvMK4I5tPh66VR2ovQkG7+2rGiPA/HwbudFX4Z+S0rIM4iPCCY5QMCr2Nwc3yCDXrpjcmiORv57eZ5YUcE6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972795; c=relaxed/simple;
	bh=FrryWqBbuARohpRluL/ICuSe+pBmE9OhN0+uJdxAJFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaAoV17wGZDsFab0RBDcMpD1Ej2nqLQD6NyQ4kz/x3W87okwRyNIQh5yN0FEOxlBkLlesPIidIRPBwwswwCsV93oDF/WBEvdrUgYLYbqRppwpgS+vA7HKwkr6mG+yd4Ntokn7SIGblpNiK/xZSG2rb0mkIsI/C1ovacxi5vj4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pqn/fnM0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so4080682b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760972793; x=1761577593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEYAPg0/9P8i0AqXf9KQgQ5ijvrv79Y+WAS0UJoYxic=;
        b=Pqn/fnM07J3pKFqJMB4PIPbsyd1mAWOY+G1Swkl7AGC0Gk0GvndxVU/dI8c9swv23Q
         ekLnfxa9NXWDYjtJSNlGgv9cHAh1C+MPU49nR3vO2xhOPX8qavCfpPl78H7Dektpl+w2
         ZGwGaBgbEbqc5ntp4SQArsUev9tUgR2PuMpoj+MJJD5V3OgBbLJKDaTJXnZFTDxRVfol
         eK1BxKh/0pwYVbH2zEJgbi9XTUlurudNYT/xQgqx4KMBVnvGg7nZSx48AU2anVL68RK3
         PHcUX/XjtZZ/AFdBmWemxfO/lWxOJMHZK0IGp9TFO2Ia7T8AOeP8VMk2BWmUwYrSe/CI
         6kZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760972793; x=1761577593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEYAPg0/9P8i0AqXf9KQgQ5ijvrv79Y+WAS0UJoYxic=;
        b=cHSGB9t3Bt2W7yfn7bWnx+YjGyvHE+A6DXWpSPo2DKCywFXZcowmeUDgYMox2QrXZR
         cQcPwRhxWWMWojUqKN1xxy1aA8sPRyTX19pjLw2i+ym7w6cnTSoRd8lSs0EPw2le6WBb
         F84dLIG7qzc2ZvrvzmCrKEJ4OMlnIO+Ilj37Mh9eTXnftYLCd+t4XQAg6B7fKKAsi/Un
         1UHPgbol5PK8BnwJsnWKDXwJu2PHaRsIEEXDqu9t3aO9f1YiM7Ptyd1iFCX6v2R3LWnW
         WeSQ3hkf3r70r582YVHZQfXOno1daeOIvoXp8JKqgXGbsfmyhYaJuIHy7D6eNCbUF5m5
         NGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd5Mbx0+pBo2Ws2Fl3W6Y7VYdiDkyhseRCQAHpT59YI9Rnc7+GSnmoLv21r4LicB3aVHRgIzzQJyTS21Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4Ejxeg+w6KNHlVXQm333FClmMpOW+Rn+D68NGPRouomjY0X+
	2p9V0zsZbQnD9YJABEHtKxvdy0bXvPAIgTQvcOb3vtG1DiLt2tiFUSCeW8XNig==
X-Gm-Gg: ASbGncvixCTLiSUS+2bGaA7HJZWVeLTAlU7Xc6I+oQYfsWtoh5hfv9/CQllPsHXvoZm
	qEh21Myj7p+ZBlr3oRgZEY+ZVIUyVMq+cYmmHykkx0kxdbmZO6yhi6wL6a5TNnjJG38lnMcDThl
	AW4Bu47S411ilQ1NqTm5K/GdOG5Xyzmez41Jtfi15NdrWURqPDJHG5k9y5RYzqnRQHptHVHbVGZ
	lRynwTDqZ6kouNaHhhkf3RPaKHonobTjWVHd02254JXte0mv6F6Peuvy193Ou/BU0UkIwxH0Bco
	QXZCC+nsfx0hVWBAJVn6HlQxpY1ENR2HT2HsZzZXZyqxqTOsjv9iLwm3Ls3IoVpaiajltFv4SAf
	LzXAXd/9Hq18CqL1Xqimg/38myUwA96qExUO2h35vDVcwrq7zgGiQDAR9Yi36QGHB80DcB2tkcD
	QFKRA=
X-Google-Smtp-Source: AGHT+IG4hAvaiT9qMc124aUjhAwGQoPr0u9gLyEZ2Bp4eQLu89aAOxbW8d4Nq6BNuCuodFW2fP8ZXg==
X-Received: by 2002:a05:6a00:2ea1:b0:793:522:b8fb with SMTP id d2e1a72fcca58-7a220aaf9e8mr14700226b3a.25.1760972792539;
        Mon, 20 Oct 2025 08:06:32 -0700 (PDT)
Received: from daniel.. ([221.218.137.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121f96sm8577259b3a.76.2025.10.20.08.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 08:06:32 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: ziy@nvidia.com
Cc: akpm@linux-foundation.org,
	feng.han@honor.com,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	jinji.z.zhong@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liulu.liu@honor.com,
	mhocko@suse.com,
	surenb@google.com,
	vbabka@suse.cz,
	zhongjinji@honor.com
Subject: Re: [PATCH v0] mm/page_alloc: Cleanup for __del_page_from_free_list()
Date: Mon, 20 Oct 2025 15:06:25 +0000
Message-ID: <20251020150626.2296-1-jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <7B0DF4ED-FBB8-48E5-95B7-4C32B645F4A6@nvidia.com>
References: <7B0DF4ED-FBB8-48E5-95B7-4C32B645F4A6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>On 1 Oct 2025, at 0:38, jinji zhong wrote:
>
>>> On 30 Sep 2025, at 9:55, Vlastimil Babka wrote:
>>
>>>> On 9/25/25 10:50, zhongjinji wrote:
>>>>> It is unnecessary to set page->private in __del_page_from_free_list().
>>>>>
>>>>> If the page is about to be allocated, page->private will be cleared by
>>>>> post_alloc_hook() before the page is handed out. If the page is expanded
>>>>> or merged, page->private will be reset by set_buddy_order, and no one
>>>>> will retrieve the page's buddy_order without the PageBuddy flag being set.
>>>>> If the page is isolated, it will also reset page->private when it
>>>>> succeeds.
>>>>
>>>> Seems correct.
>>
>>> This means high order free pages will have head[2N].private set to a non-zero
>>> value, where head[N*2].private is 1, head[N*(2^2)].private is 2, ...
>>> head[N*(2^M)].private is M and head[0].private is the actual free page order.
>>> If such a high order free page is used as high order folio, it should be fine.
>>> But if user allocates a non-compound high order page and uses split_page()
>>> to get a list of order-0 pages from this high order page, some pages will
>>> have non zero private. I wonder if these users are prepared for that.
>>
>> Having non-empty page->private in tail pages of non-compound high-order
>> pages is not an issue, as pages from the pcp lists never guarantee their
>> initial state. If ensuring empty page->private for tail pages is required,
>
>Sure. But is it because all page allocation users return used pages with

Some users [2] do not reset the private back to 0. When the page is a tail
page, the non-zero private value will persist until the page is split.

>->private set back to 0? And can all page allocation users handle non-zero
>->private? Otherwise, it can cause subtle bugs.

Yes, you are right. Some users(like swapfile [1]) cannot handle non-zero private.

>> we should handle this in prep_new_page(), similar to the approach taken in
>> prep_compound_page().
>>
>>> For example, kernel/events/ring_buffer.c does it. In its comment, it says
>>> “set its first page's private to this order; !PagePrivate(page) means it's
>>> just a normal page.”
>>> (see https://elixir.bootlin.com/linux/v6.17/source/kernel/events/ring_buffer.c#L634)
>>
>> PagePrivate is a flag in page->flags that indicates page->private is
>> already in use. While PageBuddy serves a similar purpose, it additionally
>> signifies that the page is part of the buddy system.
>
>OK. You mean ->private will never be used if PagePrivate is not set
>in ring buffer code?

In the ring buffer code, it only uses the private field of the head page,
but I recently found that the swapfile [1] is assuming page->private is zero,
even if the page is a tail page, which seems a bit dangerous. Adding this
patch will make this situation worse.

link: https://elixir.bootlin.com/linux/v6.17/source/mm/swapfile.c#L3745 [1]
link: https://elixir.bootlin.com/linux/v6.17/source/mm/swapfile.c#L3887 [2]

>If you are confident about it is OK to make some pages’ ->private not being
>zero at allocation, I am not going to block the patch.
>
>>
>>> I wonder if non zero page->private would cause any issue there.
>>
>>> Maybe split_page() should set all page->private to 0.
>>
>>> Let me know if I get anything wrong.
>>
>>>>
>>>>> Since __del_page_from_free_list() is a hot path in the kernel, it would be
>>>>> better to remove the unnecessary set_page_private().
>>>>>
>>>>> Signed-off-by: zhongjinji <zhongjinji@honor.com>
>>>>
>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>>
>>>>> ---
>>>>>  mm/page_alloc.c | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index d1d037f97c5f..1999eb7e7c14 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -868,7 +868,6 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
>>>>>
>>>>>  	list_del(&page->buddy_list);
>>>>>  	__ClearPageBuddy(page);
>>>>> -	set_page_private(page, 0);
>>>>>  	zone->free_area[order].nr_free--;
>>>>>
>>>>>  	if (order >= pageblock_order && !is_migrate_isolate(migratetype))
>>
>>
>>> Best Regards,
>>> Yan, Zi
>
>
>Best Regards,
>Yan, Zi

