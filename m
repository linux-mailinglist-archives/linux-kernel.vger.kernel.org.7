Return-Path: <linux-kernel+bounces-815656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E78B56980
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB3E189B106
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D531EBFF7;
	Sun, 14 Sep 2025 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHR/9HUm"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5531C695
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757858220; cv=none; b=LJ/1Favjx+L/VB+FuUB/uuKN4yoJw4Csk4dNANlvQ4eLcexXtPzTMxAlp8OdvgSLXRkiVoU2o/Dr+/zfV7kG8AA9n5f7Y6YjdltrMNwY29pLdYUbGPygYz0+Yiv+HxPh1DNzYwJVNl18DAZVWbGM7kf/VnMfVNofHf1WQs8+3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757858220; c=relaxed/simple;
	bh=G/YgUWwYgipT54ZkK5S7t4iIid/jh16TP1NiVGcDIfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mqLXxxhJnPmbw4/gKr5VvfjaBnbYuWZh/ZLWmEbBgdl1y1a0VTTKd67vyj8QePApLdvDarN10XLHpt4LbRZ2XtR7+zccUA3y/JQaowgL3k1LPVPm8fOj9+NRhkKUHr6v0B6tF5WihHGpQBoQG6Tq/NMvfc9IxuNUJ64eP1yttpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHR/9HUm; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so31930395e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757858217; x=1758463017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2UA8yGhG9kMHYtx0Te9toutlRddNLKPlgFwt+Jj5ZBw=;
        b=aHR/9HUmPwzCarHoxiVPUS/JKdRy83Hp2l549rHvBav+G1aHNjN8qNTMr40oPOfbx4
         +/pXMl/O8BAX45mR7VNJdalKpzw/ueWtoibME1WjIYjIVvfII2wtNIOk6BUyhZ+huHJU
         RP4zk1sttF/Fr3XykCaT96FjN/pzMD7cacDdbisKuIt2+/xBjvtBdlyUKqeN76Js32Yl
         NbBQCkiQ2dLlPVZWvlgDoQWdvkP9LbJpQrdXsb1Q8Fv+DPHKbmfReTMnQnPiMW5DYOmx
         H/POhEFkC1UL76iwgvGaYxf2baU6iK0r12ik59DM1mohymEmc9ZjME7Cnch6pQPtqmW4
         UZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757858217; x=1758463017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UA8yGhG9kMHYtx0Te9toutlRddNLKPlgFwt+Jj5ZBw=;
        b=SdWKSJUMVrV2AFz6zI4mxAjMaoX9czuUmqtjxJKSnusD7JKhqOb7pLQT5dcouRnpXk
         n27enjvGcBcMXaFYQs4MHbYjBqODfNpkjj2Bj9DLdxeKMmWwD0Fk4JY6j7+OSUgXLUwM
         4NSmXZlXpN2GAj36+iTerpr987ec/4lCkQ/8Fj3kkcNdLy+8Vn/ft9jMTFCoXrBNyDoe
         hRnLZX54G8kimVP/8Nxq8N8t1oyqtPI19TMjAE2Dt3qXAulMyEmtdWdbzZJQdZqgkjWP
         LoctEnDlxjOu/0odFRRZRxpL9e+d5ssciZZugvdiCQhnPcSCQGBEmzMKaDgj9l1Vu08B
         cO5w==
X-Forwarded-Encrypted: i=1; AJvYcCV62JY/Sk8Fi+yJutMSN1I9XQ6qwRyVONr/q9n8OoJWmKvHdnXe3LuswRNtZHRvyg4NevgItnrt1eAepu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysTPX+Jg6WX5MMZp/JRnWVKvzunMgshPI1qVtg+a58cpehxjN+
	+PkmqpX/MpaJzSgOERd9wA6A2WoI7BbQ21K30Gvsmrm401hvBK+4P6qh
X-Gm-Gg: ASbGnctLKlIe1ODSjNooslU/At/gtKyqL9cMZLK/5BicK6zzI2Ed0C7G/9BxKGYR98q
	hrI52Py44L1F53aeL1HDfprSx34xDaZD4Vojh1y7QrWidHFcAXumjx6wi/ZKWkblARUJ5Mbv9H8
	L7Y9977999B1Vuffv3Anmk81C21UgJ3tH5OFHcJXytawig3xozlVWXxrriMLp8ygD0q6EZMhhTe
	1YutJ+s/C/gOEvYvajf9wup1BDe+ae3yuy0372jCgWRNh6iSFKvNxMMn5DsrC4fX4VOxhU33pMY
	8fhMQ+nCDL+sWv0x8HODD5erW0oC1z3ncFcphLdvNHhGI2C/sxjPEPioynnDYOqKjUF8Jqj+cTB
	H6qAO2eJyI4aqlxK333cqx6JV28fK6MjdWNP+pvyLh0lQ/mUE9AWO2MhsfPWg4TMbuwBrz+r9qw
	==
X-Google-Smtp-Source: AGHT+IHB+VULFKNGf84XS/gc0CK50EFtBdez3HC/85lxGgum+zb542w5P3i1LGfQ0Av13zEl30jWvw==
X-Received: by 2002:a05:600c:1387:b0:45b:88d6:8ddb with SMTP id 5b1f17b1804b1-45f211fc2dbmr82961965e9.37.1757858216790;
        Sun, 14 Sep 2025 06:56:56 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e84de17f9bsm6740887f8f.49.2025.09.14.06.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:56:56 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: usb: samsung,exynos-dwc3 add exynos8890 compatible
Date: Sun, 14 Sep 2025 16:56:52 +0300
Message-ID: <20250914135652.2626066-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the exynos8890-dwusb3 node. It features the same
clocks and regulators as exynos7, so reuse its compatible.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 6d39e5066..6ecbf53d8 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -21,6 +21,9 @@ properties:
           - samsung,exynos7870-dwusb3
           - samsung,exynos850-dwusb3
           - samsung,exynosautov920-dwusb3
+      - items:
+          - const: samsung,exynos8890-dwusb3
+          - const: samsung,exynos7-dwusb3
       - items:
           - const: samsung,exynos990-dwusb3
           - const: samsung,exynos850-dwusb3
-- 
2.43.0


