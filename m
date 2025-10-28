Return-Path: <linux-kernel+bounces-874890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 681BFC17575
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93ED14E601F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7B736999B;
	Tue, 28 Oct 2025 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="R14oSUjh"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228436999F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693881; cv=none; b=jsVzZ3+g5L/b6lnpioqBkS6uZ5o1WfP50VkWOZQ05bBUnXDfEe5h8TMIBh9cLNBvwkM4xumvfNlRcHBOQrnVb/jXje6MTUUjBQMVEeC6BI031V3amXuInJHXad4b66DG6SBtzVO19xumQIUCYcRnONcNc64RMqDBwMiLOIiTf9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693881; c=relaxed/simple;
	bh=439yTsJFgai9ffO9s16hEvRBsetv/V8ej97KerPugMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UI/WTTtQSd2kL/zwoPA5XwAX9Rj2pl+jTIfwVGQd5f3RDc9uaGzmR8r9/4SqJTpavvUy0NHSypiR/lmqBa4xuopCfCtFj2u4DU4j8/SqHb/e5NKhDSGWQouHm0iFmibtDIQ6mdqEpdUvAOq4XMH3iAYsMelp+2ox5Uaw/UtJ5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=R14oSUjh; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 653a8817-b455-11f0-a27d-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 653a8817-b455-11f0-a27d-005056abbe64;
	Wed, 29 Oct 2025 00:25:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=CwganTJx+9Lw3WMSh7k5X4jbPqLypnHQOM2bPJvw16Q=;
	b=R14oSUjhmj2pquwuRCcE8NiEP8x8ux60XVc+D6ACcpVcOffL06DqgXioV5ukDUBDD5I99jIDX3qmj
	 a5ahmErglsZG2hwdWOOBMZ/lHAN+BfB6IkbcJmCOpchiX+QIoRtvZAcdD2Ax6xlvWM6GBFi7Fxrr2W
	 oaGqr2I0XLSbTzQ5xeQHiekciMJ1lXtLC2qWqFKvytepAWQL2BOD7VrX4GSGM+BFBvssC7v289y8Wh
	 pEXnnRkSUHUewp2x+kSy8xPU1JtdV/CXCcfYbG5JCdn/rBHCTOG8cR3tE3Fkfw3UaAi/EG/9fLZeW9
	 KUJ6fGpPGXROAUgV35GN7BGer1Uh3bg==
X-KPN-MID: 33|tzsCuW5x5QBoQxv6qLKTGow+iGUfXhzRjhiA/IpHMov+l+P/osS1hjmYvK8DuM6
 qeQra2J/YrM0pPdh4lWEJYuMx04EuMGg6QXV0aP2ppkk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fMvmz9POJ2hi8AxioCD6qmoiI1Oyk2u6fX/3p9Nolvil3pAoWorKv8vPcatxfVT
 UEdrhNBTfuylyjoVoH1khfw==
Received: from daedalus.home (unknown [178.231.9.54])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1c1539a7-b455-11f0-b8c6-005056ab7584;
	Wed, 29 Oct 2025 00:23:29 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Dave Kleikamp <shaggy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>,
	NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	jkoolstra@xs4all.nl,
	syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com
Subject: [PATCH] dtInsertEntry can result in buffer overflow on corrupted jfs filesystems
Date: Wed, 29 Oct 2025 00:23:29 +0100
Message-ID: <20251028232329.430752-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a general protection fault in inode_set_ctime_current.
This resulted from the following circumstances: when creating a new file
via dtInsert, BT_GETSEARCH may yield a pointer to a dtroot which is
embedded directly in the jfs_inode_info. When finally dtInsertEntry is
called, if the freelist field or any next field of a slot of the dtpage
is corrupted, this may result in memory corruption of the parent
directory inode.

In this case the i_sb field was corrupted, which raised the gpf when
in inode_set_ctime_current i_sb was dereferenced to access s_time_gran.

I tested the patch using the syzbot reproducer and doing some basic
filesystem operations on a fresh jfs fs, such as "cp -r /usr/include/
/mnt/jfs/" and "rm -r /mnt/jfs/include/n*"

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=cd7590567cc388f064f3
---
 fs/jfs/jfs_dtree.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 0ab83bb7bbdf..e37278596afe 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -170,8 +170,8 @@ static void dtGetKey(dtpage_t * p, int i, struct component_name * key,
 static int ciGetLeafPrefixKey(dtpage_t * lp, int li, dtpage_t * rp,
 			      int ri, struct component_name * key, int flag);
 
-static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
-			  ddata_t * data, struct dt_lock **);
+static int dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
+			 ddata_t * data, struct dt_lock **);
 
 static void dtMoveEntry(dtpage_t * sp, int si, dtpage_t * dp,
 			struct dt_lock ** sdtlock, struct dt_lock ** ddtlock,
@@ -891,7 +891,8 @@ int dtInsert(tid_t tid, struct inode *ip,
 	lv->length = 1;
 	dtlck->index++;
 
-	dtInsertEntry(p, index, name, &data, &dtlck);
+	if ((rc = dtInsertEntry(p, index, name, &data, &dtlck)))
+		return rc;
 
 	/* linelock stbl of non-root leaf page */
 	if (!(p->header.flag & BT_ROOT)) {
@@ -3625,9 +3626,10 @@ static void dtGetKey(dtpage_t * p, int i,	/* entry index */
  * function: allocate free slot(s) and
  *	     write a leaf/internal entry
  *
- * return: entry slot index
+ * * return: 0 - success;
+ *	   errno - failure;
  */
-static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
+static int dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 			  ddata_t * data, struct dt_lock ** dtlock)
 {
 	struct dtslot *h, *t;
@@ -3649,6 +3651,10 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 
 	/* allocate a free slot */
 	hsi = fsi = p->header.freelist;
+	if (fsi >= ((p->header.flag & BT_ROOT) ? DTROOTMAXSLOT : p->header.maxslot)) {
+		jfs_err("Encountered corrupted dtpage before insert");
+		return -EIO;
+	}
 	h = &p->slot[fsi];
 	p->header.freelist = h->next;
 	--p->header.freecnt;
@@ -3697,6 +3703,10 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 	while (klen) {
 		/* get free slot */
 		fsi = p->header.freelist;
+		if (fsi >= ((p->header.flag & BT_ROOT) ? DTROOTMAXSLOT : p->header.maxslot)) {
+			jfs_err("Encountered corrupted dtpage before insert");
+			return -EIO;
+		}
 		t = &p->slot[fsi];
 		p->header.freelist = t->next;
 		--p->header.freecnt;
@@ -3774,6 +3784,8 @@ static void dtInsertEntry(dtpage_t * p, int index, struct component_name * key,
 
 	/* advance next available entry index of stbl */
 	++p->header.nextindex;
+
+	return 0;
 }
 
 
-- 
2.51.1.dirty


