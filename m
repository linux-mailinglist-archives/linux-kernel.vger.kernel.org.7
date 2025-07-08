Return-Path: <linux-kernel+bounces-722230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FDCAFD6B1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 064127A29E7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9E2E6139;
	Tue,  8 Jul 2025 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTpc3oUe"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E02E5B0F;
	Tue,  8 Jul 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752000569; cv=none; b=MHxQjAHUBkod4PoOQ90vo70/uhBPK5EdV4JBBrjSmueh8hm9CCJXnDXTEwBvtsnpD0njiQo8D+rd0AD3AoiN8UBWc/8o95NCEOFDTT62ULXYVPJDhu+zDYsT7a5KaOd31zvvg3ZPtlIG36/L3nmLggcFo1egVAmhyOs1QM5D9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752000569; c=relaxed/simple;
	bh=jeFQiCir2YfsOn0bXFsJ9XT11dcWwFooGpdMj1uq1BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+OcCPemMuUW9+kKD4N7aOnt8VwQYMeAwLkDUgSSgXxqITN5E7bvHZrknTGkJS+KGT9pic3L0mvrSs4uDOg506vrJ1EVInS6BAiUN3CAkUOIMCqtppMljCAssGHVKyrTqI1hxwYQU5gajwfR0UyYYIDfZbl0D9Uw5ANylM+JIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTpc3oUe; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0e0271d82so961541166b.3;
        Tue, 08 Jul 2025 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752000566; x=1752605366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTay8Cx8bgDFDPX/AfO2y0JXUWGAYkk7ejr9qpnZoNE=;
        b=WTpc3oUeMUR7AlJG5M+qiRzu4Auky5g9A6cY5bVl68UBbOefTQ292GI44AUCMb260K
         9S2WlWSwu9EMSzjH9MXOJeQhVM5zSMDLAX6jSkApYOgBgkJ0wb/Q3ALEW94+u/ajoG7q
         6G2qQYxM6fZpfhsnZKQCmPEQJWucgD8H2K4XbPom/O2+6g8JPZInh8TM1xd5L1EMUqtK
         zCP9LiPttcbmH3raBCAOJMd40LWt8bfFe2x/+V/vyrNrAYhLrJTzwHcjcdiXHUjUV38e
         7YOzIJ5rUM3seRhPa+lxnNwdS82L5wOeqv870Feh5gLhVLV5MKNGdvF4N8D2t06w5WW7
         mlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752000566; x=1752605366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTay8Cx8bgDFDPX/AfO2y0JXUWGAYkk7ejr9qpnZoNE=;
        b=rRGRWAAKaqzZSH/yD1fBsLm53PAjSKBvYEzzwe/slcrE6JTlnM+nJklpazjNAq76gg
         UWb/B9HFO8MUQ1fEQq7+pggLAAMCXgoFM8HeFeFgdTh2fgjoljh3AJS/8lm9Y1OCmDfP
         cnS3hVoHwY7NQfoZUnBueYKVL+45JQVuVm3G/ViaJ5EZSyrCgIKculxRsg2fTZftjQtI
         id1jd5AGrPuhgpquHgg6ctpABjnyv4B+rMtsHtaQIVl/QquK3tBMgzSJ//3Q5D02rDtD
         dMr8mnYok+BKKfKmT2pVjOo+KyAUAu5YhefjbASwwiz4gvprjNSoqsuNXC4EkyaKRoA+
         vm4A==
X-Forwarded-Encrypted: i=1; AJvYcCWlinpdDeHwPRtP/zm9mq2ix449Gqz/7mbjHJ2La2QwLiZoARZ9QASvUfL+8pgZCgUPqJxoABkPTjZ7D+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOJR0nlDYucerJpr8sEgxSeCRkFINXR4fzf2zxY+Q2pQ1a8HCl
	5COE8jk9HNmV3BszNEsYs7y1u02Bps9IMoyw06I2PRmGACKbK771cqXxQ6qg+BC/
X-Gm-Gg: ASbGnctVWtopEsXrmVt326DsggE3o7eFHmodGwtyGPPr9EC8A2seyA//D6IPHp4f+0e
	CsvhwXO2Lmtp6zZ/jWbZBfaYLigd8FW+qrXXqWKEVZ+h0psP5NL0o9oQnp/z3rOdHnnYFarBCUS
	nj2EHscN4X75IFor0+jHXUiaohcGUfomJzy+mCIZ5ienAxw1ooyEHzjZBbTgIjilxN85/8CVBpH
	LThR6EdbsGe6YisNNfHRrkFsPaKqUeHDZrgWh3wLliVX2N8mPhYCcZqOb3HxGXW88TPbj26k3X0
	yLCe+GQaW0evt4vEA0gInyFofoqgPu6dtbzMVQmdZb0LCzyLOxsF8bjbZei276c2gZNt/fFlk0M
	IXX/b8IAyAXOyV6znszvpF0Cv0drx35BA6ZfGgOwvQtsnC04HhE4D25sPJg==
X-Google-Smtp-Source: AGHT+IGR897LvyX0eXo054VAQAVN3F6y1F0M1xsx9KzFC3PpF3v4lLPoZ4fbNwwovMtyDM/+TqQbKw==
X-Received: by 2002:a17:907:1b16:b0:ae1:c79f:2b2e with SMTP id a640c23a62f3a-ae6c6cd8f73mr39681266b.40.1752000566094;
        Tue, 08 Jul 2025 11:49:26 -0700 (PDT)
Received: from Lord-Beerus.tastitalia.local (net-93-70-53-177.cust.vodafonedsl.it. [93.70.53.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6baaaedsm944884666b.173.2025.07.08.11.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:49:25 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/3] dt-bindings: arm: ti: Add bindings for Variscite VAR-SOM-AM62P
Date: Tue,  8 Jul 2025 20:48:33 +0200
Message-ID: <20250708184841.72933-2-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
References: <20250708184841.72933-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for Variscite VAR-SOM-AM62P System on Module
and its carrier boards.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index bf6003d8fb76..07d2c2ab5150 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -100,6 +100,11 @@ properties:
           - const: toradex,verdin-am62p          # Verdin AM62P Module
           - const: ti,am62p5
 
+      - description: K3 AM62P5 SoC Variscite SOM and Carrier Boards
+        items:
+          - const: variscite,am62p-var-som
+          - const: ti,am62p5
+
       - description: K3 AM642 SoC
         items:
           - enum:
-- 
2.43.0


