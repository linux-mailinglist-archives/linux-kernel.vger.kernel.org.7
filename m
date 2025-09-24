Return-Path: <linux-kernel+bounces-830745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 237F4B9A710
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68CC381F01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C8130AAAF;
	Wed, 24 Sep 2025 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3i9fctR"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0C6307486
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726011; cv=none; b=p22+82HXKpXXHEBWCWOtcZaNCmRaSuHzw7jfSFGcl1tP4d/+IoP1VsujZR011zeBPUcy3Gayu37fv/be+IQMeM6WucPNRqRku7Ve8w23Y3fs6fiZKu7IrKtCe1JfHvYq3t3lZxt0myE7cMuLW8gW9o4Uo8hcDO2wu35URH9CLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726011; c=relaxed/simple;
	bh=CPBxBC4PANAWEu0yh8A8UOXRCzjxsDvq4N6WzMLVkto=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PgLRg6xHQC4h77/HrOel5m6gtqPa/UjK2SF0m5mYgZoTXECcSaz8OBa7STf+WhExJ9vCcN/jLcmgP4OFC+tSJ3/fLgMH0ahamehxGMvuN7SvDkxT7hOd7yFex4YIbf0rEMY+QUug5Qv84QGheXhQ/FAJTElUaK+xgjI8FCfqL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3i9fctR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so2511077f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726008; x=1759330808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoJVCKwzHTvI9L15TyOM+QFTR+4mknbbnsqq6MMe4q4=;
        b=q3i9fctRbRplmi8BDCmGl4Chro62AauockN0mrUaFlSnFs7JUsxklkZ3vCNGQmynIB
         Jsz0AbNyfSScu6mtlROblAwILmsoL9MAYwxl/eAYsEUMonkouaMvaYK6EaWaaNjwte4b
         8VtHzsStsnb6B8Ae7v2snRSRFW4LwbJ0p7B23A4HznSedH2TR02hE/gvZFw3HwgX+9oT
         bCAv/5pFXUBIKyNmjp8b4FGHTuN4Lea/4OUgUIQykNhoH4HUuSmiUVrVJ+kvmImJ9+cJ
         SuyjDA5bgeIFD+OwbcVRenjU7iuM/JxkEDOj6qe8kMAvBZ1OlKhM8PtXf6sM7EKJMYmD
         +y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726008; x=1759330808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoJVCKwzHTvI9L15TyOM+QFTR+4mknbbnsqq6MMe4q4=;
        b=CN+1hX3Je+mMlCZFofwew/dKCHEZ2+HU3AOpjhxmB9cLxcZG1tyNFaFUrnpVCuW7hU
         sAaFnRmOba2AtQ5j86YIctzofOPVO+Irg2XrBl1I1Vx8tVk4+FAPt1X2YzWUID4jK9q9
         pPyukNPZWtAgeIlISPInTSx1UyXXLJ26eRt9zu/ukgjxXB2KgxHMogJxcbfdPt+F0j4N
         56nSTupsUbtHmVZEFhTKgELH65vNg57uSGuAPKZDaycd3td8S7obZiv2TDRdWuLuFLBw
         lc1boWJ+HsS5bx4rEgjbB1bIjFO1HyaCaq/UtUjZN/9BdBmJLczs6/4SWL4z/3FjApzS
         u1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUG7AgeWvTjzGZTyT4QmffnmKCszjcRX9ayzt2lFdOe+R1L4MbXl1vqo7s7bg4Zuh7oW7cQjvM+io6llW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7DVwVTX6j3prz1Q5NtCezozMLxCLqYlemyg/RUxC7VBtFROaz
	1LDQhsgyUHx9ZOKNqIQH1XwlyXpa8ZQ9BGsHn3gAzCGzr0agRcV3pj1LMmQKGszcOwo1Y7O1rj4
	BPrANeiCFSkadMw==
X-Google-Smtp-Source: AGHT+IFYCM81xG8NnhOZnthImfsZs9y4y2Mpes3SZt0+UDE3H8DpBmBpiCVfYNrs7AMA4PJb8IINbQbGi/I5sw==
X-Received: from wmbej13.prod.google.com ([2002:a05:600c:3e8d:b0:46e:2291:a3a4])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2484:b0:405:1925:4972 with SMTP id ffacd0b85a97d-40e46515005mr243422f8f.1.1758726007585;
 Wed, 24 Sep 2025 08:00:07 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:36 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-1-2d861768041f@google.com>
Subject: [PATCH 01/21] x86/mm/asi: Add CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

This long awkward name is for consistency with
CONFIG_MITIGATION_PAGE_TABLE_ISOLATION.

In the short term, there isn't much arch code. In the medium term, it
will mostly be x86 code. So, put the code where it will need to go
instead of just having to move it soon.

In the long term, it should probably include other archs too, so
things should be as arch-specific as necessary, but not more so.

Follow the proposal by Mike Rapoport[0]: a generic header includes
NOP stubs for ASI definitions. If
CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION is defined then the asm/ tree
must have asi.h, and that gets included instead of the stubs.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/Kconfig               | 13 +++++++++++++
 arch/x86/Kconfig           |  1 +
 arch/x86/include/asm/asi.h |  5 +++++
 include/linux/asi.h        | 10 ++++++++++
 4 files changed, 29 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index bae871976d36f7b6b2af0be40a067ca2b3fd3d14..ad99637630406e5a484173f5207bbd5a64b2bf1f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -17,6 +17,19 @@ config CPU_MITIGATIONS
 	def_bool y
 endif
 
+config ARCH_HAS_MITIGATION_ADDRESS_SPACE_ISOLATION
+	bool
+
+config MITIGATION_ADDRESS_SPACE_ISOLATION
+	bool "Allow code to run with a reduced kernel address space"
+	default n
+	depends on ARCH_HAS_MITIGATION_ADDRESS_SPACE_ISOLATION
+	help
+	  This feature provides the ability to run some kernel code
+	  with a reduced kernel address space. This can be used to
+	  mitigate some speculative execution attacks.
+
+	  ASI is not yet ready for use.
 #
 # Selected by architectures that need custom DMA operations for e.g. legacy
 # IOMMUs not handled by dma-iommu.  Drivers must never select this symbol.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1fd698311bc1dba134a8e14dd551d2390e752cda..cb874c3857cf443c6235e05bc3f070b0ea2686f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -38,6 +38,7 @@ config X86_64
 	select ZONE_DMA32
 	select EXECMEM if DYNAMIC_FTRACE
 	select ACPI_MRRM if ACPI
+	select ARCH_HAS_MITIGATION_ADDRESS_SPACE_ISOLATION
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
new file mode 100644
index 0000000000000000000000000000000000000000..53acdf22fe33efc6ccedbae52b262a904868459a
--- /dev/null
+++ b/arch/x86/include/asm/asi.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_ASI_H
+#define _ASM_X86_ASI_H
+
+#endif /* _ASM_X86_ASI_H */
diff --git a/include/linux/asi.h b/include/linux/asi.h
new file mode 100644
index 0000000000000000000000000000000000000000..ef640c8e79369a9ada2881067f0c1d78093293f7
--- /dev/null
+++ b/include/linux/asi.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _INCLUDE_ASI_H
+#define _INCLUDE_ASI_H
+
+#ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
+#include <asm/asi.h>
+#else
+
+#endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
+#endif /* _INCLUDE_ASI_H */

-- 
2.50.1


