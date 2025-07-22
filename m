Return-Path: <linux-kernel+bounces-741312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6DEB0E2AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527F76C55E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F11280324;
	Tue, 22 Jul 2025 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="c0M6sqdg"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788F627FD74
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205918; cv=none; b=oJfohOpWCiO3kLYvDl5eOV4c+B+qnvuJBL/d4H/Rc5DiwiunYLGFroQu3iN30Vwp/hxWetPAJHVom3sxu9naoJ+dmvR+wlclvYPqEKm+0jgBmuXpsfOBzxcHl8bWs6F3dl70uOEHnox3nSpCyxHCTK/CjpvITY/72THfV13ag6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205918; c=relaxed/simple;
	bh=wEqKxN712kAbJrD4t8wAg0usjJ7fv4C0L79Sr+jBBaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGpoFI3g2DgrCTW6GRbhfr4HhZdJrSjkvTnyrsPasWgUlYfxw1hLChQw804ofvClbQ+jc8WOBG91TMuaEMyv0K/egd5LuTPRANFuQmINznteWxH1fb1jjR86lX/Ua2ZfY+BlgKowu/M8ISCkZfoCl3K9nWvbPeFfaSEG/ZcohT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=c0M6sqdg; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fad4e6d949so23522366d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753205914; x=1753810714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+/QVWVAbMlmawQzvkdd/uW3i3+BBW5J3oIOfjWO0MU=;
        b=c0M6sqdgemkgGGy8VfPnldSDVVuRK2ICu+FPepPL2VHbaC63Gz/lOYkv7WvP1AYhfd
         OjHJNW/n/ASPLwOtOE1e2ryC7DbXdxV4OeMGHWD2S0T3HoVPHl5tYhFemPkudqKIuOvT
         1Lxni6m0OQeXNlxzgyit/b94XkgNaG/iLE+LHU+KLxOlQ7+6o1M/hx7nL14KeAvFx53w
         iHAdNlqvE1nZKY4yKFzlB6jRcbeY2lb5bFcSSDoK+9ZggDCqQR8LWhdgQ2v69ob9ucre
         Fpks+f7G1YRHzIc0ssso1nKq/Vi5DPwnBuehrSp3fNHYBo+XJw9TUZR6t+7ET0VAUXcG
         nUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205914; x=1753810714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+/QVWVAbMlmawQzvkdd/uW3i3+BBW5J3oIOfjWO0MU=;
        b=vddo8LhbTNpaZP2yNDpga8YBYAE38tfuHj9QZzRQO9jl0sp4Ob/43k7wwtvntyIRPk
         DvU7ZgbeZjGvTk/1fGBfZ08BPK0TJn9258KSeHV9DeJ8Z0Z0y7ocXgExrqO0HGoPyHpW
         KwmaeoynMSuD2La8u2GBNLJ7Dllp2EWywS9q2hxMCa+ufVtXBUHf4uRBw9voHRlBufeT
         HZNQIDZ0hw2OXdzpr4L7OTBJuXUlYCWhNAvxwRJUZRgRL8hsrs9h0/6BRnFeqU8C01cu
         +MpD5ny7JbmPjL+ejfGNxTBzUiv9UmrzMPfpkxV0OkrtUSBBXTwUPWfhqIfJcC0sMNuY
         EX9A==
X-Forwarded-Encrypted: i=1; AJvYcCVA18ApoL0Vn2e6f6ulwHwjz9QRXC/FXe0U+1pL3XEODEunQ52sI6uZPeYKKc8PklBacSELwFjXrELZxoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAursiPmfncHXDtxR4F949tmlD00waBlofmrOcGCnm/4Ne2pgC
	0zjaMvGqfvJtqY/YNDSOYXW4KP1P93N+R4ylfVG5BJKX9hDxqpR6z5mjD7+nzYFqXCY=
X-Gm-Gg: ASbGncv8rZhiLSm28WFY2WkfHgKEVQA1uMGZL49rDuJfkxwNYylBuQ9KlyLXLD7I6FN
	MHuEFeYAUWEujzGWXesDULX59S1sOjEy4j/SCE2ny/E/KnwKbjpF9pv5Gs0qtay0+ihWPITcakI
	9rg5puRwu4k0nsC5d+8gV7bI7prTnZEYR0bp96gu18054DSIqSQGmjjsCEWX+a1xnaMLTMoFDgM
	Ywt/P0G8ZUdLAtatR5p6SSVPkAVWU+l0JSpGHg5TE6plB5y1yZidcNX0qWIYAtOlUyVz95FbReZ
	bHM+qK28UHT4SC5M0CovrhJYDgVueh+8A7GwsG6r7Ej6UFE2wJ2tLtQ9WMIESybopd5/sMKCoj6
	rqnmXAXPESCr3ZTdsEaSaZxnvKczbfRDH0E6Xe8IKNfGm+aFINcXwyBcw5DbiniHxVfA0/ujz8p
	Q2AgBL/JdCEsA=
X-Google-Smtp-Source: AGHT+IG6SNdAeEQgHa32J5nhXO7PW8gNm0clufSPeGcbDvffqcuVjPUUxogWKFcpPDYTBay+0VPNTw==
X-Received: by 2002:ad4:4ea6:0:b0:704:999b:e5a0 with SMTP id 6a1803df08f44-704f6ad3e7cmr422679046d6.34.1753205914143;
        Tue, 22 Jul 2025 10:38:34 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b783sm54184536d6.73.2025.07.22.10.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:38:33 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Evan Green <evan@rivosinc.com>,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [RFC PATCH 2/6] riscv: Add SBI debug trigger extension and function ids
Date: Tue, 22 Jul 2025 10:38:25 -0700
Message-ID: <20250722173829.984082-3-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722173829.984082-1-jesse@rivosinc.com>
References: <20250722173829.984082-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Himanshu Chauhan <hchauhan@ventanamicro.com>

Debug trigger extension is a proposed SBI extension to support
native debugging in S-mode and VS-mode.

The proposal for the extension can be found at:
https://lists.riscv.org/g/sig-hypervisors/message/361

This patch adds the extension and the function IDs defined
by the extension.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/sbi.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 3d250824178b..be2ca8e8a49e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -35,6 +35,7 @@ enum sbi_ext_id {
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
 	SBI_EXT_NACL = 0x4E41434C,
+	SBI_EXT_DBTR = 0x44425452,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -402,6 +403,34 @@ enum sbi_ext_nacl_feature {
 #define SBI_NACL_SHMEM_SRET_X(__i)		((__riscv_xlen / 8) * (__i))
 #define SBI_NACL_SHMEM_SRET_X_LAST		31
 
+/* SBI debug triggers function IDs */
+enum sbi_ext_dbtr_fid {
+	SBI_EXT_DBTR_NUM_TRIGGERS = 0,
+	SBI_EXT_DBTR_SETUP_SHMEM,
+	SBI_EXT_DBTR_TRIG_READ,
+	SBI_EXT_DBTR_TRIG_INSTALL,
+	SBI_EXT_DBTR_TRIG_UPDATE,
+	SBI_EXT_DBTR_TRIG_UNINSTALL,
+	SBI_EXT_DBTR_TRIG_ENABLE,
+	SBI_EXT_DBTR_TRIG_DISABLE,
+};
+
+struct sbi_dbtr_data_msg {
+	unsigned long tstate;
+	unsigned long tdata1;
+	unsigned long tdata2;
+	unsigned long tdata3;
+};
+
+struct sbi_dbtr_id_msg {
+	unsigned long idx;
+};
+
+union sbi_dbtr_shmem_entry {
+	struct sbi_dbtr_data_msg data;
+	struct sbi_dbtr_id_msg id;
+};
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.43.0


