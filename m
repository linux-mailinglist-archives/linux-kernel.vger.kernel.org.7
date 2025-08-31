Return-Path: <linux-kernel+bounces-793286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3729FB3D18C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA8217E6DD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BCB24DCE9;
	Sun, 31 Aug 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0BZ/KLu"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4211A7D07D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631642; cv=none; b=qeefcPx0GEU8hRu0TPvAJUzMl7CAYkrgHBgMPztuoDvvYPPq76DCv0X8arlU85tJECqQ3R/IlHYN0drQh2Yh+iUBBcEi2iXJ1tKZhNtxSSMa/BFWUVe0daigLqy6rUpgCpym0V2JG/DcUu2CcTyzJc1rJD5+wtLnm6mqKB6Frqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631642; c=relaxed/simple;
	bh=jlQej32j0n7qXEnY5V9OT4gzWzDjJMbxjwZlVZev3a4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HavnmVDLxSRGwlSsQFzBK8c722dkpUO+Nmo2qD4VDRPCFpr6+cJwJqBxtqDPIlltUVr98Cxc5qOxMUUZfApqIztkiwMtuxA573PuWFFENGah+/VQuYdv72f8j69vcFV11jNO7JJB8qiVWHl1U+VlDY9UmAo/Cj3flJ5H7pNkYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0BZ/KLu; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-72290cfcf5eso769777b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756631640; x=1757236440; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBznXUHFnxO7JFFRA+cSHz8XvSsYLiyW87D5PciK1Do=;
        b=X0BZ/KLuLmmiKWiPrD/+fqJFrsCeGdwUqFj3PlSxxJR+8GKczAgkcW2FLkbVhJGfHf
         35Sz5yya5i7x7y34b/+dU3HCEq8+w5n6pxpZlTcGac6kbkgLF81oVYx7eUIZIwOEUrZZ
         vYNrlbF4M/zOutuF1PCFOiMgMYBqqaRzDMLdjFS23QutDNOJh2RDqAvWDltdmb3Ey0Sx
         g9V+iQgH2E3/VnnRFdTo6DSV5MNRfZrqrFd9njPWUQFcqgbXTRjtISksmGQ0Feilu5rC
         xa0xpInBNPvV7JSpmIsL1tLt3Xs5twyLTgIW9NYkikoPRHUFSYatlx+/M0yxxqkrbHaR
         ASIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756631640; x=1757236440;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBznXUHFnxO7JFFRA+cSHz8XvSsYLiyW87D5PciK1Do=;
        b=JZEtYlpxhHMj+MDHn3L34IfZkSUtfGeshroL4Um063Rj1GY4Sau+Q5jz2iCtkqk4GO
         8dLeJcllt+FDzSQaRhmdnWv8UgqlFOgmRMSbuqlRsrfLdk8lix42ZFF7QpMsXADcPWvW
         tyqYFbkveYmdJr5A0UphDRPOV/IycjXFAUhBYjuaJPrEAhr3zPMOI/ZmhGVAmXJjeQqI
         vAzjb8dZLi53+PK79XtJsz7Q+SY964fhSDQEBiRiiD0iR4wUd4S9T5WG8YIKXlziUV9U
         Cjz9H86B2SS7L3Q+vrsFTwejaNZL7Pvs+Vv0oY2952nJj9llrv4+IIEyWznimI+PNyZD
         meqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHrxKXHwBmk5W3nzUVwaq9YIv/xM+DS+m4NCf6UVsTna95bvsy3Pka/6oe0gstMT8dOHh7mZMBcaXiasE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqfk83jIGTEyZ/3lLFfVsgiFbRME83HBMT97aS4Asn6TsncE3Q
	KE4AzQUGbcTnMCJuDwPZfs3jkrRosbFIgHsOZiqrksKxJ4ZGOI7kYulsO2zkDfUbsA==
X-Gm-Gg: ASbGncsU52qBa+YJSF5yIghSb9JTC3OvuJNuVCSlO+0P9zzCswJBehhvHh+NGLZSaMA
	2vViQlElT3CNpnQ7K6IPmHStgB+XEoBaqHAkScM9J8x/3zbpzmNuVzYewD13mHgv5HbwA26DPMt
	oAoccDHfQ6hCt/UIfDUIC1Uc4yIMKY2HtvGqbVaNT6Vyl4xka/MWZiZTCfr2Ozu174A3L9mK97Q
	niS0JMl5UuloRYIT+IIahHm3MB3j5cyrxezAWk3mh5dXD3WMKwuKN8ktKui2vwS40SzJZconn9p
	oURiFQUaDf+xHfcwgCrbZL0IkBLNGYk0TkZlNMPj0Owq3pU5NMuycvkddeXvb12YMrfKV01PTGU
	0DLy1JlZgTmBGdI0zfgQ2bMmJ4lg4TA4Zb2SwdRx1ONoNurK8O61w6v67q26Ln3uaUju1uyUOyY
	2VYgt7n4CHH7MONi36NN3fIkeemdvbB40e4KQ=
X-Google-Smtp-Source: AGHT+IF4yPQEPLuQmGbE0pb+TIdmkIJQyKnxChThhXPpgreHU7hHADg7CNY3Cer/6aWfeZDp+UC4KA==
X-Received: by 2002:a05:690c:6908:b0:721:369e:44d8 with SMTP id 00721157ae682-7227657dc4emr49185577b3.51.1756631639950;
        Sun, 31 Aug 2025 02:13:59 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7227d67377esm7100867b3.33.2025.08.31.02.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:13:58 -0700 (PDT)
Date: Sun, 31 Aug 2025 02:13:55 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>, 
    Shivank Garg <shivankg@amd.com>, Matthew Wilcox <willy@infradead.org>, 
    Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH 5/7] mm: Revert "mm: vmscan.c: fix OOM on swap stress test"
In-Reply-To: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Message-ID: <bd440614-3d2c-31d6-1b8f-9635c69cef7c@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

This reverts commit 0885ef4705607936fc36a38fd74356e1c465b023: that
was a fix to the reverted 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a48aec8bfd92..674999999cd0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4507,7 +4507,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* ineligible */
-	if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
+	if (zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
-- 
2.51.0


