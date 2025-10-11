Return-Path: <linux-kernel+bounces-849204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A708BCF80E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354283B60D7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8413127E1B1;
	Sat, 11 Oct 2025 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ne1UVR+Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D696B27A919
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760198305; cv=none; b=dPF0+x2zEY2ACmCb7/NUqfGTK4ohKUP7M0i6YxEMEutSSqxrMOmWEVHtRx7XmOhJTwZ4G9mGZ8UaWXElQTdgTTm1/KyRVGci7UB0mG/pgQ16MIwFsjiuhE2/MyiQksWxcmewPIu0PlN4Y/kNnDPfTk2GspigaqnKQycpeh+GaGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760198305; c=relaxed/simple;
	bh=13vVZxNHU2kX9V+J8ofU5hUJOLq7n/KvIycm49QX6jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BAqe81/D4WJHBcdpqb0n9/6noOPdM0rKtN/CkcfCoguN8DlcNituK4prpggtpxHVuUYaidfMhZ8V2vDqehRj4GREDcuE6urNFfqz0KAmFs+267jybhnoyWtu9JNDu6HWLzDPTuo5qdSqUyMldNhL6nwYmX53HbhIGWFFFwhwniE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ne1UVR+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7CDC4CEF4;
	Sat, 11 Oct 2025 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760198305;
	bh=13vVZxNHU2kX9V+J8ofU5hUJOLq7n/KvIycm49QX6jo=;
	h=From:To:Cc:Subject:Date:From;
	b=Ne1UVR+Y3FkFUoYr4J7Iv6hMXn0a26q4gHUnserlAo7mygmvjStku6D7AIQXjzheS
	 ooOIOfK0wFs2agrd7tEznLfh7MzPTPtXDFebfLJTF8TuK0btR9Dv97t34uWRW9+BK0
	 NwioQHlKq5T9UaLhCGGUAqwS1LrbNORabiTxaur8zAo3orIzi/mb6FlEIKic1kGZPX
	 z4e/oNmBv+lU2mpKYgFhxWq0V4qNX3FqOZcS2xeT4kft1z/yIxlUcPZLx2/BHMlQwe
	 D3olGTpEBbXSoUoFhxT+PUvB+qqLZGqabusj/aKFt0eciFGm4jX09hg1C4Cs3Q7G+O
	 iq+SnnN+Nk6Zg==
From: guoren@kernel.org
To: samuel.holland@sifive.com,
	david@redhat.com,
	yongxuan.wang@sifive.com,
	cuiyunhui@bytedance.com,
	luxu.kernel@bytedance.com
Cc: guoren@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	palmer@dabbelt.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Add pgprot_dmacoherent definition
Date: Sat, 11 Oct 2025 11:57:46 -0400
Message-Id: <20251011155746.1558731-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>

RISC-V Svpbmt Standard Extension for Page-Based Memory Types
defines three modes:

 Mode | Value | Requested Memory Attributes
 PMA  |   0   | None
 NC   |   1   | Non-cacheable, idempotent, weakly-ordered (RVWMO),
      |       | main memory
 IO   |   2   | Non-cacheable, non-idempotent, strongly-ordered
      |       | (I/O ordering), I/O

The pgprot_dmacoherent default uses the IO memory attribute if there
is no asm definition, but IO is not for main memory according to
Svpbmt rules.

This commit corrects pgprot_dmacoherent with the NC memory attribute,
which satisfies performance improvement and prevents using the IO
attribute to access main memory.

Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
---
 arch/riscv/include/asm/pgtable.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 29e994a9afb6..2a84479de81b 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -654,6 +654,15 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+/*
+ * DMA allocations for non-coherent devices use what the RISC-V architecture
+ * call "Non-Cacheable" memory attribute, which permits idempotent, weakly-ordered
+ * (RVWMO), main memory. This is different from "I/O" memory attribute which is
+ * intended for MMIO access with Non-cacheable, non-idempotent, strongly-ordered
+ * (I/O ordering), I/O attributes.
+ */
+#define pgprot_dmacoherent pgprot_writecombine
+
 /*
  * Both Svade and Svadu control the hardware behavior when the PTE A/D bits need to be set. By
  * default the M-mode firmware enables the hardware updating scheme when only Svadu is present in
-- 
2.40.1


