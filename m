Return-Path: <linux-kernel+bounces-884938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BE0C31863
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20E8434A48F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73917330D51;
	Tue,  4 Nov 2025 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="aiPQnTb7"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6301F32D0F4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266630; cv=none; b=mZmFhBOFeZm8dV4xsEXHBaSwKlVP9/RquwJOCA7X0T4JaCogek+A0UGcYB+c8C61BY9ToJ1vmndJVVcIvj9J+DYz1nooaDYr7KNI+M74gIcmilB8ZhpKQmTrSkmpqn5ESR0WZccGdPYnMTXp9GXjBkUN45QPRXxhAGoKTqAyibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266630; c=relaxed/simple;
	bh=OP/vV9wqkkrZmtHacKwbnTGp3xOKKezFJ+9b9Cjdg/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H0UEPbzZUl+oqf+DWK1K7hVaE6VpNg+qUfqeVLKw7umLzHk18s192ZnVbFd5oGcyo3nZluePUOp759gByEs+1sngSs4UZy+55USczapm7aT4UPVfYdji7UY7mXXZLPfPcAkqCqvA4IXdfx4z6dsRe1eyzpjEzpitaYgfbrmjEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=aiPQnTb7; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: eab9c498-b98a-11f0-809d-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id eab9c498-b98a-11f0-809d-005056992ed3;
	Tue, 04 Nov 2025 15:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=+ZKlco8b941O2c9jwUmj589LwJx/2en+qb021fex3xE=;
	b=aiPQnTb7VzHLq74S32z7Q2AldsZzzoGS6dP2Y8URAgcwyAYQma+Dbom63zfT6QyuUrwnPnKD92Toh
	 NlZVYEL3C2XqMm4y5fQB61G6QqAy0onWfRxnjI0VCBHJgVTakCaDgNdR+nfdSn5bKs5y1vMQddIl9D
	 N9HyBKbKXiMHgURhbPkL4Z8YfAS1vQc4DSbjK1NSRhJyAxQZAqXV4T1gRzopbjXpRJ87hkTr3/j8ON
	 GuR8yRcrU5BRf04bYaQ1wnuUtmUUy5qs9IBBtDtjhearq0pP0x6ISpG7cVyux85CzexFjzHE3RD83a
	 SA+ITUgSm84cYjt4VHBHI2Mq84Rkx9g==
X-KPN-MID: 33|AOaL8jm0SiiuMMg+0+xfpXAtOKzEkwPEnj3JRzFsAH6/I66dYDC4+AxBe2MaQA1
 0UzPpEzIsfa4OWjC7MtLK73X98dKLOfKPe2W1X+nofxU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|BqbPRmFOI0l2ebBuKRx97+PRYKU2tbpj7pFMPmkSh9Az2qKDuui3EqJNmgNmLR5
 W4owWilwTjclzc9KYLobyMQ==
Received: from daedalus.home (unknown [178.231.9.53])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cb7d9580-b98a-11f0-9bf6-00505699d6e5;
	Tue, 04 Nov 2025 15:30:22 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Cc: jkoolstra@xs4all.nl,
	linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Subject: [PATCH 2/3] Fix a drop_nlink warning in minix_rmdir
Date: Tue,  4 Nov 2025 15:30:04 +0100
Message-ID: <20251104143005.3283980-3-jkoolstra@xs4all.nl>
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
detect nlink corruption of a directory. This patch adds a sanity check
to minix_rmdir to prevent the warning and instead return EFSCORRUPTED to
the caller.

The changes were tested using the syzbot reproducer as well as local
testing.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=4e49728ec1cbaf3b91d2
---
 fs/minix/namei.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..68d2dd75b97f 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -161,15 +161,24 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	int err = -ENOTEMPTY;
-
-	if (minix_empty_dir(inode)) {
-		err = minix_unlink(dir, dentry);
-		if (!err) {
-			inode_dec_link_count(dir);
-			inode_dec_link_count(inode);
-		}
+	int err = -EFSCORRUPTED;
+
+	if (dir->i_nlink <= 2) {
+		minix_error_inode(dir, "inode has corrupted nlink");
+		goto out;
+	}
+
+	err = -ENOTEMPTY;
+	if (!minix_empty_dir(inode))
+		goto out;
+
+	err = minix_unlink(dir, dentry);
+	if (!err) {
+		inode_dec_link_count(dir);
+		inode_dec_link_count(inode);
 	}
+
+out:
 	return err;
 }
 
-- 
2.51.2


