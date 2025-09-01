Return-Path: <linux-kernel+bounces-793832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5662AB3D8F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 07:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168BF3BB508
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AEB23D7C4;
	Mon,  1 Sep 2025 05:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KrZKyG8B"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFA424A054
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756705375; cv=none; b=DBh5qG1FR0xufLASe35NPePMMR/TdEfICilSVAwBWOcB4IeYat/6IT7jiMIMKNoResjkW7ePeDOJFLMtMIfex84j3mlT1LpuLqdYhKyu0Tp1J+4SDtEHiENxuyQzHRAfQ5k5rBsshnQAH7zr1HIwNpVZ2pdxggUx6DUWz6Kr0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756705375; c=relaxed/simple;
	bh=HFgDvQWT2HyZdyNkGNo3jDHmPek971QxEVhOXxL/PLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=eZH2rx2CS7MF0MDQZVX94pNQCaasYrGKsYrDm/ComE7RMZF0C/FRfnOZed/jO0mkTsbzt73QBRYj6Umhw+gr1PxO8tF1KAYTPwdCqy4vEqmbpY0kvGysITuJDSmHFOcvL93rYbHUy61910MthPFO+Kg04iVJKVUAzpXkuDIPK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KrZKyG8B; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250901054252epoutp01b13423f8bee6bf9eb5f727da9c7a65c5~hEjp7pHAa1772917729epoutp01U
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 05:42:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250901054252epoutp01b13423f8bee6bf9eb5f727da9c7a65c5~hEjp7pHAa1772917729epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756705372;
	bh=PZ1lD7/HiIrsx1nwS+to//VvpTeYHESswHKS1MyGRd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KrZKyG8BPhP7vmkk+cWjFKosTwK3UWl2AyEaYCImwTCAap3zgo0KP8dMA6Y2Gyo1f
	 3bpV8Jbu4RiYbN55UEAAR+T1LFIWud/DUgycu20cz6L8VeWeLW6PZhLNV/CKaNUuXP
	 BNSAAdJIWx2J36HmIUY3xorWqcc/0ydepbO5mM5o=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250901054251epcas5p475f99c8efd986d517e5e335f8fe4f514~hEjpAtrz_2599425994epcas5p4Q;
	Mon,  1 Sep 2025 05:42:51 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.91]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cFd7Z0dP2z3hhT9; Mon,  1 Sep
	2025 05:42:50 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250901054249epcas5p483e898d45e072cb0faa79a681f73f0d8~hEjnlIkfz2137821378epcas5p4E;
	Mon,  1 Sep 2025 05:42:49 +0000 (GMT)
Received: from Jaguar.samsungds.net (unknown [107.109.115.6]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250901054244epsmtip284d5c2a46a5299c22e8e6bb99ea8e999~hEjjQRonB0761907619epsmtip2x;
	Mon,  1 Sep 2025 05:42:44 +0000 (GMT)
From: Ravi Patel <ravi.patel@samsung.com>
To: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
	s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com,
	linus.walleij@linaro.org, tomasz.figa@gmail.com, catalin.marinas@arm.com,
	will@kernel.org, arnd@arndb.de
Cc: ksk4725@coasia.com, kenkim@coasia.com, pjsin865@coasia.com,
	gwk1013@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com,
	smn1196@coasia.com, shradha.t@samsung.com, ravi.patel@samsung.com,
	inbaraj.e@samsung.com, swathi.ks@samsung.com, hrishikesh.d@samsung.com,
	dj76.yang@samsung.com, hypmean.kim@samsung.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH v4 3/6] dt-bindings: arm: axis: Add ARTPEC-8 grizzly board
Date: Mon,  1 Sep 2025 10:49:23 +0530
Message-Id: <20250901051926.59970-4-ravi.patel@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250901051926.59970-1-ravi.patel@samsung.com>
X-CMS-MailID: 20250901054249epcas5p483e898d45e072cb0faa79a681f73f0d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250901054249epcas5p483e898d45e072cb0faa79a681f73f0d8
References: <20250901051926.59970-1-ravi.patel@samsung.com>
	<CGME20250901054249epcas5p483e898d45e072cb0faa79a681f73f0d8@epcas5p4.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: SungMin Park <smn1196@coasia.com>

Document the Axis ARTPEC-8 SoC binding and the grizzly board
which uses ARTPEC-8 SoC.

Signed-off-by: SungMin Park <smn1196@coasia.com>
Signed-off-by: SeonGu Kang <ksk4725@coasia.com>
Signed-off-by: Ravi Patel <ravi.patel@samsung.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/axis.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/axis.yaml b/Documentation/devicetree/bindings/arm/axis.yaml
index f9c218dc6883..63e9aca85db7 100644
--- a/Documentation/devicetree/bindings/arm/axis.yaml
+++ b/Documentation/devicetree/bindings/arm/axis.yaml
@@ -8,6 +8,7 @@ title: Axis ARTPEC platforms

 maintainers:
   - Jesper Nilsson <jesper.nilsson@axis.com>
+  - Lars Persson <lars.persson@axis.com>
   - linux-arm-kernel@axis.com

 description: |
@@ -24,6 +25,12 @@ properties:
               - axis,artpec6-dev-board
           - const: axis,artpec6

+      - description: Axis ARTPEC-8 SoC board
+        items:
+          - enum:
+              - axis,artpec8-grizzly
+          - const: axis,artpec8
+
 additionalProperties: true

 ...
--
2.49.0


