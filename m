Return-Path: <linux-kernel+bounces-856903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6679FBE562A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77E3B4FCD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC42DC79A;
	Thu, 16 Oct 2025 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jakqgNWY"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548C2DF139
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646355; cv=none; b=U2kRuf13r4v0lvCIXEuib5EUVV/k1fXLUYiSndGrjmnLqH6PGPpLqpTvopTY2i9BzAOvd4cfMfSOM7jVqBi8SovD+1lhICosOxmrS88FL0UQkYsSfuDuUzwVmF5DoqjiXLzbFXSS1S6yrzkuff3gXy12c9KfnJQBiqiDqCzb6DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646355; c=relaxed/simple;
	bh=KO/OF/yd4zXyKj31xoVGvcnH26x/3OY20T5UcmQHuto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcVYpXGp0QfQEOsTEiXoQci1kB5z6REE+w5HO5L3IBo8jKb5RjhSQcx3b810JKovBnYkIhdRhGfTQuEYSWOU3BTE4gg9ylHiqwljpjNvdxdzs5Z3k0V3tSAHvClr2VpPn6X/rXGD+OauKJsUAu6N6qAenvrmO1hSLSnDcFN5ZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jakqgNWY; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b633b54d05dso830967a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760646353; x=1761251153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wttzWlbBbcXOKu22uHo1yP0Fp3HmGcEmEwEO06P/KE=;
        b=jakqgNWYrtMjPhWDL2bcdj43jCYSmAk2FRYfGyjy6BxH+/RVvjwgZFaS+c4++LbZyW
         4/+olxMjuFFTlMtHxvDfnIlqmSXRNHIaz8VDFk5XgiAhHHjRhJlV4TJPFJTjKvh0QcXt
         cHoCX50MQOysfLen7BdS/Zw0Fp8nJgUPiGGfl57e9sck32E3K7PPHaPt4ORhwfwUQFcj
         Mz9E2XFaP+OVyFSiVXLQSAkXn69r2k7hprGF4cGO+cA9ABgTo/mZpqQJ+1mgpo5SL4W8
         m5Gp5Cl5i/Lb+1oaUlE2RRVhDaA+h3EF2ImGuRuNPOa3qpXusVWl7tjZsNaRqFnNLBC+
         nyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760646353; x=1761251153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wttzWlbBbcXOKu22uHo1yP0Fp3HmGcEmEwEO06P/KE=;
        b=FMXyN4qxKAGgIH1ok9F21qmTeE1Jbb0Xvq8JbjxnpAQrlGyUi3RnN2a+AFusakNXlt
         XtOlauLYTZXjjpAkCvV0O+YJ6b9MVNpiEbBKNY9hVAUPaPvyF8/TG+KnNbyWex/Bj6v4
         8ph+3MNEXAnrPYpa3F7C7QcKYBZ3km9HJ8Y/OjkV8XgWFE91787WYwBvMo/YlMgIh0T/
         UhOG+iiVNkqwpte7FUFa5/NEGHmaxJ1M1pZcq9JnnivaSb1yo/B67xgtljd8+asXEOZY
         SsjI24Rn6cTkhtDFUZAfpug++tF2K3/EO7pIJJwR7rdTB5aiMFyYhRel3mYZUwWV/yre
         dgeg==
X-Forwarded-Encrypted: i=1; AJvYcCUeTk9xkk9t7uVuLo0RJixNSwxQu1xCmghbHZm4t5E8cKY9pSSW/LdOFp+gsTz/Ndp/AmcrYLcjwz+6C0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOc+arBlQ9zFuYLP06gMOG2+iJBlPa/5M1xia0wMklk0/RcwIl
	QdvIp7b6b2BglTy1qhM2bhhQBGNZlYrxpIz4YBsMwY0niby8zIiW0xjz
X-Gm-Gg: ASbGncvTt+LPZ4eLK/MrZSNLLFGO3A+aYan6pRq0/sdCFxt5c7vEpk6sgrsSSzlVc41
	j8xeJbQh7slOsnclmC2ZZk6xFfbiLUmYEWBs8mzdk3FwQCMVTPW3ECna89DWKgg08M3BCChg7zc
	fB3ufK9QHLGhTh7ZZRERsMC6x07/pCIa9mpI8MCTzQLTvicFpo+56jtA4+6SOmRkvYFRELlew8W
	sX7IzaCjZv5ZIfFn+swxo7/UGoE0C7StVG1SE+6ocHHGBgAErhm+zujCPxXc2GYfPIrz1sqx4wH
	6N4xIQ6lzo0peZgEQt0chX3lH8SCILGW/2yZR8LN+HlV4gEJVwAEhqk0rwrY98qsFpLh8Apri81
	6b+VG40w4HeIQZYyCH+XpmgeDs5jMl6Pyik1Hzjaa/rETUTPYj50J6BwJlqyXYZXJN5WgWAovxO
	bXuiJvNvufEyFjClYR6KJs4Q==
X-Google-Smtp-Source: AGHT+IEA2KqFqoK61jqqN2bdPvqxteC+UfFzMoBMorKHmALcj+3M/XVuPeuE+6pP40OhOBGgSdBthg==
X-Received: by 2002:a17:902:e743:b0:269:8059:83ab with SMTP id d9443c01a7336-290cb27f849mr8850205ad.51.1760646353370;
        Thu, 16 Oct 2025 13:25:53 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:a396:54ac:a48f:c314])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099af9131sm39577735ad.103.2025.10.16.13.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 13:25:52 -0700 (PDT)
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
Subject: [PATCH 2/5] arm64: dts: renesas: r9a09g087: Add ETHSS node
Date: Thu, 16 Oct 2025 21:21:26 +0100
Message-ID: <20251016202129.157614-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016202129.157614-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251016202129.157614-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add an Ethernet Switch Subsystem (ETHSS) device node to the RZ/N2H
(R9A09G087) SoC. The ETHSS IP block is responsible for handling MII
pass-through or conversion to RMII/RGMII.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 2d2db858f48f..882570622486 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -270,6 +270,43 @@ i2c2: i2c@81008000 {
 			status = "disabled";
 		};
 
+		ethss: ethss@80110000 {
+			compatible = "renesas,r9a09g087-miic", "renesas,r9a09g077-miic";
+			reg =  <0 0x80110000 0 0x10000>;
+			clocks = <&cpg CPG_CORE R9A09G087_ETCLKE>,
+				 <&cpg CPG_CORE R9A09G087_ETCLKB>,
+				 <&cpg CPG_CORE R9A09G087_ETCLKD>,
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
 			compatible = "renesas,r9a09g087-cpg-mssr";
 			reg = <0 0x80280000 0 0x1000>,
-- 
2.43.0


