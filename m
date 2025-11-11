Return-Path: <linux-kernel+bounces-894857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C96C4C473
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6A23A48DE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1662F49E0;
	Tue, 11 Nov 2025 08:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O1O/W8AA"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93953225761;
	Tue, 11 Nov 2025 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848413; cv=none; b=I9I1sWOtgdwmxcmwPQo+iE3DELt9sT5DPqJgn66MJeyGKWCTvF+fvELEayXiBgbsKU6qA/qK7pQFePGkqJf9zCiB+UUG85i/dLavKwO3ytH/PAxHGiMk2RfFiX4CcsIqjE7r9FPltAxx3WGJmFFacPOcCbKTh7BR27OksxOU4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848413; c=relaxed/simple;
	bh=+dx0yAue3k/b+NhkIOWETt6EUxGzeOC9bbDVu5NRtzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WyOZhir/pVAnkK8ZMHVlxIVPCxb7yaCf3vO47M77gaUKY3549THCGpW/n0BekmFoPDTUwWW7Y3Dkly3mDMN/eDm6/L1mFnSKwvQZVd6N4Jq6HscSDvdNNz22ichDDeVZcKTL0so2jjKqczCbFRTrgaEgOQIiqfqHF6H9ZuY+Foo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O1O/W8AA; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=I5TppMaK+ikNiBO
	g8YvMLHSWasF8jG7nBiJREzuIfZ4=; b=O1O/W8AAda22sTQLo7jG1n1WNBbMb2c
	TanABFK3Rurg4S122KrUN6gvYgI84moOK1t3w65f9bWgYaFQRsFJBeEU+I0L94XD
	f0WWfAN/WXVP3enr1uXNndgPYBwNXmR2GLV9LwrQLufBNXcaahhR6TLn6SRD498O
	hV37Q+wQa2Us=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wCnq6ln7hJpK0KCDA--.117S3;
	Tue, 11 Nov 2025 16:06:06 +0800 (CST)
From: Wenliang Yan <wenliang202407@163.com>
To: linux@roeck-us.net,
	Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: christophe.jaillet@wanadoo.fr,
	corbet@lwn.net,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wenliang202407@163.com
Subject: [PATCH 1/8] dt-binding:ti,ina3221:Add SQ52210
Date: Tue, 11 Nov 2025 03:05:39 -0500
Message-Id: <20251111080546.32421-2-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251111080546.32421-1-wenliang202407@163.com>
References: <20251111080546.32421-1-wenliang202407@163.com>
X-CM-TRANSID:_____wCnq6ln7hJpK0KCDA--.117S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1ruFWUCryxCry5tFy5Jwb_yoW8GFy7pF
	WIkr98Ww1Sqw1fX3yIgF4Fkr15Jws7ua12kFnru3yIqF4DGryYqa95Kw1qyry3JrWfXFW7
	Wa4Igr48Kw1vyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUvfOrUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiRx0D02kS5gDazAAAsB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add a compatible string for sq52210, sq52210 is forward compatible
with INA3221 and add alert register to implement four additional
alert function.

Signed-off-by: Wenliang Yan <wenliang202407@163.com>
---
 .../devicetree/bindings/hwmon/ti,ina3221.yaml    | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml b/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
index 5f10f1207d69..0fae82ca3ee1 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina3221.yaml
@@ -12,7 +12,9 @@ maintainers:
 
 properties:
   compatible:
-    const: ti,ina3221
+    enum:
+      - silergy,sq52210
+      - ti,ina3221
 
   reg:
     maxItems: 1
@@ -77,6 +79,18 @@ patternProperties:
           exclude specific channels from the summation control function.
         type: boolean
 
+      alert-type:
+        description: |
+          The SQ52210 features a configurable alert function with four
+          types: SUL, BOL, BUL, and POL. Each channel can be configured to
+          select one of these types to enable the alert function. This alert
+          function can operate concurrently with both Critical and Warning
+          functions.
+
+          The configuration must use numerical values 0 through 3,
+          0 corresponds to SUL, 1 to BOL, 2 to BUL, and 3 to POL.
+        enum: [ 0, 1, 2, 3 ]
+
     required:
       - reg
 
-- 
2.17.1


