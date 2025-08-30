Return-Path: <linux-kernel+bounces-792888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 078F7B3CA02
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E3774E261D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C4E27467B;
	Sat, 30 Aug 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpO1+bjb"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C826E165
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548875; cv=none; b=piRORUR3LHpor1GfHyASdtM2RSaQt/hFEpNIAUQaq9bq+QiskNm5hfDYKvk4et40NJLw1M3WlsxSqJy9NjU49xftdoxGGLtWFZLXyFupD2LGVwrGyabP6BQTUx1BLh7D2ds9JDNj9ZbFKgqO042nOnBLwFpOdd1FSCPgxUBPhQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548875; c=relaxed/simple;
	bh=G0KsQkUXLggC86zwYOgpd3IZPnQakWRbBH0OquAEsoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oerM99s1dAN8r2hv4cLdk4JcAQPbh4KYDTnbX9OK2tV5EewOG1ZPsysizRU9JDIyOsWxG4JbIZw5P0lQRyrf1cL57prs+Vk9xAwtiJx1FC8YiPIwZrqfeMdTynVzLZRV5UWTwTX8EbPPaPkgUvifwiInvZE46huevqIRVYHHDOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpO1+bjb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b7d485204so19956065e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548870; x=1757153670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm237iUUX1BAqnde39+6ZKw05MafVCJiN11WII489Gw=;
        b=EpO1+bjbwcz5cftf1ApchK4Wp0iDhbvYugkyc8NbRsTC4x69uHY+z+VXMQMnKt3a3G
         FpPxezVa9/YE+KaKkinPGmbcqemMP1T72107Qga3kbAWGUvZtgHu913O0MLjPqMK4fJT
         q9qZRoLivO6e0KFUGd7T3uQiPAbtVNvJvryE1igNWngnfrGi3EvURABl2BfxhJscYZ5Y
         PaUhZygLLpy14el5LpBknwypyh/Tn+u6XgCFJpGkkgOXVw3/3tsW3vvB0wKvWTzvBFOL
         PUECe7Lt97d/fZcNvQOl6/bzBty5FvOP1Im/flW/I4M2RaF6vfe0I5kWfnh5WIMStBak
         NMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548870; x=1757153670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm237iUUX1BAqnde39+6ZKw05MafVCJiN11WII489Gw=;
        b=onmfM0OPPxk5Q+LxoIG3/YKWa1r9a4nlHHvc8iVAOEeyIfckN5NvxW+yVJBRmEaHkE
         02jx5tkO4E1XgV0ZZJkiW2AgssKe9AHjTHR50Yt3udXrJlx9Izl3+FRZwk46Utz1WaTA
         UZi2yN/8t7Rp8W8e6AkW0r73GO2XK+V+gz2vXCgifTpRdBpl3oTXG7Aw0BZ8e8i+O6qK
         sTd4t9MmdVUGRAja1/GLP4C7DEXHBAF10yka0aDOJTzQ1Cj32LOxc4oI8QKTiLeqOG0Y
         jgOfK8P/B/qWu0LxgULdthTEQV360lblhyKb82E+yhluvmO1KcFCxBuWcEuBgL6f3cZC
         +btg==
X-Gm-Message-State: AOJu0YyfPLm2cyRH1Pn43XFnHEm5l2NuQ4rPSj1JXlsWPge8zN+ty1yq
	yrWhSon2q4trH9gxAc0dGVcGMtNqIEzlwd/YSvhIJff4Wf6/+8kCTcVOz5BJ493k2V4=
X-Gm-Gg: ASbGncvtcxhZjvpt3/mh56MoK9ELBJCGytpsDbcT+vwlB40L+zPUBsf0GkxJQh33Njz
	Yh18r1FkQ0vN6QUKbubij3z2IDRNPTs6pDY34oy8kKRwiO4YtLbmW5+v/TJYWskUz9OIkurmPGS
	7r+S+o1E7DM2H44RTWkHjtsT6XTv5a81pcziorFRWgj+n6buunSGlLrvrdhwJ8ZltegSdW6fJ0g
	iTD0GKryS5t/QuowIOWR4il4mEljWsx33rxVPO8VWYm/ptBzAfcTMgtEeDVxXs/F/C/h5IRRwSe
	UW+SoeZ1I4g0yBCEmprZ3NqlsJnwDREPYbumsh2jt8agNRZDDBKKIWFzwKDpzz2HG7BdjLYmo+K
	Pz4sJe25Qyzn9NXfGHYwWYpCLMvoUP24wPdjCldF9uiP+u4V3E67BO92wh5prFqrrmyHNHCVhu1
	ORQzNq7fxHMV+4KLRqf3Vjr6XOkQDdjR8DoNlUppI91eAHLVXZr0Ehu8oGwBJNYfXsfQzdyd3+T
	zEVjt/KldWJIS+M4klQ903PdYxYBg==
X-Google-Smtp-Source: AGHT+IGZZH9i15tVWJTQK0T2Dp039pLNnvoclwe2kDuN1m83wsmfxoVWvtWHjyt83sELzMrzK6r7DA==
X-Received: by 2002:a05:6000:2204:b0:3c9:a722:e189 with SMTP id ffacd0b85a97d-3d1df920006mr1106473f8f.62.1756548869458;
        Sat, 30 Aug 2025 03:14:29 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:29 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 10/12] fix: improve dlm_rsb struct
Date: Sat, 30 Aug 2025 12:14:11 +0200
Message-ID: <20250830101413.602637-10-226562783+SigAttilio@users.noreply.github.com>
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
 fs/dlm/lock.c | 889 +++++++++++++++++++++++++-------------------------
 1 file changed, 451 insertions(+), 438 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 3ead785d8dbe..4236b38aae94 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4470,545 +4470,558 @@ static int grant_pending_convert(struct dlm_rsb *r, int high, int *cw,
 			continue;
 		}
 
-	case cpu_to_le32(DLM_MSG_LOOKUP_REPLY):
-		receive_lookup_reply(ls, ms);
-		break;
+		if (deadlk) {
+			/*
+			 * If DLM_LKB_NODLKWT flag is set and conversion
+			 * deadlock is detected, we request blocking AST and
+			 * down (or cancel) conversion.
+			 */
+			if (lkb->lkb_exflags & DLM_LKF_NODLCKWT) {
+				if (lkb->lkb_highbast < lkb->lkb_rqmode) {
+					queue_bast(r, lkb, lkb->lkb_rqmode);
+					lkb->lkb_highbast = lkb->lkb_rqmode;
+				}
+			} else {
+				log_print("WARN: pending deadlock %x node %d %s",
+					  lkb->lkb_id, lkb->lkb_nodeid,
+					  r->res_name);
+				dlm_dump_rsb(r);
+			}
+			continue;
+		}
 
-	/* other messages */
+		hi = max_t(int, lkb->lkb_rqmode, hi);
 
-	case cpu_to_le32(DLM_MSG_PURGE):
-		receive_purge(ls, ms);
-		break;
+		if (cw && lkb->lkb_rqmode == DLM_LOCK_CW)
+			*cw = 1;
+	}
 
-	default:
-		log_error(ls, "unknown message type %d",
-			  le32_to_cpu(ms->m_type));
+	if (grant_restart)
+		goto restart;
+	if (demote_restart && !quit) {
+		quit = 1;
+		goto restart;
 	}
 
-	/*
-	 * When checking for ENOENT, we're checking the result of
-	 * find_lkb(m_remid):
-	 *
-	 * The lock id referenced in the message wasn't found.  This may
-	 * happen in normal usage for the async messages and cancel, so
-	 * only use log_debug for them.
-	 *
-	 * Some errors are expected and normal.
-	 */
+	return max_t(int, high, hi);
+}
 
-	if (error == -ENOENT && noent) {
-		log_debug(ls, "receive %d no %x remote %d %x saved_seq %u",
-			  le32_to_cpu(ms->m_type), le32_to_cpu(ms->m_remid),
-			  le32_to_cpu(ms->m_header.h_nodeid),
-			  le32_to_cpu(ms->m_lkid), saved_seq);
-	} else if (error == -ENOENT) {
-		log_error(ls, "receive %d no %x remote %d %x saved_seq %u",
-			  le32_to_cpu(ms->m_type), le32_to_cpu(ms->m_remid),
-			  le32_to_cpu(ms->m_header.h_nodeid),
-			  le32_to_cpu(ms->m_lkid), saved_seq);
-
-		if (ms->m_type == cpu_to_le32(DLM_MSG_CONVERT))
-			dlm_dump_rsb_hash(ls, le32_to_cpu(ms->m_hash));
-	}
-
-	if (error == -EINVAL) {
-		log_error(ls, "receive %d inval from %d lkid %x remid %x "
-			  "saved_seq %u",
-			  le32_to_cpu(ms->m_type),
-			  le32_to_cpu(ms->m_header.h_nodeid),
-			  le32_to_cpu(ms->m_lkid), le32_to_cpu(ms->m_remid),
-			  saved_seq);
-	}
-}
-
-/* If the lockspace is in recovery mode (locking stopped), then normal
-   messages are saved on the requestqueue for processing after recovery is
-   done.  When not in recovery mode, we wait for dlm_recoverd to drain saved
-   messages off the requestqueue before we process new ones. This occurs right
-   after recovery completes when we transition from saving all messages on
-   requestqueue, to processing all the saved messages, to processing new
-   messages as they arrive. */
-
-static void dlm_receive_message(struct dlm_ls *ls, const struct dlm_message *ms,
-				int nodeid)
-{
-try_again:
-	read_lock_bh(&ls->ls_requestqueue_lock);
-	if (test_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags)) {
-		/* If we were a member of this lockspace, left, and rejoined,
-		   other nodes may still be sending us messages from the
-		   lockspace generation before we left. */
-		if (WARN_ON_ONCE(!ls->ls_generation)) {
-			read_unlock_bh(&ls->ls_requestqueue_lock);
-			log_limit(ls, "receive %d from %d ignore old gen",
-				  le32_to_cpu(ms->m_type), nodeid);
-			return;
-		}
+static int grant_pending_wait(struct dlm_rsb *r, int high, int *cw,
+			      unsigned int *count)
+{
+	struct dlm_lkb *lkb, *s;
 
-		read_unlock_bh(&ls->ls_requestqueue_lock);
-		write_lock_bh(&ls->ls_requestqueue_lock);
-		/* recheck because we hold writelock now */
-		if (!test_bit(LSFL_RECV_MSG_BLOCKED, &ls->ls_flags)) {
-			write_unlock_bh(&ls->ls_requestqueue_lock);
-			goto try_again;
+	list_for_each_entry_safe(lkb, s, &r->res_waitqueue, lkb_statequeue) {
+		if (can_be_granted(r, lkb, 0, 0, NULL)) {
+			grant_lock_pending(r, lkb);
+			if (count)
+				(*count)++;
+		} else {
+			high = max_t(int, lkb->lkb_rqmode, high);
+			if (lkb->lkb_rqmode == DLM_LOCK_CW)
+				*cw = 1;
 		}
-
-		dlm_add_requestqueue(ls, nodeid, ms);
-		write_unlock_bh(&ls->ls_requestqueue_lock);
-	} else {
-		_receive_message(ls, ms, 0);
-		read_unlock_bh(&ls->ls_requestqueue_lock);
 	}
+
+	return high;
 }
 
-/* This is called by dlm_recoverd to process messages that were saved on
-   the requestqueue. */
+/* cw of 1 means there's a lock with a rqmode of DLM_LOCK_CW that's blocked
+   on either the convert or waiting queue.
+   high is the largest rqmode of all locks blocked on the convert or
+   waiting queue. */
 
-void dlm_receive_message_saved(struct dlm_ls *ls, const struct dlm_message *ms,
-			       uint32_t saved_seq)
+static int lock_requires_bast(struct dlm_lkb *gr, int high, int cw)
 {
-	_receive_message(ls, ms, saved_seq);
-}
+	if (gr->lkb_grmode == DLM_LOCK_PR && cw) {
+		if (gr->lkb_highbast < DLM_LOCK_EX)
+			return 1;
+		return 0;
+	}
 
-/* This is called by the midcomms layer when something is received for
-   the lockspace.  It could be either a MSG (normal message sent as part of
-   standard locking activity) or an RCOM (recovery message sent as part of
-   lockspace recovery). */
+	if (gr->lkb_highbast < high &&
+	    !__dlm_compat_matrix[gr->lkb_grmode+1][high+1])
+		return 1;
+	return 0;
+}
 
-void dlm_receive_buffer(const union dlm_packet *p, int nodeid)
+static void grant_pending_locks(struct dlm_rsb *r, unsigned int *count)
 {
-	const struct dlm_header *hd = &p->header;
-	struct dlm_ls *ls;
-	int type = 0;
+	struct dlm_lkb *lkb, *s;
+	int high = DLM_LOCK_IV;
+	int cw = 0;
 
-	switch (hd->h_cmd) {
-	case DLM_MSG:
-		type = le32_to_cpu(p->message.m_type);
-		break;
-	case DLM_RCOM:
-		type = le32_to_cpu(p->rcom.rc_type);
-		break;
-	default:
-		log_print("invalid h_cmd %d from %u", hd->h_cmd, nodeid);
+	if (!is_master(r)) {
+		log_print("grant_pending_locks r nodeid %d", r->res_nodeid);
+		dlm_dump_rsb(r);
 		return;
 	}
 
-	if (le32_to_cpu(hd->h_nodeid) != nodeid) {
-		log_print("invalid h_nodeid %d from %d lockspace %x",
-			  le32_to_cpu(hd->h_nodeid), nodeid,
-			  le32_to_cpu(hd->u.h_lockspace));
+	high = grant_pending_convert(r, high, &cw, count);
+	high = grant_pending_wait(r, high, &cw, count);
+
+	if (high == DLM_LOCK_IV)
 		return;
-	}
 
-	ls = dlm_find_lockspace_global(le32_to_cpu(hd->u.h_lockspace));
-	if (!ls) {
-		if (dlm_config.ci_log_debug) {
-			printk_ratelimited(KERN_DEBUG "dlm: invalid lockspace "
-				"%u from %d cmd %d type %d\n",
-				le32_to_cpu(hd->u.h_lockspace), nodeid,
-				hd->h_cmd, type);
+	/*
+	 * If there are locks left on the wait/convert queue then send blocking
+	 * ASTs to granted locks based on the largest requested mode (high)
+	 * found above.
+	 */
+
+	list_for_each_entry_safe(lkb, s, &r->res_grantqueue, lkb_statequeue) {
+		if (lkb->lkb_bastfn && lock_requires_bast(lkb, high, cw)) {
+			if (cw && high == DLM_LOCK_PR &&
+			    lkb->lkb_grmode == DLM_LOCK_PR)
+				queue_bast(r, lkb, DLM_LOCK_CW);
+			else
+				queue_bast(r, lkb, high);
+			lkb->lkb_highbast = high;
 		}
+	}
+}
 
-		if (hd->h_cmd == DLM_RCOM && type == DLM_RCOM_STATUS)
-			dlm_send_ls_not_ready(nodeid, &p->rcom);
-		return;
+static int modes_require_bast(struct dlm_lkb *gr, struct dlm_lkb *rq)
+{
+	if ((gr->lkb_grmode == DLM_LOCK_PR && rq->lkb_rqmode == DLM_LOCK_CW) ||
+	    (gr->lkb_grmode == DLM_LOCK_CW && rq->lkb_rqmode == DLM_LOCK_PR)) {
+		if (gr->lkb_highbast < DLM_LOCK_EX)
+			return 1;
+		return 0;
 	}
 
-	/* this rwsem allows dlm_ls_stop() to wait for all dlm_recv threads to
-	   be inactive (in this ls) before transitioning to recovery mode */
+	if (gr->lkb_highbast < rq->lkb_rqmode && !modes_compat(gr, rq))
+		return 1;
+	return 0;
+}
 
-	read_lock_bh(&ls->ls_recv_active);
-	if (hd->h_cmd == DLM_MSG)
-		dlm_receive_message(ls, &p->message, nodeid);
-	else if (hd->h_cmd == DLM_RCOM)
-		dlm_receive_rcom(ls, &p->rcom, nodeid);
-	else
-		log_error(ls, "invalid h_cmd %d from %d lockspace %x",
-			  hd->h_cmd, nodeid, le32_to_cpu(hd->u.h_lockspace));
-	read_unlock_bh(&ls->ls_recv_active);
+static void send_bast_queue(struct dlm_rsb *r, struct list_head *head,
+			    struct dlm_lkb *lkb)
+{
+	struct dlm_lkb *gr;
 
-	dlm_put_lockspace(ls);
+	list_for_each_entry(gr, head, lkb_statequeue) {
+		/* skip self when sending basts to convertqueue */
+		if (gr == lkb)
+			continue;
+		if (gr->lkb_bastfn && modes_require_bast(gr, lkb)) {
+			queue_bast(r, gr, lkb->lkb_rqmode);
+			gr->lkb_highbast = lkb->lkb_rqmode;
+		}
+	}
 }
 
-static void recover_convert_waiter(struct dlm_ls *ls, struct dlm_lkb *lkb,
-				   struct dlm_message *ms_local)
+static void send_blocking_asts(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	if (middle_conversion(lkb)) {
-		log_rinfo(ls, "%s %x middle convert in progress", __func__,
-			 lkb->lkb_id);
+	send_bast_queue(r, &r->res_grantqueue, lkb);
+}
 
-		/* We sent this lock to the new master. The new master will
-		 * tell us when it's granted.  We no longer need a reply, so
-		 * use a fake reply to put the lkb into the right state.
-		 */
-		hold_lkb(lkb);
-		memset(ms_local, 0, sizeof(struct dlm_message));
-		ms_local->m_type = cpu_to_le32(DLM_MSG_CONVERT_REPLY);
-		ms_local->m_result = cpu_to_le32(to_dlm_errno(-EINPROGRESS));
-		ms_local->m_header.h_nodeid = cpu_to_le32(lkb->lkb_nodeid);
-		_receive_convert_reply(lkb, ms_local, true);
-		unhold_lkb(lkb);
+static void send_blocking_asts_all(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	send_bast_queue(r, &r->res_grantqueue, lkb);
+	send_bast_queue(r, &r->res_convertqueue, lkb);
+}
 
-	} else if (lkb->lkb_rqmode >= lkb->lkb_grmode) {
-		set_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
-	}
+/* set_master(r, lkb) -- set the master nodeid of a resource
 
-	/* lkb->lkb_rqmode < lkb->lkb_grmode shouldn't happen since down
-	   conversions are async; there's no reply from the remote master */
-}
+   The purpose of this function is to set the nodeid field in the given
+   lkb using the nodeid field in the given rsb.  If the rsb's nodeid is
+   known, it can just be copied to the lkb and the function will return
+   0.  If the rsb's nodeid is _not_ known, it needs to be looked up
+   before it can be copied to the lkb.
+
+   When the rsb nodeid is being looked up remotely, the initial lkb
+   causing the lookup is kept on the ls_waiters list waiting for the
+   lookup reply.  Other lkb's waiting for the same rsb lookup are kept
+   on the rsb's res_lookup list until the master is verified.
 
-/* A waiting lkb needs recovery if the master node has failed, or
-   the master node is changing (only when no directory is used) */
+   Return values:
+   0: nodeid is set in rsb/lkb and the caller should go ahead and use it
+   1: the rsb master is not available and the lkb has been placed on
+      a wait queue
+*/
 
-static int waiter_needs_recovery(struct dlm_ls *ls, struct dlm_lkb *lkb,
-				 int dir_nodeid)
+static int set_master(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	if (dlm_no_directory(ls))
-		return 1;
+	int our_nodeid = dlm_our_nodeid();
+
+	if (rsb_flag(r, RSB_MASTER_UNCERTAIN)) {
+		rsb_clear_flag(r, RSB_MASTER_UNCERTAIN);
+		r->res_first_lkid = lkb->lkb_id;
+		lkb->lkb_nodeid = r->res_nodeid;
+		return 0;
+	}
 
-	if (dlm_is_removed(ls, lkb->lkb_wait_nodeid))
+	if (r->res_first_lkid && r->res_first_lkid != lkb->lkb_id) {
+		list_add_tail(&lkb->lkb_rsb_lookup, &r->res_lookup);
 		return 1;
+	}
 
-	return 0;
-}
+	if (r->res_master_nodeid == our_nodeid) {
+		lkb->lkb_nodeid = 0;
+		return 0;
+	}
+
+	if (r->res_master_nodeid) {
+		lkb->lkb_nodeid = r->res_master_nodeid;
+		return 0;
+	}
 
-/* Recovery for locks that are waiting for replies from nodes that are now
-   gone.  We can just complete unlocks and cancels by faking a reply from the
-   dead node.  Requests and up-conversions we flag to be resent after
-   recovery.  Down-conversions can just be completed with a fake reply like
-   unlocks.  Conversions between PR and CW need special attention. */
+	if (dlm_dir_nodeid(r) == our_nodeid) {
+		/* This is a somewhat unusual case; find_rsb will usually
+		   have set res_master_nodeid when dir nodeid is local, but
+		   there are cases where we become the dir node after we've
+		   past find_rsb and go through _request_lock again.
+		   confirm_master() or process_lookup_list() needs to be
+		   called after this. */
+		log_debug(r->res_ls, "set_master %x self master %d dir %d %s",
+			  lkb->lkb_id, r->res_master_nodeid, r->res_dir_nodeid,
+			  r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		lkb->lkb_nodeid = 0;
+		return 0;
+	}
+
+	r->res_first_lkid = lkb->lkb_id;
+	send_lookup(r, lkb);
+	return 1;
+}
 
-void dlm_recover_waiters_pre(struct dlm_ls *ls)
+static void process_lookup_list(struct dlm_rsb *r)
 {
 	struct dlm_lkb *lkb, *safe;
-	struct dlm_message *ms_local;
-	int wait_type, local_unlock_result, local_cancel_result;
-	int dir_nodeid;
 
-	ms_local = kmalloc(sizeof(*ms_local), GFP_KERNEL);
-	if (!ms_local)
+	list_for_each_entry_safe(lkb, safe, &r->res_lookup, lkb_rsb_lookup) {
+		list_del_init(&lkb->lkb_rsb_lookup);
+		_request_lock(r, lkb);
+	}
+}
+
+/* confirm_master -- confirm (or deny) an rsb's master nodeid */
+
+static void confirm_master(struct dlm_rsb *r, int error)
+{
+	struct dlm_lkb *lkb;
+
+	if (!r->res_first_lkid)
 		return;
 
-	list_for_each_entry_safe(lkb, safe, &ls->ls_waiters, lkb_wait_reply) {
+	switch (error) {
+	case 0:
+	case -EINPROGRESS:
+		r->res_first_lkid = 0;
+		process_lookup_list(r);
+		break;
 
-		dir_nodeid = dlm_dir_nodeid(lkb->lkb_resource);
+	case -EAGAIN:
+	case -EBADR:
+	case -ENOTBLK:
+		/* the remote request failed and won't be retried (it was
+		   a NOQUEUE, or has been canceled/unlocked); make a waiting
+		   lkb the first_lkid */
 
-		/* exclude debug messages about unlocks because there can be so
-		   many and they aren't very interesting */
+		r->res_first_lkid = 0;
 
-		if (lkb->lkb_wait_type != DLM_MSG_UNLOCK) {
-			log_debug(ls, "waiter %x remote %x msg %d r_nodeid %d "
-				  "lkb_nodeid %d wait_nodeid %d dir_nodeid %d",
-				  lkb->lkb_id,
-				  lkb->lkb_remid,
-				  lkb->lkb_wait_type,
-				  lkb->lkb_resource->res_nodeid,
-				  lkb->lkb_nodeid,
-				  lkb->lkb_wait_nodeid,
-				  dir_nodeid);
+		if (!list_empty(&r->res_lookup)) {
+			lkb = list_entry(r->res_lookup.next, struct dlm_lkb,
+					 lkb_rsb_lookup);
+			list_del_init(&lkb->lkb_rsb_lookup);
+			r->res_first_lkid = lkb->lkb_id;
+			_request_lock(r, lkb);
 		}
+		break;
 
-		/* all outstanding lookups, regardless of destination  will be
-		   resent after recovery is done */
+	default:
+		log_error(r->res_ls, "confirm_master unknown error %d", error);
+	}
+}
 
-		if (lkb->lkb_wait_type == DLM_MSG_LOOKUP) {
-			set_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
-			continue;
-		}
+static int set_lock_args(int mode, struct dlm_lksb *lksb, uint32_t flags,
+			 int namelen, void (*ast)(void *astparam),
+			 void *astparam,
+			 void (*bast)(void *astparam, int mode),
+			 struct dlm_args *args)
+{
+	int rv = -EINVAL;
 
-		if (!waiter_needs_recovery(ls, lkb, dir_nodeid))
-			continue;
+	/* check for invalid arg usage */
 
-		wait_type = lkb->lkb_wait_type;
-		local_unlock_result = -DLM_EUNLOCK;
-		local_cancel_result = -DLM_ECANCEL;
+	if (mode < 0 || mode > DLM_LOCK_EX)
+		goto out;
 
-		/* Main reply may have been received leaving a zero wait_type,
-		   but a reply for the overlapping op may not have been
-		   received.  In that case we need to fake the appropriate
-		   reply for the overlap op. */
+	if (!(flags & DLM_LKF_CONVERT) && (namelen > DLM_RESNAME_MAXLEN))
+		goto out;
 
-		if (!wait_type) {
-			if (is_overlap_cancel(lkb)) {
-				wait_type = DLM_MSG_CANCEL;
-				if (lkb->lkb_grmode == DLM_LOCK_IV)
-					local_cancel_result = 0;
-			}
-			if (is_overlap_unlock(lkb)) {
-				wait_type = DLM_MSG_UNLOCK;
-				if (lkb->lkb_grmode == DLM_LOCK_IV)
-					local_unlock_result = -ENOENT;
-			}
+	if (flags & DLM_LKF_CANCEL)
+		goto out;
 
-			log_debug(ls, "rwpre overlap %x %x %d %d %d",
-				  lkb->lkb_id, dlm_iflags_val(lkb), wait_type,
-				  local_cancel_result, local_unlock_result);
-		}
+	if (flags & DLM_LKF_QUECVT && !(flags & DLM_LKF_CONVERT))
+		goto out;
 
-		switch (wait_type) {
+	if (flags & DLM_LKF_CONVDEADLK && !(flags & DLM_LKF_CONVERT))
+		goto out;
 
-		case DLM_MSG_REQUEST:
-			set_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
-			break;
+	if (flags & DLM_LKF_CONVDEADLK && flags & DLM_LKF_NOQUEUE)
+		goto out;
 
-		case DLM_MSG_CONVERT:
-			recover_convert_waiter(ls, lkb, ms_local);
-			break;
+	if (flags & DLM_LKF_EXPEDITE && flags & DLM_LKF_CONVERT)
+		goto out;
 
-		case DLM_MSG_UNLOCK:
-			hold_lkb(lkb);
-			memset(ms_local, 0, sizeof(struct dlm_message));
-			ms_local->m_type = cpu_to_le32(DLM_MSG_UNLOCK_REPLY);
-			ms_local->m_result = cpu_to_le32(to_dlm_errno(local_unlock_result));
-			ms_local->m_header.h_nodeid = cpu_to_le32(lkb->lkb_nodeid);
-			_receive_unlock_reply(lkb, ms_local, true);
-			dlm_put_lkb(lkb);
-			break;
+	if (flags & DLM_LKF_EXPEDITE && flags & DLM_LKF_QUECVT)
+		goto out;
 
-		case DLM_MSG_CANCEL:
-			hold_lkb(lkb);
-			memset(ms_local, 0, sizeof(struct dlm_message));
-			ms_local->m_type = cpu_to_le32(DLM_MSG_CANCEL_REPLY);
-			ms_local->m_result = cpu_to_le32(to_dlm_errno(local_cancel_result));
-			ms_local->m_header.h_nodeid = cpu_to_le32(lkb->lkb_nodeid);
-			_receive_cancel_reply(lkb, ms_local, true);
-			dlm_put_lkb(lkb);
-			break;
+	if (flags & DLM_LKF_EXPEDITE && flags & DLM_LKF_NOQUEUE)
+		goto out;
 
-		default:
-			log_error(ls, "invalid lkb wait_type %d %d",
-				  lkb->lkb_wait_type, wait_type);
-		}
-		schedule();
-	}
-	kfree(ms_local);
+	if (flags & DLM_LKF_EXPEDITE && mode != DLM_LOCK_NL)
+		goto out;
+
+	if (!ast || !lksb)
+		goto out;
+
+	if (flags & DLM_LKF_VALBLK && !lksb->sb_lvbptr)
+		goto out;
+
+	if (flags & DLM_LKF_CONVERT && !lksb->sb_lkid)
+		goto out;
+
+	/* these args will be copied to the lkb in validate_lock_args,
+	   it cannot be done now because when converting locks, fields in
+	   an active lkb cannot be modified before locking the rsb */
+
+	args->flags = flags;
+	args->astfn = ast;
+	args->astparam = astparam;
+	args->bastfn = bast;
+	args->mode = mode;
+	args->lksb = lksb;
+	rv = 0;
+ out:
+	return rv;
 }
 
-static struct dlm_lkb *find_resend_waiter(struct dlm_ls *ls)
+static int set_unlock_args(uint32_t flags, void *astarg, struct dlm_args *args)
 {
-	struct dlm_lkb *lkb = NULL, *iter;
+	if (flags & ~(DLM_LKF_CANCEL | DLM_LKF_VALBLK | DLM_LKF_IVVALBLK |
+ 		      DLM_LKF_FORCEUNLOCK))
+		return -EINVAL;
 
-	spin_lock_bh(&ls->ls_waiters_lock);
-	list_for_each_entry(iter, &ls->ls_waiters, lkb_wait_reply) {
-		if (test_bit(DLM_IFL_RESEND_BIT, &iter->lkb_iflags)) {
-			hold_lkb(iter);
-			lkb = iter;
-			break;
-		}
-	}
-	spin_unlock_bh(&ls->ls_waiters_lock);
+	if (flags & DLM_LKF_CANCEL && flags & DLM_LKF_FORCEUNLOCK)
+		return -EINVAL;
 
-	return lkb;
+	args->flags = flags;
+	args->astparam = astarg;
+	return 0;
 }
 
-/*
- * Forced state reset for locks that were in the middle of remote operations
- * when recovery happened (i.e. lkbs that were on the waiters list, waiting
- * for a reply from a remote operation.)  The lkbs remaining on the waiters
- * list need to be reevaluated; some may need resending to a different node
- * than previously, and some may now need local handling rather than remote.
- *
- * First, the lkb state for the voided remote operation is forcibly reset,
- * equivalent to what remove_from_waiters() would normally do:
- * . lkb removed from ls_waiters list
- * . lkb wait_type cleared
- * . lkb waiters_count cleared
- * . lkb ref count decremented for each waiters_count (almost always 1,
- *   but possibly 2 in case of cancel/unlock overlapping, which means
- *   two remote replies were being expected for the lkb.)
- *
- * Second, the lkb is reprocessed like an original operation would be,
- * by passing it to _request_lock or _convert_lock, which will either
- * process the lkb operation locally, or send it to a remote node again
- * and put the lkb back onto the waiters list.
- *
- * When reprocessing the lkb, we may find that it's flagged for an overlapping
- * force-unlock or cancel, either from before recovery began, or after recovery
- * finished.  If this is the case, the unlock/cancel is done directly, and the
- * original operation is not initiated again (no _request_lock/_convert_lock.)
- */
-
-int dlm_recover_waiters_post(struct dlm_ls *ls)
+static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
+			      struct dlm_args *args)
 {
-	struct dlm_lkb *lkb;
-	struct dlm_rsb *r;
-	int error = 0, mstype, err, oc, ou;
+	int rv = -EBUSY;
 
-	while (1) {
-		if (dlm_locking_stopped(ls)) {
-			log_debug(ls, "recover_waiters_post aborted");
-			error = -EINTR;
-			break;
-		}
+	if (args->flags & DLM_LKF_CONVERT) {
+		if (lkb->lkb_status != DLM_LKSTS_GRANTED)
+			goto out;
 
-		/* 
-		 * Find an lkb from the waiters list that's been affected by
-		 * recovery node changes, and needs to be reprocessed.  Does
-		 * hold_lkb(), adding a refcount.
-		 */
-		lkb = find_resend_waiter(ls);
-		if (!lkb)
-			break;
+		/* lock not allowed if there's any op in progress */
+		if (lkb->lkb_wait_type || lkb->lkb_wait_count)
+			goto out;
 
-		r = lkb->lkb_resource;
-		hold_rsb(r);
-		lock_rsb(r);
+		if (is_overlap(lkb))
+			goto out;
 
-		/*
-		 * If the lkb has been flagged for a force unlock or cancel,
-		 * then the reprocessing below will be replaced by just doing
-		 * the unlock/cancel directly.
-		 */
-		mstype = lkb->lkb_wait_type;
-		oc = test_and_clear_bit(DLM_IFL_OVERLAP_CANCEL_BIT,
-					&lkb->lkb_iflags);
-		ou = test_and_clear_bit(DLM_IFL_OVERLAP_UNLOCK_BIT,
-					&lkb->lkb_iflags);
-		err = 0;
-
-		log_debug(ls, "waiter %x remote %x msg %d r_nodeid %d "
-			  "lkb_nodeid %d wait_nodeid %d dir_nodeid %d "
-			  "overlap %d %d", lkb->lkb_id, lkb->lkb_remid, mstype,
-			  r->res_nodeid, lkb->lkb_nodeid, lkb->lkb_wait_nodeid,
-			  dlm_dir_nodeid(r), oc, ou);
+		rv = -EINVAL;
+		if (test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags))
+			goto out;
 
-		/*
-		 * No reply to the pre-recovery operation will now be received,
-		 * so a forced equivalent of remove_from_waiters() is needed to
-		 * reset the waiters state that was in place before recovery.
-		 */
+		if (args->flags & DLM_LKF_QUECVT &&
+		    !__quecvt_compat_matrix[lkb->lkb_grmode+1][args->mode+1])
+			goto out;
+	}
 
-		clear_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
+	lkb->lkb_exflags = args->flags;
+	dlm_set_sbflags_val(lkb, 0);
+	lkb->lkb_astfn = args->astfn;
+	lkb->lkb_astparam = args->astparam;
+	lkb->lkb_bastfn = args->bastfn;
+	lkb->lkb_rqmode = args->mode;
+	lkb->lkb_lksb = args->lksb;
+	lkb->lkb_lvbptr = args->lksb->sb_lvbptr;
+	lkb->lkb_ownpid = (int) current->pid;
+	rv = 0;
+ out:
+	switch (rv) {
+	case 0:
+		break;
+	case -EINVAL:
+		/* annoy the user because dlm usage is wrong */
+		WARN_ON(1);
+		log_error(ls, "%s %d %x %x %x %d %d", __func__,
+			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
+			  lkb->lkb_status, lkb->lkb_wait_type);
+		break;
+	default:
+		log_debug(ls, "%s %d %x %x %x %d %d", __func__,
+			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
+			  lkb->lkb_status, lkb->lkb_wait_type);
+		break;
+	}
 
-		/* Forcibly clear wait_type */
-		lkb->lkb_wait_type = 0;
+	return rv;
+}
 
-		/*
-		 * Forcibly reset wait_count and associated refcount.  The
-		 * wait_count will almost always be 1, but in case of an
-		 * overlapping unlock/cancel it could be 2: see where
-		 * add_to_waiters() finds the lkb is already on the waiters
-		 * list and does lkb_wait_count++; hold_lkb().
-		 */
-		while (lkb->lkb_wait_count) {
-			lkb->lkb_wait_count--;
-			unhold_lkb(lkb);
-		}
+/* when dlm_unlock() sees -EBUSY with CANCEL/FORCEUNLOCK it returns 0
+   for success */
 
-		/* Forcibly remove from waiters list */
-		spin_lock_bh(&ls->ls_waiters_lock);
-		list_del_init(&lkb->lkb_wait_reply);
-		spin_unlock_bh(&ls->ls_waiters_lock);
+/* note: it's valid for lkb_nodeid/res_nodeid to be -1 when we get here
+   because there may be a lookup in progress and it's valid to do
+   cancel/unlockf on it */
 
-		/*
-		 * The lkb is now clear of all prior waiters state and can be
-		 * processed locally, or sent to remote node again, or directly
-		 * cancelled/unlocked.
-		 */
+static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
+{
+	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
+	int rv = -EBUSY;
 
-		if (oc || ou) {
-			/* do an unlock or cancel instead of resending */
-			switch (mstype) {
-			case DLM_MSG_LOOKUP:
-			case DLM_MSG_REQUEST:
-				queue_cast(r, lkb, ou ? -DLM_EUNLOCK :
-							-DLM_ECANCEL);
-				unhold_lkb(lkb); /* undoes create_lkb() */
-				break;
-			case DLM_MSG_CONVERT:
-				if (oc) {
-					queue_cast(r, lkb, -DLM_ECANCEL);
-				} else {
-					lkb->lkb_exflags |= DLM_LKF_FORCEUNLOCK;
-					_unlock_lock(r, lkb);
-				}
-				break;
-			default:
-				err = 1;
-			}
-		} else {
-			switch (mstype) {
-			case DLM_MSG_LOOKUP:
-			case DLM_MSG_REQUEST:
-				_request_lock(r, lkb);
-				if (r->res_nodeid != -1 && is_master(r))
-					confirm_master(r, 0);
-				break;
-			case DLM_MSG_CONVERT:
-				_convert_lock(r, lkb);
-				break;
-			default:
-				err = 1;
-			}
-		}
+	/* normal unlock not allowed if there's any op in progress */
+	if (!(args->flags & (DLM_LKF_CANCEL | DLM_LKF_FORCEUNLOCK)) &&
+	    (lkb->lkb_wait_type || lkb->lkb_wait_count))
+		goto out;
 
-		if (err) {
-			log_error(ls, "waiter %x msg %d r_nodeid %d "
-				  "dir_nodeid %d overlap %d %d",
-				  lkb->lkb_id, mstype, r->res_nodeid,
-				  dlm_dir_nodeid(r), oc, ou);
+	/* an lkb may be waiting for an rsb lookup to complete where the
+	   lookup was initiated by another lock */
+
+	if (!list_empty(&lkb->lkb_rsb_lookup)) {
+		if (args->flags & (DLM_LKF_CANCEL | DLM_LKF_FORCEUNLOCK)) {
+			log_debug(ls, "unlock on rsb_lookup %x", lkb->lkb_id);
+			list_del_init(&lkb->lkb_rsb_lookup);
+			queue_cast(lkb->lkb_resource, lkb,
+				   args->flags & DLM_LKF_CANCEL ?
+				   -DLM_ECANCEL : -DLM_EUNLOCK);
+			unhold_lkb(lkb); /* undoes create_lkb() */
 		}
-		unlock_rsb(r);
-		put_rsb(r);
-		dlm_put_lkb(lkb);
+		/* caller changes -EBUSY to 0 for CANCEL and FORCEUNLOCK */
+		goto out;
 	}
 
-	return error;
-}
+	rv = -EINVAL;
+	if (test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags)) {
+		log_error(ls, "unlock on MSTCPY %x", lkb->lkb_id);
+		dlm_print_lkb(lkb);
+		goto out;
+	}
 
-static void purge_mstcpy_list(struct dlm_ls *ls, struct dlm_rsb *r,
-			      struct list_head *list)
-{
-	struct dlm_lkb *lkb, *safe;
+	/* an lkb may still exist even though the lock is EOL'ed due to a
+	 * cancel, unlock or failed noqueue request; an app can't use these
+	 * locks; return same error as if the lkid had not been found at all
+	 */
 
-	list_for_each_entry_safe(lkb, safe, list, lkb_statequeue) {
-		if (!is_master_copy(lkb))
-			continue;
+	if (test_bit(DLM_IFL_ENDOFLIFE_BIT, &lkb->lkb_iflags)) {
+		log_debug(ls, "unlock on ENDOFLIFE %x", lkb->lkb_id);
+		rv = -ENOENT;
+		goto out;
+	}
 
-		/* don't purge lkbs we've added in recover_master_copy for
-		   the current recovery seq */
+	if (is_overlap_unlock(lkb))
+		goto out;
 
-		if (lkb->lkb_recover_seq == ls->ls_recover_seq)
-			continue;
+	/* cancel not allowed with another cancel/unlock in progress */
 
-		del_lkb(r, lkb);
+	if (args->flags & DLM_LKF_CANCEL) {
+		if (lkb->lkb_exflags & DLM_LKF_CANCEL)
+			goto out;
 
-		/* this put should free the lkb */
-		if (!dlm_put_lkb(lkb))
-			log_error(ls, "purged mstcpy lkb not released");
+		if (is_overlap_cancel(lkb))
+			goto out;
+
+		if (test_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags)) {
+			set_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
+			rv = -EBUSY;
+			goto out;
+		}
+
+		/* there's nothing to cancel */
+		if (lkb->lkb_status == DLM_LKSTS_GRANTED &&
+		    !lkb->lkb_wait_type) {
+			rv = -EBUSY;
+			goto out;
+		}
+
+		switch (lkb->lkb_wait_type) {
+		case DLM_MSG_LOOKUP:
+		case DLM_MSG_REQUEST:
+			set_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
+			rv = -EBUSY;
+			goto out;
+		case DLM_MSG_UNLOCK:
+		case DLM_MSG_CANCEL:
+			goto out;
+		}
+		/* add_to_waiters() will set OVERLAP_CANCEL */
+		goto out_ok;
 	}
-}
 
-void dlm_purge_mstcpy_locks(struct dlm_rsb *r)
-{
-	struct dlm_ls *ls = r->res_ls;
+	/* do we need to allow a force-unlock if there's a normal unlock
+	   already in progress?  in what conditions could the normal unlock
+	   fail such that we'd want to send a force-unlock to be sure? */
 
-	purge_mstcpy_list(ls, r, &r->res_grantqueue);
-	purge_mstcpy_list(ls, r, &r->res_convertqueue);
-	purge_mstcpy_list(ls, r, &r->res_waitqueue);
-}
+	if (args->flags & DLM_LKF_FORCEUNLOCK) {
+		if (lkb->lkb_exflags & DLM_LKF_FORCEUNLOCK)
+			goto out;
 
-static void purge_dead_list(struct dlm_ls *ls, struct dlm_rsb *r,
-			    struct list_head *list,
-			    int nodeid_gone, unsigned int *count)
-{
-	struct dlm_lkb *lkb, *safe;
+		if (test_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags)) {
+			set_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
+			rv = -EBUSY;
+			goto out;
+		}
 
-	list_for_each_entry_safe(lkb, safe, list, lkb_statequeue) {
-		if (!is_master_copy(lkb))
-			continue;
+		switch (lkb->lkb_wait_type) {
+		case DLM_MSG_LOOKUP:
+		case DLM_MSG_REQUEST:
+			set_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
+			rv = -EBUSY;
+			goto out;
+		case DLM_MSG_UNLOCK:
+			goto out;
+		}
+		/* add_to_waiters() will set OVERLAP_UNLOCK */
+	}
 
-		if ((lkb->lkb_nodeid == nodeid_gone) ||
-		    dlm_is_removed(ls, lkb->lkb_nodeid)) {
+ out_ok:
+	/* an overlapping op shouldn't blow away exflags from other op */
+	lkb->lkb_exflags |= args->flags;
+	dlm_set_sbflags_val(lkb, 0);
+	lkb->lkb_astparam = args->astparam;
+	rv = 0;
+ out:
+	switch (rv) {
+	case 0:
+		break;
+	case -EINVAL:
+		/* annoy the user because dlm usage is wrong */
+		WARN_ON(1);
+		log_error(ls, "%s %d %x %x %x %x %d %s", __func__, rv,
+			  lkb->lkb_id, dlm_iflags_val(lkb), lkb->lkb_exflags,
+			  args->flags, lkb->lkb_wait_type,
+			  lkb->lkb_resource->res_name);
+		break;
+	default:
+		log_debug(ls, "%s %d %x %x %x %x %d %s", __func__, rv,
+			  lkb->lkb_id, dlm_iflags_val(lkb), lkb->lkb_exflags,
+			  args->flags, lkb->lkb_wait_type,
+			  lkb->lkb_resource->res_name);
+		break;
+	}
 
-			/* tell recover_lvb to invalidate the lvb
-			   because a node holding EX/PW failed */
-			if ((lkb->lkb_exflags & DLM_LKF_VALBLK) &&
-			    (lkb->lkb_grmode >= DLM_LOCK_PW)) {
-				rsb_set_flag(r, RSB_RECOVER_LVB_INVAL);
-			}
+	return rv;
+}
 
-			del_lkb(r, lkb);
+/*
+ * Four stage 4 varieties:
+ * do_request(), do_convert(), do_unlock(), do_cancel()
+ * These are called on the master node for the given lock and
+ * from the central locking logic.
+ */
 
 			/* this put should free the lkb */
 			if (!dlm_put_lkb(lkb))
-- 
2.48.1


