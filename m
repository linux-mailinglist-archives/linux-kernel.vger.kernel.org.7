Return-Path: <linux-kernel+bounces-803791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB83B46550
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 23:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 176C07BB846
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5242F1FE5;
	Fri,  5 Sep 2025 21:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QEqt2BR6"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26722F0683
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757106940; cv=none; b=oVtXeFt+yXPDvCkGpbclIQgqpkyvfA/aa/Wp482b1qSpXspbSxgA/u+OuSLB07sm0WKN14o+2hMI/YfVqxr+l5ahgMicX7DZOWXhA8f8jTDN5SlbdR8yWxKjhZSk05A1Aivskd5HRDu+Z+7nDvtMH8EnJy+tKIJmFHGnkXEXgSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757106940; c=relaxed/simple;
	bh=ZbpTJpgq5eLZVl33raMdiFnvHNLuPpzwtxq8hWiMSh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0UqIkSUKWa4PjkgjskaGOb4CmZimzoNgCOvvp15D6LTroojd2+EdikZV2SbOX/1O/iS4zsllrO7IlbErd1zC7/H4WU72RzMu8Kw1R5/v1lL3T0XvXzeO/ZcoGrw0InsWcrQ6D/c1V76SMtr2bgM//G72gXhSp8EmD2LPCzBhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QEqt2BR6; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042eb09948so477009866b.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757106936; x=1757711736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wo0Nm6QkVqDa5/FEJy5jxjvhuwrT2EEIYGSEnkzS3xU=;
        b=QEqt2BR6/Y+P4loZL4Fxi4YgPMVPzPDPExdrMSbcCzjV+Li2LxmIWA1JRN9IRDDJ3H
         STy7JFQnEmUgSpb6aa2g/JsGfyA+Abu1gFOLAnb9qTqmC0wJi7zXrxCj4MEaEiuMyeTJ
         +xNSOUFn0lS4VoaDn0mLoju+Vrd5z1M0ouuJBTk8l+Z/BsVL43/1SPld+0M+CsMky1jl
         8G2efjJGK6WylmPdsVcWlk6Zk/GmB84lhOpKw4OBd1nxE6Wl+9d7JZ2tN+S0ma06Phei
         M/LgcdA/srbQm4l+tgGs6F0CvoKSjsCGC0o5yDwLI30hCoBCJ33HrgoWFhuzFSAxjszd
         ouEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757106936; x=1757711736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wo0Nm6QkVqDa5/FEJy5jxjvhuwrT2EEIYGSEnkzS3xU=;
        b=DIPML7fxLETK2EnvwewaB+Ah/dBDG/1LC2ushtObtyFjyku8klQqvgGrDuPesJqlBQ
         p+QwL2HRzqa8CBjIsf71Ik68xCUNQoHn758ILbCFddGJa2Omuf9mE2u7Kx6VUAr9eO41
         6Gb5Hwwbhgilk8unSObGJzbw6pnuRYAYHJVd/pp9vanbpNog8HSFeYklLyBwc34HOzrz
         zULZf63znyS3khyzpG6TX8y+g1uBwhPkLbX4kr4VIMPejzGBPJhRh3NeTw1O/2drXvez
         YYt4MqcTWORIkn+W77LAg/wHIVwh8l41Onk4sbr0pjeBgV2ioWFcpejdMlgQMLksOLP8
         g7LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyalmr5OsBQekZtxNpjuotZhRYj8pKViyYSksGXXD/hoAhNfs217UJm4lcsIuqYsNPtjXn9PF6kowPSNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw47iVWMgSHeDdK90UntYP8OxztLfY2mXu9Nnh2mwF5Q+hb0VHQ
	fSxukI3tPXxopSwX169ivsS0fIXZt+APzli9ULRQ4T6Eefq513Y/XMA8jIB7+NvdCGg=
X-Gm-Gg: ASbGncvR+NhOyVqkFrTgsMHG7PO2MJOdjA2qeoaxDoNg3i0ST4tQRlt8spEjjNd513j
	cHTkSqKtWFhU4EsITRA3HOTbKRaWVCu061U3Y1g59LieAwOu52KcpsLsM03b8NroBlmUTdaC6Ek
	0SBwcjA+5hqsGhmBvzi4cgAjSWsR1R+QT1Rv3Qusa5suOwd/rInsnGWOmrOvsx56fiUL5D1aKNo
	DQlAkNAqYaQAbXxFI4FnHrUjC5VC/nCgIAd3sTmtnJjI97h1eRvsFPgCFnSEdxm6sPZjc0RN+hJ
	02pEJEef+bgumuQOcWbJoPiUwRRTGZ3/I2IsWb5s8oCO8+582aRf0+RGPJELLG6FUC/hcKaI/cw
	b4zcieGq4YjSz0dRvCPSbrC/cFcEnq618ANvy5jDcmdUbd9lFX0MzO1nqzyGsMX0eZth7Q9I06o
	bwlVUF3GMoCZT0ekgQgy10vm/mwBVKlVKJTcY6QQFMw1oS
X-Google-Smtp-Source: AGHT+IEI0UMFbxLDbFHi93Xgr79JgLgv6e0CgFXtb2r6z2caSDYapP71MxTt7L0Jmccte/7ICI7YVw==
X-Received: by 2002:a17:907:3c92:b0:b04:1249:2b24 with SMTP id a640c23a62f3a-b04b1696062mr15691166b.37.1757106936248;
        Fri, 05 Sep 2025 14:15:36 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f356800023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f35:6800:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b047373afcesm604498166b.57.2025.09.05.14.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 14:15:35 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: slava.dubeyko@ibm.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph/dir: fix `i_nlink` underrun during async unlink
Date: Fri,  5 Sep 2025 23:15:30 +0200
Message-ID: <20250905211530.43296-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During async unlink, we drop the `i_nlink` counter before we receive
the completion (that will eventually update the `i_nlink`) because "we
assume that the unlink will succeed".  That is not a bad idea, but it
races against deletions by other clients (or against the completion of
our own unlink) and can lead to an underrun which emits a WARNING like
this one:

 WARNING: CPU: 85 PID: 25093 at fs/inode.c:407 drop_nlink+0x50/0x68
 Modules linked in:
 CPU: 85 UID: 3221252029 PID: 25093 Comm: php-cgi8.1 Not tainted 6.14.11-cm4all1-ampere #655
 Hardware name: Supermicro ARS-110M-NR/R12SPD-A, BIOS 1.1b 10/17/2023
 pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : drop_nlink+0x50/0x68
 lr : ceph_unlink+0x6c4/0x720
 sp : ffff80012173bc90
 x29: ffff80012173bc90 x28: ffff086d0a45aaf8 x27: ffff0871d0eb5680
 x26: ffff087f2a64a718 x25: 0000020000000180 x24: 0000000061c88647
 x23: 0000000000000002 x22: ffff07ff9236d800 x21: 0000000000001203
 x20: ffff07ff9237b000 x19: ffff088b8296afc0 x18: 00000000f3c93365
 x17: 0000000000070000 x16: ffff08faffcbdfe8 x15: ffff08faffcbdfec
 x14: 0000000000000000 x13: 45445f65645f3037 x12: 34385f6369706f74
 x11: 0000a2653104bb20 x10: ffffd85f26d73290 x9 : ffffd85f25664f94
 x8 : 00000000000000c0 x7 : 0000000000000000 x6 : 0000000000000002
 x5 : 0000000000000081 x4 : 0000000000000481 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff08727d3f91e8
 Call trace:
  drop_nlink+0x50/0x68 (P)
  vfs_unlink+0xb0/0x2e8
  do_unlinkat+0x204/0x288
  __arm64_sys_unlinkat+0x3c/0x80
  invoke_syscall.constprop.0+0x54/0xe8
  do_el0_svc+0xa4/0xc8
  el0_svc+0x18/0x58
  el0t_64_sync_handler+0x104/0x130
  el0t_64_sync+0x154/0x158

In ceph_unlink(), a call to ceph_mdsc_submit_request() submits the
CEPH_MDS_OP_UNLINK to the MDS, but does not wait for completion.

Meanwhile, between this call and the following drop_nlink() call, a
worker thread may process a CEPH_CAP_OP_IMPORT, CEPH_CAP_OP_GRANT or
just a CEPH_MSG_CLIENT_REPLY (the latter of which could be our own
completion).  These will lead to a set_nlink() call, updating the
`i_nlink` counter to the value received from the MDS.  If that new
`i_nlink` value happens to be zero, it is illegal to decrement it
further.  But that is exactly what ceph_unlink() will do then.

The WARNING can be reproduced this way:

1. Force async unlink; only the async code path is affected.  Having
   no real clue about Ceph internals, I was unable to find out why the
   MDS wouldn't give me the "Fxr" capabilities, so I patched
   get_caps_for_async_unlink() to always succeed.

   (Note that the WARNING dump above was found on an unpatched kernel,
   without this kludge - this is not a theoretical bug.)

2. Add a sleep call after ceph_mdsc_submit_request() so the unlink
   completion gets handled by a worker thread before drop_nlink() is
   called.  This guarantees that the `i_nlink` is already zero before
   drop_nlink() runs.

The solution is to skip the counter decrement when it is already zero,
but doing so without a lock is still racy (TOCTOU).  Since
ceph_fill_inode() and handle_cap_grant() both hold the
`ceph_inode_info.i_ceph_lock` spinlock while set_nlink() runs, this
seems like the proper lock to protect the `i_nlink` updates.

I found prior art in NFS and SMB (using `inode.i_lock`) and AFS (using
`afs_vnode.cb_lock`).  All three have the zero check as well.

Fixes: 2ccb45462aea ("ceph: perform asynchronous unlink if we have sufficient caps")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/dir.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8478e7e75df6..67f04e23f78a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1341,6 +1341,7 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct inode *inode = d_inode(dentry);
+	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
 	bool try_async = ceph_test_mount_opt(fsc, ASYNC_DIROPS);
 	struct dentry *dn;
@@ -1427,7 +1428,19 @@ static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 			 * We have enough caps, so we assume that the unlink
 			 * will succeed. Fix up the target inode and dcache.
 			 */
-			drop_nlink(inode);
+
+			/*
+			 * Protect the i_nlink update with i_ceph_lock
+			 * to precent racing against ceph_fill_inode()
+			 * handling our completion on a worker thread
+			 * and don't decrement if i_nlink has already
+			 * been updated to zero by this completion.
+			 */
+			spin_lock(&ci->i_ceph_lock);
+			if (inode->i_nlink > 0)
+				drop_nlink(inode);
+			spin_unlock(&ci->i_ceph_lock);
+
 			d_delete(dentry);
 		} else {
 			spin_lock(&fsc->async_unlink_conflict_lock);
-- 
2.47.2


