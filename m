Return-Path: <linux-kernel+bounces-782404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F8FB32002
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185D21D23417
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A966280331;
	Fri, 22 Aug 2025 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prxVYhRO"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7216258CDC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878226; cv=none; b=aqgv+In8tWm2RQxGgW8z3bmyepG+dfxyojQOEIK4QQvK+QLrZFlNk9DVehBJ2NUjjcRJNdVvvxRKN7V3oSZ8VJwWbyEt1EmYSrqoT+rRUNwZ777zVx/HzG7b4I834tkUGcMFY05L8+tfu+AHMT2C7nIOmBNei5oenb/Yi+QUxMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878226; c=relaxed/simple;
	bh=J3QsPy8kQkycbh/QGtXaAVp9rBjfq2+CcgrFWGWqjD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZsyNCDgILi7csrpJh3YjxyUoFP2o0Yqd1tl31d6bMD9Dq6rmeb5NLQjuk1C4NESHC1SGts6qpGpKVaPb5ES2wUv2T05a6OLQEHxuZh/OZ34gNd1wKUBtr98teIi6toXu44j77U6hmNqCRbXbTnlMegyjLTteS8CdcssE8+WYaN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=prxVYhRO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9e7437908so1543911f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755878222; x=1756483022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtpqNISIAtlRl+8Q1bmT7c+NIqDCslssVJowgcBc5Cg=;
        b=prxVYhROVV/rszypfhCM0q1BEHCpSBQSi0thq/MUos3/FlsyV9COmgfv3zS8rcjEdH
         UZZ1hQLooLb9l6rL/m0a7oh8uM8PZG/HgP/0egC+7VlFG4jMiPU8OgXRy9issbQdgQbp
         Nu2NhMB03pEhIwIEycYy3BTy5pzu3HR6a0NTxG2zWhtrJqXPV7EWCCmrHGPPTAhoiE0q
         eEdc0MpTKiY2pOx+owJfbOLidsf8pAK54QBs+7Izp8aeufE6HnsxnFrP+uuJ/wx8gl2x
         rs3Qjj67Af0w+3z6ewBtWl71buH+oMNFUqBHbcPBEks72TRafz1IewgcvOlr3ylgmfUo
         hLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878222; x=1756483022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtpqNISIAtlRl+8Q1bmT7c+NIqDCslssVJowgcBc5Cg=;
        b=bjO3pNbJeR0f6BEwvHqvX4i2Jba1JZDOUF0ORlF74L2Hrta6cm6FBDjmATwXU7XPft
         6VanLUKkyQ86V+0DZ2zF6m4S0cWV6xFQTy5lxj/5ZDLb+Wx0bNeBd0BVNJDUaclFWT9g
         J59q5Y30jMYYwX1wNvX7hhbtIc3Nx/EzE7TLaqhvqdj3fzCdW758d6j9mrIssogcqFMT
         sd/lS1Y/Uxa/8Bex33fJEjqQPbVhd80EIS1IyAMl61JYhdTl1BtZhX7TWvhYHOGg/+8a
         Ajv1rVfHdCxit8b+2GMTD17sVCgPVgpqBmEvldAuIZs6VCatewlqvTOX1Z7LYGw0TXsU
         iNbA==
X-Forwarded-Encrypted: i=1; AJvYcCWRlaeBoHabBHB/+/pJ2PI4Phh3rRKAQu2qTDYokynqdK2jR89oWqv4aWm9BFANyfi2iBri4awjgR8eAeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8GX6+Nrk8QXNhdAprEVw6H4d1X7FAsjZOwNbpT+gdwRQvkMwo
	mOoZG7/hieTg+7OxfIDRDvIGDg3UWuBI6shVyVk27X5o8nanDVhL+TsyWCD8FdBS2Zo=
X-Gm-Gg: ASbGnctyDPl2J4mGo9jcNHwg1sJRGeMaMAYCuhNoPK4P1xyHjp6mLOlj/kjqNKGrEpa
	a/9LlV0UY+JSkZZQV7/t59rWBXOgC48wkc5ASduVRly6+/Ye4FLkMeZiJr1nu/x6+XQfBp3q81y
	9K64GEgvquEaZhXfiEEAXls/NuqPQjhlTJ++ZoaW5+/haRIGlhhkrpMmPfMThzLG/3GcF5hkNOA
	mPO3f+zGdfWa00ep9HiWlcuOKSKk+McdglewDQ/p0HsKz6vlM752z5Uelp0UChuDSOArDr+PN6j
	k3SLEa/RJQhJMlbCG1EOTqS4Ugbe5p+55Nz9NqkwJ3L7XqxfNdGQO6aO2Tmqsx6qRUG8YhScPqX
	LIAxBAyhzrCQWvse7e0XBw9UtxlE5djIjMTk0fyzqAWU=
X-Google-Smtp-Source: AGHT+IGgSyg5J3YlH1xNxOTZtufRUM1LJYp9IrgW4WuhXZT8VqwSiQ85MdC3tgUMupaBiQowHJ80nQ==
X-Received: by 2002:a05:6000:2485:b0:3b7:9564:29c3 with SMTP id ffacd0b85a97d-3c5dcc07ed2mr2722567f8f.49.1755878221983;
        Fri, 22 Aug 2025 08:57:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3c89cd4d4sm10095765f8f.42.2025.08.22.08.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:57:01 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 17:56:55 +0200
Subject: [PATCH v3 7/9] arm64: dts: qcom: sm8550: Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v3-7-5363acad9e32@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=835;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=J3QsPy8kQkycbh/QGtXaAVp9rBjfq2+CcgrFWGWqjD8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqJNHFmezGDlyKFKW1ZayZrNQQyhNxPFN3xEUPedx
 RA1ozxiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKiTRwAKCRB33NvayMhJ0aQCEA
 CAjrqVU5sMDXlbiiyFyeY1NYDiPmI6R280sVFTGzlC2poBiVnK65Pg5B+t8z+IpXG7kMjpkFuWbKyS
 vsje9XJe+zglFaz+hiY0N06uW+mS8cDKgYIkJk3mDxEyCoeWjJe8M9jEd5HJKzTQX7AwD6ALCn8Vib
 7V38za6vfKxCA2PB9OUFILFoagQdQPem73PG5UKEAwIn29BaKl1rJT9vYI9JdU6zAgJpIvrZobL96/
 K5oaZF3PTHRTnXgx2XeHnXb4pgtnfO9QR1GmRVrF7EpwK/E5aug4BCz6kL4JSBwsFW8fy9K7NbuhyW
 YimPdG+zRX2awAYAfm2XpN0GmzeU44SL7tu+x0HimPYZCW2jyvwGyxSqsVur3krcLx4ELWS+lkFeAV
 V56BryAcXZMlBlR8UFbhdQ6ybig8fPDqURvLgzW0wMgYYHfOfSP7jDT8DXaIcDR6M/V5dV015IsVfB
 Czsfs1aN7WfzVoqVZh4fUDZO0NzIKS1AROw6kH4NtNb7CxB9CkKpi7QA0Zd49wgkRT4hT8eFTr+AKT
 W76y7ryQuNOmImAB5f8C9oOxvdRSKzVe1RVUlxhii6ow4UxB/fAyr2AYTxmFN1g/yJ6b/Qv4FIxiZs
 OZc+6URJy2IIj3WI3+DhkkQYMSV2bGcq5pc86L2PS8bv+9us87kVk6rpGX6A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHY to the
controller now the mode-switch events can reach the QMP Combo PHY.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 277820491e8e96ce282579daef5287f6327ecbbf..52055354adfa69d39e0fc5cc9d9198dc8374e1e9 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -3791,7 +3791,7 @@ mdss_dp0_in: endpoint {
 					port@1 {
 						reg = <1>;
 						mdss_dp0_out: endpoint {
-							data-lanes = <0 1>;
+							data-lanes = <0 1 2 3>;
 							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 						};
 					};

-- 
2.34.1


