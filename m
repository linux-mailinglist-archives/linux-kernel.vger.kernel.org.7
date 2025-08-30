Return-Path: <linux-kernel+bounces-792883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB662B3C9FF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33A53B0674
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D192727EE;
	Sat, 30 Aug 2025 10:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeHKEyJJ"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C732326F29B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548869; cv=none; b=Jc5IUiUZXL/2fm/h9StfGojnkL1km8iNdcQxHWCYJr2WAce95B5kgPlbEpZ5OExKVCjNopXI9XdbyDqSIWz8UfCFJBdZFLcXfQpSc+7jPYFyPtTl1v4Mpqdgwfvj0Bk6gNd9ORDim7P+tGWbTH+1z4FH4qJdd103ZgnCGlC04hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548869; c=relaxed/simple;
	bh=wA/Pik6MUxEnspdnIYub60bXTsGFkdQbi15wvL7ucik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUv+spdRk64Whe77MffGYuTxfdXbdOjwssyAB2OB65kjoTa+4gaBLc//81z4STtrtThfazMhRnk+AzxAIg9MBDyE+TUxe2NZoNvus1l2WMaDqvCq8rJMjIuPBXhv8yHXKma+7KFpbADExUN7wkutXu1GCmuOfDpDov/+nxcMJDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeHKEyJJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d1bf79d7acso254651f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548865; x=1757153665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Wtg5N6pOonnpF6K0Zpto71p7ExzZkSTSXs0r1skB4o=;
        b=PeHKEyJJH5Ys/IiOj8AvPb0DXmat7oyRorHzcwMF+bc2dEBpQ0whLrRTTLjN076t22
         gt4XIGk1ImNmxMhupPn+8u9qzdUEReWAAr9y3pJIW1TSW65mbl3l916nIiCG6HtyMSdI
         srsUbgZQRxP/psw+kd4yHDcZ9TQpvzBv11Bf8QSK8XIIIBPdwJY/rjc0SdVcgqH99Q+V
         e1FK5NWWCz0uDLiwREG5B7lyZpLHkxL88S5gq9IpyTWnytQa7wtrLej5YC+PqqBjvm6W
         BEWEmb4zdq6Brn8FHG6Rx5JhMvUT61OkXDwS44qwj0KGcN4a91EMfL1IBq1OT1rEl3o4
         hBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548865; x=1757153665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Wtg5N6pOonnpF6K0Zpto71p7ExzZkSTSXs0r1skB4o=;
        b=PjlUahmUlqNo/FbUnoaIPOzB1ERnx8Yz03g7ce2DZg6iAbOmzp9y1JZYQrfDWQnIFN
         RghfIVX001OaQR6cN3WtFFSO33hYyLO9/6Cg9hXvvCQBDMq66GgiBoW4JHIdfWRz6heP
         gmagzHw9KojtHfw5iym2GqWzy12zW28EOn9C9cAh4sL7A+G7yALuaXDFhiBnFLcuPQzr
         oDtr5Vlyq1npH4T8Nkf5unxnQCIh52t9kS1Oc8Ad71TWT6kcyI+sJ2W9SO4zDfZuACid
         M+6l1THEwyHNsJEep9RjNiTLcxWwSDri6FCt+K+gXRtB3RgO19xlLkCHqWIUWtc26DBx
         A8kQ==
X-Gm-Message-State: AOJu0YzOKipTE//z6YBMuCO9yi82kxzEfALJSIR2PJ5RrjDmji9MUGsW
	zldYLoWkdE/doRORBxkCM5I0tHuJstDHR0o5yn833b56vNve2c0/3S/A
X-Gm-Gg: ASbGncseLcGLsZ+dvQR/11HzIB0brLK5Gk4HFA0/eerVopk/DaNa3hGz08pzf5D3cR4
	woSqop7aj8GOmWac5iT2FOXYrOd5GZw0poqRKyL8eXMA+WeYB1HgocXP92DhpLK2hW/bRR7uA1w
	qk294OtDPMDnjo5yfQkSOsbZV/GXC53i1MQ1K6lIRFg7IEVb1ES+6wmIrSteKIMKh7EOJonHL16
	K3bWiimfMZUMvPMspOiN7tkwAkmVHwZJeOW+TqfrX9Dx/lmNzpFZI4SC94wMQhFo4fzwXGmWxH7
	wjPTGoOzp4+Qbd8VYjWMsxuM1wWCjlmFSX1XFKyo5ID17MwA1t73Vpuyo0/x/YDRf0T4VbAUXpI
	hh+xiVS/dsqr++o5TUVBnGUIdiKJSmQXhKklHXODJeSxWCrwI3fDgL8PyI9R0nJUYb6oY0KmLxK
	e2dx1UnTOIMr9zlENGJMjGfgec8DW4akxZBBV/lk+BakWOF4CQkCmLQkrx5o4R6lyC4Ueq2dGob
	weSYvT6F57wCJgRtKU=
X-Google-Smtp-Source: AGHT+IFJ20Y64kPiVgNYfuJAPCeBng0/KZvYpBHW2kcZyY5Krkor+lq9A0grAHXxTRT2cf3mqYx9+w==
X-Received: by 2002:a05:6000:2112:b0:3d2:6129:5505 with SMTP id ffacd0b85a97d-3d261295a85mr473234f8f.36.1756548864610;
        Sat, 30 Aug 2025 03:14:24 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:23 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 05/12] fix: improve rsb struct
Date: Sat, 30 Aug 2025 12:14:06 +0200
Message-ID: <20250830101413.602637-5-226562783+SigAttilio@users.noreply.github.com>
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
 fs/dlm/lock.c | 885 +++++++++++++++++++++++---------------------------
 1 file changed, 414 insertions(+), 471 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index de77a0e9e2db..320a652e1691 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1388,591 +1388,534 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
 		dlm_free_rsb(r);
 		goto retry;
-	} else if (error) {
-		write_unlock_bh(&ls->ls_rsbtbl_lock);
-		/* should never happen */
-		dlm_free_rsb(r);
-		goto retry;
+	} else if (!error) {
+		list_add(&r->res_slow_list, &ls->ls_slow_active);
 	}
-
-	list_add(&r->res_slow_list, &ls->ls_slow_inactive);
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
-
-	if (result)
-		*result = DLM_LU_ADD;
-	*r_nodeid = from_nodeid;
  out:
+	*r_ret = r;
 	return error;
 }
 
-int dlm_master_lookup(struct dlm_ls *ls, int from_nodeid, const char *name,
-		      int len, unsigned int flags, int *r_nodeid, int *result)
-{
-	int rv;
-	rcu_read_lock();
-	rv = _dlm_master_lookup(ls, from_nodeid, name, len, flags, r_nodeid, result);
-	rcu_read_unlock();
-	return rv;
-}
-
-static void dlm_dump_rsb_hash(struct dlm_ls *ls, uint32_t hash)
-{
-	struct dlm_rsb *r;
-
-	read_lock_bh(&ls->ls_rsbtbl_lock);
-	list_for_each_entry(r, &ls->ls_slow_active, res_slow_list) {
-		if (r->res_hash == hash)
-			dlm_dump_rsb(r);
-	}
-	read_unlock_bh(&ls->ls_rsbtbl_lock);
-}
+/* During recovery, other nodes can send us new MSTCPY locks (from
+   dlm_recover_locks) before we've made ourself master (in
+   dlm_recover_masters). */
 
-void dlm_dump_rsb_name(struct dlm_ls *ls, const char *name, int len)
+static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
+			  uint32_t hash, int dir_nodeid, int from_nodeid,
+			  unsigned int flags, struct dlm_rsb **r_ret)
 {
 	struct dlm_rsb *r = NULL;
+	int our_nodeid = dlm_our_nodeid();
+	int recover = (flags & R_RECEIVE_RECOVER);
 	int error;
 
-	rcu_read_lock();
+ retry:
 	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
-	if (!error)
-		goto out;
-
-	dlm_dump_rsb(r);
- out:
-	rcu_read_unlock();
-}
+	if (error)
+		goto do_new;
 
-static void deactivate_rsb(struct kref *kref)
-{
-	struct dlm_rsb *r = container_of(kref, struct dlm_rsb, res_ref);
-	struct dlm_ls *ls = r->res_ls;
-	int our_nodeid = dlm_our_nodeid();
+	/* check if the rsb is in active state under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
+	if (!rsb_flag(r, RSB_HASHED)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
 
-	DLM_ASSERT(list_empty(&r->res_root_list), dlm_print_rsb(r););
-	rsb_set_flag(r, RSB_INACTIVE);
-	list_move(&r->res_slow_list, &ls->ls_slow_inactive);
+	if (rsb_flag(r, RSB_INACTIVE)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_inactive;
+	}
 
 	/*
-	 * When the rsb becomes unused, there are two possibilities:
-	 * 1. Leave the inactive rsb in place (don't remove it).
-	 * 2. Add it to the scan list to be removed.
-	 *
-	 * 1 is done when the rsb is acting as the dir record
-	 * for a remotely mastered rsb.  The rsb must be left
-	 * in place as an inactive rsb to act as the dir record.
-	 *
-	 * 2 is done when a) the rsb is not the master and not the
-	 * dir record, b) when the rsb is both the master and the
-	 * dir record, c) when the rsb is master but not dir record.
-	 *
-	 * (If no directory is used, the rsb can always be removed.)
+	 * rsb is active, so we can't check master_nodeid without lock_rsb.
 	 */
-	if (dlm_no_directory(ls) ||
-	    (r->res_master_nodeid == our_nodeid ||
-	     dlm_dir_nodeid(r) != our_nodeid))
-		add_scan(ls, r);
-
-	if (r->res_lvbptr) {
-		dlm_free_lvb(r->res_lvbptr);
-		r->res_lvbptr = NULL;
-	}
-}
-
-void free_inactive_rsb(struct dlm_rsb *r)
-{
-	WARN_ON_ONCE(!rsb_flag(r, RSB_INACTIVE));
 
-	DLM_ASSERT(list_empty(&r->res_lookup), dlm_dump_rsb(r););
-	DLM_ASSERT(list_empty(&r->res_grantqueue), dlm_dump_rsb(r););
-	DLM_ASSERT(list_empty(&r->res_convertqueue), dlm_dump_rsb(r););
-	DLM_ASSERT(list_empty(&r->res_waitqueue), dlm_dump_rsb(r););
-	DLM_ASSERT(list_empty(&r->res_root_list), dlm_dump_rsb(r););
-	DLM_ASSERT(list_empty(&r->res_scan_list), dlm_dump_rsb(r););
-	DLM_ASSERT(list_empty(&r->res_recover_list), dlm_dump_rsb(r););
-	DLM_ASSERT(list_empty(&r->res_masters_list), dlm_dump_rsb(r););
+	kref_get(&r->res_ref);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	dlm_free_rsb(r);
-}
+	goto out;
 
-/* Attaching/detaching lkb's from rsb's is for rsb reference counting.
-   The rsb must exist as long as any lkb's for it do. */
 
-static void attach_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	hold_rsb(r);
-	lkb->lkb_resource = r;
-}
+ do_inactive:
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 
-static void detach_lkb(struct dlm_lkb *lkb)
-{
-	if (lkb->lkb_resource) {
-		put_rsb(lkb->lkb_resource);
-		lkb->lkb_resource = NULL;
+	/* See comment in find_rsb_dir. */
+	if (rsb_flag(r, RSB_HASHED)) {
+		if (!rsb_flag(r, RSB_INACTIVE)) {
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
+			goto retry;
+		}
+	} else {
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
 	}
-}
-
-static int _create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret,
-		       unsigned long start, unsigned long end)
-{
-	struct xa_limit limit;
-	struct dlm_lkb *lkb;
-	int rv;
 
-	limit.max = end;
-	limit.min = start;
 
-	lkb = dlm_allocate_lkb();
-	if (!lkb)
-		return -ENOMEM;
-
-	lkb->lkb_last_bast_cb_mode = DLM_LOCK_IV;
-	lkb->lkb_last_cast_cb_mode = DLM_LOCK_IV;
-	lkb->lkb_last_cb_mode = DLM_LOCK_IV;
-	lkb->lkb_nodeid = -1;
-	lkb->lkb_grmode = DLM_LOCK_IV;
-	kref_init(&lkb->lkb_ref);
-	INIT_LIST_HEAD(&lkb->lkb_ownqueue);
-	INIT_LIST_HEAD(&lkb->lkb_rsb_lookup);
+	/*
+	 * rsb found inactive. No other thread is using this rsb because
+	 * it's inactive, so we can look at or update res_master_nodeid
+	 * without lock_rsb.
+	 */
 
-	write_lock_bh(&ls->ls_lkbxa_lock);
-	rv = xa_alloc(&ls->ls_lkbxa, &lkb->lkb_id, lkb, limit, GFP_ATOMIC);
-	write_unlock_bh(&ls->ls_lkbxa_lock);
+	if (!recover && (r->res_master_nodeid != our_nodeid) && from_nodeid) {
+		/* our rsb is not master, and another node has sent us a
+		   request; this should never happen */
+		log_error(ls, "find_rsb inactive from_nodeid %d master %d dir %d",
+			  from_nodeid, r->res_master_nodeid, dir_nodeid);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -ENOTBLK;
+		goto out;
+	}
 
-	if (rv < 0) {
-		log_error(ls, "create_lkb xa error %d", rv);
-		dlm_free_lkb(lkb);
-		return rv;
+	if (!recover && (r->res_master_nodeid != our_nodeid) &&
+	    (dir_nodeid == our_nodeid)) {
+		/* our rsb is not master, and we are dir; may as well fix it;
+		   this should never happen */
+		log_error(ls, "find_rsb inactive our %d master %d dir %d",
+			  our_nodeid, r->res_master_nodeid, dir_nodeid);
+		dlm_print_rsb(r);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
 	}
 
-	*lkb_ret = lkb;
-	return 0;
-}
+	del_scan(ls, r);
+	list_move(&r->res_slow_list, &ls->ls_slow_active);
+	rsb_clear_flag(r, RSB_INACTIVE);
+	kref_init(&r->res_ref); /* ref is now used in active state */
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-static int create_lkb(struct dlm_ls *ls, struct dlm_lkb **lkb_ret)
-{
-	return _create_lkb(ls, lkb_ret, 1, ULONG_MAX);
-}
+	goto out;
 
-static int find_lkb(struct dlm_ls *ls, uint32_t lkid, struct dlm_lkb **lkb_ret)
-{
-	struct dlm_lkb *lkb;
 
-	rcu_read_lock();
-	lkb = xa_load(&ls->ls_lkbxa, lkid);
-	if (lkb) {
-		/* check if lkb is still part of lkbxa under lkbxa_lock as
-		 * the lkb_ref is tight to the lkbxa data structure, see
-		 * __put_lkb().
-		 */
-		read_lock_bh(&ls->ls_lkbxa_lock);
-		if (kref_read(&lkb->lkb_ref))
-			kref_get(&lkb->lkb_ref);
-		else
-			lkb = NULL;
-		read_unlock_bh(&ls->ls_lkbxa_lock);
-	}
-	rcu_read_unlock();
+ do_new:
+	/*
+	 * rsb not found
+	 */
 
-	*lkb_ret = lkb;
-	return lkb ? 0 : -ENOENT;
-}
+	if (error == -EBADR && !create)
+		goto out;
 
-static void kill_lkb(struct kref *kref)
-{
-	struct dlm_lkb *lkb = container_of(kref, struct dlm_lkb, lkb_ref);
+	error = get_rsb_struct(ls, name, len, &r);
+	if (WARN_ON_ONCE(error))
+		goto out;
 
-	/* All work is done after the return from kref_put() so we
-	   can release the write_lock before the detach_lkb */
+	r->res_hash = hash;
+	r->res_dir_nodeid = dir_nodeid;
+	kref_init(&r->res_ref);
 
-	DLM_ASSERT(!lkb->lkb_status, dlm_print_lkb(lkb););
-}
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
+	}
 
-/* __put_lkb() is used when an lkb may not have an rsb attached to
-   it so we need to provide the lockspace explicitly */
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
+		goto out;
+	}
 
-static int __put_lkb(struct dlm_ls *ls, struct dlm_lkb *lkb)
-{
-	uint32_t lkid = lkb->lkb_id;
-	int rv;
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
+	}
 
-	rv = dlm_kref_put_write_lock_bh(&lkb->lkb_ref, kill_lkb,
-					&ls->ls_lkbxa_lock);
-	if (rv) {
-		xa_erase(&ls->ls_lkbxa, lkid);
-		write_unlock_bh(&ls->ls_lkbxa_lock);
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
 
-		detach_lkb(lkb);
+ out_add:
 
-		/* for local/process lkbs, lvbptr points to caller's lksb */
-		if (lkb->lkb_lvbptr && is_master_copy(lkb))
-			dlm_free_lvb(lkb->lkb_lvbptr);
-		dlm_free_lkb(lkb);
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
-	return rv;
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
+ out:
+	*r_ret = r;
+	return error;
 }
 
-int dlm_put_lkb(struct dlm_lkb *lkb)
-{
-	struct dlm_ls *ls;
+/* During recovery, other nodes can send us new MSTCPY locks (from
+   dlm_recover_locks) before we've made ourself master (in
+   dlm_recover_masters). */
 
-	DLM_ASSERT(lkb->lkb_resource, dlm_print_lkb(lkb););
-	DLM_ASSERT(lkb->lkb_resource->res_ls, dlm_print_lkb(lkb););
+static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
+			  uint32_t hash, int dir_nodeid, int from_nodeid,
+			  unsigned int flags, struct dlm_rsb **r_ret)
+{
+	struct dlm_rsb *r = NULL;
+	int our_nodeid = dlm_our_nodeid();
+	int recover = (flags & R_RECEIVE_RECOVER);
+	int error;
 
-	ls = lkb->lkb_resource->res_ls;
-	return __put_lkb(ls, lkb);
-}
+ retry:
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (error)
+		goto do_new;
 
-/* This is only called to add a reference when the code already holds
-   a valid reference to the lkb, so there's no need for locking. */
+	/* check if the rsb is in active state under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
+	if (!rsb_flag(r, RSB_HASHED)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
 
-static inline void hold_lkb(struct dlm_lkb *lkb)
-{
-	kref_get(&lkb->lkb_ref);
-}
+	if (rsb_flag(r, RSB_INACTIVE)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_inactive;
+	}
 
-static void unhold_lkb_assert(struct kref *kref)
-{
-	struct dlm_lkb *lkb = container_of(kref, struct dlm_lkb, lkb_ref);
+	/*
+	 * rsb is active, so we can't check master_nodeid without lock_rsb.
+	 */
 
-	DLM_ASSERT(false, dlm_print_lkb(lkb););
-}
+	kref_get(&r->res_ref);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 
-/* This is called when we need to remove a reference and are certain
-   it's not the last ref.  e.g. del_lkb is always called between a
-   find_lkb/put_lkb and is always the inverse of a previous add_lkb.
-   put_lkb would work fine, but would involve unnecessary locking */
+	goto out;
 
-static inline void unhold_lkb(struct dlm_lkb *lkb)
-{
-	kref_put(&lkb->lkb_ref, unhold_lkb_assert);
-}
 
-static void lkb_add_ordered(struct list_head *new, struct list_head *head,
-			    int mode)
-{
-	struct dlm_lkb *lkb = NULL, *iter;
+ do_inactive:
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 
-	list_for_each_entry(iter, head, lkb_statequeue)
-		if (iter->lkb_rqmode < mode) {
-			lkb = iter;
-			list_add_tail(new, &iter->lkb_statequeue);
-			break;
+	/* See comment in find_rsb_dir. */
+	if (rsb_flag(r, RSB_HASHED)) {
+		if (!rsb_flag(r, RSB_INACTIVE)) {
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
+			goto retry;
 		}
+	} else {
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
 
-	if (!lkb)
-		list_add_tail(new, head);
-}
 
-/* add/remove lkb to rsb's grant/convert/wait queue */
-
-static void add_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int status)
-{
-	kref_get(&lkb->lkb_ref);
-
-	DLM_ASSERT(!lkb->lkb_status, dlm_print_lkb(lkb););
-
-	lkb->lkb_timestamp = ktime_get();
-
-	lkb->lkb_status = status;
+	/*
+	 * rsb found inactive. No other thread is using this rsb because
+	 * it's inactive, so we can look at or update res_master_nodeid
+	 * without lock_rsb.
+	 */
 
-	switch (status) {
-	case DLM_LKSTS_WAITING:
-		if (lkb->lkb_exflags & DLM_LKF_HEADQUE)
-			list_add(&lkb->lkb_statequeue, &r->res_waitqueue);
-		else
-			list_add_tail(&lkb->lkb_statequeue, &r->res_waitqueue);
-		break;
-	case DLM_LKSTS_GRANTED:
-		/* convention says granted locks kept in order of grmode */
-		lkb_add_ordered(&lkb->lkb_statequeue, &r->res_grantqueue,
-				lkb->lkb_grmode);
-		break;
-	case DLM_LKSTS_CONVERT:
-		if (lkb->lkb_exflags & DLM_LKF_HEADQUE)
-			list_add(&lkb->lkb_statequeue, &r->res_convertqueue);
-		else
-			list_add_tail(&lkb->lkb_statequeue,
-				      &r->res_convertqueue);
-		break;
-	default:
-		DLM_ASSERT(0, dlm_print_lkb(lkb); printk("sts=%d\n", status););
+	if (!recover && (r->res_master_nodeid != our_nodeid) && from_nodeid) {
+		/* our rsb is not master, and another node has sent us a
+		   request; this should never happen */
+		log_error(ls, "find_rsb inactive from_nodeid %d master %d dir %d",
+			  from_nodeid, r->res_master_nodeid, dir_nodeid);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -ENOTBLK;
+		goto out;
 	}
-}
-
-static void del_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	lkb->lkb_status = 0;
-	list_del(&lkb->lkb_statequeue);
-	unhold_lkb(lkb);
-}
-
-static void move_lkb(struct dlm_rsb *r, struct dlm_lkb *lkb, int sts)
-{
-	del_lkb(r, lkb);
-	add_lkb(r, lkb, sts);
-}
 
-static int msg_reply_type(int mstype)
-{
-	switch (mstype) {
-	case DLM_MSG_REQUEST:
-		return DLM_MSG_REQUEST_REPLY;
-	case DLM_MSG_CONVERT:
-		return DLM_MSG_CONVERT_REPLY;
-	case DLM_MSG_UNLOCK:
-		return DLM_MSG_UNLOCK_REPLY;
-	case DLM_MSG_CANCEL:
-		return DLM_MSG_CANCEL_REPLY;
-	case DLM_MSG_LOOKUP:
-		return DLM_MSG_LOOKUP_REPLY;
+	if (!recover && (r->res_master_nodeid != our_nodeid) &&
+	    (dir_nodeid == our_nodeid)) {
+		/* our rsb is not master, and we are dir; may as well fix it;
+		   this should never happen */
+		log_error(ls, "find_rsb inactive our %d master %d dir %d",
+			  our_nodeid, r->res_master_nodeid, dir_nodeid);
+		dlm_print_rsb(r);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
 	}
-	return -1;
-}
-
-/* add/remove lkb from global waiters list of lkb's waiting for
-   a reply from a remote node */
 
-static void add_to_waiters(struct dlm_lkb *lkb, int mstype, int to_nodeid)
-{
-	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
+	del_scan(ls, r);
+	list_move(&r->res_slow_list, &ls->ls_slow_active);
+	rsb_clear_flag(r, RSB_INACTIVE);
+	kref_init(&r->res_ref); /* ref is now used in active state */
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	spin_lock_bh(&ls->ls_waiters_lock);
-	if (lkb->lkb_wait_type || is_overlap_cancel(lkb)) {
-		switch (mstype) {
-		case DLM_MSG_UNLOCK:
-			set_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
-			break;
-		case DLM_MSG_CANCEL:
-			set_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
-			break;
-		default:
-			/* should never happen as validate_lock_args() checks
-			 * on lkb_wait_type and validate_unlock_args() only
-			 * creates UNLOCK or CANCEL messages.
-			 */
-			WARN_ON_ONCE(1);
-			goto out;
-		}
-		lkb->lkb_wait_count++;
-		hold_lkb(lkb);
+	goto out;
 
-		log_debug(ls, "addwait %x cur %d overlap %d count %d f %x",
-			  lkb->lkb_id, lkb->lkb_wait_type, mstype,
-			  lkb->lkb_wait_count, dlm_iflags_val(lkb));
-		goto out;
-	}
 
-	DLM_ASSERT(!lkb->lkb_wait_count,
-		   dlm_print_lkb(lkb);
-		   printk("wait_count %d\n", lkb->lkb_wait_count););
+ do_new:
+	/*
+	 * rsb not found
+	 */
 
-	lkb->lkb_wait_count++;
-	lkb->lkb_wait_type = mstype;
-	lkb->lkb_wait_nodeid = to_nodeid; /* for debugging */
-	hold_lkb(lkb);
-	list_add(&lkb->lkb_wait_reply, &ls->ls_waiters);
- out:
-	spin_unlock_bh(&ls->ls_waiters_lock);
-}
+	if (error == -EBADR && !create)
+		goto out;
 
-/* We clear the RESEND flag because we might be taking an lkb off the waiters
-   list as part of process_requestqueue (e.g. a lookup that has an optimized
-   request reply on the requestqueue) between dlm_recover_waiters_pre() which
-   set RESEND and dlm_recover_waiters_post() */
+	error = get_rsb_struct(ls, name, len, &r);
+	if (WARN_ON_ONCE(error))
+		goto out;
 
-static int _remove_from_waiters(struct dlm_lkb *lkb, int mstype,
-				const struct dlm_message *ms)
-{
-	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
-	int overlap_done = 0;
+	r->res_hash = hash;
+	r->res_dir_nodeid = dir_nodeid;
+	kref_init(&r->res_ref);
 
-	if (mstype == DLM_MSG_UNLOCK_REPLY &&
-	    test_and_clear_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags)) {
-		log_debug(ls, "remwait %x unlock_reply overlap", lkb->lkb_id);
-		overlap_done = 1;
-		goto out_del;
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
 	}
 
-	if (mstype == DLM_MSG_CANCEL_REPLY &&
-	    test_and_clear_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags)) {
-		log_debug(ls, "remwait %x cancel_reply overlap", lkb->lkb_id);
-		overlap_done = 1;
-		goto out_del;
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
+		goto out;
 	}
 
-	/* Cancel state was preemptively cleared by a successful convert,
-	   see next comment, nothing to do. */
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
+	}
 
-	if ((mstype == DLM_MSG_CANCEL_REPLY) &&
-	    (lkb->lkb_wait_type != DLM_MSG_CANCEL)) {
-		log_debug(ls, "remwait %x cancel_reply wait_type %d",
-			  lkb->lkb_id, lkb->lkb_wait_type);
-		return -1;
+	if (dir_nodeid == our_nodeid) {
+		/* When we are the dir nodeid, we can set the master
+		   node immediately */
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+	} else {
+		/* set_master will send_lookup to dir_nodeid */
+		r->res_master_nodeid = 0;
+		r->res_nodeid = -1;
 	}
 
-	/* Remove for the convert reply, and premptively remove for the
-	   cancel reply.  A convert has been granted while there's still
-	   an outstanding cancel on it (the cancel is moot and the result
-	   in the cancel reply should be 0).  We preempt the cancel reply
-	   because the app gets the convert result and then can follow up
-	   with another op, like convert.  This subsequent op would see the
-	   lingering state of the cancel and fail with -EBUSY. */
+ out_add:
 
-	if ((mstype == DLM_MSG_CONVERT_REPLY) &&
-	    (lkb->lkb_wait_type == DLM_MSG_CONVERT) && ms && !ms->m_result &&
-	    test_and_clear_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags)) {
-		log_debug(ls, "remwait %x convert_reply zap overlap_cancel",
-			  lkb->lkb_id);
-		lkb->lkb_wait_type = 0;
-		lkb->lkb_wait_count--;
-		unhold_lkb(lkb);
-		goto out_del;
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
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
+ out:
+	*r_ret = r;
+	return error;
+}
 
-	/* N.B. type of reply may not always correspond to type of original
-	   msg due to lookup->request optimization, verify others? */
+/* During recovery, other nodes can send us new MSTCPY locks (from
+   dlm_recover_locks) before we've made ourself master (in
+   dlm_recover_masters). */
 
-	if (lkb->lkb_wait_type) {
-		lkb->lkb_wait_type = 0;
-		goto out_del;
-	}
+static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
+			  uint32_t hash, int dir_nodeid, int from_nodeid,
+			  unsigned int flags, struct dlm_rsb **r_ret)
+{
+	struct dlm_rsb *r = NULL;
+	int our_nodeid = dlm_our_nodeid();
+	int recover = (flags & R_RECEIVE_RECOVER);
+	int error;
 
-	log_error(ls, "remwait error %x remote %d %x msg %d flags %x no wait",
-		  lkb->lkb_id, ms ? le32_to_cpu(ms->m_header.h_nodeid) : 0,
-		  lkb->lkb_remid, mstype, dlm_iflags_val(lkb));
-	return -1;
+ retry:
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (error)
+		goto do_new;
 
- out_del:
-	/* the force-unlock/cancel has completed and we haven't recvd a reply
-	   to the op that was in progress prior to the unlock/cancel; we
-	   give up on any reply to the earlier op.  FIXME: not sure when/how
-	   this would happen */
+	/* check if the rsb is in active state under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
+	if (!rsb_flag(r, RSB_HASHED)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
 
-	if (overlap_done && lkb->lkb_wait_type) {
-		log_error(ls, "remwait error %x reply %d wait_type %d overlap",
-			  lkb->lkb_id, mstype, lkb->lkb_wait_type);
-		lkb->lkb_wait_count--;
-		unhold_lkb(lkb);
-		lkb->lkb_wait_type = 0;
+	if (rsb_flag(r, RSB_INACTIVE)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_inactive;
 	}
 
-	DLM_ASSERT(lkb->lkb_wait_count, dlm_print_lkb(lkb););
+	/*
+	 * rsb is active, so we can't check master_nodeid without lock_rsb.
+	 */
 
-	clear_bit(DLM_IFL_RESEND_BIT, &lkb->lkb_iflags);
-	lkb->lkb_wait_count--;
-	if (!lkb->lkb_wait_count)
-		list_del_init(&lkb->lkb_wait_reply);
-	unhold_lkb(lkb);
-	return 0;
-}
+	kref_get(&r->res_ref);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 
-static int remove_from_waiters(struct dlm_lkb *lkb, int mstype)
-{
-	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
-	int error;
+	goto out;
 
-	spin_lock_bh(&ls->ls_waiters_lock);
-	error = _remove_from_waiters(lkb, mstype, NULL);
-	spin_unlock_bh(&ls->ls_waiters_lock);
-	return error;
-}
 
-/* Handles situations where we might be processing a "fake" or "local" reply in
- * the recovery context which stops any locking activity. Only debugfs might
- * change the lockspace waiters but they will held the recovery lock to ensure
- * remove_from_waiters_ms() in local case will be the only user manipulating the
- * lockspace waiters in recovery context.
- */
+ do_inactive:
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 
-static int remove_from_waiters_ms(struct dlm_lkb *lkb,
-				  const struct dlm_message *ms, bool local)
-{
-	struct dlm_ls *ls = lkb->lkb_resource->res_ls;
-	int error;
+	/* See comment in find_rsb_dir. */
+	if (rsb_flag(r, RSB_HASHED)) {
+		if (!rsb_flag(r, RSB_INACTIVE)) {
+			write_unlock_bh(&ls->ls_rsbtbl_lock);
+			goto retry;
+		}
+	} else {
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
 
-	if (!local)
-		spin_lock_bh(&ls->ls_waiters_lock);
-	else
-		WARN_ON_ONCE(!rwsem_is_locked(&ls->ls_in_recovery) ||
-			     !dlm_locking_stopped(ls));
-	error = _remove_from_waiters(lkb, le32_to_cpu(ms->m_type), ms);
-	if (!local)
-		spin_unlock_bh(&ls->ls_waiters_lock);
-	return error;
-}
 
-/* lkb is master or local copy */
+	/*
+	 * rsb found inactive. No other thread is using this rsb because
+	 * it's inactive, so we can look at or update res_master_nodeid
+	 * without lock_rsb.
+	 */
 
-static void set_lvb_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	int b, len = r->res_ls->ls_lvblen;
+	if (!recover && (r->res_master_nodeid != our_nodeid) && from_nodeid) {
+		/* our rsb is not master, and another node has sent us a
+		   request; this should never happen */
+		log_error(ls, "find_rsb inactive from_nodeid %d master %d dir %d",
+			  from_nodeid, r->res_master_nodeid, dir_nodeid);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -ENOTBLK;
+		goto out;
+	}
 
-	/* b=1 lvb returned to caller
-	   b=0 lvb written to rsb or invalidated
-	   b=-1 do nothing */
+	if (!recover && (r->res_master_nodeid != our_nodeid) &&
+	    (dir_nodeid == our_nodeid)) {
+		/* our rsb is not master, and we are dir; may as well fix it;
+		   this should never happen */
+		log_error(ls, "find_rsb inactive our %d master %d dir %d",
+			  our_nodeid, r->res_master_nodeid, dir_nodeid);
+		dlm_print_rsb(r);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+	}
 
-	b =  dlm_lvb_operations[lkb->lkb_grmode + 1][lkb->lkb_rqmode + 1];
+	del_scan(ls, r);
+	list_move(&r->res_slow_list, &ls->ls_slow_active);
+	rsb_clear_flag(r, RSB_INACTIVE);
+	kref_init(&r->res_ref); /* ref is now used in active state */
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	if (b == 1) {
-		if (!lkb->lkb_lvbptr)
-			return;
+	goto out;
 
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
-			return;
 
-		if (!r->res_lvbptr)
-			return;
+ do_new:
+	/*
+	 * rsb not found
+	 */
 
-		memcpy(lkb->lkb_lvbptr, r->res_lvbptr, len);
-		lkb->lkb_lvbseq = r->res_lvbseq;
+	if (error == -EBADR && !create)
+		goto out;
 
-	} else if (b == 0) {
-		if (lkb->lkb_exflags & DLM_LKF_IVVALBLK) {
-			rsb_set_flag(r, RSB_VALNOTVALID);
-			return;
-		}
+	error = get_rsb_struct(ls, name, len, &r);
+	if (WARN_ON_ONCE(error))
+		goto out;
 
-		if (!lkb->lkb_lvbptr)
-			return;
+	r->res_hash = hash;
+	r->res_dir_nodeid = dir_nodeid;
+	kref_init(&r->res_ref);
 
-		if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
-			return;
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
+	}
 
-		if (!r->res_lvbptr)
-			r->res_lvbptr = dlm_allocate_lvb(r->res_ls);
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
+		goto out;
+	}
 
-		if (!r->res_lvbptr)
-			return;
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
+	}
 
-		memcpy(r->res_lvbptr, lkb->lkb_lvbptr, len);
-		r->res_lvbseq++;
-		lkb->lkb_lvbseq = r->res_lvbseq;
-		rsb_clear_flag(r, RSB_VALNOTVALID);
+	if (dir_nodeid == our_nodeid) {
+		/* When we are the dir nodeid, we can set the master
+		   node immediately */
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+	} else {
+		/* set_master will send_lookup to dir_nodeid */
+		r->res_master_nodeid = 0;
+		r->res_nodeid = -1;
 	}
 
-	if (rsb_flag(r, RSB_VALNOTVALID))
-		set_bit(DLM_SBF_VALNOTVALID_BIT, &lkb->lkb_sbflags);
+ out_add:
+
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
+	}
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
+ out:
+	*r_ret = r;
+	return error;
 }
 
-static void set_lvb_unlock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+/* During recovery, other nodes can send us new MSTCPY locks (from
+   dlm_recover_locks) before we've made ourself master (in
+   dlm_recover_masters). */
+
+static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
+			  uint32_t hash, int dir_nodeid, int from_nodeid,
+			  unsigned int flags, struct dlm_rsb **r_ret)
 {
-	if (lkb->lkb_grmode < DLM_LOCK_PW)
-		return;
+	struct dlm_rsb *r = NULL;
+	int our_nodeid = dlm_our_nodeid();
+	int recover = (flags & R_RECEIVE_RECOVER);
+	int error;
 
-	if (lkb->lkb_exflags & DLM_LKF_IVVALBLK) {
-		rsb_set_flag(r, RSB_VALNOTVALID);
-		return;
-	}
+ retry:
+	error = dlm_search_rsb_tree(&ls->ls_rsbtbl, name, len, &r);
+	if (error)
+		goto do_new;
 
-	if (!lkb->lkb_lvbptr)
-		return;
+	/* check if the rsb is in active state under read lock - likely path */
+	read_lock_bh(&ls->ls_rsbtbl_lock);
+	if (!rsb_flag(r, RSB_HASHED)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_new;
+	}
 
-	if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
-		return;
+	if (rsb_flag(r, RSB_INACTIVE)) {
+		read_unlock_bh(&ls->ls_rsbtbl_lock);
+		goto do_inactive;
+	}
 
-	if (!r->res_lvbptr)
-		r->res_lvbptr = dlm_allocate_lvb(r->res_ls);
+	/*
+	 * rsb is active, so we can't check master_nodeid without lock_rsb.
+	 */
 
 	if (!r->res_lvbptr)
 		return;
-- 
2.48.1


