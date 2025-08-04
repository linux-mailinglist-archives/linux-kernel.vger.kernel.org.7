Return-Path: <linux-kernel+bounces-754712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C62B19B44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336F0176FCE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC1322F77F;
	Mon,  4 Aug 2025 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LI9o/v5z"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4022DA06
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287418; cv=none; b=SArxYE3+IyU5MP9cIo/M3lzhiHCfZ70GONVcwGL4F01ugyg7jF+BUbaLZ8LXmgxcK72TlPMgH9COPMbsWmFGGV+mrO7ByDQ63MM+67dMTJ4E3Y8P4zDuH+pFdYNkJTjBsIjbarOeu/yWXIuhs89vcwD2AI+FyChDa0VzvUpGtWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287418; c=relaxed/simple;
	bh=tx5X/2MJNkclXA+AmEUT+uk3o4zjsQkYuNgjznieI2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CK3Uhi4O04Eg0n+DiDpxXp5AzrV+PeiFTVRIX8fSEh7uA3TA2oGZY6Eq7TlACAUIKQMSayPzbipg7pbmFQOf8CfSFeU9yh66b5XeNbF/E9KALUeXveNIjEyg3TaC0HUfO+i2NUkGnGxH305YgC1d26XGLakbl/ir8JLhz8IQWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LI9o/v5z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so3174235a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 23:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754287416; x=1754892216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kAR2Eoyeq+sNiEt+R/9Asn6gXMfLUzb3w+CS82HR2yQ=;
        b=LI9o/v5zmbZ3npSol6B2X7yQbRMwG4I1x5FrQnAXxQeYCQlUnoMiyu5q2qqE92S3T9
         N3Z0VDKmuAwXVXoQXurRx8rPSCtZfTHxrmR0pT+aCBgvxivSP8ERNTn5xuEA4qP0wlIO
         O16COOtqu4RPvuZyqxC5GfjTuFs5L2fJ4YvB6eD6wMsxueihP0riMThc48dvo/UOtF2U
         TdYQLb/hG6A9eWIhanj+M3ixh/UfKkVtqAxqy7AQ+LsAV+OAYM6of+gjS+vDatJMXcov
         29mVDw/TzUSb6PRilppBHr9FH3L0eTN4xb4zkMe2ZiY05uCq90cEyXD6TzrlJQ6/N87x
         XkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754287416; x=1754892216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAR2Eoyeq+sNiEt+R/9Asn6gXMfLUzb3w+CS82HR2yQ=;
        b=eACcTINvLMwx/9/NOEkCUpNXgBGGgzLRKDuL6JAAYx+LKgY/E4DGqDJfHakjofHoKi
         KeZ18tOPhiqaaftKxRlzQ5+QDA2Bq6265l+4tizIwWoKFcAiSIffeAhMjVkohxMuGe6l
         ntJ8vTuad/hOkWpy+fiEUuuRQgbCeGzK9caCR1x9xTru9nn1VvVYoEnTroI1oC58b9lv
         aUg9/CZH8SYbLbiPCap0Vqz1kA1YotlV/nlCXIRKlw2e78OigxMTgtWlW6+TkKk4zaOh
         6difgthtN6AqGNODOrutaidL/AnS7yrv30jFYn2fy0NViT862cj7YKBtB1IHTvylcVxo
         fhYg==
X-Forwarded-Encrypted: i=1; AJvYcCUn3t7uC7MDeykvorkuQHwuesfa4r2x9Q9oa9kLZdFeh4RqEDH5pDEVFgurUnhfNqm/Kny5HZAgHQOU+9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ9DGh8yoNuRjhQ9FrvJxAbHyRWQ/WN3DCn2Z/zxAtyg4kUZ3q
	SIVLlpCQPaeDqPYeGa/WmZp9Y5e0iByC3sA6TB+CAYg0p8AIfin30clIEp1P3Dl5GgoQvv13bOJ
	ZfeCgi/k0aQ==
X-Google-Smtp-Source: AGHT+IHaVYUjM46yLlegvpYFMhTlII2JZiMeD++blc9CSojygb7SUXbrQ7bZ57kYXtttV4dViYL7CrPDbXP2
X-Received: from pfaw3.prod.google.com ([2002:a05:6a00:ab83:b0:746:2897:67e3])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d08:b0:23d:7b87:2c88
 with SMTP id adf61e73a8af0-23df8f6d4c8mr11124851637.9.1754287416301; Sun, 03
 Aug 2025 23:03:36 -0700 (PDT)
Date: Sun,  3 Aug 2025 23:03:27 -0700
In-Reply-To: <20250804060327.512247-1-chullee@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804060327.512247-1-chullee@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804060327.512247-2-chullee@google.com>
Subject: [PATCH 2/2] f2fs: add sysfs entry for effective lookup mode
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
 Documentation/ABI/testing/sysfs-fs-f2fs | 14 ++++++++++++++
 fs/f2fs/sysfs.c                         | 18 ++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index bf03263b9f46..e847a50e7403 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -861,3 +861,17 @@ Description:	This is a read-only entry to show the value of sb.s_encoding_flags,
 		SB_ENC_STRICT_MODE_FL            0x00000001
 		SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
 		============================     ==========
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
+		  for casefolded directories.
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 75134d69a0bd..9897dd8564e0 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -281,6 +281,22 @@ static ssize_t encoding_flags_show(struct f2fs_attr *a,
 		le16_to_cpu(F2FS_RAW_SUPER(sbi)->s_encoding_flags));
 }
 
+static ssize_t effective_lookup_mode_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	switch (f2fs_get_lookup_mode(sbi)) {
+	case LOOKUP_PERF:
+		return sysfs_emit(buf, "perf\n");
+	case LOOKUP_COMPAT:
+		return sysfs_emit(buf, "compat\n");
+	case LOOKUP_AUTO:
+		if (sb_no_casefold_compat_fallback(sbi->sb))
+			return sysfs_emit(buf, "perf\n");
+		return sysfs_emit(buf, "compat\n");
+	}
+	return 0;
+}
+
 static ssize_t mounted_time_sec_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
@@ -1166,6 +1182,7 @@ F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
 F2FS_GENERAL_RO_ATTR(unusable);
 F2FS_GENERAL_RO_ATTR(encoding);
 F2FS_GENERAL_RO_ATTR(encoding_flags);
+F2FS_GENERAL_RO_ATTR(effective_lookup_mode);
 F2FS_GENERAL_RO_ATTR(mounted_time_sec);
 F2FS_GENERAL_RO_ATTR(main_blkaddr);
 F2FS_GENERAL_RO_ATTR(pending_discard);
@@ -1282,6 +1299,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(current_reserved_blocks),
 	ATTR_LIST(encoding),
 	ATTR_LIST(encoding_flags),
+	ATTR_LIST(effective_lookup_mode),
 	ATTR_LIST(mounted_time_sec),
 #ifdef CONFIG_F2FS_STAT_FS
 	ATTR_LIST(cp_foreground_calls),
-- 
2.50.1.565.gc32cd1483b-goog


