Return-Path: <linux-kernel+bounces-748376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCB4B14068
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAE53A62DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275CB2741CF;
	Mon, 28 Jul 2025 16:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfHJpyvY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153F0218ABD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720602; cv=none; b=OQ5nUi2/OCUbmq0wRcJXpR+R0MLxJkx5IneWNnFVfAVJsIn0d7oYtd5SU0c/ZES3J2InaaPQepuDe9jhtTByu6O2XYFY8ec58ui4d0m8gM7f2EZChGY9NT6ufjxXg5yLFl1fNxzByQhTTZ12xLsYFjV0K1Y3L7FuDNDJ5gEn9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720602; c=relaxed/simple;
	bh=8VZodKc2QyWDfVbTaouqFeMrtJdF1zwd8uan0+w8ckU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8wjUiLSE+oHhIoOyG/fqRjzEjLQuZYiH7djHiwgOFpm/cUlDQEBN77Z9B0ROt0pmpGsuLVoKI8DkPYjMfGHWjRSjITZ+IA0moTg5zeCbnLnWalO33V0rugiYhckfTtsBMxPR2VlNSNnEMrW00SPkCIh8S4RBdU51/kjWSlv5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfHJpyvY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2402774851fso13536305ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753720600; x=1754325400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QJq2TaU8sjz2yL3Ynvf/1AA2Irm8dbMEWpqz4kWL01M=;
        b=OfHJpyvY8X2anu5Zlg4MMKMA5+7UdMr/wepcKb7mE8LvnLdDDOOWZdAveruppRdsdQ
         Pd9+WTzyb0xzLUEbu5BgHwQg/JjlwnSxjzqMSt4FmPS3s+N24iBBfWSP6Y+zWAGdsYek
         evyBS1GEUYh1Rl3YHCpF6+NP/IWafa8yEJ4gjsOUdLSWqHwtT1+pDrigi6INSpS7G1Es
         VrCL/ikOxEvT0HvoUbASi+IeFaucdKOYDnIqagq/3sMtSg2z/qnSdfF96//Pv5iPqHMO
         ytXEu39OVqC3rLj796c8+3CDIY5D1ePjhs/2wGW24Uz7sYDio8jdYGaIpB0SoztNIuBw
         lqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753720600; x=1754325400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJq2TaU8sjz2yL3Ynvf/1AA2Irm8dbMEWpqz4kWL01M=;
        b=ZPsXJyuNe1JnGIpMwJE3hbZ5LVPdWIYqqDpHVymjEv4jqXqT2SFEcZtKsSkBWJKh2+
         EtOeCFjGlpTC91374VfiCWf6iQY62beowPlEQJTts723GxFgHsu/SLyb25mPkYpK5P4h
         4nIRaj1ywU+Wlv2rR2tPsIaM3loPTfSoj6SmptheATEwNHXPSVmGpOEQl+VpdEPsU8xH
         mi1CNV3f03pV1Nhq+Z2Doa5ZNZId4cyNslK9XbMfmGm7GN1REzwYXeaSxqtqF9dI69h2
         FAopTeTKIwMpqFcCxrtlyvITCNTMGYyLO0SCP0Xu8mHAtGJKuNy+qYiipn2lZ2wwc1yK
         MCOg==
X-Gm-Message-State: AOJu0YxEC3dwRwh/LQOE7lzT3gs1yyLokRcHyIvAng2WIr7DtmOflxib
	lMMBuka/NqMwFgBC/O2/EV+44q7tNd6+6QfKlLRUlmMvtvxSgr8qEhsy3pWwUw==
X-Gm-Gg: ASbGnctspwyPaYPahVbtLpEd64Cs0xlCSqbOkMjSRbtu/BFycYONpxQbGybmhQ5wACv
	Dn+wIfYMTTrEDk1WT8YIs/9l2E3tNrhBYs6XiZ3SPlhI4Q/yaGqbKF2EmrrXRhzqD+ODCBeVLF3
	80ombmyCQP/2l0P3Ajv5iNvM8c9SfoluwhQQrGbH0Q0b+BFCw4ic+rB1zcsXNwrKDnDysHfSN/L
	U3BJVuPc7FqBNhykUwyOI2uZ436T5/jNMTnmpfDYAxeOGcy69LXkYzQsMV4t+O/BlbbvCGI1MyU
	Tx36VyguVml6WYeBqQjgeyLrkItwGvdG74PYZQz7mTqhNEfHvtrMHr4/AYxph+dJpfdJow2E34i
	eVnwgH/nqqhWVwSqeBxHSBeZw9YV5PEAdPVJ1LLwrg0UKw5EDfEypVVQ3sna7oqRVgHyiuqoCdE
	wSibPMIdoMhIa2+g==
X-Google-Smtp-Source: AGHT+IEGAK3rQGPwuT5QeRAnpVEGq68xpiS2AvCZbpQqKo2cPrxtkwp+3EiiPpbFDALSAHI80JOEhw==
X-Received: by 2002:a17:903:2451:b0:235:f70:fd39 with SMTP id d9443c01a7336-23fb2fd7c27mr210492365ad.10.1753720599819;
        Mon, 28 Jul 2025 09:36:39 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:b166:cd51:360c:c503])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24008d8e9a2sm35086995ad.142.2025.07.28.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 09:36:39 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: add gc_boost_gc_multiple sysfs node
Date: Mon, 28 Jul 2025 09:36:28 -0700
Message-ID: <20250728163628.1043162-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
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
index bf03263b9f46..931c1f63aa2e 100644
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
+		boosted.
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
2.50.1.470.g6ba607880d-goog


