Return-Path: <linux-kernel+bounces-880129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA06C24EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 120734F18C2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B08347FC6;
	Fri, 31 Oct 2025 12:10:17 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E045B3451CF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912616; cv=none; b=enR8G1Hsoq/f/mWEa04+rO6/NVC23fcpWSUtr7CvHK+ccREdWJGw0QgIAJwtbvm2AwIh3S76pgAc11mk9SfZC+sfyYjyTC8ECWY7GglZGNZRnFC2Mak5YLG1bJJQq5n6zA2nTBcBMJnzGFKis/dxG7nP4Y8dQBVuSGFXgQG25Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912616; c=relaxed/simple;
	bh=lkAHTmhNMxqkX+eVSbbiNIZj9cWdHWyf6xYu3kI0alM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VH0McrC5gZ8+ww0vM6uIXtgJr12dAnYHmwOFjmQefGBVfr8yHuNa87HbnkiMsxk7P7NroRREiEymo5S+/FDyLzHNIHk1akgF8xBinnBa3HbizB3Sw8XvxBA6PvbzX++6a1bXgN7Z3mnpxJv0QVpBdXYCBR06Ho8B8VoVDLrW1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-294fc62d7f4so17208525ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761912613; x=1762517413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0WbfK5vwuoBUWDeRvrXFDT7iz9UNmzAdlRjdob6MPo=;
        b=FVoQ2BtOoDz8+/8rPgfMUBA2oWd58bci9NsXIv9cOn7y6p31cwzllA8pSqZQVUi8gZ
         rB4UPQ31bn4JXWPlI6SbR2jKJSFjlqlNHK92ZSyA17CHKt3e3Cj6/Qq7f7yvZgoT2u3c
         yRHv7QLtRRWlsLlMUGRbrx3LvB0tnhlTiVQ/S/+ZJyaF5D8UBKP1W7umzN+vHvqGNlZS
         ID0NYACYbzhKMABKlDKkfIaE2+a0bbUI4ooL9g/D3A8qBsQZXgwyR2qs/qQPpsvY+mVh
         ggB8f2I9KEktAK+CYnHj9aLRHHjUYs6ya2u432ryGn8vl/rLoRVFK2SrrsW/ghg9lM29
         ZQLw==
X-Gm-Message-State: AOJu0YxuNyiVZ8zjUVSt9B89dBx17q50b8fdb8xdKDinB0SS4ZjpyZgF
	dPhiklsU9wxRrY94x+g1uZnOfBkOmFqPT13TTbt3JmqA1xScLKd8r48T
X-Gm-Gg: ASbGnctsuK3RYsNk7pdf+WNns2lpwhttmixDGTBPfaDNqAs1w15rZTW/Mg3ZW5VBJIl
	yPmnvVVxnqc++UQBleHSOSsdxHAQa/teLNlWPyZT4QkDCE4kyFdClDp6M3gfJgysQt8mjwlhDuX
	NTWAYPw5IaxL3Pmrj2yX8jrA6PC7JAhMlh9Xmy+hikPXiRnGxgqzz20oQuzo7jjb3ra+a1LXtov
	qpITN+GcPnFoS0y0oPek23D4skiH9TTmrXVCxAs/j+Igbqffr082ZQXR3cLEFzIaJV9CD+yCbJq
	rsAMDnfb/PyHUWd+lo4GHwoe4+rtmqcZdSotsi2AiDqT83si7er2WMsbD5EMCjqtSwbziUQMnPT
	7x2zjRV6t3h/i/UsPcM8DEhDPWyASd9tuhgPIn91J4EhZdgYGU1tQfqxin/86pFPAnaGK2RioT1
	dQZWZD4ujAowOJxqLIjVrDBih6Ig==
X-Google-Smtp-Source: AGHT+IFkZYYrPO9da+1rqdpxHxQzVGAbYeTTm9iNmfhwPCVX2eqm9vtdFUdqrf7DEDE/y6nY5qWI1A==
X-Received: by 2002:a17:902:8ec9:b0:269:8059:83ab with SMTP id d9443c01a7336-2951a50e59amr30879555ad.51.1761912612853;
        Fri, 31 Oct 2025 05:10:12 -0700 (PDT)
Received: from localhost.localdomain ([124.156.216.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269b95bdsm21683055ad.93.2025.10.31.05.10.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Oct 2025 05:10:12 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	rppt@kernel.org,
	willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	big-sleep-vuln-reports@google.com,
	stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v2 1/1] mm/secretmem: fix use-after-free race in fault handler
Date: Fri, 31 Oct 2025 20:09:55 +0800
Message-ID: <20251031120955.92116-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

When a page fault occurs in a secret memory file created with
`memfd_secret(2)`, the kernel will allocate a new folio for it, mark the
underlying page as not-present in the direct map, and add it to the file
mapping.

If two tasks cause a fault in the same page concurrently, both could end
up allocating a folio and removing the page from the direct map, but only
one would succeed in adding the folio to the file mapping. The task that
failed undoes the effects of its attempt by (a) freeing the folio again
and (b) putting the page back into the direct map. However, by doing
these two operations in this order, the page becomes available to the
allocator again before it is placed back in the direct mapping.

If another task attempts to allocate the page between (a) and (b), and
the kernel tries to access it via the direct map, it would result in a
supervisor not-present page fault.

Fix the ordering to restore the direct map before the folio is freed.

Cc: <stable@vger.kernel.org>
Fixes: 1507f51255c9 ("mm: introduce memfd_secret system call to create "secret" memory areas")
Reported-by: Google Big Sleep <big-sleep-vuln-reports@google.com>
Closes: https://lore.kernel.org/linux-mm/CAEXGt5QeDpiHTu3K9tvjUTPqo+d-=wuCNYPa+6sWKrdQJ-ATdg@mail.gmail.com/
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v1 -> v2:
 - Collect Reviewed-by from Mike and Lorenzo - thanks!
 - Collect Acked-by from David - thanks!
 - Update the changelog as Mike suggested
 - https://lore.kernel.org/linux-mm/aQSIdCpf-2pJLwAF@kernel.org/

 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index c1bd9a4b663d..37f6d1097853 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -82,13 +82,13 @@ static vm_fault_t secretmem_fault(struct vm_fault *vmf)
 		__folio_mark_uptodate(folio);
 		err = filemap_add_folio(mapping, folio, offset, gfp);
 		if (unlikely(err)) {
-			folio_put(folio);
 			/*
 			 * If a split of large page was required, it
 			 * already happened when we marked the page invalid
 			 * which guarantees that this call won't fail
 			 */
 			set_direct_map_default_noflush(folio_page(folio, 0));
+			folio_put(folio);
 			if (err == -EEXIST)
 				goto retry;
 
-- 
2.49.0


