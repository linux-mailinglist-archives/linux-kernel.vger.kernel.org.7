Return-Path: <linux-kernel+bounces-788902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8D2B38C95
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0645E1CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A103148C3;
	Wed, 27 Aug 2025 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WBALU0bE"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F7310627
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332291; cv=none; b=gViGO2dWWEP+V/8bSIi0N7vIEqzQD3S1s5QrN3BUrxgBcRrBhN45bndcJ5nhb3B/pp3qfhnIfYCSdQ6wb/0+m79DQUiSnM3bOX/gWKjw1+CUMCkem4N3raYpoTD89PITO87NtqvjBxj3KhewoaUjUIWi3Uzhm1bSbge9cxZ4pXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332291; c=relaxed/simple;
	bh=5z/hefYMQ7IWt+5WldeJoBO7KPwkXup7iKuyes6TM/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rawrqNWoacJd/uACz4VB1fNIrSMHZuvvYELb3GCWFPnzN6z5DEThFMD2W0Q5JlzQF1rm7gnDooaihC5vymLZeM1oQBtqDzEQvMTYRLUNlF2ZLymGtfEbVfisAiqE98wVsXJDlGIAeAAZcfQ0P7xjlsLEC7QZ/BSMKQc/fA2fHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WBALU0bE; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49d46a8d05so333815a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756332289; x=1756937089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQYJoCHr8UsTe/NWEdR+cbblxqgBEXUC11uzxpt2GJM=;
        b=WBALU0bEGS3BNkocxx4CbcRPE0jJpa3DwgTjEsMNjvTVtnGUrCk8cFz3vkGwJtCaQE
         8s52u2P8KbWHBaqH1mptrEoeK0hLg/lFDGSiSJNeg7JEQVrBp9U3rpKxiu4cCtJ30xIk
         Xh0+W7fccxbRyigk99wdgndAx8kC9M7NYr+ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332289; x=1756937089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQYJoCHr8UsTe/NWEdR+cbblxqgBEXUC11uzxpt2GJM=;
        b=dB3aoM4YY92/5/FNfwNZmGPAOaw0azci3pgTrxKpKDHcQ2B4J16LzVl1Ur6j1xePX6
         bGEXRX0E8DTx9d9Vdv3z6D/VmgPibeGbzuRott7i8/Imu5Ygo41uFK7DIM6Mpkq/2dtg
         0qJxwyrhbh/iGPePPjlmem4fWKM78m6T/qyUlNJAJibPs/CZmxlq8uqjWDzBk1T2HJew
         ugTIdn3s6gLeyv4XW5yesKv2JWUQTOhyj6gH+2D+q6iu88nIbhqXS/R6l1uh7aeOBYbf
         phd0hlXpcz4htGTYG/CXft51LLAKEy+ugahBftIuSVyo99voCd/CmOGAY60pjDr/iJgG
         pM3g==
X-Gm-Message-State: AOJu0Yy+bvuzjqDriqh1ZRPzKAfkrIn4a7T4C1xxrDVNPcylyDQVtqH3
	gM46OmDi84Tdm0E5G60UF26YJJD+R6QMINn1jqSK9oRpxx+5w08uapY6HRWFm73XNw==
X-Gm-Gg: ASbGncuO4EnR/9uopoMpi9SSsfoz3CVnhLv1FDPXWCOgp85egVRPU2T5FE/SA8fuCJ/
	yLzSqE7wbYVRgT5Z6Yo/mcklURuw47ByI8Fj+QkCgMubXBFHRWgc+B2k2o7yNotvzJZ5nH1Ceq9
	QM4KXMa7ty9iQxdX760dcfMYKNZ2+roJNK/s6ha9X5LS9APUKCvdbxItTo6Czq0OfDbKkkJPMT7
	n12xvqsGy28MCUUzkX31pqcgH0yN5Jkmxwxiz7XJz7lyOWYUPQI65ez0t+pJBZULV8v5vUgoxbv
	vtlccT4u6Xm1PBDlijpMebvL9aYlSTlgQfTQ4YW311Hkw6wxYBlboPwOjQKMAJShTnijwimamhO
	QJQbcaa76mVrmhf/gzTxAmO586pcxnwP/MDHtveCoI78fAWuzX9Uy6Cljb8Cj
X-Google-Smtp-Source: AGHT+IEMjqSQ+fgnoPTouIyunJfw71nzg7Eizpd9nDcGum95CFW4usmdozPBVbnaQPZxtX8XoFntCQ==
X-Received: by 2002:a17:903:1a2b:b0:242:9d61:2b60 with SMTP id d9443c01a7336-2462edac937mr313050745ad.6.1756332289446;
        Wed, 27 Aug 2025 15:04:49 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:36f6:f0a2:9401:263d])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2466885ed38sm130742425ad.95.2025.08.27.15.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 15:04:48 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	David Gow <davidgow@google.com>,
	Sinan Nalkaya <sardok@gmail.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] um: Support SPARSE_IRQ
Date: Wed, 27 Aug 2025 15:04:18 -0700
Message-ID: <20250827220434.1896850-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
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

This compares with pre-patch results:

    Ran 672 tests: passed: 644, skipped: 28

i.e., we no longer skip tests that 'depend on SPARSE_IRQ', and existing
tests all pass.

[1]
[PATCH v2 4/6] genirq/test: Depend on SPARSE_IRQ
https://lore.kernel.org/all/CABVgOSngoD0fh1WEkUCEwSdk0Joypo3dA_Y_SjW+K=nVDnZs3Q@mail.gmail.com/

Signed-off-by: Sinan Nalkaya <sardok@gmail.com>
[Brian: Adapted Sinan's patch; rewrote commit message]
Signed-off-by: Brian Norris <briannorris@chromium.org>
Tested-by: David Gow <davidgow@google.com>
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

Changes in v2:
 * Drop #ifdef

 arch/um/Kconfig      | 1 +
 arch/um/kernel/irq.c | 5 +++++
 2 files changed, 6 insertions(+)

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
index 0dfaf96bb7da..d69d137a0334 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -691,6 +691,11 @@ void __init init_IRQ(void)
 	os_setup_epoll();
 }
 
+int __init arch_probe_nr_irqs(void)
+{
+	return NR_IRQS;
+}
+
 void sigchld_handler(int sig, struct siginfo *unused_si,
 		     struct uml_pt_regs *regs, void *mc)
 {
-- 
2.51.0.268.g9569e192d0-goog


