Return-Path: <linux-kernel+bounces-815336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 474F1B562F5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A4944E0402
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A752561A2;
	Sat, 13 Sep 2025 20:47:30 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEE635948
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796449; cv=none; b=rNIbQJyWncBrIzRp9TJOGpgynUx9eahc6rm3ruSa+PHjxOFZL4o7MkT3kgBFs874AExtrxvjSTrnsOBHqJBsr+8B2xSCw9vW30HAz+O3rAiazEcG1utEUOBv1R8UFE3U4ddhpJ7yP/r2AWZpdl//o/CqJqbxwYfh+sOy65WRaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796449; c=relaxed/simple;
	bh=YmPTeGNJWJQzIK4aZjInjuHc1GZewTHwElFF/avJWH4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WnXy2X7vY/C0a09P7K7LfgAmiYrZMi1jsgepdjKqB2ASPNaNu88pQbeWam20JIHCjgGyaDQs5yamraA36nM5haPRCFukVqsSFoXUhSbz24XoORaVXo8iMxiKjqIopoQmI3zvEn/SUYbGX/0RZvDwR1alUSiSZLghsiBS0LjHbHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3f31ac5bd9cso40829355ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757796446; x=1758401246;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/WC4FpjWqLFn5mmBSnkjEWLq32iSjZwD0GeD4FCGNhY=;
        b=FO9E3YqMmIZRTbRCkY88MdOiH5DAj3Sip8/y0AT5/qzjwujnTMvukPQfTxLqxCDeLx
         zbukblGHBKHFNJmylFjRqacK8kiCtVenMFZUN2Inc5PJfoZ9znDL1M4MNVdfbhjc3YHh
         Urn8DIsE4FmcBcJEm8bD1T7LydYehSC+qhTy8pA9jc3fRwZXHvVBOSryEPPOhc6rJ0Tg
         jWYFiJeGagMd5ftjP99olftBmFndZ9kMoyrz5CTlnWlx+aiHnUMBEAjHYfe+NSp3BzHS
         HJ7rncxkhCbb0atvHrlGj4c2hDzyY8G2MGBX4oQDtdbyvr7Wp9icZoAiF/fMgDqv2EWP
         iCHQ==
X-Gm-Message-State: AOJu0YwzmHd4Vl9yY485XWOB1ac9yWov4nJvJ2QN8bWbCt7tlhJYWRaE
	T+p6FmJq6GD8sQYDFP3Ife3Ev5gPm+axZYmXVhrgfqqI4UuXLYVvH1ODjY6hSSC0E+hq0aIHUQ8
	UJlPo2WFgKGqNA9eWc0iKYOv5Nq9ZAj0o3MU3TeaF0jcipCaAxr9D6FM3Q+8=
X-Google-Smtp-Source: AGHT+IEEWkIobQ/TBC91FJnfs5WFhdMqQdSFgFuNJ+mT1tLx3DpI2IbfkGONVqfRVZbKqaS+uS69kxA8mN9dKOAWs5yTXX0evmxO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:423:fbf3:18ec with SMTP id
 e9e14a558f8ab-423fbf31a9bmr11538895ab.31.1757796446452; Sat, 13 Sep 2025
 13:47:26 -0700 (PDT)
Date: Sat, 13 Sep 2025 13:47:26 -0700
In-Reply-To: <68bacb3e.050a0220.192772.018d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c5d85e.050a0220.3c6139.04d6.GAE@google.com>
Subject: Forwarded: WARNING in reg_bounds_sanity_check (2)
From: syzbot <syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: WARNING in reg_bounds_sanity_check (2)
Author: kriish.sharma2006@gmail.com

#syz test

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c4f69a9e9af6..4c6000d32f46 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -16299,6 +16299,15 @@ static void regs_refine_cond_op(struct
bpf_reg_state *reg1, struct bpf_reg_state
        }
 }

+static void __maybe_normalize_reg(struct bpf_reg_state *reg)
+{
+    if (reg->umin_value > reg->umax_value ||
+        reg->smin_value > reg->smax_value ||
+        reg->u32_min_value > reg->u32_max_value ||
+        reg->s32_min_value > reg->s32_max_value)
+        __mark_reg_unbounded(reg);
+}
+
 /* Adjusts the register min/max values in the case that the dst_reg and
  * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
  * check, in which case we have a fake SCALAR_VALUE representing
insn->imm).
@@ -16325,11 +16334,15 @@ static int reg_set_min_max(struct
bpf_verifier_env *env,
        regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode),
is_jmp32);
        reg_bounds_sync(false_reg1);
        reg_bounds_sync(false_reg2);
+       __maybe_normalize_reg(false_reg1);
+    __maybe_normalize_reg(false_reg2);

        /* jump (TRUE) branch */
        regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
        reg_bounds_sync(true_reg1);
        reg_bounds_sync(true_reg2);
+       __maybe_normalize_reg(true_reg1);
+    __maybe_normalize_reg(true_reg2);

        err = reg_bounds_sanity_check(env, true_reg1, "true_reg1");
        err = err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
-- 
2.34.1

