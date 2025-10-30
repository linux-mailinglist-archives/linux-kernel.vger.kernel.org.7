Return-Path: <linux-kernel+bounces-878912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5959EC21BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11557402092
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB7336838E;
	Thu, 30 Oct 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaGilRn2"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A50D269AEE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848446; cv=none; b=Ht0olg3VUBtRHvUEeMnx1NRk7ZeIHjA0gsMmx09zbi1pqWPkp4mLyogF3py+CuGPwCz8TOOcEj18MXNnawx2IpGIZy6jAvBXG7QXDsSTtI+8f2fTjiEHaCGkCjjC7Nz2qv2IRAdlxYIK3p1+8i1152uxbR+3EE+mwhVlxJtQBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848446; c=relaxed/simple;
	bh=OFO5ByP0qS7zRMd3pNHzWffENX7ZV+vR85TaFWxUVr8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=JYI0PwyjVhHg2AhfbiESfnMYEU+mj0yFIXy+AcIckg+LGBk02qnkQpuDESgm3D7ZCqGa5XPFChEUtLBTx3kP+c2QwWlGccbkVnHbPBtdDxmS59mbcx1bWu7vf+KTmizHxm6kf9ffkBzHCW5SIH81vT2VpTP/UKJOoP2AQWVJbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaGilRn2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3c82276592so24054066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761848443; x=1762453243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjUjRNFP6aJN3yakl4D7gzIFYpfpYZ5LN/0WHYSw/TU=;
        b=BaGilRn2yMl/Ou75Ev0+6Hzi55F5j08NfyIkIQKBWCPf4h5ZcDjm3LQkcmZE9k8X7Q
         vsmDgVr7DziC2aNLEPPw7NEQV/3js0jjX8t5xsCKUCA73s0UZV6/OdLgIMYmqOhlJmRC
         LflHAYr0LgyTfeeJRzagCg34xRCdeO03lMAd4sTiBno1FrMsLlyqc7WEJa++Gd19oyaF
         5/GeVk8/4I7E9OwCcijBkeSS7Mc9/Rs6ZV0FmMoqqZ0wB5VPzEbrISnWin2d6E6HUBKe
         yuXwhlFyvwSxyjBSx3rbcyLWcM5+TYReuDwEceDNOTI9PpyKsflGuYXlPprhpBI42hYj
         cpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848443; x=1762453243;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JjUjRNFP6aJN3yakl4D7gzIFYpfpYZ5LN/0WHYSw/TU=;
        b=W2Nyyl/av5zpGkOvuhaudxcB0YTCAJ8th+KHSaHzXeUuXezJbtYCvcx7mBh9h9nmQ6
         a/IxWgWjR+Ji1R3p/P2VfyA/J3+4SombMkU0a673jcD2vaq6sjG6UWjynmpg/Dw6/KQp
         vS95cLcHZREWU2u6kBmJw1PuynaXYoOsIyRbj8YgPBF6YjA9Wz426Wsbz3JTcLJDZ+Yg
         dR0oCHk9mOBZ+YPN7VKwehkfOGieHj9RPD6FHImAL1tJcYah6978onxmpoBd+9ygfirJ
         1qfxY6n1vLKPxR1Mv562q//S4TMwpxC+IWDr2qqHsrJCtddXeCKxA4Y7rK38mAWiNtxS
         znDg==
X-Forwarded-Encrypted: i=1; AJvYcCXBH3hPH3D62Mzgwdp0jrtX45u2etZp4fiObYPVsaEzW3pW9qczU7sN+30yArHCrTatT30OO9K6/7XzmpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdZvB0wEnjhrIpzMu3i0xGzRV4huPwHH/o5sNQNiDZzNlxE0L
	bYGLeo+Z0gBBC25jB9BhYLGpu/ngWFASNXiOpHB/wY3+MV1MAi7+TUoy
X-Gm-Gg: ASbGncvnDHyUZ6GCeCW/ckxA4zOHwYekzIVLYo0nytP6Vtkt0RuMvi9rBYhZg2CZjBY
	fBZFabpG4h3fgxPdhxJ7mdUMLy6mu6/NFLBZ4o2VuQHJCHalfN6VInuSr92eLIHbmeSRffxSbrY
	huRsB+Jt/wrq2ccvlZxGWZuMGeK1ObVnLE85f+LxnvqyWbrz3Zx5p0iqMYhZOg0R5p053Io3d2x
	NAEvMHCkUxJL/Vm62T0kwYpzqQ+sAQARkRgYgR3G1kFLFscKOCpXnBmtiJUM18k6gDAKKfcPK8O
	QUJdc6+54350RY3jqhhWiidpOpB3EkzLA7dZC/ZxXriTSesCtLuY/IFdRZue5QTn5agNgC2Dz2t
	+XoQCvNpb/jmCsFE6+OUn2ESiiW+YdIefZ7UShmzRIatXmwyutVwVXerlR6Rdg7/02wKUeW7gYd
	iuNlmNgSCLSWRFuVQMaBh0Sfi5JCkB4sfoFV8v3XsWEiL+GKnyQg==
X-Google-Smtp-Source: AGHT+IGEKU2F7RouDiDAU+O5ZXJF5KXX7hpByUky1BUiO9h2llr9yFPyv+VlCHc50mSyNAzudGyZAA==
X-Received: by 2002:a17:907:2d90:b0:b2e:9926:3901 with SMTP id a640c23a62f3a-b7070627711mr22678366b.6.1761848443115;
        Thu, 30 Oct 2025 11:20:43 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983? ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c549fsm1833865566b.37.2025.10.30.11.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 11:20:42 -0700 (PDT)
Message-ID: <3e461bce-e8e6-48f1-a296-34040447ff25@gmail.com>
Date: Thu, 30 Oct 2025 19:20:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] arm: dts: rockchip: rk3288: remove mshc aliases
To: heiko@sntech.de
Cc: robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The use of mshc aliases is deprecated for some while,
so remove them from the rk3288.dtsi file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3288.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
index 42d705b544ec..7e284b4fecdc 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -34,10 +34,6 @@ aliases {
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
-		mshc0 = &emmc;
-		mshc1 = &sdmmc;
-		mshc2 = &sdio0;
-		mshc3 = &sdio1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
--
2.39.5


