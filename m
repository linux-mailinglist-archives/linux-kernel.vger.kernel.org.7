Return-Path: <linux-kernel+bounces-782987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEC2B327FE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462F35C8524
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF7248F42;
	Sat, 23 Aug 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="X1fcDyLb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lKgD5qCk"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCAE23BD0F;
	Sat, 23 Aug 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755942602; cv=none; b=fzeC6INwBf60XhrVf2jjmSs+mcHYLi0L8bfzOe/cuhxaamhI8ilrV+JcVoQp93WJIsIVmXmdPP7942kordXiQAlA72D86BJi2NXzIh1D7dfYMALURPsKtnMuY3VKqUrM/HZ8WKkvYPvv+mARDA3rNelp59tKzOL+TS1QJm5DwBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755942602; c=relaxed/simple;
	bh=KqD57XbCx6MjJZlvzND9s0jLRp0WUsHsftD4Q7jE3Ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r8bqoYa+HXKYaMpgDI1vXBfLlvfO8dQU7aKArjE3pX6OWbZT+L0NZ4pFGkyd7C6OanPQBC0kpLVsHaBxkcdypNeMe6iHs2kDuIljuA5QnfQu70SfovLcgoz3gM/kUDrW4wIzK6DXITDEZy1GAOtD+JHW5EwwEWvJxPsA9QZr0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=X1fcDyLb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lKgD5qCk; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D9121D00091;
	Sat, 23 Aug 2025 05:49:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 23 Aug 2025 05:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755942599;
	 x=1756028999; bh=Sg2H0/CDGwZbCFTHKA+pV/36BNwfVXvB3vZX7Q6GLRk=; b=
	X1fcDyLbr/uuGFjQQef8f8KhOZFi8++H9W7qJUdrjr87CJlXR9HU9QPo+ALnDXVy
	PQgClxMj9dTCctkhAX1gst5JCbN2uXyoUc+xWam07mQ0QVt9MlzWAYl8VyIj1hBM
	ecrHODKOlT57l4YnVMudB1Ks3NMwa0KYayImIlNp3MqxJauSNnDeC3pRyvzAc5JG
	oH64AeHpI4s5SZVR+p5ugO2vTFWlhMlP+G33Uhpbqu7j/n17pRncVJTjovNx3U3Z
	ZlA2nPlbfp+DZnl9HuvKOzVODWYBN6GK8HJGWD9eVGbiiGtcVZwvKGfxwukx/8lc
	i98nFzT7dNTC18Tfir4j5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755942599; x=
	1756028999; bh=Sg2H0/CDGwZbCFTHKA+pV/36BNwfVXvB3vZX7Q6GLRk=; b=l
	KgD5qCkqFIm59cPm1sG/J0RmBEf7YHy1iovxZSuRcfWwCrdgndsM2Tkfzm+kFT2o
	BRidt+oFMyUuZU+a093ob0sOxo1OnZWOJCNrcNJRFvI13GYV50CaeDK3SuMJQV9c
	pLRjCmRZ42DI6Bdh6Aes6K4UKNbjox2PIFFANjA95PUk3ufHZG3PtlVP30U2+NSs
	GMtivviF5XXXy19bq5f+Y0QL0JUG3Fkl/2YNCVzLfgSelxboItEHbs64p7fhOOA3
	4tzjsfHEPkFE+0Dsg5UfPvmSmvIwV97u8QxymysF/b+5Fnh5hpNhEH653IbK6pQv
	mAO1eUWhdAulwTitAlezA==
X-ME-Sender: <xms:x46paEyehw_pv21VXJisxP8f8joerckEz3b1ijVz_JR6IRh0v8DgdQ>
    <xme:x46paPj7fRL161Vsn7QoTqDu_EcFtl4ty3bIyW57Pm7WCBqFdaSwDCk8R_D-u5pi7
    5XKwn7W7dsaE0kEcJY>
X-ME-Received: <xmr:x46paBNgJZmw402ur0l8t6FM1p1z8RVMG1OBoDsAZWqdnSewLSzmfpmYyWUjC3xUrbzceAgODJQwR9nxZ1sh00w5J5oAKqUpEmRLyA>
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
X-ME-Proxy: <xmx:x46paCeCKfQVzzlnSTDwVIz0htNHITAVGtLXgG5aFF-X95dwycHK7w>
    <xmx:x46paLyzray2_mclKbxasM7DpWyZz0_F87xSlBoXLoUjyMcY0dqRDA>
    <xmx:x46paH0CPDEhi0rxRwJIxiVa0vXc5q0p-wa8cSmNkS2_tlWzJLPkgw>
    <xmx:x46paCfd5dKzdKGfYtEzkE_91gIDWxV8rbvuRvDi7_AIfCBFZDgk2w>
    <xmx:x46paCePxHc4v3wPqd2loYXfkNggL-i5TZpOr4-fKQRQT0devPo6lb77>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 05:49:58 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Sat, 23 Aug 2025 11:49:47 +0200
Subject: [PATCH v2 4/5] dt-bindings: arm: apple: Add t8112 j415 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-apple-dt-sync-6-17-v2-4-6dc0daeb4786@jannau.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=KqD57XbCx6MjJZlvzND9s0jLRp0WUsHsftD4Q7jE3Ug=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoyVfTvvCem4XeYS0H7+juN9mqH30sit81P2qVT/6y37O
 +8xd/fPjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABNRus/I8CF8zVtGs6+eAl5b
 VHralm+7ebSM37HuTVtFplTpY1dPF4a/Uqevxn45Ii1edNDeesaHeVsYHz155Tf5RJ3zgVZV5fM
 TuAE=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

This adds the "apple,j415" (MacBook Air (15-inch, M2, 2023) to the
apple,t8112 platform.

Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/arm/apple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/apple.yaml b/Documentation/devicetree/bindings/arm/apple.yaml
index da60e9de1cfbd0151e973c3aafba6d0880fc21aa..7073535b7c5b5ce885391699af56751241ddacb5 100644
--- a/Documentation/devicetree/bindings/arm/apple.yaml
+++ b/Documentation/devicetree/bindings/arm/apple.yaml
@@ -92,6 +92,7 @@ description: |
   Devices based on the "M2" SoC:
 
   - MacBook Air (M2, 2022)
+  - MacBook Air (15-inch, M2, 2023)
   - MacBook Pro (13-inch, M2, 2022)
   - Mac mini (M2, 2023)
 
@@ -279,6 +280,7 @@ properties:
         items:
           - enum:
               - apple,j413 # MacBook Air (M2, 2022)
+              - apple,j415 # MacBook Air (15-inch, M2, 2023)
               - apple,j473 # Mac mini (M2, 2023)
               - apple,j493 # MacBook Pro (13-inch, M2, 2022)
           - const: apple,t8112

-- 
2.50.1


