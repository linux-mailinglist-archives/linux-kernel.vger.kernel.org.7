Return-Path: <linux-kernel+bounces-779918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC590B2FB17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1468F1CE76EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08FB34F47C;
	Thu, 21 Aug 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9WjoVQ4"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A4B34AAF6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783462; cv=none; b=hWkYDPTvhH1y/z3O9+4FcR6es2fKIo2RDUMq3RtBkkuA2MhG3LZhEdbUz37zPBReXao5jpb2ayUoPh6bGEcWzoOt+Ey3rDlt+JGJhCkxABkVwANmC9aCs9CQhsSgcUP+2LByVVHxVTaCmsK+hPYp4dTssiaIpd2klWvoYlNsS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783462; c=relaxed/simple;
	bh=/ijYBip4Gef+08P0Kp9cDhiylfO8cgPDqcobGaJy3Uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oOZ6FLjh8ZtWgNcRiieE3ojCjspvktpKFhItJCZ++kE9HOGIJI0FZTgcuOreNrg2rrCymufCeaEmJTsAG/116oYBVfQOed1lL6xYy2I6IMeBWaKxaGfgAVf2ttxtbcOd7wxWqGriQrF3NJnj8gBEe0TMz3x1KEg7RMocKl6GYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M9WjoVQ4; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c51f0158d8so398501f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783458; x=1756388258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qJ51d/LzxXtFMmJ/9ohPT/eBh8hSvxUNsu8PvJJDNs=;
        b=M9WjoVQ4enxGQR4MogDnOT3pYdS5dfLDGR9zre5SbfeQQYTQjpQsjv4dQNQWCCfvQM
         nZ7Fcfe2Y4ZwN5ED9i4fdiu6eZhaEBhnfmAQpuLTY+yKV/vIPw+dYleXmHYXaY1jDCSI
         p+T//vwJdjEfZ051ngr/lUbz8ZuHfP76dHNinAt8vc53T7UbTl3WO0fd+SdJJlZTBiUl
         Dkax0oxResteurPiEJQ2v7ohrEduuVPnOgzH2O9HCu+PVEn13l24PZeV6QqI8LlGZLR4
         2exOJI5yZUtNhYhv92eMk4ePCWVonWoN19lZPSxrymUXr7zjUvohxh11z0Fx4fC3OT/6
         c48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783458; x=1756388258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qJ51d/LzxXtFMmJ/9ohPT/eBh8hSvxUNsu8PvJJDNs=;
        b=wBdIPVJvMvG8nq00h+Q52DyxN49DcB7Vc005NI4oKUEUeJL+s9JfEbGT02wQKqq+Uy
         1AukifiqXX9H3zAeKhyCkPg4cXBbG/HtdaPaQ1Ff6JH3ixKaxQUhkkVICKyZYhmdCrJI
         G+jAo09BZuLcLHq1q0VZhXA7fb8F3KkMIiqeUInNw/2QvcZpKsdfOU0TjEgyZDEpYK20
         1T3XsyurMB7MKGXy4DrauDoxvllo0W/+50m4EB0QGxFhD075HEhVTzEpy6kwZhoSSQLw
         7Z03mSmm7qtz8+BiD575uZeL3XN3XPU5kZ8JBpvpeIeCSoWJX0E4BR1TAwsTRq53WJLy
         8TYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoeAX1u74DNE6EnhEAk++G6IpOOfli5uB8qOQbDwi3U/mUK4MOOZGLQw8vc+JtL54ggwOWmIV4hOUp7xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjIeKDZHD4W7flS+NygjSCriGjuaBo1eHRDIlPnfozdq8fR26V
	rggKU9d47BqyWiAOP5glxlMk4XayGsqzebCPZUe7P+ucFmUUhWOkDo+ZXiaZhcy/JrI=
X-Gm-Gg: ASbGnctDKxe6s8dXu4YkydxcZcEAXGXXQa2NZA65aOSeisOT8kCTF6kD0jQAynwUIM2
	CtR4KnmBok/zZLvOWbXNtmQWSDn0qgmCyvOOKIK7qK/rxQiYu01Kp8oYPbYR9w5hZUhbGgqVoTC
	49yTcJM3D8qQZ59O7LgALqBPIkZOec8cHT03DeW3PREFRsHIVP8dd943W0/owoZQAogxac49PQt
	Ob11T+T9QIKN5zA9rRi+hK2tL3R/SRkTK7QXoMaxS9a9aCGD6v8fPOVlgfr2YFj0a4KIo11phnr
	PkvWMlgpeBX8zOXOgJw9a544GTvwbbpOqzbt4PCc1NtmIRoP44kDHD0B/jAmJeHqAC4DC/gY1w+
	A19FgNExp28TgqScacb/x/yv7e8207T6Ntoh0cWUl5uo=
X-Google-Smtp-Source: AGHT+IFesizZtF7wK2nBqzgzIYYHUxBGN5S7bzGV+XQDEktdmtvozHkpIXOFALNO/khX+rqNOtQWbQ==
X-Received: by 2002:a05:6000:18a3:b0:3b9:1635:c13 with SMTP id ffacd0b85a97d-3c4953a8100mr2292629f8f.16.1755783458172;
        Thu, 21 Aug 2025 06:37:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:27 +0200
Subject: [PATCH 08/14] arm64: dts: qcom: x1e001de-devkit: Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-8-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=/ijYBip4Gef+08P0Kp9cDhiylfO8cgPDqcobGaJy3Uo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEYagpjGUotx1e/7IseWh16q0H2Miq3qPxEPA5j
 aCVhdWOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchGAAKCRB33NvayMhJ0a9nEA
 CgL41E2JjvpjmGmIpUplrtjMmMKTnhOkiiTq2K9p0ja8KuFP2sMb/4r2f3PY2jqVYsl69oggjrSpOB
 cEq/2CSJxkQo0UZENvpeSQjh1DSyb3OE3Ve3qO/mwlKZhvneAxOUMHAstuOCenwMkHQpEiYlv0/vqR
 2PU/MK5KsfbZjKa013qjeofLfdESW5lCIJVmh/10wQ14hD27/OcyGysuzixD/sn7ILgbSxV8FDU1Vt
 tb0LZDyA3Q0Vhjo3OPIQqC6QucHqFsmJUdkm20MveGWKd/2pr7EBhHTb5QpRMesFLqYLs1gCP++NT7
 ZXcS/ohm/ujhNPED+3Mkyz1vx1MY6gcroIbCZHHUlw3fGs2kRp3q2t4spahx0Rir/bakevAyOGQoZ5
 esO5rRdBCVbpPqoslZ3AkGKWXTLNKTpTMc1u8trfdUzYcd4/nMx/+7/V1ps3TYBQWDAMK1AbFGXxKT
 VvLpGsoT3nUdpmj9UV9KtuZBWLtnoL919ilmzNHJWKVNrNierwaOme129QUpt7TZGU3VscgnD5xiZj
 HS6EZrwz7OasDGHSU3i8/gRb70qUG1RAs/jylbzuvCRuVT8t2Vti3UE0KuASI7LU9LYnRxpy0D/gE4
 kssx/oi+JqBkXVmAhcOhwkpMNsR60dCMv1CD2fc7DcLIg7VLWxDKazOgUM8Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 2d9627e6c7983daedba87619ba01074ee22b43c9..b055925da389146c4a141152bf0025624be53dda 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -983,7 +983,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -992,7 +992,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1001,7 +1001,7 @@ &mdss_dp2 {
 };
 
 &mdss_dp2_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


