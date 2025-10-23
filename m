Return-Path: <linux-kernel+bounces-866835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D02C00C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12D82502DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7096D2C325C;
	Thu, 23 Oct 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="4fktc6SY"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F027054C
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219168; cv=none; b=sEbCsyMWpwhTVp5o29K8nGQZlRgkOsUNV7SUSFzjusuNtxm0Jim4z4ZpaIYNe78jViIqllghQh59JoRkm4x7729GJHwJL7q8GtBZdjF6XnoGbvnJfh3xjpc0+ruZAHMhRtyxl8Ml2AnS5ELMGKrT0/9mL3QN4hARfrG6ZCjd3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219168; c=relaxed/simple;
	bh=3vO33C4prgEUuBZnqq5YTa/P4+mnJCFLtkGeOswFDlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ixece0+69/JsBuQdLxOObRIzL/+UJ5+95l2UVP5su3nkosTx2hbgfRcLD+0Lr4C6NLpIDngBG863BG3hIgBns7B4HlcsPXOOUlV2IVHRQObCEjDINy2hOx8vorJp/5CfMLLXokY2DrPALa1HWgypD1RgaWPfaqN8XCcpQ04hS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=4fktc6SY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b403bb7843eso145507666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219165; x=1761823965; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qX6cAic9M14UMmPECgjQFR7mMda0Cr1cGqbVwyyhOK8=;
        b=4fktc6SYNOhO1951KVSv9Yyv1Slytq70Km0JZtnk8as3vXR7bV/VQB3ReVus+CrePe
         MnthU/NN58Qqpp4kMaoj5ViobTcFfo6YGo3g3Fq+3B2RIayduvJX1Ik6cn1pBS+p5Vnh
         ahOpaQa7VlQF8xsgCyUaUBWUqwy7ZziA29HP02vBr+Er+YjrYG/nOB/BbN4jBvpKjQX3
         mU2uoInOz9Q5fkQGH2V3rQ1UO6Ts49esCIHEJ9Fw8C2JV1BElU3kxE6KCGIaoHTJ3T0t
         TX/vEhqKJWQLLSzKigQgxqB+Ing0cQsqZ2t4Pd1XbgNxdHTBCLwz06ZA3tGJRksN1SKl
         xnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219165; x=1761823965;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX6cAic9M14UMmPECgjQFR7mMda0Cr1cGqbVwyyhOK8=;
        b=fU80BdPfBYAfBhPoVY50XYShPgrFJh1vQpsXhmRGphqtiwdnCQxnolHxRS2ZpAtwPa
         arhczJcIu6yuedYn2HYHI5OmcYZj/zWoy9tCPdmHdvXRMS9auhhnLpHiMm5iVc++Azl1
         Q1DoLbG/b8LzowjEbSAkm2jr8oXpvnbYE0KWKWuBUe034mAKunrgnS/FDDfIrYDvU8jY
         lKlFk3iR3BeC6vZqbROFO0dj4qdXFmaZ+PzEsP1k23deE66sub3RAhd90mX+KhJtxkXS
         jVPBIdDZSOQMKnZi0ql2qCaUrvfiAbwT9I5ltevioDNF47l3HBis48QUpbxlmAc0a4pb
         cwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVU5l3PO24xgbhEDz2BKN2JSP9u/6wA904+xZYEbXnx7KI2NEbU8dW1a7U6L2rdJ8Mq/RdXc//fJCriTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMOpiZK/G/AGFb9rYDJWgNat1rQhi5Y4DEj86BjW9mxu79Bhah
	8HWzJ19WcuuVXv4BzulItoPBJRBoh37tSPRviQXCNF6y/TyjSjSMdlv9YTwsfHasLfQ=
X-Gm-Gg: ASbGncu0yjXBnolLwI7XgxPH/YThmDK1tu1glyVpLjsuQSRn4k/60+Jwotj32yGuJN/
	gvsFet2AIkIUI6ooiD4KaP64tuJzBogb9lCO+Rq/RG/ikeU38KybaOYN7H3YRy0Q9JzCe2WV/nU
	vZmm83HrHUS5sczwwYAIlneez7bfH/iuF+8ngouo4Bbq0Qv+Q/o/Nc6vsEXyJL+1hSirbOwhj0S
	7zCKd6b1U4hxbQVgfRZrecuwKMgjZMdTfobZmazbibG5GOD1gos7KB0QIzIMEcsOq1luQKqN+Hw
	iCi69HR5sBG1YUPVu69BjY9hI3jckl49wlBpKHLUWakqQjlU29ZoCGN8fbAosoaS4XoiZOqp1qO
	doB4aCJt6WIbG2LlSoJGhlPIzVUc7NT/vWwsbxFfUGRpRgFfpSqnkjXlDCe8q+UycAFmYenAm82
	zgKJIFqoIwrHtDiGdHx/AGAf4VPKTKAWrED1ukk9yiTBBPVA==
X-Google-Smtp-Source: AGHT+IFeMmUZAb8+BZ7S/5mq8JGmfL733kMk+/2+3OfwZ4fzPVXJfBgAIEpqIhkY0LDxauZHEkWl1Q==
X-Received: by 2002:a17:907:d1d:b0:b3a:ecc1:7774 with SMTP id a640c23a62f3a-b64742414a1mr3091546566b.53.1761219165148;
        Thu, 23 Oct 2025 04:32:45 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d51471ef6sm183087866b.72.2025.10.23.04.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:32:44 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 23 Oct 2025 13:32:26 +0200
Subject: [PATCH v3 2/3] dt-bindings: mfd: qcom-spmi-pmic: Document PM7550
 PMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sm7635-pmxr2230-v3-2-f70466c030fe@fairphone.com>
References: <20251023-sm7635-pmxr2230-v3-0-f70466c030fe@fairphone.com>
In-Reply-To: <20251023-sm7635-pmxr2230-v3-0-f70466c030fe@fairphone.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219151; l=796;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=3vO33C4prgEUuBZnqq5YTa/P4+mnJCFLtkGeOswFDlk=;
 b=76fW4spLjf7RNyBrxeu194Jp/rr6uFxjDGE6H0VOOQxTM9LtGH9CG6F+pNst1snLtJ/a4iDDO
 IO3Be+jDDWXAFlx4KWtCm/znytapYUj60QEsAtNN3r1MEo2cnVwYPiX
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document the compatible string for the PM7550 PMIC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 078a6886f8b1..d0c54ed6df38 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -43,6 +43,7 @@ properties:
           - qcom,pm7250b
           - qcom,pm7550ba
           - qcom,pm7325
+          - qcom,pm7550
           - qcom,pm8004
           - qcom,pm8005
           - qcom,pm8009

-- 
2.51.1


