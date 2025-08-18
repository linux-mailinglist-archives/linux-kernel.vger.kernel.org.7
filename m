Return-Path: <linux-kernel+bounces-773194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47277B29C96
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1407D189E01C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1932304BB4;
	Mon, 18 Aug 2025 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJn2XZ6c"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463F30499D;
	Mon, 18 Aug 2025 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755506642; cv=none; b=aTKxYRw1BOhz2Ga1+3ehPL8qsd5yznXdRfiK7ZYi7qALuXOXuebOWLETa7ssx0Q8BlobaV7db74pL3rIg66up9U2tSRb75VJowymgeh1ZY25hSzufv/TCtgbxazarATPk9X91mtNlhIU23j8B7cAA48nHfHhnbAnhYVJ/A+MKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755506642; c=relaxed/simple;
	bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bV/kNr9zg3OzGFGC88/nEeghaSVZ9CLfpA58GpvIpElVD1iqnbliuHQSl0h+k5YtSGNwlsnUpdhSXfzWMubDd11Uwad2HQH1W55WM1tGYGztmsbVcGx6jZGBCS7zpYYpQMoX4pd0nB5bivGZnN3P3iAqMwirWXUUsAVWs5PK4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJn2XZ6c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2445811e19dso29384375ad.1;
        Mon, 18 Aug 2025 01:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755506640; x=1756111440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=kJn2XZ6cHZXEC6ZUNSPcJG6UQaQ9sNOGZSnV82AESxkXW8ifstkrFtEx66Z0aKZsA7
         S4AVb6NPZOjAxw2ZWhSALMnAhNa9f5SSlVgqBrqdRlssKrP5jmWmfBZDoJFFTy++HKCD
         No2fg12pkxCzOY4GaMnoWgtQ6AoXtOlU1MTDNHyPqEMpTKlJ+KOCTBs8o8u9jgHB6RVU
         OxDQ3cfwPvDA22B1ko0kNMQCY3ROGPQr8waBXA/8fYpxIg6v/FqY2+BiO+40QxGEaLyr
         jKtUm6yaf1h1cTVj5kdwwI46gKgU8JOxIPqFD8txkyeH9M2JkEhqQrWPUdtnGVglzMEB
         fONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755506640; x=1756111440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=IzQ4MI0CwdyqQbf5vckBBdui0s85afPYUi6YsqUUyV8sbtEKtzhJz1UAdMz8LU06Ht
         URZHXDKBq3BSwU5xkrKrMLYZ64Mr4Oc+YinB+8uXW8XbvCDkDtMIAkusl6mT+Bfv9Luo
         FexaHJ8DaScJmuMiYSK2oNGrG0cMNuBIQhhDXJ+bMyY8TF+pPb1NyterBtyRs/I2hw1a
         jgqxXcMUK8invyBtpHFm18cFVY2qh1LWCEXxX7BapMUgdYgpoPYuBdI9ZJgxI4PNN7EQ
         Este0JKshoc2jL6VQNv8fcWj7+6WMVIhH2p6ezlWoR44T9vCfXaVukgTX/9skLXbLwXv
         quAg==
X-Forwarded-Encrypted: i=1; AJvYcCU4TyXtf1RNNXpPJj9aDw51g28PpRQoguLetUqeraOmrfwJjSfIhMUWxtkVzq6V3dyKNdeVgRc2mnv9N2Iy@vger.kernel.org, AJvYcCU4WF5KFgvBIQ0M7xP5o+7DxEiHkn6eNWzyEbtFZ6ax1Kc2nkpiTkTiGSAOGR3bFL7ojmpuUcMgFS5T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg//oVpS1lUH9s4mw7BdY8AxK5G/RCOtgBrDZAEh4zjM/Pnseb
	JIEgUegHE8gGx8MOCv1SCi/7OHJFjSbhvTeEXyHIUJTCSsxCmkXLNx9Z
X-Gm-Gg: ASbGncvZcVV2Hz8CPrSTGZifxYwix2DRN2FGHUTF46fYUZLpg88FwTNqiqlNgnSD3Kr
	ZdlPdT7R4weL4gUVfHwXnz2r3ubn+nH9ngyxuK02JoKBEO815W/uslNK+IZlUguF5n36OPuCwz8
	sqhcUKmhKd6bOkNw1vFxUyhcO1vGaTJekdRpITtdfUG5OZ6k2DNCzWpNkOcnY6eOCo0GJKufi3s
	7STkpBaFMjfjNCZaZlG+wPn9Fm2u4KShyEzQ1UmVtfe2Auhfy4sy0Kj5BPoiaRezdjySGI6MlO3
	IBOzpHqG6lpXMrk8862TRegWTGDq+ZCcyUUW6bc6qmVDBhnuZNpDBGH5m8Ic7D7PUMrqyAf1eHB
	aaVVeESqBAvdIKIUL4zVDHcHnPQW0QMfheqE5Pdroyxvwq1s=
X-Google-Smtp-Source: AGHT+IE41TgaDK6U7fh0y68RK4M9hHY2iTY9/syz4IuIq1e5ai42XH7ZdeIfRSVEhQVGfnthb5LW2w==
X-Received: by 2002:a17:903:2304:b0:242:b14b:15ab with SMTP id d9443c01a7336-2446d8db8fbmr133100255ad.42.1755506639947;
        Mon, 18 Aug 2025 01:43:59 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2446d538f75sm74090925ad.108.2025.08.18.01.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:43:59 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 18 Aug 2025 16:42:59 +0800
Subject: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
In-Reply-To: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBoouel76WKJHT6a2iEtG2nIQSl6p8GRmIT4TNIr
 Xm/tahu1kuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKLnpQAKCRABygi3psUI
 JH+QD/4iOQllLnnWwQJNPY5oL2ee4utIpCyxF094977VkZE8cu11GVaSzIu+vwks3UlOctE1/vh
 3M5vIVvKzCAQdKgP/hteJAXI4ORPUYXNdTy0OGn0Fj0uB/xNFWrkC9sMhtE9lnNb0GBc+lL5PzX
 RGnyCP5QXVmM23oBXVe1OaGgjfnOtpIbNAv06wWJv/Bl4qucj7bb2LyFmK8cXM1IEcT6agBzpv7
 b3foA51U1DraEa+d9Jq5zfc7R8mc12vXcAhEpS5o2iTxChjW7Tb7L+sKi27pyQaOzUJE6UjNRqR
 9gzojiBQzVjS+o2+JfTYJc51+fpoY1nNpg+nzXM8Vm5Ab21EQQqPAPdfEPWFcyGN+suIvZzPjVq
 0yN1QONYRLODY4YCVDVoM3inRzp6FzDavxwbyWiAhvX7vjEK9iIRXsLK5rDDAJC3HshOp9sKivR
 RLSUkoEnaJXWpCp5ImXwpGlIH+10suCQBDMDaumHOdCRrVXFOeKa8dl+cIYlw0zCoYk7aocXFtM
 grLxE9ZmZj0ZN3tyetAIMhWlwioazCLlA1Qnf9BSbpYmaZWjWfK6hrPH9WQ5SZ0zlL6cIlOdf8Y
 NVJIkscN9u+moAMEN118ut8e2Id1o37RLIs4oxboX6NH+MJLeeNQkCp3eHUzWET5DP8N28r+TIY
 vfsSluB8+N4II0Q==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ANS2 NVMe bindings for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-nvme-ans2
-          - apple,t8112-nvme-ans2
-          - apple,t6000-nvme-ans2
-      - const: apple,nvme-ans2
+    oneOf:
+      - const: apple,t8015-nvme-ans2
+      - items:
+          - enum:
+              - apple,t8103-nvme-ans2
+              - apple,t8112-nvme-ans2
+              - apple,t6000-nvme-ans2
+          - const: apple,nvme-ans2
 
   reg:
     items:
@@ -67,6 +69,7 @@ if:
     compatible:
       contains:
         enum:
+          - apple,t8015-nvme-ans2
           - apple,t8103-nvme-ans2
           - apple,t8112-nvme-ans2
 then:

-- 
2.50.1


