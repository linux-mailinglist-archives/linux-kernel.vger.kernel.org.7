Return-Path: <linux-kernel+bounces-815848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE0B56BD3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06963AE114
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045A2E1EE0;
	Sun, 14 Sep 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="XVpu1fpk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mh1X2mgI"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B761FCE;
	Sun, 14 Sep 2025 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757878737; cv=none; b=Y1lPQjvEhEawxCGGHncBRBChuaSSXgLjK08SKcRXrLeUD3l9+C/iQZCyP7KxmVB5jj2w7oUsM06UwIohI5do5VHiZFrVsRqN9qXn4a45eIbzTfmgnyyKuABb0vf9BImE24QGDcono+m6cHQlxMWyEOfP5+Art4YlUwfQ5myIq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757878737; c=relaxed/simple;
	bh=cUkvxMc1z2FUP8/ZLqz9qQHCc2lZtpnUyN61yW93mXU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lgja9or+JIHQgM4dkqi7tnJYjToy8KtrLR+Jzn5yYCfxMylYlz+2z4mQ1YtcJzG1U2Knqa6JiO9PQ2UNpOEyEL5Y/Dt8Mj/a8XYoSrLz7uPYEqPjYzVtxfpEq/l7FbFqdRZJF27Qm//kYZNkFz9ZADR69uSkOv41KduXC6SNNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=XVpu1fpk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mh1X2mgI; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECA3A7A0129;
	Sun, 14 Sep 2025 15:38:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 14 Sep 2025 15:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1757878732; x=1757965132; bh=9o
	b3+l+1f9IP3Uc7NeallE4LkO03rIbLfuv4476RPcQ=; b=XVpu1fpk7uG/ZP3obd
	r8+y6Ts0QQDe6l3zxRBt7Q2pqT7A1BB1jKIXa8qGE8rS3EIyZBdqwNXHOchezRiQ
	YCKButws4u65Wp32GE6yaLTgJoQRfV8tSVmlOeKNy+zDNKHuFQ3uiET5HBCAqFAM
	HqEesA7XLfW5PveNncDsyePsf8oNeCh3mCj2H2VONVvncRPcorP9sGMafq4SL5F7
	QERFgeqbHdgGifntm5GEr5kNSCMbTUUp60Kb6zA9FmpRaycysBTB6GTeK245kbaR
	LNoobBz9Pl6CktgDPWLkmFfOpWLSsRsqgjg+bx2NXVeks4soddbakrvqd07U4uZJ
	Kl7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1757878732; x=1757965132; bh=9ob3+l+1f9IP3Uc7NeallE4LkO03
	rIbLfuv4476RPcQ=; b=Mh1X2mgIsk0zOsXQx3JQcC9gqW0wsXNcvRkNnrlVzw6i
	uX6iWl8tEOtkXB53qrqAvx9PToSvYlJQeadAy7vyD4ekpt4SPt/+kNBTvCS0AYv8
	lHgFtq1SOTEtoe01OM8K96W0VIELYclOonjXx3f4t1UXksgCajYyUp74ft/PQPCO
	Cp3maXXTB5Tgrs+8wHNsfG2vqlDGB0D8VGRiD5FEJruYfNWDhHCIEWPBnfuwBZd/
	kTC79GwUzeMprVp6gTzvblOjkAH/F0sNTbM/hIfq8p441qt2VzPLjl27ZsJR8gKW
	bm4g5E43LmAqMEX3zYVEw429UvjuMh/Z/RgnHy24SQ==
X-ME-Sender: <xms:zBnHaKHTW0q1s9SFeBvGzOT-J4U2BkK8qQwJ82YUVvXdDBYvkWl_Sg>
    <xme:zBnHaLdSYyIJ-kljZECBmeqcJSau-87d70vM-NkbCkJ1XwSjF1IayqaRxDVdEgX6v
    oy5WKzXdDRbjh9AH2Y>
X-ME-Received: <xmr:zBnHaLm2g1qn8biWb7BGXsoUCzu2uxXkqBQhSFUyfN0cIDaJOr7Q3CAnvYbVjPnmSHap9tTtWR_P8Fxs8WbOyV6DNGKzLPi_RJ-CaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefheeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
    uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefhjeethe
    ejffetuefhjeetgeegveelleeltdfhgfetieegudelteehhfejveffleenucffohhmrghi
    nhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgs
    pghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohgshh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhr
    tghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtoheprghsrghhiheslhhish
    htshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgv
    lheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmrgiisehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhi
    sehlihhnrghrohdrohhrghdprhgtphhtthhopehsvhgvnheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zBnHaKqikW0vmKgbAfERI-K53piFSlS9r9U-w4dW-d2fXA_N-5cPCA>
    <xmx:zBnHaIEiRvs-Wz5zs2i9XBHer96afvOVvJ1Cqae67QjEOI_XAxAJVQ>
    <xmx:zBnHaASc80BvbOv-rOnT285Y7eHU_Ef1NmUeXRcb52vq6d_Ve44nZQ>
    <xmx:zBnHaON4PwWvo808Z1Uyu_MgFKQS_k5ID3AdJAvXh8S0uOgc93D6rQ>
    <xmx:zBnHaA0kq46KPksJlY5JqsuDnIec6_D6w4QGX2RmTCGF0EqpcjOxj0Dt>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 15:38:51 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 0/6] arm64: Add initial device trees for Apple M2
 Pro/Max/Ultra devices
Date: Sun, 14 Sep 2025 21:38:43 +0200
Message-Id: <20250914-dt-apple-t6020-v2-0-1a738a98bb43@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMMZx2gC/12Nyw6CMBBFf4XM2jFtBXms/A/DopRBakypbWk0h
 H+3oomJy3OSe+4CnpwmD022gKOovZ5MArHLQI3SXAh1nxgEEwWrOMc+oLT2RhiOTDDkh6JWVHe
 DoBLSyDoa9GMLntsPO7rPqRt+ctQ+TO65nUb+tt++qP77kSPDgpWdzFXe1RWdrtIYOe8NBWjXd
 X0BUFl+ycIAAAA=
X-Change-ID: 20250811-dt-apple-t6020-1359ce9bf2e7
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Marc Zyngier <maz@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6369; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=cUkvxMc1z2FUP8/ZLqz9qQHCc2lZtpnUyN61yW93mXU=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhozjkidn3RO+ZS1w/Of7n+tvPZi+KHfrkUuhi0q8dTZPN
 lLYt1dodkcpC4MYF4OsmCJLkvbLDobVNYoxtQ/CYOawMoEMYeDiFICJpMsyMnzwvbNXJ0zb4lWL
 iuxc1dqI0H/HV3jabP1kfMeP9fMGo52MDPdPhesv625NTbdyX2Erbewl84G38v5MPi7xZMF7zXd
 bWQE=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

This series adds device trees for Apple's M2 Pro, Max and Ultra based
devices. The M2 Pro (t6020), M2 Max (t6021) and M2 Ultra (t6022) SoCs
follow design of the t600x family so copy the structure of SoC *.dtsi
files.

t6020 is a cut-down version of t6021, so the former just includes the
latter and disables the missing bits.

t6022 is two connected t6021 dies. The implementation seems to use
t6021 and disables blocks based on whether it is useful to carry
multiple instances. The disabled blocks are mostly on the second die.
MMIO addresses on the second die have a constant offset. The interrupt
controller is multi-die aware. This setup can be represented in the
device tree with two top level "soc" nodes. The MMIO offset is applied
via "ranges" and devices are included with preprocessor macros to make
the node labels unique and to specify the die number for the interrupt
definition.

The devices itself are very similar to their M1 Pro, M1 Max and M1 Ultra
counterparts. The existing device templates are SoC agnostic so the new
devices can reuse them and include their t602{0,1,2}.dtsi file. The
minor differences in pinctrl and gpio numbers can be easily adjusted.

With the t602x SoC family Apple introduced two new devices:

The M2 Pro Mac mini is similar to the larger M1 and M2 Max Mac Studio. The
missing SDHCI card reader and two front USB3.1 type-c ports and their
internal USB hub can be easily deleted.

The M2 Ultra Mac Pro (tower and rack-mount cases) differs from all other
devices but may share some bits with the M2 Ultra Mac Studio. The PCIe
implementation on the M2 Ultra in the Mac Pro differs slightly. Apple
calls the PCIe controller "apcie-ge" in their device tree. The
implementation seems to be mostly compatible with the base t6020 PCIe
controller. The main difference is that there is only a single port with
with 8 or 16 PCIe Gen4 lanes. These ports connect to a Microchip
Switchtec PCIe switch with 100 lanes to which all internal PCIe devices
and PCIe slots connect too.

This series does not include PCIe support for the Mac Pro for two
reasons:
- the linux switchtec driver fails to probe and the downstream PCIe
  connections come up as PCIe Gen1
- some of the internal devices require PERST# and power control to come
  up. Since the device are connected via the PCIe switch the PCIe
  controller can not do this. The PCI slot pwrctrl can be utilized for
  power control but misses integration with PERST# as proposed in [1].

This series depends on "[PATCH v2 0/5] Apple device tree sync from
downstream kernel" [2] due to the reuse of the t600x device templates
(patch dependencies and DT compilation) and 4 page table level support
in apple-dart and io-pgtable-dart [3] since the dart instances report
42-bit IAS (IOMMU device attach fails without the series).

Both dependencies are in next and queued for the 6.18 merge window in
https://github.com/AsahiLinux/linux/commits/apple-soc/dt-6.18 and
https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/log/

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatibles anymore [4]. Instead either the first
compatible SoC or t8103 is used as fallback compatible supported by the
drivers. t8103 is used as default since most drivers and bindings were
initially written for M1 based devices.

[1]: https://lore.kernel.org/linux-pci/20250819-pci-pwrctrl-perst-v1-0-4b74978d2007@oss.qualcomm.com/
[2]: https://lore.kernel.org/asahi/20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net/
[3]: https://lore.kernel.org/asahi/20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net/
[4]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

---
Changes in v2:
- Fixed copy-n-paste errors still referencing t600x (M1 series)
- Reworded outdated comments
- Dropped all dt-binding changes except "dt-bindings: arm: apple: Add
  t6020x compatibles" as those were picked up in apple-soc/drivers-6.18
- Dropped all driver changes, will be sent separately if not already
  picked up
- rebased onto https://github.com/AsahiLinux/linux/commits/apple-soc/dt-6.18
- Link to v1: https://lore.kernel.org/r/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net

---
Hector Martin (3):
      arm64: dts: apple: Add initial t6020/t6021/t6022 DTs
      arm64: dts: apple: Add J414 and J416 Macbook Pro device trees
      arm64: dts: apple: Add J180d (Mac Pro, M2 Ultra, 2023) device tree

Janne Grunau (3):
      dt-bindings: arm: apple: Add t6020x compatibles
      arm64: dts: apple: Add ethernet0 alias for J375 template
      arm64: dts: apple: Add J474s, J475c and J475d device trees

 Documentation/devicetree/bindings/arm/apple.yaml |   39 +-
 arch/arm64/boot/dts/apple/Makefile               |    8 +
 arch/arm64/boot/dts/apple/t600x-j375.dtsi        |    1 +
 arch/arm64/boot/dts/apple/t6020-j414s.dts        |   26 +
 arch/arm64/boot/dts/apple/t6020-j416s.dts        |   26 +
 arch/arm64/boot/dts/apple/t6020-j474s.dts        |   47 +
 arch/arm64/boot/dts/apple/t6020.dtsi             |   22 +
 arch/arm64/boot/dts/apple/t6021-j414c.dts        |   26 +
 arch/arm64/boot/dts/apple/t6021-j416c.dts        |   26 +
 arch/arm64/boot/dts/apple/t6021-j475c.dts        |   37 +
 arch/arm64/boot/dts/apple/t6021.dtsi             |   69 +
 arch/arm64/boot/dts/apple/t6022-j180d.dts        |  121 ++
 arch/arm64/boot/dts/apple/t6022-j475d.dts        |   42 +
 arch/arm64/boot/dts/apple/t6022-jxxxd.dtsi       |   38 +
 arch/arm64/boot/dts/apple/t6022.dtsi             |  349 ++++
 arch/arm64/boot/dts/apple/t602x-common.dtsi      |  465 +++++
 arch/arm64/boot/dts/apple/t602x-die0.dtsi        |  575 ++++++
 arch/arm64/boot/dts/apple/t602x-dieX.dtsi        |  128 ++
 arch/arm64/boot/dts/apple/t602x-gpio-pins.dtsi   |   81 +
 arch/arm64/boot/dts/apple/t602x-j414-j416.dtsi   |   45 +
 arch/arm64/boot/dts/apple/t602x-j474-j475.dtsi   |   38 +
 arch/arm64/boot/dts/apple/t602x-nvme.dtsi        |   42 +
 arch/arm64/boot/dts/apple/t602x-pmgr.dtsi        | 2265 ++++++++++++++++++++++
 23 files changed, 4515 insertions(+), 1 deletion(-)
---
base-commit: eef7336dc6c11f80c08b55b09b24faf124baeb0d
change-id: 20250811-dt-apple-t6020-1359ce9bf2e7

Best regards,
-- 
Janne Grunau <j@jannau.net>


