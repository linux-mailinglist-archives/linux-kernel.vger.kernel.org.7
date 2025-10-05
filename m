Return-Path: <linux-kernel+bounces-842215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95765BB9402
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 06:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5897718979C5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 04:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD619DF62;
	Sun,  5 Oct 2025 04:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="Zoq7tnkY"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B22CA4B
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 04:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759639166; cv=none; b=MJqjvvJUhlvSzKEI5ybBBU4yvd7RHHuJtW5I1IlO81rawFZAfHZ+QHJLI2ZnZeYRKJDrlauRrJkNpA6qb5u57kca2Wf07LqQLWbzGObq+sjrlkWzojdsSRRhIS9iVj/Y/EqYBDWuKU+Vlk5oWGm1hzhxu7wxo+I/CZ5iz+UY5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759639166; c=relaxed/simple;
	bh=XH2xXUswwjYui6iwKQscZaPoZe7ppMJZ6Sgoi/ykVGI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aKE1oL8V13xI9NywFulPbGm2He+DAvVmHNhnk7CqPum2K8/rOYZEp3Oxcz91B8MruIUYP9yT9TzKwm2Meya6/wlooQqvF7Ps0SG5mOMcrJXcs9yG7oZrwoqcg2qXuSsshVM02XNpRALeQ66Jt5GLGCS/0Ef3m3AnOX1COGKEVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=Zoq7tnkY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33082c95fd0so4016225a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 21:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1759639163; x=1760243963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Apb38vvwB4yx6ZuSTdH5FloXnDPkndq4ehFPRMxQ1PA=;
        b=Zoq7tnkYdhztbb8x4zsdNzsS1v4Pi1UmMtbx9tCYMB4ZHr003/gXfaWB9OKxjyZCx1
         TrEnfYeAambmGtUS1uF0z6ukFCO8jTKhpITZpsnqwuAMtlqByTT1rd5In9gKoQbuHiUI
         jKvx/G4XOXwJe3In3Dr/wQdrFzoUAYIb3E0Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759639163; x=1760243963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Apb38vvwB4yx6ZuSTdH5FloXnDPkndq4ehFPRMxQ1PA=;
        b=ojUawV9tWb7Qlhwd3WQ7ckY7ddhwrzk9sOw4xdVLPjzQ/w2vnuK2UzzXOhNbUcczPf
         X0aqJc4QoFKYxleUqJZna8kDLnznbeTrQ8tk0uEDIVXI3ZvFyjIXJmtcNpzkSLO5VGbZ
         mUhJlk2fx9Wk+kbnLGI6Ig7BNs6qnMaiLOf6I1v2BtzPFT3AolrcL/a+HlWJDoHqVW/9
         quxRJ10t4Qr5Xw5HN7OkkVM0vM7KPVa6MekcUTUE2uHLkObhgEBbVWyY0PL6VL4mdg9w
         uAeeR6hzYP4FWmuoLkEc1C+VcJSet2UDPaqetjmlF4UlwOwqksCsufcGkMIrXDGvFKxt
         9krg==
X-Forwarded-Encrypted: i=1; AJvYcCUFlek/TTa94/wehU/1nRr4mRGMHVkSGEmdXLVOfHRpxmKZI01gF35T3N1K8Jd1wK1aFlGtVAJyjmrDTqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpHuZi9qMGSrB5BPnLns4dBslTclyjC3F+tvbEw8njccANrKZ
	m2/bb6/VVMJUdQ6XgDLFIUj9R53qyKqH0/dtFNwdUDBhZ7rtVYzqEDyeUBVNUoxSEIw=
X-Gm-Gg: ASbGncsxNZB2tqrWPuQmPYw1LqFoiVIw7jKUxNeqJONv7N1fhnbO7vRnJqVVrMrVbMV
	APht7zth6XN90ViaMBSbL0twN1FZVJX9/tdvZLCgVyn7HQLTF0SfDgL8fEka1J96iAFi0c9qUck
	MVZPt6Z19kDLedvsJWghNXr+XQ/rQj5gefkBYsYNAgMelIi0T/qsLnSYuJgSEpnmogTkDd5eu56
	FpKkOEv2cP5MMmyGi9xG8fsprURkohlvhrler6HUPy6GzeysF7DPX+ZTKJZ2ybWceky9qiIUKEb
	KWvbChhDuPBYjgHohCswdfppdEs2mY566GBo6nHQYEjrN1xvLVNErPDfzIPHheptYO3VJ3zQ2g7
	xoHQPfZxjDmWRuIUDxX0i+pO0glWxZ+lDj2ksj6BSnMbjvY65ENL6P1k1v53plzBuK1rP4B95Tx
	HC8xEjgZyscOmWl0u5o3w=
X-Google-Smtp-Source: AGHT+IGifsrczbdDKYNtv1noTEjGaiFZdC0gFOLKpD4Gx2VS5pRYTYCIpxROzAXFy+ub6zSL+d/53w==
X-Received: by 2002:a17:902:e801:b0:269:ba8b:8476 with SMTP id d9443c01a7336-28e9a6a20efmr107869995ad.56.1759639163061;
        Sat, 04 Oct 2025 21:39:23 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2409:40c0:105f:3153:f16e:6b07:4a58:8dc0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d574csm93059645ad.108.2025.10.04.21.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 21:39:22 -0700 (PDT)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+564efbe31172fe908429@syzkaller.appspotmail.com
Subject: [PATCH] bcachefs:fix use-after-free in __bch2_bkey_fsck_err
Date: Sun,  5 Oct 2025 10:09:10 +0530
Message-Id: <20251005043910.32975-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

When mounting a corrupted bcachefs filesystem, KASAN detects a
use-after-free in the error reporting path. This occurs due to a race
between error reporting and key deletion during fsck.

The sequence of events:

1. extent_ptr_validate() detects an invalid extent pointer with a
   corrupt disk offset
2. It calls __bch2_bkey_fsck_err() to report the error
3. The fsck logic decides to delete the corrupt key
4. Meanwhile, __bch2_bkey_fsck_err() calls bch2_bkey_val_to_text()
5. This traverses the extent entries via bch2_extent_ptr_to_text()
6. sector_to_bucket_and_offset() is called with the corrupt offset
7. Memory access occurs on data being concurrently freed

The crash happens in bch2_extent_ptr_to_text() when it attempts to
validate bucket boundaries using already-freed extent pointer data.

Replace bch2_bkey_val_to_text() with bch2_bpos_to_text() to print
only the key position (inode, offset, snapshot) instead of traversing
potentially corrupt or freed extent metadata. The position is part of
the key header and remains safe to read even as the extent data is
being freed. The specific validation error is still printed in the
subsequent lines, providing sufficient context for debugging.

Tested successfully locally using syzbot provided reproducer

Reported-by: syzbot+564efbe31172fe908429@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=564efbe31172fe908429
Fixes: d97de0d017cd ("bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 fs/bcachefs/error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/error.c b/fs/bcachefs/error.c
index 267e73d9d7e6..b0bf08915aa2 100644
--- a/fs/bcachefs/error.c
+++ b/fs/bcachefs/error.c
@@ -688,7 +688,7 @@ int __bch2_bkey_fsck_err(struct bch_fs *c,
 	bch2_btree_id_to_text(&buf, from.btree);
 	prt_printf(&buf, " level=%u: ", from.level);
 
-	bch2_bkey_val_to_text(&buf, c, k);
+	bch2_bpos_to_text(&buf, k.k->p);
 	prt_newline(&buf);
 
 	va_list args;
-- 
2.34.1


