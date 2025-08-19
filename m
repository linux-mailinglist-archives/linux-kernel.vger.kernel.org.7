Return-Path: <linux-kernel+bounces-775812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B94B2C550
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9601965B86
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3701A3431FB;
	Tue, 19 Aug 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmwpHzI0"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0B13043A4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609424; cv=none; b=tezBaPSAH7/7NMydh3M9fFsBZ6/Mm3cSh5h/g15kz6bUA02oZCoVfOnVuVh79erthZXKqGTJw/m30Q5zxAHmcGo1pD8GhFjFa9hH+KmggVqJawptprLctFhmQcoP2KR9MZW34suwNV7rsKYSkh6MSuIkkx52aGbEALkhqAjT7es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609424; c=relaxed/simple;
	bh=DurH8t9HvSvsgH3oRg+Ms+SKw2PItKWRZVBe+tEhchQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfOL8yVT/XHle2/QsYbRF1jlufbjHFeSQu4HcJ2Zwv6CIUlTbatgmPyK0N4YMYoNwPE/JD/mLYgrkiWOijaURvbylSkp1no/lOgtE7jtWJlvoLBv2ukSKuIyj8ugZjxBY1+ovhyMvP/751ZaibixvTQNrweY6Zym8WNHZDNNdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OmwpHzI0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7a01426so92303766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609421; x=1756214221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afUEtVliVjZtOeNo/hdpDwYyKku5Vsn6emnpI81Aarg=;
        b=OmwpHzI0iQfw/Q6NF320MEznRekpy9ohE7RN7S4PD+CXIb/rqGYsgoqkwHhrxb9rCd
         bSWYf/WeRW5NdZHafVFSuzwdtr9XvoUUcWPs50NpzWvNHYiQZw87wIx0qZew3a+qpY/4
         8pGGemugyV9l5EVF5gQO14H68i8NqYTID/bj7IeqWTn4r9a3KDPyG9tg/Fo+akEaI/aT
         gdMX3ZluojGwo2kKUOQGGtkY/pqlq1E4G1ZjIFFgEJZLx0hl2qgYps+KkW7CHMeFsmjt
         JeAGDEAoaoM9WC9fxjVYFwU+V/9c4Ytu8i9cx4HTzUqESa4Vifn5/lCx4gdKa1nlUkFc
         X4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609421; x=1756214221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afUEtVliVjZtOeNo/hdpDwYyKku5Vsn6emnpI81Aarg=;
        b=GlYBXz8hivNTtgANqX6K0+OBSq3HoNDzEacTRUQ344+UIc9hHCmTy4k01ujVeAhs4o
         JNAcK6SFbW7O09nheetMfr602v5sN9cm3SleHhcZncQ+XUAdh4W79kz7mtNcFE17HoRa
         DfmBSiZGvas9kRD1WNodZ0YTPP8lOsh05lxLLOi1CToGgp5wbSNzeaKEjWtSrrdOzQen
         YPlvPnB7zblbTg9lD5e0GhXwsAYS9DXsY00tFp3a8ihzNkskEJ9irm7IsgKWLsQuK0J1
         Swb7ZpyI+u8t4EFD0y/xtSU3QV2wQWDB9TppuRmV7W9GxNl75dxcuhPLYBydnnVVcAnA
         azBA==
X-Forwarded-Encrypted: i=1; AJvYcCWvDtdozEOwCVuy6B3K1tGnmSzEFVivXKRC2wM3zn3mm5wulticngykf8gcMi2Ztm4v3VvqWpTmIxzkgj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA9ieSkIpa7h2wppjmfR4vQOc6+v7GaazPDUxmn81vDqf53UDK
	HdOa8/fQOp6yCNUCfOX8RWDK3fs7IoxpkwnzIZ2z4NYW0Vl7CRILVstf/HTUkmFSLys=
X-Gm-Gg: ASbGncvVBKUh5WYmjjjXhVpaFoybAiuGoGzaSypKYVnCeLmIETv13fLnmXbW5OcoL6l
	JlFwrix97Ikmhma040Z7OW5AN9+9Lk2QqVIcZ7MWg3YiLr0G3elgni9uEgH9ppDRD64jAz7lqGh
	eQYVuf3Ybo05QfeCKrx30hTmJC24lW75LJKmDEGWpzKmW2d4b57b2IKc/L7UVX5IrhYbGt7OZqr
	SblVhOjokBs1grBnqG4GoNyod5kXt8YLyIWIvSFPOnUufGP3hWuRh/UU3NpBbrYjqSmYUjD9Xu3
	+cdKu9yXj68kBDkJJirLVvl/ndoNKs5JS2cD4rFfaIsTFVh4ioI4evZuWYut5Q28ipsOJJ6EL0p
	BaOfNXh4UVd+bYJ3WH/pU1dNa8WDjceH/GQ==
X-Google-Smtp-Source: AGHT+IGtLL/rMQjhxzJkRlPZlnKvsoJ1pZE187tn2bkOK0e/dPzM5466KD0MC8NA4ckzjg0aedgAGw==
X-Received: by 2002:a17:907:60c9:b0:af8:fd22:6e28 with SMTP id a640c23a62f3a-afddd1f804fmr139748566b.7.1755609421010;
        Tue, 19 Aug 2025 06:17:01 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccea7sm1005948066b.67.2025.08.19.06.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tony Lindgren <tony@atomide.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ARM: dts: omap: dm816x: Split 'reg' per entry
Date: Tue, 19 Aug 2025 15:16:53 +0200
Message-ID: <20250819131651.86569-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250819131651.86569-5-krzysztof.kozlowski@linaro.org>
References: <20250819131651.86569-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=DurH8t9HvSvsgH3oRg+Ms+SKw2PItKWRZVBe+tEhchQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHlED2RNTR+gOn2Nk2+yeF1Ihk8AB0mmN+Q6A
 BV9PMIiEuKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5RAAKCRDBN2bmhouD
 1yCQEACXqTIa98/3bq3O1JqYDp3gG6RAC1NUdM2KPR8Em28++Xh3z8FISafVDmkIsiK9DZGl/DG
 eimvXk1Y8oHTqKOzA3SSL8lMcT+v/nn/l5BBZDTYv3jmrizFHdah18lX/Ay2MAcTD0Zd988g38P
 1aN+Q7fUFiCofVUskLHo4UgNOWab9pNsqP9aCdD4Y1xp8V1QZp50ExH3c0qKxPCjsQgmXZ1+9o2
 jW/7FUo7ipHjHdmTNlH5X3ulXI4qRfcKU5NFleIH1BcBpTBEb7318kwlDSkuiaH6s9PuJ1bqFWW
 QvV4e3sj0Bc50dYmjB+CM103UFaVy2uRw7i0LC5tWVYFPgeZrPbKYVRS7MY7o65OhtiJGMp2IVA
 YPcBwDmDcphdcIm7ERMneVOe4GIBc377EuuhOcENPsu27Mcx492FNhIzXsY/2lpUvWm1ePqMbMW
 +Fzdk6VswXWJFynrlOHJuwi56zY7Sd6jty3/Pwe/dYZ3we4czC4QzUNbpLNPgViNA02XaorY+Ne
 yuZPBJFllB5Hf9ZbUc7/zhK2/DentWxlmgquwXCEVxxHQnbnxQEbRxktZKrebYFDyZUBwMN7ynq
 KBQ9MCU9F1ijlY1iouBVP1kt/fg5Ek2iVfBPou9csJYu8Ev58kkHbgqKGRvfiXkJRq/2RT1cdIN oyHSeQgK4x/Rv0A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Multiple entries in 'reg' should be encoded in separate <>.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index b68686f0643b..407d7bc5b13a 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -643,10 +643,10 @@ &cppi41dma 26 1 &cppi41dma 27 1
 
 			cppi41dma: dma-controller@47402000 {
 				compatible = "ti,am3359-cppi41";
-				reg =  <0x47400000 0x1000
-					0x47402000 0x1000
-					0x47403000 0x1000
-					0x47404000 0x4000>;
+				reg = <0x47400000 0x1000>,
+				      <0x47402000 0x1000>,
+				      <0x47403000 0x1000>,
+				      <0x47404000 0x4000>;
 				reg-names = "glue", "controller", "scheduler", "queuemgr";
 				interrupts = <17>;
 				interrupt-names = "glue";
-- 
2.48.1


