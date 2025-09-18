Return-Path: <linux-kernel+bounces-821878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AAEB8289D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EDB1C20FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4721230D14;
	Thu, 18 Sep 2025 01:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6Ah4Fy5"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD245223
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758159818; cv=none; b=jtWRU/dHunbFCCMKivtKHNeI/H2L+IyyrK3f5dixab/mC2na+HmIW0vcY8qHduezLrd49HpvY4pjM/xnqPO2VOn0bZxM0pt2BTT+WREi5st+DKGcfi25Nu5macUnYzUGnoTOg11H9tZd7qlMyVRbeSyGDKDIWEClMxDL4WAMba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758159818; c=relaxed/simple;
	bh=UrGxr/WjtT928xmbCCKU5+v2Ur3oxLYlU77CDE4u8No=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CwWy4RUXZDwR+jkquKAcrwBR18v2ozyHrz/NuKjNjONlgjnkCd6BbpNkivaX7VDeOo6/DDBdiXRYwGvxA5lmpLZ78+cg32xRspCMxtmej/yKQBKDLa9r2TcD7nU/Ewwi1845G5QIb23+UkmXOmFh86Lfrn9SJeCPG9IkoOmlA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6Ah4Fy5; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-78de32583fbso2361136d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758159816; x=1758764616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+l9K23yh6l3TvW8w/MfzE09CsujDDpfaYqSz07+eVdQ=;
        b=S6Ah4Fy5BvYlpmyJyghQ6rOyRf+yIrZRFuWx1AniLYCC8Tfsrxfkg5cXovWWKMpfwl
         zn8jjLY/zYqIM1MJkKYMr6eyEL4Xutmd/qJNA4GmPomqfMxMUMNuxysQ+ylr2xUPExM1
         hJiNa+EGViNqxvIsvH8J1D9Iyblil6iRT6V/2xTWsbG0tbzVesD6msVgcbGV+73kuWhY
         QOrUF5Nb/ZNHxIxqB/+8/+TjBTNVqpYpiSLCLMvvhxcFKFfrnkMgTuGrFyXmY+YTI+5q
         4YsDy6So5A3ihrDbWG5C/QRoTse3PxOyNQWfiK4avqzb1dBUBivFcxN06OvL8HrQl3sY
         RYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758159816; x=1758764616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+l9K23yh6l3TvW8w/MfzE09CsujDDpfaYqSz07+eVdQ=;
        b=OFkO9YCbviaa/yb8VZAiUCCMsQEyev3d7yVvA03L3DyJ6KtpOtIfS2L3zgvj275Zjk
         98ICMpwrOQZcojw14xV3G3W5PZlbVpxovO/MCiIUfqPA5WLCAI+sZ7sCWkNYBFDT9xCQ
         tBuD+yHf+eC4/+wOM3QasYjr8al+Sk8P3kxL8BNr1C/lwD1PRYnOuZDH7+CcypxJA6KA
         rBbabwva6dQPyerP3FuzWunLzz3iM89vZoiw6rb4MXtY/39QAdH2yCx7qCl5pRGwYKrd
         rjSTkATSwqucz63SmELHB0mECB0svyCzyAFLMtR2JT5CteOP6aCz9psFlttq03S30E54
         jpYg==
X-Forwarded-Encrypted: i=1; AJvYcCUR9IXVcfNtNq0QfJcPAFE0vC40m16dSvhXfcIBX6C9TY6+wr0PlidqrHaaXWaf9drK57Rmk4b5BQUT2mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUX1SpgWI9it+3EM5f2Qd5+7xg1PtABJvMfqFTUJBy4wwX4RHQ
	BWo5wUzMjQh5lFr3yXweYjpgSDQUavPRYP+MmLY8YcXPbIMVa6YUqTZ/
X-Gm-Gg: ASbGnctJADNBiUjMEX04bqVHfTtmPt4nX5QvHEEGt6Hj+GA7lCw3GQDZu8j4CWcLUMx
	df6UjvzgM9z7qzzUqOej4GHKIxQk9+Zn4F8H3K1pJhi8fY0HV+0NYxaVqzFMLhfWbcFj9Zpzakk
	KzDvmCpoNuNnQOOzwVrq94k4lM5KXUUXdPjjrhZJuE/Lok6wt7/75XWQcRM3CCCBkSCRzm+XGOo
	8+TiD3rv8y8OtWRTyl9ckZAeRY8plukSKnJJgUTzgHFRhK8H4jYEeYW6U+dpuJ+BJrM1IoykW+J
	f0QaEzIyUcQYBseOHPMPJrQl9SbF9F2EYaYlvJq+ycAsvWhq2eSHm5BbjIv77uvyLTmR0rdfLyb
	cYwvMv7TX0BvqETyKAaLeYlKbms3VUWkYF3Bt3uZ1DB+c3dLthm796Kbv7N8=
X-Google-Smtp-Source: AGHT+IGKxnkq9Yna25gDDHM/UBKhOjdM3Em76x+D0aBlAB+6RbOzXElaevH4sYxDOsPcW3TRYXULaA==
X-Received: by 2002:a05:6214:3482:b0:78f:5313:1417 with SMTP id 6a1803df08f44-78f531316a6mr29850696d6.32.1758159815844;
        Wed, 17 Sep 2025 18:43:35 -0700 (PDT)
Received: from rogerio-laptop.home ([184.148.194.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79346930bbesm5191506d6.17.2025.09.17.18.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:43:35 -0700 (PDT)
From: Rogerio Pimentel <rpimentel.silva@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	alexander.stein@ew.tq-group.com,
	dario.binacchi@amarulasolutions.com,
	marex@denx.de,
	Markus.Niebel@tq-group.com,
	y.moog@phytec.de,
	joao.goncalves@toradex.com,
	frieder.schrempf@kontron.de,
	josua@solid-run.com,
	francesco.dolcini@toradex.com,
	primoz.fiser@norik.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rogerio Pimentel <rpimentel.silva@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: fsl: Add i.MX8MP FRDM board
Date: Wed, 17 Sep 2025 21:40:52 -0400
Message-Id: <20250918014053.696710-1-rpimentel.silva@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree compatible string for the i.MX8MP FRDM board.

Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 00cdf490b062..8bddf1f8a78d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1099,6 +1099,7 @@ properties:
               - emcraft,imx8mp-navqp      # i.MX8MP Emcraft Systems NavQ+ Kit
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
               - fsl,imx8mp-evk-revb4      # i.MX8MP EVK Rev B4 Board
+              - fsl,imx8mp-frdm           # i.MX8MP Freedom Board
               - gateworks,imx8mp-gw71xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw72xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw73xx-2x # i.MX8MP Gateworks Board
-- 
2.25.1


