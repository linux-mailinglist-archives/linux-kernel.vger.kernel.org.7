Return-Path: <linux-kernel+bounces-815699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58176B569FC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C643D1891753
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641572D0606;
	Sun, 14 Sep 2025 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d03RQbXI"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EB289374
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862220; cv=none; b=GOBjxsAlVxMqLucUJb/YKsVfhOAq1yp17wlAuHtToQp//M5FuZJGOWIoLmJhzKLJoVhC962gLmxEf1BujggNCbfjDs/91EJxlC3JzaIGHX5dYvD8qGhss23TK2iWx3eha6SkeMT6H0JsBYjav7dQ2IF9yoYYSOuZ1Vx0SjfO/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862220; c=relaxed/simple;
	bh=t8tzZ/2f7RCQSjiip8NSX/rfbTT3f/6gXgGGXz+AV6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWLQiRAB6glopOHP5lt29O2+oCP9E+ISXoTshH0LEw4OqIOQ3MxLDcZPyTs8/BWJnYiWrNkK/W9yiF2tJIyZO6Ga7dwaFLWUUSxlwQHd5KpfOlH75w8CyyeS3ymrw9/2/3Mkx7rN2TFGkMMTXZV2+WUinDCnOLvYzVELctDIN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d03RQbXI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dde353b47so20578615e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757862217; x=1758467017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyg3bozHzgmdRL161LYvLfYk983lEGFQ9huQuS5QQKo=;
        b=d03RQbXI010PuwEvDZPjmuK1qQqg8avahsAfSGLDc/0i8DwejuU7GfWfC7CZSumyyK
         n9K9PhhSJJO95Y/aJrF1SnnUKR5RB5ezcvuGIW5Zzex6nBqzScaDD5vHOzoP+8lFLF25
         T94rLaKumyUnF6pCjUPqUrZasZfJ/K0GBojcJmAFkm/98o4Deyq4I38Naw9dQr1ATOCd
         jvyol3kbWZgpV7mUQtUROyu1y7JVM1G0jPiRau3qpw1ohwOPvq+166SkH7DQ2MlVhWgu
         MkrDunR+wqldW1gNMUKhvr+2W1lAcjOTagCLBOTFarkOjh/MFjLb6tvvvSu+qd8Y1iZW
         p+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757862217; x=1758467017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wyg3bozHzgmdRL161LYvLfYk983lEGFQ9huQuS5QQKo=;
        b=ZhMGNqdBKYCR5vNLTKjxm2P+5tEKDzmik4jBjjB8ZKvPE6r8WV2lJkIDcMJRwoOvzR
         buDK+tAIBOIOILAG9yrCGUOtcPwN6LOp5nJ03WLwIy/HpWvOlzW/CkdT6oI8oglOpqC4
         7BzTevXDhBP30Ud7bshGaHcfeSlFmBMhf5CBM/uV/zGL7LnsXxzhXzFSbWKm0qnnZ7Bd
         fOv3mKqLH8j/RWJT1xRCEKD4IY0GOq/6Sw1Mj9F0N6kVt5f0l0ovNez3CkFE8fSsjPRm
         rEQfaKjdrS962zBC52W1JefR6JZOesD7b0WwQGSSt7n1DbtMZZv8qLhgxXhzwQ2jvI6i
         qwRA==
X-Forwarded-Encrypted: i=1; AJvYcCWUOb/OC7Xe47ZRgMXDO5HNgJGXwexuRMEch0BpMfpFohvjWDdvI9N05t5YrtIPMv+I2E3gxO98IsBBlcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrkv5GqXadnV9hP0cKXpNQysW4FL7507pPLTzqL2/sounzRIn
	Aj11maJqqd0UmgIZWy9Wf1MBbsGtZT3ZGXXsEcrcobqHQxK/AN8IStCf
X-Gm-Gg: ASbGncuSYugx9grgKs5F8CLNpfq3+Tt0ErnHHOQ1Xtk282y0PizqPv1pkbqYAxeWbbe
	3wWV/s98AUZ0I8dfuJViiphHeE5jxpJOa8zUzkeshEoTPOuDJPvKjFajvo7uUEW3+CNr/GDkVL8
	aFRKleu48zxP7CPrHqCVdiRTrkXrhxF6leeZQQROX0CvxcaB8MAiZTp+dizANKqo2fJstYAr96Y
	CD7258fKfmNBi2XMTYOdo9FFWmcMhK3WCVLzu+2r+RwSBdJmWLTw26ILN6juzRFtcOLyY++pw5f
	N+jyGDjvacBvQF0QEHIEozg/CpjQmEc4uVToAWJoexknKaY6bm8q07PHqySZefRhBsOYZ20tyy3
	ELjAKoJozk+nMhTc0VnJ7gyDemmcRVjPg+UbCts3YB6wPnm6IHIcpsNBwJX6h7XITkHyUvTh6Qw
	==
X-Google-Smtp-Source: AGHT+IE3h45OZpMAY6SiSVCXJQptcZFERabg2hn7u3d3tNKA8ghZYuzRtUbXRk0u5MeYisU4RNY5bA==
X-Received: by 2002:a05:600c:1c0b:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-45f212f9888mr85615375e9.18.1757862217348;
        Sun, 14 Sep 2025 08:03:37 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm32780385e9.0.2025.09.14.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 08:03:36 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: arm: samsung: document herolte board binding
Date: Sun, 14 Sep 2025 18:03:19 +0300
Message-ID: <20250914150321.2632019-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914150321.2632019-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914150321.2632019-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add binding for the Samsung Galaxy S7 (SM-G930F) board, codenamed
herolte, which is based on the Samsung exynos8890 SoC.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../devicetree/bindings/arm/samsung/samsung-boards.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
index 26fe899ba..cb921c741 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.yaml
@@ -238,6 +238,12 @@ properties:
               - winlink,e850-96                 # WinLink E850-96
           - const: samsung,exynos850
 
+      - description: Exynos8890 based boards
+        items:
+          - enum:
+              - samsung,herolte                 # Samsung Galaxy S7 (SM-G930F)
+          - const: samsung,exynos8890
+
       - description: Exynos8895 based boards
         items:
           - enum:
-- 
2.43.0


