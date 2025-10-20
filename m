Return-Path: <linux-kernel+bounces-860377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 332E0BEFFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC773189EA5E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3D2EC57F;
	Mon, 20 Oct 2025 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HduMSBnB"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE12EC569
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760949571; cv=none; b=AQX26oK3ECBgZ2xHmcZJ4pAmOGWemihKnBNMQHa3s/dkJ21EbywWOjypWScW/lXAHqIHuqKeitVRB61a9awt8OXmaipxuH4cpubBdO+FBEhKFHT8sTrXEH7e5XA6sofUMY+idvXOM9RIQoqMQpCl/pUu7Afz+NJStjyM3IwNjI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760949571; c=relaxed/simple;
	bh=Pgz9s4yM7alHVd1TDNAq4J+mf2GXq5txdPu+yTHwbtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMDQKjWR/Jaldp5gBx1hG5Uh5cSSSzXeRJFBhptOorbPGe7CJSxKXDtzcG/fRMAklbnq9wZDoUZ5nGHe45fEyOgEgGv9L0bldTq5xb2TJIpaDSTSTbIDUdYu9iVcM7QxNFRz3gSUABt6prtMLwqypanZNGMMLSzn1e5IDXhZdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HduMSBnB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-339e71ccf48so5711763a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760949569; x=1761554369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIc6x2UqQ/+/MYkhVAsuU2AYMkhOe+CBEJq109yOhQU=;
        b=HduMSBnBEOZuCc6toEwtnhdKgGStB2kPGmNMwRYujWOmm8k5LLKIxe1M/MtG8gNH1d
         vC8Y4GKv/zLe2wIpQqnwjALuNL1wyHCMTgiZhcb/0mzs0MLFN1tpra3f+lhBHGgQAH/n
         4PqG9zzBUyMr8t9QuVYHY2JEh3Q8vrvHeSlo3CCS03OSF6Q8vABCsVvKMB++XGOzsQYR
         y1id2PwmELb57NZBRjDGBSpDDBxya/IOuca9Ck55PW/B0WXH53whckxK9jFF8VlXuO+w
         A8Bde9wgaQtS7LCQ9iAeReQ0bLMDTGxbM/guTKYnEV9rT3OC5mYbuo+btCmNXEcLta9E
         b5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760949569; x=1761554369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIc6x2UqQ/+/MYkhVAsuU2AYMkhOe+CBEJq109yOhQU=;
        b=FSb40zV0bwKNiiLwnp+unyKZaG4B55RGoHxAIpvkoFPvAyAls2EVIr/pF2CdVmNnpn
         yhp0G3jhdFtsizTLJgR1eXwYcXfOZYPUs5gOfqy0QOxpRqSUxi6YM9Ctxw3csmnfBEfM
         r9SNjdDLnSqTXkFwemH8jy89k1+nipSl2IPXL8jAN+OVQvMLtdzbtR3Od6fUwHu+m4TN
         fyHh1KhMHho676b1vk1GbdVkacQGf3JSO1RnhwEelWHZmH4ghCcQLmd0ja71j/InlRbX
         9n82jI1PTIv5Qvaz7hRywt/coWOTD4IuTgBXZOAyGdJ37XUBKkNsgzsjP01HLktWMAN1
         f6eA==
X-Forwarded-Encrypted: i=1; AJvYcCVE7TbdAlChsw3N2rfaKqV25srm9vsBdtb/wFBf3Nlhi04JNtccCP+JZURzBCW37kz5RtevsaJkEAdQIDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLR0ZqhgLZVhyT12kpOn7c+XW8l+CR0A9jspWhadKcavVZaHJK
	Dib9pnRWY+FyYQXN3M+3IwhdfgFoiXNSctfEQn4Hy8XlZtBCEmVyrmYv
X-Gm-Gg: ASbGncs25cCoXZ5Bipb4OxPDpYYeiA+89gj3MabLI7uydtBe4FdUkXV2R8zzXlBlbtb
	GhHr+5/ZTb6GFc0GvJqTxYP4ZFajXFXFt4iBWeIpHW2Cz4COpACaTg5IKeFO7FtZD9Svm3shPoJ
	d/hFq7hpzQ5SNcgwsokFVmtIwK5OnjPCvtLoJ1AF9sNWNrMyNe+S19kaRNBzrl/REvpPgY32yY0
	1pIsW19EAP0cjZ5rMVkMwLw0QY3w365lLypJdv++GmZOmj1fL+JEMuigmmFpGoJW9m1zz4bzgUR
	iWCpYLrUjG3ieNFCzWlT38wgDilSQNZpE/dB6QrorXJYYMElLG4di7dyBVw5QNNxK5gbw+DsMI8
	2colZi/4axQiHk1SwBw+2bqwjJdhSIyB80gM3PlHRQSlkh+eHhkWwzs1yvsGoWpuRTOLqedOAis
	slf1rVDe9X0bIM1ph2
X-Google-Smtp-Source: AGHT+IFkyp0InjhjZaNKMIDCmJDhxuvBQ0nCOQaXFWprMyh2MBS2FRaBpj3aAHyvwBdPHJzM/Mh1Tw==
X-Received: by 2002:a17:90b:5386:b0:32e:9281:7c7b with SMTP id 98e67ed59e1d1-33bcf85da05mr13624650a91.3.1760949569204;
        Mon, 20 Oct 2025 01:39:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5d0b4sm7062386a12.29.2025.10.20.01.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:39:28 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: Longbin Li <looong.bin@gmail.com>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/3] riscv: dts: sophgo: Add syscon node for cv18xx
Date: Mon, 20 Oct 2025 16:38:32 +0800
Message-ID: <20251020083838.67522-3-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020083838.67522-1-looong.bin@gmail.com>
References: <20251020083838.67522-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add top syscon node and all subdevice nodes for cv18xx series SoC.

Co-authored-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Longbin Li <looong.bin@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index ccdb45498653..42303acb2b39 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -25,6 +25,32 @@ soc {
 		#size-cells = <1>;
 		ranges;

+		syscon: syscon@3000000 {
+			compatible = "sophgo,cv1800b-top-syscon",
+				     "syscon", "simple-mfd";
+			reg = <0x03000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			usbphy: phy@48 {
+				compatible = "sophgo,cv1800b-usb2-phy";
+				reg = <0x48 0x4>;
+				#phy-cells = <0>;
+				clocks = <&clk CLK_USB_125M>,
+					 <&clk CLK_USB_33K>,
+					 <&clk CLK_USB_12M>;
+				clock-names = "app", "stb", "lpm";
+				resets = <&rst RST_COMBO_PHY0>;
+			};
+
+			dmamux: dma-router@154 {
+				compatible = "sophgo,cv1800b-dmamux";
+				reg = <0x154 0x8>, <0x298 0x4>;
+				#dma-cells = <2>;
+				dma-masters = <&dmac>;
+			};
+		};
+
 		rst: reset-controller@3003000 {
 			compatible = "sophgo,cv1800b-reset";
 			reg = <0x3003000 0x1000>;
--
2.51.0

