Return-Path: <linux-kernel+bounces-891495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA2AC42C70
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 13:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAC2188C9FE
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 12:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102F1266B64;
	Sat,  8 Nov 2025 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOcxcR6V"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9295757EA
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762603355; cv=none; b=BpKluqZOLySQnfUMIe1zf4chcWHx5fGc3ZXPcotb7/XagKHlbwtqcdR5bbvM1gnzqvo3yXbENbcwG4OcWkO+hLKy67fEqYQkCvOs424fHgTPvlWC9AEkov/6lQ95aI4913yzwKVKz0vGEjXEQs7VH3HBRVlbj9C83BRflXAxcrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762603355; c=relaxed/simple;
	bh=h0efBWAdcFLUiA+GAVsRMGr16AcStdyj1wmiqunxhM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vFR9o+cU6RZJJrqwSQS5eWuUgbFJp7AxkkZpCM4s3lLozwtbpHVz8W/4y/9gDxtNWYNZQG8kJHi2FklpSWi935w4PfZ2qMnRabNqOsZZhjvQAeScRy9lag/QI+Az+yovJufVfAgfSr28nL0vCanM8b/74CuNWHypAmI1Y3WJbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOcxcR6V; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640c3940649so2245247a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 04:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762603352; x=1763208152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MolBFQJK8LdoF2uvTwy8N0sP5mBs/YPd2CVkntKqOPs=;
        b=mOcxcR6VWWzd3Z/oHKvq2qpOsYa+1XfECKwEKB8o8f3beIz18O0X1BrHWnn02G7gdU
         7+JMbeeaaagwaEqyie5bM5Y0HWHyprSCkZA0WlujlhKg6dVI4dqGPL4sCpNdO5fNYPkg
         sX/jG8ghD3H//OmWifRqdk1BBfLVEn33/kG3I2g6/nyHXQhQlQQtYNNCAfEIDHDVKm8w
         jbSoWgGmWoYnPfCX2mwvHxjv0aIY6GjEYCDfEEA5dN8AMjs4zkpMz7piwyNncNnvp5FM
         YXix0UYdV93Phr6qShDnTeCigoYs+AhPTYsVnesAEDBLgHKnrKQygxPNP+L4SJWQZ8A5
         SzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762603352; x=1763208152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MolBFQJK8LdoF2uvTwy8N0sP5mBs/YPd2CVkntKqOPs=;
        b=aePFIN698xBp5InNuPczXvrJvPuti7AhtmX/9V46q0F2n0AkC3BXzhFFC/VyL3Dep+
         soAhCEBI1gMxkakNHDljaynK12xTaRYsTFsAo4AaWRnhBX4rn5jYusI6GmtDhSzqZl/9
         BMzjuG634OrnJVX1WVFas90UlUXw+MOTV3aqWJ0CvHm6XFILROG/2KrfJMBP1VCON57I
         Ja+7rvruQMQP3zYVBQBNa/XmxTUcnyGTlnx5YxJG9cUSKSN9Fb318/wjKjTwVrk1W1qX
         BUuINkMwyHPFlmy3S+uPh7Q1mSCUI8mNcDbfgksGwUiA5dU7Gd0/+XosvH89pvMXQ7Rd
         QVGA==
X-Forwarded-Encrypted: i=1; AJvYcCVJy40LiWQOTj37Z5zsLdhrn+woKsZPmiF/dFYuejbu4O2a9TmKJmoPWsK5gS4UEBuSrDT5NeUuz3MoIaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcjoWqxkYAs9k8bZYlPeNV5tIJb1z+CFai4cF9+e8QPI186CXn
	AI5f7RzhJUmgaVC/bTwVli9mE0kie6W51+k6u7whKy3OxsfmD+1mSlpL
X-Gm-Gg: ASbGncuGQOZMuHWUWOBqC2VL8FiTS3EJRoAULjdIVlEIH1qfmDX1xo0Nwa3P+U7Cy/u
	VedXU/0ZlzsGjcqb6St5cu7QMq0rXyBWCnuzUXp5rGmnAwtOZJo7PU8IgWHC3nlfBml+k9pWu48
	bggoZOGQJazA6/+W6aObyHdUYF1moDR4j+Ftgrg/eFDdt86UQsNvLC+9jOl8Mh4C8XRrYGdrqln
	fSv95EIZuzRIOjrGxk1Kmd+yjGK3qgZDFmIAGaFsMnXCISCg59cfRdotTuclQBygd9kMHHlPMkN
	V8axQ1knwRbaBH/FhiIfwH7wNppS6KxSaNW/1jImI7FQcbu/Ikfo639IivfLML5Z22abjbJrjNF
	zswZzyZvsXhrkSeX+udEwrzwa7aTcu6IjXmt8x8FV+PmQy+ZfHUJMl3kHEg8fim3enwv5x5OCmy
	zcoRo41tGUHQ==
X-Google-Smtp-Source: AGHT+IFkaflDTO/AMyaKzX31TFdl/h9dbC4ZFglrOZEwm9xh+j+bASEBScZd2OFMTAZpV1p/LcKF+w==
X-Received: by 2002:a05:6402:354b:b0:640:fb13:6b8 with SMTP id 4fb4d7f45d1cf-6415e817106mr1607860a12.22.1762603351778;
        Sat, 08 Nov 2025 04:02:31 -0800 (PST)
Received: from eray-kasa.. ([2a02:4e0:2d18:62f:6d96:aed2:215:b816])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e12fsm6459166a12.34.2025.11.08.04.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 04:02:31 -0800 (PST)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [RFT PATCH] ocfs2: Invalidate inode if i_mode is zero after block read
Date: Sat,  8 Nov 2025 15:01:35 +0300
Message-ID: <20251108120133.37443-3-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A panic occurs in ocfs2_unlink due to WARN_ON(inode->i_nlink == 0) when
handling a corrupted inode with i_mode=0 and i_nlink=0 in memory.

This "zombie" inode is created because ocfs2_read_locked_inode proceeds
even after ocfs2_validate_inode_block successfully validates a block
that structurally looks okay (passes checksum, signature etc.) but
contains semantically invalid data (specifically i_mode=0). The current
validation function doesn't check for i_mode being zero.

This results in an in-memory inode with i_mode=0 being added to the VFS
cache, which later triggers the panic during unlink.

Prevent this by adding an explicit check for (i_mode == 0, i_nlink == 0, non-orphan) 
within ocfs2_validate_inode_block. If the check is true, return -EFSCORRUPTED to signal
corruption. This causes the caller (ocfs2_read_locked_inode) to invoke
make_bad_inode(), correctly preventing the zombie inode from entering
the cache.

Reported-by: syzbot+55c40ae8a0e5f3659f2b@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=55c40ae8a0e5f3659f2b
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
Previous link: https://lore.kernel.org/all/20251022222752.46758-2-eraykrdg1@gmail.com/T/
---
 fs/ocfs2/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..d966df3aa605 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1455,7 +1455,14 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		     (unsigned long long)bh->b_blocknr);
 		goto bail;
 	}
-
+	if (!le16_to_cpu(di->i_links_count) && !le16_to_cpu(di->i_mode) &&
+		!(le32_to_cpu(di->i_flags) & OCFS2_ORPHANED_FL)) {
+		mlog(ML_ERROR, "Invalid dinode #%llu: "
+			"Corrupt state (nlink=0, mode=0, !orphan) detected!\n",
+		        (unsigned long long)bh->b_blocknr);
+		rc = -EFSCORRUPTED;
+		goto bail;
+	}
 	/*
 	 * Errors after here are fatal.
 	 */
-- 
2.43.0


