Return-Path: <linux-kernel+bounces-875881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 000CDC1A0B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC4A564A5E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E92334C27;
	Wed, 29 Oct 2025 11:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Vkte4XJH"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A1032F765
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761737246; cv=none; b=Qmd2ce8Z/x/3d9gI9OdQ1qLPGlaTc19WZJec+J/aTkBXVhA/G5tLjtTZMVy1iZU8NBQcv1HYCk6R7oeT12T/W5B581cyuX+30NbU4CkSpc5fnJVepfAZYXZqn0Y3zv3vpDCM58eF20/XOQnZ3mOk63jvg1395o7CAATVFtEX8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761737246; c=relaxed/simple;
	bh=fk1jo/sIeI52ZoZ8R5y44DiLeZbX3mH6843B2DjcmcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmYxhcIrVeQ+zUYDUC67GSelUWe9+EuwVkiVV7yCcYGgWeqBHIuZkUhZFNUiY9ieKMAQDhOKiUQgtRF3va/hr/EV/SkWLOs7bgjScnJzBo6H6HtKJan5PK8qQJ2Hiz/bisTvUtPylfNHY1gzmcTeVqoRyElZ1+z/phMmhq+7PMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Vkte4XJH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so6648035a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1761737244; x=1762342044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVrGZiCOO3VoWU6as4Ya4YNojK7gFL/5DgKPuB9HXfo=;
        b=Vkte4XJHdQ7ORuA8Lc1UhIpabVmbOk2guYMjbsJD+e4TKmOwbkVTqBOodEFa1kzeb3
         i5pY/z+AiUiY5c94cjBf90bRiI59wOaKUqb5Yl2s8rbGoIGxXAKOE+s82JBB6vcrdvL6
         mrd5NU5a6p9oqTVAo++He+73fovBhqeWxWL9TR6mJIRQ7KQ5UVSOXkvvyyolFOIMUg7Y
         DiBOOvK66RVcgmAZ6FTDdOBDbfZxY9wnabxor9cl2hOJue5wmpzMi28ZR9R2AHzd6J81
         FD2h+v5Q6zcQKLCNb5YBSnFIqOmv+1JEjj1Whs7Cdr8Uo6Sq0O6A7U5A/UYKd5c8N5Pu
         piDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761737244; x=1762342044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVrGZiCOO3VoWU6as4Ya4YNojK7gFL/5DgKPuB9HXfo=;
        b=PaEcIHD7qUQWpv+rGV8+Gd8x8hhXxgeZJOkyNDCf7W/Pryz5grIrbq66RlQCw29E8n
         DJ6AYN7vZ5WxFl0QJA3jtK6TATnITCmQMlCb1SrYwmV/M7zTsj2223BP24Qxpq/vLzaj
         wbd8S9aANyMAVFdzYCcXYdZZLUOGIc3jEcxuMJLEdqz5Qz+qH2GwtkQ40Eq82ccGmQaf
         kt1IfXViPpNaGICvGBmTqmFcZ11lMLGi253GAhzNInXXsIzm4/j3/H3UeoRARn2Ik2SB
         q7XJKyxIQLWh2GKE85m9ChZvBABjhmFiHfjRvzUaHTG84VSJthHCR6YqgYPzK8pLehEa
         JqNA==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8pnWk3++orsn6L0IS9e/At07XU0j6+n+0Hq62BCFI8qzhpAXSexJd+M5QSEUzl0y8b8y+UEbhOF/CEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSCd80c+tLn+D1cLlDY2YNF+4cuDj6dCJPwBPy6WX5bWOXtIP
	mpelgOP4KmJR2024cIYB35gtabzXzL3TL+w3Uun0zWZGLosiYE2O+L74LYH+3UsgTqs=
X-Gm-Gg: ASbGncuQEN6CceeuWTr7KDR4A8d3Xw633ChmYJuBsG5HMhOG7t1sFy3qSxmSd/YuEG7
	JpzP9ny5/koMHbTyK0FF08GyQpt/yVlvZGKV7vt7lWsgPmUb0CmU8Ni2aL/f8eILNxDb9L4cycj
	v0BE1LSa+n6N26nMZuwkSDT37Qf0Z65s49Lh5wBVc/7Iw+OD8JD9DBbBzkNmccPKW/L6VKQO4jJ
	n8huk7YqZmQp4DuwVJV9LhcDBrz5ZGwqG1ryclfrExiTZpjvbJ1TwBsBIGzE/Ngp7gHAmO+ZyRD
	flOAfquaHFgUn2Cu4V5TptGd99L8KwPCu2Pm9AsrGtN7jek1Q3fjbvtynqL8th7ZhoXRDcbCnCd
	3ttMeowcKI/9tY4/ybXlZzFxpJc6aWO5n81G894i8qX10pXM7w19PCpMifit1olCGTcCI5rJm1t
	hAtslXhYod5M7EucLn49G8Nh4qN4rr
X-Google-Smtp-Source: AGHT+IEs0ZClHYQ32GXBT6VvX4hdE/vTZzW0dkqblsfwRDrg9bIgaJQ8u6BnX6Q+OdRAzRPJ5EziSQ==
X-Received: by 2002:a17:90b:4d0b:b0:33d:a0fd:257b with SMTP id 98e67ed59e1d1-3403a2fe511mr2861483a91.36.1761737243889;
        Wed, 29 Oct 2025 04:27:23 -0700 (PDT)
Received: from ventana-desktop.localhost ([2405:201:d019:c0ce:f7f5:7789:48e5:c03f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7f6040sm15316918a91.16.2025.10.29.04.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:27:23 -0700 (PDT)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v2 04/10] riscv: Add fixmap indices for GHES IRQ and SSE contexts
Date: Wed, 29 Oct 2025 16:56:42 +0530
Message-ID: <20251029112649.3811657-5-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GHES error handling requires fixmap entries for IRQ notifications.
Add fixmap indices for IRQ, SSE Low and High priority notifications.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/fixmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..e874fd952286 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -38,6 +38,14 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+#ifdef CONFIG_RISCV_SBI_SSE
+	FIX_APEI_GHES_SSE_LOW_PRIORITY,
+	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
+#endif /* CONFIG_RISCV_SBI_SSE */
+#endif /* CONFIG_ACPI_APEI_GHES */
 	__end_of_permanent_fixed_addresses,
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
-- 
2.43.0


