Return-Path: <linux-kernel+bounces-853212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F29BDAEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E14F7265
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA640278E7B;
	Tue, 14 Oct 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW8Cls/m"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDD27978C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466047; cv=none; b=HsDUlfqTtnzLXbkXmmB0y1nXDEjQ7Fy1r6v+O2rjnpY/AHTsBNa4EgCUC/upCIU9mYU/SG8pVqhhJfjyrzIm6Chy754ahWEGzMcdfFY3XXv2PZF5IRB9dIvf+F9i4GGQ+TKUOFe1A0a8+kLM2BgV1xqI4F281VfZPQRLUOA4dhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466047; c=relaxed/simple;
	bh=CUG6T+r/hfMhOw8rHMOtfZw23pJjarr+bxDbxbOdKBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNfNIvvS30JG5h2MvNPMF9tTwBSmtSmeqZ8oL+5kjw3S18OlZd7woSCXBMJwemf1I8ldqQTjuoj5NO1oPLEktaVshKJaSsp/uTzJILT0RwFvGpVyf4emaokJHUFjeXMuqfonKCbxdG38Du60Ufl6rEfwYI4975r+VMnvjU+Gt0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW8Cls/m; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-28e8c5d64d8so52605835ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760466045; x=1761070845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=peXcX1ppZ4e00pH7Z4pOcPmB5An4hWwhyX+wypJtg6s=;
        b=AW8Cls/mk+2T/r48yailjIUe+i1sDh00iNDdtaZSg39G4C+z+PynMvuJO6QoAW7kkH
         7Ptr5vAwusJW4/WM/FM9T+NuPybHTl3gxpucK4qQ9X/dMmVPEhXAaz9Wujn+YUSR5+U9
         Hq/P9zYEgd9FWEOuO40G92XUjftOyDdEFLY9ePrcsWyw/6wCRfME59KRecQi5xmQjw7j
         RljwfpLqpqIIrXr/HKpDudUkbT+MHLcEAyFS38H/D48zPDLUqqEkGzroLvT16UMi/c0j
         gNOg0z4miiUXMwbYgYz72xLCWTi/YWWMwn1pcU5XoHUfZ+sggcT9K0CiwqVWAaDJSrUf
         iZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760466045; x=1761070845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peXcX1ppZ4e00pH7Z4pOcPmB5An4hWwhyX+wypJtg6s=;
        b=o/vfoe3Hg9OxoSgMhqZ2SnQKTp33nRbpyId04kZn+k00BPmdMASoVgQkNBmG2b6Eou
         cqCqQF/jieWrQWu0lOButwxdlB6/81vKSS7P+OEo+c65JwczFcTht76M1EdObQ/+F1Yp
         8a3PKUbe3LhkkJDi2+8/YbrXWoeF5BXsUr+hyTaiAGozGIFNE3rDCU/TF3FVCi9hCEc7
         wrG3b68j7zbaBG4sd43K8cdixdiJbtlgWYhP8v/wLiX0IKqaRcNakdEEOtRscQeDsuwd
         wdYz6IBiwtP+JtIpRBW4JVLKeQlA+QlMX+kiPs40XszLGTWYdOeKE3uRtuXEI56z1Bay
         rx8Q==
X-Gm-Message-State: AOJu0YwqASnmr+Q6Thtd6CGtndkLlpUut65yn5lZUImJ098lrgdN/a9k
	o+/RhKD433ShBSePRQSVmYax6I4mLY1CusH1FVA5MXTC9N919foL6rQF
X-Gm-Gg: ASbGnct5Z0Pgome+Epp2garNEhiuG25GYcZRyEbimhL6L/SQyytoiGX65Mo+pRbS7cl
	1lb9Y6IgidFcsb7KdGmQeTSr4yXZa2ZjX1Ys0IZW2zgAOec7UpzTyZseAZP0UqXtoWgGNensDml
	c8DW20KHT6OchNiuqq4K6ec/rHRlHocSEoTKa+3JijsuLy9O9SrGiyDO6Sx1n7PxvL6C0eDz929
	FQiH0t50hT76bNOyd/ARUpaEGpuzmpKumdlTBG6PsyyXm9hArj+HZd49QDXYaxivvQi8iBrbdnB
	v/+SZjgKUaqsJFSKMnlswdQoIRwULlY3wAZQwI0XiBYE0bB3azFAFgA5IgImUtSjbiJUxCvPILm
	oU0pPtfsu25lXYAPGCbe4M+frMttGv5Y/m2n1EVoeCUruOkdz4KvY08j5XaBTKbBR/ytTB6b/ow
	==
X-Google-Smtp-Source: AGHT+IEm4RK8/f0buMj4SrH2mJYbC2pmx4tgbD6W7/Sd4CDFLw57bVndhNrBr7LEAGTVcL+wXU3wIg==
X-Received: by 2002:a17:902:e785:b0:267:d2a9:eabb with SMTP id d9443c01a7336-2902739ad39mr313529185ad.25.1760466044665;
        Tue, 14 Oct 2025 11:20:44 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:6d70:c338:e681:47e3:e797])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f07253sm172244795ad.62.2025.10.14.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:20:43 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nishanth Menon <nm@ti.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: defconfig: Drop duplicate CONFIG_OMAP_USB2 entry
Date: Tue, 14 Oct 2025 19:20:35 +0100
Message-ID: <20251014182035.239956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

CONFIG_OMAP_USB2 is already enabled as a module in the default defconfig
since commit 8a703a728a745 ("arm64: defconfig: Enable USB2 PHY Driver").
Remove the duplicate entry to fix the following warning:

    arch/arm64/configs/defconfig:1705:warning: override: reassigning to symbol OMAP_USB2

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e401915e2f2f..478ca72c0aeb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1702,7 +1702,6 @@ CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_AM654_SERDES=m
 CONFIG_PHY_J721E_WIZ=m
-CONFIG_OMAP_USB2=m
 CONFIG_PHY_XILINX_ZYNQMP=m
 CONFIG_ARM_CCI_PMU=m
 CONFIG_ARM_CCN=m
-- 
2.43.0


