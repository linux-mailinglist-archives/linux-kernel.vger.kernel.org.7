Return-Path: <linux-kernel+bounces-731233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511A8B05169
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44EF77ABA40
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092142D3A88;
	Tue, 15 Jul 2025 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gldnOpwH"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DCA19DF6A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559167; cv=none; b=Hxq7NQ7xgAL0/S+BxbBHD1vScIvMqJ3vRXqzYqOY0CQCzlg7+FM+URZiupA1B3eaQpObxkkhojg4NSF79Swjq783lpkBMUwQP2ivGEGm/2tbl5Ccy93WsU2LQNIjh7jn0v/KEQtzfDcbi2cUxF2wKi6ziDV61iLWhydyR/UzQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559167; c=relaxed/simple;
	bh=3C+cEonAA/iyoEPy1WeIUHn0N6rqfI4N6n8fcscpFFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UgFCHJizAtkiyk35k7DKaU6tMzYeYVGWsFJlmljIknR09tmMbDXSruGKjwzQeDlelPxv76mC1JeJZmTlikFNyLTO2cY6A5WyWWDCY00cee/bllGS2zuNym6mcKopYsZ3iEWEMfoZQOF5W+rV5hG7jM7MCzWvF4UjcaNIwpboneM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gldnOpwH; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 206A8240101
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1752559163; bh=cWcMd28LdZJtvaKT2lTtEEObHQnShKEwJB2WsINCaRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=gldnOpwH6PEH0RgZG5SIBjRQauWPfke8wj178y0ekjfrdutj/WVXtdwqjMv7t10nX
	 /6RDUL8NgYkcapZIGJmDb6HEdlt8RJGeCvukQfQI5TfMnHa6Jb5yntWbL2oTNITTQo
	 jhQEgC7DpGIhz8K/ExrIuwhDBtlcpYrDB7ObJ2Z9hnq23L9riv0yrGqMTv7ZKTnW88
	 Kh80nFsgOwfroB7Af2kMWl6lrPOUuXACjHPC61JG3SOHVRrDMJplsoONw6sIekCkGm
	 UPiy0GjIbeQaOisFefm0uk1SHNSMT67EzXSzLJ7D4o9Dmc3KcrPkFRxbq5rXE7TMnF
	 el/ZjB6Vqqhrg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bh7mn3cD9z9rxD;
	Tue, 15 Jul 2025 07:59:21 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/2] arm64: dts: imx8mp: add idle cooling devices to cpu core
Date: Tue, 15 Jul 2025 05:59:22 +0000
Message-Id: <20250715055903.1806961-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal framework can use the cpu-idle-states as
described for imx8mp as an alternative or in parallel to
cpufreq.

Add the DT node to the cpu so the cooling devices will be present
and the thermal zone descriptions can use them.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index bb24dba7338ea..66e1a27d6eed9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -80,6 +80,11 @@ A53_0: cpu@0 {
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_pd_wait>;
+			cpu0_therm: thermal-idle {
+				#cooling-cells = <2>;
+				duration-us = <10000>;
+				exit-latency-us = <700>;
+			};
 		};
 
 		A53_1: cpu@1 {
@@ -98,6 +103,11 @@ A53_1: cpu@1 {
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_pd_wait>;
+			cpu1_therm: thermal-idle {
+				#cooling-cells = <2>;
+				duration-us = <10000>;
+				exit-latency-us = <700>;
+			};
 		};
 
 		A53_2: cpu@2 {
@@ -116,6 +126,11 @@ A53_2: cpu@2 {
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_pd_wait>;
+			cpu2_therm: thermal-idle {
+				#cooling-cells = <2>;
+				duration-us = <10000>;
+				exit-latency-us = <700>;
+			};
 		};
 
 		A53_3: cpu@3 {
@@ -134,6 +149,11 @@ A53_3: cpu@3 {
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
 			cpu-idle-states = <&cpu_pd_wait>;
+			cpu3_therm: thermal-idle {
+				#cooling-cells = <2>;
+				duration-us = <10000>;
+				exit-latency-us = <700>;
+			};
 		};
 
 		A53_L2: l2-cache0 {
-- 
2.39.5


