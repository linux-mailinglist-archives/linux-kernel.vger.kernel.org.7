Return-Path: <linux-kernel+bounces-805193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CE5B48527
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2EC17B58A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8101A2E4252;
	Mon,  8 Sep 2025 07:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="cSwe7GFm"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA01F8677
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316463; cv=none; b=Jb3xrEtMTePGmVgQN0odzrZG1X6N6B0qoWKYyWHU+6VlRukV2wBNDEu/kih0lXsFZTthRQlBgTujWtHhKjuAEa1EmZexOoQGklwoHf5avYfivN8rPFc7fzUz3gPII6ZzF5Z1zC7ufC9qnIsQp422xvRzSmeLIzzBvCwhZreGMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316463; c=relaxed/simple;
	bh=jTp6dX+KTbrPXH64j5P/UlCrVJyk8SPU7cS21XqAE9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mPKh5pfyFcpmoAvlNiFYLF5j05cAdF6kFgEZqj9Ben8+PHv5fNrHWk6QLotrBdPfZLcN0ylP07p/3wtRr90c2LrE3kDMWs3YLZyn429FJn5+pgNzUPrKrx+paxoi4RatYHphVLKV2WQ/aRz5u7OZhYIXKWBk+lwAwHGRm93Yvw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=cSwe7GFm; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1757316459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjpt8Wfk2LLSDqvXhNKwiJHgJRa+rYaAGISREh5isEU=;
	b=cSwe7GFmvaTFQOm0oDcdoeV857jqy/DP++daEEF2HzKkEOuEi4Le/uQ9S8igvHxrNo746m
	T3LBE9GDv0SzZXw+jDfu8DpalxI2/5k/uGT2YBI2AE9G6AxtDiAGz+U+NgWyupSG8NtOWq
	3k4fo/99OCliTWqMStrI++nfcGCBdm8=
From: Henrik Grimler <henrik@grimler.se>
Date: Mon, 08 Sep 2025 09:26:55 +0200
Subject: [PATCH v2 1/3] ARM: dts: samsung: exynos5410: use multiple tuples
 for sromc ranges
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-smdk5250-sromc-v2-1-e91b2375d4e1@grimler.se>
References: <20250908-smdk5250-sromc-v2-0-e91b2375d4e1@grimler.se>
In-Reply-To: <20250908-smdk5250-sromc-v2-0-e91b2375d4e1@grimler.se>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=999; i=henrik@grimler.se;
 h=from:subject:message-id; bh=jTp6dX+KTbrPXH64j5P/UlCrVJyk8SPU7cS21XqAE9Y=;
 b=owGbwMvMwMG4gT3Pk7swMZvxtFoSQ8a+1rhbF+a+sLAvf7GJLXJ+xbaHlw8mXdjoIuGbmdcSv
 fZR58kDnYz+LAyMHAyWYoosOvWa66Z3yqdIrnx0FmYQKxPIFGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTUMdYxYuDiFICp7o3kYJi0ccZT72fXpnm2X7Roi5HSy7Wvm5VgPNHz9ub9/DnfF70J0eCe84t
 fkn3ea1k1tcqPSamuQo5fNVYvLBM+WZSUeN3+4cIH4jclCs7vKn9S0qB5iDeQ5ZuBwZa4wBMfzT
 Z6s4txL5G9c5VrX8XM9qRedV6L1KADj64+/3e82Ml7pZFqn/fNNUv6O/0+RX91eXjwkV+f5ZtGj
 R3bLRZXrYjQjixfuSJKomWprZexLr+7a97SpaUL3v2QbP/IKPuadY9JjFhmzgNW1VXx0w6e+Zx8
 oX9HTvx15pgFJ6pkT1vfZPujeOb7p7+KT266skqWBl+OS5X5fkFM6ORScyXZ1MNlW7LtVVhsXq5
 Q+pHCCAA=
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT

Preferred style is to have comma separated tuples when multiple
addresses and sizes are defined in ranges. Therefore, change the
format to clarify the node.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/boot/dts/samsung/exynos5410.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos5410.dtsi b/arch/arm/boot/dts/samsung/exynos5410.dtsi
index 546035e78f404d764cb653ce25b73778c53fac0b..350bc8d6aa5ce8cc7c28606fb56bbcd748fdbf68 100644
--- a/arch/arm/boot/dts/samsung/exynos5410.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5410.dtsi
@@ -372,10 +372,10 @@ &sss {
 &sromc {
 	#address-cells = <2>;
 	#size-cells = <1>;
-	ranges = <0 0 0x04000000 0x20000
-		  1 0 0x05000000 0x20000
-		  2 0 0x06000000 0x20000
-		  3 0 0x07000000 0x20000>;
+	ranges = <0 0 0x04000000 0x20000>,
+		 <1 0 0x05000000 0x20000>,
+		 <2 0 0x06000000 0x20000>,
+		 <3 0 0x07000000 0x20000>;
 };
 
 &trng {

-- 
2.50.1


