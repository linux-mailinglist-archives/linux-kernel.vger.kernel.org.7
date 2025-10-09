Return-Path: <linux-kernel+bounces-846154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A331BC7286
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 04:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E86A84EDE00
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA31211290;
	Thu,  9 Oct 2025 01:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iTVRxCQ1"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5861A9FBD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759975147; cv=none; b=YPEXhJWzfILXE9xOGjlTtoGE1Fu4LsjrPA147cGzsEwSeRxOidz4Ca6tDF9pwxk18fRqMG8QH+pRGsLx+/guLe6Ly52+YlbFbA1SqNGHiPsOaKIzCYhOii9JOlqafQLwyrl32+/1xKX1OuMfZykpRv+Wut5TDHTS2MRkiYubGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759975147; c=relaxed/simple;
	bh=3rUDhOzJVhUg+Xh67CzMerB+fRBvLbao/4vIhp/KIgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxLhts2TcXJ8IZ45Jofm3Myufsjsgu8S9bgNohm6SJDhGV660ZLcY074QctpJpgYFssX/y/lGGnje7Qd1nZkl/2MANGqBf1ere0OERcqzw8WMWPhoinbZOvd0n0OTvWbbOdGjx8ctTKyz8/89ks6ML7x3URYuXq4jH9ERikDBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=iTVRxCQ1; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b551350adfaso335770a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 18:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759975138; x=1760579938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hsaEY+Rh/SX8Cp9wIkDltmX8vYREKpu310o7cjQ17zs=;
        b=iTVRxCQ1uT/L0RVg+DIhfLJaaw04XcnsYVLfciqI/tMYhoOK/yPHfZJAXfoppVnSR0
         g4n5LEkQNHxTNfw5LvkfhxX/4PB99fm8Sn29dN3O5VXxSPQ2ddI9oIw0OkgYt6qjyQWk
         W7MqxZhhwjwn9hXQmdxkGphCb4UGyY9+Exh8aZjCLyQrqxSwmG81yNWBcUNU2mYFC7k+
         YOXAYsDJeOv1p/LHab2pKUBxqGtocXya7MXbWgPI1RdZJuEGs5UamKx4h4o52FVfrSHy
         wK2liABmlFmTomvk+jVrs/aXs+OwEsKYOZDOwTkts/7woRlAx/bRMewoQsfS76ziYk/Y
         7qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759975138; x=1760579938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hsaEY+Rh/SX8Cp9wIkDltmX8vYREKpu310o7cjQ17zs=;
        b=CYtnzl7OOGDElWVcDnM+PymvQSEPuRvRn4IvXKMZWPLG19xyu/te+9M+q47l1wv1O4
         LRqphs21G6v+bxJ4/dtqCVOGKg0A1ztBUQJvCevSJ87WBSbOeQZHTQGIfi8CYTuAW/Ui
         1EIJOXUh1DiB6FcAsYREnWlmWdRid0ATPyLEpVf+c97yb+cfxqve9PhrxkGaLXdp1nWg
         Re3kfHOX6eyMHiijI8jv6r2IUbyZUGasLgbd4x6nYqIHgWiDJCWyHNOcquxbI0C62nEQ
         H58ok5KxeOTsLfLVQeG33dBzj0I3TNO2nYTmv1hDIXS1HeuiZXtHWmnFFg6up96ZH77Q
         Z/xA==
X-Forwarded-Encrypted: i=1; AJvYcCXQYFPtQnD8MdS9fo7Q8RiaQuk9aXO9kWjNaF7KiwFZHGjYih0BojSio3dH0m0n8Nqd+QkGKygeviCRdu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE7XHziKDZ02Rfh/Bh1XRJuzeVvT7y5qh7yymcoxG9lutMq88m
	vZ+LPq7nRklVSXVEe/n8+kXrFUc1rOGWo4fu2CtTae7Na0pwXB4Zps4WGLhijkQCYf8=
X-Gm-Gg: ASbGncsVeCaQkeu2Lw05PXrMqJWfq0KrUjsAVvghzPG92H/D+FS5KvN50hVjZQBKHR1
	t/YUnF1E/zm1hi1QrycZcdlQFjr877sYa2h9vkky/JeDjQel0TGEVnr/mR2R0avlbTySLAuCVui
	BjsjJTXVvqHgaQuJRxdCVAMioAbjLogwsXqHx8skFniZHWUk1YR9I51T9/QdU1Iz3rHPot2Q2q+
	iKwqEoJESGJzQeaHRaxbfFrCPQAFZ+ZLhSKf87vSLcHcReAagWwBqaOMSxazwQMuceZaCtnOaEy
	P6lDaLfBviXAqYC54jhGfZMVMrue0H3bfHO8syD1j1JYHYuIR6MvD4EYhXli7/OmTYjFaqX5tTS
	EZnrQeBW0Fn2LO7phvXGWMIEF5E9JUoXuBKpuBIWOrezgnzwPM2gH0P2NV7jNkBPrU5dT
X-Google-Smtp-Source: AGHT+IEK6h9ymUfW6feQoPDds5nddPhZXwbaTwfv9f5LhAo3XesBm08EFRVtNsNefL2i5+3bnakD+g==
X-Received: by 2002:a17:903:3c48:b0:268:f83a:835a with SMTP id d9443c01a7336-2902741d091mr61417485ad.60.1759975138296;
        Wed, 08 Oct 2025 18:58:58 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de53f9sm11033585ad.14.2025.10.08.18.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 18:58:58 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 14/18] riscv: alternative: Allow calls with alternate link registers
Date: Wed,  8 Oct 2025 18:57:50 -0700
Message-ID: <20251009015839.3460231-15-samuel.holland@sifive.com>
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

Alternative assembly code may wish to use an alternate link register to
minimize the number of clobbered registers. Apply the offset fix to all
jalr (not jr) instructions, i.e. where rd is not x0.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 7eb3cb1215c62..249ee55d05475 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -121,8 +121,8 @@ void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
 			if (!riscv_insn_is_jalr(insn2))
 				continue;
 
-			/* if instruction pair is a call, it will use the ra register */
-			if (RV_EXTRACT_RD_REG(insn) != 1)
+			/* if instruction pair is a call, it will save a link register */
+			if (RV_EXTRACT_RD_REG(insn) == 0)
 				continue;
 
 			riscv_alternative_fix_auipc_jalr(alt_ptr + i * sizeof(u32),
-- 
2.47.2


