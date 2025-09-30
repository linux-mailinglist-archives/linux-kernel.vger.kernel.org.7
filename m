Return-Path: <linux-kernel+bounces-837356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CAABAC1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31553B858A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DCD2F616D;
	Tue, 30 Sep 2025 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FG+isP62"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5289D2F5472
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222018; cv=none; b=tt/ipTwK5K8D0u4F/Xrot39TQdDdRc53NaDoAGQpUDSoDFXR9lGGxR1CQMm51hr7b9U2B2DJvWvEviMY122LW8f7oSqZ3GdqZeXpR9gT9T5jYOZaditEtHn8NpRHc6HP/4v2rCkISTOzY7m/kDQ7eQJyDBuRhFdfCRfFNYkfDmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222018; c=relaxed/simple;
	bh=1Mdzq/652LBGyytQuIr/+WYxsQX1eeyePN4MTPuKWTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BFbXEgWtnrT+XAx1QFTcC9g/I2pukh+zYVzntCgDERUkkGXePeRdjQQr8hreHkGzuUfl30EIlFpADqQoSNFZtZpFrGBcJQ1+R6zAjQ1Khzr2zfJLVcrdVRDYx9zYoXC2JWomLpOfyxa2/fBJ5exJKlJdJNGDH5as6XEMC4rveK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FG+isP62; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e504975dbso16903185e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222015; x=1759826815; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFM4fgZANGXRwrvQV4wSC81b8D8h+yUyMHAkucbMQWo=;
        b=FG+isP62FmmOi9JEY0E9mfPLpjqPGU7JVZxL8jAfoeNVva8RD22hF+mRHnN8LPV8pV
         szNOc2t/qWhxh3EWxNRgFnVP0IlZsDjgilZohFu9C08CFr9XHb20cTn9xVJhZiNGqvm2
         A+spAtnHydmczRoK3S2fcBctcBlZrwwV1UwSwpcAWuxgWcdf5v0zSXu9S3Tl2bNwlsMM
         /D8+RO3UvoXhKODmDFurUADo9A0JUHm5uZGSC5AGuUT/EZFw5KkHXIAO9n5SCFPjZS4j
         9Y7w5FpLjbg5iLZtMKIhRqFXfhg2rlYaNS6nKDje7hGL0qgvnyQeDlh9rFo1OR/Y6QId
         1tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222015; x=1759826815;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFM4fgZANGXRwrvQV4wSC81b8D8h+yUyMHAkucbMQWo=;
        b=Mr+Vxq004Ufj3eJwaMfmOUFMtS3DdnH5LHl5KkqlJC6mTm76sNzxUWPP0Tp1z52CJG
         QmrZUMHNTvdMYQwK2PQibbznvVWRfikrCdsGY+VhV26OvT+/P7TYpOiKWkYjZvFVYWqM
         XZTW2jJCkQKOQgalYgvR4EtOdm5VNw9MDptczFal/LuT1KrGr+R/+5jUHFJjycn3PYyJ
         RlJPLnF0b4NvcBkPkJ5K3vmOB86QQr7YFAi7NFt5tzQY8nE9orily+4pDWyMdVXZtrhs
         mIV1tZ8WWSvpMrRQOn3f1HDVlM97IFF0qLb6D4UdFgU9F1GYu6DkP1mVgPKlvFHkfsHl
         CNQw==
X-Gm-Message-State: AOJu0Yw6UqLVjDo15rURO9vZsVX9BwE7TgkR0+I+HdFKd/sYDpjeBbv1
	C5hW0v9n3g8VffinLDrrwW4Dcg9p968wGfEXO1oGOYqFpIZVeoVzlvZM
X-Gm-Gg: ASbGncup3/kN1WlkTDO9V/5hdoFsH+A3xbes1xD2aBrd2Pljc9PG4cWwucscqw8UH4J
	AEcJ5iSI8QnyM6UUB3NL7yWqCJ6HkavsAXs9G3G9uMHnZTpRG4Esed+vE1xeryHXUxLh5N+I5mU
	qjS7Lz0fn0iAd0qsAxPbTFgeZ0N+XBl6XIzd/Ei/XAEwmEWIo3zfAKcPY+D05THX/oN672S/Kly
	s+npOez8lL5Y3apNWxg5iO/M73v7jyY4PXqsqQx1xkTbn/2cp2ZCUQH6KVyqutq1fkWx+m7xcqg
	sTKnAhI4nOIDosP0XeM+J6MNrKl4SDrNW+iWGWrjM8yms41TELVL0DsHaA7L0yAIo3XnAuHO2oL
	RJIFFvyWFeJuxKCLDU97wPA8OKXM00u6TyPVCg87z3/fI38maN3L+lgXQsU9rr1azg/ky776A27
	CM36TCwpeGoaUZ48/TUedpF6lowc3mxxX898RPdS+AyRbnnW5Cwh8=
X-Google-Smtp-Source: AGHT+IHTFPZzGx4b88SoI+qS9EQDgCRRYbI3BPB4d5PmhtBVYrKjFEQXmYR1LT+gc8Uw7C4dhTNdmA==
X-Received: by 2002:a05:6000:4010:b0:3fb:ddb3:f121 with SMTP id ffacd0b85a97d-40e4b1a079dmr19776194f8f.45.1759222014438;
        Tue, 30 Sep 2025 01:46:54 -0700 (PDT)
Received: from localhost (2a02-8440-7149-a758-f461-9bc4-1c75-ebc1.rev.sfr.net. [2a02:8440:7149:a758:f461:9bc4:1c75:ebc1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc88b0779sm21417757f8f.58.2025.09.30.01.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 01:46:54 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Tue, 30 Sep 2025 10:46:46 +0200
Subject: [PATCH v8 3/7] dt-bindings: memory: factorise LPDDR channel
 binding into SDRAM channel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-b4-ddr-bindings-v8-3-fe4d8c015a50@gmail.com>
References: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
In-Reply-To: <20250930-b4-ddr-bindings-v8-0-fe4d8c015a50@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

LPDDR, DDR and so SDRAM channels exist and share the same properties, they
have a compatible, ranks, and an io-width.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 ...lpddr-channel.yaml => jedec,sdram-channel.yaml} | 23 +++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
similarity index 83%
rename from Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
rename to Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 34b5bd153f63..9892da520fe4 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -1,16 +1,17 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr-channel.yaml#
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,sdram-channel.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: LPDDR channel with chip/rank topology description
+title: SDRAM channel with chip/rank topology description
 
 description:
-  An LPDDR channel is a completely independent set of LPDDR pins (DQ, CA, CS,
-  CK, etc.) that connect one or more LPDDR chips to a host system. The main
-  purpose of this node is to overall LPDDR topology of the system, including the
-  amount of individual LPDDR chips and the ranks per chip.
+  A memory channel of SDRAM memory like DDR SDRAM or LPDDR SDRAM is a completely
+  independent set of pins (DQ, CA, CS, CK, etc.) that connect one or more memory
+  chips to a host system. The main purpose of this node is to overall memory
+  topology of the system, including the amount of individual memory chips and
+  the ranks per chip.
 
 maintainers:
   - Julius Werner <jwerner@chromium.org>
@@ -26,14 +27,14 @@ properties:
   io-width:
     description:
       The number of DQ pins in the channel. If this number is different
-      from (a multiple of) the io-width of the LPDDR chip, that means that
+      from (a multiple of) the io-width of the SDRAM chip, that means that
       multiple instances of that type of chip are wired in parallel on this
       channel (with the channel's DQ pins split up between the different
       chips, and the CA, CS, etc. pins of the different chips all shorted
       together).  This means that the total physical memory controlled by a
       channel is equal to the sum of the densities of each rank on the
-      connected LPDDR chip, times the io-width of the channel divided by
-      the io-width of the LPDDR chip.
+      connected SDRAM chip, times the io-width of the channel divided by
+      the io-width of the SDRAM chip.
     enum:
       - 8
       - 16
@@ -51,8 +52,8 @@ patternProperties:
   "^rank@[0-9]+$":
     type: object
     description:
-      Each physical LPDDR chip may have one or more ranks. Ranks are
-      internal but fully independent sub-units of the chip. Each LPDDR bus
+      Each physical SDRAM chip may have one or more ranks. Ranks are
+      internal but fully independent sub-units of the chip. Each SDRAM bus
       transaction on the channel targets exactly one rank, based on the
       state of the CS pins. Different ranks may have different densities and
       timing requirements.

-- 
2.43.0


