Return-Path: <linux-kernel+bounces-816552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578CDB5754B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED0717E08C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25EF2FABE6;
	Mon, 15 Sep 2025 09:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PCc++I4Q"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1E1FC0EA;
	Mon, 15 Sep 2025 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930103; cv=none; b=RZ1Mi7vZkl+oGar/4g55HEGDUTmu9vjbzM7gvlCBQM25Mbezcdt6kQIPlGeBY0Ougl14s064GK47eMHSRamYng1duk5RNcRqeTTYXiq0XrqWar7rvaWy1/IWswFIBToPuxGtu/umKfDP+xTyMDr6DVpu2Xn7vI+SgUtSmHOgFFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930103; c=relaxed/simple;
	bh=LFj7bnzkq3WxPO+5k0WLw98/60l6fANFhk/7P1BfH60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/oxuSD5ZCwXcEDyMwgyhjgL4b7xeMf/kfcl7k3BIgaUWiKFUprIG4PpjwF4451Cz3iGpZEeLRh5QiyoDZuPJrZ6jkoIB8zT99ddrvFNPJDAaCVEwdwLKeZUHI+Sj3/Qf2gdS+VLr+yzogFdpDJTPOhmaZbD5EiBrD/rEQMzias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PCc++I4Q; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id D0F1425D67;
	Mon, 15 Sep 2025 11:54:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gpN1W4pkx3Hi; Mon, 15 Sep 2025 11:54:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757930098; bh=LFj7bnzkq3WxPO+5k0WLw98/60l6fANFhk/7P1BfH60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PCc++I4QorwxPNyBKGqEmE8t5o28618cLPXzvvTUvqTBd4y4feLjGmAU50+vgAvLt
	 gfRptiwz/MBEj0pbhAhNF69mmjNEcj7FmXl0jBn2CNHSsCS7gJpPMAFf3salfoJjLJ
	 BUh/XHb4Sne/NHsciRMD8M4cf1gUw6a5CdlnoY7QioHf1tRliUgsQ3cxx0oqJ90kfY
	 pz/5j8O1D1DwX72eKMUzEYNVEM99y6sw4Umi9spNNFThpttSv8E5PIQuauKOJQrzzR
	 9HbHALF5vPj9+qk8M5yNgL/aoZBjMndBDstfKHX8O9baIgtb2EF6gg07ZXCGgVNFJS
	 KqI5TAeZgvDdw==
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
Subject: [PATCH v2 1/5] dt-bindings: reset: thead,th1520-reset: Remove non-VO-subsystem resets
Date: Mon, 15 Sep 2025 09:53:27 +0000
Message-ID: <20250915095331.53350-2-ziyao@disroot.org>
In-Reply-To: <20250915095331.53350-1-ziyao@disroot.org>
References: <20250915095331.53350-1-ziyao@disroot.org>
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


