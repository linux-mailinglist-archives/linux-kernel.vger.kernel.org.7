Return-Path: <linux-kernel+bounces-802910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C14B4584A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7681CC0448
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78768350D51;
	Fri,  5 Sep 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MypdQGKt"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F29E350D43;
	Fri,  5 Sep 2025 12:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076888; cv=none; b=S3fzDkuGv14D0QULZWo3c1tyIIq8zTH9QLkMsZ+UxNjhxsjd0ARMx08VaQIaUdpTjQoZYXnhAdHElYZYLV7BPhEs0tdwY606iywHUup36DfkES6N8g+FC5NmJraThOgntXbDM0bl58091Ky16qY463RFejVrwoLw9uvr7Z0L2lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076888; c=relaxed/simple;
	bh=autxpBj7OimBJFcZ8K8YGhZET60AK3wiVKrwpOnWoZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5g3lubr6THOupBlGbTdi2Qmf381jpAeFcS7Tdb9ThnogkGVMNuyVlQAybptMTpN+1zx8HIwQB2zy9fqKyHtQHTfj/NmC5RshJqQtypE+KM+9mwTwABrpe788gPP7Kq6Gaz5AYAE7aGxx11mnH0J63IdCDob6x0WQXlFfI/3WCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MypdQGKt; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-772301f8a4cso2813646b3a.3;
        Fri, 05 Sep 2025 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757076887; x=1757681687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/QMey6UehR0UdsA0iJYCp1jefDwJWfGBokdamz05jw=;
        b=MypdQGKt+fhnuOhpeLn4uQX1Km4TKb2pbt2YgZUV+G/V1fSg2xl+Eg0Lr2EJDsKv/q
         dCpsPonaJIxF9Hr7FkcubXR4fT18nujK/y0tliAhUE9XNZT80Fgo4IOD3LK2KEpr5GuJ
         pKNDx87hRLeH42qynuRqG/W932zzW/k0V7XQ6sp/ojcDrTFXGzgpiBcKImwYmI+jb0QT
         hNrC/awxG1H4YAzVQ2AwRGfloKlsmcjGLvpNU7oWA9lNtTPfT+NVk0+VORfXEUOVawjr
         Rieb6leK37r3PJI0z7nzb6YEYpwPk+WiBD0ERWuyq1X6iEoyvuWRxWDNRFln4pfRXT5u
         q2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076887; x=1757681687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/QMey6UehR0UdsA0iJYCp1jefDwJWfGBokdamz05jw=;
        b=ve9tikzAIceE6YAj/YXaiPT6i04Yx3N2EnbhziLL9BOCFgYfZFMd5l789Hql6i7OrJ
         NbZPg26GBEv7XUbctKhu2bcuHLnsZ5ke3bJE7aWYdOHMfLq66s8jcrmLZo2nwYemPZlp
         UxelTG/hQg1mfP4q5Llleon/+qrDl/TbBnoeDMSJON6I8Uh30s85DeJGL/hNiu5dUcvm
         KvSj9fgACMMwt8Oy12M5Mjv+gJ/lL1KugcaLaFGoTLCPP0e57b0uuBI5isrgiY7ABU0k
         +7W1ZKAFD39b+SuhGQFTYNbafhFRX1y1/K+otlMxCaKkyfRALOVaweDTv6BzUUNr2sgD
         mBcA==
X-Forwarded-Encrypted: i=1; AJvYcCUwr8uNBtMroUhjP76uD5p+LXrUDxQr+u4qK972QUqwRhb8tZRqCGd/Zuz4WlXBJdXH0jsH+aRi44Y6@vger.kernel.org, AJvYcCXke/zJ1XEwkydRU7d3sCYE4RoIv/048oysLu14golAkB7nKzhnB4/acjN3yhh0yVPHCWClp+VgRmagBdnd@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/zOU54seMSXjDE/W1DFf150aawMz6yWCQMkLvOD1NyQ0wQen
	LDzp4hw0qxcAqM1w82HK4EfrAWNPPxgZFqzclnzk77JJNAOMI66gSLMF
X-Gm-Gg: ASbGncsJcY0XznJ7mv6nHI76k7datNsNi+TiGyTnyvO1QXkEAyKrNH4b7if0+zGHXVR
	2lDQle95ri6OfOSbkJDN6kWWzxQq0AvoYKMvjhCERcOh3MDj8rW9jVnYDgKPnAvwd4TmTnv/FJ8
	dIecuQoON9VX5XQXtg5PemD3nDZ0NYTnqdKETvPmAKZn63Nqj1+AZaxKwePf0wqxu7/OkKKxacu
	x56PuC9WS4/85DcV9c6dEFo2vZgWTfMoPFCRWxXVYdgP/q+82qPdWN1dtMsetoHvyUSOwjbQn86
	4aUncJ//8YBR10z676Zt6bbL/uXmpBR6h2u3SdR8ffTXlYegCZSOuOV+e4kB7D7ifijzahuHg/F
	TVUDWEGKBqC0=
X-Google-Smtp-Source: AGHT+IEyf3xM8j5V6mj5GlAu3KmfHhJfQiwX3Z9nZxw7wYc6R6wASu1CLnq/4bkuokC9OssZ5IvsJg==
X-Received: by 2002:a05:6a20:394b:b0:243:c23c:85cb with SMTP id adf61e73a8af0-243d6e00b11mr31309016637.21.1757076886674;
        Fri, 05 Sep 2025 05:54:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:ce20:10::d4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb98f9f6asm4992305a12.8.2025.09.05.05.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 05:54:46 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: heiko@sntech.de,
	robh@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WeiHao Li <cn.liweihao@gmail.com>
Subject: [PATCH v1 3/4] dt-bindings: phy: rockchip,inno-usb2phy: Document rk3368 usb phy
Date: Fri,  5 Sep 2025 20:53:16 +0800
Message-ID: <20250905125318.7956-4-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905125318.7956-1-cn.liweihao@gmail.com>
References: <20250905125318.7956-1-cn.liweihao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for the USB2 phy in the Rockchip RK3368 SoC.

Signed-off-by: WeiHao Li <cn.liweihao@gmail.com>
---
 .../devicetree/bindings/phy/rockchip,inno-usb2phy.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index 58e735b5dd..6e3197c168 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -19,6 +19,7 @@ properties:
       - rockchip,rk3308-usb2phy
       - rockchip,rk3328-usb2phy
       - rockchip,rk3366-usb2phy
+      - rockchip,rk3368-usb2phy
       - rockchip,rk3399-usb2phy
       - rockchip,rk3562-usb2phy
       - rockchip,rk3568-usb2phy
@@ -192,6 +193,7 @@ allOf:
               - rockchip,rk3308-usb2phy
               - rockchip,rk3328-usb2phy
               - rockchip,rk3366-usb2phy
+              - rockchip,rk3368-usb2phy
               - rockchip,rk3399-usb2phy
               - rockchip,rk3562-usb2phy
               - rockchip,rk3568-usb2phy
-- 
2.39.5


