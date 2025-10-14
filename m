Return-Path: <linux-kernel+bounces-852695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEC4BD9A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39BBF4F9DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA34314B79;
	Tue, 14 Oct 2025 13:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Jl3XBTJJ"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4E315783;
	Tue, 14 Oct 2025 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447469; cv=none; b=orE+nFF28aCQW0LRCzyyOf7LhAXrLTfFpiD3N199BTyP4FlYph6Oe+9xBHGmzFWYJZw/VHGzUCk0rSW6Kjt4pEdMtapZzd25MycxAsrIpTXoRly0O8WT2CVlaARWNjJYR+6jbPPMcLzUx8TcXRD6ItM2OeyQJ1FbeBxQke4Mbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447469; c=relaxed/simple;
	bh=B0Vu5yBNwZ1Dnc8v+auSUV1b6zIitcuBDQLkvOkJmCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNf3mOFKwz70cN+0150+CX4nMDjNj2ysVM/o7EzQRrv6YCbLtLMMTskE054WtwW1Ib7mZdRXG66rVrc1jpgA15GNPwu0o/0tbggM5FScGbq/rvR03Ggqw5fsBgc4pvqEvs7rcsU8G4yeuqL9dpAMpkNi/qxlNc12H6fZImKVhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Jl3XBTJJ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B681B22BF5;
	Tue, 14 Oct 2025 15:11:02 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NaOwcABROvMi; Tue, 14 Oct 2025 15:11:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760447462; bh=B0Vu5yBNwZ1Dnc8v+auSUV1b6zIitcuBDQLkvOkJmCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jl3XBTJJHPNUhRl8/FXUpmR2GJ0iVygeIxQBrOM8e8gkDPzpX9N/74Ds2f76X+HeS
	 KB3EHPCl3goblOoZJEMx2mE8W4GLU3Ucl5CxgRWKwZPvq8dkHy77fnebenzGtrysV2
	 PdHEiz6LFC8ykADfH2n0VYXd8zMCv8RZz2lbY5o8QeeEQM9vclb8d7prgFiw40V1T0
	 6oTjHP9rPZMAN+5JgojEsICN34FwVtCT2XMQsiEIOGTBb1MksC7JFDu64pb5/uI4jI
	 tOBIMkNYjoltz3dKznJmuWC5nO2mwctlFTa2sQogXlOZTjvlltynr+g/wibrQg4dTG
	 q0HjqboZo5YZQ==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 1/5] dt-bindings: reset: thead,th1520-reset: Remove non-VO-subsystem resets
Date: Tue, 14 Oct 2025 13:10:28 +0000
Message-ID: <20251014131032.49616-2-ziyao@disroot.org>
In-Reply-To: <20251014131032.49616-1-ziyao@disroot.org>
References: <20251014131032.49616-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Registers in control of TH1520_RESET_ID_{NPU,WDT0,WDT1} belong to AP
reset controller, not the VO one which is documented as
"thead,th1520-reset" and is the only reset controller supported for
TH1520 for now.

Let's remove the IDs, leaving them to be implemented by AP-subsystem
reset controller in the future.

Fixes: 30e7573babdc ("dt-bindings: reset: Add T-HEAD TH1520 SoC Reset Controller")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 include/dt-bindings/reset/thead,th1520-reset.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/dt-bindings/reset/thead,th1520-reset.h b/include/dt-bindings/reset/thead,th1520-reset.h
index ee799286c175..e51d6314d131 100644
--- a/include/dt-bindings/reset/thead,th1520-reset.h
+++ b/include/dt-bindings/reset/thead,th1520-reset.h
@@ -9,9 +9,6 @@
 
 #define TH1520_RESET_ID_GPU		0
 #define TH1520_RESET_ID_GPU_CLKGEN	1
-#define TH1520_RESET_ID_NPU		2
-#define TH1520_RESET_ID_WDT0		3
-#define TH1520_RESET_ID_WDT1		4
 #define TH1520_RESET_ID_DPU_AHB		5
 #define TH1520_RESET_ID_DPU_AXI		6
 #define TH1520_RESET_ID_DPU_CORE	7
-- 
2.50.1


