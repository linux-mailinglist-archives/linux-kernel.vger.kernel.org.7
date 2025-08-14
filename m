Return-Path: <linux-kernel+bounces-768750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F9B264FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012C51C2630C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0459A2FC899;
	Thu, 14 Aug 2025 12:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="Uco0q+ye"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C721DD877
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755173213; cv=none; b=ZRpWkLXDW/XeFzRbQ2wMmOgpjTqP/rrMxOEszRkcDwvJ/RConR9//XqudK6OEG0zfg73TGn1IHi+cWaAz5vS3aBolHd7LfxfgOP7IvfqZTRhH7OTjlHuynrhFX4T7pCm6okS5lIwMV7qjaRDsf+GZJYmuEruCOZC0o+9x1k0yj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755173213; c=relaxed/simple;
	bh=wiB//OFp2BrFQuwN6BZWO5CNv4TW0Uuh2XVDxdHzt2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V+nKfmZvjzO7A+2N0qXBrXP4UXRgTmML92+x3inp+/EHpn5uHkUzzlMC7bcIHE57TFGlqxf+U0nzyEJ1TgRMRxEyHCsheLR0xEwVhlVz7vw+ABoe4Bij9EdL6l54E1SayhqyimvRHKukF6aWpFcGSatV+npPjeoxDYC6NURg2uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=Uco0q+ye; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e8005bso951480a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1755173210; x=1755778010; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVJEHbwUiQHMVs0nBo4suasLYxYlbOfnqJ9z6JjAl18=;
        b=Uco0q+yevvvJ8ufD9rEQuGtsN3P8qyXinaF7KujzHsRwdtEuyquqqlpxeOWlMypvWu
         W6Kt0vtiPtxKAz6ugQfq3PKTpHoQPRXsaJL+nLYUHUn6wuw4VjLdHVJfqctUDBdEgS/e
         Hirv0SSS0iwxxtT6yijbUGUCoaFo8RIrnAzqjRjs6++iwxbJ7qm/InT3fmlAUN4SE3ZN
         En/n9oqOzmz3aXpdpdOAn4vNBFeKUFd8KlZhyZ3F9to4zCbRn6BYFym68oLcOKnOvrFH
         p4Khorzzm9NksDwbB1yDo7JAvjlotvYqdmecndy6g4vU5RK/G1JLtulyVIw9ksoQR6Sp
         u6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755173210; x=1755778010;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVJEHbwUiQHMVs0nBo4suasLYxYlbOfnqJ9z6JjAl18=;
        b=IHkJQyYvOLIHj7SIPrXiGatSS8H9sd7607qdCqaMq3VjWMpXsHx+O3fgMFMK8iLUGs
         y33E8NXrfSl8rHqWjpirgOg6xI2BxFpFpCSJCg4MyO3Rj1lpqhVzouAWGlXAOkbfZ0C4
         IpZd6fInCYyf5zDj97pmtRLr8XpRU0o4PK0oB+ROTGtpXut+7Qq+4zJJHkYM73ToqJzr
         BqrRIRgcQD2jcmWa/JkpS3DGLIUackR1+aFq/O9bZzG6AoJtC1oOYUGHDt2RkAwfKf0B
         4b97jq/Cgrwa+EjcsMVuqtQV0pYyZwjwzFg8h2kxzPS+pU9s+41RB7xEGhozAfZOX5Rf
         DiMA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Qj7y+GilgCu/qlRFX05q34Gfzn5xDNj7TXRn099MYarbAqyj3VZAjykdJozsqBYxyukbyoJ/okiJkNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJCUml+/O3O1MGNMS6sUGTDGcMRDX28XVyZS1U/kQaSnS7ddYJ
	LSrxXmLPqFzRlpyNh6GRXFMcZXDFSB+UfWNkDX2Y8umEttNC9a81cpNwRnnlHjzOwlI=
X-Gm-Gg: ASbGnctwzetLxaEjkXwRW3nallPWsAl0Ao22OwN2dF7ZXukpgBUwvN2zbkx6gPzvZXH
	IUzhnJqj1uBVYYi5Y1OAFlZvCU/pk8yeojIWS8WBLfRJ0lDGKvKHtfYwDgrAehv3OEohjrocSYg
	L+0cTksqSXSf3TwlvpVvUch9P2L8j2bUuT+7KPJtp5i+06V0xhPBmiqrQ1P3g/WQ8+CsdUUIYbi
	iIOuWFkpL8nQFNaexuygcN52vEz2UYwEAIgqTIamBW4rfvgFFachqRFBIIsTiyYLxM2yidrQXuL
	BSEzOnXTUh0PEt5mDGID+mVG7rX0RF7OgZp7MYOmAUzEIOFs+4c/EmFSpNijBne3n7QSX/pM8JX
	vXlTXyfJZmL3rIUKT4D0KVHhO5aod9a7YaO4mH6d9U21o5UOf4QKBKcVH0WaXir+7nzG9gQ==
X-Google-Smtp-Source: AGHT+IFEAHkPnfRIgoDwjDPEfLaXInGcoKVU6vuvYGC8vXWNCk2KB5smgVfxup0qNj0vfsNR8sfSYA==
X-Received: by 2002:a17:90b:3d8c:b0:31e:7410:a4d7 with SMTP id 98e67ed59e1d1-32327accc9bmr5541078a91.33.1755173210426;
        Thu, 14 Aug 2025 05:06:50 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3232f8c8e4bsm923478a91.2.2025.08.14.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 05:06:50 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 14 Aug 2025 12:06:14 +0000
Subject: [PATCH] riscv: Use an atomic xchg in pudp_huge_get_and_clear()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-dev-alex-thp_pud_xchg-v1-1-b4704dfae206@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIADXRnWgC/x3MQQqAIBBA0avErBvI1KiuEhGhUw5EiVYI0d2Tl
 m/x/wORAlOEvngg0M2Rjz1DlAUYN+8rIdtsqKtaV61QaOnGeaOEp/OTv+yUjFuxFVoaKaTtVAO
 59YEWTv93GN/3A4nQqbBnAAAA
X-Change-ID: 20250814-dev-alex-thp_pud_xchg-8153c313d946
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=wiB//OFp2BrFQuwN6BZWO5CNv4TW0Uuh2XVDxdHzt2g=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDLmXvT/2sjZzsLpbla9zt1RuuD5t94w2cMrAiYbPNs49
 c9vRsYXHaUsDGIcDLJiiiwK5gldLfZn62f/ufQeZg4rE8gQBi5OAZjIyyMM//1mHIl5e/635P6/
 pQ/FNQKfHZd/Ja4ac2j/y6McX6b1rhFkZJhk8vpp7+FXXZc0rvpcrXQS7NPLM3TaFGYw/3j4Sov
 1HpwA
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

Make sure we return the right pud value and not a value that could
have been overwritten in between by a different core.

Fixes: c3cc2a4a3a23 ("riscv: Add support for PUD THP")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Note that this will conflict with
https://lore.kernel.org/linux-riscv/20250625063753.77511-1-ajd@linux.ibm.com/
if applied after 6.17.
---
 arch/riscv/include/asm/pgtable.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 91697fbf1f9013005800f713797e4b6b1fc8d312..e69346307e78608dd98d8b7a77b7063c333448ee 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -942,6 +942,17 @@ static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, (pte_t *)pudp);
 }
 
+#define __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR
+static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
+					    unsigned long address, pud_t *pudp)
+{
+	pud_t pud = __pud(atomic_long_xchg((atomic_long_t *)pudp, 0));
+
+	page_table_check_pud_clear(mm, pud);
+
+	return pud;
+}
+
 static inline int pud_young(pud_t pud)
 {
 	return pte_young(pud_pte(pud));

---
base-commit: 62950c35a515743739e3d863eac25c20a5bd1613
change-id: 20250814-dev-alex-thp_pud_xchg-8153c313d946

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>


