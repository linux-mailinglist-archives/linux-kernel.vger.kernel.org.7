Return-Path: <linux-kernel+bounces-883200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2FC2CBA4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0310C4E82D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2FC325499;
	Mon,  3 Nov 2025 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BQW/6Q8B"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D41314B89
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182900; cv=none; b=DItRymp7wRNB+QBbyqbjnJRJbD8aimExI8iKkSqaJNftp2LCckg6PCiSiQIBGk015di8rR9GXdaweFt3a4hZqp9NXjWJUbJK9YTKo8CPDVXBY8hb1jS7rhf2hHx5DW9ZV8FbvzYIoE110R9PHtLOvuMSEPVeCxNoqAACzClE1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182900; c=relaxed/simple;
	bh=8NBFLjzMEgjTDyxAIQC0mdB6Oa7ms21UQ+blpDKfkTA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RQQ2lKViVIlLSdfcA5CgoKQG/grFOEYmSWsmuzhM7wsBwZR0q1zTKZIg/QowEzOieOqrulWG1vnFim88VH8De713B5ik0w0hzub8slIs4JDWZzW+dxspo8SOECFu707FN7edPHCtFdCm0wYMJ8KjEpSNALOvpsFL6qncwAMMTyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BQW/6Q8B; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b70b2cfc032so7856266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182897; x=1762787697; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGi4/MumABrJMjqvBNuWbmBgVsY5VFid+04xGbYF4nU=;
        b=BQW/6Q8BCVStHUZL1yr1fIVexirXkOb78K8WKxV3UrUy8uHfQ4LV1tpVmR7c8Pj/To
         86C6CW7mME4Svm9J4HsE2VSQrbtiMMgoWPZUxpvWVd1DDYd2kR7cGNE0ZAUXWr8Sw3OL
         Tw7it0JyQBIW9WNtuMTWqvyagmrMBpCpgayCyiYeSVyNxGQfgF0KQWEA27373LaKrVC1
         6yh2es0JDRobtw61VUi/TIPIgsQCV3dg1gxE8h3B9fYedRWo0fmo2GyfZw2eQDs/gOCR
         3HDqayLcX6PTrKDyg8nz/+ZW3i05K3FDFWmDdeP1LE+ta/lrkCIYcFDmHS0TptgMnT7m
         JS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182897; x=1762787697;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eGi4/MumABrJMjqvBNuWbmBgVsY5VFid+04xGbYF4nU=;
        b=birBGF4kfeHESZb0c6nzhKIImrrMGoKAhGHC+k3JeBt3XlILbsWqlVNij3tkv2T5jU
         BCTbnaM7XG12QN9jZ5YguxltXVYfo5wvHEx9AhTfRHQ9xve8mkuN2fJFMy5AIezKKEiS
         OQiJX14RYSFa+CYKT2mU6ab4qLVMdommH1S+YIz48lzzlCbyeisO9mF09bKbZUrA9+He
         42FQbkvKsfoypgq/CLCdM6MJFHHlp5304LssGCUiVWEcXpL0rb0/8vVfOl2RrQrQ62pO
         7vtz14urOVI+JDeisZx7ZlZ7Y4F6bLrABg3lS8GAHWSZRD+qF5YhtxLDZWO2yk9uPpCq
         ku6A==
X-Forwarded-Encrypted: i=1; AJvYcCX5ntRZi0ZJxjoENpmkPZrarQvCMSb9yLEhFEOVFZ2pztmhGhLyjNFvIMpiSIDLAsicEQLpWVvsgWixPC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5LbxiJQJt+6+w24I7LPsbrtRjhk3Jl1fgSCY0bUDnoCKSbG33
	vyLlWsR4eDxHV/Fdq8L4Kz7FvzD8/fhePmyomCvEK6zk4DmP7AsNeH0Nm7PshYa6Z2lbcn/un1D
	LXykQ
X-Gm-Gg: ASbGnctAuU2+7Cs0GvjjDJ6C2mLVbKoA+cZjFRouEZmFfXRUePNitOnReUapwN9obqC
	cMQ5kJlf/8kLJ9Oex2uUDvYfoLozCg8m4YyEOc5GhjEsYGsEmUECJpsi3MZQ+OGuZpD0ECsRyPQ
	T1+aI8wrs9ZZGgkVaUy5ThOTwFqUuRfZLM/gz1bXb/0pzKrtB1i4MvCiiICiwmWPO8aj1IRNI3s
	f87QT778LzyvaUhzeSzXklXV3Wqkvi4eilCVTL2O0eNQ63WgXigwyrdKK92YZj0laONrI8qmeKu
	QYw8QaK392gYrztSh1S0Y0jA6GAKE9h2/ezTiV3gI1DgD4wu1TgXNaMh4WesvzLqmPREzuPJG2/
	TBLPzoeGFQGoVjNsRyCYZhakclShjAeyP+oNmxlZg3eCtkxcYbCkl59s3cyg+GOEkjji/GC1/pv
	flqhMqLfoqgYFWOLmX
X-Google-Smtp-Source: AGHT+IEt8D2L4/c6q1jdTDxYKJlbkQpEhxwOFjDzoJ6qunqS5xAMVH0vozm3Ngjbg+T611/Y2L59WQ==
X-Received: by 2002:a17:906:f9da:b0:b70:b6f5:4239 with SMTP id a640c23a62f3a-b70b6f546e4mr200213666b.3.1762182897081;
        Mon, 03 Nov 2025 07:14:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:14:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/12] dt-bindings: PCI: qcom: Move remaining devices to
 dedicated schema
Date: Mon, 03 Nov 2025 16:14:40 +0100
Message-Id: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAODGCGkC/x3MQQqAIBBA0avErBsoMbCuEi1ynGwWWWlEIN09a
 fkW/2dIHIUTDFWGyLck2UNBW1dA6xw8o7hiUI3q2kb16C60EpwEn/AgwZP2DYm0NqzNbDsDJT0
 iL/L823F63w+cKLA9ZgAAAA==
X-Change-ID: 20251029-dt-bindings-pci-qcom-cc448e48ab58
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2392;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=8NBFLjzMEgjTDyxAIQC0mdB6Oa7ms21UQ+blpDKfkTA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbjt3er7ucG129PkdA5E8TLG29nLG+vnZR7D
 FnhP5yHZIqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG4wAKCRDBN2bmhouD
 1y63D/9Avm0LvO4w9yYE/ebFsc+SFal8QNN9EOvj9Onab7bqIUuXswJh4jSHnZIL9O+WP3XqGAH
 CypktuH1H+6phnXh/FEWgzjHg+xlLWB8hcQNSSVDnDhlZ/fLyN4e8dRWbaMgYJSOf2Wg66jhsPC
 jDIy6gjxc8D5O9aHnrXH1bZxRAT4U87MGWkDiaUQG4hGmJad80rb1KJdqDkbipf1qH+VjfpQLcM
 1DGT40+XbLt0w2hxR2bRxP6lhfORQUe4BRpmmGeabenn6/KDPBTLT52nA0XccYOvHIKl16Nd3nv
 zRfOspsR8OtjRr2vJ+mxaZrZwhvgFNOJ8ftagWprDSuBv9rzGCxakqV4BuxbN4JyDu8HrGygCc0
 6sp06nz/MS+MtHQBMCegd4niQTKrlHezUoa7N457fU6zM9LPWB5RnO4P17k2CRcjgAAIbXqaqWN
 qA9uXE0UYOetER3cjGZi77ntvxGeJYwMIJa7oiKW35fP26SR2jJEZTCToGgMhx2/E30h/dxGdRx
 zff2ZK4RcEpEPuD8d67ZlG5K3NzvCxqTBwbqVOMstonmyhlbUYgMBMSe3uk+weVAcqWL0yAI33n
 1JneDZXFrF4kzL/DiIsljKxLvN8QtNZzrGpnZL/XuPfJbYAtAEQ/KgB8PpM1uWHzg9upc/tB7pq
 R7ImR3USL2MNCgA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Some time ago I already moved several devices from qcom,pcie.yaml
binding to a dedicated binding files for easier reviewing and
maintenance.

Move the remaining one which makes the qcom,pcie.yaml empty thus can be
entirely removed.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (12):
      dt-bindings: PCI: qcom,pcie-sm8150: Merge SC8180x into SM8150
      dt-bindings: PCI: qcom,pcie-sdx55: Move SDX55 to dedicated schema
      dt-bindings: PCI: qcom,pcie-sdm845: Move SDM845 to dedicated schema
      dt-bindings: PCI: qcom,pcie-qcs404: Move QCS404 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq5018: Move IPQ5018 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq6018: Move IPQ6018 and IPQ8074 Gen3 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq8074: Move IPQ8074 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq4019: Move IPQ4019 to dedicated schema
      dt-bindings: PCI: qcom,pcie-ipq9574: Move IPQ9574 to dedicated schema
      dt-bindings: PCI: qcom,pcie-apq8064: Move APQ8064 to dedicated schema
      dt-bindings: PCI: qcom,pcie-msm8996: Move MSM8996 to dedicated schema
      dt-bindings: PCI: qcom,pcie-apq8084: Move APQ8084 to dedicated schema

 .../devicetree/bindings/pci/qcom,pcie-apq8064.yaml | 170 +++++
 .../devicetree/bindings/pci/qcom,pcie-apq8084.yaml | 109 +++
 .../devicetree/bindings/pci/qcom,pcie-ipq4019.yaml | 146 ++++
 .../devicetree/bindings/pci/qcom,pcie-ipq5018.yaml | 189 +++++
 .../devicetree/bindings/pci/qcom,pcie-ipq6018.yaml | 179 +++++
 .../devicetree/bindings/pci/qcom,pcie-ipq8074.yaml | 165 +++++
 .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 183 +++++
 .../devicetree/bindings/pci/qcom,pcie-msm8996.yaml | 156 ++++
 .../devicetree/bindings/pci/qcom,pcie-qcs404.yaml  | 131 ++++
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 168 -----
 .../devicetree/bindings/pci/qcom,pcie-sdm845.yaml  | 190 +++++
 .../devicetree/bindings/pci/qcom,pcie-sdx55.yaml   | 172 +++++
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  |   1 +
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 782 ---------------------
 14 files changed, 1791 insertions(+), 950 deletions(-)
---
base-commit: 503fcb70f99075032f5bbf528cec4650cb7dd7d0
change-id: 20251029-dt-bindings-pci-qcom-cc448e48ab58

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


