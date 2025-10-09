Return-Path: <linux-kernel+bounces-846855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 833A1BC93D6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30EEE4FAA8E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FEC2E718B;
	Thu,  9 Oct 2025 13:18:28 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E36146A66
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015908; cv=none; b=InA8AOfWDiKMfL1qZ+uF0xyeC6fK8v/yv70QzKlMdddots654UdXqQhqcuJe7ZjNxeJjomPXAFZyxhtQaltOENtLOnANrhJNMlz4AKwtgEis+DS7MRYIb4qpzZ7iHLo/lZHcxm09ELGI56gRg9XeXm5V1lOf7Ij/knUoKzN7lTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015908; c=relaxed/simple;
	bh=1CeK1ONk4l3PgT2t43KHT03ww7YEEaFbS2gXJDuFeUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lv2hUqALFi1rmrUaznWampJE/UvM1r008A5lVdc0m7NvVd56K3grHPhygFGL2tvnvZaloISMRTNjPPXcICjCCNvw0et1J1rmWv3t97s1f2Wh/H4yJg1mamZ8DeisGXfj5LKdYTTgelN16tztH/JE5pe71nGMTM+lay51rh5u7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-58de3ab1831so914241137.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760015903; x=1760620703;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jgvNWQNEUEnsMKiNO7Z+h7b3CLJoE8XkViqUQ7M5aKo=;
        b=bDiVhoXRQKC7AG/XZJVWHMRQjaRald1MRzn+rQqmrovnO9vylvNGd/jK3abb3Hs5pX
         //mXE53k00uwdryCfBAWJ9aBOjf3uVd1hwLnbJ0d58UyUfthATfwRyfIOZO1vrK5AQ3r
         wqpkze1Bhs2NlguJrAS5XVCOPxWt+3Ys8/ZtQT79bXq/ip2u33atUOwDf6udk/VxtKoS
         vWfBeluWm36ODb2WqtrGL3zpddg4IVkfjuW5PNycqb+o9cMJ0mFqynfXBa0AuNYrUb6D
         D59O/LmKyy+ZwrWuxI5dcG+xXbtrgVwK5insFobHIxOClWV9V5BcJTA1A4YugSMkJuK+
         XubQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRH6c0J3OAYxIvv4isMzVE36q6b92ddt7G/MkE88AFf46DRp3UmUH4NzaJte9NdzFIvYluJEh2H9X9n7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnARCUGSeaYRqaUZaoy/s7ALWOaRq2qI2RfKGx71XGDtrRqGbn
	PQJLNmY/USy2dAYB0Ix/+7SgtF+skd/yt31vdTM2d/5V8GwAGxWE0EJKkP3jjj2b
X-Gm-Gg: ASbGnctIYdIEW7qVt3NVTQ98gFDkv1S0Ug3OnIPm9/z5K3YdVPT9xjktvxNWmrwUrg5
	DevHNWZQ/cu311A5uZoYopXIfuDV6xkmoDM2sSRgOVuVYPDBVeP2lKHrgPNi4qNX6H2lf3qCThH
	+2awvPhL/090QRDvlnq9jH6Uiy9EHEI47VQpU7WsRRYppRsiZohmkEVW227NjAVclscjxrfoeRM
	zdPIdZqKbuA3AJhpEbhnhS9QLCkyciTI5jWIGnRrHHKyPIR9imPQSwA8gCR9e8M5/RMdGxtysEx
	2UsBx4FmQADF5zP3LYkDDQba9EXNbdPhzYl3mXGLOVqkKnvwZOjzTghMLNY4NaA9JYzw9NP9k1s
	9waaMmKwUuN9e35ISCXxmPeqjOQ9OGPLOZPWvCNtDIlhLjXWvmKVv+J0PGIGai6zJ5k8sEW+eg5
	rVf0Os7ug48OjWiXSaS3YemU1ESj/5Bw==
X-Google-Smtp-Source: AGHT+IHo6Fr33VNE1khuAdT0P+tN86Ed2Z+M4VX7fR4dvrqNu0knSGEcdJ3dezA6lq8MMw9v/LaYyQ==
X-Received: by 2002:a05:6102:4411:b0:59c:93df:4fe with SMTP id ada2fe7eead31-5d5e225ed46mr3178865137.9.1760015903116;
        Thu, 09 Oct 2025 06:18:23 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d39ad6bdsm2430663137.10.2025.10.09.06.18.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:18:21 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5a265e0ec25so763148137.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:18:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+ZQgRj7O6ctvo4Zyz58MC33MpGfc1/5KaraCt/FzNQrmkBWsc3lEWmPVLTsGbZyIO/g1UNSqik7fbbt0=@vger.kernel.org
X-Received: by 2002:a05:6102:32c2:b0:5a3:5b69:b963 with SMTP id
 ada2fe7eead31-5d5e2212895mr3581618137.7.1760015900637; Thu, 09 Oct 2025
 06:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251007121508.1595889-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251007121508.1595889-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Oct 2025 15:18:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUo3qQwOBbrTuJMyfcvXfVX4ydTg=m+Evw-2rhD6z_kWQ@mail.gmail.com>
X-Gm-Features: AS18NWAFR_tuOqkjGc0mazaTQNfKABk5-3eOVxgykm60ReYpXtwRlPobaHKvywo
Message-ID: <CAMuHMdUo3qQwOBbrTuJMyfcvXfVX4ydTg=m+Evw-2rhD6z_kWQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: renesas: r9a09g087: Add Cortex-A55 PMU node
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 14:15, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable the performance monitor unit for the Cortex-A55 cores on the
> RZ/N2H (R9A09G087) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

