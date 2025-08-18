Return-Path: <linux-kernel+bounces-773197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35DB29C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4FC18A3041
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38386303CB0;
	Mon, 18 Aug 2025 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZ6ptN4c"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DF32D661E;
	Mon, 18 Aug 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506660; cv=none; b=b+GDswK0tO7wL8LIklZ2oVQ4v3So/nbQzp2/lVjWckNSWaTWeAdBddmaI0NteccN95Y1WU6lhbxukLVRduBVGEbGnlMqrqykOkO/kchb8rKxSU2i5UQBvyHv9zmbEoiLwWJG0pOBuAjn3bhy2VigCxixB7SSwKVhPMZg4Z+e7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506660; c=relaxed/simple;
	bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ImqGa82Vqe/IKqILT8fBTcOjzb+YRFQeVsyKNG1rIdjALdDHCu4QqDCA1OdJO2p6BLaV+Cjsd2nAkgSDIxjVtgOTyXxFQ1lwOTHCSagsCLt3cbIwatYJ4Jcuei5Yw3oR0gGOxONZzriKeOlo38zf9/n2vzYq2OXZSBRwX7Y2jbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZ6ptN4c; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so2790215b3a.2;
        Mon, 18 Aug 2025 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506658; x=1756111458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=jZ6ptN4cvGiCOanpJlirJr5ipV2TM3GfaY6hu1bTwZkSHNZ/dbDsEagI4M/+XuluXD
         KpHPF51pN3HrIZWv3w6/vsVygMqEXr26N7xtah7u1ydNV3XQ7teZKo+ugGMmEXB0y+B8
         jCvGFR6llHf9cKND+okYMskcL5nkYjWhVwBDXSq6vTc5fixgcJMYjgreftU6rE5rJtcP
         8o6/1mknFhozylk5RMJK8TsUePbvgSs8j37g2jdIP1HDO1z7dllLtRGtlMLNxEx9vfwa
         w/CZIwz9ixBpjvxiX1yxTCDu4RGM48qgWlBTfdygFtW64kbbeQB3QpHk5E88lzFLoJ8Y
         xX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506658; x=1756111458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9SU02hcw6WNKVO382VnK0doOc9DExiucOzxMaULtIk=;
        b=M0gg+UjmKf2bCMVdRe2CVb9XP1t0wo3TSHqDjkVH2IgJ8dGAZPtWwYdfdFFd6yju1S
         h2YMSt03yFOOZVlVEv2z62LOxDOUzotcxpPdLQO9J6Scydy29AcRcHNp1P0RMTI0dgN9
         4tVYE4YrqXYw6cBqPC3AUR2tIu1q4j43j7uXIVIG3pdBlstL0JQ1Wu+x57xt9BrZKEBm
         LLKDuq8YocjHaXwf6B9WIXPDwfeQyYOQ6H+8tT9F35Yb8Gmfgnsm86XQ99KlEAvUNrOk
         p3aGE4hv4dPs433tEcUbCb2M70Kb0PeIbFfgFjM9zs3n1nyr2DHYSwTtZwJtPblnactI
         LLBg==
X-Forwarded-Encrypted: i=1; AJvYcCVqIX0y5whW9mJF32/QJoKa7TYDmFiVGjTEtwIsczLzJxYeUlNsuWMgfUek5aRQfioGEY8jPc4Tfc4E@vger.kernel.org, AJvYcCW8WG3Jhr5JeQJtgraYM0DBF+Sn592dbFYLu5I6uEFtVkSABTwG++nCcqlBChbRVXASeYlIVcaraK1N2iCp@vger.kernel.org
X-Gm-Message-State: AOJu0YzqxXpHaGyMRHN83fn+u/Eu6rX6IJWQ2mytJCajDdKVcpyjZbQD
	9lg+KXy+S4D2F4pn9lna/ozy3mcKFVXIJrTRmI3epqGWaZBlST5JSM1l
X-Gm-Gg: ASbGnctRo5qBywoSSOhToX3yNWvnGoaVlsI5Ui2bBcpHBDvGT/ojghfvZjwzTuNjfof
	+/wtSuanKK0ztyde0yhpTSPRP0MWvFOITDIM0HoXl02MHoDmyDKevoFq1cqUHFxbXc3vI6FOPNt
	ARTwNN5Ms+6J7yfZhUXO8Oz4iN+5GUg9OCCEWB5oBzSxhiQo5zje+n8tsi83xARG3VEdTERgVtb
	u6q4h1g4pMaz1IPR79thB9eeZwGcPqoZqFIJiaHEq+9+0s316etjMyuXfsfjpSh1bXVjeUiGZRi
	RhFnw+tepKvNHm2TDC+ze3Tz7LDnBeoiJ5XuV7y06rFqBJeX84LGZR0SY8DJiIR+SKK6QdO7Hfa
	U+GISa9aCK2gxyyMjWIeihkyVstmeAP3ABm0CAsGazBpnCmk=
X-Google-Smtp-Source: AGHT+IEZ7SgzaIcViACMoklHwNzXuNrvR+dLxWbWKBIt+/2PHm1FePLfHPE2fOsDswTJBK1kq5uTyw==
X-Received: by 2002:a17:902:d2ce:b0:235:eb8d:7fff with SMTP id d9443c01a7336-2446d8b1f83mr145333235ad.28.1755506657783;
        Mon, 18 Aug 2025 01:44:17 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:44:17 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:43:02 +0800
Subject: [PATCH v2 9/9] arm64: dts: apple: t8015: Add NVMe nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-9-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=W450nZF9q8zgSwZAzN00gO+pHroqymkBwDRdi0GaMOE=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouemdDCDE0LTPBZa3djToJLXtZ0KFQccDpzbs
 4vZ5ZKiW8qJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpgAKCRABygi3psUI
 JCcpD/9Le073yzzucsbRvbZQOWl8EyMIsowsDZurct6uSh3G+LuNqc6CeLAdNkl3NfDZNbBUP5l
 dYqY/G60ao58ZeHJqd5L2pzXiBiW3uIN8TXATozENYrsBjP4+JcMqiGIId5LbEgukc/IpIeYROm
 2D5Xz7ETB0KnIg42np4fpZpljQ/QZOST9qi/n5W32yCkGIwhRLVLBM5T9pI2NfF9nUHlUcW6Uo2
 61haY/NF6qVhXOWYkfZ8AD5I7RM8H6yub1MJIg8p4nfGw75KqhtLOem59PYVel9NhammZesVXKQ
 fdUvePBRwAymKhbqhwA2VCdEfDviP8X0ENV5Mw3SrUujPvKVEE/IYLT4lOUmshWOxJwcBeWU1UM
 6QyogMYmueE65OPCkaSgQxk/U23yje4L++Zi6Yg7HDL18bZKPAXtsK/K6WrHBdsgDjaS6U2rXOa
 K8tRg04xb6dImHo8juZWVa5NgdDYJqE8Nn/yp4kAdyTeY4BuHIIu870gQo/nahWQ55hoDgTrPAI
 0ov+tkD3RHIVZZocP1JfIUVVn3D9vP3vceW2FIVbPacvpMDfqsKq3muKQBWfv/giMMohAMDlAjv
 sQHf+xvgWftQp6HsVC9TK1Lm0SJkWogXCRVUO/QJc7X8mZ2hx8rl/8scVQITbZ/B7Frp40Vxu7d
 yIEr993vDlfzcPg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add nodes for NVMe and associated mailbox and sart for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8015.dtsi b/arch/arm64/boot/dts/apple/t8015.dtsi
index 12acf8fc8bc6bcde6b11773cadd97e9ee115f510..84acf2839fb6279dcc956e1f4cee1afa909d2f27 100644
--- a/arch/arm64/boot/dts/apple/t8015.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015.dtsi
@@ -402,6 +402,40 @@ pinctrl_smc: pinctrl@236024000 {
 			 */
 			status = "disabled";
 		};
+
+		ans_mbox: mbox@257008000 {
+			compatible = "apple,t8015-asc-mailbox";
+			reg = <0x2 0x57008000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 265 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 266 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 267 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 268 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+			power-domains = <&ps_ans2>;
+		};
+
+		sart: iommu@259c50000 {
+			compatible = "apple,t8015-sart";
+			reg = <0x2 0x59c50000 0x0 0x10000>;
+			power-domains = <&ps_ans2>;
+		};
+
+		nvme@259cc0000 {
+			compatible = "apple,t8015-nvme-ans2";
+			reg = <0x2 0x59cc0000 0x0 0x40000>,
+				<0x2 0x59d20000 0x0 0x2000>;
+			reg-names = "nvme", "ans";
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 270 IRQ_TYPE_LEVEL_HIGH>;
+			mboxes = <&ans_mbox>;
+			apple,sart = <&sart>;
+			power-domains = <&ps_ans2>, <&ps_pcie>;
+			power-domain-names = "ans", "apcie0";
+			resets = <&ps_ans2>;
+		};
 	};
 
 	timer {

-- 
2.50.1


