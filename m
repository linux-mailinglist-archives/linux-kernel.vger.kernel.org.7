Return-Path: <linux-kernel+bounces-775820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB3B2C564
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1272244736
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F3A342CAA;
	Tue, 19 Aug 2025 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RlngBiUH"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF251342C90
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609455; cv=none; b=X+qRJAK5LQwAE+kv78x4vIYa/i0P4A4T10w9XKcQo/BqOmqKBG6wi8yL1gB/XLrJnm719WLMw8JCawLtbsq789sVCwBUfx/sOUvuEhTN3mVD0TNPRlifXojp+PI0wxbgMP0X+CmGHwCAkrAHBUtJq2Hj57V+A8q9L+6f7v6KUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609455; c=relaxed/simple;
	bh=vDIX409XkJoWw9Q6XgVBVMhCjeHRXaM9O04OkEsD7ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaJRoU1Pl9Bqr72vHSU+sLtAu6kNDlKWYvBI+gOHw325TogGbwRFpPF2MnffFLSLZcYVC9IqAkVn6yinnPGVel4oOE3vrrW7fpykK74ly19LMLn8GyOEZ+5XHLZ8WrT9PLN5XQezJVBCaLvsNVtMWCJ5/bSmA1BxQ2fcwtX3QUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RlngBiUH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7a5cff3so97927966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609452; x=1756214252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjVYQ2o31Wt0s4oOjjNkfAKW5LnQMlnPA5bHJIPGLc4=;
        b=RlngBiUHAhinPNkVHMTNt/hIKVBClM90BWI0a7FqP9C/CoOSC5RgMd3AN2RozPYgRN
         gfapFClpN+jz54dCLsVgmLJ6awxaXPzwUoatXoxUa1vhIU6cAJfa5oyUue9o4WGxsZNd
         A57TLhm/vYRgMGrfdq+eXF0NYc/L/euW1wqhXUsN3/G7CSDUwPcXvF51boMdoRKBQG+c
         rpkgMRf9qylOEsPQqH+ED2GOxSEWT1H0WMzjHmIKwKiB6bsYCxo8VuerfrxDPIeCX9DX
         /uYiMbxx2jUsP1JUDkt+rk5O6iLV+c7QBjwn90QAEKnM52OkGvDHkyrW/HBSh0vXKZf0
         UP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609452; x=1756214252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjVYQ2o31Wt0s4oOjjNkfAKW5LnQMlnPA5bHJIPGLc4=;
        b=bdDqZbOXozEgdA8dR/OtX+/zTRI77rlzFoa9W2oRgrqQzFtlfRfPz5k11vevxvPVLs
         /vPPTBmJNpYbv0g2q+gTAXBeLatqkqTycNb7F3ajGEbyCtbDussu4OPhxl2/6BZwQzTm
         TQrCipt6J9E3P4yBbRanwHPNdQazOGyxac8Ugw+W4wA/CwMtlJ99XUzi9yVO12W1rXyY
         pBlqCqIFPPtHFQ/D7Atazv9NiA/D5X7q42aj128kN+MWzEdDJVVXOSyt99b62Y7rAxFC
         C9v6YXTzM4Sybt2PoiPKcM2GL9Zl4P0IfDVB0GKdSQS8KOI+8nba0dHMdQaxVjS8KByJ
         fM1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoWr5SUlCo8Bv4/4fyqKNap12K5/vsEW132p+SGIAGnpShuluu+E9Xy+9bdS21l7AjL48bKltr7JQm6H8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqAp+eJcfWYpR9NIeFC6v2GLGm9CUxfbc+4MBMb8Mm6PDKmZKh
	lhmxu/sNVnbBGPs9HbtHmhD2721mC5XLEgmKvvvrLHQmNjR7hN+gtp5ae4ZIrNzudNc=
X-Gm-Gg: ASbGncsLCnKbugJIZV3pC6qdTST/2WxVA1oTcrgmiDBEc9WE4E3F9eRrUKpfPl/ibmv
	f7fJBKXcZJafXSX3pKccv6FfRDTu7ZktjuCXEEds7iRTd9DtRPr6HZadRAJKCSbXELCs6LcsXRT
	itqYJ3gUMf11oaNsP+Gmp1nM65ENPk3cBzI4aZoX8n++wOQwP+vxo/8HEi4jeEe/ZH5HXU7R948
	6YZtKv9AYQEXFYhq/9GsKjmvsYpoW6kO6h0tIgpgGGsQOCiMph84VzZKTpLMtoRkW9xUCn0/jv9
	3KcvS7eZXO69WvsqW2HEnz6pDTh2SIvpNSIDcgRT7hdl5MP43b374ULcIX6zNAS3r9aknxeUjFy
	MbJakLiW/aeGRIGfi5Y2iBA3B7OYA/cjhjQ==
X-Google-Smtp-Source: AGHT+IGoW2rMavDLleY2STVqCubc7jV6BzLT7Ex6A/gWPiyHTzPLsgNEsjpfXZkcM23dkCpRS0+YaA==
X-Received: by 2002:a17:906:7950:b0:ae6:c555:8dbb with SMTP id a640c23a62f3a-afddd27def9mr116015066b.11.1755609451918;
        Tue, 19 Aug 2025 06:17:31 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd04de2csm1023271666b.111.2025.08.19.06.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:31 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: nuvoton: npcm845: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:17:27 +0200
Message-ID: <20250819131725.86770-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250819131725.86770-3-krzysztof.kozlowski@linaro.org>
References: <20250819131725.86770-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=732; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=vDIX409XkJoWw9Q6XgVBVMhCjeHRXaM9O04OkEsD7ag=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHlmHPW43qsndZo3KHocAJD3K9RxN0VwvFKuY
 FcidO2bRDiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5ZgAKCRDBN2bmhouD
 1yAID/9Zp9ZjjLEMERK+PNNsU/fhJ5xM51k/pOhnp6a3rynBxNPgKirR6cSJW22rzyYyq3v2Rkb
 ZwKEGppGpuH9q9kT+FBwqTc2CASiUj82lj8v9MNSz3fFvPYBWcpbSbW4E9Qg4zOat01+aoJZtew
 vTZgx27fLCcXiAUYkGweEx8oTGXbxY/ODGqA4kaiDcNssCyu7zcTc38/qzaEgEAJi+l6Mj7Ke34
 Fq8O6Ga8K58o9aKyykNscT/49ahwqaLJkNlAK9xz6fXQaynm0Gsn8heGRO5HGYARYMVlW5XtLpC
 +6P1k++buaOokb8X7kl3qixEDBbhV1Q7f4+mk5NVJKPzSJNf3rHdoQxVvXR/D1A9o/va/wcKnKr
 53lZ0O/cG4UUYVz7H/QdLJPtiJmOgrqqx1ucd9dj/f4Ll/iFAs6kZiXOTecwhh26tKpeeanYZF5
 v3WxzUFTe0zHnts6WfhtZUaYtUIR4+WLHw1xx+wPrATAc6et8TIgv0y7HgJCvrcuEY8pjs6GrTJ
 MRExR5A88CN9WC5HpiLPvpB6aLr91uUZoFwBBF0jwAcZXz2gdEXc99n3iYYc50OjUo518WTyFX/
 A9VhakKqLgkFpIWl7gwkyme8ZunKQv9fkT2Em7P/MxWo4LRsKBULQu78h11QUSg2mFjcgYWb5am Ti40YDF9tdn1vnA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
index 383938dcd3ce..8239d9a9f0d2 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi
@@ -64,8 +64,8 @@ arm-pmu {
 	};
 
 	psci {
-		compatible      = "arm,psci-1.0";
-		method          = "smc";
+		compatible = "arm,psci-1.0";
+		method = "smc";
 	};
 
 	timer {
-- 
2.48.1


