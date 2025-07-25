Return-Path: <linux-kernel+bounces-745770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8ACB11E50
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44BD1CE3A13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34867246BD3;
	Fri, 25 Jul 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yiKrQ5XO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BAA246BAF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445800; cv=none; b=AZdz9r23zi0t+JYte3SgWoOVqFcZVBM1OwfbyJB1NbeqwcLuIdkKiDyvg53S8Jf8WUBT9+3N3+hbNap8Z7H6Jx0+sT549PngrL0j84Qci+DRmfkmuX6CG1IYRq/sz1PYGD735LM+wDyluMRUD2hDZG8CTE5BeONPK9nP25cxFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445800; c=relaxed/simple;
	bh=RPodm9Ldenuy/H5haDTN8fCr5D6oW2GFg9ixFEFNSgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ORZ9H2uKyg0ZDKGKSGfcwa6jawdrs9hTc+Zt7LyVg5wX+1wna9nbbihlw/xTtAm4x7im3T2AKL8H2aUkjFuZ7RXP7hUhXMCZ9/RCJc9XN06LSZjvmLFOd5XV2RvDG7ddgx/B0DtAgIC5fiZMa+f2eM4fJTthpBUxD3NizJCeTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yiKrQ5XO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4561b43de62so79855e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753445796; x=1754050596; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v8A06zzov4fRzg2AP/VvqP9aaecoBJtmC4l+aze+HnM=;
        b=yiKrQ5XODZA3GZ6OFdM1DZFowEprQrn4bjxUsiLPhd2/Qu6PjWpynA6z4qf9ix2MFv
         EdaWSZ+CdSXdBFkA++pYKtBuVLfPtGCcar+SbkBR2GGKVk2iC2aeuOc12Tb51yGQQ8N7
         tzSgQMf9Oxi/BJziuxWsxOsdKbEGrl6vgtwGYqRK+n3c1cISIfPPk5pmtgc8B/fCjI0H
         gyX/A4dQ244y192KA5ClBuUxnwPGTj7dTa6N1TisCBidPlvKXI0hP0F6qN2oYKZoeju7
         nBCefnHoDwAhZwSAjW5b0v0r3VNflTbwl7zrtt7y7E7LTsX0tY4HnXItHJDeZm2Um7LX
         bVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753445796; x=1754050596;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8A06zzov4fRzg2AP/VvqP9aaecoBJtmC4l+aze+HnM=;
        b=xCuYkfZVXf/VwT+SBa5Pn637npgjurmRRS5XNbtSSRI6fkmVr4dXQp0gkZgA8jrakI
         l52DNnKG1cNL4FcqztBJVo/Tm1gEevSgVJRXytXdqG7oXwc/emqVTHoKPnfs82+M4JFb
         700FnPAVgCX8vYZopQWhRPkMUYwqPCi0CMtyC5ZkjYHTe1+mglsV3sYCgRBqXjgSTWHa
         SPquSqy4krXhr5VLyiroM5qTfmCngNSVhkpB8dtqEHHFM5tmxnUKmVfmlB/oTA47Y++2
         8Ttw8EHT1rBwkiSMoxTVYAl2+gjaE0aLZSJ4IdtZ6v9AH48W1zPFRZdpJEKwvUSjvEd6
         /Ohw==
X-Forwarded-Encrypted: i=1; AJvYcCXG7Ujhd5P98qkNnQL4XirRRh3PYyvh9f93dm6eu1K/ysRE4LhuRUSVzPWbl+OhYMwhi2W+qxm4lfgAjTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Y2j/RyZ6UHMsryOzHxfPYl28ObBkl/l7gz0HuLQwx068Ce8c
	6RB6mvxnkoOV3cv5Sb09j0AcpkhYqT0n8p2S7YacJBVVFFc+vTDQS8MN68HNEeVJvg==
X-Gm-Gg: ASbGncud7On12TOjNCFVfvXbhgOIyoj+FHJyqzbiOvwennA2aRf1mCcT2vRkO6BRQqP
	rGI9xC5ZeviCSewWM0TGtILc9SChVqkEbtgEMd45Gffb18+mEYdelc3JDAGZik3WDYp/79F53Y7
	rjLKDvnpUo8+53XsjcKljFCGMIj9j7Px3aItkUWMIQpb+xjCT2/i3ZdSAKVpzvXD5Sx13nGCbTL
	36iH2UoSYuQfLRKyEWY1gm4615htX/1JQmWJ8VQNjC7gXxhpO5mMYhc/DyPcoFUlpS4SBESdoql
	ctLGUVkdfxClRH65+xGExbHB8E/8FO5tbQpdR6lntGN2YGORAqJ/USiSqONktR+WDNipambm7GZ
	zYIYWlxkIPQ==
X-Google-Smtp-Source: AGHT+IGciF+4vEIkN/QlW54EKn9w/jC8q5NchVG0Sr8U59/ARVTa0iNrkl49Gr+973iUxiCoTLx16g==
X-Received: by 2002:a05:600c:548b:b0:455:fb2e:95e9 with SMTP id 5b1f17b1804b1-458730cfd06mr1672715e9.6.1753445795587;
        Fri, 25 Jul 2025 05:16:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:5214:94de:bd29:e79d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b76fc605a4sm4916829f8f.14.2025.07.25.05.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 05:16:34 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 14:16:24 +0200
Subject: [PATCH v2] mm/rmap: Add anon_vma lifetime debug check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-anonvma-uaf-debug-v2-1-bc3c7e5ba5b1@google.com>
X-B4-Tracking: v=1; b=H4sIAJd1g2gC/32NQQ7CIBBFr9LM2jFAahBX3qPpAsqUklgwYImm4
 e5iD+DyveS/v0Om5CnDrdshUfHZx9BAnDqYFh0cobeNQTBxYVL0qEMMZdW46Rktmc2hVtYwMj2
 X0kDbPRPN/n00h7Hx4vMrps9xUfjP/qsVjhyFUldl7dST0HcXo3vQeYorjLXWL2nQBm6zAAAA
X-Change-ID: 20250724-anonvma-uaf-debug-a9db0eb4177b
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Rik van Riel <riel@surriel.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753445791; l=2822;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=RPodm9Ldenuy/H5haDTN8fCr5D6oW2GFg9ixFEFNSgU=;
 b=2aXvVOIInCdwGZjckt0AFw/FmLGP7KvAWt58w6Phvj1VFsc79j9yuxuT9YQ416/22q2uKcSkZ
 SpdyefrwB9RCL/p7QsSAyU1j7eMRm1X9VRAhUvVMJ+pTw/0yPy2nNZJ
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

If an anon folio is mapped into userspace, its anon_vma must be alive,
otherwise rmap walks can hit UAF.

There have been syzkaller reports a few months ago[1][2] of UAF in rmap
walks that seems to indicate that there can be pages with elevated mapcount
whose anon_vma has already been freed, but I think we never figured out
what the cause is; and syzkaller only hit these UAFs when memory pressure
randomly caused reclaim to rmap-walk the affected pages, so it of course
didn't manage to create a reproducer.

Add a VM_WARN_ON_FOLIO() when we add/remove mappings of anonymous folios to
hopefully catch such issues more reliably.

[1] https://lore.kernel.org/r/67abaeaf.050a0220.110943.0041.GAE@google.com
[2] https://lore.kernel.org/r/67a76f33.050a0220.3d72c.0028.GAE@google.com

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
Changes in v2:
- applied akpm's fixup (use FOLIO_MAPPING_ANON, ...)
- remove CONFIG_DEBUG_VM check and use folio_test_* helpers (David)
- more verbose comment (Lorenzo)
- replaced "page" mentions with "folio" in commit message
- Link to v1: https://lore.kernel.org/r/20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com
---
 include/linux/rmap.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 20803fcb49a7..6cd020eea37a 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -449,6 +449,28 @@ static inline void __folio_rmap_sanity_checks(const struct folio *folio,
 	default:
 		VM_WARN_ON_ONCE(true);
 	}
+
+	/*
+	 * Anon folios must have an associated live anon_vma as long as they're
+	 * mapped into userspace.
+	 * Note that the atomic_read() mainly does two things:
+	 *
+	 * 1. In KASAN builds with CONFIG_SLUB_RCU_DEBUG, it causes KASAN to
+	 *    check that the associated anon_vma has not yet been freed (subject
+	 *    to KASAN's usual limitations). This check will pass if the
+	 *    anon_vma's refcount has already dropped to 0 but an RCU grace
+	 *    period hasn't passed since then.
+	 * 2. If the anon_vma has not yet been freed, it checks that the
+	 *    anon_vma still has a nonzero refcount (as opposed to being in the
+	 *    middle of an RCU delay for getting freed).
+	 */
+	if (folio_test_anon(folio) && !folio_test_ksm(folio)) {
+		unsigned long mapping = (unsigned long)folio->mapping;
+		struct anon_vma *anon_vma;
+
+		anon_vma = (void *)(mapping - FOLIO_MAPPING_ANON);
+		VM_WARN_ON_FOLIO(atomic_read(&anon_vma->refcount) == 0, folio);
+	}
 }
 
 /*

---
base-commit: 1d1c610e32ab2489c49fccb7472a6bef136a0a8b
change-id: 20250724-anonvma-uaf-debug-a9db0eb4177b

-- 
Jann Horn <jannh@google.com>


