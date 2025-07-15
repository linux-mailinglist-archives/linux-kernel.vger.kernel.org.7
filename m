Return-Path: <linux-kernel+bounces-731236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AF0B0517F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B094A0C43
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 06:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521852D3757;
	Tue, 15 Jul 2025 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="pR2oBFDo"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5E25C81F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559669; cv=none; b=JXx+ijieNw8TtUuRLaOzeXRM/osrB09NEh6rw4DIkN7KgH9DEsN/z82hcCP0yqGrWX5OsScIdn1Csm+qy7ONSQ1rW9e0f1Ht1x5pRhIRKVkJ5xg7Z6Gvds0YRIjSYWHUO8Jn2Y1hkJ1tQl7T0cLz9CAwTZRU0n4eHbqKGk1ClZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559669; c=relaxed/simple;
	bh=oVON/prm48H1aLhTaKOALu1dSNvrw9f+0LmHeOMYSXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsLq6tUpzdUTrfquHbsx6oEJ5QF2Inx69lckKsKo6cujg4yEKfDJAqIMa2i+dtTGFnzQbNelhJCAEKhYrG30tdE0KCf31Dha50hQA4yHmveI81qW7izKV4JHhM0rHNwPcNn9RZ38CYY8myHrG6TasSuZqwIy22UlIFtuCh++mbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=pR2oBFDo; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 2B3FA24002A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1752559164; bh=xwt+/5yN9eHNa8k62uiqoUjCvkUIIM6ihaRXsqxOjj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=pR2oBFDoHyI44taRP3tCTyn8HSfyohptVLFF6NYGJg/0XEjWh+VPSP2bLttYa/xdf
	 PFfQ0JDP7fxWA5ZrzDr7oei++mqkbJr2cZwbi2748QkvURH+0seD9ZYY85qk9ZMvs9
	 D8jMrFpXm0Z3UEP0XoPjJfruOWe8Bey1njZNw68PEvNou+jKH7QnqJWbxx7eW0gvD2
	 blobCjz+k3D0bh5U73yN9bDakSQjR7fDWa9l4/Bw/tOL7tdmI0tZyTAs38dEF1Qyz5
	 AK9zu3QrGURH7NmEeIiOQ/8ieYUuRGMqxDQ1gTMzpf3ufTGjZx47uu3hFv8bZOv46G
	 36RuMP713pt/A==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bh7mp5MKzz9rxG;
	Tue, 15 Jul 2025 07:59:22 +0200 (CEST)
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
Subject: [PATCH 2/2] arm64: dts: imx8mp: add cpuidle cooling device to the alert trip point
Date: Tue, 15 Jul 2025 05:59:23 +0000
Message-Id: <20250715055903.1806961-2-martink@posteo.de>
In-Reply-To: <20250715055903.1806961-1-martink@posteo.de>
References: <20250715055903.1806961-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Idle-inject up to 50% of all cpu's time in order to help cpufreq
to keep the temperature below the trip points.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

hi Shawn and all,

50% is of course random, but this is an emergency situation already
so it might not be the most critical value to find a consensus for.

SoCs rarely describe and enable the idle-inject mechanism. IMO it is
desired if only in order to have an example of it merged.

thanks,

                               martin



 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 66e1a27d6eed9..6c1d7ca2de21d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -343,7 +343,11 @@ map0 {
 						<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&gpu3d THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&gpu2d THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&npu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&npu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu0_therm 0 50>,
+						<&cpu1_therm 0 50>,
+						<&cpu2_therm 0 50>,
+						<&cpu3_therm 0 50>;
 				};
 			};
 		};
@@ -376,7 +380,11 @@ map0 {
 						<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&gpu3d THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
 						<&gpu2d THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&npu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&npu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+						<&cpu0_therm 0 50>,
+						<&cpu1_therm 0 50>,
+						<&cpu2_therm 0 50>,
+						<&cpu3_therm 0 50>;
 				};
 			};
 		};
-- 
2.39.5


