Return-Path: <linux-kernel+bounces-806267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9CB4946B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6F03B8D4F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B457830F93A;
	Mon,  8 Sep 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbmGKvLZ"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6030F7E6;
	Mon,  8 Sep 2025 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346918; cv=none; b=Ny4aPXw1Jg27QkEUBxWPUP/Bhg/V10n+WT4P7l6FSVG2moZvI8XtA00HXjwvRyP4FXXkiF4rtUuGpAug8oManrMmG5h9n5Xk4lLE1mgwY/Nxa2x6OwqUtpyletbUWAHvV8CWh6Oye/8E7nU2jn1/1le3egkgLwLumXsZDCu32yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346918; c=relaxed/simple;
	bh=rsYkU9EJPw4fQCIXGWFL0/to1kEP4IbCif+s1T43wOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JYTcKEaiK8NOTfzswEhH6MDSI/L82TDzvHDjNRQ6u/EPDNjcOX7CoZfGwbcVOfSa4WMkfqJhyqFe/xW5GkZuYpfkPSzdzaUrCP8aTmK8cZlLSf3ua2wCBpZv/0ZoMGQFstydp+H5UjFhYrMjVceZYIOm7Qr7Qtkc/JEY1w4r70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbmGKvLZ; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-531fe8d4619so2343076137.2;
        Mon, 08 Sep 2025 08:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757346915; x=1757951715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=289q5ImhmKWIY5uuEZnDMeyPed+WAXRQAZew34FUvCs=;
        b=JbmGKvLZjJRYGzz2pPzMQIgycwzSYuWlEK8240rT1mCOsadejbVnU50hpKUwAtcprg
         GVmSURZmdjpE2zWbZSEQPmM80pN405A7XWZ+5tR5MQ630BCDPRsKdN7O31GM24yT7fdp
         Zv8fJhGmDN8oYxj2/8F2b43wxC9KB3PgGo+sHgCDJxA8j8QTI+xahLJCcQin0gJYz331
         R89rWeWE5p6w0u3qmtvF46DebvQaEb/1BkblMOWl1wolf+fFUtkLGZEFB2C/wGylOteI
         tvKXk6Hr0jf8ouIG3bmx2DUOZs9xQOY1+KR6i511Zo3ZCp93HN5KBM+I7XC+B+cn2ozf
         xoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757346915; x=1757951715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=289q5ImhmKWIY5uuEZnDMeyPed+WAXRQAZew34FUvCs=;
        b=SSweww0MLv3P3X/lJ+9XWGrLpWSvFrVFeEO5186vFij3Di4XDTkCOOf+Vi3tkjfzVO
         +HRl3CvE+t61tXekkN8R7s7SclJDymTfVTDwEKSLVwNTfmwQPMFjJxocWkZgNVesF1LK
         hor1PW4aK+i6jASqXM+NpiqdQmq97fmUM8TFS6nWieWsGqGlo5ZOzENchVwpw9OAzXyZ
         9eAyxPxPhN6Sclk3uYIe+CvUcLMX2WW1RTFNqw6ZftWkOggLPWrDY64Aq3X79wVPequw
         RsCOzBU8+uVDfqNZB4j7X1PkszL1mVGhfwIfAkoJAnPc3Bq045dOABRqEZGgN/xaFivu
         tWvg==
X-Forwarded-Encrypted: i=1; AJvYcCU+UCh0KJyXdK2C6mC7FOcUi4l8dcp4Ola9y8QQwTlKRhEVirvsMxkRQjeNXnLFw9tHakgO5vnUsga/e/n9@vger.kernel.org, AJvYcCVS3rrJ5+sWmTukV7gzajSxWE01tl+NQnM6GLCZhFszWfPgq+riVkkWLIDKA+31NPgqt8teFjEtijZP@vger.kernel.org, AJvYcCXnVg/iuBZWv0HudWvJJVLZYUsrvwxUA7JaPBJvBCNvWsfLhaSNysJoS4oIyDXdtfxcBWypaCwJUJsE@vger.kernel.org
X-Gm-Message-State: AOJu0YzQjJIz/K8aQ7fDEQOhjIXX1+EmluqYf5TGQZ3yjiFVg6KbEuwZ
	VnibMq2YaZAUOCh0hEs3fsQyhpzh9GWRYfVw4fMf4ZSCh1XM3swAx8J6oxSVeg==
X-Gm-Gg: ASbGncutDlDhMSG5fD5ozuZXO8uVgEeVxLvNbHxNQAvD8IvfVzy6QK8KJqXVvJyzUaq
	2EGAVf/N70NsOGxuSnizUxVTXPPrF1tW9qEIYYIyDtQQgYCgZ2cCWmCMyzbZascCT6jlqSIaihx
	/bKYDMDatB624ChVlHNVihVtLfhOsbBAWXqY6PZFwX7wdfqB34H78Sol/BH/RNTKIq+kRx1lq2l
	Y7AO/lJnP+jPGs//rxvvRD/7qk1Nxswf7AgdC96YQcAlpQheIElKaf8yi8nt21Lz+xyWTxI/gp9
	Zyh4NqLWBN4cuM28gg2jDBgDNm/XX97I4ntK9jGaLpSKg5iyQy4FbqzcZETj8LQNl80nPst+ywB
	2u4sSJQ/9FeH2iPfHjRXB+Um7GBm5ha0nIjk=
X-Google-Smtp-Source: AGHT+IFsCZbiuOT4gIWx05sFE0QdCNXBSRQtWmN9SlWZMqTEOBRZIc5IsctE2gmfcj5W2Rku0y/FFQ==
X-Received: by 2002:a05:6102:f9c:b0:4c3:6393:83f4 with SMTP id ada2fe7eead31-53d0c79587emr2574021137.2.1757346915014;
        Mon, 08 Sep 2025 08:55:15 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-89601b67070sm8689299241.20.2025.09.08.08.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 08:55:14 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 08 Sep 2025 10:54:51 -0500
Subject: [PATCH v4 3/4] dt-bindings: trivial-devices: Add sht2x sensors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-sht2x-v4-3-bc15f68af7de@gmail.com>
References: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
In-Reply-To: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=969; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=rsYkU9EJPw4fQCIXGWFL0/to1kEP4IbCif+s1T43wOg=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBn7/kSnTew+5mR2+86hxMny0ZkqDBOlE59k3rbtSI96l
 Htt7muRjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZgIZxwjw/VrB9pUvSZ4qD9k
 qZyUmjA5zUHOPrdl96wbc555rTp+V4fhv2vz5JS5m5d0Kx+Z94878krFXINjtaHnJpw3tHu7YvP
 NVwwA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add sensirion,sht2x trivial sensors.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6f81255141bdda6daf8e45369a2c2..952244a7105591a0095b1ae57da7cb7345bdfc61 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -362,6 +362,9 @@ properties:
             # Sensirion low power multi-pixel gas sensor with I2C interface
           - sensirion,sgpc3
             # Sensirion temperature & humidity sensor with I2C interface
+          - sensirion,sht20
+          - sensirion,sht21
+          - sensirion,sht25
           - sensirion,sht4x
             # Sensortek 3 axis accelerometer
           - sensortek,stk8312

-- 
2.51.0


