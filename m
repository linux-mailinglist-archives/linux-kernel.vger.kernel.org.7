Return-Path: <linux-kernel+bounces-807806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891FB4A98E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0C718932DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7929531AF0D;
	Tue,  9 Sep 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0PBeCYN"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E431771E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412490; cv=none; b=h+TNvv4UNevnJdtVMkcc2R4Ok7G1BCeAbIe/N/MFaYRwk+jcD3rql0vgBORRqU0+C0M3Q+zX2EAcgwpghwxp03idLm2j64a09w04NLPrHKU8i9xUHxpB6DDcbWsMMhz4YSkV0tafZQwGTcgU/Pwr17CMtq1xvLZ2+FnGSt1YqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412490; c=relaxed/simple;
	bh=ORlIfeVuUFj8TqCHe+6GbxbXVnDrP5dWUNMSw05JOiw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s/NIGkuz+atPiNEsQvu8tRM+KQSWFt9ONzko0t2RJtTnzu3SukWEipeMftTut8QUoQqKR/FIE6adW2qHZI1xpkPvh1bB9JYdMyykEWKlV42xqijLT0LLgP50efw6Eo3K+Q/rEScXORMmn+etu2TXqViE1ReF5E/hkJgrhCuLCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H0PBeCYN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-624fdf51b44so3102082a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757412487; x=1758017287; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+MjkjuuumUbUDHtDIz2dF54RODSv0Du6+TYcnVJO6uY=;
        b=H0PBeCYNQJnYa3YBklml2RS5ogbcZq3C08p2RDP/tC9Tn0CojrWZAS+9Zn+BYj/qgh
         51ewQCkOZ3p5rAsa1g4nYozmSmt7/4KOUEMf8Oknm2D4TgetfDtwfSqOlCq5T2s3nZuX
         OKg/0ZCJR+/IR265bzZi51yzkSSYfI1Cs2uzeKJPFgtoL+xp53qGsgCk5o9Mx4q1jxKF
         VlCV30dQbkC9EAoUwVKvQBdO4yODd2wURQ76BFNovTW+cUtrI3CEt44aMGIqG5+BVkR2
         /qsjE1XVwQaB0A7y8twdQ6aAxijxFeNjXMZbnRJtzjCWzwy5quPSxlqiqCFqMz1xy4b9
         alwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412487; x=1758017287;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+MjkjuuumUbUDHtDIz2dF54RODSv0Du6+TYcnVJO6uY=;
        b=cc3O1XjQhniG3tOSPqVcj6acBu6g67oe7aFbOLyqbMEWtm0Q57o/Y6MoDfMogF8Cn4
         Wzlh90R5ru9r9QLmomb8vKfCEe8YDWzR0GbgTvD1yj9pIk6VfNELd741qfsQoKS+HOBh
         mY58D2/TAWVNht8jItlqEXNRvLa9ITfNHjaAEFIqOjXt6HfImNKN7eG9hGi1yWWvPwqi
         gu0ZO5iLmybNeDIDvUpj9mjW20Z492QtosYEVDM/6KOkPtDkYv/LPhJ/ehoWAl7f6H+2
         nQPpkXfaHK9XCYU4WMA3O47VPTc2itxCDg+OccLU4FBFlxiOimZAMSia+UEAlrX9WRwd
         J6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNFr9os4zEjn0c0I+UALpjRuY88aNrSqYYFh6XVZKhAEyfe/CcjQqxbPh1BtkP5iSMPkH5BfAwVQCaUIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKLEDLCxWgBzCoffQE/Zqd5wdb1XAoJdOulob13R1bq5tYH2hv
	jrNnWKiFSKFGwnDotL7AZkkOXGHrn/IRw4yZl4Ksf7X5/d6QbGN229739xzH5/xEKgk=
X-Gm-Gg: ASbGncu2w5sNpjNBh6693hn2Zba3I1i9tN+tciyu/Jhn2Pc5D0Dc9I25z4xIDXf3XBe
	mjrn8v49N9E6g/KeCzCD+m7ZGs5MWiLoN1QpuJJ4hqTzTDCL3aoauxGoPwt5GHQRVHlcWJIPolS
	Amz4jvYF9JvaVyLD6yQpIYwmqAEr6Sxxttz6sMkFjB1jk0610Kt5QpE55kT6EbLGYmIFXOTtI9s
	zTncABUm+IJSsbHdEtbs34pjhHMZpaXwMjlo50xNJWAJsQPFaJIDIibWC43KcdxJrKfXBxVLSHu
	tqpuEz4vGYB4p+wpREoUHLHE8SptKhNnYzRN2JEpsQQkYTyibDaZM+acMIsBYdlwLMSvQQ3nRE3
	+MXycUg37+h9ZMZyo6YPBQvU=
X-Google-Smtp-Source: AGHT+IH56pjx4S+xCzwszByBGw0i4rHRRP48D6P7XzQ02qobQwECTA0WZ5Ve2z2zBNo3UUrAel+vNQ==
X-Received: by 2002:a05:6402:304f:b0:621:d92:d85 with SMTP id 4fb4d7f45d1cf-6237b87545amr7716194a12.25.1757412487214;
        Tue, 09 Sep 2025 03:08:07 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f65afsm965379a12.41.2025.09.09.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:08:06 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/3] phy: qcom: edp: Add support for Glymur platform
Date: Tue, 09 Sep 2025 13:07:25 +0300
Message-Id: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF38v2gC/4WNQQ6CMBAAv0L27Jq2gFJP/sNwKLRCE6B1C42E8
 HcriWePM4eZDYIhawLcsg3IRBusmxKIUwZtr6bOoNWJQTBRMsly9P2Kr9aNaLRHpTV2wzouhGH
 x3tGMQlWcX7UUTSUhVTyZp30fh0eduLdhdrQew8i/9tcu/rYjR4amyttLIxUvyuY+2EmROzvqo
 N73/QNKR+2JzwAAAA==
X-Change-ID: 20250903-phy-qcom-edp-add-glymur-support-2a8117d92b89
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ORlIfeVuUFj8TqCHe+6GbxbXVnDrP5dWUNMSw05JOiw=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBov/x3qh+1zkzDZKKOEjks5vxfK+KWla2sIQ5P5
 CtcqF+Ai16JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaL/8dwAKCRAbX0TJAJUV
 VrOND/0bhPxTsAz/y8hRCHNuaCoalofm1WeqNCg0xItbMiYGXqqM34dXABJB610AlCboDhmrxOg
 F96oqb6pfPgXC+Ly+5OxT95evYyGGaz+QQu/pt4x4KqQ5Fp2yTeqIpcWQ12qEt0K0Jsh9d1i3VF
 893hpYSpuynvLkbW5Njyawl+LcFc2oiml2cqojIfTRAeGTJjtNpwQDQvj4h81ICCX36xG0f0oPL
 dtt7AVhIqKNO4WgQ2E7t/1bqV/nRoPxbtNpgZDEwqTTCiWyUMi6yScBXSB9RYT8LV35dWmbf6jz
 0x1w+9BZN+j+XmIHNWgVbDCs0YX/6CbBOqZIIbcZMlsBvwgQtpBOcidLQjv3/hC0dsXeGh7Vwer
 Z//L3yzcsihZ3xRGm7bDUg4nnPYC300faDTIq6Xt0GK8iaAjMoOwMZOg3EJH18jN+sryNy8nfmi
 MbODlV66UA5e3DwFxY770D/0pK2y2h7IqjLSQd1opCUYBEWR1v2FfZBgXogiB/iF4X/m/BlZZoh
 xTeycGgrL/kNQqSQWBuyBdjLMIcvPA37RUIwsCnRrQELlBW6bPb0PQHT8PHw8y/Vse+9jkGWnYs
 PAB2h7t2hdQL7WrudaCexQMV71bF6u9Aytn5j2rvi0lSOi/ca8ty681aNJiyIt5lrp2mzuUUKAX
 wSiRGQjFsorC3UQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Glymur platform implements the eDP/DP PHY version 8.
Add the necessary registers, rework the driver to accommodate
this new version and add the Glymur specific configuration data.

This patchset depends on:
https://lore.kernel.org/all/20250903-phy-qcom-edp-add-missing-refclk-v2-0-d88c1b0cdc1b@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- Sorted alphabetically the both the compatible and v8 specific
  configuration.
- Prefixed the new offsets with DP in order differentiate from PCIe ones
- Link to v1: https://lore.kernel.org/r/20250904-phy-qcom-edp-add-glymur-support-v1-0-e83c6b9a145b@linaro.org

---
Abel Vesa (3):
      dt-bindings: phy: Add DP PHY compatible for Glymur
      phy: qcom-qmp: qserdes-com: Add v8 DP-specific qserdes register offsets
      phy: qcom: edp: Add Glymur platform support

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   2 +
 drivers/phy/qualcomm/phy-qcom-edp.c                | 242 ++++++++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-dp-qserdes-com-v8.h  |  52 +++++
 3 files changed, 289 insertions(+), 7 deletions(-)
---
base-commit: 8128ba77e80a40f545381f1b31267f2f204380fe
change-id: 20250903-phy-qcom-edp-add-glymur-support-2a8117d92b89

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


