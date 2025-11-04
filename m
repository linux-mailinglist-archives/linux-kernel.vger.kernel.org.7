Return-Path: <linux-kernel+bounces-884619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AFDC30989
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A12C189F151
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7312DEA61;
	Tue,  4 Nov 2025 10:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGuDfNkV"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7298C2DAFC2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762253365; cv=none; b=bGHpNUjx3/00+J2XqEwzR+W6YNTXZSsSPY3yWgnBCBgbLfrmAuLl+y2gRyTt18/Q7lZGW/hMzycFA+ajP7gQyx0NSvbWWk2RdvimihFIhwJT8Ux0KOYqegBNVZf8gc6DZSYllV0YPdn3fTIdPXDwRG/ap0yEiSgND8jb0arbtZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762253365; c=relaxed/simple;
	bh=gFtzIHzH+feMWJwo3pq+PvWg1fj4+2mq/x330+5X7j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=afUlb68x7uJFonxm2t2H4w/swIvvDQ1ntBOFz75Jnr/XlCLH1+FihCNe+KCVKZAbCWNrd42RHknQ9b+9IwhQRfO7uzpFX6HNX73y/bJyL2DlxaKJxGpwg/BNglB7ZvV9oynpWi5rMWght/eFHYkyzKvJjcenifqeTXmNADuIKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGuDfNkV; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29524abfba3so40042965ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762253363; x=1762858163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mcG5rrfn0eYABeDV2UUy44PLYPKH9hFPkeHvBJGBvcA=;
        b=YGuDfNkV0XJ7aKEt+ZbGNAOHUz43yyx6DLn8Fo8O3TmtBmxQ/VOfAg7Fpuw1OMY1rU
         ZddPgHWMprdsge3+XHvpaFezmuX2HxEMZ0Ch2FKyH9+hCDUxeSKHfBRg/OJPn/uRrF4C
         S2ZVv6z/wgh6D3o9aSTqJ0BgNb3fPIbOgzyq3Ph69nDIKj3yCuEhLtyT9zoGXYYDkcQb
         YsAlZrWR0ULMW3Q/YSJZ04IIpzc00Vifi/xdaZA3vUAi1wYV/dfopPqpzvwAVbMEmB2m
         4frb3r4Mwur66S0it1Orf0peTJxcRdTDVV3iizXVbAAWgzy3OBBsTrwM0HdV8fjKCcUP
         JCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762253363; x=1762858163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcG5rrfn0eYABeDV2UUy44PLYPKH9hFPkeHvBJGBvcA=;
        b=pelR7/CvO5ftsaFKpFKmpK4zl1S9oRHtqyZd0nnuRYu0K6j13r/L7QltjsCzsL9Lfs
         0dDgMDqglpm09SPzENvv13upDpqFk8vZNd+Dusr4NwL2I2tpDZ1s4eWn5QJk/cVhpg2n
         QhlZsEH2RDDN7k3EXJGRDU9gISJ5QknMHRhnbX9Lfjl5U4MVKXVCRIRQHooVJKRuEWAV
         hyU3Ait79Tqu9+5rSuvCOGzsJjbjvuGwBBvZhZocADg3OS3viHwK6klYB1klJCXWropR
         4OIOkpwc/TrQHBl8zNi/MHDzxRhB6OK/MSFo43amALvjDAXHhq2+z+ogQxQ3uJrY4lgS
         q2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkac41I9s0xvuybIep0zbmzmLUuF20ndaF9tzqJNZUxpGr61RrnUJoKw6N0095+NbzwDfd2f+6MbfFdu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFM2jr0peEBytWX8AzJoRzslDHPCZf3o0GwkHaI3qJFAOX8tK
	9bIQr9L76IcUf6G/DNCRy7DB98g3zNgJWmjEqG++xoZu5FmTlkZOexc/
X-Gm-Gg: ASbGncv04bSHomyjc8UoT6KowXDFVEC0l+j5twgb3T+g+5wJ10irR7mbSGHXrbhJXJf
	DURnthIKjXNUfUDFl8DwnivKERN0G0NIxOVl5M3ucvtOIi0yREs1TQ0Fbe+ya2N6ptiqp5nPLdB
	cv7kC8j6COgZQiAuNnqTjjhv786bALEDRXgU66XWfDWfVbMBrwBrOuAFcP5Xh6ukBgjBIu6YtIo
	25SBsr3mUqb009pQuZ0zDsz4mthK6EtZIVh6yLhNCZJZNL3kFGJkrixoJ2CHPT9LXXC8zNyU3LY
	uIBuQW4pJ+xdFg3W/9L9GpBnO4N8Jf3ft3fsVgdQk5oULSZXgstSs973y86oIZo9iOiWiaH2U8Y
	MvR2azkkrJnRwgKMlBWwh+FBhDyG7RuVeDXM2dqUSOK4cy4EeC1ttk4iyS+X35SLFouSHNOy+0j
	vF
X-Google-Smtp-Source: AGHT+IG2P/n05n4+4su8LX8XiTIscuAXJnd0RPNxjz3hjGLueMGYITVK4o2vmRxxXfVfLg6HdxmH9A==
X-Received: by 2002:a17:902:e88e:b0:295:fe33:18bb with SMTP id d9443c01a7336-295fe331993mr35292535ad.14.1762253362602;
        Tue, 04 Nov 2025 02:49:22 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7c5b9sm22013605ad.112.2025.11.04.02.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:49:22 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jiang.biao@linux.dev,
	menglong.dong@linux.dev,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
Date: Tue,  4 Nov 2025 18:49:13 +0800
Message-ID: <20251104104913.689439-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In origin call case, we skip the "rip" directly before we return, which
break the RSB, as we have twice "call", but only once "ret".

Do the RSB balance by pseudo a "ret". Instead of skipping the "rip", we
modify it to the address of a "ret" insn that we generate.

The performance of "fexit" increases from 76M/s to 84M/s. Before this
optimize, the bench resulting of fexit is:

fexit          :   76.494 ± 0.216M/s
fexit          :   76.319 ± 0.097M/s
fexit          :   70.680 ± 0.060M/s
fexit          :   75.509 ± 0.039M/s
fexit          :   76.392 ± 0.049M/s

After this optimize:

fexit          :   86.023 ± 0.518M/s
fexit          :   83.388 ± 0.021M/s
fexit          :   85.146 ± 0.058M/s
fexit          :   85.646 ± 0.136M/s
fexit          :   84.040 ± 0.045M/s

Things become a little more complex, not sure if the benefits worth it :/

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e4..a9c2142a84d0 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3185,6 +3185,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
 	u8 **branches = NULL;
+	u8 *rsb_pos;
 	u8 *prog;
 	bool save_ret;
 
@@ -3431,17 +3432,42 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
 	}
 
+	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
+		u64 ret_addr = (u64)(image + (prog - (u8 *)rw_image));
+
+		rsb_pos = prog;
+		/*
+		 * reserve the room to save the return address to rax:
+		 *   movabs rax, imm64
+		 *
+		 * this is used to do the RSB balance. For the SKIP_FRAME
+		 * case, we do the "call" twice, but only have one "ret",
+		 * which can break the RSB.
+		 *
+		 * Therefore, instead of skipping the "rip", we make it as
+		 * a pseudo return: modify the "rip" in the stack to the
+		 * second "ret" address that we build bellow.
+		 */
+		emit_mov_imm64(&prog, BPF_REG_0, ret_addr >> 32, (u32)ret_addr);
+		/* mov [rbp + 8], rax */
+		EMIT4(0x48, 0x89, 0x45, 0x08);
+	}
+
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
 		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
 
 	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 	EMIT1(0xC9); /* leave */
+	emit_return(&prog, image + (prog - (u8 *)rw_image));
 	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
-		/* skip our return address and return to parent */
-		EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
+		u64 ret_addr = (u64)(image + (prog - (u8 *)rw_image));
+
+		/* fix the return address to second return address */
+		emit_mov_imm64(&rsb_pos, BPF_REG_0, ret_addr >> 32, (u32)ret_addr);
+		/* this is the second(real) return */
+		emit_return(&prog, image + (prog - (u8 *)rw_image));
 	}
-	emit_return(&prog, image + (prog - (u8 *)rw_image));
 	/* Make sure the trampoline generation logic doesn't overflow */
 	if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
 		ret = -EFAULT;
-- 
2.51.2


