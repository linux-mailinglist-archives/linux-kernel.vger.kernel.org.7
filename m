Return-Path: <linux-kernel+bounces-898122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B19D2C546DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA6B4E82A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD4C2C234C;
	Wed, 12 Nov 2025 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kspnNGkv"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84572C0F6F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978806; cv=none; b=B1qQeXkCGF+ABUhhZnLwY+0CWC0M3DP1S81IxUca3hJFMbj7oZYh011TWCCkr5Q/tIy0sqIDkqWPkdSuf+xzaQV7vW6wg6FVbnXcCfUaMqxcwoCq+pGsg59595hnFNFfFuXgnGPR/J0k7vnE+Q3fWWhKKBqi8n+Q83zvdU2TYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978806; c=relaxed/simple;
	bh=/plj9fh/IZTy6oZAC8Dfhmcc4NUzFHy253uswukPQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVaAW4l2Jt1RA3sFaQsqc5dmXuXXuWslWASFDRTub3w0oSJSQMyUnOuke+qD+OcjqztgyOrPKfhs3w+CCzywnKlH6Y8wetwT68I4n8Lrt9J/1u3D3mNv548D7/QtvXm2/ZnYgXkRYKuy+oP04SF04U+XfApQA+FJAJqDPGwNayY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kspnNGkv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29568d93e87so228645ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978804; x=1763583604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/vBXqyh3UPyAQ3zsAxz2ig4U3J84dfQKbNA3jaUdzo=;
        b=kspnNGkvldDFU3englaHpott0zd5VPTj0s3hWJTLiLDhemBvyJPerksTmCMwBwjbKG
         019SusppVMeq1Xh3ndVvsOtTaPsS/eYggoRrueYikBPcjjfOaJTv+pNX0wu31zNa6WyT
         O53J/Ds676Nsdm1N7bfoSOaFMEbCu6P7bqVo6ppNKqjYGpH65bC58M+BJZSEtTlZigSH
         KOg7RgLtEAfhTmUujMqOstB0+UmTZouZUi1NtGWsCpbUnaaFOoiZEqUq7Cs5oLYu/mo4
         w20a9v7SvRa6yU9Hse4rgBfYtRtQgbLm6SQFa54l0l/9BSUZmJuvkptD5v0aoc+FUe8Y
         JWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978804; x=1763583604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/vBXqyh3UPyAQ3zsAxz2ig4U3J84dfQKbNA3jaUdzo=;
        b=Lsx7gEFYql4DrwJ0tsMoMPBdAqOpjoglkHS+6leBEDXBN1r8oPQhChEMUKWuL3ZnHn
         5gtDDCd78cNU198GXgNxNZO0uriSvxjBGCoRLrdcgW53qWjNwLYLKGyn2xrdHdgaj9N0
         CqWMm7S3Pj9i4tgyds9PqhzuZpFui7ClcZ9T7VVAnnD+ddWr8KTcYHOOGQFgy1Rlp7gc
         lB7hAYgqi25oooZOqQDeH1cEqaECUvTQUloSSfR4DkCkX8dqC6X2+r7GmPrgIYKP3lLN
         7EXAVCWIj5bBUm9vMeQ0JwFPf4JGeSipJyo5XRCJloOqtRuxNynda3RpE+V1mq1dcd5D
         rLCg==
X-Forwarded-Encrypted: i=1; AJvYcCVxLdEPjf13WtYi2Giy5Qavk7sJKo2V1jb0cceOx63aemGEnqpcbtyDbEi2vEKF1LfRonmTA20DvydILp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOCDHYcPsvys7wpXLVC9GZVg4yAAyUGDdr07GoNGOeKoS/Bqn
	Zex4vpZ4f2nAfDuGL/6AQIPmxLuLzYfreD7XpClKJPfPvk5tHXrwy8J6
X-Gm-Gg: ASbGncv3/JblQSItWohP8PFVwWt+FN2oeKvliuCorhnvc4qG9pkvMsntNTvoiut7Bsd
	YTezyPGUmwj8R8omq/smu2I1CUPSGKuOkudpU4nEMm8+m4LLVoe6W1GNM1ddv5d8pY4dir6Hn89
	e3Y1aSUF0wjRDAuQa2ouLsinVWlfKyNYQgidFv9ZcpZOB+9VbTt9/0SfR7Z1ICDZ6NICiGJWKnL
	0wFC3/lAfqdFg5IRwTqDd/HPmVdMkQ/E9wlAjn3g8hf8M3YAmHhDyA2DeDAsP3W91RjZtAZ82Ae
	hfn0VUkEUtKSRT8FVPk+cqc69tlaXi3569t3xWaazinxLRWDyN8m4+jcsGJmmInE9LNBjb6jkD4
	WQqp2dBhL490Tb03ej8ETN8Lv2T7mnSl1ONoiTLozrprc1mif9YHzvV3T8iHPwuFXMf/KMJgfrI
	Nufzarq7LfnLhjd5IoUlcvWQ==
X-Google-Smtp-Source: AGHT+IHD3owK8YXgdkefa4KWcxQZCFPmAJLbR/Dh5Q2mfLUiYfFz0jmPuayumGBai8cChDj7akOlAw==
X-Received: by 2002:a17:903:244a:b0:295:54cb:a8df with SMTP id d9443c01a7336-2984edec25cmr53252665ad.36.1762978804106;
        Wed, 12 Nov 2025 12:20:04 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5748:721b:a500:103e:1bad])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2377e0sm261015ad.23.2025.11.12.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:20:03 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: pcs: renesas,rzn1-miic: Add renesas,miic-phylink-active-low property
Date: Wed, 12 Nov 2025 20:19:36 +0000
Message-ID: <20251112201937.1336854-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112201937.1336854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251112201937.1336854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add the boolean DT property `renesas,miic-phylink-active-low` to the RZN1
MIIC binding schema. This property allows configuring the active level
of the PHY-link signals used by the Switch, EtherCAT, and SERCOS III
interfaces.

The signal polarity is controlled by fields in the MIIC_PHYLINK register:
  - SWLNK[3:0]: configures the Switch interface link signal level
      0 - Active High
      1 - Active Low
  - CATLNK[6:4]: configures the EtherCAT interface link signal level
      0 - Active Low
      1 - Active High
  - S3LNK[9:8]: configures the SERCOS III interface link signal level
      0 - Active Low
      1 - Active High

When the `renesas,miic-phylink-active-low` property is present, the
PHY-link signal is configured as active-low. When omitted, the signal
defaults to active-high.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml b/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
index 3adbcf56d2be..825ae8a91e8b 100644
--- a/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
+++ b/Documentation/devicetree/bindings/net/pcs/renesas,rzn1-miic.yaml
@@ -86,6 +86,13 @@ patternProperties:
           and include/dt-bindings/net/renesas,r9a09g077-pcs-miic.h for RZ/N2H, RZ/T2H SoCs.
         $ref: /schemas/types.yaml#/definitions/uint32
 
+      renesas,miic-phylink-active-low:
+        type: boolean
+        description: Indicates that the PHY-link signal provided by the Ethernet switch,
+          EtherCAT, or SERCOS3 interface is active low. When present, this property
+          sets the corresponding signal polarity to active low. When omitted, the signal
+          defaults to active high.
+
     required:
       - reg
       - renesas,miic-input
-- 
2.43.0


