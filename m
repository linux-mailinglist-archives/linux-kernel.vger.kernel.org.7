Return-Path: <linux-kernel+bounces-747490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404BAB13471
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0668918977CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90123534D;
	Mon, 28 Jul 2025 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgU/sgon"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F775231A24;
	Mon, 28 Jul 2025 05:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682194; cv=none; b=m6oUDSxjtYCRAj5CUru6MGxbmqsa0i4Dfl7oc5EQtr9eakJAD/0Ma9WZLTC31PAlBKnJP05YGa7KziqO/dPRFvquBuRG4uIrFtIZA1vbdRV3gqEBIrmsjShmZ/mInjV7p9P4jrMsawSwMOZuZ+DZywOr8sbcVaGFwpwNsAERI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682194; c=relaxed/simple;
	bh=ch9+9QrRpLqE587D+B0MNMv4gcQV3IP3nKnptRnvXSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBJrMLrgW3Iwye9ew++PGr5szM5gDxrwPnDt2zlH83wbGjQjZNkcJnsCdlSw2Nzn/SMsQh24me95Yvr01DUhKhE9AgRUxFrtzVUovA45opS91AEKZI02XUMdFL7LSehv1zv2B8bbA+1ei4EKmhU+EAH/QwDvxZi4B5SzkGnGd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgU/sgon; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2403ca0313aso3194485ad.0;
        Sun, 27 Jul 2025 22:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682193; x=1754286993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbL/s7XfG5xt8Ti9QG9pgz/kChTPn+PeGi5taFv6Wts=;
        b=kgU/sgonX5kiVQ33Eg8dpgb/E8+mcM4I14HBN7jq2xu6hCmqKlzjiubguNEGAJw/KM
         xPX7uG4w5SUND65SV091Dma59g+aFnDJQwWg11wxO8gdnvKG3bEtDxk/yTJ4NwFUg6Kd
         JJeeYDp+Kbgw3ZUAUZCjLRHmzpZ21jeuIsGmD90Jyf78dpk1M90hpYzVYEdm40/CAYOA
         LtrPBkd62jZRcrSdatNnXjOJQ8uGckff28RUg4grcbOCzrIwdpE7yRa2Vv883jb0+ZH4
         ZA3rXuzNEvJgAkSAdLsXp66k8jmD+TygmZPu/c9l9XmQ/BJAhjBlD10DAU+gZZxctUs3
         BszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682193; x=1754286993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbL/s7XfG5xt8Ti9QG9pgz/kChTPn+PeGi5taFv6Wts=;
        b=QEhwe4OPULhJY1a1J3IszKsiKQMmhsShdj2g1jlMfgDhe+3BmxQm6GHINzLkTqAR8Q
         8O8mGCcZ7OumPr0m+ECI1jnr9JjwMLE8HzZ1i1XQHbxteRauqVzw5kgQg6OZebh4Wdnd
         HYqqBU6NEhIbUxGa0kQQk9HY0x+Qh2y6Yy23Tcs34NY8pKIY5EES9Li94zzVvvb+/PT7
         nEdLJdP26OOT0LkQVmQYd9OXG4YVBKWRYFI/IXQ7hzqBIdPE5YQHVm1h8iXkW52jkcx2
         WKFPwEpDdI5hKz1xBa2wpQ2f9wCsPhCSOCCN/BsCwYX8OZMpLBwR8Oxz0OHo6icyD9nY
         /EDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj9dtRhT9HvO65DNj/CN7i6KR6zant1lo0EP21rK7Cs5CBQZxYzavAEjQHjlJhGAwaph/L96WeO9CR@vger.kernel.org, AJvYcCVP/O8Y2k7NPbzLiOSgvWqdpw0bIbrC92k0ujXd8histwLYVW1p8PlLUVjiNL3IshUekU4pkIf2g7caDyss@vger.kernel.org
X-Gm-Message-State: AOJu0YwKnrD5l0fCHzdOjMer9Jz6Fq0Iq4kbZyaLEfd5PdWh4H9/dmhW
	DPp24KOC9rskSxgie6BwK4JO4CO27vNWwjKg2QvpSmHIMCX8cUrovzzg
X-Gm-Gg: ASbGnctV4R51b9OaPmxg1aGGOQekDVkwDYRoHjOLlPJGYqE73DDl7cA/rmQJpx06c8T
	EoK6yTxQvDK2mtEzMlI5VNaZ8M9tOBvMq7nt8ICHriDHDStG4egJKANIX7SVd7GPBuDOJiE6ULR
	2x5LZ10wZSZWTTQ+YwC/9zk1BqJT6dbiXV0BQWx6WrOzCwvdFlgOr/pv0dCuziF/jHYrhNKTi6e
	F2VTDs87Enu/Uqc9g7k7DNNsQagdbhC1vkKKLoe2W4O0dMwaCZZIar4U30tj5L77zhGaFi2rFkW
	zTMpdQIkCS2UuXZ5ZXXBEBJr4ZpvakrbkYlmRxNtWqbc+sr1AK3KBtd5l9LNfrST0QoHj/0+XyH
	PUSKeEn6yNH2FgfA8Jc10m2EPkTqdt3HkMPdHt0+vPowOgGIgvERhqWZxWOHSWwNlITzrPPdgT0
	Y=
X-Google-Smtp-Source: AGHT+IGjBjOZSuFuT3oqj5s+Dx4Lmr33TfDS+NDJuKJg8oPiu53W+GX6Z334iGOeg/ZkK+U5oI36SA==
X-Received: by 2002:a17:903:13c8:b0:23f:adfa:3a63 with SMTP id d9443c01a7336-23fb3021609mr159555545ad.16.1753682192519;
        Sun, 27 Jul 2025 22:56:32 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:32 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 06/13] dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
Date: Sun, 27 Jul 2025 22:56:08 -0700
Message-ID: <20250728055618.61616-7-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Document the new compatibles used on Meta/Facebook Wedge400-data64
board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
  - None.
Changes in v3:
  - None (the patch is introduced in v3).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..0c9d6a30dce0 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -46,6 +46,7 @@ properties:
               - facebook,yamp-bmc
               - facebook,yosemitev2-bmc
               - facebook,wedge400-bmc
+              - facebook,wedge400-data64-bmc
               - hxt,stardragon4800-rep2-bmc
               - ibm,mihawk-bmc
               - ibm,mowgli-bmc
-- 
2.47.3


