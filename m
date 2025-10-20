Return-Path: <linux-kernel+bounces-860188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B813CBEF8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE1A3E1440
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB12E090A;
	Mon, 20 Oct 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKBlNSmA"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBB2DF3D1
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943363; cv=none; b=ETDwTdjL5d23XqfTpQeGCO4dRkUaV6Tx23tP9AaMZMDIdJnzX++qXF4N7fB37Y0fnF18jRKEdJI2/24D778ANZJB3eX2qEstJIhmx/iSj0ZVFduBS9vsgI+c1ZnGkBurRy0KjOe3r7GVbExivG7Sity8W0Pf9u4/4AsA75d3LVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943363; c=relaxed/simple;
	bh=IuhePpDwW9vcsRvZZXVskNe/TnkA6rORionZyn8mAx0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ch6glDc9EAcS55BphK/kuPJ4DacLF0+JpUe+fgVws/vl4dmf/tfMAQIkBJAbTaQpDD8FIB59y+RGh8WDg8WMVdxObw7DnWvuXVomCwBnwPXhKOtESRQq6MSsVdnaCypwbaILQxu3GfKox4YPk/vtbg0g4V77r/yRUEvQrgUaMTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zKBlNSmA; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b6a29291cebso8808866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760943359; x=1761548159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Czacv4czTyoltt/AnMN+6IUHG+NujxotRkdbKUYJy0Y=;
        b=zKBlNSmAII4Ekas7fQzlbz97M24xN5Qzz+W6cv1LVd+tIuXDoTC8a6LXfZ/quMtXRf
         Gx1Ke8hBAcStlXb9dHUcDApsfQInPb1BmZP8fz/whZ3unlwnBItFdB2/ZL66EruVnZkX
         d+5dvVZ0V5U96iOQob6Ac45qpqu+ESoERYNDwwMJX9/WlL1DL0SwMyY2DlfnL3I74tIj
         KJ1fPslyPq7UlXqDYqv4mziYi82BWK1s0ysKdm1Pd6KeKRCW+lej/2kHoDHrx8j6Vgjg
         5Pr79ZdidFQBcjQvVXpF1afDLOps3YUjAOm6I/e7AL6TQzPJEDnej5Q5JB0iFomLmTee
         aodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760943359; x=1761548159;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Czacv4czTyoltt/AnMN+6IUHG+NujxotRkdbKUYJy0Y=;
        b=L8qskpEUkPLicOG59ZdJqnxpxhsHZumW9QG8AsFB0SsgXoPl/bR6TPkKJHrvXvZuLT
         1aJqrYgYuXVuHnSIgeUK5c6pOsWt0nQEuExAa6GDw7nPTkEFFalHDgz05NHq+fSPoK6y
         Mz0RaFLqm8mjV7r1zZShHFduCMMIrc5YANUQ5PV93HW0KlNuBgDl8PtwfM2FYlRO/Hna
         mpHyCzB5OeWzrA8v+jhQizMNNc6nbyv458DprYebWLdCEUhotE1oNxDjBatMknRACPhu
         z+yCj87gG0lEFuZpDlTMJIua39vG3DFAvtEw778phYozQIYeVD27N+IkmyQSzLHmJWyu
         c7cQ==
X-Gm-Message-State: AOJu0Ywb4oLJTuTrsEVEnG3HCDSl7dm6FW2tzxOQAsgjN3shRO55b4Ti
	BDPwpBBTjG3a09iNCbm5PH/aT6h1XffZQYXnWBz2BkcJhry5exqIDXJpYD+kO3UY/70=
X-Gm-Gg: ASbGncv9d3ee9PzMP0qVkRGIkxd1ZSt8Gr1D/670s60vNCCHq4ayKExRG6VqlOgqJdO
	+TS5P0AXsqk4I+bem+/Iyg6kII6ECbheIBoaV43n+oige7Pt0yerpeEKaaMygU/DZEmP9mFVkXb
	nluTvWY9VODaVXIEgE7IJCfy2oLKbybvAJ0Fk+uOCOgKBhJq22Lqk2VBSRZ2G5h6m3Rx7ZuwX/a
	Y4f6QrrHRMIoXLVfj+c+07dGzh4CQba6DfoxISNA0smT5axBtYAzL2LUWtubp+bR+ozOlRDf9XT
	z1kGsxs0dst7PocrE0VZ8M1GUWfEp0IDq91k/o2aMFNq3Kx8X7OSft4vYy4V899OZYRDqqpoXmX
	4frmUkFa0Q4VxzgO7A86Sa+2RpKB2tYMkbIewU7OMUtoplUUup3CoioLyt0EgH7Yz5rFKRYFBIW
	4vZTVivjNj7Q7lkjYg/dX0Eimqbpk=
X-Google-Smtp-Source: AGHT+IElilp8owkCzZnU/XdgVG40znc7ITwT4r+CN9LxeRdB7kJwCrsiR6HU18MteHFSt74cs5hlHw==
X-Received: by 2002:a17:906:9c83:b0:b3e:c7d5:4cb9 with SMTP id a640c23a62f3a-b647395aab0mr764832166b.5.1760943359427;
        Sun, 19 Oct 2025 23:55:59 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036a3esm711731466b.46.2025.10.19.23.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:55:58 -0700 (PDT)
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
In-Reply-To: <20251010-acpm-clk-v6-5-321ee8826fd4@linaro.org>
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
 <20251010-acpm-clk-v6-5-321ee8826fd4@linaro.org>
Subject: Re: (subset) [PATCH v6 5/6] arm64: defconfig: enable Exynos ACPM
 clocks
Message-Id: <176094335744.18498.3151941406927244021.b4-ty@linaro.org>
Date: Mon, 20 Oct 2025 08:55:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 10 Oct 2025 12:46:35 +0000, Tudor Ambarus wrote:
> Enable the Exynos ACPM clocks driver. Samsung Exynos platforms
> implement ACPM to provide support for clock configuration, PMIC
> and temperature sensors.
> 
> 

Applied, thanks!

[5/6] arm64: defconfig: enable Exynos ACPM clocks
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


