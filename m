Return-Path: <linux-kernel+bounces-781805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E582B31705
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC355B0389B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C0C2FF177;
	Fri, 22 Aug 2025 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBHJG5sZ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0D2FE587
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864285; cv=none; b=QCxPP9W5aILUo0ku48pJA8WIwJdYHb3zEKCuHGvXAg4qDP2mGhOwVckInGPZ2aLtoxuncuIxXgBrs35MnuyE64GnOL+5fimtBYSo7KOUZwsIuey/sLjgtSKQfqwLvnMVFYNaUElhR9L/wHN2zIn7AEbrARNHKe2k0yCkiTgtUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864285; c=relaxed/simple;
	bh=SQm20kIaOiWYFBfzGEfwLlwWGDgrofGLefsJbh17LUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OwMU0ZKHtz1Luk63+q95ljWXoTdHGcQCGxAXFRdj2jkDaEae9cNEmG18ZTvH7ncJxJVREnKtFfHWWKCnh/W5emIisJ21xleUD2NBMrWN5hnHteRsCirGq0opnLMP/ZAB/VZ83jyXJFhusNI+HVOyeo9rH9o8HBL+EdfKTlr7TDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBHJG5sZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61a54560cd1so228378a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864281; x=1756469081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zM3/qo32zjBOLvIBZIBEBGO/3GnYRbMH0KTgG3XM90A=;
        b=DBHJG5sZsKg+CkDpyojutJorQl5sreLgMm1goGDxVjwDTSVeAmHrZ9AwQ7ryPsxtcA
         aRummyf8mC7U6qjRW9S5ug7GF2V+DrN9JoIOQYq92Gd/kMvfbxz6DWR+hw1XRaENXER1
         7YfAyi0CmMPZp4wRDV6eiPaotDFt9ovlH/MPDqFUMce8BnuBCqaSbWiaBk0nTqIbNt3J
         NMU6sqgCNQfEmgafIi3oXr/DgGhjYlO1SMN+wvf5NZiYELOnWDfJv8V9FMpAoVIL4mJ9
         k9yUdrgN/aB0GCxBG51te3cqpIcZnFs7bHyMOQD7/1lj2cFSjKcgYh9xTcs9WAFZlvfe
         swyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864281; x=1756469081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zM3/qo32zjBOLvIBZIBEBGO/3GnYRbMH0KTgG3XM90A=;
        b=hleO7TL0nTzCWl50lQqPin7ZwSq4i6A+2idHUg5CvSkuTtdNL521czEaX3z2pbni/W
         6zclYoHNrzBjgpiXU5TQyj1w8/bz2mgC+hSYYieLpo3PAxZVpxH5KMm+VdCunjFMNCKZ
         cZTXIAdQ67sfEZsWHtlWnchyAAFegRlTBXzVWee1U7Hq3O5LavuuW2Bn+6DOTwUcv0YM
         D034gRMF2I1VuwMgkE6CvsJzdIfa9MYKiSuMEiau+SkJ6MZFqgSJBa1QmofqBo4Kpnzi
         9Y1LQY4H5ukV8EAIG53ptqZCfGpwxqt8H5NuPobQ+uM8Sv7tqxa/0ohB6XBwscVYSCn2
         w77Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhxg0WEozCW6KBK1YgMtoxKNXdA90T+KznpjoUsh9wXcYEG2dBCQtTiBDTV0iEk9z/VSYG7b3Vo6T9b84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0m31x2sdcyyuI5z8l/9zXARHNQnopxpPaEy43aqdlXWzYyUZA
	LP3crBsLKwq06yGih/UKegREVMAwj3LtM/lPN37X+dHNclQ71ISttnSSKGWztI+hmGI=
X-Gm-Gg: ASbGnct4N5sKrqTDqTpmAxF/G/ikdmOZzmNB3KhlAn4PYYbiZ2L5leLKFfpZbGt3SKg
	QoZkDvd6fqaqbOMcFdVopvdNVDTf38yuQPDuhSFilo1yC/57u4RLR3pNJ2r/Xa1uFjfucsvKXpb
	bdGj/Nk4I/LrsELsYs2L3F6+gJWarDka5F1DlLqlfx5a4JhnG/av3AHfyn4e5AnPCeNRFlbrPgB
	cvU0bxHdi0jZu5ZvU/6OU6Hv2+X2ssDGDBzKat2dokv9eTiznI71iN6EW9XeveGHv6i5hX6URf0
	2zMw3jOaxo7CvGJwxAFCh2ydFfmpU7XBMRnWWOAZQ+ZfOE2SOoFzeSKXbRtQNdnnu6z0TQjXAMT
	OQJuQY9G+c5Ymuf1mxUOSHRPmFDWtCzGvCMVhK6k=
X-Google-Smtp-Source: AGHT+IFwMiNd25c3zhgrvhAmngDo9FNZRE9nriqcJsOWEo5om0gR7ypTZ1T9dXb++N7wKLpkbtHqWQ==
X-Received: by 2002:a05:6402:2348:b0:61b:6c51:3ffe with SMTP id 4fb4d7f45d1cf-61c1b3b8e86mr1301185a12.2.1755864281284;
        Fri, 22 Aug 2025 05:04:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm6690444a12.48.2025.08.22.05.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:04:40 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 14:04:11 +0200
Subject: [PATCH 11/15] ARM: dts: qcom: ipq4019: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-dts-interrupt-address-cells-v1-11-d54d44b74460@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=SQm20kIaOiWYFBfzGEfwLlwWGDgrofGLefsJbh17LUY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqFzE3OLh7yjsa4aMZSjWDk8pfgleU6y1gNAGY
 zq6hq/rgcyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhcxAAKCRDBN2bmhouD
 1yOyD/9iykAoYYtpeVzhCG0dNW+0mnJqxb2Zt2XvdCW9roXVThrG5Ok8fIgQ+ugiKYMPe7L62tL
 iKKBgk//O1foNODXR5lsXAE9GAkzr3X+M7WzIeFHEEcsJSK0n+pJdgsSqUxxWQygu2HsoKMkm6W
 DQGMEFoO4qrm88tB3DlMlYANpTxiu41zHwX5jUWcsiT6auR558QIQPXbCglxkZed3MoUTScarZ6
 gu34lFeEWMgU4VAU3/9YuMaEsb5w+NepagzCKlp6kWsyzT7BR/RyDfDHjctVDpunEiQW0LQiJWS
 N7c4wlc/aCb+NBuHQ1rLjmQZD3iLY2Vkf3im4Dydskg7eXNcT43vv9Qe5nqz3Hykz2mBVooxEAZ
 D1IQgfk/8KsqkEuzgkCb0hN+z+7ElKcBCtY8hWZGivdlrNLhvCfbg17WHSygo3EgcU3ZvpvURca
 vMYXF3F22CfciBePz21yUOzpCZmjwShSe0rh/1yOh3/bC5rxKz87JmcX9b/G6TGRuYjbeg+j004
 CWdvRWZsrbC8mMyDsUSpi16vVOPCc4WxNaCkiCC7KL9iced6o8gVOPa2hh0R5gngrwi5RNTC0y5
 x+xeA371vCGgdl55rIMXrJNczUCjqYdQ9xiefGwrGZ25tWSGf+B+ABm9b4cDHxqpksYWl4ja0ff
 Q5yUTaJmGdSgu1Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  qcom-ipq4019.dtsi:431.4-434.30: Warning (interrupt_map): /soc/pcie@40000000:interrupt-map:
    Missing property '#address-cells' in node /soc/interrupt-controller@b000000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index f77542fb3d4fc2fe5998aaea092d62f482af1672..5bf5027e1ad98fef92a012fefe0450c5a3df7e0f 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -175,6 +175,7 @@ soc {
 		intc: interrupt-controller@b000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x0b000000 0x1000>,
 			<0x0b002000 0x1000>;

-- 
2.48.1


