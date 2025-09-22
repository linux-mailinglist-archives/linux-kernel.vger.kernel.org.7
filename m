Return-Path: <linux-kernel+bounces-827518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B0DB91F68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3E54275DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77EA2E8E0D;
	Mon, 22 Sep 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EbcZ8RqS"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACE32E92B2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555219; cv=none; b=cj0xjz2ATwIOdIYvEbZYDyuqz8/Yd1vmsc/2dHaaUKZJ/zFvkRXpjk07L2Y3jXSgWQcI56mdAUd3RAtsILsTInhaig/c7+dMzglMq78ebK59n9Twb3mEqC0TxkuNP3F3fLE4ffvQIxo1ZCeik4csIro1mByd2yc6Zl9zlWY1Ezk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555219; c=relaxed/simple;
	bh=9GDSk+7eMD2m4olz8yNUDHsfzJO5iPrhK7AiGouP2SQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1f04txMb22nPZ0N0Sn8p46Rxa4JSXbwLos5weDZ8uKqtdNRNO1pLXeLskq80jcoSY6gzpBAKHiy3NcXBJmK5SfKV4YPR1hupHQdsTpJVCrWmMYSaYHiB4CbPFKeHfzSu4Oud8Qj4uSmb13jTpZNS04xD2/AZ1Dvch4Bjpm3vXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EbcZ8RqS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57d93a4b637so1551320e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758555215; x=1759160015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9GDSk+7eMD2m4olz8yNUDHsfzJO5iPrhK7AiGouP2SQ=;
        b=EbcZ8RqS4mvV5MmSP0RIRTEncBjwbZHP744uU278APuleIi9lH8l/VbXf+kqOevmgM
         SHzScm36ygXeXwUT11qNhOeXs6KR+Ugfegk7vO2eSCUzSd9WAwSEgHXGrtwyeeAojEaZ
         dEkjj5GImdttddn7cX6K7yZxi2MBkN2M+ht1N7M1qh3I37jt7FaIPCtsdYqnS+IyMNQ7
         973Ir883NnIApSuoAYxUsmJ0FLrm2fRP69vDPz6LKdAihXiuVoMTByn7skf1VqU4wdqt
         cwyTeqQVSzis4elHj9vFijnySwYUIgvHqESIgC7Cgl8zSA+QOS8jHCx0lxEQWuFjwalZ
         FPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555215; x=1759160015;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9GDSk+7eMD2m4olz8yNUDHsfzJO5iPrhK7AiGouP2SQ=;
        b=nF/yENqg8XNCx8QyyWp25jBfBwvzYzauDslClk7j/qlEvA+sjALhLupz8ikUkbxwbS
         fCkWCjJywzDNUXlsEOgUTWKc7kKn9yJOlZuFEvE37h68A8hDETi8tt9spyUlYZh8wVv9
         r1sgndPjyw/8HsFgEYZxxSbIhEEb8dneOUkjikuov1ZL806sKUU19WM9xISl9t8IKnD8
         XK8gpTvKIrqKFsmEm2ffC+hKukFQxwTPBHdDFalt8kugz7j2gYWD72+zqyQUJst7P2+Q
         JwXF2PAEZaMxgWdSVRzJaeEPgObdxX9abS80PJem2qbbve+EnBW+1afCRiP7ZSrr7bo4
         W0KA==
X-Forwarded-Encrypted: i=1; AJvYcCWR+aUm/vow5tvdqwPXE3Xx3QSnIMPq6DxPvFJyRvQ/MIieT9AR0tZjz6rGiZr6hW2AUK5E1staUZ+tLBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ri+ezZ/AMbcME4rZDdM0eZyRBa/+s1OrYMLHsW+Fb+M8bg4i
	tGcFTwYnpCpbSENeFE9K2dpyFN8r55koc3CVMR+ymFUodxEN8ok90fsNsphksXtOMFjyIXO+jti
	XB01V8M0o2gO5/ge8mMdL9+CEHsYDm9da2622M7v8Yg==
X-Gm-Gg: ASbGncvt1O10T6WMhj5TL/fgOoAy23C3T4jPhQvwHVawhhfg3HFU56C0nIwu1GtXUOM
	8LAnk616RnR4wax7DFXbUADs7663CpfjgQVS4xO6lXR8BC1L5EIFIwx2vbqltB66AeU8yeqR3nf
	PvDAofdMwYF7LVcX2XJ97XERaQJr6SmrMfRho9gyAOxwpg/ltWHKAji55WDhD1IJIUoaou4oVrD
	mvaIH2zmKWitS4IyN8UcANIfzIh4lhc2hCMoQ==
X-Google-Smtp-Source: AGHT+IGlZY4kCJWeN5dqXhMVz0wVth63k88LkQRY0NMxqg5N9plQEniHvw0FL0I709EW4Ka6RI0ByvFRASCxDMR0/MQ=
X-Received: by 2002:a05:6512:799:b0:55f:49ab:884a with SMTP id
 2adb3069b0e04-579e1f43c06mr3621448e87.21.1758555215241; Mon, 22 Sep 2025
 08:33:35 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 18:33:33 +0300
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 18:33:33 +0300
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20250922152640.154092-9-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922152640.154092-1-herve.codina@bootlin.com> <20250922152640.154092-9-herve.codina@bootlin.com>
Date: Mon, 22 Sep 2025 18:33:33 +0300
X-Gm-Features: AS18NWCFatxNFArvnh5SmkTj0DfmC7GBtzmB19TRGxTfynwgSMsjCS139sdcpWc
Message-ID: <CAMRc=Mfh_6kfreC6WNFvFE2X5RZmuHfuVQK+GQ2q6Df-4kJXCQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] ARM: dts: r9a06g032: Add support for GPIO interrupts
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Phil Edworthy <phil.edworthy@renesas.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Serge Semin <fancer.lancer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Sep 2025 17:26:39 +0200, "Herve Codina (Schneider
Electric)" <herve.codina@bootlin.com> said:
> In the RZ/N1 SoC, the GPIO interrupts are multiplexed using the GPIO
> Interrupt Multiplexer.
>
> Add the multiplexer node and connect GPIO interrupt lines to the
> multiplexer.
>
> The interrupt-map available in the multiplexer node has to be updated in
> dts files depending on the GPIO usage. Indeed, the usage of an interrupt
> for a GPIO is board dependent.
>
> Up to 8 GPIOs can be used as an interrupt line (one per multiplexer
> output interrupt).
>
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

