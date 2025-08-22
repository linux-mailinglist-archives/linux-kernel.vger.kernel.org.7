Return-Path: <linux-kernel+bounces-782397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D223B31FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C36845FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3E72441A0;
	Fri, 22 Aug 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icnBgfel"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442B233712
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878220; cv=none; b=PFtxhlMvyzPYxgIGkc0H8IZtlqFPA5eQtegSg7kpJhOJAEJPs8L24pB0c389kVJsuqac/wujoT0g04UVsMwyOYuJGEp8yB2WMKZb2lEslpcRxjYFvFoVJk1kyMD/koMe3UETnjwAoE7FVkQaDBHnOZtyK5KEDfCz8IlJpXqEjLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878220; c=relaxed/simple;
	bh=bFbkXWGJmm2SJsxrU4hHphoEIzK8Alyv2GhqPrtMwXM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZeUIJdx3BJSW39GELwlM3/29wE9BwCl/9Fft4MLxBL8i9SZ+OutIdG5WXBcJyfQvoDB4FFJ4gFWfh/vV5GKqVT4cTJRpRbqH5x7it+f1Yi3XxdxzP1f2l9nSwEBobjSQQjIppYimSucQVDr2YPFF3hOgKs+tq3Ptv8eQ3E0Je5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=icnBgfel; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b004954so15716005e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755878217; x=1756483017; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QacgOb2ZgVuvvk6y//Vt2Nw6LEN08WKlZ4aG0uscgHg=;
        b=icnBgfelaSTTwkjcXGruJgvAu/aRRnraJlPcIuNwbZvdoTbWDBUEN0PBi3Y11TV3AX
         HfoNznzj4H2gdIKsTLQ/WTpwWebDgiGS/nWctozo5L6M2gSaqNdbBHg2iV4kH8GXnm3b
         bJ5jCBcivDQVdEmtJdYMmyArkoznqKZm/FXvP7sxE0AKU+zkscnYoB2L4A2Za0xE2JlD
         laAtrUtcoSwuhOMa6VJr2jR6dmMXxg1hP+WHdf2UjfMG0GjaGRwHzoy5XXFrBtK9pejn
         lrfkSuNdYgGYwYkrFUEyakDAJBnQ2M+Ra2NkcobH/dat9i9opXA58ofg59LXZldKTBu1
         yPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878217; x=1756483017;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QacgOb2ZgVuvvk6y//Vt2Nw6LEN08WKlZ4aG0uscgHg=;
        b=akX/N5x5par+3IxWuMwaoZ+d3BVgwLlllJsC5MwLSFWAEgjE+kmmYY0q3Gtm+BQpeA
         98U1xf+bhFIK87s70qlUWqIwowwZyA1ZQYzrPr4HJf7mXeVT4sBQIDzLuwIce9UpNYf4
         kVGjhd6blokzQI0nrVddLe1dy2L0wM6ZV4ahgi4IQE8J+g9cIzlkfoA9B5j1POm6AsjZ
         wUAwZQVlaFUGrFDWulUOWX+pUdmQQa7+1ydHCrwOTQ68p40Rwgh8eNjugFEDAzjz1YfY
         6Sw07xAKr9Iy/Q/VeQuRIvb5frgy+LLMIZnWymmhtC/bi2UW727F/aYppWr6j8THNWSP
         IVyA==
X-Forwarded-Encrypted: i=1; AJvYcCVfoH7kbI4s1fQMKLwTGCNg0KxjzXq8XUN0xPPDBUCR8+o0s8r7ThKQ+7wFLgI/gCMivk9U7fcoMRfCqnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCRI2QMP70iyJsb6ux9MXf3Bbc2jxDwxbZt+feEfzckGa29Ow
	yu9mIsAEEmq3rEt98llrNwdJNJfXoLYuE4BUlDD+Wm4RZ5SXLj4bu2mbD1a2BRxEaGs=
X-Gm-Gg: ASbGncsaxZGM5oA4oVd11fPzjl/WYrOiWj7YJd+dnrtEvV92gIn/AB8ClGQhgG9bVe7
	BeC/fwqN1GqtuNQfej2hoRr89iLKOBBRP9x/ziRZG0WeZ8njDGWilixp4m+YWGl4dZ8UKkcAKDh
	ZNjSzDMNgYwbeAuX8lLh+ARj1YpQgLaCJqEiaj7bgvtS2ZKpSQ1NIm8kLMfAluXLMOebgXCd+9p
	+YW6kWAMsgD2a0RaIHXYIxGD3aVZO5vVJQrAoq/eEUTz0D/S3XbUllVPbKrGb9vmMtEMuGJpx5T
	GlNXXfp3dQZd3Vy+hhpXMAKTgTaaQCA2JZg1ShyrgXbOXpYrVk4BWVuLzrzYie0c+Lo6xdzS19A
	Xt8U3VTW72UGxq7Ql3Mjzca48T+0CmR6BmQskgZfz3nE=
X-Google-Smtp-Source: AGHT+IGq0ThWPZKJH0HgcylK4MA0Mh5QW4qLOf30E2AzLsWgCITzX5gUoWjudf83Dh263NPF8feg6A==
X-Received: by 2002:a05:600c:1d14:b0:456:2a9:f815 with SMTP id 5b1f17b1804b1-45b51798fe4mr31006065e9.4.1755878217019;
        Fri, 22 Aug 2025 08:56:57 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3c89cd4d4sm10095765f8f.42.2025.08.22.08.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:56:56 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/9] arm64: dts: qcom: Set up 4-lane DP for sm8[56]50 &
 x1e boards
Date: Fri, 22 Aug 2025 17:56:48 +0200
Message-Id: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEGTqGgC/4XNQQ6CMBCF4auQrq2ZGUDAlfcwLgotMIlpSUsaD
 OHuFla6MC7/l8w3qwjGswnimq3Cm8iBnU2RnzLRjcoORrJOLQiohJpQzm7iTi5oakAAWTyVNUG
 qWuuqx06Xl0ak28mbnpfDvT9Sjxxm51/Hm4j7+k+MKEFCiwo0NHmCb0+2yruz84PYyUifDP1iK
 DFFS5hX1GID+MVs2/YGtDFO9AIBAAA=
X-Change-ID: 20250821-topic-x1e80100-4lanes-a8dd7f1cd569
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bFbkXWGJmm2SJsxrU4hHphoEIzK8Alyv2GhqPrtMwXM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqJNECmzXuqOivdxSTNpCT/23prVqjvyOsvvUQay+
 ULepHcKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKiTRAAKCRB33NvayMhJ0YDNEA
 CHBQ88C5b8M7VgSHDqDzRSu6rGwZnuA4NuUjclCGCzUYaRqIwYB6bjltIxg1kKFsyerGbHC9BUiXlb
 jI7EtivHqFfltpfep6nU0JImt0wj8FCyNUEsWR8JaACf8Tw2qNmv7DQ998lSW+Frv2WOB0cCYdpkGC
 Q/0RvU4XzOA94Hmp6Npaph5zT/8XO39XBef13g1qtAKxzsZp22BuZY/KLQWKV7gWqdCKA8E4FFY0Il
 p/fcw3w/4L30U2qsZQV6Ft1tSDACRqM91gzXPYU5cgdgLZx5GfW8xeBLYJkXvAtDfPUfuS5UF2CI97
 +0Dr1Mrl2bUPB2mYMVi8jpzW5/xIjqRjzd1G/GiCnTu5POUGUkbcwVWlGJM5ZLrVYUowTnSw6eU41S
 zW+1nnkq7w9yBaBULnZBCcxB5VWS5+3qPxllqWJJoxvNbf0fP6YNIB8mtiZtMIKfFZsWK7mAoMxZ8V
 0Q12HTZjmTNXBDx6Bztf/TGFYah2VYVIwTkd/uc1J16cCtDlTd1IUPh4qDZORvFc1yrVkWxDV9ju3q
 lI0oS8cz6llK+o1uwLFqlTAIyVHI5kQVzvc6iclOXcgOmeuBvw/bfKUIir0uRKHaLOLJAu7fVg4La4
 HglOQAwt8EyYxmKaU4Tm5lizKV718e0Ub2cQpY+olw5we8VeRvtYTgiKIk/A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Now the 4lanes support in the QMP Combo PHY has been merged in [1],
add the required plumbing in DT.

[1] https://lore.kernel.org/all/20250807-topic-4ln_dp_respin-v4-0-43272d6eca92@oss.qualcomm.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Move the data-lanes in the SoC dtsi, and update it there
- Link to v2: https://lore.kernel.org/r/20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org

Changes in v2:
- Add missing x1-asus-zenbook-a14 & x1-crd
- Link to v1: https://lore.kernel.org/r/20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org

---
Neil Armstrong (9):
      arm64: dts: qcom: sm8550: allow mode-switch events to reach the QMP Combo PHY
      arm64: dts: qcom: sm8650: allow mode-switch events to reach the QMP Combo PHY
      arm64: dts: qcom: x1e80100: allow mode-switch events to reach the QMP Combo PHYs
      arm64: dts: qcom: sm8550: move dp0 data-lanes to SoC dtsi
      arm64: dts: qcom: sm8650: move dp0 data-lanes to SoC dtsi
      arm64: dts: qcom: x1e80100: move dp0/1/2 data-lanes to SoC dtsi
      arm64: dts: qcom: sm8550: Set up 4-lane DP
      arm64: dts: qcom: sm8650: Set up 4-lane DP
      arm64: dts: qcom: x1e80100: Set up 4-lane DP

 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 4 ----
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 4 ----
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                     | 4 ----
 arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 2 ++
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts                     | 4 ----
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts                     | 4 ----
 arch/arm64/boot/dts/qcom/sm8650.dtsi                        | 2 ++
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi           | 2 --
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                        | 3 ---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                | 3 ---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 2 --
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts       | 2 --
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts       | 2 --
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts    | 3 ---
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi    | 2 --
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                   | 3 ---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi                      | 6 ++++++
 17 files changed, 10 insertions(+), 42 deletions(-)
---
base-commit: 7fa4d8dc380fbd81a9d702a855c50690c9c6442c
change-id: 20250821-topic-x1e80100-4lanes-a8dd7f1cd569

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


