Return-Path: <linux-kernel+bounces-781797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5EBB316EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49D51D00C25
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE95E2FB608;
	Fri, 22 Aug 2025 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eikWxakz"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD122FB604
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864274; cv=none; b=t4w+fPj8IiKCgsVMx+oC9ZisPTmm6H3pW4bISj0kTgzz/4tpmItIha5U5OuLnhvaFyVkQwtpHmKP/jA9jGi4wJkQJNmM8KnLY2OmacARsZ3xv3ZEZXxSesbsg4aYolpROYUK1iESmSRQCvtuNhgV+/GRY5DrQOKQSika76RjDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864274; c=relaxed/simple;
	bh=axfRpRaHLYgBKlvsnB+99CUv9767J7QI0KejsL2VLyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C5OJM8nzkBMzApp7TcIpJek1veR2tfDLcoLXrFCj2IQ8aVvC1ZCJ+93S2yKkxzP1Wm4UDc4I0frjhWIO2Y955a+77VSLvjzaB5lE1qzsJ9PYBsZdCXavelXSFlVsfyLkhF9MazZ40pwL88Dg8h4ZKFG/fPeIAL4cvWn4fwF6lIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eikWxakz; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61c2874224cso25918a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864270; x=1756469070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5NG0Gepw10LOaJp1n7fNx4br+n0kCvJOxwzoA9B2aPk=;
        b=eikWxakzY6QT2zTaMCFWOwn/rtzB/eScL4F6SdOpYmTpCjP+RWmxQ3fXw25KCf65Bn
         qUrgm/ThovNF8j2kcFBTZW0YciJrEv6PnX48llqG3npSRor1g8OufoLiHMD6RfvcZjrD
         fV7CWqHe7miCSH3WE2uVwUBUO6WCeSf4imyfV/Af3m667pQay17gwZ6/mr7HUqgT3B4i
         ztNbr624PpRKyxou+qgJax0czCknAYXzAhEXrCeSyn0r/6pq5++Q3u0o2dZbVCROXgDE
         Try9276419xKZVGZGsPRCyuW0UTc6gNLVVRSk9Nm7bcuARzD2mDw7x8C7BaCf+nLmkeZ
         57ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864270; x=1756469070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NG0Gepw10LOaJp1n7fNx4br+n0kCvJOxwzoA9B2aPk=;
        b=ceAokoo+gP0AqmLp4yv5JJjaY1qEkCtP+cxoI/L+V82SOOH04IipPEPEjrMeyxAZru
         AEfXCk9q5TlQkDnAp/D3hRUx5irZaJ0mGMuLResDIYOhJeayPSeV+uT+lBHT+HtOt9cN
         U4gnVm0QhMul3wMQQjT8F+874AFUsS724T1aEJc5aGxaUaZmSPrqF21RfmKCuSx5mcEy
         A5hItWQWfs+FHje3nUKIzbUyepl182atZZSC/UEH4+5Va8/k4elnL3XmJp2/yGe+zsgo
         vJeYUyaUOLyiqzp4jQESho2wPt17uReq8wQzu2g9V7i5fmUo6J7nfYhzDIyNv+vR8Rc6
         pZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCWaNItxGuYUpM7G8ykwAbnTHhq8eIxdnOtdQeglPPfE/9yDT4yJsvSNet/7tE64KXX2edJE58/jsgPpQuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2anwHABxPiIeGASQFu9Qz0/s3UuWeQafaQ3pJNWbHiW6zTjFr
	2qF37Z34JWAkimsyNGkFYM0VTAODtRxAAV/6uy8SER98SGiV6uQMwzYP+2v2OnTEHgY=
X-Gm-Gg: ASbGnctOv7ny8HG03z0/u7pz0FoEkmNhwq0Ug52j7EAZ8JgBpm63ML1d/GUMKhwixV9
	mG8rfCAEhSFXK5mu+vBM/YT8p2+Us8Lng+fqj7GxUx1VcCk5VGvIlwFQiyeB7iGBGzUEpw3Y1+h
	hKp7c/1LY0aIteJzgy+4SKhMf3x73ZbspDtrzaXyjigAatq2guAKug9yMpb/AUaHBMF6mGJtSee
	yRC81D7gyCZ8+INhu4B5hyp5jw1JrMWhASp4a5sSthLVknExjkV2Z3PUhORzOBdkjvner7dANJt
	WAowo/KXU+bHtG+I1tx8m1KEWY2Ka51gZxKyZzWtX3RCO13WMJgXetsrQJYzZHp+WEedcq/Zk4p
	UgEJ7w4bGtiPNrvt3cam1Z7R7ryeoCcFsxQ5LIv4=
X-Google-Smtp-Source: AGHT+IHqTtnv/0uL79XsFYZ2edmqs7hNBXRJNjZ7FQAsR8lHOcLoOrCHANoRo+7jMy57BVFweKSSGw==
X-Received: by 2002:a05:6402:2351:b0:612:e258:33e2 with SMTP id 4fb4d7f45d1cf-61c1b6f4129mr1287661a12.4.1755864270515;
        Fri, 22 Aug 2025 05:04:30 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm6690444a12.48.2025.08.22.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:04:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 14:04:03 +0200
Subject: [PATCH 03/15] arm64: dts: qcom: msm8996: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-dts-interrupt-address-cells-v1-3-d54d44b74460@linaro.org>
References: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
In-Reply-To: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=axfRpRaHLYgBKlvsnB+99CUv9767J7QI0KejsL2VLyU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqFy8ellBAXeW2gM+k7VakfTemNxw1IDgPPJv7
 Jl7iI4l/vCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhcvAAKCRDBN2bmhouD
 13v7D/9n1puM8ctKaHbcgaeyB/m1ByE5XqAiMYDkwz/wT1HE1RdEh27JJ1n9qwuyCZZlOHMLUea
 QlHO9csrafPU91clYdE9+gxQDKck/TEKFFo/7bpsqfOCx1Rn543oQ6CVOf+OiZVNWfi4bnbE8qQ
 Zg9BHcaVjlUKr57tp05Zx0MgHxhNofUjWpN+anK1s/AvuzCzpo0vKKZ4aO3ru+8bXGLHbKP8jP6
 1FexXJnm5Vw162wz1TH/2ejbAi0VMaas6rvxkdgLjZ6nUxuAo7WtHSsU6GlA7s/J02skmVIQCNM
 5oTifMtS128r7UjmyxS6sVxORmEZN4+VBQvl6Slmg2DNYQII4L6yiawvyNCK/QnNUinLGEsJzL1
 0Lip2hMFYHrZu34TUVI8yO8aAwaWJdumLBiW9j/rPL+UwCObraWNmw+V9fz0948+IOt5XIj/Er3
 dOVr9fwKWHxw+btyRykwRhUX6f0+rg1fcUDJVs03Jf4Cv3aUQtxO4rFmc3GsbRZ1GSAvYMliX8Q
 QcLPoIPYA5f9+BjyUfm46Qf/eEtVhKIqUAv2BdH//QRwSG/JipCZ/acJZ9W3sBSQIyl3xv27sgY
 PUhjvKvz+pFeXa75zqPy+lpi0kwVWusVvGxw79zglZg350aM8qIBXDLik1dQJXGICoerGohusMc
 m84IXf6tGLXTwXg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  msm8996.dtsi:1931.5-1934.31: Warning (interrupt_map): /soc@0/bus@0/pcie@600000:interrupt-map:
    Missing property '#address-cells' in node /soc@0/interrupt-controller@9bc0000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f91605de49095820b811ac5a81cb43eaa136b9f1..b5aab21ac5250029ee60987a1e64871ba4e2be6d 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3766,6 +3766,7 @@ cbf: clock-controller@9a11000 {
 
 		intc: interrupt-controller@9bc0000 {
 			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			#redistributor-regions = <1>;

-- 
2.48.1


