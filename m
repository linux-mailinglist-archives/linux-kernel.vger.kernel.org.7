Return-Path: <linux-kernel+bounces-822598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CDBB843F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BBB7B1AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41EA2FFFB4;
	Thu, 18 Sep 2025 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNBxkVaU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A422C327E;
	Thu, 18 Sep 2025 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193138; cv=none; b=ZR9aJh7lXpI6eoQZBRQ+OgroOEkySvRi0bL3MSzniNqTDTKVV6Ln+Y5KaUIfzAWCvEtlrUfV8WffVUG/7KU17iLIFpvDWm/PMzQBSFi2YOppDscrWkGgPGACkaJs5/hpvy2u6aCrU1yiGyuSeNmL184LVN69HQ1Jt3IqKkMU4sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193138; c=relaxed/simple;
	bh=LL/Uw6VE1EBTQfjT9hHDOnQ6gjK5F3ud8EjZ7zF1IIY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rqJ13YkrfipuSfjMOGazz1lz/9VyakIECNmKvg6dh5pi4CEHt916QdOIcXL1SnBcuqNN7PNs6dcWUw0LnjR08weNDYrxqKG5P7dZX5Fhap7HDsDq/eDvU43zQrTcr0X0KZRUUylTwjFg2pMRjISqwZKWdbkNmidLSC58txdWZkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNBxkVaU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC74BC4CEE7;
	Thu, 18 Sep 2025 10:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758193137;
	bh=LL/Uw6VE1EBTQfjT9hHDOnQ6gjK5F3ud8EjZ7zF1IIY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tNBxkVaUZNfgfAzmWty8ZnFuWL4PXG2UJIyez+aRdN8N791hD7mlow51DFOl/8ciN
	 IbUAjgY+NxL+0GblSmQumlQEWNMOSGLin+I+Qo91w4a7ldsAN/RO/1zYyxqMyXCAsn
	 1abM2gM7GpRXaHX1BrkaK0w8w8aFTx5rOk5vKrap+grPUBaYRamVd4OOwWPBI1POFr
	 hDswyR2HkfczjReuAnSVJpeASpsFRjx8qbUgz+RMmyHPH9guJ43p/4nkpFBTHGjY42
	 HlYkaloVBbCVNOcGFLY6XhLnzow3XITAwdBnlcTMrg4yOrmaw160KUG3Tz47qFjy+a
	 k/L1Xt4kuONtw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A16CAC5A8;
	Thu, 18 Sep 2025 10:58:57 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?= <devnull+j.ne.posteo.net@kernel.org>
Subject: [PATCH v2 0/2] Initial Amediatech X96Q support based on Allwinner
 H313
Date: Thu, 18 Sep 2025 12:58:42 +0200
Message-Id: <20250918-x96q-v2-0-51bd39928806@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOLly2gC/zXMSw7CIBSF4a00dyyGRx/gyH2YDtDe2juBCoTUN
 OxdrHH4n5x8O0QMhBEuzQ4BM0XyroY8NfBYrHsio6k2SC47boRgm+lfrBuwV0pzzVuEel0DzrQ
 dzG2svVBMPrwPNYvv+gfkD8iCcabbQUzWzspM9+vqY0J/dphgLKV8ABL5JE+ZAAAA
X-Change-ID: 20250911-x96q-57e63380804e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758193136; l=1208;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=LL/Uw6VE1EBTQfjT9hHDOnQ6gjK5F3ud8EjZ7zF1IIY=;
 b=b8FZND3HZqDv0aMwfb+6qib/2eYbxutllyTSOaHscNvnojhJl4jYWwTmXgAGP3vddNoNTaqKs
 JjrhlLVOWdXCExdZ5LQB51ANHIyoWqR/qMs616ntY3FzhUaJ/sRWzHQ
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with
 auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Reply-To: j.ne@posteo.net

This patchset adds an initial devicetree for the X96Q set-top box.
WiFi, Ethernet, and HDMI depend on drivers that are currently not
available in mainline Linux, and I didn't even get the SDIO WiFi chip to
enumerate, so I left these peripherals out of the in the devicetree.

The builtin infrared receiver produces IRQs when a nearby remote sends
events, but they somehow don't end up in /dev/input/event0.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v2:
- Several dts improvements thanks to Andre Przywara's review
- Andre's Reviewed-by tag for the binding
- Link to v1: https://lore.kernel.org/r/20250912-x96q-v1-0-8471daaf39db@posteo.net

---
J. Neuschäfer (2):
      dt-bindings: arm: sunxi: Add Amediatech X96Q
      arm64: dts: allwinner: h313: Add Amediatech X96Q

 Documentation/devicetree/bindings/arm/sunxi.yaml   |   5 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-h313-x96q.dts | 230 +++++++++++++++++++++
 3 files changed, 236 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250911-x96q-57e63380804e

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>



