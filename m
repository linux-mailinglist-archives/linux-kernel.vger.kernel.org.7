Return-Path: <linux-kernel+bounces-893223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B40C46D56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AAE64EB204
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13550310627;
	Mon, 10 Nov 2025 13:18:48 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF55530F800
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780727; cv=none; b=mSEDvoBf8lxlMb5GelgOz5O5vB5khLesHFqUn/6oEag1wlcSu3kyJrte7P0/i2vSo9HsDehomYJ38mMbMOesqVgMAsOtJzd8gFTaKGGNcjRMXSq2lMHHe6fG2A8MdD5B1UwEEGUuO8rMuG9RWNGpPYf8VwPyZADL/SS72f9SWRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780727; c=relaxed/simple;
	bh=KadK8l0y+2kGqkttEVnDkIhHYVAwWa1JA/uwvYjgOO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eMU2bZFG7dWgZnIZrpVB5TdcJMYkKZLSNsJFtwu0JSUaQE5LbCt6rKKLNiFzAI4EGNbuTgS0CPxbhpWOugPC//zhT2VHwlx6gOjAqcEJgWU4/DoFV2wm+t9gQWsY7S8pjeQFRRxWhofX0seEZWki111GuDT64k8drzxzcmV0v3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5599688d06dso669225e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780724; x=1763385524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JtWC2opMXjpjODI3FtXSyNgnLs1SnEjuR36TMHiZyU=;
        b=jqUNoxxjHXJ/soSBbuD0giiF0vWzEZZxtm0QFHuEFP5EbFOrieXe5d0GE9WL8Ktmxp
         swpmjSgBK5H70LFQRfgYBtMkLw9hpeXbrmDG1+2ZXjoWgbePTeHRr16l03WbXz8lu+v0
         GNcNLHbsxsU5OGPiarNn6PY4mU+inKz631/1qysW5e/iVW2rzyTb9AtC3n/qwIkafeUu
         7X93CcbY1LUN401aJf27ucpKjHaGtsXF2h+9gQ3SX/33ClF/LmdK8Vsw2V4slRv8zTPN
         DRDIn0F8kHilVoZLNz9UbPFr/Hx/qqHP61IwIuOmR5J4z3F4i/ufwdItZJaMtBJi2SRR
         dlpg==
X-Forwarded-Encrypted: i=1; AJvYcCXuNyeJRGl7U8KIHzL3Q28CmhcrTuEs0uRkUx4lQGPuenp5C1DuJdmy+c0EU1Yj7qwH7dnI1n5auDBLFeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8gd89dNbIxV5dAmpcqQKJtQkw30S1Uh03Ng4i1kAUyvBjOJ5
	7ir9LFXRAtTq7vpwh2ojo4d4J1YJPGMfxL9aN8uia3jFVc3gNriq7+a/EZMMZhNi
X-Gm-Gg: ASbGncvmVXa4J61ctVpOqMwifhXIW8B9tl6RcXSDIgJP7zK8AA4quGU2dZ5S88Gi8VM
	IeUSxIMXnZlVuzNKQcCSKCTH6uvfV+2f+NACo3HbZjtQw9A1e7oXIAfm6pEMTwWbxySZuj0DdZ6
	jHLp4PmMQDd+YmbIB+X943tU9fcI14Pgvk9DbXnEFBkQ+RYd4h6gbQMKpFBQpdswU2U4ilicADu
	w/tOl1rqk524bmLgq7OuWu5801d6c6OmOtAs6UuTBzYjtoM6Q+Ytmdg9v0D0B6imUKrbdEr+7F5
	temxeZp2XLa1HhmP38igRKy6c2mui2yC9JnjlKDWb7pTC7+SYaGtVHt6mWrCyFk/+L1jHqMIxpd
	U4xfBtlaOwMXWqUN6YckbwNBJUDTn4zjToZNGPBQHOVdl5vDJ0hafLmvFRYyiC2+qOYrHkTZBhD
	PKLYql4Re1uX+RioOxaRNoZjv0D9r+FK1PdTBTnw==
X-Google-Smtp-Source: AGHT+IGhDaGjaf9SpSRFhMtYuq+Yh/9SNXdmmxQ5FiMvYCTBTB3B51oht5I22IpYnQvyyEcFD7a5qg==
X-Received: by 2002:a05:6122:3713:b0:559:6663:8b1a with SMTP id 71dfb90a1353d-559b3230249mr2612832e0c.4.1762780724439;
        Mon, 10 Nov 2025 05:18:44 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55995829be0sm7127320e0c.19.2025.11.10.05.18.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 05:18:43 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5dbe6be1ac5so1299143137.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:18:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXnghZ3yelji+svMWgGNEI+aK8zJWpz75RYx/ho3/MkzIlpWCmVMkss1Iu2pCP6DKq3XNP/wunxvE5rl0=@vger.kernel.org
X-Received: by 2002:a05:6102:3a0a:b0:5d7:de08:dcd6 with SMTP id
 ada2fe7eead31-5ddc467ebf4mr2259170137.2.1762780723317; Mon, 10 Nov 2025
 05:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251028165127.991351-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251028165127.991351-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 14:18:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUAqP7zdeGfvR_WaLDhvnDCR3WqNy_+qkh66=X7D7NTaA@mail.gmail.com>
X-Gm-Features: AWmQ_bnxVvrR1Phxc4_ghxbxu9QxxlwIdRwsEpstOMyyybXbOekzQi-mkOZ-Pbk
Message-ID: <CAMuHMdUAqP7zdeGfvR_WaLDhvnDCR3WqNy_+qkh66=X7D7NTaA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] clk: renesas: r9a09g077: Remove stray blank line
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
> Remove an unnecessary blank line at the end of
> r9a09g077_cpg_div_clk_register() to tidy up the code.
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

