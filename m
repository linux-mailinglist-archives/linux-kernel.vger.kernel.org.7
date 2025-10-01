Return-Path: <linux-kernel+bounces-838489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4696CBAF505
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35653C2DC0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EF023E23C;
	Wed,  1 Oct 2025 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ldnhcjb6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1A023C8CD
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301884; cv=none; b=SbCShvXwDfH+mHy9KRmy90czaGL7xktyM9Kzpo4QcSwCRewU68HzTK9eQ7i6rALyNSAllmeNb+mej0GFv9mP1awUhelrigojC62R4zEiZ2UYs66qArfKN04WOBH0kO68eYkX3QBY702XVWmRNfHNYvzNzJScBruKIkCXbkMWDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301884; c=relaxed/simple;
	bh=hfCe8SmQAHAct7mpZyJeNqeq8O+Ruejbrp48T/gcUh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKSEJ8qVV1pqjDYcd/V3zUPJ62MIWuUi7WOCtgzgXW2gFlETMPd5PkjFpcKgwE6L9jvQKsE9ut5va6HcHh5dAcNQV11D/yxxBLUKmWJ9p23PPIEBtIaMmitL99OodYkur6Xmcoczn57gQPqJy6mcOSmsRz5Tk17NNCjYa4Zdq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ldnhcjb6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3696f1d5102so60095941fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759301880; x=1759906680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hfCe8SmQAHAct7mpZyJeNqeq8O+Ruejbrp48T/gcUh4=;
        b=Ldnhcjb61uXjdr9zylGJieG7AtCoVHGe/ndwlXeVqCx6H544qlfC1sH5cpv2fqTHI1
         RD5GlU8CPdbfnKSEgyF3giOQomDqZXaWxnJtWxXUiuX00QyUKi1AhLsVg8k2AvBQ2hia
         272ay5lBDU1ncuQ0d3X5JNdLUZL/6RpHv9av1Zx7VTILQN0gyW6oTXxsxMHdsFrDMOnM
         JLHDVEdpRMcqcFtB7aa94g3aFXWY/G2cqHbyKShv1lBpCi0q5cW0jsKyC7gbJxTTCpqC
         /2DEpllaGzlJ4okIyzBp+C8wNZRu5BACHK6iY624SuQ098FPWDfexnCLHEQnC/rwN24t
         x+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759301880; x=1759906680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hfCe8SmQAHAct7mpZyJeNqeq8O+Ruejbrp48T/gcUh4=;
        b=DQ4epq+DjIALXae3OhK2xkhjZ2/XN7vV9/lj2Tor4jJZE+prJB2FflZlLkcXUhB6Mn
         Ly/xk9iT/lz826hv6J1Z6O4b9M+Btnv2ns0T314bOnTR875ZL9eSAYQRYuBjV7b1WVAz
         sgqcpI6a2ftl/kWKCYFHB+LjYeSsZAlpmYgLBMoASr5NDBBjawgebii5HzhQqtwEUMPt
         seButd3gY/tytkJejq00FuPavgHVQEfI74jKPSOe1ua3+UioaGQxdqRo28kBtqPjtM3g
         EssDrRJAmn8asD1NAONlV1/68UK53MFA/xPTD4HY7jfk+UovwwYhyJ8WidrnShNZpFbi
         KTGA==
X-Forwarded-Encrypted: i=1; AJvYcCXNPCovzdVUZOei7s9OnnT7fpPSdAliZKhTwRlZ/Sb1NweiOWUp/QzLmtLq28KhVbN6aAn0RpBVgDiE2DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFzYbPopKya15/F/FXdk9LzrPi29pGEKima7v+tN6+jdh5/xy
	FQsa11ph+9GKB2cgH4OzPo/biqJP6Ml4JPcTvwi9CiUOUM2zs4G/6f+ipZWt3l58KCUWQ1lZuMv
	Bgj6V6Cmma3jNRBOBe9xaNGQeVn+enTbhdLZlRn94fQ==
X-Gm-Gg: ASbGnctkiOb16DUIMKAiwQbtd6KLVaOXkUP6JbQj8ML2XIpsxD3KUjjJWRFtjw1GTjs
	5fkkyBWBV3t3KpOleHL8K90iLWVw5DabDSLqwb48N30fURXZ9cAxiVZDltIwT5o1HeBuN8OTYVo
	/hhHEkhzPcceRVzEP72NPHmCXtFRNINJLMgsRb7I3LOuV7Hfxe9yTujWiqFFQrw3Pg48hyePeAI
	seKLUKKWT/IoNfq+Y1UNreImVgfiVI=
X-Google-Smtp-Source: AGHT+IEFYBTk9nGSfmBNRwdlnBZfU/Sd6UTKJyGtF8VquxDEPDVY/XxX8lcgahg6Ei0VXCczWM+mbwbqwLB0jcHsDcE=
X-Received: by 2002:a2e:a548:0:b0:332:37d5:da95 with SMTP id
 38308e7fff4ca-373a7404f33mr8420991fa.33.1759301880298; Tue, 30 Sep 2025
 23:58:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922200413.309707-1-shenwei.wang@nxp.com> <20250922200413.309707-4-shenwei.wang@nxp.com>
In-Reply-To: <20250922200413.309707-4-shenwei.wang@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 08:57:49 +0200
X-Gm-Features: AS18NWAuz5cqgLXrZSSINvwGEDmvTaVcLOQI-X1PgOUAiEVmWUpsc5bfCXSgBKo
Message-ID: <CACRpkdbB+DfhqUE-fsz_RQ1U02+nMEhNsXrKB4bd6dvLDLjWUQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] gpio: imx-rpmsg: add imx-rpmsg GPIO driver
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"

Hi Shenwei,

thanks for your patch!

This patch was not sent to the linux-gpio@vger.kernel.org
mailing list, please include that or we can't merge the driver.

I think the OpenAMP project should show interest in this
patch series so I created an issue in their github:
https://github.com/OpenAMP/website/issues/122

After fixing the issues pointed out by Peng the driver
looks good to me.

Yours,
Linus Walleij

