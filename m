Return-Path: <linux-kernel+bounces-846854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25888BC93CC
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4372C3C6B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA2A2E2286;
	Thu,  9 Oct 2025 13:18:10 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860125FA2C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015890; cv=none; b=SxR85hncOcl4RQ7L5Qt720chGrwz+HaWs3rG3q2p9wWm4f3bocWPaoCvakuOBTaD0E5ja9UoQzf/7FC3Lh4dXoKqptHAhmcEckKy2S33XarjujvVy3/SrEAuVyZTj7YfpNQBBNdOclBTwvWYlePaHhr48G+8IqNxRJltAHiSudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015890; c=relaxed/simple;
	bh=INP3l40ADCP2qA0fbJj/+4957OkttXt9E+1u5k+nI6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMQTxylE1ZIS3nVdgUzYmPzHFfkVRt2A73miu+ZpeCSL+TwhOJq8vjp1uTyWg43FpRYrR7K1OjQKlU0AUwGfSE09kS1q4U6qJwhR3bG6bHmfTVY8dORp+F7u/XakZft71h/bWTGq852Esd1gaHBxq/UaTx45vUOzbbPIYecZYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-923f46f6c59so1295630241.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760015886; x=1760620686;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=si5sH6w3BFJWD5m5kkucO94XpdquBxJbgVQpUyKDB4U=;
        b=YppYy38FEaUIu/t8PsE4AkOdlgbeWX3STFLeqKP/xYPg3Y+e7JbXNIZL0U9lHRDlIv
         PvRAn4pWA48NoeM9lZykNiS9HrLaCyMo2E2l+lXzRmSp9y+HcUBProEnEoyh1Nx04wPg
         D/qpFGGqZPkgSyg+QXZqvEVcCcxDx0dPn0CSKO4/j6SdZGQBF1rgRttIXxA4hBFH43qf
         Z6uS966plclWO6SHJQKsi/qTseA9r/EE25Cd46WkqpChdyCD7aBme81JRxjzwGxMAxAo
         wLHK+TdYXlXv7+fyi+7BJ5lRHQrClpvEep0/st4fWt5x/YAstLgjLwEZhJmWIxAZhBl1
         5eNg==
X-Forwarded-Encrypted: i=1; AJvYcCUeQ3pJ41zlQlWKVFGBndBiHSfBrwYBMLG/gdQnqrbegEKPdUdl5w5R5Ox90WYCuuyEmBAUxnpiPwSDUPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSmGPJBunuNZtJC/xcV9YfXZdqMT2++27Cvh12UCR6v2CfMZHf
	jDyCFEdiKMntVr5l0HDPMxOEQmXaA/flUA71U8ArjFQQa/5alvjCrCKpp7c4O0sO
X-Gm-Gg: ASbGncsjlwHjWYMd55EEpfulHY6pQVmh4VnVWe3z3+g0Du63iBGLxnOz+GhWCITsi2z
	XwR9OYMeWhQoKyGRq2/p1qo4GJ9DejSso7VlVcJPOhs3hftVadkw7Vv4T+PwqV1h1REh8gk8/wL
	6I79xBlpOgNee9mcb5Mko5hEWc4G3bA1ZHPXSmTcX1dGcPyzzRQXJGTF707Mc2oCa5gCpGhx35r
	nacC1g8TjeGM+RXKqUbYyLzHGeGd7/WR3hXyaQuDBnxwcDnmKbWYRocVWD8P6QAmWzVxEACqWsu
	avd2bm/qrtXZn20Xa6nMXBzTbsvfr0BISnjQgqIPWe8GZ4cG/wQBM3jaxD5fijp59qw6h/9Hee3
	iBflx+QgFZaF28VX2f7M292PxpiVXFjgSHFTtYTGWIxsc8uGO7XtpE/5UiiFnAjfeOPQCiSR5g4
	7PisQvgHg2ZlbLQLKDsfw=
X-Google-Smtp-Source: AGHT+IHK1Ubjrv2xJLwSiLGKCdge2zl3PJwSznIgLrE235J2MIHSaeZhcoz6uDnLZEBIHDwFBcGr5Q==
X-Received: by 2002:a05:6102:4188:b0:5d5:f6ae:3911 with SMTP id ada2fe7eead31-5d5f6ae3e85mr693137137.19.1760015886282;
        Thu, 09 Oct 2025 06:18:06 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d39d180bsm2366746137.13.2025.10.09.06.18.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 06:18:02 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-8e3d93c0626so798536241.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:18:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQNQlYx0m+O/pu/8bMkCdBJfrjj0/LJaFymq6dNiBbaJSLugZ4lW28v45/huLWbfV3V7FdI5vkGZv440A=@vger.kernel.org
X-Received: by 2002:a05:6102:6211:20b0:5d4:1499:99a4 with SMTP id
 ada2fe7eead31-5d5d4dd9e42mr4653097137.13.1760015881596; Thu, 09 Oct 2025
 06:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007121508.1595889-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251007121508.1595889-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251007121508.1595889-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Oct 2025 15:17:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUrwNzSmqi1u_4PkN-JURxNa3X7fSXGzSBjLtA+wB_JKg@mail.gmail.com>
X-Gm-Features: AS18NWAki8Ee9WPqdnF2AgHvCLiMuvZq8C_MZHp2KGuv1ErmWlK28JGc1FB-3qw
Message-ID: <CAMuHMdUrwNzSmqi1u_4PkN-JURxNa3X7fSXGzSBjLtA+wB_JKg@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: renesas: r9a09g077: Add Cortex-A55 PMU node
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
> RZ/T2H (R9A09G077) SoC.
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

