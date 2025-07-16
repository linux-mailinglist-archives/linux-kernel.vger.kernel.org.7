Return-Path: <linux-kernel+bounces-733486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B83DB0754A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F89B3BB7F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B77B2F0043;
	Wed, 16 Jul 2025 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cN05VeDP"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0131D2264DC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752667551; cv=none; b=I3ZGw1EanL8CpCr1Zxp7PblzZcwyO5CTJjjtWly8zN8ELUI+xUc64r/bM085gosb14KK+VcOpmikthyJ1Ev55fHPvpi/spXIxBe7xpSzGkzg3Vd14I4/rPKe7+la71zU7cJpakAkSYwvQmWdsk5DvPzG2BFkuAiBnD1Ut98Dz1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752667551; c=relaxed/simple;
	bh=mqWEUluC/ejSKjmWKztJJt6Jp0vNzXefaNC/LDpRSPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gGW7WyO4cJ/1IgbEFht+KEgWdT8YCV/8dcqRtHPgbGA1MqbOWhzjgBYt5iYajVr8lZmRwTN0JjjyrXS7QiZDNxzZqnsVVbpeWhfikhQjMdWWBt5pcn70IRpCvWuQfWMZh+c1dvHCOXRH4VNz85guJ0yakkTQec5Vn2qojuwF/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cN05VeDP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so5475485a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 05:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752667549; x=1753272349; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv1g9KTy4MBNS32Uw6S8h2XR0Uo4HzG8ylTUFdR6He8=;
        b=cN05VeDPL406GW7g+E+51icm+t4emBWlIPI13mfjvJtLk8Rs9U/7AJGv5AOifvObSP
         1tyaqDYHxSKhruZvdfB1ZC5EHhwsRGJ341V7e2ooHe/3w4LyoiQQvxu1c6DIIYPQQg2S
         gdXHS4PS9RfLCQ76OGvVgu+323HW+SEY4Cxed5dcpeVkWOeWFk/OGBXoKc6NTGl/aRc+
         dtYj6OFPhPpfk6U4qSGTzWzs09h/YUHKh7SGVBU1ESsowov6R7mrhQoPdVb1/TxdUGTI
         jV2cmTi+CMrUhxFRac808DAdZFH/sr6CZvrMGrA2ixYcavRzeNm7pt4hbd0KVsJHnRQy
         G0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752667549; x=1753272349;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv1g9KTy4MBNS32Uw6S8h2XR0Uo4HzG8ylTUFdR6He8=;
        b=m2L9IcFzpuxOkUzhT1zBouxIZcqHUPeSLTaGitOHuYbduYWx6O1UkVER9WlbADkZHV
         wF8EgyOjB179Np722QvhILhMSTOvgRWwisGZdgow0oiEYEq7JLUwzxZN7jLte038FJpK
         XRM5aDQ79x4kGJuUEJeY1E/iMqG82eYz5tS8FVEAyWe3CcJkBTyD4FrTr6o1p0vrGndr
         1hrLaIXmDECwz2rPOXpTiQql0PBM+wFNdO2BrOibsKb2WuJ9DVB3VlFwBwjiaJVnc7kW
         ArZ17oKls8Q5PtOz5c8xdeMnAwOT6z5MT2+O/PchHPsEgIQ+a1NB/q82PLqlgu/mwk+I
         5ZgA==
X-Forwarded-Encrypted: i=1; AJvYcCUskqIBU285zwTGx+LBC9HV60eWGm0o3Y4O5z7f5V79sruwIP7qleBf79yBsK49fio2oA29YN1mrhizcm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQmwIQv9eMve4bVt8v5n1uTz8fudHiyvrlBa3WNXpZgGn2YC5
	WG+FPQBzRRoAfGedEhQFvX1q++LUeN67eLqYNRqNxd666GeFjyxbBm2Tad3pcyTlBXY=
X-Gm-Gg: ASbGncvCXdbIJYM4OsbKL0a6ZNqEwLU66b5gKqDy08C/3+1JK4F9EeBf/1LvY+EIrVp
	HQgTz92LFTQhgW1Ee6DJBb6tdmNd94T0ZnqL83rXxqTinJPCDW/7pKaSrvNdcXRpWmtPPjmcGBG
	7On5DdJrGyCigI+oC/zlUYwm/iyjvJChXZNmVEZh8jDxSqvZl/R8wOkv112lgUQo8QYsUEEx4pH
	G2nVVJWArJ4xZzVZGRW4nib44vTd88viRULItTAXVHsZeP/3DHvYSkUOqvXoOIowrbM8dizFXb7
	t3dakgL7NNnXx4f/4CPc3FfRg0GJiNWi/UGIPhGmY0rqF+qusiwcd5QIzPmqD3hpjE8wLn7hnOv
	ZPK2AxCW34c2DmIH9rSIUgvZGNs1WnE08sTi6fswqCjrw9Q3LF11t5UXVsY1b2GjNfw7g+ZCD9h
	GueC3N
X-Google-Smtp-Source: AGHT+IFHR63eCjaXHy6ZUAG7RHZy+oj/uFE7LzrrP+Ag+oxEgYcVF+c+wEYZkXLgOiJuODKL1x5tiQ==
X-Received: by 2002:a17:90b:3942:b0:30e:5c7f:5d26 with SMTP id 98e67ed59e1d1-31c9e77a443mr4186090a91.24.1752667548984;
        Wed, 16 Jul 2025 05:05:48 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f287bcasm1303067a91.32.2025.07.16.05.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:05:48 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 16 Jul 2025 12:05:16 +0000
Subject: [PATCH] riscv: Stop supporting static ftrace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-dev-alex-static_ftrace-v1-1-ba5d2b6fc9c0@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAHuVd2gC/x3MQQqAIBBA0avErBtQo5SuEhGmYw1EhUoE0d2Tl
 m/x/wOJIlOCvnog0sWJj71A1hW41e4LIftiUEK1QssOPV1oN7oxZZvZTSFH6wiNUUF407R6DlD
 iM1Lg+x8P4/t+m+Ih7WgAAAA=
X-Change-ID: 20250716-dev-alex-static_ftrace-882f0d8357bf
To: Steven Rostedt <rostedt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Andy Chiu <andybnac@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 chenmiao <chenmiao.ku@gmail.com>, kernel test robot <lkp@intel.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1957;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=mqWEUluC/ejSKjmWKztJJt6Jp0vNzXefaNC/LDpRSPw=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDLKp06Ycu9B3QqrZapv5BXnnrRpj+Fa7dN1YPMy1eMn7
 1V0h+lf7ShlYRDjYJAVU2RRME/oarE/Wz/7z6X3MHNYmUCGMHBxCsBEXhoy/PeeqV3/ZabxRtOK
 j7/qXt8/0+b3LVOj9dTzdrbZ7n7bZSMZGRbVVpfsuuMsaVistW1DNl9mpFKOW9HGgKpiPW+H780
 r2AA=
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

Now that DYNAMIC_FTRACE was introduced, there is no need to support
static ftrace as it is way less performant. This simplifies the code and
prevents build failures as reported by kernel test robot when
!DYNAMIC_FTRACE.

Also make sure that FUNCTION_TRACER can only be selected if
DYNAMIC_FTRACE is supported (we have a dependency on the toolchain).

Co-developed-by: chenmiao <chenmiao.ku@gmail.com>
Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
Fixes: b2137c3b6d7a ("riscv: ftrace: prepare ftrace for atomic code patching")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506191949.o3SMu8Zn-lkp@intel.com/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d71ea0f4466fc3eefd1bd89f37637193d9a464da..1c5544401530fed9ecade4dd11c1c33a0bd6a2da 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -98,6 +98,7 @@ config RISCV
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
+	select DYNAMIC_FTRACE if FUNCTION_TRACER
 	select EDAC_SUPPORT
 	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
@@ -162,7 +163,7 @@ config RISCV
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER if HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	select HAVE_FUNCTION_GRAPH_FREGS
-	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
+	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && HAVE_DYNAMIC_FTRACE
 	select HAVE_EBPF_JIT if MMU
 	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API

---
base-commit: 5bd6225da2e2d8bbf2b6713fde42159f85ad3fdb
change-id: 20250716-dev-alex-static_ftrace-882f0d8357bf

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>


