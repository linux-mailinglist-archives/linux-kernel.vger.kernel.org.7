Return-Path: <linux-kernel+bounces-854686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0815BBDF1D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9A319C82E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392942C3248;
	Wed, 15 Oct 2025 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INRlxCwK"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840E296BB4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539166; cv=none; b=kC6a/NBDcZJi/K6YXnm1r7VZqOeKX/W8iEpnT8KE/tecwV+tvIGWqxLeSyY6aIXAz4uScRCE4PLJBnxUAn5YpG1/HfqmiBIcYLde72Yebjt48KObifTNZWJNO/x1CTg5quysVrSnxjNE40EZdU46aimpzyFpxyYolxlO9e4vdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539166; c=relaxed/simple;
	bh=0qzb1wRUXnACQfE7kc/V3RbmqbCvj7mpXDT1acziKnE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8eQmhll5s4d8FpRKXIXHS8roorB4p6gj+Td7/GS4Zm10ZT4kWVZRlpG/qpUmotAjSrZWsf6Cxm5T9tAtkZfCd9y28khzSqKPZi5/iFcTKEgwkS/qj07P8Ml7LZGFknw4Ja7CEpvGcuujvKsCYpNWg5IIIR7YMYcA45QNoAE/s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INRlxCwK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26a0a694ea8so49126835ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539164; x=1761143964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1qkiZNzj4i8upyPOuFU9biKPD/HSZhrQR/i5BB3FsY=;
        b=INRlxCwKDCUElwMrIKhdH8vt8rjAzV9uHrFLd9j1RO5dAWWRaF93IuSo2FzVPAWqQD
         atCVgsXB5/4vWyFv3AboNIp0/J4ceuql0IuaIA+d3GPYZ1RKvbUEWzQahyGIEbZMFnzI
         ZINIVfcRmJv1hC9Vo22YZ4Qv8qGGBMDhajFojcWourjsWq0DP9BrWCWpy5CiDVS1lIBi
         +c3/Is2vobLQcY6fkbQEpzwEYM6uACPVZsPQwFVC2GLzkv75wV2Yf7gRkhtruGHBodGE
         K3+dw/gfNcQ5Yh3Y2wAIY5cFX9EXaQuG8HMnND1vONLWGFfUs0y7awZdwu8YPPJ18iMQ
         z2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539164; x=1761143964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1qkiZNzj4i8upyPOuFU9biKPD/HSZhrQR/i5BB3FsY=;
        b=GROa1jRd+hEGe/5C9PidvGp+bld8FMfyS5R5V0WwPk/ZLBgPDMQLsUEzJAGs2P9nWz
         yZ2p43HJ3usiYlNKIdvBvwI7qS2kR2f13QlsFsUK7l/sGMO/C8FnZvhRPy7n6APX8N93
         Hn71SgwofImejBN2FJ8/6r7VzAisvvitsCdXw9hxqcCE+1H4g4L0KH2gnCXEvgnaFHBk
         F1FHOtrUtbd0pbCtzThxIHDrjvs1n4KlATDv+M9QU97Z3hclWJvZT0aWkmnjA1NXegGJ
         x14LyqmZosqKZOmoxS9xTI4PO4FS9yn7T+N3Z80cyGadZfQgeUKUjUeIly2IZpmuPES6
         dYKg==
X-Forwarded-Encrypted: i=1; AJvYcCWNrTbreUlEcB/nGIpw7j2rOH2claz/7A2CsWYkLGYTVjMiuoSnFsGJjjd77Ys6GGi0N02vPbgSJorNCxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTkV66NHHvugT81nOYatRnuNiq9+Yi7jexqifDl7uIh2JRXrvv
	8cH1uCj19y4JZaG78dv82OH1nUolFdwZtSinChyNlAR78Up04mzs2M9L
X-Gm-Gg: ASbGncsLdjeS88AsDPRUqWo6LanvDMJWkZ07OK43wmZ9ZS8zi2hCh33/yxvtir722DI
	f57L/wN19+jm0YL2QQNvRNhGzNicKWuqK50oSNoZyqw6RVe8bW9dbLZPyielzoqiZZ+Xx/6KMWT
	wXDzKOxkOYvmwwuOcLmZwPwvgCnbpYbJ8C46lCEVn7K6HdMJD/x5xWYaT5glGX/DDy5Lrc+XOIW
	vebuyI4RkXatRoGohFvd0806Ma5YbdRp4Mxc8ZVhhKAQ9hTT4Hj5T2i9+y+bH7d1s3dd6p8bp0o
	B4Q5fHA5nghnlFPB2brUhhNQ6WEFcnS3NpcGqNYvudNnu1KgoWnkYHFM7TX6DBS4jfAMsbZIVqY
	G0ZOzZwrLJEiFz6d3LBRDpahWHUoC0xwEDgLnkpvLNxpUxwrtwF9rKoCpOm+n1pNOTbwRqj+gRN
	3dwgy8h0AjmFrOHTeH9Yw1/6i5b45adCteKTEivOa8
X-Google-Smtp-Source: AGHT+IGhJSIQPh1cVrCpB8ckttgUHuHIw4pB+GNjrgyyBubcVdnekxYCkMTZnEV3Ov7tT/KZdg62EA==
X-Received: by 2002:a17:903:286:b0:276:842a:f9a7 with SMTP id d9443c01a7336-290273a1725mr344577015ad.57.1760539163812;
        Wed, 15 Oct 2025 07:39:23 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:23 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/7] ARM: dts: aspeed: santabarbara: Add blank lines between nodes for readability
Date: Wed, 15 Oct 2025 22:38:57 +0800
Message-ID: <20251015143916.1850450-2-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing blank lines between DT nodes to follow the devicetree coding
style and improve readability.

No functional changes.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 72c84f31bdf6..4adbf15d913f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -319,16 +319,19 @@ eeprom@53 {
 				reg = <0x53>;
 			};
 		};
+
 		i2c4mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -380,16 +383,19 @@ temperature-sensor@4e {
 				reg = <0x4e>;
 			};
 		};
+
 		i2c4mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch5: i2c@5 {
 			reg = <5>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c4mux0ch6: i2c@6 {
 			reg = <6>;
 			#address-cells = <1>;
@@ -424,6 +430,7 @@ voltage-sensor@48 {
 				reg = <0x48>;
 			};
 		};
+
 		i2c4mux0ch7: i2c@7 {
 			reg = <7>;
 			#address-cells = <1>;
@@ -469,16 +476,19 @@ i2c5mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c5mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c5mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c5mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -503,6 +513,7 @@ voltage-sensor@48 {
 				reg = <0x48>;
 			};
 		};
+
 		i2c5mux1ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
@@ -513,6 +524,7 @@ temperature-sensor@48 {
 				reg = <0x48>;
 			};
 		};
+
 		i2c5mux1ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
@@ -542,6 +554,7 @@ power-monitor@45 {
 				shunt-resistor = <2000>;
 			};
 		};
+
 		i2c5mux1ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -663,6 +676,7 @@ temperature-sensor@48 {
 				reg = <0x48>;
 			};
 		};
+
 		i2c12mux0ch1: i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
@@ -678,6 +692,7 @@ power-monitor@43 {
 				reg = <0x43>;
 			};
 		};
+
 		i2c12mux0ch2: i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
@@ -695,6 +710,7 @@ power-monitor@41 {
 				shunt-resistor = <2000>;
 			};
 		};
+
 		i2c12mux0ch3: i2c@3 {
 			reg = <3>;
 			#address-cells = <1>;
@@ -712,6 +728,7 @@ power-monitor@45 {
 				shunt-resistor = <2000>;
 			};
 		};
+
 		i2c12mux0ch4: i2c@4 {
 			reg = <4>;
 			#address-cells = <1>;
@@ -722,16 +739,19 @@ voltage-sensor@49 {
 				reg = <0x49>;
 			};
 		};
+
 		i2c12mux0ch5: i2c@5 {
 			reg = <5>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c12mux0ch6: i2c@6 {
 			reg = <6>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
 		i2c12mux0ch7: i2c@7 {
 			reg = <7>;
 			#address-cells = <1>;
-- 
2.49.0


