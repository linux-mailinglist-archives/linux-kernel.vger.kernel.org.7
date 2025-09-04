Return-Path: <linux-kernel+bounces-800904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC43B43D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F127BE058
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE2C2D3737;
	Thu,  4 Sep 2025 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="syF9QHH0"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362F22FF15B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993572; cv=none; b=r4k/Tf2NbDrW0TkNKZC9qhG0wFAtW5htScvfLLQoDWCCBANAftE5iAecZfFxm9Z/oXndWoEvAVk+uxOwAUFz3fJMjM+QF4prXlG545r+pLTxfgxarRxg7boybsIe19D0LEldnkX7GtPSpdlGuv6OTrbdh+G8QJYpjX/8kj25AY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993572; c=relaxed/simple;
	bh=YbXtY+bB9UCcFJGSj880JfkrzUoWKkND3HjhqJeIUYY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mdk0rwA4ZvhfRzHVWixooJ2gifuIti04zIMM4vYbcUQtkR4IoUly6CrP3U63Dt+zAtFWBPX7/bqqUMvPbmXMXaoL4awRfQ7fWGqGHZn9n1cCufkR7xh/JLiOeOt6qUoWeuXW2GoQb/tuPrZeX3I4r/37BgURYJw6kLW0z7+s4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=syF9QHH0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b041264542eso12368066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756993568; x=1757598368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUVOYaTKR2BcmefABwOjJaCKklr+SYDWM8eaXKmt/FA=;
        b=syF9QHH0McR/jqRpSI5sBRPGCPal/w787PnnRWyhhNSuaENu/RSB9q0FV3cCQhMA9b
         f3E1+sZeqdPvflTr1EsK8/NPb5MsPkWpzdl3U9AtWWbr1opm4lW+jNvhfG+mFW2h4AFR
         qqhSghMzBh6uKwtc0NgYkPU/V0SwpM1o3APoxDYWsWuhcRjcWwW9p9jPMFWh9yCOsICS
         g2y7nfhntRbBLMPyAcGE9S5RzL3IiET8Z2CeeCxjpW19zEaj0Oo6b0IdQIxCz4S06GKN
         EqIAscX3Zx3iV/4NQDArKC2Y9LLj0djfPzl4QS+QPbypbPyPX87BMcIIjWTlhP3oTxnd
         BaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993568; x=1757598368;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUVOYaTKR2BcmefABwOjJaCKklr+SYDWM8eaXKmt/FA=;
        b=lOFY74I3hp6M0GrvkqMId+IzwZ4Iqt3pgLZP087LroeWtNILjlqm9NynjE/wjh4bYM
         no096K4eTDW7TSwnU0t3/v6llQRk81ia+xmj0v0O+ZJJyGJxmtCLsVmBuYu1Vy8vhw9f
         FwfXHQSRDp9AOp0SaBv2YZJlL406T5zBBFSh3+br/xXgXJVmQkiDWmQFYLGuVOPF9dew
         c4Mhq81jlS9+DNJwXVBMELp0DWHqMoQGWJtcQk6U49vfqQQI0XtLHpWeCFo3AMc/t/6Z
         Hf7EpBvkShaeoEFWZOL5AIxgUN23Q8RQ3Aaok2y2zWXpjIJl0Vdbf5c5iMnKPNvBXwy4
         4H/A==
X-Forwarded-Encrypted: i=1; AJvYcCUN8d02UVT3t61ZpyLolBUGGB62kXOhXzuRElGXOj/53gDLZJfemJJDBXenHqUK9YSNUdLcwL1iF/U2NSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCrkI12OHZvJ7hdutCj0uxCDi11EjDk+eCWcBnNdMMsGyI5W85
	dt/4v8f40AOqeg/PUpyP34Hsm8CRyjSME/kEEf6bQ9tydBRS3ojC0YZJifpY01qxIlI=
X-Gm-Gg: ASbGncvQoYJf4Uo989oZb3i++rTudu+DePwJUEs5qWUlKv9qpRNhLMtiQC4gW54OwrI
	Xhw60h8Hco1S9NfE89+tzhQ5qRlR6UpFr1mRnjPlvk35M0teuPizkbNncoP4YIMOcBk7I9W7Zyj
	jqSh7BxVHNlF56mS0KITLdq8QXy1eYSSVtYaSuQcOUNDYiyvUVGjt0bECkRT11f3O93XquQnEI+
	2wQ36f4E4I5TdSR1Xqil29gpHtfaN1/hsQGzKkX0VwqxfpZShzw2JGY2FNAco8HGmAUVyEiD7wS
	mXxZTuyAPAcoKECSll8STV0z4CbomqYpwos+81koiyRnDCmYZRVSYAW9GPy1t+dzgZifrRjRt5w
	pj04xgrpaGRNvFYfnPAY6fda+pkzvavIv5osQrtw=
X-Google-Smtp-Source: AGHT+IHR5XB2P+9jpNOyHwbkAht1wt06oHD5IV8g09IEd8azHiDpTqXuJszFXYr9m5Jzcbq7eoSIFg==
X-Received: by 2002:a17:907:26c3:b0:af9:3758:a85a with SMTP id a640c23a62f3a-aff0ee81aa2mr1052139466b.5.1756993568421;
        Thu, 04 Sep 2025 06:46:08 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0413782b94sm1180634266b.35.2025.09.04.06.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:46:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org, 
 s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
 linus.walleij@linaro.org, tomasz.figa@gmail.com, catalin.marinas@arm.com, 
 will@kernel.org, arnd@arndb.de, Ravi Patel <ravi.patel@samsung.com>
Cc: ksk4725@coasia.com, kenkim@coasia.com, pjsin865@coasia.com, 
 gwk1013@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com, 
 smn1196@coasia.com, shradha.t@samsung.com, inbaraj.e@samsung.com, 
 swathi.ks@samsung.com, hrishikesh.d@samsung.com, dj76.yang@samsung.com, 
 hypmean.kim@samsung.com, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@axis.com, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org
In-Reply-To: <20250901051926.59970-4-ravi.patel@samsung.com>
References: <20250901051926.59970-1-ravi.patel@samsung.com>
 <CGME20250901054249epcas5p483e898d45e072cb0faa79a681f73f0d8@epcas5p4.samsung.com>
 <20250901051926.59970-4-ravi.patel@samsung.com>
Subject: Re: (subset) [PATCH v4 3/6] dt-bindings: arm: axis: Add ARTPEC-8
 grizzly board
Message-Id: <175699356578.171312.4960170053878609185.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 15:46:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 01 Sep 2025 10:49:23 +0530, Ravi Patel wrote:
> Document the Axis ARTPEC-8 SoC binding and the grizzly board
> which uses ARTPEC-8 SoC.
> 
> 

Applied, thanks!

[3/6] dt-bindings: arm: axis: Add ARTPEC-8 grizzly board
      https://git.kernel.org/krzk/linux/c/604a932fa924e7b15be47c6208a305f289cfa309

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


