Return-Path: <linux-kernel+bounces-898471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D4FC555A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB013A30D0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8472BEC20;
	Thu, 13 Nov 2025 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GLFWgebK"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084572F1FFE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998448; cv=none; b=SfKeMO0LtCZi+m52CNRFQAqzgDcOIxB6j0UJ5IebUQtSUGHoLJBHX/4OlD6HxrMy+KIOiwOt9/Yt9eFuf2PviPpm5s84tSYmCloF/2mC8nnYyswB+vgimzUgKQjL9lisV2rto0K+aRj89NgvarO4QSJOzJbhNICxTXQm96OjWLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998448; c=relaxed/simple;
	bh=dpDUJYbCUG5DE8ks5it/OO03BiZ/1BxCSuYFxo0W7R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGYL5r1pZoEWEO9t12nRsACSUE+4DLK2L152FXMeTwOMqb4ffEd6huNXYAPWKV+2HuuI6c+f/WaL86lhhS5MTDYMC3yTq4Fk7ltFvKrowuasTkGtWPJ6sJeXqr4eB75EQEY1IHNIYHqPxUXwgE5cwudigZfLmIFhoaoAz1qCjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GLFWgebK; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso180132a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1762998446; x=1763603246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJUQdwbie0o7hgZvF0fBCgnf1I3C+S9yUEzkmCq2LO8=;
        b=GLFWgebKN00QlKqL7HbDjZoN9r/Skdq1GViY0ma1TDXfm5Ihcz2Ru2trFzwmvTQMS3
         wN+JYB0u8H1x4asuxQeVhEfKzyySc/G/THY+lsLeMzg7mw3Ga7SyaUzhX6/kt9s2bpwP
         X/glgU1cQg5vmVNLko6SBx56rSM6lZhsSQ9af2RzTaWWdC9jdiIGk1GdwZo3GLUMmdlN
         5yP8WvwwW506UeodpGJAvcuveUIE7PTQEWQdID95y17FMVi8KJQlZQa1cbP4zaSg9Ing
         Nlpv0ztQAlev2DxaF7Ipr23nWXGaayQUl9+bu+cVAH7Uqs+F2BDHwXU8f2l5xqkTidLk
         5TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762998446; x=1763603246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tJUQdwbie0o7hgZvF0fBCgnf1I3C+S9yUEzkmCq2LO8=;
        b=A0Ax/LNrlSf16IZgOW/uNVa6nVHyqILjBRk1VcHscNn9p1YU4AWbiIr1//ZyD7gq/u
         gAD8C7rJF8psnd4+3/IErJS4HA/hh3AIyIxcrEt99hU/flkMe7vDqJ+XhtwM60aionvU
         maLv4bW2Pkedj8seZ21G10uNkODsXaF0STJCSheOJc63yK/wKweljuKoPLBgoqZ3P9X0
         7vdTjd9AGe7e2ql7WoOAdT1q86BwvhyyxWmj4VEy1Iz2RVvxNSl7rOAQpRPmXuCM/aQc
         xtHoqlz9p5RoFTV7g7CAkr5bKc+bz64eiWhA+N5swP8kkQDm2R2INBvBu3qseLUYWSkF
         nn6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUV8k05DG8dImo4gxgIcHy2sH33xKfCovfCfkMhUtbavaQa3CVSU9mUPd3nx+1ijt9ag3kCD+VzCdWDEpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwHp/W5ZdCNTS9rnTBIwWTshNPnJEwmI3xBDfNRraasFF+lfn7
	hUaWIgFRG2oPZgMabpZZs9EY173zBPnJHBTvpbK9YBfTMf2iIu4FRq+PiSH19RvMKWI=
X-Gm-Gg: ASbGncsQdIRCKLzdcsi5yYi5ye4OkanHKPQxwbCLBeQRW2yTkxv3dD5Ja/T/Kwrp90o
	cEvwiWIlXW1gR/ctfxtMFPIQ1Nia6k9KIkEBhJuvzZ330U/hUZUgMYqeU33Egh2YjaY8ov8Dnt9
	5DDrc+lYcU9jIhWRZhLTfQAvEpbYROpJgGGlDYMMTuLsmbCzvKVSoD9w7iE2WsBmuOC3LYjcWXH
	NaS3zPnoiO5COxTzjNuZC6H2otYoAx166Iw001t/rj7tLucqPY024JUhEBIzIZ1VEd8WyzclaVO
	IcS5g2mY/d01EdKTOMr2S8aqaTPd28d6nECzJhpnNE+t5C9p5aLQBrFvSnmYp37S445jjyxQd7E
	sHRaKSzViOpIwxEYTDY96qsCwid4TTvOHd2goIhzWaEPKQjrHNCC+XUtWEcy5BdV9bBwCFFbOok
	+DXBsCirHS4IyPUB4/cRs2uQ==
X-Google-Smtp-Source: AGHT+IHaQsvIpnkLWjWR0rawHh2zoCdjthdQ4AoC5mETU8kGh9msFPBhPFlU6AScOiEA10G8iQrBZw==
X-Received: by 2002:a17:903:3c64:b0:295:3e80:9aa4 with SMTP id d9443c01a7336-2984ed46fcamr62454685ad.22.1762998446285;
        Wed, 12 Nov 2025 17:47:26 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2ccae8sm4986485ad.98.2025.11.12.17.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:47:26 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: devicetree@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Conor Dooley <conor@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 18/22] riscv: Fix logic for selecting DMA_DIRECT_REMAP
Date: Wed, 12 Nov 2025 17:45:31 -0800
Message-ID: <20251113014656.2605447-19-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251113014656.2605447-1-samuel.holland@sifive.com>
References: <20251113014656.2605447-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DMA_DIRECT_REMAP allows the kernel to make pages coherent for DMA by
remapping them in the page tables with a different pgprot_t value. On
RISC-V, this is supported by the page-based memory type extensions
(Svpbmt and Xtheadmae). It is independent from the software cache
maintenance extensions (Zicbom and Xtheadcmo).

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - New patch for v3

 arch/riscv/Kconfig        | 2 +-
 arch/riscv/Kconfig.errata | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fadec20b87a8..cf5a4b5cdcd4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -598,6 +598,7 @@ config RISCV_ISA_SVPBMT
 	depends on 64BIT && MMU
 	depends on RISCV_ALTERNATIVE
 	default y
+	select DMA_DIRECT_REMAP
 	help
 	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
 	   page-based memory types) in the kernel when it is detected at boot.
@@ -811,7 +812,6 @@ config RISCV_ISA_ZICBOM
 	depends on RISCV_ALTERNATIVE
 	default y
 	select RISCV_DMA_NONCOHERENT
-	select DMA_DIRECT_REMAP
 	help
 	   Add support for the Zicbom extension (Cache Block Management
 	   Operations) and enable its use in the kernel when it is detected
diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index aca9b0cfcfec..46a353a266e5 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -108,6 +108,7 @@ config ERRATA_THEAD
 config ERRATA_THEAD_MAE
 	bool "Apply T-Head's memory attribute extension (XTheadMae) errata"
 	depends on ERRATA_THEAD && 64BIT && MMU
+	select DMA_DIRECT_REMAP
 	select RISCV_ALTERNATIVE_EARLY
 	default y
 	help
@@ -119,7 +120,6 @@ config ERRATA_THEAD_MAE
 config ERRATA_THEAD_CMO
 	bool "Apply T-Head cache management errata"
 	depends on ERRATA_THEAD && MMU
-	select DMA_DIRECT_REMAP
 	select RISCV_DMA_NONCOHERENT
 	select RISCV_NONSTANDARD_CACHE_OPS
 	default y
-- 
2.47.2


