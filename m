Return-Path: <linux-kernel+bounces-895530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBABC4E391
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B95A18896B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA1D34250F;
	Tue, 11 Nov 2025 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Uw7BhU3M"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9F331235
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868683; cv=none; b=D/f1urAvkwJJDX29FzErDzTBV2kXnk5RKl2ldD+ShcM3dQyZmXL8vuxFmyAaNM/bzNBuiYbE2wAO8ZoweZWD1CEiIvES0LRGrlsgmo/UU4mWQWoe6TsnKFQJSv1CfPGUm0xq8cZTphqTDxYsmrrvZmK2PDsN3W2Yn+gMcqKXhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868683; c=relaxed/simple;
	bh=35g9I8Yb/hg4maMftzejHy/BrNK6ZvWVhKBVl/xDwn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TjPOHq51EVNr4fF0zcKBR4Y8SEQRH4Duc8WlPumzjq5YakZikrUGV2P6hzYzlREkj8MfWLuxoI+6cDqEljeu1azsa5TgBDAy6GUmSENxEv1H0WN7mAp+otaHWyKr5n9KSvaqs2lAziWTFRitCIWfh9jXe+cHNoAs7fkoQWWr07E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Uw7BhU3M; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-782e93932ffso3585377b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 05:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762868680; x=1763473480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jNls6INMU6jsxyZMe3CgvVJTOv7NvVA2mbafVbFewXM=;
        b=Uw7BhU3MU0j/xbfAgNlTaLhCiwKe71Hye0wAIFI3zXQIA7dw9s8oYVf52hqtKU/e/w
         SRu16jkWJDwtBaqaa6PCCrNa0Pb7zKt09a8QwuOEycwU48Q484WvxU508O/wRsGVNvLC
         F6uwNgUc9lWdrZcqDmhVDaYismgwyOI0+2BxYOgijhrckneQB+UzqmPvsHFERxUHBN1F
         s8PRHn0g0Wnealf9zkOgua64NlWCpBPS6dzm19MVOophrSBenZfIs+WMvWbdx+KsVVXb
         Ka8Z7Unc4RYeifh76YIFCrlSauvzqm7QxBACQLR92WmfZjICE4POiyFtweP07080gy/z
         11Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868680; x=1763473480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNls6INMU6jsxyZMe3CgvVJTOv7NvVA2mbafVbFewXM=;
        b=bQWHTP4ThIJFEV+pBQEWavJ30CeRXcRa1TIyIt1Qsw1UDbRXZZmG9zk7sVrYCLNp1H
         Q1pyCQsJTCfx0B3MBTkUcg8Oh2j6p904pER3q0EVjaJ0ydjsmu68KMnGXRzbl/CQYfqd
         mPqMANJNVJlcm1lYSaurX1boIg1yvyRxdYORokx8K7ICzKEfHPB/sOjswWjHhp2j5jMn
         XuiwwzheVsWzTty34RlcnD9Zw/Uz6o6VnJvpgziO+RLM3ebPgRdN9ue9fOL+P0ZOFsXX
         vQGIsq6aeDsq3txxbFQaWJtZwv8vMPprc/Z4Owx/ejqbkPW+ql3rfwwLymJcuXF6Zmmz
         mH9w==
X-Forwarded-Encrypted: i=1; AJvYcCUvyMKL41f4mWikTCjnQy/CJWJc4G2tE7aPrVpVj1CgqeFhQqHYL2Soz9j/TalxQdS4FkbxNLYyqQDa3No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+mhW0I3W8SQFUXvSRJkEJ/VNo3YO2b8nqaj9ut4FX+9wVnZY
	CBofQnlX60UME2n2VmBiFn4L2zkQw2HE+Vd1DbO445rxgf+LBnN7Mey1M6FRdeZzsRE=
X-Gm-Gg: ASbGncuTI2271X1gaJLqMwFhJdkqjphbdRT9O0JFBYac9tybGztHmK8+YmJq4H5lXAe
	+qyNN/w5Xz0dwqf/xVEs/NLnxn17tIaamq0/jvW3uTxosCPuSmhBpGSURspTj719sCUebEG48rd
	NVcoE69zUwwakkbZl5ZrbLUebfxAhI+xa3dPn3Fy1Tcng29pbvzqSy9ry8vImtdd9iaH8SM4hy9
	6BC7RU2leGB1RoU14V48oBiAYaEsMFQk0lCyOqABARQaJ8s+MLPWIUMEqASU0imArb+ZmEoye9D
	zRJb6pBfBIstlI1W22hzMnc6ITR9Nr1gtk4CNHzK8jGOX+N0mKs0GSTDE66ILGdlltndmKETyOu
	pjzT3bj+7HkIzR6R3L00/s4cidW5PBvTCABg9t0vm0mPEYgAQ4b7qXb3hboOAmmc9bNq0Ojnge5
	W+FiE1RTlFlgyvBau9NMsxOT+mApJ0XLf/VGgiVPFINxgmAuA2Bg==
X-Google-Smtp-Source: AGHT+IHVprBtd3SLMYC24KqamhEauYMeVGyVRUgYiCi6o4kUbc1FsyNW+cFWnBqsD+7zVZokvRrhLQ==
X-Received: by 2002:a05:6a21:4ccc:b0:340:db9b:cffa with SMTP id adf61e73a8af0-353a11b1731mr12268324637.9.1762868679966;
        Tue, 11 Nov 2025 05:44:39 -0800 (PST)
Received: from K4L2F221J6.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953e2a4sm15772351b3a.6.2025.11.11.05.44.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Nov 2025 05:44:39 -0800 (PST)
From: Wenyu Liu <liuwenyu.0311@bytedance.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenyu Liu <liuwenyu.0311@bytedance.com>
Subject: [PATCH] cgroup: Improve cgroup_addrm_files remove files handling
Date: Tue, 11 Nov 2025 21:44:27 +0800
Message-Id: <20251111134427.96430-1-liuwenyu.0311@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now cgroup_apply_cftypes(cfts, is_add) with `is_add` false
will remove all the cftype files in `cfts` array, this can lead
to some unexpected behaviors in some abnormal situation.

Consider this situation: if we have two cftype arrays A and B
which contain the exact same files, and we add this two cftypes
with cgroup_add_cftypes().

We can correctly add files from A, but adding B will delete all
files previously added from A.

When adding cftype files of B:
cgroup_add_cftypes
  ->cgroup_apply_cftypes
      ->cgroup_addrm_files (failed with -EEXIST)
  ->cgroup_rm_cftypes_locked (this will delete all files added from A)

Even worse thing is that if we add B again at this point,
we can successfully create these files, but there will be two cftys
nodes (A and B) on the ss->cftys list at the same time.

    ss        A|0|1|2|3|...|   B|0|1|2|3|...|
 +------+       |                |
 |      |       +          +-----+
 +------+       |          |
 | cfts |<-->|node|<--->|node|<--->|...|
 +------+

This will lead to all hierarchies that apply this ss controller
to be unable to create any directory:
cgroup_mkdir
  ->cgroup_apply_control_enable
    ->css_populate_dir
      ->cgroup_addrm_files (will return -EEXIST when handling node of B)

Add a new flag __CFTYPE_ADDRM_END to track the end cft if something
wrong with cgroup_addrm_files() add files, make sure we only remove
the cftype files that were successfully added.

Signed-off-by: Wenyu Liu <liuwenyu.0311@bytedance.com>
---
 include/linux/cgroup-defs.h | 1 +
 kernel/cgroup/cgroup.c      | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 93318fce31f3..7ad98048ca23 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -144,6 +144,7 @@ enum {
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
 	__CFTYPE_NOT_ON_DFL	= (1 << 17),	/* not on default hierarchy */
 	__CFTYPE_ADDED		= (1 << 18),
+	__CFTYPE_ADDRM_END  = (1 << 19),
 };
 
 enum cgroup_attach_lock_mode {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6ae5f48cf64e..0d7d3079e635 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4453,13 +4453,13 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			      struct cgroup *cgrp, struct cftype cfts[],
 			      bool is_add)
 {
-	struct cftype *cft, *cft_end = NULL;
+	struct cftype *cft;
 	int ret = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
 restart:
-	for (cft = cfts; cft != cft_end && cft->name[0] != '\0'; cft++) {
+	for (cft = cfts; !(cft->flags & __CFTYPE_ADDRM_END) && cft->name[0] != '\0'; cft++) {
 		/* does cft->flags tell us to skip this file on @cgrp? */
 		if ((cft->flags & __CFTYPE_ONLY_ON_DFL) && !cgroup_on_dfl(cgrp))
 			continue;
@@ -4476,7 +4476,7 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			if (ret) {
 				pr_warn("%s: failed to add %s, err=%d\n",
 					__func__, cft->name, ret);
-				cft_end = cft;
+				cft->flags |= __CFTYPE_ADDRM_END;
 				is_add = false;
 				goto restart;
 			}
@@ -4526,7 +4526,7 @@ static void cgroup_exit_cftypes(struct cftype *cfts)
 
 		/* revert flags set by cgroup core while adding @cfts */
 		cft->flags &= ~(__CFTYPE_ONLY_ON_DFL | __CFTYPE_NOT_ON_DFL |
-				__CFTYPE_ADDED);
+				__CFTYPE_ADDED | __CFTYPE_ADDRM_END);
 	}
 }
 
-- 
2.39.3 (Apple Git-146)


