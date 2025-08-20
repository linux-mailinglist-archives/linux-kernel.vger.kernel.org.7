Return-Path: <linux-kernel+bounces-777319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0BB2D81D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D74E1746DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3B52E2DCF;
	Wed, 20 Aug 2025 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioY+3ni0"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD452E2DD6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681460; cv=none; b=fRPslCT6tNGFI5KnHNsbRdDMpuhOiatpTkKOSyhxqeWUwvrrzaQtA7aJGSA6ynIv9xpsbJusGqcjIlA9cQlqPF68YPMjeM8iKF+4topswhGeVfaroJVbv2AmBvOAZZ53HkzCk5yppXvCRV538UejXa5bbEfvMMDBFMRQQgefkzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681460; c=relaxed/simple;
	bh=IF8wekhGVT3wOnvLrH/B71RsTpK4H/zuMWiB62N8ow4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2JL3ZPdQWzwABhVFq9pwRCGgB3GvlL0Zy4GgINjaWisaRMhFtDGgeSYaPXPFQLnh1isSWMCyZ0hwU0WR6le7hQqGdX1FtmrjlpsGAJoDiLHdvD/skCMOOwKHdni/+NqSWXra6OKqnxtWhzGNjcUmYb+B8coDx2FSWk14xSLjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioY+3ni0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso4613605b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681458; x=1756286258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9ncaQRD3E1PN8zy1g7oC/l30LY0E5NllfF6WnxDxg8=;
        b=ioY+3ni042cV1Fm5+Fk770rc4ZPqHqissniLiI0wJub/VVk8kBM9I0JRfi0PberIIW
         fVVqD+EwWf5rD5V5lO0+i/D/JGE4Js/TnzJUwi+tJyquN4uSnceQf9vGXU0xQbm4JE/4
         Zz1JSHMvEHZH3TvIpKgDLQGvbTv3jI/8b6c/zt8aIG5GC/3VUgguZG4FKw1S9RFHz/Ib
         GE4WPxTirkeptJt6H7s05+sur6iKVfoXbLK6UB4g5eP1YxYPCw8BKLgFGHVDNuQt2P3t
         rkpS5GIpX3oRZ/i8oUOwjy7xZi58Y1bPqLqFIdNsW7w7WXoGBb54WrbwWixEsHCa7a5v
         lbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681458; x=1756286258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9ncaQRD3E1PN8zy1g7oC/l30LY0E5NllfF6WnxDxg8=;
        b=rIcLFOiILX2KzztI74tg3mzdq7uJAj6J0TPNCK43YUKIXc/athW/jz7HoKo6EDGgBR
         l6K1LVxtxPrqK+F5NuFfwnorvz1Kb0MxsyNa0/09p8FnM7VWjK4I0cRmUBHO+D6kuqog
         7Xmxvms115OA/GbITo5Ks9KvsR7HO1fbgWU1moZR1m44mu5hlJa7yNyTyaovCfGR2k/q
         fQS2Uz1r9aCbu1276cY65EgAnQHXr0FkOh8CENL0TF088pRFOPWqcM0QA/dxTLSTIIgK
         gTW4OQ0e7S87gmMNH49ujQHw22Wy8fU+lQCH/ngWxZ/zKH231Tc5wvRkHPp+eTR07Hox
         jMiA==
X-Gm-Message-State: AOJu0Yzsl2PskEF+83zOx/xXjTquA0n5k4NxOJUhlALkLUUW2Nku8f2h
	9bQck9WRiNVyCnux998jE2/tcfWPnU45+31Jie7CwBksKm09oKTkONFh
X-Gm-Gg: ASbGncvXyv/pE2RkwxqbA55jaC+m5UrD86dZR2niSlr3SS/k9TI8MHFvi9ZGnVfREjS
	bH1Eveqbnr2p6EuQlBHNlcBc33riJR9wvuQzAQiCPk7SWPjEBBDODymtO7EnSDFsRtv40nFci1o
	ekQj5+qJ2Lyfogaq0P+nbNJWCvA8DUT+eqcR9QHRxsn7nYdqhZxMw36AWc9Yh/yYFPrRoLc+zjV
	p4aNQVTPka/F5BxOLr2RJ5k80t+N+VumCU0sYT0WfIpZPhvY0pMVX98j//ZFlBj5TdYZ+YszpPE
	822/xMJPlCe8nsfmeJHTVTQPq8pIykcUvEhGT9/0pE5YWv/vJmc1yRj3G2r24i6jRqUXJxXC1hD
	78S/jvVLcIC/rCfFjoWH7VeuRuhvi9X/pB3+DLiaeG6s2WBZ50ZPcU9m89xNOKeUUr/hVj6m1zg
	6E/LR4
X-Google-Smtp-Source: AGHT+IFHtCSYgqJrUWxhPdCX9Zi2FF1HyQPUrI8Q9X/CV07c8sMtfj7DH4mkXmliTRAFReISyuxB/Q==
X-Received: by 2002:a05:6a20:7283:b0:240:5f9:6359 with SMTP id adf61e73a8af0-2431b9a84bcmr3935623637.34.1755681458236;
        Wed, 20 Aug 2025 02:17:38 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:17:37 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	feng.tang@linux.alibaba.com,
	joel.granados@kernel.org,
	john.ogness@linutronix.de,
	wangjinchao600@gmail.com,
	namcao@linutronix.de,
	sravankumarlpu@gmail.com,
	kexec@lists.infradead.org
Subject: [PATCH 3/9] crash_core: use panic_try_start() in crash_kexec()
Date: Wed, 20 Aug 2025 17:14:48 +0800
Message-ID: <20250820091702.512524-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-3-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

crash_kexec() had its own code to exclude
parallel execution by setting panic_cpu.
This is already handled by panic_try_start().

Switch to panic_try_start() to remove the
duplication and keep the logic consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/crash_core.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a4ef79591eb2..bb38bbaf3a26 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
  */
 
+#include "linux/panic.h"
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/buildid.h>
@@ -143,17 +144,7 @@ STACK_FRAME_NON_STANDARD(__crash_kexec);
 
 __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 {
-	int old_cpu, this_cpu;
-
-	/*
-	 * Only one CPU is allowed to execute the crash_kexec() code as with
-	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
-	 * may stop each other.  To exclude them, we use panic_cpu here too.
-	 */
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
+	if (panic_try_start()) {
 		/* This is the 1st CPU which comes here, so go ahead. */
 		__crash_kexec(regs);
 
@@ -161,7 +152,7 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 		 * Reset panic_cpu to allow another panic()/crash_kexec()
 		 * call.
 		 */
-		atomic_set(&panic_cpu, PANIC_CPU_INVALID);
+		panic_reset();
 	}
 }
 
-- 
2.43.0


