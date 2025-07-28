Return-Path: <linux-kernel+bounces-748402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02233B140B4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2932541C38
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1588D277CBF;
	Mon, 28 Jul 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et1TsehV"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F858283CB5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721155; cv=none; b=cLs4aNBoUnZ/X/Lk16RP7MVu2OWPowgazxClpS8AuHECXlr9GWI9kmXbcbYkNe0LQxZXgkC9UbUCCex2ZzCVDUCDuniEMokaxDdG9b0Oym77QcqlGOD7H8RtGO/rVg51agpxiZrE+VaT/HNa2+5tvaF/hDdmSGD0h8ZAogz21AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721155; c=relaxed/simple;
	bh=8ZN2hSIX3WSrGDx4AF6jNVSH1YVwtDRZMihEAqn7KxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obkIZ7hgEcukK/B0CfsKs+i83oe08kuXtCsGCCSrRmuizyyWmRSNb0QaWZFtq6SEF3eIFNHMxRVbNd1ywtuRz5sko60WXyN3hoE5ehP7tnyu5/HodrHr5GADbfTtYpSGLPAD1NMSrRwhcmQmz3cWpWHHKoumT1SSsm1JP7NMt6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et1TsehV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7490acf57b9so3109146b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753721152; x=1754325952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M1UZzt0XN01fsU2MzjSe2LXAiJeLQpYEWrArpijkKzw=;
        b=Et1TsehVRV9Mr2B/gbZgNC+BVOo1DWw37VPtm9wwSAn1lZRtKViF63mGB3mxSklwwk
         02g9wUD9JaLih6WSwrOmNXoG2G+EZcREbQL6WGBBfjCYieZW76S+VK+Zx18mZFxeDfvy
         8WR8Q73Mjv1Jj6ml0vI/7yntNPg2Znzi9eEZUhkG48LJgHMxehK5V+V5RvLr5+hIJiof
         M//K0nk6ZQNlkjMGNx74cdoYHVTA9l+HhkTqbzeSnv+8gHtaLQsjUdaSXndEuqQ5zoA4
         +oUfWWEnQiXN+7BV26In4+U9dH/+QP+GxwRWIQa0qlQ87nyCCmWftPR7qmyp5ZgwQBiu
         Givg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753721152; x=1754325952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1UZzt0XN01fsU2MzjSe2LXAiJeLQpYEWrArpijkKzw=;
        b=tk+GFKLJmuQAenefHxFPDzH4B7UvJw6yjF6t8BZESQBVc95773QOnB0i+x5ku126Cq
         yiGuZ57Ieattn2nfY6TyGeiC7wZ1K7ftt1umI/nv5qAGMqF5FMLwL32Vqhox7JsUP6/V
         2ux8fo0Sw4lYL3zBQQ2F4wCDCVNsfS0PJLN/eQ74P4JmJTirzQ3qvc/RSpkSGx62Ysk0
         QCzPaUUjmDkCKa6IYRA7hW1gucSx/Z7Q3IArLgi3J4qn/86XGIkb99Uvuh4zxnCpoQw9
         K0x47NLPywGEZZZBUYh3yw0Qt950JYnuKFi0d/UZMQeS9Uo5XaHX+xUJqOzjKism1jKP
         ZkxQ==
X-Gm-Message-State: AOJu0Yw/TfHx0neQUWxTdTnvrrpgPEanaTYeHs359qXnTMKjtQDwsOjs
	struex+0anCD1Lr1OI6qBsnyytwKTbOp4R8zXcYRD6dQSvx1pAj2kecX6MAaoA==
X-Gm-Gg: ASbGncv1O4awA9Y8rRpLZfS8XaUmcmQUf7LtJ/aWmyXNuama1E+jA9bSvBTGnkn90/5
	JVXB5jtK0CsaKwZHQ/1h9sGnkJ/zb6UQVMJao2nkthOqUGldqtYbCBj82lzCYWeH14I4bqvMR24
	8KjSUdJQL4q9S2xQdfecAI/rdPCVUk7AnabmkoI2C5j4ESbUl87I3e7Lv4pFi+JIbY9yUEKoOtC
	lZWj77gTFbXGj+cChex9xT4jR+58oejKx+GSkCdkwwQ97mJLUfPB4+FV8fXJu64j8nhCVoqZMHq
	jsD+8u+22B228c307qDZD5AsrbuTPb1A7xw+ybjTX8dRmokKXdYeg9EdiIM4bexkGTC725snOsG
	BGOva78fC4ovSQMQEI8+BR1xz9PpJnzoa0u/Jh2nRPxi34P4Isp6uKPa0DNx1P1vedP+iqIMD/9
	+a8RtCvOMSHpjfhA==
X-Google-Smtp-Source: AGHT+IGPVtNIjYRbrfjW1HFVFLTh3xg8CElN5fno8fDplcWQzNyOkR6FKiFJhTUf8EkWVhNnKlE+Pw==
X-Received: by 2002:a05:6a20:3d05:b0:235:86fd:cc99 with SMTP id adf61e73a8af0-23d7015a52amr20618828637.24.1753721151597;
        Mon, 28 Jul 2025 09:45:51 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:b166:cd51:360c:c503])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23ffa37f078sm39289475ad.115.2025.07.28.09.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:45:51 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: add gc_boost_gc_multiple sysfs node
Date: Mon, 28 Jul 2025 09:45:44 -0700
Message-ID: <20250728164544.1051653-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Add a sysfs knob to set a multiplier for the background GC migration
window when F2FS Garbage Collection is boosted.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v3: fix the range check condition
v2: limit the available value range
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 8 ++++++++
 fs/f2fs/gc.c                            | 3 ++-
 fs/f2fs/gc.h                            | 1 +
 fs/f2fs/sysfs.c                         | 9 +++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index bf03263b9f46..6083119851a6 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -861,3 +861,11 @@ Description:	This is a read-only entry to show the value of sb.s_encoding_flags,
 		SB_ENC_STRICT_MODE_FL            0x00000001
 		SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
 		============================     ==========
+
+What:		/sys/fs/f2fs/<disk>/gc_boost_gc_multiple
+Date:		June 2025
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Set a multiplier for the background GC migration window when F2FS GC is
+		boosted. The range should be from 1 to the segment count in a section.
+		Default: 5
+
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3cb5242f4ddf..de7e59bc0906 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -197,6 +197,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
 	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
+	gc_th->boost_gc_multiple = BOOST_GC_MULTIPLE;
 
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
@@ -1749,7 +1750,7 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 					!has_enough_free_blocks(sbi,
 					sbi->gc_thread->boost_zoned_gc_percent))
 				window_granularity *=
-					BOOST_GC_MULTIPLE;
+					sbi->gc_thread->boost_gc_multiple;
 
 			end_segno = start_segno + window_granularity;
 		}
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index 5c1eaf55e127..efa1968810a0 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -68,6 +68,7 @@ struct f2fs_gc_kthread {
 	unsigned int no_zoned_gc_percent;
 	unsigned int boost_zoned_gc_percent;
 	unsigned int valid_thresh_ratio;
+	unsigned int boost_gc_multiple;
 };
 
 struct gc_inode_list {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 75134d69a0bd..b417b655d4e8 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -824,6 +824,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
+		if (t < 1 || t > SEGS_PER_SEC(sbi))
+			return -EINVAL;
+		sbi->gc_thread->boost_gc_multiple = (unsigned int)t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -1050,6 +1057,7 @@ GC_THREAD_RW_ATTR(gc_no_gc_sleep_time, no_gc_sleep_time);
 GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
+GC_THREAD_RW_ATTR(gc_boost_gc_multiple, boost_gc_multiple);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1220,6 +1228,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_no_zoned_gc_percent),
 	ATTR_LIST(gc_boost_zoned_gc_percent),
 	ATTR_LIST(gc_valid_thresh_ratio),
+	ATTR_LIST(gc_boost_gc_multiple),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.50.1.487.gc89ff58d15-goog


