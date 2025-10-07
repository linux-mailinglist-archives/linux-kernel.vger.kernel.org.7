Return-Path: <linux-kernel+bounces-844531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9243BC224C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9107D19A4E43
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C182E7BDC;
	Tue,  7 Oct 2025 16:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoy37p15"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76E8F6F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759855582; cv=none; b=BcK85L1Xo8v41IK1R6o8c9do21xUqFKbFsoLPF2IZf+cGckXOhXR+fciBqqbFgzVSgq2zlcJ2hErqzlW7bjvRBxZ8ltraz/Sp8Ha99X7ox5n0W7RYuVTgKCfHHQApzVHAEUc7vCJ7HscQ9PWkpTayLjLsYLJfwqMpwfUX2td/Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759855582; c=relaxed/simple;
	bh=wYijfx82w/i+5cLwyYwuMtQXPPURM8z5k55rzxEZFLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rYZtN4VbEVygFSq8lE6FyW809ER/9tJUKOqe6tc5HjZrcXXp7l473ia3h0QIZ53JB23BqwTJT61oOAOWdeNFUq5mVk5TsH2r9zNo3vpSAMqkKaLKTh4lgGUKyHqkcJi3WPqubkyPdep7nlg0xHLurRMHhbgvuY+F2cyKCQow+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoy37p15; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so7388537a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759855580; x=1760460380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oeG9oeMq3V/BRy9XfGgniPTDeM9j7ii3LAYxjxadWNg=;
        b=eoy37p15qPD5q4/QG3gzafcbim8yKyAFPZKD252CXP45fiE28KJ4UqPJLhVGA9zDKs
         eqYVAMuO44YHwHuBdaS9sHwxaGPKVrKItZ39zZpdhtg3pmfpjgPJpRLqw+4W0T2tD++5
         Bgtze86FlCEgBHZaYDygrXTMIjWWI7+PRGQU+S6zEaIVF4AhCuWQcKs3glOmXJfoWTnS
         C8XcD4cRDt0zk98ihHSgzoI4a/sfLoWVUnwCuE1t40CuHC1EvXFr93JpZMEi9gvdgB0o
         w9n3n1EZqSgUoQp7j9aTAv8Jkb5dbYizwGzyOdW7xEOABEFTJHiCdDRKgFRLFg7nzd3E
         kyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759855580; x=1760460380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oeG9oeMq3V/BRy9XfGgniPTDeM9j7ii3LAYxjxadWNg=;
        b=JXC7SSwynxzjZZfESiwCUsV4haHpVITK5V801OWGTh4pvnUPgAf7xEYS4uv0xKCglu
         KMoGjmQlAilAILCYa9rI3ImXy0QUwIjcOw51jlCXf+XCgSN+TYnEFf56eQ92+wpLmy5c
         NMxlqWV2b7UJblLqs4HTXhNgW3CnRrxmlAR7wDz9xxVrUIrvbAY3TdtdXSFVUjPYXQ+k
         VDKpN36cLY4koGCKge9OAXAiv++lgD5agluWVXUmsq3GXVby0VKxgvprDSDSATT4qmI4
         kjcNNlzUoul+d5ssIaYSBzmu6OOZFHgXJ3zmBQ7drabMjuMbuN0cSSBZhlYw7EokLUKQ
         TtAQ==
X-Gm-Message-State: AOJu0Yy8msIw6uiKeVaYQ3se7AmhAUF9vr2wDwmRsnMIZUIwme03pPs6
	3TfccCWjxJQe2AOn61psHak/MwEIsSZEkz1UZbpFDJNTlv5biuHOKsaVsNj3zw==
X-Gm-Gg: ASbGncthT8pm9aXxyJTcpvOlpP2ekZD9KzLlc04AyQiXIdn7yBl4D/eRqN4ISWTnJ/e
	BYmCzxlFzj+TkiTuSE6sQSU0Qsr708tRMlf7RJWteGOKwPHTIYnMJbDs+osD/zivZ6D7X7cMiDX
	T6AWEMgFBbNRzT/K/0PYC5jxfcFN+2M6Nkp8aZ5CHw+fTjK9SPRCw33r4HB6wg9fUh34zXX3P0l
	Ed0SOmgPZ0O3dsif1ouYOnQbELPTilEEzhs4+N2DNhMqsLFBAnxfD0e1hcc7o1kCv16p4z+f0y/
	LtzXjJe/bmA26xnDvcnWKQKwkE6nT8cahNCjOBc1u9MhT1EHLLBsWCWKfPb5owqZxFZDqHucYA4
	bn1AWKTONQvPPp++U/LRFjqir+e7U3RrOOOaKDG5DoWB4n0/u84BDvYl0cRzqdNebGcVGH9gFoK
	Y43RGGvmJnlzfeo7POHjfTPR6Dake9MuyF14n7
X-Google-Smtp-Source: AGHT+IGgdyL9Z/s6avlLrqCHpOmrQPCcVtMXKZ1vrT7JttZd3PpRzeNrKsvQMIUPfcpRZ3c+WWGGhw==
X-Received: by 2002:a17:90b:3890:b0:338:3156:fc44 with SMTP id 98e67ed59e1d1-33b513758bbmr187306a91.18.1759855580227;
        Tue, 07 Oct 2025 09:46:20 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:c285:14a:3e06:9c08])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099ad9405sm15548751a12.10.2025.10.07.09.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:46:19 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: set default valid_thresh_ratio to 80 for zoned devices
Date: Tue,  7 Oct 2025 09:46:14 -0700
Message-ID: <20251007164614.3631594-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Zoned storage devices provide marginal over-capacity space, typically
around 10%, for filesystem level storage control.

By utilizing this extra capacity, we can safely reduce the default
'valid_thresh_ratio' to 80. This action helps to significantly prevent
excessive garbage collection (GC) and the resulting power consumption,
as the filesystem becomes less aggressive about cleaning segments
that still hold a high percentage of valid data.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 24e8b1c27acc..6c4d4567571e 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -25,7 +25,7 @@
 #define DEF_GC_THREAD_CANDIDATE_RATIO		20	/* select 20% oldest sections as candidates */
 #define DEF_GC_THREAD_MAX_CANDIDATE_COUNT	10	/* select at most 10 sections as candidates */
 #define DEF_GC_THREAD_AGE_WEIGHT		60	/* age weight */
-#define DEF_GC_THREAD_VALID_THRESH_RATIO	95	/* do not GC over 95% valid block ratio for one time GC */
+#define DEF_GC_THREAD_VALID_THRESH_RATIO	80	/* do not GC over 80% valid block ratio for one time GC */
 #define DEFAULT_ACCURACY_CLASS			10000	/* accuracy class */
 
 #define LIMIT_INVALID_BLOCK	40 /* percentage over total user space */
-- 
2.51.0.618.g983fd99d29-goog


