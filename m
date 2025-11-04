Return-Path: <linux-kernel+bounces-884769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EFFC3113D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA3494F78E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5B2EC0A2;
	Tue,  4 Nov 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOJhdfqT"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E32EC095
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260701; cv=none; b=OYlpkJBGVNe8NktVQIfhNY9OfDn13iwrbax9XC9BX06m4UXsLHDSKNrAEwVQmwzYJ9/aIdEXFQxJvjx9TJCIqRVB/3NrGandbUITIc+NHdq9y6ZZId4oSTndiJGVk7SfoQt1OaHnSWL+RCbXs7S0Rde1rClrksSfzbJGBulzAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260701; c=relaxed/simple;
	bh=zfksRdzqKJhRlSNkDPTjQcTPNmX+bLOPlYzuDXVDI+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BSIRTkrgk9orZXGvnXEnAKBOsQlMfijDny5upEcj4wY4ElufupXOfL9sbh+j4uTlf5NjjeNIoQtMU6hl1ls3u0z8rc8fyrfqQqh2fhc00NvWLFGuz30ciTHzKsjxXJ5fJ6qk8L2lPBCnY2JdeaKfEPjWuKBspb1crkfCbegjeTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOJhdfqT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340299fe579so5490759a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762260699; x=1762865499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKekkA7djcC5xOnYLDnvST4x7vzTTfMx0HGr2gLWVgw=;
        b=AOJhdfqTf/r2no9t8xvJLevf3iiegfOwkmabKTHps1uMLB7sYgz0JnSC1mOAYmsP1U
         X1dZvPBWvRzdVa5B/IG/EsSh4VjKMEo84youijokCoqsv9b0meaZF6fgaXugUY4uJ+Oh
         BK49anjqu6d60zV7mFV0J1FPxTd9b/ZV5mh/qPHfBj0VIY7dxRJQh4y2LEgjlrSsYFGb
         ZTd8H5ZspHz6zJu5eZalTSzrf0JR779OY6nr3m02HgrPm1MIu/BsT4h0qVbLcTbIkh+3
         C16JmeR/XNDw2dvISkGU9K+YZGUSmyPg8VvxrC+BxpYkZTB2XSySMnhyRU6XutPCVHbG
         C5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260699; x=1762865499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKekkA7djcC5xOnYLDnvST4x7vzTTfMx0HGr2gLWVgw=;
        b=WwhERFhcSRvC/Ti13jY90XEba/rRH0QmgdT1IjYoIXxxGhEl7asigxwPbbCQZfNjsR
         z40fUKWfLr7W52yqp+jFnGIG6Bv46rMP2SfOYOuC4EvpmspiAKbY5Q9gCz0g++gjaSjb
         hEUOmGvPeM+6GY62NwpxbsN1xpmFBcuR8RQv/6HwmTf+6qfFh7nYAPp3Sz/9F7bMKt2C
         UsQ86eaTkuC0SlsJCpBvTxwW9yWeUpLkii5+7B9eFV0aoiEwuIpTyvVlturcFZVTaRZO
         r4jGV0VVAovLl0M6LdZZsdzlWj6JOvpmov5CGDaoi0s5mDP9GBlI3rBoqMC591hK6d4C
         PGpA==
X-Forwarded-Encrypted: i=1; AJvYcCUEMxHIRf4hxjIWdpDuLEEC6EThLVakUHvp0TAJDmrFYyiMlZx3lvisQttkLTc53+unFK7IP2TXm3/801M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYNtye9uoHQCInxNrrPZuuJ3v0uldFOOmnjvH5lU7d0dg35XpV
	3YwwSMvuFvuBzEULWAbAC8WMenR6vnt5N2S513d757zS2Emtj6ycujft
X-Gm-Gg: ASbGnctEGm0ODdXvwGXIZVYlWBjqgwk2NrkcTIdwd8P4fnVmdm0V0BxWjGaxuCM5flt
	/f+OJYKTlS63xPVkLX1HGsrqKIc1rAQG+pOqqo9D7AuPvj6TzYE0LzDnccJaXg0wdimT5zQ9iGs
	n66HLK6x7XQ/W2l29wWb90svX3gdyJYfEJ5Be1EhuP1RM4eLqRVLoT44lvRV5s535QT5MXCCPj+
	yrp6hbbhJFV43Vi4ueOoEOv9H0V0lDUgzZkp0dsL2O5l5pj1kWw6PWqdLYMzrP67bFysu+FEeKW
	bo5czscz47IWD1Eb1Rj9hRY7AZup88ERKwzELhU+gJBck/mSwkB7lEeHQzb+4p5yWVXjc5mSCa+
	lL3taCxZQpSOjC9JkCukYs9rGqyz4t4zuLRTK1SrGUWgycuOKYBbnMzYRwGqoIFWBl4ZgOfQK4D
	EU4azWbcz649W8+ddMPPh8ubpTmA==
X-Google-Smtp-Source: AGHT+IFNwdc3QqQkD7kIQmQums3onTSmVj2aZGeMwoERyucyIypuw1/hEudYSpSv0RCXqWPgNdn//g==
X-Received: by 2002:a17:90b:1c06:b0:341:2150:4856 with SMTP id 98e67ed59e1d1-341215049b9mr10274099a91.17.1762260699090;
        Tue, 04 Nov 2025 04:51:39 -0800 (PST)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba1f2a80459sm2338616a12.15.2025.11.04.04.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:51:38 -0800 (PST)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andersson@kernel.org,
	konradybcio@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sudarshan Shetty <tessolveupstream@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: arm: qcom: talos-evk: Add QCS615 Talos EVK SMARC platform
Date: Tue,  4 Nov 2025 18:21:25 +0530
Message-Id: <20251104125126.1006400-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104125126.1006400-1-tessolveupstream@gmail.com>
References: <20251104125126.1006400-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding support for the Qualcomm Technologies, Inc. Talos EVK
SMARC platform based on the QCS615 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0a3222d6f368..a323be3d2ba2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -862,6 +862,7 @@ properties:
       - items:
           - enum:
               - qcom,qcs615-ride
+              - qcom,talos-evk
           - const: qcom,qcs615
           - const: qcom,sm6150
 
-- 
2.34.1


