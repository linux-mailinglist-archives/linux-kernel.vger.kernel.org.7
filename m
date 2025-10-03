Return-Path: <linux-kernel+bounces-841830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C81BB8563
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 00:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890434C1841
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 22:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C626F2727FA;
	Fri,  3 Oct 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNHfkx8D"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021934BA2B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759531397; cv=none; b=mVUXQ/PLhZKX1t1k/pZWW7FKLkNlHngGXbaTRP8ittn+8IvnyKePJvftvqFpEN4opxssz9+cC0d3jy4/UoJWu9gHWmvk4bGaD19s8YRR5wy6pMIBDERFlsb0KdxAlSZ6RqjGlLSRp4aITmyGy617sBYx6/dNlmOaV6LaE5ZP2xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759531397; c=relaxed/simple;
	bh=KsRXlEeBindaZZ1g9JVwBE9UsCr4iEvkNT1JmrXyYOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hmo4SPxOnF+Dr+G5gkXLeHaJHdAWL27uokuiYdoh1nEOBuWZurZKLRKq8ow5IUh29ONHPLp0eqOLiJXeSnLnfnWE3FMkNCx7P4MVjzX3zXVl/HxIE1qMoPChGux2FFkR+8ie4v91lRmiFDEMiOYN5SqHnPThJ1ZKq9irzWNZ4A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNHfkx8D; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso2455057b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759531395; x=1760136195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=73KKTecuERpRf7wkrg2QBvVP1Lpgw3hCqJ3lLXULH/M=;
        b=UNHfkx8DnVRC2cLvBdAUHMWX0ar2cEiaFD14wakHSyBIIEU4Bi6X2X44uatJ5QMSpd
         oAyQlGDbD9zcdKRXJlurLKNbiM0p+vAUP4l1bVHFsn63Llh+xvdv7BCxXsxkG2M9z6Yi
         5ODRyYk7+ykMA7nPaB2sOFmlFQR+v7BHd7swg2K7xUClWTUsYMfHYng/2vztveJ2iQHh
         jnNA4ZYywHrOKqMokqgmAwUERt3XwlinUdoRfLIl5HmBg0SVaGYrLxvpa+//jWO4LUYr
         7vhuoEy2BhYRY74htm/btnlVQsbKOLVRAa+wGHsTowrZLtumzc1vR+HIXSVPA2ExUJUw
         CPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759531395; x=1760136195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=73KKTecuERpRf7wkrg2QBvVP1Lpgw3hCqJ3lLXULH/M=;
        b=nvEocC0UcN3XLc0bAoYbQOJ8st+MaObfp0rl3pPOpZ5AMHmAKhy4TZh3d2fe5GMkTh
         EhoQWqSCs/ffQ+EXL3VndlKfcaL5UwFHW/7Tuj8K7U2ehVDi7v8J48Mg5HlV1N3ZpyNh
         epVnT/gW1Oi4LYNhYVWuSSdidtW8RZkdVXeBzyZG9SicrmF5On0pdbVfznhViCJgDpTS
         J3vJbKuRhO/Jv1GwgaurwalpMcRLDA24ZCODnnPHxD/B9GdAXBP0ngC1e8cdbgBJGcKJ
         y5WUwGfml/cxT6WQcGC3T8kGpmnxr3eji8xStlTxV+OHnUGwttLcQ5xiwXvrGMyUezea
         54Kg==
X-Gm-Message-State: AOJu0Yzy0F6NW7E/KO3zzG01EwzAnNnkNHsNi+CdpBY0hGbfOFYmgRfN
	TruO4u6B8ypPh8qgABoirGGdw91tFWvUBXROABe+HKLQKSDYbbvwr7t++3+ey9n3
X-Gm-Gg: ASbGnctn/C67HLNQul0L+LXpqfJ2QR0pbhmbVKlKx8UNF/ahbGOAApux0RHyurcas8P
	uzUUI31UbyJcYDC4gaysUEJzNGl/8JYmGjxK5VnREy2jFexITAkv6SIaDFzVj88CovCtt5xNxnf
	JIfB7dBmPeNq89O3P67Rr/8K80GLleWFbzcaEU/C3aewSAcMGLr89x0IUWdR7SYSB4inLxrdcxh
	J/vYbpPAeer9Lawizo0b1HIoQYw4v8BCUPb5Luc/QvzdOtATqVbfIuKs4LFzFYDyfN1AmJpd8WV
	NhtteMTz+P6iuSfbkv0dAstOAcmCsmPJeIlYquVtPTYzLkF2sOyLqix0dmFBt4PEOPI7mCa15D6
	WUkwlV+LO4IWDpjzPqyQJe7wnxpraRr/zirsUT+3Nd1WcjM/VtJzI1yVDNUsGEa5mJCrzVViQr3
	+z9JnAlno2aKSneAoHWE53nedG9w4z4P8JKJjf5g==
X-Google-Smtp-Source: AGHT+IFmF2n3ezMcatiaTUf9JdwILebZU5INC9IlerHtVCGrAHjw4LULFQFl5t+XHfNHPX1/3SYHtQ==
X-Received: by 2002:a05:6a21:e083:b0:303:8207:eb5d with SMTP id adf61e73a8af0-32b61fb1607mr5806361637.27.1759531394647;
        Fri, 03 Oct 2025 15:43:14 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e7c:8:5098:8942:78be:db30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e6ccsm5861307b3a.63.2025.10.03.15.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 15:43:14 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: maintain one time GC mode is enabled during whole zoned GC cycle
Date: Fri,  3 Oct 2025 15:43:08 -0700
Message-ID: <20251003224308.1948874-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

The current version missed setting one time GC for normal zoned GC
cycle. So, valid threshold control is not working. Need to fix it to
prevent excessive GC for zoned devices.

Fixes: e791d00bd06c ("f2fs: add valid block ratio not to do excessive GC for one time GC")
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 098e9f71421e..88bbcf291034 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -38,13 +38,14 @@ static int gc_thread_func(void *data)
 	struct f2fs_gc_control gc_control = {
 		.victim_segno = NULL_SEGNO,
 		.should_migrate_blocks = false,
-		.err_gc_skipped = false };
+		.err_gc_skipped = false,
+		.one_time = false };
 
 	wait_ms = gc_th->min_sleep_time;
 
 	set_freezable();
 	do {
-		bool sync_mode, foreground = false;
+		bool sync_mode, foreground = false, gc_boost = false;
 
 		wait_event_freezable_timeout(*wq,
 				kthread_should_stop() ||
@@ -52,8 +53,12 @@ static int gc_thread_func(void *data)
 				gc_th->gc_wake,
 				msecs_to_jiffies(wait_ms));
 
-		if (test_opt(sbi, GC_MERGE) && waitqueue_active(fggc_wq))
+		if (test_opt(sbi, GC_MERGE) && waitqueue_active(fggc_wq)) {
 			foreground = true;
+			gc_control.one_time = false;
+		} else if (f2fs_sb_has_blkzoned(sbi)) {
+			gc_control.one_time = true;
+		}
 
 		/* give it a try one time */
 		if (gc_th->gc_wake)
@@ -81,8 +86,6 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
-		gc_control.one_time = false;
-
 		/*
 		 * [GC triggering condition]
 		 * 0. GC is not conducted currently.
@@ -132,7 +135,7 @@ static int gc_thread_func(void *data)
 		if (need_to_boost_gc(sbi)) {
 			decrease_sleep_time(gc_th, &wait_ms);
 			if (f2fs_sb_has_blkzoned(sbi))
-				gc_control.one_time = true;
+				gc_boost = true;
 		} else {
 			increase_sleep_time(gc_th, &wait_ms);
 		}
@@ -141,7 +144,7 @@ static int gc_thread_func(void *data)
 					FOREGROUND : BACKGROUND);
 
 		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
-			(gc_control.one_time && gc_th->boost_gc_greedy);
+			(gc_boost && gc_th->boost_gc_greedy);
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground && !f2fs_sb_has_blkzoned(sbi))
-- 
2.51.0.618.g983fd99d29-goog


