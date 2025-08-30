Return-Path: <linux-kernel+bounces-792887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38624B3CA04
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD4E1C24480
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37AC273D92;
	Sat, 30 Aug 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwNMBbPC"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8833271470
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548874; cv=none; b=bXraQEWm+IUXL+qUJvP85g2bg4fAWABSUi1AwUzq+3owwz7OMgdXlDu91zPyN81xR6dAbMI0SBiTMdZPXmSlPe8+WwjS8qBP0YLP8YkleqSeqy85JWpfegfwQzNImRTyW8ET9viQOQn2/udDdtAUETIOBOJ+BOcwKt18qasFc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548874; c=relaxed/simple;
	bh=psJi9tLpqtjrtpKlvB+azvQ+Kh7XlAj8epcHUomzFVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctLAG81QjvXnaJgPpo5Gn4tihviiqkDR1TvvnhCLOisJoyq2bI3kxWHISKR/i+tnlhByL2qc15dpCa3V2ViQ8LmFCqA3873gJHMWWd9Xo0D6zvTxEXlbIOTnGC9hSYeWnLmebc3/EnPQQGODy9ro33tOUghS/OeaLIgvpg3qXSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwNMBbPC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d17f24d42fso604871f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548869; x=1757153669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVPfPjxWpE+hQlXk8TwArh1rYLfnJjJSSIT5fFxWQDU=;
        b=lwNMBbPCaxZ+jeMiAx1lj1fjqML7lYloj8kZhehdKS3u5y1JASiokRNIyb9Z4Qi3kh
         JGGAgQki9UAvhZZ7FIjjrM0th0CbSai+z8gc0CGGnlZ3yiLZiNSyd8q0dtCJ7kTiO6/g
         /MtGjwann4Z1av6665uHe8S+tCXozmD3lwRlnOxy+h5V9mm08mCj9DQdRtxMx0nrnXCh
         rvglBxhQ/rMd3Yyu8Rlf7wnp4yAjJTNw2unW0LPF2JT4t39XWccHA1LwZ7T2hFWD7fBw
         hrjTu4ZTk2lutVQ+EDgm41DjXPjOqqBpqXE5gLohmOuDTjiEF+PeIDDpkIGnSv9t0tiL
         IrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548869; x=1757153669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVPfPjxWpE+hQlXk8TwArh1rYLfnJjJSSIT5fFxWQDU=;
        b=bhr+Upw7qVq5UkeexxiUO1MDqUZtE35PMjWYXOi2gY0zcX+xQzdS3ETDcmlIT7fbOG
         CtF34tQoQEekvdOKmZCaDtPZGDzYElg7NobgZt9QQiLicV1vvy8l0JevT0aNuAWG/wwr
         oPCiRMCtB87bRcqwp0ifWhUy3sHRBSrCdFrL86G6uctqBlZsftBU9PzY6ywowVeisGyq
         c4exG+HI/jDjzrkvkiY77iGt4wGMCd8A3s0ABLEh1QMBWe04ddWM7RaGWL7xLvAaL9Vv
         LIWiD/4n5edCEDiQ25XipDd1xiRWy2zgusieTagFhJtHbkFEHFq4buukTNohwY4WT26H
         QK9g==
X-Gm-Message-State: AOJu0YwzWdX283jem3ie7iWKSUWC1Ii4IpBw9Z9CTLK6a48Ikt4l3Kuz
	TTVIJ95Mv7dTK/a3JtcmqtNyu4sAHygMyp4FTQc7WcxthnJzZNYIQjLC
X-Gm-Gg: ASbGncs/VlnMUKBKhermL0HLGFiLv7Wz9oHKv+53H/C3fJxP53hUkn/rCEtXu1ycF2f
	cRW/NOQu6DIBxYuFjEIhDQTOPR9zRymPvsxmG22Ca+5mY/9ErlN98i0KdKfR8JS9KYKB3AP222k
	o+zs3qRdOiqQMlja8AKdSgvoCtU0/rztgZ1asv6xGN9SKaWA2PI94sx4g0SZhSONoq9Nti7HBpo
	+qyFNAax14IMgSN1LJnuwqr2QQ0S6tWVh3eZe4lihy3z0WS3fZxFdyZs2d5BneXEGSMgtoitBd6
	yfAeSJ3Ah+RAuJxTucd3jXHMMMNKzNc8skRH9ZioddBj49ydNRvnd+FU12WJ9pT0JKH2ic7fJOO
	Q820+NmLJO8sDnh025FX6kWmmCjyhrg8S1n71HEiI6Z7rwB7vvG7F4hSFpu5Q3K8ZHq8l7ed+4t
	Nwfa/esmeJzFDo6QrdTgyekSHFWe9hxYRZB8dRPAc2myQRe182N2VweSo0sZjX6+ABAvQOlYBVJ
	mb79ulC
X-Google-Smtp-Source: AGHT+IHfEl+7881mGIIMyYBXx1Abd6Wl3e1MA8eydCoNXKECxCrSNrEY4H1jOC7jyvivp1a/v1maTg==
X-Received: by 2002:a5d:5d09:0:b0:3cb:66b5:e3d8 with SMTP id ffacd0b85a97d-3d1df8289bbmr1245578f8f.63.1756548868525;
        Sat, 30 Aug 2025 03:14:28 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:28 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 09/12] fix: improve lkb struct
Date: Sat, 30 Aug 2025 12:14:10 +0200
Message-ID: <20250830101413.602637-9-226562783+SigAttilio@users.noreply.github.com>
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
 fs/dlm/lock.c | 937 +++++++++++++++++++++++++-------------------------
 1 file changed, 472 insertions(+), 465 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index f7d3d154e2a9..3ead785d8dbe 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3883,585 +3883,592 @@ static void set_lvb_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
 	int b, len = r->res_ls->ls_lvblen;
 
-	from_nodeid = le32_to_cpu(ms->m_header.h_nodeid);
-	our_nodeid = dlm_our_nodeid();
+	/* b=1 lvb returned to caller
+	   b=0 lvb written to rsb or invalidated
+	   b=-1 do nothing */
 
-	len = receive_extralen(ms);
+	b =  dlm_lvb_operations[lkb->lkb_grmode + 1][lkb->lkb_rqmode + 1];
 
-	error = dlm_master_lookup(ls, from_nodeid, ms->m_extra, len, 0,
-				  &ret_nodeid, NULL);
-
-	/* Optimization: we're master so treat lookup as a request */
-	if (!error && ret_nodeid == our_nodeid) {
-		receive_request(ls, ms);
-		return;
-	}
-	send_lookup_reply(ls, ms, ret_nodeid, error);
-}
+	if (b == 1) {
+		if (!lkb->lkb_lvbptr)
+			return;
 
-static void receive_remove(struct dlm_ls *ls, const struct dlm_message *ms)
-{
-	char name[DLM_RESNAME_MAXLEN+1];
-	struct dlm_rsb *r;
-	int rv, len, dir_nodeid, from_nodeid;
+		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+			return;
 
-	from_nodeid = le32_to_cpu(ms->m_header.h_nodeid);
+		if (!r->res_lvbptr)
+			return;
 
-	len = receive_extralen(ms);
+		memcpy(lkb->lkb_lvbptr, r->res_lvbptr, len);
+		lkb->lkb_lvbseq = r->res_lvbseq;
 
-	if (len > DLM_RESNAME_MAXLEN) {
-		log_error(ls, "receive_remove from %d bad len %d",
-			  from_nodeid, len);
-		return;
-	}
+	} else if (b == 0) {
+		if (lkb->lkb_exflags & DLM_LKF_IVVALBLK) {
+			rsb_set_flag(r, RSB_VALNOTVALID);
+			return;
+		}
 
-	dir_nodeid = dlm_hash2nodeid(ls, le32_to_cpu(ms->m_hash));
-	if (dir_nodeid != dlm_our_nodeid()) {
-		log_error(ls, "receive_remove from %d bad nodeid %d",
-			  from_nodeid, dir_nodeid);
-		return;
-	}
+		if (!lkb->lkb_lvbptr)
+			return;
 
-	/*
-	 * Look for inactive rsb, if it's there, free it.
-	 * If the rsb is active, it's being used, and we should ignore this
-	 * message.  This is an expected race between the dir node sending a
-	 * request to the master node at the same time as the master node sends
-	 * a remove to the dir node.  The resolution to that race is for the
-	 * dir node to ignore the remove message, and the master node to
-	 * recreate the master rsb when it gets a request from the dir node for
-	 * an rsb it doesn't have.
-	 */
+		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+			return;
 
-	memset(name, 0, sizeof(name));
-	memcpy(name, ms->m_extra, len);
+		if (!r->res_lvbptr)
+			r->res_lvbptr = dlm_allocate_lvb(r->res_ls);
 
-	rcu_read_lock();
-	rv = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (rv) {
-		rcu_read_unlock();
-		/* should not happen */
-		log_error(ls, "%s from %d not found %s", __func__,
-			  from_nodeid, name);
-		return;
-	}
+		if (!r->res_lvbptr)
+			return;
 
-	write_lock_bh(&ls->ls_rsbtbl_lock);
-	if (!rsb_flag(r, RSB_HASHED)) {
-		rcu_read_unlock();
-		write_unlock_bh(&ls->ls_rsbtbl_lock);
-		/* should not happen */
-		log_error(ls, "%s from %d got removed during removal %s",
-			  __func__, from_nodeid, name);
-		return;
+		memcpy(r->res_lvbptr, lkb->lkb_lvbptr, len);
+		r->res_lvbseq++;
+		lkb->lkb_lvbseq = r->res_lvbseq;
+		rsb_clear_flag(r, RSB_VALNOTVALID);
 	}
-	/* at this stage the rsb can only being freed here */
-	rcu_read_unlock();
 
-	if (!rsb_flag(r, RSB_INACTIVE)) {
-		if (r->res_master_nodeid != from_nodeid) {
-			/* should not happen */
-			log_error(ls, "receive_remove on active rsb from %d master %d",
-				  from_nodeid, r->res_master_nodeid);
-			dlm_print_rsb(r);
-			write_unlock_bh(&ls->ls_rsbtbl_lock);
-			return;
-		}
+	if (rsb_flag(r, RSB_VALNOTVALID))
+		set_bit(DLM_SBF_VALNOTVALID_BIT, &lkb->lkb_sbflags);
+}
 
-		/* Ignore the remove message, see race comment above. */
+static void set_lvb_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	if (lkb->lkb_grmode < DLM_LOCK_PW)
+		return;
 
-		log_debug(ls, "receive_remove from %d master %d first %x %s",
-			  from_nodeid, r->res_master_nodeid, r->res_first_lkid,
-			  name);
-		write_unlock_bh(&ls->ls_rsbtbl_lock);
+	if (lkb->lkb_exflags & DLM_LKF_IVVALBLK) {
+		rsb_set_flag(r, RSB_VALNOTVALID);
 		return;
 	}
 
-	if (r->res_master_nodeid != from_nodeid) {
-		log_error(ls, "receive_remove inactive from %d master %d",
-			  from_nodeid, r->res_master_nodeid);
-		dlm_print_rsb(r);
-		write_unlock_bh(&ls->ls_rsbtbl_lock);
+	if (!lkb->lkb_lvbptr)
 		return;
-	}
 
-	list_del(&r->res_slow_list);
-	rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
-			       dlm_rhash_rsb_params);
-	rsb_clear_flag(r, RSB_HASHED);
-	write_unlock_bh(&ls->ls_rsbtbl_lock);
+	if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+		return;
 
-	free_inactive_rsb(r);
-}
+	if (!r->res_lvbptr)
+		r->res_lvbptr = dlm_allocate_lvb(r->res_ls);
 
-static void receive_purge(struct dlm_ls *ls, const struct dlm_message *ms)
-{
-	do_purge(ls, le32_to_cpu(ms->m_nodeid), le32_to_cpu(ms->m_pid));
-}
+	if (!r->res_lvbptr)
+		return;
 
-static int receive_request_reply(struct dlm_ls *ls,
-				 const struct dlm_message *ms)
-{
-	struct dlm_lkb *lkb;
-	struct dlm_rsb *r;
-	int error, mstype, result;
-	int from_nodeid = le32_to_cpu(ms->m_header.h_nodeid);
+	memcpy(r->res_lvbptr, lkb->lkb_lvbptr, r->res_ls->ls_lvblen);
+	r->res_lvbseq++;
+	rsb_clear_flag(r, RSB_VALNOTVALID);
+}
 
-	error = find_lkb(ls, le32_to_cpu(ms->m_remid), &lkb);
-	if (error)
-		return error;
+/* lkb is process copy (pc) */
 
-	r = lkb->lkb_resource;
-	hold_rsb(r);
-	lock_rsb(r);
+static void set_lvb_lock_pc(struct dlm_rsb *r, struct dlm_lkb *lkb,
+			    const struct dlm_message *ms)
+{
+	int b;
 
-	error = validate_message(lkb, ms);
-	if (error)
-		goto out;
+	if (!lkb->lkb_lvbptr)
+		return;
 
-	mstype = lkb->lkb_wait_type;
-	error = remove_from_waiters(lkb, DLM_MSG_REQUEST_REPLY);
-	if (error) {
-		log_error(ls, "receive_request_reply %x remote %d %x result %d",
-			  lkb->lkb_id, from_nodeid, le32_to_cpu(ms->m_lkid),
-			  from_dlm_errno(le32_to_cpu(ms->m_result)));
-		dlm_dump_rsb(r);
-		goto out;
-	}
+	if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
+		return;
 
-	/* Optimization: the dir node was also the master, so it took our
-	   lookup as a request and sent request reply instead of lookup reply */
-	if (mstype == DLM_MSG_LOOKUP) {
-		r->res_master_nodeid = from_nodeid;
-		r->res_nodeid = from_nodeid;
-		lkb->lkb_nodeid = from_nodeid;
+	b = dlm_lvb_operations[lkb->lkb_grmode + 1][lkb->lkb_rqmode + 1];
+	if (b == 1) {
+		int len = receive_extralen(ms);
+		if (len > r->res_ls->ls_lvblen)
+			len = r->res_ls->ls_lvblen;
+		memcpy(lkb->lkb_lvbptr, ms->m_extra, len);
+		lkb->lkb_lvbseq = le32_to_cpu(ms->m_lvbseq);
 	}
+}
 
-	/* this is the value returned from do_request() on the master */
-	result = from_dlm_errno(le32_to_cpu(ms->m_result));
+/* Manipulate lkb's on rsb's convert/granted/waiting queues
+   remove_lock -- used for unlock, removes lkb from granted
+   revert_lock -- used for cancel, moves lkb from convert to granted
+   grant_lock  -- used for request and convert, adds lkb to granted or
+                  moves lkb from convert or waiting to granted
 
-	switch (result) {
-	case -EAGAIN:
-		/* request would block (be queued) on remote master */
-		queue_cast(r, lkb, -EAGAIN);
-		confirm_master(r, -EAGAIN);
-		unhold_lkb(lkb); /* undoes create_lkb() */
-		break;
+   Each of these is used for master or local copy lkb's.  There is
+   also a _pc() variation used to make the corresponding change on
+   a process copy (pc) lkb. */
 
-	case -EINPROGRESS:
-	case 0:
-		/* request was queued or granted on remote master */
-		receive_flags_reply(lkb, ms, false);
-		lkb->lkb_remid = le32_to_cpu(ms->m_lkid);
-		if (is_altmode(lkb))
-			munge_altmode(lkb, ms);
-		if (result) {
-			add_lkb(r, lkb, DLM_LKSTS_WAITING);
-		} else {
-			grant_lock_pc(r, lkb, ms);
-			queue_cast(r, lkb, 0);
-		}
-		confirm_master(r, result);
-		break;
+static void _remove_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	del_lkb(r, lkb);
+	lkb->lkb_grmode = DLM_LOCK_IV;
+	/* this unhold undoes the original ref from create_lkb()
+	   so this leads to the lkb being freed */
+	unhold_lkb(lkb);
+}
 
-	case -EBADR:
-	case -ENOTBLK:
-		/* find_rsb failed to find rsb or rsb wasn't master */
-		log_limit(ls, "receive_request_reply %x from %d %d "
-			  "master %d dir %d first %x %s", lkb->lkb_id,
-			  from_nodeid, result, r->res_master_nodeid,
-			  r->res_dir_nodeid, r->res_first_lkid, r->res_name);
-
-		if (r->res_dir_nodeid != dlm_our_nodeid() &&
-		    r->res_master_nodeid != dlm_our_nodeid()) {
-			/* cause _request_lock->set_master->send_lookup */
-			r->res_master_nodeid = 0;
-			r->res_nodeid = -1;
-			lkb->lkb_nodeid = -1;
-		}
+static void remove_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	set_lvb_unlock(r, lkb);
+	_remove_lock(r, lkb);
+}
 
-		if (is_overlap(lkb)) {
-			/* we'll ignore error in cancel/unlock reply */
-			queue_cast_overlap(r, lkb);
-			confirm_master(r, result);
-			unhold_lkb(lkb); /* undoes create_lkb() */
-		} else {
-			_request_lock(r, lkb);
+static void remove_lock_pc(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	_remove_lock(r, lkb);
+}
 
-			if (r->res_master_nodeid == dlm_our_nodeid())
-				confirm_master(r, 0);
-		}
-		break;
+/* returns: 0 did nothing
+	    1 moved lock to granted
+	   -1 removed lock */
 
-	default:
-		log_error(ls, "receive_request_reply %x error %d",
-			  lkb->lkb_id, result);
-	}
+static int revert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	int rv = 0;
 
-	if ((result == 0 || result == -EINPROGRESS) &&
-	    test_and_clear_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags)) {
-		log_debug(ls, "receive_request_reply %x result %d unlock",
-			  lkb->lkb_id, result);
-		clear_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
-		send_unlock(r, lkb);
-	} else if ((result == -EINPROGRESS) &&
-		   test_and_clear_bit(DLM_IFL_OVERLAP_CANCEL_BIT,
-				      &lkb->lkb_iflags)) {
-		log_debug(ls, "receive_request_reply %x cancel", lkb->lkb_id);
-		clear_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
-		send_cancel(r, lkb);
-	} else {
-		clear_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
-		clear_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
-	}
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	dlm_put_lkb(lkb);
-	return 0;
-}
+	lkb->lkb_rqmode = DLM_LOCK_IV;
 
-static void __receive_convert_reply(struct dlm_rsb *r, struct dlm_lkb *lkb,
-				    const struct dlm_message *ms, bool local)
-{
-	/* this is the value returned from do_convert() on the master */
-	switch (from_dlm_errno(le32_to_cpu(ms->m_result))) {
-	case -EAGAIN:
-		/* convert would block (be queued) on remote master */
-		queue_cast(r, lkb, -EAGAIN);
+	switch (lkb->lkb_status) {
+	case DLM_LKSTS_GRANTED:
 		break;
-
-	case -EDEADLK:
-		receive_flags_reply(lkb, ms, local);
-		revert_lock_pc(r, lkb);
-		queue_cast(r, lkb, -EDEADLK);
+	case DLM_LKSTS_CONVERT:
+		move_lkb(r, lkb, DLM_LKSTS_GRANTED);
+		rv = 1;
 		break;
-
-	case -EINPROGRESS:
-		/* convert was queued on remote master */
-		receive_flags_reply(lkb, ms, local);
-		if (is_demoted(lkb))
-			munge_demoted(lkb);
+	case DLM_LKSTS_WAITING:
 		del_lkb(r, lkb);
-		add_lkb(r, lkb, DLM_LKSTS_CONVERT);
-		break;
-
-	case 0:
-		/* convert was granted on remote master */
-		receive_flags_reply(lkb, ms, local);
-		if (is_demoted(lkb))
-			munge_demoted(lkb);
-		grant_lock_pc(r, lkb, ms);
-		queue_cast(r, lkb, 0);
+		lkb->lkb_grmode = DLM_LOCK_IV;
+		/* this unhold undoes the original ref from create_lkb()
+		   so this leads to the lkb being freed */
+		unhold_lkb(lkb);
+		rv = -1;
 		break;
-
 	default:
-		log_error(r->res_ls, "receive_convert_reply %x remote %d %x %d",
-			  lkb->lkb_id, le32_to_cpu(ms->m_header.h_nodeid),
-			  le32_to_cpu(ms->m_lkid),
-			  from_dlm_errno(le32_to_cpu(ms->m_result)));
-		dlm_print_rsb(r);
-		dlm_print_lkb(lkb);
+		log_print("invalid status for revert %d", lkb->lkb_status);
 	}
+	return rv;
 }
 
-static void _receive_convert_reply(struct dlm_lkb *lkb,
-				   const struct dlm_message *ms, bool local)
+static int revert_lock_pc(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_rsb *r = lkb->lkb_resource;
-	int error;
-
-	hold_rsb(r);
-	lock_rsb(r);
-
-	error = validate_message(lkb, ms);
-	if (error)
-		goto out;
+	return revert_lock(r, lkb);
+}
 
-	error = remove_from_waiters_ms(lkb, ms, local);
-	if (error)
-		goto out;
+static void _grant_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	if (lkb->lkb_grmode != lkb->lkb_rqmode) {
+		lkb->lkb_grmode = lkb->lkb_rqmode;
+		if (lkb->lkb_status)
+			move_lkb(r, lkb, DLM_LKSTS_GRANTED);
+		else
+			add_lkb(r, lkb, DLM_LKSTS_GRANTED);
+	}
 
-	__receive_convert_reply(r, lkb, ms, local);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
+	lkb->lkb_rqmode = DLM_LOCK_IV;
+	lkb->lkb_highbast = 0;
 }
 
-static int receive_convert_reply(struct dlm_ls *ls,
-				 const struct dlm_message *ms)
+static void grant_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_lkb *lkb;
-	int error;
-
-	error = find_lkb(ls, le32_to_cpu(ms->m_remid), &lkb);
-	if (error)
-		return error;
+	set_lvb_lock(r, lkb);
+	_grant_lock(r, lkb);
+}
 
-	_receive_convert_reply(lkb, ms, false);
-	dlm_put_lkb(lkb);
-	return 0;
+static void grant_lock_pc(struct dlm_rsb *r, struct dlm_lkb *lkb,
+			  const struct dlm_message *ms)
+{
+	set_lvb_lock_pc(r, lkb, ms);
+	_grant_lock(r, lkb);
 }
 
-static void _receive_unlock_reply(struct dlm_lkb *lkb,
-				  const struct dlm_message *ms, bool local)
+/* called by grant_pending_locks() which means an async grant message must
+   be sent to the requesting node in addition to granting the lock if the
+   lkb belongs to a remote node. */
+
+static void grant_lock_pending(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_rsb *r = lkb->lkb_resource;
-	int error;
+	grant_lock(r, lkb);
+	if (is_master_copy(lkb))
+		send_grant(r, lkb);
+	else
+		queue_cast(r, lkb, 0);
+}
 
-	hold_rsb(r);
-	lock_rsb(r);
+/* The special CONVDEADLK, ALTPR and ALTCW flags allow the master to
+   change the granted/requested modes.  We're munging things accordingly in
+   the process copy.
+   CONVDEADLK: our grmode may have been forced down to NL to resolve a
+   conversion deadlock
+   ALTPR/ALTCW: our rqmode may have been changed to PR or CW to become
+   compatible with other granted locks */
 
-	error = validate_message(lkb, ms);
-	if (error)
-		goto out;
+static void munge_demoted(struct dlm_lkb *lkb)
+{
+	if (lkb->lkb_rqmode == DLM_LOCK_IV || lkb->lkb_grmode == DLM_LOCK_IV) {
+		log_print("munge_demoted %x invalid modes gr %d rq %d",
+			  lkb->lkb_id, lkb->lkb_grmode, lkb->lkb_rqmode);
+		return;
+	}
 
-	error = remove_from_waiters_ms(lkb, ms, local);
-	if (error)
-		goto out;
+	lkb->lkb_grmode = DLM_LOCK_NL;
+}
 
-	/* this is the value returned from do_unlock() on the master */
+static void munge_altmode(struct dlm_lkb *lkb, const struct dlm_message *ms)
+{
+	if (ms->m_type != cpu_to_le32(DLM_MSG_REQUEST_REPLY) &&
+	    ms->m_type != cpu_to_le32(DLM_MSG_GRANT)) {
+		log_print("munge_altmode %x invalid reply type %d",
+			  lkb->lkb_id, le32_to_cpu(ms->m_type));
+		return;
+	}
 
-	switch (from_dlm_errno(le32_to_cpu(ms->m_result))) {
-	case -DLM_EUNLOCK:
-		receive_flags_reply(lkb, ms, local);
-		remove_lock_pc(r, lkb);
-		queue_cast(r, lkb, -DLM_EUNLOCK);
-		break;
-	case -ENOENT:
-		break;
-	default:
-		log_error(r->res_ls, "receive_unlock_reply %x error %d",
-			  lkb->lkb_id, from_dlm_errno(le32_to_cpu(ms->m_result)));
+	if (lkb->lkb_exflags & DLM_LKF_ALTPR)
+		lkb->lkb_rqmode = DLM_LOCK_PR;
+	else if (lkb->lkb_exflags & DLM_LKF_ALTCW)
+		lkb->lkb_rqmode = DLM_LOCK_CW;
+	else {
+		log_print("munge_altmode invalid exflags %x", lkb->lkb_exflags);
+		dlm_print_lkb(lkb);
 	}
- out:
-	unlock_rsb(r);
-	put_rsb(r);
 }
 
-static int receive_unlock_reply(struct dlm_ls *ls,
-				const struct dlm_message *ms)
+static inline int first_in_list(struct dlm_lkb *lkb, struct list_head *head)
 {
-	struct dlm_lkb *lkb;
-	int error;
-
-	error = find_lkb(ls, le32_to_cpu(ms->m_remid), &lkb);
-	if (error)
-		return error;
+	struct dlm_lkb *first = list_entry(head->next, struct dlm_lkb,
+					   lkb_statequeue);
+	if (lkb->lkb_id == first->lkb_id)
+		return 1;
 
-	_receive_unlock_reply(lkb, ms, false);
-	dlm_put_lkb(lkb);
 	return 0;
 }
 
-static void _receive_cancel_reply(struct dlm_lkb *lkb,
-				  const struct dlm_message *ms, bool local)
+/* Check if the given lkb conflicts with another lkb on the queue. */
+
+static int queue_conflict(struct list_head *head, struct dlm_lkb *lkb)
 {
-	struct dlm_rsb *r = lkb->lkb_resource;
-	int error;
+	struct dlm_lkb *this;
 
-	hold_rsb(r);
-	lock_rsb(r);
+	list_for_each_entry(this, head, lkb_statequeue) {
+		if (this == lkb)
+			continue;
+		if (!modes_compat(this, lkb))
+			return 1;
+	}
+	return 0;
+}
 
-	error = validate_message(lkb, ms);
-	if (error)
-		goto out;
+/*
+ * "A conversion deadlock arises with a pair of lock requests in the converting
+ * queue for one resource.  The granted mode of each lock blocks the requested
+ * mode of the other lock."
+ *
+ * Part 2: if the granted mode of lkb is preventing an earlier lkb in the
+ * convert queue from being granted, then deadlk/demote lkb.
+ *
+ * Example:
+ * Granted Queue: empty
+ * Convert Queue: NL->EX (first lock)
+ *                PR->EX (second lock)
+ *
+ * The first lock can't be granted because of the granted mode of the second
+ * lock and the second lock can't be granted because it's not first in the
+ * list.  We either cancel lkb's conversion (PR->EX) and return EDEADLK, or we
+ * demote the granted mode of lkb (from PR to NL) if it has the CONVDEADLK
+ * flag set and return DEMOTED in the lksb flags.
+ *
+ * Originally, this function detected conv-deadlk in a more limited scope:
+ * - if !modes_compat(lkb1, lkb2) && !modes_compat(lkb2, lkb1), or
+ * - if lkb1 was the first entry in the queue (not just earlier), and was
+ *   blocked by the granted mode of lkb2, and there was nothing on the
+ *   granted queue preventing lkb1 from being granted immediately, i.e.
+ *   lkb2 was the only thing preventing lkb1 from being granted.
+ *
+ * That second condition meant we'd only say there was conv-deadlk if
+ * resolving it (by demotion) would lead to the first lock on the convert
+ * queue being granted right away.  It allowed conversion deadlocks to exist
+ * between locks on the convert queue while they couldn't be granted anyway.
+ *
+ * Now, we detect and take action on conversion deadlocks immediately when
+ * they're created, even if they may not be immediately consequential.  If
+ * lkb1 exists anywhere in the convert queue and lkb2 comes in with a granted
+ * mode that would prevent lkb1's conversion from being granted, we do a
+ * deadlk/demote on lkb2 right away and don't let it onto the convert queue.
+ * I think this means that the lkb_is_ahead condition below should always
+ * be zero, i.e. there will never be conv-deadlk between two locks that are
+ * both already on the convert queue.
+ */
 
-	error = remove_from_waiters_ms(lkb, ms, local);
-	if (error)
-		goto out;
+static int conversion_deadlock_detect(struct dlm_rsb *r, struct dlm_lkb *lkb2)
+{
+	struct dlm_lkb *lkb1;
+	int lkb_is_ahead = 0;
 
-	/* this is the value returned from do_cancel() on the master */
+	list_for_each_entry(lkb1, &r->res_convertqueue, lkb_statequeue) {
+		if (lkb1 == lkb2) {
+			lkb_is_ahead = 1;
+			continue;
+		}
 
-	switch (from_dlm_errno(le32_to_cpu(ms->m_result))) {
-	case -DLM_ECANCEL:
-		receive_flags_reply(lkb, ms, local);
-		revert_lock_pc(r, lkb);
-		queue_cast(r, lkb, -DLM_ECANCEL);
-		break;
-	case 0:
-		break;
-	default:
-		log_error(r->res_ls, "receive_cancel_reply %x error %d",
-			  lkb->lkb_id,
-			  from_dlm_errno(le32_to_cpu(ms->m_result)));
+		if (!lkb_is_ahead) {
+			if (!modes_compat(lkb2, lkb1))
+				return 1;
+		} else {
+			if (!modes_compat(lkb2, lkb1) &&
+			    !modes_compat(lkb1, lkb2))
+				return 1;
+		}
 	}
- out:
-	unlock_rsb(r);
-	put_rsb(r);
+	return 0;
 }
 
-static int receive_cancel_reply(struct dlm_ls *ls,
-				const struct dlm_message *ms)
+/*
+ * Return 1 if the lock can be granted, 0 otherwise.
+ * Also detect and resolve conversion deadlocks.
+ *
+ * lkb is the lock to be granted
+ *
+ * now is 1 if the function is being called in the context of the
+ * immediate request, it is 0 if called later, after the lock has been
+ * queued.
+ *
+ * recover is 1 if dlm_recover_grant() is trying to grant conversions
+ * after recovery.
+ *
+ * References are from chapter 6 of "VAXcluster Principles" by Roy Davis
+ */
+
+static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
+			   int recover)
 {
-	struct dlm_lkb *lkb;
-	int error;
+	int8_t conv = (lkb->lkb_grmode != DLM_LOCK_IV);
 
-	error = find_lkb(ls, le32_to_cpu(ms->m_remid), &lkb);
-	if (error)
-		return error;
+	/*
+	 * 6-10: Version 5.4 introduced an option to address the phenomenon of
+	 * a new request for a NL mode lock being blocked.
+	 *
+	 * 6-11: If the optional EXPEDITE flag is used with the new NL mode
+	 * request, then it would be granted.  In essence, the use of this flag
+	 * tells the Lock Manager to expedite theis request by not considering
+	 * what may be in the CONVERTING or WAITING queues...  As of this
+	 * writing, the EXPEDITE flag can be used only with new requests for NL
+	 * mode locks.  This flag is not valid for conversion requests.
+	 *
+	 * A shortcut.  Earlier checks return an error if EXPEDITE is used in a
+	 * conversion or used with a non-NL requested mode.  We also know an
+	 * EXPEDITE request is always granted immediately, so now must always
+	 * be 1.  The full condition to grant an expedite request: (now &&
+	 * !conv && lkb->rqmode == DLM_LOCK_NL && (flags & EXPEDITE)) can
+	 * therefore be shortened to just checking the flag.
+	 */
 
-	_receive_cancel_reply(lkb, ms, false);
-	dlm_put_lkb(lkb);
-	return 0;
-}
+	if (lkb->lkb_exflags & DLM_LKF_EXPEDITE)
+		return 1;
 
-static void receive_lookup_reply(struct dlm_ls *ls,
-				 const struct dlm_message *ms)
-{
-	struct dlm_lkb *lkb;
-	struct dlm_rsb *r;
-	int error, ret_nodeid;
-	int do_lookup_list = 0;
+	/*
+	 * A shortcut. Without this, !queue_conflict(grantqueue, lkb) would be
+	 * added to the remaining conditions.
+	 */
 
-	error = find_lkb(ls, le32_to_cpu(ms->m_lkid), &lkb);
-	if (error) {
-		log_error(ls, "%s no lkid %x", __func__,
-			  le32_to_cpu(ms->m_lkid));
-		return;
-	}
+	if (queue_conflict(&r->res_grantqueue, lkb))
+		return 0;
 
-	/* ms->m_result is the value returned by dlm_master_lookup on dir node
-	   FIXME: will a non-zero error ever be returned? */
+	/*
+	 * 6-3: By default, a conversion request is immediately granted if the
+	 * requested mode is compatible with the modes of all other granted
+	 * locks
+	 */
 
-	r = lkb->lkb_resource;
-	hold_rsb(r);
-	lock_rsb(r);
+	if (queue_conflict(&r->res_convertqueue, lkb))
+		return 0;
 
-	error = remove_from_waiters(lkb, DLM_MSG_LOOKUP_REPLY);
-	if (error)
-		goto out;
+	/*
+	 * The RECOVER_GRANT flag means dlm_recover_grant() is granting
+	 * locks for a recovered rsb, on which lkb's have been rebuilt.
+	 * The lkb's may have been rebuilt on the queues in a different
+	 * order than they were in on the previous master.  So, granting
+	 * queued conversions in order after recovery doesn't make sense
+	 * since the order hasn't been preserved anyway.  The new order
+	 * could also have created a new "in place" conversion deadlock.
+	 * (e.g. old, failed master held granted EX, with PR->EX, NL->EX.
+	 * After recovery, there would be no granted locks, and possibly
+	 * NL->EX, PR->EX, an in-place conversion deadlock.)  So, after
+	 * recovery, grant conversions without considering order.
+	 */
 
-	ret_nodeid = le32_to_cpu(ms->m_nodeid);
+	if (conv && recover)
+		return 1;
 
-	/* We sometimes receive a request from the dir node for this
-	   rsb before we've received the dir node's loookup_reply for it.
-	   The request from the dir node implies we're the master, so we set
-	   ourself as master in receive_request_reply, and verify here that
-	   we are indeed the master. */
+	/*
+	 * 6-5: But the default algorithm for deciding whether to grant or
+	 * queue conversion requests does not by itself guarantee that such
+	 * requests are serviced on a "first come first serve" basis.  This, in
+	 * turn, can lead to a phenomenon known as "indefinate postponement".
+	 *
+	 * 6-7: This issue is dealt with by using the optional QUECVT flag with
+	 * the system service employed to request a lock conversion.  This flag
+	 * forces certain conversion requests to be queued, even if they are
+	 * compatible with the granted modes of other locks on the same
+	 * resource.  Thus, the use of this flag results in conversion requests
+	 * being ordered on a "first come first servce" basis.
+	 *
+	 * DCT: This condition is all about new conversions being able to occur
+	 * "in place" while the lock remains on the granted queue (assuming
+	 * nothing else conflicts.)  IOW if QUECVT isn't set, a conversion
+	 * doesn't _have_ to go onto the convert queue where it's processed in
+	 * order.  The "now" variable is necessary to distinguish converts
+	 * being received and processed for the first time now, because once a
+	 * convert is moved to the conversion queue the condition below applies
+	 * requiring fifo granting.
+	 */
 
-	if (r->res_master_nodeid && (r->res_master_nodeid != ret_nodeid)) {
-		/* This should never happen */
-		log_error(ls, "receive_lookup_reply %x from %d ret %d "
-			  "master %d dir %d our %d first %x %s",
-			  lkb->lkb_id, le32_to_cpu(ms->m_header.h_nodeid),
-			  ret_nodeid, r->res_master_nodeid, r->res_dir_nodeid,
-			  dlm_our_nodeid(), r->res_first_lkid, r->res_name);
-	}
+	if (now && conv && !(lkb->lkb_exflags & DLM_LKF_QUECVT))
+		return 1;
 
-	if (ret_nodeid == dlm_our_nodeid()) {
-		r->res_master_nodeid = ret_nodeid;
-		r->res_nodeid = 0;
-		do_lookup_list = 1;
-		r->res_first_lkid = 0;
-	} else if (ret_nodeid == -1) {
-		/* the remote node doesn't believe it's the dir node */
-		log_error(ls, "receive_lookup_reply %x from %d bad ret_nodeid",
-			  lkb->lkb_id, le32_to_cpu(ms->m_header.h_nodeid));
-		r->res_master_nodeid = 0;
-		r->res_nodeid = -1;
-		lkb->lkb_nodeid = -1;
-	} else {
-		/* set_master() will set lkb_nodeid from r */
-		r->res_master_nodeid = ret_nodeid;
-		r->res_nodeid = ret_nodeid;
-	}
+	/*
+	 * Even if the convert is compat with all granted locks,
+	 * QUECVT forces it behind other locks on the convert queue.
+	 */
 
-	if (is_overlap(lkb)) {
-		log_debug(ls, "receive_lookup_reply %x unlock %x",
-			  lkb->lkb_id, dlm_iflags_val(lkb));
-		queue_cast_overlap(r, lkb);
-		unhold_lkb(lkb); /* undoes create_lkb() */
-		goto out_list;
+	if (now && conv && (lkb->lkb_exflags & DLM_LKF_QUECVT)) {
+		if (list_empty(&r->res_convertqueue))
+			return 1;
+		else
+			return 0;
 	}
 
-	_request_lock(r, lkb);
+	/*
+	 * The NOORDER flag is set to avoid the standard vms rules on grant
+	 * order.
+	 */
 
- out_list:
-	if (do_lookup_list)
-		process_lookup_list(r);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	dlm_put_lkb(lkb);
-}
+	if (lkb->lkb_exflags & DLM_LKF_NOORDER)
+		return 1;
 
-static void _receive_message(struct dlm_ls *ls, const struct dlm_message *ms,
-			     uint32_t saved_seq)
-{
-	int error = 0, noent = 0;
+	/*
+	 * 6-3: Once in that queue [CONVERTING], a conversion request cannot be
+	 * granted until all other conversion requests ahead of it are granted
+	 * and/or canceled.
+	 */
 
-	if (WARN_ON_ONCE(!dlm_is_member(ls, le32_to_cpu(ms->m_header.h_nodeid)))) {
-		log_limit(ls, "receive %d from non-member %d %x %x %d",
-			  le32_to_cpu(ms->m_type),
-			  le32_to_cpu(ms->m_header.h_nodeid),
-			  le32_to_cpu(ms->m_lkid), le32_to_cpu(ms->m_remid),
-			  from_dlm_errno(le32_to_cpu(ms->m_result)));
-		return;
-	}
+	if (!now && conv && first_in_list(lkb, &r->res_convertqueue))
+		return 1;
 
-	switch (ms->m_type) {
+	/*
+	 * 6-4: By default, a new request is immediately granted only if all
+	 * three of the following conditions are satisfied when the request is
+	 * issued:
+	 * - The queue of ungranted conversion requests for the resource is
+	 *   empty.
+	 * - The queue of ungranted new requests for the resource is empty.
+	 * - The mode of the new request is compatible with the most
+	 *   restrictive mode of all granted locks on the resource.
+	 */
 
-	/* messages sent to a master node */
+	if (now && !conv && list_empty(&r->res_convertqueue) &&
+	    list_empty(&r->res_waitqueue))
+		return 1;
 
-	case cpu_to_le32(DLM_MSG_REQUEST):
-		error = receive_request(ls, ms);
-		break;
+	/*
+	 * 6-4: Once a lock request is in the queue of ungranted new requests,
+	 * it cannot be granted until the queue of ungranted conversion
+	 * requests is empty, all ungranted new requests ahead of it are
+	 * granted and/or canceled, and it is compatible with the granted mode
+	 * of the most restrictive lock granted on the resource.
+	 */
 
-	case cpu_to_le32(DLM_MSG_CONVERT):
-		error = receive_convert(ls, ms);
-		break;
+	if (!now && !conv && list_empty(&r->res_convertqueue) &&
+	    first_in_list(lkb, &r->res_waitqueue))
+		return 1;
 
-	case cpu_to_le32(DLM_MSG_UNLOCK):
-		error = receive_unlock(ls, ms);
-		break;
+	return 0;
+}
 
-	case cpu_to_le32(DLM_MSG_CANCEL):
-		noent = 1;
-		error = receive_cancel(ls, ms);
-		break;
+static int can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
+			  int recover, int *err)
+{
+	int rv;
+	int8_t alt = 0, rqmode = lkb->lkb_rqmode;
+	int8_t is_convert = (lkb->lkb_grmode != DLM_LOCK_IV);
 
-	/* messages sent from a master node (replies to above) */
+	if (err)
+		*err = 0;
 
-	case cpu_to_le32(DLM_MSG_REQUEST_REPLY):
-		error = receive_request_reply(ls, ms);
-		break;
+	rv = _can_be_granted(r, lkb, now, recover);
+	if (rv)
+		goto out;
 
-	case cpu_to_le32(DLM_MSG_CONVERT_REPLY):
-		error = receive_convert_reply(ls, ms);
-		break;
+	/*
+	 * The CONVDEADLK flag is non-standard and tells the dlm to resolve
+	 * conversion deadlocks by demoting grmode to NL, otherwise the dlm
+	 * cancels one of the locks.
+	 */
 
-	case cpu_to_le32(DLM_MSG_UNLOCK_REPLY):
-		error = receive_unlock_reply(ls, ms);
-		break;
+	if (is_convert && can_be_queued(lkb) &&
+	    conversion_deadlock_detect(r, lkb)) {
+		if (lkb->lkb_exflags & DLM_LKF_CONVDEADLK) {
+			lkb->lkb_grmode = DLM_LOCK_NL;
+			set_bit(DLM_SBF_DEMOTED_BIT, &lkb->lkb_sbflags);
+		} else if (err) {
+			*err = -EDEADLK;
+		} else {
+			log_print("can_be_granted deadlock %x now %d",
+				  lkb->lkb_id, now);
+			dlm_dump_rsb(r);
+		}
+		goto out;
+	}
 
-	case cpu_to_le32(DLM_MSG_CANCEL_REPLY):
-		error = receive_cancel_reply(ls, ms);
-		break;
+	/*
+	 * The ALTPR and ALTCW flags are non-standard and tell the dlm to try
+	 * to grant a request in a mode other than the normal rqmode.  It's a
+	 * simple way to provide a big optimization to applications that can
+	 * use them.
+	 */
 
-	/* messages sent from a master node (only two types of async msg) */
+	if (rqmode != DLM_LOCK_PR && (lkb->lkb_exflags & DLM_LKF_ALTPR))
+		alt = DLM_LOCK_PR;
+	else if (rqmode != DLM_LOCK_CW && (lkb->lkb_exflags & DLM_LKF_ALTCW))
+		alt = DLM_LOCK_CW;
 
-	case cpu_to_le32(DLM_MSG_GRANT):
-		noent = 1;
-		error = receive_grant(ls, ms);
-		break;
+	if (alt) {
+		lkb->lkb_rqmode = alt;
+		rv = _can_be_granted(r, lkb, now, 0);
+		if (rv)
+			set_bit(DLM_SBF_ALTMODE_BIT, &lkb->lkb_sbflags);
+		else
+			lkb->lkb_rqmode = rqmode;
+	}
+ out:
+	return rv;
+}
 
-	case cpu_to_le32(DLM_MSG_BAST):
-		noent = 1;
-		error = receive_bast(ls, ms);
-		break;
+/* Returns the highest requested mode of all blocked conversions; sets
+   cw if there's a blocked conversion to DLM_LOCK_CW. */
 
-	/* messages sent to a dir node */
+static int grant_pending_convert(struct dlm_rsb *r, int high, int *cw,
+				 unsigned int *count)
+{
+	struct dlm_lkb *lkb, *s;
+	int recover = rsb_flag(r, RSB_RECOVER_GRANT);
+	int hi, demoted, quit, grant_restart, demote_restart;
+	int deadlk;
 
-	case cpu_to_le32(DLM_MSG_LOOKUP):
-		receive_lookup(ls, ms);
-		break;
+	quit = 0;
+ restart:
+	grant_restart = 0;
+	demote_restart = 0;
+	hi = DLM_LOCK_IV;
 
-	case cpu_to_le32(DLM_MSG_REMOVE):
-		receive_remove(ls, ms);
-		break;
+	list_for_each_entry_safe(lkb, s, &r->res_convertqueue, lkb_statequeue) {
+		demoted = is_demoted(lkb);
+		deadlk = 0;
 
-	/* messages sent from a dir node (remove has no reply) */
+		if (can_be_granted(r, lkb, 0, recover, &deadlk)) {
+			grant_lock_pending(r, lkb);
+			grant_restart = 1;
+			if (count)
+				(*count)++;
+			continue;
+		}
+
+		if (!demoted && is_demoted(lkb)) {
+			log_print("WARN: pending demoted %x node %d %s",
+				  lkb->lkb_id, lkb->lkb_nodeid, r->res_name);
+			demote_restart = 1;
+			continue;
+		}
 
 	case cpu_to_le32(DLM_MSG_LOOKUP_REPLY):
 		receive_lookup_reply(ls, ms);
-- 
2.48.1


