Return-Path: <linux-kernel+bounces-876549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C492C1C0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FFD05C231C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6B833B6DF;
	Wed, 29 Oct 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psXYPhMk"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42E1336EC4
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752460; cv=none; b=BsD+XG/pJ9xNu3ZJ9UktJlaU1NG0I9og8BSUiGQc8ghFe3rF64OLoN0Q+JcUJr8171D0ZvFvAQqhO4ay+6fw01AULfnyEirRkf4Ff4w2Bqm5ueWr6ix2WE2CE3fjYVW2GSVsWq3YSlr9lgvv28UpVjEnnMvEPrB3+htfx+0oSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752460; c=relaxed/simple;
	bh=XZh7Co6zslMBQjbIXCr9v5B3gCRv9boi3KNiCtrOq7M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TMt9G329wrOi2MM2IOijzl7LSm9+vtW9MPxRdN0g/2RSlMLvmQGhIfqUxJmx/znmUSSynpiV2RtZ3u6X8hc+DHtnXfO+7kiNjrh1VkPYox8OByLEGmHxyCEGMek5Fl01+IhV7kl0+N2kfla/0FthZi90H0S7lMCyT5kRmx6uVlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=psXYPhMk; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f4319b8c03so888251f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752457; x=1762357257; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YDt91SNIDyuEo7g1pxTkmePyL8nY5ebc1O1twS6LBZ4=;
        b=psXYPhMkUm5AETXhX3qqViCknno+TxnmOPaOsQKdBsoy0gXVW1G9PYXh8GesS1NqdB
         E8a4BzC9RwBdsng4jmXlewiadSTA+rmg9Bs0HrxXAHWOA2pGNO7z9JeQLRoXjsOZIcTO
         GHcWPdtNO2cijUIcJMdLv60SGhyF0OiiNyycf4zVtzP7/JERigZJSTrllfCSFQbN7spm
         AyghfSdJoGR+fV1pT+E4E669B8BdbQFhVtJGx4OB43RAdcCSy/Rygbgflw4JZQewuutU
         hlF6iFH31p+HonIxeWYQhFTn/SrV0qUfKodCw3oaeSz0d/KOloeX6jvclA2aWkGpLAjH
         CQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752457; x=1762357257;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDt91SNIDyuEo7g1pxTkmePyL8nY5ebc1O1twS6LBZ4=;
        b=tDYwDqgSHEyPMyWQo2MKfSfRXpiAmMdnhziDG0Wf5eH+mDGNdyaPFgXfAHLllQYXxA
         5cC/+0EMCj4wx9Zzw3zbt3ZktbrRS2/6IsMEklK9HKNabna5cQMmf5vZ2N6r5y1D/GIh
         f/ax6EGXtxpIV8A9P2aY677mtKnqp1d3bhWZWtuWClmILwEZTloekKt8uAmw8PW/Ukwu
         QGjgP911AFASlGG/+zJu+tGMW5E5lvRvNJ6/V8TlRgiAucWRlpc0VY2Y+Y1iH6BbI5Vf
         02i0kOhv4s2zyWIkPuezwAqP+6Hj8RrSP8hpES/7N9W92iQpEaIkZZ4rjjQ5sECRYIlX
         of+A==
X-Forwarded-Encrypted: i=1; AJvYcCXCwySyOoYHvxNtATWTo7lG8aNgVJ6S/KgW33yu64kNRIH4lv/8kZFK4hzZsJS3Yy16t1E3So3dB8NuSs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyord4AeQpvxhxjBgRrVzpOhhcSdk/rTHfMZ5E6Qvh7SWbvZKpk
	MRNxx9kpaq1M26ULnMFLeOj1ktAmohQ+hcdH+fNGOyVQuDe1ydxgEHoI1Wkom6Bizks=
X-Gm-Gg: ASbGncu+U3vhVmbbkmZGLKFrvSOAhOIjjz6gcFUp1sECWbuhaZ/d6pIA8c8uhMvvpHM
	ynjk6v1krCF6Rs5ExpZNqEV06f/GSBCBuqSu/SeEMtlr0Xw+EJ1DJK64nf/RvRBzDyodALHYCGJ
	iFMc7Td7LO95dMiQNXabufGJA2sLTRhT038ta0HPlyYA1JxSSUNZVZaACYQtO/SV9SrAV7QV10b
	nDbENMxvsty4hQX+vxZAZR7f1o93zLHwOxTgTXzActW0e8rM8k0riPXv+BhGQoX3t2zdpNA7RPt
	LqMsTzAe1RWJfpxfmiphrt/s3NZjxaoz0w9Z5UY2B8Ww9gkE0lFboSUIabc2lXQon3MjU9xqI1K
	MAmwGvMxAWdl5suuPwHESibL8DlH88sFPjFwnAwZWTscWhJWOjwa87SFeL6x3cf86FN+iMHiDeJ
	+zmb+DxVCzU2sjgEfa
X-Google-Smtp-Source: AGHT+IHfW4idvTSP2Ah3w6TfkGF/17Rr24+yasDsIjDvlkJDa3pwbq9RzRK1P0QDGji5PJoM5iNpwA==
X-Received: by 2002:a5d:64c7:0:b0:3f3:3c88:5071 with SMTP id ffacd0b85a97d-429aef802dbmr1640035f8f.4.1761752456995;
        Wed, 29 Oct 2025 08:40:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:40:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/9] dt-bindings: PCI: qcom: Add missing required
 power-domains
Date: Wed, 29 Oct 2025 16:40:37 +0100
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHU1AmkC/x3MQQqDQAxA0atI1g1oigP2KqWLcSZqFmbspLQF8
 e4Glw8+fwfjKmzwaHao/BWToo7u1kBaos6Mkt1ALfVdSwPmD46iWXQ23JLgO5UVJ/mzs/y4Yi5
 rFDW8hxjCMBJTT+C7rfKV+e35Oo4Td6w/QHoAAAA=
X-Change-ID: 20251029-dt-bindings-pci-qcom-fixes-power-domains-36a669b2e252
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XZh7Co6zslMBQjbIXCr9v5B3gCRv9boi3KNiCtrOq7M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjV8+rRwsh6mtOgt9cwnJyDBWBR90T9DNg1e/
 fAEZX9j8aCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1fAAKCRDBN2bmhouD
 1wxlD/0eFmxwUES2BznztM3ZTBcUo2UEJN5PYuTkJgH8y0sWSON51yeBBxwTK3SEA4IYe+HiQTQ
 i7Ms7eOUIjsmTT4/8qYW6bt/BCR7ZLULzMzNpfrtLfWJzqZCGzoj1fN8sPINtmo1XiO8V3ks4Fd
 jUB6qp1ldl0MXpWwLJzs3ck8JP6GueflzYZGH2Tq/IRLWLpTtIgkwL3Bi1qNcFZMeglCtBWBGkQ
 eoU18LISRmP+hWNrjaqKs3aA5Dw+YJtfouNyEdcvTmqtDviwV7rv/0H5oLQfARllF+2Gf0/Trnw
 PNjCqQSHtscaKZ9E5MJvCzjkcIZ+BoMq2A7GovFhWcLoMOdrfEBVA/+ROS+e3SJnAHYr/rwsqpu
 xNQfCzkurb2KyIYNwgsQKOrzJtEnbmN2ozK7k692z4hBWDv2c73DRNxPSmplr8i3AucNs38EZuB
 +WXhq7A/96rRaOFHAqCcegRt37R21Nn4YYmlVVbLgmyNhkYB8wHluSrZhqCLuV+jhuL9yapwWN6
 EQImQRMwkuyj28c+42uISguJX/Fr6tl9LBZ3dn4NAo37lKzfm0Tw519lZizr+e/jkL13elDA0+2
 I6VmNbLlSk88QQxlXXo1KF8r7FrRfrFKbh1WYryLK7xTHr3Zc+6iqI3BDcBl9KvI8S0yIUbUQ+k
 uToJGQdKF9rcLSg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Recent binding changes forgot to make power-domains required.

I am not updating SC8180xp because it will be fixed other way in my next
patchset.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (9):
      dt-bindings: PCI: qcom,pcie-sa8775p: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sc7280: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sc8280xp: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8150: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8250: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8350: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8450: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-sm8550: Add missing required power-domains
      dt-bindings: PCI: qcom,pcie-x1e80100: Add missing required power-domains

 Documentation/devicetree/bindings/pci/qcom,pcie-sa8775p.yaml  | 1 +
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml | 1 +
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml   | 3 +++
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 3 +++
 9 files changed, 23 insertions(+)
---
base-commit: 326bbf6e2b1ce8d1e6166cce2ca414aa241c382f
change-id: 20251029-dt-bindings-pci-qcom-fixes-power-domains-36a669b2e252

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


