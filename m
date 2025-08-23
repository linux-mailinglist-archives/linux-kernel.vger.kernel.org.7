Return-Path: <linux-kernel+bounces-782985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B756B327FA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A03A5C7ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B02253F3;
	Sat, 23 Aug 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="FKJOS1LU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WrCILy44"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C5242938;
	Sat, 23 Aug 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755942597; cv=none; b=XalgEo4hK/Hl2EJ89nofUMjI8UGxY/X9JeL1d8pfApo4pbV42PfE90M4pz1aEWxUlZfmNb6cuZqVzewhhJWzfCp+Y4mFsAI3E0zGtUm2djN5UkwX2zPkUUNMVrPnSqg45584Wq7YrL8uM312QsdBBCN84IJvgMy2gEw8VXKznug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755942597; c=relaxed/simple;
	bh=CLEFlgDLyWaae2+gPA5prv0GE6nVObDi4nCUB+aqOPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NrF27+Kd/QuKh1M8BPSSFIHaazyC1duDU8Rj7pXsMFPBbrAZdA0f5uwJnWwoUR/eFH7lpMAnBUsNbsTtMb4RqZJQOg69LSN05PONr14CcmwshDWqrzjAyt/RPcpA9Ke/jKTq6uF5HeUxCCAi6NHq7ZSVFssjvdSEE46D3Gq8oTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=FKJOS1LU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WrCILy44; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7AA847A0137;
	Sat, 23 Aug 2025 05:49:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sat, 23 Aug 2025 05:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755942594;
	 x=1756028994; bh=zIEZ79kkVYGhuScirCpXFEjqDlYt3vFs+rDCw2sPbA8=; b=
	FKJOS1LU6ejW6havAPlBQHjV7oPCIyCsPS5YRN/plT2ZP+VZgTPio0zJJfc7SRxi
	rHMhqDlFdJ+bvjOK7ThIupvfGldDk68LepnbgV80cLqGtGUpO0Ly+I5Q60Bs7TAg
	GJ3POQab5pYzM865zV55oyfuYcu13nn00NWMb3MbzbkiDW4GPm4b5AzdArMEcs0V
	uqbvge6j+r6Bi6UoeA+y1WkOvqvaYEKm7cI/ye4NREzIKHVo3aOmGezk+wxmsWmA
	7qoYeeH/uEg0jkBKWiPEkGNPCMadnEtTjtxiF33CEWUv0ZtzjztNDcYpNhS+MFjj
	GTOpjYzK3uIWdMJY+e5zLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755942594; x=
	1756028994; bh=zIEZ79kkVYGhuScirCpXFEjqDlYt3vFs+rDCw2sPbA8=; b=W
	rCILy44ua83bb1K+Fa5scbTOOipfPRuPHiSuB1A/r/M7VPWv91OjCUiQXU7ylhWo
	z9MF1GDlNhoOpg9jtnv25dW4t+AxaYEMF6vGlJ45QTBUAPkszLze3Lsz44rgQHqg
	66a3iptqVEf32uq50WKETeKfkAttGWZ32NH7VP3Yc+J76xPqYZVy1Oys7g2csS/u
	fEZZCyC1Uw0eFOGkKn//cPRuEq5lzRxr4RhuKNMVQEULjzOy+8HfklyHBzH5hiwN
	0Se+kmtpL9ROteqKTdtYox13TxXgSg002sZgCCL6HiQlope9Ekrzpir67ryOZmAr
	f3i9OwE413kYkexkcwasA==
X-ME-Sender: <xms:wY6paCiGnFhKaihWrwPgavtxcjoQAHzjVuw9jT5oeBfufxLabzbH2w>
    <xme:wY6paKRchH-i4FQfC3fIE2aMN1YaTJZeZfXs8YAbd05Pyx7J7VFwvNTce0eubtFcc
    Vcgk4kPZQg8uhc8ZQY>
X-ME-Received: <xmr:wY6paE8RRwY7G7_tK51B4uniD-ubGvuxKMuRNILqC6-JARs6XqPK1u4Wddi-MlDKLFosVQZ12I924ugWXk4dagWA33seaji3Z4o24Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieeifedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflrghnnhgv
    ucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ehheeileduffehteeihfdvtdelffdutdeludduiedutedvfeffheekhefgtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrg
    hurdhnvghtpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtghpthhtoheprhhosghh
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprh
    gtphhtthhopehmrghrtggrnhesmhgrrhgtrghnrdhsth
X-ME-Proxy: <xmx:wY6paLPgDRxbmc7J0sLqvwPVxPl8wQ6IWhF1Hx0yLkzQEyypeWk5gg>
    <xmx:wY6paFi962bndx-V5TyXU-GlMIcdLp438IL1j0grl3g1GRBucO3HsA>
    <xmx:wY6paOlBGF5r-StLV23s6yoZ-tSIzHKl4G3G4gQjiI8BTqUq37TUyA>
    <xmx:wY6paCPmN-1yGMpgxYaJE3YBUQuY2IsctTU6rf64lCGSzOtgO72lFQ>
    <xmx:wo6paPO02tWOeXWFVJHHxF3zxjrUMmoM9SmfqnAPpqfcKUaNrZrQw9ua>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 05:49:53 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sat, 23 Aug 2025 11:49:45 +0200
Subject: [PATCH v2 2/5] arm64: dts: apple: t600x: Add missing WiFi
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-apple-dt-sync-6-17-v2-2-6dc0daeb4786@jannau.net>
References: <20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net>
In-Reply-To: <20250823-apple-dt-sync-6-17-v2-0-6dc0daeb4786@jannau.net>
To: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5020; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=4sTHPm369837yATd/OM+wN0/EZ/iAnwGoBiqIT2OsUw=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoyVfTuXPbRauG1B5ttlz5pbrJqzii+43vA8u2HWKsUEK
 9Z5/4vXdZSyMIhxMciKKbIkab/sYFhdoxhT+yAMZg4rE8gQBi5OAZiIthwjw9H5CWvex4SGcn/w
 snjgqWu88ojhTFPNQoUH5rsqz9Rx2jL8D+3fOItph6LzEi232zoFrus0jGZlreCcWejl67nQukG
 OEwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

Add compatible and antenna-sku properties to the shared node and
brcm,board-type property to individuall board device trees.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 arch/arm64/boot/dts/apple/t6000-j314s.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6000-j316s.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6001-j314c.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6001-j316c.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6001-j375c.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t6002-j375d.dts      | 4 ++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 2 ++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 2 ++
 8 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6000-j314s.dts b/arch/arm64/boot/dts/apple/t6000-j314s.dts
index c9e192848fe3f9f91c3c305e169b949a45e7f7e3..ac35870ca129ce353b04296800b197bf684d0bd7 100644
--- a/arch/arm64/boot/dts/apple/t6000-j314s.dts
+++ b/arch/arm64/boot/dts/apple/t6000-j314s.dts
@@ -16,3 +16,7 @@ / {
 	compatible = "apple,j314s", "apple,t6000", "apple,arm-platform";
 	model = "Apple MacBook Pro (14-inch, M1 Pro, 2021)";
 };
+
+&wifi0 {
+	brcm,board-type = "apple,maldives";
+};
diff --git a/arch/arm64/boot/dts/apple/t6000-j316s.dts b/arch/arm64/boot/dts/apple/t6000-j316s.dts
index ff1803ce23001c7817a336456bed626adc3931e3..77d6d8c14d741e9b6a0dc44f764ea54f966e0d59 100644
--- a/arch/arm64/boot/dts/apple/t6000-j316s.dts
+++ b/arch/arm64/boot/dts/apple/t6000-j316s.dts
@@ -16,3 +16,7 @@ / {
 	compatible = "apple,j316s", "apple,t6000", "apple,arm-platform";
 	model = "Apple MacBook Pro (16-inch, M1 Pro, 2021)";
 };
+
+&wifi0 {
+	brcm,board-type = "apple,madagascar";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j314c.dts b/arch/arm64/boot/dts/apple/t6001-j314c.dts
index 1761d15b98c12f9f6a19798e10d0544805538397..0a5655792a8f1cb6d0029bf9f967aa74cf6c01f7 100644
--- a/arch/arm64/boot/dts/apple/t6001-j314c.dts
+++ b/arch/arm64/boot/dts/apple/t6001-j314c.dts
@@ -16,3 +16,7 @@ / {
 	compatible = "apple,j314c", "apple,t6001", "apple,arm-platform";
 	model = "Apple MacBook Pro (14-inch, M1 Max, 2021)";
 };
+
+&wifi0 {
+	brcm,board-type = "apple,maldives";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j316c.dts b/arch/arm64/boot/dts/apple/t6001-j316c.dts
index 750e9beeffc0aa87f1dcac1b57dddf78184ddd47..9c215531ea543e9afe8c131f7c8dc68cfaae666c 100644
--- a/arch/arm64/boot/dts/apple/t6001-j316c.dts
+++ b/arch/arm64/boot/dts/apple/t6001-j316c.dts
@@ -16,3 +16,7 @@ / {
 	compatible = "apple,j316c", "apple,t6001", "apple,arm-platform";
 	model = "Apple MacBook Pro (16-inch, M1 Max, 2021)";
 };
+
+&wifi0 {
+	brcm,board-type = "apple,madagascar";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j375c.dts b/arch/arm64/boot/dts/apple/t6001-j375c.dts
index 62ea437b58b25ca649e20b1072b4d835bbc17d3a..88ca2037556cec4307d27bba0244d7ba7f45b184 100644
--- a/arch/arm64/boot/dts/apple/t6001-j375c.dts
+++ b/arch/arm64/boot/dts/apple/t6001-j375c.dts
@@ -16,3 +16,7 @@ / {
 	compatible = "apple,j375c", "apple,t6001", "apple,arm-platform";
 	model = "Apple Mac Studio (M1 Max, 2022)";
 };
+
+&wifi0 {
+	brcm,board-type = "apple,okinawa";
+};
diff --git a/arch/arm64/boot/dts/apple/t6002-j375d.dts b/arch/arm64/boot/dts/apple/t6002-j375d.dts
index 3365429bdc8be90b63c8051822243d897854ab27..f56d13b37eaff1c3c14815575a71024661669296 100644
--- a/arch/arm64/boot/dts/apple/t6002-j375d.dts
+++ b/arch/arm64/boot/dts/apple/t6002-j375d.dts
@@ -38,6 +38,10 @@ hpm5: usb-pd@3a {
 	};
 };
 
+&wifi0 {
+	brcm,board-type = "apple,okinawa";
+};
+
 /* delete unused always-on power-domains on die 1 */
 
 /delete-node/ &ps_atc2_usb_aon_die1;
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index 22ebc78e120bf8f0f71fd532e9dce4dcd117bbc6..b699672a5543c1c172f9a788d36287c0b09051e1 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -99,9 +99,11 @@ &port00 {
 	/* WLAN */
 	bus-range = <1 1>;
 	wifi0: wifi@0,0 {
+		compatible = "pci14e4,4433";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 10 18 00 00 10];
+		apple,antenna-sku = "XX";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
index d5b985ad567936111ee5cccc9ca9fc23d01d9edf..95560bf3798bfebe133afafba674005a3e62ddcc 100644
--- a/arch/arm64/boot/dts/apple/t600x-j375.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
@@ -84,9 +84,11 @@ &port00 {
 	/* WLAN */
 	bus-range = <1 1>;
 	wifi0: wifi@0,0 {
+		compatible = "pci14e4,4433";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 10 18 00 00 10];
+		apple,antenna-sku = "XX";
 	};
 };
 

-- 
2.50.1


