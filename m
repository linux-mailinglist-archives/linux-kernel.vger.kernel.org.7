Return-Path: <linux-kernel+bounces-834710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35B8BA555A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0D1383CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC12275B16;
	Fri, 26 Sep 2025 22:30:56 +0000 (UTC)
Received: from sxb1plsmtpa01-11.prod.sxb1.secureserver.net (sxb1plsmtpa01-11.prod.sxb1.secureserver.net [188.121.53.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01622288EE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758925856; cv=none; b=YrJQmVHU29d2Ve9fZnJGNuWP/sGJdXgaISl7OZQCp+V3j8r4Fh3QilAary2I3cDda1yd11K02RrDm5TiMDfqaORp+hwdnJvmfnik79PfuDD5jT0gGZkbwQa9LfAMPKbmBjaq9A+vt2M2Sy4Zq7yItf/3QM1sg+rvjOWNm89E/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758925856; c=relaxed/simple;
	bh=iD8iNHiy9fgQceWo7ozCTRyQ3TTrmOLAiqx22VgD3ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vEHhXnusmiGOV2kvnfqZY1yfjedjdVv2KHmS7rUq5kgqSnn1jpP2YFdrUsMOUwrvkfTp/1gYiEzQzpSCGLuzFgebVrYOE7FKlAzp0j/jbFYKv1nEO41qsLlrMdS2BKlob647mExtgF1IGSzR3Zhmb9QKTa0NcCXRs2Ka3GfHY6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; arc=none smtp.client-ip=188.121.53.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Received: from phoenix.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id 2Gplvk8IcGJzA2GqMvKteV; Fri, 26 Sep 2025 15:23:11 -0700
X-CMAE-Analysis: v=2.4 cv=C8+wCQP+ c=1 sm=1 tr=0 ts=68d71250
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=hSkVLCK3AAAA:8 a=FXvPX3liAAAA:8 a=M97Rj3-oF8V_cyoQVJoA:9
 a=cQPPKAXgyycSBL8etih5:22 a=UObqyxdv-6Yh2QiB9mM_:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=irvUdcZYBsSKPCvlqN3O:22
Feedback-ID: 3b2e3888ed6f0b38a29ac2aa4c2cc632:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Cc: amir73il@gmail.com,
	Phillip Lougher <phillip@squashfs.org.uk>,
	syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Subject: [PATCH V2] Squashfs: reject negative file sizes in squashfs_read_inode()
Date: Fri, 26 Sep 2025 23:23:05 +0100
Message-Id: <20250926222305.110103-1-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP3qiyX6e9p6sF4QJw7JmhysBAyrrAFteV7bTkF056nV00y77H3fGt4krnJUrw76hgNsnkyuYzrq+2q4RKqys/EFXZb1N6cUxUBOAxPGG3t0/hOvP6WX
 /nIYOXoM8R6MYN/CEtvcNjQAAT0G/qf0f+XJSTCOValYH1PEvd+XRuP7ci7r7YJxw5RKGLI2/wVpHRXJDC9Y3iFm0Y9gA6ID2xQRggV0mlkqw4mqQocysL3z
 +SpAZ5GfCUBdq+lgZcf7qjMdLmR+swIwwNkjg/3HIQonAoVSTlraQLyDyFgIEJDGr/DIi+x9rgUHlEujJ50lCRYrtZpbGom9nkWqxtYomL1r+ZRYbjJatakB
 jXd8DLxWm6+mHiB5i4tuwfkVl0bWogiwYWtbL0Y5n3Ce5nW+yG4=

Syskaller reports a "WARNING in ovl_copy_up_file" in overlayfs.

This warning is ultimately caused because the underlying
Squashfs file system returns a file with a negative file size.

This commit checks for a negative file size and returns EINVAL.

Fixes: 6545b246a2c8 ("Squashfs: inode operations")
Reported-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d580e5.a00a0220.303701.0019.GAE@google.com/

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
V2: only need to check 64 bit quantity
---
 fs/squashfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 5920a33e44a1..49046a286e20 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -192,6 +192,10 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			goto failed_read;
 
 		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
 			/*
-- 
2.39.2


