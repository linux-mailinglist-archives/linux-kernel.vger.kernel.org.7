Return-Path: <linux-kernel+bounces-832694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA163BA01D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85744C785F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A556E2FFFB7;
	Thu, 25 Sep 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o9oyVXj1"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909B2FC01B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812585; cv=none; b=CKtIEz3fnAQZEkaDQN1zZscQnhMG3R1SC3Et4n3qvCmI1NFeUswYKurcvdpfC7Z/bGyk/3sruoRnqV7ge3u1bGNNo4LjDMrAjwVgkP14terjpWtez20SZ+tifAb/Zk+hr/8ed14pE4vsVWFhPDcs1duL8cfF9NNaTG9uf8T4ipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812585; c=relaxed/simple;
	bh=kHt3Za85TiLa3ZNoDNdIbgLNwPPF0v10ibeKMgRoB18=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mE4XkPYrb6tyr7zCm2+8Cfy6Mnh52BBVmFZV5FReOH62sPRZLGxr4IenUz2UyKQqHs8yhhpPN9OM51Bm5gXDdGzgJ3nuS3A7hUKH/2YRWUJILo4nUwz7H9jvl3vL+7EBj2dCVCVaKLwSDzQzzpGeJuueCqbQxYqRiuYZIa3y+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o9oyVXj1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46b303f7469so7551775e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758812580; x=1759417380; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+pBKLLa3VBhnYm+J1RNW0G8pBZhK11FWF0+3C0J6Jeo=;
        b=o9oyVXj1cqQghh/pQCdc8QD1qVq7zZW3/o1d6fnYqG3CbBrDjNJ39NQ00extC75CmR
         EXUEztOcV3S/zvikvddXd88DdProXAytW7x4oEpePrPUnYn1m6h7g09uwVT0gvforkI2
         Jg7d1/3W/781JrLeuJ/IIsdAG4v9nMPmcQnhL22S6waadNW5Kj5zZySBP5ZDMm9xuRju
         iQusQwoeKZPOTdO1W0rBZS6QjWvUUbfBgHrnsmqUjBdWf1vjM6nEj77wTNJdAOzkZHau
         PBsSYKsH+IQlu4AEv2sj6sa9yweTCrPCplJnnSWDgRZCSqszJf0ViV8QzoTcjkRscCpy
         br5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758812580; x=1759417380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pBKLLa3VBhnYm+J1RNW0G8pBZhK11FWF0+3C0J6Jeo=;
        b=A1QqBMD/fT7bquSmiYKESXme5r2aDll0/xm6TX/dOZBhJ9kJtsxBWg8+jETfKonnqH
         2LJm1tMfYKgqlonK++6t2bw89mX3W1pO9nwgZBxGQ03wjF2XmOC5Z4H0K07XlZOJtk2m
         AoRwWiYfBDkXdNr+IYBEML8tPevxrYVzxQ8bd0z1HLcgjO/PkBFeRF8WF/ht1SxoLCrS
         6g1ZKTTUiBz6F+aah5oQzZ21xZswMEEoogAuoOpTBt7LhkEBxDsWcNsb9XA2fkEh9iz7
         TG+ISyM/4wzDi5yGXRQbWu/h/vYlaLNA3AofJ1LGo7UJ04rtdRKxLfbBUjrsSAQvJ3vp
         PWUw==
X-Forwarded-Encrypted: i=1; AJvYcCWbZ6P6QQCTsc5ENvNKYUljutJn6AhLAXHrFS4o5FrAwVTtveUa3NEWu/AlwjdItcIMLZBXk3yWT3ivgqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxCU0oxHTmH06TM6qIUzmGAWW+gHhKWsVPvKRpEiZ+9A9w44g
	1DKDzdGetWDUceiaD72bqP4vkQXYM65QCcG9bpnZAE2OYwpJtGlEMT3+yJxbLjUSs18=
X-Gm-Gg: ASbGnctMAsLesKlo0zVSqEmEq+Xq/s89AdcySnIVRiS2UIUOuPtORZiS8JusHdo/c1f
	yoU90UFttv+h1gyd58xURTC9+YgKk/2QAK6Rxla1EgHbAzD6/QLtaWwcLf3S4HR015Be9uqn6pD
	ESy9B+HP1xxgaV1mDvNOIO4yNqByhOo3y+s2NIhzOlbMaTc1dYhaJCFSbMzA3vASLxB4j+rvX5j
	weRxOM4kkoMKi8Zd6b7KcdzkM4zpAHwh+xuxKajPqU5F7AoXdeeh1Xhf5rTl4jRsCiO3tBWosBb
	WHXUr/LriWn9XdSgm/vPo0JapiDQYNzsU8aj7mXq1iR4jDP+kQVD5oB7s3U8D0cux0hTOcxzT8Y
	UysZgljdGWzxX2r+iclIl1ww=
X-Google-Smtp-Source: AGHT+IG4i6d2IsCnZQ9ANVdLGKQz6wp6q7Tip9TC74mUz0FzESGyHO6UsjLXrEwoX0gpJfSo436lCw==
X-Received: by 2002:a05:600c:a03:b0:46e:1fc2:f9ac with SMTP id 5b1f17b1804b1-46e32debce0mr45672295e9.10.1758812580044;
        Thu, 25 Sep 2025 08:03:00 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33baa625sm38516575e9.7.2025.09.25.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:02:59 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: glymur: Enable SoC-wise display and
 eDP panel on CRD
Date: Thu, 25 Sep 2025 18:02:47 +0300
Message-Id: <20250925-dts-qcom-glymur-crd-add-edp-v1-0-20233de3c1e2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJdZ1WgC/x3MSwqEMAwA0KtI1hOwlYp6lWEWpYka8DepiiLe3
 eLybd4FkVU4QpNdoLxLlHlKMJ8MQu+njlEoGWxuXV5bh7RG/Id5xG44x00xKKEnQqYFvSuq2rS
 l8cSQhkW5lePdv7/7fgD7TKeZbQAAAA==
X-Change-ID: 20250925-dts-qcom-glymur-crd-add-edp-a53891f61ade
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=kHt3Za85TiLa3ZNoDNdIbgLNwPPF0v10ibeKMgRoB18=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo1VmZVICuo4qVyPs5Y/0//V+MMUBSdHS/H1FrX
 N84C90Nak2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaNVZmQAKCRAbX0TJAJUV
 VpWqEACX/ou3hw6pj6VWU9cq6wOn2OHqmnzZON6j51HIVoEkojg2WDycaVo8MTvY/LfYXHP6+uQ
 dCoYUWCkg5EDZrmjuNeCmNRGaxa8LS7ao0hNj4HNGUxjLH4QjGnF2x28htyCutThX08ASf5nlbi
 EK1NKgPSFCPx/xtBVgIw/DB1DZJ60oraZ5kqNo+eifYq4BzWyFyeEMBYJWpUhJ1e8LHgv2ng4tU
 suCL0tEasX43OTf6sWg+ZvS/YvMyjGGLJ4lycn3StUbvRl86TmvbIOIgWJ8FWqx/M6NMh1pli+6
 6d5LLEPc7hHhxQsbxxsYdIMhxUrs6NZgfSAcJvZXENkJsKWVmrxpuqOVveHT+6WPXsrtmtWeujp
 XJI3H6NIaE7NNmtXsfbA7lhivxJ2S8eJH7XmHH36HdlytiAARnWsaWooFfo7zbhEKc8Ycpxr3La
 zhk2GU1TM4u3T5gyLd1X0bacJ3ovDICvxmw758mxsOeRzv7eyBhlum/7Lasm8U1w21vK3gUWhBb
 tmIxs2O1POUqw0p7TBbOHBoZ1qTjTFPW0G3Oqmr4BWY+fiydT0vZVxV4ZSmjlLbyqT0jYV2Thav
 /uUS/NUzghpszfWZcTfLIsIhFBexZVxU3imXJytnj98yEpj8AbWStPPKbcWNNFZeOdJtBMQ4iuZ
 tUS+iS0+5/od9LQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Start by describing the MDSS (Mobile Display SubSystem), the MDP
(Mobile Display Processor) and the 4 DisplayPort controllers it brings,
then describe the PHY used for eDP and tie up the PHY provided clocks
to the Display clock controller.

Do all this in order to enable the eDP panel the CRD comes with.

This patchset depends on:
https://lore.kernel.org/all/20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (2):
      arm64: dts: qcom: glymur: Describe display related nodes
      arm64: dts: qcom: glymur-crd: Enable eDP display support

 arch/arm64/boot/dts/qcom/glymur-crd.dts |  76 +++++
 arch/arm64/boot/dts/qcom/glymur.dtsi    | 492 +++++++++++++++++++++++++++++++-
 2 files changed, 560 insertions(+), 8 deletions(-)
---
base-commit: 9380481900aa7bd033b3fe3616531058b0b410be
change-id: 20250925-dts-qcom-glymur-crd-add-edp-a53891f61ade

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


