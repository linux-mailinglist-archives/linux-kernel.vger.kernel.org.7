Return-Path: <linux-kernel+bounces-781484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E31FB3130B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A060AAE65A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7712E8B7F;
	Fri, 22 Aug 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPN7qEWL"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436229E10F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854803; cv=none; b=GAqPJPObGaaeZunCPsnmV+L7VydI6PNwcTLN7yV28ZZ76zUNN1sjXKDdxDG8BkFNsZUgWBdgKCbDJh4QE+bjwPwmBHlfZbIOcRfcq6RekUa3xL2TP0f4bTGb88UZtmHXjK6Qb3tMQChLSBqI/wn/OH3ZllNVCyO4Sws143sJkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854803; c=relaxed/simple;
	bh=jR/DVJ6iHDhOV9awxYxxy+P7xYkU9pJ0t0jQsaJ2ZMc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mn8fJf3LIoQRrpBgDlEwUMup6lQ7iJOw1kEDQRLfcEdZkTLfVEoZ8fbReBgGsmvx81mfuaYCksEnn61J+dll/A8pZF44Ta9ITz0udWwKaoU/F+P4GjbxXPiyjjn3X9vrs8AlcfomhtXYKDZaaoyX5pqJfw68I9BpSVVB8tnTOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WPN7qEWL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a15fd04d9so19772235e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854800; x=1756459600; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=InzC6AEUn6N2EzT5qCdqSdLJvQVx7PhxAAj3EHoLbYQ=;
        b=WPN7qEWLpgMSk7RLRGq+8gS1op+1SZ+CLuY1TLwf5kyyLuEMxHJzqzZ2EYFGVid3Rd
         9qE1b5bJ7DcC9V+Xd8ipJaqKNoVzzJrLRt+pdWuwk0R/bGUxx0Ym9CVebMoZzWTqSZLE
         O9n8DKFmHhe7ca8rl2zHss0LcH8Qdv5FJRZczVkjMZuxP6EJTVEVi0wiO3PS0IAhXFM8
         gplkh37xlUcLRa2ptQE1iZdfbHjYMNESxvJxZjT0W3bK9moj/NC0j/7lbTm4TdNx1Jqw
         3lXqhVi1cEHXo+yRhx/9gPQjkFU5USR1QMK2OkQDDs+jUtM1B91WilKHtnx2Bj5jqIzi
         lHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854800; x=1756459600;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InzC6AEUn6N2EzT5qCdqSdLJvQVx7PhxAAj3EHoLbYQ=;
        b=p0vnvLVFSS8PLNTOblsqn7VmGP/+xBR9K1smzruZBnRiBYEPHXez2uIZTtMaEiOz0r
         w8+QdIZxVXrCbzNgEWbSamxZltETqgaa4RWpHShJ59BCzODFBHE+x6KZp73x68hNK1P8
         VNYKECmg6v5kvjtVAZWY+uNMN/SGQ5uL6prqwV78JPQWvOwXQFisUKX4mwL98hEWPZvm
         l18S5wfl5yY60xLQvWpdz/G+/CAeSlrqjH0FChilPKJSNIsUdVIR4LnZXYGom9qnjbSm
         s6wIyIlTpNS71U6JCZAtlUM1qhmDee06EP/XvmFemEDE4ivUR8DfjPnLcu7e7Xx3JejD
         qwUw==
X-Forwarded-Encrypted: i=1; AJvYcCXhKJcVti7o+apOLIg+awnxBk2vVm7Q7j1zZCpdJZ1B1Gha0LHFTMOITSrm9ZPz8sbBHyiujtuZ8HVfXMs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2wk9JvGEfk6+WH4ew16Tg9KfFDeSolnq8+DLGbQ+WOXaAB7et
	R5dSP2Nlk+hK3Uvpq+GIesgjwyEhV2GIsW70d+eLlDKDUb/JNDZNdST8qXjPWnJ8NcI=
X-Gm-Gg: ASbGnctKjbKP15Gl2CTS4LczhrmE7nsKA/7VIQ7fCMjRIDndInhY2p/KC5xbXvglQKr
	fBFuhhVFC1OVpr3bt2XoGQnHYWXxaTph3GVuTfbnm/yoolIu5x+fUaMC3n1NiRQwxPjFS9IVIGl
	vazqy2TdGfZEGWh7ZzHDzFeDmTlgpwXq14Svx7bnD7+R6g7LTv3c0d6vcS2mvKlNsRKZDZjsCWg
	8gMX4hohycLIvnGDfBpxDKvLrzvzrzZOdOzx8ZbGaG0hA3ybH1KokXNmtHGu2R4nC/AbhaRcINC
	YouT8s+zqGAfdrJRZ7+DXKNxfwTO97wCscjpcYoJpCTrcDiuGeB94AQS8sxTxuPl+7ZY1h0i/fD
	XYLJn34BYrkrHYMb07rn3mkoycvakjND2nW3xW2IyQhU=
X-Google-Smtp-Source: AGHT+IHj/debPj3AF+wfArUxR9wwDm7ZVG+p4jjPslw0JJ64XTjQA8wlXji7gqknsPS5xlcQeVdntg==
X-Received: by 2002:a05:600c:4343:b0:45b:47e1:f603 with SMTP id 5b1f17b1804b1-45b4d817001mr25345445e9.18.1755854799533;
        Fri, 22 Aug 2025 02:26:39 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5826751d5sm3297007f8f.14.2025.08.22.02.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:26:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/6] arm64: dts: qcom: Add multiple power domains in
 videocc/gpucc
Date: Fri, 22 Aug 2025 11:26:32 +0200
Message-Id: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-0-28f35728a146@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMg3qGgC/53NQQ7CIBCF4auYWTsGSKjFlfcwXZCC7SQUCFBS0
 /TuYo/g8n+L9+2QbSKb4XHZIdlKmYJvIa4XGGftJ4tkWoNgQrJecCwh0oh56TfJcI25JKsXjM7
 hsrpCGA3WUMhPaApq2QnFjZLKamiXMdk3bSf3GlrPlEtIn1Ov/Lf+CVWOrGmcjXdhNFPd05HXK
 dxCmmA4juMLJJkdjekAAAA=
X-Change-ID: 20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-a56291d959ea
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Taniya Das <quic_tdas@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jR/DVJ6iHDhOV9awxYxxy+P7xYkU9pJ0t0jQsaJ2ZMc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDfLssrex89Htd+CHrcEIaVG1MX0XtHQx5y2Wea9
 5GO8oqyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg3ywAKCRB33NvayMhJ0R3wEA
 Ci6aSitiWcpVoz9QLvm9Ri5o+4WiDPhqS+c2da2fbIwp/eG9T8lQp1PBB/Dv2TIrO6alzy6kFU6sMT
 U+lQxsQUz/OkRIypgBZ78tEYvwD1Bpc9G0XFbRpO8sPzqnOSakq9sJ4aDuFUZZSDDTSO7JUe0i2DsZ
 j484inFgHl3lGsTJabtdHbSKMJd9tcaN4oSKIJ+dHlC3z9xfSJX5tmjS5tv3/uHGTiaZqlEyD3CQAU
 dG2r743c6rptCw+C74qEtrH0cd+01Z1Rm6EQ5KlB4lwFJXUCGX6R1dgKovhjPvC98KnJbgM/8FcqBX
 7iLf+5fLkmXbgNsOt+QqiZ4FcaDkf1XO5AV/Po7nRZCfaBn8MF9zED16d/bw3ya69P7CHaXUQS/iR1
 VV7Fn5bYZp/AknQBJ1Q8uYjv5I7SDea4zzSleqAuWN2sEKfNM2jlDBqYtMA4HSbnrYd8JXRxHwy55w
 O4WHbbHzCPNKKllP3P0dapQRUTXv/i30VW+TkTgUujqZH7AxY7Na2vgjwac2Z5w6T0cOuWdxvEIrpa
 vCMfYQr6nB8grRR59kzlIJRB8j4dwIQB9XPUx2zEyXr5uYs0aYZxPvXGcNQRZg3mYdi95yljPjS/cZ
 VzG2iA5T2diuxVkNbOY5nOk+N5OuZyUlHVYDitZ60cCe5D2dSkx2gaLVphrQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This is a continuation of [1] ("clk: qcom: Add support to attach multiple power domains in cc probe"),
where all the clock changes were merged and the DT changes are lying
on the lists for allmost 4 months now.

I kindly asked for those patches to be re-send separately [2], but was
ignored, and the lack of those causes a bunch of DT check errors, hopefully they can
be picked for the next revision.

I did apply them on current next and fixed a patch 4 that
didn't apply cleanly.

[1] https://lore.kernel.org/all/20250530-videocc-pll-multi-pd-voting-v5-0-02303b3a582d@quicinc.com/
[2] https://lore.kernel.org/all/8e56e1a8-7b26-44df-ad57-e2092cb5c9ab@linaro.org/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fixed patch 5 commit msg
- Link to v1: https://lore.kernel.org/r/20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-0-a510c72da096@linaro.org

---
Jagadeesh Kona (5):
      arm64: dts: qcom: sm8450: Additionally manage MXC power domain in videocc
      arm64: dts: qcom: sm8550: Additionally manage MXC power domain in videocc
      arm64: dts: qcom: sm8650: Additionally manage MXC power domain in videocc
      arm64: dts: qcom: sm8450: Additionally manage MXC power domain in camcc
      arm64: dts: qcom: sm8650: Additionally manage MXC power domain in camcc

Vladimir Zapolskiy (1):
      arm64: dts: qcom: sm8550: Additionally manage MXC power domain in camcc

 arch/arm64/boot/dts/qcom/sm8450.dtsi | 12 ++++++++----
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 12 ++++++++----
 arch/arm64/boot/dts/qcom/sm8650.dtsi |  6 ++++--
 3 files changed, 20 insertions(+), 10 deletions(-)
---
base-commit: 6f66e22d741775dbd54e174560ae76b46750e570
change-id: 20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-a56291d959ea

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


