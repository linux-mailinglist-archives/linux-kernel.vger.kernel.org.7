Return-Path: <linux-kernel+bounces-838829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B5BB03B7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A152C1891E32
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E02E229A;
	Wed,  1 Oct 2025 11:45:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F82E0903
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759319154; cv=none; b=Fc9KNQO/Y3FIaAyyyBZP+/L+CrtOsVNpJX0mK6YGFfbbSQv3TcANd3nJG7ojJ6AW2oxPpylywKb4uzaMMbV4SPe5UhgwC/QP1cwjhy4DD1nhOADm4gQ+IXAS417dKMF/MBBZJAMM/EhEUh44tHojipOTJ9Rjwn5Rz36DCI3nWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759319154; c=relaxed/simple;
	bh=1qJy9jcIfpdFjPrSvKLZEJCwCb+4vGaNfFjpmvlwpAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYGjFaXp6qwD1YE3RyhCRJITBokWkaCg9f44dIBNciefJdDECrpbgpVaxUoXvD8VEJQyYrT33oAv6MOatBdjOeaxyys4Lt220lKj9FIK5pwrgGq+UNximW9gJqfvxdZMMyUxXV5CO+y/0afAdK7Uk5zhHgm+8rqD5tYfvQIp7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vGz-0007sl-F3; Wed, 01 Oct 2025 13:45:29 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vGy-001PCA-2Y;
	Wed, 01 Oct 2025 13:45:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1v3vGy-000000081Ta-2zBI;
	Wed, 01 Oct 2025 13:45:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 01 Oct 2025 13:45:28 +0200
Subject: [PATCH 2/2] dt-bindings: hwmon: ntc-thermistor: Add Murata
 ncp18wm474 NTC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-ntc-thermistor-ncp18wm474-v1-2-2c64b9b509ff@pengutronix.de>
References: <20251001-ntc-thermistor-ncp18wm474-v1-0-2c64b9b509ff@pengutronix.de>
In-Reply-To: <20251001-ntc-thermistor-ncp18wm474-v1-0-2c64b9b509ff@pengutronix.de>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759319128; l=979;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=1qJy9jcIfpdFjPrSvKLZEJCwCb+4vGaNfFjpmvlwpAk=;
 b=8sxMIld2O85ooVIPRtecEYqfKXoP2LASuGBvZc/ZsxTrWAP/KafpUsyISNLVgK7f0ZBU6k+1c
 8J7L+1D5TddArmw8LWGBZ93m1TddX6uGxG0i/d6y7zKHmov8EBooBSb
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Add Murata ncp18wm474 [1] NTC to the ntc-thermistor binding.

[1] https://www.murata.com/en-eu/api/pdfdownloadapi?cate=&partno=NCP18WM474E03RB

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
index b8e500e6cd9f861fbbabd79a14d882341dbb387c..dc8bc4c6df34dfe79517044beebddad2a9700f56 100644
--- a/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml
@@ -75,6 +75,7 @@ properties:
       - const: murata,ncp15wl333
       - const: murata,ncp03wf104
       - const: murata,ncp15xh103
+      - const: murata,ncp18wm474
       - const: samsung,1404-001221
       # Deprecated "ntc," compatible strings
       - const: ntc,ncp15wb473

-- 
2.47.3


