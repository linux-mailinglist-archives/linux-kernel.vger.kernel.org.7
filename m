Return-Path: <linux-kernel+bounces-766262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D39CB24472
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4FD7209BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C58D2EE5F5;
	Wed, 13 Aug 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fe0C0+jO"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CB12BE039;
	Wed, 13 Aug 2025 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074040; cv=none; b=N4+KZhCwk2EGUueTqLk9hWglUJxyBv3HREDzQ0TyiIbUQWeLwFHWqSp/JJPctE0vEKb1u+z3xjxCZ8OyWllpXHnRmhvp98FMdkEMF4jA+pZD5Rc3f4ppRu2Kwn9m5cah3amji4iFIBvYdVmXT/KVkcDOymzRlvINCbXIqNuFopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074040; c=relaxed/simple;
	bh=mP87CQG19Zoa2RA1RPyhIuAVJaVjC1v+XuBf7j+Wzzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGZRvGDMuAuqo3CNM2rieChQ3nFHiHMl36S7tfiEEtBO4iMXGmW98T9JHEzmk2I6YfJ4F0k9dHMbtkYDzDeJzVGJgf4PFj7nffbv8gpNMWsW0+o4opvpC9FfTqyFFvdsD+ldBVWTR/zk62scYsIJeo6fn4UufNBFboQ2D5vj+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fe0C0+jO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bdc73f363so5688548b3a.3;
        Wed, 13 Aug 2025 01:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755074038; x=1755678838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMX2wwg5qxLiJB6Y+xH52K/4W3C0oAMt7T3m0sUQaiw=;
        b=fe0C0+jOuIYWNYcnkV2/WSw3zNbO7ePRx2J8DLwZF3Vob/6pcpWBowgfQ9Ez4pwsAg
         l6oVEP3XZqF54rWpiYznZpw//wdmDVU5myPAK20RbjlxWNw/WD0wRXfI0epZPV5Sn/3E
         fzU4jHo7GD2+8ff8tCIXlDsCjmDxiJgy4T9vSZUheS/1CsAf5jcP2q0J+4YWgTeM5+U0
         4lIylEfy4qezdWDC22yKOOKIsp4Yi9UNDNjyzeW/hRNe2MTHuWDWGwszhsy6pGW3gh+H
         Qufd5Tk/c5BMUaf1goV0S2DDP1UkHtFQHIZ4XR1KIrkP65ij5wm0oJMAQa/xtrrGdFWN
         2iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074038; x=1755678838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMX2wwg5qxLiJB6Y+xH52K/4W3C0oAMt7T3m0sUQaiw=;
        b=AjkAXXXDNG6Wbrs+Thluljd+jf3WRjNUwFjXxDZgxvZTn40mL2JTAm0HG/iDEfQdzR
         1tXZl9S287kiQMrq4rZveLRhzr+gqs3EAjS1huPxVBnmGYsIlugm3ZkqXNdUZkCHry0x
         /Q6SB4yeaXn4jWNQxC5auhLb2K2/YFGRwIc3d7xVZZUP5wYc+SBl1jqh+YSu8QlMSVsb
         mT8qURUnYrCGY5QCoAJJkp40NC/tEvfLai38/3KlQy5H7ZTQ85QTkhW40EMnYDy3IC6i
         RXfTnpgRQXOY74GITbVpZr6r/B9ZFcmV3aPrFMtmqgxAlvyGd3j9qrUwVKzt9wip6Vr9
         xvow==
X-Forwarded-Encrypted: i=1; AJvYcCUYeaa/qeP7cDW0K4dmTxRYVHcsmbBRhG1WBXGSWoytCJU9z3Rd8YeWAhU/ekFqa/mzAqF7P2UW8+0pomY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRfIBWjxM2rmghdxxmb+dvl3x50fNryY6lYzHqA5Iphd0XSBb
	Le85d11DBx1PAtyeBN4Z+SU+Cl18ud2gJaFUKjvgQ1dNMbWWsYqNamVOyTzBQa7owiY=
X-Gm-Gg: ASbGncvj5zjSv3zEsRPB2gGOP4qtPF4489Grb+8xxp3fsrgwl43Qx5O3zBRO4FM7Ts/
	7mtf5EVSta/v3fiNWgdM6T+UZeDOFZVP4gErzw9gPjdxN+gY7+qu07ZFHHQcwwgj7n6jrRY6VH+
	9wLd0YZej83tu+jVkgPMhDtMJnZwhVEUszVPZYKSQ4VrRyTYf9vAlsMVRMGDilQCVZbX7KwQtqK
	W9np0u2B7N5POP5dpqjOLIkBhp/NN1p9qhnyoSr9PYQc4jHN9h1Mr0BJ4QJT29SBvligIP997B9
	qpeoKM+jPramZ9bbA8qLEJ+rodDVlTkKhImCsP3zImgHR5l/MJo96CTUghWKp+1EV5j0iwKDSco
	kR5kyoAX9uI8JR874/5csdw==
X-Google-Smtp-Source: AGHT+IGj5o8hVlE+Dk8XrFfk3mVJEaO/uVdNHOJLV0qytV//OwbV2WeV+n5C+vKxx6Aq4gjkbNqqsw==
X-Received: by 2002:a05:6a00:1709:b0:748:fb7c:bbe0 with SMTP id d2e1a72fcca58-76e20fa8977mr3864511b3a.24.1755074037944;
        Wed, 13 Aug 2025 01:33:57 -0700 (PDT)
Received: from [127.0.0.1] ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe50c8sm31307814b3a.120.2025.08.13.01.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:33:57 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Wed, 13 Aug 2025 16:33:19 +0800
Subject: [PATCH 3/4] riscv: dts: sophgo: Enable SPI NOR node for
 SG2042_EVB_V1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-sfg-spidts-v1-3-99b7e2be89d9@gmail.com>
References: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
In-Reply-To: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Gao <rabenda.cn@gmail.com>, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755074006; l=1133;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=mP87CQG19Zoa2RA1RPyhIuAVJaVjC1v+XuBf7j+Wzzc=;
 b=H7SatGJcG7eupDmrDjtbkNoJnu+FkRemjDVyIyvwmZ0prrLEES4hcDOwL0Tcf4eJqxlpuIAgB
 0BnI2mg9zdUAYkiWJ2yEduyUi06sieCxor0YOvHNP7lZwTTM5D777Im
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Enable SPI NOR node for SG2042_EVB_V1 device tree

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
index 3320bc1dd2c66ab1a77fce719f145070ad51f297..d447d66177ee5c66b12af2d8ca79a22cc920c666 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
@@ -238,6 +238,30 @@ &sd {
 	status = "okay";
 };
 
+&spifmc0 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&spifmc1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_cfg>;
 	pinctrl-names = "default";

-- 
2.50.1


