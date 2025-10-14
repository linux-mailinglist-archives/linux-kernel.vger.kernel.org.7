Return-Path: <linux-kernel+bounces-851644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF45BD6F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ABDB4FE673
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D904F238C0A;
	Tue, 14 Oct 2025 01:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WidJdK1s"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D12AD2C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404444; cv=none; b=jRyZq1eeWr9HrVBNuZCLnPAf+9eq0STaulVtFoussdUqcNK8TyUsglN0LkyZh1q9muxiInFVX13jmBl3/ECgOCbKWWXUpK83xd0MDGe+/5y8FnTd5A9UYyc0uULur3P4mjRveDoVZDiKg91xYdSr2klG6oRgTQpoC33n4gfVkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404444; c=relaxed/simple;
	bh=QvwH9/NjBJYxdmVmwoMoiYukHyoXHc6/Cd91lXu5rQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h4h0QXN2QHDpZS397bfBqODi9WqSrkyuukLnMuDw/xQM3fgG6WFwpymvLVC//vBfcIJcF5pKwZuRK4P+tRdNTattNbj4v8d8cGb6b3bkyFuYNnnNfi3/BzrE153rduk+i2c1ZfcGdXC+PbZLMxMXh+DpuUnPfmp1X0WfSoiQB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WidJdK1s; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso4188299a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760404441; x=1761009241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sUUDmgUiMLCWBMLh8sM1y8ajkdguTuggUBmRSWDk8OY=;
        b=WidJdK1syv7TN0aBGpdfsxl6E8b7j2R6xcAGD8VvzrvVx0InTpZkIyHKwLKUg5oaI8
         ALgrMi58Abru/6TxeXOhRnM+Uu3NKL7T+fhBLvcK8bQbiLCxxP57WOvHn2N+lymDqex7
         hm4QFI0RXygnEQBmO404BPs0/kl1i2CftGEZLXXtVRTLjK4/onMWhawuEJRpJQTI3GEq
         JZaTWIwIXM92zaz5wqw93D2ZVkqmlJxgGaJs0mD6LvWXbufJ/Qr15nM3ueGBAqNS+E0h
         GLZT7WHyzCzDGqeEhr50fp0bPmijRPv1Yb6X6ZilOBUjoEYpyvAyMEHWiEM94cYmYjqI
         KW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760404441; x=1761009241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUUDmgUiMLCWBMLh8sM1y8ajkdguTuggUBmRSWDk8OY=;
        b=EiXBGjRV+dNZJ2DEIcoeG5tuGjguK7MBbenWc1g6OonYSaagPVxiWPv4CKcdNa7n1q
         9ktPlEjPjwky2twtWaLDti4Wr2U+ydSsYwtPcnznU0UWL94mnHHbm28SGk9sFPFj3rGF
         4bo2YHUHyNn35JmikkEjY/H7V/t/uSPA0BBzRpsjfYCvxvjxITR26apeQMV0esYNq+BR
         VbJ/QzNBFMWmDVfM+BzrQTO1DbPdPgonTDpLenYRIKbhtCawmyr9WakCccW95wP8M0zF
         TMhYqK/V95T/S6ZoTUo31S1qvwXVZHRU6gnvYQ0RJ91fxOLRqY0J3P12JjWeDb5vn865
         S5fw==
X-Gm-Message-State: AOJu0Yzgc+FjtSdfkK3cHw1eNtGl6eT5x6BaNficZ8v2+EsLh2uxf/0a
	g2IHvhfkeqlwvXlL5wVRyS4K4wGo/NKIV4sXwiov0D+cMYs1TW0fDIBBkjecJPdKQ/xFdg==
X-Gm-Gg: ASbGncuxCt1rCP/QUYOWvqurvZYEUgXV1h5aw3PORG7fPCaS6akRFKdsLwLhnpGUWxw
	HwyvAeLEVNCTA26pkxz5mDpKT3w0HUfOfhH8Evt4zQLCgJ3exkoFRM7SFSczQtnSUZxi2mzgdSJ
	yAHL2niQHnu143uQzp2Fb/Ddi2Xvw0/wpwO3eI/CNe/p/hM4u5y4LPLZTt6crQPZ+g2q9r7FPX9
	koKHXuFcnzLvTok2VrylHEX/lOl52EYqUIiWtx1lV+Xuq1QpDC3IMmABfOl4kbkXPb4kaFVIzs0
	kAfMMSJF/fYqrFtV4z40oKcrtEB1X6JCBAcTV+zPRunlx4DxUKc0koS3EaWCIfkfignVki8vEeE
	Qm4WLwDPz4XdZLxHZSipmlsvNapr+xTynQwKDVAjfHvDlD2Z6pfqg6bWWUbQWwyFViTPgn7rFlO
	k1uFYpYUeDMJ/FvaWgLDcxOHw2zJg=
X-Google-Smtp-Source: AGHT+IHIhl/B3yHEby1/bdqAVwH7IZTRAiZsvqjv9k7B+2M3pNyqGBlY2gObvmLGERJsO1AEfi3VnA==
X-Received: by 2002:a17:902:f64d:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2902741f7admr280674595ad.61.1760404441355;
        Mon, 13 Oct 2025 18:14:01 -0700 (PDT)
Received: from linux-dev.dhcp4.washington.edu ([205.175.106.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b6262de3asm13516269a91.2.2025.10.13.18.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:14:00 -0700 (PDT)
From: Aditya Gollamudi <adigollamudi@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: adigollamudi@gmail.com,
	mark.rutland@arm.com,
	peterz@infradead.org,
	kees@kernel.org,
	mingo@kernel.org,
	ubizjak@gmail.com
Subject: [PATCH] include/linux/atomic: fix typos in atomic-arch-fallback.h
Date: Mon, 13 Oct 2025 18:13:51 -0700
Message-Id: <20251014011351.88032-1-adigollamudi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adi Gollamudi <adigollamudi@gmail.com>

Fix typos in comments throughout the file, change "occured" to "occurred" in
include/linux/atomic/atomic-arch-fallback.h

Signed-off-by: Aditya Gollamudi <adigollamudi@gmail.com>
---
 include/linux/atomic/atomic-arch-fallback.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 2f9d36b72bd8..455579470b15 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -2121,7 +2121,7 @@ raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
@@ -2155,7 +2155,7 @@ raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg_acquire() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
@@ -2189,7 +2189,7 @@ raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg_release() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
@@ -2222,7 +2222,7 @@ raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg_relaxed() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
@@ -4247,7 +4247,7 @@ raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
@@ -4281,7 +4281,7 @@ raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_acquire() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
@@ -4315,7 +4315,7 @@ raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_release() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
@@ -4348,7 +4348,7 @@ raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_relaxed() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
-- 
2.34.1


