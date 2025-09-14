Return-Path: <linux-kernel+bounces-815635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1858DB5693B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56C77A3868
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797E265CC9;
	Sun, 14 Sep 2025 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVf3Cw++"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328826058D
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855937; cv=none; b=NsBWNiN69S6xKQWz8owVnuVVGlRydvEWtiWBFuprVXiet6W5s7Kt7kfOECUP6z6XDrf9VJXMWOUHdPYQedQG8TduOA8ZemKG5yNoz9DmCc+GCtwZYyR/4S98uZRcFbKfxn1Sr3wksITNtgt6S3AnQ4/2YfnwgzKb+SfrPh8jq4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855937; c=relaxed/simple;
	bh=ilMxvWH2dg61Z6fyXi47Z0rAj/IgKekCXgAzquw3YXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axysFGQV0tSl0VbAEbUrgspbJWLDr6zBOosdPvP63+f/AtZJzb2HlT+Rq+02RY2uLwD1UOuE5w2plBEN2sMCfGY/QWawD5QAnHfSIkydkEZIGBOraYFl6cKiUOywSECzeGDLXAhiriZyBC+ARDhsSolbF2sAj7DLJbVhyX/MzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVf3Cw++; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso27340975e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757855934; x=1758460734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpcddqPrYhRHRnLKWFJl0UXLOkAIbo7ClNO40SWmR1I=;
        b=hVf3Cw++enjGQUC9WJ50stlt7rX4H35ZsfgQGzaiUVbxhOB32YAQdl4Dnpp1zqnTlp
         sa6KTtBAG0/zLJE4UWOPP0ziV027L105cojgMak1t8JT2gXaBI4PoSyL/uSaGfBCt9LZ
         voGxVCPcQjO75VppmQRCU0FPOYpQJxZtnGKcaUHg/nRQqRM6PfO3PHjOEk5cU4zboo7c
         G+hxISv31JYJxUeDImvElLbSO9SpA1boKwB7a3Mol8ML4izkmwdrZgbJ/6Uqow7ECg66
         nVv1jbKVTM6kDA5B4ZiUIpaPFjb8JUeD6kitjAU80jBEMrIL3xZIE0Jqb47Qt7/j+Md4
         Qh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855934; x=1758460734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hpcddqPrYhRHRnLKWFJl0UXLOkAIbo7ClNO40SWmR1I=;
        b=IZis+kMZBbilQ8c0B8ZBAw2Iu6NVQHN5v2E13b+/2Fu2SNlv8QWXcbOW1ZbVF/mpmi
         8NDCK/miTvilR/AuraHeQbMr5UyUjlSKXZa4IXUsbBkf9RjHNebPKrwIcxxcm8axWLeg
         WdqdeiF4PvWUEAVx4wa/iHn0+h5o4NNTnGMzPSIErS02JMdL6UdiXfZqokvmaZz3DPXS
         bFRFQ605DlzodSxfoXWufXEn1ObObWTQHhgHKQa7LcpWLOLUoahLrWL5ItV6aj5nONV9
         E1vC/Pv2Cd0WmG2En816Q6LXC/0CrTD9H/NoIYoCgq+TbnvJ+VpmFiUXBziRdokPxnyK
         BcWw==
X-Forwarded-Encrypted: i=1; AJvYcCWt3UTvssSiyOsl5xbfVpEScsI+uGsDf08SKmqSmxbEwQMTH0g/2kB+LSugPxn9r0BoutTGRNup6N7d92c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk1lgwfASZwVRXFJyC57ssrKqv80bv2BTpopM8EXT6oHutPEsq
	rACCdEI46B/OphedAu9nSPN/oHqOFRvFo3f6KaV9pvocCV/5KYzKTslg
X-Gm-Gg: ASbGnct/kq9evZBv8ItaIX07p/WVDRd/7fkZUwvA+0niaEoop6NGpF1q/1QCpiqK/AS
	gCrQHqNUFMQFe9K+5hhc1yDpNX8A5354nqb5ZZ5wP7eXn7v9hA2/ZQDcJlhEVzVWgv+d1bJxIYY
	/nJQYA9gO4EQw/mF9f4VkX6b3FQnqoZbZ22bJkCrjDZ+6CGHwFPJuLY0cooy5EDXSudgk3uOq4O
	9NKdEyD8gH78ihc+Agh3K5AplBVUckg7dx/lcOuLa2PnX7jnLaiwpPFzKSOSAc7+Qb1f2c12fMD
	apwBrTmhiNp+RImsnfBqb46tNXaR6M6uiDOWfwW5PPoyEASufXHqESeM+SQe5o1/6v7+P7eULci
	Z+y+i8cOOA5lbwyn4eHo/NEnGAjCF7HIgbu5nZmrysZsiO3wuwBO7lfGlpMliQo0F4/bal6Ge6g
	==
X-Google-Smtp-Source: AGHT+IGAQ9494spxVybXeZcysph17sK0XNJ3EcpSw8C5tvKdn4tAgtOfyRpsT2ldfbY8hA09fnwBpg==
X-Received: by 2002:a05:600c:1c0b:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-45f212f9888mr83535235e9.18.1757855933631;
        Sun, 14 Sep 2025 06:18:53 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037d62besm133359875e9.21.2025.09.14.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:18:53 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for exynos8890
Date: Sun, 14 Sep 2025 16:18:48 +0300
Message-ID: <20250914131848.2622817-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add samsung,exynos8890-dw-mshc-smu specific compatible to the bindings
documentation. Since Samsung, as usual, likes reusing devices from older
designs, use the samsung,exynos7-dw-mshc-smu compatible.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index e8bd49d46..27c4060f2 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -31,6 +31,7 @@ properties:
               - samsung,exynos5433-dw-mshc-smu
               - samsung,exynos7885-dw-mshc-smu
               - samsung,exynos850-dw-mshc-smu
+              - samsung,exynos8890-dw-mshc-smu
               - samsung,exynos8895-dw-mshc-smu
           - const: samsung,exynos7-dw-mshc-smu
 
-- 
2.43.0


