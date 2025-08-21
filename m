Return-Path: <linux-kernel+bounces-779914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7352DB2FB33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAFB3B2FD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AD734AB11;
	Thu, 21 Aug 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keCbdRti"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25034573E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783459; cv=none; b=sllg00AMPL4BcIrprasbuTRs0CQ0doaa10TAq9NrkeygFARaqESfKPxf5wsGOoI29C/gUgZ0As6kBTJyDgyMHL47BXIDcuU8Opx26oY2B/csXgjMo4XS5vUT9dchrfal+SWjWsjWKY30ZSbeHbfXaIevFIbYetSjRMdGb0QaJvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783459; c=relaxed/simple;
	bh=33V6vO8dY2xO/0hImlUa4h4K6tSixB5izhQ3YWGUhF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PA4JVQQc6q24avz9JpMJ7zYYW/i7x3F/z/zNbiMsLuHmilCZp1gbCfB51AWHRxlvALvyxZyLgVRcU1gcYI2PY2bJh3z3Vq4jIITQ4LzJYXdGkVomLa5h7ESuQeQd2yRFZWr3lFdI+NY/MXndexYexJf+9WZiY4O+iboXh32EHa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=keCbdRti; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c43399ea42so711996f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783455; x=1756388255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FN3M1ELHzNZvl0HLZKgIMT8AvEW6zwa4QCuopr7VTZI=;
        b=keCbdRtiNSgAgT/Q5bNHzXraBNBzHO0WrjwT4rwgxyx6RHe/9Jr1RRkZKpv7ujR4Nh
         dXgm06WRbOcA50CTlhGezYPK7y63gVTGsJprv09nU6hzQiJiTxXRicYev5UnBlDjf5t8
         GAt6HP3oAGl2kW0Qyni7vLfcUvyg4RDYShMOVMioabZdcKFhANvnL2kHIF77Lyj2U946
         8DrY1C2BYRflsOHMPMXIFxesgeeIO342Opxauip3yjze4dqSyg3Mrt9YR63bU36B9OtE
         VgINz37k8DRcAHVU0yJvKLWhPEGNZeHjDD7cZnNH4Jw3wSnlL9B1yca3j7P8IHQes2bp
         Topw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783455; x=1756388255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN3M1ELHzNZvl0HLZKgIMT8AvEW6zwa4QCuopr7VTZI=;
        b=mQMv4PgzHNXDx9PW+ZMbm/iHX8ewxIz6DIimRQ61Gj93cyLCRpnMfp+rWT5FJ7VO9Z
         rOfRlwYjOeRS1cnSWo0PKxhPI7U3m2IZXwNDBFvvN9ijRnDlempRbqWO+xIq9HVZBh24
         sByDzN4DQTvHTv6E3Wx8qTdP7k0U1V0V7ZZIhZtZ79iU9LB7b4OXSncMxN/OsUWapdKk
         1IOw8VK5DQB3JCg8JQe3Fla3eqyPDlmeC033zw6845dePSJb9Slin/pOoy/HaE4hzHn0
         czElbMBFHNzi4n1bfbWDK3S5flSMpjdx/E8cMsKdPySMEu97xman51snVSbUMw6ak02Z
         Qf+g==
X-Forwarded-Encrypted: i=1; AJvYcCXU3ezAFdvRalZSZHqSaIgCh+GAVcAUil92+Nfa4fWk/QEV7OeEMce4fCBFsiRSUDobr/HVv35vt4V4EeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9YrVh1NaloOGmU70IhD8P7t5ylKco76KHVKH08DQnHJvSWgS
	NVrJSqiNLFelJoESL9ixTWgjqcTafKHehGnjuFyTy6ucYFKQNW8CuHidtTsjDmiBFlA=
X-Gm-Gg: ASbGncvb0SW/degdRlalquudsScgxsdtuaZLW0oKxwHMrcJ/YYfbKrMw7SRItrmkiSh
	gRTMZx5Hx2j8jtb5PPKDOdQ3k1n1V3DYrmLY5X38/PwxUKgh8C7rH8isksq2Xkq3CW9PMrPEK+o
	ELbLiGv27nk6y/hB0PPCLstDAZjWU5PGhYbW0oXA/wjFuOwCYIFbrWGgKcPlCvx0xm3MM3MSJy2
	34t7hKZbULfGcyA+rC4w8jxqdWExrBYQr6+rgMa6Q2804rSiRJsbsK9xX6g2dVJ60rT7W0yLV/M
	4lv/DgXIjkAUpIIHS6j28trMrvuyxjfr+NzndNhmSI9CP173LPJOllTnbjDZhcBZrtGHKZyCYig
	Gkfmx50yHIQ+BSUHMUW0913gp3KkUuNnEmTc2WYkQNnI=
X-Google-Smtp-Source: AGHT+IEZQjhC7XeqnXNCleJsATeP//d/zJRQS4uFjvJ/BLGBre/bly9A8aoj28lhG4LujxbvPVWfrw==
X-Received: by 2002:a5d:46cf:0:b0:3c5:406d:aebf with SMTP id ffacd0b85a97d-3c5406daf16mr1220179f8f.63.1755783455527;
        Thu, 21 Aug 2025 06:37:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:35 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:23 +0200
Subject: [PATCH 04/14] arm64: dts: qcom: sm8550-hdk: Set up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-4-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=734;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=33V6vO8dY2xO/0hImlUa4h4K6tSixB5izhQ3YWGUhF4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEXr1VEslWyONNVDdpF0ska7gFINWifaa1BfQB8
 OYoFLvWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchFwAKCRB33NvayMhJ0X9wD/
 4342OclvtVQwK6qp+mEQZjxslzW+BxFOiVncFvE8qpeLBQmZPy3HoTVxBoXud+jcRsR9C6c2Cloh9p
 7cTJ8PMD+ICsp0+sapRJnNJtzRkFlx8vLzrueao26mnTNPnKTsbJtM9zeo+aZRERMoKlevHNPtqAyg
 BFVl59DkokTZ/tEMV1e27NVl+ni2jatJ1b/98XxyDJnU4NgGyKxnnqjdr84+ckjXGfCjVlvGB9VNwn
 t4D4KrMNwIF2/AFpGBC/GJ/R2z9FlZFFH7+tlI3/1f+1Vqoxby+A5TrDrR+mzXp+iyCpGkuAlstILs
 R0CdGEgMvB0oOD9bHySDwkzs8Y02M2rBx6RjcVSssYIanZiOGxBM8nCzdU7vGYFuGAERXWlIR+RQZC
 dVSUPXHkWaLpt3s1MbvAeP578cvUT75B5fVm3aCnl+PnzqW+AhZqhoIR+POSQfRKZe7IoH7/Kxik6K
 RjsQPKx0+4ubC9jjj+2QnQK737Q/exHLB/wn6XATms9XzLaqSvtud/tp9wK+TZjI8G3rxzT2uwZ3Kk
 aKQMqpvlcog7GmpuVqV8sszCf8xgGo1vobfPUOFpLjvOsylMk8SZzVEoIqvp8fY4Lp+nzW0rTycUue
 K7PaBVmYP/b2ojt+cRcFBf8FeRgtNfP1kx4KddgeyGgcdmQzpcNWxSscCbbg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 9dfb248f9ab52b354453cf42c09d93bbee99214f..6c2c9514a7396a8b75ebe24585b47571c74ff568 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -1003,7 +1003,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 };
 
 &pcie0 {

-- 
2.34.1


