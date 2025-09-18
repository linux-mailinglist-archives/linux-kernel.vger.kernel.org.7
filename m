Return-Path: <linux-kernel+bounces-789730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AD2B399B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AF01897747
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC2D30F53B;
	Thu, 28 Aug 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nXJyfwS"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE6330EF69
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376575; cv=none; b=rT0ewF0Pp4iwqnUCFI4WBJh1WP8+jzNNO2fiwiWVDh/1MuKILiV214SoH2y6ijGDwwQKYDVgihmjZDwEQ/zLAXnpmrKgzI6u1RUgAzJVmqXmMY7pvoTxOQGLf58vyVFKaPTFfqic8LJ6fRfJNGvH4u46d2YNEKg1Wu4W8KXkl40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376575; c=relaxed/simple;
	bh=C8Csp226/YzfeWHSASzw9WJOSXUwkB6EtwTL/bzqdvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8vzCBoNt5Rpt6/T6MuBcI8sIlxTNbZII++RrsMk82dFth9Rh8xQQ87kw6JW8iW/sQbcXZi8MQrcRorC455WbWF+B5znwa3F4PlGRTer7XmLPvRrejj0bPferQYlxrH7f1hT7BwUYTKKEJcRqf9x8c3yjRZCHJlTNODZm72SFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nXJyfwS; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3c584459d02so543612f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376571; x=1756981371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=drwOIUdP9CFzwn412iXkc1dycUMYVpFZ2JoqeIstN34=;
        b=2nXJyfwSXjatzWHuohfq8n+XMgDG7RnY7gXEQK6vefylHKrHK3QkhAcTIuZMIXDdrI
         fGqIiU9nMtyX7cz49MzrEnJiUGAQnQb70yvH1p3piHy5CQh9oCfiMHhH0+Ag8GQl2g60
         i1GIYDmO5q5kdc8ymBysGitueqHiPBv7H/Sku/AH9hm0ycP7k2ih4TGSruoZYF27ot4R
         NsmYCQdKTOyhrnJ/xJ8HwUbXX7DxM8w/J9xUvXaVqlcSQeHgPkH0eFkw1T9YPbmuJSRW
         wsxhv+zicYScOkMngImIbfhpT5YmUS+4S4g1cvPm715oRzvXaHaaqzf8kHzwly3/2uIW
         7Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376571; x=1756981371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drwOIUdP9CFzwn412iXkc1dycUMYVpFZ2JoqeIstN34=;
        b=jar67/sqqvUADuFwYdBAyJll96vmSojv3MopJHG/c8ZANwrW3Xekcy6NiZoyv/6uJ0
         DYxC7d7kGOxe9OS7LWBhE1OmPXhHy1D/0xMHaYFDKbkA4TS8KcB8N/Jb4juaiKXUBXfF
         ZH3mTjKAAgPkPQX+p9Sf7mqHwizpPS9DmdiXXjSXdlk0Y3d4PcNr3r16TyLM3/K5j3Ll
         77JzRr0P0UMpZhA0eS7pKcg7ylEKK2KDauwk9Xmkbi626BRfyo0ZU93Hd7zK6r7kl8yc
         IqehpYNEMqWmzP6X5ePUmNciQ2WDBXfuvFebBNxG8pF6dlepYJtQXKZ51N5t6EswRIAv
         AGCQ==
X-Gm-Message-State: AOJu0YwZ2erxOCcBEhis99aHoLpCg+YiGBSXWWMGHyPWqVBMTFkxPeak
	QGVCgKIDzaZG6Dyju0u0UVuyAdzKUn7WW2MGeQpjftkJ9V4H87IxUk3Vh1KcXmWnMgdnQOI0n4m
	dpMf5F5cEKBEzmaQaa5b/cEyaN0XDBByiPB5k9NGANyiB6lvVr3TfMt+w3euUQNbO6R8q6e6qb0
	KaY2gkBoE45TvwaDFzWJrKRS4EQ5kkzGwcLw==
X-Google-Smtp-Source: AGHT+IEW9YcvbPIqRSaXTvjHk3oWsIrAjMzazaRVz/Z6Q9LwVhMb6DSeRsnCMsjz2Kfh4d0bChGQfID3
X-Received: from wmbds12.prod.google.com ([2002:a05:600c:628c:b0:459:e068:b510])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:18ad:b0:3b8:fb31:a42d
 with SMTP id ffacd0b85a97d-3c5dc6385e1mr16035040f8f.34.1756376571462; Thu, 28
 Aug 2025 03:22:51 -0700 (PDT)
Date: Thu, 28 Aug 2025 12:22:17 +0200
In-Reply-To: <20250828102202.1849035-24-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102202.1849035-24-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=ardb@kernel.org;
 h=from:subject; bh=/OAv7ZhuG2hKsYziZ71xYvsi1BlIFCdIV4BfD+340/U=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIWOD7m3GAjtTV/Os+CMRe44bTTTU3x89wXHmkurnXu0v2
 Fen2nh3lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIk4OTP8Fb/6sv/qz1khuVa9
 68/oyB75ty7Y8fmszWox24/kmyuW7mX4X+o6m/d8iRGrLWPZMR2/ykqzrTe2iMT5/f5Ylc+X7mP FDwA=
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102202.1849035-38-ardb+git@google.com>
Subject: [PATCH v7 14/22] x86/sev: Export startup routines for later use
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Kevin Loughlin <kevinloughlin@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Create aliases that expose routines that are part of the startup code to
other code in the core kernel, so that they can be called later as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/exports.h | 14 ++++++++++++++
 arch/x86/kernel/vmlinux.lds.S   |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/boot/startup/exports.h b/arch/x86/boot/startup/exports.h
new file mode 100644
index 000000000000..01d2363dc445
--- /dev/null
+++ b/arch/x86/boot/startup/exports.h
@@ -0,0 +1,14 @@
+
+/*
+ * The symbols below are functions that are implemented by the startup code,
+ * but called at runtime by the SEV code residing in the core kernel.
+ */
+PROVIDE(early_set_pages_state		= __pi_early_set_pages_state);
+PROVIDE(early_snp_set_memory_private	= __pi_early_snp_set_memory_private);
+PROVIDE(early_snp_set_memory_shared	= __pi_early_snp_set_memory_shared);
+PROVIDE(get_hv_features			= __pi_get_hv_features);
+PROVIDE(sev_es_terminate		= __pi_sev_es_terminate);
+PROVIDE(snp_cpuid			= __pi_snp_cpuid);
+PROVIDE(snp_cpuid_get_table		= __pi_snp_cpuid_get_table);
+PROVIDE(svsm_issue_call			= __pi_svsm_issue_call);
+PROVIDE(svsm_process_result_codes	= __pi_svsm_process_result_codes);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 4fa0be732af1..5d5e3a95e1f9 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -535,3 +535,5 @@ xen_elfnote_entry_value =
 xen_elfnote_phys32_entry_value =
 	ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
 #endif
+
+#include "../boot/startup/exports.h"
-- 
2.51.0.268.g9569e192d0-goog


