Return-Path: <linux-kernel+bounces-779117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C4B2EF57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9665E7394
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515B2E9737;
	Thu, 21 Aug 2025 07:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nW//MayP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20263EAE7
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760608; cv=none; b=o9xvQnrM3naCeuskRqqES3OkQdGRvo+kIXwrWTuWUmbQzAiDQzP1lvLkkvUjrGUmQb0dlFgLePeXkJL7iIkx2tUeKAo7LeMtWaJyRr8+N0aZODbJS1nf+a1C1BSAVSDS0dcCCUaSJ2jqb+RPd9TrEi4ZSskAF+DvuOgLiXwJ7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760608; c=relaxed/simple;
	bh=PyUQi8YMEtw07ZLmRCK8btCo2t5iTXXchMaxMmTMsLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DacxbPdCho4Vlo3JH7FjecBYcygbxQ4jzQlYkpLnvVCtPL+qqMiCsDzm3YST/pAGxPvJc4y7Fel2JFWEvgB7Nn2OM6dsM9KD7kfeziEo/DvDsgA3xdtfTwrzowfEQKXyF+L9ZmzPKRFjhMRPXuSVf+GQuZcGDixq5zz0kFlzbeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nW//MayP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so11540255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755760604; x=1756365404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPn06geqbCWQqNy693X8sDc8Y17mZtLy3S+a8W9CJcY=;
        b=nW//MayPB+uCamdM65U1knydA52i8ibbFo83jMxLmSSuDvC/ggN8yj3MweFjKNMxoA
         vDC3K7ZgOUamcLU/atiasBi4GbpzBTG8jtZswDrLYTIKlXiUYbehAtRe1lQ3e70soERK
         ev8hALedjraUosMjQcx7c5aIKvYokE1odjH1ldJNv6ZxcbgOFwpnlIAFZO5jF21ESxiN
         E7sI4T+BOFcaAGhqQzwH6N5iAS607ZhV5cBqVvlqlATPtzYnNPFie8VaR4vEtZeT/gpJ
         AXRmsfVvK1obUNlucd1MvRQm3kpCXC0w2hmCpTcTNge7sNCGjHhXjN2KDpxGW84aKizm
         NBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755760604; x=1756365404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPn06geqbCWQqNy693X8sDc8Y17mZtLy3S+a8W9CJcY=;
        b=HAE14U5BEeDviOlN/KQ75BVicd2TDEByZPH4gq7QMY/FU5B0121T+dV2p3bF1mcNTR
         wrjWUWckeyIJTm5jzSIVGFELVuCECA/1RZr6AErjuUk/PXR9RE11ytKrKb6qQ6Ov1zAD
         hb+XK802+ikZUl6ajusK1Dwi514NMGbR/XpLYSQylqL3u/GmZyx1NCT1fJhR8V32P2MU
         Xs3TAPuDtsLYJWKMLtx4lkPxNVU9/JYzhhcXzBc+m+CkpuqMKMuLCoWEBq/xG1sRW/jC
         53nNqaU/YXZF7OC64gd9l7sYd9C/Zf+hNXvS09Z74acgHsdwVmUsi7o/LZ2KaxnSsvwH
         hzKA==
X-Forwarded-Encrypted: i=1; AJvYcCUS/bdyfEg5upTybUIAbvYyiDIdANvwG2iuVZiOg8SdJp2GxlukZ6n3IQQ+XTQULyRjEYHQ/Ux+Vvpew7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4in4K8QezqDjYOd7uVN8hwQz9mWtyX72rgOE702CKwXCRgR1m
	HHyUHsKDOpLaeJdOHkBqH4/zQ5S1jlsBLY3PpxXXhyBwFWua3q0VAdIw4vBYp/rLfDMncHmMXAV
	QZirR85Y=
X-Gm-Gg: ASbGncs/1BfCsu0t/xwWjFS4oXLjuVIC4hY9aiOe1oBX5hMbdeSoaUSTAu0LXNk5nxK
	EV1ZM/8M+vaQFvyyp710R/pP6t7bHtAz0hNrCxVFGE6x0vpAQNsuBkQP0+ynL7/6GMgO1wJmqie
	QctJfFSXFm0x6DCm16oPbB9VT6Rzy2MgXsCd599JE4/3PDyL2JO/lZS8AnIvY0FEkCetqWY2PVM
	hGtW88tfvYEyr6oCp5ydlqTRcYPmI2Bf2FetlCppbScFl88fAEhrpUSDlLqC7M/Y/H5bK4naLES
	kX99rMY5dXWNsYDc9OpSS8pWXEn/CgJCqQAv/uXh8aR74KZHbfgktPKc8+nzFiMv+hivc73iwpi
	EIuxP6EV2Xby8OsosMrfnB/OL36osZ8EKdEQpco0SX02Qz9EtYkiLFw==
X-Google-Smtp-Source: AGHT+IFpHS77wysF7sSxitfSc+cWkgFQSjGLTrZBx8pZCjnrHd/xkGW1pOgXBqORgCCrp4pDOEJT5g==
X-Received: by 2002:a05:6000:2509:b0:3a4:cec5:b59c with SMTP id ffacd0b85a97d-3c4b0c15702mr728369f8f.25.1755760604126;
        Thu, 21 Aug 2025 00:16:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4de5b52esm14411455e9.20.2025.08.21.00.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 00:16:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 09:16:37 +0200
Subject: [PATCH 4/6] arm64: dts: qcom: sm8450: Additionally manage MXC
 power domain in camcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-4-a510c72da096@linaro.org>
References: <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-0-a510c72da096@linaro.org>
In-Reply-To: <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-0-a510c72da096@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8OWok+mQJ6cMYBBRb+TGH/dRfH3HUvGf9YkBq8GS3GY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopsfX/sIxqn8XI3H09gENW6VOxz6kf5JX+t30K/+c
 Il3yFUKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKbH1wAKCRB33NvayMhJ0Xy2D/
 4tIgycF36KsaJIDdije2iePK2eztQluDrZPwIM4p2ruecs1Ds0vSWPyzy39QnukeFsrXgkQOKOwp9D
 K0S/gD+vJpi9pFYZGbLhnHSIv51RdBeDE0GUU9s5oaIz1Fu7Hb16VfxBFw97w8SZ3fHqRyyk4nyotd
 WCHW54Xs1rNgRNE8KmplL+HZB71xZum2pDa9sqCUdYe2BRY24nBtbwL45o8ss8bIWwrEc9+ehGJKPg
 2Qw9hSBMtxp6bEBqvjYggoOwle86X/YDaF8WoJebSjSuP4ruJvfUquEPggN3shJmQmThlgcPaAPU2y
 c/dvB6iaDTeu1o6CqFvGBs9vS0HzcNGLCMcTQcZfMO7myCJOjahRoyTtMYgmqmk1hfLEkg/B+pEzaD
 2k/GXO0RJgle+du68HIuGSl97KZi0o/ehpeYuslhDQ3YnLDNJD/IVKGrp//IBu5L+EXP6Ye9lpJheo
 kf71d7pOZGgo+rujK9SEaZ8Dkh6qkjCe9lZS1dJ/Ss6c/85bN7UI/wbzLFKqQJZgt7WFNwXBrKc31m
 9JsLuWV1GyqF7+gz3h7I6bFVnkbnUNtEZ3yLbhXGrIl+7Vfscyphz9vzq+kBZWq0ErBOhRzC9ZykGF
 O9GPVCxSVEYfXANPPXl/Xo48ZAbtCrzMn9O97ms52woxk2QuxIn64Sgh11bw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Camcc requires both MMCX and MXC rails to be powered ON to configure
the camera PLLs on SM8450 platform. Hence add MXC power domain to
camcc node on SM8450.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 8f6db0d78f738b14c776735d6b3ae9233b165026..dad1395c8c6712d233e5acd558e67f1e53d678ee 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3293,8 +3293,10 @@ camcc: clock-controller@ade0000 {
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>,
 				 <&sleep_clk>;
-			power-domains = <&rpmhpd RPMHPD_MMCX>;
-			required-opps = <&rpmhpd_opp_low_svs>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			required-opps = <&rpmhpd_opp_low_svs>,
+					<&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.34.1


