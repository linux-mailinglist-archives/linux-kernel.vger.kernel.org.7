Return-Path: <linux-kernel+bounces-722685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB28AFDDB4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C64C587563
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841C01FAC37;
	Wed,  9 Jul 2025 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAlZ7G53"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D182AF00;
	Wed,  9 Jul 2025 02:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029283; cv=none; b=VYVpXIU574CO+vwBHfod7dROHChc60a2oIYEaKgH6Irknna3m/eI3mm+kdYg9FeBoL0NzRFu95jOyyRV5YXiO+60IfzY6ZoMxFlnqdLmr/pmdQmPiw8ZpsOWsRzQtsk407LL9W9IQEqfqB1zj6l+8MIL+lu88H/vC51OMOKWzX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029283; c=relaxed/simple;
	bh=C1LsZ9W8lfvnLWDitte0pOS7D3tBTAQlCj+feMupwhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk7SKPhN2Qc/+264KfMjC3LTDas87fqk2Cb7WhXIfo7bYgk8t6DzqqeWcGRToFKTucZQFeDi9LTwqGXz03U8GHWnHQ/Wzv+PNgVINbcTSVDq57c/fMvFIh7F0k0QWUeBaURVLF+cy65AN1ZbllY5CgWtZO+0kVMe4FlBqQQJHbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAlZ7G53; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c8a5053c2so38355945ad.1;
        Tue, 08 Jul 2025 19:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029282; x=1752634082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbCoNFAXgJ1u06xPfJomCqYDGEeGz6O7TJ4NSyYFR1w=;
        b=GAlZ7G53SmNCvvYbXbjQsJm8GJTM8b6OhOeB03kgtqCvrfOXc4XSaJO83eP5tBQaJh
         JhT+uO7+x6fK6Lap5+iC5bo/EVvi5/qh3pCAQzN4j+4m7sJCVBNHyljiQdLdSNmzKJRu
         66k74FIgxQ0o1jpN2CfFiy0HAcRXgIgxnaqRNnpRf+lRhzKYDg2GIcQcbkDiWw/RImeP
         4ahtxfSokP7qH9KgYFRYEzTIhTxUSe2Ge5F27SNq5dEmLUzr1PsvcBsNNrlXssqZwrZn
         b3nFUOSFfaRXh57mXzG/sxELRH4ewAT1X4ZHWbksxfXYClXzSx1vF0ce5T1Zug4i/PaP
         np6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029282; x=1752634082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbCoNFAXgJ1u06xPfJomCqYDGEeGz6O7TJ4NSyYFR1w=;
        b=qswiGape3GiCQHLQskXfYjzK78xINyRFv2KbH4T+sHaQaTHQilLfmIGqMQo1Bdj757
         UAzhL4PzlDbdHqMZC4FKeE8gxuryTJ6luzs6Q9nLfIQxdNtpmyC41xKdC1drvTr9RVyI
         jeAqlbssP/uZdZFASm4uu9wYslUoRhFWNi1SS21HuIJAWIDDT/OXdXU+KI8QQmAAvoiR
         Bh71a2Csyea68bHM4jZUAsd8xV8itK/ESaTaQIuOwWo/pRjw4UU3qU9rdTZG4Hil09Fw
         3vE48AzE7clNpN5KEBXUf+8UU5iiiYipcxlzJHiAHwAOuQNIeI2N4sMhwyF4etsvE3kn
         VD8A==
X-Forwarded-Encrypted: i=1; AJvYcCVPx8BI7M35NH5YDoWJ3EyMYNWVn5nutRRhxwxxhw+lx7OhJZTQf5rImyweYK5yi5kGKlbGC7+cP+1FYIWL@vger.kernel.org, AJvYcCXdz0Nab9pZuiYyhjNXjVUoRL5VXriZ6C3bcrhPWClZTsCwUgdgqNsi8erXdlCnqjPp6Ytf5l/5hC2U@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKj2rZ/HxPsy8rox5auY32SdNQr/xJCt4bz5pt77iB1Fz2vFM
	qz7LT/iWPxHesQdZ29wfAxnddPRcXH8x603By6wmzrZF/Ss4SLc4Uq9L
X-Gm-Gg: ASbGncuvsuGgCGevDJ//BhevdGjyEnHBIE+HOD64GdLSck3MAIKYpd01aXrmGUGv+vl
	/SN7AwcCjyjw2wfkKBVKvxd1vaHGgtIhqKN+fW6OREfd8I3FfA8//pBYw/HKEaEv5gR88rpXJTI
	9wipmqQsf9ZZsA4agWP8PAWKoDnq5B1eg/C9QnnxqQI+KrJgs2GwTS159A6TWvKukMzJoD6tv7n
	5zpe3wQbsjissOiCZwBfrmKER6C4VSPCXpWWs31TLdwhfTYzWqjTIEcrYDwlxyog5FE+nGFYUDt
	rKNkRAZ/oZRCaxkd4cAiTUnPu2vdJlf7kM8ttou0VZjxBnWc+ajtP1uRTWGC0LBWesNk9X5Hd17
	NBhyFb4d43ZulMmM=
X-Google-Smtp-Source: AGHT+IHd1Z+FmTRa1asnNlLnEn30cVzrwGTapFm8fIlAGdDy6iS1OdY+vSoGoBYhUhMz+FU0lXSVFQ==
X-Received: by 2002:a17:903:3d0f:b0:223:4537:65b1 with SMTP id d9443c01a7336-23ddb301298mr12221495ad.36.1752029281938;
        Tue, 08 Jul 2025 19:48:01 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300b50e8sm535082a91.31.2025.07.08.19.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:48:01 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: reset: add BCM6362 ephy reset definitions
Date: Tue,  8 Jul 2025 19:47:29 -0700
Message-ID: <20250709024740.194520-6-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709024740.194520-1-kylehendrydev@gmail.com>
References: <20250709024740.194520-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definitions for resets in the ephy control register.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 include/dt-bindings/reset/bcm6362-reset.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/reset/bcm6362-reset.h b/include/dt-bindings/reset/bcm6362-reset.h
index 7ebb0546e0ab..503fd651eba7 100644
--- a/include/dt-bindings/reset/bcm6362-reset.h
+++ b/include/dt-bindings/reset/bcm6362-reset.h
@@ -19,4 +19,9 @@
 #define BCM6362_RST_FAP		13
 #define BCM6362_RST_WLAN_UBUS	14
 
+#define BCM6362_RST_EPHY1 0
+#define BCM6362_RST_EPHY2 1
+#define BCM6362_RST_EPHY3 2
+#define BCM6362_RST_EPHY4 3
+
 #endif /* __DT_BINDINGS_RESET_BCM6362_H */
-- 
2.43.0


