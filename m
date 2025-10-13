Return-Path: <linux-kernel+bounces-849836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419FBD10AB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 844874E741E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5951A1E5B72;
	Mon, 13 Oct 2025 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0k1PdCc"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E71D7E4A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317334; cv=none; b=DzpTEIRMjnKsHeh3//ydpx6u7Pcl2sSbyqp/SfEH7Ww8fIXREK1+hfcSFkXrd/w3Esfy4OYbuVJk+D/y0pphAhjXWHx5o5biLET+UtE7XKo2Lp32tW29WC+n2jstiM7yj0HgwqBXqkMpm2A9Sq/zw9ypVEOhFrItvcJ+NVpMrww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317334; c=relaxed/simple;
	bh=hPO3fb9A5GUMjlwesrVBFk2doqpjzcMDbOWwmKe2wnI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eBnM8Mj5BnMLfnVdeO7x6IMlr/rw1sQJwfYAfY7f+PDMQ2nftDXJVjubpwDgO5S6dVteG6qMrYvs/k+jc20StvLo/wsknhwXp0kWHD6iNgo9q4pR3Ed/hWGoek1wsyqO7Is7vsQZveGh63lAhqswNin+rlhg0A2+uTaJZA2S8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v0k1PdCc; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5538e4343fso87769a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317332; x=1760922132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10a4vKq6IEmQUW56jJWKaFLXuKf0sl8IrALpzNZuGbU=;
        b=v0k1PdCcMHpIJAj+EkMYnEy7cH0xMYWMKeWr5Gu30AL0CUYnG6OzFlIgGi1v/C4so9
         kGNta/zreolQcmUr6TdorZWBctyCclXRKnzW5y5RrGfgVxWsjuJFnj00jRbKTlABScTA
         DxZchP+CiwdCzYdijY5NJL7t7De8anxvxJSiYsPBLOZeCfrtwzqa2hc9dHep663OBJXU
         EO+7TCTBOj9FUcMHPnm1uN2QZV/X2InUp1+vbL8NsDy7DK8Y8C/jfXYVmCtXost56Neu
         GodZ4oRlNPkKmXa5CtA4uIdeJILbfnTHihnaYdFdRdNLfxjVvk3SZRATSbsA+iH6Bycc
         Gplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317332; x=1760922132;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10a4vKq6IEmQUW56jJWKaFLXuKf0sl8IrALpzNZuGbU=;
        b=LQ7gDFZo0RDFvj/JcF3zg+QflSQJGSmetZMKazK6pj4MpCVJ5nu7DCLeYHB9qNL1XS
         muFhdPay4RdErSgxiFDGWu9IkLgdqtZZbFVV23tHQwl0F+d6mRJ1r8Na7wZK1/XZ7zX9
         tn+NZa4Mxcbe0h75kuamj+60Gc7wOBX5cMatiGSQuIEdkIbOxQFPqXjTCHqf1iCtDNgl
         4+6wSsLzzIe9rBVHOGnntrl/fn7Y1t6U0tPfoUDbB2UO4+mp9JeU8ewXbzpbfDszaiwi
         2Vvkm5ld2R2SrwImONY84k3X4lp3VeGi4FAEq5oPWAoMhN7ah5vOUhHFmW5A0U6uGRCC
         eOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUutuipYzvEOaVBVQmuDzhYIQJ9Zucp82cPYusLhya63GFqbMByhE3reqNkCoQDH3oGP4lWJMIGQczdO6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw88k1NCibNtBQosoYyOyUXWbCsCFoWu0mbMLJfRHolK3Hx/44r
	jJnu0QmJ4L/xeDUge5GMeccHSO+ex4KOahS5TfsMYlcbL6ij5PuCBffeki+29ohFBzY=
X-Gm-Gg: ASbGncuAzCiTXdk98kvI3P0nQc+mKamy4y8F3752coYDs2huS/S6xVia8oIq9VqjqX2
	PVJJCeaYwqODXY7cetAEbKQUYsAYw+v5S0A6QROBlmZPUQUyDY++vYIKOel0GRCxP0WFoHiXf4r
	uI5z8At7vI5WpRzYhQZ6VmxjqofWkh4HgIAvyiRJMAt+MQj6YTGrhmL26zb0ke25pkcWPuDqM4G
	cJxVxdOj6dAHhu/DGeXfX5SkBsbRbarT2G2Db0jintnBUV50i/dlI0QmL5KuSzVtCAHuzPe4SiH
	0gQzFge6yVO1/lQQ2Xs9EmsW1kbT2UtGVg0pwgA9gJI4cctxIuoJeXpow9IYEuJ+lAm7AawTYSK
	99ciFiS4N2BGe23jxSd52db/xt2kEEG56XMdvd+h9pl/nZX5QSQBDQR96cObh
X-Google-Smtp-Source: AGHT+IEt21JJ0GbW52Ae6IIeXGAxkDnv8PoqVX129SAInTnAX3MkkPG+Hi8yBSex+9tD040Mp73hFw==
X-Received: by 2002:a05:6a20:d526:b0:2f9:74d6:440e with SMTP id adf61e73a8af0-32da8508ec1mr13363457637.8.1760317332410;
        Sun, 12 Oct 2025 18:02:12 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:02:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org, 
 linux-i2c@vger.kernel.org
In-Reply-To: <20250917-perics-add-usinodes-v3-2-a3629e4666ef@gmail.com>
References: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
 <20250917-perics-add-usinodes-v3-2-a3629e4666ef@gmail.com>
Subject: Re: (subset) [PATCH v3 2/7] arm64: dts: exynos990: Add sysreg
 nodes for PERIC0 and PERIC1
Message-Id: <176031732773.32330.8134222095806318376.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:02:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Sep 2025 21:04:22 +0000, Denzeel Oliva wrote:
> Add syscon nodes for PERIC0 and PERIC1 blocks.
> These are required for configuring the USI, SPI and I2C controllers.
> 
> 

Applied, thanks!

[2/7] arm64: dts: exynos990: Add sysreg nodes for PERIC0 and PERIC1
      https://git.kernel.org/krzk/linux/c/1e6daba7a3c05af0f8b02cb59e71ce18fb913aa6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


