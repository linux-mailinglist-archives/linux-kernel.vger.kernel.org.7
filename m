Return-Path: <linux-kernel+bounces-755744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD9FB1AB30
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE173BB792
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800992918DE;
	Mon,  4 Aug 2025 23:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c53ESy/h"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E4242D99
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348773; cv=none; b=RXjRNyDUuOr9+YO9y4oPiSFSL4lpOW38V47vBU7RlZQAqvBHlRmeHKO3YmQ0PzMjVdeU2NJ5ZN7sJkjRk9zay5NW5BtEkWFBS+waF0NPjrlHi/45JoFpso3FMxSWU8RxCLWPi7HcEn1YxAhOPB6y3w7i6CvdKEq5vuFi/2uLI8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348773; c=relaxed/simple;
	bh=mW94YNphCeMDCqeSKUMhIoQuVsakToAJfrbz1O1/Yjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kWaAW177snWW9I37Ooqi75bfiZ9bSVrvZs8QPjVaIHOuBCSLX5Iu1wmvXoHvCen1ckivyxamJ4A7iRyWoCps3rrunkOsju9S5vNn9IJ3CEGiwbSleXsLR799s5+dQIoKWvo5CtfGChFVn40XBG3+nH6b07OLnHHK/HpsS3JUcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c53ESy/h; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4225ab1829so2620057a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754348772; x=1754953572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGnjhlkr58/FOajbxu7sCyHuJOVEyicbJJHbor5PpZw=;
        b=c53ESy/h8T0QYWrl38ulAWpSKmKEDa5UMfJxh/avUJfK2vYYOS1OpqePrrglCCGx8Y
         ubdrACygZRuTU5t3E5zuZur+1jMk0swFt19Y/rN/7pz+p54J0zByKVhdwqcRH4VNPqWO
         kjtaUefqZB97j3CGqyPe57Qv45Y3VHKnOuQkGC7IxKrUe7nFP+Vm+DfUrtgbVo4V94VS
         fBe/ORNbz6aV98E4sbxKWsHR0HAnFbj9Ph/LJz+KE+Jvos/wHLwMlZGmhWpWuE3Sc1RM
         pUwU4xgL84GKD1vK8o3wrp3Kd30nmKtjSWRGC+kezvGlQyyZeCf3xniWR+4bsGGFNRgG
         YP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754348772; x=1754953572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGnjhlkr58/FOajbxu7sCyHuJOVEyicbJJHbor5PpZw=;
        b=J0BxRo+pMr7EsGx+VqdWJRHHy9dcrt6DzyVF271/1/5wWi4FFTQjE0xF9pWwYOHIw6
         rPeE2G184ZLP1+2pZoulyxxJR6d5zeDqkiPuUuZ1cnJMU5iyKtTHq1TpzHCauy1ABFxE
         LNQ5d/rFN9uSMrQWPJoJtTpR0Uxd2YUd2WKOqf6n+H3YENki/N5hUBtsVYiG+Tr5Sel1
         jckeYhmAuJv+56MrYmQaZt4v4WcMX7YHRggWwT17TsOk6eEOc7Re882Rypat6Gqq8pTy
         i5Xd7QAEPEOgRMvTyd4kib/mGe2xSB873f9+FA5iN1C/lZsiHmz/jlNEJKd9xgr6gBTZ
         SxFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvuvwE2h1mWIypa/HocKFyTxaTkwKaeEOQWZ1VqnwCxeRDaJaBjkBTpMrCDV3++QEtVHdiqu8vVYZ/Wyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8OOqtUo6SAV+JqgNj3F5njiSYwOq8Yk9CQcVOvtWI3YWd9jM1
	AuHC1TBFU7nmoqXOKe9HKCBi0ekbKkyX8JP7KISG6bA4sg5fllgFSjlh2M8Akme7ibLFjZjfBy1
	qBCX/F569gw==
X-Google-Smtp-Source: AGHT+IHqorv7ISi2bpW1ywQ+0QWFp7Iixj0oB+s092j6YhuI66/ybNz3R6cLh8nZkBsRPXr/TTdU4tUtW7s3
X-Received: from pjbeu3.prod.google.com ([2002:a17:90a:f943:b0:321:162c:e4fd])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b83:b0:31e:4492:af48
 with SMTP id 98e67ed59e1d1-321162d3205mr14330735a91.28.1754348771682; Mon, 04
 Aug 2025 16:06:11 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:05:58 -0700
In-Reply-To: <20250804230558.746338-1-chullee@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250804230558.746338-1-chullee@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804230558.746338-2-chullee@google.com>
Subject: [PATCH v2 2/2] f2fs: add sysfs entry for effective lookup mode
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


