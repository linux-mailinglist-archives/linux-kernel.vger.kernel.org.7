Return-Path: <linux-kernel+bounces-723049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D821EAFE21F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28827563431
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8F427F00E;
	Wed,  9 Jul 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvnoRvHg"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794A827E05A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048699; cv=none; b=sXHTXvJlwqBmdXdfczHlklLuR+KPjMM/XXf2JG7w3m3Tz4+azjlFlabCNFkYYT6/mK2HIb5MlEaFrIEiAeefY5TJ7ea5XQ/KZ9z38j3BxJEp9MVxuI36n6bNxww1xJVATrjyO8MEOSLV/E+Rc8i5uL8b3BZALZuK5diHPWaYS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048699; c=relaxed/simple;
	bh=AziSCYrqEKp3iXhsTCzhbJczPEzyYFFzm0EbdakEq+k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E+IFvWc3oOtHR/ehw87vhCOYLQs+zEBSTB4E86G2xpnSgvC/sdlYRSVvh/EetKyXZ8/Kmr7LPtd6QlV8VyDN1nXn26W+kS30bEp53xECFhBIa6qmw2jZpGG4j4nxvf9iSS7VPW/GVzzH1yAO5k6pT5V6ZT+duS18WsO/i/XY9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvnoRvHg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45359bfe631so28182175e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752048696; x=1752653496; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mW4f9PE0jE0e9wTTI8oFMDAAeEX2PGjVbeFJW21fiSw=;
        b=KvnoRvHgTTDmGDEFjxvc9fkCkKa4b41HXfAWjk+FQPooRmj4sUtl6oxRhutPzEtNIE
         LrLUP9ffD5j8EyddbfR30kMOKj2YtwXU0aP+0LZ3zldqjgFHZiIQit2f8nE+SJFxr+Zq
         x0r1rDp65bIeBmolYPkzlzxWvHJIw8+USVfW36wckdx/Ke8Q5j70w2Q/KxHbwnJzPgj+
         M0aYmeUHtr2qAtCOb+OVAC9Km47CmmeenJ/uB2HUu2QcY1kJI4823foceEzwboxin2Ur
         mfN81dtNit7zW59oUfvHVv4R3biT/Dr35dWAETL1fyCciZ1XYJl0EG5uDacV1siUcHKF
         q6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048696; x=1752653496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mW4f9PE0jE0e9wTTI8oFMDAAeEX2PGjVbeFJW21fiSw=;
        b=bKnQ9SNIYsxeW/xUjbUM9YsMycnDmaXAvs9CmpYWelRA8BzjjRbmzTHkCteM8IfsAM
         Azql/7ip1Rvxn+WlylVTecCpHcp9P0dzqZcwlSLAhkIrbwXmFI1GHlgrIsSJxiwAvyMy
         c8r7xo5N444d1fbH9fwGi9tvR1POnHT0BA/swyUDoG0R0LQQbVbcfpflQ7wosd0cCBbL
         oDXtdgs8JIy8pg5RVLbuLEHe+hE6X5v7D7q1VWZtSFlZVi29/Fj9HenAChOEGPHWPMGU
         3QY++I9j0E51tYEwwr8xYTznGP02rwNPDTObdT8qAcD/KYkGuOOpN+cXIJOoHxJosPLl
         dhMg==
X-Gm-Message-State: AOJu0Yw2C0BGaU+1CioTTcoggsFUJQdRR86cyuBr4YmgAzvjX2/X5Y8k
	9qhEE/rW1I7CnmUdojqOry/EHXx1QRs+cMP7sZt6AzfvE2IPlfmBf4LdNbmU7VTmU7jzWJojWZT
	VdGD5oYBe/WZat7yFtb5fRLFqHISM/1RrfhL+fNOtibDBsXjGrUO4h2ksuqYoXcUJ8qtW9kxRBj
	hPa8Ot4ZEsj8oW5KQI3+HdquE38kPSKOCCGw==
X-Google-Smtp-Source: AGHT+IFYnMWunOkuwZilhgJj8CBhve/N6rClwHekltMlTHywqNLrvtHoe8epebqPwqikRuScN1ldq4Iw
X-Received: from wmqd14.prod.google.com ([2002:a05:600c:34ce:b0:453:86cc:7393])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b88:b0:441:ac58:ead5
 with SMTP id 5b1f17b1804b1-454d53f34bfmr14215915e9.31.1752048695741; Wed, 09
 Jul 2025 01:11:35 -0700 (PDT)
Date: Wed,  9 Jul 2025 10:08:57 +0200
In-Reply-To: <20250709080840.2233208-26-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709080840.2233208-26-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1696; i=ardb@kernel.org;
 h=from:subject; bh=kOQMYaSiu+ZXQWR7MbRw268I2y+/O3YrdyRKP8LesAE=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JISNP+Y6M88n9Sbzbf+1YeWOdnNHSbVutr83/+Jjr9Feb8
 59Mpy5m7ChlYRDjYpAVU2QRmP333c7TE6VqnWfJwsxhZQIZwsDFKQATeZTEyNBzosrq8PFTS/dk
 qy1K7WH7de3V8dzX3dnRGdryNiFT9MIYGd67Rhms+RsQlJ3PlX/mdfsJ+ZO/6isKP66u4tJTaQj Yzw8A
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709080840.2233208-42-ardb+git@google.com>
Subject: [PATCH v4 16/24] x86/sev: Export startup routines for later use
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, 
	Dionna Amalie Glaze <dionnaglaze@google.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
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
2.50.0.727.gbf7dc18ff4-goog


