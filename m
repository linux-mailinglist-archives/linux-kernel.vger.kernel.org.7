Return-Path: <linux-kernel+bounces-723531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72DFAFE816
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE7058753B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A63D2D97AD;
	Wed,  9 Jul 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ob4PIReo"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865822D6636
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061609; cv=none; b=USMMzIsnLGbDHwLl1hCTeJU5HXL9bCc0bSKKhwxoAZ/x+gvgbqV9MBDVOdqZ/Tdeh1C36h7ZhBeaED4XWGyHqEwvIonYIiXzegJ4Un+FWlC3cPfC+D68rpGhv5YUS+8GBQvTgMpCoitfhdwQOZwWUA1TiDmHa2+jjp/FXWMIiP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061609; c=relaxed/simple;
	bh=g50h0b21o9jDK79Pni6TRJUIQF1PpFN5TZVZVqE7T6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o1fTipjXsnfsJJiDjpnPM2vqFh6go1szk25f4ay5CP4XXmhOzjf1lre6DTQPoEb+VvJCcb2/mYdEgto0A4NvK8KgKw9yzuuqU8mXIg4op6FBoTENbsjF5gdhN6zW+F1BZlVTUZ4pWPRyaym6i1I8AGnUX/vBkodG/WM7rKjrCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ob4PIReo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a16e5so10098318a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752061606; x=1752666406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfzIi1YuPj7vEDdWX0E+BtY/lnIkWXKOrOjK3rEMMzE=;
        b=ob4PIReobgG/pdtLop0zVpxlVA2PYJ9P9eMXRjHIQYUaF3Qi09sFBeqZMpJEL8t5tU
         iWQLg7h+/uDgx4Nc0kBOPf41al8aNhXqqCrVpX34UwLUElU86QxdLrYNGYiL26JWvbDF
         7dQtzM/tcyD6mvoJfflILeSgwPH2RQz1LyISs0luFddVM3WKh8JPRK7ObEB2HipTVHZa
         prJpy57j+36OoDLtl7FjTeVzuCo5ajbqhxy1D0hXAmxzLUt0ZG6Mpa8qgW59ztvUivlF
         WUIqC/5eBoniiYLfeQ7l+9juuhk7G1aJQ3ZdWxNsRU3LGciJJbK+g/t9rjI80MmS827x
         LFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752061606; x=1752666406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfzIi1YuPj7vEDdWX0E+BtY/lnIkWXKOrOjK3rEMMzE=;
        b=T0xciIQC6rDfzzff5E7/v/j3v0noU0dtjoLG3MtpmwUexKX16SeLGA3WlosMbouOhy
         x2rvuzw363RcBWn+qehZWpIG920T/IMi2kKiozKlhlYo4ZbO5XNBXKQS2X+knV0WcW3B
         18+XLR1RFbwMpzfK+8DEC/vpRYWQ6fJsbaWELH15uJulJxvtaTuQjBwourTXMDYwuK7E
         takuTlWKYX23YaHWSJduxL6iLFtDwQdNmuvr8//+7w5HkLG9SF3rE0SLijpjBptRgy2F
         r5Ovd9anr+vem97lRfgaAL5bcqQQuYu/YgFwGBG/RMY/+hygkl/wk/d7SU4uNlUptQ/8
         T77Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMpbcd5lQNgw0trkxbudVxm05sdF4crmqvPDAmdAN2Md60XjuiOxmo5HRWciTXcQGVQRkN3LtBZ/CMVNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3NzOjh17mCp3FD+xG1E//621iHefdY8nmjHFYC3BGDotpHzV
	oAgCZ8JuLDrqGpSAlqwAmps7aqtz6z9DIzEQQxEcgKx9xzrjCdCJrB5pFWzYy8JF4F8=
X-Gm-Gg: ASbGnct6nPZA+mME1WYiF5nFLU6qs84wKC4SJwRtuiGBKs8q8nsUB0mQ0Z+efXDCM0R
	LdjDij4bavVC1f12FAzsDE9WN+sW5rvEIqi1dgMWHuDuTqxZ5sXKtb0xTK4/ISYcvURKj7oZI5W
	RvR9HH1uzmGt9UI8G0IskkGPcx2d03OiCIVGR1zOTtWGeCHtaguRoXy/AgYZloFvOnlh7diwOMN
	27ABR92VdR4K7xMvmqby3DPWdDVV5Jq+DHSavckpm0jmmZJMYFWxKgajZxy1gajalbx23ZgSqtF
	ea+/BgHJpCMaJLG+OGj7anhgMjcXTzEcsloeiyL7zerhgwhp6ffihP11MIVyyBkTCmkPUZ3KD+b
	Iigjmqi4dIMdcDaHxjWXIw4LmVFv+ZW+b
X-Google-Smtp-Source: AGHT+IEKz0ezpWx63F7Bc9s8vjVt0t3vOlKUT+8PNrFet/P8kfDzpR48FWdx1BFlSEC/UY4y2HwISQ==
X-Received: by 2002:a17:907:d28:b0:ad5:78ca:2126 with SMTP id a640c23a62f3a-ae6cfba40a1mr220756166b.59.1752061605839;
        Wed, 09 Jul 2025 04:46:45 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692e4ecsm1102995266b.55.2025.07.09.04.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:46:45 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 13:46:32 +0200
Subject: [PATCH v2 1/5] dt-bindings: leds: qcom,spmi-flash-led: Add PM7550
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-pmxr2230-v2-1-09777dab0a95@fairphone.com>
References: <20250709-sm7635-pmxr2230-v2-0-09777dab0a95@fairphone.com>
In-Reply-To: <20250709-sm7635-pmxr2230-v2-0-09777dab0a95@fairphone.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752061604; l=897;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=g50h0b21o9jDK79Pni6TRJUIQF1PpFN5TZVZVqE7T6I=;
 b=yYYcBGUYoAJgY9qfpIoIRedVzxCinLcscXS9kcX5OTx4vF27NwVMwNcavqROL8jBlObpt3Sv9
 PBbf1cP2EUvBF2wdpp/RhcK4BUtUajso9ei2nCw/JbzwrSW/6xkQy94
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Document compatible for PM7550 Torch and Flash LED controller.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
index bcf0ad4ea57ea6dbba9ce71280bc3cb9f74db83f..05250aefd38575f00dfc73263f7e4eaef38ab565 100644
--- a/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
+++ b/Documentation/devicetree/bindings/leds/qcom,spmi-flash-led.yaml
@@ -24,6 +24,7 @@ properties:
       - enum:
           - qcom,pm6150l-flash-led
           - qcom,pm660l-flash-led
+          - qcom,pm7550-flash-led
           - qcom,pm8150c-flash-led
           - qcom,pm8150l-flash-led
           - qcom,pm8350c-flash-led

-- 
2.50.0


