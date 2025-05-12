Return-Path: <linux-kernel+bounces-644802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E681AB44A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A99419E2016
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4BC298C1E;
	Mon, 12 May 2025 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTkUha0l"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E587029A9D3
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077128; cv=none; b=dORm0vRTHQYOcn7qD945Wj4MckFk3AW+F9ZBS2oemyEAhWEwO3U+an1GntvaVg0qZp0w+8kUA7zaEPY9MRdY+CLrxRqfPtD0ZjTswh2xG3CNMYSMi7rZVwPjZ1j11LWzePF6CfhmvUldCGzPhWcXvhOX3mR/Tkt5puO+e44GKSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077128; c=relaxed/simple;
	bh=hrj/f2XMqgf3lgxecBq7szb9aSl6GvUlDkjfdpj7J4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AxK8pyp+l8TZaEuIkK49oNL9yoLxJc7YfKABfTjlSvWq921UV60L0i7LcaD6RCGQ0WSAzMMhZLaIYFhnMoKFIC+daFhrM2tk6sHPnAE4sSnDaVbHNQ2cIKNT7ySKRGCyCYXGj188w/wMmhhicNqeDuGzwgZk09HrMR9dUi7FRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tTkUha0l; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso22717765e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077125; x=1747681925; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kBEvFCRHzj3sxKuZiVFkKW45Vr6NzjhFUp7ez1esUg=;
        b=tTkUha0lqn6tHUEpHG3mD4Ozl+BACe0+agvYfY2PgVka0IX2HqB2ukeZjIi1+KDCqr
         iU7dUStR7ISUpuZlUj8JWfrvph3xCiFXCR0Fynd2YmW+cnaLKHm65AdWeqncqhOB4Tss
         0grQ9xWH5/S+2OcfhIGXfjCaYHBjCprHB5kT9v+fGEkYorG88flVPZImywJwnbUR+CUk
         2GwLcQs4kKm34Vv7/E1OhbhRd6PBvKqcbWdWBZQAmaGvtvQILFRXlBHgc1AiLQOZhgm3
         7yu7c41oZDf7utqVY8bjtiXFjW2Fs6uBJ3L3lSKOCWxYTg5Wwk3rwsYcTJ8tqjvTAz2X
         +l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077125; x=1747681925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0kBEvFCRHzj3sxKuZiVFkKW45Vr6NzjhFUp7ez1esUg=;
        b=RNAX+hm/Hy5jYGQgmznqA+AgWpgmuY+BDXE8kVX/GpAnNFgSgCfZu1QjO364gYTgyH
         1uJH9DAeFsaXf2ZCtPR3ajSWkHJ8SLpogBXbcXmMFxkB8Yt5vkFPG55qltptFmVFJeFk
         e4KI6BYh2DRm8bM1fOBGlE3gPBAuGMMfgG3N+aTTN9bQcEn3AqieNS9UXZeicslwC35j
         d5VTCvbVtZROCaMKINTDdni0FZa9yn3kIstIwAMEL3WS1XSPyEPkUwLD0fOEeXjCvlN2
         yF6Ohbcv7eR7w4Guw034nAlQHcTuuBvkiWSfO/MIyPLrhT3mPyPB7gc9Yti17yhu+6uB
         Mo5A==
X-Gm-Message-State: AOJu0YzjnOkkcWcjQ7aIrL5Vx23eM3z9KeNsjP9P5Bf9iRDKbmd9hF0W
	8iprYv3J7T3oZjO4KVGR2RSWvQDxwwEQwyJa/0TlJrGcsrjYceFsJbYvz5QcnoY6YrqzFMNlrO6
	p2S5QwOKrekz8FseOunk0ofNaGC2/ppjDiIU6ujSd313ktBlK/wl9CWieuEp+kfWqXLX5Cm4m0X
	k5qt4VBnGJ0J3ca05vgFHK6MNq6fIoZg==
X-Google-Smtp-Source: AGHT+IGX7wvkk5NB2UW0lU9LegdtqDep2bQwFWNh4CLHj1aKbk3SjdRqu090wwZ8j+WpgYLve8lzEnGa
X-Received: from wmcq3.prod.google.com ([2002:a05:600c:c103:b0:442:dc75:51ef])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3e8c:b0:43d:fa58:81d3
 with SMTP id 5b1f17b1804b1-442d6ddf4d7mr102964655e9.32.1747077125389; Mon, 12
 May 2025 12:12:05 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:51 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1571; i=ardb@kernel.org;
 h=from:subject; bh=I2NxwJteYinEfH5nIuZqIb0VkWxRZ1JZLhC2mtLZwrQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJPejwKuGY4q9ZLlH/Dzk8uSwdk+L95sAdC6v/05i9d
 t8RUWLqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPRmM/IcHlr27Zld1dpncw4
 ObndwF2l/NwqW+36zE0qVflZcxZ6BjEyfM/4FXst5MFMzQzWql+Rj1+uTbBYG6+RtfJvm4oZ03V tPgA=
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-39-ardb+git@google.com>
Subject: [RFT PATCH v3 16/21] x86/sev: Export startup routines for later use
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Create aliases that expose routines that are part of the startup code to
other code in the core kernel, so that they can be called later as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/startup/exports.h | 12 ++++++++++++
 arch/x86/kernel/vmlinux.lds.S   |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/boot/startup/exports.h b/arch/x86/boot/startup/exports.h
new file mode 100644
index 000000000000..00ea376fde33
--- /dev/null
+++ b/arch/x86/boot/startup/exports.h
@@ -0,0 +1,12 @@
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
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9340c74b680d..4aaa1693b262 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -517,3 +517,5 @@ xen_elfnote_entry_value =
 xen_elfnote_phys32_entry_value =
 	ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
 #endif
+
+#include "../boot/startup/exports.h"
-- 
2.49.0.1045.g170613ef41-goog


