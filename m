Return-Path: <linux-kernel+bounces-849397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F35BD0058
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 09:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 993D94E0F79
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 07:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557BC224AE0;
	Sun, 12 Oct 2025 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="Ap4mKUSw"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8C2236FA
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760254428; cv=none; b=Yg+JU7t6K/+PYX6LCPMWdR0GlNA5rfj4K54yi/J5zoyLANuZZaKLl2PaNt1AlQPHXyuOvZkufdh4oE7ir5tsl1+/UJ2BqVPbCdprec2Wle4nkdFH0Lwkl5tIHd8AJ0U++E/xPGcEPsyWZR8FB73YEKPLULWAjmfuLwcie323nBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760254428; c=relaxed/simple;
	bh=o6Krl45XALcFc+4s7K8Ll5ecQ8kjyAQErwhMcmzQJJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRiG3EwEWZYpT5h8Zt1XLPaeXH6BESq0dO8omLu30qgOwaJZvXtuCqmdPXxo4hQsuUfe3dCxXjvN/A+L3DLb/1hPymEeeDSe/pALUlRvlvQLz8uN6/TnxKNVbqV0fShe3qc1eiUMlzELghmqYiy777covDyYF8k/2moaP4FxbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=Ap4mKUSw; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 799BF240103
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:33:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760254417; bh=aF5ZMX3vFZFd5CUhN4D6QEcI/dgKVJ/xw2JACBB6noQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=Ap4mKUSweBPoDyZb2N3CfWInSTdNXyJuntlwOz65i088COZrJUG8ylj6zK2YrQ5Po
	 PbQk2KiOlxal6/B0RVHyJfDw5jlC5IEDU4tuZfRbejlusOefFyNQzkC3OLGWfcsxQn
	 dCVQ7vggT8zqKptSGt1gwTBL3bZOC7WOYyOsckS35amGFlu+bUsdgY5Gn65uNSB6ft
	 iAtcc5CTBj/WzT4oTgDOG0vG1MgDIdLylgV/gXLm8Ou3stm9rI9c+ur6tQWLJS2InV
	 WT+PA96SbTIxOlUzdHwuRD9cLfZcKQ5/a3AJE2Gz59QWM5xAZRXCfVvWzkw9kkbw8o
	 Fb0QR7f7Wa0dA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cksfS6mGLz9rxF;
	Sun, 12 Oct 2025 09:33:36 +0200 (CEST)
From: =?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
Subject: [PATCH 3/3] dt-bindings: media: imx8mq-mipi-csi2: update Martin's contact information
Date: Sun, 12 Oct 2025 07:33:37 +0000
Message-ID: <20251012073314.9035-3-martink@posteo.de>
In-Reply-To: <20251012073314.9035-1-martink@posteo.de>
References: <20251012073314.9035-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update surname and email address in order to be reachable.

Signed-off-by: Martin Kepplinger-Novaković <martink@posteo.de>
---
 .../devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
index 3389bab266a9..9d9b697e936a 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: NXP i.MX8MQ MIPI CSI-2 receiver
 
 maintainers:
-  - Martin Kepplinger <martin.kepplinger@puri.sm>
+  - Martin Kepplinger-Novakovic <martink@posteo.de>
 
 description: |-
   This binding covers the CSI-2 RX PHY and host controller included in the
-- 
2.47.3


