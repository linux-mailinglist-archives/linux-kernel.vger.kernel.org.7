Return-Path: <linux-kernel+bounces-773929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A62B2AC7E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42751702F1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137D9248F72;
	Mon, 18 Aug 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DRWiZ4Hh"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F1524886A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530187; cv=none; b=fVBsBMFZu7Hd81t/nB5v7v3vwr7SBY1UXdj9/nfRCYsB799BI0VhmmpBp/Z9I2lyoR9BDNdHFKqk3uq70d9CfAMinbl7BAWbmLR0Ik2hxdyBwph2zGcYTFW+SMkuZ0YERZZTCUchhl6oSA+y5ADyL+Zje2c6F+9Tij2oJDBu/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530187; c=relaxed/simple;
	bh=5l8fao5tyyCXjqpBW/epFwUkG6rVSrLdqtcUPVUunrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8vbUyQvs4Qgxm4gbN8lpU+maW5pXW9Eop9mVKpUGH1RWB4mAlL7Ggewf+rqiXPrc3zEt3IPD+OzgmgKpoeyukx16SXxoHIcCg6CUCojSm/qM5eR427ZZXk2GfydX3uLxdDcCngADa5sFGRoWbZJT2oa4injx/TB7UWgFpxuSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DRWiZ4Hh; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-333f8db5aedso30982851fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755530184; x=1756134984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l8fao5tyyCXjqpBW/epFwUkG6rVSrLdqtcUPVUunrE=;
        b=DRWiZ4HhajMQipwt5VgmjcjbAgFaTzu5dOHCeOm8wgz+TuTymCz3Xvd/uvYowflnks
         lrPUb9WpvXqwR2eiUgXD5DaILJHL4ll0yk6n9E51imjvtNfsB6+jHcm9+7OZtJAtZgPY
         v2WS/ZTXfyu44y6w6+91J7nIHXoSwE9AIFXhyiUDxpghkjtNSil9+/471Z2jN+wHjS4W
         ZgRcyuG63jZ5CdapfpZhecMM7MLaqO3g1pupwEtO520OXuyVXOiKUTgTROGD/9Qmmr4Z
         bSfSz6+4OiGUSVq2oSXg2mgsM2DKZa0W0ImYEG/fiVKnJFiZ00+eOT6IC10/IYlEpyrA
         s+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755530184; x=1756134984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l8fao5tyyCXjqpBW/epFwUkG6rVSrLdqtcUPVUunrE=;
        b=NpdH4SD309oTPDOKQJIrGOIj+qoPPWzYfc6VCe+Gw4MRfKsBQwrPbD3sggTb5wvUyI
         jqcQY9lm7YWb87WInZS8GUfqIGRUYsjMLNoCKFLrtU4lu9FfIH7FUIycGrvUgoEjO3IX
         orxz/O43BNDPB6trKS5h6AICFNfamf6F+hjDwnJdk0ragSQgx38VqR8j2GZJOQvyzJBR
         5T4hfmXLM/mjS7K6p1Tkc23HEcWd4UdyAYNVCMjTlrHly4olW7UUnXNbmpPnRXUQV+Fx
         QqYaCt9kfveWb0LCQJkvDfW1H94kK8UEUf850oE6j0ObyhSQww+JtB8XzS4OqQAnDbBp
         4EcA==
X-Forwarded-Encrypted: i=1; AJvYcCUlwPe1r35J6kBsxoKBMAWSpSm8Q4UHqBU+FMKfNeXz8P+/L3ndoC9txxYN0qPv7CyF4+h+BHHCHvNtTXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9MXL5JlGtOhV94pF1EHv9y+NAGm+Bxj5XSW75tlhk2v7LLivr
	V8fN5FaJiaguXY0isibOTLukUyLxPIqINq44d/biWZKiBEvIydDJLK6ztUPhBzWBxVKV4/ciUQ7
	VD0NoKGS3zQJt2BJsNa5jqJrGOgEM0TsqYGvWvgG49A==
X-Gm-Gg: ASbGnctkz1+dBAe3GEhD+je+t1lJi2800i9yzKVIzLJgi1elfLM9hYPcgWQ95wsbdlN
	blef/reVuB8aqH0dMqHCDz3mfGq3oXrTUma28v425/csZ5RT23iT6ADVykduQOWp2YuV+BwBwqV
	KGFUL7TzZCbIFtrGyom1JVQfSIHHLWuaR43lB6h8FdnpsBrpLkBMTA6pri1cHZGv5aSsP8Me1NH
	l7t5iw=
X-Google-Smtp-Source: AGHT+IGzqxCnqLVvPxKCko2DlB85KniY6TF5HHlMzLUiXgvNhvXoucfmnrbgjKUH/ALtayc9hnqKx6ybbX/dLc1uNDE=
X-Received: by 2002:a05:651c:198d:b0:332:4528:c0e0 with SMTP id
 38308e7fff4ca-3340996011cmr37441011fa.32.1755530183649; Mon, 18 Aug 2025
 08:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801-mtk-dtb-warnings-v1-0-6ba4e432427b@collabora.com> <20250801-mtk-dtb-warnings-v1-7-6ba4e432427b@collabora.com>
In-Reply-To: <20250801-mtk-dtb-warnings-v1-7-6ba4e432427b@collabora.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 18 Aug 2025 17:16:12 +0200
X-Gm-Features: Ac12FXxjGtIqn77Wg-HXxURZEtSYdu71ByUfcWhpILl9XIWrUY16-cZaSQJoAaQ
Message-ID: <CACRpkdZpUhPERPFvNTwormrqz-H-5VUDaOrRQQ2ap+Oe6YN2Qg@mail.gmail.com>
Subject: Re: [PATCH 7/9] dt-bindings: pinctrl: mediatek: mt8183: Allow gpio-line-names
To: Julien Massot <julien.massot@collabora.com>
Cc: kernel@collabora.com, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Ikjoon Jang <ikjn@chromium.org>, 
	Enric Balletbo i Serra <eballetbo@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
	Weiyi Lu <weiyi.lu@mediatek.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Julien Massot <jmassot@collabora.com>, Sean Wang <sean.wang@kernel.org>, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 1:18=E2=80=AFPM Julien Massot
<julien.massot@collabora.com> wrote:

> Add support for the 'gpio-line-names' property in the MT8183 pinctrl
> binding.
> This allows naming the GPIOs, which is already done in several
> device trees (e.g. mt8183-kukui-jacuzzi.dtsi, mt8183-kukui-kakadu.dtsi,
> mt8183-kukui-krane.dtsi), but was previously generating DT schema
> warnings.
>
> Signed-off-by: Julien Massot <julien.massot@collabora.com>

This patch 7/9 applied to the pinctrl tree.

Yours,
Linus Walleij

