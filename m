Return-Path: <linux-kernel+bounces-792882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94290B3C9FE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 12:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141A01B207E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8426FDBF;
	Sat, 30 Aug 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM+QPzg0"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C726E146
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756548866; cv=none; b=SPi+Fpnjs4PpmHDJS9ZkD4k9NXHuyqf/LF4jd2aju6G4jlAgviPr7Hfk4qtNmuW6fK1mlSsxs2P2myA/3SbBo4ClbhKZQ8RQpU/hERFJWZD4Cw9juqU8gb/ZXEaMjyajCSc15ZaYXXrW9Sa1dbqjmn2r26BK0iHC6JNNh0xG9bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756548866; c=relaxed/simple;
	bh=0H8upeMCBiIlgPWCih17kcD59k9Wc8/nlE7Rf2FKpjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vl3xwLGcb7jT1I/kvQAcsaVizc/Wgn3TDG+MVVtR/WwWLNPirCAUutxCfWWysM5R6s2NLcTRrmiXuttNMMiGDfx/KAE8G+cQriW0ZtNm6d7a552bl72OPyTkDtMnMVkgrhmTmHC+VLC74scN6Igt/zqlNVGzaZkKXpy3/KCVZ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM+QPzg0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3cd59c5a953so1896405f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 03:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756548863; x=1757153663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeY1cTx0A9tt639AWyhl3UrwoNAsYdIDU0iO9qjGd+Q=;
        b=FM+QPzg0jUepPKdMR1fI2914rt7gjZ7E0R2AX+xr818XCJRv8mv0PXaboEbN0bfw1u
         XX0BX2l2ifd+sMbGv9rmC2CH6PZRPoBtwlY1vgzaVb9u4zhdYv7O5ICPEVpA8WJ7Giiy
         6tNUFRzTwXmRNu2SLxK7Plif6B0h5V1q9MMtFmE6FSmtYvo1V/r45SSGpWp/SV7ilRvM
         EuKf16c2gKEp52k5bhOrWqOziWFdUS6WokDmfl35jziJvt5mdQRac5MPG46t7aWPWs4s
         xJ3steXWhpmnZfsVXxZ6KP05tGFhMqoGw6Fzo4rsFP1LG9yktokkz/fQoTK7EdobYPGh
         N1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756548863; x=1757153663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeY1cTx0A9tt639AWyhl3UrwoNAsYdIDU0iO9qjGd+Q=;
        b=KaaZqNOxInGsUpw4zQxkrLtE97z9gOp1MVPIzQlaupXNv486egveEV+A6LqPaQAxeR
         ueXOsfXvMZFY/TGREGR/Wypbln/NC8I3GbPNJK5OJKjzLefRbY/9trt7pRCRpDwBK/+8
         WEnzzwOiaQUF1nGBfXz4J+UJu/t6zoIgCe0kvEzuuSTH1cwurn3oHJIfr7mKJPBqQzyj
         29YpsDuBj5xp8RYZV/T0fEmF+lqB5WhQAdkja69UThPIjcLWwmrI5raAPMj+FfVv7NG3
         rctWIKDRqyvUlmVMp0b+P/fg3LUEJUS4fAtwICSgVrebii48hPhvbOi1RUtWVu/SMAvC
         I2qw==
X-Gm-Message-State: AOJu0YyGPCSYMC7SnC5rawTYjnLtns83yeuJNt+ZlYp2t40sKZxpfPW4
	hOVaOtrg7scot2fO/7UYuHK7EuxSxpUD22xynAsxajOO6qWdBhVFkt6J
X-Gm-Gg: ASbGncs31nVM0qpFkVaXl1CYWFYz4aMJQuNdpVnIIeYEoo1oARnHW1rmE0EuGyZ7trP
	4pQERYONiDVQLTw9ojjRU+eo68dm4w52K5WBIodY7qsPgUb7VoQZ/r8ovQOAfe/oBrDPHvdrINN
	GbCVP1OXFwhHOGuewCYVaoayQDBu+/gR3AM+zmD6oLhsmD5geR9ufzZTJ+xFy43di4FGEHuUEru
	4NBsjwwtHGiS8bqIj3gbrWF1hfuqen9f/TSwv/L1Ofqa/fhKHECK7HRwbknG4PoheeAOxmkRPqD
	4QiJ0xhXOOBcIxSQu18P5Sv7M0v1kjLX4RW7I7zYPHCs765ngQKsaPbmUatjw6cbglfoiqkOFSP
	905mcdKwIPwKAEP1ScSne0l6sDEa7AC2AwBev5hpaiANJ84Dc25OLS1g3ntMoxFrp+79n74FXVT
	2XyisrOI81JTpNp4WMofwbCJ+DOZzlM5x0oOFMpcpLbZ7izzdQwmTVg7NElD8Xs7pE+WWZBdn0U
	bhL5XGSk49lR/+oE846In+rXOtJng==
X-Google-Smtp-Source: AGHT+IHa9vtUH8SZHOCaW16YYswy/rsRTCPtSre+83Oyx/za744bIPxfAlah5IEXb/vFgUJLZYCFvw==
X-Received: by 2002:a05:6000:26cb:b0:3ca:3206:29f with SMTP id ffacd0b85a97d-3d1de4bc29emr1144928f8f.40.1756548863061;
        Sat, 30 Aug 2025 03:14:23 -0700 (PDT)
Received: from local.station (net-93-148-93-71.cust.dsl.teletu.it. [93.148.93.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm6758790f8f.15.2025.08.30.03.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 03:14:22 -0700 (PDT)
From: Alessio Attilio <alessio.attilio.dev@gmail.com>
X-Google-Original-From: Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
To: gfs2@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	aahringo@redhat.com,
	teigland@redhat.com,
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
Subject: [PATCH 04/12] fix(find_rsb_nodir): corrects the management of inactive rsb and the creation of new rsb
Date: Sat, 30 Aug 2025 12:14:05 +0200
Message-ID: <20250830101413.602637-4-226562783+SigAttilio@users.noreply.github.com>
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
 fs/dlm/lock.c | 118 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 34 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c62ec235c047..de77a0e9e2db 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1265,69 +1265,119 @@ static int find_rsb_nodir(struct dlm_ls *ls, const void *name, int len,
 		goto do_inactive;
 	}
 
-	/* because the rsb is active, we need to lock_rsb before
-	 * checking/changing re_master_nodeid
+	/*
+	 * rsb is active, so we can't check master_nodeid without lock_rsb.
 	 */
 
-	hold_rsb(r);
+	kref_get(&r->res_ref);
 	read_unlock_bh(&ls->ls_rsbtbl_lock);
-	lock_rsb(r);
-
-	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, false,
-			    flags, r_nodeid, result);
 
-	/* the rsb was active */
-	unlock_rsb(r);
-	put_rsb(r);
+	goto out;
 
-	return 0;
 
  do_inactive:
-	/* unlikely path - check if still part of ls_rsbtbl */
 	write_lock_bh(&ls->ls_rsbtbl_lock);
 
-	/* see comment in find_rsb_dir */
+	/* See comment in find_rsb_dir. */
 	if (rsb_flag(r, RSB_HASHED)) {
 		if (!rsb_flag(r, RSB_INACTIVE)) {
 			write_unlock_bh(&ls->ls_rsbtbl_lock);
-			/* something as changed, very unlikely but
-			 * try again
-			 */
 			goto retry;
 		}
 	} else {
 		write_unlock_bh(&ls->ls_rsbtbl_lock);
-		goto not_found;
+		goto do_new;
 	}
 
-	/* because the rsb is inactive, it's not refcounted and lock_rsb
-	   is not used, but is protected by the rsbtbl lock */
-
-	__dlm_master_lookup(ls, r, our_nodeid, from_nodeid, true, flags,
-			    r_nodeid, result);
 
-	/* A dir record rsb should never be on scan list.
-	 * Except when we are the dir and master node.
-	 * This function should only be called by the dir
-	 * node.
+	/*
+	 * rsb found inactive. No other thread is using this rsb because
+	 * it's inactive, so we can look at or update res_master_nodeid
+	 * without lock_rsb.
 	 */
-	WARN_ON(!list_empty(&r->res_scan_list) &&
-		r->res_master_nodeid != our_nodeid);
 
+	if (!recover && (r->res_master_nodeid != our_nodeid) && from_nodeid) {
+		/* our rsb is not master, and another node has sent us a
+		   request; this should never happen */
+		log_error(ls, "find_rsb inactive from_nodeid %d master %d dir %d",
+			  from_nodeid, r->res_master_nodeid, dir_nodeid);
+		write_unlock_bh(&ls->ls_rsbtbl_lock);
+		error = -ENOTBLK;
+		goto out;
+	}
+
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
 	write_unlock_bh(&ls->ls_rsbtbl_lock);
 
-	return 0;
+	goto out;
+
+
+ do_new:
+	/*
+	 * rsb not found
+	 */
+
+	if (error == -EBADR && !create)
+		goto out;
 
- not_found:
 	error = get_rsb_struct(ls, name, len, &r);
 	if (WARN_ON_ONCE(error))
 		goto out;
 
 	r->res_hash = hash;
-	r->res_dir_nodeid = our_nodeid;
-	r->res_master_nodeid = from_nodeid;
-	r->res_nodeid = from_nodeid;
-	rsb_set_flag(r, RSB_INACTIVE);
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
 
 	write_lock_bh(&ls->ls_rsbtbl_lock);
 	error = rsb_insert(r, &ls->ls_rsbtbl);
-- 
2.48.1


