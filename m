Return-Path: <linux-kernel+bounces-781566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 332E7B313D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBF024E632C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247A52FE564;
	Fri, 22 Aug 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cfi/8yHy"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B52F1FFB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855577; cv=none; b=BQStzsTwRScVnx8gzZvxl26HS/GriYuylcN8J/1EqG3J/ydTPP+y+QYrdJhAEp5SYQ2+hAm5o/XX6pvD7yhD8umbuhfV+dO5hzY1pN6b1RCUVAg2Mgc5WyFlTMhzVNxupZwwjoNdgU7npT8WNmsxoA+pglz+q6YTfNLPgSnLo/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855577; c=relaxed/simple;
	bh=DbsExdoRyp3kdjCk0epdoDIR0B1+3ES9cdqkRoNTHi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fGsQ2kEx5yiOlNxxlzKTKSvRTlWtCqT9fRPFAhAXVeU23hfSZF75GEIhjfVFdtwAVPGorfpM+0Gvo3puPRZ0/oMPe1+0JZJvQNlz4vJDKmJsmAz2qZSPTsvtSoHCXAo2G9g0GOpYqJhYecAq22+kmCyX42kI5rCZ2apye73a6+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cfi/8yHy; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b9d41baedeso1007385f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855568; x=1756460368; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5otisq1c/9/dwhaTo3HsCPZ/30o0nEKHZQeBlO8KVEI=;
        b=Cfi/8yHyOfdgtC7uL7tSYtCSfzOdrvhB2s9RzVqRjlEPuyGU1JsZoh3a+wGyOGy9mm
         S84BcYdC9oP2xrotKi+YILCYjbZ8+UblbpOZ8kBmwbHIB6ScGoVg01Ov6eEB1kTv6QV2
         St/uW84y5biil3YE/CxhEVSWl4nk7WJwCXIROCR/G+jHOwmWQzPdOSrhF93M2bNT0aFw
         o4Nv5QnCmYkiWrw3Z8HpPyDWdjEIV1OOCrEe0B5mjXRvxU+FLKG5vG/YEji3pNeQeWDw
         vmnUYO7lpAsdMvfJT6opA+aDXtyiXa49oN2Y0N7pTnBa98ykhZlVSRgjJ2EOkwT52mm9
         fUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855568; x=1756460368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5otisq1c/9/dwhaTo3HsCPZ/30o0nEKHZQeBlO8KVEI=;
        b=A16vJYuWPOklhk4hacPnuXaNy6Nrhi12VsfcIdDUMuf9jo9cyFRdkTEq1jttZ/wGZI
         PA47FcWyoCeXaAh48K3tHI+MVGkzAi5uHOy7TevI+JEVGP/Vx0GJT1zefaBYBVUjy2Hm
         C5w7CnKf+F8j4lgR3xf4L78OznKaUSlL++KjrPDQEEzlfK3PCL8jp1/Jfz8E4aJPP7JH
         ZBG+Rzk/3mGm1eAIFpwt6xLYfnAqzpze32IA2R/1UZIlFGZrWyYQgW0KHNcdFeYb76FW
         xUJzcO93PlK/7dkETTtIKL5B7vkxrEAhiXSV8ybAbzFleJNGSazAU9DApfOHdliI6fBl
         i83g==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ah774jcAPANbbIaNPlpAL8JqDGsfrwEk3DzqohSPRWh7gEI56LCp5333oz9FB56ArLgbmE4a0DFrRrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQMs7Cd5CtBR8RGXRn+HGQoAncztBbZgmLB0gs/Zqdy9ZP29O2
	vQZIFnwAcSsSw87Pq6qXhrr7xUlJif+liwTuyw7boAtSO03HZwn8qGnIQngqUdQSWZU=
X-Gm-Gg: ASbGncuob4qElelLrgV+iz1e9WKL+hn03bj3kJPHFlYPgBwH4XmJKiUP4PpZJIBuYxR
	VtuvG/usLAovbhrqzy3ioVYcRBZPj5422p7mexvdrsFNFIMhF5k31Pj4+EeLxDzTSwuyQ20C3nL
	XHAGm1OoOPOL+UxrPKLq1dJWw7ejRUREjkchVwYYx6v6zpTch9Gnr9AMbZvWguGwPda/oEqjGRs
	PUPOcwb5GI6vpgnzVh+ZTXX9le13BPGY8vIv8/s3tZCtvkjT+I29f3gkYY8ehGVapfmNbTLKPIh
	ESNrjoODMIApQrQQjvmGJbYTzokdLYGqySFHQb26ogPPmsUZbr442q4lhSV+H24QSWxappuDB/G
	GwpeJ+ofPl3mwzY++xSwqn5RCB3cMnHa1Dc6smdRqNAI=
X-Google-Smtp-Source: AGHT+IGoSafaMShGAhyL0uPmSQ5Go+OMOZAWfey8bujTBly9Sd9IfalZviwj6/bmexg0ZbQqD5Zmuw==
X-Received: by 2002:a05:6000:24c9:b0:3a4:eef5:dece with SMTP id ffacd0b85a97d-3c5dc733e04mr1776437f8f.35.1755855568329;
        Fri, 22 Aug 2025 02:39:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:22 +0200
Subject: [PATCH v2 10/16] arm64: dts: qcom: x1e80100-dell-xps13-9345: Set
 up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-10-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DbsExdoRyp3kdjCk0epdoDIR0B1+3ES9cdqkRoNTHi8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrFUpiExxFun+gPYtavnvc68tqffKglmf6QDK+3
 J2EMioqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6xQAKCRB33NvayMhJ0SoWEA
 DMD07+exlTYQzOOqpgxM02WzNd3YceTj+CorC/WBpy6n4rgAuCmiU2dfOH/rpmdZ57wR8kNDNzfpQd
 why9QAxQvCVYJZ9gemYW7tCCHJVSbr2onTaC5C5ouEgVOBFmYJG1wcPSQ+igY3C7Y1hSPmBGHiZGBv
 y15FEWSrTUOzcsaVcPdHW3J3lanVWOjci1vzE/4XAUhZpswEUMXSYixVE/v2q3r4z1NKPN6ttSqPyI
 H3jHemRDTG/usMCXbt8Gu/F+HTeEO/WAfEBaa2frXH45UzFKM0Ip1JV/o1Rqp7L5P0h1mJO3kAGyLE
 bjNXzbhwD8vdjAvxUObyIfSrTKeFjJ6XtyoPeiNHEVq25xGfg8BbNJNQfYDdIkuycpUjvEgbrY/YIN
 S/G1MqB6o4l6muPQFVbySUWpr4LOTUeM/o6oq5e8Ft8rxiZNQTyNP4OVkWyq86hJY6pHhb5c3ZbAgK
 EvqzaIurd2MOHLpGmraXO3Ekl/ZPqG87KXLTmW7VeBEkydS64QZDsnuN57cTlnLMvPqIaW0UFXFMKt
 toZn5geBxR4eJnw4xpYVH4IaUtDJrP/zKIvFWO9Qv+Om3AqfRJmja1NtKVnajMCZsvYiGvud1NvhSE
 UCb3boNBJYFFZHqcFWytlXYMy7ZrUrhj7sba4i53MgETUuC64yxx6udVuxqA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 6b27067f0be66b5c41fa681ff3b4f535100bdf59..293e557ee07e0e622984d6f869a5f79a5766ed18 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -884,7 +884,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -893,7 +893,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


