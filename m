Return-Path: <linux-kernel+bounces-752656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E9BB178EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4612E7AE481
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BF826C398;
	Thu, 31 Jul 2025 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLJcqY90"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D8519DF62;
	Thu, 31 Jul 2025 22:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753999960; cv=none; b=t1hc39BYITiodsf6b2c9JN9SMVkPA9tnKKSEXW5THX9qbS3vP6x0WL1V9N1XBvjfxvkHVjMgNxEtG46bkZkYMGtMrxAo+6cM7UaHxmz5hjruHvY2ZUhtf56hL8LR6bw+3PuV2Wlv3IqECS/ZyFgIrjhAYkuPMES+2QUZJ29osBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753999960; c=relaxed/simple;
	bh=dGSihHIH6s1bKpn+VJDgTQDiIrWhwFA7/h+sIJx6jwg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=D5dL72ad7E5K49e73N/tzdOcu2Y7G8WWrxFiBOKR+nXjf01aNO9xzssUBp774rbkgMsIlsNpKUvDWlU2JtaQYrI6hTabIe9bN88fQ+RF/Ah1S5odHiVKR/PsFFHN+/GDRJC5es+FcJiLP2vuLVp2wkKMm+13BmXPiLW17d0hr9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLJcqY90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A0CC4CEEF;
	Thu, 31 Jul 2025 22:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753999960;
	bh=dGSihHIH6s1bKpn+VJDgTQDiIrWhwFA7/h+sIJx6jwg=;
	h=From:Subject:Date:To:Cc:From;
	b=oLJcqY90eQJdOq4+ZVdz9zCLTXxY9bYXetWN3wruycZl68Vv8gOinkMD1NxlUtUU7
	 KKZdgufnrqxghzfCIpcVsP3a4SUL2gkcBcukTJZTEj+TmrSU4/PCG1awNmtn5dsfwy
	 MQNiKrUxOePQXuomTAgaRPMUZCjAaSS+ARkk8dc49O91FthtGs1ySu4P+hycZIzoWw
	 yJwRvZFKpTm8rpsTb9Ayip8A8O1z697Wp/1bZACv9Pq7uqzrOUGwkXbjCRgaCpD/Hs
	 DipIW8Hnun2M+qLnJ1C338nHAPVgDVH0+SoM+e1SA7/1/YEf+h+MhLZLm1EhasDVH7
	 9ZVX0dE4D+2Mw==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/6] ASpeed FSI DT clean-ups
Date: Thu, 31 Jul 2025 17:12:17 -0500
Message-Id: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHqi2gC/x3MMQqAMAxA0atIZgNtRQWvIg5qEw1IlUZFKN7d4
 viG/xMoRSGFrkgQ6RaVPWTYsoB5HcNCKD4bnHG1aSuL/kRWwXmjMVyHInvrTVPzZNlAro5ILM9
 /7If3/QC+DbP4YQAAAA==
X-Change-ID: 20250731-dt-fsi-cleanups-fd1d065fb1f0
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Eddie James <eajames@linux.ibm.com>, Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org
X-Mailer: b4 0.15-dev

There's a whole bunch of FSI related DT warnings on ASpeed platforms. 
This series fixes most of them except some related to SBEFIFO.

The remaining SBEFIFO warnings are from some deprecated properties noted 
with 'remove when userspace is fixed'. Not sure if they can be removed 
now or soon. If not, perhaps the deprecated properties need to be 
properly documented.

All the patches here are independent, so DTS changes can go via ASpeed 
tree and FSI bindings via FSI tree (or ack if you want me to take the 
bindings instead).

Rob

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (6):
      ARM: dts: aspeed: Drop "no-gpio-delays"
      ARM: dts: aspeed: Drop "fsi-master" compatibles
      ARM: dts: aspeed: Add missing "ibm,spi-fsi" compatibles
      MAINTAINERS: Add FSI bindings to FSI subsystem entry
      dt-bindings: fsi: Convert fsi-master-gpio to DT schema
      dt-bindings: fsi: Convert aspeed,ast2400-cf-fsi-master to DT schema

 .../bindings/fsi/aspeed,ast2400-cf-fsi-master.yaml | 81 ++++++++++++++++++++++
 .../devicetree/bindings/fsi/fsi-master-ast-cf.txt  | 36 ----------
 .../devicetree/bindings/fsi/fsi-master-gpio.txt    | 28 --------
 .../devicetree/bindings/fsi/fsi-master-gpio.yaml   | 63 +++++++++++++++++
 MAINTAINERS                                        |  1 +
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts | 24 ++++---
 .../boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts |  3 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts |  3 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts    |  2 +-
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts |  3 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts  |  2 +-
 .../boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |  2 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |  4 +-
 arch/arm/boot/dts/aspeed/ibm-power10-dual.dtsi     | 12 ++--
 arch/arm/boot/dts/aspeed/ibm-power10-quad.dtsi     | 12 ++--
 18 files changed, 188 insertions(+), 94 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250731-dt-fsi-cleanups-fd1d065fb1f0

Best regards,
--  
Rob Herring (Arm) <robh@kernel.org>


