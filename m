Return-Path: <linux-kernel+bounces-802543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A00BB4538F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E60D5817DB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC5228505C;
	Fri,  5 Sep 2025 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KWCHyawG"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EF1279DD3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065253; cv=none; b=nx5VTPnSH/FkVFpOl9k5tOuH2/BeOA9OYD4SPwkNTzNUIJ4lrx8fjv89HL6prLpcIsfLcYoS1pc2A+xREk+Em27nhKubgtSNQvb6ftLeupNQsTuySSdwSCVgW1123u/8ItzhxuE1cRlLuGyYBbkDzR59Do7caD4ihZ0Bkfbsdh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065253; c=relaxed/simple;
	bh=CyBzeTKKQTYkP5v9fH3Sisy9Cw4GsHTyaTY2ml6XFmQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c82l9jkXJtvdOUvxuOQqqGvLjBgaaJ3URjqo1zO573p8POb5GFsOXHTUxWzeGm7qWF2Kg/Qp2uR6OcCGYDQpZU6VKYk1olyejuOjxDPCRVC2IK7pyQXPKrSpD/pUiJ0aZaKl+0IT6amf8xAXwKEQ+6Kk7wjyESfJ2bRcgSz6MqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KWCHyawG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0472bd218bso342329466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757065250; x=1757670050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSWkjItMEsVNotyoDAMPLMvhhraXQe3wDj+bg0giOKA=;
        b=KWCHyawGwlz6VLFwgXTXe3EQpyfkpCqcLy5pn3VK1LAV3p0CjTU55nNtQ8r4kYjOOd
         qKs6+/TD3e6wMdGqzDL5UPwmfoaQGH+eUDYbIYVqEkyWOhRBvm+n6RBzvDMtNx+S6OCs
         6D6C7aRZtt68v5m1IgvK6wpt3xICpC9IDpA8HmOeljx0ty82vzqlVNnu1UtT0FYxdcGi
         mEmb4WAHQO62HImMpRRpyMKjyW0+ImlibEh4TqTYUOzDOq0tkQdc4X9krMikoiCQ5BV4
         k2BiSpnmjBV3rq4VHG2HBMa56b/IwhjGjhhIx0gKkTW+ZHiCCjHB6cFTfaHGCemLdVQz
         Hvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065250; x=1757670050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSWkjItMEsVNotyoDAMPLMvhhraXQe3wDj+bg0giOKA=;
        b=jPmexDVSZ5f1fasYsMTT3Irvaa/PyFe8LmGxmkqi7WIv7M7NUOmmSFU2tP/f1Z8vja
         pVuAtK6GOJe8CuxWSvtAYOl9/Ucup/pneehwlNWcz5VObPMVfGel5zaaO/ue/jn+VQol
         Q/ZuJMIFY/LxJb2zLM3G/KkHXO+pqhSW84hcbND8s8O4L9Tp/ZZOy1D9ubQhGUdFm3oB
         8gbRuhHDeL9pCNyFJHYb+vP0hjdcjwO/oW1gWngT6iofV8BxVv6pUXJi75FaQH8jMg++
         F8ZAzR2VMdim7aMeugQL7XoHCCAK2GMK/ftwHL6hLAoVDYOMfRwLOlxuYcOQXYFgO9OJ
         ZRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrW+lNed23QmiOsxsarrmnIgMjYbHHH9et1OvouRfhxrlK03HbW47KvHsqMqv9eEymJ+l8UcDLpY5rX10=@vger.kernel.org
X-Gm-Message-State: AOJu0YypfH0YR4KmyXcaaDhy3OPwSrZiBIeU5Cc3orGtmOnhanmC/Hn+
	IaacLMteCpJ3OVD0c1CdRzsY8hL2MyOjTomjugA26hShTdQfhdXyor5sh6PfMWUTPko=
X-Gm-Gg: ASbGncuI0slhbE3lfar27nhcHR5DWaOgwYCopCpZovhm/70s2HgM1uwS71UDDyBy2AX
	3/Nbq+7d5PklQmH0qH3n9zWHW019KMHBw6JjLtZc3Ijk6rjLwKhOLyMmy6T+ROpM8lzmgouf2fS
	8TNg0u8Nen8t2jLRNa2Gtq2/BtGOD36Swum+UKK3snI2YKjwouKqv+uoJdp3A2NWIDLCHrBHFRp
	SM9H4lAdbxPYppbo917sq8aY0WOQ2vgRuTYfYWhxX8v8ZzTkG3JThVvgOwTBqyqoFP4HI5D1L+6
	w9v7tBXbgCo2/C7sb3Fyv1TxdMRbCDv9v2oFNmJDknjsZsg7FwiOvUW1nw9aXwtn+xtTdN0o4hm
	0LKDzu/xVuMGwH+AjbCSCyItMM2/tY8OokKZZOoZzutVCn/kh9K91ylG/KcxjgirHoE7Lv5yB1y
	lxVOAK252+w6pgQacGX/BsbV2V9eeJi2XL
X-Google-Smtp-Source: AGHT+IH146YCd5rLDFXJuCKGLfeNOz6gYO2M5rsXVh68MQw9WmhS/YuaAcFuV11qUOxFVCZjfM7jgg==
X-Received: by 2002:a17:907:7fab:b0:b04:48c5:36c with SMTP id a640c23a62f3a-b0448c50704mr1338741866b.3.1757065250127;
        Fri, 05 Sep 2025 02:40:50 -0700 (PDT)
Received: from localhost (host-79-31-194-29.retail.telecomitalia.it. [79.31.194.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b04190700a4sm1362967966b.63.2025.09.05.02.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:40:49 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH v2 2/2] arm64: dts: broadcom: Enable USB devicetree entries for Rpi5
Date: Fri,  5 Sep 2025 11:42:40 +0200
Message-ID: <c6b17f0f896b5cdd790fc10aeb2b76b71df9b58d.1757065053.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <16d753cb4bf37beb5e9c6f0e03576cf13708f27d.1757065053.git.andrea.porta@suse.com>
References: <16d753cb4bf37beb5e9c6f0e03576cf13708f27d.1757065053.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RaspberryPi 5 presents two USB 2.0 and two USB 3.0 ports.

Configure and enable the USB nodes in the devicetree.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index 865f092608a6..95ab67c7aa47 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -21,3 +21,20 @@
 &pcie2 {
 	#include "rp1-nexus.dtsi"
 };
+
+&rp1_gpio {
+	usb_vbus_default_state: usb-vbus-default-state {
+		function = "vbus1";
+		groups = "vbus1";
+	};
+};
+
+&rp1_usb0 {
+	pinctrl-0 = <&usb_vbus_default_state>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&rp1_usb1 {
+	status = "okay";
+};
-- 
2.35.3


