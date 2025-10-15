Return-Path: <linux-kernel+bounces-855371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A41ABE1094
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7337019A66B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59505314D37;
	Wed, 15 Oct 2025 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UNt7J+N1"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2F19D093
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571210; cv=none; b=hCBh1j5MIVajJrhn3NAjnixdqnMhiUlOJzFlpSPR/x9ibW1bslsw421J3WekqicZP/ZCjtdwgdKuOzZJ2JfPm3ugVvuGuzN+I8wcSO5QyIjE+HQgK3BDVq57WRH+eaGrfjxNNrPbIh0WC2C4mqDKaDpSJfxv02t7lzQD+5doGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571210; c=relaxed/simple;
	bh=Qh+7y83OX1pUkVrI0aodZpcWNMonK0uOwIoEy1G1tP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjW2PIOZ3Mhv7Kdxm9GtZC0dEsRFhMP6ad8BpaCQfIYe4V3RMJuXFLjN4/VzYMlLVDo+QejDSl0ukj1RzLc/QrTxm0eoeqHFvC2Mu4gFiyc0ql1UxKM5vQLZVL9qtcuI7oE9pQopr3AqFawyV+8lUQgL+wAoUIWncthZaI7j6po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UNt7J+N1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-279e2554c8fso1112955ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760571208; x=1761176008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/xwbeQ5bIQIWErosPRtwfCXJoRyKfX0d/gFTO3gag4=;
        b=UNt7J+N1O7Lvd2GpUsURttR53vKoXr7QW2MhRkNRW3GOvbm1vqTQTMzxD5YVvyzd54
         qktGQAFWmbt4D8NqY+H87hNR5iUjKzawqUwRi/2544Q4XJTHhSDRlS7aJwTcCSQsmfjf
         zPNS6T5Upxxdg2lkhsWpmvQH+5joVygNrGNK1WyNuHncNNZEuiOfovnZz9uZaADUj2AN
         GiZ8Y3h/eeCNcrLRATk8gP9Z/TcnC2XuQG5cK2uVw4zTB7BjSTkXXfZYg6aLyW47G+5c
         EsS547V482nSN4b4ZWbrz2Oyomm+QeM4nLiBseUJeTjAhZej268LbMakqPGcAaWtcPMu
         wKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760571208; x=1761176008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M/xwbeQ5bIQIWErosPRtwfCXJoRyKfX0d/gFTO3gag4=;
        b=GwFt9K/tYc64V7c/REX/JCfwpqnlHiloQFsF3qcX49VB00Vtm3Pk9tF/ZIzb+pZGLn
         q81cP5lnJMBh4fJb+Gi1muqocuzXxJ1kDiCc/et9XHgbDhzEgUIPcU/tDOMHwFQE75Ev
         /EE/Asxfhc2msfkW3KjjgPSAHXr+pJYFh+hk8LuanEciYUdFKyw9Fao5wwwM6gZQTDw2
         vhNf+SSry7saxb9S6170TapIHCl6eVGSo7gshZRcRkSoTOBnbI/BPPmEv5yne/ydzTO7
         qUCPhBf+Zx3PQqQ5mUJyLiNziuv8sY4jKtVXcgNk4CTzlZOfOX/LTfhsxJ0r8CFPTd90
         kLrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhQmBlVpVrEixuVG/1quxocJlwCFcI+Oalx8S4XQf2opld8Ft+EOuTymT7c3VcJ+GyLd8NdWyz/zlL0Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC29RqTNY8StGyO7kVOXx5wmJH+EIQLpIxT/CgMa2PvV9xOQPg
	VioAeEWY5WbCzvFHxW5j6W9Ob7mFW8AJ2qJ6CCF/8OCKniBmZo5ouFowGj+Hhe7vFXU=
X-Gm-Gg: ASbGnctp70oYFmy809HyjrT51oKLaBfafASqsoIpm4/l5KJnvK8FuL7FpO55PSXz2Vn
	Gl/U515PkZcysZfl7vewNfv9OmiJrec8PssCwx6CvloSjiDzzM7voe4vtmrtvFiaqZf3rYoGOyg
	Q73qo/u2YdLgApqKTJgHJdA6PU9ikFExWTYwPT4lVcvVWO282o5SKyHyaKbCXUFzCJDnjSp+IPP
	uV19jQ5tXwkyinBm+2FkYJ6kKP6wjmOARqUV7xsTMvgPrLg1v+6bABlc5AiprFVgfIDGnuCMdKs
	oEkSZcsCIDOjzDmNFZoZ8zWY0C0D108vIJ4jMBEQnNCi11NfZYbwF8d8GAEEAhwAd6/NXhxDjHh
	IwRbRHywNgv1887BGv3vaTqnowHMpP8TgxLGfKyrLUG1m8Yo0fobFEaUR2jr8xWPk6cKD6S5HUP
	UtS53htwseIATq5i37V9sSVA==
X-Google-Smtp-Source: AGHT+IFJxhyIFn8lZdohbXgnHWWU2Rr0cc/uefUtzRQp/cd9WZ75fBWDZIoRbdvSXfYnLLtM0vr2tQ==
X-Received: by 2002:a17:903:2342:b0:266:7871:37dc with SMTP id d9443c01a7336-290272c0229mr367720335ad.36.1760571208378;
        Wed, 15 Oct 2025 16:33:28 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61acc413sm21216568a91.20.2025.10.15.16.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 16:33:28 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: mm: Define MAX_POSSIBLE_PHYSMEM_BITS for zsmalloc
Date: Wed, 15 Oct 2025 16:33:24 -0700
Message-ID: <20251015233327.3885003-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This definition is used by zsmalloc to optimize memory allocation. On
riscv64, it is the same as MAX_PHYSMEM_BITS from asm/sparsemem.h, but
that definition depends on CONFIG_SPARSEMEM. The correct definition is
already provided for riscv32.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/include/asm/pgtable-64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 1018d2216901..6e789fa58514 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -69,6 +69,8 @@ typedef struct {
 
 #define PTRS_PER_PMD    (PAGE_SIZE / sizeof(pmd_t))
 
+#define MAX_POSSIBLE_PHYSMEM_BITS 56
+
 /*
  * rv64 PTE format:
  * | 63 | 62 61 | 60 54 | 53  10 | 9             8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
-- 
2.47.2

base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
branch: up/max-physmem-bits

