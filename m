Return-Path: <linux-kernel+bounces-780770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CCAB30925
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3867C4E6BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0372EA478;
	Thu, 21 Aug 2025 22:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b="HeSqW70C"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684472EB5DA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814927; cv=none; b=p1oQDU1cH4gPYNIHQApzfclG/vqEiARwYsQIjnAXP/hymJxV2KGxc7KVTEPKBcI94giLTLRrhFkfLWKTsJj1Lwv2uNq4egICi/D1pCNlMDTeR5hFcJizpBc4NyyW8eARajuRseSmgkz3g7bwzxFLXPDravDygCHZugV/yDII+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814927; c=relaxed/simple;
	bh=wfvrOUarsnAgVOaXTV03r1PbaKh+yXIIvvT8ysYqXk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p172kNhiPaC4yDwurYZcUNzKKu744F6P5z2tLPrY/45MzKWkiLHcYH115m5OYSE6bc6j/poH43PqnUZGQXLrNkEAvv+MqmxHxTRdNHTBMv6gFq0P1V+M5pJTWt7nll1vawfYACCBzNLtGs3lEMqjlOuDsAiH9Q1K0m+V7B1dYWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer; spf=none smtp.mailfrom=libretech.co; dkim=pass (2048-bit key) header.d=libre.computer header.i=@libre.computer header.b=HeSqW70C; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libre.computer
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=libretech.co
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d601859f5so13460727b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=libre.computer; s=google; t=1755814924; x=1756419724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBj8SHJfZNGuq71dQKyp+ING7ZoPtD6w+DOcmGVXVSg=;
        b=HeSqW70CJbGyo42KQLImVE1GO5VaB+4y5Nf+hi2EjObKOBIHBbckeP6QHGgsPh9SNX
         EjEggCtoiSac76HP+sPHbAXZ7zxA06XV1lVwqQ2FDkQPcCQFq5FiVjQdSqHHFbZSQ9Tf
         GvLoaBCwyjPjXRbglhq62YK5lgOjRqJQKxI6iXFPXoSam9U3H1vn9V2w451RGyWNxv1X
         P8dPhayyce3ObgvQ1kP0VlAgBdwC0PAVIsyWmxwnWQIZOJ4lkB3j6vdJG0RNO/gyYYmQ
         722xr8iTej/7N4U+k5IAAeRs1NXR6kTvlrR1VxJXK+RkGYm1Y4cY8HfKXy8HOl+MJfr+
         mZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755814924; x=1756419724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBj8SHJfZNGuq71dQKyp+ING7ZoPtD6w+DOcmGVXVSg=;
        b=cZYTC8fsPGYFLDNDLk377gq8g7+b+aEihNfX8JGL+/JzeXrZDZfwcIiPItPn1yPEFD
         CLS8ssDU+Hl18APp2wMaAwC2KEdYImIHTWt2t1gXqWklWVTi9k+hQKTf4AguVyzDlLq4
         KgbYbC1sBLDk+TndvBeviNQR9aYyjzx2py+yWPPd3aCZXiJvz5UVK+8z/TI6xXgCHbJG
         XRUN2zMdrnPNDE7DiI1VYvvmLWhTpMB8NNUKtCXuguvLmildQC2Z8LUixLPtZ8twqFr2
         oVl9SwTP5my+klEFHJYOfBEXD9BO8pm80Z12ZzDP0rbwA+a06IwwEOtrhLd7MphR8jek
         qBQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCe33uXuBfNL32TKLATopxnNohcIk8XFVemN/qJay5HzXk69jvZx7r+rZcRo1TvOjaVnRb6ocFze6bp88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyIIYb3viIdTZ8io/uETVRZIYa5Giy6tHLB/QFhdGKc1K8ZOR
	u+8cpS+sYoxhDhXfd18VzBWidPdnYJxMHumMQsg2J5Lnms237xOixORGw+YsI383U/hXJZ+QYmY
	rVeHjLnufVVnKEyWfLXuzDAcqC0eZ0MEjqtkVPEcw
X-Gm-Gg: ASbGncuhitOLo9ikfZXmmdF2Qg038E+VqkxNT61FBMXgMPI6zEzGe9PCAiKlMZTBLEM
	MnwLdYvr5a/7zP8ZWHPqqemhDsCLkqWqtKj+mK77I6t5tbejLz/VDjcFALBkbdaoVV1JeytKmGs
	Jmr+B6daT5EfhxFFfv661QZAplfY1eg/k1zoDG0EyitvyqISn1xE1Y2pw6dU5AHaIIhFUhmV33r
	qTqJFWCUwzoSI6V3LS8hdDm4041jFxLT6TOxHOOOPLSCNTVtmsW+o6pr8kxYg==
X-Google-Smtp-Source: AGHT+IGsRvIzVdiLiubOw6s26FCV+8GUBa/zvOZHQKwnuxp9m8DDW2C1NVHDopq1Qw9f3dHJcaZcP9J53I+yjNcPN2E=
X-Received: by 2002:a05:690c:9a01:b0:71f:96b4:9adc with SMTP id
 00721157ae682-71fdc327bd2mr9169047b3.18.1755814924223; Thu, 21 Aug 2025
 15:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814200953.1969944-1-da@libre.computer> <CAFBinCA2XZfiY2ESDSp2WyM9r-XB_LSj9s91woU9iWoQKrp6QA@mail.gmail.com>
In-Reply-To: <CAFBinCA2XZfiY2ESDSp2WyM9r-XB_LSj9s91woU9iWoQKrp6QA@mail.gmail.com>
From: Da Xue <da@libre.computer>
Date: Thu, 21 Aug 2025 18:21:53 -0400
X-Gm-Features: Ac12FXxi99gixxdRQMIukXDBwJ56n_o8uuNClN7qs096fAcZ04uxsTATA3IRRuY
Message-ID: <CACqvRUaZaoh7vV7Qo_dtnxC-NE227rY7EQe=dx2a_nCcfiZB2Q@mail.gmail.com>
Subject: Re: [PATCH] clk: meson-g12a: fix bit range for fixed sys and hifi pll
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Da Xue <da@libre.computer>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jerome Brunet <jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 4:43=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Thu, Aug 14, 2025 at 10:09=E2=80=AFPM Da Xue <da@libre.computer> wrote=
:
> >
> > The bit range 17:0 does not match the datasheet for A311D / S905D3.
> > Change the bit range to 19:0 for FIX and HIFI PLLs to match datasheet.
> I have:
> -  S905X3_Public_Datasheet_Hardkernel.pdf
> -  S922X_Datasheet_Wesion.pdf
> -  A311D_Datasheet_01_Wesion.pdf
> These state (for all three PLLs) that .frac is [18:0] (that's shift =3D
> 0 and width =3D 19).
> I get where you're coming from with 19:0 - in the context of this
> patch this can be misleading as it would mean that the fractional
> divider is 20 bits wide.

Yes, I was in a rush and missed this. The description is bad and I'll
spin a v2 with the Fixes as well as report the clock differences.

>
> > There's no frac for sys pll so add that as well.
> I first read this as sys pll does not have a fractional divider.
> What do you think about: "The frac field for sys pll is missing so add
> that as well"

Will correct in V2.

>
> I guess at this point this should include:
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> > Signed-off-by: Da Xue <da@libre.computer>

Ack
>
> [...]
> Have you compared /sys/kernel/debug/meson-clk-msr/measure_summary and
> /sys/kernel/debug/clk/clk_summary before/after this patch?
> I'll test this during the weekend and then give my Tested/Reviewed by

Will provide in V2.

>
>
> Best regards,
> Martin

