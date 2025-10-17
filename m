Return-Path: <linux-kernel+bounces-857839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53664BE80B0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0291AA18E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703493126C1;
	Fri, 17 Oct 2025 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewM6SnuE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995E3126A4;
	Fri, 17 Oct 2025 10:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696559; cv=none; b=YoYItUabG6BFnO/TE7DxFasgu4+qR7BA5SE4uPXK39NgpcpnFTNNdPbltaOZ8cBK+tIbP0UK2/FkhElkka/G4fOvE5HeIsjzKKFfzInh0AQSfODgpngC61T1Tdnoy6LhmpDsLjN5AtBcNrJ+i44CUuMXqRbTk0NyoGSkGoCYKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696559; c=relaxed/simple;
	bh=/+tJshZWidqYuqT3iDUpEKBB+Rq7VWc/REj/SVidg98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGO4W99gAxl9QkpOjX1apsOw8VN8qEPfv5G5BUuqdP0gSGqfnSdE0E3+tVpWyE6Gj4QFJ7BW52JYJYzHsyPOzs8KGUDftudymE0/HC9c4lum+sXnULDzRqxEFUuJjrloFUwTethSm/R0CHctwPuoKpVjMBETzEKptVdoK64Bjug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewM6SnuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A08DC4CEF9;
	Fri, 17 Oct 2025 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760696559;
	bh=/+tJshZWidqYuqT3iDUpEKBB+Rq7VWc/REj/SVidg98=;
	h=From:To:Cc:Subject:Date:From;
	b=ewM6SnuEjggeJMuD5GeY3bQ2rhXvle5vtCW7+r26VkpmtOqt4lVbq8T3BMaN2GPjj
	 kXCMM6/nLWyEi7FpMGjvP9kGiJru8EbGukJ/QSAEfOcIP1D2xe9U2609owmtN22zsO
	 4eqO/1go3FFYB/81cWL0K3PxIuKw4SVzwzVTShFo7mDFDftdlSdy/KTUp0PTQhYhpe
	 /baNxmrmSNSce97JwNE5jBzjdQzxXUv7MJ8V4mfnSrUh3MbcSZvRliomiaqCdLbXtY
	 qS++SH0wASy4fn1chbylNirRi8EGytAN2bHt/+na1Y89ttQS+8qyqcmvwQDyNc0OR+
	 8+ksGjDGHaiTQ==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v1 1/2] rm64: dts: ti: k3-j722s-evm: explicitly use PLL1_HSDIV6 audio refclk
Date: Fri, 17 Oct 2025 12:22:21 +0200
Message-ID: <20251017102228.530517-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parent of the audio_refclk0/1 is about to change to a sane default
value. Thus, move the (soon to be) non-default value into the board
device tree.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
It appears that the eval system just need *any* clock rate for the audio
codec.  Thus, if it's confirmed to be working with the new default
value, this patch might be ignored.
---
 arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
index ce3ed1b0f24d..5de038166a3d 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
@@ -235,6 +235,11 @@ opp-1400000000 {
 	};
 };
 
+&audio_refclk1 {
+	assigned-clocks = <&k3_clks 157 0>;
+	assigned-clock-parents = <&k3_clks 157 15>;
+};
+
 &cpsw_mac_syscon {
 	bootph-all;
 };
-- 
2.47.3


