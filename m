Return-Path: <linux-kernel+bounces-878833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 059B3C218FD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACFF14E7749
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B8236CA86;
	Thu, 30 Oct 2025 17:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDQ2AxW4"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A903683B1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846759; cv=none; b=VK9nauTROJq7hu4GzTf1xQy0PzysCjTo3JpRZz9UFFObJRtQ2rx7QesqFpWrVVv+Bmp1cpIA/W7ruzDBbirD/G3gmXfZcKLlUg13CboQsP9F4Y0bDG42+4Ix3T0A1u0Ymj06/zAVOxuKMU7kRgEa4vxocoX9nOG7EKZlPJdoaLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846759; c=relaxed/simple;
	bh=NFQXh/5i0Z5ZvERywwVsKntqvSCAyTKJqCpMAnOffNI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=kwuvL5YAK8c3KM+6v8QCeWGsjhqPhRiiD7hIjb8AP2cTUi+ry9TKXgW2N92FYGD+lZcJCOdos/G4qRATGki1VH4vqCuMH8UxHlZJ1gRjfWRL1FCPQNgN0krpAxoWL2Mw4zJUkfWrdGMd9kil2SO3d8fZFHfV/+v0e9X6F1Cb56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDQ2AxW4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6d4e877915so19819366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846756; x=1762451556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njsjO4VFZqA7R0pPo1P10WkBD8Q9L5cVjM6fjzkdhIU=;
        b=CDQ2AxW4JYo5F6/XVkF0swxcz0BxqYPsrQGu0zbnRJHO4IbZ0LbA/mSsoeAuUlIGDE
         g44G6hcHffo6Z3/feR+acCv0l+abEWOZsQtj/Q6Vdd8Kzyn+cdLnXqDYXluztjkJn9xo
         Lqk4xUIphbmD8lxdfo3K2UXJ0ZMiwtsiel2T9uYJV3dcKoYD8ZpR4m4m/g1M6VpY0cYa
         MFZmOarlk7Wja5TBsymwUAlXjPuIkNIe4EscFCLJeijIcMOwoqozKS81zGE/HHDinieq
         zjNVfr2JROukb9zXkIhnxcVfsGwBIwssfffHmj2N5LMSOI2PfdpK9qZtwAfpwv1hUldm
         ZO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846756; x=1762451556;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=njsjO4VFZqA7R0pPo1P10WkBD8Q9L5cVjM6fjzkdhIU=;
        b=gtlFZFX9AYfYSD5DwG+19mlfQk/nR13wqqjJBZfNH8EbH/l6KlmLaid3/26ot6H3/B
         r9+7QTlj0aC29oWnJ9DoCVtRzDFN2LPtAqck6xiSOt2DEiTNBjySwCwtOO1p0jIB1hpo
         dRY7HxjXITu5P9mcUZTJzgwuPlMtfXayfVZ2DeKULTMRJtv1jRRmftyHG5+hoP6HssLb
         0gmGJgrdKYefgJ2DrVm82vHokP5vUjoJkHVe4c4EkOcmRDVAUA0x5IL6QaexlJT4WrXF
         mq6+6C4XVCOM49xwgxhkEDB+7t5/qJKxA/bB/3o0yOJ5iwsz6EOaGnSTTjS+/uHzevlG
         H93Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDrF32iw8fD8AvzHEl7H+c6Ct3sjCGHQtxbGl1xuw3XT9RzpM/z0u0iZ143jfhjwAo+iZTnbyKbsXaFBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhzyq70/V0itEQzzBrgRHRgqsFZbcv2DSyXotkGyIvad6V2v+P
	4M5rwUmgfB7564z3XKNBOtCyh1lVKmlyLJvPuFmRVDs6emEk79VBvCqE
X-Gm-Gg: ASbGncuXW2l1Xcyr2knDGKsPL7ZwwifrG85jC+VR34ob3GBt1i7B9Z7IaUcndcFESmL
	HbvHAOqIKfPncOz13EXeulfO6JGZYHf0roHNiTetVi++um4ut1UmMFisnkt45Ca03cQM6bJbEsp
	8E1SqwL9vYPG6/RPA9ZRcd2YXxq6B+WgPreFMzaXoA2P44bZDiIl/XLHQH6vOkXYMNlsxBHYH9K
	br/o6/764awNU43rsC3S+gPByvifx+pjZ//meQmfoDQHJLC0VHeLk1OfWHHYfIKO13cr4bqdu5o
	8Ai/xWyrinemzp0bqnpxVT8Wkka3PnUoQ9Z19WN9ECru+bH+xGhy+ZpkdyNOe5mci1ChF5NzmBu
	TrmiTYAH5k13UYdh/Z/+JYAv/0QW2WF/ZLxQyJiaLGiV5dJ2DnWcUgFvb4feMqVaujhhyCXSIh3
	WHNfqpoBeyUr5hC2bCfRUIs+GzJAYbKUZzCrkFjiU/rjtofIQv0w==
X-Google-Smtp-Source: AGHT+IHEjrjKgjCwmL8TWuOerIFvVWufwSPMm4yYLEbgFtGVI/ku0NlxLVuGe2f+k6tpzEbHXAXZQA==
X-Received: by 2002:a17:907:3e0c:b0:b6d:6d44:d255 with SMTP id a640c23a62f3a-b70700af393mr23224166b.1.1761846756003;
        Thu, 30 Oct 2025 10:52:36 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983? ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85398444sm1778908866b.35.2025.10.30.10.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 10:52:35 -0700 (PDT)
Message-ID: <8a423a6f-bfdc-4947-aef9-35ee7c4f6ca2@gmail.com>
Date: Thu, 30 Oct 2025 18:52:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] arm: dts: rockchip: rk3288-veyron: add spi_flash label
To: heiko@sntech.de
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The u-boot,spl-boot-order property requires a label at a boot
device node. In order to migrate to OF_UPSTREAM more easier
add a spi_flash label to the rk3288-veyron.dtsi file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

https://gitlab.com/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3288-veyron-u-boot.dtsi#L10
https://gitlab.com/u-boot/u-boot/-/blob/master/arch/arm/dts/rk3288-veyron.dtsi#L267
---
 arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi
index 260d6c92cfd1..2d6cf08d00f9 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron.dtsi
@@ -388,7 +388,7 @@ &spi2 {

 	rx-sample-delay-ns = <12>;

-	flash@0 {
+	spi_flash: flash@0 {
 		compatible = "jedec,spi-nor";
 		spi-max-frequency = <50000000>;
 		reg = <0>;
--
2.39.5


