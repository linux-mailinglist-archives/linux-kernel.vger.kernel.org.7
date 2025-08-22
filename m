Return-Path: <linux-kernel+bounces-781556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90FB31407
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06A75C537B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A776C2F547A;
	Fri, 22 Aug 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ot2cmto/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD864291C3F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855573; cv=none; b=TycosVkc4jAqoU9Jl2aXreSRSKdtHEFdOzviJAKtOw7Cm+DemdCu+vta6LnnBTiBy0azrXZsUp0wZEvBg8MH+sMPkSPvTtm2HJ+LQOT0tC1ZdnKT/pQzHrIXv9ADLpyeibuewxLksSNwBMq0kqNDTMT9h69G/pUKqSFIzPAwyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855573; c=relaxed/simple;
	bh=WfJTFOkiFfJ8imdBbfyVJQJksDVscMbwStcuwHTKDos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KB4LFx1925Cxk+/Fb5QHq4nfLl4hk/3jCwScr0DxVhIE70kvtrSPHU9YulKGgZLlmCuCiRRx69OPPsgAacRZnQeAiatrx04ZuklFpFVmUlkeFvOPvAROZylFcSuz7PZt3ML4VVxUgTbs8rS3zmOZfrSGE8vZ4mUoubZK1gFi/rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ot2cmto/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9dc55d84bso1732017f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855566; x=1756460366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HblogMXc0c0fbHZC8tuteY/HEVF9rO/2JJ7XgNKcksY=;
        b=Ot2cmto/DzNJ2O8WbJvf5WV8CuqC49K5ZP3dfEgKFaN5DAioWioLpUnxEzoBp8Z0hs
         P9nkK7WfB0HjTftZ2UNyJJLXbrKhAc8rIaQ7kRtTkC90NaZJshyGVBiIK8UqjtCF3utM
         ofTO8U1ueDlidejYl2oXNWUPtUmNDMGY1jhw4IdbIHA2VJ8upZnJzaj5A7virbsYZS4u
         pkuDOvhuJLFz8L+opgT/kyvz1FLsmlRrwYiEpWzonqnBpep8XvVn0nV0kkuM8BRweWWX
         7eqYx8CiY0x0Mlp6CZwug5Qsm8YNrg6IU0mMRgO/WppbZwH/waUjA+XGr7ENFFChMaom
         F+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855566; x=1756460366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HblogMXc0c0fbHZC8tuteY/HEVF9rO/2JJ7XgNKcksY=;
        b=N5YUfyotVuAALMZu2IobVIZJDd6QKGKdfocECgD7G4gGTvSRmHkVgFQL71AqtVW+RN
         QhUhHrrlKIew2mnaWS4iEZXQFGa1FtaZLc2TcxD2zHTQdVRT4q/aq/pHZ0mD2AsI/q7d
         68y5wHKt+XqUM9lJ/srZFVubtDAY13sy0kis8V0SvSY+eL7RlljTFzlcLWvD0oS6nWpA
         60ZRDH69jgbBMA7kzXdx1QA/+x1+2lj5G2pGFzXw/FVIRk93fotash0C1eEslR2kPAiF
         +DqdahY4lFk18aaaEKkWTavAi/VfhyPCAxIcczo4OJngJTxBDdybNQhid6qBS4Bbkvc+
         DTCg==
X-Forwarded-Encrypted: i=1; AJvYcCX24HZ33/Nw9r/V8Z0lJUbeBJgSulxWJRm/vUuekri1V+5HmmgqMGP2NOw+f5GUyW8sD1AIXIg6bERKyyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkE7pLhiERNkwT4cRTqEQ8typXp6vlFPZDIzHAw22H0yyBchG
	MXed0+qKkVlHA4mQLFRLRzDXNyl8hqeTaJFYf5IDIgEHFC0KBJbV913QHCGRIwU376E=
X-Gm-Gg: ASbGncuWKNg+iLv9cRkk9CuyjInllyrT95dJDCTMa5OEmUq6U221LtDlNsB70Q34uHY
	hfh15AXjVwFGWoe75G3XhxbIupFDH/3x9cyknx037clANZ5nqho9vltIVxOW58U1ZNjh+mEx2MY
	pGfsG56E8TEREc1l2iHKSDGgfyi5VlqzGQa8DzEvVr9T9UMrjHyiArjf8qyq61/rRdtDcy9MOB9
	3BtmRx99l8UprA/Sis2UP8l6c6gKjW+bJ+A9vdDm4DpWIajinZDar0a3x2V03khiXjHZhwsOcVK
	caYhTzxzALfoagPVfQj6wnUSfMZ3QHBhiIjheTvELBz+DU5uwBacMes5qork6Gb82EQ7oXKOdui
	YgJkOFqHL2cEjJquQPKq+arFrDOv3odC9wwqaD2X4kOUybF9K+RGvmg==
X-Google-Smtp-Source: AGHT+IEFZf0iPzP6rxsAyIV261ItRqbrT/i4PxGfzqmPGqWuvtcq1FqGCxJEmHWOyGtJpgIDPl6/rw==
X-Received: by 2002:a5d:5f4a:0:b0:3b8:d4ad:6af0 with SMTP id ffacd0b85a97d-3c5dcdfe499mr1667246f8f.40.1755855566265;
        Fri, 22 Aug 2025 02:39:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:19 +0200
Subject: [PATCH v2 07/16] arm64: dts: qcom: sm8650-qrd: Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-7-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=732;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WfJTFOkiFfJ8imdBbfyVJQJksDVscMbwStcuwHTKDos=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrEOajx6C4sFY9R2ZFNqgl31CWXPBPuPDwQEkue
 y+pMUOCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6xAAKCRB33NvayMhJ0ZCbD/
 9YKTh7dZXEmP3OHThGTzoeOhPj802ukfqgW71WoQvUm3YvGNBbl7fvFXhdg5GxqCJ9hNNart7UQcXy
 uagF9/nklJ/xAaC8l0e2fulzlM0FIFELVpmC5EgBiH+4S60CYtQ/DVyd45XJykN7CT+ySnpAYmc7hT
 z+hltEixPvEAgcm313dIc/y3EQbE7JnmPpXTBqW4A0wZvWClaFmjfvj6/y3vBoNh+TCCP3RbTG0zPa
 KBt2vcyVWyrlTE7bPnlmZPgXHcxQXM3demJ+/cFoNd5NoTUxmFPsSq/aDvtG3tyBuS7dlnXMMAiHHm
 xNvMrVYRrzwMQBDog9h5TnY94ToaW95md66Qo0B3S10fG9jDcQmIVus9EvPgYuxcS5m6UK/vr0IoEv
 CAJRPbIOWNVTP4XLBZY4ob2na7GySZansx00R0OJ/+7b+PzDbsLrXSkg1lvYaOSFdqbfszIrXO1OTG
 UK/gd/hBPa/7flawOxzK6hf5FlkpE4cEGtPr+M4LRS30Ph4rWol+/pZVDGjns497ofrNl3Idjdejf/
 NuTy5bNKlsTO9bp1swGuR4LwS1CYn6eLLyIo18/mVYM5WArnkIc8YE9gLuUfsWHRFaPX2P/eojpIuQ
 ZcSZ32ufjx01W/sq1uOiMCuIPVl8ahIzYw+V3m1PrbSmXG6j3jFs0QjuEFeg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index 081b7e40f5742120a611cbfa57a59dfb1dc19b9f..88e202e1d49053230f58d719d3c7d57df2c9922e 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -893,7 +893,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 };
 
 &pcie0 {

-- 
2.34.1


