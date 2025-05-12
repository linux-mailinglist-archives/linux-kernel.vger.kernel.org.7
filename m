Return-Path: <linux-kernel+bounces-644800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5AAB44A3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 21:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE9C189EE7E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 19:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F0429A9C1;
	Mon, 12 May 2025 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0JfW20Y2"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4A29A32F
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077125; cv=none; b=kigFquyGzpnHUNZU6riUOnJWNmBjuq/hyb/DweiYpp2N5VRdht+xvXdVVjnWfP3b5VaAZIkVmu4OfTBJk3vUd20sK4dIcfhGhSxLdqMkt6oBgXZqsnU/mEDtqdwUDvwCjWM+MbwaEibnGtawtXtCO3W++UXISTTJV8EFyC7PLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077125; c=relaxed/simple;
	bh=1Hjpnh9dda2ORviudkcMn1du7RIYbpCSvA6mjNRuDvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D/ERjoh3f2E510fqG8byN8QQBZBS6LnNsCV+qU4xnJ/JIFGSXgDRCqEdys2I8hzuWaEhpeA6rjclBQcCOLm6ioInH2KLKOqZzEJfuPF2S3Khs0eb69gb4trhyM2E1gW1V3Rd0ZqAaO9uj8QMvDc81W8rLP3qdVOo92xMvSY5atA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0JfW20Y2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so20618305e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747077121; x=1747681921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bY9IzSlLGQPC+pLUaE7gEvrg/6v4J3wqpLjIKooAt2g=;
        b=0JfW20Y2nlUWjvNVB+qh1BnvYYQI6vAzArQg2A01V++o0nrZrhHs8HA8QCvtX/PPgR
         VnTLdNVTaytiLQlFPt6BDshIxxxL8uVEhiuQJt7yh2oeHCDxMhH4DdrBgIa4XZV5flHf
         s7D3WI5Zi21KWfwfAN2BLU6t1/dXNLdvOrQXZPu6aai+dOelg+05ru3I+Da8NiTkGTka
         VuOzGwvjM/ewYU9l6peD7LZmUQvM1/extqbI6bPmpjPMdIi0TObF3ihgFSas57OlheS9
         oncuQQbrx29k2yYjkd1tPmLDmapy18VxucNZYSekIirGdCCOa0sXbQTGmQA1kd7cfTGi
         EN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077121; x=1747681921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY9IzSlLGQPC+pLUaE7gEvrg/6v4J3wqpLjIKooAt2g=;
        b=HRDGjV7PccS9AK4t6iWwuHcp7XX66Tjozno9rOFobmdNGsv/bT8Rh7cG+lNmCwk2ri
         Z2ma7SpAVrOTcebQz7KpPoxk5NirZdl+0Z2B2hh+MK2mXh2QkyQPKjy/Poi1kqZ6yVct
         JY2eGFZmY/GeGy93NZOWxR8azyN7oEk3NooW5khwn1Qbs7LrLtOhXh3zSZqV4fGghEYf
         6HPVV1wSKnMldZsUTn2yHIKrtmZsDVkFdQkHxfxiQdwYEpnXGagEWXlsYSfEcCRWfPFw
         XMI4Tfd083g2CCCQ1oVgdpLznNq8LWnj2hWlHniN4BY3271q5IW7cdpY/SdepNdglrdq
         j+mQ==
X-Gm-Message-State: AOJu0YyTQaU4PDWxfmK465USWo6+FeEgjbo97mKoIxdciTeBP9htoInS
	nFn7R4f+5ovL78/CVAEFsp4dcYUxFitcxeb7g752zaOtfOjgjbmky7FYP4JvQM0nsBwsMdJqIHB
	Ph4uiOhYB0581T7YR8Sz5GK5e2vbjdtl/9Bv8eyG/WTWwty8XTj1NLwWVfweYMErVbPxwsWImnl
	Hstgq78QHCHxNM7qy+qi8+J4ww7xTOzw==
X-Google-Smtp-Source: AGHT+IG6r7Gg70bdS7tcnW+62zSzZoWqv+6NsK7xaxabAud3Z8dqLNSZsfNkRAZ44imeWrkOrJ7kMKGs
X-Received: from wmbej7.prod.google.com ([2002:a05:600c:3e87:b0:43d:1873:dbaf])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:450a:b0:441:d437:ed19
 with SMTP id 5b1f17b1804b1-442d6d448afmr102359415e9.11.1747077121291; Mon, 12
 May 2025 12:12:01 -0700 (PDT)
Date: Mon, 12 May 2025 21:08:49 +0200
In-Reply-To: <20250512190834.332684-23-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250512190834.332684-23-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036; i=ardb@kernel.org;
 h=from:subject; bh=Dg3l458uD80s7OT/oBv3zq8dwv/NJq7U/qhuTc4s+G0=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPJ3V+2sWte77OvKbdeR09ZJzFxtt2D7waXneIrVtyOf
 L5G+RNvRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIXyWG/7W3S2ctnjy94q7+
 kv+v7ly8ZbBuib1KP8Mht+4reROUBDIY/heJhQnbyH2Q45iyMf7tz7V3bFsW6efZid77nD25YMe aA9wA
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <20250512190834.332684-37-ardb+git@google.com>
Subject: [RFT PATCH v3 14/21] x86/boot: Provide PIC aliases for 5-level paging
 related constants
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

For the time being, provide PIC aliases for the global variables related
to 5-level paging. Some or all of these are in the process of being
removed, but currently, they are still assigned by the startup code.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 510fb41f55fc..8c69cea84297 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -53,10 +53,13 @@ pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
 
 #ifdef CONFIG_X86_5LEVEL
 unsigned int __pgtable_l5_enabled __ro_after_init;
+SYM_PIC_ALIAS(__pgtable_l5_enabled);
 unsigned int pgdir_shift __ro_after_init = 39;
 EXPORT_SYMBOL(pgdir_shift);
+SYM_PIC_ALIAS(pgdir_shift);
 unsigned int ptrs_per_p4d __ro_after_init = 1;
 EXPORT_SYMBOL(ptrs_per_p4d);
+SYM_PIC_ALIAS(ptrs_per_p4d);
 #endif
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
-- 
2.49.0.1045.g170613ef41-goog


