Return-Path: <linux-kernel+bounces-827396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4412B91A58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D46B11902B68
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CDB1EF091;
	Mon, 22 Sep 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="u+xzBCaA"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7D1DF754
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550951; cv=none; b=D3XsexJyWgwIAIF38O5gJT5Dc4Tz8iNrAXNBbqAn7ylSVEgwYmv5vQLf8mq5KpfoM6Lf+yf1gIsb3hD4PtNDK7olXxrwH+BP76dT+3bVm1eRRSOsPVs0+QyfzAK3cfrM9B3FrYeXU4qRkoVjEdY6YwRD3uXmEONqLYjUaB3x2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550951; c=relaxed/simple;
	bh=SjkP5yGz/xRxx4pQdR4vQflYXtDB494tBUDB3Z6Py1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZJdY5ZxWEhjCfuM2D0kem5eAXRglAhaY2AVq+voJ5M7HORIc5m/iAXMRDC07Ao9pcWZeBtp0Pf8h1GUwO8+BtbHFJhGSyQeyUTQ+Sg0uwTtTVePAz713EikaQDpJW2/Fnhof4xwiDTUHH1pNL72j744pN2kb3tgvB2enIA7uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=u+xzBCaA; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3682ac7f33fso17854491fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758550947; x=1759155747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjkP5yGz/xRxx4pQdR4vQflYXtDB494tBUDB3Z6Py1E=;
        b=u+xzBCaA1koPlaWuSNuCzf3dtOMkZ1fjgzQVN7T9x3fjLpbXkZHK5a3F7IcaPgcUwD
         AXORU/H16epV44OXJQJov35BZDrIIEJ7FsYT9lXyeXWLtxILytdQnQboCyi0EyV4aJZz
         +pfAwsuZXowlxDMJR4uWAaEYARjy2pOQ6U/MEx+wtMP6otxhP/Ulc2O937UJfjB2X4Z+
         SWxrfwzSCIje+FJHpOXz+r5AMTummOOcWXOrnplSwMzZPeA4reqn9t46jR1oGpCs2IA4
         97RmaweRg1Yshe0ECZT+NRdfyay7MLfkp147NEsBUNaMWcLDWd6ZgECiodYKQOk+KAXP
         HHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550947; x=1759155747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjkP5yGz/xRxx4pQdR4vQflYXtDB494tBUDB3Z6Py1E=;
        b=JGJji8fgi68lnTKPTIH6jgOb44QTrriGlgvybMFxkeMrrwAzXoS2YVN74jRh1lDs2J
         0EPMP7FrBD0K0RqyYdypFzfT6twXWwRzpm2ZqRMVQlTpwE+CkNP0YJOVNtwehmOsZAq8
         MIXLGN0tAgIioOEjIkfiJqLegqsHU1jaMS9AIV14ZoGaekrhYakBlMnUFINxWXcoNDPy
         in1L7WzJVc13ZUAODJkMhhzPwe5Whe48je+jfJrs5kRrptlQI5B7nOMHpoUGm0nIfgn4
         PJTncFkbM1LCcReUIlLELY5q4FLUa9PSTd4Kd9eL0fweI7yknpa8aIR7aOBzUJdiDZ55
         PF7w==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+9pJUmkDwrvMZj/n+cGAOoQwM8oGhA7mdf723/6YxnAyMuXq8ZEqWrYAgRJCfyFRpZvjfyPqXkibWPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0PTogk4lZ5tSbYv7jRlLceUOsdR012ruDnXap9CU8hpV7H5BD
	gk4RrA2hggj0AOR0eKtDbDYwsvLyj8vYgvkF6e6BqwGq9EFtc3zKx6IkvNrmyueVZJugbkOrJNJ
	dNWfn9uMf1DssboYdylO4Hjp0q8ecDnbSlPAOBT6ngA==
X-Gm-Gg: ASbGncvR6vliq/+jCnyAc81H0Lndcokm8tISN/lbGJY0BhEdU3ACaHW3P+G39CnADSS
	kg9/AXpz+tjyn7hgLJw+1slFRyeZog5tliFd0HAyv8e2r4XoSrZ41y/JdfV48/EQlcQLK9+v4J1
	VjpWqb1EIzA6nGQS8nkhapipJioeZLvKxpYfWpjFAywqksXpzJzEtqHqQ287FuChm8jV7AR6qDb
	/loSkPmR3KiynlmsJPRSG+5eX05tk0cJLxq2H9NmPyuGODt
X-Google-Smtp-Source: AGHT+IHM84ueQYZ9iZ0Qa4Qm9CUg13Hf0FdD3aE1fsoAwS/ftbhluR15FvogGC5XBgUTZZOIIabAnpI8Xb0tC2gPGbk=
X-Received: by 2002:a2e:be2c:0:b0:336:b891:18db with SMTP id
 38308e7fff4ca-3640783d62cmr42506421fa.2.1758550947438; Mon, 22 Sep 2025
 07:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918104009.94754-1-herve.codina@bootlin.com> <20250918104009.94754-6-herve.codina@bootlin.com>
In-Reply-To: <20250918104009.94754-6-herve.codina@bootlin.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 16:22:14 +0200
X-Gm-Features: AS18NWD1ipwVFTExS5bz_jzcAnlunJqilyv8xe6onY25Xz_C9hqGC8HY_m9G3Qs
Message-ID: <CAMRc=Mf9OB03FXEpSXG8XeJhtd7MkwJTH=rY11SBb9SazCMqJw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] ARM: dts: r9a06g032: Add GPIO controllers
To: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Hoan Tran <hoan@os.amperecomputing.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Phil Edworthy <phil.edworthy@renesas.com>, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Pascal Eberhard <pascal.eberhard@se.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 12:40=E2=80=AFPM Herve Codina (Schneider Electric)
<herve.codina@bootlin.com> wrote:
>
> Add GPIO controllers (Synosys DesignWare IPs) available in the
> r9a06g032 (RZ/N1D) SoC.
>
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.co=
m>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

