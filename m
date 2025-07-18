Return-Path: <linux-kernel+bounces-737389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E204B0ABE9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 00:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF6958769D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A621FF36;
	Fri, 18 Jul 2025 22:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIcF68u/"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B517CA17
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752876281; cv=none; b=jXb23uuZ8o0sHgwWrjyYGvtDKyq9ImrqVxDP6Sq8A/kS1Rko7/jBWWrJydZDncvRtisgF4C9d/HqC3bS9wCBxQ7jxU5AYwBXiWBzt4bvCse4n2OwOg1l72j23dsDFolI0WVegSQ1Qc7dsQNqJHwb9vZZY1RkZXUC1H3MDrEptQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752876281; c=relaxed/simple;
	bh=3DjuYLXtAsYQlyObqLWduTsvcR7X0g0x/sJxh6ampsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPoH/SIZrHxvA+nuIW6Gt7FmxQYL9g4KR749WxTaCF3twd+8JCeJplCtB1c/FmGeMTlnEB3O/47tbEu7JPUkumwa4iBgp6m1WIWA3my2JMy24oPX0V4T0Wfsx96+m4CUlk6PeSt6QTLcatCQUzLTiPIXSY/RF/Iuwbdsob70hM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIcF68u/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31e076f714so2586424a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752876278; x=1753481078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cotPtNUE4rLZJyYjdxBKbaVvjccEgnkQtK9k7m4RQqQ=;
        b=FIcF68u/9eGO9wRqhQsAGtfflBY8kfbl07+EjcODDALI8r4+aWkPb4oZ8Trmc9s78u
         H9TKJ44pKW+H73mTRlAMacmC7TRdoxShzZvrsrhnRowGrOhYGAaobA4waH6KNC7QVx5O
         5NWIZSHdKuTWo4GQEm6W8t0km0y2JZX2JeVwU19WrQDuZziwx3FYtSmYfRdcNXMIacD6
         66smxVAAi7AX0jxmf090BDMyUPCUIWOzULkqx6cPMk6UHe2Ri7lW4qlt8LcjtjeoTrgo
         J7SGpnWNK9g9zcZ1DKcGsVhyHt/eTnbBuqNv9bHRQQyc0Oq6zN2qadhXneIhT/XivdAJ
         3Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752876278; x=1753481078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cotPtNUE4rLZJyYjdxBKbaVvjccEgnkQtK9k7m4RQqQ=;
        b=aXq4uxpXjXFypfGu2FprzvTsPXUFON+ZEsLbDYf9RpwSK1IGl40UEc5Lh5Km2heu/a
         QzrhUqN/dl6A/wHbYVRxJQJevWUKL8O0LQ/0k2frmNON0OODt84juH81pRKzu4KN5adu
         sFRZvi7UDS2TZP3gPy0l/QHj5NzgK8m18z7Yqla8XZJvmOD4v+HJ9Mh62g4RKFZhkZTF
         wPfLy2BAJB1p8RXikja9EJK1ZTYqQGUAn71IuHMsciKMfFW4LJ342lur2hEN+OR8flVW
         UKlRH97XdQAUqUOd4V2V/A+MAaGEu1b0WJMxCSHXkWo2e3xARQX8Twc1P4sq4DhIH9gG
         rqAQ==
X-Gm-Message-State: AOJu0Yz5xrSbPgRSh3jy0wN8tUpZWWzFyabk2G+HXV8kkRMpqCuXe0Vv
	M22rT/EuWl4m2Aahjq91sxka8SQ0DykY517P3/YXPbJRf7tC3NXTO7fTYm5LmA==
X-Gm-Gg: ASbGncsLV34q47HWOhVbhxEVY2XyHZTcb77Ct2SWem1eaZCRIe1wYoaRL1Cne7nvInX
	MPKlTqtZ9lIyNVh0DzfPEe3+dun6ym/I8NL3aZy4Y1Ke/2p7TotRVYLOAJapA0uhQ1k3kOUQFZA
	0Qd61eQkX1xpM1RVQGlQVukWowyEQR3t/qJ1ttU2VaB3Kdd0VOTWtOXUKK1cXtcb1c3uEFKf2ku
	iAPnpo3zfglTkqo6Ve9ZXsW3WY46jCNsQs6NyWJ5xu9Xnnl0VR/uyI4I4BW92eUEzfaWBzox5Ov
	WVnPTWE/FuQDG9UmxyY8K9IYwIMwAXmsxtntjPXNDvQBA/ge9DlOep3nX1oQBZC0pAWL+ZMSe2x
	PSogWwqKd7kUdLooiTmVfBe1KN9SbXNby7COX+oqG/74wzF2ELBd04/R/eCLkW9SDQVTnZfmGW3
	Q5y6UzVGB62sRwog==
X-Google-Smtp-Source: AGHT+IGQbuSHZnDK57D7JQm+lc791tZ8jnltH/uC9vUd5j5mSXBQn7TT7sy0xz1SYBKQti0d5gN9Lg==
X-Received: by 2002:a17:90a:e187:b0:311:482a:f956 with SMTP id 98e67ed59e1d1-31cc03d9906mr7010038a91.5.1752876277557;
        Fri, 18 Jul 2025 15:04:37 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:902e:59ec:cd2a:fc00])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f46ffdsm1847494a91.40.2025.07.18.15.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 15:04:37 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: ignore valid ratio when free section count is low
Date: Fri, 18 Jul 2025 15:04:31 -0700
Message-ID: <20250718220431.2290301-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Otherwise F2FS will not do GC in background in low free section.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/gc.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 0d7703e7f9e0..08eead027648 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -391,14 +391,15 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
 }
 
 static inline unsigned int get_gc_cost(struct f2fs_sb_info *sbi,
-			unsigned int segno, struct victim_sel_policy *p)
+			unsigned int segno, struct victim_sel_policy *p,
+			unsigned int valid_thresh_ratio)
 {
 	if (p->alloc_mode == SSR)
 		return get_seg_entry(sbi, segno)->ckpt_valid_blocks;
 
-	if (p->one_time_gc && (get_valid_blocks(sbi, segno, true) >=
-		CAP_BLKS_PER_SEC(sbi) * sbi->gc_thread->valid_thresh_ratio /
-		100))
+	if (p->one_time_gc && (valid_thresh_ratio < 100) &&
+			(get_valid_blocks(sbi, segno, true) >=
+			CAP_BLKS_PER_SEC(sbi) * valid_thresh_ratio / 100))
 		return UINT_MAX;
 
 	/* alloc_mode == LFS */
@@ -779,6 +780,7 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 	unsigned int secno, last_victim;
 	unsigned int last_segment;
 	unsigned int nsearched;
+	unsigned int valid_thresh_ratio = 100;
 	bool is_atgc;
 	int ret = 0;
 
@@ -788,7 +790,11 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 	p.alloc_mode = alloc_mode;
 	p.age = age;
 	p.age_threshold = sbi->am.age_threshold;
-	p.one_time_gc = one_time;
+	if (one_time) {
+		p.one_time_gc = one_time;
+		if (has_enough_free_secs(sbi, 0, NR_PERSISTENT_LOG))
+			valid_thresh_ratio = sbi->gc_thread->valid_thresh_ratio;
+	}
 
 retry:
 	select_policy(sbi, gc_type, type, &p);
@@ -914,7 +920,7 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 			goto next;
 		}
 
-		cost = get_gc_cost(sbi, segno, &p);
+		cost = get_gc_cost(sbi, segno, &p, valid_thresh_ratio);
 
 		if (p.min_cost > cost) {
 			p.min_segno = segno;
-- 
2.50.0.727.gbf7dc18ff4-goog


