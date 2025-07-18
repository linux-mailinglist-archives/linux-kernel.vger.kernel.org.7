Return-Path: <linux-kernel+bounces-736969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F3CB0A5EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871C17ACD0A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B32DBF46;
	Fri, 18 Jul 2025 14:13:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663D221287
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847989; cv=none; b=LcuZx3ygI5CemBX+xSH0o3y2srIVOPw7nUus0hQyBFZpiDnKP4MDmGEvCQNmZQfdblpFmgn9+5gJiiXi+iYAp+g37007Vzu5f5g57AHQ6kXGt+U0QZut+3i7E2Pj3KVIKgw5tfkQrak7CuagRaOUWtOqmJJac+ncb1lEHIUX/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847989; c=relaxed/simple;
	bh=F9NqNt6Q/0O3j4qGBJ4CsUBJD1PPRxeeIhc8Ja66Ju0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nHQLYpit9jPJci/ZdxK3nNfewB3jmGm5HfSqL/l/cCnavzLmDyBuZfOXxcuZNF/Ral2TQ2l8uwEtTcFLInDJcBvSVmPqyokT7OYq32fhd3CxP94nnQb/HG6QD791p2AXovpz4QEnD9XsmlTk9jTNYQkU+AZUTSxBIOfYodjQ/W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uclpT-00065i-J2; Fri, 18 Jul 2025 16:12:51 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Subject: [PATCH v2 0/3] ina238: Improvements and INA228 support
Date: Fri, 18 Jul 2025 16:12:47 +0200
Message-Id: <20250718-ina228-v2-0-227feb62f709@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF9WemgC/2XMQQ7CIBCF4as0sxZDB4jGlfcwXUCZtrOBBiqpa
 bi72K3L/+XlOyBTYsrw6A5IVDhzDC3w0sG42DCTYN8aUKKRt94IDhbxLrx3xhjpR4cK2nlNNPF
 +Qq+h9cJ5i+lzuqX/rX9E6YUUSkmcLGmttHuuFOb3lmLg/eoJhlrrF+uyqiuhAAAA
X-Change-ID: 20250715-ina228-ddb5550dcb23
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-19c33
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=F9NqNt6Q/0O3j4qGBJ4CsUBJD1PPRxeeIhc8Ja66Ju0=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYsioCkuUi+DymLLB/ePVk8c3NOz2cZma1RLoZFGkslb1Y
 JGOd965jlIWBjEOBlkxRZZYNTkFIWP/62aVdrEwc1iZQIYwcHEKwET27mT4K6AvefzsDlfeSDMX
 eXuhy8w3faxnf6zTOfJW4rO/+1kfc4b/wa93scaFT7K4Pnv2Ggttxo4/8487z2V1Cous1pAX0rD
 lBQA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series includes:
 - Whitespace fixes
 - Support INA228 ultra-precise power monitor

Tested on the INA228 chips on a TI TMDS62LEVM.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Changes in v2:
- Drop patch for label support for voltage inputs
- Sign-extend the twos complement ina228 20bit registers
- Upcast current readings to s64 earlier to prevent overflow
- Improve whitespace patch
- Link to v1: https://lore.kernel.org/r/20250715-ina228-v1-0-3302fae4434b@pengutronix.de

---
Jonas Rebmann (3):
      hwmon: ina238: Fix inconsistent whitespace
      dt-bindings: Add INA228 to ina2xx devicetree bindings
      hwmon: ina238: Add support for INA228

 .../devicetree/bindings/hwmon/ti,ina2xx.yaml       |   2 +
 drivers/hwmon/ina238.c                             | 134 ++++++++++++++++++---
 2 files changed, 117 insertions(+), 19 deletions(-)
---
base-commit: 27b297ca04813623d8df2f79d141d51e0856810c
change-id: 20250715-ina228-ddb5550dcb23

Best regards,
--  
Jonas Rebmann <jre@pengutronix.de>


