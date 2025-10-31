Return-Path: <linux-kernel+bounces-880364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D476BC259C5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1CA54F67A6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876B634C9BC;
	Fri, 31 Oct 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SVqep/WT"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61E03446C4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921359; cv=none; b=WDRwtnhu11owtRDvSKaJrdpZZKJNdR8Cu4ns8JbU6m6HAaW7v+2XKTPH23VHkwpSDhRAnFcAnAV+8nyz4qIRHm/JsKysPU6jcHL9Cay5RZ0pYcHaHCMFhsKfyfHeywmnDoKMnJacxFoUJDglTUcjkzg1HnAlJP9dYRDOsKUXtqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921359; c=relaxed/simple;
	bh=Nto1O8E7F5eJtEn7urOazOXUZMZvjmxSVO6WsqWWhjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akU9J7f3S11tiYGNy9eAKxljBHgU48Y3Te7ST2fHWX+O1jf7ikkK1VccMcEmFdd1y6a/3sY9wPVINHJLt8HspeS9p9OcPLedOPOqNGUpdcWXn+l4VV5x2tWybWXlQH7Q+lAZwpNIlFM8Qdf/vLSJlYBUF6l9hFc9Z130vqNfDDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SVqep/WT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2A21A1A17A7;
	Fri, 31 Oct 2025 14:35:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFE8560704;
	Fri, 31 Oct 2025 14:35:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FA9811818038;
	Fri, 31 Oct 2025 15:35:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761921355; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3MDxKT6qWTpGYlDNP4UwvRsNDZKSMQvEE+tXEiO2EX4=;
	b=SVqep/WTwpM/G10GwxAS0R6jtgTpo/G/OKyQY6p20xsofowsu1CrJg7uAviu1NyBoalOER
	TsjgxlIvfA+ckLhBfmQ6yo4Jknitu68rEs/qO7yaGLoqJHzKByCRK9QUXz8K7D7wn6hlR0
	ww6kPUfCR0UcD0shm9kdbhnfe8ErhqHqLRhQcOVqzJjQB4s49e5JAfDzp+A91FS0/xYlIN
	ZrT3h65sklMHz4lhK3f1CaIa3rmVOayuHXGIf9oaBzYwpvoBhNP8h0OOoQKxN13qXmDURE
	wQcud06/GR2xnNT0PC2oMqQnO7xa9Je39p6l499tUv65WcZjUIlzXt4U17WGRQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 31 Oct 2025 15:35:39 +0100
Subject: [PATCH v2 1/5] dt-bindings: i2c: dw: Add Mobileye I2C controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-i2c-dw-v2-1-90416874fcc0@bootlin.com>
References: <20251031-i2c-dw-v2-0-90416874fcc0@bootlin.com>
In-Reply-To: <20251031-i2c-dw-v2-0-90416874fcc0@bootlin.com>
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Jan Dabros <jsd@semihalf.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Dmitry Guzman <dmitry.guzman@mobileye.com>, linux-i2c@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add compatible string for the I2C controllers present in Mobileye
Eyeq6Lplus SoC. The same controllers are also present in the EyeQ7H.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
index d904191bb0c6..bc84631f28d1 100644
--- a/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/snps,designware-i2c.yaml
@@ -36,6 +36,7 @@ properties:
         const: baikal,bt1-sys-i2c
       - items:
           - enum:
+              - mobileye,eyeq6lplus-i2c
               - mscc,ocelot-i2c
               - sophgo,sg2044-i2c
               - thead,th1520-i2c

-- 
2.51.1


