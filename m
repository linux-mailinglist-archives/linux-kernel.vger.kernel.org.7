Return-Path: <linux-kernel+bounces-822548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB870B841CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0452D5423A2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83553016E7;
	Thu, 18 Sep 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jf+Y7Sol"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590AE2F7ABD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191439; cv=none; b=XjWYcj19xCZ8OvYxezvjZXmJRJeQyC0+2a5nr2Y4j4rbfrGqLoKaNxOPow4qZDktZvzmlknXSeMWccca8ZyiUUey29KzLD4X2K85bFmpDeIZOypq04h0WhUERqdtGFcWvFcHCtFxYYUSJIS3Ai1I26KiAD3eniQpIZAXs0ZVQlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191439; c=relaxed/simple;
	bh=9IGxOSD8/IQWLwc8jT7mSjBjvXiOryrCfl8S8dMZveI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ckbPaqex8ISvHNyW4vZRlWlJek7/xmiHGFHWSLc3eD/OVUn8kPkoZmd42bkfzdVLJN8Oo/W8owd+mJ0XY6Q15infowNKa9nfhhqAC0QQRT4/DD6SxGsLdv/0ARGAIObdehiMWYIKCyfgZ0mz2JRvNC+dGLaTbreP3s6hEArfYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jf+Y7Sol; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45dd9a66c3fso2586285e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758191435; x=1758796235; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9g+ayt4FM2fztSLOAfcyGb2gFshK+qygOJzTnKa0+m8=;
        b=jf+Y7Sol+xrsEKY4qAJ4bS/lgFYjmExMOG8jASjDwJI3oXxGyP7v8mu8bOZqcxbD2K
         pIDKVkcNpt8dl23XwRA0O2nHoKoDC2iYGTCs908wfsDWEwnQwXUi1o3DIgcnieEnk30E
         4C0LW9EPK9vok3aJciech8wBmlsp8W/9wx9QgsD/s8odWX+2pdUlCvKbS99amkDXG16h
         7Nx4dtnL7NHSNXc/NUyBZSkGaoDjYYvUbpb4Jdkp7eU7v1LI2ikeWo8KygH6haI6pVOZ
         UdV1t2ygY3ZVwnpccL8yaFbD6CGkc5PhkZ60Y/uuPO/q7jI+N1qtgXKOlHPogK57wHfp
         D8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758191435; x=1758796235;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9g+ayt4FM2fztSLOAfcyGb2gFshK+qygOJzTnKa0+m8=;
        b=k87jkRrH2y1XI4wQERN5FXSurRKsz+wZzUrjBoecixfqSn7NgXQntaNRLNJc6ydTMP
         ThCNN3D3IVfTl2EMzADYuVqlOq3DOO94pP8cc0hTsQ/dAzZTeCrLxGp5dQmqipWYQBQ9
         r8dHAmZM+3Gy+EtaSiaKYTmUWvkveoRKic4Vvg+0FPw1RkufNWZBw57MNiAaQsrVOIU+
         4XyDwFpsh1kDqZSZdYuieB4myY/kTbaTmRdcu9FUGHGlDOA5GjEjwLRQeJ2Q/lz/zQ6u
         Tk1XgNrXi9xWyTfQJRWpAukXm/qeVZAM8MXfvM0g8sPBxd7+a8AO6CMtXkmqWiwp7h7u
         11pQ==
X-Gm-Message-State: AOJu0Yyg/yrha55ZDujgdBeERVqLLpdZyKR19ncd/O1QCrAJJwBfHkPw
	z+Ot6RXLlvd5fq8+mG9UJq95rcvcTy4JTaTF+5fLsNlZ+KMMnYuu0YO+8GP8S2UixVnE5KcB3w=
	=
X-Google-Smtp-Source: AGHT+IHLme5GiJqIwrRwEMO5+ZWXnbB3UysoUpD5npyfKiKL033RbmiEockBVOaN3XQJRx9xa79Wam2T
X-Received: from wmbeq8.prod.google.com ([2002:a05:600c:8488:b0:45d:d39b:53ca])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d05:b0:459:db7b:988e
 with SMTP id 5b1f17b1804b1-46202a0e68dmr48837855e9.13.1758191435539; Thu, 18
 Sep 2025 03:30:35 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:30:12 +0200
In-Reply-To: <20250918103010.2973462-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918103010.2973462-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=804; i=ardb@kernel.org;
 h=from:subject; bh=6f4GfQJsdA/kppXTxBZ4Rl0+1i1W3t0MYvIV3huOmLg=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0fVOTx8nmnjWPnBfWRlyx2Nust7U+6NwL8w/u6QyND
 RPLOTw7SlkYxLgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwERqTBgZluiZM7wIMHV4y6zk
 ptEotHLrMlbGvhem5399bg39UWz4i+F/seOk8zl9+Tn7j2ns0a9iejh1HUdq+LoVum3H9upcd1b gBQA=
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918103010.2973462-11-ardb+git@google.com>
Subject: [PATCH v3 1/8] efi: Add missing static initializer for efi_mm::cpus_allowed_lock
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Initialize the cpus_allowed_lock struct member of efi_mm.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1ce428e2ac8a..fc407d891348 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -74,6 +74,9 @@ struct mm_struct efi_mm = {
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 	.cpu_bitmap		= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+#ifdef CONFIG_SCHED_MM_CID
+	.cpus_allowed_lock	= __RAW_SPIN_LOCK_UNLOCKED(efi_mm.cpus_allowed_lock),
+#endif
 };
 
 struct workqueue_struct *efi_rts_wq;
-- 
2.51.0.384.g4c02a37b29-goog


