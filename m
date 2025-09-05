Return-Path: <linux-kernel+bounces-803067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE7B45A21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 16:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A1F5667DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C42B36808F;
	Fri,  5 Sep 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYY+zzMo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6917597
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757081504; cv=none; b=O4q9JxoZsXFLaYr5xN6uzrtATjQn2JnjCMvM65P59fPcyFcbg/EVouTOCHUJ4N2OiW4YDsbr1fxQ60/GbesqXAu4FZKRYDiOp7TtDzKNnoY2WZpW71GN/KPbeg3PXQEY1qq1RULvS58GJhI+NlWF+jb0WFMbQKgsA7uhl0r+gXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757081504; c=relaxed/simple;
	bh=qzRL6nIjbjmGDjrS4kIcDQkqTGTlvYWK4YBKHtPWoaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sy1OsTmECMrshSXxTRXoS7aw004kW4G5JaQmXBLLYLm5D7d/xY3JJqng4RrYwic96LLBSvVkVS1bTqYB/Z6L5Nzkzj2CR/oj4h00Wi+hsSQvcn8L5tBcXeB4jJ2f2xmb1Hn0J73ZTBSJsPcTLhqVauQZkeEYUUdxeY0EFT9AXBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYY+zzMo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757081502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GgsRFe2do3K+Eon4rEy4MOebN7y4W7Y0WG9L41KSk7Q=;
	b=bYY+zzMoFXMu043wECyYhvLu2MHdhcdgEJQ9S//wbQGqKxpU/x4kD5N0Jkk8i+5QiA4p4+
	fzhX4Z+rXRVXo7/KCqp1EL7Lt2zDWttDQAkov+qYwTFc/dVDDk4Ez6Li/rqMP0gR2WXRX7
	Kk6hPjZT1KizD+8nvYI464UuCO0jTV8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-iSG5nlMUOSCAPQrj2DK9sQ-1; Fri, 05 Sep 2025 10:11:41 -0400
X-MC-Unique: iSG5nlMUOSCAPQrj2DK9sQ-1
X-Mimecast-MFC-AGG-ID: iSG5nlMUOSCAPQrj2DK9sQ_1757081500
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e40057d90aso320586f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 07:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757081500; x=1757686300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgsRFe2do3K+Eon4rEy4MOebN7y4W7Y0WG9L41KSk7Q=;
        b=u9qPtIUOyWnClxuHemtMMGD6wSjrOubaqEXzkAgAme0wNMKxrGQxn1xhNwsjByPvUu
         FvYOtqbI3pcrNiCX75OaVGCCSTHVF1F+0MF5ZYgAW0oxjVcy/K+41YUQYIrRYs6DYOpA
         DPjscYfS5f/WDfx+LzhqVEHQmwWuM6zchU4wvBDtNR1ZTRMN7w8EFDWIum2GPgcSWWjg
         EruOGKq1qjxUf+X+fiJX2/4EOHelFDXyLYcdllp9IjcXSM0TTFU0xqr7f4onUPmzmhLp
         dm3konb7BHhuX3x9rmveOsE59yw7LAqk5dP0HE31K9q+YlpoUM4p5naQlyOPeiZmI6ts
         7i0g==
X-Gm-Message-State: AOJu0Yx/7UvNOfwUMo8Frv4CuvPWaa8ttoOQV9bfl8QKOihltEt9wu5T
	S7M+ff+YXW58+lRUB8RNANdLeBNE0wyTTmfzVd0weSY7mvXw8PMJ4Mk5MH59cAIROaMN0LsOXaw
	xt2UVaStdEIuxuLCq/hRjP17nbumnWgs7WJl4C96EUmGHBdKwNbZ14DVduYVhpWjA7X9rDTSY4b
	h7kw13BqtyAzokDJB2eWKsBO1xR4aWw5VwyFVPNaciZkitPA==
X-Gm-Gg: ASbGncupaieY7gVZEYkk1bai0IE599z/sz3CGIQ54P447azKgpJCyvAiDcFijU9oazV
	SQ5eF/W5/cBLuRctTdrrjm4mTwWynxF7w5boDrnMMqcqLoFqr+K+N3aEt52edT7ee6S67vMCxIt
	zuPYI7ZdRaJc+RQ7iVdcaW8R0gUj7WWc8THQknSH0D4TxscuEHPt2m4FFeibeMQlh+ZWTlz3KEa
	AC/gzoBs/2giF1sA6/qtm3V5ut32VeTNi13yuehYkjCcxY4/BLPhfsfLl1wHUA27lyzwUxiuwFu
	+KqmJoOmjjRn6FfDyhd1uMi+1TBopA5u2HHFZoWsKOF/oVkadTqfsirWKkNGjXWyCvFbArTtevj
	CWlLOvoo6albTawbT6VU=
X-Received: by 2002:a05:6000:26cf:b0:3da:e7d7:f1eb with SMTP id ffacd0b85a97d-3dae7d7f7a8mr11388560f8f.22.1757081499612;
        Fri, 05 Sep 2025 07:11:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbS3uPY4JafB96Ovf66PFgi6ZGs7+8QsZrgTjUwGTDYPGb2ZrMAPKBqZ7pui9VY1zMR2lTfg==
X-Received: by 2002:a05:6000:26cf:b0:3da:e7d7:f1eb with SMTP id ffacd0b85a97d-3dae7d7f7a8mr11388511f8f.22.1757081499075;
        Fri, 05 Sep 2025 07:11:39 -0700 (PDT)
Received: from localhost (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3deb99d10a0sm10156163f8f.37.2025.09.05.07.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 07:11:38 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v1] mm/huge_memory: fix shrinking of all-zero THPs with max_ptes_none default
Date: Fri,  5 Sep 2025 16:11:37 +0200
Message-ID: <20250905141137.3529867-1-david@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We added an early exit in thp_underused(), probably to avoid scanning
pages when there is no chance for success.

However, assume we have max_ptes_none = 511 (default).

Nothing should stop us from freeing all pages part of a THP that
is completely zero (512) and khugepaged will for sure not try to
instantiate a THP in that case (512 shared zeropages).

This can just trivially happen if someone writes a single 0 byte into a
PMD area, or of course, when data ends up being zero later.

So let's remove that early exit.

Do we want to CC stable? Hm, not sure. Probably not urgent.

Note that, as default, the THP shrinker is active
(/sys/kernel/mm/transparent_hugepage/shrink_underused = 1), and all
THPs are added to the deferred split lists. However, with the
max_ptes_none default we would never scan them. We would not do that. If
that's not desirable, we should just disable the shrinker as default,
also not adding all THPs to the deferred split lists.

Easy to reproduce:

1) Allocate some THPs filled with 0s

<prog.c>
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/mman.h>

 const size_t size = 1024*1024*1024;

 int main(void)
 {
         size_t offs;
         char *area;

         area = mmap(0, size, PROT_READ | PROT_WRITE,
                     MAP_ANON | MAP_PRIVATE, -1, 0);
         if (area == MAP_FAILED) {
                 printf("mmap failed\n");
                 exit(-1);
         }
         madvise(area, size, MADV_HUGEPAGE);

         for (offs = 0; offs < size; offs += getpagesize())
                 area[offs] = 0;
         pause();
 }
<\prog.c>

2) Trigger the shrinker

E.g., memory pressure through memhog

3) Observe that THPs are not getting reclaimed

$ cat /proc/`pgrep prog`/smaps_rollup

Would list ~1GiB of AnonHugePages. With this fix, they would get
reclaimed as expected.

Fixes: dafff3f4c850 ("mm: split underused THPs")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 26cedfcd74189..aa3ed7a86435b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4110,9 +4110,6 @@ static bool thp_underused(struct folio *folio)
 	void *kaddr;
 	int i;
 
-	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
-		return false;
-
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
 		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
-- 
2.50.1


