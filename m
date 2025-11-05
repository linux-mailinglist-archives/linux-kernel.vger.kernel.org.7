Return-Path: <linux-kernel+bounces-885725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7DDC33C66
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 03:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771CF18C5B94
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 02:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35D20B800;
	Wed,  5 Nov 2025 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="s/hxortp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nwda5BzP"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259739463;
	Wed,  5 Nov 2025 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762309912; cv=none; b=WFNJL0gDSkryquDUcuIHNRDGOlPX5FTiMPZnoEOGD56uamd3brJVeeSidjaL9Z9p1fVKEsfx8x4hpuXVlx2+no19a9VWvhP3FKI5KxEtrPuif6UuXoj6g0xTi6R5Gw6y8gwgSHhok9ruroF9I6zW+Al04mWaePqIWGepFi/vVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762309912; c=relaxed/simple;
	bh=iM1CoNC6J32/ceDhS7PJrRge2UBxxZgIZ0hA083uRhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aACyKnFsth53JduVwoeVs8AdtPR0ff/Eor7gw12uDjFwD082QYDsw2dpAtEsKn3uVkxGtIp7nS8iLddY+zFMcGb0BZofdt3BQLMt3cIlouoFennkyVFB/+DZCOGp9tVeoqW0drCvUVGnn80a1I8cKIsuiy2+zus9zhzitl5QJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=s/hxortp; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nwda5BzP; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4d1Tq55cZgz9v6m;
	Wed,  5 Nov 2025 03:31:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762309905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z/uQlLcWkcXrAM9tnykNqF9EsldAO802bJDf3PdUnsw=;
	b=s/hxortpM+gPg8PFmvi0x7II0G6K9dUstt6JW+SkjD2jOiBKjVOy9lp1PDrnPQZE/m7ujn
	G2r1yo/8vVv7k2Onbjveqj4rR0u1bJuRmscj4o3SsfchGXiT5l1zx0iJQ5m/x2Y2P2yDQ2
	WvLJEz0IHOEQkJCcmWQfiOMjckpIKKracGIhAQmgMbdH+phqwrD7e6/LX58oHTCTn5uQZq
	lYa2HBaDblAzDb7SNhJeceDm+tyRPUOWShleQYAJpCJ1iBBFyhuFKL8J5b5R7BlB+BiWXJ
	u7Ws7LWPtH6FWWn+kQuw6grvr6nhfbW9RGZjGfmpe3sSsQIVjETGhZzuTx1fWQ==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1762309903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z/uQlLcWkcXrAM9tnykNqF9EsldAO802bJDf3PdUnsw=;
	b=nwda5BzPkOT2uG+rvGCie+I4/u62BwspznEHPXTumoQyR/2iHrwyTZESkass56m+qdpxxF
	7YnK5i69LoR2L8MuTonvVGlaLPvvZjGjq1GUWgNsBrk+Dsomd/9oiE759VDOReg5VldUj8
	AV4uhGfnY+0DXJo53t5ooE23VyFr65wwLUQ8ZEeYU9j8m1mLlmCu2iBBKCTZhy/OCf3oem
	Cv52O0kec9QcyG2gQLgW6k/RtdHK0t6/yKlugGBPgLMu2C6XGuGOsEAWq0Z5/v87Hwa+cW
	n4FsIvZ79VQQRuYX0YAuWMLrnimwytsix4I74G2h/n2f2H/H+jsqM9ZiGlpJ0Q==
To: devicetree@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Christian Eggers <ceggers@arri.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Markus Heidelberg <m.heidelberg@cab.de>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: eeprom: at25: Add Anvo ANV32C81W
Date: Wed,  5 Nov 2025 03:31:17 +0100
Message-ID: <20251105023138.68340-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tf4jhk36yw6m1fgz6oa7yj9qsk6iudba
X-MBO-RS-ID: ef9f64f352f72eab609

Document the compatible for ANV32C81W 256kb Serial SPI non-volatile SRAM.
Although it is a SRAM device, it can be accessed through EEPROM interface.
At least until there is no proper SRAM driver support for it.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Christian Eggers <ceggers@arri.de>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Markus Heidelberg <m.heidelberg@cab.de>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at25.yaml b/Documentation/devicetree/bindings/eeprom/at25.yaml
index 00e0f07b44f84..e1599ce109165 100644
--- a/Documentation/devicetree/bindings/eeprom/at25.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at25.yaml
@@ -25,6 +25,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - anvo,anv32c81w
               - anvo,anv32e61w
               - atmel,at25256B
               - fujitsu,mb85rs1mt
-- 
2.51.0


