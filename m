Return-Path: <linux-kernel+bounces-835854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57583BA833B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1E6189BE84
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1FB2BEFF1;
	Mon, 29 Sep 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsH0QbCq"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9F2C026D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759129058; cv=none; b=jGAV7+h5fQh/IsfXmZDsQzgGsFFrytd7QQlMMQuW6nMxMJY7vadLkQamMTb7xlzyGnECZMRHwBqj8zVH0wuThhXObeaJJoUC5TbS/Kv5hee1kZVOQje5G5Ekx0e7DE5SoI3+PH9BkSF+NJerTEHZA5ekEfqNY7VhG6umEtFouoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759129058; c=relaxed/simple;
	bh=MkXy8B0HvDpu3XB7QRokGYJw4lWQNt80EBtTGcgIso0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peEiU+a6m2N31pfgnF5FALnZK8xbQyPthFwx9v4qJ7D5Sg216l9Ufu5P0CJT4dWQCnUofkIq5hB9wbqFmfRrmtbdNPnqJ7CsUABtvd3lEgEAxNCjydRNaA6ugl4NATTwsWGXmOYLvsfJi5K4Gfe+M3/mhtz+WCYRJzvKNZF7iMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsH0QbCq; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7811a02316bso1995860b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759129056; x=1759733856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzgyK9PV21LUzCc3kELjlfdCuadwZ4YNSm8kpUWXn6s=;
        b=OsH0QbCqM9VfA3L6Q2MXi8CDbIvAsi8P5xxklr5vSQ9qD+gaPoyLAuY0LwzA2biB8S
         SGquCGCWlrMsE6sONWoADao3QMi93cay+RgUXmb9GcGnyaJbKn9og1PMrs0DI/86F7CJ
         6TQmuItEQKGBp7QitYkgayxxZVGax7tPfqo91sPnrtZRpfkqewNBOb9mU5FD2Bvl+JiO
         FgZDa7g01Nd2PchyOV45TWBPp8ebAD17UNycs4x0qwGXlAdOGiHJhP7BLvSKoX8nTz5e
         o59aMidehSoN3l4C1zUFxvbTsX0ugvc4Kg3H1Kcjt240nGRmjO6rWUj8O4h1abhBukbo
         +rlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759129056; x=1759733856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzgyK9PV21LUzCc3kELjlfdCuadwZ4YNSm8kpUWXn6s=;
        b=ZQ7K6oxALbiYghccxrLbrvrzJGGXmLSHbY1rmUcry6UCldIKe1/VxsI7Q6LCFb7gR1
         n5ER3QzzxjBK32kuIfgT/A+sN9ybt6jEO4iFvJatxM04J4SXRAQEhoahkHJG0oK8S1IK
         lWw6fpidXcfxsC726TWb6BtxERT71H/19DOyXltZ/TPMWbWwh/LHRg6dfS0mVfcWpPd7
         WRF8umadhLJo3JXehlzlpFQ2As61NawNSnS5EL4G7yVGBbYXhP/IXwk3cJs7GXecPArt
         XDEjXdXZPEYo1MMiOtRMZCxoTuOzqJdkEVmXZNfXiom7n5xypRDFCR4Xt/3cuTySdXop
         HZoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG+RliAb4C2iZYB88DOi7Ts7mXQEDFWivWonJy4Ty76TX7LDDOuXM3/R2G9GRe1lZIPODD5IemcQ5MpMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/hdQmSf/ZRLgFpjeXpXOnIypjnnypX8SG9g2PGBRVcdtuLzPs
	zHRcgWAy8+7S5oriXSek+OGfjNKYqk/gZbVuNsOU4oHk2blIsGpRt7YO
X-Gm-Gg: ASbGncv/fYfdZKFhUZtB3G6d82r7tggL3XgDg26lYwNysZuGuBoDiO9iOU+RtQGvwhU
	azTqf0FIMWUThIqWkedmB2kEqJLDQNzCXRmvujInX9+sk+UNhrLEHbQTijr4wJylLCOUihOTB4X
	zssGXVLXvyO0tX3cStFkZ7e7v6YNL+ZOIxqKADvHR3cikbrlIFX5MT9fGY0uXnO8v7oWw0R5xSn
	vqPcW0Q7wwtjK3IscxKDE9HhwLqLioqgeqtW7sn8WewVD82JfLDXWC/HhIg+PfqVchSnE+HVXkG
	EtetsJsDzuBxGw2STntleAyrFINayOfUCn9uRUxsclf4PJWI9PXfF2YhhgSQPZsc2p4rUOiVnr2
	+UZ8fOfFJ0sSqRnkhVSlgjd2Vpw1VAHQdLaHnXq402ssTlC6oiv8cO380hZ2he78O
X-Google-Smtp-Source: AGHT+IH4i8/G2t5oPtUqYoiiGGusyxmzE1tEeQmVVpR1IWJ1EkiDqJkPlsoVlGwgQEV5FUFAV7yu3Q==
X-Received: by 2002:a05:6a21:3397:b0:245:fb85:ef58 with SMTP id adf61e73a8af0-2e7d184ddcdmr19240666637.40.1759129055820;
        Sun, 28 Sep 2025 23:57:35 -0700 (PDT)
Received: from localhost.localdomain ([120.229.16.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53cac77sm10549595a12.17.2025.09.28.23.57.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 23:57:35 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Document LinkEase
Date: Mon, 29 Sep 2025 14:57:12 +0800
Message-ID: <20250929065714.27741-2-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929065714.27741-1-jjm2473@gmail.com>
References: <20250929065714.27741-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase is a company focusing on the research and development of
network equipment and related software and hardware from Shenzhen.

Add vendor prefix for it.

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad..db496416b250 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -873,6 +873,8 @@ patternProperties:
     description: Lincoln Technology Solutions
   "^lineartechnology,.*":
     description: Linear Technology
+  "^linkease,.*":
+    description: Shenzhen LinkEase Network Technology Co., Ltd.
   "^linksprite,.*":
     description: LinkSprite Technologies, Inc.
   "^linksys,.*":
-- 
2.51.0


