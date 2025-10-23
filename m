Return-Path: <linux-kernel+bounces-866818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5043C00B97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBFC3AF03B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA230DED3;
	Thu, 23 Oct 2025 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="3buHssXf"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694530DD21
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218958; cv=none; b=LzAXXt7eFvtvgLKSS3U1H6mxfP2RYo8nS2KxbEws1fdq/j5rXDVNnA6DrJrgZgqGgnFMh36+oBe7IbPp/r/Oxlv5u7bCtXJCgS8wCJRG40b1+fK59tpDwzx41fHEGOYW0Dwl0EfD2PyO5UpW/3oRInTlArqjSO0/P9K4tiAsIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218958; c=relaxed/simple;
	bh=Ji+2OA/G77HU1f1xpLuadVpNWAo7bT6AM6eYU0UkkOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r2rv61y1qHG9Zuzx5RQfjhyQofgsvq8jAexfTf2xX0XDh1AaHoY4kq1CpGpi1gVa+ZP/SAMG+cw1xASj45a0rdvORhl2A/L7aD+Edd24hn5S9fL3E1q3u7kWWlAXi2LAo0YHbTWu9DjYLeC+KWDCbS20+v7gpMGhXdIg85/vpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=3buHssXf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63c556b4e0cso1406510a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761218955; x=1761823755; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvQpSe6/vMPCasxVcuAk8VD6h5eBPb8DgHD/tEJPhZo=;
        b=3buHssXfCjKtHP2jmBKtjffuO261NkP3J+UMUSAWZUCljSduxm0LdFlhCDyv+BHfsm
         d4nYP7uG1hIJAHzuxFm5x1DSGE1owOwHyBFDcKaumCtZRvOlUb4p8M7PSbx5ACdjMmuO
         TV9yMTR0FvnNpQZ17dxXpPBcokgfQiHd9MUyOArCLzUwFdgTnNIkzJRLMAvKruBzPzY+
         nVacZXVB9/omweqwtxUNPCcfTUAszhL25MSrvteXcV7JIqIfz7t/kR7Aktwr+d7o4CsQ
         BFmNFJHKYYMmxgI5xVVY/RKUXuQAVLCFvrVJrIbu+e+L8SEX4YJy2TH19a8Pwl0k34YF
         uu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218955; x=1761823755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvQpSe6/vMPCasxVcuAk8VD6h5eBPb8DgHD/tEJPhZo=;
        b=IMHyAdDeBh0qNY8Fg8WO1mqGYy4iPgfZXlZtfWTE1nRTR1bOiF8bwQ6zuvqBhKDo+7
         SXblPrZ+9LJhgQOHrXs9x4ytONmFN9JWMBohC3EPhBHQnpX0hjH9TwUwwI3enYlTbsJf
         /P5ly3e6cf2HrlJ/s+NYROSS3Z57iB5+32/ERhktrlC21PdP78aclqsQP75bVz5OVJ+z
         AH0pHf3NTdAMT7dw7aiRV2a6AT89e4OJ0cm48VuL6RF2DrnsfT1+YHG7EImJOuXONQWY
         Wul5QpjSj3BEjYPKSappLg9VHI4flZZhaFXgfGJkC5fncTgvvCxQJqUInZuSNkys8gSf
         wztw==
X-Forwarded-Encrypted: i=1; AJvYcCUqWNy4+PLXHK+dfHERi0HxsGRc5YFtiCBaFMkidcH573bvB+RS6kvwfyZw9hwfTTNcx06e9ALZO+uEeVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTv+nR5xd9nZi2c78hY8wk2882plv1zPhLUn1SWZjQqf6JB4MM
	kcDDckNXVLb2Qb9F7GhBV/vEds2AoQcqGh2HeG20PpqAQPa4bFXcCHo+7V/ykQEpnjk=
X-Gm-Gg: ASbGncvXkiQMZeK60gW8FTBfyQ5LZgfenl2Qxfv04YoO6DPcE46eSIo6nlPPi9X3p8f
	MGwKWuRjc8GitotkXoedUFPvRK6l+m+euWghvfgH8P09UHJU20Xx/gqeGBAYmVnEkoS0R+I1pwG
	eZSkij/1A2ECkRQ9h21fo5htKsBDCkOEqAS3gqj7OxOSFiaIDJpx941mKrbq32kHpNPzYNOMJ4X
	WO54Wg3iDS2S/PLFIXP9nKfEvrwJi29MbZ7Xk752MUx1vGNiiULQzMRxWDp7JU2R3ftHymVUrG9
	ivUue3TcDzBzvT668/6SOTmZ9KsjG6HbpIAtKl5ldNgo54C3eo5td1Nx3FABpHOXDHwvU2Xum3b
	giyaC+a4s4KaTFSaB4ADNm1wWPHmHu98o0+7WUGZ687g5m927keDzYDGZIYIfwyLiv3hq0A6jPV
	Tk6IX4Lu+xGiazK/vF+kvmjGVO+gEbRcTxotrNbovHs9RiJQ==
X-Google-Smtp-Source: AGHT+IEAiF4kvYBagBPtSGcpjL7Owqx9cK2+EGyXrrsdo3qMlvN5hXcuHy79E89AMKx8P7LbEH7kPA==
X-Received: by 2002:a05:6402:5245:b0:63c:5f76:2d22 with SMTP id 4fb4d7f45d1cf-63c5f762da0mr16853069a12.21.1761218954952;
        Thu, 23 Oct 2025 04:29:14 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb328esm1439098a12.5.2025.10.23.04.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:29:14 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 23 Oct 2025 13:29:01 +0200
Subject: [PATCH v3 1/2] dt-bindings: mfd: qcom,spmi-pmic: Document PMIV0104
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sm7635-pmiv0104-v3-1-27f1c417376d@fairphone.com>
References: <20251023-sm7635-pmiv0104-v3-0-27f1c417376d@fairphone.com>
In-Reply-To: <20251023-sm7635-pmiv0104-v3-0-27f1c417376d@fairphone.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761218951; l=836;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Ji+2OA/G77HU1f1xpLuadVpNWAo7bT6AM6eYU0UkkOo=;
 b=MPKa1d8RVu/ZBgt2nQvrDkRsX8rNCMnUMowVQCQp/HH5c6TMQ2gQE1Hwl53Pawo48fFQEIwpm
 if2t3Ddqt+ODHFqy/zXxyPgmOzEHTD5RJ8SitlU0LY656KQMBe1XgEW
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the PMIV0104 PMIC which is found on e.g. boards with Milos SoCs.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 078a6886f8b1..c416f25c90d6 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -84,6 +84,7 @@ properties:
           - qcom,pmi8994
           - qcom,pmi8998
           - qcom,pmih0108
+          - qcom,pmiv0104
           - qcom,pmk8002
           - qcom,pmk8350
           - qcom,pmk8550

-- 
2.51.1


