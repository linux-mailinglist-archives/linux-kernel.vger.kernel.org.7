Return-Path: <linux-kernel+bounces-792889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17826B3CA03
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D3C208257
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D392749C5;
	Sat, 30 Aug 2025 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTa9iCie"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273327281D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548876; cv=none; b=Edf4Zd6fsz1rfQ6XZsN8E0Urly3rSaIDTN7FZBtbdUefOkgP6qk6aPP7DjCFA26LBs0ooHW40tvOoN7BCh75cD/C0G9dNjs3ood2J8GwDvS/7y4MQHhxLNAMpuclxTOQ72lcGlJZfF+6QyTiyI77V8nIQSwI6+s5xOgud5QYkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548876; c=relaxed/simple;
	bh=Vrkoh8IOmMVywrgiT6ngFzkEZymnYYLyqmoB0PKcwm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtSdBPWfcRpHynTvmCpOj3VpAt2/UxphaAQdfzIrmv3pGXtPoOp2DXFxEJt+PUV3j3jIJC4jHov2tFf2bsmI1Opxr4MBcDrXX8QiUU8/pWHWgFkbVsE74d1ydyR9Gm+Sqx9Aix+Mf9E6n7WVIG/6YG6a5VoVK6VTVY8IcCL+aLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTa9iCie; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so606375e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548871; x=1757153671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqQERp9ijgUEo0uTxYHd0/Cc4u1lie+Utk8ZGWvtmtg=;
        b=TTa9iCieKyEHT0EIQ9HZIgq/eL+rCU/ItjHIvbMNbQr64Hkt2QqgMVVL8YjE+AyZ1x
         ymB9uu42O6fNLjeiK3B5iAj0dTAWmIxxo2m1Ti3p6T3xKfimiasIxtSxZCzUh2ZcUgKu
         oNJJiOk10+3RaG3uynW1VUybSv5lLOzkl8mj2QMU8zrKnwJKqtdRIQdZvPHLGPEX+n9Y
         yZj7+8L3fCJXg98V3fzfG611PFSqlMtJunFluJyi3X9YSjNBwUpW99XkQHfwnzIRmD3c
         Q8CbgrVOVt14r8fBpgytzfUEX2sqM6n3n6BPZMNHEbVeg4jwC28Z7z/PW3NQd/dZ/AX1
         pmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548871; x=1757153671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqQERp9ijgUEo0uTxYHd0/Cc4u1lie+Utk8ZGWvtmtg=;
        b=Sq3oyYB1NcxN58bS27MHObIU9p8H8ZregIwtVd3UNfdUNUVAokVN2BV4ZhVfVt4FYq
         q4W6vWitnQ1JWxdBFyCJGFIS9a2d5TfGFQDB7KoCxiMOoHbVSCwxJpEWAs3e9vYXdagi
         o8pbK+Avb1OZuliIwlPdJW2Q/PtdOPA0L6hbRgLvvqIzGSi0okT3yfi1wPaiYfe3Qpqj
         XG7UMHn35CI6CrJnMZvpjVeeGxEHQ/fpbCi6od8aP1DbKkoRalN2yWYuZo29pMtxmaBV
         yal+BnDU9yIrA8SDy4fF0DpciHEsgt03fc1BbVNjIcAXvn47syZw3xQCkjneCJFsqUtU
         AjSw==
X-Gm-Message-State: AOJu0Yx1jghC79GBuWtWP/dZhSALUeq1WkDcEypL2VRiwLuVphj31U+j
	BR20WR/2obaAz4PZ2+ptqjtcNDpmPETEEwKoC65bUKi8TiU9i+GjVe6J
X-Gm-Gg: ASbGncs05ybOx5ZCb5RW7o9vuzRxd8RMQ92LRIkMjHXxz6WijTe7xFa/LsUi/tXDyhl
	oX5RyzxdK54l70zyQhoDj9CjqQFblFENVT/fI8YdClTddhTxN3exEcdWnwFFqCrONle1FM9tjVC
	iBqvSVfDu5x9zJXEV2KMr6PMP0m4NsvSeh3Sll4MKLlHCSE9rbOf6JNlNbMq8Nf0C43t3KtdXxV
	2AadjcBLJoUxu7Y1nzv52T76Njv7Dl1r/bOueB6EEIT/HFN7VuoaspAcW+7dtc24byYiYR5ibS2
	0TMDqrBtgq94KRYHeGPRKYqXo0xd5oZHiL73YcZlxGDWHOyd0dbw7YGcX9FyLScndY5zoYYjorZ
	yGi6ToEsZ2weklosqH+ehXm7njbu3X39uLJ3wrfPx1oEWLP47FWaOImA5+3ty6cIMbyvMRfW2Nx
	dI6SJz5mDyW3CfT3gM/7rwrL3BSVaevm1oWRbUaWdgpFjSZnF5lPs/k9ojr4TKVhQu7PxKFaefO
	uvVtgcV
X-Google-Smtp-Source: AGHT+IFQGMY4LTFziePc6Tf79PZD05xrbRO7Mx+alU5py1bnWCJAkyeChd/SGbf5AfX26u6Uk9P1PQ==
X-Received: by 2002:a05:6000:2909:b0:3d1:b8dd:c1c2 with SMTP id ffacd0b85a97d-3d1dc5a2febmr1135481f8f.13.1756548871295;
        Sat, 30 Aug 2025 03:14:31 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:30 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 12/12] fix: imrpove l/c error
Date: Sat, 30 Aug 2025 12:14:13 +0200
Message-ID: <20250830101413.602637-12-226562783+SigAttilio@users.noreply.github.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
References: <20250830101413.602637-1-226562783+SigAttilio@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 fs/dlm/lock.c | 635 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 442 insertions(+), 193 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 6b0ab9e1bfcc..4dfde93f4056 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5513,264 +5513,513 @@ static void purge_dead_list(struct dlm_ls *ls, struct dlm_rsb *r,
 				rsb_set_flag(r, RSB_RECOVER_LVB_INVAL);
 			}
 
-int dlm_user_unlock(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
-		    uint32_t flags, uint32_t lkid, char *lvb_in)
-{
-	struct dlm_lkb *lkb;
-	struct dlm_args args;
-	struct dlm_user_args *ua;
-	int error;
+			del_lkb(r, lkb);
 
-	dlm_lock_recovery(ls);
+			/* this put should free the lkb */
+			if (!dlm_put_lkb(lkb))
+				log_error(ls, "purged dead lkb not released");
 
-	error = find_lkb(ls, lkid, &lkb);
-	if (error)
-		goto out;
+			rsb_set_flag(r, RSB_RECOVER_GRANT);
 
-	trace_dlm_unlock_start(ls, lkb, flags);
+			(*count)++;
+		}
+	}
+}
 
-	ua = lkb->lkb_ua;
+/* Get rid of locks held by nodes that are gone. */
 
-	if (lvb_in && ua->lksb.sb_lvbptr)
-		memcpy(ua->lksb.sb_lvbptr, lvb_in, DLM_USER_LVB_LEN);
-	if (ua_tmp->castparam)
-		ua->castparam = ua_tmp->castparam;
-	ua->user_lksb = ua_tmp->user_lksb;
+void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list)
+{
+	struct dlm_rsb *r;
+	struct dlm_member *memb;
+	int nodes_count = 0;
+	int nodeid_gone = 0;
+	unsigned int lkb_count = 0;
 
-	error = set_unlock_args(flags, ua, &args);
-	if (error)
-		goto out_put;
+	/* cache one removed nodeid to optimize the common
+	   case of a single node removed */
 
-	error = unlock_lock(ls, lkb, &args);
+	list_for_each_entry(memb, &ls->ls_nodes_gone, list) {
+		nodes_count++;
+		nodeid_gone = memb->nodeid;
+	}
 
-	if (error == -DLM_EUNLOCK)
-		error = 0;
-	/* from validate_unlock_args() */
-	if (error == -EBUSY && (flags & DLM_LKF_FORCEUNLOCK))
-		error = 0;
-	if (error)
-		goto out_put;
+	if (!nodes_count)
+		return;
 
-	spin_lock_bh(&ua->proc->locks_spin);
-	/* dlm_user_add_cb() may have already taken lkb off the proc list */
-	if (!list_empty(&lkb->lkb_ownqueue))
-		list_move(&lkb->lkb_ownqueue, &ua->proc->unlocking);
-	spin_unlock_bh(&ua->proc->locks_spin);
- out_put:
-	trace_dlm_unlock_end(ls, lkb, flags, error);
-	dlm_put_lkb(lkb);
- out:
-	dlm_unlock_recovery(ls);
-	kfree(ua_tmp);
-	return error;
+	list_for_each_entry(r, root_list, res_root_list) {
+		lock_rsb(r);
+		if (r->res_nodeid != -1 && is_master(r)) {
+			purge_dead_list(ls, r, &r->res_grantqueue,
+					nodeid_gone, &lkb_count);
+			purge_dead_list(ls, r, &r->res_convertqueue,
+					nodeid_gone, &lkb_count);
+			purge_dead_list(ls, r, &r->res_waitqueue,
+					nodeid_gone, &lkb_count);
+		}
+		unlock_rsb(r);
+
+		cond_resched();
+	}
+
+	if (lkb_count)
+		log_rinfo(ls, "dlm_recover_purge %u locks for %u nodes",
+			  lkb_count, nodes_count);
 }
 
-int dlm_user_cancel(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
-		    uint32_t flags, uint32_t lkid)
+static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls)
 {
-	struct dlm_lkb *lkb;
-	struct dlm_args args;
-	struct dlm_user_args *ua;
-	int error;
+	struct dlm_rsb *r;
 
-	dlm_lock_recovery(ls);
+	read_lock_bh(&ls->ls_rsbtbl_lock);
+	list_for_each_entry(r, &ls->ls_slow_active, res_slow_list) {
+		if (!rsb_flag(r, RSB_RECOVER_GRANT))
+			continue;
+		if (!is_master(r)) {
+			rsb_clear_flag(r, RSB_RECOVER_GRANT);
+			continue;
+		}
+		hold_rsb(r);
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		return r;
+	}
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
+	return NULL;
+}
 
-	error = find_lkb(ls, lkid, &lkb);
-	if (error)
-		goto out;
+/*
+ * Attempt to grant locks on resources that we are the master of.
+ * Locks may have become grantable during recovery because locks
+ * from departed nodes have been purged (or not rebuilt), allowing
+ * previously blocked locks to now be granted.  The subset of rsb's
+ * we are interested in are those with lkb's on either the convert or
+ * waiting queues.
+ *
+ * Simplest would be to go through each master rsb and check for non-empty
+ * convert or waiting queues, and attempt to grant on those rsbs.
+ * Checking the queues requires lock_rsb, though, for which we'd need
+ * to release the rsbtbl lock.  This would make iterating through all
+ * rsb's very inefficient.  So, we rely on earlier recovery routines
+ * to set RECOVER_GRANT on any rsb's that we should attempt to grant
+ * locks for.
+ */
 
-	trace_dlm_unlock_start(ls, lkb, flags);
+void dlm_recover_grant(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r;
+	unsigned int count = 0;
+	unsigned int rsb_count = 0;
+	unsigned int lkb_count = 0;
+
+	while (1) {
+		r = find_grant_rsb(ls);
+		if (!r)
+			break;
 
-	ua = lkb->lkb_ua;
-	if (ua_tmp->castparam)
-		ua->castparam = ua_tmp->castparam;
-	ua->user_lksb = ua_tmp->user_lksb;
+		rsb_count++;
+		count = 0;
+		lock_rsb(r);
+		/* the RECOVER_GRANT flag is checked in the grant path */
+		grant_pending_locks(r, &count);
+		rsb_clear_flag(r, RSB_RECOVER_GRANT);
+		lkb_count += count;
+		confirm_master(r, 0);
+		unlock_rsb(r);
+		put_rsb(r);
+		cond_resched();
+	}
 
-	error = set_unlock_args(flags, ua, &args);
-	if (error)
-		goto out_put;
+	if (lkb_count)
+		log_rinfo(ls, "dlm_recover_grant %u locks on %u resources",
+			  lkb_count, rsb_count);
+}
 
-	error = cancel_lock(ls, lkb, &args);
+static struct dlm_lkb *search_remid_list(struct list_head *head, int nodeid,
+					 uint32_t remid)
+{
+	struct dlm_lkb *lkb;
 
-	if (error == -DLM_ECANCEL)
-		error = 0;
-	/* from validate_unlock_args() */
-	if (error == -EBUSY)
-		error = 0;
- out_put:
-	trace_dlm_unlock_end(ls, lkb, flags, error);
-	dlm_put_lkb(lkb);
- out:
-	dlm_unlock_recovery(ls);
-	kfree(ua_tmp);
-	return error;
+	list_for_each_entry(lkb, head, lkb_statequeue) {
+		if (lkb->lkb_nodeid == nodeid && lkb->lkb_remid == remid)
+			return lkb;
+	}
+	return NULL;
 }
 
-int dlm_user_deadlock(struct dlm_ls *ls, uint32_t flags, uint32_t lkid)
+static struct dlm_lkb *search_remid(struct dlm_rsb *r, int nodeid,
+				    uint32_t remid)
 {
 	struct dlm_lkb *lkb;
-	struct dlm_args args;
-	struct dlm_user_args *ua;
-	struct dlm_rsb *r;
-	int error;
 
-	dlm_lock_recovery(ls);
+	lkb = search_remid_list(&r->res_grantqueue, nodeid, remid);
+	if (lkb)
+		return lkb;
+	lkb = search_remid_list(&r->res_convertqueue, nodeid, remid);
+	if (lkb)
+		return lkb;
+	lkb = search_remid_list(&r->res_waitqueue, nodeid, remid);
+	if (lkb)
+		return lkb;
+	return NULL;
+}
+
+/* needs at least dlm_rcom + rcom_lock */
+static int receive_rcom_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
+				  struct dlm_rsb *r, const struct dlm_rcom *rc)
+{
+	struct rcom_lock *rl = (struct rcom_lock *) rc->rc_buf;
+
+	lkb->lkb_nodeid = le32_to_cpu(rc->rc_header.h_nodeid);
+	lkb->lkb_ownpid = le32_to_cpu(rl->rl_ownpid);
+	lkb->lkb_remid = le32_to_cpu(rl->rl_lkid);
+	lkb->lkb_exflags = le32_to_cpu(rl->rl_exflags);
+	dlm_set_dflags_val(lkb, le32_to_cpu(rl->rl_flags));
+	set_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags);
+	lkb->lkb_lvbseq = le32_to_cpu(rl->rl_lvbseq);
+	lkb->lkb_rqmode = rl->rl_rqmode;
+	lkb->lkb_grmode = rl->rl_grmode;
+	/* don't set lkb_status because add_lkb wants to itself */
+
+	lkb->lkb_bastfn = (rl->rl_asts & DLM_CB_BAST) ? &fake_bastfn : NULL;
+	lkb->lkb_astfn = (rl->rl_asts & DLM_CB_CAST) ? &fake_astfn : NULL;
+
+	if (lkb->lkb_exflags & DLM_LKF_VALBLK) {
+		int lvblen = le16_to_cpu(rc->rc_header.h_length) -
+			sizeof(struct dlm_rcom) - sizeof(struct rcom_lock);
+		if (lvblen > ls->ls_lvblen)
+			return -EINVAL;
+		lkb->lkb_lvbptr = dlm_allocate_lvb(ls);
+		if (!lkb->lkb_lvbptr)
+			return -ENOMEM;
+		memcpy(lkb->lkb_lvbptr, rl->rl_lvb, lvblen);
+	}
 
-	error = find_lkb(ls, lkid, &lkb);
-	if (error)
-		goto out;
+	/* Conversions between PR and CW (middle modes) need special handling.
+	   The real granted mode of these converting locks cannot be determined
+	   until all locks have been rebuilt on the rsb (recover_conversion) */
 
-	trace_dlm_unlock_start(ls, lkb, flags);
+	if (rl->rl_status == DLM_LKSTS_CONVERT && middle_conversion(lkb)) {
+		/* We may need to adjust grmode depending on other granted locks. */
+		log_limit(ls, "%s %x middle convert in progress", __func__,
+			 lkb->lkb_id);
 
-	ua = lkb->lkb_ua;
+		/* We sent this lock to the new master. The new master will
+		 * tell us when it's granted.  We no longer need a reply, so
+		 * use a fake reply to put the lkb into the right state.
+		 */
+		hold_lkb(lkb);
+		memset(ms_local, 0, sizeof(struct dlm_message));
+		ms_local->m_type = cpu_to_le32(DLM_MSG_CONVERT_REPLY);
+		ms_local->m_result = cpu_to_le32(to_dlm_errno(-EINPROGRESS));
+		ms_local->m_header.h_nodeid = cpu_to_le32(lkb->lkb_nodeid);
+		_receive_convert_reply(lkb, ms_local, true);
+		unhold_lkb(lkb);
 
-	error = set_unlock_args(flags, ua, &args);
-	if (error)
-		goto out_put;
+	} else if (lkb->lkb_rqmode >= lkb->lkb_grmode) {
+		set_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
+	}
 
-	/* same as cancel_lock(), but set DEADLOCK_CANCEL after lock_rsb */
+	/* lkb->lkb_rqmode < lkb->lkb_grmode shouldn't happen since down
+	   conversions are async; there's no reply from the remote master */
+}
 
-	r = lkb->lkb_resource;
-	hold_rsb(r);
-	lock_rsb(r);
+/* A waiting lkb needs recovery if the master node has failed, or
+   the master node is changing (only when no directory is used) */
 
-	error = validate_unlock_args(lkb, &args);
-	if (error)
-		goto out_r;
-	set_bit(DLM_IFL_DEADLOCK_CANCEL_BIT, &lkb->lkb_iflags);
+static int waiter_needs_recovery(struct dlm_ls *ls, struct dlm_lkb *lkb,
+				 int dir_nodeid)
+{
+	if (dlm_no_directory(ls))
+		return 1;
 
-	error = _cancel_lock(r, lkb);
- out_r:
-	unlock_rsb(r);
-	put_rsb(r);
+	if (dlm_is_removed(ls, lkb->lkb_wait_nodeid))
+		return 1;
 
-	if (error == -DLM_ECANCEL)
-		error = 0;
-	/* from validate_unlock_args() */
-	if (error == -EBUSY)
-		error = 0;
- out_put:
-	trace_dlm_unlock_end(ls, lkb, flags, error);
-	dlm_put_lkb(lkb);
- out:
-	dlm_unlock_recovery(ls);
-	return error;
+	return 0;
 }
 
-/* lkb's that are removed from the waiters list by revert are just left on the
-   orphans list with the granted orphan locks, to be freed by purge */
+/* Recovery for locks that are waiting for replies from nodes that are now
+   gone.  We can just complete unlocks and cancels by faking a reply from the
+   dead node.  Requests and up-conversions we flag to be resent after
+   recovery.  Down-conversions can just be completed with a fake reply like
+   unlocks.  Conversions between PR and CW need special attention. */
 
-static int orphan_proc_lock(struct dlm_ls *ls, struct dlm_lkb *lkb)
+void dlm_recover_waiters_pre(struct dlm_ls *ls)
 {
-	struct dlm_args args;
-	int error;
+	struct dlm_lkb *lkb, *safe;
+	struct dlm_message *ms_local;
+	int wait_type, local_unlock_result, local_cancel_result;
+	int dir_nodeid;
 
-	hold_lkb(lkb); /* reference for the ls_orphans list */
-	spin_lock_bh(&ls->ls_orphans_lock);
-	list_add_tail(&lkb->lkb_ownqueue, &ls->ls_orphans);
-	spin_unlock_bh(&ls->ls_orphans_lock);
+	ms_local = kmalloc(sizeof(*ms_local), GFP_KERNEL);
+	if (!ms_local)
+		return;
 
-	set_unlock_args(0, lkb->lkb_ua, &args);
+	list_for_each_entry_safe(lkb, safe, &ls->ls_waiters, lkb_wait_reply) {
 
-	error = cancel_lock(ls, lkb, &args);
-	if (error == -DLM_ECANCEL)
-		error = 0;
-	return error;
-}
+		dir_nodeid = dlm_dir_nodeid(lkb->lkb_resource);
 
-/* The FORCEUNLOCK flag allows the unlock to go ahead even if the lkb isn't
-   granted.  Regardless of what rsb queue the lock is on, it's removed and
-   freed.  The IVVALBLK flag causes the lvb on the resource to be invalidated
-   if our lock is PW/EX (it's ignored if our granted mode is smaller.) */
+		/* exclude debug messages about unlocks because there can be so
+		   many and they aren't very interesting */
 
-static int unlock_proc_lock(struct dlm_ls *ls, struct dlm_lkb *lkb)
-{
-	struct dlm_args args;
-	int error;
+		if (lkb->lkb_wait_type != DLM_MSG_UNLOCK) {
+			log_debug(ls, "waiter %x remote %x msg %d r_nodeid %d "
+				  "lkb_nodeid %d wait_nodeid %d dir_nodeid %d",
+				  lkb->lkb_id,
+				  lkb->lkb_remid,
+				  lkb->lkb_wait_type,
+				  lkb->lkb_resource->res_nodeid,
+				  lkb->lkb_nodeid,
+				  lkb->lkb_wait_nodeid,
+				  dir_nodeid);
+		}
 
-	set_unlock_args(DLM_LKF_FORCEUNLOCK | DLM_LKF_IVVALBLK,
-			lkb->lkb_ua, &args);
+		/* all outstanding lookups, regardless of destination  will be
+		   resent after recovery is done */
 
-	error = unlock_lock(ls, lkb, &args);
-	if (error == -DLM_EUNLOCK)
-		error = 0;
-	return error;
-}
+		if (lkb->lkb_wait_type == DLM_MSG_LOOKUP) {
+			set_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
+			continue;
+		}
 
-/* We have to release clear_proc_locks mutex before calling unlock_proc_lock()
-   (which does lock_rsb) due to deadlock with receiving a message that does
-   lock_rsb followed by dlm_user_add_cb() */
+		if (!waiter_needs_recovery(ls, lkb, dir_nodeid))
+			continue;
 
-static struct dlm_lkb *del_proc_lock(struct dlm_ls *ls,
-				     struct dlm_user_proc *proc)
-{
-	struct dlm_lkb *lkb = NULL;
+		wait_type = lkb->lkb_wait_type;
+		local_unlock_result = -DLM_EUNLOCK;
+		local_cancel_result = -DLM_ECANCEL;
 
-	spin_lock_bh(&ls->ls_clear_proc_locks);
-	if (list_empty(&proc->locks))
-		goto out;
+		/* Main reply may have been received leaving a zero wait_type,
+		   but a reply for the overlapping op may not have been
+		   received.  In that case we need to fake the appropriate
+		   reply for the overlap op. */
 
-	lkb = list_entry(proc->locks.next, struct dlm_lkb, lkb_ownqueue);
-	list_del_init(&lkb->lkb_ownqueue);
+		if (!wait_type) {
+			if (is_overlap_cancel(lkb)) {
+				wait_type = DLM_MSG_CANCEL;
+				if (lkb->lkb_grmode == DLM_LOCK_IV)
+					local_cancel_result = 0;
+			}
+			if (is_overlap_unlock(lkb)) {
+				wait_type = DLM_MSG_UNLOCK;
+				if (lkb->lkb_grmode == DLM_LOCK_IV)
+					local_unlock_result = -ENOENT;
+			}
 
-	if (lkb->lkb_exflags & DLM_LKF_PERSISTENT)
-		set_bit(DLM_DFL_ORPHAN_BIT, &lkb->lkb_dflags);
-	else
-		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
- out:
-	spin_unlock_bh(&ls->ls_clear_proc_locks);
-	return lkb;
-}
+			log_debug(ls, "rwpre overlap %x %x %d %d %d",
+				  lkb->lkb_id, dlm_iflags_val(lkb), wait_type,
+				  local_cancel_result, local_unlock_result);
+		}
 
-/* The ls_clear_proc_locks mutex protects against dlm_user_add_cb() which
-   1) references lkb->ua which we free here and 2) adds lkbs to proc->asts,
-   which we clear here. */
+		switch (wait_type) {
 
-/* proc CLOSING flag is set so no more device_reads should look at proc->asts
-   list, and no more device_writes should add lkb's to proc->locks list; so we
-   shouldn't need to take asts_spin or locks_spin here.  this assumes that
-   device reads/writes/closes are serialized -- FIXME: we may need to serialize
-   them ourself. */
+		case DLM_MSG_REQUEST:
+			set_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
+			break;
+
+		case DLM_MSG_CONVERT:
+			recover_convert_waiter(ls, lkb, ms_local);
+			break;
+
+		case DLM_MSG_UNLOCK:
+			hold_lkb(lkb);
+			memset(ms_local, 0, sizeof(struct dlm_message));
+			ms_local->m_type = cpu_to_le32(DLM_MSG_UNLOCK_REPLY);
+			ms_local->m_result = cpu_to_le32(to_dlm_errno(local_unlock_result));
+			ms_local->m_header.h_nodeid = cpu_to_le32(lkb->lkb_nodeid);
+			_receive_unlock_reply(lkb, ms_local, true);
+			dlm_put_lkb(lkb);
+			break;
+
+		case DLM_MSG_CANCEL:
+			hold_lkb(lkb);
+			memset(ms_local, 0, sizeof(struct dlm_message));
+			ms_local->m_type = cpu_to_le32(DLM_MSG_CANCEL_REPLY);
+			ms_local->m_result = cpu_to_le32(to_dlm_errno(local_cancel_result));
+			ms_local->m_header.h_nodeid = cpu_to_le32(lkb->lkb_nodeid);
+			_receive_cancel_reply(lkb, ms_local, true);
+			dlm_put_lkb(lkb);
+			break;
+
+		default:
+			log_error(ls, "invalid lkb wait_type %d %d",
+				  lkb->lkb_wait_type, wait_type);
+		}
+		schedule();
+	}
+	kfree(ms_local);
+}
 
-void dlm_clear_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
+static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
 {
-	struct dlm_callback *cb, *cb_safe;
-	struct dlm_lkb *lkb, *safe;
+	struct dlm_lkb *lkb = NULL, *iter;
 
-	dlm_lock_recovery(ls);
+	spin_lock_bh(&ls->ls_waiters_lock);
+	list_for_each_entry(iter, &ls->ls_waiters, lkb_wait_reply) {
+		if (test_bit(DLM_IFL_RESEND_BIT, &iter->lkb_iflags)) {
+			hold_lkb(iter);
+			lkb = iter;
+			break;
+		}
+	}
+	spin_unlock_bh(&ls->ls_waiters_lock);
+
+	return lkb;
+}
+
+/*
+ * Forced state reset for locks that were in the middle of remote operations
+ * when recovery happened (i.e. lkbs that were on the waiters list, waiting
+ * for a reply from a remote operation.)  The lkbs remaining on the waiters
+ * list need to be reevaluated; some may need resending to a different node
+ * than previously, and some may now need local handling rather than remote.
+ *
+ * First, the lkb state for the voided remote operation is forcibly reset,
+ * equivalent to what remove_from_waiters() would normally do:
+ * . lkb removed from ls_waiters list
+ * . lkb wait_type cleared
+ * . lkb waiters_count cleared
+ * . lkb ref count decremented for each waiters_count (almost always 1,
+ *   but possibly 2 in case of cancel/unlock overlapping, which means
+ *   two remote replies were being expected for the lkb.)
+ *
+ * Second, the lkb is reprocessed like an original operation would be,
+ * by passing it to _request_lock or _convert_lock, which will either
+ * process the lkb operation locally, or send it to a remote node again
+ * and put the lkb back onto the waiters list.
+ *
+ * When reprocessing the lkb, we may find that it's flagged for an overlapping
+ * force-unlock or cancel, either from before recovery began, or after recovery
+ * finished.  If this is the case, the unlock/cancel is done directly, and the
+ * original operation is not initiated again (no _request_lock/_convert_lock.)
+ */
+
+int dlm_recover_waiters_post(struct dlm_ls *ls)
+{
+	struct dlm_lkb *lkb;
+	struct dlm_rsb *r;
+	int error = 0, mstype, err, oc, ou;
 
 	while (1) {
-		lkb = del_proc_lock(ls, proc);
+		if (dlm_locking_stopped(ls)) {
+			log_debug(ls, "recover_waiters_post aborted");
+			error = -EINTR;
+			break;
+		}
+
+		/* 
+		 * Find an lkb from the waiters list that's been affected by
+		 * recovery node changes, and needs to be reprocessed.  Does
+		 * hold_lkb(), adding a refcount.
+		 */
+		lkb = find_resend_waiter(ls);
 		if (!lkb)
 			break;
-		if (lkb->lkb_exflags & DLM_LKF_PERSISTENT)
-			orphan_proc_lock(ls, lkb);
-		else
-			unlock_proc_lock(ls, lkb);
 
-		/* this removes the reference for the proc->locks list
-		   added by dlm_user_request, it may result in the lkb
-		   being freed */
+		r = lkb->lkb_resource;
+		hold_rsb(r);
+		lock_rsb(r);
 
-		dlm_put_lkb(lkb);
-	}
+		/*
+		 * If the lkb has been flagged for a force unlock or cancel,
+		 * then the reprocessing below will be replaced by just doing
+		 * the unlock/cancel directly.
+		 */
+		mstype = lkb->lkb_wait_type;
+		oc = test_and_clear_bit(DLM_IFL_OVERLAP_CANCEL_BIT,
+					&lkb->lkb_iflags);
+		ou = test_and_clear_bit(DLM_IFL_OVERLAP_UNLOCK_BIT,
+					&lkb->lkb_iflags);
+		err = 0;
+
+		log_debug(ls, "waiter %x remote %x msg %d r_nodeid %d "
+			  "lkb_nodeid %d wait_nodeid %d dir_nodeid %d "
+			  "overlap %d %d", lkb->lkb_id, lkb->lkb_remid, mstype,
+			  r->res_nodeid, lkb->lkb_nodeid, lkb->lkb_wait_nodeid,
+			  dlm_dir_nodeid(r), oc, ou);
 
-	spin_lock_bh(&ls->ls_clear_proc_locks);
+		/*
+		 * No reply to the pre-recovery operation will now be received,
+		 * so a forced equivalent of remove_from_waiters() is needed to
+		 * reset the waiters state that was in place before recovery.
+		 */
 
-	/* in-progress unlocks */
-	list_for_each_entry_safe(lkb, safe, &proc->unlocking, lkb_ownqueue) {
-		list_del_init(&lkb->lkb_ownqueue);
-		set_bit(DLM_IFL_DEAD_BIT, &lkb->lkb_iflags);
-		dlm_put_lkb(lkb);
-	}
+		clear_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
 
-	list_for_each_entry_safe(cb, cb_safe, &proc->asts, list) {
-		list_del(&cb->list);
-		dlm_free_cb(cb);
+		/* Forcibly clear wait_type */
+		lkb->lkb_wait_type = 0;
+
+		/*
+		 * Forcibly reset wait_count and associated refcount.  The
+		 * wait_count will almost always be 1, but in case of an
+		 * overlapping unlock/cancel it could be 2: see where
+		 * add_to_waiters() finds the lkb is already on the waiters
+		 * list and does lkb_wait_count++; hold_lkb().
+		 */
+		while (lkb->lkb_wait_count) {
+			lkb->lkb_wait_count--;
+			unhold_lkb(lkb);
+		}
+
+		/* Forcibly remove from waiters list */
+		spin_lock_bh(&ls->ls_waiters_lock);
+		list_del_init(&lkb->lkb_wait_reply);
+		spin_unlock_bh(&ls->ls_waiters_lock);
+
+		/*
+		 * The lkb is now clear of all prior waiters state and can be
+		 * processed locally, or sent to remote node again, or directly
+		 * cancelled/unlocked.
+		 */
+
+		if (oc || ou) {
+			/* do an unlock or cancel instead of resending */
+			switch (mstype) {
+			case DLM_MSG_LOOKUP:
+			case DLM_MSG_REQUEST:
+				queue_cast(r, lkb, ou ? -DLM_EUNLOCK :
+							-DLM_ECANCEL);
+				unhold_lkb(lkb); /* undoes create_lkb() */
+				break;
+			case DLM_MSG_CONVERT:
+				if (oc) {
+					queue_cast(r, lkb, -DLM_ECANCEL);
+				} else {
+					lkb->lkb_exflags |= DLM_LKF_FORCEUNLOCK;
+					_unlock_lock(r, lkb);
+				}
+				break;
+			default:
+				err = 1;
+			}
+		} else {
+			switch (mstype) {
+			case DLM_MSG_LOOKUP:
+			case DLM_MSG_REQUEST:
+				_request_lock(r, lkb);
+				if (r->res_nodeid != -1 && is_master(r))
+					confirm_master(r, 0);
+				break;
+			case DLM_MSG_CONVERT:
+				_convert_lock(r, lkb);
+				break;
+			default:
+				err = 1;
+			}
+		}
+
+		if (err) {
+			log_error(ls, "waiter %x msg %d r_nodeid %d "
+				  "dir_nodeid %d overlap %d %d",
+				  lkb->lkb_id, mstype, r->res_nodeid,
+				  dlm_dir_nodeid(r), oc, ou);
+		}
+		unlock_rsb(r);
+		put_rsb(r);
+		dlm_put_lkb(lkb);
 	}
 
-	spin_unlock_bh(&ls->ls_clear_proc_locks);
-	dlm_unlock_recovery(ls);
+	return error;
 }
 
 static void purge_proc_locks(struct dlm_ls *ls, struct dlm_user_proc *proc)
-- 
2.48.1


