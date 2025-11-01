Return-Path: <linux-kernel+bounces-881181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFF6C27A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9BA1A23E00
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447DA2765DF;
	Sat,  1 Nov 2025 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VOCQm3gZ"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69E28506C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761987835; cv=none; b=a0MaRRMopwaNbX/CeCuPPHqk8R+7emdfszIGZvN3O9/sTEosDjNSKMd8D6VJCKNLHamdbW7VPuNnCMAE6xLD8rBKbpmzk4ZIGQn6bN50f2Pn1uBYUYzLb73gN/zequ44wXuuu8nT0kwEawj9ZUCELDasvOqdE/beN0Ronr86Okk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761987835; c=relaxed/simple;
	bh=BNDOpTBqIHfhN5s3DzIpQb6oNVZm3V416PNj1AzPqUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=de5nXa4tEdXqki5p5qZiLqhHW+Dd0Q7u+JZ+s+qbBGKJUwYkwlkZWkGZvWryLc71CxbbFAlMTedk7wFe+jDZOWezXEy6Dv/3+65ZmaxPOd2HU8MbfPSui8JILhUOzc5181PdFYiDD88zY4qDPhztXOvLUDwd+aaxecQ6h2d1HDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VOCQm3gZ; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761987822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9g4umT06lYMRrIWBhnN/oX2rBXZTFT6Aq7ZWIZM3zcc=;
	b=VOCQm3gZpSHROT2ogm8w86JEYICDHuulZ/v8UhYPtaF++QGfa2DSyFc37YeRojlZ4iqgaT
	UP8HiPHge1xstoNWZkRwmXL9YNo9uoM8iGe6EtVLy/0/A+IzMgxu4lMHyMPTwgg2O8/RED
	WKyohW/8Qa61+H2I6aCjfXWX0nH9Hj0=
From: Ze Huang <huang.ze@linux.dev>
Subject: [PATCH 0/3] riscv: dts: spacemit: Add USB 3.0 support for K1
Date: Sat, 01 Nov 2025 17:03:24 +0800
Message-Id: <20251101-k1-usb3dts-v1-0-dd2660e5740b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANzMBWkC/yWNwQ6CMBAFf6XZsyUtVQrEGP/DcChlq40C2i3Eh
 PDvVjjOS97MAoTBI0HNFgg4e/LjkEAeGNiHGe7IfZcYcpGfpFCCPyWfqFVdJO5KzF2rKlfqCtL
 hHdD57ya7NTsH/EzJGfcRWkPI7dj3PtZsLjJZ8mDl/9sjkdlqNTvvMallJfRRZEoUuhRccnx1G
 K7Bk6VoQpZEF2jW9QcQGBA1xQAAAA==
X-Change-ID: 20251030-k1-usb3dts-f8e2fb39f879
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Ze Huang <huang.ze@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761987811; l=1820;
 i=huang.ze@linux.dev; s=20250705; h=from:subject:message-id;
 bh=BNDOpTBqIHfhN5s3DzIpQb6oNVZm3V416PNj1AzPqUQ=;
 b=1byT/ixmKTzrTCZvS/cB4k0sP1v8oeqKfXPzsLpQlo6hJLNh8axUbETazb6yxaD+mnu+bJAvi
 Q6qCzqKoMAaCg76bUIEgvtCNq0mqC/j7jSlk4wdYilujHQH2FlkgVO2
X-Developer-Key: i=huang.ze@linux.dev; a=ed25519;
 pk=Kzc4PMu5PTo8eZZQ5xmTNL9jeXcQ9Wml0cs+vlQpBkg=
X-Migadu-Flow: FLOW_OUT

This patch series enables the DWC3 USB 3.0 host controller on the
Spacemit K1 SoC, and enables it for the Banana Pi F3 board.

To make USB 3.0 work on the K1, we need patches for the USB2 PHY [1],
ComboPHY [2], and DWC3 [3] driver, also, ensure enabling the following
configurations:

CONFIG_PHY_SPACEMIT_K1_USB2=y
CONFIG_PHY_SPACEMIT_K1_PCIE=y
CONFIG_USB_DWC3=y
CONFIG_USB_ONBOARD_DEV=y

The series is based on v6.18-rc1.

Link: https://lore.kernel.org/all/20251017-k1-usb2phy-v6-0-7cf9ea2477a1@linux.dev/ [1]
Link: https://lore.kernel.org/all/20251017190740.306780-1-elder@riscstar.com/ [2]
Link: https://github.com/torvalds/linux/commit/e0b6dc00c701 [3]

Thanks,
Ze Huang

Signed-off-by: Ze Huang <huang.ze@linux.dev>
---
Ze Huang (3):
      riscv: dts: spacemit: Add USB2 PHY node for K1
      riscv: dts: spacemit: Add DWC3 USB 3.0 controller node for K1
      riscv: dts: spacemit: Enable USB3.0 on BananaPi-F3

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 47 +++++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1.dtsi            | 32 +++++++++++++++++
 2 files changed, 79 insertions(+)
---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251030-k1-usb3dts-f8e2fb39f879
prerequisite-message-id: <20251017190740.306780-1-elder@riscstar.com>
prerequisite-patch-id: e6c36ae11fd6bb6238b3f256221856869db6958c
prerequisite-patch-id: b7bf3a95a8baaea88d776db7d9e46ced879187a1
prerequisite-patch-id: 893145648925a17c16a5de55bd6952f18e8b7d8e
prerequisite-patch-id: cd96cd9ae2fb4a1f73d34046952dad346823f80d
prerequisite-patch-id: 0baa531df5c47ffe9354ac3885e89bda9ae9b282
prerequisite-patch-id: 3beea086bdfd0ce6ffd011a8906319b1ba253c9c
prerequisite-patch-id: 755e4f791e363ab2f0ac0a4459d0cfd289123800

Best regards,
-- 
Ze Huang <huang.ze@linux.dev>


