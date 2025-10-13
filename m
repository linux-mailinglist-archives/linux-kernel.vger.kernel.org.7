Return-Path: <linux-kernel+bounces-849837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D51BD10B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9418D347056
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2B22A7E9;
	Mon, 13 Oct 2025 01:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WwTXZQjt"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA891D7E4A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317339; cv=none; b=BUthBPKD15c3KW5iTID04i282o0iwvPFlOdcwlKAfH6SLLzwMLiuNbwQUSX3iT4X6TapTjrGMsWATAxOgrBBjF9mY7ocbIEQVHXVvCCS02jMSCMvC04YHxPGz/mT4WoVW1F6kEMSNy6ydkkkRkkfLbOIfVGAckgx4mTRAAVrlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317339; c=relaxed/simple;
	bh=ja7vo346BFzdNy+njt9WDe3hSZLT7mbvCRSsDWXU9p8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u0y7Qr7ld8G21atodAKcm79n2aYt7A1ZxNckvh75uJ+Qgl9HIc43apB67d9F/UcdyNzLU4TGWCD0l1w4OojaLVMRhTrJ5qLYC4zMGWd9OEaCnrLFLPK/xpO/aR6GAAWwNRuSjw8TIYMfyt5e3j7rZW7999L4kaFxvN+O0IVAfXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WwTXZQjt; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77615d93276so226540b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317337; x=1760922137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49r4OZCVCJl4F6bzchFunKqMZbc/Igv48ydqq7l5uCU=;
        b=WwTXZQjtoN9wHUW/PqIi1k85Pyx6RuJdOSJZNhn+EGEHOnxInlkm9VDqCxmePFI/H9
         Wh1BTSpr3aWZb4x8VhdL5ObY8O3tEs/SEo9AOCvDs7fyyBAP4Gg5/h2uwpUWYYU3nhx9
         Ki1jKCmLscfc62UReKMC4d6MLo83GKHTuQcvnyG0xRvxtJIRCSFrikv9P4aeprTlpttE
         OoSIcwxevfc7/pYUg1eaf3pIO+7BhitUp7BDCDdghqYR6XORASP+GnvxLzZ07hfwv/MW
         uobDRu2/AbnRtL15xCRjYcLnpzNmekqpagUT3rjfop8W+voEnPm4TXK46E11ZqoHpXBu
         DS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317337; x=1760922137;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49r4OZCVCJl4F6bzchFunKqMZbc/Igv48ydqq7l5uCU=;
        b=lxcvdTpqH+H7hfpEYQPZNP5ELQXr1m1hbmqJsCKBWVnHQSSfkZTJqpuKsCv+cx8bhK
         +H6LM5iekE7LYECU0yemgp3QygIQliWkYa3bM2mby0jkeidnLIvaJpusC5WuXzS6A/8r
         TmQeYtt87I6fSaZoZi4VA/FLlG/vYeELxn/7W1ryrjhBaivti1XpTaMhwU4v8u7uvKG7
         qX9kDBgaqmdsok+ObV9agjbui7JoTXeRjZQWGXyRcpZ8ExZAef/gK9+Nz/lV041o1//7
         KuYOb0q3mSdGylEh4l5f0Tx7QqshFlQ1xgBtam26JFnXkH4pQ/ZygiVv3TsimU2ShzwY
         Mhnw==
X-Forwarded-Encrypted: i=1; AJvYcCV9A4cEw4LmHuAQHJ4y6yNnefQv7WaY9SbWMRlVZJ0VdcT0Wv8DrKDPjF6cz5yX/dy2mhwp0Xbzjykid8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaXDLHmgKEr2u5Cvq3kASlWiy1NoBiZZPaLZWfNPB8dPKXGoFA
	/1W1uHvyZbX0f5xPcJ52+x9xJ0SNdjmeaFVsIH1MAKYc8+j7dwTdadxM6RH12yRj45bc2cndUL7
	/QsoJ+zE=
X-Gm-Gg: ASbGncvJjw9LtIMwOr677nWy0Y9/NcpLIiN13ZnX13P/Zv5gUcnqNNkT9jkwD1yUEVt
	EnBtElmJ3lMZIuoMsBPbZ01I1rqPJ6eJuXqwJtbQvaY+YkPevaJ9ScdhmoVT0banLZKBlTqzzl5
	qJwsi3oLD3/W1FGRD/q/3ZsH/n5nKTagJy6nM5F2YxMoGOqQ8nuOvn/kl9lrFPJtvfpuV5UWyIG
	ga6pk2s8bLg0kO2dWOTAvY06gIrhLLJgMm62XzXPQ5I70xjvpBkg78Zk6Fdyd7HPy3A5zvHSMtH
	gHmkL8bKgFiq2HcZdHP9Rfjdlq3vYfRx0+gohjvEa1wCLor3imndh7Ja5BVNZo3edmzCydHp1gU
	Vxi+BdwszDMk4V/gwvQxsxyVszOPn1XrMytEKj5CKXAZjH8cdruBiIeKUvtzbF2ChlGSc/4c=
X-Google-Smtp-Source: AGHT+IHdWvsayO7maue0By4WbQhYlT572j0j+2mQ7G3lnuobyyblOpI7dDXgWIwyUScRYBarFk896A==
X-Received: by 2002:a05:6a00:a589:b0:781:21db:4e06 with SMTP id d2e1a72fcca58-79382794da2mr11782142b3a.0.1760317336612;
        Sun, 12 Oct 2025 18:02:16 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:02:16 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Alexandru Chimac <alex@chimac.ro>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250914-exynos9610-chipid-v1-0-ade99e09a23c@chimac.ro>
References: <20250914-exynos9610-chipid-v1-0-ade99e09a23c@chimac.ro>
Subject: Re: [PATCH 0/2] soc: samsung: Add chipid support for Exynos9610
Message-Id: <176031733307.32330.8934958583314860754.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:02:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 14 Sep 2025 19:50:18 +0000, Alexandru Chimac wrote:
> This patchset enables support for chipid on Exynos9610.
> 
> 

Applied, thanks!

[1/2] dt-bindings: hwinfo: samsung,exynos-chipid: add exynos9610 compatible
      https://git.kernel.org/krzk/linux/c/944d40232eb4281aa8b56ea5389a8fe83b7c7074
[2/2] soc: samsung: exynos-chipid: Add exynos9610 SoC support
      https://git.kernel.org/krzk/linux/c/fe31e894c284012f11a841dd2346fd99bce4a001

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


