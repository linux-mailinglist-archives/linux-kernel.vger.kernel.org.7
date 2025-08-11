Return-Path: <linux-kernel+bounces-763415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCEDB21446
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962FB3BB090
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9B22E11C3;
	Mon, 11 Aug 2025 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaF3cZtZ"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B82E0B69
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936714; cv=none; b=sKtsfaME+Qo2CXxHnlkAcU17fnzJqODUGDpDlmFpTRW4E+kkptsh3Q7LvP7KDy82wlvuSqexk6i/Wx6dHTQ6wEkRef/HqE/uo1BubBKvLb9TYIJ1qWplPtusO7mo9mvjgKHbmotjIiOUCXuZf3hJkHMpEFaDO3MfNS6GswSnDe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936714; c=relaxed/simple;
	bh=DokD3vIRoHjif+5R31Uuaz7qu2/o6zaJk/QPZLREa1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bP2OkMhcc4O4oA+Tze5p1zi/f+wCkS7+2uKMUXbapevcDXugYJSt1K+XoiUxB/SCIh3liD8usQ2KUXEyiJN+8hEjNQzi+VHwQ9ODznQMz0CfsLg2l8A1a8omD7v1b50zonlUXlTZyfN9lX0/bZO+0MRT+fMDtAAMekwyW51Nfd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaF3cZtZ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76bc61152d8so3981379b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754936709; x=1755541509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFiR90ByEmrbZSIU4oPPtikQuOT0OadaiRvQ1pEaI/0=;
        b=RaF3cZtZIuPX+i7SYSgS/gVmYOCVAIgZuDCdAEx18G3WT8YIA+bGkQOo1bnsbkaQMU
         mTV4me6/rOZ+8SqGIQdiRhfChPEicK8autG3kcII7FK5fySYglgwl6/3MG02JdgKdNOd
         BRV4nq/I5NBZg2cHA3AGTG4+3uaBJfDu6BOB996SfSwyLjC9OGfY+vcKF+iwhat6nJwT
         lG0tql8OLzV5Th6Lnixlfb55mSq99CfLbR3lfGK2Gd5rj1KLGEokz/L597XRMDUFtysw
         IIEFCjv7zBJoznBKiPtRYlNC/dPKo0iKdg7sbxeP1Tx2cqCvbZt9kdylkrCH0TmA3TOU
         Oi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936709; x=1755541509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFiR90ByEmrbZSIU4oPPtikQuOT0OadaiRvQ1pEaI/0=;
        b=KHVtTJrOhm1VY6tWhMuYvrMjLodKndPYIpsW3/udjUwTu8DvPv9dSgOqyrFB6qkL1R
         RHZaZrHYTPY8jGrPkVVebKMrh1ofZVi227csSLQFnnlZfs4A6i3AXSDqpC7M43l2o6Py
         M3F5zh64b5htCCD56/Nw2ER5Mu72aRdAvF5Kdhs6sz8qYOiku0O7zQrX7ZjEISO13iqk
         WZ6aDrTR42j0m3YiIQBEOt6XedirR+MWICRwvibYpFNtdBRAI1FS7kDoe6uroLOJXzUv
         vzkMMtnhO/YDpR2BJp5+/J/HvZctOkrqzJzVSku6+VHm8juCxNc2fThcARpDhM83tJLv
         p+cw==
X-Forwarded-Encrypted: i=1; AJvYcCWgQhDZyHISwNf+BcuMaGb1qlHV1TwEzEmqoyUdhW2U8ratNisGDHfiXfL2TGT9I13/ihnVvVFL5mENogw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIoBkqqfypbf2zyVvM6vSc99FFErTp5m7JdjBhB+yHEI8zlnGa
	LfkR3gRK9OTMvTGi7dH9HhekfcZXz4sx09DFhR7v/DouUU7oKdF0Qsgp
X-Gm-Gg: ASbGncvz0xZyXhLjmEiWoIvbaLdkjykNgxd7NUJi8qnyKlc0Dp0r/RsdcS3VbKmeY2b
	zPGLs2fOsNiGjBfEszay8q7zrIIqhpLnDXiCx2qfE0T+sGaXUlAcT4r75CvmaG1R5mcDaultiyH
	ooV4JJTcHgRfKrHz6aaLvNCmlGy2f1FdLkl3X/KM6M7oy6G+TVkrePg2/4UQj5uyXJ1soLBTH3l
	Fo+9SkTgPI5/vLT17uZzFzeAMx/p2glIa0SgsJb8Vv2eQFZeimadGCM/i70o9Q12jk2U9mxfTyy
	YzOvTvgQpyXFPOyYbvaqeY8eSNKDQO8BKBB11wNZ3t41y+CWEokzzVPGOphlchIbY6dB4V1Gint
	ziD67zAzEh7ro6bhxnwUaQOu3Hab/dEgI
X-Google-Smtp-Source: AGHT+IGXJ6A+jBw2s9ZXQYHpLI2Ze6FA2tDiIc8Rtctqegz0VHdY8uYfOogfh0O8oZki2NTtbzW9CA==
X-Received: by 2002:a05:6a00:1388:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-76e0de2ddf8mr950598b3a.3.1754936709451;
        Mon, 11 Aug 2025 11:25:09 -0700 (PDT)
Received: from archlinux ([2406:da18:c0d:d265:8107:1fcd:5d57:ff7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c020a4a1dsm20101039b3a.13.2025.08.11.11.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:25:08 -0700 (PDT)
From: Jialin Wang <wjl.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jialin Wang <wjl.linux@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] mm/vmscan: remove redundant folio_test_swapbacked()
Date: Tue, 12 Aug 2025 02:25:00 +0800
Message-ID: <20250811182500.42670-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When !folio_is_file_lru(folio) is false, it implies that
!folio_test_swapbacked(folio) must be true. Therefore, the additional
check for !folio_test_swapbacked(folio) is redundant and can be safely
removed.

This cleanup simplifies the code without changing any functionality.

Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
---
 mm/vmscan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7de11524a936..9d4745ad5e23 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -985,8 +985,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
 	 * They could be mistakenly treated as file lru. So further anon
 	 * test is needed.
 	 */
-	if (!folio_is_file_lru(folio) ||
-	    (folio_test_anon(folio) && !folio_test_swapbacked(folio))) {
+	if (!folio_is_file_lru(folio) || folio_test_anon(folio)) {
 		*dirty = false;
 		*writeback = false;
 		return;
-- 
2.50.0


