Return-Path: <linux-kernel+bounces-850548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894B6BD3260
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67463B0DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3260C2EC568;
	Mon, 13 Oct 2025 13:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymHa93Am"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E52E267D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361155; cv=none; b=BG9sW/xFylcuGPri0Q1v4cWQvrBrT0g055sIbPC938btOt+SMKoRm8BsAauHAH8HTSlBFoUbdXUbW3t8lr2HbqDSsw7xDrHIkhNOanYKD86kZ9pwFsomRsMuXqNwa0INcpECKwGrLK1wJ9HZxeW8sDysN05c7sq9pek0gFJDiSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361155; c=relaxed/simple;
	bh=cx8c00vvcYciQmbGZm3+AuToOvX/AiPHnZpUc62RD4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHQt4Ai7sfKoVpi2ICBe/AxPOJHw4v5LhJoPW2BApWecNdGfw1VpvcmUY/nNc5D4XRvXPyJN3OYD4szNjfSsF72cuOcxGmlFb6KPa2DQicLBozT81eO4mM2K/XSmfRkjTuDSS+gxq4KbkQ3wMbtNx1BKmnLzBHwcAic34VaDsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymHa93Am; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so36274491fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760361152; x=1760965952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cx8c00vvcYciQmbGZm3+AuToOvX/AiPHnZpUc62RD4E=;
        b=ymHa93AmOHyeoIONqnse0WzUIiaL5YmZCK/9aCdAoMvu94TZJBsUKdt0NIgfIFaFRi
         ZT2Lb5nA4r9lgLM4hea1nolQBO4mlbMqnELea+rszXep+RF5/G/lLhreR94Raxh9Osge
         6TCkbRieIDbrgA6J69IlwVFBGToALIZo5yx6CdpeSqqA46h1Nn86HUgJQIiWzVEuolUd
         K6FvR7OK6rnPlCGmQdvbhkA9ynaibN2eVTiNS98MNquhhH2lQV2fk7LiE9aY7o8hB1Sd
         MU3MsWtrgnPKCDkmYpGWSgbVNwZnNgjtCvV++qflS0q0pyGq5XLvv6FmMHN+5at7stfb
         6F0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361152; x=1760965952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cx8c00vvcYciQmbGZm3+AuToOvX/AiPHnZpUc62RD4E=;
        b=ARTGPdM3/CB639HcxwNw9+STBgBGN2oUQr1HfHsd/7ksudYwkiULP+mk1cAVRD+Irv
         fFV5FgF08Q5VCGCFZIjE7kTFc9XML3+TR8PbRf4WFbXgen7h6tELuxvqbu8PqxivCYCr
         nHM1+H+KicyP4wZv3VhH93ABBR8qUmW2fa9ID+RNgW2txhHLdTdn3f4ibJXBKTCsdCLv
         CWF3hOF8PUygeihEFKjM2WqAv7TrlK3kOTKYa+Oh1pyX1EwjUXfLOhIgsDFghrlcyISh
         QcLAmoOkROkbPIP8uTPDdnHMV4cBMC561Cm9BdEv7AXSvacLtbO1g8zGJVeRIHdXwwrX
         I/RA==
X-Forwarded-Encrypted: i=1; AJvYcCWicq/D8Ioqe1px8f9pBwWkyNvgN7JHgF30eWbiMP5yzMfUXe1SPejOe7J4QBaMd/HLPteXf9fsggdIjrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUChfwB+27oikGngr1IvfBZujEQrGLL9wClV1256oPkodtKiHK
	0SpBiz9K+nSLtKE51CS2Dd8wlAmiYAhT9aWFobwiEPHhtR+xXyO5yeMVF9Dd0rPrPj1p5Mtz8uS
	aW2v9z9ps6eoTASCxhsM9YKljx4WzljJXzYWI1FelTw==
X-Gm-Gg: ASbGnctPLMoJxlUJs3ZCs5gDPuZ0xhIDsiAeBVXp3goIuQP7EGvTeavFwmV4BqfUDt1
	V8yckNenXdFB56H0UdT2RfyceqRru2rnjcsLNO/MoKa0Nnfmi0VipIPFjvEgxmzWV7HsnuMZqSW
	TVy1qLf97FWiQVWIoN7ywvpijr0KA/WQGjqo/Y3tflhUZksJ0BOZGZN95jp2egsbZ8X0VEWJPjn
	zniumwjjPZQ4DjiNhvsGesWIJFwrHegt56x9p5x
X-Google-Smtp-Source: AGHT+IFy7QQZzDisxgLU7RQiHqmGLbp9GU/ko5TeFOP01cdLTHtzWG4syZZ8PgjrdKymxne7+Wg23WBWjWeGpiwOdDo=
X-Received: by 2002:a05:651c:4394:20b0:376:45a3:27c4 with SMTP id
 38308e7fff4ca-37645a32d2dmr19705401fa.5.1760361151675; Mon, 13 Oct 2025
 06:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008073046.23231-1-clamor95@gmail.com> <20251008073046.23231-2-clamor95@gmail.com>
In-Reply-To: <20251008073046.23231-2-clamor95@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 15:12:20 +0200
X-Gm-Features: AS18NWB0Tr61DfHtPSZqpJT6vjMUO75ud5f5_b3M4zNOdVsqYQjTLusmQxbBsw4
Message-ID: <CACRpkda3o55N2m=H+RA2p0r598KBLv6bbbin76Uu5Sy44qCLig@mail.gmail.com>
Subject: Re: [PATCH v4 01/24] pinctrl: tegra20: register csus_mux clock
To: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
	Dmitry Osipenko <digetx@gmail.com>, Charan Pedumuru <charan.pedumuru@gmail.com>, 
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, Aaron Kling <webgeek1234@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 9:31=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.com=
> wrote:

> Add csus_mux for further use as the csus clock parent, similar to how the
> cdev1 and cdev2 muxes are utilized. Additionally, constify the cdev paren=
t
> name lists to resolve checkpatch warnings.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

This patch looks like it can be applied independently from the rest,
can I get a review from Thierry or someone else at nVidia so I
can just apply it?

Yours,
Linus Walleij

