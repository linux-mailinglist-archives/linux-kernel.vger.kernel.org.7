Return-Path: <linux-kernel+bounces-826731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B76FB8F363
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193F13B2540
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 07:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DEE285C92;
	Mon, 22 Sep 2025 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWMkjLgP"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812F286A9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524591; cv=none; b=M2rOtoQOYPWGfCCwpqggClBmzoApU6YHK94VsLkb1HLa0GfHTxxZhy74zGFET//Hg281XRFfERD+A1xRp8uZBG7QW8XLpaBnxixtYtfYNykWbTvkmSGiIzIg2s8FEPTX5+WwNerirMQ0IaVY5j3Ci8/sXA3a5VqXReUqAgPC/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524591; c=relaxed/simple;
	bh=965izMH36FGLomjtcPvBm89ybWQtRT8ePyq8yto8kUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fIgBwlEgGBp6CKtL0scoLhQ9WH2bEaSlI1GU8q13FwN8/ApufNn45yKRBu6pZb2GpFbbaCk9Ox3NbIyJdjU7U0THV5BTSa5U86gAuPkx+HLNarjelrEMPa+24yuAOhVOnQsBqsqneqtujHMkKjPvOUukL4RJiXWS+5RBZiqNPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWMkjLgP; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77f41f819ebso268992b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758524589; x=1759129389; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4VdrnFXMa9rFd83Zher/BcNQQzlodlm+IkoVXej7FCs=;
        b=hWMkjLgPJjieabMET5HCu0mjhCIfHxA8msfSyjFD3buAxOcCivFR72GlSSHyKYu1jn
         krhf8ZwJY86vo+MJmHAdNscIs32yNSAiyrdTPfaSj8gPuTbYCZEoEX7T2hpBKXyNriBz
         rb5I2Fn6o01yJvXdeknMGTE+byXmOzY1ZUv5qMp5wcc29XI3PLtr/A9iQVqx8aURzEv5
         wGeVwI8iGqCg4XVqC0GcbVrZJEDcD7H+rEMuLmPS5bgBhAuZucCAcCt1t3xdPLzP7kEU
         /dMgNoiRpXKOne6SfkGAZZuR+Ks7KdaJ0yy2p4KgNDZ4etUy1uP6ZNpbQ8GioAKP5TBY
         oNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758524589; x=1759129389;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VdrnFXMa9rFd83Zher/BcNQQzlodlm+IkoVXej7FCs=;
        b=JSk/fScoCJ9hvQQRxXbSbHNKxMgoRdBpbJe+3/jeaYioAsfzSPWbeEy0G2dvqD5lUs
         /IywtyL2SbFo6385I16ByuUwynSrycwgvmvr7Q9I3JGhPPAD0NLlK9kSH/oo76q4iaUH
         1HUhgmG+QDQE1mQon0o1Scj+qA5DUfRmEuve3BvM6SK9EFIUYRYaS8AdAmYkmnhaycNx
         oXgwefBZQ+wIZr4G7gu0ojdQfSfqLWQIRjkbp8gtw4OoBwg/uyujmcAGf+dlEkbZJDvX
         LzEcp5Esc++PxCEE0yB6E6IH/b2j0a8nLWzbllMsPHnL+46ZvekuXp48Lg5lo95yxrqT
         yIbA==
X-Forwarded-Encrypted: i=1; AJvYcCVSONsIAHmllMIiAW78UwuinCfGqSXiGDg97WLDowP9FFQ9tCfpXiqc9hQWFgiSo4ZU0SDz1xEfoqInB5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwelPLeeQ4Bw4rhdq5jFQyYI9QcxPoPOdEvcL4c32+vFivV/ZdR
	CDIX8ucEH30+c8uEkQHeOKDx6mycQhtXi6TNh24V2GBqvtdcIzATk8ag
X-Gm-Gg: ASbGncs5ddBNpdSv8NgeQnDwu2ZG/C7vFPGjZZPUcYLuyRCNXhxN1nRGafV/sVhigSM
	0pSiRSc7xbXG0rj1wLl0oCZ6WtoWMXl/5HtjMlpxW8TBCK/Z/T5oJ0IHbJFMdZUEBH6l913QLOA
	lJL5uWaH27ntQsVo6THXEoTCSnWaBSBtJylDMprSkF2xdTqStGNJC4n8vQABK7O1loIhlVZr+Ez
	2anYb7fXj11zojCZeO3P70OXqoo/MNshQRc+voBePhA7RiNeFiScaquPxagLiz4ps1UhsOM5BZC
	Ji8lTO7KDGWec7OIfMaDsKTvAPGLgBpeCPOYvAVuHefQl7pmPARvOosv5ZSI4na1TNPejmz3PWs
	qUbiztPKP+RfzVyXeoCTU73PMOxggV7Isnou6TSrLty1+qVf8TMnB0EtCEtuw/be9EQ4=
X-Google-Smtp-Source: AGHT+IGJ48A08lAcVKcYdk0WkcJU/k9veu86ugQxlnRCGNKMTcl5D3T3DnGhbnyIKjGQKizhhH8t5A==
X-Received: by 2002:a17:903:2f4c:b0:263:d6b5:fbe1 with SMTP id d9443c01a7336-269ba56738bmr118340355ad.55.1758524589057;
        Mon, 22 Sep 2025 00:03:09 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-270cdb02c3bsm61149115ad.102.2025.09.22.00.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 00:03:08 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Mon, 22 Sep 2025 15:02:48 +0800
Subject: [PATCH v2] ARM: dts: aspeed: clemente: add MCTP over I2C support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-leo-dts-transceiver-v2-1-d2dc0e24a70b@fii-foxconn.com>
X-B4-Tracking: v=1; b=H4sIAJf00GgC/32NTQrDIBBGrxJm3Sn+IKRd9R4lC9FJMpBoUZGW4
 N1rc4Au34PvfQdkSkwZ7sMBiSpnjqGDugzgVhsWQvadQQllxE2OuFFEXzKWZEN2xJUSkndaknZ
 K2hn68pVo5vdZfU6dV84lps95UuXP/u9ViRI1KTMKrUyvP5bd8nZ1cYeptfYFSinqOrYAAAA=
X-Change-ID: 20250918-leo-dts-transceiver-edc31e3c21af
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758524586; l=2794;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=9m5R4VJWufe7k7yurqqw3z2y+D8AnXNo6e7S0rTybvc=;
 b=H587RMaWwa8qjdxlMqKskZgP2x92LSHN4XC0VLs+x1k0fF8sSLgQ/oghPLxbeWH2ZTr3udvki
 ykREjgsCdz8A2JTncdm266pra8yLsRJBoZ5qb8m1GYIjQptIuBJiPlC
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Enable MCTP communication on the Meta Clemente BMC board:

- Add an MCTP I2C controller node at address 0x10 on I2C0
- Mark selected I2C mux channels as MCTP controllers
- Remove unused "i2c-mux-idle-disconnect" properties

This allows MCTP devices to be discovered and used for
management communication on the Clemente platform.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Please consider the patch "[PATCH v1 1/1] ARM: dts: aspeed: clemente: add MCTP over I2C support"
withdrawn.

After further review we determined that enabling MCTP in the Clemente device-tree is not
required; the affected devices are managed through other mechanisms and adding MCTP nodes
would be unnecessary. To avoid confusion and noise, please ignore the previous patch.

Original patch message-id: <20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com>
---
Changes in v2:
- Withdraw patch; no functional changes
- Link to v1: https://lore.kernel.org/r/20250918-leo-dts-transceiver-v1-1-3e2580325edc@gmail.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..a2f0ed6e7bbefbdcec33f7ddebdf2de62adec164 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -269,18 +269,23 @@ &gpio1 {
 
 &i2c0 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9546";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 		};
 
 		i2c0mux0ch1: i2c@1 {
@@ -332,6 +337,7 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 		};
 
 		i2c0mux0ch3: i2c@3 {
@@ -457,12 +463,12 @@ i2c-mux@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 		};
 
 		i2c0mux3ch1: i2c@1 {
@@ -514,6 +520,7 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 		};
 
 		i2c0mux3ch3: i2c@3 {

---
base-commit: 1937f781fe7fcde26e537e74dfc6097fc08fc9bb
change-id: 20250918-leo-dts-transceiver-edc31e3c21af

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


