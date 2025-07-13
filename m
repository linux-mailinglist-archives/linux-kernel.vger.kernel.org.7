Return-Path: <linux-kernel+bounces-728933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF8B02F2F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 09:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71BBF7A6FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 07:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCA1DE2A5;
	Sun, 13 Jul 2025 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4CAun0c"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F441CEADB;
	Sun, 13 Jul 2025 07:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752391135; cv=none; b=hB7j/sh8uJe9orZp8oROb2WVhpA9NvGy6IcrN9Tvg/4OrsKFz0xiyOUU6EWXF0FlKipqnWeY1t2UhO8Y2hzqb0L69X1c3dsD2+jRoZAfn1ferslE9JQXCCj/xIpm9KMYtEsVf+PKKBPUosiBiHd6QgHvIyWMN8dpe08MtfBWHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752391135; c=relaxed/simple;
	bh=fDuhxKXtc16eFK6Plf0USrGpABtee8VskhHVfXtiGIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqenIBjTtfWYKHVktgP3SpyDDeFeoqna6AoD8R7Hds7Rvy5BoEetTtr+RWvVu9nV9nCvlXthhQPNLTqsSsssdF+R+M8rZ/79o6QsT4Dkp3bKiNeKwMMpJj5J7yoQnnZ3IQMZLNdmGMW57/vTp1wCsq4c+rDYoF9kL7PvEjEa0CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4CAun0c; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c8a505177so31278955ad.2;
        Sun, 13 Jul 2025 00:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752391134; x=1752995934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3ibt1l+rop3MAv0eHcRbDk5yd86v3dxAfG2YHfIqhs=;
        b=X4CAun0c66hLy9CCL7KWWMyHWwkXJhLIE4ibVeC/F61XhYhETQ8n1Sa3lBJYaKhrwS
         WgKc8fXBnROdRm3sKqj6aJrUtJGYTVWqBdKRzce2/0Wqu7rdOJjT4MnLGikp6lGSZvy6
         gWNSJ39DcjFu+PwlVYtg4TX8eD1LuyadDK/lMVVoHiNuxLr5ygLcPZdVEsHEqip9VNRH
         9SCqHs9Nm+BKbQlh/doVeu1Ptzc/5ybhF1ZUUJeweNivUwtNIstq+tRJbur+jOoXT8kV
         EbbcDqae9+zYyQoggfKVgs2j/cGzLWkwPipXh5c/1xZi+rcjbcQU3yx4pxXnx9xkt0T2
         27Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752391134; x=1752995934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3ibt1l+rop3MAv0eHcRbDk5yd86v3dxAfG2YHfIqhs=;
        b=IAhpLvclPYgprcvkHdLsmdthOKtfXNCBMHgbKWjqX9ATaQjgDkrt1Kt54xUi3SdiTZ
         taWZ5qtQx8mE9EgGo4UVrcFZAlYgRN6iD3EfmYupKqa/tO1R1fnaX9UzDFFrgSaZmzt9
         exlONFXoAWq27VgOxs/0tr4I/kL0d/CrftyE6e+SZZcWB2UJXI9K2ucRRU2H+JC5moE/
         X6aXUiZPYkiseXr2SMJGwQUVKStN6Y388B4c2BZN/4RQdQ+GiKlABkbUrz5E/W2FR/Qf
         4IovmY2MTrhgWMo1T+2vbFSqvY4pLOr1i/ACoJMf6Pfs1zIkanCLFid7IeFMqWA8IBHC
         llBA==
X-Forwarded-Encrypted: i=1; AJvYcCXFtMu+wEeHfNWF7LTzHjOvjUJSw6lPDb5DLuppXv4s9qS+LCcr345QEz1og/l40WAQWnnI0dR2iRPN@vger.kernel.org, AJvYcCXxEFzxJgnKekPiuuU3LUQc3QbbziAaw047Pgpd1N7IZ3218/KPll+o1kEJSqKAly2CfYbIGsHHy/KxG5xH@vger.kernel.org
X-Gm-Message-State: AOJu0YyigJlW9mvVLhxdQ1IyPrqSqkaHZ1lr2ZsPTflWML6AO5PqyfVN
	ogvSvotbH0QHsxM3y8oAucPmkuWVFTAwQCu+9sCUpFRzNWoSJsP34hap
X-Gm-Gg: ASbGnctfjmptd0JVv6XThcTPIciAjiu5pNavGFSGXhzAmubLNp8tt/bu9CDYE4yz4f4
	ze15p4eLXACKCrCc7gEFBkRNmf21Bu6a9s50ldDPo3XntGD/jr/KogF4e/6IPGc7Nm4lbTFwfGx
	NFL8/dO7WL8DmYtJiyeAqFHCOxnzAgentbZ9mJ3NeJPsVLlfcmp21IPmuJjBmNa7yZpLbiamxkZ
	P7rbW+HVHUYwnXZvgtlsOBCmsWFk7SRhFf2pJUZvBGz9SxFfQyvRisQPZRLLiMLJO0SHQAkA6YH
	N7mdE11LNV+7wOuGTVgArdSRBfh8xBV0fdSgWlmhN1sVZzPPRK8iV4KcIaasVJHBYRFZCJebtzI
	C0JrPp6KOPnsTyxMSmTCf83GaJg==
X-Google-Smtp-Source: AGHT+IGMgM20cpvHH2kxzpXJumjvyHc9GWSjG5JdVb9B98ORpebrIisP8unEckmgfVfsezZxxcE4bQ==
X-Received: by 2002:a17:902:ef03:b0:235:e1e4:ec5e with SMTP id d9443c01a7336-23dedea54f2mr152203795ad.49.1752391133613;
        Sun, 13 Jul 2025 00:18:53 -0700 (PDT)
Received: from ubu24.. ([2400:2410:dfca:c200:3d5e:f962:c950:134e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322db2sm75239065ad.100.2025.07.13.00.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 00:18:53 -0700 (PDT)
From: Taishi Shimizu <s.taishi14142@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Rafal Milecki <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Taishi Shimizu <s.taishi14142@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: bcm: Add support for Buffalo WXR-1750DHP
Date: Sun, 13 Jul 2025 16:18:24 +0900
Message-ID: <20250713071826.726682-2-s.taishi14142@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250713071826.726682-1-s.taishi14142@gmail.com>
References: <20250713071826.726682-1-s.taishi14142@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Buffalo WXR-1750DHP under BCM4708 based boards.

Signed-off-by: Taishi Shimizu <s.taishi14142@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index d925e7a3b5ef..f47d74a5b0b6 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -25,6 +25,7 @@ properties:
           - enum:
               - asus,rt-ac56u
               - asus,rt-ac68u
+              - buffalo,wxr-1750dhp
               - buffalo,wzr-1166dhp
               - buffalo,wzr-1166dhp2
               - buffalo,wzr-1750dhp
-- 
2.43.0


