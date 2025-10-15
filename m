Return-Path: <linux-kernel+bounces-855350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D618BE0FBB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 00:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A63F18806A9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368D2315D25;
	Wed, 15 Oct 2025 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YaNXGesi"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8726C3A7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760568968; cv=none; b=c8sc5zLImq2L3Ytq6qgSw6hxd7PaQmIIEgjbzFoz7miULcCy5C6tWQy36KFKbMAVSxDuWCRuUvoi6EOXRXYQhYkD05zr5NnMPv4pCs0DeEywV3HC0NZ1X+6vrjPQJYYlANTNgS26xOBtTtJyI6he0VIlMhyCc3T/XiDhjaIeaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760568968; c=relaxed/simple;
	bh=cts1aGgjOO17rVlhWjCHbi/gwIe/Yqk749HXlpHcY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWQn8njtcOieQQGgMuzPMmQ6V2lg8L3N343GpUblVI8H5G/KYCR9hrQd0Pdd3Yu7lOrgzR5EU+KFLK0GPzpzVOG3M191vQbbc78EOAyKG8IZX8uOEhdEemdJW/26Fs5/XzRaTHcWFHBzuVitHmGmiNlWJcWen8b65zy8mIDAvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YaNXGesi; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so144268a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760568965; x=1761173765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VFmd6Gbc/aLFm7anjGNLJMoxHRshjAtp5OcPtG6yYWY=;
        b=YaNXGesiDKBqw9yCJUCMchEqvOMWmECcJ7MLdXqCtD6aHljxz+NOxbVYFzBHvThBL1
         fYHes47Tb6a3TQWXjTK3tFG02IAySjyPbfW/oB8TZB8+7kxHK+Qk+5m1fULQXqK4weGt
         X5IGhBg8s1ZDFZ7rW2u5oNpa2tQv2vUm1VruYZpfB5TvW4Q2sqgFEz2TJPKUq8RBTdEs
         o/VgGTXcyQRLoTKq9QxPVnayUzwISC7pN93/vWvxSjkbjO+4mbqqo4xTc6WmpvzBYRhl
         ygQME69/8DMzb5Ksqid5kjRUTN1LiCdjIAsjP59c8+84yrgeXjtzqMPuavWtgwl3FZRk
         4SFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760568965; x=1761173765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VFmd6Gbc/aLFm7anjGNLJMoxHRshjAtp5OcPtG6yYWY=;
        b=sToVkamOG+KACE/g+1KCD229Eb56NZzk3ToIRvexVJ1mm+U5kx/iFEkGHYw+tWkLHR
         GAV8JlOV6UdBnY6gmR+bE/LgG60pDuEso8dMnfYhLMFWKDv5q8Uvo06wBhOvtKSEGMbC
         0yuBYqooJM8rpCwgP9kNJPjuau5GZ1i70P1mEJ6USgOKOugHSAMdasbYCzIBSdfL/NzV
         8A/6+kGdkLtMkgER2bOa5B9tEWQAP7IxKxGvyuKmLmbeiGKlAjeXUE+x1S+SFg6NfuSB
         8GoaNmU7n+RNeGTdtCN+E4/ve2UTwctt2Cz6pI6uiMR2I78Ivlfpt9Tx8hjoAmwUTJ4W
         3yfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCCigZr9w1tCVNPDA4kND+rwXitnIVtuDlTmCcyKQ+KrTR2QNRIJXixjCdJp6LVDXv0+X0AmtdnGqjaDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4h37bBNCgBUSEHduBa8/m1Nt8e1j+yCf9qjxgpLrKrfXwKYM2
	hcbTYaXhTuID/+mlwtk2IeTDKBHccC84iwE4dZEr8AWgGocEaDlwkbbQiuuFwnqw3MY=
X-Gm-Gg: ASbGnctD2B7L9GVclLAUZvzhB00ixPoLMwUZPuUq/VphF+A5WKajQAsukwJtQDuKtRJ
	77HzaU1kPdQJl8vmftBR0jf6+/r1f8MCSjuRcM8Hl0O7KO3OlCgARPkPnbkUc+4yNyY52Qxpwa+
	VBozR5XiyadnLB8iks4nUVzME64QBar6ipbFZmI4+GZKMf6xivjFcvbSf9DGS8X2z7kmcRQ/RXo
	0bmdsvak46LDy/sVGcVky3HDCpbrfAI6x0ZYLkuXLX4uIGO7uzCMzLY2m6k/EjgKMsbdIbVM1IJ
	seY9cQWOPS9aJx4b/YCvIeHWf0iBZwSmo/ByJnVMndCzZkEBV8qB+gQ4xF90/FzSVbSJH2LK77M
	4hwStvB44wRYT4Eyu6Ks9JQflc00a6mdUCtiqZx3q6EvuxiUGMB8OYSUunO0Jx6QGdkPk5fEnC2
	yDtLwygCMLS6u5B+/amejUT0Lg6OvqwH3S
X-Google-Smtp-Source: AGHT+IGMDc40TRec5CNPCGntnVAlaUyey/p2L74uxLAtYHLpIqRuuwj9pmkS0fKnBmRsmWayiBsKhQ==
X-Received: by 2002:a17:90b:3e8d:b0:32c:38b0:593e with SMTP id 98e67ed59e1d1-33b5114d3d4mr39059251a91.5.1760568965288;
        Wed, 15 Oct 2025 15:56:05 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba927394csm243597a91.0.2025.10.15.15.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:56:04 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Thomas Huth <thuth@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Remove the PER_CPU_OFFSET_SHIFT macro
Date: Wed, 15 Oct 2025 15:56:00 -0700
Message-ID: <20251015225604.3860409-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__per_cpu_offset is an array of unsigned long, so we can reuse the
existing RISCV_LGPTR macro.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/asm.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 8bd2a11382a3..ac28066bb564 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -84,15 +84,9 @@
 .endm
 
 #ifdef CONFIG_SMP
-#ifdef CONFIG_32BIT
-#define PER_CPU_OFFSET_SHIFT 2
-#else
-#define PER_CPU_OFFSET_SHIFT 3
-#endif
-
 .macro asm_per_cpu dst sym tmp
 	lw    \tmp, TASK_TI_CPU_NUM(tp)
-	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
+	slli  \tmp, \tmp, RISCV_LGPTR
 	la    \dst, __per_cpu_offset
 	add   \dst, \dst, \tmp
 	REG_L \tmp, 0(\dst)
-- 
2.47.2

base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
branch: up/percpu-shift

