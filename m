Return-Path: <linux-kernel+bounces-741195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE619B0E152
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1843A6247
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0030627A90A;
	Tue, 22 Jul 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WlqMtJSf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1227A47C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200597; cv=none; b=kfd+XLW85b/uzs6sjskaarTAfJTD6sh05fpYLo4zh9nJoor9fX7N9lWymIurUd1gqoqbIx/Guw+zDcWMRxd4iFg4Sj8eR7l+KsBpvEMyjcUA0rvSUkbpob3OXg42KD+9zvRojYTyuHNNmLzVvVgTG8t+O7n/U6hlNZzKQUlYK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200597; c=relaxed/simple;
	bh=BDY4sXSBW86+Vui62oyOjJyWQVT4Wa3hYjJRaoCvfTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiAL9JGCIsLCwDvESmiduVs+cxOMtdxfi/CZANXP37nToEN1cJpcJLnZifyVh5Rej83S1KbZFEdYpyAajfK4aOjhLvEXJwaCZpQLWhD+pM/q68AsoN4QastA/zsQqblM86ktsuxU0o7IZ4y0uP92Jy+8FmeJPE7FF1q8rjHBwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=WlqMtJSf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-456382f1a56so2517025e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753200594; x=1753805394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKk7eEoD9Afhi6CnnRkuOlPcLuRjhPLEJ9MSAogYdhU=;
        b=WlqMtJSfsNghU45bK7vmOr8unC2B8B7OUvlQz4hps7OBr0HXb4VdWC4khVVkD4r6gd
         ISokOSXM1QrtclLvQdO70xtsU1mWDSzCsh4R0+3y2U7YeejNbzZP8k2TZHUd7Kf+EfQT
         GQE7mHoyWBsjSGGl9mdr4A+Y0kFZcfmWeId0HhVvNuxCFOnLV4SIKLEy3EUZOyYkoDsx
         McgsChlmGFhTxnjy1dz+9wkWmMITBI5zT4l9w6qL33nj7F5skqVc0K+vh/Xz5sfGFefO
         CV3AWh6G/5PaFkDdRhpItS1mHTIvklgxfwvokgLNYhNrlKenuk9QsiPzY30riTX0/imm
         erBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200594; x=1753805394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKk7eEoD9Afhi6CnnRkuOlPcLuRjhPLEJ9MSAogYdhU=;
        b=F7WBMRxXBYJLFEjOQMmCNRYZnvk2BsnD1o7IyPx/euJEm7/71uOHce0Y1OIWZWmI6W
         HbAahEo1ObkRjJRsnz3YjKCfxoias/Zt7O6Zd25aGqO8oJvMPTCTj/1gIGYbrPl9p3qB
         3uogwHS5j0DkhuuK3CxxFzAuTPi+cLR3u10HzjhMX3p1mBdGCtJPKnFFRUl3EkGb+jML
         qhsNT4neAChgAJmI/Qs/gBpYABCH8CL+7qzzoJdr4CfUqnksty3w9l5LIVIVxXhGz9ko
         Axa7aty3+4xWukoi2cqTMPJM1rMcs+l/ajUKWz7Byi0DMit+Sx5B2mq9OqxxgmUHjkJN
         QiaQ==
X-Gm-Message-State: AOJu0YzyqGv8nLn87XVdeTaieOxtY5vuuHOIZJHWsDFc2Z/8HoPN/Id6
	a9UZ7Z4Rzc+P7JbMGWtFXF9OteNOcSVAGbWaSnOaGAKf40xX+/Aztn1AZzLRVDCFH9k=
X-Gm-Gg: ASbGnctsDc2VnutjMfKaj95nIzZRVytaRYfhyGwlLozhEy2os/ab/tSphQbq+Aa0Dqb
	BUcKdf3Yabj99mA2RuSkCEwgeZ9vY2Qn/+4DHQoPnFaW/UkYEsHYopNspzo80Om6KhUQ5N2Cti4
	NnnvpNQaj9OUoVLu1j9n4o4uusqx0DUAT5tRMMWTywDLYZXQ+2hXBXKX6IpQbkJWNemfP9Libqk
	1BnlYWnydcaKmDXFqGxLqrF6XemBbx22CZlWUZlQhD7+uVxhsfYzOrgFDYs1FaO29xLSUSJEvmL
	w5sulrv3DYqsvn2hU97iyrHIKbFp8+mZULagQ3d+M/Onoba3+BNJ6Xz7NQZCEYT9NajGKjWA1cA
	cpmOtz29AjyG1UH66r0b10ObBKadHKg==
X-Google-Smtp-Source: AGHT+IEdbcW5tiM6a+vZti3qt9gbdvCtyoDm0M+U5Gb52pX9GNPInay3IeMeUoo/yrbUTX9EOmnrAA==
X-Received: by 2002:a05:6000:2509:b0:3a5:324a:a04e with SMTP id ffacd0b85a97d-3b60dd0f03emr7930217f8f.0.1753200593252;
        Tue, 22 Jul 2025 09:09:53 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:30d6:4986:8040:bb0a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca25533sm13602031f8f.11.2025.07.22.09.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:09:52 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 1/3] riscv: use TASK_TI_CPU instead of TASK_TI_CPU_NUM
Date: Tue, 22 Jul 2025 18:05:55 +0200
Message-ID: <20250722160556.2216925-3-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250722160556.2216925-2-rkrcmar@ventanamicro.com>
References: <20250722160556.2216925-2-rkrcmar@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The offsets of TASK_TI_CPU and TASK_TI_CPU_NUM are identical, and
TASK_TI_CPU is a better name for thread_info.cpu.

Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/include/asm/asm.h    | 2 +-
 arch/riscv/kernel/asm-offsets.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index a8a2af6dfe9d..b3022bc224ec 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,7 +91,7 @@
 #endif
 
 .macro asm_per_cpu dst sym tmp
-	REG_L \tmp, TASK_TI_CPU_NUM(tp)
+	REG_L \tmp, TASK_TI_CPU(tp)
 	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
 	la    \dst, __per_cpu_offset
 	add   \dst, \dst, \tmp
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 6e8c0d6feae9..49cf2c347485 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -49,7 +49,6 @@ void asm_offsets(void)
 	OFFSET(TASK_TI_A2, task_struct, thread_info.a2);
 #endif
 
-	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
-- 
2.50.0


