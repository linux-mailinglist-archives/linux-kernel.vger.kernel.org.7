Return-Path: <linux-kernel+bounces-750679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA717B15FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DC57A3255
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B73293C42;
	Wed, 30 Jul 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8qQddoV"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E617C220
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876030; cv=none; b=l2ZbCBMUMiCZSl2CCOxFSWXWRTxkNzlO7zd0VbJ+lRtKEb2Nv4cfChXhjOzVfo+lIV9Gi6ykP1h4uTy8SDmXyPVrKhLkQHHyGaq4cyzzbYmyLkbBTlMXt75VzPzwP6leBQDm6sU4XM6TQu57CRaszA03WDOgPR6o8Qtmytx1NHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876030; c=relaxed/simple;
	bh=PPzsEWxbNLwJQ4PFTPPmrbQv/VqLl1WNdraoffF/cFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BZbzWtDwGdNn/ittkzJVVdSp4HZRsqGHBgQkAXNKnsinowtXJlJjTksDM64xmCkov8RsixY+LsqpHftgre8eZB57TokC1cZUc2VoOQXxQcbJoXeUvKSsNKHsETSRI28KCZO3O8/oQrdGTB7D+nvGqEgYDlsz3+ECXRM3621BHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8qQddoV; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45896cf24ebso4521015e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753876026; x=1754480826; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDvSgqMNHa6pK6/sHq8aMUOcGLW4HtPHI+Zx0q18Mkg=;
        b=l8qQddoVkrH36y34qntdoGTcvcv00JBN4/x+GzKXkdE4yZ2FFaT3OKuy3QOO5Ulwh9
         Ft1rlutmSuLcDdiUPwsb0GC0z9p6oQrtJA5QavlUN4BsHmTOpXs7Qcsx2FQezIOlhgC6
         ED4isJxFwtDJ+RtLDoPVxmFO4cbRIQF+StXD6BLPVHWTCMncva2HBh6OwPhcMYY6uUvQ
         rcvYVgT4lEMPhhzG+owhNu/NOFa/Of9KIWpnZPwVT1uc0KVBj9EwSjKlHtdDzc3QoUVF
         XdII5B0PBOl20Jt1L3g1tuondWgu+GmpvtO3HDvf/5FgUUoevaskSo+nxD/qprRg/iuF
         Gbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876026; x=1754480826;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDvSgqMNHa6pK6/sHq8aMUOcGLW4HtPHI+Zx0q18Mkg=;
        b=IZR+/SJOt754wvC5E1xH7rRHHI4BSv4jxPCvPk033OivCKOEu52J98ubkWXzvruqKy
         fh6ASniu5uRM0Ai+p3rn00ZlwENFpS+kvk7KvNt4SjHU08Oa6yu4jVWbKeu5e5QOYIlt
         ypzl4dcfIavvP7ECfh7L4eFmGTwfQ9D2Su/CBmCrOu3AiayvrmX8W3Wgj8zY7S0oTQ+g
         O5tjTIIXSrQHEgn+93FjoZIWDtWOIGH1vsubKnaoIJjz1uB2LNGNFGAjYfXtqGWpjhLn
         MHqyzrmkdcbCLAifR4+H+MZrECdkuMduNxAzwHwsRZchrhSaSAaSuNt/mYNyJbhVQI6x
         +vuw==
X-Forwarded-Encrypted: i=1; AJvYcCUV+G9WpVCU7u78COH7czKgUTTurJW4Q6SZljg7ihuSVn8sfUz+ByBkDN/0p6OthghHTInfSgmiQIwCu2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOs/CG0hNgSWN8z3Ev6gCrTvP2iV/nv4783F2jU4/K6rdHWKOg
	YLBQsTtvlNuSPC+9/RG79VaVKPqoV2vvBJ5rkOlspyIzDJPzg9O3DsS+68Fgni5r9aE=
X-Gm-Gg: ASbGncv7crtQrivg0xrVXlYWxRlN/3IKUjF0M/chSeZk+t3XzU8msO+N6Xz29gP/u4G
	o9wsCNNAQWnJKvfChQI7iuebNo+Tl5+BU9aco+nrPnBCltP4K5ScoNzsdEOPW4/etNvosJlOBQ8
	dGb5muNHfrp/Wgc6KEWQ0F9m0C1TivedVppHi9uykox8OajkDWqFBVsogn2THRuc23skypcDxnI
	qMEmybA5mF+Nq6mZ2aC/Zx6FMD3f1on2BhPbsWxFAVu8BCErYFm04V80SGgH4SJjENoGFicgGtS
	litpXgQQXnccHmB4uzOORgZGbF0//qas0Dn/rYAjlkMZfZa6G8om+OTEJbGL4hm22AvI7U+9KNt
	a/CjVjV8z8Ofd975pUqlv
X-Google-Smtp-Source: AGHT+IEB+YwR+DpUWl96VRVfJqnHrx70aTbCoi7WlBph+Pjdsqm+59fGnyFfLtjJThrUZcQTfhLunA==
X-Received: by 2002:a05:6000:2c0b:b0:3a5:57b7:cd7b with SMTP id ffacd0b85a97d-3b794fd735emr2401593f8f.22.1753876025818;
        Wed, 30 Jul 2025 04:47:05 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm24503235e9.25.2025.07.30.04.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:47:04 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH 0/3] phy: qcom: edp: Add missing refclk clock to x1e80100
Date: Wed, 30 Jul 2025 14:46:47 +0300
Message-Id: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACgGimgC/x2NQQqDMBBFryKzdiBNEcWrSBdpMiZDa4wZkBbx7
 g7yVu8t/j9AqDIJjM0BlXYWXrPKo23AJ5cjIQd1sMZ2pn8aLOmPm18XpFDQhYALi3COWGn23w9
 27j1YZR6oB10p2vl3P0yv87wABPjbrXEAAAA=
X-Change-ID: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=PPzsEWxbNLwJQ4PFTPPmrbQv/VqLl1WNdraoffF/cFA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBoigYqr3oqVDq6QF5yX7prai0WCXSHnoIt642Xl
 k2knTASat+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaIoGKgAKCRAbX0TJAJUV
 VhFtD/90XNK6iKLj9l8tp9cBMZHm8XpbvrPknsAXmIwTAN0bf7mbmn0O8abBJS6Zz53LoIBwsYW
 zbuIkOlJUgce7OBnWaKSXy9//hp7O7lqqstqXvl1sxx8w4fn+e2fPhCJpsmgvUkiz0msPEWTxVR
 5AhEeYO+nFuc+4qg0dwGxuM6Sh2o7tHEa3AHW/5ZiLtp/33NgrpJAu/5a0nCP2CsZDSkqqXsGMS
 FbDoEvLhsMvxOO5B/bd1Fo0etapeXDHoiVdJV3qpz9b5wWh4xcOcxwGdVoUr+6RQ2oNWKKsoANA
 e3f1XD8DMT8DzwzLuHpZO4Njrj1XSnq6fPP2xwY2T6RDczym+Z9iSn0cuUSHH+eFGXb+HuzI+hN
 AfW+hFJkA5CNLAzgc0BmkC1ubNNYJbFt0JlNikfFE5sEbJtl0ny+fEXaVS9NkNZ5yN1or03P7Gb
 5Ffmngi6F1knLNx/9PgpjghBNwD6RIKaMAPQmo1ETO2k27FlSohORP+BiYpwuKKLKdh1UMKXf8J
 y73HqxdrSrJp1bGmuY9p7xJilZiLbP8kQbSukUv4Mi0dxcOxEdN/YTRZzQjjESN2w6uou39FdtS
 5tgrktrmYUHURLI0sESp6kXhlUsLzupQQlic4ePtbIvhG+v69bQie0ZWvcbueUtk8hauJAsYMQY
 bWi6i1nKftduGUQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

According to documentation, the eDP PHY on x1e80100 has another clock
called refclk. Rework the driver to allow different number of clocks
based on match data and add this refclk to the x1e80100. Fix the
dt-bindings schema and add the clock to the DT node as well.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Abel Vesa (3):
      dt-bindings: phy: qcom-edp: Add missing clock for X Elite
      phy: qcom: edp: Add missing refclk for X1E80100
      arm64: dts: qcom: Add missing TCSR refclk to the eDP PHY

 .../devicetree/bindings/phy/qcom,edp-phy.yaml      | 23 +++++++++++-
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             |  6 ++-
 drivers/phy/qualcomm/phy-qcom-edp.c                | 43 ++++++++++++++++++----
 3 files changed, 62 insertions(+), 10 deletions(-)
---
base-commit: 79fb37f39b77bbf9a56304e9af843cd93a7a1916
change-id: 20250730-phy-qcom-edp-add-missing-refclk-5ab82828f8e7

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


