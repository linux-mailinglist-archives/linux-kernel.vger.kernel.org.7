Return-Path: <linux-kernel+bounces-881956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC62C294F7
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 19:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24B354E7021
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 18:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95720E005;
	Sun,  2 Nov 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="hqvy2c3r"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209E3B2A0
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762107950; cv=none; b=mdnO//Y8KcQ6ic5kdlwE/beQl3Oyx1IsTkJ7FD6/06ntN+FGeybfS1znxCrA7E+Fv9cv1LJmW+DsUjNLxtyUgTr8zCLgiFOOuA0qir6/SXnxtSh2FTo5HWL67PtiOaHRCywWA8EaNbwBiYXksrbBZ+1uqvzRLyXwtx2TB2SxFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762107950; c=relaxed/simple;
	bh=TwHlJpZFsemf3UqLD8y60ujlqNUNm6ogZpd52yNfdYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mw8xaQM+Td37xy2b4BZu5CyfyQLPUv/AUO9ofo0uA7qYZoBUm/9Gtk2Z188Zl4qCLrl/is5baglrINPL/Cj/lv1hPd6w9gFC1XvVQZh/z+byMRgG3Ooujk6i01prhN8v0zgV4QcAgUAeFZeOFEZwKJMTmNgBKQPtwJ2uboCeJbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=hqvy2c3r; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 9deae9ae-b819-11f0-a27d-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9deae9ae-b819-11f0-a27d-005056abbe64;
	Sun, 02 Nov 2025 19:27:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=KjXwryYYJOl8pKhYag2MoDq8K98eIOWKWxcpjBWJmE8=;
	b=hqvy2c3rGUuSNYocAoJ2uK8OMM/WjmCMiPrJB6srMDRETV2WLoKv+mb3FEA/PizKVIMUnIfEx0JGA
	 mK8UDidp43r77dfA0DsswDmIfBjcKOl7C5o+NFfSe6YPcqpJtMaVQzPxWtalBjEBTZcbC4CetbT2mw
	 jBjtYodhAI1IRZm2aKbaU+ExgYCTB7oEqt+bWEyYEeF70jJ762ylVGwN3eP2gFg4G+D6UWcSba/DZq
	 I6oCNjLEhmhFfefbDTlbacw9nPWJKA3oE5BiI2pWbTDzjhUKKiPh7FohuYJd9mliTd3mWVTD7n6Ya3
	 yUY//28t3L3SmTJgLDJ6orK1gbZQlxw==
X-KPN-MID: 33|WBqdOdxHIk2PXkHzOI9dNj37wqZGkw5swjJuThHlmoU7qgPDwlHJ6UllP968jvC
 5Kk1q7MXDq1dDgkqfa1mBgy5m1c6CD2LWLaxZfCLKnlc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|tHYjJi9VeW1esH8G21B3SpgmYURe7J00XQGgTl23hGEiXhttym9apfFPAEKvwYs
 W9w8Uc95WTEYlJfkC/yNJzA==
Received: from daedalus.home (unknown [178.231.20.253])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 54f7d97a-b819-11f0-8005-005056ab7447;
	Sun, 02 Nov 2025 19:25:39 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Cc: jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org,
	syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com
Subject: [PATCH] Fix a drop_nlink warning in minix_rename
Date: Sun,  2 Nov 2025 19:25:32 +0100
Message-ID: <20251102182532.2442670-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot found a drop_nlink warning that is triggered by an easy to
detect nlink corruption. This patch adds sanity checks to minix_unlink
and minix_rename to prevent the warning and instead return EFSCORRUPTED
to the caller.

The changes were tested using the syzbot reproducer as well as local
testing.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+a65e824272c5f741247d@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=a65e824272c5f741247d
---
 fs/minix/namei.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index a8d5a7e22b7b..4bc1d9c31284 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -145,6 +145,12 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 	struct minix_dir_entry * de;
 	int err;
 
+	if (inode->i_nlink < 1) {
+		printk(KERN_CRIT "minix-fs error: inode (ino: %ld) "
+		       "has corrupted nlink", inode->i_ino);
+		return -EFSCORRUPTED;
+	}
+
 	de = minix_find_entry(dentry, &folio);
 	if (!de)
 		return -ENOENT;
@@ -218,6 +224,13 @@ static int minix_rename(struct mnt_idmap *idmap,
 		if (dir_de && !minix_empty_dir(new_inode))
 			goto out_dir;
 
+		err = -EFSCORRUPTED;
+		if (new_inode->i_nlink == 0 || (dir_de && new_inode->i_nlink != 2)) {
+			printk(KERN_CRIT "minix-fs error: inode (ino: %ld) "
+			       "has corrupted nlink", new_inode->i_ino);
+			goto out_dir;
+		}
+
 		err = -ENOENT;
 		new_de = minix_find_entry(new_dentry, &new_folio);
 		if (!new_de)
-- 
2.51.1.dirty


