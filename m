Return-Path: <linux-kernel+bounces-860187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CEBEF8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8112718863C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F283E2D9EE7;
	Mon, 20 Oct 2025 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V4voWSlj"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B52DCC17
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943360; cv=none; b=JafVBeveOu4kmeNVTMVUvWn/93xls8hf0TqsD+9Y22Ep98mS7j4CFRHiZA2HbqKH/VLC/6Ac82bjc8+gxwzgMAQRHHsAa9f4KSUMBkOFiPjRH6q2ye50bPLCy1+j0C+uIejGCvTqcj5avxXiRbAN2A8k7xWhqTkM+eDFjJOPT0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943360; c=relaxed/simple;
	bh=Guy/Wn6qWPXOWpR+qBL2zJhf1WK3pLxtBayRj8tlDZQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sPV531WP24SDyTJeroSbvGJp8IoWLsfDhkBDyV+JUx/H4IliZuSt++/2eI+yOSw8LP1zHSjnsk3hk/4Orod7wI6jm8z3LOvQ7f/jPojOucDPGYR/RnE8vKESxJUYc/2AwlfPTFavHPJwXS5rAXQQVOrObjUWQAcNNc5s8pH3liE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V4voWSlj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b4557950d23so78467966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760943357; x=1761548157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnPFmndDgQ5IwJj7APl0bxqe2uCJD2IB3khq/qdk9Cc=;
        b=V4voWSljIe0l0Fu9YOB3FvMObA0AxXsL4rhAbhIZwmtwfLUiBfJMdQ+qAJA9niCnfv
         +93flgq35FPdkFWiTp1p3UKdnCjEBr7JuRCkq+C9/YbrBoIzWZfPON9HQb3lDpkTaKa9
         8g6kMKSF4q6id2Xa8sgnR2X+ZzhawhRgpeVGdPxW1+fGlxch6BUGhmw5b0KYsJZKMq1B
         oeKowRa9Be7mZTFZfRcIqea5wZXjAZmC46BOy123Sw/IWxJHgHGD9fAg1HVGmjzayzid
         HpBxBh+yCtBcW+2IAIxkyi1dJq/8SIwT+q+B9wPPesRd+IslvZyAMC+bhc8XYxsMBmaC
         75FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760943357; x=1761548157;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnPFmndDgQ5IwJj7APl0bxqe2uCJD2IB3khq/qdk9Cc=;
        b=PfD4aa+Jm5hYeFE4hBQXRjZNwvhLrrZleypX5bxo/karqZOiCO4Qo0yCKrtHtH1TIh
         TXP0VS7enqJJfgRsIIq2y9wdjgt/PKp0HF4Dj6wRx7YfmRBrMUve9DhUNV+GEPcRVkFO
         hzI1GjMdUFCp/28MsXyYkW1aBPwTUBB0gKN+09k5a3rK9jUJfeDVkKqfJfTN9JO1KyNk
         9OuHkgsxzqAMIk7oS+h9w5OzN2cn7wr4OPKHVFpALKwU5rfAsTTCenCHNLihNJPDhqFF
         ZBMDDDRIO1+uExsz0QMnXrtguevK4WEp2Rdlj9f/8/bQyuFiprqxN+pM/WV1K62CiXcm
         2b9A==
X-Gm-Message-State: AOJu0Yxzt+3f9z93qViCpkN8j8PZzfbyXpmNHebl5tzMe3LNCCyqpG0a
	f70Y+OrjVB6rypwIP3IvxX58GoIhPCdjR9+ACAyF8fW+euZjKgty6/XoO9B6xwWFoak=
X-Gm-Gg: ASbGncv58w1OJU23iufnvxDfRCBSNHJDIKnUu7S/iU4NFaSGcBbsgE9rQp0QlgzZ02C
	QngR4HEzyRleHGrS1JPy8JtJuu2QTtqvjfK9zGuTl1+J73AarAQBDw8GX+lixb8R7Iiyex5hGe8
	vgCmPBP6XCuf5+hbEkNW9RXCXe/lCQge1m7rHzo5kda7bPL9/g/jtarj0rW8z+R8Pxk4VvTzbnl
	uFt4WIjdUm/HZVFOl0srxNW96V5maebFybvBNgPoAlzxiUm3tq0wgTnYvE1XWuGwyFm6nfroOF7
	Mv5RH7YG1s/ztCpPqeLpl766givqJswU8dD/2W97pa8MKDKJa8GDFSVVpvMtn2SJc0Jgc5xc7Fa
	zmfUtuYIVArrJoqfHGHiLLtN1d1lftRjCAZeqZKwILh3HUlSKZj0AIOuf9655CG9TR7OIjUurjC
	ZWhhtelwZS6cCLh5BE
X-Google-Smtp-Source: AGHT+IGM6LazFp2mSfgZ9xBnbGP6M9hpAAYO7X9ryVeCtJlSZaxmstc5s6rhO0igzS0nmtIalIlyNg==
X-Received: by 2002:a17:906:7312:b0:b3f:331a:a98c with SMTP id a640c23a62f3a-b6472c64be8mr763154366b.4.1760943357324;
        Sun, 19 Oct 2025 23:55:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036a3esm711731466b.46.2025.10.19.23.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:55:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20251010-acpm-clk-v6-4-321ee8826fd4@linaro.org>
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
 <20251010-acpm-clk-v6-4-321ee8826fd4@linaro.org>
Subject: Re: (subset) [PATCH v6 4/6] clk: samsung: add Exynos ACPM clock
 driver
Message-Id: <176094335539.18498.16396321408282036378.b4-ty@linaro.org>
Date: Mon, 20 Oct 2025 08:55:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 10 Oct 2025 12:46:34 +0000, Tudor Ambarus wrote:
> Add the Exynos ACPM clock driver. It provides support for clocks that
> are controlled by firmware that implements the ACPM interface.
> 
> 

Applied, thanks!

[4/6] clk: samsung: add Exynos ACPM clock driver
      https://git.kernel.org/krzk/linux/c/40498a74205371400a5b0088acb886ac47a523aa

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


