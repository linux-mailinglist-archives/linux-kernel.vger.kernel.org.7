Return-Path: <linux-kernel+bounces-874437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B25C1658F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0063BB84A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246EB34DCDF;
	Tue, 28 Oct 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfQiRtps"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A3034DB51
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674116; cv=none; b=HEvXcAcfU4cVsHkitbAPgzi6cEXubs8UMOO2kDgkXop7LWg2q+5IUsfsb5jwGk7eBO0HVfZ4uvuXhqYSl1EXG2np68bhM7gupgXWbae25AhMnrXGBdgK1pkjl8OTDb3JGdATWdYD2cOCfjmEpghnCtvjUneRiNxYqWSfEHLTXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674116; c=relaxed/simple;
	bh=PwsyC81v3tRrRPNuJHDHL2QzEBY4a5tRjjnrba7X5gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfzIglBzX86FlQ5EFX+Z+iDstJ3boNEtzfuP1/T4YjCm1TF9OEON1TQtUDurUlzHVbPMtcSTgAKs6LN1qfPrR7MmmQPtuCQmfurIoEN5mRUM873LGwK1j4u9WR+kn1ypPDJ7Bxb0N4KdNcs7093Vm71T3VD8t5EVwzCVzj8ircU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfQiRtps; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b67684e2904so4554642a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674114; x=1762278914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+55/dqa9+0HC3hZu/kC0nj8fjuThSbHmQ5+76wIXkDU=;
        b=QfQiRtpsQbN2zW1X7O6Dw1bjJRSy1kbL52ymg8E8UgOinlJZ+2SSRn1ufSKwiGrcy+
         Ytn8i18n0Q/nKEpsNAhyTr/snTbdxuC4sajkMSPh7IQjWs/gyXW3OaKl72qGMAQ2KruI
         k0pXcL9m6DsR8mIKkYT9KCSwCdw89BqlaC+QJ4QQaqFdFjCw7eEsRwycBQf4qH4vLzY2
         szd9ZTBd+3gbhgOyBqCNb/Ljevou3lG+RmbRJOOjqTZD5UywD8oBcA1f8T7C0MIwrqKc
         Toxwy5Q8CFVs9WRt2z90Nb+4QyTCFkCSpn8Uf1t775Z9ZPFyPkKmYxrHpN1Z2GiQTQke
         L8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674114; x=1762278914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+55/dqa9+0HC3hZu/kC0nj8fjuThSbHmQ5+76wIXkDU=;
        b=ixpVz502CynteJ90TyxMvEboaNcpcW9HBrh77SEAhqybMAeZBW0RGqrsJPg1fXGACo
         oWCMTCz56NVBQAdF1NZbkvI85G0EV6/X/r6JDHWZt+nFKnoi7sEFRcQodJznOzkP8xfq
         R27l9S1OyFNs5OFSQuaa1+g+tgVMMHRIOqTW4KfYU1E0kBuJBic3ERPd2R6T2p7/ADiU
         a7liwi953vt28LvAGyTSRLEv30iPfr0Qs/XVcVZdLX5xEXFPQHNby13DGVBZJDFcx5O/
         HLNIVWR9mF6Ue9wSrIxPmPzghe8R2PwxWhex0//zKQ8/uMgJbRXOtJGX5uI86YhVG8iU
         lGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3lSGdKSfIiuGpX9GMVkmhsIchgZGcjsqkAQEPCNgpDy6W+app7W88qrmJFnYO7PgC/S493k7SGO8KXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YznJJvWDOEscRqkP9zqFyG4P2XiOrmFOS9oMQUFDaNflBlAfxSU
	lwPgsPe2pyarJM71oRbwirz0heVZO6mKjEd2TZzuzlF2xLS0Jlc2zQPx
X-Gm-Gg: ASbGncvzH36N9Li80JPJ3p9+fRmhswPGFW5dx4hT6EbSw/KZfsK5luoo6f94ifm4jWp
	/ND8yXarAtIUzVrehmB321gHH+yue96+gT1+ENLnIXr8QefaGUIMhf7mTvpk2m4e6uaD0bGowK7
	jvAUoX49PeulZJ9JWXj1h4ooQmyCfkWOV2JeCqNf1s+wn9RYfuLlV3CR5Nx4l/rRjf6UInY9Il/
	Sr1dCXev6faik2jmRSioUNmI9fadGOAZSjwvEV/faqokRL6cdIieawzgRYksy3cr+vwhVjApCbH
	CT2JeXGEqF/hr6ZBN3DnL3LgSyWQ8uoI5U6EkOAZ/dM/uSEfqa1A9O/8Ve8qhF0gjd5JvF5VeLs
	8GfsFfzafxlkSAB/yE6dd3VK1KGIiCc4JW9plm3CBOtIIj+2DSiJjZWzqYdtBFyjzWNodr2qRpS
	tdm5ixKT/O4Ut6Qarax9hhIQ==
X-Google-Smtp-Source: AGHT+IF4dKtNRfxxNp4OrXB9wZEZoNLTOJhqDtJGPdpTZiD9T/kISh+eB5h1ld3hQ9XZZ2q9Va6rVw==
X-Received: by 2002:a17:902:c40b:b0:293:e12:1bec with SMTP id d9443c01a7336-294dee2c381mr675755ad.20.1761674114059;
        Tue, 28 Oct 2025 10:55:14 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:77f0:168f:479e:bf92:ce93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3410sm125713005ad.8.2025.10.28.10.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 10:55:13 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/5] arm64: dts: renesas: r9a09g077: Add ETHSS node
Date: Tue, 28 Oct 2025 17:54:54 +0000
Message-ID: <20251028175458.1037397-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251028175458.1037397-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add an Ethernet Switch Subsystem (ETHSS) device node to the RZ/T2H
(R9A09G077) SoC. The ETHSS IP block is responsible for handling MII
pass-through or conversion to RMII/RGMII.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2 changes:
- No changes.
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 2acca4bc1d3a..8a530c12a6dc 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -270,6 +270,43 @@ i2c2: i2c@81008000 {
 			status = "disabled";
 		};
 
+		ethss: ethss@80110000 {
+			compatible = "renesas,r9a09g077-miic";
+			reg =  <0 0x80110000 0 0x10000>;
+			clocks = <&cpg CPG_CORE R9A09G077_ETCLKE>,
+				 <&cpg CPG_CORE R9A09G077_ETCLKB>,
+				 <&cpg CPG_CORE R9A09G077_ETCLKD>,
+				 <&cpg CPG_MOD 403>;
+			clock-names = "mii_ref", "rgmii_ref", "rmii_ref", "hclk";
+			resets = <&cpg 405>, <&cpg 406>;
+			reset-names = "rst", "crst";
+			power-domains = <&cpg>;
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mii_conv0: mii-conv@0 {
+				reg = <0>;
+				status = "disabled";
+			};
+
+			mii_conv1: mii-conv@1 {
+				reg = <1>;
+				status = "disabled";
+			};
+
+			mii_conv2: mii-conv@2 {
+				reg = <2>;
+				status = "disabled";
+			};
+
+			mii_conv3: mii-conv@3 {
+				reg = <3>;
+				status = "disabled";
+			};
+		};
+
 		cpg: clock-controller@80280000 {
 			compatible = "renesas,r9a09g077-cpg-mssr";
 			reg = <0 0x80280000 0 0x1000>,
-- 
2.43.0


