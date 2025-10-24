Return-Path: <linux-kernel+bounces-869031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A704CC06C23
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 462FD4E6068
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703C9225408;
	Fri, 24 Oct 2025 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBfwnMSn"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F98190477
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317146; cv=none; b=DW4TSYR2XD+v1n6zg8DuJ6o6sbyLCID3WeX7aDJx6nGdxvyimjlbbbHf7q5utdD8IhXGpvsEjOhJvjRBO4Yf6E/+OhVh/actf5fchpTUpR31N0KeU7b/qRZsCwea9TiQQiC3xBESUNIK5yttiw6tsYp5NMYTXaorhWfYK6Xck+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317146; c=relaxed/simple;
	bh=nqG4zh+kHvMInvyQ9gQCc4CsAgJQ86U7Qt1LNvskd/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7dlY1dIgn5xlLJEDGE1rm+hHEGc6+4fNOTbUVNADc6HTn1f2WmrjEwd2dUS13jmmOg6xTQzrR9a8c9IKjPLebXV8C0ymm+sLG8lDpnOHqt10KgUm2ynZ+UXpJzx+hYSEJR2SQXAVJo6n4tzNY4/7I+9kjqfAev1ax2WuTFIevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBfwnMSn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so2186073a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317145; x=1761921945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4n0UnjLUys/j015DW1wlIcevAZ741dIgKslESCiUAc=;
        b=nBfwnMSnJh6L4b+sbLSaup+w3YRhihByO3Z2D0ztQWakPNu52obqOi5rlf7O5MUREJ
         ttSdYm062RoCj5AA1wJ3tOoG9TYfGsXTiSwJeCDlapz0gik3dV2GvDHXy46IcilvRAiS
         8YyJO/vMEtPVMX8hyw1U3LU7sIdA1rz+aJf8RM0UWjAeWNUtpQyvFH1aSEqzdK4WdQKs
         365Q3pcIuRTnkr/9mXkGBc6Mq5alVDqluNRBPx1BzfJJGSucDvzOXxhTkV4PF/wcEmuu
         4FJCwAtVo6kjQnqCVWU8KL/pofR98HfoQmOcL7WXHpHDEOppDsz0fPkSbvMW0IMspEns
         M5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317145; x=1761921945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4n0UnjLUys/j015DW1wlIcevAZ741dIgKslESCiUAc=;
        b=Xmll1wVnGJPyL62vIzgzErIPhCWKbQmEhKk6lgbwI0jBsqiTXHEs4fTcpvQPM9jWXL
         mO9VKyjv9iCGyTfKWsXI3XvrvEPUL0/JhmB9ouQyNr5+KstkXY2LixKLk4OGWw2nGBZK
         UfnDrxnvK6AOuSIu3zyNK1FjRL/oTn4QTwqtTEwE67U4qJCrT+GfpY6pmr+loUUZxc+a
         atDsPuzeuBQwU7Dy0zT3iUUqNdzm7AD+q9b7U6cMdm2A3CM1siHeiNqWNrG6FAOTlv+r
         b604ZVAFJftHjF2DxCCHWf6gL7Suz9e7oEM0xc2Hf+rHa4tclVLmllCYLPCT/1JjPbjG
         jYFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjxXi0lTPrIJOSMBGoRl37aRVIoujhuIrk4lXrnKv2DgnSZpF4c6k/crYiu4XJh0VZJkj6RyGdnK82cdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6jRo5KKFFzvAOr2jp33+Fh+Tz33Wq7GH7bEeH//q+loHHfPo
	khZi0wQOBxPHfGP2M2kV/w1dVrUQ/JPmiPRiqZ+PYkZR5uRLrBAntyB25Kbderex
X-Gm-Gg: ASbGncvZ/yUyMQMTR/u00Y/CKWrOWMWV3Pu1Gltz31UcdcbV3pOca8tqMkvig6HuaAx
	rvpcw6d3VqbMc2p0kNhZNCbRzcBKKfN1LUe273laiBoNz5CxMUnMW+8CDfI9y1/jJ7s8WI1qZNp
	E7GS0UBOud2WAc7ViEe7VkvcU+NVqbYrOIkTP7uD00F5f9ZkE9WZl/l8WyXRchP1k01lVASucJo
	Wwa/UnBt4ciwJyPhvdgNtQiEveS2bui094C2lLp1tp5tNgU2k5b7F/bI8IVLO2sFlWuL+JxVaJQ
	n7UKX4MlrsCb8vLEBKetx+m1dfSG9Gb3Q0tMTApIIdY2KaCIy59mV6wtUbXZmowTbtR9/fLmSm7
	Vqkp/406A0I7y6Yx9xcxEcwLKkBHpIfZBlbGkubZkURZ5m1/TYGKruQkRtSz8/9IVbSDHLa2/w4
	1GTm8FOXLG6JVKjCIogWEq0QCiBvEv6510EK5MbcI8XT6gA8fSAaArNFBb
X-Google-Smtp-Source: AGHT+IEX5+Zc6CDsncOD1U2YKgYTgfSBUwM+Np98fLDZTHhgs+0g9k59w3ppAgkJNjKS+pbJ2TSgiw==
X-Received: by 2002:a17:90b:4f:b0:33b:a38e:d868 with SMTP id 98e67ed59e1d1-33bcf8e95f3mr35727097a91.24.1761317144424;
        Fri, 24 Oct 2025 07:45:44 -0700 (PDT)
Received: from prakrititz-UB.. ([2a09:bac5:3c3a:1aaa::2a8:13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e224a2f28sm9344760a91.19.2025.10.24.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:45:44 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] gfs2: flush withdraw work before freeing gfs2_sbd
Date: Fri, 24 Oct 2025 20:13:33 +0530
Message-ID: <20251024144332.33773-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
References: <68f6a48f.050a0220.91a22.0451.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported an ODEBUG warning where free_sbd() was freeing memory
containing an active work_struct (sd_withdraw_work):

  ODEBUG: free active (active state 0) object: ffff888026c285a0
  object type: work_struct hint: gfs2_withdraw_func+0x0/0x430
  WARNING: CPU: 0 PID: 6010 at lib/debugobjects.c:545
  Call Trace:
   free_sbd+0x1e4/0x270 fs/gfs2/ops_fstype.c:1308

The issue occurs when gfs2_fill_super() fails after initializing
sd_withdraw_work at line 1218. Some error paths (fail_lm, fail_debug,
etc.) skip the existing flush_work() at the fail_inodes label and jump
directly to fail_free, which calls free_sbd() without flushing the
potentially pending work.

free_sbd() is also called from init_sbd()'s error path before
sd_withdraw_work is initialized. Since the structure is allocated with
kzalloc(), work.func is NULL in this case.

Fix by adding a guarded flush_work() to free_sbd(). Check work.func
before flushing to handle both cases: when called after INIT_WORK()
(work must be flushed), and when called before INIT_WORK() (work.func
is NULL, skip flushing). This avoids the WARN_ON(!work->func) in
__flush_work().

Note: gfs2_put_super() already calls flush_work() before free_sbd()
(line 606), so the flush in free_sbd() will be redundant but harmless
for the normal unmount path.

Reported-by: syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=19e0be39cc25dfcb0858
Fixes: 8fdd8a28fe5c ("gfs2: Asynchronous withdraw")
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
Testing performed:
- Reproduced original bug with syzbot C reproducer
- Verified fix prevents ODEBUG warnings in all error paths
- Tested early mount failures (unformatted devices)
- Tested all gfs2_fill_super error paths (4 scenarios)
- Parallel mount stress test (3 concurrent operations)
- Memory leak test (50 mount/unmount cycles, <4MB variance)
- Race condition testing passed
- Validated with syzbot on linux-next (Oct 22)
- All tests completed with zero ODEBUG warnings

 fs/gfs2/ops_fstype.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 08502d967e71..6cea03410e57 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -67,6 +67,14 @@ void free_sbd(struct gfs2_sbd *sdp)
 {
 	struct super_block *sb = sdp->sd_vfs;
 
+	/*
+	 * Only flush withdraw work if initialized. Work is initialized in
+	 * gfs2_fill_super() at line 1218, after init_sbd() succeeds.
+	 * Checking func avoids WARN_ON in __flush_work() for early failures.
+	 */
+	if (sdp->sd_withdraw_work.func)
+		flush_work(&sdp->sd_withdraw_work);
+
 	free_percpu(sdp->sd_lkstats);
 	sb->s_fs_info = NULL;
 	kfree(sdp);
-- 
2.48.1


