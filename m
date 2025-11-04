Return-Path: <linux-kernel+bounces-884937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B72C31896
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608E4189696A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF660330B24;
	Tue,  4 Nov 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="KJjC502c"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77132ED3C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266625; cv=none; b=rBsBGNT/7f79+7LS8X5+vbs7MRGuhCuFf1lEWZTBsKi0sz/2RYhmU1z8qmUFZpKOH3KcWpEB/LjegtK4suOh3t7MjOZxtoGmUhkACLR1uKgKJb13w8wAJOdCnXphmHz+dqTQ8vtLeVr/ZgKVcmGPSOVvsKkT3HRBG+AcdnWHTaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266625; c=relaxed/simple;
	bh=Gim/7ab8Ps8c288C2FI2mEQ1eaYsaH0pDWPy3VZlBgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAZSkXXmHmHMoNgsK1Spj9AEwzfyvkINnl0dWUs0KN1ZxLeorJIxQ5WhbDiU2zP7+BkUMVfIdLOCH0+fxiUENt7BWAAPnsT44KOGhnIjxLmPIID5YBMEcPl90+LpRFmEkYqv5dfUHxwyfpDttXjKw0ofeH+tBJuo4zNkoHpts/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=KJjC502c; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: c9295e83-b98a-11f0-ad1a-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c9295e83-b98a-11f0-ad1a-005056999439;
	Tue, 04 Nov 2025 15:30:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=D3xeqw/dfEIrVeGKh37I3luTw6enqPX65TtleKpnD1A=;
	b=KJjC502cER0Ii2sJ4BldIcJZ/j7F0XbvxYVptX5mHKXBnkOBj03NBPv8R1AVLKsAN1a1zpJsSOFsA
	 5gHG+9K7DET5acqYOXWRzqDP0g8AguMm/fVa3IVX0HE5JCaEvTyJHr5Kfticxxi+jXtORixVjTqb9t
	 dC5a6rmucLn/IGV0+svSB8EueNjChqRU/VURdDsq6J7Dowru/Bt5XIcqHndzPxRf4O7+MRTNSULaj9
	 lBtPWVPkYIC5nIcyw83l1Tk+AGZ34BQFhjSd31Or+op7HBC9JNBV8v2nNU1SvT8O+juRrwSlaTTLv9
	 WS2Rm9nEPGJiLJlnRvAmq7wffMT1MOg==
X-KPN-MID: 33|aNPH0QzK0RE3qu1XJXi7PG+3Ef1mEc/+LE0/zF1r8KHYpKJSoN1nFABjbtk/lLA
 b8+a/SaXX7rllaq7LeCJKqyq/xkxW/LunuaW+K0UTvgg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|A1japG/uqVWdUlER6TfUx40HlQjRePt8PtemcbvKi7GH6oXw5qi5sHk8x1sw7sO
 6tBOYphBKIIexkj1mErvokQ==
Received: from daedalus.home (unknown [178.231.9.53])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c77a76e8-b98a-11f0-9bf6-00505699d6e5;
	Tue, 04 Nov 2025 15:30:15 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Cc: jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Add error handling to minix filesystem for inode corruption detection
Date: Tue,  4 Nov 2025 15:30:03 +0100
Message-ID: <20251104143005.3283980-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104143005.3283980-1-jkoolstra@xs4all.nl>
References: <20251104143005.3283980-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We would like to provide early and specific warnings of filesystem
corruption without running into generic WARN_ONs and BUG_ONs.
Towards this goal, ext4, e.g., has a EFSCORRUPTED errno and a
standardized inode corruption message format. This patch adds this
errno and message format to the minix filesystem.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/minix/inode.c | 16 ++++++++++++++++
 fs/minix/minix.h |  9 +++++++++
 2 files changed, 25 insertions(+)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 32db676127a9..7897f5123b3d 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -26,6 +26,22 @@ static int minix_write_inode(struct inode *inode,
 		struct writeback_control *wbc);
 static int minix_statfs(struct dentry *dentry, struct kstatfs *buf);
 
+void __minix_error_inode(struct inode *inode, const char *function,
+			 unsigned int line, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	printk(KERN_CRIT "minix-fs error (device %s): %s:%d: "
+	       "inode #%lu: comm %s: %pV\n",
+	       inode->i_sb->s_id, function, line, inode->i_ino,
+	       current->comm, &vaf);
+	va_end(args);
+}
+
 static void minix_evict_inode(struct inode *inode)
 {
 	truncate_inode_pages_final(&inode->i_data);
diff --git a/fs/minix/minix.h b/fs/minix/minix.h
index d54273c3c9ff..2bfaf377f208 100644
--- a/fs/minix/minix.h
+++ b/fs/minix/minix.h
@@ -42,6 +42,9 @@ struct minix_sb_info {
 	unsigned short s_version;
 };
 
+void __minix_error_inode(struct inode *inode, const char *function,
+			 unsigned int line, const char *fmt, ...);
+
 struct inode *minix_iget(struct super_block *, unsigned long);
 struct minix_inode *minix_V1_raw_inode(struct super_block *, ino_t, struct buffer_head **);
 struct minix2_inode *minix_V2_raw_inode(struct super_block *, ino_t, struct buffer_head **);
@@ -168,4 +171,10 @@ static inline int minix_test_bit(int nr, const void *vaddr)
 
 #endif
 
+#define minix_error_inode(inode, fmt, ...)			\
+	__minix_error_inode((inode), __func__, __LINE__,	\
+			    (fmt), ##__VA_ARGS__)
+
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+
 #endif /* FS_MINIX_H */
-- 
2.51.2


