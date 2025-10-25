Return-Path: <linux-kernel+bounces-870133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BC2C0A02C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45833AE847
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F63299ABF;
	Sat, 25 Oct 2025 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvdy4u8K"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3142D8DB9
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426434; cv=none; b=u6S6F7g80MhlJy8tcrUoktPguCHkvkUZUtZqm9fy+Rphz7oDsaQla/Rlhnm0TYMlRd64klFJ+HssfeyAcv2e5xyEmrY2bBqtc1wDtSclqeRiKUe31nIpcoQ6aRg50CQ6x5+c5AwEqQpCu7oBxMXpWbRUakHj2rsBwmeVcFg9O3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426434; c=relaxed/simple;
	bh=vKbmQPnxwBg289DjWSmS0b59pBATdSkR5Ho4WAMAT9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y29wDTpW+wvzYnaZleJCGBgPm+DaXZlXj5j0cAxeLASrruCx4Cocdc2wdeQplV04JzfXhlm15VmZ+23KjTNwDGAXnpP8M6gzCR3aiDcRTFc8X/Z2j2gceC91NCPw8Ro8BKjz/vHu7O+qRxji6kY8AshI0u6ZuG20uW9MX6ZgTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvdy4u8K; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so3635733e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426431; x=1762031231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOKLEyEqhroRvoLq2wOrgCP0+QeKumxXjJG7yF7kNYg=;
        b=jvdy4u8KNy0jWtN6XzskatheWMC1wnAf11lb0V4AjfZAfGD5jNHjl+3RYDapacVt8l
         qV3r5ENo5abtfyHaov/2tyz95MJIbthX1a7rNT41GkuYoXMcZrhAOamSRyuXkVTUvEc/
         0K41iBv6b9Conc4UBlDdLfs/i2hqf37MPMK+kvu4eP0y1ahxrqKqJs+4vnpokmOALGJ1
         L4C2s1QmkAoNWndF8WawP1oYNeiygoPUSAoHagg0yDQMuds6M1wcgtu3hXBd2PWSmtmJ
         WqGSeItSy8WBJpbgBQn5E9TRigbby94wagDHCB6Q/WmnRlOcDwW2hFmkuDICMwGu4Og2
         wUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426431; x=1762031231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOKLEyEqhroRvoLq2wOrgCP0+QeKumxXjJG7yF7kNYg=;
        b=D+fpL9QVexvUYpTvK06TDsF/0ceGoCTA/vy7uXZnFgz0n9PJYV0qfd2Tx9/HFTgnkr
         hhdjH7oR945VgFEZXis3JjQYQvSd+rVvqFFWwxEeVB7AdCgJ3GYavrNldE8YMKwfgTrq
         sfcUFGyEs6aDBw2dNJKFUjogsxMTgE5Cltjtz4kFq+g0RtJls4lR/dT1zbh//63Pf0Ak
         OJIjlaHjDHbQQGxdS+qa6beVW40Se7o4M7/XYr+sEGSudkFTwH+mfMqtv+l5JOGM2keR
         XeFRRTJVNtLWtM/4s/4uN0WCvloXcEcOKlyXmd65e900YIllcTLXivoIOkm5SSTLVSrj
         TSfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+59FtFp5gA11d/0RMGdPMPUsXv8KCpdpN+TqVetDzixShbt9rWwab7aAfX4xcdAXRbrNaDMjUBvDxrsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIC6o0qvmDbj+NPhVp4qDWgDdKxFk1t8JU3Y8gllQZTgjDEjRa
	25kzbPZaf8j4sPXoUCNxwae01ccCGUIRjlJXf3NkL1KYZVSuKCwMsWGU
X-Gm-Gg: ASbGncsX5cQ5NlMGFnAqPwHg6JrW7bpm0lvpNSCc9zn2HuP7zR1sfYfqv+rAQj5wJqH
	ZU2VuIphPWn8Vjhdp7PjzB3bmwTj04bpHHGZ3qHvw187vJkndbF1ai/I5nccXn9Eu7LFRug1lHV
	0klsXDaBGqGQb623SDKM340bhOQ1eKORUWlh2fd+JfTIZqR9EgjiPcMdJBHDN5k41ci89Wv/Vnq
	vSW+nAVwLSk4ONtYyhu1AemS/6RELAt7Im2cwfGB9fEEnuTIy9EXwU84T/5ygpIu7X+bdaTyJmM
	uVKpZHmOAAzpnmWtepwoZ3OJj8uOwg+HFRB29f359wnXCc0hDFMBPRktvczxL97bzkSC0w2lm7K
	IX/5vWV67iEtE9gQZNtpxdoClQ7Ka052zWNk66rFMl+A+f2TchAXQAsQacHSKPE6AXbQ=
X-Google-Smtp-Source: AGHT+IF1PY8CjKZBltkRiaMjAPbsy0y2I5sExlfobv+KioSsAE6i9yPd2n/v6imAUn4q9skXUbuNAQ==
X-Received: by 2002:a05:6512:1581:b0:591:c93c:cf6a with SMTP id 2adb3069b0e04-591d84cf7a9mr11591651e87.4.1761426430511;
        Sat, 25 Oct 2025 14:07:10 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:08 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Ilya Mamay <mmamayka01@gmail.com>
Subject: [PATCH v3 2/9] riscv: ptrace: return ENODATA for inactive vector extension
Date: Sun, 26 Oct 2025 00:06:35 +0300
Message-ID: <20251025210655.43099-3-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025210655.43099-1-geomatsi@gmail.com>
References: <20251025210655.43099-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Mamay <mmamayka01@gmail.com>

Currently, ptrace returns EINVAL when the vector extension is supported
but not yet activated for the traced process. This error code is not
always appropriate since the ptrace arguments may be valid.

Debug tools like gdbserver expect ENODATA when the requested register
set is not active, e.g. see [1]. This expectation seems to be more
appropriate, so modify the vector ptrace implementation to return:
- EINVAL when V extension is not supported
- ENODATA when V extension is supported but not active

[1] https://github.com/bminor/binutils-gdb/blob/637f25e88675fa47e47f9cc5e2cf37384836b8a2/gdbserver/linux-low.cc#L5020

Signed-off-by: Ilya Mamay <mmamayka01@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 8e86305831ea..906cf1197edc 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -95,9 +95,12 @@ static int riscv_vr_get(struct task_struct *target,
 	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
 	struct __riscv_v_regset_state ptrace_vstate;
 
-	if (!riscv_v_vstate_query(task_pt_regs(target)))
+	if (!has_vector())
 		return -EINVAL;
 
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return -ENODATA;
+
 	/*
 	 * Ensure the vector registers have been saved to the memory before
 	 * copying them to membuf.
@@ -130,9 +133,12 @@ static int riscv_vr_set(struct task_struct *target,
 	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
 	struct __riscv_v_regset_state ptrace_vstate;
 
-	if (!riscv_v_vstate_query(task_pt_regs(target)))
+	if (!has_vector())
 		return -EINVAL;
 
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return -ENODATA;
+
 	/* Copy rest of the vstate except datap */
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ptrace_vstate, 0,
 				 sizeof(struct __riscv_v_regset_state));
-- 
2.51.0


