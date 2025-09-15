Return-Path: <linux-kernel+bounces-815997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64F7B56E05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7717A0F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC87A20E6E3;
	Mon, 15 Sep 2025 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUyL43dy"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB721D3F2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901177; cv=none; b=GNh+sBA3inoIu60AgwnRilHN/AxHQ84I/ggv5zKb4K+sIV1tOt8okbZJKxFR8jlvoRURKxqN12RruXJgXuAmQ0HOn/SnFfZPSPp0iwUeMTywptVZQyJ6LysCtbhXgxdcELiw68f/eJm4AJ0iatI+xbGFmj++kVg+XncCQeo9otE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901177; c=relaxed/simple;
	bh=hIWxj9zV2KpfWd9HN2GYWeuxu7uVsrIcQRAZP2bkNnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJPPrI6ni7GIjMv6zcmIOnGLbLB0p7DtUz5CvUD1DCclmGksh5ivCmn/LTrcSnIpE5ZOqrx69vHcbVuUYk2esckZjbMdwfnD0YAmR3wbJ2IVPmXxNLbJKxvywnDxXBp+Aix3lEClwbucvmshnshvSWbv4Y+XiwV3u732qP3h5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUyL43dy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b54b3cafdcaso1412731a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757901175; x=1758505975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lKauwi606JW76n+c/E/TFgwwggsMIGS0qNvVRFiPKQ=;
        b=FUyL43dypwVO8pfgc894/z+gXv+xP1DhZq8hLnkEcXd0j/NXG5iialhM8I4egZMchb
         6BYY0PZBg91UeROPng7xCps8t7R8y0j2T2OR+pWR8f26kMBtrRcaftApgE7U3wXXkzsS
         40dDDCocdsvI6pjwRNcU639S0hjqoafrcdByG/U1IZ4gGRhua/pRUxUl58rs0k9f7xWZ
         +lAIMvpFyU2Jr/BkAlgB+m8wVV/pU46KUuQI8u0gzF1zOBd+rIdkQZuleeyw3XYcfrdr
         Qqs6Mnj4meGa9VwZb6E11AbFv9gqMFxJeqqV96C18mmVOTwiP3UBRW3xWaQELu2XAD4S
         cwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757901175; x=1758505975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4lKauwi606JW76n+c/E/TFgwwggsMIGS0qNvVRFiPKQ=;
        b=BBeXXzwh+JDD4KXFSkjYeSoqFWbQo+zF4cGK2Sg4WQLY7902Klbot7dC3bHqJsDiaL
         YCov9LaUkT+fMox7Y6Z4YU2ATKxd2FQ+3teDlUyWbxYu09GFan7pRZdIAGv8/ULAZVk8
         F423ydVBhnfnapgACdT0DJ930MYhoZ17FL8NEjHbCrAYpFZHuWDVTbUpaMP02TKj2Reu
         PYwaK9uSEYf8YDXVM8gNEqHQ5OcpIhIv9P6e0T3cYEhtqt6yD8vE+BFY89d6Y0B7wSNk
         e4QDL7RzoV/6OX7OH0GvPa3nN1dvLOcp6r/0TxKRSX52FnYKAn63/x6nOq8owcWEPA7e
         X5tw==
X-Forwarded-Encrypted: i=1; AJvYcCVvFSoAHXBvlgaMZ5B5Yu4ASVx5EVYuwdLJdHd9GMqGTYcwOfQCwZe38ZigD/tdoh/L6F9EH7dLwkmx9yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlg9HEYFcESJpEZ6bsTO6WSMKrVUvg0xZRdPhkaZawXdTczftH
	vxRSFPYtX2xtiAFqyj16rUZz2IWEK8AGCR2BjSuAGgEkfBbrGBOrljeY
X-Gm-Gg: ASbGnct9+WeY70BXIBj/2A+2sHLBrZoOuJ8vxY0aRqGWhGKFsxkSEMPwcwTjVEUz6RH
	s+CnSmDhjDZT0L9lZA3h+3IjHZbq+a1xDOadpWqrlupf10LHZXEDo9mXnMSntIpkS2nEHggy35m
	AmLHrSHp1cSNcTRXRb4JuLXx31LLf0B++oXnt58YX4mAu4sV64z/j8vBsVREiMgRWnBfj4QWSvn
	mCkNBk7MuLYM3drayKPznl1j1xofdv1gotHPdgeHbhrDEIa5ILnZJuwaniSzlaEyCDfnuWJEYxj
	tslQ8GM3sbfdfeDMrFRGrxwU3oAX8BsveToms0jJyibpQqzt+076GFfT4QvLlHLCgQYLd9Wvb3m
	VOGtYGnuDn/aA7VyuCMJrID2zmpB5Q2LAYDc=
X-Google-Smtp-Source: AGHT+IHWuYTbEVpZyLJS7fo2wvFisOiIUIQdPnNoSbXPJNsFdx7r09O0spNATU/bO9TcPnESAwBMXA==
X-Received: by 2002:a17:903:19cc:b0:24c:cb22:8221 with SMTP id d9443c01a7336-25d243efcacmr120111695ad.3.1757901175108;
        Sun, 14 Sep 2025 18:52:55 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-262df893ec5sm41565255ad.46.2025.09.14.18.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:52:54 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 15 Sep 2025 09:52:24 +0800
Subject: [PATCH v4 1/3] dt-bindings: spmi: Add Apple A11 and T2 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-t8015-spmi-v4-1-758620b5f2ae@gmail.com>
References: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
In-Reply-To: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=hIWxj9zV2KpfWd9HN2GYWeuxu7uVsrIcQRAZP2bkNnA=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBox3Fw0lI+FDkxbVsnvMxk4d6qhiOLERJV93n27
 tRJib2kXUCJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaMdxcAAKCRABygi3psUI
 JJvvEACoCQwgoPlFXhCu6aP1Yzfukrb4xs2OuMeTleGduVEcbjvhnY7+8noTnDVwUxB9QjHDQJ8
 cXdwqikO3XMly1/8zAbFzYc/UlWhNitGrKvG7HVP8Hp1xZmdPzl0hYKzrNq1/pk2fwIYNaTF1Ng
 9I4sj7rSjOxUT77j0KDQO35Lw8c1IiZX7rDN5gGrDAHhOwUZa3GvSMRStssqPMeOeIhXMJssO6N
 XuRglKBrjfXCq/YnM6OeJkAiJ0iAl5Tn1cUvkpI4VB1Aavoy0KPIdc1dF/ad3Gn4LoI2WGcXd05
 /fkRoAihhT+BUuoWw1ljYwCB4/tsScaBLTT4R10+iArSkGo4ZO+pohJ4rDpEfEkhoggMbvAmnU4
 6TcKbaGKCgeZmAIVxvbENvknuebGJgYEKO3zQVEpqPVUkwRue9PFdP8q+VDH/wXT54hEhxNEWFO
 2RQ0g4pu+17+L9iGf/mhqdjze3xjHY3IMAPrgxlr8t5P9UD35TDTx/iX3RPZ95AkUlLyC43SrkV
 ipe5Nm0TP9qGqsGEY3/N/oM+0w0R14mTV+J8L6118du7GWmbQdHtk0mLx1EHHoKrZP/tylT1V6X
 ucju8hHM5S4Rv78omdfawQeCBwiyaSOhJaM84vjHkiY4paUHrGpIAfSDrvD/BtVr532U2Cys4IQ
 q/8pFvmjRLnyvcA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

The SPMI bus found on Apple A11 and T2 SoCs are compatible with the
existing driver for t8103's spmi so add their compatibles.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spmi/apple,spmi.yaml b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
index dbf09ad0ecdecab82074344aa6a840a820bc448a..ba524f1eb7049dc5ba7c5f83f734d3f2f7e905b3 100644
--- a/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
@@ -18,7 +18,10 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: apple,t6020-spmi
+          - enum:
+              - apple,t6020-spmi
+              - apple,t8012-spmi
+              - apple,t8015-spmi
           - const: apple,t8103-spmi
       - items:
           - enum:

-- 
2.51.0


