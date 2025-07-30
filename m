Return-Path: <linux-kernel+bounces-751115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF0BB16569
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B544566F7E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49932E06EC;
	Wed, 30 Jul 2025 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="nMRdhoC4"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB141F4E4F;
	Wed, 30 Jul 2025 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896192; cv=none; b=ayxIDnBoZxhnrQ4MTeraEJ6Vs2zFiLicKICPtJmOunryfEopAVUf+fSpMM68jMhQTCcrgFPyqYuDgFF0/FtUI+BVgufpDv1DZT2COa8mu9Ii9Crg3rBJEMla/RKXYyhtA3e4KBOU2vrL/Po9dtG32ZcaiM+XsfGjIYMOKnp2Usw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896192; c=relaxed/simple;
	bh=/BZJDz86DA6t69bUf0wl6foW/BKJ1xZaOxAGF/awv1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGIzLiCkPNb34PijpiEK07As6RJNiWdSsXtO7e/tD8OReOtYfk/VdlqDJ/nQtoCr4Sen+g+vvNTWUqm/hbVGom5CK31nh4ZdnS0OAaM8r2DLWSPPf3WwbQ+P7L+c0EZ1pxG/kgTjL3YpW/C15XPOEsav4Q5P3U+fFtoxrSmJ0rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=nMRdhoC4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=GK6Yzl4ZSnIYpyse6ljIcHIa4H1HuRYkuWoHSBKcCZk=; b=nMRdhoC4EzhDkBWe9Sc6gxMAgj
	DB2SWMpZSiMSMt10oynDeI4PrgBMMorQ1PEgdq2gLyqGFi/hRY0Qwjwvf/cObOJnT5o6KFzzq9h28
	CERarF7zGznbz03fDCYNN7UF66AB8txzwWOXrU5uEn7ejVz/FHF5upqb9ZkFYXvzw3+SBag1YV3PV
	1NFmo8VXsAE1NzFidej0X3qOjmL4EmdoRtISziTO7bW64TdOCA9hB4fk56X3OOEB9tJ+oVEZyro7S
	VtxrKlnHFwbSALJRjdQ9blKqnGHMl7SIyWlZPMVVXpkXnIdvouLmwetlUetGRCYge8+pUVa4m6Qih
	NTRQAg1w==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uhAWC-0001Xq-LX; Wed, 30 Jul 2025 19:23:08 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: lee@kernel.org,
	srini@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: mfd: qnap,ts433-mcu: allow nvmem-layout child node
Date: Wed, 30 Jul 2025 19:22:47 +0200
Message-ID: <20250730172248.1875122-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250730172248.1875122-1-heiko@sntech.de>
References: <20250730172248.1875122-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MCU has an eeprom memory connected internally, that for example
contains some mac-addresses for the soc gmac controllers.

Therefore allow defining the nvmem-layout for the eeprom.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml b/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
index fe9e06cfb933..5454d9403cad 100644
--- a/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
+++ b/Documentation/devicetree/bindings/mfd/qnap,ts433-mcu.yaml
@@ -19,6 +19,9 @@ properties:
       - qnap,ts233-mcu
       - qnap,ts433-mcu
 
+  nvmem-layout:
+    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml
+
 patternProperties:
   "^fan-[0-9]+$":
     $ref: /schemas/hwmon/fan-common.yaml#
-- 
2.47.2


