Return-Path: <linux-kernel+bounces-821981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE8BB82C26
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450A87220ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4038244668;
	Thu, 18 Sep 2025 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y3yrUWal"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF13225416
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166045; cv=none; b=qTrc5tQwZeCVb1t9IPweMnbXglpmSXh+Ins9BpKwDPAjFCeiodCGdvUKjwfa1yj8+Qjx/OiuET0di4HbJ8M+30a3S4ozKq+NkOqkRIkA6nUSk06hQnWs1mhlBk9UqG1porW1QpZIICCBna+lrUfCDa2TqQxM9X2VdS2rxJJX0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166045; c=relaxed/simple;
	bh=IWAvZc9XNOhKSbefPW6ZuZDu3C9roTl6Uw9ZX8MCcnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=C9ZBTUDEq67v0Pf4kWBv3DKNQLuawdY8TRZn3AslQwQyB5xazk+J8eHt+1h/W6pcgtv0No3yNauA0gIung4Pi7Lms+vnwhACjX5Q9uk1PBv259lqtociqTAuUIvzFwwGQWVD/o9JLEAC99Ufw2rHk+1is6nYhJ5kgg7rZFqec8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y3yrUWal; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250918032717epoutp03ecb50d01e497f5fb3a700f6d992ca895~mQrI-EkIU0178301783epoutp03H
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:27:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250918032717epoutp03ecb50d01e497f5fb3a700f6d992ca895~mQrI-EkIU0178301783epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758166037;
	bh=NE3XfrRkhwEKqjy08lI0S/9Q38XrQ40aHbrikvthnuI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=Y3yrUWal/rfn3draRh9ilZvKOqQh6Hxx/sLwKVZ/svR5bpPXrgmhbUqRnYQcm2Btz
	 SQupOnZ8mSJiWLdhzXhZaHihhh0NoNKKsDLlmpx2YQz/oU0f+PNc+RTiBUIW/PrIOa
	 EEoTgOl6pcgItWuAH9DGB1SNbeUBTcWCDIw3msv8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250918032716epcas5p38f08377a24228c806b6f1569df328559~mQrILNqbe1789717897epcas5p3t;
	Thu, 18 Sep 2025 03:27:16 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cS1KJ03X9z6B9m5; Thu, 18 Sep
	2025 03:27:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250918032715epcas5p1d1144cc09fa9c301315a5e2778d8668e~mQrGiXWxN3008930089epcas5p1Z;
	Thu, 18 Sep 2025 03:27:15 +0000 (GMT)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250918032712epsmtip2d9dccd5b8fb088ae2db9766928a16ca5~mQrDm1fkE1525515255epsmtip2V;
	Thu, 18 Sep 2025 03:27:11 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, ksk4725@coasia.com, pjsin865@coasia.com,
	gwk1013@coasia.com, bread@coasia.com, jspark@coasia.com,
	limjh0823@coasia.com, lightwise@coasia.com, hgkim05@coasia.com,
	mingyoungbo@coasia.com, smn1196@coasia.com, shradha.t@samsung.com,
	swathi.ks@samsung.com, kenkim@coasia.com, Ravi Patel
	<ravi.patel@samsung.com>
Subject: [PATCH v2] dt-bindings: serial: samsung: Add compatible for
 ARTPEC-9 SoC
Date: Thu, 18 Sep 2025 08:57:03 +0530
Message-ID: <20250918032703.8885-1-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250918032715epcas5p1d1144cc09fa9c301315a5e2778d8668e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250918032715epcas5p1d1144cc09fa9c301315a5e2778d8668e
References: <CGME20250918032715epcas5p1d1144cc09fa9c301315a5e2778d8668e@epcas5p1.samsung.com>

Add Axis ARTPEC-9 uart compatible to the bindings documentation.
It is similar to the older samsung,exynos8895-uart design.

Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
---
Change in v2:
- Removed "axis,artpec9-uart" string from allOf section
Link to v1: https://lore.kernel.org/all/20250917071342.5637-1-ravi.patel@samsung.com/T/#u
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 1a1f991d5364..d12018aaac9b 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -48,6 +48,7 @@ properties:
           - const: samsung,exynos850-uart
       - items:
           - enum:
+              - axis,artpec9-uart
               - samsung,exynos7870-uart
           - const: samsung,exynos8895-uart

--
2.17.1


