Return-Path: <linux-kernel+bounces-865973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB65BFE757
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1583A6E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B79305E0D;
	Wed, 22 Oct 2025 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBS2Gpsq"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C88305E19
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761173737; cv=none; b=T3HrQGUvKoDvi0CxO5SvlJXIgohPPVxiXNsm0iUGU/xNrdyGJwkx5MVQNPMzA1u4W2rjuMQ57xdmblHgZN6DmKoQfRvuMoy/PGPCSh3qua+lO9GkYtBqLTsoSqx88V+mZZuKFhik+fImlPhEfRvsrGNiFDw+BfuPl3LibADOZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761173737; c=relaxed/simple;
	bh=jXpe3FWCpQUX/yPmnJVd1DXf8MBuRUFgjgrR0h+DnJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h/xr1KtZPxyeAS4xZlR6GW5xlA8QXwQmUMP1qtG5SFbIKtS3wQg+uTY4Etwud4P4Fqm6VoeSY/ckN3JC8+j/jMMmGeXNlkrbqUkHHLS0vTStUVnqSWvDLl2ESRcgms0BnIPT9Erv9jlC4ylB8wQ62X7dpZeXPgZYoaI7H8N91lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBS2Gpsq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso269168a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761173734; x=1761778534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6jfzJ65e63ENjO8fdUhho5J1IrbkDS/V7pwquMxujQ=;
        b=BBS2GpsqJ4ZBt3X5NibW8tzKdg+9ZOvdyDbaaFaxmK1lGNwgis3p/hfcv5Q2Ry75A6
         XX7u+VDXncunzFeudN2rU6WYn6fcm03Mvsk+a/da2W3vKEkjSwQharlaqknc7dd9b9B1
         giE1Hy8uQNvxAxQpxH5BuWMWDyCoTBtyCIiD4/7q1Ptrrr6Jc70NzAfxG5EYprxwEsOn
         Y7E3yK4YXuiPG6yf7Dg1kgScCQ8i2ab+2x/kjKzo1r1hJapHzaz1K2HF3VfhiS8M2t0T
         MRNgHtwjdqnHMpn4LaBIZoE34UnyTXSba5+T+djizQY1Gog/tjxb/WW8BjlOGc2Mgw97
         kbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761173734; x=1761778534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6jfzJ65e63ENjO8fdUhho5J1IrbkDS/V7pwquMxujQ=;
        b=pS7nNrdepfaP43CXKDcuw1R6KfrwRuAr5Z1IqvtASdBeTNgD9cA/ldXwLqK23i4de4
         +/ozVuWJ3ktL+4lzzYI/Vt/LnhHwqXLkIA8EFyaRr72FJ1EiodfC0BRCj/R4P2nVa767
         cwbqIszc/IvfassUkI+1FTU3SkTEsAPMUJrP9aRJU8ZSuIWKsB3F6IaFbDCj9lmvNRYe
         YTPNcs0p6A4eoX+o6kLBBkcvlbuNs2YIFTVXyiBNgQ6tyrBTPQR3oqpx7kc9XOEYjCAW
         e7kJpzwtyhpWh4N7PPB8nVj9iNBH8NevAg+rO41C5Pz3yNQXJwY9vaaTLRvlcrnITOYL
         eeUg==
X-Forwarded-Encrypted: i=1; AJvYcCWKVUOcBZRa9+lxuun2T+c526Wgf7O4iUbLA+JSsMKdHTLrWMfmHO+QWrQMnSUYS30QFj5X5wh/4+9IElE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoxn8gnw39fuyjvRqtu9HTXMZCylwEE2xh2DHb7haN+b/6MxI
	dJsLEQLRSzTEZmRp3tYPHELgbFemctDADancR1D23mqjb28zHzZW2VqD
X-Gm-Gg: ASbGncvafGcX4CVvgXng66tOKZaMSbwZGnZ+zy0/SZQ96xcVBaQ+lS9XrHzKHVLNnHS
	TtH4T/tTAnU1XztpZhntylWZTKK7gNdBBFZ91RQZkC/IO3hkbOveQHJMExeJ+C2ZHZnewb8J2s7
	84AdgIGpnFLw9lEo3JCo4hDZsh/+EdFGplD8rPx8tJN1mUrAOX4x/hynnkraWGPH+j8nej8q4n9
	7wNKb8pBXidKOkSHL8Ltun4zqhO7pcvZzxrDew2F5FmS8M1tfOhoClKizcIANQ82+diZryKoutF
	C3vz08oU7kEvFSuY60N+htCdXUytWiAXOfl1RgIVXt/usgB/ur0/YPicwZKjN+dKPQuKfVYctSS
	aHdTaKvRehP2HEizyNxbly4FdeAd5ftW+EhbtiZjvuTOe7/z5JU1O1I2G6d30R3OHJNpQD9dhvB
	+yzDf7lcntLeZiwoJL0FBGZTx81iRgNdpXmkezpNXn+5ie+A==
X-Google-Smtp-Source: AGHT+IFkISWylZTmXXKWNfi6f/Bk/rTCvGgQ01lwVN+2xfhUjSVC9e3mnZIfqUNAmHDc9CA4YwGE7w==
X-Received: by 2002:a05:6402:3514:b0:63e:19ec:c8e4 with SMTP id 4fb4d7f45d1cf-63e19ece4d3mr4907540a12.28.1761173733370;
        Wed, 22 Oct 2025 15:55:33 -0700 (PDT)
Received: from localhost.localdomain ([176.221.203.198])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb3848sm156665a12.1.2025.10.22.15.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:55:32 -0700 (PDT)
From: Jascha Sundaresan <flizarthanon@gmail.com>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jascha Sundaresan <flizarthanon@gmail.com>
Subject: [PATCH] nvmem: layouts: u-boot-env: add optional "env-size" property
Date: Thu, 23 Oct 2025 02:53:24 +0400
Message-Id: <20251022225323.189114-1-flizarthanon@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices reserve a larger NVMEM region for the U-Boot environment
than the actual environment data length used by U-Boot itself. The CRC32
in the U-Boot header is calculated over the smaller data length, causing
CRC validation to fail when Linux reads the full partition.

Allow an optional device tree property "env-size" to specify the
environment data size to use for CRC computation.

Signed-off-by: Jascha Sundaresan <flizarthanon@gmail.com>
---
 .../devicetree/bindings/nvmem/layouts/u-boot,env.yaml     | 8 ++++++++
 drivers/nvmem/layouts/u-boot-env.c                        | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
index 56a8f55d4a09..5d526d960103 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
@@ -46,6 +46,13 @@ properties:
     type: object
     description: Command to use for automatic booting
 
+  env-size:
+    description:
+      Size in bytes of the environment data used by U-Boot for CRC
+      calculation. If omitted, the full NVMEM region size is used.
+    type: integer
+    maxItems: 1
+
   ethaddr:
     type: object
     description: Ethernet interfaces base MAC address.
@@ -104,6 +111,7 @@ examples:
 
             partition-u-boot-env {
                 compatible = "brcm,env";
+                env-size = <0x20000>;
 
                 ethaddr {
                 };
diff --git a/drivers/nvmem/layouts/u-boot-env.c b/drivers/nvmem/layouts/u-boot-env.c
index a27eeb08146f..ab32bf1291af 100644
--- a/drivers/nvmem/layouts/u-boot-env.c
+++ b/drivers/nvmem/layouts/u-boot-env.c
@@ -99,10 +99,12 @@ int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
 	uint32_t crc32;
 	uint32_t calc;
 	uint8_t *buf;
+	u32 env_size;
 	int bytes;
 	int err;
 
-	dev_size = nvmem_dev_size(nvmem);
+	dev_size = device_property_read_u32(dev, "env-size", &env_size) ?
+		nvmem_dev_size(nvmem) : (size_t)env_size;
 
 	buf = kzalloc(dev_size, GFP_KERNEL);
 	if (!buf) {
-- 
2.39.5


