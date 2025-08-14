Return-Path: <linux-kernel+bounces-769082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBBFB269B5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0547B38ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F24A1EF091;
	Thu, 14 Aug 2025 14:40:14 +0000 (UTC)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716B321449
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755182414; cv=none; b=saTVBVGsqWarWAeX1HC/F8trsn5JlD8mP4F7XoiwQ+G9y17jMKmKf2wi6IUitkasIZGa+lCisk/a/e+ckaGip49W8L86VOiOV3vojqH3DZ3+oH+LLImmABsQuBlvH8D3alSO7D+EVhquXvf3w5GPksEXfEgZK3P+ikpAqqEbh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755182414; c=relaxed/simple;
	bh=8hUnzCdq+4xIBM6fKmuHmArWK8OAelLvAG16A7gzsPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B6aZZkvuzJoWd1XR5R3F/1WDkxgekMoXv6k5GY3ZdCrWwt8i1tBcCT0N7gmmsA6YdbAiCCYKs203K1GT0j7VMij22hIKOdAkG8K3fuzOlo5lHaXgUSWvuXWzjnaH9ZaBbkmXBX1JLxJ/060nU3BPEcOTWQzy1Tgt8EDFhW6umMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-89021b256d1so124490241.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755182410; x=1755787210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaH5wVLQcCdHSa8C/Q8gM8ep2RHMYVswk335MNTKl4Q=;
        b=b3TvzpxyEd6SF3lj+2HFldmuy/hOWlamcaquONdM5eA9m1FECiY2HqG+I8JUIn0nVR
         LzWAVGy77hlUrvE4aUWh7qqdr2Tx/4SEcW2/OnckMOJpkFt1xkcSNmy6zIpBt2fsfvjd
         5VVfdNfoaQ5gcczTDLIJzjCyBYsRX3o5ztUl63KbI+y2Xt6gF69nj5qMFn/45YPr6AeU
         pxGTRXCsrG1IHoF0+eVYB/YaB9HCTi8iDcg+w+j0sd5m58/UxnyEaUJL5M42vE9AOQhI
         ZLnznGx66T6cy1vOfA2BMQYx98nIgRS+0wbDYXPSqAJ4Lq4MlwbK7ZzCIoVMwAPTyY2k
         zQ3A==
X-Forwarded-Encrypted: i=1; AJvYcCXfL85y80C6ARcm9YmoN+f4vMZkMKDykzPET6SRi7QqRdZK3Az5A07Uv0e/2/fMT/LQYUri+d+KbO+j2JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YysBDa3+o7YdcsR57D4ijy+UZo2YhseZglVBmAQg3cH8bDcl2dn
	Nxdfv9grs76uLyFyKTd0+hoKTdlpemsl+wR2GCWa61B/I/rRUAnvxaosx9qguE+k
X-Gm-Gg: ASbGncs/b/eycdlIvRWylXj1lH8O0VOliAcBPKVLeN0+jEN9cVDYfzgl47+E0/0CUyz
	9x+5aKQvd8TQZxO2ZmZMBq/3OG0pmyk4nPBU0au7rkGFZh5tC8ab7Yf4naiYK0jaTWJ5SUD8gWl
	Px+b+7K7CJfFQQgUMtSrHjYAqtvSCfSkdcgt8co8t1s26wu+PImjUTNadjKhP3qQKoO4ut0g+WV
	zP+BR3/GqNm46uO7WlBeiu5AijUEzJIubhWM7CupYpvEL9F5r5AJViDi8mC28XJpRr+jwIC5DLe
	n24XHtdLB30WXp5IRmpslJVQ0QmbwG6z2OjJtvtO7xXBTkCcQMcJvwLhQ+qrfbKCTKsriB4sqjk
	NGMEPO63VDD14qpscQ62vbvfDCJDaa9KnjYdZMz6CA3XawJyuu69nCEN5cwYt
X-Google-Smtp-Source: AGHT+IEzj0iN+Ez5jKjmGkUpkH3Zob1I2zYzencDcpjBlDrXsmyVPdi56n4C5erln5NqjskkQgrISQ==
X-Received: by 2002:a05:6102:510f:b0:4fd:3b3:d4b0 with SMTP id ada2fe7eead31-5100271cc8emr1259538137.20.1755182410462;
        Thu, 14 Aug 2025 07:40:10 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88e0271b434sm3305727241.10.2025.08.14.07.40.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:40:10 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-50f890e3df6so309349137.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:40:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXih5/LUSRSSYHmYCfiz8yjgam06skeep40f3/MQveGm69EqYdynl9t2hoSyd1LB+UIMYflJQakEanw2Gs=@vger.kernel.org
X-Received: by 2002:a67:e70a:0:b0:4fb:142:f4c0 with SMTP id
 ada2fe7eead31-50fec575832mr1384714137.0.1755182410088; Thu, 14 Aug 2025
 07:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
In-Reply-To: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Aug 2025 16:39:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJ3im+k9uQgRhUh52Z_tJ+KQjAGY_Y8FjbEu6gB=0UKw@mail.gmail.com>
X-Gm-Features: Ac12FXxCewyX2KO-GwUn49WCWjFooiUGy2LjA7azqcnSwW3bRWhwL2RPKQ2cGqU
Message-ID: <CAMuHMdWJ3im+k9uQgRhUh52Z_tJ+KQjAGY_Y8FjbEu6gB=0UKw@mail.gmail.com>
Subject: Re: [ISSUE + PATCH] Interrupts were enabled early by spinlock guard
To: Edgar Bonet <bonet@grenoble.cnrs.fr>
Cc: Thomas Gleixner <tglx@linutronix.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"

Hi Edgar,

CC loongson

On Thu, 14 Aug 2025 at 15:00, Edgar Bonet <bonet@grenoble.cnrs.fr> wrote:
> Subject: [PATCH] irqchip/atmel-aic5: Fix incorrect lock guard conversion
>
> Commit b00bee8afaca ("irqchip: Convert generic irqchip locking to guards")
> replaced calls to irq_gc_lock_irq{save,restore}() with
> guard(raw_spinlock_irq). However, in irq-atmel-aic5.c, one such guard is
> created early in the boot process, before interrupts are initially enabled.
> As its destructor enables interrupts, this results in the following warning
> on a SAMA5D31-based system:
>
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 0 at init/main.c:1024 start_kernel+0x4d0/0x5dc
>     Interrupts were enabled early
>     CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.16.0 #1 NONE
>     Hardware name: Atmel SAMA5
>     Call trace:
>      unwind_backtrace from show_stack+0x10/0x14
>      show_stack from dump_stack_lvl+0x38/0x48
>      dump_stack_lvl from __warn+0x78/0xd4
>      __warn from warn_slowpath_fmt+0x98/0xc8
>      warn_slowpath_fmt from start_kernel+0x4d0/0x5dc
>      start_kernel from 0x0
>     ---[ end trace 0000000000000000 ]---
>
> Fix this by using guard(raw_spinlock_irqsave) instead.
>
> Fixes: b00bee8afaca ("irqchip: Convert generic irqchip locking to guards")
> Signed-off-by: Edgar Bonet <bonet@grenoble.cnrs.fr>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -279,7 +279,7 @@ static int aic5_irq_domain_xlate(struct irq_domain *d,
>         if (ret)
>                 return ret;
>
> -       guard(raw_spinlock_irq)(&bgc->lock);
> +       guard(raw_spinlock_irqsave)(&bgc->lock);
>         irq_reg_writel(bgc, *out_hwirq, AT91_AIC5_SSR);
>         smr = irq_reg_readl(bgc, AT91_AIC5_SMR);
>         aic_common_set_priority(intspec[2], &smr);

I think the conversions in
drivers/irqchip/irq-atmel-aic.c:aic_irq_domain_xlate() and
drivers/irqchip/irq-loongson-liointc.c:liointc_set_type()
are also wrong, and need a similar change.
Unfortunately I have no hardware to verify.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

