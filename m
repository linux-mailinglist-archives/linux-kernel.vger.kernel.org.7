Return-Path: <linux-kernel+bounces-788460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AA4B384ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C877818871B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12253570DA;
	Wed, 27 Aug 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4WwQjrb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92ED1C1F12;
	Wed, 27 Aug 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304831; cv=none; b=PvC3cFuD/kYh2FoAN2wDHBEyNDfwOu6hqJceah/MavCIIsDgjKnDkr29JbcuruWl1PxTW6r2mgeM3hjo91tjk7SdPA2U2JVRmfrSqsDSXBByczGk1kz29F+pG/SwBVUiA53GgDTIlY5Cdw6uESc+HX7fXv2/8iwxLtZGQ31Btok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304831; c=relaxed/simple;
	bh=HAtDQoOSIYXaOPEf6N7lpWthcN7fYVSXj+XM3UaQHrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HruzshxtgFgFXnuhX+DFxyC8/PjxZys8bLoZZf4xWsQwQWCt6WfqTaGUHvGo6tMIVh/AbsG9qoBbOKK6L2l5zQRZyFqhtMYZG5JXagELw6VKtnBabPS6XagM10zlc7SUNBcBXNpoyDZXp8HhGVC6sX4yUL45A0go/IM4jEWzNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4WwQjrb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b5d49ae47so20406935e9.0;
        Wed, 27 Aug 2025 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756304828; x=1756909628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OlWIdPkGg4S2fo5kB16i5sKgEKgxu7PrfmJLsX5dU8c=;
        b=R4WwQjrb9UDXmhtmKo84QDY+RG+P+6XAXwerVcJCNtvnQOsNPI0mKHgFRfnUBRcW9C
         d5u+AFRGDKf1mxoA4CB1LjIZHa3AUiKsHJJPxjgOuRn5E4kMgtRxg1GcmvmMrRw14x+O
         61NO25OoZOqkfAU1t5nip0I6MrudNvSUzI9NWw7bvPKPlLWRSSo/XJGwcRkAjGDxfXwX
         RRQwbanul7yUVrq3w7/5Gl1GfSViftgrg/BYlTk3EF92BRw9u5aO/ljFJTETOC8i3caj
         KT94Vky2aD15hO4K1IFdOXsWj8dJX7iZ4TGHiLqwF2H3xgad72fmw4o/4NA4PA2ma9Eg
         oJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304828; x=1756909628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OlWIdPkGg4S2fo5kB16i5sKgEKgxu7PrfmJLsX5dU8c=;
        b=QERezMYp9uctbiXaUzJclLLjOfkKCw397Nw8m6Qi9PbVEZeXKEm+mH7nY1CKZmZXgr
         dHvvR3UorRu1BP0Wyi9dLYZjNNOII//LfCfK+pd+sTv+boXysshKYpeO90clwVkO8Jiw
         fdehysTYsn/zdecyui9mZ9I2ZgQlMmTeMb/r+ehGCtA+WlZxfA855B6VBF2adDeLiskk
         Maeo3/d61IM+nBQ6bNUqprf/tNpCd/laZRi6o5aVVv9vgi17cvkLpi2VBrTQG1Sr4AgZ
         ujTWHBjP6ol+pggko2mEhBp8WE4Vqx7HS2OmIFuCI3wJItRXhbhqDks7I35/oGcjZwrO
         0AGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmywQNEwJu5e8k3kH/jPdO+q1cNhRv+Hyc4xnYfmFFbTU9vFQCc3K54lyoADY9M8NtEkqt8HsehUe2kwOs@vger.kernel.org, AJvYcCWdZANRhPbM/8+vzakDr/n/325MN5kJjvRwQUqtrYZKnM8UvcPFczHXzjSc0YLUhjI/qPmr+Yj8Jufy@vger.kernel.org
X-Gm-Message-State: AOJu0YwE0nb8uqfV3U4+8ELiC3PlYBdnAxj8rHsSQ3Kjhff+U8YW6b6W
	JBhhOwH7vXFSJXmah9qJc/NZjTMn086lCBLlp2FUXOhsK9EHPP9vQyJD
X-Gm-Gg: ASbGncuOFqFlh1f+kenQWG4XFgpNaAuIGFh3JCl4Kp+6GBDAzCTRq3OO872kHJjPv5q
	HVk1YkR3PtKrf6Zu66xHTUYVJ0iAceN/jo2/uqe7TGCtmc+ANH1mlJLiteboj8CccZyCnM2lep7
	lKKnPPksjiuXrf0ALvv3VGzMSbl2GBL/UpwXrQkQnWWLmN2P1lbXbLRy5TlUJ8HhcaUJ7O3n+3q
	PpvDag18SJDhU67EaI+lQLIGcXOs3nU1Pcv+MS1zuc8fgmv6/o1+vRIT/uys3KABHSVe+Pjo9Hx
	NIIDpQBEkEYcqWOhjqz89eR3hI7S0Vl4CkOiyNFhgWpjg5UKmJ9t1HRMeyDDHh3DXiXRUPymuP5
	Jj5Q5seB674/V/PIH2n92/Ij60xypatznEjBLk7IdcWgv9aBZdHwU7OiTARZUdWF1h9l0IC78QT
	I56HZrBIiAofKFyB5Mb6rMMUsf0XQOCIZnG0Cmn22HRiva8ejfKulY
X-Google-Smtp-Source: AGHT+IFNCwrMfbz7LD21TXZtyQIGGdT67AQlxP0BxYWJyMfjYOfyk6JYYh10ZJLjj2OlUZIF5cWMxA==
X-Received: by 2002:a05:600c:1f8f:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45b517b9a7bmr143052535e9.22.1756304828087;
        Wed, 27 Aug 2025 07:27:08 -0700 (PDT)
Received: from cypher.home.roving-it.com (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:e9:f8b:31b:f797])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm22735499f8f.14.2025.08.27.07.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:27:07 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Diederik de Haas <didi.debian@cknow.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: Add vcc-supply to SPI flash on Pinebook Pro
Date: Wed, 27 Aug 2025 15:26:57 +0100
Message-ID: <20250827142705.1644267-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in the pinebookpro_v2.1_mainboard_schematic.pdf page 10,
he SPI Flash's VCC connector is connected to VCC_3V0 power source.

This fixes the following warning:

  spi-nor spi1.0: supply vcc not found, using dummy regulator

Fixes: 5a65505a69884 ("arm64: dts: rockchip: Add initial support for Pinebook Pro")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 5a8551d9ffe47..b33a1509a8e93 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -959,6 +959,7 @@ spiflash: flash@0 {
 		reg = <0>;
 		m25p,fast-read;
 		spi-max-frequency = <10000000>;
+		vcc-supply = <&vcc_3v0>;
 	};
 };
 
-- 
2.51.0


