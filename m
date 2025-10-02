Return-Path: <linux-kernel+bounces-840461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9A8BB47AE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFE733C1383
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58331257843;
	Thu,  2 Oct 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4wLHIgO"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7E25334B
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421864; cv=none; b=kFAYCyNCqXt5ALtmVL9QrSrl15OfEPJ0r6jrKWUM0NiQVXnrWd25VdMUTXevd98ZllQRSlcJEfzXs7kpMp+DI6q0bKqg+Hc+S+XNED5I3aSKFkyG8gmysOd8CL01jAlwPyrJUqh+TgzSPzpp0A18Ut1Fsv0tfize8E4qPpoRCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421864; c=relaxed/simple;
	bh=AyS3u95uyqH/xDcmCFbZlmlbD4K3Ky/RpGp89Hwicg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qucMV20BJi1gOesNSiyZYEPAygR7/8nD0kdCtChKh7WJt4MXNHAXtlggGwEBD4OC844h1wbHHfenDE5eq9hDkLSL67kbHxPi0kz9k1Fvq+XsyccAhbCECausMu+BWRP5s1Mb0ta1OsCi8tXOWJxxMh/cBsTAtrW/88lplUwXRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4wLHIgO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so10883815e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421861; x=1760026661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDy+bcBz5SReUL1/hrWcatTUHafCDQsXpig3EVAl2cQ=;
        b=A4wLHIgOk17gfgMioo5/nuoJjbA48ZMS9gw9ZdImDSAXkNlNXsHxagAhaQ3BuctgJm
         FvHeVRFjTv4BCRCSgPg4GiPCUQzqdQi9UZS3D1nV8ljn08lIPKEuR4f0VdlXO8Ba8xB3
         UkDhGAkuxt0jeLjO5IPlodYENM+ZG9eBj55WpqJ/7Gx7XBpWxjgjoXtok6mlOOF5zMFM
         KCCMepK+ivm5ecRzcRKGShchWZGcRQUvMewXwq9cAXSYbbOcyJZm6wGlEQKbSKscNFb+
         atcrexBi1HVIEZur7kjYh5+IQhN0EQlsQn68QnhwnBDAoovk3/xkjVJG2+Ej4xFTDPkb
         Za3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421861; x=1760026661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDy+bcBz5SReUL1/hrWcatTUHafCDQsXpig3EVAl2cQ=;
        b=mx4kesMsF8QEpdE3wsv+W4oH0NZinwTRZOmTR3h15hU3SSlSxvPWCaNBIUfuBWcgRl
         7m93WWkFZ4/gOMk78U3ZTtKdTfHxT08UI+3HUpvBeg/MAGw48fqK9H5hu/uAWH0UM4Yx
         pFCYjDSyrXIZm+hY5/k97sIKQHd36rJhFbLyXHOdcpIu9zCrX1dnDCvQZ/hAY7vET+Fe
         GeVJ2ntfxx++QcKH2MmvF4CETcIvmrvX/j3196VI/1bXoYgeDLHNrhACpUsJSbsTZ2Qy
         Ls9ItnRN5VDEJRpLyT7hqXjRSrO5Vk41lhaieCo+CC6YzO6QVbCfQoV+81BJo6LDSr19
         lrVg==
X-Forwarded-Encrypted: i=1; AJvYcCXkRDj1IDsEmhBOY0E3VeTlH2/6gmiGBJVUakvVFzwSHCN0noi1Vje5MSK9dqrzPCk+xF5iAS5IE2E6mCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYgXWw7TN6HMSd6yp6HRVPiKWnHlb78zozzpbnJNA/zabEp4a
	aH6ACfZgy/BZmrtbKv4a0aDK1lMB6evUIV4EzRZ5CcpE28KIVuXSzouZ
X-Gm-Gg: ASbGncsCHYXy0/HBBb+6ChVdDwtCuTgRLbzCOozkojHSBXnGzkT94LTUeFWG6Buqc6D
	I/rbLshWA7iW4wvlyWpDfxiqwx754x44pZsdscC67dqu3Oz4W9JaSB7G0XxfnbkBqJy0toyAHOm
	VrmZhbmC3l+xNyHQVKE8tLm4p5n83jS9e7MHRULD4ETl+RdJJwkQHEiud9nkGZv2FTu7en5hlQM
	J92dkUrI7mgck19Tk2sHG7Wfl5R66mOurv1mB3gActw2G58IOxWxbynEB4u4I0x7C53H0WOC1ud
	PhakHZLAVNKhNpQfY5zcY6MNL0w8gz5y8PsNu53pDGAyrH6C2Z80E+EvVSc961LOPPMCmF5LQkK
	9KJcDGS03Hc7w1NfXs96n9jsCodhIgpH+2EecrBito7mYZF4s0yJyp3uJhy2T+j4DFJtxDBqBs4
	Gh3JF5
X-Google-Smtp-Source: AGHT+IHrq2Ok4208eIeZKRmn8dvl8f5AQ6yStLCnXfA+SOQTweqJ+ph9ADJMK5C1VCoebsbnYj9+Yw==
X-Received: by 2002:a05:600c:3149:b0:46e:3b81:c3f9 with SMTP id 5b1f17b1804b1-46e61269212mr68911085e9.17.1759421860723;
        Thu, 02 Oct 2025 09:17:40 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:607d:d8e6:591c:c858])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b5e4922sm58605515e9.1.2025.10.02.09.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 09:17:40 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v9 1/6] clk: renesas: rzv2h-cpg: Add instance field to struct pll
Date: Thu,  2 Oct 2025 17:17:23 +0100
Message-ID: <20251002161728.186024-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002161728.186024-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251002161728.186024-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add a two-bit "instance" member to struct pll and extend the PLL_PACK()
macro to accept an instance parameter.  Initialize all existing PLL
definitions with instance 0 to preserve legacy behavior. This change
enables support for SoCs with multiple PLL instances (for example,
RZ/G3E we have two PLL DSIs).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v8->v9:
- No changes.

v7->v8:
- Added reviewed-by tags from Geert and Biju

v6->v7:
- New patch
---
 drivers/clk/renesas/rzv2h-cpg.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index 840eed25aeda..e2053049c299 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -16,20 +16,23 @@
  *
  * @offset: STBY register offset
  * @has_clkn: Flag to indicate if CLK1/2 are accessible or not
+ * @instance: PLL instance number
  */
 struct pll {
 	unsigned int offset:9;
 	unsigned int has_clkn:1;
+	unsigned int instance:2;
 };
 
-#define PLL_PACK(_offset, _has_clkn) \
+#define PLL_PACK(_offset, _has_clkn, _instance) \
 	((struct pll){ \
 		.offset = _offset, \
-		.has_clkn = _has_clkn \
+		.has_clkn = _has_clkn, \
+		.instance = _instance \
 	})
 
-#define PLLCA55		PLL_PACK(0x60, 1)
-#define PLLGPU		PLL_PACK(0x120, 1)
+#define PLLCA55		PLL_PACK(0x60, 1, 0)
+#define PLLGPU		PLL_PACK(0x120, 1, 0)
 
 /**
  * struct ddiv - Structure for dynamic switching divider
-- 
2.51.0


