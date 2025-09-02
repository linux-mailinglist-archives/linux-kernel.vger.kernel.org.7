Return-Path: <linux-kernel+bounces-796713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25116B40637
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AE6188753C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEFB33997;
	Tue,  2 Sep 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JX4SWZd6"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248C1DD9AD
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756821986; cv=none; b=RSxpUrxXd1Mw9yYaHNejtktEqHO1/VuP+/czlODZ0apiUCZUxE9EQMIIjONIgvDrtRbsADLGv21lMLX/E8hKXz3RqHgK0NExMx1V5765snFqD4IZt3KrrYDp7n0zw9Gw+/3kdGtD0ewhzLoAApMOPPXnkngfZ4EqjCpHzUCPcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756821986; c=relaxed/simple;
	bh=uLft5kRVu50U08OO/8BXcCGPsrG3pukiHLm/Fxycblc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MAxIxEbfbsXgkCjV+89TUScL2ir9Ijz+EB6WbjLLnx0TQTRg0qFcl7wuQ5DEkb/tlct+HXqSlUwsKMYq4s7l49NOI9DwtKsc8ceVuj/vfbx6OBR8Mma8Jf+F8gYRs6TYlQS/IL4eU6WHx9KP9RcCgdmGVOB6aGMjug8jifEd1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JX4SWZd6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so2204008b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756821984; x=1757426784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3vAMDDKCjzCh1ioreOxwAOGysxZFkQVkoExnnbmuyM=;
        b=JX4SWZd6/IF4cM51tYU0NO/8M1zfb89DPhMYNcMXBVZQNtZ9R9slGoV+087a/5LiGh
         TE7FTjy6hEt18iCxVh9v+zLCCk8yoaebdl22oLhg6+Sg+yXz6KrjfhKWVuIIyjVcPx7v
         N21eYLyF43TplMTGTFV1YxwmBbvM19KmNZjjweuTcLq+QzsIEiTCxkxQjh1/bm+skAij
         tCJ529C+OGdKwLFguDdv8UT8rweF/9wdeGkbVM1hrvsneVUeBjlL6HeeF9qQst9D2o1N
         2Ds2bfOkbesdzl6uh2eAMcG4Hxs99cHnKVDPf4rnIKHotOJhnEBPikQVUwU+JlAzrDdb
         lQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756821984; x=1757426784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3vAMDDKCjzCh1ioreOxwAOGysxZFkQVkoExnnbmuyM=;
        b=gbXxawCl4Dvlj2t4oMxhRJolKj8lNz4oi6YOJaOIhlWEeZSyZ6UOoR9IaIb5nK8fD4
         w2kbGwylMPumsKnJZkprpF56xCa7Qq0GlQIun+RBwiBRe8EFgC1dNUpfNVHtUI60AGse
         Lf99eFFuMZTfNfXun/ygEnLlZZ9Sh6ai7jbeBlvPkuvC+k3l/SerPVNb+wm1myDGhxlK
         /6Aaml2Zi+HpIlTAnVXJiPD1E56MxhDYoI/Kl4ECW/bHbTySfuoCyLS2M0i30TELZ2Tl
         uqvvslmjIW1uullyc7i9mky/6vQ3K1LxpnzE37LT9xdzQYtqmF0E0pArCEU40h89PJRQ
         9dmQ==
X-Gm-Message-State: AOJu0YyphH0FZLts95ZOCs6UoGbfbom/AAwz1w6+RsQuPgPs7KSLGZlB
	mC/kITalKzWBM/5H+oZ4V9wG22jmLc1gZ/964DudoRQJnY1ZxcO7MWqzTc/K7Q==
X-Gm-Gg: ASbGncu5K23t75SybIMfYfhBpChW7GZQK4lK4cCo9DRT+Fp8umOoita3+jMGaJVT+Tp
	qV+Hvzq+eyef1m6AElMKVxx2ZWLH16LjQfDdhZAwet+uJQNLbjDe1dAIBi/QkxfYuPoUqPfxL00
	6nYkJiQE+eJEvVyeqwFLNooHUO9n7rnYHn8Heb7v6LkY1QxClk1HR+kXTVVV0+vvUIv+oV7j7mj
	ffghxK47OBhSa2hMWFHi3HyBbzmn2Ak/XQplOaOnzrnS+wipOF5tU1TlkDguEEjE03DgVYGVIFu
	yycZ/PqtAW8NWWzfzqii9T2fmTeAFd7jB4rK9TMEaD3FEl+NBk3QnPw0Cy01rnqEAr4MAhK3MY2
	xxsDwZV5cYx0pWHrGAcPDikPs6a8EFXqfhqL3vQ1e5WUGRD3K79GCKFrxyV+1unbNqDDmmjgnOi
	TQkaW9Uw==
X-Google-Smtp-Source: AGHT+IFsScJ15/QUZv60Zo2uHTm2UDdGGH2WIwQwZpn6zxGguEGAcChStYOSgmUQZBZg3Dn+Yt+tsQ==
X-Received: by 2002:a05:6a21:3396:b0:243:b0fb:7086 with SMTP id adf61e73a8af0-243d6dc8084mr14285242637.4.1756821982032;
        Tue, 02 Sep 2025 07:06:22 -0700 (PDT)
Received: from localhost.localdomain (36-231-167-123.dynamic-ip.hinet.net. [36.231.167.123])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a269f27sm13927961b3a.12.2025.09.02.07.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:06:21 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kusogame68@gmail.com,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH] ipc/msg: Replace testmsg with  msg_matchs_type
Date: Tue,  2 Sep 2025 22:05:48 +0800
Message-ID: <20250902140548.110167-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function name testmsg is misleading, as its purpose is not to test a message
but to check whether a message matches the given mode and type conditions.

To more clearly convey its role in validating whether a message can be used for
send or receive operations, it has been renamed to msg_matchs_type.

Signed-off-by: Nick Huang <sef1548@gmail.com>
---
 ipc/msg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index ee6af4fe52..0831a3589c 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -791,7 +791,7 @@ COMPAT_SYSCALL_DEFINE3(old_msgctl, int, msqid, int, cmd, void __user *, uptr)
 #endif
 #endif
 
-static int testmsg(struct msg_msg *msg, long type, int mode)
+static int msg_matchs_type(struct msg_msg *msg, long type, int mode)
 {
 	switch (mode) {
 	case SEARCH_ANY:
@@ -819,7 +819,7 @@ static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg,
 	struct msg_receiver *msr, *t;
 
 	list_for_each_entry_safe(msr, t, &msq->q_receivers, r_list) {
-		if (testmsg(msg, msr->r_msgtype, msr->r_mode) &&
+		if (msg_matchs_type(msg, msr->r_msgtype, msr->r_mode) &&
 		    !security_msg_queue_msgrcv(&msq->q_perm, msg, msr->r_tsk,
 					       msr->r_msgtype, msr->r_mode)) {
 
@@ -1077,7 +1077,7 @@ static struct msg_msg *find_msg(struct msg_queue *msq, long *msgtyp, int mode)
 	long count = 0;
 
 	list_for_each_entry(msg, &msq->q_messages, m_list) {
-		if (testmsg(msg, *msgtyp, mode) &&
+		if (msg_matchs_type(msg, *msgtyp, mode) &&
 		    !security_msg_queue_msgrcv(&msq->q_perm, msg, current,
 					       *msgtyp, mode)) {
 			if (mode == SEARCH_LESSEQUAL && msg->m_type != 1) {
-- 
2.48.1


