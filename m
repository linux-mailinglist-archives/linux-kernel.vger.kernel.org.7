Return-Path: <linux-kernel+bounces-859328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B16FCBED4FF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5929C5E823B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BE6259CAF;
	Sat, 18 Oct 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axR7RU/+"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F77253F3D
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808012; cv=none; b=lbIMQUBQIMC51xkUuNTlnb5DYW3EGFmbwB86sd9e1ScFFncY1EfW/Lh0QsEHBksB8nFa4XXwpIBvWhy7CfQvhUpiTLd2PxZSDklf++eNGuSb/gSdQzB6cZMiUCZdb/PBEMPjJuVNvq6ibUmmKZfsRk5TQbfqvaCoGf88+pD//w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808012; c=relaxed/simple;
	bh=vg42KvZVt3grWpFEwkoTaxWeHLF6xTh0VHrTgE6DOaQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=icml6YaV85YdBrmsOtltb+FndY5gqyrHeDgs9LoQHXKo0vCqBPi+mbXkw3U+GnidOzPG9lfVSolfwGYtMoAwjNMUrmGDt0KolN18ynMDfJRkA1BFyCOEI0NcTyah7/UT0mHDsCtjETqWdSy14KYys37TF+n9ABKGk47zEVTHwy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=axR7RU/+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3b1eac8460so62902966b.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760808007; x=1761412807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x00T8hSWTvPjR/PV+ewhXMDM1VtYrlavfAoGAuH1srE=;
        b=axR7RU/+cGPW/Jgs1pfiA0naDKMXwTOHaISJtu96WhpHfbIynBlQ3wKOIqyZFxqypM
         BSJcYXw6/WbifjO6tP9EWBFs5DCqMOd8BmKKzNULTyY43TsOh+jDa0ZrZ3aPzegdlIee
         N2W2Z9Vc/Jf3Hasz8Bbstm/MbFPiMPqP7zzjUfL2sv+hXeAERdgprxPwTIr4toGDvHEf
         SN5C9J2kL++7oXoYEUg2LgR2AB/JzdlHBKw/qyaQMwUKieWCo8oAdmKbzdIt3ocZaOpt
         1lQShfpZYdWF8A1VtsuSW1B5BDccgSBIZUJTzjEX9kCisQQkUXePZlyt1jXAh3T1wmzT
         1PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760808007; x=1761412807;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x00T8hSWTvPjR/PV+ewhXMDM1VtYrlavfAoGAuH1srE=;
        b=L09+qPphiWCjZ9bBaMLub1i4FRl6fYYEvHxwNXveDm99d03Oz2X2+sANro//aN31Bg
         fkrbSkEAha3hBLTwls0tw4aZ6dMIazw5h/4XheV975iUOYG6VwYCdgAFlVTHxRIGVv8P
         I4D90D2iGi78G9YbAUfWKesHW+0+BJHDF8EBJYv/FZB1OJSs5DFQDyM+O1y6N6V4l5v1
         lv2wHHQn3Mqx7Htr4YTCH5g2R6h9a8Fqpgk+QEfROaS7rRdPRZO16S3T9oNUx1S9gklO
         JiMimiqv8BV58hQonZ9akvIa8dNYxtdsexMkEDBP9Ck1KVPCwnpUzSyrQCI9sV3Y8frh
         7/8A==
X-Forwarded-Encrypted: i=1; AJvYcCWWST70zJ160CHnovBlt0sEwynEebB/QHd9OuJGlRCeySQHK2c//nsM+MgxryPZcVXyJfFQubCh4f6s934=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0BlYm7ARDtv5Y1vLe+OFFb3Q7y12LCUybWUf7zJagE6nu6lw
	Dvh45Gf5TX5pUeN2ZZCAZA+MIq2+qDJ13IYxQHy3+pbjlDF5irdYUJyuz6wiT4toTKc=
X-Gm-Gg: ASbGncvbVxaDMBkVyP5/U6iUKRqukANGJcCOFY1k9ynqx2fAWC+Y1acezdkboM7CGA6
	AK1AIWdCwi7GImcEbEUULdaehDZrUrnSqOX+wBcgOex3ttZrMTwM+vXLUHIHVbv1zpvjbMSFj+F
	O7ryHfIOocQvRHY98b2JuYpKS+PcQHdyyTWLtNAClc1IxgQ4s8UzrXZZnue6gQc9M5mqCRq58c7
	W/0WaSGxSRCeVoTNQiStEygCE7PbdSxLRQD/tI/2xhzrbSMn1micfzT648LBTZAkspAEYR/KzwC
	6W1CAYughiQ9umM+PgIHtqPJnS1NUfH91NDjLPwWH1M+jOc5YiWCzDF3mucpX3Ho65M4skqaNO5
	PVEHHNpQTtkNyT/3+L/W24RzmOKUEJLiF8fAT/bCc5bJYCEg+bRwBB4Fm+54b70JLglozA+DegD
	iXyY02JI+c8efb/Scf
X-Google-Smtp-Source: AGHT+IFSGq3ZEBbgPdz+Al3sMkuXJaRZsJGuzuIpXqA4Kk0u8lvyKGkeLN15Xp4kSmIuqK8SKTLelA==
X-Received: by 2002:a17:907:3e1d:b0:b2d:a873:37d with SMTP id a640c23a62f3a-b646f894876mr524393066b.0.1760808007534;
        Sat, 18 Oct 2025 10:20:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da2bc7sm280666466b.16.2025.10.18.10.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:20:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sam Protsenko <semen.protsenko@linaro.org>
In-Reply-To: <20251013-samsung-clk-pll-simplification-v2-1-b9aab610878c@linaro.org>
References: <20251013-samsung-clk-pll-simplification-v2-1-b9aab610878c@linaro.org>
Subject: Re: [PATCH v2] clk: samsung: clk-pll: simplify
 samsung_pll_lock_wait()
Message-Id: <176080800602.47136.11869769472487961810.b4-ty@linaro.org>
Date: Sat, 18 Oct 2025 19:20:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Mon, 13 Oct 2025 06:27:16 +0100, André Draszik wrote:
> readl_relaxed_poll_timeout_atomic() has been updated in 2023 in
> commit 7349a69cf312 ("iopoll: Do not use timekeeping in
> read_poll_timeout_atomic()") to avoid usage of timekeeping APIs. It
> also never used udelay() when no delay was given.
> 
> With the implementation avoiding timekeeping APIs, and with a caller
> not passing a delay, the timeout argument simply becomes a loop
> counter.
> 
> [...]

Applied, thanks!

[1/1] clk: samsung: clk-pll: simplify samsung_pll_lock_wait()
      https://git.kernel.org/krzk/linux/c/d669ec6be0b1965c67248407d87c848b1b7c12ae

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


