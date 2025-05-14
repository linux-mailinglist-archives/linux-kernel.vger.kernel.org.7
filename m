Return-Path: <linux-kernel+bounces-647381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A155AAB67C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 11:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586317B4473
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 09:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5322D4F1;
	Wed, 14 May 2025 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CjNOLa0k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MREWsN+e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9922AE7A
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215541; cv=none; b=g/LZxgobSeOfaDvsA/nV2FwGLlT4AnfWy+eGav40LAS1G2wMV1RPRO7hxFCnxtnBjlgHKzeW/t2nJTlZkTL814Yx8BAEP+qKRtQbax4EKP3ZrWQS3WhC5ryLw8OacHE3Q4cUk8MKX0AQW3h17c9Q05DUlhllCMjQeaAo3a1QeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215541; c=relaxed/simple;
	bh=pp8rXHmAAbML37R1XE9nWT97fOfbqMxBcQMy5qEtWuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mOZrPTgYU7oGul0/7hnsDFjr2hYvw8/1nCrzEbANc8xYlha6rGtKWCmfbDWwkdZKK0Qj+/NXVhq1Ktp1fcqcAGwrrmYxQNze0Z5Md0nZiCOgkAlM1NFZiUxIgLZRULjIrAsABGbo/0Dr73rA9AEbWjHqF2IBihwTN9nOd9Lrxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CjNOLa0k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MREWsN+e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747215537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LK+Og6CgstdynsfQmcoHpOPeAtyjebuHccUKvOXx7QM=;
	b=CjNOLa0k4B30MmTLnXdLk3vjDzqeMwucYzVXriRYkskWy3Lx6AkhGPSMBz2sUka3u67E2r
	QpCrGj1/ZcLI+GiMVBmyYw8pUGBRHHBRfAfLjFg3QvJ0bup0J/HMbkQKPrVe2sFODu1cpB
	EQzigHl93WFISnE0JxMv4JlMwcwFjs18bgzjsMs1CI9bqTAxlVAYuQeOSsqTZxvUE0pc5q
	0WN5uWelwOSlc7FJl21fGOGz+0uW2sdis0EjcqHsZM9iM37R5pFn1pjEtbzH8Tv2zpbb/b
	+ePW8jwhhOs39cXAizEIbzj4wBnYGsjIs0m/AKhivUcrYxS5NUpoo+mYdLCxRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747215537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LK+Og6CgstdynsfQmcoHpOPeAtyjebuHccUKvOXx7QM=;
	b=MREWsN+eYcLWH45438eJ/TnM+IWRxtCMgbkxzsoS+xk3eUCQcnN7LOcxS40DEE7f5AYitS
	0rg3tQ9Q65Kk8CCQ==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 03/11] riscv: kprobes: Remove duplication of RV_EXTRACT_JTYPE_IMM
Date: Wed, 14 May 2025 11:38:42 +0200
Message-Id: <af502036738d381c6bdb96a236d21bab8c343f74.1747215274.git.namcao@linutronix.de>
In-Reply-To: <cover.1747215274.git.namcao@linutronix.de>
References: <cover.1747215274.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use RV_EXTRACT_JTYPE_IMM, instead of reimplementing it in simulate_jal().

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/kernel/probes/simulate-insn.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/p=
robes/simulate-insn.c
index d5f74fadbc3a..b76a691d0d9a 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -41,19 +41,16 @@ bool __kprobes simulate_jal(u32 opcode, unsigned long a=
ddr, struct pt_regs *regs
 	 *     1         10          1           8       5    JAL/J
 	 */
 	bool ret;
-	u32 imm;
+	s32 imm;
 	u32 index =3D (opcode >> 7) & 0x1f;
=20
 	ret =3D rv_insn_reg_set_val(regs, index, addr + 4);
 	if (!ret)
 		return ret;
=20
-	imm  =3D ((opcode >> 21) & 0x3ff) << 1;
-	imm |=3D ((opcode >> 20) & 0x1)   << 11;
-	imm |=3D ((opcode >> 12) & 0xff)  << 12;
-	imm |=3D ((opcode >> 31) & 0x1)   << 20;
+	imm =3D RV_EXTRACT_JTYPE_IMM(opcode);
=20
-	instruction_pointer_set(regs, addr + sign_extend32((imm), 20));
+	instruction_pointer_set(regs, addr + imm);
=20
 	return ret;
 }
--=20
2.39.5


