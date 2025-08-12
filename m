Return-Path: <linux-kernel+bounces-765557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C410B239F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6957A7A65
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F7C2D060D;
	Tue, 12 Aug 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNf5OIQN"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA74627450;
	Tue, 12 Aug 2025 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755030631; cv=none; b=gY2X3jJUSwBbF14bu/x0jQ+gQnSICo9ksEtCCYv/DNcrfRkpcQBpABhdvthB/BjHwvjkOhE4GnGer1pdFx/rVP90SSR9CgPtHLDQopph7tOoFunmAwmI/w/fj1GwpsML580ckarPut8TMWSppm/Zh2waONKTv1uq4khDgaHRP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755030631; c=relaxed/simple;
	bh=DPUg/AoorRxu3yhwbYOhHRtH0CbbSLCxMzRYqdsDRVU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UNQi1m5HnZeFegjmdrHPL2IE2dkoVcxB3w+Vjcefxdvu+IgsM8WVFwIImnMUgWus2SinO/YeGctlNmtD/ZiFV6NEqQlalbGeEUxAJW3lH1VkgHF04u2Lj/KDPQHBNNfD6Gw7YtLPjiQFQ6SxrEqepBIuZXo2/QApuCfzZzYl/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNf5OIQN; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af967835d0aso823756866b.0;
        Tue, 12 Aug 2025 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755030628; x=1755635428; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UDpZ/uLV4xgn4kCXyhg6m1oHwpXbM6/gIBFZ0zY+grE=;
        b=lNf5OIQNgUlxgmXTvvoo3oGnDIu2K3jjmKH/PafOtUfmmQaAaFBVJJM0gzRoasMnpd
         ufGnSr4w2th/LDajBCtaRefl/0jnL94u7n+2KEaMi6GT3vT2TZmdRrNfR900RgCGR5eh
         BpooY/OmXOR01APCgR2KrIAYwN3g9ICNX3D6ha7V7hVqfrcbjYbSSFQKCEP7EyQMu2p3
         5FLewnY63A5Sl+CbvK3vfIE0xXiiKHxID9mwt8DsRqtvqIWXfbnU6wAArYsWCvWlR2/O
         IDKm+/W0Sgmh5ichbC5E9hejt7WVuvrFJFjb/cjRuWR7/apnMVI+lsw5YmuCiSFs3sv4
         qaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755030628; x=1755635428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UDpZ/uLV4xgn4kCXyhg6m1oHwpXbM6/gIBFZ0zY+grE=;
        b=bUYJOAMAQdUfz+Ptu1pu1X4ly704EQ18qBZkWaRFKjbS1wECEnGIAV7xuKr8UmEX6F
         UdYZNaKzIYwM2/jyVaGysPiMpESZ87xAvl51q5LxvcvK88UrEMRWNsr+sPwCAABa2Rmi
         RQLZxCMIpNnIvkSDj9LGHZgQNXwU/PIuN0sYkGeNjEnB85SbrNxAmkXIwvf0TiS7Ivlc
         dw2+hRESPgz8OGh5QpnlMmbl/Mhwgy6Wi8rP9aajH/py1p1rl3QKIPXXY6aOwCNepvCh
         924xleP5IBEZWpJ9inCB52VPeQ4n6Yj8gkf23Ys/i+8HWnJXJbGeRPIkO1BdoXxnLLIr
         Km1A==
X-Forwarded-Encrypted: i=1; AJvYcCXwxD2ujXk9twHzJ3zIhedmQ8txaYoQKs5Y1ysUW8dKu6d+5pbevW0fN7Czgf4UwUt0VSib7kYJvNe9B2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOIqJ0oBNrmZOCcHipNciDqSogKNrhAeRWGubbM235ejkp/vS
	vy6/lVVz5z+JrQP4bu3m1PkLqSQbNr5IBGwqL9DHTlIFd9A4asUku6OH
X-Gm-Gg: ASbGncsKV8Qk09I8bZb1PM5pPiUcrrBb53dcpfwLusCYO/tWpHPNjLd7uCCMtfJsG5U
	h+OFhS+kSLMCUA1zt0EZ6t4www2LODFZVm+FWsXmk7A9U1VVSnjnUdkT27dvNvA/Is/gToaTHhA
	LSd3JUgsHMUXtPoWDzMpRIvrQYlS902ojzCByyZaKo66F5aOQVwS1Epsnhboqeyh03aAnrRxjjh
	UujFpftRQRS+rBl3qoJiLte0icwmQ3gV/BGnCO83YutWbsAnmcgSd2HxNJvLJBc7s7/2hQot7nh
	7U5+/j2PtDhtA4cizX0u/xVtX0zh6tfIOkr7OBph3Cr8t929A2qgZLCuM8W3FfFUx3/OvDeYKxl
	1+bIRWGObSdiRTImK/S99qNGDAHfFKgJSSHwFwVvSctDb5vML8go=
X-Google-Smtp-Source: AGHT+IE8qPYJK5nv9hP6mJhBYPJdtTcVBRcIuezef0tNEf/XrB7lXj0liRGKyKHHW8hVebGuWOnP2g==
X-Received: by 2002:a17:907:1b13:b0:afa:1a67:c046 with SMTP id a640c23a62f3a-afca4cbb1c0mr54830066b.11.1755030627838;
        Tue, 12 Aug 2025 13:30:27 -0700 (PDT)
Received: from alchark-surface.localdomain ([185.213.155.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b58sm2266073166b.58.2025.08.12.13.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:30:27 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH 0/3] arm64: dts: rockchip: Enable RTC, WiFi and Bluetooth
 on RK3576 EVB1
Date: Wed, 13 Aug 2025 00:30:22 +0400
Message-Id: <20250813-evb1-rtcwifibt-v1-0-d13c83422971@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF+km2gC/x3MQQqAIBBA0avIrBPU0qSrRAutsWZjoVJBdPek5
 Vv8/0DGRJhhYA8kPCnTHitkw2DeXFyR01INSigtrDAcTy95KvNFgXzhru2kFr3RdtFQoyNhoPs
 fjtP7fqGDmURgAAAA
X-Change-ID: 20250806-evb1-rtcwifibt-a341507658d5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Pavel Zhovner <pavel@flipperdevices.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755030626; l=1045;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=DPUg/AoorRxu3yhwbYOhHRtH0CbbSLCxMzRYqdsDRVU=;
 b=olIxr2X1rvA6OPvIHjWNujq7kqoN3cBugQA6uDhbvCgzXX49DIhFHYGpp25HJaliyfIbItPBh
 9GeZmMsbRDNAsn+459X9Obgn6qN1H6ZX9a+K5vr0zTjK5oFDsVtaNMo
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

Rockchip RK3576 EVB1 boards follow the usual Rockchip design pattern
with the I2C connected RTC chip feeding a 32 kHz LPO clock to the
onboard Ampak AP6275P combo WiFi/BT module. In this case the WiFi
part is connected by a PCIe link and BT over UART.

Add required DT nodes to enable them.

The board also has a connector for an external WiFi/BT module, which
is out of scope for this series. There is also a PCM connection from
SAI2 M0 to the Bluetooth module, which is also left out for now.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Alexey Charkov (3):
      arm64: dts: rockchip: Add RTC on rk3576-evb1-v10
      arm64: dts: rockchip: Add WiFi on rk3576-evb1-v10
      arm64: dts: rockchip: Add Bluetooth on rk3576-evb1-v10

 arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dts | 115 +++++++++++++++++++++++
 1 file changed, 115 insertions(+)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250806-evb1-rtcwifibt-a341507658d5

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


