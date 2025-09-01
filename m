Return-Path: <linux-kernel+bounces-793910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8599B3DA01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3FB16A181
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6925C802;
	Mon,  1 Sep 2025 06:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUH1RrNn"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6A25A2A4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756708403; cv=none; b=EAFSQsIgQTlBD7SvsxW2iS5heF+wY4Vmtcfx4ZH+qk81I9M2qnSxTO1OCd/haHPFh+Vt28G1uYOuPPRhds5VgvLplpRcW7wnToP97VUmgTOHP2Wf4lFGfeG2k7Gw/HdS5LeuzKV66c/vfFVH34vboGpioaUSXaIeLZa2W48G9iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756708403; c=relaxed/simple;
	bh=+CeJXa+e4zK/6sG28nGzvsAwOcZbN6tT4ayz7cnNcJo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YBW3WKJxKdw0LCSmStP/mvrlc9XPhsTc8HQlkfmJDPwhswhGk0fczI/FCTQWaROJqEbKebmkzEltCFNj1MIHFQpsvL5+j41LHusNAMUi1zUxwrx140Kak6yK/atn4DpC4Rak36u/o6rgDId/Q967QxU/6IXg+zhXIX6qL5c4Wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PUH1RrNn; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61eaa4f6784so17643a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756708400; x=1757313200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT25ONXdlRJv+CRudnnHBniNSpVv/dBQXOd0f5NOe1o=;
        b=PUH1RrNnX/sGj0uVxSftlS47ts2qMTvfJtWGC1Id158DGBvbma8oIXFMxW7/2p147c
         0TVzzBq2YelCPXRGg9x/yFVpbIj1M0lssPuj7cBc7SZCTsrodalpoq/Q1r9OO+z0mwIq
         dxix2dgQ5Wms0deyjI75QDkwQ2l108rIjJDOhaH4LQf5of9yX/Kp4r+fOuJVRA1nSIR1
         1D4aG1bmBuiyLNDZjdRr3qq6diAlR7bh8L0o9XAx+bvK/3BO1du3otBiDokR5tB4KvF+
         bA23umEJJtg3etLSj7GavtHHNSPbqEBd+ZA9uAVoFt/2zgxX8AL/7Ofmm/8tZNvMZcN2
         to9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756708400; x=1757313200;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT25ONXdlRJv+CRudnnHBniNSpVv/dBQXOd0f5NOe1o=;
        b=MZ/4QiUIl5X1B4OeNvJV/uSQ+4QPE9Q/dby6+RC5ABHKhPK2SEZ6IJfwUfDPJhP57F
         2kE4YfGonHsA/WV6eblBbJXvp0+38M4vJ0x+2gfhWkenDlIk8JDcIHTRVm0EoVVCWq5k
         z/KvTCAHehdfIJq26vHUq00QPueRHoKvVfyRoeZu2PFI6P4zDXRFJYiw3F+1q1M/cWWH
         c73wScuyYhiyiwU68lIndjI0d9h9Yk8OFG0RwGXaIlL0JIUGEFFXAmqSPUzR6xuxVuBq
         adHYRiHRJ+RRkltQhJi4Z1ytLQl/qrsay2oZ6cJ494QlrA45yTEswzl9makU+0jbn1+t
         G7qA==
X-Forwarded-Encrypted: i=1; AJvYcCVmp5KZiFHxPSMhfYqrSShwI3Iq+8uBJWrIxyVPpvLSL4/5LvoYo8wgBjbnnEv9CTroA3yaKced+cPjXec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJk0vMySbQnlMYpqcyrnmczssonT6Mijten6dcJPHeC3R1qXk
	2HbJwnboicivgkypUPwIORiTI1KEapUfcsZKFGwjbIv2WvJWN/Web0mdfgNnYWGJX90=
X-Gm-Gg: ASbGncsnvVv0erHTWkxL2tHUHHNi84ZbyyS7dsaewn23FVJILXXdzqAH88qlz2di4gS
	KRROgiRSjIGrgeFhSFsFjbNSfOJj8pDXDzDU3xPaa6ocTsqy08R6b/FjmBF+FTg+QJ0NBFKEMBm
	MOZT6geOU2VXMxEKY9XJzfCqTyEdXR18QhnIEX5s2TItzzvJow2w0jY8Q4gr6bAXZb28nqd7Rlr
	pOT5m6iS2tDmBl1WL6zZ9ZKto8Zfht2SmC1bUPGFrWqnF8UqHtHRLx+1BSw159eOJayYoL4DFfa
	2eOW3CmLwYBJQjaMJBD4/gYDt5qJvUJt1Pk9Q4iRLtCUXw0CSQVcc2PyXsjq7H+Pg1XswO7OZgC
	tiI5hs6yaYyk+bcxWLeXQ9XZo1aES4Be4Cd24mFo=
X-Google-Smtp-Source: AGHT+IH2EH71GqZysZaHULgZnawZA/ilqSzMTKNSHRHdyGYISzSRl8kS8S+lxJ5IgYxfEUW2K8qFqA==
X-Received: by 2002:a17:907:3cc3:b0:afc:ebfd:c285 with SMTP id a640c23a62f3a-aff0edc4d6cmr519702266b.1.1756708399621;
        Sun, 31 Aug 2025 23:33:19 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0420ec9787sm266471866b.72.2025.08.31.23.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:33:18 -0700 (PDT)
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
In-Reply-To: <20250901051926.59970-2-ravi.patel@samsung.com>
References: <20250901051926.59970-1-ravi.patel@samsung.com>
 <CGME20250901054239epcas5p214f3d0a29b87eda7f9b671fe05ba4bf9@epcas5p2.samsung.com>
 <20250901051926.59970-2-ravi.patel@samsung.com>
Subject: Re: (subset) [PATCH v4 1/6] dt-bindings: pinctrl: samsung: Add
 compatible for ARTPEC-8 SoC
Message-Id: <175670839704.114610.3984450537189054873.b4-ty@linaro.org>
Date: Mon, 01 Sep 2025 08:33:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 01 Sep 2025 10:49:21 +0530, Ravi Patel wrote:
> Document the compatible string for ARTPEC-8 SoC pinctrl block,
> which is similar to other Samsung SoC pinctrl blocks.
> 
> 

Applied, thanks!

[1/6] dt-bindings: pinctrl: samsung: Add compatible for ARTPEC-8 SoC
      https://git.kernel.org/pinctrl/samsung/c/03724b3496cb0272a5050a989ebf2494b1ff5a55

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


