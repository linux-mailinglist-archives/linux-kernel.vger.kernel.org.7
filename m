Return-Path: <linux-kernel+bounces-812314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBFB53620
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E73188C521
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F713451AD;
	Thu, 11 Sep 2025 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HyUkSf5y"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF36342CB4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601947; cv=none; b=kgqUFXPHhrh5Mgx6IKfGXWeYRmwwS0pkMNiPKEpR3a9ylTfAjpeF/TvHHfH4k9oEbfWeGy+mb8zzKOqXfiymK0g7VffZc1Xhsb3FB56sQtDlpwJ5NTu7Of5NxWnKyMRwRhx2c8GOf0/JyuCZ61jkvpGySM5Jbx8fgKt0dSRrUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601947; c=relaxed/simple;
	bh=03YskNZLKf8OhvkKpOjLnPHFdGEAsbxR+ROwyIo2lLQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LGiA9aKpmrpkNHpPJT6w0QDeernpRhI+ZoeXEcG/5OEmIJ17WDBHKAKV8U8YlJWE3pCy7pvWXiKJw9OtdGFlHmPzC+1QxvYD7cjvRSDL84XLNS/6nAi9vbRdMtMwcirBrIaghZxrukRxDbdpqLzNJ96P3WCW04UMqvvLJs0e78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HyUkSf5y; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b078aabeb9fso133018666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757601944; x=1758206744; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TmaovmcheFOmFnp07VWNh+ByfgZPGvN3Mt5j2vCPIc0=;
        b=HyUkSf5yzHGNNcQr2xsccSOQygQc4M3hiB3CygSqa+LzQJo1ScEa6EVlso+kkRs4Hs
         YoqKGwqKtr127x1KU+pRKtHwGRjZjKNZxZKJIRw+OnjcoiWl40/zjwEa321h27GdAklS
         o+ZVKf5CgVP4360f4fNnFqBGdgNdCzDznaXLXBVGO1wEcWKNw1yUQYLpD14epanv2+8J
         UFmWLFWbOQNlFDjfiR4B7FbkRe70XbHVg9AHqNVfHlFk29pdjvj4OkQKURJRunUVMKe2
         9lOInqAPNoVsnDGXWp4NxdqJl8Ocb4mPmYSlEqv2VX+aJjfHm55aTPyMt1agTiiENwm8
         2nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757601944; x=1758206744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmaovmcheFOmFnp07VWNh+ByfgZPGvN3Mt5j2vCPIc0=;
        b=PhUq6WvjD0nTH4l23SyWOEOoaxEDXP7i/HUZJw58lpuQnYhNtda0zuyn+YhWR8APhO
         XIRsbpXrC+RcJia07sAvKNoC7PG5B5G9GUdyz2NJVu9ewAWldouexuaIl8ArKiq/ydiA
         5yNaFkzi8Y3k//Pl99C+H+fdjNOepD/8v695hszp3KPYbjjQGP5gWTC1B5+OSQUHoQJP
         OsbT78MTz/+2zeSTPWBGx60iTsknNEmwYhX6B1e6k9pnbVv2VG4YWW8FK+8os+p6gPP6
         9gHS3ZwemTEqgQf7N8T1x3XGktgsN+gmzsUq9wdVcOu46l74X16wsTP+c1gncw5WZTWT
         FvoA==
X-Forwarded-Encrypted: i=1; AJvYcCV5wmgvz0BTL+2nGMDSOgcYiuMJDRgDKxHXjtgfxcukAIx154DHbPaO6Ne+JNzrKklSiE3dpg1N+YGINbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQd9WjG1Zha/YxmlYFRTI4FM1JljaIkBYQinWIpfr7pYt3YxI
	Ubup7hm+odAoyP7dI7fvY6yuKrjgJhLMO11bEwdBkM+/qXIaQZGfq5t4KJUM7dhliis=
X-Gm-Gg: ASbGncuE2TyIHKeC9Nhouhd+l1KWiDmGnFvPNxGcuYACOyPcdy1aIFt5ktlsL3X3GgO
	wqyy4tIQOe110UAzhld0TnoRo1RIeOlAaEDnM3jwRP9SuxoD/dP7F8WnZxrDh1FeUCS/GeDPbPq
	Q3WGTChlvvVfdMfAK1VjrdezG0zhKuODrSpl8/brK9eVAJAV6GyjMmfiAReLDzQ61wvJtqXc9I8
	hK1Ex3NmKM0P/jk3zfRY2JLS+pZSOr0/R5DC9mimFnEOlxeJbxIJyxyB7MJ0IvLvImXVPwd+Aba
	iQtF2hnTQgcn/y2TOWwUldh+eC+SfX3QFDbac1lHBMBlQeSTSVmExq1JhGuqqINVAqFoG68YonM
	HW3NifXMXiN2JYYslT9TxFnrVIuii58ar6btEwd0Z96FI
X-Google-Smtp-Source: AGHT+IEMGu3GJ/3a4WGqg/zWMK0hDQtQmJ6Iryn3J3JjlXUMGe4FLDan/R6dvlN1OT4FB+YPOlnyAA==
X-Received: by 2002:a17:907:c921:b0:b07:8894:35 with SMTP id a640c23a62f3a-b078894027amr514662266b.27.1757601943851;
        Thu, 11 Sep 2025 07:45:43 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31282e7sm147196266b.23.2025.09.11.07.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 07:45:43 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 11 Sep 2025 17:45:22 +0300
Subject: [PATCH v3 1/4] dt-bindings: phy: Add DP PHY compatible for Glymur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-phy-qcom-edp-add-glymur-support-v3-1-1c8514313a16@linaro.org>
References: <20250911-phy-qcom-edp-add-glymur-support-v3-0-1c8514313a16@linaro.org>
In-Reply-To: <20250911-phy-qcom-edp-add-glymur-support-v3-0-1c8514313a16@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1120; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=03YskNZLKf8OhvkKpOjLnPHFdGEAsbxR+ROwyIo2lLQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBowuCPnspwHKIZuOZw7Vc7dqO/VRg7HNsBadaLS
 qe4sALclxiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaMLgjwAKCRAbX0TJAJUV
 VpOkEACEGvJeUaLnixFnmTZWS2Ex+hDrx0G1njopKGtlFM+swtrbL9z9C8aHLYwt3nkiYXPzccC
 KslQ6dBsuW+6pEVYHKKTehDjjfSIlVF/KZIB1M10pY8iuA9lnZpUbGBggnFHsBRdB+VmxxkBXzX
 U9eCcuGiA0myD42WScdZoEhmnyfeWACSURsWJFm35IsHtYbYSZAzPeYO6E0wxrwUaqLlQ5fYQ+V
 SQFrgaJIczJOWymcybAgOG+fiD9JvPVwiyVHOeKwAe/dQ8Kcy3dpyUHNBqel9lCVUn2O6VLzwRR
 eKdWt7g23lrqxmR1V1XFRvnVrrOVG7nWZBVbrEeOVDwDqbBL/cNdoCaOS1qsQC5/5LNC/X2whpQ
 9i6eYETZvZ4hnWCq0lmZZ54z3cyFD0yxxmUt+Gl03HffHOO14H5TEG2oyXf9v1DAkOHq7QfuSis
 tRs9a/7pjs+NW7DjXFUIKsf89EjIjDlqO5r9G6xmcowKWipR7RCEB5LLYrhyPZ6OYXY0W09KA1+
 OSeugCXy9dFO+ClUKaZ9dKcHn+t0v8y8YSF15A4tlv1+yzxeO5b9BZ+nMmFI7l6Jx6gDILrKWK6
 mXj2LcOHAp+TdAUSmbJ7M7qd0cKeUPB4r3uVrLQd5Jp4Ok3yzdwsrBo7hLBbON6Al9Ge0MFRSeI
 WiuQxRrlECuGOGA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Glymur platform is the first one to use the eDP PHY version 8.
This makes it incompatible with any of the earlier platforms and therefore
requires a dedicated compatible. So document it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index bfc4d75f50ff9e31981fe602478f28320545e52b..4a1daae3d8d47ca5f08d97a1864cfd615dcf108d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,glymur-dp-phy
           - qcom,sa8775p-edp-phy
           - qcom,sc7280-edp-phy
           - qcom,sc8180x-edp-phy
@@ -72,6 +73,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,glymur-dp-phy
             - qcom,x1e80100-dp-phy
     then:
       properties:

-- 
2.45.2


