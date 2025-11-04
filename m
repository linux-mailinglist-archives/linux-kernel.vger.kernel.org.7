Return-Path: <linux-kernel+bounces-884939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB9C31899
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DA542470E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED18331A42;
	Tue,  4 Nov 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="saCyWy/s"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740A83314A0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266633; cv=none; b=pe0h/S2iLHQiH//HquXQ6FWZ1kE9OWi4N9jiJEI3BYNTMbTq+5t/sZq4IPTjdTqIrm1+B7YfBMczTH2uhOwiOHze1OTnUFRfN7y2xVjmovXV0BCRU1M3RUolFSwHaa9Ymshy40VaeNf10V/6b3jKBB72ZdkOhVJ4phT+Rdjri60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266633; c=relaxed/simple;
	bh=IL2nrGlEqs3K32c6TMpRLuNQm6KKha/RXLuIUi5rJsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZuOMjhNmuqwHHdV1xByJ/B9IvY9sGI51tgzJKP/0JrJfh8RmCMMVXGecquRmMoy3jtBUfLZag2SY9MSQIC67M3V2/13AIqlWFGPmpP6NNGHTR/pjWIvwcNQ4brtSQEsqtfhynGOTYc1N4l/XgGr+J3UL0SDaHEvGzgmvpPoQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=saCyWy/s; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: eb973a6d-b98a-11f0-809d-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id eb973a6d-b98a-11f0-809d-005056992ed3;
	Tue, 04 Nov 2025 15:31:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=So3V6E2kJy5zkPbcq4XrBxevV+PIGfWxZmUHoE1an4I=;
	b=saCyWy/stXYI35VSyKCaQCtFtE+OFlFekLrswaqhuTz+DwF3gkgFRH1wXgKm0RCN1wIJv6FGUtQWD
	 DC7hSJnuwHw0QKMJ3hiG1mwwRjWx1PUb8NCsfs/v//xi1/VIB94BZg4LEK9PN2Ehy60Rb+/fup+NVS
	 iLxWQkrfhnabwPJTPxq9cPyr9RkzweW3mECIusZtJqkR3Bo9iKixDTtIPsCQvGCaxTW563kUaN0wW0
	 ReDaJ88KvVbRQmtg2Z09OnV1fyvVzpMSVz0YJ4VC48CxK9La0tz05z8geuTrq1gCZKIi8XPG/zbym4
	 w5SCXk8GM78zX1Hnlch97Rz8AmkXp2g==
X-KPN-MID: 33|T0nD5WN8WsynbF9UJ6sQxGlWSXykxTaW+9Odhmv6jUxAOcFVwOnrfSunCM/EPqt
 ND2O8n17gEcQHrUl6Pw2fkAsxCsFca5O/dmqNuc2nvUI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6GV+mNOx4esihGkMDcJdfZgD7UFh9x1J3SNjl027vj0XaFwqJsL1h51tHzwkVL9
 xcaqxRzwXKkEOvt7+pZvjaA==
Received: from daedalus.home (unknown [178.231.9.53])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cc594538-b98a-11f0-9bf6-00505699d6e5;
	Tue, 04 Nov 2025 15:30:23 +0100 (CET)
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
Subject: [PATCH 3/3] Fix a drop_nlink warning in minix_rename
Date: Tue,  4 Nov 2025 15:30:05 +0100
Message-ID: <20251104143005.3283980-4-jkoolstra@xs4all.nl>
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
 fs/minix/namei.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 68d2dd75b97f..263e4ba8b1c8 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -145,6 +145,11 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 	struct minix_dir_entry * de;
 	int err;
 
+	if (inode->i_nlink == 0) {
+		minix_error_inode(inode, "inode has corrupted nlink");
+		return -EFSCORRUPTED;
+	}
+
 	de = minix_find_entry(dentry, &folio);
 	if (!de)
 		return -ENOENT;
@@ -217,6 +222,17 @@ static int minix_rename(struct mnt_idmap *idmap,
 		if (dir_de && !minix_empty_dir(new_inode))
 			goto out_dir;
 
+		err = -EFSCORRUPTED;
+		if (new_inode->i_nlink == 0 || (dir_de && new_inode->i_nlink != 2)) {
+			minix_error_inode(new_inode, "inode has corrupted nlink");
+			goto out_dir;
+		}
+
+		if (dir_de && old_dir->i_nlink <= 2) {
+			minix_error_inode(old_dir, "inode has corrupted nlink");
+			goto out_dir;
+		}
+
 		err = -ENOENT;
 		new_de = minix_find_entry(new_dentry, &new_folio);
 		if (!new_de)
-- 
2.51.2


