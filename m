Return-Path: <linux-kernel+bounces-733081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C0B06FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1FA4A4646
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502D3293C7D;
	Wed, 16 Jul 2025 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Asrs9Gu8"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B63293B4F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653325; cv=none; b=mmNURo2g79pPoDYBl10whorzA+3CPxmKcFdQTYoMvUN5GaNwar/+ELHz44vvnAgTUQOiOjcXFBhW04BRZX8zZ7W1j2pXW8y6+DSyQFAZgXuucQZwp2UZwC3DkUAYgiAJMoMHsF9imTKusTJUCy1dEXMONLQ+gooQn1S9KkiVbp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653325; c=relaxed/simple;
	bh=lZsQ2gwN9ljVhxoz/SiSUPOcc+N1zJEFyhh6g8FaG34=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=em0L3aPEob2mgPCvRaq7JgFR8L+Y0UpVuMNvzMGOPDCPJGLsBW5ZD/oqKCbF7IHYgkgUIY191YXPgFgBZAYo9UNhkOpa0rnbnzB7FGnbupm9+Hhm+ntQqzLXjxEWltZXaGqiv9PLXnVVYlzN6hiQarrSVdMh0NwLKZRYLBpHK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Asrs9Gu8; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-710bbd7a9e2so58410907b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752653323; x=1753258123; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=08CqE3Ik5fBs0g6B74PTfgkS88D8qEGFKgqTypvcbss=;
        b=Asrs9Gu8YGBEpPgHb7uC/+ulX+RpSUVMOdm59GjSsct18Sl/hcmMQ8yEMdUqnAtz0a
         DLYzINAcCve940SCJ33d+2eCiJpuvuozCg4VLepxuJH/Kg+2Ljrm5u/G8D+Cmi8S+fcO
         awTRMvH3lOqPXd3lgACTLVsH4YaSaZCOntA8V2PpWpeFjyAWaZ1YxtAP1cBjOpS0/8Am
         X56XXpFdd9lIr/9THjevDvCFYwC4BrYLA+J7JeHLMloWDMVttrLxdi1qcnvuzE/R07wO
         Je9PXaZGmvUSz6iJWdKbwZ8PUOBhcOFY5XYTpCcosID4NhZkHmiS1x7JcEyMsu99ZdPm
         IMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752653323; x=1753258123;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08CqE3Ik5fBs0g6B74PTfgkS88D8qEGFKgqTypvcbss=;
        b=hrGT7YhJ7B5s1rdiW6byV05vnNmYWJQTm2gaW6QK6/orw1o9QTIiCswMGpAN7HyeMd
         76ogO/s2h1s5uKEv81TxaawNKn5qpRhOFt2jU6Ot2UaqrnXCUO5WrJgbBBpe40Z/plTI
         A2yhDC0xQWJuauQACCMNf1xy+Ugxn0h940LlfuvH2ZuRkziwoaswxlGeEv87+zfwPgaq
         mcrvPXG1jmjAvZGBiqU5Gxm1GZ0TP/j5lPmOTsGJFOpMovIPbNOpC8W172/Rd0zbYXT4
         yfAEfHgi+bH72s3KtOddet4VBQugO8XmxPLrji8/x284MCLSiT8nyfvOrrm2aQJLH2GH
         I6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV005Mi4oyxYwbrVICbnkQJHA9lsJIMjMRAS6PYu3WgdMukWZhUfDjaXRBmWVYalrKLLqOONRtX1/aBac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQsILR1n7Umdv664QQEcdBSWX66DrYILWlKqTHE+WA5rHWqS6w
	2KMvO4Ea9loLPSWcKF9oC1kxFhax+/n9xcQGywltxB59i93b9zVtywjZcxz37TMaPA==
X-Gm-Gg: ASbGnctv9zKoEwh2Iaff6PcQ5EF50pJjpCtCsLn2q1rspyreUk9DyIgxA7G6Mc0aO3H
	BiXFsasPJRo9TcbHxg8Vfyr01fPYGEc3s+OqCqqrClEGscN9DirTdsN55O4KJFJ4slldJh2wRg/
	3dh3CALnYYUxvt2hZwcyGtb9AUIw1FWkuW416JxFYv2Is6kzPMBWYHh6KXc3UCrLbxhXw1afTPr
	Z8LOSp5/vuDVcyjF4uduygZmnEHHrHaJlGmISJarp8jHjULoZAL2J7Ikc1/YLz5ZVnwMk4Xkm8u
	klhV4QoH5ELuwX7+1CnMqPBDsTv1seSeK320o9F3IF5zpxLrTZGRBe4Ql7vgQ1v4riJAmcTynxy
	jFZgdpnRyMSBv/Lo3mXadkWfOi/osm9ihTNtemOgCUqoTwqFC2L8nzLmu1FLQsAHm0XfMy7LapG
	kuwDKAp5G+j5qXUtDg/Q==
X-Google-Smtp-Source: AGHT+IFrBQ99BZuCwDDY6J95Zyz4vVJH0mAF19xa9tibQ7EDIJE4wXhxD/UGS/MpcQxmcLsGKLZDOw==
X-Received: by 2002:a05:690c:9b10:b0:70f:8884:a5fc with SMTP id 00721157ae682-718370ee6e1mr19390797b3.4.1752653322748;
        Wed, 16 Jul 2025 01:08:42 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d74e9bsm27995757b3.47.2025.07.16.01.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:08:41 -0700 (PDT)
Date: Wed, 16 Jul 2025 01:08:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
    Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, 
    David Rientjes <rientjes@google.com>, Kairui Song <ryncsn@gmail.com>, 
    Kemeng Shi <shikemeng@huaweicloud.com>, 
    Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH mm-new 2/2] mm/shmem: writeout free swap if swap_writeout()
 reactivates
In-Reply-To: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
Message-ID: <5c911f7a-af7a-5029-1dd4-2e00b66d565c@google.com>
References: <87beaec6-a3b0-ce7a-c892-1e1e5bd57aa3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

If swap_writeout() returns AOP_WRITEPAGE_ACTIVATE (for example, because
zswap cannot compress and memcg disables writeback), there is no virtue
in keeping that folio in swap cache and holding the swap allocation:
shmem_writeout() switch it back to shmem page cache before returning.

Folio lock is held, and folio->memcg_data remains set throughout, so
there is no need to get into any memcg or memsw charge complications:
swap_free_nr() and delete_from_swap_cache() do as much as is needed (but
beware the race with shmem_free_swap() when inode truncated or evicted).

Doing the same for an anonymous folio is harder, since it will usually
have been unmapped, with references to the swap left in the page tables.
Adding a function to remap the folio would be fun, but not worthwhile
unless it has other uses, or an urgent bug with anon is demonstrated.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 33675361031b..5a7ce4c8bad6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1655,6 +1655,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 
 	if (!folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN)) {
 		bool first_swapped = shmem_recalc_inode(inode, 0, nr_pages);
+		int error;
 
 		/*
 		 * Add inode to shmem_unuse()'s list of swapped-out inodes,
@@ -1675,7 +1676,37 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(folio->swap));
 
 		BUG_ON(folio_mapped(folio));
-		return swap_writeout(folio, plug);
+		error = swap_writeout(folio, plug);
+		if (error != AOP_WRITEPAGE_ACTIVATE) {
+			/* folio has been unlocked */
+			return error;
+		}
+
+		/*
+		 * The intention here is to avoid holding on to the swap when
+		 * zswap was unable to compress and unable to writeback; but
+		 * it will be appropriate if other reactivate cases are added.
+		 */
+		error = shmem_add_to_page_cache(folio, mapping, index,
+				swp_to_radix_entry(folio->swap),
+				__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
+		/* Swap entry might be erased by racing shmem_free_swap() */
+		if (!error) {
+			spin_lock(&info->lock);
+			info->swapped -= nr_pages;
+			spin_unlock(&info->lock);
+			swap_free_nr(folio->swap, nr_pages);
+		}
+
+		/*
+		 * The delete_from_swap_cache() below could be left for
+		 * shrink_folio_list()'s folio_free_swap() to dispose of;
+		 * but I'm a little nervous about letting this folio out of
+		 * shmem_writeout() in a hybrid half-tmpfs-half-swap state
+		 * e.g. folio_mapping(folio) might give an unexpected answer.
+		 */
+		delete_from_swap_cache(folio);
+		goto redirty;
 	}
 	if (nr_pages > 1)
 		goto try_split;
-- 
2.43.0

