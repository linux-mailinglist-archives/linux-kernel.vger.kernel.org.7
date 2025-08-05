Return-Path: <linux-kernel+bounces-756031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC0B1AEEB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F04A620F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6401E230BE4;
	Tue,  5 Aug 2025 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GyjPm8jo"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2A2264B8
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376925; cv=none; b=MCtqoxwn/N9KaBpmMcGdZHh5l1bmtrU8bNqOx4T8FEdn/VTYFtnfYvxcrhnF6TAIzXiHAOf0DfaQ9VETCpuouKMeeYChazOye/wZWyLlZvvSVg/coFcxYFrOjrIzvM1j3nMl5msQExYi7QGtQURZ2y5fmE33LmHt5sxudi4Olnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376925; c=relaxed/simple;
	bh=mW94YNphCeMDCqeSKUMhIoQuVsakToAJfrbz1O1/Yjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ix1dSPqYvFCf51+TR3Vv+uYAfzNpnXfX4/nAWRGaVITG9dMS8qAp9GC0A+GKP+8Z2i/6ZmaSlShYOoIjNmN34v94TtrGZl1WSse7kDVdJvFG5y5AIleiNT8cGktCNK6jUiC9pVF//olW3Xi+ZZXjOCg0j4KVZn8nAAIY+rvTkLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GyjPm8jo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3215b3229c7so216245a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754376923; x=1754981723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGnjhlkr58/FOajbxu7sCyHuJOVEyicbJJHbor5PpZw=;
        b=GyjPm8joG8RugfUaITZXQCULPzi7uLiXiWT7LolXXSgxslnXievth9CQNlvbgmYE5G
         cV/SZ2cOk3+zRY1AIuYy7T+rtaHcDhj5Q8j42YaMqXCVLXgW8dK1V1Vx9fnmNTDXzYqQ
         SbZKDClgka2tJj+TT85xZ8eGVBr5qtIEA/0wqHrmXleMm6AWfNZepcf1g0KNXF/r4M8N
         HTXtMOLyDEQ7RdhTZMCvVqMkFtdjiIp7+WTUlqEpyqOqczxPFJGZBhBiFBEeWz0EuIay
         S2GfM4/gA4x/5osAMIkY+kt6WoK1uBHF7uXna3piEnhquUkDPO2BfoWnILv0CEWgNC1L
         ckOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754376923; x=1754981723;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGnjhlkr58/FOajbxu7sCyHuJOVEyicbJJHbor5PpZw=;
        b=WhyJvGfDOs2vz57vsb2LlXSiZtoW4Z0pIwIYo2cBVcgwbcpZ8PeTJ3SzTLuaSyZbUJ
         EVH01qz0wLgctfuGbQV7dMOnoDdWFdPolA1UjyKBoJKmmHaxSDjaUi0nL/rn3qc0L4R2
         OWvpxkgdoBNOFzvxl/gYof+HhcVQ7A9EYyjV5+um/NTbdy9jOAdiQvmazEHlGBHuY+Hn
         ShqukvKGnSqL6jND5IkyP4kFCMca7BzNjzq7Qr7UK9+Vf1gd+BmJFUOnd1ztDIhwknmT
         uyCWl1FGO19/uzSEGUxK9MdU8LTsJdDoGhI0r+MsTtQn5qH85z84XBzmGn6ZLCdwgx7f
         ewug==
X-Forwarded-Encrypted: i=1; AJvYcCWnOJQJiwKDzyfX+RLI+0aEYWE5jShRRSBvqmqIFJs71oz1zYTlN3xP9IDE4iIs3VX9X9stejMV/wNgHgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPbWjEKowzsCGFZM0JHauz9aHXXhPI27Y5ix8nc4q5LKjqvwwN
	trQeiUguRqTvUKurZeA/p94DSAWxOm9iLccZv8DkBk5R0Gg4LrX5MmRPZaS3Qt+zIYOwIhh3/bm
	MlzzhtOOxvA==
X-Google-Smtp-Source: AGHT+IHiu4DhHhvqRwnRV+7sEMgNrWuou7jXyKKVTJWIaRvXuvPn5nPcl5lKq7G3lUXODl1vhwiF8Dy9CJ5P
X-Received: from pjbqn4.prod.google.com ([2002:a17:90b:3d44:b0:31f:1a3e:fe3b])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c8b:b0:314:2892:b1e0
 with SMTP id 98e67ed59e1d1-321162e56camr15849803a91.34.1754376923165; Mon, 04
 Aug 2025 23:55:23 -0700 (PDT)
Date: Mon,  4 Aug 2025 23:52:27 -0700
In-Reply-To: <20250805065228.1473089-1-chullee@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805065228.1473089-1-chullee@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805065228.1473089-2-chullee@google.com>
Subject: [PATCH v3 2/2] f2fs: add sysfs entry for effective lookup mode
From: Daniel Lee <chullee@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Daniel Lee <chullee@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit introduces a new read-only sysfs entry at
/sys/fs/f2fs/<device>/effective_lookup_mode.

This entry displays the actual directory lookup mode F2FS is
currently using. This is needed for debugging and verification,
as the behavior is determined by both on-disk flags and mount
options.

Signed-off-by: Daniel Lee <chullee@google.com>
---
v2:
- show "auto:perf" or "auto:compat" when lookup_mode is 'auto'.
 Documentation/ABI/testing/sysfs-fs-f2fs | 15 +++++++++++++++
 fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index bc0e7fefc39d..ce189acd1908 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -883,3 +883,18 @@ Date:		June 2025
 Contact:	"Daeho Jeong" <daehojeong@google.com>
 Description:	Control GC algorithm for boost GC. 0: cost benefit, 1: greedy
 		Default: 1
+
+What:		/sys/fs/f2fs/<disk>/effective_lookup_mode
+Date:		August 2025
+Contact:	"Daniel Lee" <chullee@google.com>
+Description:
+		This is a read-only entry to show the effective directory lookup mode
+		F2FS is currently using for casefolded directories.
+		This considers both the "lookup_mode" mount option and the on-disk
+		encoding flag, SB_ENC_NO_COMPAT_FALLBACK_FL.
+
+		Possible values are:
+		- "perf": Hash-only lookup.
+		- "compat": Hash-based lookup with a linear search fallback enabled
+		- "auto:perf": lookup_mode is auto and fallback is disabled on-disk
+		- "auto:compat": lookup_mode is auto and fallback is enabled on-disk
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index f736052dea50..82489c78aeda 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -281,6 +281,22 @@ static ssize_t encoding_flags_show(struct f2fs_attr *a,
 		le16_to_cpu(F2FS_RAW_SUPER(sbi)->s_encoding_flags));
 }
 
+static ssize_t effective_lookup_mode_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	switch (F2FS_OPTION(sbi).lookup_mode) {
+	case LOOKUP_PERF:
+		return sysfs_emit(buf, "perf\n");
+	case LOOKUP_COMPAT:
+		return sysfs_emit(buf, "compat\n");
+	case LOOKUP_AUTO:
+		if (sb_no_casefold_compat_fallback(sbi->sb))
+			return sysfs_emit(buf, "auto:perf\n");
+		return sysfs_emit(buf, "auto:compat\n");
+	}
+	return 0;
+}
+
 static ssize_t mounted_time_sec_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -1211,6 +1227,7 @@ F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
 F2FS_GENERAL_RO_ATTR(unusable);
 F2FS_GENERAL_RO_ATTR(encoding);
 F2FS_GENERAL_RO_ATTR(encoding_flags);
+F2FS_GENERAL_RO_ATTR(effective_lookup_mode);
 F2FS_GENERAL_RO_ATTR(mounted_time_sec);
 F2FS_GENERAL_RO_ATTR(main_blkaddr);
 F2FS_GENERAL_RO_ATTR(pending_discard);
@@ -1329,6 +1346,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(current_reserved_blocks),
 	ATTR_LIST(encoding),
 	ATTR_LIST(encoding_flags),
+	ATTR_LIST(effective_lookup_mode),
 	ATTR_LIST(mounted_time_sec),
 #ifdef CONFIG_F2FS_STAT_FS
 	ATTR_LIST(cp_foreground_calls),
-- 
2.50.1.565.gc32cd1483b-goog


