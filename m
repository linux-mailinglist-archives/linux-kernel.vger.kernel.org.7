Return-Path: <linux-kernel+bounces-815384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97234B56396
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 00:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D322565B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B12BEC5F;
	Sat, 13 Sep 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9RXjM+z"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23512BE034
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 22:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757802251; cv=none; b=KFViSbc4G8PQHtzcfo7/f7sNcO944kUFE0cRwzb7Gxos8bVbUCeakHFCPgOv+EIebn6ywNLEJ1a9ktQdP1iXoXwIyhdSNkJ3e++4OZQTJCC/GF2DgbO7ppI8zBuSlNhWMaG+eYsNSxsj3Bk33IN10MSjdF+a/JH4Z4WJCwFD29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757802251; c=relaxed/simple;
	bh=6MnyGHDG1rusY3NQB0hLrFzipj3IpjlxWbVDL92fm/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZlD4Ky11ZjUlUwKkPPtbRyMIebTe67hzpkRyeZIsLGtgRIP/w3aSqGJ93SHoOmlR5tS7IbzqsWyQQltWqbQMS7jEC3VzqFWw/EQxMht3c5gui5O2KLG9FFRTVNtJ0h3RNNICo6L0OOtRhtrxhUTytxathXGsmjIspATxg8vNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9RXjM+z; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7761578340dso2178819b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757802249; x=1758407049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNusiAJMG1RTzATvkpKjGZWnI3GIvk3GTQ3dPlhq+mM=;
        b=l9RXjM+zBqZhFvQKLgj/fwOK5WtpqpsXnECCs6TmN/JFZ4WK0X+BA0vg8k3j6zEpIj
         vO2tPj62fYM3Cc3oiRQ+8FV/1vDRBlUpLcyLn3/FlkL7jEe+72rPA3XtDxDfYWVlqLhh
         kQgvreozYzmX6F8Q60hVRx1P4IC9DawNMgFu/0DsK4peO8ps/Y1oHJsTqXFf5f/4I6+T
         hKNKzIu0KsimS95l7lKO4aOHcHTDMqrnJAJzswI++nVupQGVNmWenSR8FW6kXi5SYwVp
         A3eNEiIEuK4Jm2QnRXXqRvDSP1qJZoJF3h4l4dm4mBF7Wb0fIedEqhdRNxopDCs3fjvG
         gDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757802249; x=1758407049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNusiAJMG1RTzATvkpKjGZWnI3GIvk3GTQ3dPlhq+mM=;
        b=MDyHsnZhr2IVPubUlGs6jVRsf3Rw1fB+0wZVW6+yZewjV/r3oNJX7zOIC0JNSd06k5
         QTPZ9ni0gMSyoL874JCIH/WPGppikGiC+6TeQ2/mNa0q1PEZMn9y+D16fyyo8fsJHQnZ
         saPAcz9l0X2tqNchHiOJvtTQjOUiKBTJIupY9tjy+FaM4EOQZ+jaBkMHTQp/ugWXCyt6
         55CRBkXVCMEYLsXg+CvYv8FvchiEu2QiEjkBhjVrrgH/KrADH8u+6u+nuXrF8ptVS1aG
         /vWdX9KzTI6/JCA/yiPiysQ3XisH1YhJYRC91T+/ktgKisZdHKDQa5U9gUYcDGeYZ9Kl
         Sgqg==
X-Forwarded-Encrypted: i=1; AJvYcCVZnxV5iUhsPR5UtCWxBiIMUUzXKQ6kt8h8iXeOPml5zCdSskfOjgGMRBdMQHsoz3oWvrCATK4vVRX/fjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34xElXkxdexLHIWdh6Fcqx9hcHnzZKTHFszqsJQrx+V9FH0TU
	pI0gDVuXbOveJRdWLqhAqm3aGNgm9b/8JllCIMVRV/8vw5e2r1rYKrCg
X-Gm-Gg: ASbGncsuUReVcmTU4XXb9t1oc1ccyWQ3lvw3Uthw4l1Cg6bJE8KLosHi2KYBqvKL6v6
	IRWGyxizMMwrkyQYKCsFv/XOlMrXbv+zWZ1HqMXH+Xy3HiHRsT2yNP8OGaGdUTuHaA/b+pEvcD8
	Ekrh+QS6SUyjXY5gsTmUPn4fn0JNPporczjAeFMPTvGDhh/NSCZLZbe/EwLA/EChDo9PBeI4FkW
	PFJ7B6e74p2gHavLyHkA/FgJeV66bgwq+qyTPXbQ9tvOGCRG/V2f+Fce5pUUxOoR5h0Gkulop7Q
	71MKROmNUvQs9Z97zGvTNRx/UUQhPPBR1NTqrgPDXBfx51d170OuZWFKUHLi3sFrE7y1n41ZRz+
	XQCLa2iM3Ux5MW01y6+iTsREvOHroSTcFs/KdY/9eaQwVwEET+xB8tXJyM0hm8HKasRg0Nlfluw
	n/tUmiYIpQMVHq3OIoLMYyRaHoWNG5V3fvdJyn
X-Google-Smtp-Source: AGHT+IH/5SIKYW4a2UvOEi85RoAgE5wgtLyQpdm4OPJOd59TSMw/eqJBPBbkFEJjKYxCPxkTuc8E/g==
X-Received: by 2002:a05:6a00:4b49:b0:776:21e4:23f with SMTP id d2e1a72fcca58-77621e40333mr4826900b3a.15.1757802249130;
        Sat, 13 Sep 2025 15:24:09 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793be6csm9326449b3a.14.2025.09.13.15.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 15:24:08 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Subject: [PATCH] bpf: verifier: fix WARNING in reg_bounds_sanity_check (2)
Date: Sat, 13 Sep 2025 22:23:23 +0000
Message-Id: <20250913222323.894182-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a "REG INVARIANTS VIOLATION" triggered in reg_bounds_sanity_check()
due to inconsistent umin/umax and var_off state after min/max updates.

reg_set_min_max() and adjust_reg_min_max_vals() could leave a register state
partially updated before syncing the bounds, causing verifier_bug() to fire.

This patch ensures reg_bounds_sync() is called after updates, and additionally
marks registers unbounded if min/max values are inconsistent, so that umin/umax,
smin/smax, and var_off remain consistent.

Fixes: d69eb204c255 ("Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..8f5f02d39005 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16299,6 +16299,19 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 	}
 }
 
+/* Ensure that a register's min/max bounds are sane.
+ * If any of the unsigned/signed bounds are inconsistent, mark the
+ * register as unbounded to prevent verifier invariant violations.
+ */
+static void __maybe_normalize_reg(struct bpf_reg_state *reg)
+{
+	if (reg->umin_value > reg->umax_value ||
+		reg->smin_value > reg->smax_value ||
+		reg->u32_min_value > reg->u32_max_value ||
+		reg->s32_min_value > reg->s32_max_value)
+			__mark_reg_unbounded(reg);
+}
+
 /* Adjusts the register min/max values in the case that the dst_reg and
  * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
  * check, in which case we have a fake SCALAR_VALUE representing insn->imm).
@@ -16325,11 +16338,15 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
 	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
 	reg_bounds_sync(false_reg1);
 	reg_bounds_sync(false_reg2);
+	__maybe_normalize_reg(false_reg1);
+	__maybe_normalize_reg(false_reg2);
 
 	/* jump (TRUE) branch */
 	regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
 	reg_bounds_sync(true_reg1);
 	reg_bounds_sync(true_reg2);
+	__maybe_normalize_reg(true_reg1);
+	__maybe_normalize_reg(true_reg2);
 
 	err = reg_bounds_sanity_check(env, true_reg1, "true_reg1");
 	err = err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
-- 
2.34.1


