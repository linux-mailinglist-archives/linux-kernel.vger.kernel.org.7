Return-Path: <linux-kernel+bounces-855155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E7ABE0690
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 937D735843A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242B031280C;
	Wed, 15 Oct 2025 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7b9BiaC"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D3630F539
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556397; cv=none; b=L1BzNS1HUKz17BjLgBYh/EwO3DYUyJd0dickoIdVKoDaaKykhgkjFPP9ULg/DN4fTADix6oVVh+dBLgCmuYFHkyGfgzVikN7E5JlkL7jKy3VqRwms9RYIS9CVWtyYm/Qf795HzY9QiH5nh6PKt69q/Bq1W29O6nMyG/TSNPCQS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556397; c=relaxed/simple;
	bh=BdsJ2sEqN6rODDSWveW3Do2KQsZ9ykXTS6FV9Hcz5/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOky+XfYx1zizkrVMx0Zi646MfaI9KbSWJj7hhPuc9soIyL5fp5NHY/NIAagzvNzAiz5jp9x1fnRc2Z+LKV8o6S5v6g+hTEGFNn+z4TIjWh0zqmQwzrAhNowy3sFDhzr/tKqKosnGjJW5noAKE493aVR85T9TldFqxmNaifbpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7b9BiaC; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b551350adfaso5703010a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556395; x=1761161195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzeiqeSx2hP+uCSg6LMRTweWgMxjeUkFjtP3zeTP43k=;
        b=R7b9BiaCRAXucLHJvD8ePybVAtvtYJLNXS+XRzmBe6aGxnkdHATgjNq1KyecQ0OGvn
         3mGKXSpS5cMt12MSVBywXMwatbUXubKXWIBfPUY4VI7LPW7r3hscu4Nhkofq6SJ4scSi
         5tsewx/KiCxUS93W/6T8mUeeNQfK0eMKsXITU7tA+j/aYv6i5EwFbB13SwdJgrFMgRTp
         BgLdCy72Yz426AbXl7X/CvhwSsbV5m0GiPQl/qAaV8ybn7NBnZs9+0P7XuoneanW+Zmp
         6cNOYc2AYg7/W9pHu1KQ0MEmG9yHnXlMMoAnYVWIuR8+xDaI/AyoErmm4saTPRuj4VZi
         jfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556395; x=1761161195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzeiqeSx2hP+uCSg6LMRTweWgMxjeUkFjtP3zeTP43k=;
        b=NcYa+ptUdWwyXoX3N1LyK+RskCXUrRon8aaDWHd8Poyn2hD4RpMvkD4Ws87zFTAch8
         q6m6uXbs1Xd0sMJ66pC+sSD1dAAEgGf1hSQtOMeeDr1FXVvR4vlOXOhYvfI0kncZytyC
         3yo7RM/L2OKM0oNLqpquQ44OjrFlOVr/cTdy0quAkb3Jk30GSt877n9KrlyfXZ2xBiEw
         ajelAWywfO1QXmDOhB9rW9ygdKiFHHCxaaL92/BPaM4qF44oLrwv1kU0vMgaI6ocTmh2
         bLlHwKVwH6HLLnmjIkXFihpl7Qr9FrXZ7TDcnjCbvzRyDxPj2R4cWe9rBk7VvlcV5Nw1
         HpIw==
X-Forwarded-Encrypted: i=1; AJvYcCWnN2SZYsGaaJ/cpNgymUQx9WxUfH6FYfPZReGhx/rZCuowxV7iLzUwNLvjPDYhog0eJ2a7P6vkUvdYUkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzXG2smdvRJWAwrO7IJn0NU81ekoz1TFfkhAyt9NR48O24Sp9+
	eSrD7ocWQ0CN0ssJgIjWdAlzWRQU1XDPWc5g+R++lfYwHL16inmBDAhP
X-Gm-Gg: ASbGnctj2ZFCSVZoz9yzZ1Mz/IkTJ915W87hvkcKEDBLg+L3SedRrGAz85ROQ+P0nqB
	HVrzlNqBx/hRSvGRa073VINYyixdmh9cX09W7z0hUmBmHbIeKhhb4Vo/bKzYEif1iJVVfXay51J
	hfpSbOTKZ0a2pXme41mVfYDKhNW9faA/tM8CkmMmJb6m3QNwkMCbX32xtVAaEERQwKZDL4vLwXC
	499VV/VobQStl1B337zRVZJEYjh52RB3AmmNxQED+FDUGIbvbo83uCxC3pkwwV87/pJXDPzddbN
	3FuUFQLGvxwccReFfjDBGpmnzCcLlqq7m1G64IFh1q+GTSJfHNsHQKoHpUWRZ73Yz+dMl+ETPWW
	vK1ajzUFyxNKLAZLj6W87IAIr1QLUjNs5MO8jhr82n71r0hb2FQtPTDxJsAET3fagbuEbFrC+uj
	3+EnMx/YdmuNyhoc3HwFuSqQ==
X-Google-Smtp-Source: AGHT+IF40uLj5O1VNn/1ilvror5cZrwViGxizn9s293CQe+Duobh8kb93icrEIO0yMNIwwVc30gkmg==
X-Received: by 2002:a17:903:3c6e:b0:26b:3aab:f6b8 with SMTP id d9443c01a7336-2902741ce06mr353175745ad.58.1760556395165;
        Wed, 15 Oct 2025 12:26:35 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:f449:63fb:7005:808e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290993102c9sm4427005ad.24.2025.10.15.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:26:34 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v11 1/7] clk: renesas: rzv2h-cpg: Add instance field to struct pll
Date: Wed, 15 Oct 2025 20:26:05 +0100
Message-ID: <20251015192611.241920-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015192611.241920-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251015192611.241920-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v10->v11:
- No changes.

v9->v10:
- No changes.

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
index e020d9624dfd..fe6ab8e3cc6e 100644
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
2.43.0


