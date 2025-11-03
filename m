Return-Path: <linux-kernel+bounces-883431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D4C2D753
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 18:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C853AF42C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 17:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C831B102;
	Mon,  3 Nov 2025 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThF09iwO"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF1731AF2E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190263; cv=none; b=teA5BtFiICJBH91+5jhVAp3EoTJqP94RMg8GvD1uomV99UYViZGYVXn4dNvaZA9zy9vNe6w0dGFpRl9R4WIVl66+t6GK9CwvoG8AnLXyzKVos7+nbI1HQki/n7LgEPL3+MPDtosQeqoKp0tesoxH85ZhrE7+a1GCDL797qC5+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190263; c=relaxed/simple;
	bh=oJ3OmNhOvxqd1qIdx+Md8cFm686Vdj4pRlbydhNYjB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgSQGD85nYjOQ7/WJ2km1U9QCcexc46QvbBop0HdwjpRwM26oLhKalroahuIvLlE3NQBkSzYYZWIlrUcnHwMkcHFTRga+DFJOA5s/LeAkzUl31nsvoB9gUSkpE+o0rwLWLzAnc3MHwLm9GnO81Hog1pt+T5WWsWy2T8oGGVSp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThF09iwO; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4661136b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 09:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762190261; x=1762795061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyQp65YrshJlf/E9g4tBCluPHZ0bWpe/t0XipA0RiBk=;
        b=ThF09iwOoZ0770s7eTOKthUYdoKTxlnwe4NKe9mVldnPo1zqBvFU+8TSmrZ7BtDdJc
         Fep/hqdSzVw0P08gQ/qcKahq1QSjJgJ4SSEYG0Xmf4lYVGJZALiXCq3aKhMNHvSvHf+j
         SN2W7h6Y6Jo+4unukTr/46lwq+dtgn39rIk9/4UJEtiLi6c9TVUw2qP9SjT5SUqMA2jp
         qE8nZu3WBdE2DQq54ThKrVViaeuCD6bS9lnTnpuRd23jQk8kTNCYQHeORtJ8ZfHkD1fV
         XPOMJoCXszvzj9KqG3CSYSRRoPmx2WVa179XmToogswVut9+99R5ohGCOsdfPGNLgUey
         4woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762190261; x=1762795061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyQp65YrshJlf/E9g4tBCluPHZ0bWpe/t0XipA0RiBk=;
        b=EjnO6HyA/j/7EUXC4VLlA0nS6tusVpfVda3IMUqtnL1+/TTWki/tdsTN/atOVefd5g
         WopLw/dKoJE38MjLj9wvLfXBjkndSHBnPAQ6DcJxdQNnDRmX138TFgwjVU5LXiaz6175
         ZQDukdEGqqNvqrl/z9gn66NabDY9FBH3YJjBqqHsULLJY0b74aNliczv17AMqGcNnBmc
         VeJYoMsN4NWLl/bH/trZDfTmNT0Dao16wOMECamBpbRqa9XUW6Zt2LJZgvNPHiqiSazi
         fbHwOg/oCN1ET1LrClZ4tzdY9kyJbn3BHY/NSuvDrOJdAFTeTK1XkzAVdsoeNG7zTIeG
         6QOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLdpzHX9uH0dxq0brNLvP5cjto+NqMreN8IIPS1Bie61Za0K5jLRVvMHNNjbgo5WENkck8gY+bE2GiWH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy543p2wD0w5VXLh3296vvi1dhEljJpQnqIupEX5jXqtFpMC/Cb
	CogG5R4UhDDwq2ARF2JQS0bwj8VzL610Eu0unsDJOMkljrAeZzEy4BZF
X-Gm-Gg: ASbGncu8jC+TfOkRt8gQI0KzIVVZs2DStMSaVep0AtBeqr8h4xkBBqJsdWFDITAndVQ
	qIXqP9O8W5zZ4+XSvFENfVG28sJS5Bnl48qkwWtYNMQc4P0xapPdLIs9W70kS4y6fsHREvXcHeC
	1eSkIpHmJT+08Id3LU07JmvxR/rh47ZzdDQGbaPwtkAAEqQttpj2TiykeKcjpA/zyNm2S6g7+bg
	1FloDqTwbW9CIu2Oavk6s1l1fZeqz45ukbQ6ZkitsNQErI8U3dRKZ1mbJIdFLN8xCCpKGszqzWa
	R2kIRu6pqEUhL6z80dcYxn6R0XrveGaEeH+N9VkS3S/s5Ymi204BCsSbuHwLM5zZFn32oyOShqX
	Q3u1Uha2dKlGuxkG2tod491d+3qWCqnbK3pA95inkx/Aua/IPSDakBFwxixu8hBaDVq6aJ6YD2H
	d5WJlLoRFrTQ==
X-Google-Smtp-Source: AGHT+IG2SBCsPp3obcuh2HPn9F1zioqp77l2USqTslrv2MAJmfMr3FJvfEFhjKUR1CAermd0xiOHng==
X-Received: by 2002:a05:6a00:2e93:b0:7aa:a597:6881 with SMTP id d2e1a72fcca58-7acbf6ab4ecmr204256b3a.4.1762190261426;
        Mon, 03 Nov 2025 09:17:41 -0800 (PST)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db28d3fbsm12148112b3a.43.2025.11.03.09.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:17:40 -0800 (PST)
From: Coia Prant <coiaprant@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH v5 2/3] dt-bindings: arm: rockchip: Add 9Tripod X3568 series
Date: Tue,  4 Nov 2025 01:17:01 +0800
Message-ID: <20251103171702.1518730-3-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251103171702.1518730-1-coiaprant@gmail.com>
References: <20251103171702.1518730-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents 9Tripod X3568 v4 which is a SBC based on RK3568 SoC.

Link: http://www.9tripod.com/showpro.php?id=117
Link: https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6aceaa8ac..9b9b3d2c0 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -25,6 +25,12 @@ properties:
           - const: vamrs,rock960
           - const: rockchip,rk3399
 
+      - description: 9Tripod X3568 series board
+        items:
+          - enum:
+              - 9tripod,x3568-v4
+          - const: rockchip,rk3568
+
       - description: Amarula Vyasa RK3288
         items:
           - const: amarula,vyasa-rk3288
-- 
2.47.3


