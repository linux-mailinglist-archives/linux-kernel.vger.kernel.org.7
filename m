Return-Path: <linux-kernel+bounces-792886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E2B3CA05
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C76B67C2ED4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89442741C9;
	Sat, 30 Aug 2025 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvOCOWtV"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957A26D4E8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548874; cv=none; b=LYGe40VBtBt7aZVSofS17G8Pd3EjhFPAFR26Qq19k5XoyTAfnE77WzgTr+Gr79/zh4j8AO4vjOHGjramHibicQtRtAqSCqh/W5ct6YTDuzkPhlZn6JPwlfSGIQuHPKQj6fUO7kUve5i0uTTnmYPSSl3J+bHVQVhhd2cURd1eglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548874; c=relaxed/simple;
	bh=5oa4l+aIPuDAYVbQm6EBc0it0JYAKB4iuk0L0lO5TC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxrJ8SOtN4xE1aOr8UoMIlNOkCoVHvNr9tpf8pkLTR8dfGDVGAwg0zdDqKp8nBf6CLrL1ke9KTgr1UF4Wl5M87giqimrQp2CovSDX4fe2JQANqL7QZPkHPhMyoKuFW5y1d5hfWAiZOf38mcZyWBsfml7bjjXqPU8Nlmo+WY32Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvOCOWtV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3cf48ec9fa4so1189911f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548867; x=1757153667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXHXWv2vcXwo3PdhQfcyHkePfgtYXXAsTvn5EkMlhpc=;
        b=XvOCOWtVJnmHSfYCacSSDdb2QSveqWIzj5mvxk90nKXB/LtefFVQnTJCg3WcclfTlD
         tTEKoD+I+bho/WiIQITWqUd8lTTA6RmYPuafRmgm0guWEQzecmIquZZZbLwI75BkYc8g
         tdBH3Ik92I5ZkhKymsPcBwrvk3rteFNFfK1QpDApVV5Bs1bOVHI7eHlNX7CFCY7D4iaF
         DTLwi+TeOWrkHeSRwzU+pMayETOeJlk5tw4sXeNMog46AhjZVfHh4yAgqMir/jpy1PFT
         TZ4NGg1FNyCFiLGQfsUqDij1/dnIn1Ffkszr3xufdbKX6FbZw3cDq/zAfEWxWigQhYtf
         Ro6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548867; x=1757153667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXHXWv2vcXwo3PdhQfcyHkePfgtYXXAsTvn5EkMlhpc=;
        b=bgJdwWz7MJTU3hWhItKqqH7W1VuNvYzxjzEBQFmGpcVr+MODCsuWskxYTXTIoF0Cet
         S2SGTKfkeYCFO+HFD+I4eXqMHoYrm74eE1AXHxc1GEb4760j/mTHF8TZi5x2s8U+Xmk7
         WK0sELzFVHIcSXC40xn1o6fTEmOu/2GLdT+gca56OzSrdFH2iCqOOKeYILbdEU+R7hJE
         Xcl7VZsmc5hfeescr9K6GccZ+iy8eSzA8sSVuDvRTtnYEbpQDwEZhDh7X5CrESruXY8d
         GHTJhufv2PD0CUKCDc6dhWjf6WWC6wPEfIvJ6HBoTej6yKdAaLwRDmNJ/KbyTrgjGPbA
         7PNQ==
X-Gm-Message-State: AOJu0YwOXzumhTYtvhBWsqbrES90A0iaY/8yNDqbPkQCfbVCNlq98iTX
	cDJDJk9jfs0xZbTyABrty8s5PORYDZ41h3eWPsFvsL79NMAPQPYoVYOf98wqhCW+A0k=
X-Gm-Gg: ASbGncvCfLEyc/FAPGpv2KglzgJk4GNXySO1JJTLuTNEKLpBQ8gaxLzb8zQd/2Cq6C7
	+gy8lYpmCBQQGj1ibtvlcoOURbeb6T8a7kvj8OrbP3LRQlOhFqxT/WbhwPSlMH5HSyAnStRzIXr
	rllRWWkSqbn/IvwWqwblj+NpCcrVTYY3y6R94VDM+x1xtAMwi7X1saLK/1HRwSEUupp1mV5pbrt
	GuStKYbf6fE11X+UNtlMMy0xHSQUky7p71upMENq0ePL9qXusH2osxyjDWJpwXlhJbCSQS48d5M
	LLZor6JezMUhWXv0ZqDyujiSjPIffqEu6MsI+/VT/njag4gubcJrUXMpdLRy5SJQRee0CLtZrA5
	tZq4FrPyXQofpAxPAQ0efwCZMdTvyCgCtFOpr6gme3swDuDkZ85ol0TP6HIqecgfZ4zLbNQjait
	hjzXKIuaDRmYQ5e2dBSTsAni9TUXQMfUeoAYtg+HU27zLoutTTL+Yjw7543dtJ317jNYyDaRA5T
	aY7h3EabODAq69O4p4=
X-Google-Smtp-Source: AGHT+IG6q3+NvlTuy6H35up7zLVmY9Q+x4gB6HojudsSQTpqi/CLvDGtYfOuRSgbp277IAJTedy7tA==
X-Received: by 2002:a5d:5887:0:b0:3b7:92ca:2831 with SMTP id ffacd0b85a97d-3d1dc5a34bdmr1117090f8f.12.1756548866628;
        Sat, 30 Aug 2025 03:14:26 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:26 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 07/12] fix: improve spin-lock struct
Date: Sat, 30 Aug 2025 12:14:08 +0200
Message-ID: <20250830101413.602637-7-226562783+SigAttilio@users.noreply.github.com>
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
 fs/dlm/lock.c | 1378 +++++++++++++++++--------------------------------
 1 file changed, 465 insertions(+), 913 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 4d5e4548d9f9..1eae9cdb4fcd 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -2503,1052 +2503,604 @@ void dlm_rsb_scan(struct timer_list *timer)
 static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
 			  struct dlm_rsb **r_ret)
 {
-	send_bast_queue(r, &r->res_grantqueue, lkb);
-	send_bast_queue(r, &r->res_convertqueue, lkb);
-}
+	struct dlm_rsb *r;
 
-/* set_master(r, lkb) -- set the master nodeid of a resource
+	r = dlm_allocate_rsb();
+	if (!r)
+		return -ENOMEM;
 
-   The purpose of this function is to set the nodeid field in the given
-   lkb using the nodeid field in the given rsb.  If the rsb's nodeid is
-   known, it can just be copied to the lkb and the function will return
-   0.  If the rsb's nodeid is _not_ known, it needs to be looked up
-   before it can be copied to the lkb.
+	r->res_ls = ls;
+	r->res_length = len;
+	memcpy(r->res_name, name, len);
+	spin_lock_init(&r->res_lock);
 
-   When the rsb nodeid is being looked up remotely, the initial lkb
-   causing the lookup is kept on the ls_waiters list waiting for the
-   lookup reply.  Other lkb's waiting for the same rsb lookup are kept
-   on the rsb's res_lookup list until the master is verified.
+	INIT_LIST_HEAD(&r->res_lookup);
+	INIT_LIST_HEAD(&r->res_grantqueue);
+	INIT_LIST_HEAD(&r->res_convertqueue);
+	INIT_LIST_HEAD(&r->res_waitqueue);
+	INIT_LIST_HEAD(&r->res_root_list);
+	INIT_LIST_HEAD(&r->res_scan_list);
+	INIT_LIST_HEAD(&r->res_recover_list);
+	INIT_LIST_HEAD(&r->res_masters_list);
 
-   Return values:
-   0: nodeid is set in rsb/lkb and the caller should go ahead and use it
-   1: the rsb master is not available and the lkb has been placed on
-      a wait queue
-*/
+	*r_ret = r;
+	return 0;
+}
 
-static int set_master(struct dlm_rsb *r, struct dlm_lkb *lkb)
+int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
+			struct dlm_rsb **r_ret)
 {
-	int our_nodeid = dlm_our_nodeid();
-
-	if (rsb_flag(r, RSB_MASTER_UNCERTAIN)) {
-		rsb_clear_flag(r, RSB_MASTER_UNCERTAIN);
-		r->res_first_lkid = lkb->lkb_id;
-		lkb->lkb_nodeid = r->res_nodeid;
-		return 0;
-	}
-
-	if (r->res_first_lkid && r->res_first_lkid != lkb->lkb_id) {
-		list_add_tail(&lkb->lkb_rsb_lookup, &r->res_lookup);
-		return 1;
-	}
-
-	if (r->res_master_nodeid == our_nodeid) {
-		lkb->lkb_nodeid = 0;
-		return 0;
-	}
-
-	if (r->res_master_nodeid) {
-		lkb->lkb_nodeid = r->res_master_nodeid;
-		return 0;
-	}
+	char key[DLM_RESNAME_MAXLEN] = {};
 
-	if (dlm_dir_nodeid(r) == our_nodeid) {
-		/* This is a somewhat unusual case; find_rsb will usually
-		   have set res_master_nodeid when dir nodeid is local, but
-		   there are cases where we become the dir node after we've
-		   past find_rsb and go through _request_lock again.
-		   confirm_master() or process_lookup_list() needs to be
-		   called after this. */
-		log_debug(r->res_ls, "set_master %x self master %d dir %d %s",
-			  lkb->lkb_id, r->res_master_nodeid, r->res_dir_nodeid,
-			  r->res_name);
-		r->res_master_nodeid = our_nodeid;
-		r->res_nodeid = 0;
-		lkb->lkb_nodeid = 0;
+	memcpy(key, name, len);
+	*r_ret = rhashtable_lookup_fast(rhash, &key, dlm_rhash_rsb_params);
+	if (*r_ret)
 		return 0;
-	}
 
-	r->res_first_lkid = lkb->lkb_id;
-	send_lookup(r, lkb);
-	return 1;
+	return -EBADR;
 }
 
-static void process_lookup_list(struct dlm_rsb *r)
+static int rsb_insert(struct dlm_rsb *rsb, struct rhashtable *rhash)
 {
-	struct dlm_lkb *lkb, *safe;
+	int rv;
 
-	list_for_each_entry_safe(lkb, safe, &r->res_lookup, lkb_rsb_lookup) {
-		list_del_init(&lkb->lkb_rsb_lookup);
-		_request_lock(r, lkb);
-	}
+	rv = rhashtable_insert_fast(rhash, &rsb->res_node,
+				    dlm_rhash_rsb_params);
+	if (!rv)
+		rsb_set_flag(rsb, RSB_HASHED);
+
+	return rv;
 }
 
-/* confirm_master -- confirm (or deny) an rsb's master nodeid */
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
 
-static void confirm_master(struct dlm_rsb *r, int error)
+static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
+			uint32_t hash, int dir_nodeid, int from_nodeid,
+			unsigned int flags, struct dlm_rsb **r_ret)
 {
-	struct dlm_lkb *lkb;
-
-	if (!r->res_first_lkid)
-		return;
+	struct dlm_rsb *r = NULL;
+	int our_nodeid = dlm_our_nodeid();
+	int from_local = 0;
+	int from_other = 0;
+	int from_dir = 0;
+	int create = 0;
+	int error;
 
-	switch (error) {
-	case 0:
-	case -EINPROGRESS:
-		r->res_first_lkid = 0;
-		process_lookup_list(r);
-		break;
+	if (flags & R_RECEIVE_REQUEST) {
+		if (from_nodeid == dir_nodeid)
+			from_dir = 1;
+		else
+			from_other = 1;
+	} else if (flags & R_REQUEST) {
+		from_local = 1;
+	}
 
-	case -EAGAIN:
-	case -EBADR:
-	case -ENOTBLK:
-		/* the remote request failed and won't be retried (it was
-		   a NOQUEUE, or has been canceled/unlocked); make a waiting
-		   lkb the first_lkid */
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
 
-		r->res_first_lkid = 0;
+	if (from_local || from_dir ||
+	    (from_other && (dir_nodeid == our_nodeid))) {
+		create = 1;
+	}
 
-		if (!list_empty(&r->res_lookup)) {
-			lkb = list_entry(r->res_lookup.next, struct dlm_lkb,
-					 lkb_rsb_lookup);
-			list_del_init(&lkb->lkb_rsb_lookup);
-			r->res_first_lkid = lkb->lkb_id;
-			_request_lock(r, lkb);
-		}
-		break;
+ retry:
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (error)
+		goto do_new;
 
-	default:
-		log_error(r->res_ls, "confirm_master unknown error %d", error);
+	/* check if the rsb is active under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
+	if (!rsb_flag(r, RSB_HASHED)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -EBADR;
+		goto do_new;
 	}
-}
 
-static int set_lock_args(int mode, struct dlm_lksb *lksb, uint32_t flags,
-			 int namelen, void (*ast)(void *astparam),
-			 void *astparam,
-			 void (*bast)(void *astparam, int mode),
-			 struct dlm_args *args)
-{
-	int rv = -EINVAL;
+	/*
+	 * rsb is active, so we can't check master_nodeid without lock_rsb.
+	 */
 
-	/* check for invalid arg usage */
+	if (rsb_flag(r, RSB_INACTIVE)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_inactive;
+	}
 
-	if (mode < 0 || mode > DLM_LOCK_EX)
-		goto out;
+	kref_get(&r->res_ref);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
+	goto out;
 
-	if (!(flags & DLM_LKF_CONVERT) && (namelen > DLM_RESNAME_MAXLEN))
-		goto out;
 
-	if (flags & DLM_LKF_CANCEL)
-		goto out;
+ do_inactive:
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 
-	if (flags & DLM_LKF_QUECVT && !(flags & DLM_LKF_CONVERT))
-		goto out;
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
 
-	if (flags & DLM_LKF_CONVDEADLK && !(flags & DLM_LKF_CONVERT))
-		goto out;
+	/*
+	 * rsb found inactive (master_nodeid may be out of date unless
+	 * we are the dir_nodeid or were the master)  No other thread
+	 * is using this rsb because it's inactive, so we can
+	 * look at or update res_master_nodeid without lock_rsb.
+	 */
 
-	if (flags & DLM_LKF_CONVDEADLK && flags & DLM_LKF_NOQUEUE)
+	if ((r->res_master_nodeid != our_nodeid) && from_other) {
+		/* our rsb was not master, and another node (not the dir node)
+		   has sent us a request */
+		log_debug(ls, "find_rsb inactive from_other %d master %d dir %d %s",
+			  from_nodeid, r->res_master_nodeid, dir_nodeid,
+			  r->res_name);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -ENOTBLK;
 		goto out;
+	}
 
-	if (flags & DLM_LKF_EXPEDITE && flags & DLM_LKF_CONVERT)
-		goto out;
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
 
-	if (flags & DLM_LKF_EXPEDITE && flags & DLM_LKF_QUECVT)
-		goto out;
+	if (from_local && (r->res_master_nodeid != our_nodeid)) {
+		/* Because we have held no locks on this rsb,
+		   res_master_nodeid could have become stale. */
+		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
+		r->res_first_lkid = 0;
+	}
 
-	if (flags & DLM_LKF_EXPEDITE && flags & DLM_LKF_NOQUEUE)
-		goto out;
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
 
-	if (flags & DLM_LKF_EXPEDITE && mode != DLM_LOCK_NL)
-		goto out;
+	goto out;
 
-	if (!ast || !lksb)
-		goto out;
 
-	if (flags & DLM_LKF_VALBLK && !lksb->sb_lvbptr)
-		goto out;
-
-	if (flags & DLM_LKF_CONVERT && !lksb->sb_lkid)
-		goto out;
-
-	/* these args will be copied to the lkb in validate_lock_args,
-	   it cannot be done now because when converting locks, fields in
-	   an active lkb cannot be modified before locking the rsb */
-
-	args->flags = flags;
-	args->astfn = ast;
-	args->astparam = astparam;
-	args->bastfn = bast;
-	args->mode = mode;
-	args->lksb = lksb;
-	rv = 0;
- out:
-	return rv;
-}
-
-static int set_unlock_args(uint32_t flags, void *astarg, struct dlm_args *args)
-{
-	if (flags & ~(DLM_LKF_CANCEL | DLM_LKF_VALBLK | DLM_LKF_IVVALBLK |
- 		      DLM_LKF_FORCEUNLOCK))
-		return -EINVAL;
-
-	if (flags & DLM_LKF_CANCEL && flags & DLM_LKF_FORCEUNLOCK)
-		return -EINVAL;
-
-	args->flags = flags;
-	args->astparam = astarg;
-	return 0;
-}
-
-static int validate_lock_args(struct dlm_ls *ls, struct dlm_lkb *lkb,
-			      struct dlm_args *args)
-{
-	int rv = -EBUSY;
-
-	if (args->flags & DLM_LKF_CONVERT) {
-		if (lkb->lkb_status != DLM_LKSTS_GRANTED)
-			goto out;
-
-		/* lock not allowed if there's any op in progress */
-		if (lkb->lkb_wait_type || lkb->lkb_wait_count)
-			goto out;
-
-		if (is_overlap(lkb))
-			goto out;
-
-		rv = -EINVAL;
-		if (test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags))
-			goto out;
-
-		if (args->flags & DLM_LKF_QUECVT &&
-		    !__quecvt_compat_matrix[lkb->lkb_grmode+1][args->mode+1])
-			goto out;
-	}
-
-	lkb->lkb_exflags = args->flags;
-	dlm_set_sbflags_val(lkb, 0);
-	lkb->lkb_astfn = args->astfn;
-	lkb->lkb_astparam = args->astparam;
-	lkb->lkb_bastfn = args->bastfn;
-	lkb->lkb_rqmode = args->mode;
-	lkb->lkb_lksb = args->lksb;
-	lkb->lkb_lvbptr = args->lksb->sb_lvbptr;
-	lkb->lkb_ownpid = (int) current->pid;
-	rv = 0;
- out:
-	switch (rv) {
-	case 0:
-		break;
-	case -EINVAL:
-		/* annoy the user because dlm usage is wrong */
-		WARN_ON(1);
-		log_error(ls, "%s %d %x %x %x %d %d", __func__,
-			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type);
-		break;
-	default:
-		log_debug(ls, "%s %d %x %x %x %d %d", __func__,
-			  rv, lkb->lkb_id, dlm_iflags_val(lkb), args->flags,
-			  lkb->lkb_status, lkb->lkb_wait_type);
-		break;
-	}
-
-	return rv;
-}
-
-/* when dlm_unlock() sees -EBUSY with CANCEL/FORCEUNLOCK it returns 0
-   for success */
-
-/* note: it's valid for lkb_nodeid/res_nodeid to be -1 when we get here
-   because there may be a lookup in progress and it's valid to do
-   cancel/unlockf on it */
-
-static int validate_unlock_args(struct dlm_lkb *lkb, struct dlm_args *args)
-{
-	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
-	int rv = -EBUSY;
-
-	/* normal unlock not allowed if there's any op in progress */
-	if (!(args->flags & (DLM_LKF_CANCEL | DLM_LKF_FORCEUNLOCK)) &&
-	    (lkb->lkb_wait_type || lkb->lkb_wait_count))
-		goto out;
-
-	/* an lkb may be waiting for an rsb lookup to complete where the
-	   lookup was initiated by another lock */
-
-	if (!list_empty(&lkb->lkb_rsb_lookup)) {
-		if (args->flags & (DLM_LKF_CANCEL | DLM_LKF_FORCEUNLOCK)) {
-			log_debug(ls, "unlock on rsb_lookup %x", lkb->lkb_id);
-			list_del_init(&lkb->lkb_rsb_lookup);
-			queue_cast(lkb->lkb_resource, lkb,
-				   args->flags & DLM_LKF_CANCEL ?
-				   -DLM_ECANCEL : -DLM_EUNLOCK);
-			unhold_lkb(lkb); /* undoes create_lkb() */
-		}
-		/* caller changes -EBUSY to 0 for CANCEL and FORCEUNLOCK */
-		goto out;
-	}
-
-	rv = -EINVAL;
-	if (test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags)) {
-		log_error(ls, "unlock on MSTCPY %x", lkb->lkb_id);
-		dlm_print_lkb(lkb);
-		goto out;
-	}
-
-	/* an lkb may still exist even though the lock is EOL'ed due to a
-	 * cancel, unlock or failed noqueue request; an app can't use these
-	 * locks; return same error as if the lkid had not been found at all
+ do_new:
+	/*
+	 * rsb not found
 	 */
 
-	if (test_bit(DLM_IFL_ENDOFLIFE_BIT, &lkb->lkb_iflags)) {
-		log_debug(ls, "unlock on ENDOFLIFE %x", lkb->lkb_id);
-		rv = -ENOENT;
-		goto out;
-	}
-
-	if (is_overlap_unlock(lkb))
-		goto out;
-
-	/* cancel not allowed with another cancel/unlock in progress */
-
-	if (args->flags & DLM_LKF_CANCEL) {
-		if (lkb->lkb_exflags & DLM_LKF_CANCEL)
-			goto out;
-
-		if (is_overlap_cancel(lkb))
-			goto out;
-
-		if (test_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags)) {
-			set_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
-			rv = -EBUSY;
-			goto out;
-		}
-
-		/* there's nothing to cancel */
-		if (lkb->lkb_status == DLM_LKSTS_GRANTED &&
-		    !lkb->lkb_wait_type) {
-			rv = -EBUSY;
-			goto out;
-		}
-
-		switch (lkb->lkb_wait_type) {
-		case DLM_MSG_LOOKUP:
-		case DLM_MSG_REQUEST:
-			set_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
-			rv = -EBUSY;
-			goto out;
-		case DLM_MSG_UNLOCK:
-		case DLM_MSG_CANCEL:
-			goto out;
-		}
-		/* add_to_waiters() will set OVERLAP_CANCEL */
-		goto out_ok;
-	}
-
-	/* do we need to allow a force-unlock if there's a normal unlock
-	   already in progress?  in what conditions could the normal unlock
-	   fail such that we'd want to send a force-unlock to be sure? */
-
-	if (args->flags & DLM_LKF_FORCEUNLOCK) {
-		if (lkb->lkb_exflags & DLM_LKF_FORCEUNLOCK)
-			goto out;
-
-		if (test_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags)) {
-			set_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
-			rv = -EBUSY;
-			goto out;
-		}
-
-		switch (lkb->lkb_wait_type) {
-		case DLM_MSG_LOOKUP:
-		case DLM_MSG_REQUEST:
-			set_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
-			rv = -EBUSY;
-			goto out;
-		case DLM_MSG_UNLOCK:
-			goto out;
-		}
-		/* add_to_waiters() will set OVERLAP_UNLOCK */
-	}
-
- out_ok:
-	/* an overlapping op shouldn't blow away exflags from other op */
-	lkb->lkb_exflags |= args->flags;
-	dlm_set_sbflags_val(lkb, 0);
-	lkb->lkb_astparam = args->astparam;
-	rv = 0;
- out:
-	switch (rv) {
-	case 0:
-		break;
-	case -EINVAL:
-		/* annoy the user because dlm usage is wrong */
-		WARN_ON(1);
-		log_error(ls, "%s %d %x %x %x %x %d %s", __func__, rv,
-			  lkb->lkb_id, dlm_iflags_val(lkb), lkb->lkb_exflags,
-			  args->flags, lkb->lkb_wait_type,
-			  lkb->lkb_resource->res_name);
-		break;
-	default:
-		log_debug(ls, "%s %d %x %x %x %x %d %s", __func__, rv,
-			  lkb->lkb_id, dlm_iflags_val(lkb), lkb->lkb_exflags,
-			  args->flags, lkb->lkb_wait_type,
-			  lkb->lkb_resource->res_name);
-		break;
-	}
-
-	return rv;
-}
-
-/*
- * Four stage 4 varieties:
- * do_request(), do_convert(), do_unlock(), do_cancel()
- * These are called on the master node for the given lock and
- * from the central locking logic.
- */
-
-static int do_request(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	int error = 0;
-
-	if (can_be_granted(r, lkb, 1, 0, NULL)) {
-		grant_lock(r, lkb);
-		queue_cast(r, lkb, 0);
-		goto out;
-	}
-
-	if (can_be_queued(lkb)) {
-		error = -EINPROGRESS;
-		add_lkb(r, lkb, DLM_LKSTS_WAITING);
-		goto out;
-	}
-
-	error = -EAGAIN;
-	queue_cast(r, lkb, -EAGAIN);
- out:
-	return error;
-}
-
-static void do_request_effects(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			       int error)
-{
-	switch (error) {
-	case -EAGAIN:
-		if (force_blocking_asts(lkb))
-			send_blocking_asts_all(r, lkb);
-		break;
-	case -EINPROGRESS:
-		send_blocking_asts(r, lkb);
-		break;
-	}
-}
-
-static int do_convert(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	int error = 0;
-	int deadlk = 0;
-
-	/* changing an existing lock may allow others to be granted */
-
-	if (can_be_granted(r, lkb, 1, 0, &deadlk)) {
-		grant_lock(r, lkb);
-		queue_cast(r, lkb, 0);
-		goto out;
-	}
-
-	/* can_be_granted() detected that this lock would block in a conversion
-	   deadlock, so we leave it on the granted queue and return EDEADLK in
-	   the ast for the convert. */
-
-	if (deadlk && !(lkb->lkb_exflags & DLM_LKF_NODLCKWT)) {
-		/* it's left on the granted queue */
-		revert_lock(r, lkb);
-		queue_cast(r, lkb, -EDEADLK);
-		error = -EDEADLK;
+	if (error == -EBADR && !create)
 		goto out;
-	}
 
-	/* is_demoted() means the can_be_granted() above set the grmode
-	   to NL, and left us on the granted queue.  This auto-demotion
-	   (due to CONVDEADLK) might mean other locks, and/or this lock, are
-	   now grantable.  We have to try to grant other converting locks
-	   before we try again to grant this one. */
-
-	if (is_demoted(lkb)) {
-		grant_pending_convert(r, DLM_LOCK_IV, NULL, NULL);
-		if (_can_be_granted(r, lkb, 1, 0)) {
-			grant_lock(r, lkb);
-			queue_cast(r, lkb, 0);
-			goto out;
-		}
-		/* else fall through and move to convert queue */
-	}
-
-	if (can_be_queued(lkb)) {
-		error = -EINPROGRESS;
-		del_lkb(r, lkb);
-		add_lkb(r, lkb, DLM_LKSTS_CONVERT);
+	error = get_rsb_struct(ls, name, len, &r);
+	if (WARN_ON_ONCE(error))
 		goto out;
-	}
 
-	error = -EAGAIN;
-	queue_cast(r, lkb, -EAGAIN);
- out:
-	return error;
-}
-
-static void do_convert_effects(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			       int error)
-{
-	switch (error) {
-	case 0:
-		grant_pending_locks(r, NULL);
-		/* grant_pending_locks also sends basts */
-		break;
-	case -EAGAIN:
-		if (force_blocking_asts(lkb))
-			send_blocking_asts_all(r, lkb);
-		break;
-	case -EINPROGRESS:
-		send_blocking_asts(r, lkb);
-		break;
-	}
-}
-
-static int do_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	remove_lock(r, lkb);
-	queue_cast(r, lkb, -DLM_EUNLOCK);
-	return -DLM_EUNLOCK;
-}
-
-static void do_unlock_effects(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			      int error)
-{
-	grant_pending_locks(r, NULL);
-}
-
-/* returns: 0 did nothing, -DLM_ECANCEL canceled lock */
-
-static int do_cancel(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	int error;
+	r->res_hash = hash;
+	r->res_dir_nodeid = dir_nodeid;
+	kref_init(&r->res_ref);
 
-	error = revert_lock(r, lkb);
-	if (error) {
-		queue_cast(r, lkb, -DLM_ECANCEL);
-		return -DLM_ECANCEL;
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
 	}
-	return 0;
-}
-
-static void do_cancel_effects(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			      int error)
-{
-	if (error)
-		grant_pending_locks(r, NULL);
-}
-
-/*
- * Four stage 3 varieties:
- * _request_lock(), _convert_lock(), _unlock_lock(), _cancel_lock()
- */
-
-/* add a new lkb to a possibly new rsb, called by requesting process */
-
-static int _request_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	int error;
 
-	/* set_master: sets lkb nodeid from r */
-
-	error = set_master(r, lkb);
-	if (error < 0)
-		goto out;
-	if (error) {
-		error = 0;
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
 		goto out;
 	}
 
-	if (is_remote(r)) {
-		/* receive_request() calls do_request() on remote node */
-		error = send_request(r, lkb);
-	} else {
-		error = do_request(r, lkb);
-		/* for remote locks the request_reply is sent
-		   between do_request and do_request_effects */
-		do_request_effects(r, lkb, error);
-	}
- out:
-	return error;
-}
-
-/* change some property of an existing lkb, e.g. mode */
-
-static int _convert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	int error;
-
-	if (is_remote(r)) {
-		/* receive_convert() calls do_convert() on remote node */
-		error = send_convert(r, lkb);
-	} else {
-		error = do_convert(r, lkb);
-		/* for remote locks the convert_reply is sent
-		   between do_convert and do_convert_effects */
-		do_convert_effects(r, lkb, error);
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
 	}
 
-	return error;
-}
-
-/* remove an existing lkb from the granted queue */
-
-static int _unlock_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	int error;
-
-	if (is_remote(r)) {
-		/* receive_unlock() calls do_unlock() on remote node */
-		error = send_unlock(r, lkb);
+	if (dir_nodeid == our_nodeid) {
+		/* When we are the dir nodeid, we can set the master
+		   node immediately */
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
 	} else {
-		error = do_unlock(r, lkb);
-		/* for remote locks the unlock_reply is sent
-		   between do_unlock and do_unlock_effects */
-		do_unlock_effects(r, lkb, error);
+		/* set_master will send_lookup to dir_nodeid */
+		r->res_master_nodeid = 0;
+		r->res_nodeid = -1;
 	}
 
-	return error;
-}
-
-/* remove an existing lkb from the convert or wait queue */
-
-static int _cancel_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	int error;
+ out_add:
 
-	if (is_remote(r)) {
-		/* receive_cancel() calls do_cancel() on remote node */
-		error = send_cancel(r, lkb);
-	} else {
-		error = do_cancel(r, lkb);
-		/* for remote locks the cancel_reply is sent
-		   between do_cancel and do_cancel_effects */
-		do_cancel_effects(r, lkb, error);
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
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
+ out:
+	*r_ret = r;
 	return error;
 }
 
 /*
- * Four stage 2 varieties:
- * request_lock(), convert_lock(), unlock_lock(), cancel_lock()
+ * Compatibility matrix for conversions with QUECVT set.
+ * Granted mode is the row; requested mode is the column.
+ * Usage: matrix[grmode+1][rqmode+1]
  */
 
-static int request_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
-			const void *name, int len,
-			struct dlm_args *args)
-{
-	struct dlm_rsb *r;
-	int error;
-
-	error = validate_lock_args(ls, lkb, args);
-	if (error)
-		return error;
-
-	error = find_rsb(ls, name, len, 0, R_REQUEST, &r);
-	if (error)
-		return error;
-
-	lock_rsb(r);
-
-	attach_lkb(r, lkb);
-	lkb->lkb_lksb->sb_lkid = lkb->lkb_id;
-
-	error = _request_lock(r, lkb);
-
-	unlock_rsb(r);
-	put_rsb(r);
-	return error;
-}
-
-static int convert_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
-			struct dlm_args *args)
-{
-	struct dlm_rsb *r;
-	int error;
-
-	r = lkb->lkb_resource;
-
-	hold_rsb(r);
-	lock_rsb(r);
-
-	error = validate_lock_args(ls, lkb, args);
-	if (error)
-		goto out;
-
-	error = _convert_lock(r, lkb);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	return error;
-}
-
-static int unlock_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
-		       struct dlm_args *args)
-{
-	struct dlm_rsb *r;
-	int error;
-
-	r = lkb->lkb_resource;
-
-	hold_rsb(r);
-	lock_rsb(r);
-
-	error = validate_unlock_args(lkb, args);
-	if (error)
-		goto out;
-
-	error = _unlock_lock(r, lkb);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	return error;
-}
+static const int __quecvt_compat_matrix[8][8] = {
+      /* UN NL CR CW PR PW EX PD */
+        {0, 0, 0, 0, 0, 0, 0, 0},       /* UN */
+        {0, 0, 1, 1, 1, 1, 1, 0},       /* NL */
+        {0, 0, 0, 1, 1, 1, 1, 0},       /* CR */
+        {0, 0, 0, 0, 1, 1, 1, 0},       /* CW */
+        {0, 0, 0, 1, 0, 1, 1, 0},       /* PR */
+        {0, 0, 0, 0, 0, 0, 1, 0},       /* PW */
+        {0, 0, 0, 0, 0, 0, 0, 0},       /* EX */
+        {0, 0, 0, 0, 0, 0, 0, 0}        /* PD */
+};
 
-static int cancel_lock(struct dlm_ls *ls, struct dlm_lkb *lkb,
-		       struct dlm_args *args)
+void dlm_print_lkb(struct dlm_lkb *lkb)
 {
-	struct dlm_rsb *r;
-	int error;
-
-	r = lkb->lkb_resource;
-
-	hold_rsb(r);
-	lock_rsb(r);
-
-	error = validate_unlock_args(lkb, args);
-	if (error)
-		goto out;
-
-	error = _cancel_lock(r, lkb);
- out:
-	unlock_rsb(r);
-	put_rsb(r);
-	return error;
+	printk(KERN_ERR "lkb: nodeid %d id %x remid %x exflags %x flags %x "
+	       "sts %d rq %d gr %d wait_type %d wait_nodeid %d seq %llu\n",
+	       lkb->lkb_nodeid, lkb->lkb_id, lkb->lkb_remid, lkb->lkb_exflags,
+	       dlm_iflags_val(lkb), lkb->lkb_status, lkb->lkb_rqmode,
+	       lkb->lkb_grmode, lkb->lkb_wait_type, lkb->lkb_wait_nodeid,
+	       (unsigned long long)lkb->lkb_recover_seq);
 }
 
-/*
- * Two stage 1 varieties:  dlm_lock() and dlm_unlock()
- */
-
-int dlm_lock(dlm_lockspace_t *lockspace,
-	     int mode,
-	     struct dlm_lksb *lksb,
-	     uint32_t flags,
-	     const void *name,
-	     unsigned int namelen,
-	     uint32_t parent_lkid,
-	     void (*ast) (void *astarg),
-	     void *astarg,
-	     void (*bast) (void *astarg, int mode))
+static void dlm_print_rsb(struct dlm_rsb *r)
 {
-	struct dlm_ls *ls;
-	struct dlm_lkb *lkb;
-	struct dlm_args args;
-	int error, convert = flags & DLM_LKF_CONVERT;
-
-	ls = dlm_find_lockspace_local(lockspace);
-	if (!ls)
-		return -EINVAL;
-
-	dlm_lock_recovery(ls);
-
-	if (convert)
-		error = find_lkb(ls, lksb->sb_lkid, &lkb);
-	else
-		error = create_lkb(ls, &lkb);
-
-	if (error)
-		goto out;
-
-	trace_dlm_lock_start(ls, lkb, name, namelen, mode, flags);
-
-	error = set_lock_args(mode, lksb, flags, namelen, ast, astarg, bast,
-			      &args);
-	if (error)
-		goto out_put;
-
-	if (convert)
-		error = convert_lock(ls, lkb, &args);
-	else
-		error = request_lock(ls, lkb, name, namelen, &args);
-
-	if (error == -EINPROGRESS)
-		error = 0;
- out_put:
-	trace_dlm_lock_end(ls, lkb, name, namelen, mode, flags, error, true);
-
-	if (convert || error)
-		__put_lkb(ls, lkb);
-	if (error == -EAGAIN || error == -EDEADLK)
-		error = 0;
- out:
-	dlm_unlock_recovery(ls);
-	dlm_put_lockspace(ls);
-	return error;
+	printk(KERN_ERR "rsb: nodeid %d master %d dir %d flags %lx first %x "
+	       "rlc %d name %s\n",
+	       r->res_nodeid, r->res_master_nodeid, r->res_dir_nodeid,
+	       r->res_flags, r->res_first_lkid, r->res_recover_locks_count,
+	       r->res_name);
 }
 
-int dlm_unlock(dlm_lockspace_t *lockspace,
-	       uint32_t lkid,
-	       uint32_t flags,
-	       struct dlm_lksb *lksb,
-	       void *astarg)
+void dlm_dump_rsb(struct dlm_rsb *r)
 {
-	struct dlm_ls *ls;
 	struct dlm_lkb *lkb;
-	struct dlm_args args;
-	int error;
-
-	ls = dlm_find_lockspace_local(lockspace);
-	if (!ls)
-		return -EINVAL;
 
-	dlm_lock_recovery(ls);
+	dlm_print_rsb(r);
 
-	error = find_lkb(ls, lkid, &lkb);
-	if (error)
-		goto out;
+	printk(KERN_ERR "rsb: root_list empty %d recover_list empty %d\n",
+	       list_empty(&r->res_root_list), list_empty(&r->res_recover_list));
+	printk(KERN_ERR "rsb lookup list\n");
+	list_for_each_entry(lkb, &r->res_lookup, lkb_rsb_lookup)
+		dlm_print_lkb(lkb);
+	printk(KERN_ERR "rsb grant queue:\n");
+	list_for_each_entry(lkb, &r->res_grantqueue, lkb_statequeue)
+		dlm_print_lkb(lkb);
+	printk(KERN_ERR "rsb convert queue:\n");
+	list_for_each_entry(lkb, &r->res_convertqueue, lkb_statequeue)
+		dlm_print_lkb(lkb);
+	printk(KERN_ERR "rsb wait queue:\n");
+	list_for_each_entry(lkb, &r->res_waitqueue, lkb_statequeue)
+		dlm_print_lkb(lkb);
+}
 
-	trace_dlm_unlock_start(ls, lkb, flags);
+/* Threads cannot use the lockspace while it's being recovered */
 
-	error = set_unlock_args(flags, astarg, &args);
-	if (error)
-		goto out_put;
+void dlm_lock_recovery(struct dlm_ls *ls)
+{
+	down_read(&ls->ls_in_recovery);
+}
 
-	if (flags & DLM_LKF_CANCEL)
-		error = cancel_lock(ls, lkb, &args);
-	else
-		error = unlock_lock(ls, lkb, &args);
+void dlm_unlock_recovery(struct dlm_ls *ls)
+{
+	up_read(&ls->ls_in_recovery);
+}
 
-	if (error == -DLM_EUNLOCK || error == -DLM_ECANCEL)
-		error = 0;
-	if (error == -EBUSY && (flags & (DLM_LKF_CANCEL | DLM_LKF_FORCEUNLOCK)))
-		error = 0;
- out_put:
-	trace_dlm_unlock_end(ls, lkb, flags, error);
+int dlm_lock_recovery_try(struct dlm_ls *ls)
+{
+	return down_read_trylock(&ls->ls_in_recovery);
+}
 
-	dlm_put_lkb(lkb);
- out:
-	dlm_unlock_recovery(ls);
-	dlm_put_lockspace(ls);
-	return error;
+static inline int can_be_queued(struct dlm_lkb *lkb)
+{
+	return !(lkb->lkb_exflags & DLM_LKF_NOQUEUE);
 }
 
-/*
- * send/receive routines for remote operations and replies
- *
- * send_args
- * send_common
- * send_request			receive_request
- * send_convert			receive_convert
- * send_unlock			receive_unlock
- * send_cancel			receive_cancel
- * send_grant			receive_grant
- * send_bast			receive_bast
- * send_lookup			receive_lookup
- * send_remove			receive_remove
- *
- * 				send_common_reply
- * receive_request_reply	send_request_reply
- * receive_convert_reply	send_convert_reply
- * receive_unlock_reply		send_unlock_reply
- * receive_cancel_reply		send_cancel_reply
- * receive_lookup_reply		send_lookup_reply
- */
+static inline int force_blocking_asts(struct dlm_lkb *lkb)
+{
+	return (lkb->lkb_exflags & DLM_LKF_NOQUEUEBAST);
+}
 
-static int _create_message(struct dlm_ls *ls, int mb_len,
-			   int to_nodeid, int mstype,
-			   struct dlm_message **ms_ret,
-			   struct dlm_mhandle **mh_ret)
+static inline int is_demoted(struct dlm_lkb *lkb)
 {
-	struct dlm_message *ms;
-	struct dlm_mhandle *mh;
-	char *mb;
+	return test_bit(DLM_SBF_DEMOTED_BIT, &lkb->lkb_sbflags);
+}
 
-	/* get_buffer gives us a message handle (mh) that we need to
-	   pass into midcomms_commit and a message buffer (mb) that we
-	   write our data into */
+static inline int is_altmode(struct dlm_lkb *lkb)
+{
+	return test_bit(DLM_SBF_ALTMODE_BIT, &lkb->lkb_sbflags);
+}
 
-	mh = dlm_midcomms_get_mhandle(to_nodeid, mb_len, &mb);
-	if (!mh)
-		return -ENOBUFS;
+static inline int is_granted(struct dlm_lkb *lkb)
+{
+	return (lkb->lkb_status == DLM_LKSTS_GRANTED);
+}
 
-	ms = (struct dlm_message *) mb;
+static inline int is_remote(struct dlm_rsb *r)
+{
+	DLM_ASSERT(r->res_nodeid >= 0, dlm_print_rsb(r););
+	return !!r->res_nodeid;
+}
 
-	ms->m_header.h_version = cpu_to_le32(DLM_HEADER_MAJOR | DLM_HEADER_MINOR);
-	ms->m_header.u.h_lockspace = cpu_to_le32(ls->ls_global_id);
-	ms->m_header.h_nodeid = cpu_to_le32(dlm_our_nodeid());
-	ms->m_header.h_length = cpu_to_le16(mb_len);
-	ms->m_header.h_cmd = DLM_MSG;
+static inline int is_process_copy(struct dlm_lkb *lkb)
+{
+	return lkb->lkb_nodeid &&
+	       !test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags);
+}
 
-	ms->m_type = cpu_to_le32(mstype);
+static inline int is_master_copy(struct dlm_lkb *lkb)
+{
+	return test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags);
+}
 
-	*mh_ret = mh;
-	*ms_ret = ms;
+static inline int middle_conversion(struct dlm_lkb *lkb)
+{
+	if ((lkb->lkb_grmode==DLM_LOCK_PR && lkb->lkb_rqmode==DLM_LOCK_CW) ||
+	    (lkb->lkb_rqmode==DLM_LOCK_PR && lkb->lkb_grmode==DLM_LOCK_CW))
+		return 1;
 	return 0;
 }
 
-static int create_message(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			  int to_nodeid, int mstype,
-			  struct dlm_message **ms_ret,
-			  struct dlm_mhandle **mh_ret)
+static inline int down_conversion(struct dlm_lkb *lkb)
 {
-	int mb_len = sizeof(struct dlm_message);
-
-	switch (mstype) {
-	case DLM_MSG_REQUEST:
-	case DLM_MSG_LOOKUP:
-	case DLM_MSG_REMOVE:
-		mb_len += r->res_length;
-		break;
-	case DLM_MSG_CONVERT:
-	case DLM_MSG_UNLOCK:
-	case DLM_MSG_REQUEST_REPLY:
-	case DLM_MSG_CONVERT_REPLY:
-	case DLM_MSG_GRANT:
-		if (lkb && lkb->lkb_lvbptr && (lkb->lkb_exflags & DLM_LKF_VALBLK))
-			mb_len += r->res_ls->ls_lvblen;
-		break;
-	}
-
-	return _create_message(r->res_ls, mb_len, to_nodeid, mstype,
-			       ms_ret, mh_ret);
+	return (!middle_conversion(lkb) && lkb->lkb_rqmode < lkb->lkb_grmode);
 }
 
-/* further lowcomms enhancements or alternate implementations may make
-   the return value from this function useful at some point */
+static inline int is_overlap_unlock(struct dlm_lkb *lkb)
+{
+	return test_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
+}
 
-static int send_message(struct dlm_mhandle *mh, struct dlm_message *ms,
-			const void *name, int namelen)
+static inline int is_overlap_cancel(struct dlm_lkb *lkb)
 {
-	dlm_midcomms_commit_mhandle(mh, name, namelen);
-	return 0;
+	return test_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
 }
 
-static void send_args(struct dlm_rsb *r, struct dlm_lkb *lkb,
-		      struct dlm_message *ms)
+static inline int is_overlap(struct dlm_lkb *lkb)
 {
-	ms->m_nodeid   = cpu_to_le32(lkb->lkb_nodeid);
-	ms->m_pid      = cpu_to_le32(lkb->lkb_ownpid);
-	ms->m_lkid     = cpu_to_le32(lkb->lkb_id);
-	ms->m_remid    = cpu_to_le32(lkb->lkb_remid);
-	ms->m_exflags  = cpu_to_le32(lkb->lkb_exflags);
-	ms->m_sbflags  = cpu_to_le32(dlm_sbflags_val(lkb));
-	ms->m_flags    = cpu_to_le32(dlm_dflags_val(lkb));
-	ms->m_lvbseq   = cpu_to_le32(lkb->lkb_lvbseq);
-	ms->m_status   = cpu_to_le32(lkb->lkb_status);
-	ms->m_grmode   = cpu_to_le32(lkb->lkb_grmode);
-	ms->m_rqmode   = cpu_to_le32(lkb->lkb_rqmode);
-	ms->m_hash     = cpu_to_le32(r->res_hash);
+	return test_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags) ||
+	       test_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
+}
 
-	/* m_result and m_bastmode are set from function args,
-	   not from lkb fields */
+static void queue_cast(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
+{
+	if (is_master_copy(lkb))
+		return;
 
-	if (lkb->lkb_bastfn)
-		ms->m_asts |= cpu_to_le32(DLM_CB_BAST);
-	if (lkb->lkb_astfn)
-		ms->m_asts |= cpu_to_le32(DLM_CB_CAST);
+	DLM_ASSERT(lkb->lkb_lksb, dlm_print_lkb(lkb););
 
-	/* compare with switch in create_message; send_remove() doesn't
-	   use send_args() */
+	if (rv == -DLM_ECANCEL &&
+	    test_and_clear_bit(DLM_IFL_DEADLOCK_CANCEL_BIT, &lkb->lkb_iflags))
+		rv = -EDEADLK;
 
-	switch (ms->m_type) {
-	case cpu_to_le32(DLM_MSG_REQUEST):
-	case cpu_to_le32(DLM_MSG_LOOKUP):
-		memcpy(ms->m_extra, r->res_name, r->res_length);
-		break;
-	case cpu_to_le32(DLM_MSG_CONVERT):
-	case cpu_to_le32(DLM_MSG_UNLOCK):
-	case cpu_to_le32(DLM_MSG_REQUEST_REPLY):
-	case cpu_to_le32(DLM_MSG_CONVERT_REPLY):
-	case cpu_to_le32(DLM_MSG_GRANT):
-		if (!lkb->lkb_lvbptr || !(lkb->lkb_exflags & DLM_LKF_VALBLK))
-			break;
-		memcpy(ms->m_extra, lkb->lkb_lvbptr, r->res_ls->ls_lvblen);
-		break;
-	}
+	dlm_add_cb(lkb, DLM_CB_CAST, lkb->lkb_grmode, rv, dlm_sbflags_val(lkb));
 }
 
-static int send_common(struct dlm_rsb *r, struct dlm_lkb *lkb, int mstype)
+static inline void queue_cast_overlap(struct dlm_rsb *r, struct dlm_lkb *lkb)
 {
-	struct dlm_message *ms;
-	struct dlm_mhandle *mh;
-	int to_nodeid, error;
+	queue_cast(r, lkb,
+		   is_overlap_unlock(lkb) ? -DLM_EUNLOCK : -DLM_ECANCEL);
+}
 
-	to_nodeid = r->res_nodeid;
+static void queue_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int rqmode)
+{
+	if (is_master_copy(lkb)) {
+		send_bast(r, lkb, rqmode);
+	} else {
+		dlm_add_cb(lkb, DLM_CB_BAST, rqmode, 0, 0);
+	}
+}
 
-	add_to_waiters(lkb, mstype, to_nodeid);
-	error = create_message(r, lkb, to_nodeid, mstype, &ms, &mh);
-	if (error)
-		goto fail;
+/*
+ * Basic operations on rsb's and lkb's
+ */
 
-	send_args(r, lkb, ms);
+static inline unsigned long rsb_toss_jiffies(void)
+{
+	return jiffies + (READ_ONCE(dlm_config.ci_toss_secs) * HZ);
+}
 
-	error = send_message(mh, ms, r->res_name, r->res_length);
-	if (error)
-		goto fail;
-	return 0;
+/* This is only called to add a reference when the code already holds
+   a valid reference to the rsb, so there's no need for locking. */
 
- fail:
-	remove_from_waiters(lkb, msg_reply_type(mstype));
-	return error;
+static inline void hold_rsb(struct dlm_rsb *r)
+{
+	/* inactive rsbs are not ref counted */
+	WARN_ON(rsb_flag(r, RSB_INACTIVE));
+	kref_get(&r->res_ref);
 }
 
-static int send_request(struct dlm_rsb *r, struct dlm_lkb *lkb)
+void dlm_hold_rsb(struct dlm_rsb *r)
 {
-	return send_common(r, lkb, DLM_MSG_REQUEST);
+	hold_rsb(r);
 }
 
-static int send_convert(struct dlm_rsb *r, struct dlm_lkb *lkb)
+/* TODO move this to lib/refcount.c */
+static __must_check bool
+dlm_refcount_dec_and_write_lock_bh(refcount_t *r, rwlock_t *lock)
+__cond_acquires(lock)
 {
-	int error;
+	if (refcount_dec_not_one(r))
+		return false;
+
+	write_lock_bh(lock);
+	if (!refcount_dec_and_test(r)) {
+		write_unlock_bh(lock);
+		return false;
+	}
 
-	error = send_common(r, lkb, DLM_MSG_CONVERT);
+	return true;
+}
 
-	/* down conversions go without a reply from the master */
-	if (!error && down_conversion(lkb)) {
-		remove_from_waiters(lkb, DLM_MSG_CONVERT_REPLY);
-		r->res_ls->ls_local_ms.m_type = cpu_to_le32(DLM_MSG_CONVERT_REPLY);
-		r->res_ls->ls_local_ms.m_result = 0;
-		__receive_convert_reply(r, lkb, &r->res_ls->ls_local_ms, true);
+/* TODO move this to include/linux/kref.h */
+static inline int dlm_kref_put_write_lock_bh(struct kref *kref,
+					     void (*release)(struct kref *kref),
+					     rwlock_t *lock)
+{
+	if (dlm_refcount_dec_and_write_lock_bh(&kref->refcount, lock)) {
+		release(kref);
+		return 1;
 	}
 
-	return error;
+	return 0;
+}
+
+static void put_rsb(struct dlm_rsb *r)
+{
+	struct dlm_ls *ls = r->res_ls;
+	int rv;
+
+	rv = dlm_kref_put_write_lock_bh(&r->res_ref, deactivate_rsb,
+					&ls->ls_rsbtbl_lock);
+	if (rv)
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
-/* FIXME: if this lkb is the only lock we hold on the rsb, then set
-   MASTER_UNCERTAIN to force the next request on the rsb to confirm
-   that the master is still correct. */
+void dlm_put_rsb(struct dlm_rsb *r)
+{
+	put_rsb(r);
+}
 
-static int send_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+/* connected with timer_delete_sync() in dlm_ls_stop() to stop
+ * new timers when recovery is triggered and don't run them
+ * again until a resume_scan_timer() tries it again.
+ */
+static void enable_scan_timer(struct dlm_ls *ls, unsigned long jiffies)
 {
-	return send_common(r, lkb, DLM_MSG_UNLOCK);
+	if (!dlm_locking_stopped(ls))
+		mod_timer(&ls->ls_scan_timer, jiffies);
 }
 
-static int send_cancel(struct dlm_rsb *r, struct dlm_lkb *lkb)
+/* This function tries to resume the timer callback if a rsb
+ * is on the scan list and no timer is pending. It might that
+ * the first entry is on currently executed as timer callback
+ * but we don't care if a timer queued up again and does
+ * nothing. Should be a rare case.
+ */
+void resume_scan_timer(struct dlm_ls *ls)
 {
-	return send_common(r, lkb, DLM_MSG_CANCEL);
+	struct dlm_rsb *r;
+
+	spin_lock_bh(&ls->ls_scan_lock);
+	r = list_first_entry_or_null(&ls->ls_scan_list, struct dlm_rsb,
+				     res_scan_list);
+	if (r && !timer_pending(&ls->ls_scan_timer))
+		enable_scan_timer(ls, r->res_toss_time);
+	spin_unlock_bh(&ls->ls_scan_lock);
 }
 
-static int send_grant(struct dlm_rsb *r, struct dlm_lkb *lkb)
+/* ls_rsbtbl_lock must be held */
+
+static void del_scan(struct dlm_ls *ls, struct dlm_rsb *r)
 {
-	struct dlm_message *ms;
-	struct dlm_mhandle *mh;
-	int to_nodeid, error;
+	struct dlm_rsb *first;
 
-	to_nodeid = lkb->lkb_nodeid;
+	/* active rsbs should never be on the scan list */
+	WARN_ON(!rsb_flag(r, RSB_INACTIVE));
+
+	spin_lock_bh(&ls->ls_scan_lock);
+	r->res_toss_time = 0;
 
 	error = create_message(r, lkb, to_nodeid, DLM_MSG_GRANT, &ms, &mh);
 	if (error)
-- 
2.48.1


