Return-Path: <linux-kernel+bounces-782983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02938B32800
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A83843ADAF9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313B423E352;
	Sat, 23 Aug 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="fHpnSRRC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cezUg/Po"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00271E51FA;
	Sat, 23 Aug 2025 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755942594; cv=none; b=I6EFT/8hiOAyr+AoOn5hewPOg3CFET3Fs1t7HZFLtSBJ7XcsKah9zEYx74SQ5SnSValmuo8v2f9J5TM6MaYJvJBJ3QfSvKF7PeRht8IRrAoxpq7FZOvppEq2UZIIB5++iXD4D2Yvm4G7x07RAY0UGdLiJnFWczIv5EEMLKEA30s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755942594; c=relaxed/simple;
	bh=wXnxizWwkszTat9AweecGcJnROVya1QAB6nbCu02L5I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PjfKWLJuf3/MKardZ5lRyL/QtNBEXQBR2UMfKDH9xHFQhJTnzvQI4Ab+8V5JbdzaAdj7ZztgM89jwaG34qnRuI5suXVwmTeLNkfN+XKhnTOuaboSTrdNCmJnRCdYjhaxjoaBwcNCcNFZoN+rJrI+sQwNPYbGzawwKTcycPfxASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=fHpnSRRC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cezUg/Po; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BB72A1D00088;
	Sat, 23 Aug 2025 05:49:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 23 Aug 2025 05:49:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1755942589; x=1756028989; bh=bm
	kOGDbZuHb+4/T8LqP7nmd61o+/4jaly+x5FDNGBwk=; b=fHpnSRRCjuGFsi9rO2
	Z6NcFhBpITWA495+M+3PSznWk5iqhWM6J5fuePnLsOxlTfZHp9R7XjR2jSwlG1fY
	kkSHyru1wiWYeSvr1V+Eku3hxNcBtaROvr0wo/8djMhSusah7YoycvVndMPBzIMW
	aTZ9shLxij3cDryAVmOWici5MpjC6gDkQOucgIc8nUgeuOy1q/nzGBauGLHbxyLi
	ZkB8ZXsEUHT4HbywLtJMRJtlA8yRSaKZ2dKfp7iCVHwy3nSUbqzUrA171/WsiMNp
	dDXJiYYQHcWLk6oAygvhaEde7p5lDwHBJd4PAh5v0j7QKFHqItZcreMPI9aVpIXv
	GVxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755942589; x=1756028989; bh=bmkOGDbZuHb+4/T8LqP7nmd61o+/
	4jaly+x5FDNGBwk=; b=cezUg/Pok3jq0Shzd7ZIEoJ0szKKmPSv3OSfvrEi6U86
	kRvtrhSxx0L4q0kHUTsSB2i6qQcAMwzSIamR+Z1R7/5SWPTkYGtiDY0XoISm18+t
	+0HIvGHcnYZsAugeKBbdze4sr9JmWheDds59mFBM1frUMT0J8/osmL7kCnGSKCtO
	cNqOUzPOJJ34pLOLZv9nbHqwcaz8mIZ16WFPgQw/iC+lQ5J74UmPIsfprWkN97f2
	wh+HBdnhpoVnHxCeum5RgGhQd9u2EpRMswiP5eYChKpgCBc+3rfBNRpLdcPLkCxE
	daW4GzF/O6bNO/H+Sa7eXNxqXLUEV2dNYnbmTHSU+w==
X-ME-Sender: <xms:vI6paFHdsxIzH6bHiuGgKH26qk7X2u75b0t9q9vRS1b0PoEnflp4lw>
    <xme:vI6paBlPj5upxrTpPcBoaF8M0J6k1PNPMjhoAnZtVGaw08ioQgJJPscSfPvxN3OMw
    RM_UFOtjKMbu0vwLhk>
X-ME-Received: <xmr:vI6paCBrocZcFghRChOpdcCPk8g3Ae3qKtEkotuGQz45SFDjEmdP68ppEzX9oxZmjOhlxNljQ2k4TdSeS_UT4yNMSiiBBeAJyRMa9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeifedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepueelgf
    fhfedvgeelfeduuefhfefhjeeihfffueefjeeihffhheeuteeuvdeuhffhnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvthdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghtthgvnhhishesohhpvghnsghs
    ugdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdought
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhgrrhgtrghnsehmrghrtggr
    nhdrshht
X-ME-Proxy: <xmx:vI6paLDk4zmdnUxlfV1AZmqMJ--2Ggr1941uzcaBP26d0l-HMPdnqg>
    <xmx:vI6paBG-3HWT9BNKiKpPY_XKV3xHurvAc-r8vH10Sl5cRtWPN4E3Lw>
    <xmx:vI6paK7G51l3NqWzuR1d6wVe2VrtM1MTHV6gyzeOUU3oxGKnwH0qcg>
    <xmx:vI6paARseNFcebZYtM37iHbgWbtvsyou4j8xuX6XUJRt1lZhVyEjBg>
    <xmx:vY6paCANtR_nHA5HS_4-dd0OryT0DIoLUwlHUwLiuKwYFlGjnUPcCoxp>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 05:49:47 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 0/5] Apple device tree sync from downstream kernel
Date: Sat, 23 Aug 2025 11:49:43 +0200
Message-Id: <20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALeOqWgC/32NQQ6CMBBFr0Jm7ZhODQKuuIdhMWmnUmMKaZFIS
 O9u5QAu30v++zskiV4S3Kodoqw++SkU0KcKzMjhIehtYdBK16qlC/I8vwTtgmkLBq9IDVpyhkz
 bucYwlOEcxfnPEb0PhUeflilux8dKP/s3txIq1KpzVFtSzKp/cgj8PgdZYMg5fwG5KnogtQAAA
 A==
X-Change-ID: 20250813-apple-dt-sync-6-17-d1fc1c89f7ca
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2698; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=wXnxizWwkszTat9AweecGcJnROVya1QAB6nbCu02L5I=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoyVfTtjZHV4Dizd+CMn68Jxo5sTt1Yf2Okb72Fx8JvTl
 Cv5Wh/ZOkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEyk8QgjwwYdsZvR/Lc+HxQR
 Sr/n/a92aniE+Iq6Gc5NJw+vlg4+/4vhf8gJveRD/9oLg7heJH728ExsmRMXLaNx9Hret9uOPwN
 2cgEA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

This series pulls changes from the downstream device trees which are
supported in upstream kernel.
Most importantly it fixes the PCIe description for a specific iMac model
(iMac M1, 2 USB-C ports, 2021). This is worked around in the downstream
kernel by not disabling the port. In preparation for submitting M2
Pro/Max/Ultra devices trees I investigated the issue on the similarly
affected M2 Pro Mac mini and fixed it this way.
It completes the Wlan/BT device nodes for t600x based devices and adds
the missing 15-inch Macbook Air (M2, 2023).

Checkpatch emits following warnings:

WARNING: DT compatible string vendor "pci14e4" appears un-documented --
check ./Documentation/devicetree/bindings/vendor-prefixes.yaml

Which I chose to ignore. `vendor-prefixes.yaml` prefixes contains no
other mapping for PCI vendor code and the list of ignored prefixes
forbids extending it. Both options feel wrong though. "pci${vendor}" is
clearly a vendor prefix but duplicating the PCI vendor data base feels
wrong. `vendor-prefixes.yaml` currently does not contain and PCI vendor
aliases.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- fixed commit subject of PATCH 2/5
- correct Macbook Pro (15-inch, M2) to Macbook Air
- added Neal's and Sven's Rb: tags
- Link to v1: https://lore.kernel.org/r/20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net

---
Hector Martin (2):
      arm64: dts: apple: t600x: Add missing WiFi properties
      arm64: dts: apple: t600x: Add bluetooth device nodes

Janne Grunau (3):
      arm64: dts: apple: t8103-j457: Fix PCIe ethernet iommu-map
      dt-bindings: arm: apple: Add t8112 j415 compatible
      arm64: dts: apple: Add devicetreee for t8112-j415

 Documentation/devicetree/bindings/arm/apple.yaml |  2 +
 arch/arm64/boot/dts/apple/Makefile               |  1 +
 arch/arm64/boot/dts/apple/t6000-j314s.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6000-j316s.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6001-j314c.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6001-j316c.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6001-j375c.dts        |  8 +++
 arch/arm64/boot/dts/apple/t6002-j375d.dts        |  8 +++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi   | 10 +++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi        | 10 +++
 arch/arm64/boot/dts/apple/t8103-j457.dts         | 12 +++-
 arch/arm64/boot/dts/apple/t8112-j415.dts         | 80 ++++++++++++++++++++++++
 12 files changed, 161 insertions(+), 2 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250813-apple-dt-sync-6-17-d1fc1c89f7ca

Best regards,
-- 
Janne Grunau <j@jannau.net>


