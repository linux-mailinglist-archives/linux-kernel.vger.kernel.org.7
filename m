Return-Path: <linux-kernel+bounces-748414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04ACB140E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D261895618
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB827465C;
	Mon, 28 Jul 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeOwk1Iq"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49D3273D6E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722279; cv=none; b=OBkaLVHSKEvn71RLpdzybOMFto/Gf+XRTKzFOC0EvBRRDftaEcbilZy6Dtcc0/5zaUxFpBD93ApFfG1edYwXvY8sTt9nlUoMI2WspXdzzMK0/0NdSV64U8tRcUaxcyEDEx9i4N9pTT6SPO0dtLoCbokpcmRFK0k/jucNg2i85go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722279; c=relaxed/simple;
	bh=YsTZXuSrMqpfp5uGaioi6BfXNCFCsyEZl89IQIw8erY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UeklaJKw8qY3r0Z7VVFcExZh+qHX4GU2SdnXayt1EFjrxEzARcmhm1Yqm1k0RiHT6tMI6I0IIq+9nPnDuPdZcMFQXy5DIac2JKbNP4uW+JsSZKIkXxFY4H/QJAoSJ6/ULrt8mo64SwPqC/8vXlogBkStChgssWxuqPOCRUAi0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeOwk1Iq; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-31ee880f7d2so1253379a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753722277; x=1754327077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxjc2xR5JFXNirG/cV66jE1QTbUqCpT1C3LCgQSBfqI=;
        b=JeOwk1Iq5Dmm/jDH4LXi/SrVsiSQ/HxLM34fVdCSid7FY5fqeKhLZTbcIhKylbGaWB
         fY4PCs4Hqk5sUmewjtr6ajsCyJdAiJmy+pOuQao3JCfbnrB5KdeQ1SqDZzwEbxrnvXEa
         pvy561zw4VrWwyDW6m6DOwYxLjbk9WU/6P7vDOZ8seb8agdo5lG2vxRS2C7KM2BNw0Fu
         jJQLKaETxdFYuEcRFklQdirU3vHWEpzszu0+qFAW+2cW9oqiz3LWNdNwnHa1Mp0JBSnp
         ju2OUDS8WEGseo6PcK72rk1pTXD+G4Rf7PPyh1q5rEePBaRNGpVhF8hF0MrcxnGpK8Z3
         2Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753722277; x=1754327077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxjc2xR5JFXNirG/cV66jE1QTbUqCpT1C3LCgQSBfqI=;
        b=xTBQ6bt9wbtKMyOK/nsqVIVEowtZodd55UYweHH0Furk3Z0nD2zFosWiHazUIRBW2f
         7x9xjsz5KEFjwX0CmSjAfHg3cf/BGaJYro1F+DOy9Q1IzFMP0qN5+IWYcVzdT54ib8vT
         +lHz5smEJV8/DAUUKjHNggq1E8bs5eqHG560wjV4lKfxh7ZekwQG0xwWzg7b1eHcI0O2
         GBlbfshrU7HCogo5LmRW88RMisoY2/WbOUBjksu5svySIwxutVdISdQvNYdHjL/3t3+X
         zh1Bok4N3hHvRxrQDfb3jXL5hfo+faX+pw8/gjZr88vEPBHMBWrEqOdfOOlWmc2tEUjQ
         c1ig==
X-Gm-Message-State: AOJu0YwdkcqacK7A0jZjseAcFWQv6qanVh/KtKDHh2TGtrR0QSgTaPFP
	qAZcGm6ABUunl2Hunj6p0L3BodJgxCrcZLJ5lp0lmA6ChYX/9Z5Ec8OzYh/Wfw==
X-Gm-Gg: ASbGncuQR4bfkWBs9P+hhv47SCFj3TbuUydjYFVdd9LcWT16NCE/UQjcufu70jK/wSy
	WZt2V1FmX48cZ4LOKKxyZpNYTA9NFssKBbfmn78mV+mrcSrcFoN1fiZHT7s6lvatOePCHYzCoEC
	6q0KyaU97OlQKlUscFGBnISQEY961vbslIDhDEbbyNT+RTqXGJRDB80gfgzDwe2M3dhaXLsSjhj
	UWchPwrt1uFgY6Rl8HQLpVj8FY75N5U9pV/WG9ncrGi8LPR/RhTywcXCqCGAdYZddUNMTyN0sIv
	I4/qFWO1i52OOvCbmLuFu3w7fAGqmWPaYnLUCn3iJRMu7iB5tbbmVYUV2D48tGPE18qybGKCIyi
	XGDFZbKRSJuxSJHQz3VkndCkcVfWbO/d0uXlsjF3NaaDvClWv9AguREUOprDlfHhFxM4+qtcAYM
	7CNDWlmPxEqJkGTthYSdMJiCW6
X-Google-Smtp-Source: AGHT+IH+ndwT3hlDz5e7HfXxFgSwhqGIuulx/XclPHWpH/Y7XNIFRMhBmBr3mp4Dosq5rVN9owcW3A==
X-Received: by 2002:a17:90b:58ee:b0:31e:1311:2033 with SMTP id 98e67ed59e1d1-31e77a1a541mr16931818a91.29.1753722276504;
        Mon, 28 Jul 2025 10:04:36 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:b166:cd51:360c:c503])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e832f8766sm6257912a91.5.2025.07.28.10.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 10:04:36 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: add gc_boost_gc_greedy sysfs node
Date: Mon, 28 Jul 2025 10:04:30 -0700
Message-ID: <20250728170430.1060976-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Add this to control GC algorithm for boost GC.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v3: fix the range check condition
v2: use GC_GREEDY instead of 1
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/gc.c                            | 3 ++-
 fs/f2fs/gc.h                            | 1 +
 fs/f2fs/sysfs.c                         | 9 +++++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 6083119851a6..d6881572c53e 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -869,3 +869,9 @@ Description:	Set a multiplier for the background GC migration window when F2FS G
 		boosted. The range should be from 1 to the segment count in a section.
 		Default: 5
 
+What:		/sys/fs/f2fs/<disk>/gc_boost_gc_greedy
+Date:		June 2025
+Contact:	"Daeho Jeong" <daehojeong@google.com>
+Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
+		Default: 1
+
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index de7e59bc0906..0d7703e7f9e0 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -141,7 +141,7 @@ static int gc_thread_func(void *data)
 					FOREGROUND : BACKGROUND);
 
 		sync_mode = (F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC) ||
-				gc_control.one_time;
+			(gc_control.one_time && gc_th->boost_gc_greedy);
 
 		/* foreground GC was been triggered via f2fs_balance_fs() */
 		if (foreground)
@@ -198,6 +198,7 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 	gc_th->urgent_sleep_time = DEF_GC_THREAD_URGENT_SLEEP_TIME;
 	gc_th->valid_thresh_ratio = DEF_GC_THREAD_VALID_THRESH_RATIO;
 	gc_th->boost_gc_multiple = BOOST_GC_MULTIPLE;
+	gc_th->boost_gc_greedy = GC_GREEDY;
 
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		gc_th->min_sleep_time = DEF_GC_THREAD_MIN_SLEEP_TIME_ZONED;
diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
index efa1968810a0..1a2e7a84b59f 100644
--- a/fs/f2fs/gc.h
+++ b/fs/f2fs/gc.h
@@ -69,6 +69,7 @@ struct f2fs_gc_kthread {
 	unsigned int boost_zoned_gc_percent;
 	unsigned int valid_thresh_ratio;
 	unsigned int boost_gc_multiple;
+	unsigned int boost_gc_greedy;
 };
 
 struct gc_inode_list {
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index b417b655d4e8..3a52f51ee3c6 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -831,6 +831,13 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_boost_gc_greedy")) {
+		if (t > GC_GREEDY)
+			return -EINVAL;
+		sbi->gc_thread->boost_gc_greedy = (unsigned int)t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -1058,6 +1065,7 @@ GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
 GC_THREAD_RW_ATTR(gc_boost_gc_multiple, boost_gc_multiple);
+GC_THREAD_RW_ATTR(gc_boost_gc_greedy, boost_gc_greedy);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1229,6 +1237,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_boost_zoned_gc_percent),
 	ATTR_LIST(gc_valid_thresh_ratio),
 	ATTR_LIST(gc_boost_gc_multiple),
+	ATTR_LIST(gc_boost_gc_greedy),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.50.1.487.gc89ff58d15-goog


