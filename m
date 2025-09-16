Return-Path: <linux-kernel+bounces-818094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41695B58C96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D51C320EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDCF2BE051;
	Tue, 16 Sep 2025 04:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlPvhbxU"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145729BDAA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757995223; cv=none; b=HqZaGooWJ2ROFMp8B/HDoxwrrAS6cm3OJdUZoE02ZvM6CL6qouY1nNBSrEl7Rsx4zgc3H5/R+HzhjFiZbJ8/4OAnybDA8LvWZZmb4EsFBMYBBxxPTUYGsiGO5Ntpb4FaG0bb6FnBX+OkKO2JiLc7SdZvPNPea0cvgzIVlPeRgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757995223; c=relaxed/simple;
	bh=iWrhlgWuA7TGtP0B0fKF91NDmS+ZlRTZlzLTTy8VKRI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fktAuogsPl7/JlQKhhGmn+8/0MlZW8TRzbsfUHQfYKAsNBg0YNU8gq76EsFU+ttIfBy9taPvhwWSvUYdT1TxFaCYPVYqza19hSVvC0s8jcNmugEVrl+5TMbPpfH4R4QLQ/o6PAN8BsZs3Kb9r9ViYJthT7Ynz+5S7GqRJ3aBoqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlPvhbxU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b54b55c6eabso2912018a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757995219; x=1758600019; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNJEtVfq2GcQ0AyVudDE40VF7bLdO7axK4ZeL2S3GZw=;
        b=hlPvhbxUT2vo2b71h9i1GhPN40FDzRz8Glrl9q2haHdA6Vl6qTwZ4FKRVRq3n5K9xd
         j5DSkJW8l8nsXsKE8/TjriAYZ0YHh2bplotdBJmQKYq+SIWd0CmKnYrtzcXcR7FVD8dC
         TALPtVMw40CEFHmtj/MESSxlFruhyyQh9KdunpXgYcuprySKesyiciNkUZnZx3PvruPo
         XXSg3TZmEcXMw+tDLqzBnagA/UexybYkJ4bRlFXASWyNtNnYZGr8x3YlpuvDvdBReyGw
         ZGsMRjV7UxXOUlNzr9RdHGCpVVtSDVgmfOVEmKszJUi6s9QaLEyZrhFYTCcscOD7yzxS
         jY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757995219; x=1758600019;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNJEtVfq2GcQ0AyVudDE40VF7bLdO7axK4ZeL2S3GZw=;
        b=xMQuX3/cHm+JVXD+xDY3asG7bIam6R4TA5oKly2e9Dmx5LnQMRxmJEwYXBz4EZDQZv
         /lJcNRHZP306XqqmJFLxa3sPpGMCCBoLA4DgIf3dwsn1nuBuvC96eEqZM62H3/Kjh6VK
         XSGgkAP81cFNb0QXrxKbJpIlTx++usjZnDWVaUjJEYDa1jUmkzU/HnyUj+JYGZyfZLjN
         L0yRTF7md/Rvq6/EgJN/NZnvbWPmz+KV/LvDFn5tCtD+8vCQafR3mAAWvy6AO5acTrGH
         stkQy0yg7KeYEd3pmpJg4nfFApOdbtVrj7otciIQrDAvIg1vUFnnSWvc7OWJRISwVmWt
         Gp3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqVcDytmXimArxwm30FJA5gFQ58BcW4OQfei9CNvid1ixbesV/LD8TRtGDWmAWcHcGGT72FV5b3hw8eSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3NPFUFU3EUZuK5f6h5KN/l0bZ+CeWUh0u1hNOtU8IGFKQNDL8
	XYO3+GH0eC9Dekgqy/z0e9onYTFvz8HuK0XVXYnWoLrd39ovqUodjbUmYC9T/34/HA==
X-Gm-Gg: ASbGncvGOANd8XnfTRWGpySY8VwaIgsiKzs/fmfAhOonfkGtPssFT5KA4Jbg9081eSb
	yU5hM1H/BudCbBkfIO7pWPr6i0rj1MY6RtCKhwF4yLoC++g2WAVuSjc1zrzmpWt72sJavohdgA9
	aF3N5bfeIV/nuWoJR/YURh7W5V+V0oh0Qz+xZfVEPp4zXxOsb1vg7haLi5mcA8yzyD+ZqCX9b1q
	aMFGmgOD7/G+QEGv+BPOUETTWAn12nnSUGg0MRJlHrj963zOaH76uEhC/nTQLi8JwjWdX0pV004
	5Vs9CB9Dh7lPc8/Xea981fteqzdnqIyPqKrwdKTnmcXCG44VYtEt7afpmqTeuwQEm+LUFo0yLjF
	MYlGfztfbv3hHETq0+icgOADAhXwOdX7acAgn85m6Q/FQf95O7Nvz3TDxCsrNtUFIXIodPn7KJP
	KaFLndqLUHn0yKC5MeY74VlCY0
X-Google-Smtp-Source: AGHT+IG53T40RNUouBo3s/mXkbMb2lD7TO6r4nQUvRGb2r6am8D5LXotHvJ3Vh5+L4tCmKOg3d7KJg==
X-Received: by 2002:a17:903:234f:b0:24c:8984:5f9c with SMTP id d9443c01a7336-25d26470152mr168660115ad.36.1757995218820;
        Mon, 15 Sep 2025 21:00:18 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2631e29e60fsm71657895ad.137.2025.09.15.21.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:00:16 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:00:07 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
cc: Shakeel Butt <shakeel.butt@linux.dev>, akpm@linux-foundation.org, 
    hannes@cmpxchg.org, david@redhat.com, mhocko@kernel.org, 
    zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com, hughd@google.com, 
    willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: vmscan: remove folio_test_private() check in
 pageout()
In-Reply-To: <02798d6c-1ad3-4109-be3a-e09feb5e4eda@linux.alibaba.com>
Message-ID: <9b01a2cc-7cdb-e008-f5bc-ff9aa313621a@google.com>
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com> <b8c0fe71982aa1cafafd59d8e71064efaac16007.1757648598.git.baolin.wang@linux.alibaba.com> <qe56xt2natnxnkht7wgknsb5nqjhinaaajomvvvgnfpwry2jih@hsj2w5zqj6wv>
 <02798d6c-1ad3-4109-be3a-e09feb5e4eda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 13 Sep 2025, Baolin Wang wrote:
> On 2025/9/13 00:13, Shakeel Butt wrote:
> > On Fri, Sep 12, 2025 at 11:45:07AM +0800, Baolin Wang wrote:
> >> Currently, we no longer attempt to write back filesystem folios in
> >> pageout(),
> >> and only tmpfs/shmem folios and anonymous swapcache folios can be written
> >> back.
> >> Moreover, tmpfs/shmem and swapcache folios do not use the PG_private flag,
> >> which means no fs-private private data is used. Therefore, we can remove
> >> the
> >> redundant folio_test_private() checks and related buffer_head release
> >> logic.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> ---
> >>   mm/vmscan.c | 16 +---------------
> >>   1 file changed, 1 insertion(+), 15 deletions(-)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index f1fc36729ddd..8056fccb9cc4 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -697,22 +697,8 @@ static pageout_t pageout(struct folio *folio, struct
> >> address_space *mapping,
> >>     * swap_backing_dev_info is bust: it doesn't reflect the
> >>     * congestion state of the swapdevs.  Easy to fix, if needed.
> >>     */
> >> -	if (!is_page_cache_freeable(folio))
> >> +	if (!is_page_cache_freeable(folio) || !mapping)
> >>   		return PAGE_KEEP;
> >> -	if (!mapping) {
> >> -		/*
> >> -		 * Some data journaling orphaned folios can have
> >> -		 * folio->mapping == NULL while being dirty with clean
> >> buffers.
> >> -		 */
> > 
> > Can this case not happen anymore and try_to_free_buffers is not needed?
> 
> For dirty file folios, pageout() will return PAGE_KEEP and put them back on
> the LRU list. So even if mapping = NULL, background workers for writeback will
> continue to handle them, rather than in shrink_folio_list().

You've persuaded everyone else, but I'm still not convinced:
what are those "background workers for writeback",
that manage to work on orphaned folios with NULL mapping?

I think *this* is the place which deals with that case, and you're
now proposing to remove it (and returning PAGE_KEEP not PAGE_CLEAN,
so it misses the filemap_release_folio() below the switch(pageout())).

There's even a comment over in migrate_folio_unmap():
"Everywhere else except page reclaim, the page is invisible to the vm".

And your argument that the code *afterwards* rejects everything but
shmem or anon, and neither of those would have folio_test_private(),
certainly did not convince me.

Please persuade me.  But I've no evidence that this case does or does
not still arise; and agree that there must be cleaner ways of doing it.

Hugh

> >> -		if (folio_test_private(folio)) {
> >> -			if (try_to_free_buffers(folio)) {
> >> -				folio_clear_dirty(folio);
> >> -				pr_info("%s: orphaned folio\n", __func__);
> >> -				return PAGE_CLEAN;
> >> -			}
> >> -		}
> >> -		return PAGE_KEEP;
> >> -	}
> >>   
> >>    if (!shmem_mapping(mapping) && !folio_test_anon(folio))
> >>   		return PAGE_ACTIVATE;
> >> -- 
> >> 2.43.7

