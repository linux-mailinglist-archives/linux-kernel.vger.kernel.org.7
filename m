Return-Path: <linux-kernel+bounces-793911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C8BB3DA07
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5773189AD6F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2072261B75;
	Mon,  1 Sep 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HF4O7RuA"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF14B25C809
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756708405; cv=none; b=tmzObI1D91J7kPXbb4kXUisKlGUcK1IcsEBNM39QPEvgqjufoG8bHq4BxaRhcpsRvrXPvQqQErHSBZ7vh1Iv8XMcIpFnZlZjGV7zD0MRp9VMMQfBkg+DG7cdhVCBfrSYFmm/11jlrDCD5c0EPyOpA+qosUUXH+x3co5kK9JQGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756708405; c=relaxed/simple;
	bh=MRmqW5v8kC98mxeYLALMsgbUur3JoJDIJRKOAe+vVfg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c4OTPosGo821F9LBj6FBaROnKSaBjd0NICYYRW7um6RjyJs/S5Jdb4vSRILx4yHrFYvYS4MEixLHd0v+wsqahF1v3+lGvOSooSW8RzC9+eSShz1K0RebxIwrc+7ED3KfWj+MHtbLeT7K9ibVxnT4sFx3Cr5tdFcsWSxnmqVRWmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HF4O7RuA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb731ca55so69717366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756708402; x=1757313202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/aU0CbnFkMwpLJ4PSvNvpEZBk4OI5YLNQdJgy1dRfE=;
        b=HF4O7RuAzduQIfXhnXdB253CrGMpO7Vw2TFubeq0mXV5OMGyg+Xq8zqeKCnyrPJy2j
         1jtuhWtoAL2Cg3FG/nXzXpY2H5RP/DT6hINvbqPAHQDTwJokFxOyfZLIKCyyE7EWrFwW
         p+VYtwSJyksYnXMBYYUEhiwYI24evaBdVDyn+eqfxCNunPjsuPwWz4MMtIqpLsIxUW9b
         8+tK64Qtkq0UFZPTiL0mWg9gsKQpLJk6olsV1l0GCWS9dWh1x7eDwYY6S3wznTJdymv9
         mzl/Fqo81uj8hPYvBmXPJg/7l4dW8IU6Ah8lYXmHnvnAuDdvujQQ65MMtr0wlCrRuB39
         RHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756708402; x=1757313202;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/aU0CbnFkMwpLJ4PSvNvpEZBk4OI5YLNQdJgy1dRfE=;
        b=X0lYgIgILbfy9NNaO1HPwdLIaPyK2+5fzlV56NAtQaqXrl43eHMV4y5TpEfI2hogRW
         lXHvNqgntE9zuU1gxS10lK9tkxTrJnRXJQECR75IXFl2ZJS7CexOfZ+S/tTcNCj0J+o7
         jFuPOiYAn9RUjghzxqof/1HD5HP9O9KxCbbB3eXpCX/Qqx5VFF8mW1C9Pf/bcjx3x+77
         aRqpibsne3+HvaCKu2mmdrz/ilAx92DPGFk3jcFN+NurNWMJm6SmOmbO08/PtVw1MYxo
         AdlhBtnWl91Qj4SrH2KAtoQ0mT3yZhHcTdkHj1of4rFaqFRY8HsoW7zGjWoOe7T4KjUS
         mOIw==
X-Forwarded-Encrypted: i=1; AJvYcCUUDBpVAtDMNawcZvcUj4MWm0bETycTZnTflpJs3NFvkIN9fNEAkV+34J7r4JDqIvWtTDsbYDHH+WUNWxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxarQ/pg9HC261bsYpQQ4Y8HMBm8MgVLzLhSa+ZFfawZunSm0UJ
	IfwrC+zPP0JPv6Z4ELUq15IV/OQcTfKqy0sdgLFG6D2GPCYjSrSK/5wUa3u9SPrJmsg=
X-Gm-Gg: ASbGncsIxems1AV6BHJd62KBeNAEbpQ5knDv49KJT2eI+TDV5KSt0x48X3PvH2CJANA
	Rpy0m5Ju8GZYkdrCWm0AxqjCUAKLoEReD9+R1d7yqx8FyA8bSq1PQyBSX8WSwMjOH9tmd6yPE+4
	5PMEQo5ZDpLQYHplttGaT75UJDl5JpIngs66hsZS/x3g8CjYVif8MZp2KzW7V7o3Q7h3NosEhNW
	iVXgwDGhKdiyiZnB8Fwbp4PXUFEGnNcF6vvj+xw2kbBgPbh0Z9R7k4hP3z4M6rqdDrgA2srM9SN
	4G910WTlbn9sDpeX3I+n4gunFcdTzgHSVuDmjJSDvjjbzhjHH3VqVZxK2sp3EOrCspZJcE5fzLk
	1IQwvySuO+d2YjjFTfr4qEgneDCzpXUhS+RpUYb4=
X-Google-Smtp-Source: AGHT+IH3Ge5EijHIz4q/oz0m1h7tqBKzwaZiLUKt08VUzyALygnT1OIjd4bZHZm5MjGV43BBeaD1fw==
X-Received: by 2002:a17:906:16da:b0:b04:1fc6:1347 with SMTP id a640c23a62f3a-b041fc67c80mr163666366b.0.1756708402124;
        Sun, 31 Aug 2025 23:33:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0420ec9787sm266471866b.72.2025.08.31.23.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:33:21 -0700 (PDT)
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
 linux-gpio@vger.kernel.org, Priyadarsini G <priya.ganesh@samsung.com>
In-Reply-To: <20250901051926.59970-3-ravi.patel@samsung.com>
References: <20250901051926.59970-1-ravi.patel@samsung.com>
 <CGME20250901054244epcas5p474b65dbf838296ba3177edaeb2c6ec97@epcas5p4.samsung.com>
 <20250901051926.59970-3-ravi.patel@samsung.com>
Subject: Re: (subset) [PATCH v4 2/6] pinctrl: samsung: Add ARTPEC-8 SoC
 specific configuration
Message-Id: <175670839978.114610.10121672934609894956.b4-ty@linaro.org>
Date: Mon, 01 Sep 2025 08:33:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 01 Sep 2025 10:49:22 +0530, Ravi Patel wrote:
> Add Axis ARTPEC-8 SoC specific configuration data to enable pinctrl.
> 
> 

Applied, thanks!

[2/6] pinctrl: samsung: Add ARTPEC-8 SoC specific configuration
      https://git.kernel.org/pinctrl/samsung/c/d4ac729964d8967261fe15fdc8f249729f923120

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


