Return-Path: <linux-kernel+bounces-775810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2206B2C516
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE227B73E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99133EAE2;
	Tue, 19 Aug 2025 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Czx+qDBG"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCBB33EAF1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609407; cv=none; b=tiHFk7+MeJZL/9+cz7/LIGRed6i5DzexTvkTao3vXqJP0+I6fu1aV7hds7pXIwOixI8YJzWJ4eH/5SRC+qZjA8Yp8TgtjHZsA0QF6EBGOMWAaXGoK1e/Qvl1iN2QOqwwj3bqpO0MgnZdAxShkONHCWVp/cthqzQapJddfDtTUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609407; c=relaxed/simple;
	bh=GuIpDTrIKMYk3WhNZGOiGrIbDEbFiSVL0yY6nh1sxyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+id27SxoQ1rlkMIZZwVQVUHRWGSrKUWCZfDn3pdjDocXMqoydaoTxEn8kN4HoSxc83Wn/LjLERC0AQBGiEtE7y1W9L7AURzAhGyFCYlJ27ia5F0NjORce+AGyKnGA8fpnSLrKyRK+d9lLWFdkYJJQ0YV6O0SPCdO2w0NN4eqY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Czx+qDBG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b5e3de6so676609a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609404; x=1756214204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNcHUwUSUoXG/NU5XWsU2yLUiTQdEs7s2EmvbkhBOOs=;
        b=Czx+qDBGMPvMpENM09UvM9TjNF5h+m1IxyPOZpTF0lQzYQGmAPMnlqMF2LjF/KbT6x
         gcOT3qOTFK36WCkxkBl1t6/1NI9tvZIl6yUivkdDMZL2mz4qhgwwK7+8pEMfwYxNadge
         S5NhRliBUmLiMPXBojaiQBVYwtbfZlAKycDpbvTmOrJ2kqe1gNulHq2Esjv2h2+GWrpT
         +lp+RGTPakY86fYniHuT3hb/f/kZJeUv9eCM3yTQ+0UPxLHOL7qP4In6Kj6tI/f+OpBq
         q+PGHZfO/MT69g3vMtZ6/RupwxLSr/h9aZZuuwju3kpIWM8UqmSkLtnW1jNPZqdKZVic
         mgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609404; x=1756214204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNcHUwUSUoXG/NU5XWsU2yLUiTQdEs7s2EmvbkhBOOs=;
        b=s6xrcwmXulCHBJ6v4M5Ovt87bwX7jqM+/nH5Jaft7lZP/7uXI+9zDjcP2fnGyYmL0k
         1zR7b6TjCoYxghxauS2FI8ZxbWRCndvKm4njuID23AYE8r+NtDSu7ODdJ+ag3mQCLUud
         EWDsrYjtk4fMfscgSNkDBPoQsTGjjH60s4WWhAgnl7/gtCtboRkQZylXn+BvKjMmrRgo
         AZh0q8c1bWMSK0BBAnyM32W2tZDU10ED8Y8XXxxwYIgujx7Iqk0Qnpc4LRbP3oXhTfsY
         bLMulLrlbs/G4O747wZxg1GzWoi2ZTYKtKplIgI0hUuXOzif/EfJbtbf+YilRndLF1ti
         P7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu7rAzGPL4yY8Ns2HNXYCd4I5+Qalkz05kYqdKZ/cecmhh3cK2FzOE2z178o24Xn6VvSS2cZr54h3Tqxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoACczQi1ueRzlS8zC8kig9ihHONBDvRiWLCdK9sInKSyxlG5o
	KyUTqn6vNIXj9lFwt6QwWSVj8qefkRg5+K1tYOp/mggGq0oazw1TjiTHbA/kOzkMwe4=
X-Gm-Gg: ASbGnct74Jup7K/Et/rACZQ9jGEhwA32/1jhZckxUs413BDhOgEwRVMkFPUUD/ECA9Q
	AW3t3XAObXh0LySyULRYgV1tLdXpl/sO/afksFHJwjBQpbnUJOoAxiWzloxNWVSn+o548mQgYwO
	kQUBKQJXvw1XsLZ11CI6WjpJfJyu4O/Z+mtXZ6wo3ubByJDHr+n7+chj3KL+Qi4vCvilPcPxRGN
	sMJ39xKoDpvu34e5ZI8y/AlZx8KbpLrz4mRyHp7Ij1nA4rh4lF75txazKavoZODZHiw72VEkEGq
	zrmxZ7/Ia7Kw3xgeW9W76tt5mjVnVO152gSAm8SQJw8xMSdvOtxGAWh6tE6yINtmAUSYc58Pwev
	1YAC7qYfMzTDA/vDbUoCE/VmHtLHzP8XopQ==
X-Google-Smtp-Source: AGHT+IHr5vEYmlpLTI1y4MLxEE80BWKAd2JViKb4VuSRUFyaMN9Jgc15AWVrSJjvQAIQU/3UzhdxPw==
X-Received: by 2002:a05:6402:42c6:b0:615:7ba6:4876 with SMTP id 4fb4d7f45d1cf-61a7e7840ccmr1220925a12.8.1755609404319;
        Tue, 19 Aug 2025 06:16:44 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75774623sm1703971a12.32.2025.08.19.06.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:16:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: exynos8895: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:16:42 +0200
Message-ID: <20250819131641.86520-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=836; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=GuIpDTrIKMYk3WhNZGOiGrIbDEbFiSVL0yY6nh1sxyo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHk5GI3dFwiPjFb3vzq4sGFQJINn7QVqknaof
 HKsp/nfVamJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5OQAKCRDBN2bmhouD
 1yh9EACVAlFJ4VV2G2Szbi+YZvBSwEYs61YuY/gO1MbCCw5YImO/uPqlyWu5egLzhRHgR0fMqK3
 BKHYIqmiOQUVJzEl8BqP4otG8zdAklN6VJie3yszDwqjl4QqpgkUsjC2j9ylY16v4AWpQJ91DdS
 2Z0ikvnkKE5VMzqY+E/FhcgEyGZhSpjBEUxXPUHDCX4H5lKXuqLgDmxjBYw9wuTaY8tup8fxam8
 oIHIUbwYWWh+FRPbSzt7xfjxAO0dVyBcJtWa2r26PxUd6k77AnPVr4QUyI5gv8fohLgSfbojkP4
 gpGcHS+dQx28fTpy5MD+/Br8cNUosTBljYooPZielv3n48xoSgJudgA15MhN/Wwndu3AEzQMhAC
 qif8Uj2OOMOq3ZF/4I3TTw0KpMXhqPqueQk2Mc8HM6CzI6QlvkIW2I30/qOZNtXC7aF/SbOupE5
 Bg+gG7nt0TpqzdCHzvoSe/OOCpspHNsjy25lTwzG2+SJf/p/bq+XgrGBPzOmUhUVU8KSaOMTiC2
 cGCAot35vTYkWjMU12ouZMA98jPoiI+yYeKKmKPmCt0n2jme5+zu8qIHZgTizRz9J3h5nPXj2IN
 RzNTTVS87Twn0Tqycbha3ynfoQ74XdCAG21f7vZcnwRJnrcPhYL/sQiNOwG4x4O8pFkj9DQ4EZe 39VgAC5NVW3cjPg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi
index 51e9c9c4b166..16903ce63a32 100644
--- a/arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos8895-pinctrl.dtsi
@@ -202,7 +202,7 @@ bt_btwake: bt-btwake-pins {
 	};
 
 	bt_en: bt-en-pins {
-		samsung,pins ="gpj1-7";
+		samsung,pins = "gpj1-7";
 		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 		samsung,pin-con-pdn = <EXYNOS_PIN_PDN_PREV>;
-- 
2.48.1


