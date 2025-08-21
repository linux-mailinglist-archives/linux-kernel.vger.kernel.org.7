Return-Path: <linux-kernel+bounces-779921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DACCB2FB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2652AE580A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A323570A2;
	Thu, 21 Aug 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mh0wcPur"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EF34DCFD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783464; cv=none; b=Ui8iOPCLqXA7O/u5uglKs3XGKgp7fLhT3NeMBV98atCoqd+uBau4NjWh4x0pvD3IoF0TDl/73fqMPBG7+FcE/vgo4Fk2kNzM4NRSupvTN4RSFM9fMK06JeJzY2CMZR4Fwsw376XDsnZIKlordq0hcK7DHXUA+5CVNOM3kK8MFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783464; c=relaxed/simple;
	bh=XnG8D8Z88eQIU49PG/7dMe7xnqvu5KLqqFXsnUqNrnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HXOGD9X0j6oXIG2podKW3Mr0Ga10T5xItDy7j6kQSsAt4AS4tHqjFg/SbelcdziyasDW2y0kgsFGbCgLNkAmDunjuWFdHL9A6WydA7uh0AuD1rR0aEqiJ/5GRY4pawHGnQgzCaJRqzIYXHueZ5TKzCAfetY4eZUDLYZvquAIdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mh0wcPur; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso5072805e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783460; x=1756388260; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0n5vgZCuc6Zp7e2AYbn/NQMbYtFdI2JHkj77/HaE12s=;
        b=mh0wcPur8/+iyNbWORGm1GxrNbqtWvnYpTLjnThfSu2mo7k6hyBdh/7lat4D+jflSP
         M9Mdzs+ivCJ5CJYImdlw2mTN+eCATT3qu+7tBxXaUNwbNF3qojLAsVvu4yoVu2/tctwb
         zQw2CTJI+P9FyMajr+ZRE/azcVr/vISICOvESlxxF1on/mRtdl9f0TNrmVyZW3I//dVH
         rljC+OburUFe9zO1mXNmnqB4Cnowm/7iLvC8M+/Ldp7CNKqQh00aC2BFb+nd6m4HAnGN
         pieZCaTpc7pernCGwzL6hvcCrnOqGT9sK4NKlzt3qLTgW9gVMhtIOU3NtgUdhEYOeS4+
         cXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783460; x=1756388260;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n5vgZCuc6Zp7e2AYbn/NQMbYtFdI2JHkj77/HaE12s=;
        b=c4/bnR5JOPH7upyzMVbx4+KqTiQjFyCTkoJ2tIZtNh/4h7H1/qaGGGhM5hVm+mSxq8
         g1odA5qo48R1SPynl7N+yDPYu4wlOKBrW96izLBq1o3j3oGw36F6jFCbZutGyX0x8gZe
         Dcy3nZsbtwzNnakXbwc2nrOOC6OHEIe1dPECjZzRi0/OLF1w1Oc440mi1cCm6Pecj0jg
         MSJCPBtTQqRFXeIccw4wIkIF72fxKrvrZgK7p661UCbflQ/Hud57XDmC7uSCwwuWzmqv
         4g5jta9oP6Bag3tRNXtydd+MGzOiMUZYGUkbiKgnoXU99HaOHi86VaWZjoVqmE6dhd2v
         D5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXU+apQgB60MxT6YEbpvGZNnM0olF9ZVBJGBHS0farYpMkLqIutq4M+ttNy2bbN7RhHvlA0AShu5hGwctI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLS1p3zOhnfZ5F7G1Ggr2oQQ6+aqz+Nxjy3vF3VDgb9VhPdsR9
	7naJvWIJkjVnrxepxyS7eV1VjMlzz9IrF3FtUCrwIS6d7Y1YYsZOu3/z44IEjmaYx5k=
X-Gm-Gg: ASbGncvLuuIHjGp7DFpJQjbvHkf/KodAPrbKJijuwfzUHTBXAytZm6EAi4q8pTkDfe+
	R5Aar9YVHoGLwwzBBO+LsH9GtWxBZ86QHczu3PgklXW0eGfkSLDt7iStvUSvvH5vbRP6Zk8SHoz
	8csvJP3ssVnaT/87KL1AotWLTxN1cIOv37qkryyiSRZHafX6IAQpPJoVXqbgot7kAXVIrdyD5T9
	qBqM95fz/ts6P5DrwUq+VARmpNnzZT6FxNpFQjIjrU29GlQ+8FoXgH/Bw4/Z5UAuiEGvoafXVJs
	Kz8F08dGUZSU9nycWIU1GiuCpBoKvHYA7irX1GeuR/m8/tntcs/kzxUxANotu83y0MuD+VF/01H
	k2llTXul9KwWIrDu0r3EZyXVzyu73r7jrOhDXP8onQbI=
X-Google-Smtp-Source: AGHT+IFqD7llHhzk+1jAUW8V0U8p8rCikNUfq/3J1Rv2WNpcmCukNyxfV/L5ski5EeoSS60HiNtf6g==
X-Received: by 2002:a05:600c:3b19:b0:456:496:2100 with SMTP id 5b1f17b1804b1-45b4d84e6f0mr27751175e9.31.1755783460167;
        Thu, 21 Aug 2025 06:37:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:39 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:30 +0200
Subject: [PATCH 11/14] arm64: dts: qcom: x1e80100-hp-omnibook-x14: Set up
 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-11-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=XnG8D8Z88eQIU49PG/7dMe7xnqvu5KLqqFXsnUqNrnY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEawqv+WwSoP0xut2l5TXogzMXYZ/3IM278vlrs
 g9a+n6aJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchGgAKCRB33NvayMhJ0e0fD/
 0Q15UKMxvBB0mOvrpgf8mgROi2tOgO8LutI66Vejcjh1nKsM+dv8EJkB6V2qJ+xrPSnuLLw66FzaKR
 V9jN0nU8JxAgnD/eQFhzDwejBJHHJww/viIViUWXaYGYX3Etit7NBjKSPUalBt/5s+RqWPTSBB10SB
 CPm22HhHu7dj4TTq2RRabt4Mj3UI/vqjXbTpeHoEOo8cVIH//T1HHmFmsX4EFH+0RmKgsTFslE4XO+
 6vSAJUeaR47rpe0qXO5CysoDhP6tvNL/sZj2xFU85AtUnecF7onY+YjJth9WqJRTC3BUG18mgeQwNm
 wzXy3pCHuOsG50qPx2OJyw7Nc2IDA+82FI9Om0btyiI4gZ665Pq2u7GuPPQB6jhP6j2KHNm6LhBele
 jPCX9OltPPL1OQtYr+Y2p/XhJdPZgmjqsYU76MZIIBbxN3zPwt26QDJT20FnjUGsxR9qdlKoT+Aigo
 0VZRIvuWDIoh2YxlqPTxpreuvafscwFGi1kdPQkQE/eSsBdoU/kzDUbVz+nIcwBRA5MfI3sbL0Klxt
 MfGh6t0dRw4Kw9A6Pmpv+z+qj8II6tt+OAZzjz6q881cvmqrJxvUqvuH0MmsAW3ctQ19WulLyI/NjJ
 eaN+5cv/uS+uHj88k+U/VEByts9XVr78o5lRLNSsZe6F0bIYjC8dbDLIah6Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
index f9ce2a63767c151192b0618ee2154e8d97316c1b..e1116ca9c0ada2431d36805e20535e2edca62b31 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
@@ -1028,7 +1028,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1037,7 +1037,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


