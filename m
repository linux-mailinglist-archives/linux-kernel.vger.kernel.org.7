Return-Path: <linux-kernel+bounces-779922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E80FB2FB54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5DFAA5890
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3A3570B9;
	Thu, 21 Aug 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q2Lz0+6N"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A257234F474
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783465; cv=none; b=Q3Z6IU77E+IYWY9YmRhV1hmejYMc/dTBBQOZNX74X8x7PEo/Lt/jL3ogefAyrP8vv3Syl3O6x2ZBj0qimEsIV97Z51gVm/nXpR5VbMuJfLWGxLvB6Y2NYf/BmLWiCa96d0mEtgfWZIYSkTirKEXd/Tj8L86WX9hamJAvEicBCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783465; c=relaxed/simple;
	bh=sucDWngkcc57lEpuqUyMvN5D5nggCib4i3lqmpo2kAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzbH+CUuxUm2tBT/GSi1xBqiUn0+mCRnGKK+HB8swI/ZLYNcf+QpKThYS+3RxBUAS6KKxiFuWQ7n/SuQycLbAjMOt9lDz8b+dZzp/8aBY8CtWgZy456LuuVybtvWivPX4TEGA4vDfY92F8VF702u1D/besnoQyXNm1HEvdwnEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q2Lz0+6N; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b004954so7130515e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783461; x=1756388261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CdhuTg7uI5AhWYYHaCMZroPXcVIf1dIpA0xTfE6eKw=;
        b=Q2Lz0+6NYzjfLfER/+15Tgv1ifg46+CrWDiczHZXpdns4YahAMzgRqEKNgeHNkyGLW
         02ZO6Hu1eoCFfLkeimHnclE5UA26mhwaWDuisJG6zEdQQ6CEkRsFRBDSPhI5xQ28pICL
         hkAXOzbhAhDdCM4kAjdW8R9qXeTL53HxUO/fZ4xg/sQt3LJ9WiZ/UD+ELs2zg4p3ZBKF
         kKykYWXN+8cFK79gWVNCE0AYiyuroQRGAG5sZERCRMxKe50d/1SoFlA9W8UnNkWwc65L
         ehYC3siHXNV/DWbMjf+2hRjJYnB4olG+D4m5dhmhv2wWoXfo20UCCPmvmLweuZdswYkV
         axAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783461; x=1756388261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CdhuTg7uI5AhWYYHaCMZroPXcVIf1dIpA0xTfE6eKw=;
        b=ki2Gw6Eb86662gS5IKfN7JsSHMcbre6qR/inMKZg52gGuEA6wO/sQf4xa1aaJnXnX5
         BEFmejkkMQSviHfFSc95HqZmEx58XeQqFPYFLqihU2VPWWfAAAtKnhW8QPv5cTDnERHP
         X6525Yv86bXQNWIjx8OBErjzBne6KgBupq1uMa6DjFoYqS3qUnXq40IfpIF1Q2aJFPzt
         Ys6ylCVoVeNezqJBZd4pYMrcFoTNk7XDQG0MvvSX0EA0DAziQJZV6uFqVkiidTl5mI7I
         1irIZYwDJ8zyPMzgDbyUhqU91P6mCVt5Od0iwTm04/fK5Pd0vtVv/FDbupOJ93pKlDwO
         DOCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSOtsP2iWFjvGS9KmRolFaI9u8+RX1Tu/kM5o9xkUqSnJIRwH8I5v4ZI7la6Zf2M7j9GyaHuB1hdCBodQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTjDzGbKD+isaLIC97/lg5RdQF0bFXKRZ9c9ymtpSGsw3fWqQ
	fdRxMUIvbNP5sCd5pAmGBc0bwOPkH/SavuBSVWVrb81srG9rrR540bmkxDxjj31FmIk=
X-Gm-Gg: ASbGnct8vGzA571LKxSq5kRtdHAspvdPc2Wzq9X67Hi15LgUYFAmEHRwGYpmp+oQ+oh
	mo+rGb5ECH54dblI2PGwYMQ6kqcQ8bV+2/fxDHGVEga3KCAJpUBcGLpHPHDq/Ydi893PqrQ5gNL
	HUEyPyXC8L9kGI1QxAFug//tj9zXw0InWEhNvegUplF4G1KhH1tg+nkCO53q8wgDJGk8Lm58Lyw
	Ct/7qw3RyRncDNOSt8nqgwvmO+Xch2DQ9F5QRhIyYjjoqYovhJWbhI03QZkNA1rPWgPA9m6DhBS
	DfjtbpLd1mLNJQsklrrWcnaAeTs8UKiJCXOFSw2QZLVJtV0/UoOn94r0GUC8UILnu9iwviedKkV
	NTGErUxm0IIQQqH9Rhw6nDRhgMNPJnpNWKWvqB9Ajors=
X-Google-Smtp-Source: AGHT+IHJcRqxvxhfNk5q7LamRHRhfUiEMhvBean18E0qgC7uRY11qL6PpxaespWRZGAMiDI1SzOoZQ==
X-Received: by 2002:a05:600c:4590:b0:458:6733:fb43 with SMTP id 5b1f17b1804b1-45b4d854718mr20919835e9.19.1755783460789;
        Thu, 21 Aug 2025 06:37:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:31 +0200
Subject: [PATCH 12/14] arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Set
 up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-12-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sucDWngkcc57lEpuqUyMvN5D5nggCib4i3lqmpo2kAM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEaLSvxD8vmZe2M8WM4JfJREm2CXx429V0432lo
 vTKEyi2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchGgAKCRB33NvayMhJ0fVDD/
 96OZTgHm+92ETPV2lKOqXNAK5CiF2LTcdC2GLWwRNEx0hJgjzDaeZmTVVyxdDzx8VhCMsEcAtBd29f
 M+EwoMv/3dDn3AwniIEPRRPR0lknz6YGMpi3Gax0s/XiZghBFHk1v0QSgSXFqm+OPdUNakGgrqj7Vl
 fvEbuvgYwMSn6tTWLBj+2GDIODgThf3p9tt2F2PLue8UJcvS3LqXY1YqMIMJxpUf3K/v/Nhi5tLBtr
 GPtMYUzQBT21RSWAqqjK+DksmOlZTX9fPvorLL/OWCUAaU7An1l/VsWMnJw04djbbGfR3wyn1WsRoY
 TG4RCg04zgk7mIXA2hSbQWC1seLSjIC32Pdrl3eSZ+sU74xbUL9yDr14YYtAZvL/oLKu/jAdKb0uwC
 DrOxEEruF4TP9Jlt2cfPKSFfP+MfExYh7sCnkRTXWl6IyZCx+Eqkub7t3F9ea9EzJaeKB9Fnupwiu6
 k7wMJsBNdtyeL7PRxDhDAeBgh8LSvwWStP2rNTZS0Ie7lrgI9g56eqwjmSbuMf5RK/yvEdBbuBX78m
 C5D2SeUMrul1WogkK4dRAkq0FKB78wlXeRGnJt0n/ZvE/w8O2IMe7fd5xO8ByhYIhCgrcIx9VTEc6a
 YIVIOsdIwz1inVVaoYxDoeOp3Rz1gwGKKytoqUutfDhMLI6usx6l2uClBurg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index 71becfc5e6f649299b05b0b93cf74b81dea9fa57..4374692d6da9030462a577279263dceeacb3ce7a 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -1061,7 +1061,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1070,7 +1070,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1079,7 +1079,7 @@ &mdss_dp2 {
 };
 
 &mdss_dp2_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


