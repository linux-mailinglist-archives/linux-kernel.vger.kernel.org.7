Return-Path: <linux-kernel+bounces-867118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61FC01A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1CE3B8D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609EC320A32;
	Thu, 23 Oct 2025 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pg1y0IDU"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79E28E00
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227910; cv=none; b=TQ6DqSmeiAWNNW1ixepPXbSz2vnu1we6ySMQS2AXehT/d9/X+NGqUCeBIXuKf0MaS9rVr6o8bg3rVPNggCCTabsa6uCAJe1d8prADkQisEOJI76bGI6oxIKkgtLs3Ix3g9+oces/sW5wcAJyJi5Q0Mis/RW1kBogX6CXSXXwHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227910; c=relaxed/simple;
	bh=/jPm6jH+d13noCe9SKn4mrnwnuDsNjdGPU/d9Ul9H6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sq/4txS0TuPqGe0oCdGvWJKuOuZefMELijSvh/3KjUkjzeIbA63qk04E4qJfZKwx0ZlVwH0gJkSUkWZYX802yicbkUhkYUS0lv0nhWfc8cVF+BFUiARcJG/pD25PBWdspXb6i5qWbCZKOy71sshP/T8fCSlDVCafRQZrkuvJEaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pg1y0IDU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d345d7ff7so88439766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761227906; x=1761832706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcs7Y+EttDztrEgb0m4AiPh1csnrxylUuqHzrjAxJgY=;
        b=pg1y0IDU42Q63ySQjK8xYqBMTr+J+75fH3VLzWrgauSbvcV1Nm62SDXq8SKumILzks
         WE3K3r/8FdZpx0Tc9Ojiob8wqG1jKbKpPdeleKKo72e+zWH4KQg+nbGkeIxXyg4Xmejm
         tTfGubpGPwBOdLRttoVKOfy4M4iDUcRpeoCYc84Gu3KTyLw/i0pJTzGR3Au60Kn4mDv+
         VfsZUy3nxn4wdcUj2UmU0e4NSKhPvb/vsZdVS+D4ANWNzCdUaF/rsOww/dTyp3Dyx6Yi
         vbnvAD4dLAfavtq6mJJA5chHn7QWiJQB7rvsOmfpixshc01bU5hOZmSVfhene/SNLpCF
         1fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227906; x=1761832706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcs7Y+EttDztrEgb0m4AiPh1csnrxylUuqHzrjAxJgY=;
        b=G9xIBVDEL8Y7OaVI4EigG7i1K5idzTBC9D7ocn+7QD9Bn8ZblSgQqCUFEpeipzi0Io
         vri2ZgGrMcGO+Ql/AQO5SbTz1EHnlZMptAtJNfAuwSs5O+i2SssOWoG7RR2U+96DVbpx
         J9XxtqE1OPgh5J8aK2Vj+oUyepJN9OcZpEVCgqxXbFjfGBqd1/U9qtnS0zSv7o4RICBr
         Shkr38tIZo7W9TBQm93/7CXXcpQrzwzdwt73vL7W4JK7MNCr3PYB6L1L0crWtk8K3Zk8
         9DcPv4MO3pergILeHXpqMNgHWMBDW7SJ35Go3PBhvZkQ13Jpb38oLLGd0JoBYiwssfCD
         NBNw==
X-Forwarded-Encrypted: i=1; AJvYcCUl6io0Dtqkh1TYduHPaZPPhRi11wjw+LpmbXiTsi9KqJNq2Kh5L+4S9ME5NYSr2e0nBDqympc8t6JVDbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjiWM37GOFTiwMUcwDTs024ixNPl+/4acupzPhODbRvkp4l7V
	AMNHIbOdnghLBuQwQAkDFNRRzs7Y8qFhwofKvz7AhuqOpQtb9ukkE0aAssN1Jr2Co4o=
X-Gm-Gg: ASbGncvL2O14QD6gqUiIU7bGGj/XzR7D12SlJIjd8iPADu/S6aVtE1o7EGXWaQfleEQ
	Zi5bXUtFrfff+obtkktcP5y2rN73oBmO1p09nUMoY+H9Pno6gvREAK6BcPX4lRsGC4nGHab75ZV
	JH1bQZ8Dz9X5/T7V65XdOsJ1XSDkO8EzSc+vjygzbOEAucfaYGy+BsDrLF/LJ3WSXzbo7wDmH9N
	j7RPJ5yv64Lps3Wuww1aFwX9qfNI5dWJBAccFm37z7TWIR8LL6apEg8pjrGAThOLh3E0Ip3WdPo
	PzXMx5qwHBz4Ty05y5P8pXxKbci1d+fGZxy2xBmEbac+ibwn7tNGkGqT9zYIZB1k5+f9PM5gqgM
	M72BgN3iwefYrKAD1pFZNjOD5MIDqLSm6dk2Da1cAcGhT4Qj1lzGRrtWwACxYz4XWBeKF9uXtIb
	2G/Uyl7MIDlmU0hpfORhO1rYHalciR37jM8cPYqfG8
X-Google-Smtp-Source: AGHT+IErl4KxFsPoyMcgmYdHQ18H8eQgx+LzGITPImiQSgQDh6xe3/IOiWXni9Y5LKEyJSLxqP3qGQ==
X-Received: by 2002:a17:907:72c4:b0:b29:57b0:617f with SMTP id a640c23a62f3a-b6d2c6df653mr921330166b.1.1761227905751;
        Thu, 23 Oct 2025 06:58:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f8634sm226114066b.29.2025.10.23.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:58:24 -0700 (PDT)
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
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 1/7] dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
Date: Thu, 23 Oct 2025 16:58:04 +0300
Message-ID: <20251023135810.1688415-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
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
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- dropped Tb tag as it was reported that it is not valid on bindings

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


