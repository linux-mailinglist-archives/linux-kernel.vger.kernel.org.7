Return-Path: <linux-kernel+bounces-781555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35B3B31409
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBE65C5303
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3402F39D6;
	Fri, 22 Aug 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6QUCdeZ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D922EE5FF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855573; cv=none; b=fcEtRqRlhBhhp3GWZ4IoGitcsuUf8KUEr7NNi+R1r+CHrg/phUI4yU9MFSgCBKysSgTXcKRPHs5ksOoTQI4s0j+X1e1X+RmiunYzHqZnla0wz0QDomymD+6tX1XuykkdduJhMSj7o0B5rAtjdNp4tfIjT47joHGfHfCy5597+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855573; c=relaxed/simple;
	bh=G/wzh1LKlqFj1XHpSW24RpGEuz40jGEwYVOccwOIdpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovoV+mzu1xaOpsz+3IeWQA32F+TgZWppjzQhOpBDQqy7zP3R/JZgYLzIKQczg5Eu4UeE84gKetysiDsEraBb4WNmy6h2GYawzB7e8h9wjbD7EOHfLdSvRI8rvj0TYyIyV5RwIREoPGJ50MPaxL3YzjS3WP2qKPnUpI8XalZUVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n6QUCdeZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso10078665e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855565; x=1756460365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9vU+AzX5hawYwkThmd0VTvOrafIrJwi5Pt/Uz+FZJs=;
        b=n6QUCdeZdiqWMlJLQdbH00TLOpUlrLW6GAakfZ0rWVY6rVI1yaF5raHoAuCYDK6pv9
         6D9MT1tMN2lEQzLDMYsA+4W/Dk50C8KCarWrw+63wPMxEyrYgMTNxw9xjfWYErSUZk5z
         ZgbVU847S12n1sgciXKvpCkh12lUnNm9G1SpnDw7xHUSfGv5Zi1gF5qKWtmJJ+WQI+hJ
         oO+gD3rL9u9WHNwiCSp18hafJrCa1wiVTUxGJLP9yVLjtWtzPypP8sOCNyekrEM0zSR8
         XtFGlewK3XFJK5irL+1/qqT9SjFERl+Q3lbcicpkf8VnC5a1QLB33CE+loCDh9zc/u6b
         Ipug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855565; x=1756460365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9vU+AzX5hawYwkThmd0VTvOrafIrJwi5Pt/Uz+FZJs=;
        b=oQ/Vv/egOB1x1zOJTjEqsxAujQHpfrqIawHcxOh/dnJ9uFv+uMqPONEDjTG706PSgY
         WVvsSm0d+4fYtScibH/e/TJ8SI5pnr+F03tHhTIgazPDtQbk7/O8NqGTzC38rUi6LLzR
         GJrt9n4sDAP4JO1Ek9RG66SLzP7mSmyRVF7ERJveAheC3jLaLGVt3Rl20BaXdmDHdOWh
         ad1+Z0gbfQ1b+2XTHighDqTkSPEfIQsE8rD9gCsvoGgbuCcWWPBMXbBHmhgUjuTqX/LM
         tAesMld9aaebpfoAh7B8Sa0FzaTdXU2ybJflXAsR4v+9EDs/vB6bas13zuIGpzkDcHkx
         OP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYbB16R8kdqK4uuVCeF+F1Pjb+U/cMzaiWX1Y0zNYFnqHlm2oBtfLOvCcuetVvFYG8TGg6ANsKWx9L/zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBPLjcueH83GjBb3eVhOJX6E0XKsDdTfQi+y8OfZ6NsUtICwQ
	4ojaAqDafFiUlKJiaFZPARPyPQs3/HYHFDORGWRzuH1E/J80WiYzX7G2u0jWx+bIsPA=
X-Gm-Gg: ASbGncsItFJXhu2A82dBpftXFpjyYngEui9+1gs4epXsBlscFF3RkPJnr3GXGZ5/YUR
	oHVHV8RFxabZrRbvCP3EGF9mKPXim/6x6q1VFFO3Wr7fo+crztQFsvqv05x05hEGVH6tMLqXOi/
	vX6FdJwGP3395OQmpjIPq2NAMfV3oe6C1zSVr9kPokvdAS4A/ZID639pKfGZm2bYHSm4y0H9mqb
	Iu5B4sHinZ9J4tVqgdJ0OFYGiq+YEkcC2nM7Ukir5AoseeO5L99v/nKOgPZbAZp4y8U/vD4UUkF
	OSq5En4zANhE9ERdqgUXMou2YErZ2XTSHT9nZHLoaWIWKkD16Pi0wWnC7EgFhYO+TwJ9XhAgCN7
	WmX9OgffWzTWNfb3alWTYiY+gLQSuxtTZZYOCb6Mtapyz8fThRGrNrg==
X-Google-Smtp-Source: AGHT+IGBWpvmCWtQxpbr2Q0sAV/Drw56IfHvctmF77NIYGiyESrl4m58R8Mw1FV0/xzDYN3ZpPU4bA==
X-Received: by 2002:a05:600c:524f:b0:459:d8c2:80a6 with SMTP id 5b1f17b1804b1-45b517cbeb0mr19614205e9.33.1755855564945;
        Fri, 22 Aug 2025 02:39:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:24 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:17 +0200
Subject: [PATCH v2 05/16] arm64: dts: qcom: sm8550-qrd: Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-5-4b21372b1901@linaro.org>
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
 bh=G/wzh1LKlqFj1XHpSW24RpGEuz40jGEwYVOccwOIdpo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrD8l6vYtYPHmdI5hVYtqPRa82XLUzSdldEkMLl
 suO1xPWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6wwAKCRB33NvayMhJ0VgQD/
 9bfPy8gI3yq8EJFwCIHEPa/qUylYoCEAXwu4iODxadQCkm2js7bWpZMA0Nek8X/+Z+ad7no0pRNTdZ
 eM1aT5f6YOCxwgmX7VPV59A1t1AqMRlFMAhAHTtKgRueh+4VqTUR59KF5ypvctXaVStG3rx/8M4+Di
 +YRznbr26UPl/t6PnY2dpm3qyulu1WxNfWP/blHpuEZuJEzgbjx4GYTsepqTHqJygbsOB+dMzbhce9
 tMMnfhF5A/1NR8y5/cDp4va0ceXz3YTKeK0EEd4DJrD8pi++QC6CU46SfjyUmSwD95XIse/nQgZULr
 h5IfmYK8wnpVLNTZYomWNYFBM4kBdM8nsq1ktVaSOXbpvBQC+nx+cT/NU86hDiaSBtkbToYoba6nZr
 vsN0amOzrRl/p9VTagdfVOvSa1bkUCuH4W+rSVMym8lhmpe/Wzu1kZ69vZIHwuCoLHM9lWCrTXi+ed
 qH0mDNsX+XqY6pQmAu9gaPcLoYEUDNr/yEIcUrCwb6G3GQcjutNzcSVF0fDlZForwMQixWqSv0hW9f
 vmxKPsYFZylgoSYUakW2/hbmleIo2Aeg/5651beQf8aod1rWr8OjCYIXI04DxsR1b9YmHG+ES6849b
 Ps0o4dhsu9kqm8ISTL/qYs3+wQNfMr6TEha4Ldq5VLxboHD80eqb9vzRx0gw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 49438a7e77ceaab9506158855b6262206bca94ec..873835eb1ce98f2306abcf0153a284f148e69cef 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -858,7 +858,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 };
 
 &pcie0 {

-- 
2.34.1


