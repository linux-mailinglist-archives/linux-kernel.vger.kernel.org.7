Return-Path: <linux-kernel+bounces-745297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE94B11814
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB6A7AFC6C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ABA244677;
	Fri, 25 Jul 2025 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8RrNpDB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEDF23BCE2
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422615; cv=none; b=ZZCwM6cxKOMvgSWawcMuzvikObb1yMlrWG5sDOrAPMjpa8B9J24PdclLeV/RCSKf95i5RKawxc1rtIVgoc9K0zsETuk4w/vOTX+fXTJfjPjYNAwCO/vHK4eQ4DRIJmUshvgRrSMsYp6LceA1AgJiroeyaF1MGdWrCinvqnoF3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422615; c=relaxed/simple;
	bh=BGjXsUnNjLE7O41aldkupZWLOiDewT6Hs1fr1D63K1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdHYVAPpllc1hBAi1vKpbXmqhhfqDHLOnmZSvP4ObiLl4S0o9QyxdgJ2VE2IjSmFu2DHwPjk8Xpn0G5nKOctq4hWqX666Sc1BYfCSaeY3Z/hJmrLxm8/HCmcLS/kvmzgP7V1XCprCLu0AEFRkTPyNqeWfWkct38yeS1V/55s18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8RrNpDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF8AC4CEE7;
	Fri, 25 Jul 2025 05:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753422614;
	bh=BGjXsUnNjLE7O41aldkupZWLOiDewT6Hs1fr1D63K1c=;
	h=From:To:Cc:Subject:Date:From;
	b=D8RrNpDBV3QGCenq/W5CMdUMA/dks0uOADljV8y1fH7ojMR6Q/jG2p5zX+m0SuTPO
	 r2qgrjFOan12YSJbUTxmO/ot3Lv0NnC7jHZ1wAaHqgmse3CJtRg5HZ1r8Lf8I2caMG
	 Zqg8A+Pr+NwEdAHfwKrkdB1ukLL4xsK1Rhd74I8a+HWaq+I2fuQ/hDI4HpgFMbIVsi
	 Vn7MmgckdNbBXMV7lyc9jwGUzOwdjyLmV0ThgM9IBdheRHIystMvkGQk/AFbN/m6QP
	 DO8K/ioilJCwEcR7ohhA9vOvhJainVFQg10EDwY/xE4Ei1GMsV9FO+kYr7k0eG5Pt8
	 PR7au4Oi41yqg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3] mkfs.f2fs: support -C [no]hashonly to control linear lookup fallback
Date: Fri, 25 Jul 2025 13:49:22 +0800
Message-ID: <20250725054922.3972265-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It provides a way to disable linear lookup fallback during mkfs.

Behavior summary:
			Android		Distro
By default		disabled	enabled

Android case:

1.1) Disable linear lookup:
- mkfs.f2fs -f -g android -O casefold -C utf8:hashonly /dev/vdb
- dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
s_encoding_flags                        [0x       2 : 2]

1.2) Enable linear lookup:
- mkfs.f2fs -f -g android -O casefold -C utf8:nohashonly /dev/vdb
- dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
s_encoding_flags                        [0x       0 : 0]

1.3) By default:
- mkfs.f2fs -f -g android -O casefold -C utf8 /dev/vdb
Info: set default linear_lookup option: disable
- dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
s_encoding_flags                        [0x       2 : 2]

Distro case:

2.1) Disable linear lookup:
- mkfs.f2fs -f -O casefold -C utf8:hashonly /dev/vdb
- dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
s_encoding_flags                        [0x       2 : 2]

2.2) Enable linear lookup:
- mkfs.f2fs -f -O casefold -C utf8:nohashonly /dev/vdb
- dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
s_encoding_flags                        [0x       0 : 0]

2.3) By default:
- mkfs.f2fs -f -O casefold -C utf8 /dev/vdb
- dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
s_encoding_flags                        [0x       0 : 0]

Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- honor [no]hashonly flag for Android case
- update testcase and output
 include/f2fs_fs.h       |  3 ++-
 lib/libf2fs.c           |  6 ++++++
 man/mkfs.f2fs.8         |  9 ++++++++-
 mkfs/f2fs_format.c      | 11 +++++++++++
 mkfs/f2fs_format_main.c |  3 ++-
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index f7268d1..a8da8fa 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1478,7 +1478,8 @@ enum {
 
 /* feature list in Android */
 enum {
-	F2FS_FEATURE_NAT_BITS = 0x0001,
+	F2FS_FEATURE_NAT_BITS		= 0x0001,
+	F2FS_FEATURE_LINEAR_LOOKUP	= 0x0002,
 };
 
 /* nolinear lookup tune */
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 2f012c8..1a496b7 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -1424,6 +1424,7 @@ static const struct enc_flags {
 	char *param;
 } encoding_flags[] = {
 	{ F2FS_ENC_STRICT_MODE_FL, "strict" },
+	{ F2FS_ENC_NO_COMPAT_FALLBACK_FL, "hashonly"}
 };
 
 /* Return a positive number < 0xff indicating the encoding magic number
@@ -1485,6 +1486,11 @@ int f2fs_str2encoding_flags(char **param, __u16 *flags)
 					*flags |= fl->flag;
 				}
 
+				if (fl->flag == F2FS_ENC_NO_COMPAT_FALLBACK_FL)
+					c.nolinear_lookup = neg ?
+						LINEAR_LOOKUP_ENABLE :
+						LINEAR_LOOKUP_DISABLE;
+
 				goto next_flag;
 			}
 		}
diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index 8b3b0cc..fcb227c 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -232,10 +232,17 @@ Use UTF-8 for casefolding.
 .I flags:
 .RS 1.2i
 .TP 1.2i
-.B strict
+.B [no]strict
 This flag specifies that invalid strings should be rejected by the filesystem.
 Default is disabled.
 .RE
+.RS 1.2i
+.TP 1.2i
+.B [no]hashonly
+This flag specifies that linear lookup fallback is off during lookup, to turn
+off linear lookup fallback, use nohashonly flag.
+For android case, it will disable linear lookup by default.
+.RE
 .RE
 .TP
 .BI \-q
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 2680bd3..04dfc20 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -671,6 +671,17 @@ static int f2fs_prepare_super_block(void)
 	memcpy(sb->init_version, c.version, VERSION_LEN);
 
 	if (c.feature & F2FS_FEATURE_CASEFOLD) {
+		/*
+		 * if [no]hashonly option is not assigned, let's disable
+		 * linear lookup fallback by default for Android case.
+		 */
+		if ((c.nolinear_lookup == LINEAR_LOOKUP_DEFAULT) &&
+			(c.disabled_feature & F2FS_FEATURE_LINEAR_LOOKUP)) {
+			c.s_encoding_flags |= F2FS_ENC_NO_COMPAT_FALLBACK_FL;
+			MSG(0, "Info: set default linear_lookup option: %s\n",
+				c.s_encoding_flags & F2FS_ENC_NO_COMPAT_FALLBACK_FL ?
+				"disable" : "enable");
+		}
 		set_sb(s_encoding, c.s_encoding);
 		set_sb(s_encoding_flags, c.s_encoding_flags);
 	}
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index f0bec4f..8f8e975 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -143,7 +143,8 @@ static void add_default_options(void)
 		force_overwrite = 1;
 		c.wanted_sector_size = F2FS_BLKSIZE;
 		c.root_uid = c.root_gid = 0;
-		c.disabled_feature |= F2FS_FEATURE_NAT_BITS;
+		c.disabled_feature |= F2FS_FEATURE_NAT_BITS |
+					F2FS_FEATURE_LINEAR_LOOKUP;
 
 		/* RO doesn't need any other features */
 		if (c.feature & F2FS_FEATURE_RO)
-- 
2.49.0


