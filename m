Return-Path: <linux-kernel+bounces-829612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4DCB97752
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7E097B4E53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF830B505;
	Tue, 23 Sep 2025 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GdaLm28z"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3F30AAC8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758658376; cv=none; b=OPWkkSNwCT0sOfs2QSrerziB7F6qZMyHyehMSrvHWBGK6wVg6GJ9sfQL7gx2/H8FD6dW0o2DQtzS5+zuauvQKTfN/arT87rG+m2WDgQCJYsaolt7M13hkTfsjM3AwsQCxRGiOSsTI1D3YZr6EPVgTioAfWw7iw7K3ublLPV0jcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758658376; c=relaxed/simple;
	bh=pQQc50aYzZqifBZLt/GUeCSMwtVtlqq98lQJ7t3A0hk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeYa4DsMWWB0xb0cwoMkq3x6zsYR28UKqcssLP4/e5bCUcPhrzPvGXh9hfB1tndSWpA/dRvg7p3oRY97oT2CQByNCyFLvWWU+wBJBA1F7dlVNmRqOx6WU+QRBQXCLhYcvqhYYx8EI2MnBaSQ1m1216tbckJc1k1MMnzBH4k7PjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GdaLm28z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so37600915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758658373; x=1759263173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/aSYEPITl7MXFUBK4l9sWKvsSHUrdrtUDK4IHLwFVI=;
        b=GdaLm28zJdmARM/vjxZu6Cy1UUqOuylADCdBvQm7kf2zMRz2kiqhqlP/29XylFicbc
         88QSqo3TUiBydYebyvW6p/8/BUCTk5auL+9pzKFyEnMoEQqanJAiNDAeUJPkUj4TJy6T
         6fMGQeL52htGG8cfrfnO405If6BVbeZ0M++0YM0O97DKwe6QxCf9Qz+YhHkSolXKSHrS
         fcbWJ3p3KOuucvQxTA9CafhIHoB5Tbfvu6VEMG2zHPXOIIhtFhXFBhnmo9it6YsDfHfx
         N4tWA6tRJknC7CGrBrbBVELPBF6XKf0bckQLymGBHgRX/7Y12xuUwRNQHpxBQPLrf+Pt
         aIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758658373; x=1759263173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/aSYEPITl7MXFUBK4l9sWKvsSHUrdrtUDK4IHLwFVI=;
        b=mOQG2rO5bhVLLQZ9xFPir9wwWV6GKH7dkMaVxhPxWxx/dGt/xnEllzCsdXOvZyvGAi
         fDs7JhI4ZNj0w6a5n90+HorvPvdOPj3vMleYwax3VDUwPykZcalP0WulCx+luex1bGUG
         aLglLVfPrpGCVaom0Izfb1r4X4eXAUPlmm35TMxcgQnD51iGMGop4vdANa8ReeuB+r/u
         XF/d0GkIbSj3cwowzkTcVvWTK5FutznKaq49dgmO4vMMVzdkHuBnxJwC9WcUtjTdrKgi
         m99jfcxsiDXwBASvqlsMeaP23cNidYcmPafnS9ee9/GB2dmR8xlUawCQTmF+VfD6wgw7
         yxwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtBdE910vYonle41QFbx3EeCVj6N7zEstkWNuXeLaa5heHW6gB5LnFW/9kBnHfWLUogw/AiETKAC8xhQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDP0sqS2bSP5pZfNwhmIq6Mzv3skfBWpFP3peLZKIIVJ+BBCD
	yLPZmAts7KFoCO5OADFo0gmW0OI9tYNdlI6tIQt/KSoqaDoPDRxmLymu
X-Gm-Gg: ASbGnctbTIZ+hCSlrDGs/7hhoOLGnahvcvO2FOOEPAY1ZePjsaomzX6/iVetVagtMdB
	zoYlgpGk4t3HTk2FdKd8LnXjAjLRqFoRRuMskyqJ6Q+9rz6L9LyK0D56xvJWwQf3ZEw4RaH1yEM
	0K/V3lzCNKZ886qGJpI95nX8RMvPWlpV/cZxIKkLuSUPp4s2rPDRtFoVFYQ31D5vUPKOJXvTadx
	jbgNmhJ2ELudo3ybw+zvPAQB308ajfsZvuObuMJjJqNiPCzQ7VHPGk0MM92gwr3CVIjPXATvxjN
	w7NthB7Hi80HWbSL/PoYWPO6J7t9K4UZUBPSJDZAQLkwaAn6R7zs6XuUcbim0hvtdU40AWCgiik
	u9y0kwIVqo6AJsSfVRWqfaRvAKk7QBnmoXKWAmSlao7w720OfU3NpgAAW5G7htislqUq45eo=
X-Google-Smtp-Source: AGHT+IEEsRLoHeCjXxyp+KHw/4kToNUaWd3xzTGb2VSF+HgIp8CNjCGOmpc4a03QsHuOffoop0UVIA==
X-Received: by 2002:a05:600c:4f44:b0:46d:996b:826d with SMTP id 5b1f17b1804b1-46e1daca1cemr38382195e9.34.1758658373435;
        Tue, 23 Sep 2025 13:12:53 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee141e9cf7sm24889690f8f.12.2025.09.23.13.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:12:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 1/4] dt-bindings: clock: mediatek: Fix wrong compatible list for hifsys YAML
Date: Tue, 23 Sep 2025 22:12:29 +0200
Message-ID: <20250923201244.952-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923201244.952-1-ansuelsmth@gmail.com>
References: <20250923201244.952-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While converting the hifsys to YAML schema, the "syscon" compatible was
dropped for the mt7623 and the mt2701 compatible.

Add back the compatible to mute DTBs warning on "make dtbs_check" and
reflect real state of the .dtsi.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
index 9e7c725093aa..aa3345ea8283 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
@@ -16,13 +16,15 @@ maintainers:
 properties:
   compatible:
     oneOf:
-      - enum:
-          - mediatek,mt2701-hifsys
-          - mediatek,mt7622-hifsys
+      - items:
+          - const: mediatek,mt2701-hifsys
+          - const: syscon
+      - const: mediatek,mt7622-hifsys
       - items:
           - enum:
               - mediatek,mt7623-hifsys
           - const: mediatek,mt2701-hifsys
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.51.0


