Return-Path: <linux-kernel+bounces-641201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329DDAB0E18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02BC522E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E8F279916;
	Fri,  9 May 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sxWUEtvR"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AFD276045
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746781194; cv=none; b=c2g2NWIYWNvgFJX6jasfS6JRSdbGNLPj86rTCPAACsOS0iSC/vSHGUhCtu+fSnB2eApNoVrsJHyAHVxCYSiEo0Ef7ucnFwMYdxvqIX1MDjgLZxxYGRM+z18csxWMwveKq7rsagms6h7xA/jkKd2Y9Rm2CZ5IKNL7ZAf66C2zI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746781194; c=relaxed/simple;
	bh=rvVI43CfQy0TaBWEg2H5pe+5q0FlzAzFAvzc02/y6V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYUmo8ACI7mpQ0m2SJrCxCoLPiuqB1Au2dBiyB4LF3YRicO8IQWCi91VGQjpWM7MlMa/Fziam9SU/IQr57kgNCLUy8apKtMUQvBzsfvXLIvJA5e0lH+c0HKJMDwrHUuprj3JyZXz3QrtUk+WBDQroPY0NmlkJWik1+XQGltPSr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sxWUEtvR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe574976so12889245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746781190; x=1747385990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfmCayRUwr3gSafmTaOxUqOuvcGOwzom1+h8hbh2uFI=;
        b=sxWUEtvRJJ95V1D7jP2uMmqiBzpD9XKNyBpgvfYuUybxEiqG0G5YmGhZPMaZN/chZF
         9xs9n13RvwHutfv62EeEnYVzePQHku6LIfC5pCcm2XdfGza4sOX+NXrZ9t+8UI7r4SSV
         dpHgHIjT+rWi2l57C2EZaPgS12O0aMdEb/JRaUmY9vTLA1LBvT8xFoRuyj2mr+waGO14
         YcPdtwNrsOUAQosxkZHSA5RKtAT7BaaXCSBw0Ek61n41T3P6/eOZuBOZXbKbLIVgGzK2
         EXtMQlSHRMN/wNkWnpLDg9/1OQNrJxQ/rX9QvUgkBZ09YRFUdSflRc/JJVQBgPfUhy+S
         xR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746781190; x=1747385990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfmCayRUwr3gSafmTaOxUqOuvcGOwzom1+h8hbh2uFI=;
        b=ciKA/yqUh5pXUEvLyG2Z6qOgpFZpio/sZCfc5BoZedYjoRHQf1kq+ejBxc93CP48Ev
         gc/vVt+exLpebbbw0PnNo7lsc1m0JxjMHwJmxEuxhUhfckw/OeNCfB8kzPCq2715Q1B0
         FAatc8U/Md1RShMrIO5JAuMZAYAC2VXZrtNuJn+j/tKkwupBJzSvKeQWDx4N5fLPGYxR
         tCurg98XhALwuxE+t2OGOS5KvBqHkMcpcgSSuu51YYtk7mh0Gg0zMzcaeDWKATODENIT
         ynlX5h0CC3bSjQG9ZeYEO0lM6OOe9c3HJE6gllYI4UJC/qq1kvsz1H7EYMmUtIi+02iM
         j6SA==
X-Forwarded-Encrypted: i=1; AJvYcCXvDCOVjPCH2eHzhXhg9dlrPzQ9Pb13Gi+YvqcMAuCT2jFAwm9rXxQdKTZWEtfdLejPBMOiSPxwPQsd9kA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMxaG9Wm+DVgDbmhEzfNe6AoCFBPjq7oL2C5gNHRfF+EJ9RFi
	Yzu+0tO2AjnqcixA82cRKuUde2Ovme/ctfNEEtnIVCrLBKYaMxAPKZvwjT7YtCQ=
X-Gm-Gg: ASbGncs8eRxAxAFKD1GHesZnJwqYw7iOZpvoGJLT1e09KbUIpPxGgD1pWeUYtSvvZQe
	zrpmkx4iKwsuYjvwxgciiYm+/d6YH5TpI0HvBFHOEiNP4a0lD4zu5GWwHaMZVN1GZHum8jHYNEo
	9ODaFCJHKOSK773koX+YTZpzbh2eYX/L+PR9qdGwjbBE4KuLkfKiuNJSGvJGcJsZniN55tWND3y
	4vkE06F76SDIndDCV+w7HLP1bId80AnEVTWSLPNe1bYhRZtc+mDf2Cd6f82hmaqj4+Vkk2CuawQ
	Mp5EIVepBsMqIoKwnysRMeBtIjsWYhnesGwDDmXHs0/p/lWkv0J9tFo/FFnvIA==
X-Google-Smtp-Source: AGHT+IE7qtjLG+dHf/JB33gMcHmOc55oJ6Skmmte2kAyic0c68/mzJS1hOHbv0dTCDDLFx2FxomgiA==
X-Received: by 2002:a05:600c:6814:b0:43c:fbba:41ba with SMTP id 5b1f17b1804b1-442d6ddec51mr17382075e9.28.1746781190474;
        Fri, 09 May 2025 01:59:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67df639sm22369115e9.13.2025.05.09.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 01:59:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 09 May 2025 10:59:44 +0200
Subject: [PATCH v2 6/6] drm/panel: visionox-rm69299: support the variant
 found in the SHIFT6mq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-topic-misc-shift6-panel-v2-6-c2c2d52abd51@linaro.org>
References: <20250509-topic-misc-shift6-panel-v2-0-c2c2d52abd51@linaro.org>
In-Reply-To: <20250509-topic-misc-shift6-panel-v2-0-c2c2d52abd51@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Caleb Connolly <caleb@connolly.tech>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9721;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=k0xSNLGIrpZBoG7rAiHsU8lvzVIj0T+xUF5s6G0C46c=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoHcP/sM9IVoVCzuWEjIB2l0Y08ZaQP3sfLq/UiBh0
 zwqvGTeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaB3D/wAKCRB33NvayMhJ0bRzD/
 94jzDx24tJTK5Zlb3cf9TTJqVc2ggiAVlraNfFfNCK23Te7nFGMK0Yj2Ih6/3YeucdGnqFVMYDEAG1
 ub7vJdPNJL2CFUHq0T7a9ckqZxAEdfwDw0zAVExDciqw3owVQjWmSBtRsg2HVVVQQqAtq9opJEt8R/
 gus1oGzf20y4Xr/7UqNLwLosGUPbV00RvvCYBD1ZU/xjE0OCguSlw2PNlJuNsQVJ+C4t00KIepDzDa
 mInEeAQmo/ICZJ5N6CJchw/5gQEz6fbkDqt+BgCgeU57HHjoR9AgJm5qf4R/7WYwBC3WoxHx2JB3sJ
 g9CVX4WFiW9xZucuR0VtWd4eHQMKX4GsTRNygUNgVxKvzclzYx6pQd+QMelwy1PQ7K/LIzIQO6C7VW
 lq6JeI2jkvd44ZGyZ++TBpie+AFfKPOXgrXC22Qrd86HAbxOsV1mVRKqOMrPYizJ+corEPXsQGBrgD
 A8soYZAZ3cAw48jiDC/VsjrYxBxb4nt6xQKH4qaSJuxK68lUkkIyNbSeZKt2xGp8dHptK8WoqfK2EN
 H2gsFFumw/oSjp4me3DKWUYPjfqA84k3gTonxZZ2bWJSW9aqRCHUENkU/4st2gF1NbNWAlZ81EpCWh
 jjFJ9D+zICUJhRby+J8yPVurUexyq2yxcecjayRFfp9f9+bCjPR56KWvkpfA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Caleb Connolly <caleb@connolly.tech>

Add support for another variant of the rm69299 panel. This panel is
1080x2160 and is found in the shift-axolotl (SHIFT6mq).

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
[narmstrong: moved to panel_desc]
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/panel-visionox-rm69299.c | 132 +++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index fda1caa9052dd1c61c2dc23934d5faa8a52a6e31..f0791ce499409d353b65b9d1d84efce5b01a7d41 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -39,6 +39,117 @@ static const u8 visionox_rm69299_1080x2248_60hz_init_seq[][2] = {
 	{ 0xfe, 0x00 }, { 0xc2, 0x08 }, { 0x35, 0x00 }, { 0x51, 0xff },
 };
 
+static const u8 visionox_rm69299_1080x2160_60hz_init_seq[][2] = {
+	{ 0xfe, 0x40 }, { 0x05, 0x04 }, { 0x06, 0x08 }, { 0x08, 0x04 },
+	{ 0x09, 0x08 }, { 0x0a, 0x07 }, { 0x0b, 0xcc }, { 0x0c, 0x07 },
+	{ 0x0d, 0x90 }, { 0x0f, 0x87 }, { 0x20, 0x8d }, { 0x21, 0x8d },
+	{ 0x24, 0x05 }, { 0x26, 0x05 }, { 0x28, 0x05 }, { 0x2a, 0x05 },
+	{ 0x2d, 0x28 }, { 0x2f, 0x28 }, { 0x30, 0x32 }, { 0x31, 0x32 },
+	{ 0x37, 0x80 }, { 0x38, 0x30 }, { 0x39, 0xa8 }, { 0x46, 0x48 },
+	{ 0x47, 0x48 }, { 0x6b, 0x10 }, { 0x6f, 0x02 }, { 0x74, 0x2b },
+	{ 0x80, 0x1a }, { 0xfe, 0x40 }, { 0x93, 0x10 }, { 0x16, 0x00 },
+	{ 0x85, 0x07 }, { 0x84, 0x01 }, { 0x86, 0x0f }, { 0x87, 0x05 },
+	{ 0x8c, 0x00 }, { 0x88, 0x2e }, { 0x89, 0x2e }, { 0x8b, 0x09 },
+	{ 0x95, 0x00 }, { 0x91, 0x00 }, { 0x90, 0x00 }, { 0x8d, 0xd0 },
+	{ 0x8a, 0x03 }, { 0xfe, 0xa0 }, { 0x13, 0x00 }, { 0x33, 0x00 },
+	{ 0x0b, 0x33 }, { 0x36, 0x1e }, { 0x31, 0x88 }, { 0x32, 0x88 },
+	{ 0x37, 0xf1 }, { 0xfe, 0x50 }, { 0x00, 0x00 }, { 0x01, 0x00 },
+	{ 0x02, 0x00 }, { 0x03, 0xe9 }, { 0x04, 0x00 }, { 0x05, 0xf6 },
+	{ 0x06, 0x01 }, { 0x07, 0x2c }, { 0x08, 0x01 }, { 0x09, 0x62 },
+	{ 0x0a, 0x01 }, { 0x0b, 0x98 }, { 0x0c, 0x01 }, { 0x0d, 0xbf },
+	{ 0x0e, 0x01 }, { 0x0f, 0xf6 }, { 0x10, 0x02 }, { 0x11, 0x24 },
+	{ 0x12, 0x02 }, { 0x13, 0x4e }, { 0x14, 0x02 }, { 0x15, 0x70 },
+	{ 0x16, 0x02 }, { 0x17, 0xaf }, { 0x18, 0x02 }, { 0x19, 0xe2 },
+	{ 0x1a, 0x03 }, { 0x1b, 0x1f }, { 0x1c, 0x03 }, { 0x1d, 0x52 },
+	{ 0x1e, 0x03 }, { 0x1f, 0x82 }, { 0x20, 0x03 }, { 0x21, 0xb6 },
+	{ 0x22, 0x03 }, { 0x23, 0xf0 }, { 0x24, 0x04 }, { 0x25, 0x1f },
+	{ 0x26, 0x04 }, { 0x27, 0x37 }, { 0x28, 0x04 }, { 0x29, 0x59 },
+	{ 0x2a, 0x04 }, { 0x2b, 0x68 }, { 0x30, 0x04 }, { 0x31, 0x85 },
+	{ 0x32, 0x04 }, { 0x33, 0xa2 }, { 0x34, 0x04 }, { 0x35, 0xbc },
+	{ 0x36, 0x04 }, { 0x37, 0xd8 }, { 0x38, 0x04 }, { 0x39, 0xf4 },
+	{ 0x3a, 0x05 }, { 0x3b, 0x0e }, { 0x40, 0x05 }, { 0x41, 0x13 },
+	{ 0x42, 0x05 }, { 0x43, 0x1f }, { 0x44, 0x05 }, { 0x45, 0x1f },
+	{ 0x46, 0x00 }, { 0x47, 0x00 }, { 0x48, 0x01 }, { 0x49, 0x43 },
+	{ 0x4a, 0x01 }, { 0x4b, 0x4c }, { 0x4c, 0x01 }, { 0x4d, 0x6f },
+	{ 0x4e, 0x01 }, { 0x4f, 0x92 }, { 0x50, 0x01 }, { 0x51, 0xb5 },
+	{ 0x52, 0x01 }, { 0x53, 0xd4 }, { 0x58, 0x02 }, { 0x59, 0x06 },
+	{ 0x5a, 0x02 }, { 0x5b, 0x33 }, { 0x5c, 0x02 }, { 0x5d, 0x59 },
+	{ 0x5e, 0x02 }, { 0x5f, 0x7d }, { 0x60, 0x02 }, { 0x61, 0xbd },
+	{ 0x62, 0x02 }, { 0x63, 0xf7 }, { 0x64, 0x03 }, { 0x65, 0x31 },
+	{ 0x66, 0x03 }, { 0x67, 0x63 }, { 0x68, 0x03 }, { 0x69, 0x9d },
+	{ 0x6a, 0x03 }, { 0x6b, 0xd2 }, { 0x6c, 0x04 }, { 0x6d, 0x05 },
+	{ 0x6e, 0x04 }, { 0x6f, 0x38 }, { 0x70, 0x04 }, { 0x71, 0x51 },
+	{ 0x72, 0x04 }, { 0x73, 0x70 }, { 0x74, 0x04 }, { 0x75, 0x85 },
+	{ 0x76, 0x04 }, { 0x77, 0xa1 }, { 0x78, 0x04 }, { 0x79, 0xc0 },
+	{ 0x7a, 0x04 }, { 0x7b, 0xd8 }, { 0x7c, 0x04 }, { 0x7d, 0xf2 },
+	{ 0x7e, 0x05 }, { 0x7f, 0x10 }, { 0x80, 0x05 }, { 0x81, 0x21 },
+	{ 0x82, 0x05 }, { 0x83, 0x2e }, { 0x84, 0x05 }, { 0x85, 0x3a },
+	{ 0x86, 0x05 }, { 0x87, 0x3e }, { 0x88, 0x00 }, { 0x89, 0x00 },
+	{ 0x8a, 0x01 }, { 0x8b, 0x86 }, { 0x8c, 0x01 }, { 0x8d, 0x8f },
+	{ 0x8e, 0x01 }, { 0x8f, 0xb3 }, { 0x90, 0x01 }, { 0x91, 0xd7 },
+	{ 0x92, 0x01 }, { 0x93, 0xfb }, { 0x94, 0x02 }, { 0x95, 0x18 },
+	{ 0x96, 0x02 }, { 0x97, 0x4f }, { 0x98, 0x02 }, { 0x99, 0x7e },
+	{ 0x9a, 0x02 }, { 0x9b, 0xa6 }, { 0x9c, 0x02 }, { 0x9d, 0xcf },
+	{ 0x9e, 0x03 }, { 0x9f, 0x14 }, { 0xa4, 0x03 }, { 0xa5, 0x52 },
+	{ 0xa6, 0x03 }, { 0xa7, 0x93 }, { 0xac, 0x03 }, { 0xad, 0xcf },
+	{ 0xae, 0x04 }, { 0xaf, 0x08 }, { 0xb0, 0x04 }, { 0xb1, 0x42 },
+	{ 0xb2, 0x04 }, { 0xb3, 0x7f }, { 0xb4, 0x04 }, { 0xb5, 0xb4 },
+	{ 0xb6, 0x04 }, { 0xb7, 0xcc }, { 0xb8, 0x04 }, { 0xb9, 0xf2 },
+	{ 0xba, 0x05 }, { 0xbb, 0x0c }, { 0xbc, 0x05 }, { 0xbd, 0x26 },
+	{ 0xbe, 0x05 }, { 0xbf, 0x4b }, { 0xc0, 0x05 }, { 0xc1, 0x64 },
+	{ 0xc2, 0x05 }, { 0xc3, 0x83 }, { 0xc4, 0x05 }, { 0xc5, 0xa1 },
+	{ 0xc6, 0x05 }, { 0xc7, 0xba }, { 0xc8, 0x05 }, { 0xc9, 0xc4 },
+	{ 0xca, 0x05 }, { 0xcb, 0xd5 }, { 0xcc, 0x05 }, { 0xcd, 0xd5 },
+	{ 0xce, 0x00 }, { 0xcf, 0xce }, { 0xd0, 0x00 }, { 0xd1, 0xdb },
+	{ 0xd2, 0x01 }, { 0xd3, 0x32 }, { 0xd4, 0x01 }, { 0xd5, 0x3b },
+	{ 0xd6, 0x01 }, { 0xd7, 0x74 }, { 0xd8, 0x01 }, { 0xd9, 0x7d },
+	{ 0xfe, 0x60 }, { 0x00, 0xcc }, { 0x01, 0x0f }, { 0x02, 0xff },
+	{ 0x03, 0x01 }, { 0x04, 0x00 }, { 0x05, 0x02 }, { 0x06, 0x00 },
+	{ 0x07, 0x00 }, { 0x09, 0xc4 }, { 0x0a, 0x00 }, { 0x0b, 0x04 },
+	{ 0x0c, 0x01 }, { 0x0d, 0x00 }, { 0x0e, 0x04 }, { 0x0f, 0x00 },
+	{ 0x10, 0x71 }, { 0x12, 0xc4 }, { 0x13, 0x00 }, { 0x14, 0x04 },
+	{ 0x15, 0x01 }, { 0x16, 0x00 }, { 0x17, 0x06 }, { 0x18, 0x00 },
+	{ 0x19, 0x71 }, { 0x1b, 0xc4 }, { 0x1c, 0x00 }, { 0x1d, 0x02 },
+	{ 0x1e, 0x00 }, { 0x1f, 0x00 }, { 0x20, 0x08 }, { 0x21, 0x66 },
+	{ 0x22, 0xb4 }, { 0x24, 0xc4 }, { 0x25, 0x00 }, { 0x26, 0x02 },
+	{ 0x27, 0x00 }, { 0x28, 0x00 }, { 0x29, 0x07 }, { 0x2a, 0x66 },
+	{ 0x2b, 0xb4 }, { 0x2f, 0xc4 }, { 0x30, 0x00 }, { 0x31, 0x04 },
+	{ 0x32, 0x01 }, { 0x33, 0x00 }, { 0x34, 0x03 }, { 0x35, 0x00 },
+	{ 0x36, 0x71 }, { 0x38, 0xc4 }, { 0x39, 0x00 }, { 0x3a, 0x04 },
+	{ 0x3b, 0x01 }, { 0x3d, 0x00 }, { 0x3f, 0x05 }, { 0x40, 0x00 },
+	{ 0x41, 0x71 }, { 0x83, 0xce }, { 0x84, 0x02 }, { 0x85, 0x20 },
+	{ 0x86, 0xdc }, { 0x87, 0x00 }, { 0x88, 0x04 }, { 0x89, 0x00 },
+	{ 0x8a, 0xbb }, { 0x8b, 0x80 }, { 0xc7, 0x0e }, { 0xc8, 0x05 },
+	{ 0xc9, 0x1f }, { 0xca, 0x06 }, { 0xcb, 0x00 }, { 0xcc, 0x03 },
+	{ 0xcd, 0x04 }, { 0xce, 0x1f }, { 0xcf, 0x1f }, { 0xd0, 0x1f },
+	{ 0xd1, 0x1f }, { 0xd2, 0x1f }, { 0xd3, 0x1f }, { 0xd4, 0x1f },
+	{ 0xd5, 0x1f }, { 0xd6, 0x1f }, { 0xd7, 0x17 }, { 0xd8, 0x1f },
+	{ 0xd9, 0x16 }, { 0xda, 0x1f }, { 0xdb, 0x0e }, { 0xdc, 0x01 },
+	{ 0xdd, 0x1f }, { 0xde, 0x02 }, { 0xdf, 0x00 }, { 0xe0, 0x03 },
+	{ 0xe1, 0x04 }, { 0xe2, 0x1f }, { 0xe3, 0x1f }, { 0xe4, 0x1f },
+	{ 0xe5, 0x1f }, { 0xe6, 0x1f }, { 0xe7, 0x1f }, { 0xe8, 0x1f },
+	{ 0xe9, 0x1f }, { 0xea, 0x1f }, { 0xeb, 0x17 }, { 0xec, 0x1f },
+	{ 0xed, 0x16 }, { 0xee, 0x1f }, { 0xef, 0x03 }, { 0xfe, 0x70 },
+	{ 0x5a, 0x0b }, { 0x5b, 0x0b }, { 0x5c, 0x55 }, { 0x5d, 0x24 },
+	{ 0xfe, 0x90 }, { 0x12, 0x24 }, { 0x13, 0x49 }, { 0x14, 0x92 },
+	{ 0x15, 0x86 }, { 0x16, 0x61 }, { 0x17, 0x18 }, { 0x18, 0x24 },
+	{ 0x19, 0x49 }, { 0x1a, 0x92 }, { 0x1b, 0x86 }, { 0x1c, 0x61 },
+	{ 0x1d, 0x18 }, { 0x1e, 0x24 }, { 0x1f, 0x49 }, { 0x20, 0x92 },
+	{ 0x21, 0x86 }, { 0x22, 0x61 }, { 0x23, 0x18 }, { 0xfe, 0x40 },
+	{ 0x0e, 0x10 }, { 0xfe, 0xa0 }, { 0x04, 0x80 }, { 0x16, 0x00 },
+	{ 0x26, 0x10 }, { 0x2f, 0x37 }, { 0xfe, 0xd0 }, { 0x06, 0x0f },
+	{ 0x4b, 0x00 }, { 0x56, 0x4a }, { 0xfe, 0x00 }, { 0xc2, 0x09 },
+	{ 0x35, 0x00 }, { 0xfe, 0x70 }, { 0x7d, 0x61 }, { 0x7f, 0x00 },
+	{ 0x7e, 0x4e }, { 0x52, 0x2c }, { 0x49, 0x00 }, { 0x4a, 0x00 },
+	{ 0x4b, 0x00 }, { 0x4c, 0x00 }, { 0x4d, 0xe8 }, { 0x4e, 0x25 },
+	{ 0x4f, 0x6e }, { 0x50, 0xae }, { 0x51, 0x2f }, { 0xad, 0xf4 },
+	{ 0xae, 0x8f }, { 0xaf, 0x00 }, { 0xb0, 0x54 }, { 0xb1, 0x3a },
+	{ 0xb2, 0x00 }, { 0xb3, 0x00 }, { 0xb4, 0x00 }, { 0xb5, 0x00 },
+	{ 0xb6, 0x18 }, { 0xb7, 0x30 }, { 0xb8, 0x4a }, { 0xb9, 0x98 },
+	{ 0xba, 0x30 }, { 0xbb, 0x60 }, { 0xbc, 0x50 }, { 0xbd, 0x00 },
+	{ 0xbe, 0x00 }, { 0xbf, 0x39 }, { 0xfe, 0x00 }, { 0x51, 0x66 },
+};
+
 static inline struct visionox_rm69299 *panel_to_ctx(struct drm_panel *panel)
 {
 	return container_of(panel, struct visionox_rm69299, panel);
@@ -135,6 +246,19 @@ static const struct drm_display_mode visionox_rm69299_1080x2248_60hz = {
 	.flags = 0,
 };
 
+static const struct drm_display_mode visionox_rm69299_1080x2160_60hz = {
+	.clock = 158695,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 26,
+	.hsync_end = 1080 + 26 + 2,
+	.htotal = 1080 + 26 + 2 + 36,
+	.vdisplay = 2160,
+	.vsync_start = 2160 + 8,
+	.vsync_end = 2160 + 8 + 4,
+	.vtotal = 2160 + 8 + 4 + 4,
+	.flags = 0,
+};
+
 static int visionox_rm69299_get_modes(struct drm_panel *panel,
 				      struct drm_connector *connector)
 {
@@ -225,9 +349,17 @@ const struct visionox_rm69299_panel_desc visionox_rm69299_1080p_display_desc = {
 	.init_seq_len = ARRAY_SIZE(visionox_rm69299_1080x2248_60hz_init_seq),
 };
 
+const struct visionox_rm69299_panel_desc visionox_rm69299_shift_desc = {
+	.mode = &visionox_rm69299_1080x2160_60hz,
+	.init_seq = (const u8 *)visionox_rm69299_1080x2160_60hz_init_seq,
+	.init_seq_len = ARRAY_SIZE(visionox_rm69299_1080x2160_60hz_init_seq),
+};
+
 static const struct of_device_id visionox_rm69299_of_match[] = {
 	{ .compatible = "visionox,rm69299-1080p-display",
 	  .data = &visionox_rm69299_1080p_display_desc },
+	{ .compatible = "visionox,rm69299-shift",
+	  .data = &visionox_rm69299_shift_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, visionox_rm69299_of_match);

-- 
2.34.1


