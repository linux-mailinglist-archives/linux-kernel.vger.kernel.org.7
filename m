Return-Path: <linux-kernel+bounces-757806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774F2B1C6E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24356624416
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A52B28C5DE;
	Wed,  6 Aug 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDPPjUsF"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468128C5AF;
	Wed,  6 Aug 2025 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754487514; cv=none; b=Jxk9kISoQ9Eu8c3wlODQVtSVZMcB8PbWPkVBfqJPdCJo/okKf0zASPnKCmhar1lfemD4P1QmPdMcgPsrkjb1Xl7PiNaZAxobwjAJ0FWkW2oF07uYnE4UnD53dIGuk9CtzJ5AksnvTOdYYltg3aFBYIDOIppYN4HJxD78FpeB7Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754487514; c=relaxed/simple;
	bh=Ywz1KbJmjrnTrTPcUbkqyeSEiahjOffQal/pZfaaIUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSfnsNcjW4DW5nZoI95746v565HvBCmhtRQygIAglZj2oxjPEg8V5TURZdjxmPqiNdoGnsuJ4m9hPl+T4RMU6YRkRD6f7Jb49eRx1Oq2SU+ki+hLodXV4RfY06q0xDxIv1yxiB76/yHlGyUuYo4zlwP7aDOuVs6KnkMMYerxIjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDPPjUsF; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61589705b08so14447429a12.0;
        Wed, 06 Aug 2025 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754487510; x=1755092310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE7TCvCxG2zRfjEqEq1jHdxAR83d70+ntgHwgKLT2O8=;
        b=HDPPjUsF9p7F92WrkfvTuFgFPjKXfY+q3EYErNvStLVNyiWAufij/vMoEfl0qg26SU
         Iv3GTx7q5K5WKayzzxOaoEF0hH86adxkfPplgos04zQ8r18UHoXTvMFNj0lYxwxz3wit
         fRis8TElVjWxo2vGVIZVKC+IDwcWc0/+YCd4PLXSIRlOJvgu5sEHSpTAwO3xcFz7zljl
         79Ud0OCP41ofYdF2BuFPd30BdQXWE9Ky/fyhp+97xk4ORWtS3X3GJmmYZHxgTN8y1/vi
         UHMiVj+SY71LoBpDKfwI2KhEu922rNK/OF9ovHJHDWRf81qMzCTbRrqIvfItYJreVL5S
         BcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487510; x=1755092310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE7TCvCxG2zRfjEqEq1jHdxAR83d70+ntgHwgKLT2O8=;
        b=D2oiW+5BW916E0rtHHifOt45Y9FbO56zrIEuYeSaXVhuQ9AJZzb2FcFITjPa8h6G9U
         ZTHu3Th2qIzz0S3d2tbd3dEF1ENmdSZlqVaTsWYxIMdQiYKnWBfx+Z/d5LefEtRO/x+h
         hCUVZ0Fu7xSHwG3eYXbCM3hEetyiku1zidyrkXjOF7N+USvmo/SX03B/iWX2cIoOhCdI
         DwdmBvKJ9lEuQla2od4TFiQSXjEI4qot5rv8O9PYSDT6TU701hErMS96qjZr7QxxkEnG
         7L3IAO9lpj/i1okRsgkeCR8WNIYafAW7JwxyunV0UbzlqjdonRU9fdGeGa/u15BlJA9T
         oz0w==
X-Forwarded-Encrypted: i=1; AJvYcCV/qUMulWd83wON40oePgzvzj5xCgpzH0GDYgKnezXkYE+nwZpODOjwVAelE3Q+VNdS2rAIpW46hTDCBI7e@vger.kernel.org, AJvYcCXpaj8+lNezF9sz+N+sqb8DwG8E6SZ8stylVR6fx8Y477gSpABakcXjuCfq2t4bBzHsr9PPyFjJ1I/a@vger.kernel.org
X-Gm-Message-State: AOJu0YzE48MnVxuYFTE8R1DiFIiRrO0Vi02V8TD9sOqgqLJNpLigWATU
	q3RCPkWPqSiXir7tjBFhIDWPXI2V4Gx6ltdrgPeV0bn6gIddX4btMTbYJV5g9H/b
X-Gm-Gg: ASbGncuTltLHGYJO5nesqiWesOX8vbjifkemfLNK5k8eyeNep4h4dcq4IipPb8+MTuA
	KT8Z1ikfVmxT9Ef+Z/vyq+hJwqknqlZmXeMqOVyvAIskdGYQS6Yk4fBiOadHsGsz9LenS1OCSkT
	wtIVGdYf/ztC5wpcb8lkV23C97m2eZglfFA7ZoShmNfj4jSUdm6VkfmHFBbmR4ch+nk/aYlPoaw
	gSgn+R6ElSJ7c+vchcPBRaIZ2p7lZ25wWBMNylimgNZRyE2EqSDM/ScHZxitSQFk8fqDF4XIP0R
	5eqXaon8xyUHnamDyGD2g6nftm7reh2wBz3INT/imFsfgGuFFo9eJ2UIwQPgZeAJ8caFFoYGBYK
	UJ85kmbKp59NYHaxoWTNvfO3EpHsEsVtomgvzyaF9Np1e6k0/t49AYDjst8I=
X-Google-Smtp-Source: AGHT+IF2ymGd2AoFy9NFAFSdbbtre8bTkfbWoo2XU03adYW5ZL+BPbzq5aCYNXd1svLTsa/+uCsjAw==
X-Received: by 2002:a17:907:1b19:b0:ae0:e18b:e92f with SMTP id a640c23a62f3a-af99032f881mr258825566b.23.1754487510304;
        Wed, 06 Aug 2025 06:38:30 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c10asm1113170666b.116.2025.08.06.06.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 06:38:29 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: phy: rockchip,pcie3-phy: add optional differential phy clocks
Date: Wed,  6 Aug 2025 15:38:21 +0200
Message-Id: <20250806133824.525871-2-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
References: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both PHYs can use an alternate reference differential clock, add the clocks
to the DT bindings

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 .../devicetree/bindings/phy/rockchip,pcie3-phy.yaml   | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
index d7de8b527c5c..b747930b18f1 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.yaml
@@ -20,11 +20,11 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
 
   clock-names:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
 
   data-lanes:
     description: which lanes (by position) should be mapped to which
@@ -82,10 +82,15 @@ allOf:
     then:
       properties:
         clocks:
-          maxItems: 1
+          minItems: 1
+          maxItems: 5
         clock-names:
           items:
             - const: pclk
+            - const: phy0_ref_alt_p
+            - const: phy0_ref_alt_m
+            - const: phy1_ref_alt_p
+            - const: phy1_ref_alt_m
     else:
       properties:
         clocks:
-- 
2.25.1


