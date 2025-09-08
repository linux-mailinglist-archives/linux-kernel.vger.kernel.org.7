Return-Path: <linux-kernel+bounces-805194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 776E8B48528
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B8017B6FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03562E54D3;
	Mon,  8 Sep 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="MTTgnw23"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EEC292918;
	Mon,  8 Sep 2025 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316464; cv=none; b=d1ZGApsJzI2vA9iAYmt+61VH49GhqD86WeA1f29lqZU/m/3XEphkZTnwLqMBz6qBc6Mn5f3wF782TV3A37AnQBUFd7zLYSs9ASoA+JG06lNejH5SuOTd+cIZkmzNP92fG24J8jZosiyiKx2DthGQWECU7pJfkHZSftikz2DF0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316464; c=relaxed/simple;
	bh=MdZEy+mKc13tFn5n0EEYzZw6bxpGTPBNamn20XR+u4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NrW00rlENXDLrIT2czdSLpifN59yLao6TDiFke9xez3WSTkix0Grg2LoqDSt6b0T0lNOz5ocZvVr9JZtoRyM5UV6QrrjqRVtbR3SPYPZ4PC/nLoAm9wbB0HoPpYwgWhp3n2zXrmvsR/dUmi+5N0/iYEz+Bkk71ayy3hjL+rE/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=MTTgnw23; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1757316460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJIQiWkgB4AInE9n12DbAJF2fbihCnUqwsNzAIdNdKk=;
	b=MTTgnw23A9YdbEDCSM7WyTzhFLgqc4Qd7TY0vTs5kKCzidQnR9fUAYyMQDD2jLUIINp4U8
	76Y3VnGW+vT2P7C19kDIXYU8gPed8+OsTcl2gBj4IK543MH56YRLYuKQ1fJs33FjWsfdio
	3+yq5vdTeSO799I1ugNbwa2KVKZjyDo=
From: Henrik Grimler <henrik@grimler.se>
Date: Mon, 08 Sep 2025 09:26:56 +0200
Subject: [PATCH v2 2/3] ARM: dts: samsung: exynos5250: describe sromc bank
 memory map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-smdk5250-sromc-v2-2-e91b2375d4e1@grimler.se>
References: <20250908-smdk5250-sromc-v2-0-e91b2375d4e1@grimler.se>
In-Reply-To: <20250908-smdk5250-sromc-v2-0-e91b2375d4e1@grimler.se>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=henrik@grimler.se;
 h=from:subject:message-id; bh=MdZEy+mKc13tFn5n0EEYzZw6bxpGTPBNamn20XR+u4c=;
 b=owGbwMvMwMG4gT3Pk7swMZvxtFoSQ8a+1iQd5hNph9YvyJFW/nTF+k+YVccMjYX7rt0+a1UYy
 qO/1CGxk9GfhYGRg8FSTJFFp15z3fRO+RTJlY/OwgxiZQKZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hoY6xjpGDFycAjDVHULs/91+SLufMeoKZOJvZfko43rs1ZpIo08mEh2htiy3F/+bxFYRwHdvG6+
 tZFthaHSe6/O7UpVrJobGdbg7qief3Hyqzk2/vHuulcv6iVFzkrcoKp9k2PjktGS6+NGJzPmLhF
 705ie4uYjJ985436RzZNYGaak/ndsvr/FY/elH/TkvfR/LA2IdJQzbTJd6PJu4tV5pzsEUJ/7V6
 3o319xWY/E8OOP44iZu1UkfVqbV6Nsf++VZtPvxvAN1/xvSK39yT/MWdnl5hEdlYpF/5xoZ7dqm
 RbOOc26by7pJUycs3S0j+1zp2Q8+JcJBO1Xy4g5p6Whc1Xj06Nr24NYlU96HpIQFCfxcx+jZ7Kw
 u+XMXAA==
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT

According to public user manual for Exynos 5250 [1], the SROM
controller has 4 banks, at same addresses as for example Exynos
5410. Describe the bank memory map of the SoC.

[1] https://web.archive.org/web/20130921194458/http://www.samsung.com/global/business/semiconductor/file/product/Exynos_5_Dual_User_Manaul_Public_REV100-0.pdf

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/boot/dts/samsung/exynos5250.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos5250.dtsi b/arch/arm/boot/dts/samsung/exynos5250.dtsi
index b9e7c493881804647534b1d7395f6eb62a07fb92..4616794b19e8c5c341d7a7d3cfe2b16bbd8c840c 100644
--- a/arch/arm/boot/dts/samsung/exynos5250.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5250.dtsi
@@ -1214,6 +1214,15 @@ &serial_3 {
 	dma-names = "rx", "tx";
 };
 
+&sromc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	ranges = <0 0 0x04000000 0x20000>,
+		 <1 0 0x05000000 0x20000>,
+		 <2 0 0x06000000 0x20000>,
+		 <3 0 0x07000000 0x20000>;
+};
+
 &sss {
 	clocks = <&clock CLK_SSS>;
 	clock-names = "secss";

-- 
2.50.1


