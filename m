Return-Path: <linux-kernel+bounces-792890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46954B3CA06
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12286A0186B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66560274B2F;
	Sat, 30 Aug 2025 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lur5Te4v"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF14272E41
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548877; cv=none; b=f699ianaVQMcoxXAHoeqQbmBWWn32LFWJ7dPhpkRRXlhnCJuFkfcNO2XhrsBJPegOkKe5TGefZF+sFH0CuNraNDIBN407jYeaqpAb0d971JzenvTxACTQglgQxfilkKZfnkAnR0wB2PwLOnkKyBu65vAhC174OFlhpoSXpyNX1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548877; c=relaxed/simple;
	bh=CcXEfUMRf2cQmxE0ag5UkElhUyi/j25Pbg/E3TkcvIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzoJMqwcd1qfcu4M9oukwHWeajH4Ac1CeGwpfrgH/E0JsGYl8I3fDTdi+nTjK4Spf4Fvyz2s3hWounitBlBHcW9A5fLryrN93hfo8Obl6sHAERuaU9ufm8U0QsHIn8N6uD/xL1nbXXYocXEe38IhhsGGUdrOFJVn0+0zYQAtJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lur5Te4v; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b869d35a0so1270235e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548871; x=1757153671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoQFPVbxejJ6set8ozL+F6n6HL//jQi4uJHuOtJvdWQ=;
        b=lur5Te4vep4BnCIs1M9W18xCyrw5A4rgkE8VpUoGdE6DS0GqHMGOECmU8tpEu+dDoy
         +Q+g1txlL2pJQjjdj5JrmDgnY37tgEztpKz9W2jyMXRMEWqNZ0hf0guY81/1JJV2gnzg
         cDu4mx86CbfSzvBWv7RT7oS2EjxVsx25QFU8teOsWipfdMI6SWIzSkXJnCVWEQ9G6x6E
         sX5ZVqiLpCFZmhooKeBuvz3atnbmHxULzOC3x7AiqWWsrU6B/WpILWFOxSn7o8bSmzxi
         zEJg02l9s3ujGQUAKefEVgw7DyjYLkgbmh14sc4gyBqo12WsLax83JGE0UiFk04MWSiL
         Rxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548871; x=1757153671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoQFPVbxejJ6set8ozL+F6n6HL//jQi4uJHuOtJvdWQ=;
        b=FrzXSQoKSJmYBAY7bxh+uyyPmkBFf1KmD/h8mNPS5FReVYwu+IHiG7yV/K4CWjXzia
         B/LDn6TPa77WdD1wTwrGfoqbgegJTRj4nK82/x3+vwg96iXyPyVen2/nsnIfE0fdov5V
         HPfrQt1os/dcPjLdg+KEwzbkmyko/HqmMCfRulL0fpV235yJmHmccSOdt4aqc2j/sO5a
         CXUGqiSLYON5YVSlb4l3rUh8aBuMyK0nQvwZcgK4pYUO2qqqZQtYsUS8xzwvVT8tYjtJ
         b5vOm/4YSlt3u08/et/mx8OjwYCLPxalBsgCGVh10btvcUT/hbbeOlqFJ8LQU/HABomb
         H8Fg==
X-Gm-Message-State: AOJu0Yxne74GGsRy5tEMIvjdh6lusQBpTLbwd41FZNbeKXRssYResEXH
	y7mzUb+ium5AP4Aru+FXV6z3iWH7toumE+oV4n8+dWQmIEmviq/Wryz/wSgWldGc5fU=
X-Gm-Gg: ASbGncsY6SOhL1F2DzeZfPzIO73cACGOxD7QYD2CykiNjZxl9Us6E6f3MoSaJD/smT+
	x9uJVyJoxRTjPT5XhkNTwVcDTF6x8I3LtpKNUXhM1R+TrKfvZDiiH9WhmqmupaYBVBCIn7++8X1
	af58HnrIDMfThhWvQ8gHh812TDrz2FapdXKjFDHuBqyHCiPBRACF4XAXLBLAcirpcybwckdY9+V
	GuBJDKn5GoWuDZJ/DONOOynzbxZv4yNsj5CWfO5GuS5/CumQUDP0lUGelpGfI5LpDT6IYtL1XxW
	0MiTIqCMRifNHL/g20xuzm0IKuRKwMjwjbqPKYkVGMnDy9Rk2jwUyRCjqSP1jBfmnLFz6xFtky4
	qXAhDYa6OcpZPAqMHhqiUI0EfG+y7l4dWaO8/tJOect0V/J4Kvr19tHP3TLwm66yQeeEc3Ta4TB
	r74jJeqBLbavLWF64jRTCZhstiPmvqF7IrHgLlxHSxZQohb52VDBIRkcR1ljQASvEUvLBVVrYlL
	pLnrgyWH/RuRggrKSYDXcyDSUQitA==
X-Google-Smtp-Source: AGHT+IGGKVHMfjYrT0CqkPkXERIOl4WjRjGpCs0RJwAXxrP4wIPqf7w4uiEQzD91iM4RJuHfeX/XJA==
X-Received: by 2002:a05:600c:4705:b0:45b:74fc:d6ec with SMTP id 5b1f17b1804b1-45b8553f1e8mr14089425e9.8.1756548870328;
        Sat, 30 Aug 2025 03:14:30 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:29 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 11/12] fix: improve lkb struct
Date: Sat, 30 Aug 2025 12:14:12 +0200
Message-ID: <20250830101413.602637-11-226562783+SigAttilio@users.noreply.github.com>
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
 fs/dlm/lock.c | 752 +++++++++++++++++++++++---------------------------
 1 file changed, 346 insertions(+), 406 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 4236b38aae94..6b0ab9e1bfcc 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -5023,555 +5023,495 @@ static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
  * from the central locking logic.
  */
 
-			/* this put should free the lkb */
-			if (!dlm_put_lkb(lkb))
-				log_error(ls, "purged dead lkb not released");
+static int do_request(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	int error = 0;
 
-			rsb_set_flag(r, RSB_RECOVER_GRANT);
+	if (can_be_granted(r, lkb, 1, 0, NULL)) {
+		grant_lock(r, lkb);
+		queue_cast(r, lkb, 0);
+		goto out;
+	}
 
-			(*count)++;
-		}
+	if (can_be_queued(lkb)) {
+		error = -EINPROGRESS;
+		add_lkb(r, lkb, DLM_LKSTS_WAITING);
+		goto out;
 	}
+
+	error = -EAGAIN;
+	queue_cast(r, lkb, -EAGAIN);
+ out:
+	return error;
 }
 
-/* Get rid of locks held by nodes that are gone. */
+static void do_request_effects(struct dlm_rsb *r, struct dlm_lkb *lkb,
+			       int error)
+{
+	switch (error) {
+	case -EAGAIN:
+		if (force_blocking_asts(lkb))
+			send_blocking_asts_all(r, lkb);
+		break;
+	case -EINPROGRESS:
+		send_blocking_asts(r, lkb);
+		break;
+	}
+}
 
-void dlm_recover_purge(struct dlm_ls *ls, const struct list_head *root_list)
+static int do_convert(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_rsb *r;
-	struct dlm_member *memb;
-	int nodes_count = 0;
-	int nodeid_gone = 0;
-	unsigned int lkb_count = 0;
+	int error = 0;
+	int deadlk = 0;
 
-	/* cache one removed nodeid to optimize the common
-	   case of a single node removed */
+	/* changing an existing lock may allow others to be granted */
 
-	list_for_each_entry(memb, &ls->ls_nodes_gone, list) {
-		nodes_count++;
-		nodeid_gone = memb->nodeid;
+	if (can_be_granted(r, lkb, 1, 0, &deadlk)) {
+		grant_lock(r, lkb);
+		queue_cast(r, lkb, 0);
+		goto out;
 	}
 
-	if (!nodes_count)
-		return;
+	/* can_be_granted() detected that this lock would block in a conversion
+	   deadlock, so we leave it on the granted queue and return EDEADLK in
+	   the ast for the convert. */
+
+	if (deadlk && !(lkb->lkb_exflags & DLM_LKF_NODLCKWT)) {
+		/* it's left on the granted queue */
+		revert_lock(r, lkb);
+		queue_cast(r, lkb, -EDEADLK);
+		error = -EDEADLK;
+		goto out;
+	}
 
-	list_for_each_entry(r, root_list, res_root_list) {
-		lock_rsb(r);
-		if (r->res_nodeid != -1 && is_master(r)) {
-			purge_dead_list(ls, r, &r->res_grantqueue,
-					nodeid_gone, &lkb_count);
-			purge_dead_list(ls, r, &r->res_convertqueue,
-					nodeid_gone, &lkb_count);
-			purge_dead_list(ls, r, &r->res_waitqueue,
-					nodeid_gone, &lkb_count);
+	/* is_demoted() means the can_be_granted() above set the grmode
+	   to NL, and left us on the granted queue.  This auto-demotion
+	   (due to CONVDEADLK) might mean other locks, and/or this lock, are
+	   now grantable.  We have to try to grant other converting locks
+	   before we try again to grant this one. */
+
+	if (is_demoted(lkb)) {
+		grant_pending_convert(r, DLM_LOCK_IV, NULL, NULL);
+		if (_can_be_granted(r, lkb, 1, 0)) {
+			grant_lock(r, lkb);
+			queue_cast(r, lkb, 0);
+			goto out;
 		}
-		unlock_rsb(r);
+		/* else fall through and move to convert queue */
+	}
 
-		cond_resched();
+	if (can_be_queued(lkb)) {
+		error = -EINPROGRESS;
+		del_lkb(r, lkb);
+		add_lkb(r, lkb, DLM_LKSTS_CONVERT);
+		goto out;
 	}
 
-	if (lkb_count)
-		log_rinfo(ls, "dlm_recover_purge %u locks for %u nodes",
-			  lkb_count, nodes_count);
+	error = -EAGAIN;
+	queue_cast(r, lkb, -EAGAIN);
+ out:
+	return error;
 }
 
-static struct dlm_rsb *find_grant_rsb(struct dlm_ls *ls)
+static void do_convert_effects(struct dlm_rsb *r, struct dlm_lkb *lkb,
+			       int error)
 {
-	struct dlm_rsb *r;
+	switch (error) {
+	case 0:
+		grant_pending_locks(r, NULL);
+		/* grant_pending_locks also sends basts */
+		break;
+	case -EAGAIN:
+		if (force_blocking_asts(lkb))
+			send_blocking_asts_all(r, lkb);
+		break;
+	case -EINPROGRESS:
+		send_blocking_asts(r, lkb);
+		break;
+	}
+}
 
-	read_lock_bh(&ls->ls_rsbtbl_lock);
-	list_for_each_entry(r, &ls->ls_slow_active, res_slow_list) {
-		if (!rsb_flag(r, RSB_RECOVER_GRANT))
-			continue;
-		if (!is_master(r)) {
-			rsb_clear_flag(r, RSB_RECOVER_GRANT);
-			continue;
-		}
-		hold_rsb(r);
-		read_unlock_bh(&ls->ls_rsbtbl_lock);
-		return r;
+static int do_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	remove_lock(r, lkb);
+	queue_cast(r, lkb, -DLM_EUNLOCK);
+	return -DLM_EUNLOCK;
+}
+
+static void do_unlock_effects(struct dlm_rsb *r, struct dlm_lkb *lkb,
+			      int error)
+{
+	grant_pending_locks(r, NULL);
+}
+
+/* returns: 0 did nothing, -DLM_ECANCEL canceled lock */
+
+static int do_cancel(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	int error;
+
+	error = revert_lock(r, lkb);
+	if (error) {
+		queue_cast(r, lkb, -DLM_ECANCEL);
+		return -DLM_ECANCEL;
 	}
-	read_unlock_bh(&ls->ls_rsbtbl_lock);
-	return NULL;
+	return 0;
+}
+
+static void do_cancel_effects(struct dlm_rsb *r, struct dlm_lkb *lkb,
+			      int error)
+{
+	if (error)
+		grant_pending_locks(r, NULL);
 }
 
 /*
- * Attempt to grant locks on resources that we are the master of.
- * Locks may have become grantable during recovery because locks
- * from departed nodes have been purged (or not rebuilt), allowing
- * previously blocked locks to now be granted.  The subset of rsb's
- * we are interested in are those with lkb's on either the convert or
- * waiting queues.
- *
- * Simplest would be to go through each master rsb and check for non-empty
- * convert or waiting queues, and attempt to grant on those rsbs.
- * Checking the queues requires lock_rsb, though, for which we'd need
- * to release the rsbtbl lock.  This would make iterating through all
- * rsb's very inefficient.  So, we rely on earlier recovery routines
- * to set RECOVER_GRANT on any rsb's that we should attempt to grant
- * locks for.
+ * Four stage 3 varieties:
+ * _request_lock(), _convert_lock(), _unlock_lock(), _cancel_lock()
  */
 
-void dlm_recover_grant(struct dlm_ls *ls)
+/* add a new lkb to a possibly new rsb, called by requesting process */
+
+static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_rsb *r;
-	unsigned int count = 0;
-	unsigned int rsb_count = 0;
-	unsigned int lkb_count = 0;
+	int error;
 
-	while (1) {
-		r = find_grant_rsb(ls);
-		if (!r)
-			break;
+	/* set_master: sets lkb nodeid from r */
 
-		rsb_count++;
-		count = 0;
-		lock_rsb(r);
-		/* the RECOVER_GRANT flag is checked in the grant path */
-		grant_pending_locks(r, &count);
-		rsb_clear_flag(r, RSB_RECOVER_GRANT);
-		lkb_count += count;
-		confirm_master(r, 0);
-		unlock_rsb(r);
-		put_rsb(r);
-		cond_resched();
+	error = set_master(r, lkb);
+	if (error < 0)
+		goto out;
+	if (error) {
+		error = 0;
+		goto out;
 	}
 
-	if (lkb_count)
-		log_rinfo(ls, "dlm_recover_grant %u locks on %u resources",
-			  lkb_count, rsb_count);
+	if (is_remote(r)) {
+		/* receive_request() calls do_request() on remote node */
+		error = send_request(r, lkb);
+	} else {
+		error = do_request(r, lkb);
+		/* for remote locks the request_reply is sent
+		   between do_request and do_request_effects */
+		do_request_effects(r, lkb, error);
+	}
+ out:
+	return error;
 }
 
-static struct dlm_lkb *search_remid_list(struct list_head *head, int nodeid,
-					 uint32_t remid)
+/* change some property of an existing lkb, e.g. mode */
+
+static int _convert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_lkb *lkb;
+	int error;
 
-	list_for_each_entry(lkb, head, lkb_statequeue) {
-		if (lkb->lkb_nodeid == nodeid && lkb->lkb_remid == remid)
-			return lkb;
+	if (is_remote(r)) {
+		/* receive_convert() calls do_convert() on remote node */
+		error = send_convert(r, lkb);
+	} else {
+		error = do_convert(r, lkb);
+		/* for remote locks the convert_reply is sent
+		   between do_convert and do_convert_effects */
+		do_convert_effects(r, lkb, error);
 	}
-	return NULL;
+
+	return error;
 }
 
-static struct dlm_lkb *search_remid(struct dlm_rsb *r, int nodeid,
-				    uint32_t remid)
+/* remove an existing lkb from the granted queue */
+
+static int _unlock_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_lkb *lkb;
+	int error;
 
-	lkb = search_remid_list(&r->res_grantqueue, nodeid, remid);
-	if (lkb)
-		return lkb;
-	lkb = search_remid_list(&r->res_convertqueue, nodeid, remid);
-	if (lkb)
-		return lkb;
-	lkb = search_remid_list(&r->res_waitqueue, nodeid, remid);
-	if (lkb)
-		return lkb;
-	return NULL;
-}
-
-/* needs at least dlm_rcom + rcom_lock */
-static int receive_rcom_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
-				  struct dlm_rsb *r, const struct dlm_rcom *rc)
-{
-	struct rcom_lock *rl = (struct rcom_lock *) rc->rc_buf;
-
-	lkb->lkb_nodeid = le32_to_cpu(rc->rc_header.h_nodeid);
-	lkb->lkb_ownpid = le32_to_cpu(rl->rl_ownpid);
-	lkb->lkb_remid = le32_to_cpu(rl->rl_lkid);
-	lkb->lkb_exflags = le32_to_cpu(rl->rl_exflags);
-	dlm_set_dflags_val(lkb, le32_to_cpu(rl->rl_flags));
-	set_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags);
-	lkb->lkb_lvbseq = le32_to_cpu(rl->rl_lvbseq);
-	lkb->lkb_rqmode = rl->rl_rqmode;
-	lkb->lkb_grmode = rl->rl_grmode;
-	/* don't set lkb_status because add_lkb wants to itself */
-
-	lkb->lkb_bastfn = (rl->rl_asts & DLM_CB_BAST) ? &fake_bastfn : NULL;
-	lkb->lkb_astfn = (rl->rl_asts & DLM_CB_CAST) ? &fake_astfn : NULL;
-
-	if (lkb->lkb_exflags & DLM_LKF_VALBLK) {
-		int lvblen = le16_to_cpu(rc->rc_header.h_length) -
-			sizeof(struct dlm_rcom) - sizeof(struct rcom_lock);
-		if (lvblen > ls->ls_lvblen)
-			return -EINVAL;
-		lkb->lkb_lvbptr = dlm_allocate_lvb(ls);
-		if (!lkb->lkb_lvbptr)
-			return -ENOMEM;
-		memcpy(lkb->lkb_lvbptr, rl->rl_lvb, lvblen);
+	if (is_remote(r)) {
+		/* receive_unlock() calls do_unlock() on remote node */
+		error = send_unlock(r, lkb);
+	} else {
+		error = do_unlock(r, lkb);
+		/* for remote locks the unlock_reply is sent
+		   between do_unlock and do_unlock_effects */
+		do_unlock_effects(r, lkb, error);
 	}
 
-	/* Conversions between PR and CW (middle modes) need special handling.
-	   The real granted mode of these converting locks cannot be determined
-	   until all locks have been rebuilt on the rsb (recover_conversion) */
+	return error;
+}
+
+/* remove an existing lkb from the convert or wait queue */
 
-	if (rl->rl_status == DLM_LKSTS_CONVERT && middle_conversion(lkb)) {
-		/* We may need to adjust grmode depending on other granted locks. */
-		log_limit(ls, "%s %x middle convert gr %d rq %d remote %d %x",
-			  __func__, lkb->lkb_id, lkb->lkb_grmode,
-			  lkb->lkb_rqmode, lkb->lkb_nodeid, lkb->lkb_remid);
-		rsb_set_flag(r, RSB_RECOVER_CONVERT);
+static int _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	int error;
+
+	if (is_remote(r)) {
+		/* receive_cancel() calls do_cancel() on remote node */
+		error = send_cancel(r, lkb);
+	} else {
+		error = do_cancel(r, lkb);
+		/* for remote locks the cancel_reply is sent
+		   between do_cancel and do_cancel_effects */
+		do_cancel_effects(r, lkb, error);
 	}
 
-	return 0;
+	return error;
 }
 
-/* This lkb may have been recovered in a previous aborted recovery so we need
-   to check if the rsb already has an lkb with the given remote nodeid/lkid.
-   If so we just send back a standard reply.  If not, we create a new lkb with
-   the given values and send back our lkid.  We send back our lkid by sending
-   back the rcom_lock struct we got but with the remid field filled in. */
+/*
+ * Four stage 2 varieties:
+ * request_lock(), convert_lock(), unlock_lock(), cancel_lock()
+ */
 
-/* needs at least dlm_rcom + rcom_lock */
-int dlm_recover_master_copy(struct dlm_ls *ls, const struct dlm_rcom *rc,
-			    __le32 *rl_remid, __le32 *rl_result)
+static int request_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
+			const void *name, int len,
+			struct dlm_args *args)
 {
-	struct rcom_lock *rl = (struct rcom_lock *) rc->rc_buf;
 	struct dlm_rsb *r;
-	struct dlm_lkb *lkb;
-	uint32_t remid = 0;
-	int from_nodeid = le32_to_cpu(rc->rc_header.h_nodeid);
 	int error;
 
-	/* init rl_remid with rcom lock rl_remid */
-	*rl_remid = rl->rl_remid;
+	error = validate_lock_args(ls, lkb, args);
+	if (error)
+		return error;
 
-	if (rl->rl_parent_lkid) {
-		error = -EOPNOTSUPP;
-		goto out;
-	}
+	error = find_rsb(ls, name, len, 0, R_REQUEST, &r);
+	if (error)
+		return error;
 
-	remid = le32_to_cpu(rl->rl_lkid);
+	lock_rsb(r);
 
-	/* In general we expect the rsb returned to be R_MASTER, but we don't
-	   have to require it.  Recovery of masters on one node can overlap
-	   recovery of locks on another node, so one node can send us MSTCPY
-	   locks before we've made ourselves master of this rsb.  We can still
-	   add new MSTCPY locks that we receive here without any harm; when
-	   we make ourselves master, dlm_recover_masters() won't touch the
-	   MSTCPY locks we've received early. */
+	attach_lkb(r, lkb);
+	lkb->lkb_lksb->sb_lkid = lkb->lkb_id;
 
-	error = find_rsb(ls, rl->rl_name, le16_to_cpu(rl->rl_namelen),
-			 from_nodeid, R_RECEIVE_RECOVER, &r);
-	if (error)
-		goto out;
+	error = _request_lock(r, lkb);
 
-	lock_rsb(r);
+	unlock_rsb(r);
+	put_rsb(r);
+	return error;
+}
 
-	if (dlm_no_directory(ls) && (dlm_dir_nodeid(r) != dlm_our_nodeid())) {
-		log_error(ls, "dlm_recover_master_copy remote %d %x not dir",
-			  from_nodeid, remid);
-		error = -EBADR;
-		goto out_unlock;
-	}
+static int convert_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
+			struct dlm_args *args)
+{
+	struct dlm_rsb *r;
+	int error;
 
-	lkb = search_remid(r, from_nodeid, remid);
-	if (lkb) {
-		error = -EEXIST;
-		goto out_remid;
-	}
+	r = lkb->lkb_resource;
+
+	hold_rsb(r);
+	lock_rsb(r);
 
-	error = create_lkb(ls, &lkb);
+	error = validate_lock_args(ls, lkb, args);
 	if (error)
-		goto out_unlock;
+		goto out;
 
-	error = receive_rcom_lock_args(ls, lkb, r, rc);
-	if (error) {
-		__put_lkb(ls, lkb);
-		goto out_unlock;
-	}
+	error = _convert_lock(r, lkb);
+ out:
+	unlock_rsb(r);
+	put_rsb(r);
+	return error;
+}
 
-	attach_lkb(r, lkb);
-	add_lkb(r, lkb, rl->rl_status);
-	ls->ls_recover_locks_in++;
+static int unlock_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
+		       struct dlm_args *args)
+{
+	struct dlm_rsb *r;
+	int error;
 
-	if (!list_empty(&r->res_waitqueue) || !list_empty(&r->res_convertqueue))
-		rsb_set_flag(r, RSB_RECOVER_GRANT);
+	r = lkb->lkb_resource;
 
- out_remid:
-	/* this is the new value returned to the lock holder for
-	   saving in its process-copy lkb */
-	*rl_remid = cpu_to_le32(lkb->lkb_id);
+	hold_rsb(r);
+	lock_rsb(r);
 
-	lkb->lkb_recover_seq = ls->ls_recover_seq;
+	error = validate_unlock_args(lkb, args);
+	if (error)
+		goto out;
 
- out_unlock:
+	error = _unlock_lock(r, lkb);
+ out:
 	unlock_rsb(r);
 	put_rsb(r);
- out:
-	if (error && error != -EEXIST)
-		log_rinfo(ls, "dlm_recover_master_copy remote %d %x error %d",
-			  from_nodeid, remid, error);
-	*rl_result = cpu_to_le32(error);
 	return error;
 }
 
-/* needs at least dlm_rcom + rcom_lock */
-int dlm_recover_process_copy(struct dlm_ls *ls, const struct dlm_rcom *rc,
-			     uint64_t seq)
+static int cancel_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
+		       struct dlm_args *args)
 {
-	struct rcom_lock *rl = (struct rcom_lock *) rc->rc_buf;
 	struct dlm_rsb *r;
-	struct dlm_lkb *lkb;
-	uint32_t lkid, remid;
-	int error, result;
-
-	lkid = le32_to_cpu(rl->rl_lkid);
-	remid = le32_to_cpu(rl->rl_remid);
-	result = le32_to_cpu(rl->rl_result);
-
-	error = find_lkb(ls, lkid, &lkb);
-	if (error) {
-		log_error(ls, "dlm_recover_process_copy no %x remote %d %x %d",
-			  lkid, le32_to_cpu(rc->rc_header.h_nodeid), remid,
-			  result);
-		return error;
-	}
+	int error;
 
 	r = lkb->lkb_resource;
+
 	hold_rsb(r);
 	lock_rsb(r);
 
-	if (!is_process_copy(lkb)) {
-		log_error(ls, "dlm_recover_process_copy bad %x remote %d %x %d",
-			  lkid, le32_to_cpu(rc->rc_header.h_nodeid), remid,
-			  result);
-		dlm_dump_rsb(r);
-		unlock_rsb(r);
-		put_rsb(r);
-		dlm_put_lkb(lkb);
-		return -EINVAL;
-	}
-
-	switch (result) {
-	case -EBADR:
-		/* There's a chance the new master received our lock before
-		   dlm_recover_master_reply(), this wouldn't happen if we did
-		   a barrier between recover_masters and recover_locks. */
-
-		log_debug(ls, "dlm_recover_process_copy %x remote %d %x %d",
-			  lkid, le32_to_cpu(rc->rc_header.h_nodeid), remid,
-			  result);
-	
-		dlm_send_rcom_lock(r, lkb, seq);
+	error = validate_unlock_args(lkb, args);
+	if (error)
 		goto out;
-	case -EEXIST:
-	case 0:
-		lkb->lkb_remid = remid;
-		break;
-	default:
-		log_error(ls, "dlm_recover_process_copy %x remote %d %x %d unk",
-			  lkid, le32_to_cpu(rc->rc_header.h_nodeid), remid,
-			  result);
-	}
 
-	/* an ack for dlm_recover_locks() which waits for replies from
-	   all the locks it sends to new masters */
-	dlm_recovered_lock(r);
+	error = _cancel_lock(r, lkb);
  out:
 	unlock_rsb(r);
 	put_rsb(r);
-	dlm_put_lkb(lkb);
-
-	return 0;
+	return error;
 }
 
-int dlm_user_request(struct dlm_ls *ls, struct dlm_user_args *ua,
-		     int mode, uint32_t flags, void *name, unsigned int namelen)
-{
+/*
+ * Two stage 1 varieties:  dlm_lock() and dlm_unlock()
+ */
+
+int dlm_lock(dlm_lockspace_t *lockspace,
+	     int mode,
+	     struct dlm_lksb *lksb,
+	     uint32_t flags,
+	     const void *name,
+	     unsigned int namelen,
+	     uint32_t parent_lkid,
+	     void (*ast) (void *astarg),
+	     void *astarg,
+	     void (*bast) (void *astarg, int mode))
+{
+	struct dlm_ls *ls;
 	struct dlm_lkb *lkb;
 	struct dlm_args args;
-	bool do_put = true;
-	int error;
+	int error, convert = flags & DLM_LKF_CONVERT;
+
+	ls = dlm_find_lockspace_local(lockspace);
+	if (!ls)
+		return -EINVAL;
 
 	dlm_lock_recovery(ls);
 
-	error = create_lkb(ls, &lkb);
-	if (error) {
-		kfree(ua);
+	if (convert)
+		error = find_lkb(ls, lksb->sb_lkid, &lkb);
+	else
+		error = create_lkb(ls, &lkb);
+
+	if (error)
 		goto out;
-	}
 
 	trace_dlm_lock_start(ls, lkb, name, namelen, mode, flags);
 
-	if (flags & DLM_LKF_VALBLK) {
-		ua->lksb.sb_lvbptr = kzalloc(DLM_USER_LVB_LEN, GFP_NOFS);
-		if (!ua->lksb.sb_lvbptr) {
-			kfree(ua);
-			error = -ENOMEM;
-			goto out_put;
-		}
-	}
-	error = set_lock_args(mode, &ua->lksb, flags, namelen, fake_astfn, ua,
-			      fake_bastfn, &args);
-	if (error) {
-		kfree(ua->lksb.sb_lvbptr);
-		ua->lksb.sb_lvbptr = NULL;
-		kfree(ua);
+	error = set_lock_args(mode, lksb, flags, namelen, ast, astarg, bast,
+			      &args);
+	if (error)
 		goto out_put;
-	}
 
-	/* After ua is attached to lkb it will be freed by dlm_free_lkb().
-	   When DLM_DFL_USER_BIT is set, the dlm knows that this is a userspace
-	   lock and that lkb_astparam is the dlm_user_args structure. */
-	set_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags);
-	error = request_lock(ls, lkb, name, namelen, &args);
+	if (convert)
+		error = convert_lock(ls, lkb, &args);
+	else
+		error = request_lock(ls, lkb, name, namelen, &args);
 
-	switch (error) {
-	case 0:
-		break;
-	case -EINPROGRESS:
+	if (error == -EINPROGRESS)
 		error = 0;
-		break;
-	case -EAGAIN:
-		error = 0;
-		fallthrough;
-	default:
-		goto out_put;
-	}
-
-	/* add this new lkb to the per-process list of locks */
-	spin_lock_bh(&ua->proc->locks_spin);
-	hold_lkb(lkb);
-	list_add_tail(&lkb->lkb_ownqueue, &ua->proc->locks);
-	spin_unlock_bh(&ua->proc->locks_spin);
-	do_put = false;
  out_put:
-	trace_dlm_lock_end(ls, lkb, name, namelen, mode, flags, error, false);
-	if (do_put)
+	trace_dlm_lock_end(ls, lkb, name, namelen, mode, flags, error, true);
+
+	if (convert || error)
 		__put_lkb(ls, lkb);
+	if (error == -EAGAIN || error == -EDEADLK)
+		error = 0;
  out:
 	dlm_unlock_recovery(ls);
+	dlm_put_lockspace(ls);
 	return error;
 }
 
-int dlm_user_convert(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
-		     int mode, uint32_t flags, uint32_t lkid, char *lvb_in)
+int dlm_unlock(dlm_lockspace_t *lockspace,
+	       uint32_t lkid,
+	       uint32_t flags,
+	       struct dlm_lksb *lksb,
+	       void *astarg)
 {
+	struct dlm_ls *ls;
 	struct dlm_lkb *lkb;
 	struct dlm_args args;
-	struct dlm_user_args *ua;
 	int error;
 
+	ls = dlm_find_lockspace_local(lockspace);
+	if (!ls)
+		return -EINVAL;
+
 	dlm_lock_recovery(ls);
 
 	error = find_lkb(ls, lkid, &lkb);
 	if (error)
 		goto out;
 
-	trace_dlm_lock_start(ls, lkb, NULL, 0, mode, flags);
-
-	/* user can change the params on its lock when it converts it, or
-	   add an lvb that didn't exist before */
-
-	ua = lkb->lkb_ua;
-
-	if (flags & DLM_LKF_VALBLK && !ua->lksb.sb_lvbptr) {
-		ua->lksb.sb_lvbptr = kzalloc(DLM_USER_LVB_LEN, GFP_NOFS);
-		if (!ua->lksb.sb_lvbptr) {
-			error = -ENOMEM;
-			goto out_put;
-		}
-	}
-	if (lvb_in && ua->lksb.sb_lvbptr)
-		memcpy(ua->lksb.sb_lvbptr, lvb_in, DLM_USER_LVB_LEN);
-
-	ua->xid = ua_tmp->xid;
-	ua->castparam = ua_tmp->castparam;
-	ua->castaddr = ua_tmp->castaddr;
-	ua->bastparam = ua_tmp->bastparam;
-	ua->bastaddr = ua_tmp->bastaddr;
-	ua->user_lksb = ua_tmp->user_lksb;
+	trace_dlm_unlock_start(ls, lkb, flags);
 
-	error = set_lock_args(mode, &ua->lksb, flags, 0, fake_astfn, ua,
-			      fake_bastfn, &args);
+	error = set_unlock_args(flags, astarg, &args);
 	if (error)
 		goto out_put;
 
-	error = convert_lock(ls, lkb, &args);
+	if (flags & DLM_LKF_CANCEL)
+		error = cancel_lock(ls, lkb, &args);
+	else
+		error = unlock_lock(ls, lkb, &args);
 
-	if (error == -EINPROGRESS || error == -EAGAIN || error == -EDEADLK)
+	if (error == -DLM_EUNLOCK || error == -DLM_ECANCEL)
+		error = 0;
+	if (error == -EBUSY && (flags & (DLM_LKF_CANCEL | DLM_LKF_FORCEUNLOCK)))
 		error = 0;
  out_put:
-	trace_dlm_lock_end(ls, lkb, NULL, 0, mode, flags, error, false);
+	trace_dlm_unlock_end(ls, lkb, flags, error);
+
 	dlm_put_lkb(lkb);
  out:
 	dlm_unlock_recovery(ls);
-	kfree(ua_tmp);
+	dlm_put_lockspace(ls);
 	return error;
 }
 
-/*
- * The caller asks for an orphan lock on a given resource with a given mode.
- * If a matching lock exists, it's moved to the owner's list of locks and
- * the lkid is returned.
- */
-
-int dlm_user_adopt_orphan(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
-		     int mode, uint32_t flags, void *name, unsigned int namelen,
-		     uint32_t *lkid)
+static void purge_mstcpy_list(struct dlm_ls *ls, struct dlm_rsb *r,
+			      struct list_head *list)
 {
-	struct dlm_lkb *lkb = NULL, *iter;
-	struct dlm_user_args *ua;
-	int found_other_mode = 0;
-	int rv = 0;
+	struct dlm_lkb *lkb, *safe;
 
-	spin_lock_bh(&ls->ls_orphans_lock);
-	list_for_each_entry(iter, &ls->ls_orphans, lkb_ownqueue) {
-		if (iter->lkb_resource->res_length != namelen)
-			continue;
-		if (memcmp(iter->lkb_resource->res_name, name, namelen))
+	list_for_each_entry_safe(lkb, safe, list, lkb_statequeue) {
+		if (!is_master_copy(lkb))
 			continue;
-		if (iter->lkb_grmode != mode) {
-			found_other_mode = 1;
+
+		/* don't purge lkbs we've added in recover_master_copy for
+		   the current recovery seq */
+
+		if (lkb->lkb_recover_seq == ls->ls_recover_seq)
 			continue;
-		}
 
-		lkb = iter;
-		list_del_init(&iter->lkb_ownqueue);
-		clear_bit(DLM_DFL_ORPHAN_BIT, &iter->lkb_dflags);
-		*lkid = iter->lkb_id;
-		break;
-	}
-	spin_unlock_bh(&ls->ls_orphans_lock);
+		del_lkb(r, lkb);
 
-	if (!lkb && found_other_mode) {
-		rv = -EAGAIN;
-		goto out;
+		/* this put should free the lkb */
+		if (!dlm_put_lkb(lkb))
+			log_error(ls, "purged mstcpy lkb not released");
 	}
+}
 
-	if (!lkb) {
-		rv = -ENOENT;
-		goto out;
-	}
+void dlm_purge_mstcpy_locks(struct dlm_rsb *r)
+{
+	struct dlm_ls *ls = r->res_ls;
 
-	lkb->lkb_exflags = flags;
-	lkb->lkb_ownpid = (int) current->pid;
+	purge_mstcpy_list(ls, r, &r->res_grantqueue);
+	purge_mstcpy_list(ls, r, &r->res_convertqueue);
+	purge_mstcpy_list(ls, r, &r->res_waitqueue);
+}
 
-	ua = lkb->lkb_ua;
+static void purge_dead_list(struct dlm_ls *ls, struct dlm_rsb *r,
+			    struct list_head *list,
+			    int nodeid_gone, unsigned int *count)
+{
+	struct dlm_lkb *lkb, *safe;
 
-	ua->proc = ua_tmp->proc;
-	ua->xid = ua_tmp->xid;
-	ua->castparam = ua_tmp->castparam;
-	ua->castaddr = ua_tmp->castaddr;
-	ua->bastparam = ua_tmp->bastparam;
-	ua->bastaddr = ua_tmp->bastaddr;
-	ua->user_lksb = ua_tmp->user_lksb;
+	list_for_each_entry_safe(lkb, safe, list, lkb_statequeue) {
+		if (!is_master_copy(lkb))
+			continue;
 
-	/*
-	 * The lkb reference from the ls_orphans list was not
-	 * removed above, and is now considered the reference
-	 * for the proc locks list.
-	 */
+		if ((lkb->lkb_nodeid == nodeid_gone) ||
+		    dlm_is_removed(ls, lkb->lkb_nodeid)) {
 
-	spin_lock_bh(&ua->proc->locks_spin);
-	list_add_tail(&lkb->lkb_ownqueue, &ua->proc->locks);
-	spin_unlock_bh(&ua->proc->locks_spin);
- out:
-	kfree(ua_tmp);
-	return rv;
-}
+			/* tell recover_lvb to invalidate the lvb
+			   because a node holding EX/PW failed */
+			if ((lkb->lkb_exflags & DLM_LKF_VALBLK) &&
+			    (lkb->lkb_grmode >= DLM_LOCK_PW)) {
+				rsb_set_flag(r, RSB_RECOVER_LVB_INVAL);
+			}
 
 int dlm_user_unlock(struct dlm_ls *ls, struct dlm_user_args *ua_tmp,
 		    uint32_t flags, uint32_t lkid, char *lvb_in)
-- 
2.48.1


