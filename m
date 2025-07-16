Return-Path: <linux-kernel+bounces-734365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABFAB080A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 00:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC670189862A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54472EE989;
	Wed, 16 Jul 2025 22:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SasYj44G"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965502EE988
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752706000; cv=none; b=DRUNHD5ZZoTC6FOGY8PUfCdeKOXnfoFdpsNddOVGj6K+hhH8ApVWTQobebSAbqR19fhadhNzHoLSiIUe1hbLnB3uJN0Upt9IFQKA3NP03v5vRkb9T4TtF/RWeSzHo1Mi7LLlnO3buIjiLmr4eJs2Q1CFbQElhONi2s2QO2aqE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752706000; c=relaxed/simple;
	bh=S7zflZfckkjVA+Sb60lAmOii8syH0HQaukr1eAjN8hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5qp/o5HcQkIM1qWQsCRAuGozElzcVjsDNDP1o9Y/FSMMrfZ5SI1ifoYjnhejAgChgRsr2WgEmlbnK2NgAtuKYjsyNTkW1AbG+5JYt7qsOVzQ9PSwdu+NToDGAO635SLiw9iaEgCVZA/l1QI2tOuWEXJ0hevgaiHfnqgoWKt1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SasYj44G; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40a4de1753fso243773b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752705997; x=1753310797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0u/YC913AnORCbk7RT9GNyXowu0h11qkd01RjAkHwZc=;
        b=SasYj44G6ucWOtkBvOKXR95q+BDzlwXUZ8B9KNL3DVYQPcm6YAfU7dopq1Ali7BE53
         meIQSJ3IhpPv3xWVUUTjG1DPKReyHysXHt1xg5UN+cDU7PXIrXdxUImPW5Myber11Xtx
         NTh4UzrKOj8iXOW3QwhJlzfEOG3vlgWCnO5UxsoyjiXNFhxJC/mg2e0m7+G1iKG0egCu
         3o420XCy28Dfmu7e/BIbmOWwDHWde7wcKh+01fiAAK3RQEZ7A83YfSh31WbGSaeOGLVg
         bdK7588P2QHXYX7AgGaOEq7W4EyXsgmbeaC0yu5hmy1K/ZzhIgHfnZlGrFe84/545Tsc
         frxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752705997; x=1753310797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u/YC913AnORCbk7RT9GNyXowu0h11qkd01RjAkHwZc=;
        b=EsDCSTYAbdkMsN/e2TdMJvyl2EnxRBAZRAAcfHJq9s74sK2DrzbjMjeH2/fWrd8M1b
         Jxsu7Tw347pTVtasOIB7dFUs5FU6GP5P5GMAykcC/8TaBKwHkWG81zBAekUXg4RAfhZS
         lni1cfm+Lbramnzt9R+2PgL/GnAtoKe0ibe+IL0ZgW0dLrJ1he9zIapfWO4ByZ6xAY4S
         xgktX7vnWfMIBYS2t6jXdd5lVv+km2aqdFVR8PeVJvMxoOveba8Hlz6zRZR3MyuH6RPI
         7jJF8KDt7XwjBOCoB2ZajqvHrKo9A2RcSK+rMTavJRYhdOMkdqAS6L7FUy2vCl5ArTbL
         6kTw==
X-Forwarded-Encrypted: i=1; AJvYcCWf1ctnrpxaPTmlcdl7sf3tNilDdqKg2CBxftYwGgiJMS+8r8ObahLcLSG0L+SbAUZYQBZba42GoDXW9hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaX3toWnS9E7s3PzKcUQqzpxXV06I2fFNu9TVTGWG6wzfZOYge
	O3kfB6wv7Vaw9kvKFwwPmlULlHqx5qTwz5qpGqiIfSzBkxogtxA7N4tJvIq2NAmE+UI=
X-Gm-Gg: ASbGncuGUvQFN36nJBpDEtwuZWJ8wjE5PnMM3ZrAVshkXz1UGQhXcCILmgA/Xp9Ctac
	Aa7N5O6vExPTrU9i5lODEIhd39l9UA6axqQ8HhL4do+8XVgJrF+v1Gy7YM2gJOZ7cAqNYA8GJwl
	NZhR0jCMuwjNYtU3/VHQa0h5sVbEtdW4medzT0gzOPPoU9CatHzjTa4e21ykf3/1uyFM/s1QbOQ
	32DWmTKNuoB94Ke6NF6RYt/WW0dH3ZQA/3VLLBxGn3doV6CHJgspTHdW1pvsyZBlbSZK8GkWvK6
	Bvvv2vG1E7O80fPPsL+ZpsiWYzGHTX7M4Lssct1AKVNLoGYM0qBt/HMyJVCNzjinvIPTYMYpOHT
	m7lbUFmnZI+emJEeLaZUYoGsDXjEKyw==
X-Google-Smtp-Source: AGHT+IHW7jvGVN1nZDNV19D23iLay5SH3FruLv6n11izEuEkrlyk9Tea64PpmwgpUO6OAQQLBc1AXA==
X-Received: by 2002:a05:6808:50ab:b0:41b:2876:a93b with SMTP id 5614622812f47-41e26d2426dmr821249b6e.6.1752705997476;
        Wed, 16 Jul 2025 15:46:37 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:3f28:4161:2162:7ea2])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41dcf3be2a7sm466494b6e.23.2025.07.16.15.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 15:46:37 -0700 (PDT)
Date: Wed, 16 Jul 2025 17:46:35 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: s32g2: Re-order usbmisc device tree section
Message-ID: <14d3cfde-57bd-452e-afa6-8a468281e5e7@sabinyo.mountain>
References: <cover.1752703107.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752703107.git.dan.carpenter@linaro.org>

The compatible line is supposed to be first.

Reported-by: Xu Yang <xu.yang_2@nxp.com>
Closes: https://lore.kernel.org/all/u7glt7mn33lbdeskbr4ily6tjjifvffy64llwpi5b2rrhx5tnv@y2h2y3oz3xc4/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 089f54415571..6f700085dec2 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -424,8 +424,8 @@ spi2: spi@401dc000 {
 		};
 
 		usbmisc: usbmisc@44064200 {
-			#index-cells = <1>;
 			compatible = "nxp,s32g2-usbmisc";
+			#index-cells = <1>;
 			reg = <0x44064200 0x200>;
 		};
 
-- 
2.47.2


