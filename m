Return-Path: <linux-kernel+bounces-737382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA93B0ABBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 23:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC2B56460C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D922127A;
	Fri, 18 Jul 2025 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5sbT42m"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5869421D3F4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875410; cv=none; b=h9i2IDZI5DJkGET1nebb0JnQZul+bS/Cg7dXxwkK/dEJfROug2/6FWP1c0FNvjYstmDN9srqGbjq73klM6dW4zXx6iYYIbUapxbmkewVpl+it/qdTMk48XElH6Kxzz6sJIOdE8piKmkJUJAEvnRy+POakKG0khGeKN2aU9hXr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875410; c=relaxed/simple;
	bh=AUkUsf/KFg817SmSNb973yO/40vdrf1JQ3SgHxi6d6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5dx/dYyBAacbYFiMUEbGIGXoeDmTJ3wgiyPLOHQuV9nCtEqxW0H+6lYWM6A0VhCUmp7ZbiEOQ9P/QxsLtBOoa0NQSWXkd8YIYPdEGOvJ/i6mKj08Ljmm5x/vC0jeRIoUHnVCgiLfDKkm14wlDENmdfOHvAdGg2QNEW09jGJSbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5sbT42m; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-74b50c71b0aso1504013b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752875408; x=1753480208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vkMUMoA1UivzBLhqZ+bzZIQ12HlKF5zuA3g0fn0IJSg=;
        b=H5sbT42moAAosFwDZVHzPx6mHXHcQzmWVXD6Iy91pzg5u0I9vWZmbH/tSk5Jcp4/D5
         SZKt7nZz3Ox5oaR8IpdzFW2q0he956NXNPpEMWbQXsX9y6cMr49JpUspZ2MWJyqZCvb8
         L7RR1y9qD04luq4fdtTzFzDnj4keOxpflrOaqQCf6SSX88DcpvwJt939T4Nkdl0NQjvJ
         SVSfcECIrnG+dFY/H4JCY3afc9PKekBA/JzAZK8uupN5rdxGXWrc0wFrVWBJJs7CCIFh
         Uu1Ds38pCCHG9VujJkPWQeKBWT+SUPLVDap/242fRETWKX0Knaxxsuv8gGkh5yWV4aCX
         iiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875408; x=1753480208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkMUMoA1UivzBLhqZ+bzZIQ12HlKF5zuA3g0fn0IJSg=;
        b=p3uTDAuPz1tNpRWyZjCKDbRyIIg6wzKzN4U/BvOqUtTPj7e+qN/A+sq/7ZpOjOWHnH
         CdFycMNshrbjH8TsX6hTDMV4voOXi2N38TXq0AYjLgH1btny2Mq9lsI6xtOiqxRopU8v
         jF2bxC+BohvyRbWYSoNuMfdJANaxIS/PS3mVMz/Dz25vAE9d2jP28GkO+ghU/v6/7XmS
         5olanKYFhOgVzmZA/m8jipTIoaHwNvIKIXnHcbejggoqN6Mx+gR30aIxyxfHw/rbjDQB
         vZzVQWBAVpcypRzrrJ2whcMazlnGYnKnpkC0ifg8nalwmZZLxQOpngGCQmkRwX1U4Kh2
         kpVQ==
X-Gm-Message-State: AOJu0YxydTNvrKqy/rT0WPm0Vn24uew37pyJPOjfTnWVg5upuJQ1eFZt
	h+Cs6XKfXBqiGUkH6N7xMgSpdlPdhWirlWogFXbLo/iNEnfbytjCMYzSN+qi2A==
X-Gm-Gg: ASbGncublDw9gejXVpKtKEuonTTW5dQyp9N9jaG9DhL1HpNcAzeHEMZCfcCt8MNACWb
	hwTXdKmpxPlvi/qgRx81QWLEUd7yBNPx8YYuuM406gIYsRSoJ1h8xEEQifhHzlpDvn6ZABzqMKt
	FpIFd6asVNYhNiCZgxqNgZ0fh7o3v/njIBEVwLKYX9tIGmjus3d+91SworNpF/qi3xAoY/z6fjx
	htTkxefbWvfziWMjb6LnEBrT3emB9b/nhU0v3lOcGNGIvwUZc99MtZDxL8ki+sFbcHKFo5Mj2hV
	zZz5JsMI5vGQtCV6jFOBWUTiqNnXwPzEZhHbggirv87n5Hd1R2TBAh8JSJ2UQSBOHVxXGxWSil0
	ktWBuxs+EMZB9WKj1RKLfZr/ZF2BRMV1gHfO27Pc1UHidSOUBbY6tCLmezrYr5SaqAmq6ceyPSa
	pRFGUlM3tGoVr25A==
X-Google-Smtp-Source: AGHT+IFVZlkWS40fPv2xMRzPGNdRd58qU6Vif92LpMuLo3svyO4zJnooHC4ZMgfo8z7+w3Goti4Eaw==
X-Received: by 2002:a17:902:ef49:b0:235:779:edfd with SMTP id d9443c01a7336-23e25759752mr173198155ad.39.1752875408325;
        Fri, 18 Jul 2025 14:50:08 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:902e:59ec:cd2a:fc00])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6d2dd6sm18156305ad.164.2025.07.18.14.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:50:07 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v2] f2fs: add gc_boost_gc_greedy sysfs node
Date: Fri, 18 Jul 2025 14:50:03 -0700
Message-ID: <20250718215003.2283009-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
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
v2: use GC_GREEDY instead of 1
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  8 +++++++-
 fs/f2fs/gc.c                            |  3 ++-
 fs/f2fs/gc.h                            |  1 +
 fs/f2fs/sysfs.c                         | 16 ++++++++++++++++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 931c1f63aa2e..2158055cd9d1 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -866,6 +866,12 @@ What:		/sys/fs/f2fs/<disk>/gc_boost_gc_multiple
 Date:		June 2025
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Set a multiplier for the background GC migration window when F2FS GC is
-		boosted.
+		boosted. the range should be from 1 to the segment count in a section.
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
index b0270b1c939c..3a52f51ee3c6 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -824,6 +824,20 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		return count;
 	}
 
+	if (!strcmp(a->attr.name, "gc_boost_gc_multiple")) {
+		if (t < 1 || t > SEGS_PER_SEC(sbi))
+			return -EINVAL;
+		sbi->gc_thread->boost_gc_multiple = (unsigned int)t;
+		return count;
+	}
+
+	if (!strcmp(a->attr.name, "gc_boost_gc_greedy")) {
+		if (t > GC_GREEDY)
+			return -EINVAL;
+		sbi->gc_thread->boost_gc_greedy = (unsigned int)t;
+		return count;
+	}
+
 	*ui = (unsigned int)t;
 
 	return count;
@@ -1051,6 +1065,7 @@ GC_THREAD_RW_ATTR(gc_no_zoned_gc_percent, no_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_boost_zoned_gc_percent, boost_zoned_gc_percent);
 GC_THREAD_RW_ATTR(gc_valid_thresh_ratio, valid_thresh_ratio);
 GC_THREAD_RW_ATTR(gc_boost_gc_multiple, boost_gc_multiple);
+GC_THREAD_RW_ATTR(gc_boost_gc_greedy, boost_gc_greedy);
 
 /* SM_INFO ATTR */
 SM_INFO_RW_ATTR(reclaim_segments, rec_prefree_segments);
@@ -1222,6 +1237,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(gc_boost_zoned_gc_percent),
 	ATTR_LIST(gc_valid_thresh_ratio),
 	ATTR_LIST(gc_boost_gc_multiple),
+	ATTR_LIST(gc_boost_gc_greedy),
 	ATTR_LIST(gc_idle),
 	ATTR_LIST(gc_urgent),
 	ATTR_LIST(reclaim_segments),
-- 
2.50.0.727.gbf7dc18ff4-goog


