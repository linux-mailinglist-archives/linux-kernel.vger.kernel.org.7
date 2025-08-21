Return-Path: <linux-kernel+bounces-780658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED97B307AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F801D066BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B883C35AACA;
	Thu, 21 Aug 2025 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YEatoojs"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5053128C4;
	Thu, 21 Aug 2025 20:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808985; cv=none; b=V7eIMs8L+cs+yz8jmXWr13lRN1zHcCf9Rci7MRPeTB/QshjJyAGwFf7uP+qKiVuC0hCg0Yv1TaXTtmWs72rwruBU0amZj2r55SPxrjSOljYUrgKZ0zdH7gEJ7XCbpPUuukmZCsUqPJjZENgScOUvYf087cGUUOwXWgRGH9Nj63s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808985; c=relaxed/simple;
	bh=Y1I8jahgciXUO2vX0njJM1NW5jilQkAEyjxTM0zI+ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaBnC4RD2i91Q9E5xY2X6VaTj7LfBAcSw9ZhAxLaA0+fTeCvg0GG2w9SuPBTC08qCRMfCNh85ZnXeZB6JzIsZa8whyTXOKgKkll2MhjyS7IqgfqUn9+NB+xkrcTYfqhb0R1gAmVnWapCuhNYtMlQjyO9zvgvE8KA77ESWh6GYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YEatoojs; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-245f3784edcso13858945ad.1;
        Thu, 21 Aug 2025 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1755808983; x=1756413783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HMnbUJjOig9s+/+Eizv6zpmYG/IGENV4CSNveOOfxM=;
        b=YEatoojs2TGtlLmf8emm1chahTE9Vv7lpUIrw33HAV+mme8h+MN1uJJrh2UUFzKHGa
         aLfV6NccaxynX4Pj6KJFLj/sNXtZfIkFNgjaA+koL5ZHisx/Dvh2SyYP6rcPWixibNbN
         XKequdhg6xzy16MjmUuh2qzaaN8heR2RkQ0w/aSH0OJxXzm270Y9Nskjxq8ndFqZA1AZ
         0AHmBw4eomOTlbJ5WZS2OgTJ/O/KrTqLwtXlTCSnR+gBBrg4L/bJcf2pPljg+Imvay6t
         gsGHDFmG2ScEMcYXZ2wf3anHBwqqFjibCQToTvzOsWI8vT0Ydv4G0R3KDkySw8Hw7bTc
         rlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808983; x=1756413783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HMnbUJjOig9s+/+Eizv6zpmYG/IGENV4CSNveOOfxM=;
        b=edfSQdKZEUZeR1s8BVM/VIwM5tUIgRcIQtNUse0qAmH6NsK101wTGjMCkDGjcCCC6S
         yD9GYhxCjppmP4ruv1QRTOVE9pcXzuBGwoogM31cY/+UZu+ViWRpWdaJ78ljJwAgSjk+
         Azt0m3286bj0LMI9Lt22FVJfnuZjYJGiqWzGT7dBIuxFqW0SAUY5R6C3yOoy28E+OCh3
         fmsvau03s9Fwf+RG0YfvJ40HzYHxBdynPNQtg70OETGXCpmkdu9h7EqApqHIJ7+OtzeI
         c9SAfffunX87ik1nfNdyEO9Q7g6+4mARLimwBc7H5hMJlXD03lXcerwr3aLw5TpxseI8
         7aUw==
X-Forwarded-Encrypted: i=1; AJvYcCUOhrEsLKnM41aLCrYFqUZvyk1pGeVZmNSB/J75g/Q42aamgVB2PWcJgRoqH3JpPJoPSv7qIFPyyX9W62w0@vger.kernel.org, AJvYcCWTMXTg+Bgx9qXTJJG6lEYtR3xdf7Qea5fdOQy/PhsXSWj4o9+iGMOUMhEn0iYSDIHB1mciG+v+DG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrrE8s4QrKbLBE+YhehM8esojwCpzqw3Q7hV7KZjKM0za8Hzye
	aign1nDQKKOb0PVE0pRne00m10mzcmKqZHl5QS+9ndePuu+XV6RS7LuHrfQ74d3HiVuiibzwwrv
	qKTawaNVmYMg8XkKQckYgx88uFxRj2bg=
X-Gm-Gg: ASbGncvXF2EKLhDW+ak0ZeXE0Qwi/hrbXw+stZ1UCIRtouXbpWBAj4PaTGBnhyUpHaE
	MMxG5NMgn/OlW2KFh2JO2qZNhi/w6Yw7ANz5aKAvZdTqv6vUHKrYIirQUxOdwSP7YxESNnFaY1g
	IexyXGCtZ44uLTbRJZ9ePsX1+xOJZElXY/tb4izxkkVw2f1Y4C0kVRKg9B573IyvfofF7XSaMri
	N7wpK+I4q6OX8IzPe+hybO2wE9gV+qJzqD0Mh4K
X-Google-Smtp-Source: AGHT+IGuprKMUQEODaMep9Ho8yPNqOKRMqZI02yinYtRQ7Fki1XZs3M4IXAeEY52gzg1zE/0hwBQh7l6+wPOYT0Ocrc=
X-Received: by 2002:a17:902:e888:b0:246:570:2d99 with SMTP id
 d9443c01a7336-2462efc9965mr8562475ad.58.1755808982872; Thu, 21 Aug 2025
 13:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814200953.1969944-1-da@libre.computer>
In-Reply-To: <20250814200953.1969944-1-da@libre.computer>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 21 Aug 2025 22:42:51 +0200
X-Gm-Features: Ac12FXweMQUvhGMxkUIwx9HmkMNbiRniVi18J_hwc2Z1Wue7xjXq3oeWyHupql0
Message-ID: <CAFBinCA2XZfiY2ESDSp2WyM9r-XB_LSj9s91woU9iWoQKrp6QA@mail.gmail.com>
Subject: Re: [PATCH] clk: meson-g12a: fix bit range for fixed sys and hifi pll
To: Da Xue <da@libre.computer>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 10:09=E2=80=AFPM Da Xue <da@libre.computer> wrote:
>
> The bit range 17:0 does not match the datasheet for A311D / S905D3.
> Change the bit range to 19:0 for FIX and HIFI PLLs to match datasheet.
I have:
-  S905X3_Public_Datasheet_Hardkernel.pdf
-  S922X_Datasheet_Wesion.pdf
-  A311D_Datasheet_01_Wesion.pdf
These state (for all three PLLs) that .frac is [18:0] (that's shift =3D
0 and width =3D 19).
I get where you're coming from with 19:0 - in the context of this
patch this can be misleading as it would mean that the fractional
divider is 20 bits wide.

> There's no frac for sys pll so add that as well.
I first read this as sys pll does not have a fractional divider.
What do you think about: "The frac field for sys pll is missing so add
that as well"

I guess at this point this should include:
Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Signed-off-by: Da Xue <da@libre.computer>

[...]
Have you compared /sys/kernel/debug/meson-clk-msr/measure_summary and
/sys/kernel/debug/clk/clk_summary before/after this patch?
I'll test this during the weekend and then give my Tested/Reviewed by


Best regards,
Martin

