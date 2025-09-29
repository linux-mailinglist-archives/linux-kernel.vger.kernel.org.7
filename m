Return-Path: <linux-kernel+bounces-836254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF19BA91CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61668188419E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED3D305E19;
	Mon, 29 Sep 2025 11:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5HlwL4k"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301FF305948
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146574; cv=none; b=HGE9zogcxuf93AXP3xxWolsjKva7zYxLcHNt11JFnjM35fu3SM4w6iQetWkkdULzKK5OoQ/Xfh1HSg9Xrr6UJJ4vPj1jwkVUacW2vGz2wB8AIjUULxNSEwDG8LAY6k8z8NjJVapq4Z9yocSeS6h6jCdWDW0xbP8wqQbWDWCs8ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146574; c=relaxed/simple;
	bh=tXM1CxOM4vCqq8YBToQQUXlfse+Xjw1zD+k6o2Xtvs4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUV7IzZq8kwCJYV8NRIaOif8crIeMJok8bvSfatgEFonviHwJPP91V78RKwxm4n/KtcVisiS12xx1g0wgZqbmUPcuQhFwWHpY24zT6u2jQvrmFAN9yDXqzOxVAutx0/Cs9Jov5Ok5Pmlb02b/nubW4Cec5WK4S5aepfWCuaZiTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5HlwL4k; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso28036175e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759146571; x=1759751371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIsMYN876VGoFoSvGb+9plrH+kv/tFGDMPOel0bH+u0=;
        b=J5HlwL4kNc05SZ9J6SRAi7OwzOk5KM1fTOB5GEXLyQwIRsqW2488L9/EKyzSiLGDY/
         dY+zVpAyGv96Hcp0Qv2nM//MeW7bZLMWa16XcHHZg7JOIiqzNgRIuPDBsxU/I9g3hPRl
         jGeHaTGVqPLpdY4Vr4C8LDBbfjNa6BQfDF/MSyz6fkdEVlePBtRNvBtNe24od/EXKOGc
         +ooNMv+A7BuvRoWnfY9RDab9wqyuuIF/8JA2OldIJ5925+A7HEFByKZQEbVzbaFphAC3
         ZHCRGw2qOX5wl/aoc3Ll7qhkFzRIn6dm7hCGRn02KAm33CrbEVel4r640tjCAdJe+ZeE
         t/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146571; x=1759751371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIsMYN876VGoFoSvGb+9plrH+kv/tFGDMPOel0bH+u0=;
        b=p7TQnvhCZbAajknZVtU0rfirDMPoQvkTlnBOXCV2cY1b63rIEyZ5K6B4ERw2eMN07U
         4CCxGR1ZlvKVrallrDUnW2XDelvJ8Nk5r3sTOE6a9DgyPuuN4LiTxLITrQ3x/cuoQZbv
         rSCLTBdwRG6PNShVukuXRiEt9jtPnmMq/BEy8Q60zmHKP+HR7qnmClVXzKMNOunbkN+I
         LXaLMOQ6XZ3KheQHFNARw7/gEvjg3wnW642ifUCtrdxkXADbKY2vQhcJjytU8jHSALgT
         zgMvggiczjwa3fWtTtaW6qTMrFh6dQ4awpzGehKTxsHJ1ugFv5r2Z4Z29mAeibXUSUuh
         zLdA==
X-Forwarded-Encrypted: i=1; AJvYcCVVlurtQZnu0RF9PO7M/sLCjAjBLZ6Vl/8U1ntPEUrrQje5a7EO+TAKDYK1XI+YZ/lqw0XBKTiQHOpF2gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCCTxGCNzM5hTjdUJNfc1wiJ11hsgQyWEe/bpZG5lr4vE61t1
	HOty/Dv6iDw+Uy+xX15+IJIDiqF216l0DuadTU+sJRHA13cUajOWa3uM
X-Gm-Gg: ASbGncs9hIslxJxJJlOhvDQiPx8NIEUTp4mSHsK2Q+I3+GneLPR5jL/q5BhODeiT0IX
	aydcOI3hN1LypVPdS5GpWokd1IZs69cvH5G0m49tQF0pzRzS4ratdnrA9nCeTpIWBDiObniIdMh
	kEb8Mqa4BZtYIsCpmGDbBO+DJtWp4HJ5Oo1mOOXVXvMAD5lCKs5Xq4F+hPp4J1z9xh6raYte/Rq
	C0NABBrz7AoRuRQRGUXLoIOzsYRo/DsY1qusNOA4E29GIsHNuD7hTOzxdOVyAF6dj6epXhvgs09
	TD7XHrfAv9ZSLT0g0sXrSgCwGofxepRqIQJMSATQKI1Yq+bSOe8+mLWVeoZMsol6QG0/8n/op6k
	Ml1BvI6g1alyjTFOnzu7RbuOyvtYW9irtxX+2VyBQ9FZTSZQaG9f0wNkfTMQuCFK98hXAcWQ=
X-Google-Smtp-Source: AGHT+IHF2CwXyWBOC4BcrLBbsAVVrnt/gxj/QYgegqRmUtsThNiGS8+anT8fVSz00MWmGGHmAtEBwA==
X-Received: by 2002:a05:600c:4689:b0:46e:32f5:2d4b with SMTP id 5b1f17b1804b1-46e32f52ec4mr147677375e9.37.1759146571403;
        Mon, 29 Sep 2025 04:49:31 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46e56f77956sm10030835e9.20.2025.09.29.04.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:49:31 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v4 3/4] dt-bindings: arm64: dts: airoha: Add AN7583 compatible
Date: Mon, 29 Sep 2025 13:49:14 +0200
Message-ID: <20250929114917.5501-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929114917.5501-1-ansuelsmth@gmail.com>
References: <20250929114917.5501-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN7583 compatible to the list of enum for Airoha Supported
SoCs.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/airoha.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha.yaml b/Documentation/devicetree/bindings/arm/airoha.yaml
index 7c38c08dbf3f..df897227b870 100644
--- a/Documentation/devicetree/bindings/arm/airoha.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha.yaml
@@ -18,6 +18,10 @@ properties:
     const: '/'
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - airoha,an7583-evb
+          - const: airoha,an7583
       - items:
           - enum:
               - airoha,en7523-evb
-- 
2.51.0


