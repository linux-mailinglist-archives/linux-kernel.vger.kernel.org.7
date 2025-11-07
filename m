Return-Path: <linux-kernel+bounces-890439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD23C400F0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B275D3AE54D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82842D7DC3;
	Fri,  7 Nov 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmUk856L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD1B2D7D59
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521170; cv=none; b=aC2WDCFvPab0VhFCXqCHzesyTNGMOclFf5vKaWNi1YOltPmEXHZD7mqZrgPENvhaobr9EIeY3mYu6OVEOjw2TyJxnwV2N3HaL6e7XIo1/6Z5NMELMnVJ21/+hBO93OUylbvBrul4gqIzIVvqkrQB/tTGuNgx1Stht1wz+9opCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521170; c=relaxed/simple;
	bh=FWO/8gHk53RYXD8wsffSK2ke0SFZ1bG9gjIfGIFTJuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7JA9jrdia5n8CK/CFiWAP3pGLpMriSARm1I5tZfb5Q0C0jR8czXCO/27W8UG6c+2NWxrWI6T6oBjseui9nr8lkp0qhCKnNV70LL94qtCjBw8kgr6q3CE4bluhuUwxawrG886HwxDnZc5IX3UAnoRd+Ko0FoLciXr1M+JUAGE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmUk856L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7AEC2BCB5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762521169;
	bh=FWO/8gHk53RYXD8wsffSK2ke0SFZ1bG9gjIfGIFTJuI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=VmUk856LB3Ktid9JTM1p/HRUccXaDtTvjP+q4dhPWT4wSln/qPkV/VQu6vernisKV
	 TOiBfbwqozLZk5euuhK+PjZQPMezUhrIMdpfuKw2WKuqOZ9jIxlM+qYSwGmHlb53q7
	 YFWTsYSshNNpUqj4G0nHtU6ckASu72pJffLn1WR8CTKW3neiXm4XGYq8wXTMRuiXF0
	 YQTpO7XP/wsIoQ4PycZ9vGqeoMSSJWdUR0iew6wB1xUFKvfd1ZL3P5VabnSdmxy6IY
	 Em8ZkCAL4zE8XdO+35qZJIBafvwOzJSsIhwygOORffdFKPGIo4jxcwhjKvwckqScZx
	 kHA3V9Bh9hbtw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a48fc48deso6842091fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:12:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVNsFVM1VyvmTU3rAVcd7bwEDVYdmO2RYgJag7cqajT95aTdgOOTxApOcm3ReO8T11U6nsdHDCurjb1gXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfG2g4HNh55RRCTix8P//VXIu4JPb7ivXCPRzp6RHs+6f59pAD
	3fKJcgEbR2JKLEQcK+wlOtQ9uHUo1rER8aEayF2ZQoIRWDs4+YNB4xISH9H+xhib28r3ZTOXCKH
	hW4zg68x2lGE/4VWIWTSLuQ2VEy4L9J4=
X-Google-Smtp-Source: AGHT+IEi60U+MS5fuwhOECte6O05g72+EAD4tfI6rsUD0G2v7W8zO7uqdgB+Fmi8wi+riCfy3k40Cuh7KGFUeVlePak=
X-Received: by 2002:a05:651c:4014:b0:373:a675:cd5f with SMTP id
 38308e7fff4ca-37a73335a70mr6546391fa.39.1762521167522; Fri, 07 Nov 2025
 05:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-b4-of-match-matchine-data-v1-0-d780ea1780c2@linaro.org> <20251106-b4-of-match-matchine-data-v1-4-d780ea1780c2@linaro.org>
In-Reply-To: <20251106-b4-of-match-matchine-data-v1-4-d780ea1780c2@linaro.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 7 Nov 2025 22:12:34 +0900
X-Gmail-Original-Message-ID: <CAGb2v65fcCEqJEdSuH+n1BFtoBxSCxEXaxAk7norRWzpPoT2cg@mail.gmail.com>
X-Gm-Features: AWmQ_bknqHyNaA5_RcBhQtheiViI_1Nkl4lCccfeS9SBJtkNwcoPaIb-tzaunfo
Message-ID: <CAGb2v65fcCEqJEdSuH+n1BFtoBxSCxEXaxAk7norRWzpPoT2cg@mail.gmail.com>
Subject: Re: [PATCH 04/13] cpufreq: sun50i: Simplify with of_machine_device_match()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Yangtao Li <tiny.windzz@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 4:08=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Replace open-coded getting root OF node and matching against it with
> new of_machine_device_match() helper.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Chen-Yu Tsai <wens@kernel.org>

