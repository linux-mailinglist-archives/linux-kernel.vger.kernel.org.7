Return-Path: <linux-kernel+bounces-765829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B6B23ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94189627720
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B8129CB43;
	Wed, 13 Aug 2025 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="x12OFLBF"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7579FE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755054824; cv=none; b=Quhc+kpGz3dXY+6nr/lAA9CEnTBd2PFO2b9ZqzTeO6tyMbqZqITUiH19yur+/cfsvw8DS4ZRiQXNu7l199wZzm3vkNuEIB8AGLyaT4lf51G3rvw1CfdiV0cPJvgX7PwnqbKSklyuWwWIEQ9nuLOb+02AFdPzpXy/mrKV7mz9m+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755054824; c=relaxed/simple;
	bh=4e3XC4i6uPEnWMRcXdvMk1P32JDvw0n2PeDK+VlwzBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxkfg6u4MQoMMqVq7lDtHjohcgHYgxCQY7XtCO0oWEtrssSiU6pSvmYuhzY1NG8BmXYFR7lf4UIG5hdN4t9XhLR3mzeU1sld6zOrhsyXMtBXIedR5xgkivBrQ6L94Ru1INHVZjJE8svpMxn4UeBkcy7+sUFvQPEt4v6/3vueTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=x12OFLBF; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e55b170787so2614755ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755054821; x=1755659621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8PhVQGmNNzCiMu9pw3hx+9YH1Eu7sHoNmFIOK1HnGfI=;
        b=x12OFLBFtGzsaCf0B2ke4y0asbbcQ9v81MB4w076TddKKCfZYgUJSA3F0AGZkn8voq
         uqCRgG8OD4vv3bPNJ+buSfUVVtbgRkU5OaIquRuZjcAQI35CAAq0qGUgliQbE5JyeWCb
         XeGCd4wGmoLJnpUXT1ax+tMV8RsqTTTf0NofzkA7h4MBsjrWFn0fmmVmiZorKeqYQRoR
         wQZHcs9Fbm2Bk39+nE+zaMudt9JJ7FBEzFJ5WhSlbgxBbqj0ghhRID6+ocTbcrDkIXVm
         p+y0paVLZImToJT+gFroiR0s2Hyn/rxoJZYecPcJwDnAHoXQGSg6XdxOUyxCs6Yorkl1
         WXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755054821; x=1755659621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PhVQGmNNzCiMu9pw3hx+9YH1Eu7sHoNmFIOK1HnGfI=;
        b=pQMDoK7ahEjCG7UeF0/fAwiKcAx9tSX0ybAbRXc01YhApl7gsU6687iekmlJwcfTCE
         L11NveF0kHPs8TuhdvVEjPqEjJg629/k2il+KRT+fiY1a6aBH2CEuZDrzfa3Dfu/Zm9L
         qugjoCsRuv6EvcY8lyIKGf9D1kGCfRxQwhOIlKJAAKHqfCFZAImJ+Q1ryemRnaRo7jBh
         4TmY0SCs/z5x8IU2pX6EuwgZT6HGRBOJM/4qsuGOPyLgacAgwxRxzi/0xqJLvQrCb/kL
         WkMczmINig+9mjqrgd4+i5G/iDSW0hkqYfgG82zB0JHUwioaJ8e5cCfY2wnaUWholOOr
         FF6A==
X-Forwarded-Encrypted: i=1; AJvYcCX9eUaYeIYxxkpoQjAAOWeiz8/5EOWjLfdgCrlx9vDUuTSv3g1ZeFoOH0dOLsfMN2D/CqrjJpimClQTRnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7yLbO4urmtUa2csNq6yw1apRsGnlSch15hWJdhyItCkiYvbbA
	ys6jeoduh39lzd9AN+cmsmiKyCecz2hvzpuXP5v4dDQhKry7oZof5Pb2pMGtKM3qa84=
X-Gm-Gg: ASbGnctEz8RrZAxLi2PgcvEmcyuKyL2ZavY8E4fEryI3jDUyoLlhtknK37OJw8Xya7P
	JAGnTgHPLQaCwzWLCmVr5rQYjwzkjTiJVYYoXQTZNAYHRaY+q/lYMzjUSO5uDwY2/R09n+GeMCe
	pEMJ7bMxIG0HHvdxQkjQ4w3pFcrZr0sHn7PheVkZPXy8w5jERsFn1DkKPdXOhkWKpUArWQ4xe4M
	mR56TaMs5vyts22nbp0wpH4S5zTfrmzBAcF2ZrIYLh9M//eI0WBXyWgcoVAEnNmQdqR4kaoIY8Z
	OZibkRXaXsxppKT4nI7b+a2B2/1bVAmaXxBcoN7BK6Krk2C2RcU2GwrXkfx5Bf5R0SHxXe8nwnJ
	UnJNge+Nu76z+WzNDitGlbnPO87gxpcweTz0VIvezsLl5vzpwu3Q1JcYAHoQvOWWy1A==
X-Google-Smtp-Source: AGHT+IHJ3cV6K51nVGXbggkk4n0mggTrNvjqK58YjsUKI/uGamOMw1V+7ccv0fj3Is/jMTtEld3VjA==
X-Received: by 2002:a92:ca07:0:b0:3e5:55b7:1eb5 with SMTP id e9e14a558f8ab-3e5685ab4f6mr13673995ab.11.1755054821496;
        Tue, 12 Aug 2025 20:13:41 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bcfecbsm3616330173.62.2025.08.12.20.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 20:13:41 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dlan@gentoo.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] dt-bindings: serial: 8250: allow "main" and "uart" as clock names
Date: Tue, 12 Aug 2025 22:13:35 -0500
Message-ID: <20250813031338.2328392-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two compatible strings defined in "8250.yaml" that require
two clocks to be specified, along with their names:
  - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
  - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"

When only one clock is used, the name is not required.  However there
are two places that do specify a name:
  - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-btif"
    compatible serial device is named "main"
  - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
    serial device is named "uart"

In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock
'uartclk' and 'reg' for nxp,lpc1850-uart"), Frank Li added the
restriction that two named clocks be used for the NXP platform
mentioned above.

Change that logic, so that an additional condition for (only) the
SpacemiT platform similarly restricts the two clocks to have the
names "core" and "bus".

Finally, add "main" and "uart" as allowed names when a single clock is
specified.

Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index e46bee8d25bf0..0a05a1647b5cc 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -60,7 +60,12 @@ allOf:
           items:
             - const: uartclk
             - const: reg
-    else:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k1-uart
+    then:
       properties:
         clock-names:
           items:
@@ -162,6 +167,9 @@ properties:
     minItems: 1
     maxItems: 2
     oneOf:
+      - enum:
+          - main
+          - uart
       - items:
           - const: core
           - const: bus

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.48.1


