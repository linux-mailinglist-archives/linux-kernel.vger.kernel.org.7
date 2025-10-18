Return-Path: <linux-kernel+bounces-859176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E90BECF42
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0A044ECADF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234DB2FC02E;
	Sat, 18 Oct 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOwblmpZ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448C2F9DAD
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760789532; cv=none; b=q7oSzLAMLz7X2y+eZ8x+c5tUxwFqtDhME2ZIcXn18WNY7/LdgzWkUbX1OegIzCFI2FykDglb2XpogM81bOHpOxbES+POo8FsQE7f1h0IjzxnJhCNKvNlEIltFbleuoXRLE4/s9HB1Oa0ciQHaSWTXyf1/SGu1UObbU+VX4pg9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760789532; c=relaxed/simple;
	bh=DgZps663UDZN5epdnEzCbjtCIn6+YBKEMEwNs6f1LhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLSt84u51qIQ5f0yvpn8is+ULBduwotlKcQTaEZn2hbeDTmPdcmHmZY4fQLT0t4NquRH3pg4Rqewo7MUGo1yFAwDSQtG/Yz8zVfLsScQCdGW+RAUHsWsro8KZp5V4uoq/AAXEQIIbRx7MUY+5odL1agyJ4sfwjtTZI+6dQ8IHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOwblmpZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-427087fce27so189165f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760789529; x=1761394329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxpK3WEFRP24pO6er2HLu1PilAUDMnnv6oX193o3fM4=;
        b=AOwblmpZ/IcleGqeSoXhSL4y5BNIMc0z3QsztL141FAs0pEWD3wrayU7YgKS00yUay
         lIjOMkAQvK09w16r3npYGEyAAcsa0PS4yTqupkmOsHqXilCC/c6ciS+vvp/b72AhnXRh
         7d79SdCbo+QO0BQWgmpH1JS3E3AEx3xkJkI7hXPVRvojh2ZX+c/Q+JdFPsrcJVeSPdsZ
         JB75vZz32P48t9ty8tQZ4sxSUP5/5NHLK4q7iKl1rDPFBG8brUN6uBoNY6yxYznvFUgI
         nAUKRFsIUkfMOVdsS8kXTeURL+76VOdCA/Lgb11n4KJAIXbU1bUG44j3C/Ek4G5bVGeq
         GJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760789529; x=1761394329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxpK3WEFRP24pO6er2HLu1PilAUDMnnv6oX193o3fM4=;
        b=nnJe8eTPrf4Lz5Ef6kpo+gBpQOXFOkML4dOXzIi4xn4Z8v/OcYZ1uxokMoxnEDviJX
         V7Gpbze5OP2jYF+sUVIHjY3DM2UWZ69ePkykin5Fgi9KO9LlbFZrJ7Var79KUHBVaXPC
         EuaM093hzoSQjknWPTJD3xQ9rs0bRBT84bR4wSXPvXWqVLy/ejRJjRvwbUlomIvFcidS
         qCu9ATL/41kbO7fCMC5gFUPixoA2i9Pn2tiRB4G5xn6yHey2LqxmNcDTT9vIgzrbviUX
         +0SVbWos+hkJ0EeDYZGBznP9R7eSlaIlDHjVpu7BT4VNHar8XRcNFhvLM3zyWw0aexq8
         a2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV7hdUl1fBP7zDjpw0iT4q6sJA+P4rrsv8bS8N/MeYdqol8MWNo+gsGCXkmYHq/18vavJ0DyWwfrEfvb9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBbZIWklvDFDV1rVoBnSAZDusUYW1a+OqxNZDmX53wFORSj5+u
	G0Onohcwh6ZyDTYP0hR9r+26PkZ0uyAHEtFeYBGXaydm2OhmtbkcvzDP
X-Gm-Gg: ASbGncsEPcL+kq7N8yn/N7aVtcYcLvXS5dGbEnM4RAXPsnUA7O1N7+J0PPrfKKS6Zga
	hVM4YMh4r7Ed1rCXRphwltmRfuHUbrBcNwRHQiTz3RiB7uZeedx+EaWxTRlaC9aUUQpqK9R+DFd
	ZeO2DrJbd5zZRXDh9v/jqvab+TCU1IVGh4io0IgfYEG6ciYYF9xu+ncguOgbDPAZFcBwJvaELGz
	vyN4ZlgN9G5FvBkKRUB43rXpTYCbjDvAHoa2CbVLG2PaGYm/mPO+Hnem7c+QoTP6TR3GWxUmkpe
	XNBMwmuhyI+pTg4DNiM5wuC7J2ySM3SvjWd3hS4UUKWfr19KWl4p6yn9zTR86IfGjDCtbWzCva5
	gR01Ae04+/lMdN2A5kMi6Hg0++MjkAmvuOEX7s0eTAGFyZAH1RDm77prGWUqkBCQ314qCYB+Wge
	TesD74xYt8pcJk8kfNsEfP4zsdeFZgLjTQC40D1pxA
X-Google-Smtp-Source: AGHT+IGC6LKFKhEP+nYqlEkB/aggNqEhJWaEiRHj+L9VYwOXrlGpXchMJU2/J+fkSJXgQUSdUq6mnA==
X-Received: by 2002:a05:600c:3b09:b0:471:152a:e574 with SMTP id 5b1f17b1804b1-471178a4b36mr29997065e9.2.1760789529097;
        Sat, 18 Oct 2025 05:12:09 -0700 (PDT)
Received: from localhost.localdomain (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f19sm4763812f8f.9.2025.10.18.05.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:12:08 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	martin.petersen@oracle.com,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	bhelgaas@google.com,
	l.rubusch@gmail.com
Cc: arnd@arndb.de,
	matthew.gerlach@altera.com,
	tien.fong.chee@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 08/11] dt-bindings: altera: add Mercury AA1 variants
Date: Sat, 18 Oct 2025 12:11:52 +0000
Message-Id: <20251018121155.7743-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251018121155.7743-1-l.rubusch@gmail.com>
References: <20251018121155.7743-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update binding with combined .dts for the Mercury+ PE1, PE3 and ST1
carrier boards with the Mercury+ AA1 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 72cf04b22a08..227665d0016f 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -31,6 +31,9 @@ properties:
       - description: Mercury+ AA1 boards
         items:
           - enum:
+              - enclustra,mercury-aa1-pe1
+              - enclustra,mercury-aa1-pe3
+              - enclustra,mercury-aa1-st1
               - enclustra,mercury-pe1
               - google,chameleon-v3
           - const: enclustra,mercury-aa1
-- 
2.39.5


