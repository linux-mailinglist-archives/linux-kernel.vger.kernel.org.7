Return-Path: <linux-kernel+bounces-856526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E39BE4642
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CA01A64298
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6152A350D48;
	Thu, 16 Oct 2025 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qxd8D/ID"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677F134F47E
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630327; cv=none; b=FlFoNU874Za3BoNH4XXH9XFwFTJGqAxfqHPGSwJwjcIEOUqYaz89cc26+08129DClrq+3jLo4gjgjHHpjNhqOahDyyaitzDvX7EbmLWs9nNNrfNCNuMIugr7S4PJ+ztNKmV50AOsjdZwShENInK9Q9QK91JV7V2PIovAmXx5CpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630327; c=relaxed/simple;
	bh=wrIYG3Nz5u06Jww4oYJhqOv0hyk+YRHCWFWVoDPnx30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrk/Io4XCt0qIElbNCI+CUGK0Hq+Ya+DALMIiIAL05eyiiMMzn0fADjCo/r69ZxP2L8jJv8mEd12GmCGPc0OwCapo+Ioh0SKtv05W1pkAaw4nVKnuC6p7BGWx2ghlFe9LqfaxJFrHswtSTnEIttrSGmajIc6N+Aw0Bubuy1Q3qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qxd8D/ID; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b50206773adso395186866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760630324; x=1761235124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EZqCABiIEnd0Y9dNLKHtIhbcAbjGjEboA5l9h/vQsc=;
        b=Qxd8D/IDhfolUnz1Lc0tfc6fhnSEqzVHXye5rlrzSnJaLjIyoB4CIuRRnsgbbgZ8yE
         3z5hJKWC9Z/qYLB3Y3nZc2i2HsE4PK7IMuts/ff7eFES64jxbS7PEnVUFaeauwabUDHv
         fJtuveJOFII2WmAMBJukAD2OtFaxxJOItsGbvyN+NeNlvx5f4I9Nv1IC8YUxPphYAu23
         9488NaG1kU4BZtM3E+nYT7pwkLNH1FMcRsOHZ6PwXGs4TWqBrlTFzzPG+uld6/Pvo+GP
         PNzfTP2VM01VznCGC/vypaUanUjSh7DjJNWGwVumSuEBrZJi/rBnw0DDWCVZrVZFtpVe
         bJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630324; x=1761235124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+EZqCABiIEnd0Y9dNLKHtIhbcAbjGjEboA5l9h/vQsc=;
        b=Nkb42pwuhKI2+IMCgEpXVS+Nc6GUCAsJ/VWDDZtBxhhYLM4mERKbPNbbCOhpPyTSCe
         hY6MhPbaoxNLHTDmkTFVEkxvT/EJDwRbH4DDpDOKrFWuJtuUMbyGphcjHurcijOptNjZ
         D2LBsF1Ec9gXIRX0ay4HyQDeAW+CslO7CHZtGFJtHzn155skfD78fRU4Nte+/soOM/Ze
         hwCeIe5Ls+UpWFY4AmCGIbQLLG2U7MBVJWTk6Fh256HkkQbrIzqrKQtg6U6rotPlYXDu
         roWmrNf0u2ccR9kbm7jv+oaM9mX59mq3kuU9bH1O5v1z+eE8Lo2tKQUYse9+pHUUPX6u
         S24w==
X-Forwarded-Encrypted: i=1; AJvYcCXZdMahKS8u3At/GcP5CcMgoV1ZivkyFnCs6uepPYDs4Lnm3AX1lZaLFsI4J45Ef6QUXTN+Nd7ycotlkWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJCwyCNcpZW0yOAY/hFBYkzhEnch6Tpn/nWniHPZEoUZFcyZ+
	1VulDvlMe/x1wbL+LhX/0uJEYTJwxkR9CtP5uY3TifXnWySoeuRawsIkRmZ4zDMRGWg=
X-Gm-Gg: ASbGncvkaajmicd6lkSwn+725kMmkwWQDVR07JnZlN2pgQu3390SJwk3Bh3wRP7U3r1
	pyHSK+SnTHkrtY56M6v/Bhur6v4caiDxy0zWrTUZaVb4B5eVR7TZDqE8hoo9S+bwcPkxOgEzbGM
	k0/hDuDXmCEiAjxgGc3BqyFmonq0o0d4CXD18Psezm4q0wxndA9GdsU8PVNZx9GTT+zTm7ydxbJ
	pNFNSuNN/1iTWnD5tBBsW2+N/+L7l1/ckhPtfTlUdK6Hmi9ZkGHw4KSyyJ2byIfKdQU+YCfo0hR
	J1q0wlHUMzqZ9ikkEPGnjsG+H3AS5jKxAIlgq2HuhCCSzxf9bh3HnBmIbfwyzLG9pPzcMxNq6bY
	Fvyylxa0NiGPgTGDeoxxIdW4bBnlCuNC8oAs/iBptJ0f3THzoB188Fhx4iU53k13ViC092b/Ayx
	rvtSNQ+66hijs2VH/BndIVTF24m1mECQ1K+iS6wUi2YJpyoFSI+VEuJYb6KiFD
X-Google-Smtp-Source: AGHT+IFH5MBvT1BbvZNO7LnK4pIDcpdPVfm9z0TGyk/r6VaVSo4jUiDBCHuy36yU9LuWlmcxA0MaVA==
X-Received: by 2002:a17:907:d27:b0:b38:49a6:5839 with SMTP id a640c23a62f3a-b645d20f122mr99022466b.11.1760630323679;
        Thu, 16 Oct 2025 08:58:43 -0700 (PDT)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccb4811sm549021666b.56.2025.10.16.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:58:43 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 16 Oct 2025 16:58:34 +0100
Subject: [PATCH v3 01/10] dt-bindings: power: samsung: add google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251016-gs101-pd-v3-1-7b30797396e7@linaro.org>
References: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
In-Reply-To: <20251016-gs101-pd-v3-0-7b30797396e7@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Add support for the Google gs101 version of the Exynos power domains. A
new compatible is needed because register fields have changed.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/power/pd-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
index 9c2c51133457112ca0098c043e123f0a02fa1291..c35c9cb0115d79e5c36142da2c2a5dd30cd2ad47 100644
--- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
+++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -19,6 +19,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - google,gs101-pd
       - samsung,exynos4210-pd
       - samsung,exynos5433-pd
 

-- 
2.51.0.788.g6d19910ace-goog


