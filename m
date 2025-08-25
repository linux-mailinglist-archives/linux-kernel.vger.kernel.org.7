Return-Path: <linux-kernel+bounces-784371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB8DB33A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17CD7A66F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110ED2D4B68;
	Mon, 25 Aug 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnS4a7BA"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92C62D47F4;
	Mon, 25 Aug 2025 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113383; cv=none; b=J3yeOLP5K5v9rDBxKrgMFIkBFugqj/Cmqf8d8ODsOXlv7j2r0T70oC7QpuNg97rIswveH6VIWc4Dg2eSf2yeU/570TBtRcphwt/LO5F+wDyoLuMNEchXL+2y+2ebMhgitH/IWo7IkHslOQPcHpqlK82hW+1ijMVOUvzEjfyhJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113383; c=relaxed/simple;
	bh=CYNjF9OQgn4g6Ftiuun6/MohBcP92VmI1C5IHAHtgWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4siiYonzOF8r0zyjg5pO7K8N2zHxvjUtOBOLWdrni6gWaNDrH0rngurWTL0gTlkm6Hroqss3W3jAbkoTte+H3u1DUcJInsPxC1r5cq1zd2Bm1+6kcg4OmYGn9gGLObepzFffzDDVv/58PQtZU42wgVNIH/K8XF2y0cI2dT3GkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnS4a7BA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24680b19109so11819255ad.1;
        Mon, 25 Aug 2025 02:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113381; x=1756718181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=;
        b=CnS4a7BAKUf4W+dLkVHMym3bibuHefnDxz55xzkhCuRQn3HYLJmTOh+kicV+nLo9dY
         QfoxsLxhfupVe6tt2NQfO31+NAPvemagTMVKjy6Bza63hKvQZHX5SCc52Irr9CZ5eBzP
         0hDrDhN9TTisKgCYpkjBKWauKuox6es0TE6E+MV0VD8xESqaixFK8iXTm59iLDKqBpIC
         cfxe9tRbLeFY7gOxpfmxOSx0Nu5BtMrfSQ9zIsLX7Fd/y/Cg61NzfWtnvTjVIyqWbbes
         6g4e9hl34m0Ztla+MVb4pDsubPpbvfFDRuVMG2AdXdUzxglc0dq877lKs6Xqx97J7yU8
         IR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113381; x=1756718181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Te1xVrQgzDBuz4rdm+oAY4F74VBZ8yuKiz2U07Pbv64=;
        b=LC0mgZPog3YfK6IGxi9oz3yf/LrfJtKUtmYydipd4ruUxZZ6N1UAngOWf1yk/yk1qh
         mtntGBLPwxc6pkbSoHMOiWrvtxjgza8YtdYror/8mCxzax0u45PfwmAKwfZa/81xtaVS
         skuVvZYsGeO05wW3Z1ObzyiqADWWwxCuJelQ/yTPE1tJjgpSwMij0iCeVnE/fZifkSPI
         BYSr3fxPqu2y2Hz5IFbBGD+e9VutonmzJV2GlaN3oJQclywdIQlZvCb8MkwI56Ov1ccg
         96MyGBP9RqIr6ktTr+3PzRzD1rNqbPzT1Y7B1bUPR3W138xpxqbOIxz43FaQu6UnPwL+
         S9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEha7HHBIk64TtsFGNF6hBp6LTOPzwRM+weOzBJ4iIhdziGGjvLo40X/Hv36es+GzUW9gpfphdGtrH7NlO@vger.kernel.org, AJvYcCVgOlnzyrQvd8/4Yy7fC/TRNTKz9vVKYg6frmm1EtsEa3q2pmbkPy2xo3sids2MhYkuIwEiKORTHzm1@vger.kernel.org
X-Gm-Message-State: AOJu0YyrV9v5XHeRKP9Xu39+ySLX6aWD3WnfnRbdLmfnuF60V4oDFgMt
	ZAXs6rDhLkWCi3o7xFV/thrE/a3By0eShDJoErKUnuNcPRROl3lnNQVR
X-Gm-Gg: ASbGncu8230AoeivoipUyRdG7BWm0NeW+NsVTkAgYABz5QwYgba8PUzeK1s+Qff87+u
	5zNsF+JIsvx0r+r/dQtdYvV1QIK2VUlQ5h6tFetOlIj7A3VX2y9Cb3RkLQl9cYsLCPguHY/gBlU
	YNWS64sUMFdlAExMIIGKKY0cz1fonj6pe4vUDr02pubLQu/lcQpFbjRRVZZIAqCwUnqftrQe0xE
	75MqYPmlLksG7EMZiVJlHyemTLOC9PG1ISsaSfqpdErC86DHgW4oBnE1/exm9B7q4MlCBcxysF4
	93//JnnCihr5Bg2PAj1FSaaUdY0d8ZBjAdJbIFH6NiO7GjzvnDR+sxj2CQJEzbtbqXxtk13cJMN
	mPkwRaMYBRkwkrmel95C4Y8kl13m1xl7Bo9ossA==
X-Google-Smtp-Source: AGHT+IHA47RwYrhQlSdnPL+YYSXKWvogaXdS7+aDOLyvLluP5swy5MJMTU+F1aS+P0WHsZaiEZ4Ang==
X-Received: by 2002:a17:903:2f44:b0:242:fba2:b8e4 with SMTP id d9443c01a7336-2462efaf1demr168678245ad.56.1756113380983;
        Mon, 25 Aug 2025 02:16:20 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2466887fc8dsm62873875ad.122.2025.08.25.02.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:16:20 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 25 Aug 2025 17:15:06 +0800
Subject: [PATCH v4 3/4] arm64: dts: apple: t8015: Fix PCIE power domains
 dependencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-t8015-nvme-v4-3-6ffc8f891b6e@gmail.com>
References: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
In-Reply-To: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=798; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=CYNjF9OQgn4g6Ftiuun6/MohBcP92VmI1C5IHAHtgWs=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBorCnSe7tdWkaBU97yy4wbnzIj/pY02k9llba3c
 I7lzujWLziJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKwp0gAKCRABygi3psUI
 JE7dEACzNVpLM+4i8uqFOcvOfkjW3xgay/vR53ye42qMYaEkvaP37KrBfyROeY1ZGEj31z6QKUv
 D4DPls/oRz0S0RP4ck/YVCFrpfljG3aW9Wq1f9DshvLquSf3e9ruU0QCi70tjs+dt538UoGJ0yh
 l7bl7MRAkV7DM23zcqubRmTY5F1z+yiLjdyaa37estt3dSJlcP/RhBg/K7YPpfH6vtq3ywLImyb
 K4/GkOhv+8aK+wjafHlMLooSlIix6W9m5iEGlO0z6KZT7n7A5LSYoVoX1182hCQMpY+6MV8wfXn
 ZDGRpO+Zqsx85UJjZS/bfCSzRpmAToQ01y0bD0WnPy1YjpChz4G1rPaCePat+OTgGDnmHmOIp+I
 gDyU59GEHTc4RUAQsBKxVE8swI7ILEB5DhxKSCuOORCf6DlQB4hDjxcduOA2W6QayDpDAmk6ZIn
 /bhAKiN7+cGq5Do5Ec74edy+NysyAtcY2eC9xIC4w589hMTbovRXpWOIaDB/F/MXdwsVgyojWnD
 a1dZjlZ5RMCgzDrAgnv227Iji6yzH5C5WQSU4qViyAcRO8z3CCKcZtICfRk/h1PvqniHJUUSVo7
 UOD+So9LIrnSMgsY/wfLY/Yh7fM4rFMlJliKNeIEygoIlMpmPrr/ja5jYXIsCvO6Q6UFS6tMy/V
 xEsbtftF5ap2cOg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Fix the dependency topology of PCIE power domain nodes, as required by ANS2
NVME controller.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8015-pmgr.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
index e238c2d2732f7944dc1f984a4eb647ba212b9ea5..1d8da9c7863e5b7a732888342de9d481f309edd8 100644
--- a/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
+++ b/arch/arm64/boot/dts/apple/t8015-pmgr.dtsi
@@ -658,6 +658,7 @@ ps_pcie: power-controller@80318 {
 		#power-domain-cells = <0>;
 		#reset-cells = <0>;
 		label = "pcie";
+		power-domains = <&ps_pcie_aux>, <&ps_pcie_direct>, <&ps_pcie_ref>;
 	};
 
 	ps_pcie_aux: power-controller@80320 {

-- 
2.51.0


