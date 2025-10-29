Return-Path: <linux-kernel+bounces-876551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D39F5C1C129
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1EDAF566C90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7274333B6E2;
	Wed, 29 Oct 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VI0p/V9v"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C9D33769D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752463; cv=none; b=QUn6tpfB+h4fxnJVQIEK8JRopTWqBgP94IIM9ZM5/0519YMcuNkqAfVGQ+V3MWAxo2NiVep5BGndTP+zMcBXiY+CSNp9FsIoGQjGOVzEtrCTCRKFYuDTXxrTq9N1evIc7h2pCJbTuEb4WQP2lPIFt/3Cs70a3/i2ChrlFAYbwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752463; c=relaxed/simple;
	bh=C5fheZMBlXveADhbIuGHjBBUwZi8+svZZb3r9XyaFgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UG09mecpImGOTfq2quZTpmUM7GNv2eJo16WPbPBU0DgyyK0XduK0kVVaY/FJ59Mxv4rrRAEFFM/h+kjDQZm8nRxd5euqqdkC1Dmg6twriSrkiOtUPRkhqfbCiggWijysGNTMusOtkVB2xUOWEiRCbaozXWwkU/Hhxjf58E9eBFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VI0p/V9v; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-426ff579fbeso896900f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752460; x=1762357260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHf+cMn6Kxy6WzhI5tfMdwjUbyEZvfJl3wRfjjKCl04=;
        b=VI0p/V9v98EGZn5H6JHrfUHp4apdEKgO8ZGVJkNihExh/sX15+MILGJ5We1GvfDypc
         6FAb42QN6fz1TnvsWHArPl7/0WgpgkUvqiBdOQ4rW/D0KOgCcvRFqQnEnuJvtuMIhjX+
         wa3OiQ4ZUgv9pXdCG6pcY1vgAqMC7bzPRbaM0QbqLwiTofwhZRKjnrCHQV4kA8dFbuqW
         UrjTa8d1yzQJyzCMo2V831Ah3+s7q79foba9FOPxUmwcy11cGTvCtmeugswZn4YSC2Ay
         X2Plc0HbfoRRqss9lxsbQGrWbHLmFAvJrCBjt+UoyTqErUaGG03H4fhSVUg0pi7w54Ei
         Btwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752460; x=1762357260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHf+cMn6Kxy6WzhI5tfMdwjUbyEZvfJl3wRfjjKCl04=;
        b=cQcGO6YgafJ0OIN//U7/TwXBaxmjDKzGYvnhrdNMKP+thWlTfZ5QTVCjE5STKIxsoP
         jAJECAKMg+KJERVe76g3ezzmQotlRtaJHmAb4nvK83KsNEQSiFF94sFFPvQaQVq66mQp
         1x8cf8yF0jVqcpXa8RQhYfkmREghk2X3CThx7MCyweRRH6rGgDmqRque0ahMm9bYoKEh
         Lu+zLGB379263GFNGYVZG4R3EMI7FNcp5o3XxZGbp1NdoGVtiLcJOzfRGWhjhoMYoD8D
         RY24zkTHcF4N5P3DRN6BTl7pCMl2MxO0NtkJ8ASN23yZVQK4lEK+zEO9lLMn/EvzBt+V
         ghxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6PFdiy2wQpQd+tOXgHZQNq7o0yF9qDFcWqazgBI8b7jx7Sm7YTgMLEiTeInIR80//6S1zm/d9gNw3lr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqZFbuJv4wE7TSlQ30VxW84f+jityrzWn8MPphmx10J4cUUkb
	EQJFFqvLuyP0XYuCDnXNA++SYrQODdeQ5xXClLEZMowProzdXB3/9aZmpdbV/rwZbg8=
X-Gm-Gg: ASbGncvQy2+Ahc7acrREv4HbdVHptfAqrRriFxTWuKKIJsn5mvndD+ZbNBGqZbf9ouU
	X7bad+WxY8svoVReJL7YqQHCDkZilGSBB35yBXkVd1OnqcWRiIg/sy1oOfUbBBqTmLFhUbo4OJh
	aB5L22mIRhi2jqQevttSd2ET6HXTI2E1YilyeO4hKDZx1heTtjRCz9k+NNRXsyhHbkiptQivi+g
	LoA6gIG1pMbsRa7iTVsoFS4gHSrsLh/ry/83CkLqI3zC00uqyYQJ1ZcOEPaMcSKoF89pu5D0AGC
	MoaTFB+GDIx1Z9DH6B32iWGe4c8pxr1oUKdi3RvcDvNzFPXvM/aCMJQOIvV7yu2gR7njhqAFSxE
	l05w2mTw8Vpok8wz10S+q1tcXMv1U+0WNRU2JNwbrnJSMDEOUePxXlpVEHaPDy2WGB4fThnHIeM
	ZJ8EMvDBqs0lbJv62A
X-Google-Smtp-Source: AGHT+IHwTcSdwYOPG6r0415Zk++YfUcU5yMqIL3/VKwOKYxZYrAgJvqhz956H0VjSJ5yRA+kTI4Y/g==
X-Received: by 2002:a05:6000:2891:b0:425:6794:f19b with SMTP id ffacd0b85a97d-429aef80d97mr1719532f8f.2.1761752459735;
        Wed, 29 Oct 2025 08:40:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:40:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:39 +0100
Subject: [PATCH 2/9] dt-bindings: PCI: qcom,pcie-sc7280: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-2-da7ac2c477f4@linaro.org>
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
In-Reply-To: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=C5fheZMBlXveADhbIuGHjBBUwZi8+svZZb3r9XyaFgw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWAt2He8JZrv/2UagbsLKx6hiqQ2Hf2ne8uq
 b8GbzFp+LGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1gAAKCRDBN2bmhouD
 19jkD/9Y7Yud/iWVjUfcttWhamndLFmOnwuyiuZymgw1con27IkeBHVSMvkIBdLuyikpuwWc1uW
 +Ec/O5v7B16bPf0jNppNGhvRq84rLdPVWIH66HBXdEhZ+WGrOPLWjbnR7gBu4z2ZNFJvb4sAENE
 Ceu2rWZ8Xqxusv1uPK7vgQdOyfh31QZ11tfdgb0vMnvJDX3bTNzW/yDhH1KUKMSGk+8sYtaMkiB
 p1a4+FLqpui7RYHuNhW+TShdrGEJNDoxzvTgfDKMq0jh+2VZcpgdRNY/u9f2HwvdGdz387YFUbj
 Cb9Baykvgu1ObF8OOCsX47JP/2jpbISUcqLcPXZIl+kbT+mCBo+P+SkpIjA1YFXJCmVN+JRQVGn
 ItnuHF64n2Y34BTJHGmd0BL6TkgBCftyiOvvac+k6tvcmwZljxTtZ2s0So3wqNHZlla7wgZQIHe
 NZc35CvS0VMLAfC5P/Pgd2XNo1F5V6kF7hgCmZYZhvMuBm1nY0vmJLG2R7aO43J2zXVh1AxnMOf
 HiuypfkdNcN66zEdM4SvtqATrEsym3Nr2RWO7AbQRkKmy2z0+N5lybQBPhq4iDkLl1MGtfVWNIA
 UOj7R7uIgkUvPlthOzxRVr2QqZnDynsibJjYcWKElIw/h7494pUE8qoXrN6V13ggDhqdKiL99jX
 9nDVLsO4TpIJJmg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 756485bfbb85 ("dt-bindings: PCI: qcom,pcie-sc7280: Move SC7280 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
index 4d0a91556603..a2e5755855aa 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
@@ -76,6 +76,9 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


