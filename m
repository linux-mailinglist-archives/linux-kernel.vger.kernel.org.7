Return-Path: <linux-kernel+bounces-782986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3437EB32804
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B492AC510A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A195246783;
	Sat, 23 Aug 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="M6Rew6Av";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZDnpKnu"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD2245012;
	Sat, 23 Aug 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755942600; cv=none; b=VeNBhiLY6pWsQhH9+nTLLLh9ejwLjyPTB0Hd4Glc3DUAbdOA6FluPuF06d7piYWB5LoqgwyOrJTg+BIsYxh91kBDoM85arQDLB87bW+xeGsFJEzR6NO8CjCjLs+hAKsOjButVvV+rXY6Lm/gTVCF5XRmN3Fg1kZXzME5h40Bj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755942600; c=relaxed/simple;
	bh=N61cUScGxR49b1KFyKCM29kk5mE2tBYzPKRNXsNz210=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNfBQ8kxi42j4mOKqFVuOP/vDp+aGIXlz/A8rmN2ytXzBtiMF3qjUK9Q4ASjkGJWUHJlehh38maz1xa1rgx46f1Iwh+NGuE9dH41q2H6vOZTcSJ+u/9KztNuraV8fF/OJilh2KaYaHQUKvoZklm29hbLgsHjtW8eOyECyjRrDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=M6Rew6Av; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZDnpKnu; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FB841D0008E;
	Sat, 23 Aug 2025 05:49:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 23 Aug 2025 05:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755942597;
	 x=1756028997; bh=Go3RWvjsLbfJOoYUEzJX3Es7RZi0lRYCJnXPeYrINTk=; b=
	M6Rew6AvC3w/zlOXSnkCKZROyaPShkbOJovHPZHSuOezgv/z/lMf8rPN2HwAmQxe
	wbRG9GkbU+XCSHM2AMaoS+vJnlnXaMNYV/FNm+3wRRUmAr0cHqjph16sxLl2jlVo
	Fz2AWZz22RjyJH0Vu/yLc7BArDH537UOgsRbETiKSvSllX8pJt8dfItxlmrKyLgy
	j2rnhZSaN3WFC/wbKuxYB/5SPOs0//num9H8mtOvH4PNkcPv9x5OT77ElcmKWnHG
	n7gxsLsQnBekSlu7efXFsO4WIt8H3sDQM2FYTEjYscpKGLhkouUlPQOTtOoajavy
	+/gAajA5ICc6ffc5QhN6XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755942597; x=
	1756028997; bh=Go3RWvjsLbfJOoYUEzJX3Es7RZi0lRYCJnXPeYrINTk=; b=i
	ZDnpKnucBcAk7G+V+893dY+1mYhlkhyE7521zTBUTg0RVYV7fbwafome8zoCiCfG
	cFR2cKZE9UJAjtVtS6Fgb/ae5Vo0MlJMP8Y9yQpR4p3RiGjPzUATxwfMnicLPYoL
	CmZ72jxURDvQhHohfrcrfGaXGBStbACAHwJd2wfzBraeRwM9LS16fmg/U2AlmOU2
	Gp2oZ2DgrkLjI+u8wXTgiUMSiGVqGsycpZOk4qt55pLnOEs7DBq1A0btdmJJJDeo
	+ff1xMwshqoXknzHxfroIkHAxRlz19Pq/Qkqx9LRZcNMlQUcjU+dCWgfpagKnlzj
	SZsgZ0bP+GMfzXi7DHy6g==
X-ME-Sender: <xms:xI6paFsUsK4KeNS3jmV998cjXQX8hlr4qRpb-9ERzJjVye5LEOhvmg>
    <xme:xI6paFu6nQjCsJPJ40fAEsYogBnGvDw-Bf_JcunLo8MfOG-9PHA9hqG9XuXvZ2MKl
    auCsVQ4dVIHa5Y6zPw>
X-ME-Received: <xmr:xI6paDpi-kb2mQOM2yTpft_FhMcYNYuYNUOK6iSGHhtweeAU6MP3FRUrezCEdY8OORtpTV4WLLINkpgf4Y0JCGeEVJPh1JOxRkuv4g>
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
X-ME-Proxy: <xmx:xI6paMJ2viXRyCkt5lWXzUoi6IwzuftzX0Xytq16VXbBSdBVvio8TQ>
    <xmx:xI6paLsbwYUz-I3JyPs3lErgpgZmbBbuI_4C6ybVVNJUOHyZ90M4yQ>
    <xmx:xI6paBBkAg-S_lhPtdcupK_MW0BKjrhgzj_BNB1s6tI3jPGVBXS8YQ>
    <xmx:xI6paL56i-mxkoEwwL33Gk0pLSr58kM-h5E3kS1ilMz5BZLjD2HfMg>
    <xmx:xY6paBIGcz-R3FYypwQeJKrlrwcK0FM1f_DP3CiqzB2GwPTU_1f8zqLW>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 05:49:56 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sat, 23 Aug 2025 11:49:46 +0200
Subject: [PATCH v2 3/5] arm64: dts: apple: t600x: Add bluetooth device
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-apple-dt-sync-6-17-v2-3-6dc0daeb4786@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5087; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=7c3SkMBzFNKg28PahLtBmKxHAl3BYf8TeqOO7O4y298=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoyVfTvPC+1Y943D4MMEIZ4H1xe3tgru6mBNZvySk7JQR
 1diXoFXRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgImIxDEyzFtg+C9NLSw6JGDJ
 salS/GHXJqZNdzTbPdu8Pz3PoU01mJFh8erTe3u69+ZZFAfYd6nNinv2YULem7L2tvuhy1N+erI
 wAwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Hector Martin <marcan@marcan.st>

Add bluetooth PCIe device nodes to specify per device brcm,board-type
and provide the bootloader filled "local-bd-address" and calibration
data.

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
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 8 ++++++++
 arch/arm64/boot/dts/apple/t600x-j375.dtsi      | 8 ++++++++
 8 files changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t6000-j314s.dts b/arch/arm64/boot/dts/apple/t6000-j314s.dts
index ac35870ca129ce353b04296800b197bf684d0bd7..1430b91ff1b152e5a23025d5377f189601bb5a09 100644
--- a/arch/arm64/boot/dts/apple/t6000-j314s.dts
+++ b/arch/arm64/boot/dts/apple/t6000-j314s.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,maldives";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,maldives";
+};
diff --git a/arch/arm64/boot/dts/apple/t6000-j316s.dts b/arch/arm64/boot/dts/apple/t6000-j316s.dts
index 77d6d8c14d741e9b6a0dc44f764ea54f966e0d59..da0cbe7d96736b1491497243bdbd1d13c9ab6c62 100644
--- a/arch/arm64/boot/dts/apple/t6000-j316s.dts
+++ b/arch/arm64/boot/dts/apple/t6000-j316s.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,madagascar";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,madagascar";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j314c.dts b/arch/arm64/boot/dts/apple/t6001-j314c.dts
index 0a5655792a8f1cb6d0029bf9f967aa74cf6c01f7..c37097dcfdb304d8fcdf77de82e494e158d94c72 100644
--- a/arch/arm64/boot/dts/apple/t6001-j314c.dts
+++ b/arch/arm64/boot/dts/apple/t6001-j314c.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,maldives";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,maldives";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j316c.dts b/arch/arm64/boot/dts/apple/t6001-j316c.dts
index 9c215531ea543e9afe8c131f7c8dc68cfaae666c..3bc6e0c3294cf98c89dddfb4891eefbe8aae7020 100644
--- a/arch/arm64/boot/dts/apple/t6001-j316c.dts
+++ b/arch/arm64/boot/dts/apple/t6001-j316c.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,madagascar";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,madagascar";
+};
diff --git a/arch/arm64/boot/dts/apple/t6001-j375c.dts b/arch/arm64/boot/dts/apple/t6001-j375c.dts
index 88ca2037556cec4307d27bba0244d7ba7f45b184..2e7c23714d4d0007b7096d469f32c689944c85ff 100644
--- a/arch/arm64/boot/dts/apple/t6001-j375c.dts
+++ b/arch/arm64/boot/dts/apple/t6001-j375c.dts
@@ -20,3 +20,7 @@ / {
 &wifi0 {
 	brcm,board-type = "apple,okinawa";
 };
+
+&bluetooth0 {
+	brcm,board-type = "apple,okinawa";
+};
diff --git a/arch/arm64/boot/dts/apple/t6002-j375d.dts b/arch/arm64/boot/dts/apple/t6002-j375d.dts
index f56d13b37eaff1c3c14815575a71024661669296..2b7f80119618ad1b497b67597c55968585bd92a9 100644
--- a/arch/arm64/boot/dts/apple/t6002-j375d.dts
+++ b/arch/arm64/boot/dts/apple/t6002-j375d.dts
@@ -42,6 +42,10 @@ &wifi0 {
 	brcm,board-type = "apple,okinawa";
 };
 
+&bluetooth0 {
+	brcm,board-type = "apple,okinawa";
+};
+
 /* delete unused always-on power-domains on die 1 */
 
 /delete-node/ &ps_atc2_usb_aon_die1;
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index b699672a5543c1c172f9a788d36287c0b09051e1..c0aac59a6fae4f6f4b387483665349a8e2521c1e 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -13,6 +13,7 @@
 
 / {
 	aliases {
+		bluetooth0 = &bluetooth0;
 		serial0 = &serial0;
 		wifi0 = &wifi0;
 	};
@@ -105,6 +106,13 @@ wifi0: wifi@0,0 {
 		local-mac-address = [00 10 18 00 00 10];
 		apple,antenna-sku = "XX";
 	};
+
+	bluetooth0: bluetooth@0,1 {
+		compatible = "pci14e4,5f71";
+		reg = <0x10100 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-bd-address = [00 00 00 00 00 00];
+	};
 };
 
 &port01 {
diff --git a/arch/arm64/boot/dts/apple/t600x-j375.dtsi b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
index 95560bf3798bfebe133afafba674005a3e62ddcc..ed38acc0dfc36a1e30b1d44f1a8dcee089e87232 100644
--- a/arch/arm64/boot/dts/apple/t600x-j375.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j375.dtsi
@@ -11,6 +11,7 @@
 
 / {
 	aliases {
+		bluetooth0 = &bluetooth0;
 		serial0 = &serial0;
 		wifi0 = &wifi0;
 	};
@@ -90,6 +91,13 @@ wifi0: wifi@0,0 {
 		local-mac-address = [00 10 18 00 00 10];
 		apple,antenna-sku = "XX";
 	};
+
+	bluetooth0: bluetooth@0,1 {
+		compatible = "pci14e4,5f71";
+		reg = <0x10100 0x0 0x0 0x0 0x0>;
+		/* To be filled by the loader */
+		local-bd-address = [00 00 00 00 00 00];
+	};
 };
 
 &port01 {

-- 
2.50.1


