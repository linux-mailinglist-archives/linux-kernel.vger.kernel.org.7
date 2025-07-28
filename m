Return-Path: <linux-kernel+bounces-747612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D0EB135E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934723A7A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52297236A9F;
	Mon, 28 Jul 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiUv1iaR"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F272367D4
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689238; cv=none; b=Qvm0YAs4SHzvXU3DHJgkekedSbPNaNLD6mQvVFay4849fvgB63AFWDLS66nyJBH6NczDOWc2gtdHlGLER43dkZXh3T0MUnzMT+dMIcD+elNi8XBdvrVYUK0UT6RKYpD4rpbQdgGFZAeIDJ1a+Zf1cRa+w4GG7af/22HkokJgbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689238; c=relaxed/simple;
	bh=3QRbs4ecGrdC32cfsqPknVeHalLahgEtXvUa5MGgKP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtppgyA5XjLWHGPc/gkQCKvvGc47Ntld5dQJ4UXOVqW1Y1AkpRwNYr6Iwv2uJwwlt9miBYmDxAvtFb/DyJZGfs0Cv7zrKyM9lrsS7QF7pyMj9kF9zcHmM/Xq6WEcI9qXR2AProZo+q5k5b2jLl36kXXhiwBC8FZUZ0tB4yfJBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiUv1iaR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so9969295ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689236; x=1754294036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uaDofCvBJJi4OU/LmXdHLeynm/OcrnFAPJYm0C8Ejq8=;
        b=CiUv1iaRjihzdjH7/tb/nzbpkyTdVhG0LgYFlDhjxbDrpw8oZmpiRxTLzJ2WAKsXv8
         B6kGKZp3iaDTAG9cW8yf2Pa5Y86EgVIDAPLbjrXzM2eCo/VZmFFNhNoqk3GvfcVzUxeh
         P3Lw5iHdJ+tMsS55jsVX6rjsHIN/cXyWl/GyZUKF/N5cdUqPiiEz9q5131s9+GeGXswp
         SCLqdO3rLjyzUX2g6U+k3ArYYsviK5sQslJzHOYlHvb0ajRhFZOOcEUanN9gYwk+rIH0
         eDLIANhv04sPCfYOHpphJc0VOecAg815QcJ7cVL1Rnpf5juE2NdLY+fJBfxoBuR87aCv
         x9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689236; x=1754294036;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaDofCvBJJi4OU/LmXdHLeynm/OcrnFAPJYm0C8Ejq8=;
        b=HH7tKbj1XIeWJWg/Q8/nqBCewdWf1dgbg0TrmTBk0eyW+pp5kjLR5ns+Zig8U5avUB
         C96YBwx3ZmSuNEOIbXA8d8CIwJtzQ+Dy+KdpGICXJBwN5xdvO+xzRj8toHxom6Ke1lUc
         y0GYRLyiWpcvhuLCwEALlnb9Vx9cVIT6l8bKuf2Iv3FpcCjqwK0Q3ccTz5Vr3oAdqRHc
         xQDDKcR/RNDhavEh9UAHZDeNiLY4SMTMfDutoo/9huTtBPkbcBbiwrTSpL7Zw38sbU4u
         bvB+MXHReCrAnvumkpbAPSJUXBXcJDwniBImI6bIl3uhiJ3UTZNCi5iN88vuDNezgLAM
         7oCw==
X-Forwarded-Encrypted: i=1; AJvYcCXvDDaxo4ilFpz0zuP57kWOCtD1WTdZmnlIhWSnrgDZD5Dy2vs3c1bwdoqH8MXUN6a2QCO5I4OGnyu3bdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4dA7wFUbc5VW1u2o0wBcs9d1yhJhdjE0cCzd6mQHho51a+tQN
	iAjKIJ7O+g8T1uZy6YIFzt+aEhVX7pnFhTS5n3RnjTLeJu2dJjC5dBnN
X-Gm-Gg: ASbGncs4QiR86+w/wqf6SIjW2ma1aNnuW9EBnx0Lz8At8ReheQc+LtYWnY/icufNb9i
	X27AwdsP55kR3SUEKu7yJn9a/2LAwuliEhMf6aEtbayUzsPvl4HsgZNR3McEszg6xdGUN2tdKEM
	MgAS5kzTs2NF0YhH6UjOx4Y5SU8rOB+b2PdtFpX5ah4e6q2ua96mBx3EuwdKrl6Utpc8X48/9I+
	imjzcCc+6pG0riyRLJpa8f0QFFTjnK/n4XAyi0fXv1BnAJRF+uPmKmn+XrqpdAg85DghrexCwEP
	jZftJ0+fg9j5g3z+D76VaQ3sqWRJ68+vqaY4TGQM5L+I+OCBgmUyryo/lPWacufJxSh/dpVoBcS
	9YnRBJ+Q9lt53uUg9lHjuUzRMmFDzhu0bBIME
X-Google-Smtp-Source: AGHT+IFcjk+VnwZPRERIPqhI1RvqOKp0YIfha59JqXJyCrT3wpyy9RckeBIOnrxvrdcmptyOyK+pDg==
X-Received: by 2002:a17:903:1111:b0:23c:7b65:9b08 with SMTP id d9443c01a7336-23fb3050816mr151982835ad.1.1753689236321;
        Mon, 28 Jul 2025 00:53:56 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2a1sm20272305ad.4.2025.07.28.00.53.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 00:53:55 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v6 6/8] mm/shmem, swap: simplify swapin path and result handling
Date: Mon, 28 Jul 2025 15:53:04 +0800
Message-ID: <20250728075306.12704-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728075306.12704-1-ryncsn@gmail.com>
References: <20250728075306.12704-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Slightly tidy up the different handling of swap in and error handling for
SWP_SYNCHRONOUS_IO and non-SWP_SYNCHRONOUS_IO devices.  Now swapin will
always use either shmem_swap_alloc_folio or shmem_swapin_cluster, then
check the result.

Simplify the control flow and avoid a redundant goto label.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6bcca287e173..72b6370a8e81 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2357,40 +2357,33 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
 
-		/* Skip swapcache for synchronous device. */
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
+			/* Direct swapin skipping swap cache & readahead */
 			folio = shmem_swap_alloc_folio(inode, vma, index, swap, order, gfp);
-			if (!IS_ERR(folio)) {
-				skip_swapcache = true;
-				goto alloced;
+			if (IS_ERR(folio)) {
+				error = PTR_ERR(folio);
+				folio = NULL;
+				goto failed;
 			}
-
+			skip_swapcache = true;
+		} else {
 			/*
-			 * Direct swapin handled order 0 fallback already,
-			 * if it failed, abort.
+			 * Cached swapin only supports order 0 folio, it is
+			 * necessary to recalculate the new swap entry based on
+			 * the offset, as the swapin index might be unalgined.
 			 */
-			error = PTR_ERR(folio);
-			folio = NULL;
-			goto failed;
-		}
-
-		/*
-		 * Now swap device can only swap in order 0 folio, it is
-		 * necessary to recalculate the new swap entry based on
-		 * the offset, as the swapin index might be unalgined.
-		 */
-		if (order) {
-			offset = index - round_down(index, 1 << order);
-			swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
-		}
+			if (order) {
+				offset = index - round_down(index, 1 << order);
+				swap = swp_entry(swp_type(swap), swp_offset(swap) + offset);
+			}
 
-		folio = shmem_swapin_cluster(swap, gfp, info, index);
-		if (!folio) {
-			error = -ENOMEM;
-			goto failed;
+			folio = shmem_swapin_cluster(swap, gfp, info, index);
+			if (!folio) {
+				error = -ENOMEM;
+				goto failed;
+			}
 		}
 	}
-alloced:
 	if (order > folio_order(folio)) {
 		/*
 		 * Swapin may get smaller folios due to various reasons:
-- 
2.50.1


