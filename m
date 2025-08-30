Return-Path: <linux-kernel+bounces-792885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A6B3CA01
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B8B1C24398
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDB726D4D7;
	Sat, 30 Aug 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hU5D8nSV"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B962B270EC3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548873; cv=none; b=snKQ87EPHF0iMIcE9JGqvSI8cnfmtGf2eJc8JoFDQUx9ZGEZpSVb8Lh0wDv8MpV9oQL4CjDrdoLJICyqNjStVHF3+y3s/J2/pYxgtUKw1YmNi1hyV+ApgamALBg4iQMOt5I7pz9egmGLNRoS04nJ+vSnTbzYWIISNnah0bslCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548873; c=relaxed/simple;
	bh=LYB2SIuVBK9yXx6sK1vVssNgBZkxaHxhcpWPaITcvf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWp1NlSNzPCW7ZMbr1VjCMi4fVszOMrv3SD19EdMzp3Rvbxf78HHa4QmnBPa2Wv4yoBwdMLNUiERP9TvYQUvSSyPM2E2edABw1ycpEq6P6r44TdpYu9gPyw4GabRGw4kj7GjJJeocH/M3upgsJHrF1VPw0V05x9zj+zmFf7SUJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hU5D8nSV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c98b309804so1801336f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548868; x=1757153668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng0amTIpGwc98hysjAWa+JC2MWBcKOSSY1xPAfrAz+8=;
        b=hU5D8nSVxD/9VgkzHkBNmcMT7iFcPvb+xI+nIk6B0Whj1ZIoMM3x1pHO/AJ5pyGDbf
         N1mt7X45V0eSjGqN4ZxWN+ib53AzYM8rbr6oHD3CXlQKOgSArRvM+n0l63tS+zJ83oVu
         ZyVIqrlcvcUffbUh+uhMyVewF4HZjbslBDoi8gaE5xjn8hWChNbQIpqzp1HD+xYXKf0o
         7SgI0uACNzmNUctnwrCAY01gpXDpiTX+yABf1YSJZVOoF8SRiX3bcdNX2tRhLKQb8Zi4
         JNzqaKGWECXC3vOMMdO3GlSD03b3P5sD2tuEBNjuWT106U1+r7R0f07r+cDpyt5UTrx6
         vD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548868; x=1757153668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ng0amTIpGwc98hysjAWa+JC2MWBcKOSSY1xPAfrAz+8=;
        b=XiTQOsr8vaVQgZAXqaGsYzbyTYtOQrsEsJ4WNGWwX/yvOyHE1hC9zns8OmKxI1q2ho
         +7APF24jhI4EDvEbZ+bz4nHaOyTwptkAOXiHyE7Ge+1RwwD3hQY1APsqPTuH1hTj8Aiq
         Ijm8ZI8Ne8OyWrrShC3E+pGM9LDcW3TKLMmU36v4Xti8UM/m6uXBVTMa8f/P2P0cFbvK
         RMBuI4TBPCGzwL28zOGTvfRqm4NP/ayxX/mFpY4RrlZkq6vXe9wiP9k+zsnqm4Ow6XnH
         3A9I1OVJ0QhjCpUwC+1ZHXBF69XVxWRpzHCzP0jKTFgCqlJ3aUGflevFSudzpHe2plt0
         oInA==
X-Gm-Message-State: AOJu0YxBDpanM6qbwknzCKApNP6YrQkQgHqo+tnebpzTSKKvlHuyxih2
	FcfeaEHK5Wnkzw/OTangmWQMOiwc+ZPcqs9Mdps1xsEA4Jk5jaYO+tgE
X-Gm-Gg: ASbGnctkx+0xtPAhOIR3ZTMKaggbgQAunHRl0N/Jh4N1K5+SH1pny1eARkRvls3PlyS
	enwKX9iWipldt4vNIHPNP8dgKxDplpFuF4uDPFEsySw1j6zI5jXRklF7PPQlq0b9IMYOpxBZiZX
	7ffzf3cZOO2QlAKdssDPcbCuAlqNIN/fkouIjrpQ/Zhdh1VLOKjqKzwgsjD3ty5bHZlbKfySmZk
	Tc+8bdew8yIM4KReBWwUanhorIRnT5+8C+N+955oJ/xOUdE5GuvLGBnpYsBmcrpLOXENdlRNiFD
	r8QpOCqbMNGmsnzwG9NgDbAHpGQ/que0yWv7B4u7lB5lHAdWzdklzp805YhZ2lwCLo4Ce74ZgmP
	edUdGIuruond++wtjZeO+4Ate1H/10m130NUoXHcm/UW8GJiPMbvY6BdjfC5ZKynKkNn71eUe+v
	ikOEaVqidMcc5d8mQoj+I3SwIOZiY7U9PpDsr+FUSrW0QEU50kz6DMLhjuAAufyPvPQQH7i6rll
	nLvr2p3X6d6TbbQ5h0=
X-Google-Smtp-Source: AGHT+IFY4O9H/Bap0AakKyckTdcDIgKF7o3LzSf3oQQuFSVX94G6qMXMyDmLjEJ+JjqsK2O0loed4g==
X-Received: by 2002:a5d:64ec:0:b0:3d1:d24:ba56 with SMTP id ffacd0b85a97d-3d1dd52aa86mr1190800f8f.26.1756548867601;
        Sat, 30 Aug 2025 03:14:27 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:27 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 08/12] fix: improve lvb struct
Date: Sat, 30 Aug 2025 12:14:09 +0200
Message-ID: <20250830101413.602637-8-226562783+SigAttilio@users.noreply.github.com>
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
 fs/dlm/lock.c | 1096 +++++++++++++++++++++++++++++--------------------
 1 file changed, 641 insertions(+), 455 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 1eae9cdb4fcd..f7d3d154e2a9 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -3102,600 +3102,786 @@ static void del_scan(struct dlm_ls *ls, struct dlm_rsb *r)
 	spin_lock_bh(&ls->ls_scan_lock);
 	r->res_toss_time = 0;
 
-	error = create_message(r, lkb, to_nodeid, DLM_MSG_GRANT, &ms, &mh);
-	if (error)
+	/* if the rsb is not queued do nothing */
+	if (list_empty(&r->res_scan_list))
 		goto out;
 
-	send_args(r, lkb, ms);
-
-	ms->m_result = 0;
+	/* get the first element before delete */
+	first = list_first_entry(&ls->ls_scan_list, struct dlm_rsb,
+				 res_scan_list);
+	list_del_init(&r->res_scan_list);
+	/* check if the first element was the rsb we deleted */
+	if (first == r) {
+		/* try to get the new first element, if the list
+		 * is empty now try to delete the timer, if we are
+		 * too late we don't care.
+		 *
+		 * if the list isn't empty and a new first element got
+		 * in place, set the new timer expire time.
+		 */
+		first = list_first_entry_or_null(&ls->ls_scan_list, struct dlm_rsb,
+						 res_scan_list);
+		if (!first)
+			timer_delete(&ls->ls_scan_timer);
+		else
+			enable_scan_timer(ls, first->res_toss_time);
+	}
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
- out:
-	return error;
+out:
+	spin_unlock_bh(&ls->ls_scan_lock);
 }
 
-static int send_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int mode)
+static void add_scan(struct dlm_ls *ls, struct dlm_rsb *r)
 {
-	struct dlm_message *ms;
-	struct dlm_mhandle *mh;
-	int to_nodeid, error;
-
-	to_nodeid = lkb->lkb_nodeid;
+	int our_nodeid = dlm_our_nodeid();
+	struct dlm_rsb *first;
 
-	error = create_message(r, NULL, to_nodeid, DLM_MSG_BAST, &ms, &mh);
-	if (error)
-		goto out;
+	/* A dir record for a remote master rsb should never be on the scan list. */
+	WARN_ON(!dlm_no_directory(ls) &&
+		(r->res_master_nodeid != our_nodeid) &&
+		(dlm_dir_nodeid(r) == our_nodeid));
 
-	send_args(r, lkb, ms);
+	/* An active rsb should never be on the scan list. */
+	WARN_ON(!rsb_flag(r, RSB_INACTIVE));
 
-	ms->m_bastmode = cpu_to_le32(mode);
+	/* An rsb should not already be on the scan list. */
+	WARN_ON(!list_empty(&r->res_scan_list));
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
- out:
-	return error;
+	spin_lock_bh(&ls->ls_scan_lock);
+	/* set the new rsb absolute expire time in the rsb */
+	r->res_toss_time = rsb_toss_jiffies();
+	if (list_empty(&ls->ls_scan_list)) {
+		/* if the queue is empty add the element and it's
+		 * our new expire time
+		 */
+		list_add_tail(&r->res_scan_list, &ls->ls_scan_list);
+		enable_scan_timer(ls, r->res_toss_time);
+	} else {
+		/* try to get the maybe new first element and then add
+		 * to this rsb with the oldest expire time to the end
+		 * of the queue. If the list was empty before this
+		 * rsb expire time is our next expiration if it wasn't
+		 * the now new first elemet is our new expiration time
+		 */
+		first = list_first_entry_or_null(&ls->ls_scan_list, struct dlm_rsb,
+						 res_scan_list);
+		list_add_tail(&r->res_scan_list, &ls->ls_scan_list);
+		if (!first)
+			enable_scan_timer(ls, r->res_toss_time);
+		else
+			enable_scan_timer(ls, first->res_toss_time);
+	}
+	spin_unlock_bh(&ls->ls_scan_lock);
 }
 
-static int send_lookup(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	struct dlm_message *ms;
-	struct dlm_mhandle *mh;
-	int to_nodeid, error;
-
-	to_nodeid = dlm_dir_nodeid(r);
-
-	add_to_waiters(lkb, DLM_MSG_LOOKUP, to_nodeid);
-	error = create_message(r, NULL, to_nodeid, DLM_MSG_LOOKUP, &ms, &mh);
-	if (error)
-		goto fail;
-
-	send_args(r, lkb, ms);
-
-	error = send_message(mh, ms, r->res_name, r->res_length);
-	if (error)
-		goto fail;
-	return 0;
+/* if we hit contention we do in 250 ms a retry to trylock.
+ * if there is any other mod_timer in between we don't care
+ * about that it expires earlier again this is only for the
+ * unlikely case nothing happened in this time.
+ */
+#define DLM_TOSS_TIMER_RETRY	(jiffies + msecs_to_jiffies(250))
 
- fail:
-	remove_from_waiters(lkb, DLM_MSG_LOOKUP_REPLY);
-	return error;
-}
+/* Called by lockspace scan_timer to free unused rsb's. */
 
-static int send_remove(struct dlm_rsb *r)
+void dlm_rsb_scan(struct timer_list *timer)
 {
-	struct dlm_message *ms;
-	struct dlm_mhandle *mh;
-	int to_nodeid, error;
-
-	to_nodeid = dlm_dir_nodeid(r);
+	struct dlm_ls *ls = timer_container_of(ls, timer, ls_scan_timer);
+	int our_nodeid = dlm_our_nodeid();
+	struct dlm_rsb *r;
+	int rv;
 
-	error = create_message(r, NULL, to_nodeid, DLM_MSG_REMOVE, &ms, &mh);
-	if (error)
-		goto out;
+	while (1) {
+		/* interrupting point to leave iteration when
+		 * recovery waits for timer_delete_sync(), recovery
+		 * will take care to delete everything in scan list.
+		 */
+		if (dlm_locking_stopped(ls))
+			break;
 
-	memcpy(ms->m_extra, r->res_name, r->res_length);
-	ms->m_hash = cpu_to_le32(r->res_hash);
+		rv = spin_trylock(&ls->ls_scan_lock);
+		if (!rv) {
+			/* rearm again try timer */
+			enable_scan_timer(ls, DLM_TOSS_TIMER_RETRY);
+			break;
+		}
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
- out:
-	return error;
-}
+		r = list_first_entry_or_null(&ls->ls_scan_list, struct dlm_rsb,
+					     res_scan_list);
+		if (!r) {
+			/* the next add_scan will enable the timer again */
+			spin_unlock(&ls->ls_scan_lock);
+			break;
+		}
 
-static int send_common_reply(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			     int mstype, int rv)
-{
-	struct dlm_message *ms;
-	struct dlm_mhandle *mh;
-	int to_nodeid, error;
+		/*
+		 * If the first rsb is not yet expired, then stop because the
+		 * list is sorted with nearest expiration first.
+		 */
+		if (time_before(jiffies, r->res_toss_time)) {
+			/* rearm with the next rsb to expire in the future */
+			enable_scan_timer(ls, r->res_toss_time);
+			spin_unlock(&ls->ls_scan_lock);
+			break;
+		}
 
-	to_nodeid = lkb->lkb_nodeid;
+		/* in find_rsb_dir/nodir there is a reverse order of this
+		 * lock, however this is only a trylock if we hit some
+		 * possible contention we try it again.
+		 */
+		rv = write_trylock(&ls->ls_rsbtbl_lock);
+		if (!rv) {
+			spin_unlock(&ls->ls_scan_lock);
+			/* rearm again try timer */
+			enable_scan_timer(ls, DLM_TOSS_TIMER_RETRY);
+			break;
+		}
 
-	error = create_message(r, lkb, to_nodeid, mstype, &ms, &mh);
-	if (error)
-		goto out;
+		list_del(&r->res_slow_list);
+		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
+				       dlm_rhash_rsb_params);
+		rsb_clear_flag(r, RSB_HASHED);
 
-	send_args(r, lkb, ms);
+		/* ls_rsbtbl_lock is not needed when calling send_remove() */
+		write_unlock(&ls->ls_rsbtbl_lock);
 
-	ms->m_result = cpu_to_le32(to_dlm_errno(rv));
+		list_del_init(&r->res_scan_list);
+		spin_unlock(&ls->ls_scan_lock);
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
- out:
-	return error;
-}
+		/* An rsb that is a dir record for a remote master rsb
+		 * cannot be removed, and should not have a timer enabled.
+		 */
+		WARN_ON(!dlm_no_directory(ls) &&
+			(r->res_master_nodeid != our_nodeid) &&
+			(dlm_dir_nodeid(r) == our_nodeid));
 
-static int send_request_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
-{
-	return send_common_reply(r, lkb, DLM_MSG_REQUEST_REPLY, rv);
-}
+		/* We're the master of this rsb but we're not
+		 * the directory record, so we need to tell the
+		 * dir node to remove the dir record
+		 */
+		if (!dlm_no_directory(ls) &&
+		    (r->res_master_nodeid == our_nodeid) &&
+		    (dlm_dir_nodeid(r) != our_nodeid))
+			send_remove(r);
 
-static int send_convert_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
-{
-	return send_common_reply(r, lkb, DLM_MSG_CONVERT_REPLY, rv);
+		free_inactive_rsb(r);
+	}
 }
 
-static int send_unlock_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
-{
-	return send_common_reply(r, lkb, DLM_MSG_UNLOCK_REPLY, rv);
-}
+/* If ls->ls_new_rsb is empty, return -EAGAIN, so the caller can
+   unlock any spinlocks, go back and call pre_rsb_struct again.
+   Otherwise, take an rsb off the list and return it. */
 
-static int send_cancel_reply(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
+static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
+			  struct dlm_rsb **r_ret)
 {
-	return send_common_reply(r, lkb, DLM_MSG_CANCEL_REPLY, rv);
-}
+	struct dlm_rsb *r;
 
-static int send_lookup_reply(struct dlm_ls *ls,
-			     const struct dlm_message *ms_in, int ret_nodeid,
-			     int rv)
-{
-	struct dlm_rsb *r = &ls->ls_local_rsb;
-	struct dlm_message *ms;
-	struct dlm_mhandle *mh;
-	int error, nodeid = le32_to_cpu(ms_in->m_header.h_nodeid);
+	r = dlm_allocate_rsb();
+	if (!r)
+		return -ENOMEM;
 
-	error = create_message(r, NULL, nodeid, DLM_MSG_LOOKUP_REPLY, &ms, &mh);
-	if (error)
-		goto out;
+	r->res_ls = ls;
+	r->res_length = len;
+	memcpy(r->res_name, name, len);
+	spin_lock_init(&r->res_lock);
 
-	ms->m_lkid = ms_in->m_lkid;
-	ms->m_result = cpu_to_le32(to_dlm_errno(rv));
-	ms->m_nodeid = cpu_to_le32(ret_nodeid);
+	INIT_LIST_HEAD(&r->res_lookup);
+	INIT_LIST_HEAD(&r->res_grantqueue);
+	INIT_LIST_HEAD(&r->res_convertqueue);
+	INIT_LIST_HEAD(&r->res_waitqueue);
+	INIT_LIST_HEAD(&r->res_root_list);
+	INIT_LIST_HEAD(&r->res_scan_list);
+	INIT_LIST_HEAD(&r->res_recover_list);
+	INIT_LIST_HEAD(&r->res_masters_list);
 
-	error = send_message(mh, ms, ms_in->m_extra, receive_extralen(ms_in));
- out:
-	return error;
+	*r_ret = r;
+	return 0;
 }
 
-/* which args we save from a received message depends heavily on the type
-   of message, unlike the send side where we can safely send everything about
-   the lkb for any type of message */
-
-static void receive_flags(struct dlm_lkb *lkb, const struct dlm_message *ms)
+int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
+			struct dlm_rsb **r_ret)
 {
-	lkb->lkb_exflags = le32_to_cpu(ms->m_exflags);
-	dlm_set_sbflags_val(lkb, le32_to_cpu(ms->m_sbflags));
-	dlm_set_dflags_val(lkb, le32_to_cpu(ms->m_flags));
-}
+	char key[DLM_RESNAME_MAXLEN] = {};
 
-static void receive_flags_reply(struct dlm_lkb *lkb,
-				const struct dlm_message *ms,
-				bool local)
-{
-	if (local)
-		return;
+	memcpy(key, name, len);
+	*r_ret = rhashtable_lookup_fast(rhash, &key, dlm_rhash_rsb_params);
+	if (*r_ret)
+		return 0;
 
-	dlm_set_sbflags_val(lkb, le32_to_cpu(ms->m_sbflags));
-	dlm_set_dflags_val(lkb, le32_to_cpu(ms->m_flags));
+	return -EBADR;
 }
 
-static int receive_extralen(const struct dlm_message *ms)
+static int rsb_insert(struct dlm_rsb *rsb, struct rhashtable *rhash)
 {
-	return (le16_to_cpu(ms->m_header.h_length) -
-		sizeof(struct dlm_message));
-}
+	int rv;
 
-static int receive_lvb(struct dlm_ls *ls, struct dlm_lkb *lkb,
-		       const struct dlm_message *ms)
-{
-	int len;
+	rv = rhashtable_insert_fast(rhash, &rsb->res_node,
+				    dlm_rhash_rsb_params);
+	if (!rv)
+		rsb_set_flag(rsb, RSB_HASHED);
 
-	if (lkb->lkb_exflags & DLM_LKF_VALBLK) {
-		if (!lkb->lkb_lvbptr)
-			lkb->lkb_lvbptr = dlm_allocate_lvb(ls);
-		if (!lkb->lkb_lvbptr)
-			return -ENOMEM;
-		len = receive_extralen(ms);
-		if (len > ls->ls_lvblen)
-			len = ls->ls_lvblen;
-		memcpy(lkb->lkb_lvbptr, ms->m_extra, len);
-	}
-	return 0;
+	return rv;
 }
 
-static void fake_bastfn(void *astparam, int mode)
-{
-	log_print("fake_bastfn should not be called");
-}
+/*
+ * Find rsb in rsbtbl and potentially create/add one
+ *
+ * Delaying the release of rsb's has a similar benefit to applications keeping
+ * NL locks on an rsb, but without the guarantee that the cached master value
+ * will still be valid when the rsb is reused.  Apps aren't always smart enough
+ * to keep NL locks on an rsb that they may lock again shortly; this can lead
+ * to excessive master lookups and removals if we don't delay the release.
+ *
+ * Searching for an rsb means looking through both the normal list and toss
+ * list.  When found on the toss list the rsb is moved to the normal list with
+ * ref count of 1; when found on normal list the ref count is incremented.
+ *
+ * rsb's on the keep list are being used locally and refcounted.
+ * rsb's on the toss list are not being used locally, and are not refcounted.
+ *
+ * The toss list rsb's were either
+ * - previously used locally but not any more (were on keep list, then
+ *   moved to toss list when last refcount dropped)
+ * - created and put on toss list as a directory record for a lookup
+ *   (we are the dir node for the res, but are not using the res right now,
+ *   but some other node is)
+ *
+ * The purpose of find_rsb() is to return a refcounted rsb for local use.
+ * So, if the given rsb is on the toss list, it is moved to the keep list
+ * before being returned.
+ *
+ * deactivate_rsb() happens when all local usage of the rsb is done, i.e. no
+ * more refcounts exist, so the rsb is moved from the keep list to the
+ * toss list.
+ *
+ * rsb's on both keep and toss lists are used for doing a name to master
+ * lookups.  rsb's that are in use locally (and being refcounted) are on
+ * the keep list, rsb's that are not in use locally (not refcounted) and
+ * only exist for name/master lookups are on the toss list.
+ *
+ * rsb's on the toss list who's dir_nodeid is not local can have stale
+ * name/master mappings.  So, remote requests on such rsb's can potentially
+ * return with an error, which means the mapping is stale and needs to
+ * be updated with a new lookup.  (The idea behind MASTER UNCERTAIN and
+ * first_lkid is to keep only a single outstanding request on an rsb
+ * while that rsb has a potentially stale master.)
+ */
 
-static void fake_astfn(void *astparam)
+static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
+			uint32_t hash, int dir_nodeid, int from_nodeid,
+			unsigned int flags, struct dlm_rsb **r_ret)
 {
-	log_print("fake_astfn should not be called");
-}
+	struct dlm_rsb *r = NULL;
+	int our_nodeid = dlm_our_nodeid();
+	int from_local = 0;
+	int from_other = 0;
+	int from_dir = 0;
+	int create = 0;
+	int error;
 
-static int receive_request_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
-				const struct dlm_message *ms)
-{
-	lkb->lkb_nodeid = le32_to_cpu(ms->m_header.h_nodeid);
-	lkb->lkb_ownpid = le32_to_cpu(ms->m_pid);
-	lkb->lkb_remid = le32_to_cpu(ms->m_lkid);
-	lkb->lkb_grmode = DLM_LOCK_IV;
-	lkb->lkb_rqmode = le32_to_cpu(ms->m_rqmode);
+	if (flags & R_RECEIVE_REQUEST) {
+		if (from_nodeid == dir_nodeid)
+			from_dir = 1;
+		else
+			from_other = 1;
+	} else if (flags & R_REQUEST) {
+		from_local = 1;
+	}
 
-	lkb->lkb_bastfn = (ms->m_asts & cpu_to_le32(DLM_CB_BAST)) ? &fake_bastfn : NULL;
-	lkb->lkb_astfn = (ms->m_asts & cpu_to_le32(DLM_CB_CAST)) ? &fake_astfn : NULL;
+	/*
+	 * flags & R_RECEIVE_RECOVER is from dlm_recover_master_copy, so
+	 * from_nodeid has sent us a lock in dlm_recover_locks, believing
+	 * we're the new master.  Our local recovery may not have set
+	 * res_master_nodeid to our_nodeid yet, so allow either.  Don't
+	 * create the rsb; dlm_recover_process_copy() will handle EBADR
+	 * by resending.
+	 *
+	 * If someone sends us a request, we are the dir node, and we do
+	 * not find the rsb anywhere, then recreate it.  This happens if
+	 * someone sends us a request after we have removed/freed an rsb.
+	 * (They sent a request instead of lookup because they are using
+	 * an rsb taken from their scan list.)
+	 */
 
-	if (lkb->lkb_exflags & DLM_LKF_VALBLK) {
-		/* lkb was just created so there won't be an lvb yet */
-		lkb->lkb_lvbptr = dlm_allocate_lvb(ls);
-		if (!lkb->lkb_lvbptr)
-			return -ENOMEM;
+	if (from_local || from_dir ||
+	    (from_other && (dir_nodeid == our_nodeid))) {
+		create = 1;
 	}
 
-	return 0;
-}
-
-static int receive_convert_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
-				const struct dlm_message *ms)
-{
-	if (lkb->lkb_status != DLM_LKSTS_GRANTED)
-		return -EBUSY;
+ retry:
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (error)
+		goto do_new;
 
-	if (receive_lvb(ls, lkb, ms))
-		return -ENOMEM;
+	/* check if the rsb is active under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
+	if (!rsb_flag(r, RSB_HASHED)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -EBADR;
+		goto do_new;
+	}
 
-	lkb->lkb_rqmode = le32_to_cpu(ms->m_rqmode);
-	lkb->lkb_lvbseq = le32_to_cpu(ms->m_lvbseq);
+	/*
+	 * rsb is active, so we can't check master_nodeid without lock_rsb.
+	 */
 
-	return 0;
-}
+	if (rsb_flag(r, RSB_INACTIVE)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_inactive;
+	}
 
-static int receive_unlock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
-			       const struct dlm_message *ms)
-{
-	if (receive_lvb(ls, lkb, ms))
-		return -ENOMEM;
-	return 0;
-}
+	kref_get(&r->res_ref);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
+	goto out;
 
-/* We fill in the local-lkb fields with the info that send_xxxx_reply()
-   uses to send a reply and that the remote end uses to process the reply. */
 
-static void setup_local_lkb(struct dlm_ls *ls, const struct dlm_message *ms)
-{
-	struct dlm_lkb *lkb = &ls->ls_local_lkb;
-	lkb->lkb_nodeid = le32_to_cpu(ms->m_header.h_nodeid);
-	lkb->lkb_remid = le32_to_cpu(ms->m_lkid);
-}
+ do_inactive:
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 
-/* This is called after the rsb is locked so that we can safely inspect
-   fields in the lkb. */
+	/*
+	 * The expectation here is that the rsb will have HASHED and
+	 * INACTIVE flags set, and that the rsb can be moved from
+	 * inactive back to active again.  However, between releasing
+	 * the read lock and acquiring the write lock, this rsb could
+	 * have been removed from rsbtbl, and had HASHED cleared, to
+	 * be freed.  To deal with this case, we would normally need
+	 * to repeat dlm_search_rsb_tree while holding the write lock,
+	 * but rcu allows us to simply check the HASHED flag, because
+	 * the rcu read lock means the rsb will not be freed yet.
+	 * If the HASHED flag is not set, then the rsb is being freed,
+	 * so we add a new rsb struct.  If the HASHED flag is set,
+	 * and INACTIVE is not set, it means another thread has
+	 * made the rsb active, as we're expecting to do here, and
+	 * we just repeat the lookup (this will be very unlikely.)
+	 */
+	if (rsb_flag(r, RSB_HASHED)) {
+		if (!rsb_flag(r, RSB_INACTIVE)) {
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
+			goto retry;
+		}
+	} else {
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -EBADR;
+		goto do_new;
+	}
 
-static int validate_message(struct dlm_lkb *lkb, const struct dlm_message *ms)
-{
-	int from = le32_to_cpu(ms->m_header.h_nodeid);
-	int error = 0;
+	/*
+	 * rsb found inactive (master_nodeid may be out of date unless
+	 * we are the dir_nodeid or were the master)  No other thread
+	 * is using this rsb because it's inactive, so we can
+	 * look at or update res_master_nodeid without lock_rsb.
+	 */
 
-	/* currently mixing of user/kernel locks are not supported */
-	if (ms->m_flags & cpu_to_le32(BIT(DLM_DFL_USER_BIT)) &&
-	    !test_bit(DLM_DFL_USER_BIT, &lkb->lkb_dflags)) {
-		log_error(lkb->lkb_resource->res_ls,
-			  "got user dlm message for a kernel lock");
-		error = -EINVAL;
+	if ((r->res_master_nodeid != our_nodeid) && from_other) {
+		/* our rsb was not master, and another node (not the dir node)
+		   has sent us a request */
+		log_debug(ls, "find_rsb inactive from_other %d master %d dir %d %s",
+			  from_nodeid, r->res_master_nodeid, dir_nodeid,
+			  r->res_name);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -ENOTBLK;
 		goto out;
 	}
 
-	switch (ms->m_type) {
-	case cpu_to_le32(DLM_MSG_CONVERT):
-	case cpu_to_le32(DLM_MSG_UNLOCK):
-	case cpu_to_le32(DLM_MSG_CANCEL):
-		if (!is_master_copy(lkb) || lkb->lkb_nodeid != from)
-			error = -EINVAL;
-		break;
+	if ((r->res_master_nodeid != our_nodeid) && from_dir) {
+		/* don't think this should ever happen */
+		log_error(ls, "find_rsb inactive from_dir %d master %d",
+			  from_nodeid, r->res_master_nodeid);
+		dlm_print_rsb(r);
+		/* fix it and go on */
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		rsb_clear_flag(r, RSB_MASTER_UNCERTAIN);
+		r->res_first_lkid = 0;
+	}
 
-	case cpu_to_le32(DLM_MSG_CONVERT_REPLY):
-	case cpu_to_le32(DLM_MSG_UNLOCK_REPLY):
-	case cpu_to_le32(DLM_MSG_CANCEL_REPLY):
-	case cpu_to_le32(DLM_MSG_GRANT):
-	case cpu_to_le32(DLM_MSG_BAST):
-		if (!is_process_copy(lkb) || lkb->lkb_nodeid != from)
-			error = -EINVAL;
-		break;
+	if (from_local && (r->res_master_nodeid != our_nodeid)) {
+		/* Because we have held no locks on this rsb,
+		   res_master_nodeid could have become stale. */
+		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
+		r->res_first_lkid = 0;
+	}
+
+	/* we always deactivate scan timer for the rsb, when
+	 * we move it out of the inactive state as rsb state
+	 * can be changed and scan timers are only for inactive
+	 * rsbs.
+	 */
+	del_scan(ls, r);
+	list_move(&r->res_slow_list, &ls->ls_slow_active);
+	rsb_clear_flag(r, RSB_INACTIVE);
+	kref_init(&r->res_ref); /* ref is now used in active state */
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	case cpu_to_le32(DLM_MSG_REQUEST_REPLY):
-		if (!is_process_copy(lkb))
-			error = -EINVAL;
-		else if (lkb->lkb_nodeid != -1 && lkb->lkb_nodeid != from)
-			error = -EINVAL;
-		break;
+	goto out;
 
-	default:
-		error = -EINVAL;
-	}
 
-out:
-	if (error)
-		log_error(lkb->lkb_resource->res_ls,
-			  "ignore invalid message %d from %d %x %x %x %d",
-			  le32_to_cpu(ms->m_type), from, lkb->lkb_id,
-			  lkb->lkb_remid, dlm_iflags_val(lkb),
-			  lkb->lkb_nodeid);
-	return error;
-}
+ do_new:
+	/*
+	 * rsb not found
+	 */
 
-static int receive_request(struct dlm_ls *ls, const struct dlm_message *ms)
-{
-	struct dlm_lkb *lkb;
-	struct dlm_rsb *r;
-	int from_nodeid;
-	int error, namelen = 0;
+	if (error == -EBADR && !create)
+		goto out;
 
-	from_nodeid = le32_to_cpu(ms->m_header.h_nodeid);
+	error = get_rsb_struct(ls, name, len, &r);
+	if (WARN_ON_ONCE(error))
+		goto out;
 
-	error = create_lkb(ls, &lkb);
-	if (error)
-		goto fail;
+	r->res_hash = hash;
+	r->res_dir_nodeid = dir_nodeid;
+	kref_init(&r->res_ref);
 
-	receive_flags(lkb, ms);
-	set_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags);
-	error = receive_request_args(ls, lkb, ms);
-	if (error) {
-		__put_lkb(ls, lkb);
-		goto fail;
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
 	}
 
-	/* The dir node is the authority on whether we are the master
-	   for this rsb or not, so if the master sends us a request, we should
-	   recreate the rsb if we've destroyed it.   This race happens when we
-	   send a remove message to the dir node at the same time that the dir
-	   node sends us a request for the rsb. */
-
-	namelen = receive_extralen(ms);
-
-	error = find_rsb(ls, ms->m_extra, namelen, from_nodeid,
-			 R_RECEIVE_REQUEST, &r);
-	if (error) {
-		__put_lkb(ls, lkb);
-		goto fail;
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
+		goto out;
 	}
 
-	lock_rsb(r);
-
-	if (r->res_master_nodeid != dlm_our_nodeid()) {
-		error = validate_master_nodeid(ls, r, from_nodeid);
-		if (error) {
-			unlock_rsb(r);
-			put_rsb(r);
-			__put_lkb(ls, lkb);
-			goto fail;
-		}
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
 	}
 
-	attach_lkb(r, lkb);
-	error = do_request(r, lkb);
-	send_request_reply(r, lkb, error);
-	do_request_effects(r, lkb, error);
-
-	unlock_rsb(r);
-	put_rsb(r);
-
-	if (error == -EINPROGRESS)
-		error = 0;
-	if (error)
-		dlm_put_lkb(lkb);
-	return 0;
+	if (dir_nodeid == our_nodeid) {
+		/* When we are the dir nodeid, we can set the master
+		   node immediately */
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+	} else {
+		/* set_master will send_lookup to dir_nodeid */
+		r->res_master_nodeid = 0;
+		r->res_nodeid = -1;
+	}
 
- fail:
-	/* TODO: instead of returning ENOTBLK, add the lkb to res_lookup
-	   and do this receive_request again from process_lookup_list once
-	   we get the lookup reply.  This would avoid a many repeated
-	   ENOTBLK request failures when the lookup reply designating us
-	   as master is delayed. */
+ out_add:
 
-	if (error != -ENOTBLK) {
-		log_limit(ls, "receive_request %x from %d %d",
-			  le32_to_cpu(ms->m_lkid), from_nodeid, error);
+	write_lock_bh(&ls->ls_rsbtbl_lock);
+	error = rsb_insert(r, &ls->ls_rsbtbl);
+	if (error == -EEXIST) {
+		/* somebody else was faster and it seems the
+		 * rsb exists now, we do a whole relookup
+		 */
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		dlm_free_rsb(r);
+		goto retry;
+	} else if (!error) {
+		list_add(&r->res_slow_list, &ls->ls_slow_active);
 	}
-
-	setup_local_lkb(ls, ms);
-	send_request_reply(&ls->ls_local_rsb, &ls->ls_local_lkb, error);
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
+ out:
+	*r_ret = r;
 	return error;
 }
 
-static int receive_convert(struct dlm_ls *ls, const struct dlm_message *ms)
+/* FIXME: if this lkb is the only lock we hold on the rsb, then set
+   MASTER_UNCERTAIN to force the next request on the rsb to confirm
+   that the master is still correct. */
+
+static int send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_lkb *lkb;
-	struct dlm_rsb *r;
-	int error, reply = 1;
+	int rv;
+	bool only = true;
+	struct dlm_lkb *iter;
+
+	/* Caller should hold lock_rsb(r) when invoking send_unlock(); it's
+	 * therefore safe to inspect the rsb queues without additional locking.
+	 * If this lkb is the only locally-held lock on the rsb, mark the
+	 * master as uncertain so a subsequent request will reconfirm the
+	 * master via lookup.
+	 */
 
-	error = find_lkb(ls, le32_to_cpu(ms->m_remid), &lkb);
-	if (error)
-		goto fail;
+	/* Check grant queue for any other lkbs */
+	list_for_each_entry(iter, &r->res_grantqueue, lkb_statequeue) {
+		if (iter != lkb) {
+			only = false;
+			break;
+		}
+	}
 
-	if (lkb->lkb_remid != le32_to_cpu(ms->m_lkid)) {
-		log_error(ls, "receive_convert %x remid %x recover_seq %llu "
-			  "remote %d %x", lkb->lkb_id, lkb->lkb_remid,
-			  (unsigned long long)lkb->lkb_recover_seq,
-			  le32_to_cpu(ms->m_header.h_nodeid),
-			  le32_to_cpu(ms->m_lkid));
-		error = -ENOENT;
-		dlm_put_lkb(lkb);
-		goto fail;
+	/* Check convert queue if still only */
+	if (only) {
+		list_for_each_entry(iter, &r->res_convertqueue, lkb_statequeue) {
+			if (iter != lkb) {
+				only = false;
+				break;
+			}
+		}
 	}
 
-	r = lkb->lkb_resource;
+	/* Check wait queue if still only */
+	if (only) {
+		list_for_each_entry(iter, &r->res_waitqueue, lkb_statequeue) {
+			if (iter != lkb) {
+				only = false;
+				break;
+			}
+		}
+	}
 
-	hold_rsb(r);
-	lock_rsb(r);
+	if (only)
+		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
 
-	error = validate_message(lkb, ms);
-	if (error)
-		goto out;
+	rv = send_common(r, lkb, DLM_MSG_UNLOCK);
+	return rv;
+}
 
-	receive_flags(lkb, ms);
+/* add/remove lkb to rsb's grant/convert/wait queue */
 
-	error = receive_convert_args(ls, lkb, ms);
-	if (error) {
-		send_convert_reply(r, lkb, error);
-		goto out;
-	}
+static void add_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int status)
+{
+	kref_get(&lkb->lkb_ref);
 
-	reply = !down_conversion(lkb);
+	DLM_ASSERT(!lkb->lkb_status, dlm_print_lkb(lkb););
 
-	error = do_convert(r, lkb);
-	if (reply)
-		send_convert_reply(r, lkb, error);
-	do_convert_effects(r, lkb, error);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	dlm_put_lkb(lkb);
-	return 0;
+	lkb->lkb_timestamp = ktime_get();
 
- fail:
-	setup_local_lkb(ls, ms);
-	send_convert_reply(&ls->ls_local_rsb, &ls->ls_local_lkb, error);
-	return error;
+	lkb->lkb_status = status;
+
+	switch (status) {
+	case DLM_LKSTS_WAITING:
+		if (lkb->lkb_exflags & DLM_LKF_HEADQUE)
+			list_add(&lkb->lkb_statequeue, &r->res_waitqueue);
+		else
+			list_add_tail(&lkb->lkb_statequeue, &r->res_waitqueue);
+		break;
+	case DLM_LKSTS_GRANTED:
+		/* convention says granted locks kept in order of grmode */
+		lkb_add_ordered(&lkb->lkb_statequeue, &r->res_grantqueue,
+				lkb->lkb_grmode);
+		break;
+	case DLM_LKSTS_CONVERT:
+		if (lkb->lkb_exflags & DLM_LKF_HEADQUE)
+			list_add(&lkb->lkb_statequeue, &r->res_convertqueue);
+		else
+			list_add_tail(&lkb->lkb_statequeue,
+				      &r->res_convertqueue);
+		break;
+	default:
+		DLM_ASSERT(0, dlm_print_lkb(lkb); printk("sts=%d\n", status););
+	}
 }
 
-static int receive_unlock(struct dlm_ls *ls, const struct dlm_message *ms)
+static void del_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_lkb *lkb;
-	struct dlm_rsb *r;
-	int error;
+	lkb->lkb_status = 0;
+	list_del(&lkb->lkb_statequeue);
+	unhold_lkb(lkb);
+}
 
-	error = find_lkb(ls, le32_to_cpu(ms->m_remid), &lkb);
-	if (error)
-		goto fail;
+static void move_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int sts)
+{
+	del_lkb(r, lkb);
+	add_lkb(r, lkb, sts);
+}
 
-	if (lkb->lkb_remid != le32_to_cpu(ms->m_lkid)) {
-		log_error(ls, "receive_unlock %x remid %x remote %d %x",
-			  lkb->lkb_id, lkb->lkb_remid,
-			  le32_to_cpu(ms->m_header.h_nodeid),
-			  le32_to_cpu(ms->m_lkid));
-		error = -ENOENT;
-		dlm_put_lkb(lkb);
-		goto fail;
+static int msg_reply_type(int mstype)
+{
+	switch (mstype) {
+	case DLM_MSG_REQUEST:
+		return DLM_MSG_REQUEST_REPLY;
+	case DLM_MSG_CONVERT:
+		return DLM_MSG_CONVERT_REPLY;
+	case DLM_MSG_UNLOCK:
+		return DLM_MSG_UNLOCK_REPLY;
+	case DLM_MSG_CANCEL:
+		return DLM_MSG_CANCEL_REPLY;
+	case DLM_MSG_LOOKUP:
+		return DLM_MSG_LOOKUP_REPLY;
 	}
+	return -1;
+}
 
-	r = lkb->lkb_resource;
-
-	hold_rsb(r);
-	lock_rsb(r);
+/* add/remove lkb from global waiters list of lkb's waiting for
+   a reply from a remote node */
 
-	error = validate_message(lkb, ms);
-	if (error)
-		goto out;
+static void add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
+{
+	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 
-	receive_flags(lkb, ms);
+	spin_lock_bh(&ls->ls_waiters_lock);
+	if (lkb->lkb_wait_type || is_overlap_cancel(lkb)) {
+		switch (mstype) {
+		case DLM_MSG_UNLOCK:
+			set_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
+			break;
+		case DLM_MSG_CANCEL:
+			set_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
+			break;
+		default:
+			/* should never happen as validate_lock_args() checks
+			 * on lkb_wait_type and validate_unlock_args() only
+			 * creates UNLOCK or CANCEL messages.
+			 */
+			WARN_ON_ONCE(1);
+			goto out;
+		}
+		lkb->lkb_wait_count++;
+		hold_lkb(lkb);
 
-	error = receive_unlock_args(ls, lkb, ms);
-	if (error) {
-		send_unlock_reply(r, lkb, error);
+		log_debug(ls, "addwait %x cur %d overlap %d count %d f %x",
+			  lkb->lkb_id, lkb->lkb_wait_type, mstype,
+			  lkb->lkb_wait_count, dlm_iflags_val(lkb));
 		goto out;
 	}
 
-	error = do_unlock(r, lkb);
-	send_unlock_reply(r, lkb, error);
-	do_unlock_effects(r, lkb, error);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	dlm_put_lkb(lkb);
-	return 0;
+	DLM_ASSERT(!lkb->lkb_wait_count,
+		   dlm_print_lkb(lkb);
+		   printk("wait_count %d\n", lkb->lkb_wait_count););
 
- fail:
-	setup_local_lkb(ls, ms);
-	send_unlock_reply(&ls->ls_local_rsb, &ls->ls_local_lkb, error);
-	return error;
+	lkb->lkb_wait_count++;
+	lkb->lkb_wait_type = mstype;
+	lkb->lkb_wait_nodeid = to_nodeid; /* for debugging */
+	hold_lkb(lkb);
+	list_add(&lkb->lkb_wait_reply, &ls->ls_waiters);
+ out:
+	spin_unlock_bh(&ls->ls_waiters_lock);
 }
 
-static int receive_cancel(struct dlm_ls *ls, const struct dlm_message *ms)
+/* We clear the RESEND flag because we might be taking an lkb off the waiters
+   list as part of process_requestqueue (e.g. a lookup that has an optimized
+   request reply on the requestqueue) between dlm_recover_waiters_pre() which
+   set RESEND and dlm_recover_waiters_post() */
+
+static int _remove_from_waiters(struct dlm_lkb *lkb, int mstype,
+				const struct dlm_message *ms)
 {
-	struct dlm_lkb *lkb;
-	struct dlm_rsb *r;
-	int error;
+	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
+	int overlap_done = 0;
 
-	error = find_lkb(ls, le32_to_cpu(ms->m_remid), &lkb);
-	if (error)
-		goto fail;
+	if (mstype == DLM_MSG_UNLOCK_REPLY &&
+	    test_and_clear_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags)) {
+		log_debug(ls, "remwait %x unlock_reply overlap", lkb->lkb_id);
+		overlap_done = 1;
+		goto out_del;
+	}
 
-	receive_flags(lkb, ms);
+	if (mstype == DLM_MSG_CANCEL_REPLY &&
+	    test_and_clear_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags)) {
+		log_debug(ls, "remwait %x cancel_reply overlap", lkb->lkb_id);
+		overlap_done = 1;
+		goto out_del;
+	}
 
-	r = lkb->lkb_resource;
+	/* Cancel state was preemptively cleared by a successful convert,
+	   see next comment, nothing to do. */
 
-	hold_rsb(r);
-	lock_rsb(r);
+	if ((mstype == DLM_MSG_CANCEL_REPLY) &&
+	    (lkb->lkb_wait_type != DLM_MSG_CANCEL)) {
+		log_debug(ls, "remwait %x cancel_reply wait_type %d",
+			  lkb->lkb_id, lkb->lkb_wait_type);
+		return -1;
+	}
 
-	error = validate_message(lkb, ms);
-	if (error)
-		goto out;
+	/* Remove for the convert reply, and premptively remove for the
+	   cancel reply.  A convert has been granted while there's still
+	   an outstanding cancel on it (the cancel is moot and the result
+	   in the cancel reply should be 0).  We preempt the cancel reply
+	   because the app gets the convert result and then can follow up
+	   with another op, like convert.  This subsequent op would see the
+	   lingering state of the cancel and fail with -EBUSY. */
 
-	error = do_cancel(r, lkb);
-	send_cancel_reply(r, lkb, error);
-	do_cancel_effects(r, lkb, error);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	dlm_put_lkb(lkb);
-	return 0;
+	if ((mstype == DLM_MSG_CONVERT_REPLY) &&
+	    (lkb->lkb_wait_type == DLM_MSG_CONVERT) && ms && !ms->m_result &&
+	    test_and_clear_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags)) {
+		log_debug(ls, "remwait %x convert_reply zap overlap_cancel",
+			  lkb->lkb_id);
+		lkb->lkb_wait_type = 0;
+		lkb->lkb_wait_count--;
+		unhold_lkb(lkb);
+		goto out_del;
+	}
 
- fail:
-	setup_local_lkb(ls, ms);
-	send_cancel_reply(&ls->ls_local_rsb, &ls->ls_local_lkb, error);
-	return error;
-}
+	/* N.B. type of reply may not always correspond to type of original
+	   msg due to lookup->request optimization, verify others? */
 
-static int receive_grant(struct dlm_ls *ls, const struct dlm_message *ms)
-{
-	struct dlm_lkb *lkb;
-	struct dlm_rsb *r;
-	int error;
+	if (lkb->lkb_wait_type) {
+		lkb->lkb_wait_type = 0;
+		goto out_del;
+	}
 
-	error = find_lkb(ls, le32_to_cpu(ms->m_remid), &lkb);
-	if (error)
-		return error;
+	log_error(ls, "remwait error %x remote %d %x msg %d flags %x no wait",
+		  lkb->lkb_id, ms ? le32_to_cpu(ms->m_header.h_nodeid) : 0,
+		  lkb->lkb_remid, mstype, dlm_iflags_val(lkb));
+	return -1;
 
-	r = lkb->lkb_resource;
+ out_del:
+	/* the force-unlock/cancel has completed and we haven't received a reply
+	   to the op that was in progress prior to the unlock/cancel; we
+	   give up on any reply to the earlier op.
+	   NOTE: not sure when/how this would happen */
 
-	hold_rsb(r);
-	lock_rsb(r);
+	if (overlap_done && lkb->lkb_wait_type) {
+		log_error(ls, "remwait error %x reply %d wait_type %d overlap",
+			  lkb->lkb_id, mstype, lkb->lkb_wait_type);
+		lkb->lkb_wait_count--;
+		unhold_lkb(lkb);
+		lkb->lkb_wait_type = 0;
+	}
 
-	error = validate_message(lkb, ms);
-	if (error)
-		goto out;
+	DLM_ASSERT(lkb->lkb_wait_count, dlm_print_lkb(lkb););
 
-	receive_flags_reply(lkb, ms, false);
-	if (is_altmode(lkb))
-		munge_altmode(lkb, ms);
-	grant_lock_pc(r, lkb, ms);
-	queue_cast(r, lkb, 0);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	dlm_put_lkb(lkb);
+	clear_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
+	lkb->lkb_wait_count--;
+	if (!lkb->lkb_wait_count)
+		list_del_init(&lkb->lkb_wait_reply);
+	unhold_lkb(lkb);
 	return 0;
 }
 
-static int receive_bast(struct dlm_ls *ls, const struct dlm_message *ms)
+static int remove_from_waiters(struct dlm_lkb *lkb, int mstype)
 {
-	struct dlm_lkb *lkb;
-	struct dlm_rsb *r;
+	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
 	int error;
 
-	error = find_lkb(ls, le32_to_cpu(ms->m_remid), &lkb);
-	if (error)
-		return error;
-
-	r = lkb->lkb_resource;
+	spin_lock_bh(&ls->ls_waiters_lock);
+	error = _remove_from_waiters(lkb, mstype, NULL);
+	spin_unlock_bh(&ls->ls_waiters_lock);
+	return error;
+}
 
-	hold_rsb(r);
-	lock_rsb(r);
+/* Handles situations where we might be processing a "fake" or "local" reply in
+ * the recovery context which stops any locking activity. Only debugfs might
+ * change the lockspace waiters but they will held the recovery lock to ensure
+ * remove_from_waiters_ms() in local case will be the only user manipulating the
+ * lockspace waiters in recovery context.
+ */
 
-	error = validate_message(lkb, ms);
-	if (error)
-		goto out;
+static int remove_from_waiters_ms(struct dlm_lkb *lkb,
+				  const struct dlm_message *ms, bool local)
+{
+	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
+	int error;
 
-	queue_bast(r, lkb, le32_to_cpu(ms->m_bastmode));
-	lkb->lkb_highbast = le32_to_cpu(ms->m_bastmode);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	dlm_put_lkb(lkb);
-	return 0;
+	if (!local)
+		spin_lock_bh(&ls->ls_waiters_lock);
+	else
+		WARN_ON_ONCE(!rwsem_is_locked(&ls->ls_in_recovery) ||
+			     !dlm_locking_stopped(ls));
+	error = _remove_from_waiters(lkb, le32_to_cpu(ms->m_type), ms);
+	if (!local)
+		spin_unlock_bh(&ls->ls_waiters_lock);
+	return error;
 }
 
-static void receive_lookup(struct dlm_ls *ls, const struct dlm_message *ms)
+/* lkb is master or local copy */
+
+static void set_lvb_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	int len, error, ret_nodeid, from_nodeid, our_nodeid;
+	int b, len = r->res_ls->ls_lvblen;
 
 	from_nodeid = le32_to_cpu(ms->m_header.h_nodeid);
 	our_nodeid = dlm_our_nodeid();
-- 
2.48.1


