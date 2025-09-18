Return-Path: <linux-kernel+bounces-779923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D6B2FB26
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441FF62532F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3023570DC;
	Thu, 21 Aug 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnXkQPD1"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F834F493
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783465; cv=none; b=R4dg4w5xwrs5z/pjiJwi12ZU9GYVc83oBl5HkfR5s2N6wjbVI45ao9TdWSYZnfH57Blb7zaXt4VNaDssyh0mdxaQJIScmadWy8QjPIpMx0sT8vrZm+YMQXEQd3dUqVxB0nHGvrroy59P5Psfl1wzsyo79hZku5QTkWTgwhF4Rog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783465; c=relaxed/simple;
	bh=LBXaPRYmChgNlaxLd1aqKcJ//ltc453vN2DqhuB6DAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u02tGO5B2g3jCjU/UkBQH21c2zuml0uKUeMRvlm/ev0PGondvPy+Zp/gIzjXI1roxhx1qZbnTstqsYrl33th9DK7bMB1L1FlLtMpUFZXWlXXZbSYEOvWbqZaFASl6pBm0TT5/HWYqUj3CFh4bpyn36qjHPWJ+ylvtu+JpChi53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TnXkQPD1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so7368055e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783461; x=1756388261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l1/E3apL0wGXJRh3OODxJwb4Or93GWoBw71KuYToUQ=;
        b=TnXkQPD1x6NDBv/BNDj+dMd/kLt6euT68N5P/mu9pyJECooqezlWirDMIhptvpIDwf
         lp/1pvmoyuaNPxTGfPcUprn7Vah+zDV55DGpNuMPROaNAw2uSPpV18+6Xzr6rbutpB18
         4iI4zV8J7CL7+1n5UQ6vRMbs6+nQdFZWBKlqeoXu7FcEaYMWfVkASkcwLliQWt9LUJJO
         PI5KAogbTeEFrLrSIKn4XIdsRkg2oSRxBYw+P+Ab5tYZWeWl+72f8Np9zAYuEPMeRJHO
         yl/kyEd+xHFANZ3BC1LBgAFg3p5uNhb+eKf0Y+q5ZZuhGfM4ZbNKHkKWWWxZXFUWqB+t
         Ph/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783461; x=1756388261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l1/E3apL0wGXJRh3OODxJwb4Or93GWoBw71KuYToUQ=;
        b=PTWf+3ge1yU0oYsHfaGJd+npcfdNI19Ous8a6JYbjFAD7UjG3KvzKbUh/fhLkQfyQz
         X15PKQKt68r77/NMh/3E7yuLNTJeBFRaIZM1mXOvi+omDZ1113u2xoyca+DDRooc8uA8
         KtUKkDj3zQ8QacorKLaCYG5rhXG5zV3te3853+X9vhYUb/DdV05BmSFe8jDpDQqyyTed
         JmXQZyeiqk5SHTKTbUakjFdvzLRd1kHp4G+Z0Tykf3Z/o1cUz6TK66bJjYhFmptJ6YL/
         YW7JJQ/ZDS2l54MkXQ3oEANcwt3LBWaYTVmilS7onxwvSVwqE09fVUteURELeHAKwGSD
         VOpw==
X-Forwarded-Encrypted: i=1; AJvYcCX9wikNmLOXUPgj+nQFEHXQfXnL/Wc3voibGrntfkoBW7m4YHtfwQEfPSNyneosSWGLREvUPWIXC4e6cMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0JphMngC/ZgWCJzizc/e5fdZwhzYnf5lLYTdTrsxoqGflkptm
	xxQudHSziOPFZ67k+kBxaSTAWpDkuk4g2B3OpGbnjwtsSeU+dkdriFAaQ1NdZ6ZDiUc=
X-Gm-Gg: ASbGnctZxPQ9YcAYnd5FwAoN2XiRt0Ghe+Y+asVXwF4rRUA//Z3kdu1vzii1Odm3Hio
	Lk4bzifLu3mIY2GCd29T+yXFzPf7iNoTKoq9c0lQrXKGPHTng1AenC/FwYbaFyK8smEYjDe0ldn
	JqddLGGvL28ZSE6xamFxcmV3dL6YHeasa2CMU6lVXSmEX7OplAiEe+QLyi3TPlHXOQ+y+9TgrYj
	2ax2YiGrokPcX4P4rlsOkWakcyBvAJB0XbRzmkCMqJOtrgMg+wvgNomTG2HNBPoX9pWPLe+OCDy
	Qf3AwA6lHHVI3hutfg7d6kY8L076d65HyR34dv06ZpNmaTx4zB6hYX8LNOr2jccmmVJfxF1SWMs
	HvN8dkw6ceSA21nzaVgB0HSCjqbLL5nZ82UXidjBza/g=
X-Google-Smtp-Source: AGHT+IHYQ0VibPzspFB+zgvk970PubOWXwYZUwalgmYQR8MfRm7xTWTKvEO4BmoR78po7meZpmjw5w==
X-Received: by 2002:a05:600c:154d:b0:459:d8c2:80b2 with SMTP id 5b1f17b1804b1-45b4d7d5e26mr23191245e9.7.1755783461456;
        Thu, 21 Aug 2025 06:37:41 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:32 +0200
Subject: [PATCH 13/14] arm64: dts: qcom: x1e80100-microsoft-romulus: Set up
 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-13-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LBXaPRYmChgNlaxLd1aqKcJ//ltc453vN2DqhuB6DAw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEbWx5Bh7dddIvDEFFv9yrmqmHlvrPHKg+C+0+Y
 CBDKyOWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchGwAKCRB33NvayMhJ0WX5D/
 0YXpw7kwW0tz24IhiT0nym/mjzfEfAbCNy0pgdphJ16KHAkNLWn7+yOlut5OasM+zGg3/nFwPVLCs5
 scWqHDWM3gNtclkyHb2+YksyASj0hFXv95F6TePE36tHRUprK52vY4EdAuDZcx83ItJSUcfE8+eSdl
 CfIAYkW3LCGdCFaf0t8As3NK384p2z5cqbpe7Ag+Yk3DfXYYCs50jArRSymZS930mc2JpwhS72pU75
 iRz0Ek/av1vYbgbb8d7Ufu0YL/muTlCrl6lqtSeRUWA+52V3GSYzrX3GUJ09h+ccSZ5u/3k24sNZow
 85iPZj9iGtWx+jxBjvYrneDqSB4PXQPRlIxdDdeLP2TerOheG/0pTAwL3Be/3kweX0Avy5heOAa3YD
 81mm9zsn+SLP6NmyuysY9tk5NnA75jHEf3EJb7hQ0T+QOElnfi0qE8qtcuB2VJlGKx4dSJ3j34+4EO
 W1y2vrr+dUZ+DL+Wx/fQN7jm2/9j4PSxgKjWuSrou3zNLCezrnFGqSWzH8juBQgE2n6X/1W2fZMhN1
 UKtDsne53kXHfUvs/irMYiWthRQCOsbb1Hfxga5UhTmP5beJUNxmcpttg8a3DEFb+4NR8QEfYSUGpw
 uuaolTt3FI5wR36iPA5RCTFMsJxtxLNgsSXB9E7mA48MLOZ/TWQFwXHcMDJg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 27dd5e4e9939124360544ee9c59900ebb01f3f49..559ebd9547ec4c3324576d58976c0bf2a8fc2217 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -949,7 +949,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -958,7 +958,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


