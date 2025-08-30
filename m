Return-Path: <linux-kernel+bounces-792884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ADEB3CA00
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A053B6FCB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABECC272E4E;
	Sat, 30 Aug 2025 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANI6c7rM"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8D27056D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548871; cv=none; b=srkyVaiShq+Z3icVfnIfJjoRTLjKscLuHQMyGdbvzBiZI5JNL73hvjAOT2BmPIyX2yO9VEMIcfNIL4sSZjm8Rf7MZv4DqPNO7so0bT+buft6rWYTFR4YltB++3/9/dhiwFrHSQxsex7/KdXuysXc3hv+nsPjflK4XY+c3GIzIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548871; c=relaxed/simple;
	bh=XNi4zefz/Tdc1OpGL8DI9rSbAQ36S4+wPVmDU5qExoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwDTkubliJxpxH9ky/QcVqltLL460mhb1jnczijcIbkc0UkmJJLTpp2r2hvH/F1OMQ4w4IiIqXp00QBWFN5ClFrb82WuIY9evThMETiyUzLzwlY4WZASDps0GaMVTQXu1IHCwHrSpoJRG9igu0ZyvByHF4N9B3b2ETH852JZlio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANI6c7rM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ce47d1f1f8so1816837f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548866; x=1757153666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NMy5xb2n/+45tKrQgk51NSLn+/5//njGZ01D2SG2GU=;
        b=ANI6c7rMlaRZ7oJFmy9YAVsLUdXsQ8LZVR6+OpRuPg8ny8PnPtvdkTu+Bm5c0XfZIl
         WEPtwfrTO2xnHAFrMGP8AfMkBfiPpxs+TkE73HMT98hOVoPwR2Wpe8uZh4tJzWXN9ujR
         DWQuVbnBj+mmptWoEs+SIPJod+jM5p+bPdcpnq7riydzAAA3pGiyL9l5wqgkcsyZ6taW
         WL2wLYYTSziOYknF/vbkGIr8Aot3N8GnULm3QqAH1jhdtpMV3DA3EN7dRxYVneblgvDu
         TsomNhW9ByFkO62V7Edx+ro+L/QDdUUrbzDQTh706Z4OSiYvLkuYjFZdsqH1obm7mbUc
         Z4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548866; x=1757153666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NMy5xb2n/+45tKrQgk51NSLn+/5//njGZ01D2SG2GU=;
        b=f3AxDNcJchTCvQ6bC9jrA/FzEqc5EoFt83L4/7nVUExaZv2isYUT2pgw8eQsDUzXPA
         iA3DH3BGgtbocxxUfuDSt0JFedT7rFFfLi/fL2xHFScoUBaBC1GjxMg3ewyKwM6wekeJ
         NS9PkeN5rHGnIcraH93t3Z1CoHbxZbXQh4f2M2SDh3K3zzRCkHEkmsStv6XPnGouT4Re
         4yrjH2NtrEGilW69fSiWfUnZJpH/p2hKit4YlTPIhg+SA1UbHSjHgBBjiDc9L5jVtxSJ
         Rie6UyciVEXUfjVdPU/y9SU/3wltYuwGSHm/MFbsWeMbuZVAFKu4+SvvBUnLGc5ZGtwD
         kSaw==
X-Gm-Message-State: AOJu0YzCZ4Ays9zfPfypSbnHSWxbhlFbTa9kyflMRUq1SgXo2rw3BfU8
	+TDfi/IDd5wpN2JEOZ2lk5kpDQg/ay6ECByvZRg/HPlEp/udcn8LT6W2
X-Gm-Gg: ASbGncvgkyX8UOAyZjtmSeofn3LrVT9dv70NrhZQsevwFcDM4utscfBqbK1rbRdPljR
	U1shK9/fpRMH+Piuz6WBgzSSmt4tSUY8ZWuG3JS8iZnYwQsqSzLAZDXV2Gv7FfVWlcy8XsbR7cS
	XqH52RtyzK96fmUBCDvafSCBQBczn8XB2BjRzSmyMf5yLUPVeRo6Ph/cat8BglHtQECUJuSX68e
	j2Gm2Z19SFanOYJJB69PO3aK/DmXGO/eDWxjHOmWqPauJciwtpMDSsUCLh7NGh+tqQEEj4Ggbl4
	1KGJKjAjARdzr3fId+p0bfgjCkNzF1gp4INgilwJk5uT6EqFnfthtSOKH66QrBGlefADoHC2Skq
	n3d9GE8uaS5uCQRjYg/mNDzqxY3dp7sYrqxOcAEXyHMaWYNaAm7SORn7ePVu/4s1NKD5JvUDP6w
	WUPVB5/JBKV4zda++eo3quB7rY2l/Na2ti4ReR3vSFQ7BPk1pnwOiQRzMOEL3EBEd2tC0xakRDU
	0eXWEXPAQQ1rFzJ+dmiN7VnRvwv2w==
X-Google-Smtp-Source: AGHT+IEOHqUGEWonBtcpMm+1n53Bl9Fb/ZS6nJTYOUfKpnVZsGmH1t2LijadeO65xMYuWg8ag2OCmA==
X-Received: by 2002:a5d:5d87:0:b0:3c9:52db:9f64 with SMTP id ffacd0b85a97d-3d1dcf57a08mr759457f8f.22.1756548865593;
        Sat, 30 Aug 2025 03:14:25 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:25 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 06/12] fix: improve dlm_rsb struct
Date: Sat, 30 Aug 2025 12:14:07 +0200
Message-ID: <20250830101413.602637-6-226562783+SigAttilio@users.noreply.github.com>
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
 fs/dlm/lock.c | 1003 +++++++++++++++++++++++--------------------------
 1 file changed, 460 insertions(+), 543 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index 320a652e1691..4d5e4548d9f9 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1917,674 +1917,591 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 	 * rsb is active, so we can't check master_nodeid without lock_rsb.
 	 */
 
-	if (!r->res_lvbptr)
-		return;
+	kref_get(&r->res_ref);
+	read_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	memcpy(r->res_lvbptr, lkb->lkb_lvbptr, r->res_ls->ls_lvblen);
-	r->res_lvbseq++;
-	rsb_clear_flag(r, RSB_VALNOTVALID);
-}
+	goto out;
 
-/* lkb is process copy (pc) */
 
-static void set_lvb_lock_pc(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			    const struct dlm_message *ms)
-{
-	int b;
+ do_inactive:
+	write_lock_bh(&ls->ls_rsbtbl_lock);
 
-	if (!lkb->lkb_lvbptr)
-		return;
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
 
-	if (!(lkb->lkb_exflags & DLM_LKF_VALBLK))
-		return;
 
-	b = dlm_lvb_operations[lkb->lkb_grmode + 1][lkb->lkb_rqmode + 1];
-	if (b == 1) {
-		int len = receive_extralen(ms);
-		if (len > r->res_ls->ls_lvblen)
-			len = r->res_ls->ls_lvblen;
-		memcpy(lkb->lkb_lvbptr, ms->m_extra, len);
-		lkb->lkb_lvbseq = le32_to_cpu(ms->m_lvbseq);
+	/*
+	 * rsb found inactive. No other thread is using this rsb because
+	 * it's inactive, so we can look at or update res_master_nodeid
+	 * without lock_rsb.
+	 */
+
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
 
-/* Manipulate lkb's on rsb's convert/granted/waiting queues
-   remove_lock -- used for unlock, removes lkb from granted
-   revert_lock -- used for cancel, moves lkb from convert to granted
-   grant_lock  -- used for request and convert, adds lkb to granted or
-                  moves lkb from convert or waiting to granted
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
+
+	del_scan(ls, r);
+	list_move(&r->res_slow_list, &ls->ls_slow_active);
+	rsb_clear_flag(r, RSB_INACTIVE);
+	kref_init(&r->res_ref); /* ref is now used in active state */
+	write_unlock_bh(&ls->ls_rsbtbl_lock);
+
+	goto out;
 
-   Each of these is used for master or local copy lkb's.  There is
-   also a _pc() variation used to make the corresponding change on
-   a process copy (pc) lkb. */
 
-static void _remove_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	del_lkb(r, lkb);
-	lkb->lkb_grmode = DLM_LOCK_IV;
-	/* this unhold undoes the original ref from create_lkb()
-	   so this leads to the lkb being freed */
-	unhold_lkb(lkb);
+ do_new:
+	/*
+	 * rsb not found
+	 */
+
+	if (error == -EBADR && !create)
+		goto out;
+
+	error = get_rsb_struct(ls, name, len, &r);
+	if (WARN_ON_ONCE(error))
+		goto out;
+
+	r->res_hash = hash;
+	r->res_dir_nodeid = dir_nodeid;
+	kref_init(&r->res_ref);
+
+	if (from_dir) {
+		/* want to see how often this happens */
+		log_debug(ls, "find_rsb new from_dir %d recreate %s",
+			  from_nodeid, r->res_name);
+		r->res_master_nodeid = our_nodeid;
+		r->res_nodeid = 0;
+		goto out_add;
+	}
+
+	if (from_other && (dir_nodeid != our_nodeid)) {
+		/* should never happen */
+		log_error(ls, "find_rsb new from_other %d dir %d our %d %s",
+			  from_nodeid, dir_nodeid, our_nodeid, r->res_name);
+		dlm_free_rsb(r);
+		r = NULL;
+		error = -ENOTBLK;
+		goto out;
+	}
+
+	if (from_other) {
+		log_debug(ls, "find_rsb new from_other %d dir %d %s",
+			  from_nodeid, dir_nodeid, r->res_name);
+	}
+
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
+
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
 
-static void remove_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+/*
+ * Compatibility matrix for conversions with QUECVT set.
+ * Granted mode is the row; requested mode is the column.
+ * Usage: matrix[grmode+1][rqmode+1]
+ */
+
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
+
+void dlm_print_lkb(struct dlm_lkb *lkb)
 {
-	set_lvb_unlock(r, lkb);
-	_remove_lock(r, lkb);
+	printk(KERN_ERR "lkb: nodeid %d id %x remid %x exflags %x flags %x "
+	       "sts %d rq %d gr %d wait_type %d wait_nodeid %d seq %llu\n",
+	       lkb->lkb_nodeid, lkb->lkb_id, lkb->lkb_remid, lkb->lkb_exflags,
+	       dlm_iflags_val(lkb), lkb->lkb_status, lkb->lkb_rqmode,
+	       lkb->lkb_grmode, lkb->lkb_wait_type, lkb->lkb_wait_nodeid,
+	       (unsigned long long)lkb->lkb_recover_seq);
 }
 
-static void remove_lock_pc(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static void dlm_print_rsb(struct dlm_rsb *r)
 {
-	_remove_lock(r, lkb);
+	printk(KERN_ERR "rsb: nodeid %d master %d dir %d flags %lx first %x "
+	       "rlc %d name %s\n",
+	       r->res_nodeid, r->res_master_nodeid, r->res_dir_nodeid,
+	       r->res_flags, r->res_first_lkid, r->res_recover_locks_count,
+	       r->res_name);
 }
 
-/* returns: 0 did nothing
-	    1 moved lock to granted
-	   -1 removed lock */
-
-static int revert_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+void dlm_dump_rsb(struct dlm_rsb *r)
 {
-	int rv = 0;
+	struct dlm_lkb *lkb;
 
-	lkb->lkb_rqmode = DLM_LOCK_IV;
+	dlm_print_rsb(r);
 
-	switch (lkb->lkb_status) {
-	case DLM_LKSTS_GRANTED:
-		break;
-	case DLM_LKSTS_CONVERT:
-		move_lkb(r, lkb, DLM_LKSTS_GRANTED);
-		rv = 1;
-		break;
-	case DLM_LKSTS_WAITING:
-		del_lkb(r, lkb);
-		lkb->lkb_grmode = DLM_LOCK_IV;
-		/* this unhold undoes the original ref from create_lkb()
-		   so this leads to the lkb being freed */
-		unhold_lkb(lkb);
-		rv = -1;
-		break;
-	default:
-		log_print("invalid status for revert %d", lkb->lkb_status);
-	}
-	return rv;
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
 }
 
-static int revert_lock_pc(struct dlm_rsb *r, struct dlm_lkb *lkb)
+/* Threads cannot use the lockspace while it's being recovered */
+
+void dlm_lock_recovery(struct dlm_ls *ls)
 {
-	return revert_lock(r, lkb);
+	down_read(&ls->ls_in_recovery);
 }
 
-static void _grant_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+void dlm_unlock_recovery(struct dlm_ls *ls)
 {
-	if (lkb->lkb_grmode != lkb->lkb_rqmode) {
-		lkb->lkb_grmode = lkb->lkb_rqmode;
-		if (lkb->lkb_status)
-			move_lkb(r, lkb, DLM_LKSTS_GRANTED);
-		else
-			add_lkb(r, lkb, DLM_LKSTS_GRANTED);
-	}
-
-	lkb->lkb_rqmode = DLM_LOCK_IV;
-	lkb->lkb_highbast = 0;
+	up_read(&ls->ls_in_recovery);
 }
 
-static void grant_lock(struct dlm_rsb *r, struct dlm_lkb *lkb)
+int dlm_lock_recovery_try(struct dlm_ls *ls)
 {
-	set_lvb_lock(r, lkb);
-	_grant_lock(r, lkb);
+	return down_read_trylock(&ls->ls_in_recovery);
 }
 
-static void grant_lock_pc(struct dlm_rsb *r, struct dlm_lkb *lkb,
-			  const struct dlm_message *ms)
+static inline int can_be_queued(struct dlm_lkb *lkb)
 {
-	set_lvb_lock_pc(r, lkb, ms);
-	_grant_lock(r, lkb);
+	return !(lkb->lkb_exflags & DLM_LKF_NOQUEUE);
 }
 
-/* called by grant_pending_locks() which means an async grant message must
-   be sent to the requesting node in addition to granting the lock if the
-   lkb belongs to a remote node. */
+static inline int force_blocking_asts(struct dlm_lkb *lkb)
+{
+	return (lkb->lkb_exflags & DLM_LKF_NOQUEUEBAST);
+}
 
-static void grant_lock_pending(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static inline int is_demoted(struct dlm_lkb *lkb)
 {
-	grant_lock(r, lkb);
-	if (is_master_copy(lkb))
-		send_grant(r, lkb);
-	else
-		queue_cast(r, lkb, 0);
+	return test_bit(DLM_SBF_DEMOTED_BIT, &lkb->lkb_sbflags);
 }
 
-/* The special CONVDEADLK, ALTPR and ALTCW flags allow the master to
-   change the granted/requested modes.  We're munging things accordingly in
-   the process copy.
-   CONVDEADLK: our grmode may have been forced down to NL to resolve a
-   conversion deadlock
-   ALTPR/ALTCW: our rqmode may have been changed to PR or CW to become
-   compatible with other granted locks */
+static inline int is_altmode(struct dlm_lkb *lkb)
+{
+	return test_bit(DLM_SBF_ALTMODE_BIT, &lkb->lkb_sbflags);
+}
 
-static void munge_demoted(struct dlm_lkb *lkb)
+static inline int is_granted(struct dlm_lkb *lkb)
 {
-	if (lkb->lkb_rqmode == DLM_LOCK_IV || lkb->lkb_grmode == DLM_LOCK_IV) {
-		log_print("munge_demoted %x invalid modes gr %d rq %d",
-			  lkb->lkb_id, lkb->lkb_grmode, lkb->lkb_rqmode);
-		return;
-	}
+	return (lkb->lkb_status == DLM_LKSTS_GRANTED);
+}
 
-	lkb->lkb_grmode = DLM_LOCK_NL;
+static inline int is_remote(struct dlm_rsb *r)
+{
+	DLM_ASSERT(r->res_nodeid >= 0, dlm_print_rsb(r););
+	return !!r->res_nodeid;
 }
 
-static void munge_altmode(struct dlm_lkb *lkb, const struct dlm_message *ms)
+static inline int is_process_copy(struct dlm_lkb *lkb)
 {
-	if (ms->m_type != cpu_to_le32(DLM_MSG_REQUEST_REPLY) &&
-	    ms->m_type != cpu_to_le32(DLM_MSG_GRANT)) {
-		log_print("munge_altmode %x invalid reply type %d",
-			  lkb->lkb_id, le32_to_cpu(ms->m_type));
-		return;
-	}
+	return lkb->lkb_nodeid &&
+	       !test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags);
+}
 
-	if (lkb->lkb_exflags & DLM_LKF_ALTPR)
-		lkb->lkb_rqmode = DLM_LOCK_PR;
-	else if (lkb->lkb_exflags & DLM_LKF_ALTCW)
-		lkb->lkb_rqmode = DLM_LOCK_CW;
-	else {
-		log_print("munge_altmode invalid exflags %x", lkb->lkb_exflags);
-		dlm_print_lkb(lkb);
-	}
+static inline int is_master_copy(struct dlm_lkb *lkb)
+{
+	return test_bit(DLM_IFL_MSTCPY_BIT, &lkb->lkb_iflags);
 }
 
-static inline int first_in_list(struct dlm_lkb *lkb, struct list_head *head)
+static inline int middle_conversion(struct dlm_lkb *lkb)
 {
-	struct dlm_lkb *first = list_entry(head->next, struct dlm_lkb,
-					   lkb_statequeue);
-	if (lkb->lkb_id == first->lkb_id)
+	if ((lkb->lkb_grmode==DLM_LOCK_PR && lkb->lkb_rqmode==DLM_LOCK_CW) ||
+	    (lkb->lkb_rqmode==DLM_LOCK_PR && lkb->lkb_grmode==DLM_LOCK_CW))
 		return 1;
-
 	return 0;
 }
 
-/* Check if the given lkb conflicts with another lkb on the queue. */
-
-static int queue_conflict(struct list_head *head, struct dlm_lkb *lkb)
+static inline int down_conversion(struct dlm_lkb *lkb)
 {
-	struct dlm_lkb *this;
-
-	list_for_each_entry(this, head, lkb_statequeue) {
-		if (this == lkb)
-			continue;
-		if (!modes_compat(this, lkb))
-			return 1;
-	}
-	return 0;
+	return (!middle_conversion(lkb) && lkb->lkb_rqmode < lkb->lkb_grmode);
 }
 
-/*
- * "A conversion deadlock arises with a pair of lock requests in the converting
- * queue for one resource.  The granted mode of each lock blocks the requested
- * mode of the other lock."
- *
- * Part 2: if the granted mode of lkb is preventing an earlier lkb in the
- * convert queue from being granted, then deadlk/demote lkb.
- *
- * Example:
- * Granted Queue: empty
- * Convert Queue: NL->EX (first lock)
- *                PR->EX (second lock)
- *
- * The first lock can't be granted because of the granted mode of the second
- * lock and the second lock can't be granted because it's not first in the
- * list.  We either cancel lkb's conversion (PR->EX) and return EDEADLK, or we
- * demote the granted mode of lkb (from PR to NL) if it has the CONVDEADLK
- * flag set and return DEMOTED in the lksb flags.
- *
- * Originally, this function detected conv-deadlk in a more limited scope:
- * - if !modes_compat(lkb1, lkb2) && !modes_compat(lkb2, lkb1), or
- * - if lkb1 was the first entry in the queue (not just earlier), and was
- *   blocked by the granted mode of lkb2, and there was nothing on the
- *   granted queue preventing lkb1 from being granted immediately, i.e.
- *   lkb2 was the only thing preventing lkb1 from being granted.
- *
- * That second condition meant we'd only say there was conv-deadlk if
- * resolving it (by demotion) would lead to the first lock on the convert
- * queue being granted right away.  It allowed conversion deadlocks to exist
- * between locks on the convert queue while they couldn't be granted anyway.
- *
- * Now, we detect and take action on conversion deadlocks immediately when
- * they're created, even if they may not be immediately consequential.  If
- * lkb1 exists anywhere in the convert queue and lkb2 comes in with a granted
- * mode that would prevent lkb1's conversion from being granted, we do a
- * deadlk/demote on lkb2 right away and don't let it onto the convert queue.
- * I think this means that the lkb_is_ahead condition below should always
- * be zero, i.e. there will never be conv-deadlk between two locks that are
- * both already on the convert queue.
- */
+static inline int is_overlap_unlock(struct dlm_lkb *lkb)
+{
+	return test_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags);
+}
 
-static int conversion_deadlock_detect(struct dlm_rsb *r, struct dlm_lkb *lkb2)
+static inline int is_overlap_cancel(struct dlm_lkb *lkb)
 {
-	struct dlm_lkb *lkb1;
-	int lkb_is_ahead = 0;
+	return test_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
+}
 
-	list_for_each_entry(lkb1, &r->res_convertqueue, lkb_statequeue) {
-		if (lkb1 == lkb2) {
-			lkb_is_ahead = 1;
-			continue;
-		}
-
-		if (!lkb_is_ahead) {
-			if (!modes_compat(lkb2, lkb1))
-				return 1;
-		} else {
-			if (!modes_compat(lkb2, lkb1) &&
-			    !modes_compat(lkb1, lkb2))
-				return 1;
-		}
-	}
-	return 0;
+static inline int is_overlap(struct dlm_lkb *lkb)
+{
+	return test_bit(DLM_IFL_OVERLAP_UNLOCK_BIT, &lkb->lkb_iflags) ||
+	       test_bit(DLM_IFL_OVERLAP_CANCEL_BIT, &lkb->lkb_iflags);
 }
 
-/*
- * Return 1 if the lock can be granted, 0 otherwise.
- * Also detect and resolve conversion deadlocks.
- *
- * lkb is the lock to be granted
- *
- * now is 1 if the function is being called in the context of the
- * immediate request, it is 0 if called later, after the lock has been
- * queued.
- *
- * recover is 1 if dlm_recover_grant() is trying to grant conversions
- * after recovery.
- *
- * References are from chapter 6 of "VAXcluster Principles" by Roy Davis
- */
-
-static int _can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
-			   int recover)
+static void queue_cast(struct dlm_rsb *r, struct dlm_lkb *lkb, int rv)
 {
-	int8_t conv = (lkb->lkb_grmode != DLM_LOCK_IV);
+	if (is_master_copy(lkb))
+		return;
 
-	/*
-	 * 6-10: Version 5.4 introduced an option to address the phenomenon of
-	 * a new request for a NL mode lock being blocked.
-	 *
-	 * 6-11: If the optional EXPEDITE flag is used with the new NL mode
-	 * request, then it would be granted.  In essence, the use of this flag
-	 * tells the Lock Manager to expedite theis request by not considering
-	 * what may be in the CONVERTING or WAITING queues...  As of this
-	 * writing, the EXPEDITE flag can be used only with new requests for NL
-	 * mode locks.  This flag is not valid for conversion requests.
-	 *
-	 * A shortcut.  Earlier checks return an error if EXPEDITE is used in a
-	 * conversion or used with a non-NL requested mode.  We also know an
-	 * EXPEDITE request is always granted immediately, so now must always
-	 * be 1.  The full condition to grant an expedite request: (now &&
-	 * !conv && lkb->rqmode == DLM_LOCK_NL && (flags & EXPEDITE)) can
-	 * therefore be shortened to just checking the flag.
-	 */
+	DLM_ASSERT(lkb->lkb_lksb, dlm_print_lkb(lkb););
 
-	if (lkb->lkb_exflags & DLM_LKF_EXPEDITE)
-		return 1;
+	if (rv == -DLM_ECANCEL &&
+	    test_and_clear_bit(DLM_IFL_DEADLOCK_CANCEL_BIT, &lkb->lkb_iflags))
+		rv = -EDEADLK;
 
-	/*
-	 * A shortcut. Without this, !queue_conflict(grantqueue, lkb) would be
-	 * added to the remaining conditions.
-	 */
+	dlm_add_cb(lkb, DLM_CB_CAST, lkb->lkb_grmode, rv, dlm_sbflags_val(lkb));
+}
 
-	if (queue_conflict(&r->res_grantqueue, lkb))
-		return 0;
+static inline void queue_cast_overlap(struct dlm_rsb *r, struct dlm_lkb *lkb)
+{
+	queue_cast(r, lkb,
+		   is_overlap_unlock(lkb) ? -DLM_EUNLOCK : -DLM_ECANCEL);
+}
 
-	/*
-	 * 6-3: By default, a conversion request is immediately granted if the
-	 * requested mode is compatible with the modes of all other granted
-	 * locks
-	 */
+static void queue_bast(struct dlm_rsb *r, struct dlm_lkb *lkb, int rqmode)
+{
+	if (is_master_copy(lkb)) {
+		send_bast(r, lkb, rqmode);
+	} else {
+		dlm_add_cb(lkb, DLM_CB_BAST, rqmode, 0, 0);
+	}
+}
 
-	if (queue_conflict(&r->res_convertqueue, lkb))
-		return 0;
+/*
+ * Basic operations on rsb's and lkb's
+ */
 
-	/*
-	 * The RECOVER_GRANT flag means dlm_recover_grant() is granting
-	 * locks for a recovered rsb, on which lkb's have been rebuilt.
-	 * The lkb's may have been rebuilt on the queues in a different
-	 * order than they were in on the previous master.  So, granting
-	 * queued conversions in order after recovery doesn't make sense
-	 * since the order hasn't been preserved anyway.  The new order
-	 * could also have created a new "in place" conversion deadlock.
-	 * (e.g. old, failed master held granted EX, with PR->EX, NL->EX.
-	 * After recovery, there would be no granted locks, and possibly
-	 * NL->EX, PR->EX, an in-place conversion deadlock.)  So, after
-	 * recovery, grant conversions without considering order.
-	 */
+static inline unsigned long rsb_toss_jiffies(void)
+{
+	return jiffies + (READ_ONCE(dlm_config.ci_toss_secs) * HZ);
+}
 
-	if (conv && recover)
-		return 1;
+/* This is only called to add a reference when the code already holds
+   a valid reference to the rsb, so there's no need for locking. */
 
-	/*
-	 * 6-5: But the default algorithm for deciding whether to grant or
-	 * queue conversion requests does not by itself guarantee that such
-	 * requests are serviced on a "first come first serve" basis.  This, in
-	 * turn, can lead to a phenomenon known as "indefinate postponement".
-	 *
-	 * 6-7: This issue is dealt with by using the optional QUECVT flag with
-	 * the system service employed to request a lock conversion.  This flag
-	 * forces certain conversion requests to be queued, even if they are
-	 * compatible with the granted modes of other locks on the same
-	 * resource.  Thus, the use of this flag results in conversion requests
-	 * being ordered on a "first come first servce" basis.
-	 *
-	 * DCT: This condition is all about new conversions being able to occur
-	 * "in place" while the lock remains on the granted queue (assuming
-	 * nothing else conflicts.)  IOW if QUECVT isn't set, a conversion
-	 * doesn't _have_ to go onto the convert queue where it's processed in
-	 * order.  The "now" variable is necessary to distinguish converts
-	 * being received and processed for the first time now, because once a
-	 * convert is moved to the conversion queue the condition below applies
-	 * requiring fifo granting.
-	 */
+static inline void hold_rsb(struct dlm_rsb *r)
+{
+	/* inactive rsbs are not ref counted */
+	WARN_ON(rsb_flag(r, RSB_INACTIVE));
+	kref_get(&r->res_ref);
+}
 
-	if (now && conv && !(lkb->lkb_exflags & DLM_LKF_QUECVT))
-		return 1;
+void dlm_hold_rsb(struct dlm_rsb *r)
+{
+	hold_rsb(r);
+}
 
-	/*
-	 * Even if the convert is compat with all granted locks,
-	 * QUECVT forces it behind other locks on the convert queue.
-	 */
+/* TODO move this to lib/refcount.c */
+static __must_check bool
+dlm_refcount_dec_and_write_lock_bh(refcount_t *r, rwlock_t *lock)
+__cond_acquires(lock)
+{
+	if (refcount_dec_not_one(r))
+		return false;
 
-	if (now && conv && (lkb->lkb_exflags & DLM_LKF_QUECVT)) {
-		if (list_empty(&r->res_convertqueue))
-			return 1;
-		else
-			return 0;
+	write_lock_bh(lock);
+	if (!refcount_dec_and_test(r)) {
+		write_unlock_bh(lock);
+		return false;
 	}
 
-	/*
-	 * The NOORDER flag is set to avoid the standard vms rules on grant
-	 * order.
-	 */
-
-	if (lkb->lkb_exflags & DLM_LKF_NOORDER)
-		return 1;
-
-	/*
-	 * 6-3: Once in that queue [CONVERTING], a conversion request cannot be
-	 * granted until all other conversion requests ahead of it are granted
-	 * and/or canceled.
-	 */
-
-	if (!now && conv && first_in_list(lkb, &r->res_convertqueue))
-		return 1;
-
-	/*
-	 * 6-4: By default, a new request is immediately granted only if all
-	 * three of the following conditions are satisfied when the request is
-	 * issued:
-	 * - The queue of ungranted conversion requests for the resource is
-	 *   empty.
-	 * - The queue of ungranted new requests for the resource is empty.
-	 * - The mode of the new request is compatible with the most
-	 *   restrictive mode of all granted locks on the resource.
-	 */
-
-	if (now && !conv && list_empty(&r->res_convertqueue) &&
-	    list_empty(&r->res_waitqueue))
-		return 1;
-
-	/*
-	 * 6-4: Once a lock request is in the queue of ungranted new requests,
-	 * it cannot be granted until the queue of ungranted conversion
-	 * requests is empty, all ungranted new requests ahead of it are
-	 * granted and/or canceled, and it is compatible with the granted mode
-	 * of the most restrictive lock granted on the resource.
-	 */
+	return true;
+}
 
-	if (!now && !conv && list_empty(&r->res_convertqueue) &&
-	    first_in_list(lkb, &r->res_waitqueue))
+/* TODO move this to include/linux/kref.h */
+static inline int dlm_kref_put_write_lock_bh(struct kref *kref,
+					     void (*release)(struct kref *kref),
+					     rwlock_t *lock)
+{
+	if (dlm_refcount_dec_and_write_lock_bh(&kref->refcount, lock)) {
+		release(kref);
 		return 1;
+	}
 
 	return 0;
 }
 
-static int can_be_granted(struct dlm_rsb *r, struct dlm_lkb *lkb, int now,
-			  int recover, int *err)
+static void put_rsb(struct dlm_rsb *r)
 {
+	struct dlm_ls *ls = r->res_ls;
 	int rv;
-	int8_t alt = 0, rqmode = lkb->lkb_rqmode;
-	int8_t is_convert = (lkb->lkb_grmode != DLM_LOCK_IV);
-
-	if (err)
-		*err = 0;
 
-	rv = _can_be_granted(r, lkb, now, recover);
+	rv = dlm_kref_put_write_lock_bh(&r->res_ref, deactivate_rsb,
+					&ls->ls_rsbtbl_lock);
 	if (rv)
-		goto out;
-
-	/*
-	 * The CONVDEADLK flag is non-standard and tells the dlm to resolve
-	 * conversion deadlocks by demoting grmode to NL, otherwise the dlm
-	 * cancels one of the locks.
-	 */
-
-	if (is_convert && can_be_queued(lkb) &&
-	    conversion_deadlock_detect(r, lkb)) {
-		if (lkb->lkb_exflags & DLM_LKF_CONVDEADLK) {
-			lkb->lkb_grmode = DLM_LOCK_NL;
-			set_bit(DLM_SBF_DEMOTED_BIT, &lkb->lkb_sbflags);
-		} else if (err) {
-			*err = -EDEADLK;
-		} else {
-			log_print("can_be_granted deadlock %x now %d",
-				  lkb->lkb_id, now);
-			dlm_dump_rsb(r);
-		}
-		goto out;
-	}
-
-	/*
-	 * The ALTPR and ALTCW flags are non-standard and tell the dlm to try
-	 * to grant a request in a mode other than the normal rqmode.  It's a
-	 * simple way to provide a big optimization to applications that can
-	 * use them.
-	 */
-
-	if (rqmode != DLM_LOCK_PR && (lkb->lkb_exflags & DLM_LKF_ALTPR))
-		alt = DLM_LOCK_PR;
-	else if (rqmode != DLM_LOCK_CW && (lkb->lkb_exflags & DLM_LKF_ALTCW))
-		alt = DLM_LOCK_CW;
-
-	if (alt) {
-		lkb->lkb_rqmode = alt;
-		rv = _can_be_granted(r, lkb, now, 0);
-		if (rv)
-			set_bit(DLM_SBF_ALTMODE_BIT, &lkb->lkb_sbflags);
-		else
-			lkb->lkb_rqmode = rqmode;
-	}
- out:
-	return rv;
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
 }
 
-/* Returns the highest requested mode of all blocked conversions; sets
-   cw if there's a blocked conversion to DLM_LOCK_CW. */
+void dlm_put_rsb(struct dlm_rsb *r)
+{
+	put_rsb(r);
+}
 
-static int grant_pending_convert(struct dlm_rsb *r, int high, int *cw,
-				 unsigned int *count)
+/* connected with timer_delete_sync() in dlm_ls_stop() to stop
+ * new timers when recovery is triggered and don't run them
+ * again until a resume_scan_timer() tries it again.
+ */
+static void enable_scan_timer(struct dlm_ls *ls, unsigned long jiffies)
 {
-	struct dlm_lkb *lkb, *s;
-	int recover = rsb_flag(r, RSB_RECOVER_GRANT);
-	int hi, demoted, quit, grant_restart, demote_restart;
-	int deadlk;
+	if (!dlm_locking_stopped(ls))
+		mod_timer(&ls->ls_scan_timer, jiffies);
+}
 
-	quit = 0;
- restart:
-	grant_restart = 0;
-	demote_restart = 0;
-	hi = DLM_LOCK_IV;
+/* This function tries to resume the timer callback if a rsb
+ * is on the scan list and no timer is pending. It might that
+ * the first entry is on currently executed as timer callback
+ * but we don't care if a timer queued up again and does
+ * nothing. Should be a rare case.
+ */
+void resume_scan_timer(struct dlm_ls *ls)
+{
+	struct dlm_rsb *r;
 
-	list_for_each_entry_safe(lkb, s, &r->res_convertqueue, lkb_statequeue) {
-		demoted = is_demoted(lkb);
-		deadlk = 0;
+	spin_lock_bh(&ls->ls_scan_lock);
+	r = list_first_entry_or_null(&ls->ls_scan_list, struct dlm_rsb,
+				     res_scan_list);
+	if (r && !timer_pending(&ls->ls_scan_timer))
+		enable_scan_timer(ls, r->res_toss_time);
+	spin_unlock_bh(&ls->ls_scan_lock);
+}
 
-		if (can_be_granted(r, lkb, 0, recover, &deadlk)) {
-			grant_lock_pending(r, lkb);
-			grant_restart = 1;
-			if (count)
-				(*count)++;
-			continue;
-		}
+/* ls_rsbtbl_lock must be held */
 
-		if (!demoted && is_demoted(lkb)) {
-			log_print("WARN: pending demoted %x node %d %s",
-				  lkb->lkb_id, lkb->lkb_nodeid, r->res_name);
-			demote_restart = 1;
-			continue;
-		}
+static void del_scan(struct dlm_ls *ls, struct dlm_rsb *r)
+{
+	struct dlm_rsb *first;
 
-		if (deadlk) {
-			/*
-			 * If DLM_LKB_NODLKWT flag is set and conversion
-			 * deadlock is detected, we request blocking AST and
-			 * down (or cancel) conversion.
-			 */
-			if (lkb->lkb_exflags & DLM_LKF_NODLCKWT) {
-				if (lkb->lkb_highbast < lkb->lkb_rqmode) {
-					queue_bast(r, lkb, lkb->lkb_rqmode);
-					lkb->lkb_highbast = lkb->lkb_rqmode;
-				}
-			} else {
-				log_print("WARN: pending deadlock %x node %d %s",
-					  lkb->lkb_id, lkb->lkb_nodeid,
-					  r->res_name);
-				dlm_dump_rsb(r);
-			}
-			continue;
-		}
+	/* active rsbs should never be on the scan list */
+	WARN_ON(!rsb_flag(r, RSB_INACTIVE));
 
-		hi = max_t(int, lkb->lkb_rqmode, hi);
+	spin_lock_bh(&ls->ls_scan_lock);
+	r->res_toss_time = 0;
 
-		if (cw && lkb->lkb_rqmode == DLM_LOCK_CW)
-			*cw = 1;
-	}
+	/* if the rsb is not queued do nothing */
+	if (list_empty(&r->res_scan_list))
+		goto out;
 
-	if (grant_restart)
-		goto restart;
-	if (demote_restart && !quit) {
-		quit = 1;
-		goto restart;
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
 	}
 
-	return max_t(int, high, hi);
+out:
+	spin_unlock_bh(&ls->ls_scan_lock);
 }
 
-static int grant_pending_wait(struct dlm_rsb *r, int high, int *cw,
-			      unsigned int *count)
+static void add_scan(struct dlm_ls *ls, struct dlm_rsb *r)
 {
-	struct dlm_lkb *lkb, *s;
+	int our_nodeid = dlm_our_nodeid();
+	struct dlm_rsb *first;
 
-	list_for_each_entry_safe(lkb, s, &r->res_waitqueue, lkb_statequeue) {
-		if (can_be_granted(r, lkb, 0, 0, NULL)) {
-			grant_lock_pending(r, lkb);
-			if (count)
-				(*count)++;
-		} else {
-			high = max_t(int, lkb->lkb_rqmode, high);
-			if (lkb->lkb_rqmode == DLM_LOCK_CW)
-				*cw = 1;
-		}
-	}
+	/* A dir record for a remote master rsb should never be on the scan list. */
+	WARN_ON(!dlm_no_directory(ls) &&
+		(r->res_master_nodeid != our_nodeid) &&
+		(dlm_dir_nodeid(r) == our_nodeid));
 
-	return high;
-}
+	/* An active rsb should never be on the scan list. */
+	WARN_ON(!rsb_flag(r, RSB_INACTIVE));
 
-/* cw of 1 means there's a lock with a rqmode of DLM_LOCK_CW that's blocked
-   on either the convert or waiting queue.
-   high is the largest rqmode of all locks blocked on the convert or
-   waiting queue. */
+	/* An rsb should not already be on the scan list. */
+	WARN_ON(!list_empty(&r->res_scan_list));
 
-static int lock_requires_bast(struct dlm_lkb *gr, int high, int cw)
-{
-	if (gr->lkb_grmode == DLM_LOCK_PR && cw) {
-		if (gr->lkb_highbast < DLM_LOCK_EX)
-			return 1;
-		return 0;
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
 	}
-
-	if (gr->lkb_highbast < high &&
-	    !__dlm_compat_matrix[gr->lkb_grmode+1][high+1])
-		return 1;
-	return 0;
+	spin_unlock_bh(&ls->ls_scan_lock);
 }
 
-static void grant_pending_locks(struct dlm_rsb *r, unsigned int *count)
+/* if we hit contention we do in 250 ms a retry to trylock.
+ * if there is any other mod_timer in between we don't care
+ * about that it expires earlier again this is only for the
+ * unlikely case nothing happened in this time.
+ */
+#define DLM_TOSS_TIMER_RETRY	(jiffies + msecs_to_jiffies(250))
+
+/* Called by lockspace scan_timer to free unused rsb's. */
+
+void dlm_rsb_scan(struct timer_list *timer)
 {
-	struct dlm_lkb *lkb, *s;
-	int high = DLM_LOCK_IV;
-	int cw = 0;
+	struct dlm_ls *ls = timer_container_of(ls, timer, ls_scan_timer);
+	int our_nodeid = dlm_our_nodeid();
+	struct dlm_rsb *r;
+	int rv;
 
-	if (!is_master(r)) {
-		log_print("grant_pending_locks r nodeid %d", r->res_nodeid);
-		dlm_dump_rsb(r);
-		return;
-	}
+	while (1) {
+		/* interrupting point to leave iteration when
+		 * recovery waits for timer_delete_sync(), recovery
+		 * will take care to delete everything in scan list.
+		 */
+		if (dlm_locking_stopped(ls))
+			break;
 
-	high = grant_pending_convert(r, high, &cw, count);
-	high = grant_pending_wait(r, high, &cw, count);
+		rv = spin_trylock(&ls->ls_scan_lock);
+		if (!rv) {
+			/* rearm again try timer */
+			enable_scan_timer(ls, DLM_TOSS_TIMER_RETRY);
+			break;
+		}
 
-	if (high == DLM_LOCK_IV)
-		return;
+		r = list_first_entry_or_null(&ls->ls_scan_list, struct dlm_rsb,
+					     res_scan_list);
+		if (!r) {
+			/* the next add_scan will enable the timer again */
+			spin_unlock(&ls->ls_scan_lock);
+			break;
+		}
 
-	/*
-	 * If there are locks left on the wait/convert queue then send blocking
-	 * ASTs to granted locks based on the largest requested mode (high)
-	 * found above.
-	 */
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
 
-	list_for_each_entry_safe(lkb, s, &r->res_grantqueue, lkb_statequeue) {
-		if (lkb->lkb_bastfn && lock_requires_bast(lkb, high, cw)) {
-			if (cw && high == DLM_LOCK_PR &&
-			    lkb->lkb_grmode == DLM_LOCK_PR)
-				queue_bast(r, lkb, DLM_LOCK_CW);
-			else
-				queue_bast(r, lkb, high);
-			lkb->lkb_highbast = high;
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
 		}
-	}
-}
 
-static int modes_require_bast(struct dlm_lkb *gr, struct dlm_lkb *rq)
-{
-	if ((gr->lkb_grmode == DLM_LOCK_PR && rq->lkb_rqmode == DLM_LOCK_CW) ||
-	    (gr->lkb_grmode == DLM_LOCK_CW && rq->lkb_rqmode == DLM_LOCK_PR)) {
-		if (gr->lkb_highbast < DLM_LOCK_EX)
-			return 1;
-		return 0;
-	}
+		list_del(&r->res_slow_list);
+		rhashtable_remove_fast(&ls->ls_rsbtbl, &r->res_node,
+				       dlm_rhash_rsb_params);
+		rsb_clear_flag(r, RSB_HASHED);
 
-	if (gr->lkb_highbast < rq->lkb_rqmode && !modes_compat(gr, rq))
-		return 1;
-	return 0;
-}
+		/* ls_rsbtbl_lock is not needed when calling send_remove() */
+		write_unlock(&ls->ls_rsbtbl_lock);
 
-static void send_bast_queue(struct dlm_rsb *r, struct list_head *head,
-			    struct dlm_lkb *lkb)
-{
-	struct dlm_lkb *gr;
+		list_del_init(&r->res_scan_list);
+		spin_unlock(&ls->ls_scan_lock);
 
-	list_for_each_entry(gr, head, lkb_statequeue) {
-		/* skip self when sending basts to convertqueue */
-		if (gr == lkb)
-			continue;
-		if (gr->lkb_bastfn && modes_require_bast(gr, lkb)) {
-			queue_bast(r, gr, lkb->lkb_rqmode);
-			gr->lkb_highbast = lkb->lkb_rqmode;
-		}
+		/* An rsb that is a dir record for a remote master rsb
+		 * cannot be removed, and should not have a timer enabled.
+		 */
+		WARN_ON(!dlm_no_directory(ls) &&
+			(r->res_master_nodeid != our_nodeid) &&
+			(dlm_dir_nodeid(r) == our_nodeid));
+
+		/* We're the master of this rsb but we're not
+		 * the directory record, so we need to tell the
+		 * dir node to remove the dir record
+		 */
+		if (!dlm_no_directory(ls) &&
+		    (r->res_master_nodeid == our_nodeid) &&
+		    (dlm_dir_nodeid(r) != our_nodeid))
+			send_remove(r);
+
+		free_inactive_rsb(r);
 	}
 }
 
-static void send_blocking_asts(struct dlm_rsb *r, struct dlm_lkb *lkb)
-{
-	send_bast_queue(r, &r->res_grantqueue, lkb);
-}
+/* If ls->ls_new_rsb is empty, return -EAGAIN, so the caller can
+   unlock any spinlocks, go back and call pre_rsb_struct again.
+   Otherwise, take an rsb off the list and return it. */
 
-static void send_blocking_asts_all(struct dlm_rsb *r, struct dlm_lkb *lkb)
+static int get_rsb_struct(struct dlm_ls *ls, const void *name, int len,
+			  struct dlm_rsb **r_ret)
 {
 	send_bast_queue(r, &r->res_grantqueue, lkb);
 	send_bast_queue(r, &r->res_convertqueue, lkb);
-- 
2.48.1


