Return-Path: <linux-kernel+bounces-820464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF67B7E6F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A566C32738A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76624362998;
	Wed, 17 Sep 2025 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYuN9kgs"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A33680A4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104319; cv=none; b=pwCxl1z3I5bJgBDrV9/44fTHBpf8s4r0IS5GtMW9jro74A1f9G/5YRqGL33YIntDCJ7n7qtqU92RD9NzfJP882N0c0Y3LwqHVoNv7cbtBA2R1kmc0jKQc0vDzfco1jBcK/UHValYkD1pNWrFEOqgftKMfJd/SJ0WfqhjtUxEQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104319; c=relaxed/simple;
	bh=xFVGSPwKpdfp5mcRwbL+faWVzT6eGApTe3Qaswq49wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLZGhPr2JSWwBr799AeV/6vJb+znIWqXFR1DziR1fSnmLAhgqDLhnXB1AcArauokVuWvhkmnwlZdpzK0mCOKaUN0n3jylw+8GakX/QLuisPPUYgPaUaUVHfaTSsBdAQMisqY3f9IoSe1a1lHkQuU4XglraXEMbFYD4d9Pls7l20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYuN9kgs; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54dd647edcso1850832a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104318; x=1758709118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t96kEL8qjy4YgliK0l0rnhpDDiQlebw3W1jReBJnKWs=;
        b=jYuN9kgsQZtTawUUwpURKX5oiDYS6YAnuDw7KnI1AXuOsJSZusykTULGkg3FAEDLvy
         JhZTvG5Pe03aheJjXs0JVrwjmGy8y189L2ZatvBizA2N+ukTybfxZoGT4pPeGxBUSkAm
         qn+kJzktfy72grgNYfXkkK57r21YSsa3Yo1TemFr3n/NH9pEmNdRCMzO4tH4azq6CF0y
         JEgbko8r4WeGd8dLfLhd/rRjSGTpoPn7phYW1pAVrRvrsNkX4CYWAM9DC9wuhD1P1f3t
         BdPMwMFTEz8hcGxUf1Q34N+XQxJRpFBNfRJc74cY0tVqelcc6F9Ivpp//CtZa9DKvoQ5
         pbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104318; x=1758709118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t96kEL8qjy4YgliK0l0rnhpDDiQlebw3W1jReBJnKWs=;
        b=vPhE5bLDCKkMRn7ZJzh5MjL5vTqCJ6z99Q62OTQBAtt6PNl2zZA3e8K0qC/Anvbp58
         LPFXbYFO83jyARVAyTee51xR9qVgBsgJDI0wVnePY2WjA7VNW3cZ4Aa9xkO+Q1s4Isgv
         f1Z/YDowI76tQ69aq85buz2cFp2VbHOMWCYeGx/53toL34sxBGWFR/Tud85esYPlBSi5
         1GABVrzEiDpATHrQ/RIrBV39L4KesLM9Fnz4uDsRnGouJ1OCRa9y7SWxipc8659H+ZJL
         F3Xehd5u2kCFiXXQadb6y/gR6dkvVFQz78+GYK5o11O/hGElUHOBJKy2SNr/akErC1ND
         UkVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdv/gp4XtD9YMYmOpmFyJWaWFW9pXfuwOvTRpHU5x31hYmGofnbYX+ch0rQS0wBvsek+JEKPSHtLkhDwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qjT1nA8L0SmV9Qz8irduJIpauvhdmJ++8Y2n5yVlNz8LWrmX
	qw6G2WGrEVbL7EwHZ6bFyoPig0RmdkoyHZpkIhACsN5/9SMOWRmCNKGF
X-Gm-Gg: ASbGncus6irknBYacIIow4/UDQIyElM8YNme9JjsXRppcNoi00Isd7iD1XNcQRtNM21
	gKowvhra53jqK/ifqticBUDjIHn/KBJQzAdpazaCGXb6GJcHHvlg/SCkJb37Ap0XFzpkmXxldjK
	qve27X/3a1SIqpEwAO0VTf9Y3fDfsLKPD40a0Fh7DxrKsHitm1FabLL4vKEMS6vWJ6fKMbeMlzK
	3EWnWUMD9ySOCqcObl8rZB64hud9gQhDACBGe7b5Ts4ExM33bgREYh3Ek+pKrZYWkVbFlOlgf6e
	n1+MbEgnfUQjpGClj+w9NthBRwYCL+KbDh4gvBZM5oEdRwzR5LywgCPd6xCk1hE32m8MFyHYYYl
	iFecCT5gK36uWv+KdBWmvpkGDY/KOO++Qx07KqAZt4/2OLcwlUVaUvQnjqtkRRNxjCWJxbn0jUr
	jYBhUPmyGYr/zVma9QiQuVUBig8g==
X-Google-Smtp-Source: AGHT+IFwCJZiejFhBOaCOBZZ9XSV1F4l94l6zN4IWDTuh2gTutWzk7T5JzgCvehFOl7X++T/mgLFCw==
X-Received: by 2002:a17:903:2f0b:b0:24c:92b5:2175 with SMTP id d9443c01a7336-26812191675mr18151565ad.24.1758104317549;
        Wed, 17 Sep 2025 03:18:37 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:37 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v1 2/4] ARM: dts: aspeed: harma: use power-monitor instead of power-sensor
Date: Wed, 17 Sep 2025 18:18:23 +0800
Message-ID: <20250917101828.2589069-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revise the node name from "power-sensor" to "power-monitor"
in the Harma device tree to follow Device Tree naming convention.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 41ae86180534..bcef91e6eb54 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -190,25 +190,25 @@ pwm@5e{
 		#size-cells = <0>;
 	};
 
-	power-sensor@40 {
+	power-monitor@40 {
 		compatible = "ti,ina238";
 		reg = <0x40>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@41 {
+	power-monitor@41 {
 		compatible = "ti,ina238";
 		reg = <0x41>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@44 {
+	power-monitor@44 {
 		compatible = "ti,ina238";
 		reg = <0x44>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@45 {
+	power-monitor@45 {
 		compatible = "ti,ina238";
 		reg = <0x45>;
 		shunt-resistor = <1000>;
@@ -264,25 +264,25 @@ pwm@5e{
 		#size-cells = <0>;
 	};
 
-	power-sensor@40 {
+	power-monitor@40 {
 		compatible = "ti,ina238";
 		reg = <0x40>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@41 {
+	power-monitor@41 {
 		compatible = "ti,ina238";
 		reg = <0x41>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@44 {
+	power-monitor@44 {
 		compatible = "ti,ina238";
 		reg = <0x44>;
 		shunt-resistor = <1000>;
 	};
 
-	power-sensor@45 {
+	power-monitor@45 {
 		compatible = "ti,ina238";
 		reg = <0x45>;
 		shunt-resistor = <1000>;
@@ -374,7 +374,7 @@ power-monitor@40 {
 		reg = <0x40>;
 	};
 
-	power-sensor@45 {
+	power-monitor@45 {
 		compatible = "ti,ina238";
 		reg = <0x45>;
 		shunt-resistor = <500>;
@@ -520,7 +520,7 @@ imux28: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
-			power-sensor@20 {
+			power-monitor@20 {
 				compatible = "mps,mp5990";
 				reg = <0x20>;
 			};
-- 
2.43.0


