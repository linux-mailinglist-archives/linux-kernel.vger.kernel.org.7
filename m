Return-Path: <linux-kernel+bounces-734737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A623B0858E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39D55812A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE7821C9EA;
	Thu, 17 Jul 2025 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="gdcGCMAm"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678B219A67
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735307; cv=none; b=h7iL+OYnK6e4hWDMziLwElsLbHFcmI4EzfS9sqMtkg2czFOQjvbzTjGMwpS/iOLHG2rrVmzSsrhf0l/M38n6Z/m6Vfamwk5uB932GO+1v1PUMSk5qPJLUzwG82Yfn8CZB3BWRvXg8LpDTFgJvQ2gB57jWRrHX8PWRKlENNnqdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735307; c=relaxed/simple;
	bh=ofhA9RZIk4qK/ObGD/C/ec3J4PZjgTsyOWqBjcz8540=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dndkJK2TbvEYr2Uqp+XcjKcIrmyBQW2kKthhJ7IcBDM2IuhvKPSE7YT375lIGjXOPK/bJzGE9Guwt6iLPSuWYrXeB9z4NFZkC7FHW/pIA0C7v42vuWP3+GmddNvzz4g3MODdepbpeg1MLcWucPALqnDYp4hGq5UO5D+hM3QZVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=gdcGCMAm; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so1109693a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752735304; x=1753340104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYbV51/nzoj2zUAYRNyGSsBe1Ra4KqNdW7VDa67aLhY=;
        b=gdcGCMAmu3HA+GnekioSysSrnvPwDpese0Q5M64y5W7j5+kGoBTPvzz0h9f0r4nFIc
         cywpXh4YmbVgLa7FlSmDvAm291eWV27XshYC3bt0/gTXLjZc6FAhhNIPv1/H7ZKNmLxI
         xTWJuoR2iZCwmrPNOFMCDSrW+roskgHYwp1szf9ziVlvgzd+AkPutt+ha6tTi9FACsFa
         n3ykVCzILQIXkZDL6Lq1QsenzRQwN7G/bSpD51GXFrGUhgK1HX8Po1boroa5fHoazqzF
         AtFKiwrsTul+kGMUYXePLerDC2MdQ+rhTpxKy41SVbkqcf7cD6b+RlJIn0WrTWzRKm3i
         AtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752735304; x=1753340104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYbV51/nzoj2zUAYRNyGSsBe1Ra4KqNdW7VDa67aLhY=;
        b=VLTJbABbjz9GAeI2dwJYlhNvEpuf4rdne02vMAM3Tvl6xDSOU3v0ULEfoOOAkFFZPS
         F9EyqpdUyO8MqKUIwKgtzZNYXMpIIiGtXojdefHlGSNq3vFaKaFtdX8lw3CI/tCGbYeY
         ZSL8tqNn/GfAeTjoNNMEA4IEMV8Vw1XJSAh+jVnrN01mMw5kkFIuqOJYbM3PVUqfRsXo
         TaVpK3aJ8Zec9BGEaXfIO+YuzqPmSAK8KVzqH06g5g/W44dSz+GoCOO7H1oD1bcX0sIx
         nZkhScWqMxIC7jlTPQkofxhzxk34HMtCJOoJSSsAIHOAmW5i9HZtlxevk+ei1krahSP0
         Jl9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWo+J3gmshB9TNBEpaIHj3m3Dav4x+IhI0dDWzfhbhwZznG7OLqGc+LW4c77g8xwxByCtovxueP/xAOmJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSc7srZ9rLNwApYSMErdo1Nr0P2CeT1RewSqrT2gcQ/DtWycMG
	zqiMOubONv7imAa59RmGOygkV6eMjy/a1rXvLjxpTKpGRorOK/SWlYCnUbklRWFAOn8=
X-Gm-Gg: ASbGncudzniPwbOKVjL/hneet1x1TgQaG5cQQ1Y/t2fmpYFflRbBtjGE3KMabyN3i0A
	V6eGBP3D1HjapYYHnN/jNRkVqtS8Z0WoAcbOcGk/Oi0GVW+r6YjJ5+abKQ6lWs0AnJJPcnbo2rK
	oQMuTVzH7fxYWk2Esk2rSB4WmmesBdwrNb6+z0VYvgrHQ0jmlBJfKg1PK8zQV+uia2GlWNTRs5q
	mt8e8dCGJZLpg3vGzRTyz9Wc7mx6x1xULwY8ad5+yrbLLTQ3LbPfW/3ksiTPFVJftzK5rxIzn20
	E46mghg8SLGqLNsiEQYSVuNDEjBa+lgOG7+Z9P0PjcPxqjayrhhfEpJLzbtiSchknnv5KQNDYOQ
	cQ71zwC86iorede7jnEIUNg50at+fYJxYld7PBbwzZUzV5+PkNrtGQDlGvClNIRMZIrHB
X-Google-Smtp-Source: AGHT+IGCMa79Ak/KZtDl4v+vAe363Fk1VViVdgQtd6Y0WVZGvhTIykL9Hsq6Biw3grMwr05Z3oUtyg==
X-Received: by 2002:a05:6402:d0e:b0:607:ea0c:6590 with SMTP id 4fb4d7f45d1cf-61285bd4fcfmr4635510a12.24.1752735303707;
        Wed, 16 Jul 2025 23:55:03 -0700 (PDT)
Received: from otso.local (212095005146.public.telering.at. [212.95.5.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612477e1d2bsm4688882a12.34.2025.07.16.23.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:55:03 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 17 Jul 2025 08:54:46 +0200
Subject: [PATCH 3/3] dt-bindings: soc: qcom,rpmh-rsc: Remove double colon
 from description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-bindings-double-colon-v1-3-c04abc180fcd@fairphone.com>
References: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com>
In-Reply-To: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Martin Botka <martin.botka@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robert.markoo@sartura.hr>, Shawn Guo <shawn.guo@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 krishna Lanka <quic_vamslank@quicinc.com>, Iskren Chernev <me@iskren.info>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Ajit Pandey <quic_ajipan@quicinc.com>, Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david@mainlining.org>, Jens Reidel <adrian@travitia.xyz>, 
 Priya Kakitapalli <quic_skakitap@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752735293; l=1085;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ofhA9RZIk4qK/ObGD/C/ec3J4PZjgTsyOWqBjcz8540=;
 b=VJbUUQ0rCnBxTbImTmB/hVXOv7XbLDUVYLoJsKSS+TR2gyz2+Ol258xtVReyF40biRSlSSPz2
 pmPtDCH1uODDNHkEuJpdy7Eb/+p1eRmo+VM2KO//CPgIZeIXd7ORQSJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

No double colon is necessary in the description. Fix it.

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kernel.org/
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
index 036562eb5140c78c10d845fd6efe42470b41895c..26d9bc773ec5cd42c147c776d2865fa2b435bc24 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml
@@ -28,7 +28,7 @@ description: |
     SLEEP   - Triggered by F/W
     WAKE    - Triggered by F/W
     CONTROL - Triggered by F/W
-  See also:: <dt-bindings/soc/qcom,rpmh-rsc.h>
+  See also: <dt-bindings/soc/qcom,rpmh-rsc.h>
 
   The order in which they are described in the DT, should match the hardware
   configuration.

-- 
2.50.1


