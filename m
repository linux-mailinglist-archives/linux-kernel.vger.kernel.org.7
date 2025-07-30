Return-Path: <linux-kernel+bounces-750682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E48E3B15FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DE3189EC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93A317C220;
	Wed, 30 Jul 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOJxJyoW"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C152989A2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753876035; cv=none; b=Kwa+SyTRoaK5r3NqMhi50i/SEtvSKl31Shi9Bz+QPIXXPBVE6ogURmiiFCgy7AF9HLkzP4qb827cCF3KN9FvzdAGH7h/Jxzmhy3mEgk4wnP4p+n0+W+IwdAfjtqGqBtYHVK13+xrgLtGQIln/g4FfigC17nj9dDrDqFk8tC3988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753876035; c=relaxed/simple;
	bh=3+mFkiMttykY34ebovED8rFvS08Z4HkJkzkCJaTNiW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dV2AUzdzI8+3c/6nYluL6Y4oy7XRNN4Gw7WDWKQ4I9/+838m49WuIgC5IFWSuWAaTBxEeQa7k7nKcfWaN5pS/jfGjhwgO+TfesKAmquQ89lCpNNQux37bOXE6x9sEugMT2ock/wqMuIOK12iwBHEOUV+dBEzLStc6PPIhNkgFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LOJxJyoW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45892deb1dcso4127065e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753876032; x=1754480832; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kkYNO2zotv63kU8jp/OPqMKQUNskP7pSGb6GnBgyQc=;
        b=LOJxJyoWQsoYlybPD3Z/m8FRqW5ePeHw9bcDsoQm9P+Tk8L7fdqk12wywHSEH81406
         vsCyRqhay27xMaPxXNSFuCmuHQy5H9n9n1eSmREa0rF1ly914LreaI2hS8mA9WGJ+7+H
         M3RA5XBlb/KVqLy6DATJzY87PLeiKp8Op+l7uU4l45lSLJciMHAkabRwVUGy4ZGShKH+
         RBYpAKKcqJSJ0ezurSzRqObwMRUc1quvUCmfJr2boX9ofAMbUaJ010tb4NYvM+mwUL5D
         qN2Gg8BrXvAQjZHzNYyfpaI9v4wKtv3fsMJGtKJteo8Rryy6svtXpxK4M0ybKAYje+6q
         KCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753876032; x=1754480832;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kkYNO2zotv63kU8jp/OPqMKQUNskP7pSGb6GnBgyQc=;
        b=rdhitCK7GA04iLyNA/DpXkHhDaDWZEZ0KHbny8J9UwZdK7yP3DhyW98EzW0i516j+Z
         4O5KL+28uBdAGgHEeOCrDO4/3cZbPpoKhvtRq3L8yjFqpNtGtmJvKS5zGaZChghaQ3wj
         GZAnk8h0EZaA7ymWdHn3yuMGcOKHja8Td62uqCeR21i7pm6j757X4j+hEN96wOczaTw8
         9HQHIafuTI6C0eUEFThwc0on0P73opE+z7sASwlyOkYON6UB8NSfYNd/V/v4+3HLRTCh
         O4ZGLpkNox1RH2lceBhr0XViuyiKUKbKK88facDsW2anQegwLOG0rV1l8+rXZUIBlYNW
         Hi0g==
X-Forwarded-Encrypted: i=1; AJvYcCV9a4D0mPatcwfk2vV/wDh8cda9sNhHcGpBp0W4xW6KuINeMcA+9gC6OwREe/1x45YWoEqJ9hQBLoVlKcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfb0ocNKUOpqW7kHb99Wv4IygxnXxr4xY0wuhuabx2dqr9HiU6
	i0Aq4v1KW68bxpkZTrr7aln+1kXdBEY7Z6p/PBv0EVQvF8xGVqqNZoIQF3qVodH3sRo=
X-Gm-Gg: ASbGncseSj/AIOke5yJD5d6r7X6qUkzz07acoPXhcK/brCzmY1TZU2JVF33EJqeT/iu
	ChqizyzSJx51KCf/7dn2Bnddol65+yV0vFQjzxw0HNsNQjzM8k5kmwvfhzIG5wxOJ3AqEQ8kYuj
	sF2WDnXMiPn7smZEAv4jPR5Xgp5o3+7hdR9rJhV9U2pdDDfasH9Bz5jL4SwfkMuX+8vM7pc/vZk
	wTViTIaZsOBSgexPh2fYch9N3gmPbS2agqlfHGzky1F/RZV416qcFekIjjEHpgpANF5OfDGTqmg
	wqYLQf7T3SVnrptrJvxUCOVt7lEtvkwBD/+wHtGcO/iZGOBUiehuFY3NLI3nXaFgmXaYO9YkhwP
	PVDKInzXI4GJKN0OCmM54
X-Google-Smtp-Source: AGHT+IFhg9IXuQga3JWPvhcEKH0T1CESr1U+ubBYILDjsH+y0nI5opFSiCuxHFfoCrAfoGvhuNPruQ==
X-Received: by 2002:a05:600c:c4a3:b0:456:58e:3192 with SMTP id 5b1f17b1804b1-45892b9524fmr26009525e9.1.1753876031728;
        Wed, 30 Jul 2025 04:47:11 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eaeeesm24503235e9.25.2025.07.30.04.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:47:10 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 30 Jul 2025 14:46:50 +0300
Subject: [PATCH 3/3] arm64: dts: qcom: Add missing TCSR refclk to the eDP
 PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-phy-qcom-edp-add-missing-refclk-v1-3-6f78afeadbcf@linaro.org>
References: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
In-Reply-To: <20250730-phy-qcom-edp-add-missing-refclk-v1-0-6f78afeadbcf@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=3+mFkiMttykY34ebovED8rFvS08Z4HkJkzkCJaTNiW8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBoigY2BfjLKn3//RyDBBmZMWRyKXpNADuYBBhWE
 4FHCRAmhvCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaIoGNgAKCRAbX0TJAJUV
 VjprD/wKyetj6InZwSuz05kvMoar7tz0UqM68PxSBb4lV/KPGScU+OSvLovxXXs7z7x2qmWkJP5
 mRpIm/2/rqqLJbLGwBHIX5QaPrZ+2cn5NnI1D7feCHAuqP6CrrWJ6Tm1dw9E8qfgMzotkee7uYp
 GG2Sbb68hb8XS8fb+qO4ny8TukliRi9ZUDLB3kxlMBI92F8RJRBiwKMxyi55pumjceyB7wihYU4
 5MSTdVPZ/+FS4qxW4VkZJ2AhVF4qsdwIUdPGAt3QFrjWKDh+IPRYBkRu6/le4l7Oja5ZO6wAra3
 Sr1afqpoSxkssca6Dw+uSMU3qN5lH5lPivei//xYt59agSqfVrF+P57pwmZiDfjElt3JqqC7q4+
 1aR7BL3Izv+BuE8JtoBQbfHHvHqDJGNqWYqKbaW//TCch8GRg6COj6kk58EJoCrIwoDbo3JsCtL
 I+tgdKU/lOZDOsRfMRm1LlDme0Ve8TpyxVUIzBh31tytuAGkVOhkvRIwVvZymnYakVWTUckuAtN
 3WQYydC73WjFmImtLzV9t+15Q1as2g61mM/bEVk5oOcn8o32hn8AgZK4i5tS+tC113GCLDd02Dm
 NxV9ipsNplrokGrFESVmrXE2gc0h7WfIDS+a7htqOX1v9bSdsl1IsmxCAZXu9OVY/OXpztfSPco
 6lloQo7nmIgRXww==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The eDP PHY on X1E80100 needs the refclk which is provided
by the TCSR CC. So add it to the PHY.

Cc: stable@vger.kernel.org # v6.9
Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 5e9a8fa3cf96468b12775f91192cbd779d5ce946..6cc0c85191fdd0563e62e08d50590d546387b827 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5655,9 +5655,11 @@ mdss_dp3_phy: phy@aec5a00 {
 			      <0 0x0aec5000 0 0x1c8>;
 
 			clocks = <&dispcc DISP_CC_MDSS_DPTX3_AUX_CLK>,
-				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
+				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&tcsr TCSR_EDP_CLKREF_EN>;
 			clock-names = "aux",
-				      "cfg_ahb";
+				      "cfg_ahb",
+				      "refclk";
 
 			power-domains = <&rpmhpd RPMHPD_MX>;
 

-- 
2.34.1


