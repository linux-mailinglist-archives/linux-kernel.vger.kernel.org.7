Return-Path: <linux-kernel+bounces-768080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5BB25CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBCE8875A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AE72641D8;
	Thu, 14 Aug 2025 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="eVPArtS4"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2825C816;
	Thu, 14 Aug 2025 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155370; cv=pass; b=ZCTvt5wi2corzx48Dw7F7/6x86WizN36P1Izp3EF1isxq0dAR6YB35RT7AqFZUvpqCfCv2ynZjUOLhitcyh74m5rlQcsZfl6ogsw7WDXMup2SAZZzgaulO9JUD4muAxh0JVFcj9LZJY5aUy6xjLoBVbFcRIIIXlHKrI+JCTbB9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155370; c=relaxed/simple;
	bh=tGJQwWPlYMBYIiPn3hm8qMNx+p/F+QNvF2jJny2cDfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XN+SagmrpnfPvE3NWBrLv4kPaBmdScsHzeCPaK3yg56g57XPsqG3B5TD1wH5/RIBBe2z/50+VYzKD1b9g8g7RzIUVac5vqtZPlhSbCOn+OX+dauEqFDAKKOHFwkSipK7/vVuxXb3f5NP1ZHlIIMUD6ccvkiYWjqfLWVFsrgpne0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=eVPArtS4; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755155349; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CGBpP2W8+XyP+ijwC5mVu0sCt/wY6l1nkGT89S//8IAneMCIYxkSEQ+1pt3ogTFm15i3yAwCssCMvRCzyv9Gzhp2tjOQ2ephKg0bMVSabyf7ZaOKX3mtS/6uo3yMpbLFVKWZSSBcJ9ia1Kcm9vLxH8FRnlezU8cCXS5N+BkefdE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755155349; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ovEpVAobaOr5oSBqbEFTxrzxetp69gYJsDnRp3Z4kbc=; 
	b=YusffWqmjwbF8xra1OyH9QFNBqY2kNfq4IKnhr7VRyw7R7tjSXmpCzC11L90pKdFmToJJr8GsStcnXziLwJSLio/6mvGEAV/s8TCz7j7Fn2oQzFXP7O1wt4g9mjaUR8zRnufPVfvukQVnYEsZ6Bk1s4onWWwwO+JiikT8s5a2QM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755155349;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ovEpVAobaOr5oSBqbEFTxrzxetp69gYJsDnRp3Z4kbc=;
	b=eVPArtS4raaE+ZdXltwOJwjfHIFRpXne6G8ci5hUeEcWGtb2BBoysE3JyxGaWDFy
	w8WxC+DynbcWgkbS9dcQCE7dXLdCybNncVTB+18cQ7WmoAXDF1TWLqWppnYOTHYlXOy
	+lNX1USHsX83k6e9SqulDArMtFSDe387sNMgf/vQft0s5NtKvGwKH7lBp2HTS3PCgvG
	w6+MlRE0JBKUanjSHDMYwntqF0HE/uDDsWSegyJWtXU8n8nlG4nbP5+HoHbwf5Z3LXa
	yfa9Po7eLkda7x17hX8DlNrOnxzhT9pZJBWnFGyDpCvAQC5dfWmkswYFhI7VU5q4j6r
	1McF2xJ7aA==
Received: by mx.zohomail.com with SMTPS id 1755155346042254.80641025392765;
	Thu, 14 Aug 2025 00:09:06 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [RFC PATCH 4/4] riscv: dts: thead: th1520: add mailbox channel for SBI-to-AON comm
Date: Thu, 14 Aug 2025 15:07:57 +0800
Message-ID: <20250814070757.2267325-5-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814070757.2267325-1-uwu@icenowy.me>
References: <20250814070757.2267325-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a mailbox channel declaration to the AON firmware node to describe
the mailbox channel assigned to the SBI firmware to communicate with
AON.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 136ebe210b876..6e5e0223d0c16 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -233,8 +233,8 @@ stmmac_axi_config: stmmac-axi-config {
 
 	aon: aon {
 		compatible = "thead,th1520-aon";
-		mboxes = <&mbox_910t 1>;
-		mbox-names = "aon";
+		mboxes = <&mbox_910t 1>, <&mbox_910r 1>;
+		mbox-names = "aon", "aon-for-sbi";
 		resets = <&rst TH1520_RESET_ID_GPU_CLKGEN>;
 		reset-names = "gpu-clkgen";
 		#power-domain-cells = <1>;
-- 
2.50.1


