Return-Path: <linux-kernel+bounces-846314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850B3BC78C1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E12419E61D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F2528D8D1;
	Thu,  9 Oct 2025 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B09IWro2"
Received: from mail-il1-f227.google.com (mail-il1-f227.google.com [209.85.166.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF86AD4B
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759991114; cv=none; b=tkTr7+tBmxe4aVtq3i2Rq6rSt6wC7LU12Us4TdLkwBCBkoDOdRDiduCK3VU/3kAqf1gaCFgttZZv6Xlc3UXHoulSV3+XMXfc0arCy9uhafjz/F1dtuCzQlFawdQT2NL6erMmCu6CqbIdwWUui6x6eyboe2+LdHTFcf/EYdP9jGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759991114; c=relaxed/simple;
	bh=+J+9CQSJvXmIuePph7LZKBSTQUJaQDgSX95H7QjCjvA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pdttX/MkWgbD6YLbhKK7lcXiIQqw1yOrlr5c9jlWZJODqoo4+ySZLR7IYDOf+GNv31kLAlnHRiGorcIQAgAddola9XmSI9giqOch7bwUIPcm+Zz7xVXFBumu3rlNoDKnxnBA1KhTxSd3dDRWxDcXkDto8oCxrjlM1OGcDi8uLRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B09IWro2; arc=none smtp.client-ip=209.85.166.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f227.google.com with SMTP id e9e14a558f8ab-42e758963e4so5623225ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759991112; x=1760595912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS+vJs2offx96KKff6hwDdiXDpHtb7AICfG+1qxivmI=;
        b=MW26DyWBpzqT1cRAtV4YA3MhkcnJgk5BWgsUflExS6B3ShkOUawavIVV6qEzG33Rac
         AhraBSozBhPFzb9Hjv3NJx23Lx2KsyoBTStP8nGZm19kRaS/wDlSrNyk/8+aM+3ApXds
         QRR+hqLtUg4h14RJVJDIkuY82VnE2da+MXB23jkan0GMiw5dcli3RKAYMOUNszGZCzZg
         Fkq+tU5urG2r2ivlqjEQ3IU5sw4nriqu3ATaybmXULAx4JFOu1mlUr4GQ89OkgXQus25
         /5KjQywHsTd5BXS9XNxKDQkYeh3geR3ORacJczjKWYeh8pJKGwFSVujG6tO7CQujroIX
         devQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW9lGSzFxE1d8X2Yzqb2h9YXEqWuNmRsx6BAPSVUYXRA2Clr85AdzHHPtNqy2VrOd3uqdPWDRH2Y0KC7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaaT/ubbriH8g3jUtSkQ0elyvhFJ5b7q8BFtE/iEuf9EoP8tA2
	YZoJQwcdZvTW9HVpbCzRLs14FQ9rFQW3EPrwuStCck41jI8RogjFhChHb27X5CS1kynz23+1U32
	J779rZvPYqFoO+uFaanmOa5mE05J0+qtD8zfxbzj66vPClIEumNadbr6gSJKf6tK/LqdBq5hyuZ
	fKFEFHlnV/YEz8awHDa2YTdTCsXlNF/cOM49lmXMKz63GbUVvO6CyWexo0u+L2VOOkbyV6Gtvpx
	pHzvc1bC4Wr3jljW7xGNo2RBA==
X-Gm-Gg: ASbGncsxWYtEjWn2JUoCSb4g5RP6nqt7iepoa2tpVJyqVIvKKbMwBSNEiFDL0yFXP9x
	1Vl2rfVIbZHOt5ltVfcJlxOHOnjeROrNxaV8RRXmpcYdPkhTyXfp9ORbucQGqWjZKirI/mi2XtL
	kNRiB84FDZXGkUV7rCWg5NKtSbVr4c4cBaLislrO4gdpST+bB3cdcbQqKWgFH3PHkW6X63awwOs
	NDjg9HOUXw+5f/khTMyEswEsiPCVqh4/Wnc57S2xPeATg5yGpT3L37bXmUTA3rzMJkiWFalkA4O
	D8V172ufw6su0mXdNvW2/NlJey0K1gEfE4Hiyvuc52HMs5K8C6ZytyOMdV2clMfWC+uiEY3v4kM
	+1EtgFeRDJdH7Sc2DhDRu6auxGS1PXBfKpvZHSYraoRx3KpmntgFUzz1Q05NqvjKSBx8kQdH8w6
	4ujTfbfNMW2ik=
X-Google-Smtp-Source: AGHT+IGIYZ4m/UXZ2hmyDH5sg43kUoRnoDLbewdel/Fmwwnz1VuSsMQWsL8mAlyhNgHz//CoHVTy7yu7SwcL
X-Received: by 2002:a05:6e02:4412:b0:42f:9187:f6e0 with SMTP id e9e14a558f8ab-42f9187f8edmr17973085ab.13.1759991111664;
        Wed, 08 Oct 2025 23:25:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-57b5edd2601sm1321962173.48.2025.10.08.23.25.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2025 23:25:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-828bd08624aso219102785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759991110; x=1760595910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bS+vJs2offx96KKff6hwDdiXDpHtb7AICfG+1qxivmI=;
        b=B09IWro2M/rBm7Kwi5qYHfrmWk+uPl145ZU15FFVpV5lZorusB8IZ3i56ogn/o70Z7
         vMU7bP+fK5cZzWNkSk89OrnVIdXHioA5S6wHIFwTDQR11/OCPxXR6htXoQDZcFHm+qeG
         WVS/K+lyvI2RHdIA109z4saWl2YezCf8mTFlM=
X-Forwarded-Encrypted: i=1; AJvYcCWBbZYC5ema1zg1+WVAxR7JwFwrR1y5kLEOX6JQo6vIR/D6hdxjO0sPg4vBu5lQnu75rNLpRNpzIICvzYA=@vger.kernel.org
X-Received: by 2002:a05:620a:4016:b0:862:75e0:76e8 with SMTP id af79cd13be357-883535590bdmr909460785a.42.1759991110348;
        Wed, 08 Oct 2025 23:25:10 -0700 (PDT)
X-Received: by 2002:a05:620a:4016:b0:862:75e0:76e8 with SMTP id af79cd13be357-883535590bdmr909458885a.42.1759991109866;
        Wed, 08 Oct 2025 23:25:09 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a274d0fcsm136973085a.55.2025.10.08.23.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:25:08 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Paul Aurich <paul@darkrain42.org>,
	Steve French <stfrench@microsoft.com>,
	Cliff Liu <donghua.liu@windriver.com>,
	He Zhe <Zhe.He@windriver.com>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v6.1] smb: prevent use-after-free due to open_cached_dir error paths
Date: Wed,  8 Oct 2025 23:08:46 -0700
Message-Id: <20251009060846.351250-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Paul Aurich <paul@darkrain42.org>

commit a9685b409a03b73d2980bbfa53eb47555802d0a9 upstream.

If open_cached_dir() encounters an error parsing the lease from the
server, the error handling may race with receiving a lease break,
resulting in open_cached_dir() freeing the cfid while the queued work is
pending.

Update open_cached_dir() to drop refs rather than directly freeing the
cfid.

Have cached_dir_lease_break(), cfids_laundromat_worker(), and
invalidate_all_cached_dirs() clear has_lease immediately while still
holding cfids->cfid_list_lock, and then use this to also simplify the
reference counting in cfids_laundromat_worker() and
invalidate_all_cached_dirs().

Fixes this KASAN splat (which manually injects an error and lease break
in open_cached_dir()):

==================================================================
BUG: KASAN: slab-use-after-free in smb2_cached_lease_break+0x27/0xb0
Read of size 8 at addr ffff88811cc24c10 by task kworker/3:1/65

CPU: 3 UID: 0 PID: 65 Comm: kworker/3:1 Not tainted 6.12.0-rc6-g255cf264e6e5-dirty #87
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
Workqueue: cifsiod smb2_cached_lease_break
Call Trace:
 <TASK>
 dump_stack_lvl+0x77/0xb0
 print_report+0xce/0x660
 kasan_report+0xd3/0x110
 smb2_cached_lease_break+0x27/0xb0
 process_one_work+0x50a/0xc50
 worker_thread+0x2ba/0x530
 kthread+0x17c/0x1c0
 ret_from_fork+0x34/0x60
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 2464:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 open_cached_dir+0xa7d/0x1fb0
 smb2_query_path_info+0x43c/0x6e0
 cifs_get_fattr+0x346/0xf10
 cifs_get_inode_info+0x157/0x210
 cifs_revalidate_dentry_attr+0x2d1/0x460
 cifs_getattr+0x173/0x470
 vfs_statx_path+0x10f/0x160
 vfs_statx+0xe9/0x150
 vfs_fstatat+0x5e/0xc0
 __do_sys_newfstatat+0x91/0xf0
 do_syscall_64+0x95/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 2464:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x51/0x70
 kfree+0x174/0x520
 open_cached_dir+0x97f/0x1fb0
 smb2_query_path_info+0x43c/0x6e0
 cifs_get_fattr+0x346/0xf10
 cifs_get_inode_info+0x157/0x210
 cifs_revalidate_dentry_attr+0x2d1/0x460
 cifs_getattr+0x173/0x470
 vfs_statx_path+0x10f/0x160
 vfs_statx+0xe9/0x150
 vfs_fstatat+0x5e/0xc0
 __do_sys_newfstatat+0x91/0xf0
 do_syscall_64+0x95/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Last potentially related work creation:
 kasan_save_stack+0x33/0x60
 __kasan_record_aux_stack+0xad/0xc0
 insert_work+0x32/0x100
 __queue_work+0x5c9/0x870
 queue_work_on+0x82/0x90
 open_cached_dir+0x1369/0x1fb0
 smb2_query_path_info+0x43c/0x6e0
 cifs_get_fattr+0x346/0xf10
 cifs_get_inode_info+0x157/0x210
 cifs_revalidate_dentry_attr+0x2d1/0x460
 cifs_getattr+0x173/0x470
 vfs_statx_path+0x10f/0x160
 vfs_statx+0xe9/0x150
 vfs_fstatat+0x5e/0xc0
 __do_sys_newfstatat+0x91/0xf0
 do_syscall_64+0x95/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff88811cc24c00
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 16 bytes inside of
 freed 1024-byte region [ffff88811cc24c00, ffff88811cc25000)

Cc: stable@vger.kernel.org
Signed-off-by: Paul Aurich <paul@darkrain42.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Do not apply the change for cfids_laundromat_worker() since there is no
  this function and related feature on 6.1.y. Update open_cached_dir()
  according to method of upstream patch. ]
Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
[Shivani: Modified to apply on 6.1.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 fs/smb/client/cached_dir.c | 39 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 3d028b6a2..23a57a0c8 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -320,17 +320,13 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		/*
 		 * We are guaranteed to have two references at this point.
 		 * One for the caller and one for a potential lease.
-		 * Release the Lease-ref so that the directory will be closed
-		 * when the caller closes the cached handle.
+		 * Release one here, and the second below.
 		 */
 		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	}
 	if (rc) {
-		if (cfid->is_open)
-			SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
-				   cfid->fid.volatile_fid);
-		free_cached_dir(cfid);
-		cfid = NULL;
+		cfid->has_lease = false;
+		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	}
 
 	if (rc == 0) {
@@ -462,25 +458,24 @@ void invalidate_all_cached_dirs(struct cifs_tcon *tcon)
 		cfids->num_entries--;
 		cfid->is_open = false;
 		cfid->on_list = false;
-		/* To prevent race with smb2_cached_lease_break() */
-		kref_get(&cfid->refcount);
+		if (cfid->has_lease) {
+			/*
+			 * The lease was never cancelled from the server,
+			 * so steal that reference.
+			 */
+			cfid->has_lease = false;
+		} else
+			kref_get(&cfid->refcount);
 	}
 	spin_unlock(&cfids->cfid_list_lock);
 
 	list_for_each_entry_safe(cfid, q, &entry, entry) {
 		list_del(&cfid->entry);
 		cancel_work_sync(&cfid->lease_break);
-		if (cfid->has_lease) {
-			/*
-			 * We lease was never cancelled from the server so we
-			 * need to drop the reference.
-			 */
-			spin_lock(&cfids->cfid_list_lock);
-			cfid->has_lease = false;
-			spin_unlock(&cfids->cfid_list_lock);
-			kref_put(&cfid->refcount, smb2_close_cached_fid);
-		}
-		/* Drop the extra reference opened above*/
+		/*
+		 * Drop the ref-count from above, either the lease-ref (if there
+		 * was one) or the extra one acquired.
+		 */
 		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	}
 }
@@ -491,9 +486,6 @@ smb2_cached_lease_break(struct work_struct *work)
 	struct cached_fid *cfid = container_of(work,
 				struct cached_fid, lease_break);
 
-	spin_lock(&cfid->cfids->cfid_list_lock);
-	cfid->has_lease = false;
-	spin_unlock(&cfid->cfids->cfid_list_lock);
 	kref_put(&cfid->refcount, smb2_close_cached_fid);
 }
 
@@ -511,6 +503,7 @@ int cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16])
 		    !memcmp(lease_key,
 			    cfid->fid.lease_key,
 			    SMB2_LEASE_KEY_SIZE)) {
+			cfid->has_lease = false;
 			cfid->time = 0;
 			/*
 			 * We found a lease remove it from the list
-- 
2.40.4


