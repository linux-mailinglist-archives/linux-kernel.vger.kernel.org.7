Return-Path: <linux-kernel+bounces-758420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F90B1CEDD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E92B722A9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632B22E3F0;
	Wed,  6 Aug 2025 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4/y6t/s"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539AB28FD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 22:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517627; cv=none; b=nkTI7zmUDejYQxdkdPWuFLKMulvLG+4W2zppAhrdWFEIGW0mkXc3OJAWLxNqPNkdoHJF864RWiwx1QMJH5P4AbJVCRIoaAAxhgBTSnZMMRifVZFvcf88nnrwdewgLv71yiu9Fgy+GQabhdeBDnxz/TwBse+u9QjLW9cKt7Uwe6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517627; c=relaxed/simple;
	bh=5lOaVPIox90EtPwO5fOrQolK9YVZjng1IH3ugUBN0Nw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fFqrlJgzmi9Uviy0kzIFKOcJpZQ1wmuc4vWbv9wIMtbwh7C3fJoTLMosUniFA9AG+uueiW0D3kOUbZNl09sadfehd3VT+u4rCWCZ0ULY6nXwrVyGXci+g2daPTMD1822JBtVNRBRFrGIFHEofXQJuKcbSy9o/7q783U0rDI1/AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4/y6t/s; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so184814a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754517625; x=1755122425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0DGq3Zp4fJ6DZNHeIX2b5x/XDF+UYujZX+55RuFP5IM=;
        b=h4/y6t/skR7JP+Cp9WK/W7dx276vx6bPQvD4bSWg8UwTfwKsnZFu+PVcmH1Z7h+miB
         MoIZz6gXvYESgR0G+WZ3tGWhjUJPHE1tCsSpmy5YDRKRQzqUOQ6jabsgcpHU33mY/OPm
         0ZfGku4CQSRDHyN5Vsk9gQnY8dxS0w/oduiuKrk/VjR0ARzgHNtZdyTiRV5FEy8LCB6x
         zqBMj+j+ypGPjehE0SvUITJTiG8UDqCTKr49n3xNiC22n14AkH17xBdETk5aBI9MytSz
         MN1qQgKkzmDQeE3ojMlnTkC1nbl1l3PNidWv8fZQQ3HvEWkw7SxcENExvYvHXAvOeGfA
         yelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754517625; x=1755122425;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DGq3Zp4fJ6DZNHeIX2b5x/XDF+UYujZX+55RuFP5IM=;
        b=UNppodVg4Y+TF0jpQur08ZXuP5ZckpZvPZB5k5i69Mo2MwjphJ2+nyPdtvjUomgrsG
         JWml73tYLl6BCcYEk906SzwwqYfja6ZzvVq48AfisYYRnqsbszruwMPMoLus7EgPhOka
         Mai9DeCjTn6aH7JH3IYccTGV2Qm7ogN4lpSejG+A9zKx4Rqj54eqwPF0eYXlOjoapFn0
         FeGUbgOJmgeYt/ujpWFV1mg0SAlEQ0o/ZjXpKrwDjdJ8qkYzip/t3MBWPyG4hE6DD80G
         6OIuX2YaCwgt3DET2L+7gRAY+HMXTZUof/aZe8zWNOLWfbwCkPBjEP5JXv9bdy2P3F1R
         vSvw==
X-Forwarded-Encrypted: i=1; AJvYcCVZtF3qu0Xld9cwbGwLZs1biuFzz6yivDFF8xCm0flESJvIC0akVtmK5wb6NUpNxaphX0yPSgusvylecZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrGtXNxQoZFF/fC9CECIXsbLy2imx3k6QlKeh6TCLv8xjb2ale
	nuelKjHbafY+ZkzlwKaKh2AgAq6msJN1P/VpE4hZlk8Je/kYvsCn20uUz2+R0YopLJ73W6wxB9t
	wCwI0Eg==
X-Google-Smtp-Source: AGHT+IEgXVgvOPOZLzpUU0uxEIMp34b7pNlfgpNcH4fA0yFqf6+H+2ZoRWuQLabxen09rQvlDcn4hw3n9b0=
X-Received: from pjob20.prod.google.com ([2002:a17:90a:8c94:b0:31f:a0:fad4])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54b:b0:240:8f4:b36e
 with SMTP id d9443c01a7336-2429f30a072mr61870205ad.34.1754517625374; Wed, 06
 Aug 2025 15:00:25 -0700 (PDT)
Date: Wed,  6 Aug 2025 15:00:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806220022.926763-1-surenb@google.com>
Subject: [PATCH v4 1/1] userfaultfd: fix a crash in UFFDIO_MOVE when PMD is a
 migration entry
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterx@redhat.com, david@redhat.com, aarcange@redhat.com, 
	lokeshgidra@google.com, surenb@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When UFFDIO_MOVE encounters a migration PMD entry, it proceeds with
obtaining a folio and accessing it even though the entry is swp_entry_t.
Add the missing check and let split_huge_pmd() handle migration entries.

Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: syzbot+b446dbe27035ef6bd6c2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68794b5c.a70a0220.693ce.0050.GAE@google.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Cc: stable@vger.kernel.org
---
Changes since v3 [1]
- Updated the title and changelog, per Peter Xu
- Added Reviewed-by: per Peter Xu

[1] https://lore.kernel.org/all/20250806154015.769024-1-surenb@google.com/

 mm/userfaultfd.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 5431c9dd7fd7..116481606be8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1826,13 +1826,16 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 			/* Check if we can move the pmd without splitting it. */
 			if (move_splits_huge_pmd(dst_addr, src_addr, src_start + len) ||
 			    !pmd_none(dst_pmdval)) {
-				struct folio *folio = pmd_folio(*src_pmd);
-
-				if (!folio || (!is_huge_zero_folio(folio) &&
-					       !PageAnonExclusive(&folio->page))) {
-					spin_unlock(ptl);
-					err = -EBUSY;
-					break;
+				/* Can be a migration entry */
+				if (pmd_present(*src_pmd)) {
+					struct folio *folio = pmd_folio(*src_pmd);
+
+					if (!folio || (!is_huge_zero_folio(folio) &&
+						       !PageAnonExclusive(&folio->page))) {
+						spin_unlock(ptl);
+						err = -EBUSY;
+						break;
+					}
 				}
 
 				spin_unlock(ptl);

base-commit: 8e7e0c6d09502e44aa7a8fce0821e042a6ec03d1
-- 
2.50.1.565.gc32cd1483b-goog


