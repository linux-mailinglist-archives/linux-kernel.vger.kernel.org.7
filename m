Return-Path: <linux-kernel+bounces-876554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32991C1BCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5007666E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1414B3491E8;
	Wed, 29 Oct 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEXx2Iv7"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3007345756
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752470; cv=none; b=runkGF1gjktciEA7zoUQpFdUufiUXrWAQrJd0e9UMUT0838TIyCMa2uO8iy8jemZBAZo3N8GnetWY9mnE84k2r0u7+LkLY2TBBCcxrYX9UnTuk2G7SLmrbJ7dS7Dngj2zMfXrDdUVkfsSQi1G+l49li68AQzvK3ShFqwef4Y3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752470; c=relaxed/simple;
	bh=jcD/muh/yg3HFerxyFZxTqkuolBzxrZADlEk8jQbDjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nIDO8LmG1OK5AwkSjEfm3mxup2UJ33JE79o73yPFvqxMiEXNorUoWT8lNRQx9RBukj2My6eb+tVWDO2Zvg0dEhmJMFbD2faT8Ee2Oc6wsjt9cGLPOYsa1Zkx6bCoFlTKg7vq/ptOMaALLmUl6COvfR7qeWeNaIWAcL8UiiSF5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CEXx2Iv7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4769bb77eb9so3107315e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752464; x=1762357264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB4XYlUY2JZQ36hrOiaGPtBE9KxSOxOkBTNgx+iHCVg=;
        b=CEXx2Iv7dLxz/Adf0kZlWhXsl9klwAKaYYcCA2TXyTnO9SYTQupcnYVoe1I5bngy6t
         KI4KlzKshBUr4tGptunz0Bb3G7avRHiH6OINZ2WF+iS4jei8P16Kqke2OQhlqMa6H0Kn
         KS3VDc35pRA6QnYzH8OHmbGHphQsRSbq92sGNdhQdZO35m8MYO02RzzSUcVdNP6M+AEU
         h3x96OUrZzt9ftR7vhGmmfMBN9T4OzL5sWeingZG7ZFtfC9Z+VxBDoIEE7RDHWWCXiKQ
         xYBZNpA604RjM1JWJC5U5YJL3h3uNAq0/G8pDuXedk6q57ByLD73/u+Wp3J5VXudb2td
         w13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752464; x=1762357264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IB4XYlUY2JZQ36hrOiaGPtBE9KxSOxOkBTNgx+iHCVg=;
        b=SCc5uH4474BwVjzzcWHEo8SZkfyfG/AqTrZu/AXTdplqFZ6xguFr8WYFPNk+uK5zw3
         MKP/0CkVY2YAXwbdYxnGG4IuBkKQNwTK1i6lp94CjJJYAENQvJq4LkeAtF1f5M0eh6gw
         sgZiCIZehsBOQbBdDovDaOaHJ3XXGXMNxnENsxY1+VHSAW1DC1O5XvDsMZacPuinCEqK
         IYHmgukW3HN/MqoRF942NiMxGLa6tnneK46G26LaDtUfWmyks+A1PToxygSQ9qRyGNiY
         0R67QiEwnEHgN33lFyFhHMbmYL6IgubNq/wAhp9xCmoCjBf18PNM8sOIj30VUJwloziH
         r7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTY+jRSJ5+Xq5wLYUyhS/FA84G0O7ifjhnXniXFdDDLxe/MuIgFYYl2r7h+opAZ1PtX8bLMr8ZSEeMvkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqda82OGqKfq75yquGiEOxBmTPbl44olb9rqiU2v//OYQdqQz
	vgDLf5+Z9HRuyEhQvd9D8eQ/plFxX9QnwUyPk38HGhjuUkauLZ/FA2xzdowI/6U/XU6Bh/VHBaV
	oZ1T+
X-Gm-Gg: ASbGncsEpk7PyKPeG+qPOAF1XZ+y4v2cOfG1xYLrUk9yuq7T8q9C39/qFKQ6q0+rg3s
	u/6feBUXFIZ/1Yx+9qMyHkyEijO+BlQdX47DqY62c7x1Ci71hOEcr43cQ+IV0tRbpBdKxdU4Gm4
	qW0nIo56UpiWRwCyHzBeIwu2PkkTKe1sN2fPBU/ASDjfh1GBNr5BJ4y4W/ALmufP/aZTacEt0hd
	xZM/xvle+ASMZf5Ri/qttK1qLTI9ziPJqVnEl82/MY60fsQkrc5a6svgty5Pnaa8JLFILxElDlz
	10VrdyuJq9IUyJZI0jseXuWYkbzDPUZCcksF1uGrTzYGHamIemn1mMds643OyLMXU2NXx1extsV
	d4RqCUrCE7X2TufXT1nHmtewvcjHM5hBND4x57fF3rHq4q97xfFy2bEQUqxseVP7wK+estA+mv8
	CWcpoVppVUk09DjRux
X-Google-Smtp-Source: AGHT+IG9DjbF0EUlFUTGru5YaWEbzqZRQ5rKxmL+Dczniu/qZ8YVLMUMQrhXAGjSZsPLoQbulsBrFg==
X-Received: by 2002:a05:600c:4ecf:b0:471:152a:e574 with SMTP id 5b1f17b1804b1-4771e16e538mr17553815e9.2.1761752463973;
        Wed, 29 Oct 2025 08:41:03 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:42 +0100
Subject: [PATCH 5/9] dt-bindings: PCI: qcom,pcie-sm8250: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-5-da7ac2c477f4@linaro.org>
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
 bh=jcD/muh/yg3HFerxyFZxTqkuolBzxrZADlEk8jQbDjE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWCdRkgSj+crNTt0ZPf5p7k3sOTszyclpDbU
 1o3zeCn0G+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1ggAKCRDBN2bmhouD
 13d6D/9i2r5Li5azvJiuPvOaq5bhZqUycmZaxUdiWiryjuPm7d3LEylVeO0glrT3h1lLvjxc66v
 2W9bOdT5RWb69wU6RRyFm7l7/pOmNC79C/zTHVypzzUIKbV1R48cbGg0MdZGqvyjcwKNgIiwNJI
 jjUfhRCJIfG0snC5pDqO5KNYUhH0B6IpC116cuoMLto5wr9wq0ADXkkXp8nBq175ACmXY0/s7aI
 Ht4DbFEmBtNwNq59/bqWeYHw6V9R9jsmLOBXv9ted9vsuULuuIW6JvQ71EVHQR/K/SuDlElL2z4
 eahFimBL9xGOnkwhizjnYmxWTFcNz8ZUYikS64Z3IZjs/d2sq4yhOU2aVMs/IcqHNgKe2byTbiB
 kl+TUgFUH+X6Hu/CUrqf/5nx5Z4IBCo5OPTSd//JIey0eaUSyBkeZAM0eBdt0UVBKRkH4rzX5Qk
 w/u58DwGiKInGkZzIuQBIOaKLZrPyZRr8kw8zLGQ6cvgezmPyq9biYlM7s3I81qEsx3YKcjN3Tv
 FA1Q4eCrJHNR0aPL2j5P+XdbUDyNUQXh45ngocNiXvkreTV5t4vm8BNYGBGS/aGrMEpnl6lBLI4
 JgF+IsBygKmMunPMjGg2z0SfP+wQSdzePL4iQEQbvVa0DYqZh3aFLRouuDyYXMl4PNkrDz2m1pQ
 THb2JVzFbi89lEQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 4891b66185c1 ("dt-bindings: PCI: qcom,pcie-sm8250: Move SM8250 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
index af4dae68d508..2ad538019998 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
@@ -83,6 +83,9 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


