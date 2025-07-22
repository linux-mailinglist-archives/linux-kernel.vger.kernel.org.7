Return-Path: <linux-kernel+bounces-741197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2ECB0E154
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F93AC11E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565A827BF80;
	Tue, 22 Jul 2025 16:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RWjg2kl6"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D3827A915
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200599; cv=none; b=Igt05RTftrEQN2UYB0j76nmsk/FSgWhvU+tai/1XwsQySMDOVzVReGwWmy80rqtbePeTRBRawinsUz/uwnDtzG+fWRCUlGryV0xzfZjQiYpA+qItr5Mm8qFVeMDXeaZukDb6UawkksgnWX+kN5FdfjVkif0fcAic5odq5uKbPPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200599; c=relaxed/simple;
	bh=prr2gppYJVhksqdSSSfeWn6Qq8se3DaVIAjVlNSb8RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kL+2FyEVF6GOQgVs9ErRUQTCm5fMvxSxadLkRDrSowwgca+35LmGkuu4CyoeIXaDpBKTG0gCsvQgNVxkC2npccBpYwKp6bsXkXNYULa1g/vcBNflFSAsKcHdT7KJmQ5seWIUfneNaYTEDWuOIg90jadqUmFZz2v68j9320TCUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RWjg2kl6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso10115485e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753200596; x=1753805396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUIN734c8F9Q1V9KdFeOGIQnf08UJxOJxruFh9+meKQ=;
        b=RWjg2kl6mj/95ZwIZY/GhfTufGSYsOWDBCmV76M+59yBFaG2Co302pOBPdb1uJNTnv
         gpamr05+quF785Mz1vxs77HnOYdbMlOn3DXPBsFof5IkD7uGmy+cmpsm5c1HKA+iD0if
         +ITaJCHJSqcDPFXUQgCk1+Pry+WAq+tPm3B71mN5eRcpIhEK/UwrVUyXYvk/F7RVbvz3
         Op8IDvKXKMCdcIL5H8GLnsBrT6WIOfHvzp05i8unW85I/ccVo+P+T+MtB7f9H8662Gdt
         Zg9WlJS39NGEi80liug22sEa0Lf+t2erIMpRbC3m3D4TUI0ODLOy/u/genSfMA1rirzp
         FcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200596; x=1753805396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUIN734c8F9Q1V9KdFeOGIQnf08UJxOJxruFh9+meKQ=;
        b=XBC89GXTr0f3uEAwmQWueCJ2oYS3E/3oaXmve32tIZCp6ZXs6Th11hwVYr1vXoFfVh
         XYxG6f1F2UNR+RzNRN9+8wnESgEsd74W1deQveyfpLkO5ZGJo06uIWLyWQoMyMK5s4W7
         vYoGDgBjhczEtqrDjcQKZ4l/OTFuQQsPCLPvN68zx8U+ll78ZkZoFFr1w5Brd+TOnxMY
         SqBDB25kgRcf/wq71YU010r8c/rI8tT4OKmHom+YkQTP7m4OkpPPxyVhlgEe6d0rPu5e
         2XLAAu0NKQoQsMX8Ffjiq4A62dGWh+lmsJqAI7st0TMS+mxV3JOsDtXmSVOlwgaC3r67
         vNRg==
X-Gm-Message-State: AOJu0YwohEGfJHkQZa2FHKRUZD4q0QGBnhg2/Xyu5DwRnQqUmlTg6i01
	CZeFdFCYCb2FDIKLiulz/jPW/WyJZt8zcwyna/wFYuOQtILsl5AVJu+yUeSFwGO2cLA=
X-Gm-Gg: ASbGnct7xRAYm01DzPmhm3l8BiFeh/BX7zi0jNHeJelt4MoDQlvgJVJtIDPxrd/gjU+
	vV0eXCxVUh4h629vgtWmXpBqUBD8sbLcuM22lfK33zsayotqKIck7HgfxZ7unjQQIC37m/yuPoO
	mirjN6XzOrD5i+qSMxjhRo5yHorqigxG/rJyVTwb/KxoaO3qNZA4qROnQ/iKcQXwX+zqvtJErc5
	jxLNZ4e3WCsmZVZo1n1z9vHei30G7v3y91hOgUcly1UrsQJyiu5ykz4mY6CU3ChALxzd1lp8EB/
	r8TIpIeH4wKBB6jPxhMpff4zqTmMlXIqdyJlUA4G4Ic2jmt4zxNTMkGGvfuX68zIk50JhVwMtov
	ojSYMSccyuGiRluUwmpdr3GW17Tx1mQ==
X-Google-Smtp-Source: AGHT+IGyGnUn7vJdarGNb0EVJqGL251dIgBLpKbjL2CJ9wo77hAS7BHWXW7JVTY6NvJ4447wrID6KQ==
X-Received: by 2002:a05:600c:c097:b0:442:e0e0:24d with SMTP id 5b1f17b1804b1-4562f706949mr80974655e9.7.1753200596089;
        Tue, 22 Jul 2025 09:09:56 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:30d6:4986:8040:bb0a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-458639ffca5sm19058775e9.1.2025.07.22.09.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:09:55 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 3/3] riscv: pack rv64 thread_info better
Date: Tue, 22 Jul 2025 18:05:57 +0200
Message-ID: <20250722160556.2216925-5-rkrcmar@ventanamicro.com>
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

On rv64, preempt_count and cpu were both 32-bit followed by 64-bit, so
placing one in the hole saves 8 bytes in the struct.

Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index f5916a70879a..c267d6bd838e 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -53,6 +53,7 @@
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
+	int			cpu;
 	/*
 	 * These stack pointers are overwritten on every system call or
 	 * exception.  SP is also saved to the stack it can be recovered when
@@ -60,7 +61,6 @@ struct thread_info {
 	 */
 	long			kernel_sp;	/* Kernel stack pointer */
 	long			user_sp;	/* User stack pointer */
-	int			cpu;
 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
 #ifdef CONFIG_SHADOW_CALL_STACK
 	void			*scs_base;
-- 
2.50.0


