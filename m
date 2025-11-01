Return-Path: <linux-kernel+bounces-881106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7364AC27787
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 05:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB161A26243
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 04:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A635F285C96;
	Sat,  1 Nov 2025 04:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgsLooRp"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE93F2848AA
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 04:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761971096; cv=none; b=pBZ3bCvcIGBnbdxNu2yjk9N2oLh4xUkfaCqaBPzP///TlrQZkNNQut4hlyjnfU59K67+elvVkNlkqy56BGUS0IJrqouHifxa9nJJkSToBFc49HS3ZyiMq3YOr6czm14b8YkInrNXqJq/IyLahaaRGgz4Mv3tlg7A4fIV2Jxxb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761971096; c=relaxed/simple;
	bh=5WHfnnAEjEl7b65PNjGeo2Ba/xJE8CKHD2SN89cu3Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lR0ynLpj7xQMm7TOx0NQo6Xn02ed4pito/bOtiCFxjUQ6hh463vEZyfZLDsqOzPxtkuVEX8vuezd+D3cPosNlQG1bidIQ6o3A4SpAbHgeQ6q75uics6a47EAM+vRVDYsoOYBaVikdbNtuFT/jUKhh3XMTN/w8tS+EbwkrHTjqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgsLooRp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78125ed4052so4080696b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 21:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761971093; x=1762575893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cpDoufdPjG28A/t0l3uGrRRBG6p6T+fKPiyqq6TZvRs=;
        b=AgsLooRpDTUkIS7wnKxThtMOGBE9alk1zizSUyt0orMuVHT3evGWwNLvdSulqS/gRP
         7is1N0BVgLy2agIVUqonQL83X9Jg0hFRZDrlsrTeQsDOA1pIw/3WBGI9DLoY+1+ZszsT
         QAVpLGrzN32Ec04oA3w5M0ur/k5SJ+/e/PcUKMlU9qPZhPLATzyvFNDGeurh8s3pCRm3
         9bWNwyBiHeLRK0wxNM+ZrUGBH9bP8+wiFhRlUnvZaFWHMWaJlDtH6tK758bqmXPwEi+Y
         +/kThZKUMdV67YUNLbDbyALO2GEIkiygoigHcQV82d+QABetEaz+FOeIEMTbTiaIciQA
         MzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761971093; x=1762575893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpDoufdPjG28A/t0l3uGrRRBG6p6T+fKPiyqq6TZvRs=;
        b=TyefB3rr3+3TfplE4X8yaq9rmrkSn0WYjdnpXdfJ5bOUejRVVlJPBHmbmBvoygFO7w
         jcgIN9i9VSXsmT0QjUC/DjZGY4jY1Ujzyba1/XAEExt06jKTL/koxN0pQG8jUVhj9kL6
         KzvDRPLlk83V+6nnUb2l4yuCbOl7xdW3pSpzog5eUvtWoq8BhENdRJvigDZ788izP6BT
         LkXoHOjpefVmd5lKKfIryz2m0g9SzAH3fbnR+0R3JrmsYtXEU2/skqnv5EqzcGQuQKyg
         BkiTXxw4Y8nusDkHYC1vyd9yGLP2rBQD786/hzUWoq7mGUsc8mdXEC2R0BepdOuoPlbs
         97Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXpw9K3xDetC5LKvZreGCklD1iBitRSvmPbF0Hbzcu+Z670P1jXegXDROzF1BcgFeUeVMyzwwRNfQD/moQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7lqjg+n2bloy9yTvp4gljnxrq0Sqx/OlowyraoLNn/MJrpV2
	9elkfDcmZPSTqantdxUtPYyFze8kWV+ruj5Q2Z6N9BSjGJC9uJmZ7R9R
X-Gm-Gg: ASbGncuxC2POwIkHBzxe1CR7vLUkGfEZjDgXuTiT2TWS/iGylhFeMNoYFp/dhTGkRcV
	AgIpQSHFp001zBeWYV122vLfY1Z4/258iw6J61/amqpy321Gcnz35xZnt8kLuyC2Sj8DwU3KRaK
	Ki05WurG0YosVhg03TF9WKmiuTEtQ7TanNa1wJwPypCP+s7LgK4ezFyIuuWf7qFRpp+n9NRszw8
	C01LgvnEkO6iBdZWRQDzRYOjxjNgh6r6X2MJrpo1pfw9MOF6zmATXM6IXlu6MxqP27ze7Nlgtci
	/Q3pVFJzlx32lGC9xB1IFSsATSclWjj9tGnZQDKjdel3GEBTzwvJIWQFYW387UqF6KpM9DHtXM7
	7gAcQOOB6c49M3Sldn07PVGOLtooUxgmVgA9P9gVV8YgpyfTkBwda+qDqbwK35em2LNEab5eK5o
	8v+tiQL8+nDvhJYjN0bW7mGxMJrMwUw7807oRecQ/C2A==
X-Google-Smtp-Source: AGHT+IFBtoVlonGhlHWnTjQtAUPLEqb/CZBWvidsGzOw9KrDiWj7lh+Ow3/Lpm6it8MHYuXUquZ47Q==
X-Received: by 2002:a05:6a00:1251:b0:781:2290:e7e7 with SMTP id d2e1a72fcca58-7a7788ff6acmr7585723b3a.18.1761971093225;
        Fri, 31 Oct 2025 21:24:53 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:600d:690:cbc4:d4d9:22c2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db678f67sm3795120b3a.57.2025.10.31.21.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 21:24:52 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: usb: renesas,rzg3e-xhci: Add RZ/V2H(P) and RZ/V2N support
Date: Sat,  1 Nov 2025 04:24:40 +0000
Message-ID: <20251101042440.648321-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add device tree binding support for the USB3.2 Gen2 controller on Renesas
RZ/V2H(P) and RZ/V2N SoCs. The USB3.2 IP on these SoCs is identical to
that found on the RZ/G3E SoC.

Add new compatible strings "renesas,r9a09g056-xhci" for RZ/V2N and
"renesas,r9a09g057-xhci" for RZ/V2H(P). Both variants use
"renesas,r9a09g047-xhci" as a fallback compatible to indicate hardware
compatibility with the RZ/G3E implementation.

Update the title to be more generic as it now covers multiple SoC
families beyond just RZ/G3E.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/usb/renesas,rzg3e-xhci.yaml  | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml b/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
index 98260f9fb442..3f4b09e48ce0 100644
--- a/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,rzg3e-xhci.yaml
@@ -4,14 +4,22 @@
 $id: http://devicetree.org/schemas/usb/renesas,rzg3e-xhci.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/G3E USB 3.2 Gen2 Host controller
+title: Renesas USB 3.2 Gen2 Host controller
 
 maintainers:
   - Biju Das <biju.das.jz@bp.renesas.com>
 
 properties:
   compatible:
-    const: renesas,r9a09g047-xhci
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a09g056-xhci # RZ/V2N
+              - renesas,r9a09g057-xhci # RZ/V2H(P)
+          - const: renesas,r9a09g047-xhci
+
+      - items:
+          - const: renesas,r9a09g047-xhci # RZ/G3E
 
   reg:
     maxItems: 1
-- 
2.43.0


