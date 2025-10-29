Return-Path: <linux-kernel+bounces-876314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C905C1B7D6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09C105C6BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACE02E0B44;
	Wed, 29 Oct 2025 14:07:28 +0000 (UTC)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [84.16.66.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5C2E0402
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746848; cv=none; b=Dzy0NEWXtZ/nh9/ohQtXnhtiJVSvSjEns8U+FPDSx86H7APO7bQzkbleJyh8H2K+Vjt4Bm/XZ75KT5XmzZGSAZ2A9cBc0zsKGDGVmEN7GXLiHRsDGSP68/EbgRUC/nMSHh+QFRLdo/S/wfgc8KU6UclwadvflDThO/V5HfybBqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746848; c=relaxed/simple;
	bh=a53+V3uaK6I4AEhPDfDelsj7DwEolLCX0yrz9pu12RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FEXGVZEPRSBYf9QWUtEQfUvnfem8P/YhBRJk0duCxGwc3DBZmpwikXoWGfJ9IKJIdNndMOGeEva7pihMhbwOghQUJJqPMM64N9qHkmDaxWrczLLNqHe/nyP36AngjLfX+4aKBsUFG4cx4vfvYWZC1tcOXgdf2zdNgKs8Qb+zCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=84.16.66.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cxTDL1QMfz9X7;
	Wed, 29 Oct 2025 14:51:14 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4cxTDK1V4Rz5F0;
	Wed, 29 Oct 2025 14:51:13 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Wed, 29 Oct 2025 14:50:59 +0100
Subject: [PATCH] arm64: dts: rockchip: include rk3399-base instead of
 rk3399 in rk3399-op1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rk3399-op1-include-v1-1-2472ee60e7f8@cherry.de>
X-B4-Tracking: v=1; b=H4sIAMIbAmkC/x3MSwqAMAwA0atI1gaaVoV4FXHhJ2pQqrQognh3i
 8u3mHkgSlCJUGcPBLk06u4TKM9gWDo/C+qYDNbYkoxlDKtzzLgfhOqH7RwFe0fUF0IVG4YUHkE
 mvf9p077vB4K2Eq9kAAAA
X-Change-ID: 20251029-rk3399-op1-include-b311b4e16909
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Dragan Simic <dsimic@manjaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

In commit 296602b8e5f7 ("arm64: dts: rockchip: Move RK3399 OPPs to dtsi
files for SoC variants"), everything shared between variants of RK3399
was put into rk3399-base.dtsi and the rest in variant-specific DTSI,
such as rk3399-t, rk3399-op1, rk3399, etc.
Therefore, the variant-specific DTSI should include rk3399-base.dtsi and
not another variant's DTSI.

rk3399-op1 wrongly includes rk3399 (a variant) DTSI instead of
rk3399-base DTSI, let's fix this oversight by including the intended
DTSI.

Fortunately, this had no impact on the resulting DTB since all nodes
were named the same and all node properties were overridden in
rk3399-op1.dtsi. This was checked by doing a checksum of rk3399-op1 DTBs
before and after this commit.

No intended change in behavior.

Fixes: 296602b8e5f7 ("arm64: dts: rockchip: Move RK3399 OPPs to dtsi files for SoC variants")
Cc: stable@vger.kernel.org
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
index c4f4f1ff6117b..9da6fd82e46b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1.dtsi
@@ -3,7 +3,7 @@
  * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
  */
 
-#include "rk3399.dtsi"
+#include "rk3399-base.dtsi"
 
 / {
 	cluster0_opp: opp-table-0 {

---
base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
change-id: 20251029-rk3399-op1-include-b311b4e16909

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


