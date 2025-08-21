Return-Path: <linux-kernel+bounces-779917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A24B2FB12
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4601E1C87858
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2D34F481;
	Thu, 21 Aug 2025 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJ53qKNM"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255C3451CA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783461; cv=none; b=cNGUxYPUZOhW/+nVnaHYsPqI69aJoZC5GxyTHFhRRSKVdQlFd1yDKvEbPAJcsczI+lT65uDIzROzWhsIobpSByUncuzDItI2Tq9GrnYwYtymrq14SV0CDxUYRYKmTA3jOW6wgcS3djGwsKvypxIZGkUfFZ6VmE/k7d2pRRUaTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783461; c=relaxed/simple;
	bh=WfJTFOkiFfJ8imdBbfyVJQJksDVscMbwStcuwHTKDos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tr2qdvHSGRPV5Q4bB1GSehi+73+9/7pjI9W6Mk2fdNtXCtTukNA8ucgAOO4xOLzYzVu1grnKkKMN0DYIsIo51qL1cHnUSJw/BMIwV3DW+F342i/gUp8CjM+QsqjGeJTZ64vwZ4Lv/KBlZWrjvMPCA/bWkO/tmGWSj++Ek8fK2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RJ53qKNM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so455150f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783457; x=1756388257; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HblogMXc0c0fbHZC8tuteY/HEVF9rO/2JJ7XgNKcksY=;
        b=RJ53qKNMM/ODuusLEmuqay2AEszIBz6m9JdbWzm8Ft4xnSPphJjpA1PYU3ZPb3Q7LY
         HJsc2eWkoVQlVUImA+faiJbWQBeepAWeKTD2cjpgdHv8YaCQY1C+EQ/gkDpgZF9kp/sy
         hEQeIUpYhJ4R5lOUwVtzCr8YTMGiLKm4lb3+GwGflgJmAgTHLMB5gdQmN8Ox91Wzpzb/
         fIxxXQVXQu61/Qo8Xrom/Og9IayqaDFGeP/1DJWV/K4+sImvZCxGCzZwmqw0QLEzdrzu
         mLHv6fabPLQjJR+/44SPDozdAXZMnTYFdKG+osrrfr14vastOQnfj73hXqvbv88/RLMI
         u9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783457; x=1756388257;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HblogMXc0c0fbHZC8tuteY/HEVF9rO/2JJ7XgNKcksY=;
        b=qvAEqsXb9x58Dl2vPS4JWPx1d8ckjtCc8n4OlWoOXU3MdFwCi7UHykV9X/MbDPOs4o
         q+a+U3ntdMY3urTWY9vkyN/TMQuK9qxRRhaQM76QrBF+AGrIgiMz1Gm0FZY+Y+Gfe01Q
         beK8Tatj2WURsax1APbz+ivLnGHlqFJGQ5goN+dCu80N8s7g1mDpPPeWbtWz2xkYZXRc
         aN2/Y3QHbtpeWZdB3CM+We+Cjda8YTI+J9AwljpOH3Q0pLO0sy77DB34J5chCaL6oo6W
         hKWfm57xasizvGalhb56TfbqEFx6rpli4IJRjD6Dl13o7nySNezS+IMHERiaoN+Qo3tt
         bxCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtuYOsFyKQcXNLPfdoJ5IbJCZAZgySMcJYAE+aR6BB6BlbOjrOPN5yqVHTiR3Yx48fQ0lL0XxFzr+Glug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR8cpKAbV78D3sJhKX8X/3smXhCQw/u8S/GowznqKkOxhn8c6n
	4pILfm9Vy51boWRK/vrTNyxoaLONCl/rMimChveZ6utuuWdih3G17zlNy1D5PWk3fg4=
X-Gm-Gg: ASbGnctI19tydYTbHVJD5o/8q4FAV7aEIrNT0Xz7ZSf4uYvvFvwPuI44+gjG8OqCy7m
	XAK7pdkDWyxi4I/cD30sVYswf3fXIyf3zi0SutS8f0KmVrfOdVOunQiiA7P+gSTK7oj7WxrJe0h
	eYTCXT6mluDFfC9cLjRZSPbApppU07Qg+g9aRt3NHsE+SWavYQhqm4v+f9POPRkr3v3CQ6pf0xy
	AQXM835ZW8kPHJ30VL9vDe0Z2zimH7LdCncrXMmOs8ToD46iunKZ5AqTpzp0mZevOM22pC5z7x3
	PurTOIoN6IN+P/LXnkSVoru7D2xGdWiHg2/snXYQzkjzR9Ro/rgnbDrIhLqjQj8NrGWyBUvp7QS
	s73Ghm0iXBgzrY9IdGxWWTFk6p8WYXpMhW7mirs7f0jPeQ6WWjVQxXA==
X-Google-Smtp-Source: AGHT+IEXm9NNE9ud3brhdYVDrXEExkzpZLJB9UqRWcK/w7ClUKnvtt8/ZKeRQXFAhKI/DG7/zxqBpQ==
X-Received: by 2002:a05:6000:1aca:b0:3b6:c88:7b74 with SMTP id ffacd0b85a97d-3c496ac4eb0mr1775012f8f.59.1755783457532;
        Thu, 21 Aug 2025 06:37:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:37 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:26 +0200
Subject: [PATCH 07/14] arm64: dts: qcom: sm8650-qrd: Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-7-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEYe/I4C1TPI3rTWzhJipTrmqdx4ftH89S4Fft8
 P/EaaT2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchGAAKCRB33NvayMhJ0e56D/
 9MT+Cil4Uhw02/xRvCPQDGTmo9Fge8YPrEEzyD+4BKVrSdYCNh2hI9UVHckl5E2YcpSU+yeg+JvAFr
 CQnfx8sYJ95zBSzq/Rsjy9nVZSY0LukeMRSnkdpodRXB/7uYkjBflO7bhQcc1hGEamvpZxCTNhwllE
 /fxQMg/6qvhwjKOpMZ11QJssF9luABiyfWl9i657KoTEHpRjkaR0D5rZPcMyl5PGOdlS/7DK3WyyJH
 6TYAVJfkF4VmnzSwTvHdLbg0x6CCHC0Sk1HBiJc2n+DSAnDRdqOyUyWzA4Y9POeiCjCOvmiKAvqWWX
 nZMHAd09me5L4gssulCL2OhG4jbWQ+I3rtweGq2lFuD0VzClfvPbAODEcgEUL6v5MRQK6hNbiD3oOv
 EQU18z571OUHQuWVUjT1S4ulQHkrte18vhRdRUQUoXozO6uWN+EWR3jfoRnOKz5JSyxmXMtE35YcA2
 tQgsD8QyPXC1rSkmgXCotZCo/u0Kv+tJgPqibgy/CwgfYUX6FBJsn2mEaGQr33nAcTTd8np5oaFVo5
 2ad0IlQdI84uLL+6m5HZN9YvHJsgmD8FGd+FK14Zrl5I+7EZ8/Im6oey6g35GaIFNXPOQlIG8ycpvZ
 lTdh2qdc9tFS4DrXL5itoCc9CBzC9t308/Sfo+eHrpO1Gjva/RGxKyhbVCIA==
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


