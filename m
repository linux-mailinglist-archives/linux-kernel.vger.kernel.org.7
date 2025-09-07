Return-Path: <linux-kernel+bounces-804575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC6B479FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4031C7A95D2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EEF221546;
	Sun,  7 Sep 2025 09:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDTv/Lne"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14A21FF36
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757236448; cv=none; b=eI1PJpNbri4N0Vqi7mHSx/eIZBGBgUDzKCZo/f/4OwOOHPHvqpJ44i6ER3I/cq+GcaPrSr5n/h+czr/jteMm/GXBvDbsgDooRxgm+YfYN74YFepwxeH2vwwn9Tw37R3usksqGCn7b3W+1VrcxOrIjYeCZCyGV1kJ2I1RiHyp+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757236448; c=relaxed/simple;
	bh=sU7+/OKR3H0AJm7QtOcIJdDLNqhe68RVRMMpjau/P+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pn2VpoE3FqQVFRyUiOFbYuG6Fm3SkLZOQBeNnzDX0Qu78cYb09DIiITDwMS16lqwxVP0WcoKxsyvJvkIbRwNAP4HLkK1x8pqI+fAf+8jvEeXjmR7aeRm8YqDHF9u91iGW+AiBCkqwGg3sGSic8y014wO7hbLRnvj1zqAkHX5Jho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DDTv/Lne; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de185c04aso1155055e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757236445; x=1757841245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h09TDfJ0VCIYwMjqv+nUCRRx8qKcN59ZJYX5ff84mD8=;
        b=DDTv/LnerbbkADMhaf0ViJTmnp0va3tlnP3KfUkxQW08vIRYDEbbg90JTkoeWBxHx1
         aC8fVjv74oV00AMw+fg0q6La1qcsKlsJ/lnEkccvbJg/kzDDh+2jAlbmjDuQn/08jAnF
         q1TwFkT4VMiBU1zWeCcrcfoykhIytvS0tKB/1m441AwAp7N4NcGuril7uPmZAyODtmj7
         OdMYif0Bo6wEnjSRYnJtyQHkFR2u0PNEq4AAPrvdM0L8m7r8xhnCwKHzwCpwzOBAneq6
         Fo9rlW1LY3wiA67CVBR1ndTbdxlKcjzRdPw3lhUUW1+tHFJkcnQJ6AAkgswaspx1vv6X
         H0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757236445; x=1757841245;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h09TDfJ0VCIYwMjqv+nUCRRx8qKcN59ZJYX5ff84mD8=;
        b=iYmdu/1HinD6czTeYQ+YLzPVt1wcQdUNAB2apXfLdBwJxqMg6qwNuE/ygakQPCcSwe
         oapXsKNC9pVyCSCcheguQSUZhoJiU3bVANw8VvpGjtGI2uPVAeXnXdzx1LGG6snlNejB
         GNJ6BCUzX6mnXyiLpmlVcb6GDh7dqAymhjGGe3a7GFcEx4IIbHJWa7wkwJmMEsP1we4Q
         rGp5tUFQO7xivaUvAYfaVR9oAZkMegGRPIEA3ZrCmZMoVJOj+Mjiwn77OTdEjpt/qK3b
         atuSsYxjxS9AiWBmPWYLIg6m8YtdEEcT3EB5kO+VQScibAnX7RxsH9B6YjV9YMG4hdkr
         MAtA==
X-Forwarded-Encrypted: i=1; AJvYcCXtulphuJQHTefxsGgIpVydvmbkR7O/X+XpfV4HawFPKObJKyF22pv+6zIuLPvRooKepjJJGdJtvcxx8MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyoEj95yknWTjt8syy735KV1YoRJDtRWF74F5n+9aqEH6AQdKb
	p7RluQRyNJrl87KMApGyCKBOaWydcq3X9D/92B2vpfaiskmQ5VzpiIKa7u2UHGYRfn4=
X-Gm-Gg: ASbGnctm+VSqZ20cuIW22QF02JF5+0NNg/v+D9iUjfYtd/Ayc+DUioiZjSwBS+1M/Fd
	TXO3dfiJsxMJLvSB6dtCGErqHSAraT64l2uS09rOunUcHrQ2WkrVbxqMxsI+Z+NQwJanIuCAQIT
	lVbetFcxw/agHNPGdFdQgSKXasc2FxPWUig5m7aW49edn8bQ/Y8kxvIJ/D+4UMi04mNOs2oMUoI
	4CmWzqKc1HFO0qAhWAFdMGc0vWLMgy1tt8XbGMVPDTbbPqSedU5kcYAK71/ZDtjLF6DRBeN+noa
	1IjIInDE9Q221xuCIj3xb1pXzKLvqmcU9CP7rtTtluA53hMSsLX+yPe+TK59FCDPmKSujxV95RO
	NsK+BmCZTeI3wdGBvC0dQr3JbQCGm1MtGCcBAJVI=
X-Google-Smtp-Source: AGHT+IEs+zHj+nZWtDLKO7AMy5vUsh2MOF4u8kwkXxf2nwQ+E1nf9C+MVn+vLhdElVbV4Wh2U+33Gw==
X-Received: by 2002:a05:6000:4107:b0:3e6:e931:b428 with SMTP id ffacd0b85a97d-3e6e931f97dmr1115038f8f.10.1757236444776;
        Sun, 07 Sep 2025 02:14:04 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e21e4c0e6fsm10918962f8f.17.2025.09.07.02.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 02:14:03 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
In-Reply-To: <20250904-perics-usi-v3-1-3ea109705cb6@gmail.com>
References: <20250904-perics-usi-v3-0-3ea109705cb6@gmail.com>
 <20250904-perics-usi-v3-1-3ea109705cb6@gmail.com>
Subject: Re: (subset) [PATCH v3 1/4] dt-bindings: clock: exynos990: Add
 PERIC0 and PERIC1 clock units
Message-Id: <175723644300.30719.16385900171586342437.b4-ty@linaro.org>
Date: Sun, 07 Sep 2025 11:14:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 04 Sep 2025 14:07:11 +0000, Denzeel Oliva wrote:
> Add clock management unit bindings for PERIC0 and PERIC1 blocks
> which provide clocks for USI, I2C and UART peripherals.
> 
> 

Applied, thanks!

[1/4] dt-bindings: clock: exynos990: Add PERIC0 and PERIC1 clock units
      https://git.kernel.org/krzk/linux/c/43bd82eb33b2ac33232724a8ddb9e07cde492328

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


