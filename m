Return-Path: <linux-kernel+bounces-838453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA02BAF32D
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF024A5522
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB4C27AC21;
	Wed,  1 Oct 2025 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uh/fxsUD"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FE0296BD0
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299282; cv=none; b=p7b+OMTRFGbn7oeSdfqN+tZEhEkxD2XEvZfzaPcdDE2IsVGcd/sJmFi74Wim23ODV+4q1U5/FHgQPhX18d06nxD2SAxKlELHmboRXSwv/p1bKIY6BTx9aDcQBLLbpZ/CaOoCn/otaiWKFHL2GJ8B5NRSIAlyODfGq8q0Tm4XgWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299282; c=relaxed/simple;
	bh=9+pLrX0Q4NwZE9lEirGuVWH9jUzrol+ZXQHzqv0t/Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIeXmJbX+yflOS7JjXQtVG+Sc/TrLXYSM6sBFOSuBhTkPAiLCdpNLopjAeOSSOiEDRNwlxGcXAtfyeuyJPWW0ITlBrAiFOfSFBL/BqcVyRD+3aOq5MMIVCSojwIKETJHCtlCuXFlvl4UOQFQ9wMd1r5yteAzRdIP8F+9i2dkPgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uh/fxsUD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57d8ff3944dso4939163e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759299277; x=1759904077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+pLrX0Q4NwZE9lEirGuVWH9jUzrol+ZXQHzqv0t/Tw=;
        b=uh/fxsUDUmuawGTGXKM3Osh5B3xk0Z/svX9F8nBDYyBWVx3CSsGuXqrCd1TYba+cnK
         qU+lz32fzQaXpaBwU/8ZoEgPCAnW9b6xLDVi7t1X52BEKgyge8Ai2m/4WHHNlKendJ96
         cTFM3O+RiFp+xa28EIvyrn5EoN76sdZzUjTuzY86aeNAKJCY3K8vAE4uDC6CyWUBH0gE
         azrZmUZxlSkeu0kbBOTdClim7pbPOVfuBBWztGIakLvFuGmGfDr7VgOF3aQzPPLkp38P
         rPPm6/z5u3rSPCjEN3YXWIsUbEA1aKYnrlep5+gn1CGrJcVM47s0MSc/JQCIZd1tcnkE
         l6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299277; x=1759904077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+pLrX0Q4NwZE9lEirGuVWH9jUzrol+ZXQHzqv0t/Tw=;
        b=OXxsJLp0wdZw/6uywbZruHGiRf1cFf6w8H7Q5AMc3HFw2DRTgpm5SAdEIba2zx2X3r
         K4a3t0BYsmmtErmAYW1epb4JE+98uFu3ozGSRVBIby+wGk5dPz7zusbUTUKlshapNuPR
         Y3cD4VEgOsi/uEGKCMA0MtWbOHGgG7JIOUGK0TsX6deWWtU0zbrw6U/0zxfqnEQoOIOZ
         I0Un0zxOlAnwlEORdWTnOI+HtnFC9h2Gds13cNmqwrBpQkRpmZiAfEnz3Vs4xgaY19Ya
         Tyg9gFfBduJnZ5YjG0AatwqbGKFq9vrlxERp0dFJkQvx0Xz0FI2o+GvJ95C/yJm+UnzE
         ITwg==
X-Forwarded-Encrypted: i=1; AJvYcCXa5lK4rsERSygOuH+ZQJTtiS3qpSK7PzUKcFKL+zdprcVehVf7DheHGPLuFXJET4Y2KhmXs3J4U2pVDnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNsQaGwuLJI0Ur9XmgIcWgVPu9gcOhzeCIkeWjiCYaB6BoY7cv
	hC9IuOIOBJrCN1Hecu6Jl9DRcbvgDmiLScPfhz5+83vEArjHJ29o4u/fKuV1FnvYYFeWHkHzOXt
	SGQnepFm2QUHgI7LSrB8zcbKGB/EUiN67Gn66A/HtDA==
X-Gm-Gg: ASbGncubZHouKVb7zb+BPd/VI3n+LKPRxeY2g87nOb5Fyo1LHu+IDtXpeTDa6ka8wpl
	QmZT9Lf1r6H3FgGucNAh0XT5Lw6n47FzVwe9Rw/D4Jykk3NOd7crO6a71RDRiUue4H4y5dbfI81
	HkgNOmn+fLY/wRiHCTrK0WZ2r69U+gXgPehGNZzrbhsnDyyioR8glPvrpY2+fgPX647Ziuu+/sb
	mf6xeOWuJ+7DR00O42ql8yxySSWZZU=
X-Google-Smtp-Source: AGHT+IG2GQMXvM5wXsx6CzkWWALkmKJo7n9m32peMSwizZiLBt3hdl4uunMSSjoXjLkgjaoaZY2YYv9fSHpGi6xLHvU=
X-Received: by 2002:a05:6512:12c9:b0:58a:f88b:25a1 with SMTP id
 2adb3069b0e04-58af9ed287cmr658282e87.5.1759299277410; Tue, 30 Sep 2025
 23:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710-arm32-clk-round-rate-v1-0-a9146b77aca9@redhat.com> <20250710-arm32-clk-round-rate-v1-3-a9146b77aca9@redhat.com>
In-Reply-To: <20250710-arm32-clk-round-rate-v1-3-a9146b77aca9@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 08:14:26 +0200
X-Gm-Features: AS18NWCsR4raMo4wbunxRFTWZtDHnEXvF9gNLQU5m7trixs7xTJv_rQ_r124Pjg
Message-ID: <CACRpkdar_4UR-HtBb88dKLWbaM-p_vx_Z7RBEg5szPTMbdLN4Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: versatile: clock: convert from round_rate() to determine_rate()
To: Brian Masney <bmasney@redhat.com>
Cc: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:42=E2=80=AFAM Brian Masney <bmasney@redhat.com> w=
rote:

> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
>
> Signed-off-by: Brian Masney <bmasney@redhat.com>

I signed off the patch and sent it separately to the SoC tree.

Yours,
Linus Walleij

