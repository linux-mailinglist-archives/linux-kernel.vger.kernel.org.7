Return-Path: <linux-kernel+bounces-745320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24065B11860
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD985A1FF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7087623F421;
	Fri, 25 Jul 2025 06:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="To3MtcVj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ook6lqJ4"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A4DDA9;
	Fri, 25 Jul 2025 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753424210; cv=none; b=MZGlAWZ5Q+JekV3WZB3C4i9ZAxPFy4ZsKhkIOK9IdF/BhHjHDhqGYZKiTkwt1I0cOJMX+OTyRlYq5cobEV1gczmtsnWcKXpC4DBFLGR8cbGn5IP0F06hF7mx+XZmjDBV1857OLqW+/ag7XVpXAmzlMxPbPjGWMsJx8YHoehS9RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753424210; c=relaxed/simple;
	bh=UX9o2UBcrLrTyB/SAnQgRLvf5FcPARPR/tUxFeAlJvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVxH+xcWa3jaMzTtHMQXlVdrmKN4Tp8VOycnWQWegoPNaP5hgcV1vVHuwBjBdQHSpsrN/hpUzfTqMFX13duUaXtgWeUN6kIKp8E11BJU4CB0uHw1AwpuSDgQpaz+EKqDMHNI+uD5nopl3y1imlYlqPibFUX2UX1FhL/lvHjFpeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=To3MtcVj; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ook6lqJ4 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1753424208; x=1784960208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6+NMJ7h/o8pylRH4ygiHeGJQ+PzavQZbTp36paYIGYQ=;
  b=To3MtcVj0ym4A+m4q3+tXKlQb2wb6QXC4GC5tAnvfZBq/tbXCD6e+Ic7
   0E0O5Udnv2PPJBpQilov2XvIafjyXKJdmdds7UW10W+N01nHpWv3uJAAu
   PUUBqUqEtoQal7ijTZnvO1XF8YRPdpN9mP0MUv0ZgH2JkpbbfijbHUW57
   NRh3f9tHDJgvHqNwr5fkNHnlJSkKk13jtHgK1lPfrdPZH51z6JbI+/ChA
   MSBOaZr+UrBGXaM51UFqbSMUkOcC8S0tiKoVSZGO6VSaDtGE54KoGFR7L
   n7yHmHiOkqZBwMFo0iaBDRUIONuBMGXLjXCwCPm874A9TQzSFpU6gYaJf
   w==;
X-CSE-ConnectionGUID: wCx4nWgLQiaR7GJ+WCauAg==
X-CSE-MsgGUID: pdqx8zC9RPi5hh2m7frMQA==
X-IronPort-AV: E=Sophos;i="6.16,338,1744063200"; 
   d="scan'208";a="45413152"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Jul 2025 08:16:45 +0200
X-CheckPoint: {6883214D-39-943DFC15-D71A48EE}
X-MAIL-CPID: 382319F339E41E674EC679742E33E083_5
X-Control-Analysis: str=0001.0A002101.68832150.000C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59D22173655;
	Fri, 25 Jul 2025 08:16:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1753424201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+NMJ7h/o8pylRH4ygiHeGJQ+PzavQZbTp36paYIGYQ=;
	b=Ook6lqJ45cr4IQkw5NLK0hVGwkBA4ZFHhDp0XrV/6cMurI/wwyHM/Hq0aKVz8ezmHR9a4P
	K9u9RD++BnIxLHAe5/cEyjMWzOdFbBjLfiUuAcHG9lFDNj5P4RrgN9SE7+16U65kV4Bi57
	Y3j9xaNmXgYXl66WhHGdAlTeCDIvM2AAE0jdn3lQgFxDyp94RCSWrtDx7ibcQbqQEPvGno
	3fhxVw9wqi8bt+D3oXyrfII8HPJXdbcXCRSrTPDfFV/nED1eOxIwqfLO1Ggibh4jEeH2jr
	UGs9Lzlnnc+n4V/musW+kvG7LWtVaeNnqC6YQnwqO0xclpu9BCb8+Jb9IZ5MQA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: ls1021a-tqmals1021a-mbsl1021a: Remove superfluous compatible
Date: Fri, 25 Jul 2025 08:16:32 +0200
Message-ID: <20250725061633.267174-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725061633.267174-1-alexander.stein@ew.tq-group.com>
References: <20250725061633.267174-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The touchscreen compatible in the overlays has one extra entry. Remove it
to fix the dtbs_check warning:
  touchscreen@38 (edt,edt-ft5406): compatible: ['edt,edt-ft5406', 'edt,edt-ft5x06'] is too long

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso    | 2 +-
 .../nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso
index 146d45601f693..66cedc2dcd965 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso
@@ -36,7 +36,7 @@ &i2c0 {
 	#size-cells = <0>;
 
 	polytouch: touchscreen@38 {
-		compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
+		compatible = "edt,edt-ft5406";
 		reg = <0x38>;
 		interrupt-parent = <&pca9554_0>;
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso
index db66831f31af9..8b9455bffbd26 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso
@@ -36,7 +36,7 @@ &i2c0 {
 	#size-cells = <0>;
 
 	polytouch: touchscreen@38 {
-		compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
+		compatible = "edt,edt-ft5406";
 		reg = <0x38>;
 		interrupt-parent = <&pca9554_0>;
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
-- 
2.43.0


