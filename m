Return-Path: <linux-kernel+bounces-838402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BD0BAF18D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 06:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D427ACEE9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 04:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879872D7395;
	Wed,  1 Oct 2025 04:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATT1gJdy"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC523C8C5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759293496; cv=none; b=eyAD+d9osmVpxNGD7d+99Jns32HM/gmxmWpoZC8gn19M0Qa9QqrGxP9yRtpD5dYGqNWO1ZLwSOlsKL58swLFw6vm9AZtYQBURKr2aEXKzMNYU2Fgj1lSvt1RUkGLrUQTeFdsv0rELroKoTq1d/lsPkASmMgukhE6HGRIIgkGUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759293496; c=relaxed/simple;
	bh=7HSNOzIY51c4TpYh8yLbct1BvlwpV+qQxyH91bUBfwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLIztJAHkKZHrf6w9X9u/7HcvxREiPsn+eVIvShZw3INUaWDvZldmSPQCRL3Iq0FdIN9TwsDE2KgcFZFUCTkUaRG55qrXtFaTdZxIvg0Ih/NqtUE3CPQj7VUxQ4BIsHZPkI1en3/aQSWY0AfCig1vZqTLeW+Bc91n6auR7Z+m58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATT1gJdy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78127433a32so3463959b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759293495; x=1759898295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=orjiVwk9jVmakZ54G1xSOOUArCKwPbL4DFcsMOqI4MI=;
        b=ATT1gJdyC5kBGn6F10/uj6TQaq9veS6fELn/jLdWLpxqyk476zjXHE/ChewJj35BOH
         exw2GjnhP9afK9Fbkd1/j9AIgntE8MWLPSNxYKsg+TiLHD9+FT1iq6o6myOJguYi9wkv
         o3We+u2LeXffp4wye7PxXcqsEeXSH6TrkmKls23tZp3IEEbxJVEYKx80BZP1h3Mz3l3A
         0kDfM2phNYnAAdmdQ8+RS326LNZA/qbKLpmTkrLTeEoWYmJg1NPZsmu+bW7XP573W9qB
         hOl7NzTL1tGvwx3sMh0hsPhSt0Vws7tkwKTLDMDlc7xhF6PEpYUF/OxzVu5wofmLlnmu
         nbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759293495; x=1759898295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orjiVwk9jVmakZ54G1xSOOUArCKwPbL4DFcsMOqI4MI=;
        b=I42RAk2UrL/D8UfFSvMGblLiIGUX3nOwYtVgULsv5Vq5N/t4iJVOOAD6IDvYbDthYP
         XhKITzom/EeijNWIiUB0QvNo8qtPRod/5JEHhcGUOcDpzAKCPZyJlj53k7DFYzx1SCDs
         z8HYcnOgvhUlspwZ3XPdCQR3rESqDYgYdBYqXU0EFTqXnBDyj2ZAOK08nQIy0QHsE37F
         XrlSTqVFTGdUxvLT13tT32X+sr/I5V1hL6m9WlTUbTrZxl2OtAZNahk4lONo+0xyAeG4
         hykmxeXsVCFIMtjGnPxJMOyE6Lvd5bjKqbWHitxQx5G8t8Wti7Xm7LgQez3cSFHpEtTA
         r/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb5CSOnk2TTqzw3PLa+puL+WO6rnRzjVO6mGSYd4s7viQHiZ1qVuXBfaDtdRsqGhyKwAUyMAWseQ2nako=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/AuWDpCsuQIAn3Ti8NyAlfbhMjNgOKnjcoA60baDdbdjWU+I
	Gd9AVwTx7K/qZeA5AWAx6kRpgpVdUEIMn30cI/Ky0OFdJJU1cSeMdDGB
X-Gm-Gg: ASbGncvTIQ3BTx9cCs+46FxOVSifElj6szF+FlvgH4FruqbY48kYohLQBizp26aGMnn
	JxKWtGn/Q1W6WYHGvlZiM0ZqsdfRfFNzWTvC0AQwnhXdabfCHqgbsb7LgRxKk3hTJED/3B4H9Uk
	mB6TCpPMOiqeQzNA8s0LWD0IOPgAsFfnvB/+Z3EC6FbDrv5kx0SjSJZLjeUJGNCayvpJ2/mJNTk
	5SXFYef1Xd/srUQffxo/0YxXkmynN9AXXhPMejw40bX2cmChANI8+lHSRppQjBLWD7QKffkTPyJ
	8+G7HJZ+KtRLyVk3DVC/0zuOTCFUdoL+KyTsJr+WFkIk9SuD+hLGLUxqxNS+yHjwwy/lkjHMN2M
	cCTkxGrBnUAhD326YXq7iSW4DH39ULhqPnwsp
X-Google-Smtp-Source: AGHT+IFs5bZFDV04o//0C2oYnOx72aMORXDwifOEjRchzNZn3UoLmDmaq+PUE6cX7sUUJbBmPCgC0Q==
X-Received: by 2002:a05:6a00:194b:b0:781:1a9f:aee7 with SMTP id d2e1a72fcca58-78af3fe9a87mr2377050b3a.2.1759293494640;
        Tue, 30 Sep 2025 21:38:14 -0700 (PDT)
Received: from daniel.. ([221.218.137.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-783ad5e99acsm7912871b3a.22.2025.09.30.21.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 21:38:14 -0700 (PDT)
From: jinji zhong <jinji.z.zhong@gmail.com>
To: ziy@nvidia.com
Cc: akpm@linux-foundation.org,
	feng.han@honor.com,
	hannes@cmpxchg.org,
	jackmanb@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	liulu.liu@honor.com,
	mhocko@suse.com,
	surenb@google.com,
	vbabka@suse.cz,
	zhongjinji@honor.com
Subject: Re: [PATCH v0] mm/page_alloc: Cleanup for __del_page_from_free_list()
Date: Wed,  1 Oct 2025 04:38:08 +0000
Message-ID: <20251001043809.11019-1-jinji.z.zhong@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <F1AB428D-73B3-4E40-939C-2A7BAEA1E73A@nvidia.com>
References: <F1AB428D-73B3-4E40-939C-2A7BAEA1E73A@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On 30 Sep 2025, at 9:55, Vlastimil Babka wrote:

> >On 9/25/25 10:50, zhongjinji wrote:
> >> It is unnecessary to set page->private in __del_page_from_free_list().
> >>
> >> If the page is about to be allocated, page->private will be cleared by
> >> post_alloc_hook() before the page is handed out. If the page is expanded
> >> or merged, page->private will be reset by set_buddy_order, and no one
> >> will retrieve the page's buddy_order without the PageBuddy flag being set.
> >> If the page is isolated, it will also reset page->private when it
> >> succeeds.
> >
> >Seems correct.

> This means high order free pages will have head[2N].private set to a non-zero
> value, where head[N*2].private is 1, head[N*(2^2)].private is 2, ...
> head[N*(2^M)].private is M and head[0].private is the actual free page order.
> If such a high order free page is used as high order folio, it should be fine.
> But if user allocates a non-compound high order page and uses split_page()
> to get a list of order-0 pages from this high order page, some pages will
> have non zero private. I wonder if these users are prepared for that.

Having non-empty page->private in tail pages of non-compound high-order
pages is not an issue, as pages from the pcp lists never guarantee their
initial state. If ensuring empty page->private for tail pages is required,
we should handle this in prep_new_page(), similar to the approach taken in
prep_compound_page().

> For example, kernel/events/ring_buffer.c does it. In its comment, it says
> “set its first page's private to this order; !PagePrivate(page) means it's
> just a normal page.”
> (see https://elixir.bootlin.com/linux/v6.17/source/kernel/events/ring_buffer.c#L634)

PagePrivate is a flag in page->flags that indicates page->private is
already in use. While PageBuddy serves a similar purpose, it additionally
signifies that the page is part of the buddy system.

> I wonder if non zero page->private would cause any issue there.

> Maybe split_page() should set all page->private to 0.

> Let me know if I get anything wrong.

> >
> >> Since __del_page_from_free_list() is a hot path in the kernel, it would be
> >> better to remove the unnecessary set_page_private().
> >>
> >> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> >
> >Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> >
> >> ---
> >>  mm/page_alloc.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index d1d037f97c5f..1999eb7e7c14 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -868,7 +868,6 @@ static inline void __del_page_from_free_list(struct page *page, struct zone *zon
> >>
> >>  	list_del(&page->buddy_list);
> >>  	__ClearPageBuddy(page);
> >> -	set_page_private(page, 0);
> >>  	zone->free_area[order].nr_free--;
> >>
> >>  	if (order >= pageblock_order && !is_migrate_isolate(migratetype))


> Best Regards,
> Yan, Zi


