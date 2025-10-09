Return-Path: <linux-kernel+bounces-846153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C59BC7280
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 678F14EE0CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDEA205E02;
	Thu,  9 Oct 2025 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kJgqjFuT"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6081D130E
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975144; cv=none; b=BvIynD87XCOPdw3/ZkZj+xQbl76AzxL69AoaZyz1gerD2y9jJ+SLi4ujEwcCpY3Aoa6iCg8nZL3/mlWcHjixnUnnhN4XrGILV9mSyvs6KN4IijfnMW6G5iMhxlpVvANvrlkkitOIpbVVImU7Os5gML+0dsrOiaGDPBQKGPRK/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975144; c=relaxed/simple;
	bh=u9BOqgX5810YUwjXJSruqd+C4hDFRKbWRsLI/Cxrbrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgehMwk7uEYkrSKXYNR7nNscxfewcddv/I27jpY7ONpd6jEmw0d7+C97ltxqGFNYymSAOgJy6PeNZ6ynzVgER9y0XRoGOKulbCxM7eHRBiz9fBQRdH7P41gjx4hAfCX8dPfF9bB6n6KudiU7zjpIrtWHhhjF5ySqXKuQLTYjPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kJgqjFuT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e0798so7093795ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975133; x=1760579933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfdCPw2IgJr1hV5CQEQggBFG3P5nbVH7ubzcz6g7ycw=;
        b=kJgqjFuTcjy9l6JsrJJZNu8XL6wi3CpBjDMP8zLCB/LgUlD9Uu73dFwbizHNJJtIe9
         ChEyV6r66MLZwy0oi0Ld/z4XPC049W29EvjgTExIw0B52WgCRFVhyPIryizIIc2lZ5I0
         fY4Q6jtStLTfMt8Nayd9WLtubV53bBpN2imyRRLOJYo2jUK1yhh+m5Mz+VFpez1qPqrq
         g2+j5SgVbN4ooa6t7Mq6XE9H4eiz053uu6+AINRrA8LdXHD8FkxepC7X3eyI38z/WPrZ
         vFgOjl9Wvc9uyjvtja7GXZcP1+VPLqCxib/9Xv3Y1A1NSnBBsH1QnxHR0AEmb8gaLPqX
         X6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975133; x=1760579933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfdCPw2IgJr1hV5CQEQggBFG3P5nbVH7ubzcz6g7ycw=;
        b=pN1LtZ/7BSeln7Dcp4p7uDuFpi2jgoJitTeFjU9fnbzkb4BF4mRx92j/eUON0rFozN
         ZONnChFw7ValaVh6ETXYFQyEoRlVH8eDpSqOmrFAp9jq3EnwLwQEybW+jQMe9/u94MGA
         AWn6jlP07zJqpK7a19rTero+sX9UvFrEh1OtOKgA/NiQYVYfML+sM4JzSMqtpN9dFtcw
         3QNFqMSEW2X32t2xZfACGNhdE4YVgagoiEEekKgdErzpjCSyTBv4ao3GNmw7/ikKr1t/
         wa5oHjgkgLutzvFhCIFOVCie3KZTS5IaOL/CfohTbFmiBO2m8Ykya32neZzi1pjuy7pG
         Ml/g==
X-Forwarded-Encrypted: i=1; AJvYcCUq8pyAa3M7+yMwlNZen+TEGeMQwpYQtg0FrtfXtdlRPEfpkXlIWrZlchno6Se4tUR3L/jkB/nVYOLjYC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bFPZN4l1G2meo4B/DShJNgC9luKnyoNF2LugyLqQDNDQaDLs
	D45vT6BK+pzTfl8j2incyNJWokKi3Mw9zRhuzIA9b2kqni7hJJYYu/9ueFiJWG5Qiq0=
X-Gm-Gg: ASbGncuj4+a/+//ObYoO6eHCbPcCbC0U9CJh2DAlTJjx52SYQv2WTc5LpusY8cLmCds
	Z/DdLdfn4Uc5NA2yZBYmtzyNi3mVD8YQv0OwhXNc5maoOjkVenbpeOnkRN1zFf+k9wXWY0QNJqZ
	PAkiXdZW00Ku2DVEqQIOrfyf5ikUPpVggzWqtifkqN8qCZiVfNdRH2t9/rLHt6Gzcifmdm3zHja
	MlVY7pRwNTo8vWl707/yTI0eMXo06+6hE/i77vEc4fsSsFBVLfRRdpL9ZqznqqEUHMox4+F5g7u
	/W/nvyFlxnAFFXeOQvFiFKQx84IkVOj612ZHYJIEVQIQvgsLGcWoEx2+h0eAJ6qGyQ1onv8sR/h
	wXzlRFs63H5JEzEpKV1hrq9ByKptqYegncECO9NHEcjn7JYMglpwheIpru/1ZGAfWlUNL
X-Google-Smtp-Source: AGHT+IECa/siV4SXNVKe+S+DKZ7Fr1sjCiPZn21F/lR8t8KUoN1d0luw1JkzSMcpjXsSdsF0G571uw==
X-Received: by 2002:a17:903:94f:b0:290:26fb:2b91 with SMTP id d9443c01a7336-2902724dc96mr73646385ad.0.1759975133415;
        Wed, 08 Oct 2025 18:58:53 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:53 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Conor Dooley <conor@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 10/18] riscv: ptdump: Only show N and MT bits when enabled in the kernel
Date: Wed,  8 Oct 2025 18:57:46 -0700
Message-ID: <20251009015839.3460231-11-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251009015839.3460231-1-samuel.holland@sifive.com>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the Svnapot or Svpbmt extension is not implemented, the
corresponding page table bits are reserved, and must be zero. There is
no need to show them in the ptdump output.

When the Kconfig option for an extension is disabled, we assume it is
not implemented. In that case, the kernel may provide a fallback
definition for the fields, like how _PAGE_MTMASK is defined on riscv32.
Using those fallback definitions in ptdump would produce incorrect
results. To avoid this, hide the fields from the ptdump output.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/mm/ptdump.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index 3b51690cc8760..6608162459ae0 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -134,11 +134,13 @@ struct prot_bits {
 
 static const struct prot_bits pte_bits[] = {
 	{
-#ifdef CONFIG_64BIT
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
 		.mask = _PAGE_NAPOT,
 		.set = "N",
 		.clear = ".",
 	}, {
+#endif
+#ifdef CONFIG_RISCV_ISA_SVPBMT
 		.mask = _PAGE_MTMASK_SVPBMT,
 		.set = "MT(%s)",
 		.clear = "  ..  ",
@@ -214,7 +216,7 @@ static void dump_prot(struct pg_state *st)
 		if (val) {
 			if (pte_bits[i].mask == _PAGE_SOFT)
 				sprintf(s, pte_bits[i].set, val >> 8);
-#ifdef CONFIG_64BIT
+#ifdef CONFIG_RISCV_ISA_SVPBMT
 			else if (pte_bits[i].mask == _PAGE_MTMASK_SVPBMT) {
 				if (val == _PAGE_NOCACHE_SVPBMT)
 					sprintf(s, pte_bits[i].set, "NC");
-- 
2.47.2


