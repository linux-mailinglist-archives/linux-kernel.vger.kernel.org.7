Return-Path: <linux-kernel+bounces-785569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC4B34DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D93F1A81019
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934E259CA5;
	Mon, 25 Aug 2025 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="atK6zwIh"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03ECDF58
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156848; cv=none; b=idJ+jSCaQsw47hAgDe5bIwraPX8ANvmSyCB/6TsjcIa0CTaMysj5fIrppRATztM9nSdfxOSyr2YW3ThwN6SVyZELG68X5n6oDpf+7zQvFJEEdi+VNckhnhHVFHGtbtaAMocfkfymPfMj5DRojjReWE+qqiMGCEKk9giOVl69kG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156848; c=relaxed/simple;
	bh=tzuDy2CZYI//6W2KVvy85k0W5E9xFPlGFqjjni4pQ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lN6pCG1OWWkuqwooX8txnfsgOkXF2ESi/AvPwhgvcc9sgO+5ZZSyoxbexF+oE+P5mM+JNk8CwPZyIl4rxYhevvGLXOW1k9O8ZF49qhrTypneUeGMdTtnOp3+69q9sujT25ZUTtm6PwtazbQJau1zna+GFvHTQRRAaTxbpull3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=atK6zwIh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3254e80ba08so2934573a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756156846; x=1756761646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=415LBzM8hZdcn0llBBL+cpvcLMGysoV8tKCiyVqoPY4=;
        b=atK6zwIhQ7QIO+tUWHdzPFnOiU3XNa9VGRrG9E+kzY5wN1QJJdea3H/L3bGvh6HKgv
         W+tZi8/IK6+er0f+A04Ju7YJzouIfFUmCNOgcscvpGYev628jRFuYDR7uIGvO0sk2909
         S4czaEAmO6liKc5Apbns18Co51Ap9z+NAa9x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156846; x=1756761646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=415LBzM8hZdcn0llBBL+cpvcLMGysoV8tKCiyVqoPY4=;
        b=DhNYUrC2Mg24n+cXGKJsJW5gDfJMiBVwHxhKCNGxG/8x1NgxB2/liQuO4kE53ymp12
         fcK67tb/zRCLGls0J3ybWBbQl977ic9+PODe3XZbl4J+10Fac4qMGyHlSuYTQPSFYk3+
         lLZsG55KI5cY1EAzdOZd8Ph3nFscIJv9alFGnzSPkmPwF9aEyvMt2Wx9Y1Oh6vButN33
         FRgiZV7hErHJ47zo1EyMNnGo+QxBrAZbJGu9v4IvA6T8eSRuGjBo2TJXf08TELxbF2l2
         CwgBVtxacPprv1OXfNDW+D5Tdx6hHaRAT0mDmjIaHZDvUeFMXceYGtpYro25Yr4MBCnn
         liVA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ92OGWI+FiP22Hsr7QJBw1rJjF7GH98tdRIa1UINdFKufr55I8wlwGyvi5+AjggnfIwhwadlB7Sx98YA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRCaXpbanfYdEQI/CBXmL8/LzCvS/5gzAc0LCaNUk3/HXqLNdv
	0D4XDfU99nMyQUAPFn0ME5BajoDWUNbAsrikFMJ3ZX0/CaJLV17F2tUpvlnlNZJTOQ==
X-Gm-Gg: ASbGncuv4K112VZjTCFY9rFQ7ltqv7sZx01BaGS5syH6QoNAM3iVYa7XpkTLRqBar60
	+5gpfVVzkAA0OBwiRIV6+Pl/3PiVE2uZcMb2XLEMraP0I2rVw5U8Nt/D8ILOuCNJfTDI1qwFTsR
	5+YpE+3Wa10IMzg/2SasG/6BFWp/PBkLg6ov16rpGeMKm/VM8NLx+3jF5KYpO1yFOjG6wfJXFGe
	B7Hdxkd6kKAUm0rZMKihPVmNgQdrM08Z1Um9mgaZluoF+pf339tsGnwTTNQGOGl1L+zfvVZhKOD
	keOwEQaYaMSQ3hSct2nklpXo99jjYst0kqjKcFgemf/UY+3lAIDZkdqjZp768iELW9hwTVvR7/F
	RHyfz00PI46Jokqct+AWtrrsKG6svor9OmOTsL1gCom/XnaC7iXNm1+sgUl/jeqN5da7c
X-Google-Smtp-Source: AGHT+IHF8MOd3EdGFOYW1z3Ecj0EnwmW/nsob9IgPBVbInj/t2YlO5iUytv57P9VYQ3LDbFnmtbluA==
X-Received: by 2002:a17:90b:4c0b:b0:325:8a91:cebe with SMTP id 98e67ed59e1d1-3258a91d131mr7473494a91.35.1756156846019;
        Mon, 25 Aug 2025 14:20:46 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:230e:95:218f:e216])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3254aa71348sm7839396a91.29.2025.08.25.14.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 14:20:45 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Sinan Nalkaya <sardok@gmail.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] um: Support SPARSE_IRQ
Date: Mon, 25 Aug 2025 14:19:51 -0700
Message-ID: <20250825212031.111027-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sinan Nalkaya <sardok@gmail.com>

Motivation: IRQ KUnit tests are going to require CONFIG_SPARSE_IRQ [1] in
order to:
(a) reliably allocate additional (fake) IRQs and
(b) ensure we can test managed affinity, which is only supported with
    SPARSE_IRQ.

It seems that the only thing necessary for ARCH=um is to tell the genirq
core to skip over our preallocated NR_IRQS.

Tested with:

  $ ./tools/testing/kunit/kunit.py run
  [...]
  [13:55:58] Testing complete. Ran 676 tests: passed: 646, skipped: 30
  [...]

This comparse with pre-patch results:

    Ran 672 tests: passed: 644, skipped: 28

i.e., we no longer skip tests that 'depend on SPARSE_IRQ', and existing
tests all pass.

[1]
[PATCH v2 4/6] genirq/test: Depend on SPARSE_IRQ
https://lore.kernel.org/all/CABVgOSngoD0fh1WEkUCEwSdk0Joypo3dA_Y_SjW+K=nVDnZs3Q@mail.gmail.com/

Signed-off-by: Sinan Nalkaya <sardok@gmail.com>
[Brian: Adapted Sinan's patch; rewrote commit message]
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This is adapted from Sinan's work at:
[PATCH 1/1] um: Fix broken IRQs if SPARSE_IRQ is selected
https://lore.kernel.org/all/1360193940-31504-1-git-send-email-sardok@gmail.com/

Place any blame for errors on me of course.

I'm not much of a UML developer, although I've been developing KUnit
tests which default to running on ARCH=um.

I also can't quite tell if MAY_HAVE_SPARSE_IRQ or SPARSE_IRQ is a better
'select' target. Almost every other architecture uses 'select
SPARSE_IRQ', with the one exception of arch/csky. For my purposes, it's
better to 'select SPARSE_IRQ', for consistency with other ARCH'es, and
to make it easier for KUnit builds to get it. But I'm less sure if there
are good reasons to want to make it user-(un)selectable.

 arch/um/Kconfig      | 1 +
 arch/um/kernel/irq.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb7735..8161cc5ae6f7 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -38,6 +38,7 @@ config UML
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
+	select SPARSE_IRQ
 
 config MMU
 	bool
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 0dfaf96bb7da..d59a5a0f7fbf 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -691,6 +691,13 @@ void __init init_IRQ(void)
 	os_setup_epoll();
 }
 
+#ifdef CONFIG_SPARSE_IRQ
+int __init arch_probe_nr_irqs(void)
+{
+	return NR_IRQS;
+}
+#endif
+
 void sigchld_handler(int sig, struct siginfo *unused_si,
 		     struct uml_pt_regs *regs, void *mc)
 {
-- 
2.51.0.261.g7ce5a0a67e-goog


