Return-Path: <linux-kernel+bounces-771873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B71B28C70
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68031C826AA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BF91E1A3B;
	Sat, 16 Aug 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="cu++eg9n"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139E824679B;
	Sat, 16 Aug 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336778; cv=pass; b=r6NsLYmEkHzev+rBTB3YEMhr7Lrrv51aZ2mtxtUqXp83hYfaX1OyzMHIrNh6qqLED7vHrzq7ZX7oUz+UA6xP+pAjFPy/3pjB6oHY9UStC8kyiIQ9hDH/0VTDk+DnCYFEGCm5l9Qfh4725MmIyVYRVTT0r8X4iyi/CwWojWBMnlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336778; c=relaxed/simple;
	bh=KBk1KwAODd1Zk/766TOzD3cy3Z16Ze3mqD9MoBF2AO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfCX2EaamUq1HEgrJqrxELXsKVK0x712AQgp54mqq3eqK5hR2l/RgPXsQRaFWGvjAVozxpGs9i0bxO7Zqz6FXSF25+llbZUjVw9PIGFm00gWV7sxFCCShioULOYU8Al8vRxcW71cP+L9k8PPQNYilGNQophzb9qdLEIa2UNVrvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=cu++eg9n; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1755336766; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZUVD1jKbcycpJoOHNYt6loehgxTSeRCDJag3kw2I2QnzA+ypHO88tNyQqye1FylJlD1mnBs+EFnle10N+R/eGNjCIxG3mqzHbqJs0kxF313+bGsVuJSNnncrc3GFzLfAGS+cfNNcC9QDsjFSP+aqh3fDaKsLYYIIUXdXWOQKVbo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755336766; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T93m/qBDDnHV3ndKiLSsbo6LGiGCBHHPOQ9wTTk4DHs=; 
	b=DC04lwQgdsvQi67rgSxznHA3hJeSQj2Vn4sF+M7mknA368ZE+sWzO65z/+0Ju4mf/Ppr2TYXDhl30iuhi3NciyhP3KV26N5Q2cAitPpbLF28HgiJxlx4YkNVx2J0GVy5mHZEBQS97evZ5iizG3IFwBjqd2dum3LqXErplzt1UTw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755336766;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=T93m/qBDDnHV3ndKiLSsbo6LGiGCBHHPOQ9wTTk4DHs=;
	b=cu++eg9n1Z7p9md9w6Hqnxk23dieTThLkzdyjxuBokoEuIYqdp/ezHSbfK+1hqO6
	oBfyAPzX3ddH45cGu8U090vE97Y8Etbx79Sjj7P2pO1yj2WxTvF/iSU5RaB1wnE9qiQ
	xPFKDojTlNQNYwmnC0/fK1aRrcTKLVhFuIy93c/f1xslO9VfoYLYlDsUxyd+dIvU7h+
	wiH4rMOGQISG1D+ELvvAa7Q/zGxYkaSLMATp4VAMSQRlEOGWZuBESxGWL25+JgoHrmy
	vjAzv3bsSSEMHPmsSEO603t/+CfCZRXedlXpNTNwJ2EtSCqdhF9UhXdtMlB9Nxi9ZaG
	Mxkbc4B6xw==
Received: by mx.zohomail.com with SMTPS id 1755336765084748.2338970354662;
	Sat, 16 Aug 2025 02:32:45 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>,
	Yao Zi <ziyao@disroot.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/3] riscv: dts: thead: th1520: add initial thermal zones
Date: Sat, 16 Aug 2025 17:32:08 +0800
Message-ID: <20250816093209.2600355-3-uwu@icenowy.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816093209.2600355-1-uwu@icenowy.me>
References: <20250816093209.2600355-1-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

As the PVT sensors's "T" means thermal, add thermal zones for the
thermal sensors.

Because of the current lack of DVFS, only a critical trip point is added
now.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index e9c81bdabed8a..a48eca5def606 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -701,4 +701,29 @@ gpio4: gpio-controller@0 {
 			};
 		};
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <15000>;
+
+			thermal-sensors = <&pvt 0>;
+
+			trips {
+				cpu_crit: crit-trip {
+					/* milliCelsius */
+					temperature = <110000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		ddrc-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <15000>;
+
+			thermal-sensors = <&pvt 1>;
+		};
+	};
 };
-- 
2.50.1


