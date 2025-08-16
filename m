Return-Path: <linux-kernel+bounces-771681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B73B28A47
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F245A828E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56B41B0F11;
	Sat, 16 Aug 2025 03:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="hmS8pZ++"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F917A2F6;
	Sat, 16 Aug 2025 03:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755315261; cv=none; b=MhjgJ6wLczi3nZcSqdt/cnAdrQEzDL+Bg65Rj5iR56iLiSJp/O7x0I9g28EqZJojYku+bYQaZFo6Qet93eS2JcfS9TqzTUw6TnWdR72hdI+eZwJyoFgEwyRtD6HTyToMHT12dpugjUlhVaQVdB/PvXC7GVvS93R0EED2Iexqp0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755315261; c=relaxed/simple;
	bh=N/oqJn4ZvxNNFoCwA259VuHk2vtLCnNsRDlcE0nBqtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHiInPUsj7f3PNkfjLrGlls483z8FER2bdpkuozdrK1KWzBHoKazwtEHLsNVjJMxMFJvZBvuu+TtvaFP4N2Z6IjJMmERswoeKtkrFDBGfVmbu/jMJB4kmuc4rlRXEvWP/OSb1BRbINnxWgz7jt3BG3cEmEke1XTLh+wwShjKIFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=hmS8pZ++; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id AD8EC25E27;
	Sat, 16 Aug 2025 05:34:15 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FQXJYJxO1B6p; Sat, 16 Aug 2025 05:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755315254; bh=N/oqJn4ZvxNNFoCwA259VuHk2vtLCnNsRDlcE0nBqtU=;
	h=From:To:Cc:Subject:Date;
	b=hmS8pZ++BVZsO/z9DTcDa7fA3JNsaWGb8+W6b2snuaYetaqdCQiZfCtB6I6ai6Sq0
	 M1NuAAwf/+1dZuq9C+qX2rCC0wybSv1itsPO7cGAtW6BfrL/cd9JS5GBydzNo4O+Px
	 NRySM0fGRtmLvNvX3ukkWtzAfaobTL/FuYy1BMQfBPZLiDzvzVnGGudVUjOpOCCJhA
	 2Zv848mu1+BtQ0nAtm/RrrHtNCFuyDSXZVCLGG1bDob7+a3Bxq9Z4tk7QcGGKtncGW
	 aW1j+Si91lfSABlFit7Qu1J7JfSqHauBlgHYjJdmhNbGG46/Jo2u4TYIeCYjosIW9s
	 KJiyaVC5uCgJg==
From: Yao Zi <ziyao@disroot.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 0/3] Support reset controller of Loongson 2K0300 SoC
Date: Sat, 16 Aug 2025 03:33:25 +0000
Message-ID: <20250816033327.11359-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different from previous Loongson SoCs, 2K0300 integrates a reset
controller that provides reset signals represented by contiguous,
distinct register bits for almost every SoC function block. This series
adds its dt-binding and implements its support through reset-simple
driver.

Reset functionalities are tested with UARTs and GPIO module, it's
verified the module won't work with the corresponding reset asserted.

The devicetree patch (PATCH 3) depends on series "Support pinctrl for
Loongson 2K0300 SoC" for a clean apply. Thanks for your time and review.

[1]: https://lore.kernel.org/all/20250811163749.47028-2-ziyao@disroot.org/

Yao Zi (3):
  dt-bindings: reset: Document reset controller of Loongson 2K0300 SoC
  reset: simple: Support Loongson 2K0300 SoC
  LoongArch: dts: Add reset controller for Loongson 2K0300

 .../reset/loongson,ls2k0300-reset.yaml        | 35 ++++++++++
 arch/loongarch/boot/dts/loongson-2k0300.dtsi  | 17 +++++
 drivers/reset/reset-simple.c                  |  2 +
 .../reset/loongson,ls2k0300-reset.h           | 70 +++++++++++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/loongson,ls2k0300-reset.yaml
 create mode 100644 include/dt-bindings/reset/loongson,ls2k0300-reset.h

-- 
2.50.1


