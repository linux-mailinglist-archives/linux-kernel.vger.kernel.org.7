Return-Path: <linux-kernel+bounces-893234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5E5C46DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7BB1887C53
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C6C2EBB9C;
	Mon, 10 Nov 2025 13:24:44 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99871303A39
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762781084; cv=none; b=EB3Pch+leST3UnynmR8YDVmm3f+7JteiQVl6brZILSiEv+CZ+mDWdRr0O7/IwRNjv1EFWZOvlxpM4xWryyolV90DwWo+ZY+R014NUI07ssbY7nycJO/nTvThUD+MozfxAFycvS6RbztdsgRIDg3rPwOlFsRZUkQG5rX+mqgI4yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762781084; c=relaxed/simple;
	bh=wA9BCmDruypxe3smorD0vULZ7Tgi2Cly7mnUgeAvySY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnkXvg/+vag9DkVhfpI6cZ2KMUYEKeanAd4uGwGNeoOKX+8wQcl7vMZok5pmo0TEMQx+gOk3WV8JAmqFSMc26hMU51jfpuUhBhRtSS3W01lPfFg8O6OWWvicAPbl0v8Vi8VCWtlCisWmo2u7Q8tfWZ0kjLqVVNDGj1f/BJlNYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b272a4ca78so171859785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762781081; x=1763385881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7x+CI2dPjKNXpWEkjlBqw4SucojwVb7aPiVE+kUAJGs=;
        b=AOXdkUmk/Jl0FdKPqRQDDRwPT4xx3jnLc78YOZu/cpN6qQNWmTHxyoJMd8e6ENOrGS
         cFffAYWT4mF2IVph0YOScOo3i+MbfcXI1irdpX37ae4t/3uk9UG5/74AyVcr4sztieq7
         +01NwnbFXbQI/8n5HmldUOrZ/PqUJFkrtDUGEzIknN378kEqiiQiG/YJTB4cVC+8cfCs
         XReVMeW30tFaSSFh/DKS5M6TIur1W07m4I1Jkz2IbxCAW4HwZe8/EEBtjMB9Z8F3/Brp
         ORd2TxfMdsRk60W8FXYA3j+/BFI8+parMWEP8vqQwOD8jTzjkJeZF5M2zlS2Kp0Kve7L
         9Vaw==
X-Forwarded-Encrypted: i=1; AJvYcCVyyJ4LMkSXIW6CrvAQLOlHoGT2qWjtbLUjRdR8dwS72iVOgPS3bOAN/2GA/JgC6GCc2Yw55bM8yqxj9C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBR4ja9IsXftpHea1TTJFKXCGMosgUh8nIZFpzQUiceogDN+35
	QLxB7JJcJAI8D5SekAIOcTjh8IpWnAsdTyUTv7Pvsb0lY/70/r2BqMwQo/wJJ7LU
X-Gm-Gg: ASbGncvsChQfGfEv4hM2up2LUbhN8adw1NFtSy/LIXUi0vpFxLZl6pLZ8VWQdJmn3bu
	NSCCT6tBvhDD975q6llnJ/WskaA71NYEOLR0yqVM81PL6F3bh8JO5LmI7sndw3W8Sgr9yKfiYgg
	bdIiYkW+1Pg5hQY3wR3cuvYWwP7GRS0YS1AU3o2lTEHD+uH5wkt4zDfwDxQ8mPOplgtQVHiAtkc
	OS0+5L5or8arhxAL1C7s+goxduAbod75FDnub5O+Y2TgXxSOjvUrpBNX5j1++1do8w9tWbKIY7d
	nGtxyxNeDpUC85vKsVij9FMB+g421S9MyDpfxcQsNbOSFpNqDJHPcPmkYQ/53nmCqgWPngggsVX
	+/5VgFqExyAnYWqgruKMk6pX3zoQsavrmowfWqDijz771rvdz/ajPwD03bf+hiddWOfpkN30FGd
	Ih2/OLUXHmETM75/3UEJRBQGtQ+alptDNXrAWioPxBbLlcFRfI
X-Google-Smtp-Source: AGHT+IFT8jsoYkEGs5diQ6Bwy3IXEJBQDYQ6wFoXY3ankyP34vbQ9zIkJsGw4TXPRuRPzokuxwQeKQ==
X-Received: by 2002:a05:620a:2546:b0:88f:561:d956 with SMTP id af79cd13be357-8b257ee0970mr873783385a.13.1762781081313;
        Mon, 10 Nov 2025 05:24:41 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2358278c3sm1021149785a.52.2025.11.10.05.24.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:24:41 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8824ce98111so13234656d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:24:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXwncusGzc/XO9wBWLjA/mRH+wWmLCa6k6d6wnLA8DvrgNgbsx3S87Nn1MPQIumsILnWfP3oCWlAsrAJb0=@vger.kernel.org
X-Received: by 2002:a05:6102:549e:b0:5d5:f544:a88e with SMTP id
 ada2fe7eead31-5ddc4814e83mr2563556137.35.1762780760163; Mon, 10 Nov 2025
 05:19:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251028165127.991351-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251028165127.991351-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 14:19:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUoGQVhdy-h6B_6_z3-h03GnNz4AhpS5i0WJf_oAPNktA@mail.gmail.com>
X-Gm-Features: AWmQ_bmIROBItvdVM9xE3_P83zJy9BKTyQeGOqvTNjEHYV_SlB5kh2Ov6vUy8Lg
Message-ID: <CAMuHMdUoGQVhdy-h6B_6_z3-h03GnNz4AhpS5i0WJf_oAPNktA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] clk: renesas: r9a09g077: Use devm_ helpers for
 divider clock registration
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Oct 2025 at 17:52, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Convert the divider clock registration in the R9A09G077 CPG driver to use
> device-managed (devm_) helper functions.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

