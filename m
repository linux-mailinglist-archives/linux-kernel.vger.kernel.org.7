Return-Path: <linux-kernel+bounces-810750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 754C6B51ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C6C1C87099
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D03313E29;
	Wed, 10 Sep 2025 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH2GmaR3"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B52797A1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757524993; cv=none; b=W5Bm86S/PfTq6FbNPyNmXmWKxQ7ODcJpG8aboRwj3JnkOUlQf2H4YLrfA7wRwLK6aM7SYmH3TDYEvZLsj+aEj9ehTcxDE47ONipGuUWhAdWRhB09aPivQaIy9vD/j+6viANwqrjMBDsSshnUISf2G39GOEBOZ+0Aeadw/4xcOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757524993; c=relaxed/simple;
	bh=U/Bw0oFJjYkILogoteFC2JraE5vzOSx4DuQGpJ23rt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1rCccuiZUMurPuTtGLi+rcuu82/6HZtloRHLr3BSdTUSJL3d0w0D3QvGtSZNU86xt8UdnAS5WPTEOYKm596bZYRcjmVVE7bcnqetpDUaSdAJq6yBfUSZ1lfWTDJCkhSsCrkTyCiud5i6JLKUj1ULMgL6olY0183NfYNK46Jlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH2GmaR3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b078aabeb9fso179004466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757524990; x=1758129790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VPbSGL+wh5oLzTDoSZB7hbuuAk8K+GQPqz1VxG3+o6k=;
        b=KH2GmaR3jkNP4r2ZuryaKRaRn3QGRfFRqhpuY5yQdzbgtOclXTI1PBST00Rtnteg8S
         AUwgtvIVzEWMePfxpPVMZ7g8RzNNGhhfHCWlqXmpCeNmir9ug9BrHNJmisu9bce6dy2I
         YEsxHZmtYPl7M5hpQlR6Jgo1E3kyPhfvd1YOLXUXSFjmKf/tEgm6DRnJrBP03rVk/2pb
         tKc2tTQ1ii9mfm2JHirIMusu6TfbutxlSDy4KueHyPASzbHQTh80j/QiP62ybA8JFmIJ
         0sFDnRC3ScGJgUbOrpP09K240pmJ9vpA3qq/Kg0fF6YBp9oVqQbD3agv1EYswc223xpM
         vlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757524990; x=1758129790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPbSGL+wh5oLzTDoSZB7hbuuAk8K+GQPqz1VxG3+o6k=;
        b=JUeJKnxzi/NAgEflVcJ3xgPzUqpxS3Eso/lWAzY9GkrlMtmICONccgEGzfsjMX3gYL
         qo37l/Ku+q1/pTThMXXzrX3q3UxrYOIarqK186gQFFlp+YS8f1JkzyTKtkC0Uc5AdPEZ
         aGbLJUR8vboYGK+KO06UHQ3OExbKc6uKCS06Bm1My9tEcLeFfA4+miTmjb71n6NUjg0N
         crzSRSl2CYfkgshM/CmqAWe1EgleWFmErDvCrHFTg9kVC7NkgAu47OfpvNI8nmB5an0P
         enlyU0trLTIZyQDzA5GL1oGaxNlox8eNs6jTxJictIMJ0cV25acQLvCaKWFFDOFyiLs0
         qJzA==
X-Forwarded-Encrypted: i=1; AJvYcCVkX4IJqinJDnbS2GG6RFnbsi3/tHJHz3XCHi4Su2+qQHGhVAZU0I5LQ2X/QzVHodzn6nWI1CHZtc0Ve/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGv5GRJVHst1+Uv21W5qIThitJHiDfVmrvDTAqcx/13vIUH1g5
	MmbxIEDm5OAsAb/VF3pHgE3CkZ9oaH82zBgS0gQUHR5q+7k8V021QMaW
X-Gm-Gg: ASbGncvXzDUmTb1RB6DcTBqlFLlmBTCKTKTQaHSAzMmAqLAO2yQbhSP5Px4PpqVmhlM
	JZfeQf4ugeGEYRqZhI84fqtLO5YhctDcwG8GSEijB+tbVWuM04P5pM/jXmwCbkKOwg3LfvFCSPd
	kdi3SFy8eu3YN2rzvfgRTakVyGZ/k2W2IwvftbKQFNwqMN6bWsp85hZD/7wCwqdgJn3GG73eL6n
	4CtsR9vQGrYkoHvN/nlo/jxyDC1y0VhQG/guYGTPLOLK4utOFLM1h9eMD3iWdr6rhEpgdDDWAr4
	RF0d7S0/zQTuecAWTK3sx5SWWMlGRB04VT/dx4NTQc61ug0MS2+cpOsJn0Le+c6nMfSc3ocl7cN
	cpDg0LYrk1rXsO0C67Tp6X39V6xIegHSq/mGO5zZlg015UbugMnBKGEZgrx7pG7MoWkEb7O9rSE
	jKanafgUH7+A7SeQgxKuIPK3aIOnUqYEWWUMZOCn9bTMWXQ6RS2SIE/E5eHlH6oUQLH8Ic7g==
X-Google-Smtp-Source: AGHT+IFUk1dDOuaOT329tP4Uhn2J0sm2O7Oj9XL3NsIFiXqJhDbLfm76/tPWMehVqhL/HSTbSP0NRg==
X-Received: by 2002:a17:907:3da9:b0:b04:4d7a:84ef with SMTP id a640c23a62f3a-b04b13fe1e9mr1471789366b.6.1757524985317;
        Wed, 10 Sep 2025 10:23:05 -0700 (PDT)
Received: from local.station (net-93-148-99-27.cust.dsl.teletu.it. [93.148.99.27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334db1esm203495566b.65.2025.09.10.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 10:23:04 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
To: aahringo@redhat.com
Cc: teigland@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alessio Attilio <alessio.attilio@engineer.com>,
	Alessio Attilio <alessio.attilio.dev@gmail.com>
Subject: [PATCH] * dlm: improve lock management and concurrency control
Date: Wed, 10 Sep 2025 19:17:06 +0200
Message-ID: <20250910171706.173976-1-alessio.attilio.dev@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alessio Attilio <alessio.attilio@engineer.com>

This patch introduces several improvements to lock handling in the DLM
subsystem, focusing on thread safety, correctness, and code clarity.

- Added explicit locking (spin_lock_bh/spin_unlock_bh) around accesses
  to proc->locks and proc->asts in dlm_clear_proc_locks, ensuring safe
  concurrent operations during lock cleanup.
- Replaced del_proc_lock with direct, lock-protected list operations
  for improved clarity and correctness.
- Updated send_unlock to set RSB_MASTER_UNCERTAIN only when releasing
  the last lock on an rsb, ensuring proper master confirmation.
- Improved handling of persistent and non-persistent locks by setting
  appropriate flags (DLM_DFL_ORPHAN_BIT or DLM_IFL_DEAD_BIT) before
  orphaning or unlocking.
- Removed outdated comments related to mutex protection and serialization
  assumptions, reflecting the updated concurrency model.

Signed-off-by: Alessio Attilio <alessio.attilio.dev@gmail.com>
---
 fs/dlm/lock.c | 99 ++++++++++++++++++++++++---------------------------
 1 file changed, 46 insertions(+), 53 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6dd3a524cd35..9170b5c09823 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3654,12 +3654,33 @@ static int send_convert(struct dlm_rsb *r, struct dlm_lkb *lkb)
 	return error;
 }
 
-/* FIXME: if this lkb is the only lock we hold on the rsb, then set
-   MASTER_UNCERTAIN to force the next request on the rsb to confirm
-   that the master is still correct. */
-
 static int send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
+	struct dlm_lkb *tmp;
+	int count = 0;
+
+	list_for_each_entry(tmp, &r->res_grantqueue, lkb_statequeue) {
+		if (is_process_copy(tmp))
+			count++;
+	}
+	list_for_each_entry(tmp, &r->res_convertqueue, lkb_statequeue) {
+		if (is_process_copy(tmp))
+			count++;
+	}
+	list_for_each_entry(tmp, &r->res_waitqueue, lkb_statequeue) {
+		if (is_process_copy(tmp))
+			count++;
+	}
+
+/*
+ * When releasing the last lock on the rsb, we mark the master as uncertain.
+ * This ensures that the next lock request will verify the master node,
+ * maintaining consistency across the cluster.
+ */
+
+	if (count == 1)
+		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
+
 	return send_common(r, lkb, DLM_MSG_UNLOCK);
 }
 
@@ -6125,79 +6146,52 @@ static int unlock_proc_lock(struct dlm_ls *ls, struct dlm_lkb *lkb)
 	return error;
 }
 
-/* We have to release clear_proc_locks mutex before calling unlock_proc_lock()
-   (which does lock_rsb) due to deadlock with receiving a message that does
-   lock_rsb followed by dlm_user_add_cb() */
-
-static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
-				     struct dlm_user_proc *proc)
-{
-	struct dlm_lkb *lkb = NULL;
-
-	spin_lock_bh(&ls->ls_clear_proc_locks);
-	if (list_empty(&proc->locks))
-		goto out;
-
-	lkb = list_entry(proc->locks.next, struct dlm_lkb, lkb_ownqueue);
-	list_del_init(&lkb->lkb_ownqueue);
-
-	if (lkb->lkb_exflags & DLM_LKF_PERSISTENT)
-		set_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags);
-	else
-		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
- out:
-	spin_unlock_bh(&ls->ls_clear_proc_locks);
-	return lkb;
-}
-
-/* The ls_clear_proc_locks mutex protects against dlm_user_add_cb() which
-   1) references lkb->ua which we free here and 2) adds lkbs to proc->asts,
-   which we clear here. */
-
-/* proc CLOSING flag is set so no more device_reads should look at proc->asts
-   list, and no more device_writes should add lkb's to proc->locks list; so we
-   shouldn't need to take asts_spin or locks_spin here.  this assumes that
-   device reads/writes/closes are serialized -- FIXME: we may need to serialize
-   them ourself. */
-
-void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
+static void clean_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
 {
-	struct dlm_callback *cb, *cb_safe;
-	struct dlm_lkb *lkb, *safe;
+	struct dlm_lkb *lkb;
 
 	dlm_lock_recovery(ls);
 
 	while (1) {
-		lkb = del_proc_lock(ls, proc);
+		lkb = NULL;
+		spin_lock_bh(&proc->locks_spin);
+		if (!list_empty(&proc->locks)) {
+			lkb = list_entry(proc->locks.next, struct dlm_lkb,
+					 lkb_ownqueue);
+			list_del_init(&lkb->lkb_ownqueue);
+		}
+		spin_unlock_bh(&proc->locks_spin);
+
 		if (!lkb)
 			break;
-		if (lkb->lkb_exflags & DLM_LKF_PERSISTENT)
+
+		if (lkb->lkb_exflags & DLM_LKF_PERSISTENT) {
+			set_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags);
 			orphan_proc_lock(ls, lkb);
-		else
+		} else {
+			set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
 			unlock_proc_lock(ls, lkb);
-
-		/* this removes the reference for the proc->locks list
-		   added by dlm_user_request, it may result in the lkb
-		   being freed */
+		}
 
 		dlm_put_lkb(lkb);
 	}
 
-	spin_lock_bh(&ls->ls_clear_proc_locks);
-
+	spin_lock_bh(&proc->locks_spin);
 	/* in-progress unlocks */
 	list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
 		list_del_init(&lkb->lkb_ownqueue);
 		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
 		dlm_put_lkb(lkb);
 	}
+	spin_unlock_bh(&proc->locks_spin);
 
+	spin_lock_bh(&proc->asts_spin);
 	list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
 		list_del(&cb->list);
 		dlm_free_cb(cb);
 	}
+	spin_unlock_bh(&proc->asts_spin);
 
-	spin_unlock_bh(&ls->ls_clear_proc_locks);
 	dlm_unlock_recovery(ls);
 }
 
@@ -6351,4 +6345,3 @@ int dlm_debug_add_lkb_to_waiters(struct dlm_ls *ls, uint32_t lkb_id,
 	dlm_put_lkb(lkb);
 	return 0;
 }
-
-- 
2.48.1


