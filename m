Return-Path: <linux-kernel+bounces-870419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C07EC0ABD4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406473B3A53
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC62248A8;
	Sun, 26 Oct 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQu4EhvJ"
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53269219A8A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761491079; cv=none; b=cBDfa39xO4dCL03ifV655ZPXQz4qdfdXehrHew0uaSEcFrJ0d6K1hcP1lYIMSbkEEFKE4BetRagtSX6iF7ANi0ktPmoC5V7BpVPRId3Pp/3FaViR5aYx5K+RO6JG4l26Wv5rhdbin2/npv/p5+YHXzwhPFBiirk14Q1UQWikmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761491079; c=relaxed/simple;
	bh=6EBhaAV6a7FA2r3SP0wp+EL6O6ZmLiovT9x9nt8WHL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGPlUCeNb2ZA7JoUDq+I5zWd7bERW+9xrOmneIQoxH+v/3DQpFNB/gF7t+0RFRTLrbKhGv5XLumQ7Bsm/T3jq+X7rPxhfmlbBuLpMr6k2ric6wrHVz/TKkBqeVZYFTNv41oFojz5w2DPERwaotnBQahy3VFkgsb9hURVgOJYfLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQu4EhvJ; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b6cf07258e3so2768565a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761491077; x=1762095877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+ee3KqA2yzD2P8W3Se92HTLPVHTZnMBaNq34xZJiVY=;
        b=YQu4EhvJAHO06+/3lwqLhNNSb2ErLD0nXt4myKIwTTTbtCB5CphKtx4+XOr7rD4sbt
         2BkafclgeZW3aaYXeAzCXM1mRl9QQT2l32yaZWXxuEdgfv11B/vcI8vBL/L0DYrRllq7
         vIhyb9Jq40rmdWXR18zof2brnRLgy1paNjqiEoz33KUEkN7McGtzql/eohfvqt+T1anR
         VdXOx4QeBcKR7ceck/lDb6qLurIrdLeDmVNWBMWv0DxcXxQI+jml+qlbKEJvvj7ZaOQs
         Ae/OwMU3cWSge4h7hB+shOorB/+Cd4G5vCtXsQEJJ921VKPjV9F8AEVmzyBn2a2dlnpe
         xgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761491077; x=1762095877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+ee3KqA2yzD2P8W3Se92HTLPVHTZnMBaNq34xZJiVY=;
        b=Cobg0WIhyTpXs+glfvigjwiHzjZxeDVGyr8ujRHaMwcimynk9HMdAhquPEndAcWcOd
         xkkNy7MZ6a5nyX/NLFiSjZPGmc4Rg6LI3h/NcIEXTD3I74EVloZ3JdbO+cAQNXj4LPbm
         Uc2LSyytO8xoyIOSzYMjdOfgqMKJrqSckrG4vsUGb5SCV4Gwg9lPiz+dhhcjGZDoJ6a8
         eZCr+ABsKUon3xTJHDOCWqJE80Mb91DW7XrLELWnWsmBd43J2x+AlHTiQGXHjyHMsRTa
         UtS8gePBNOV1jDUvlu4Yge+cUybqUe+c0JItuDCCXB2BvBn+SA+vYWk4jp9wBTst9sUp
         Oj4A==
X-Forwarded-Encrypted: i=1; AJvYcCUhdMHV4+yO4CVqx/HFP7+ArbCekOSfgRkMiDeyh5DpfEYM05o2FoGfLuXjeAyWDGc/HNFT9W6us0dQAr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIhEdpM792a5cE3R+gKiHVrfcJOJ1Osd32aPykErvPJLRkEZq0
	pQd9sKrM9rT+Uza7u02rHt3YLnYsD/TVrtegXeWvFhw/+rXAHWM2jdod
X-Gm-Gg: ASbGncu/6QrP8/U4qf/Bu63UqP3DOcqUvxLbWlDmxxIPswRGovShR8rMx0X1KsmHrlz
	Ax7dt24ZXmAgg40uV4IrP7UJaVuCsuPm9I+VKZtnNuBXW9eTxiIPhQS7OzjWDz8vcT3APlkYM4Y
	0ljkSg9V93uV9TM9w4yLvZgPepJG03d4zZh27Vsf7Hq2nR7PKGqh2fstnSDheCBwmvMOt3aPT13
	gn6n2uYl+Gl6V1c8ph740tcTr3sqlJsFF0xhz65Ru1Dq2uNz8sZGHC2tttxedAoHjqVVMWzFCyi
	AxyyUt/ZpzNarXiGFxlyF4OKY0xBqcQJIx8bfzhhzfLGtVxvjzPYVjtlert8i4sGhuK+fEot1EK
	U34XtLGR3vbUZCUZeACfAIzYYGw4h5CZ9Hi8QldUQB3dc3qP7xeAQM2V4TaTClJmBPasBYA/xvK
	lMye6sYKg1hA==
X-Google-Smtp-Source: AGHT+IFxsSx87V6j4xGCO/gIK9SEmLM0XVc2BXFyfyHWu6d+W66LEceiivJPxXPgqc3+OLhbzD/l6g==
X-Received: by 2002:a17:902:f542:b0:24c:b2a4:7089 with SMTP id d9443c01a7336-290ca121a5amr484987455ad.31.1761491077286;
        Sun, 26 Oct 2025 08:04:37 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09958sm52320375ad.24.2025.10.26.08.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 08:04:36 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH v4 2/3] dt-bindings: arm: rockchip: Add NineTripod X3568 series
Date: Sun, 26 Oct 2025 23:03:57 +0800
Message-ID: <20251026150358.1078453-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251026150358.1078453-1-coiaprant@gmail.com>
References: <20251026150358.1078453-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This documents NineTripod X3568 v4 which is a SBC based on RK3568 SoC.

Link: http://www.9tripod.com/showpro.php?id=117
Link: https://appletsapi.52solution.com/media/X3568V4%E5%BC%80%E5%8F%91%E6%9D%BF%E7%A1%AC%E4%BB%B6%E6%89%8B%E5%86%8C.pdf

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6aceaa8ac..417100209 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -777,6 +777,12 @@ properties:
           - const: netxeon,r89
           - const: rockchip,rk3288
 
+      - description: NineTripod X3568 series board
+        items:
+          - enum:
+              - ninetripod,x3568-v4
+          - const: rockchip,rk3568
+
       - description: OPEN AI LAB EAIDK-610
         items:
           - const: openailab,eaidk-610
-- 
2.47.3


