Return-Path: <linux-kernel+bounces-810322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264BB518B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BA9B4E226A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7939322745;
	Wed, 10 Sep 2025 14:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RjC4WqNI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481C31CA44
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757513007; cv=none; b=TbHY6ECJhXIjBdMoCw+3aMKZpHw7bZOQD1EdhYiT/auQk0f7FBW6l5/x2sYmoejKgds6Bo13kBPqSvL4ho/iOf2r53BJhjrj795dx8FFaDxaAr5BtX99wQllXgYpNSC9PabbQxPZz/YVQqffWT2EJMkt/4t4FS2QQWYVoEW/HhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757513007; c=relaxed/simple;
	bh=mIES78B6726Znvf8L6XTq1c7dfrUiohkxj+gjIIj/0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2d2v29kUaRqFTbTR+sxFPRYP5JHf7+AhzlYMo/uuPAT2swq09maji8t//tWqeTYefzgqC+5EZUksfJ+rh50iRkn1hrs9qKMd3MVSySg2vLIcK2N8YdPZE6XCvzpqN4U+IO0BbM5hf6yVkab2714rbPCg3rv6ViLabkCML2D4Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RjC4WqNI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de60d39b7so24358265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757513003; x=1758117803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VRRoBJDxUtuCClVOWAtoorGRAjTpvhk+jM3BYoUxN8=;
        b=RjC4WqNIESNPp4dqszRZR95oQCaMhUL5drrffpgkfmVxkN0y72k8naR+jotCgZMEif
         4sMAZFgsKNnDOpKR/UoK/cuv49WbLvrXdAdeAWxuXM6aYka2EK5+lpYv2hU5R69sSENx
         rxXMYT2eUCVz1kRBwQFj6bd3uqExJbfoGu388MNUbRXoSzl+IxNhW6bkPuydso8oghM9
         VUePHir0UD2CkEROJIrHAuM7ZoscKYc7bp19cO4WxtoSV9T58PWB/NMbPIdA0fFQgAa5
         Knt3gQ+nzSc2fq3CGd97aisPRcMdcj/F/qQMK6sRTLiRXdoHfFumKTGf0u+skX1lBNSZ
         z/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757513003; x=1758117803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VRRoBJDxUtuCClVOWAtoorGRAjTpvhk+jM3BYoUxN8=;
        b=EiJjyP4sfw3YBoXsvYpJOCmcg09CVpLowCNgyrgq91iPvTDR4GEjSE001dvaas2j3Q
         JGdUySZVAOJECJazfyVqeReKzNGb7Q3Zrk5ImaqCsEJHcLwiM9gL1HNu7ZnnIl9S3dTa
         s7ktYuYLNccQBPDPliMyxcI5qC3ugGUAuh9PzUNtG9lGfUe7ANtGPTPsXG0Wua2UjITb
         PtkoHaXGVub28EnyzoJI7ZYz7y3RgSO5NKtJMg/iiDP1+B/Ot8RMPdCbwvkUKtFOt+bm
         AofUDJ7C3En9Ldc0pbTMfzCZZMkihWoHUs0z4y+i1mmYK/05aDvQ1Kxsfq7HezQKeY04
         7QJA==
X-Forwarded-Encrypted: i=1; AJvYcCWqgrlN9fnw+t5WMkBzwC6DjWhckknyE1Gun4XNdvqMJEQVOJPk4oEC3j+FF9kK2CJpkfHVEeSFlLMoBbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFYE4P3/XBuaS/yJG1XpV4IXGWBmWHBWZKSuSto5t17wJKjMa
	l3jBTvWMTXBxcYcYeNQFWcx74WqdF3WISniZmJHsLFuOJmpvhE3WoSdkCcUNsSTX0KA=
X-Gm-Gg: ASbGncss0C1RmQiP7LGDSYCqLj4mscl+wdqbbqXeB8530x2X8FxUPVodu1ViQfPRJld
	D3+PeevhrKzZJUy2rztjXap2J9gDId9NGx6TyWb1lSMnADPsQHZMDC8P8UvzIBLeQKCRdSegISS
	Mf5D4r2PQrFrln6iLgDU3EYh/+GU7ZxYSRQHfo8HkvehrRgH4HWo1IHfqVeiHjUeD/fhze5GJqn
	tFMQPQDfYG43gH1eNZRMe+VBhkdCVjHXyO8O5J7X1uUa3ApmYmx0FFPUoy36wv22wCxDv3T/2Bb
	z9r2tYE/aXXFBFNVEaJZzR0ZZv8CFtbip98CPHGmGO7bS2sCWE7TOhFbZGwed67zjFsP553eV4X
	gZK55c6W9PU7lCRMs/xmnyXt7nL3DNjipeW4uzHlrQlEIrXz31q/e
X-Google-Smtp-Source: AGHT+IHhfcHfzteNbpb670GfMcFeMNBt1xhdYwJHk1+Sw0KbXw/4z1Sr9oNd9yxGkx0R5Z7OW1OtIw==
X-Received: by 2002:a05:600c:840f:b0:45b:6365:794e with SMTP id 5b1f17b1804b1-45dddecdacemr152293835e9.24.1757513003366;
        Wed, 10 Sep 2025 07:03:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df804bce3sm29523875e9.0.2025.09.10.07.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:03:22 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v6 1/7] dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
Date: Wed, 10 Sep 2025 17:02:59 +0300
Message-ID: <20250910140305.541961-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250910140305.541961-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The reset lines are mandatory for the Renesas RZ/G3S platform and must be
explicitly defined in device tree.

Fixes: f3c849855114 ("dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S phy bindings")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- collected tags
- rebased on top of latest version of renesas,usb2-phy.yaml;
  Conor, Geert: I kept your tags; please let me know if you consider it
  otherwise

Changes in v2:
- none; this patch is new

 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index 179cb4bfc424..2bbec8702a1e 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -118,6 +118,7 @@ allOf:
           contains:
             enum:
               - renesas,usb2-phy-r9a09g057
+              - renesas,usb2-phy-r9a08g045
               - renesas,rzg2l-usb2-phy
     then:
       properties:
-- 
2.43.0


