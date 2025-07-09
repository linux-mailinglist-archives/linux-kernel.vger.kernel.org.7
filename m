Return-Path: <linux-kernel+bounces-723949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAE4AFECE6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C6B5A710A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64602E8E06;
	Wed,  9 Jul 2025 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="o4+qvPsY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD02E6D24
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072931; cv=none; b=SKz741rYa3S8Qnd8iUUU/xthfry+0UnDsxH/oVPl8fLL2rPlMaq7bwQ+jc94wVHO3EsPKPXFs0tYjrN329b2EIygsEVpHsb4LceQK9UI/W0pDp3tmSS1Kv3LQZF6Ag9wISzlMqUy/XuFmBrbS6O8liZJ6emXRUAKqmksPZ1IrTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072931; c=relaxed/simple;
	bh=RBqmm6y91+jO6MdXINPCWCg3viAFwnMdKUq3SgXL3z0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fw5mVSzFZjNmyQ8MG0eSfJuqH4d0ptkDXfpD/QHyCVKtLMKr3H1PCWa8VdHjSefZHP7bU6mscC/XCNVy3DYa0nL5wMaX6jLdNR8zK1MFAjvxUUWvP0rdKPSZJRmGOA/9gsWF0ywQHU4nQ7F7breG0jc4cZ5enj0SSTT8foPT7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=o4+qvPsY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so3677166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752072926; x=1752677726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NN/6WRtWv+PbFm6J3y+B0W74bkmxsW5QkrIaTbqFnB0=;
        b=o4+qvPsYfRKiUoqwQMhbRKBKXtpc9sslGmFMAlEvjAjAtQ1Qh7EJZ35fx2bKlvcQs9
         EXNhYt/6RsDTy/gzMHzUnLgexHGGWTM8Uc10u0S8Eyhq26b6y5eisZa4t8n+gN1GcOvM
         eJwrSD2n4uC062WtV1v7vsK9fontsS0nlc0WIjc4ibUwq1gwzSMfthuHxybceq4GKB95
         3HP4bsC5lIkaxQ4RTwuM/pkyCU0kvwQf7rw1Q3ARl2uruQgHb4do/vPTkxrq13/aDiiY
         iI1bmPsIbZ7JWs2XXNBV2ESSgiGVOHq9wxpQAlliwCRH3s7Y5u1YjNaGgAV5QDXCx20M
         fUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072926; x=1752677726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NN/6WRtWv+PbFm6J3y+B0W74bkmxsW5QkrIaTbqFnB0=;
        b=mvGD/xdVsMINc+fTlaePoNYPgVkp094edAYRYKzw0NnpjoNeC1khnTB73dcRYv8xMz
         MS7FYac5GBJqlStwf8evg06rW95Y6s4o7I8jrX4htgmugMO/ZldqOpfnElTi4A6vKC+t
         K3fhX5hktxDcoi2dd9L7jsSTSoDtTW7lo+R5sTL94vK/NwplYX/VOE5IzE+3P3MPHDgf
         3L5+NRg3OjaIYjPgH1lDedXIYWm+jAGs3DcZqpMmWa2G1o3Ywlu6dtRy2gBSYEtZI2li
         z3X5X9PdIeAUl+/vmR18vZntDskoBQ6B5TkcmeopLjNls2bBFjKMZ0t45Zj3C2VLypyT
         Oxjw==
X-Forwarded-Encrypted: i=1; AJvYcCWzPd+we+1Y8Kc7PatcpfkRTdHVo9kk8QJKAYzpAsQn9SbFzF+N3frFg2oouijk7taQLFHxjw2ayPlt57Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOhfOXC5zZplFmIXP2g+gOL06YJACQskQXx3nv9CSVIonTGV1S
	86uBowePs/HBbE3FAlG4kcdXyLxoEA3V8/M8Iq0BaXnNWaIb5bKHtgoXMHS4kJfH8Wc=
X-Gm-Gg: ASbGncu7XtSrDci2aMkwJBcSLK1EjnU27P7JbeSx1q2eL/yfNLaIYE0mzJUYDB+OGTz
	YkUp5emlBIsjZN7Ay89hOjqqLtEWLGy2oUpnAsnsVOaPvISBscD2jEfmSKNRNLd76ocFUwT4bHh
	9VH2stns0ayoBZvUjAKTk60AQR5+8Td0an5bhbGFknWXpkGDFI9yF1dkt3bgc65kBR3MLghb9gT
	bJNFlKCT5076fNyZ1YYCLX3Oz+j1ul4xwxBJ76xMk6MpwejwgUS+auqAIAd3j1mPpKXlWjhojeJ
	PbkmRg/eos9aKghY+4EWjaq0xYiv+7ZFx6IlqS+SLz/Coisxy2NL7ELC9g/oORkVSWsVnq9ayuX
	HuKoC/DhzhgR/M/wkk1zWVA7rlouytFXU
X-Google-Smtp-Source: AGHT+IF2i3QqxTWjuz5P1YW6xQ4cfF5i5ZqOygwIXICALdfEZ1j4uTvDCh18CLGk4T33wWsNXDP94Q==
X-Received: by 2002:a17:907:bd96:b0:aca:95eb:12e with SMTP id a640c23a62f3a-ae6d146ee2fmr277785366b.24.1752072926007;
        Wed, 09 Jul 2025 07:55:26 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b600ddsm1116795766b.158.2025.07.09.07.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:55:25 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 16:55:16 +0200
Subject: [PATCH v2 3/4] dt-bindings: phy: qcom,snps-eusb2-repeater: Add
 compatible for PMIV0104
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-eusb-repeater-v2-3-b6eff075c097@fairphone.com>
References: <20250709-sm7635-eusb-repeater-v2-0-b6eff075c097@fairphone.com>
In-Reply-To: <20250709-sm7635-eusb-repeater-v2-0-b6eff075c097@fairphone.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752072923; l=956;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=RBqmm6y91+jO6MdXINPCWCg3viAFwnMdKUq3SgXL3z0=;
 b=hwGOCiTQWIof7HrmAiBGw2P9RUOR2R7YKLzD2dtTwUYTAmNlWb35hTXpZMFEfFaYmjFiUHBqy
 d2B4j4RXkNvDSM+jA2uL6VWuTxh1n7b9WZPphpHedP0CWDus6dVYyYm
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a dt-bindings compatible string for the Qualcomm's PMIV0104 PMIC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
index 6bfd11657e2992735998063b3ca390e04a03930d..5bf0d6c9c0256300d00f84307b7f6ccf669f17c4 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -22,6 +22,7 @@ properties:
           - const: qcom,pm8550b-eusb2-repeater
       - enum:
           - qcom,pm8550b-eusb2-repeater
+          - qcom,pmiv0104-eusb2-repeater
           - qcom,smb2360-eusb2-repeater
 
   reg:

-- 
2.50.0


