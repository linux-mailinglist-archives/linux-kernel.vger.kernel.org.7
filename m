Return-Path: <linux-kernel+bounces-891684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11603C433ED
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4A0188D68A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD24286D6D;
	Sat,  8 Nov 2025 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMH6eU0/"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0B287242
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630961; cv=none; b=VV3Pz397TSpVFyHCHPqMZZ18TAJsroU9Zq9z4gw0vp+eQ2RmqhZ+surwyw0DcIgHBcEl2bMdipuRzhy4WpDXoym8g6a/kZ37Ielf5o7HcXcVBc/RvW5OBDMDzchCiBKXTwHxhZKgYaGTwZNrJCpuBlhVpmyM1W/nQ89eVV29P/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630961; c=relaxed/simple;
	bh=jnr4/IicmhQWUarmW2dk3Y2ffc/gcKbJW3iMq4WfPl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZUfCNA5Ucde2xnnuXb3jD2tArnWFjSoU8OfvXUkZ0wSYhRbLhy0cvLaSGH0zhg4BcddahyNRz4X9ImOie2Qye3FZTWVseYMtb/K3NINf9Fy6uWIQUUc4hA+Ml2MkTcEqJcKuBCRpX4O3qiCXgMiBrssRf6lfi01gpvB/d8FFBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMH6eU0/; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3737d0920e6so21427281fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630958; x=1763235758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYGbqwLXExmna8eBWQ52VSI73UhSuti8d9ZiNWksIVc=;
        b=kMH6eU0/iTjepgzoJ8NitP6u/FQv7uxZY3PJ8Z0EYffEWMDx1NWYtEYD9JchUh90QO
         ib5RT/0MNry/3eDh+6DYFbXQnoi92ye7fODYqWj7O8E01nKQXQ5s2E8xQN1waDCLxE2u
         BcCEBfm4V7+6mG7y+0YlHIka0O+/z5Cf1FEAK8hV62eUtjPQDXaDVpkx3HQGmjUtgiWJ
         hJv9VYuu2jB00TDI1p9Qhvhnbve8/egnangDU5kyptqrngUds1Vn1j4pjg3TpwvdVbB+
         PLRLe/xhtNVlAT5zHbZX5f5rMpAZ/6DpQw+WBQclEJS9CsLADiOpPYqTC7c2LG7JfItv
         b61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630958; x=1763235758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYGbqwLXExmna8eBWQ52VSI73UhSuti8d9ZiNWksIVc=;
        b=kAEfWIQ5ZHAgyAZ2q7Upjhj9OOMDJ1a/xiZayqdvyGQ7GFPaeVeiEgn6jkz/zaDQQC
         krUHW9rM72ZxuYxmi2aeWgn9vRc4cKG8n4piUsBsfr9LNuZp8JxuO246UoJ2DxhwwGE/
         R6UOA+TN5ReztmMAymNBtw6Tv4eDNkc7Kw602vnwfhujE7GSXThWRb6+Ocx8hygRAAbF
         zKSdin9jEr2S83XpURpsHGdvCnHAWc5964rgMZB7IyRhc4UHmHnmqXu7JjPPmtY9v3V+
         im9n8HifG6ntgndtc9yWh+8JM2ufZhqwHE2CzoGp6j2RnjqitzFb2Dq9nmY3RtbqavNn
         L42Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYl68/oEWfHMOCPfFMJVmLPDcGQDwwGoEqlnxr22KYehUMKzCg9WBFVfUgD1cQiWoea1290LMTT7JQsGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUKira+dOTQR9M0GRUzp67yy4bWi3yTmiyLvRe4TCXbZqHqLp3
	cXt9XqE34E1vm31Tygi9ROnJpq7Ftm/y2mVrt34r/9KoejQOziWaYEaU
X-Gm-Gg: ASbGncsJfDXNYminTaDRucsxwLrm50/5PnChjRYIRf2XMSaKYSb8n/kCOakxoHSXMZQ
	XC6bVqTTX/B6dG6b3VWOcTOuT0rZoi7d059atRXsnEzDUt2tt1ojzNS9EaNdX1V3Z/s5k7zHeUn
	xR7jmBe3msB0SHts9vY6sESGor6IVLgcw+ERH8TOmQ5s6/EI7ul3zhVwSiaph9WNf9KoiUropUh
	Z8B7nDVFfYhIozhoVWlx8lBaf+dH9Kw4lJ82BeIjhGikkPxUgEn8cvBhDOPyEgaumcdtjLqV8A4
	X1V8uxQWx87VXN52cvEZifhSI32ZEnDra+TX+IknLdnWvtZfUKfGUgPzJQ6iPMJqvmWYkOFYGKz
	is0uOzYlgKdFP89/lvAFD6qyKa077stLpCdKrI2z6bNP3ZhHl7ZxqeGqhqWI8BpvYDwgTWTlGAI
	RnnQ==
X-Google-Smtp-Source: AGHT+IGCGTuLFvx1ywHQFavK6M7uVgMXiMcQh8hxSwydElhFvD3mPQcbttpE9Nqhi6nEDN0y6TVfhQ==
X-Received: by 2002:a05:6512:3da6:b0:591:c862:2b2e with SMTP id 2adb3069b0e04-5945f205993mr991066e87.45.1762630957976;
        Sat, 08 Nov 2025 11:42:37 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:36 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
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
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v4 6/9] riscv: ptrace: validate input vector csr registers
Date: Sat,  8 Nov 2025 22:41:45 +0300
Message-ID: <20251108194207.1257866-7-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108194207.1257866-1-geomatsi@gmail.com>
References: <20251108194207.1257866-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add strict validation for vector csr registers when setting them via
ptrace:
- reject attempts to set reserved bits or invalid field combinations
- enforce strict VL checks against calculated VLMAX values

Vector spec 1.0 allows normal applications to set candidate VL values
and read back the hardware-adjusted results, see section 6 for details.
Disallow such flexibility in vector ptrace operations and strictly
enforce valid VL input.

The traced process may not update its saved vector context if no vector
instructions execute between breakpoints. So the purpose of the strict
ptrace approach is to make sure that debuggers maintain an accurate view
of the tracee's vector context across multiple halt/resume debug cycles.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 62 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 906cf1197edc..a567e558e746 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -124,6 +124,66 @@ static int riscv_vr_get(struct task_struct *target,
 	return membuf_write(&to, vstate->datap, riscv_v_vsize);
 }
 
+static int invalid_ptrace_v_csr(struct __riscv_v_ext_state *vstate,
+				struct __riscv_v_regset_state *ptrace)
+{
+	unsigned long vsew, vlmul, vfrac, vl;
+	unsigned long elen, vlen;
+	unsigned long sew, lmul;
+	unsigned long reserved;
+
+	if (!has_vector())
+		return 1;
+
+	vlen = vstate->vlenb * 8;
+	if (vstate->vlenb != ptrace->vlenb)
+		return 1;
+
+	reserved = ~(CSR_VXSAT_MASK | (CSR_VXRM_MASK << CSR_VXRM_SHIFT));
+	if (ptrace->vcsr & reserved)
+		return 1;
+
+	/* do not allow to set vill */
+	reserved = ~(VTYPE_VSEW | VTYPE_VLMUL | VTYPE_VMA | VTYPE_VTA);
+	if (ptrace->vtype & reserved)
+		return 1;
+
+	elen = riscv_has_extension_unlikely(RISCV_ISA_EXT_ZVE64X) ? 64 : 32;
+	vsew = (ptrace->vtype & VTYPE_VSEW) >> VTYPE_VSEW_SHIFT;
+	sew = 8 << vsew;
+
+	if (sew > elen)
+		return 1;
+
+	vfrac = (ptrace->vtype & VTYPE_VLMUL_FRAC);
+	vlmul = (ptrace->vtype & VTYPE_VLMUL);
+
+	/* RVV 1.0 spec 3.4.2: VLMUL(0x4) reserved */
+	if (vlmul == 4)
+		return 1;
+
+	/* RVV 1.0 spec 3.4.2: (LMUL < SEW_min / ELEN) reserved */
+	if (vlmul == 5 && elen == 32)
+		return 1;
+
+	/* for zero vl verify that at least one element is possible */
+	vl = ptrace->vl ? ptrace->vl : 1;
+
+	if (vfrac) {
+		/* integer 1/LMUL: VL =< VLMAX = VLEN / SEW / LMUL */
+		lmul = 2 << (3 - (vlmul - vfrac));
+		if (vlen < vl * sew * lmul)
+			return 1;
+	} else {
+		/* integer LMUL: VL =< VLMAX = LMUL * VLEN / SEW */
+		lmul = 1 << vlmul;
+		if (vl * sew > lmul * vlen)
+			return 1;
+	}
+
+	return 0;
+}
+
 static int riscv_vr_set(struct task_struct *target,
 			const struct user_regset *regset,
 			unsigned int pos, unsigned int count,
@@ -145,7 +205,7 @@ static int riscv_vr_set(struct task_struct *target,
 	if (unlikely(ret))
 		return ret;
 
-	if (vstate->vlenb != ptrace_vstate.vlenb)
+	if (invalid_ptrace_v_csr(vstate, &ptrace_vstate))
 		return -EINVAL;
 
 	vstate->vstart = ptrace_vstate.vstart;
-- 
2.51.0


