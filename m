Return-Path: <linux-kernel+bounces-721016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A73AFC36B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB069169E54
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 06:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B7D2222D7;
	Tue,  8 Jul 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="At0j1/TC"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BC2222D4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 06:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957595; cv=none; b=hk/HpJMRgJTsoazZLT6ENqvCDjPsHzaSEQWVT5qgsFGvYGhI3VSlXJJkdnG0Si+ULLsI1V3hWdsDEvf+w4RXpkgvTGDrj8ACPnFRV6VEWTeYVT/qzg3gpjT/eCEyjk92otaH7p8UkrzrgBQm22f+K2MyIf+ysRfuTS7FR5iVYvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957595; c=relaxed/simple;
	bh=KeJy1I2WRqHTgKYre78w4cnzBjwEfXqNjUN5/iOMgok=;
	h=From:To:Cc:Subject:Date:Message-Id; b=n7vsLsRO43IrqxGfiH6CKUZMnX5xyAN8JU3+tNrELJmUTec3a5u69UaB8c2l6Ghxv2ywv3d6pcG5nxch+ul5+B/u5xKjrXuxEAcLHD2W/QbU94otuT1Sgq3JsqqjDuSZj8PNIaNCnfgNb2/fy/ONljnE3RM2sIEeF7K62tVGc7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=At0j1/TC; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fd0a3cd326so51335036d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1751957592; x=1752562392; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUaCIiC5eT7Qg5Sm8qe+PiTSoWZ3Xtk6pXg4jHYXzdA=;
        b=At0j1/TCz64hH9AT/0+AEdy89Rc8c8cjocdwCTZx75Q/xHCW8CgPkBcBi0NEUd1JZK
         AWtaIqbV0+LOAQXhkqnbnYG8+8B1mLwihgYz20DBzdNMWi2NDNwGLVY8F+wgBtd1cGjP
         ItggjOrH7/H9sTtrNcHX6HmciYmwdTPbWIoxeiJqGBcqRIEcWlckQI8bGQSEF1uG2R0D
         OBfp+lFj1SWYd/phK/QtSo2YrE0p57W+7UYc4xOvq4nrAJ8incQyJSrcb951vu3S738u
         vtRlQKUkKF9G6ZtLa8GYsSq612OLlfzew0t/H3HpZEVFXYKwC768FYA6IWLhhV2k7nnh
         AJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751957592; x=1752562392;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUaCIiC5eT7Qg5Sm8qe+PiTSoWZ3Xtk6pXg4jHYXzdA=;
        b=uZpEYAVSWZprtXHEVmgEAsT5+gdYY7ClI+JjmFxj+uZSzIzZ60yPNk04XPxlI8dpPP
         PyDU66bkJ/3ctFmNCQwLw98Rg+U/JM/WBFjh50kLZb8su+VFfpEVQ6wpkaYzFCH9aHYn
         m4JP9T1mLVzYD8omgaNQEp8nwDtlLXDRDJp599iegEOMiLjL9n56qCoQH9ePQUJUo012
         fkSjy6bQwfZ1LpbZfbeHmNJ+KDKVUXImRAv8sOm/XN+x88BY7ZayYETZz7Ld+my/OVoh
         O44lKrMwcNnehYiLFnrBIrvl1PewdzkJGF5EX5+X6MD2e3cYyKsg9v2XHB/mN9NE5g5p
         2cxw==
X-Forwarded-Encrypted: i=1; AJvYcCWf95UbqrJLzV5xCVoxqaupKzJNgc1TzTmApMGAQrsXRNPWzVHt4k+EyymLlaKJA1iJMRGc5PW7W9+qpm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3UK9ekKm4IigQjYzrZQh477LPqkjEuvauwHS+LqwX2oLahWjO
	N32InovCFkeLRW8j+ggbhHvGGHwVuit+eoCDUMcP5E6UhYPH3aFH3eAnRuVv9axYKMc=
X-Gm-Gg: ASbGnct+hOozK0HEfTAg4Ylv6jjcyRBN+TLDsncHYCmWICk92Qqs0MAP0fpDKcSoEaR
	svCyOsmuAVsH+7dtEWs/GfhVRC9NTojV2PCUk/fElGofsWKr8t0s/oaNj9vVhS3Hv/a6Gqx2/cK
	dcwStpkBQKO1q34ZnIZckdIVhsvQve8nCcBcNvI1DtNK/TJ8WY/VY4KPP5HTeHR0oJRUplT8TjC
	urHNeZ9mf1Lj1iu2u/nTui2Cuqcaf8D3kh1cX03/IQcb9S3Ti9/qJIwmNYknBdYLpo7EsdG2NVe
	gQa5bLikrBLyzHrt0URfP9NJX83HgSk/guaKfAK+/ylBGNG2gIlmXzGxA6Qouy+9hvy/+QXFDnZ
	/mmAZHqxA
X-Google-Smtp-Source: AGHT+IFO5mmekcCC0R1ZHrs+gCMYv738zxfhnZx8tkn82YBM93zZS29An9l1jVIQp8jc/Pogs4YsmA==
X-Received: by 2002:ad4:5ce8:0:b0:6fa:c054:1628 with SMTP id 6a1803df08f44-702c6d66235mr267954486d6.23.1751957591948;
        Mon, 07 Jul 2025 23:53:11 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d50e14sm72109856d6.74.2025.07.07.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:53:11 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>,
	Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nick Hu <nick.hu@sifive.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH] dt-bindings: riscv: Add SiFive vendor extensions description
Date: Tue,  8 Jul 2025 14:52:42 +0800
Message-Id: <20250708065242.26371-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add description for SiFive vendor extensions "xsfcflushdlone",
"xsfpgflushdlone" and "xsfcease".

Signed-off-by: Nick Hu <nick.hu@sifive.com>
---
 .../devicetree/bindings/riscv/extensions.yaml  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 72c1b063fdfe..10c37c61243d 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -626,6 +626,24 @@ properties:
             https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
 
         # SiFive
+        - const: xsfcease
+          description:
+            SiFive CEASE Instruction Extensions Specification.
+            See more details in
+            https://www.sifive.com/document-file/freedom-u740-c000-manual
+
+        - const: xsfcflushdlone
+          description:
+            SiFive L1D Cache Flush Instruction Extensions Specification.
+            See more details in
+            https://www.sifive.com/document-file/freedom-u740-c000-manual
+
+        - const: xsfpgflushdlone
+          description:
+            SiFive PGFLUSH Instruction Extensions for the power management. The
+            CPU will flush the L1D and enter the cease state after executing
+            the instruction.
+
         - const: xsfqmaccdod
           description:
             SiFive Int8 Matrix Multiplication Extensions Specification.
-- 
2.17.1


