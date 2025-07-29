Return-Path: <linux-kernel+bounces-749021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D009B148F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E14227A5238
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FBC25F97A;
	Tue, 29 Jul 2025 07:08:47 +0000 (UTC)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF3101F2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772927; cv=none; b=Utd0T/qWMWzHb46TYDxaBvO35tIJKEEQmZrrOP3k5UE8GNG5Jz44GvMe6MWeV/jQ18fK6MsNAfx7HR+WwFXHQ2H/uAdoS2wQEciGgd4UMLV8Mm5XtCe0WTxgXpNYUCuFH5U0JT+QCOLB3XxiwOtsMTSLarNtzlZRECcPbDYxfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772927; c=relaxed/simple;
	bh=qEOp4eAuXtjwqThRUtipER/RVG2D7gK9UTVt7qKgUs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZGUNWpjAeRT1Y9vWoTVT+1vDyg0Qh7NLpFAMQ3bh8/H68ENjs8XCwNSYbO4fgo5oeGNj95Hqvk9ba5UwJ6nGwFwSGMSM7NFbOLjv5G2tU1Hm20T5PARaXw/oclZtjqU1KkxHdRRhU4ni482lmOoWhnmEjD0NRLWo2evU3lKYqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4f2fe63d51eso687919137.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772924; x=1754377724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8YtcC/yIgCDEWMFfAtdpI0rgOgUJRQFp+eUsj2IWqc=;
        b=WsoEKBbBbRfdrgpp/6T2xWipb4aORfRcs+F3yTZYDqnxrH6CnHly45Lt7qxarYeKyG
         evVBJYCasonc4/Fuzp6VUtPIl2gn7xYs36anz+5JSWvN3wpp8AwxyXAj2VfJkvf18WMK
         WCbWTly7pjE3OUJbp5pB31blOBkCZfwr6pBsiGjMIG06EYqFJx4Mw4pahwH4/6z6YOgS
         6U0pKKcO9VLSOV4a5MgOQi0nFvPjsRNePQFS7IAujP9Bjkg1evgCX1NJTMoHQVKqgoef
         MlCgrECT/eLT2WTP1sMqJdsCfr0t1B1k2dpWpux7ZVaLfXyZQCxVcPdCni9RGfrOZbon
         BadQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+3eioubNKs4nNx5UYsI57g56wjkhFr/miWdZW1lGV4QMNZ6BpjvZilv8QNg2YRSoCjKRDTsMhU5tiCLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzevBZPgwjGM2PU9lfFcdNdHxgCwSRQ6gNki/T2QJQP8T0EP70u
	ZePEE8Tj45ocAuW9Hd0EU4PytYvI0EBzCidtDtXeeLEKqsu8sMArnptMjIKhx+ct
X-Gm-Gg: ASbGncs2WL5DQUT91iw0C97t3psG4Rj7IaxqVCLizATP+khPnYs4v9kWDsxezsbWUfg
	HV+0yX6/W3f6A23g0GJ992lmaWmqAuWxucKvP7Ct/C+mC58sQWXQBP7F6+uNHCBKaRxvviefAer
	uMdVGxYMQlqq7DyppYchEhIp85mTmYhsorRVjJOkXA10KPLX1F2Hcba7185wfW6o6DWFEylWeTO
	zGcJceDmWcJrKR8X5Th+PBcjl0aOejtuzg2mcarVRKLzdYE5rXlHiuiBFqqU5YdrdHRBtzHh0I4
	xbKxreDIyFJRZ++dvuJLxZ/bnwkuscezfTrDHsIW0JJ6Bd8W+CtBiHk/Id2f+G9ePHmBZIerTBw
	UsEOvjs3TPI2rp0xHYKzYJXnk+8N/SJYmqvwreS5/7a4ZaZIPkSwhVqEICXGr
X-Google-Smtp-Source: AGHT+IEsks1As/gJsDabYMkZtubh2e00/bL05lXckTjA8CXrq21q3vR7ANvYkQltyMGDQObLQ2tZ7g==
X-Received: by 2002:a05:6102:950:b0:4e7:3d55:5212 with SMTP id ada2fe7eead31-4fa3fa91ecdmr5863721137.11.1753772923957;
        Tue, 29 Jul 2025 00:08:43 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b8d8c5d29sm1664603241.3.2025.07.29.00.08.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 00:08:43 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8815049d0a8so1403374241.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:08:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpI2y7qSp4h4a32TTuTRJlVLDLN1CVJdw+vTSBjSL9D4Tc2sh4nIm83gNWkoWYWCljfsy8JGAdeKvfAKk=@vger.kernel.org
X-Received: by 2002:a05:6102:304e:b0:4fb:dcde:3f96 with SMTP id
 ada2fe7eead31-4fbdcde4191mr324280137.8.1753772923410; Tue, 29 Jul 2025
 00:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728093412.48065-1-jogidishank503@gmail.com>
In-Reply-To: <20250728093412.48065-1-jogidishank503@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Jul 2025 09:08:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUkJrsug-hKkM_f+0xxrPHBQfw_3WB2FhMM=yAYzRn1Eg@mail.gmail.com>
X-Gm-Features: Ac12FXxAEbnb4l6V0uvEPoVTtKnza535a3ryL1k5c8rsxUEbVBR5-jZ6yXaKH1E
Message-ID: <CAMuHMdUkJrsug-hKkM_f+0xxrPHBQfw_3WB2FhMM=yAYzRn1Eg@mail.gmail.com>
Subject: Re: [PATCH] zorro: fix checkpatch error by avoiding assignment in if-statement.
To: Dishank Jogi <jogidishank503@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	darshanrathod475@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Dishank,

On Mon, 28 Jul 2025 at 11:34, Dishank Jogi <jogidishank503@gmail.com> wrote:
> These changes improve code readability and bring the file
> in line with the Linux kernel coding style.
>
> No functional changes.
>
> Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>

Thanks for your patch!

> --- a/drivers/zorro/gen-devlist.c
> +++ b/drivers/zorro/gen-devlist.c
> @@ -44,7 +44,8 @@ main(void)
>
>         while (fgets(line, sizeof(line)-1, stdin)) {
>                 lino++;
> -               if ((c = strchr(line, '\n')))
> +               c = strchr(line, '\n')

As Christophe pointed out, this line lacks a semicolon.
Please do not submit untested patches.

> +               if (c)
>                         *c = 0;
>                 if (!line[0] || line[0] == '#')
>                         continue;
> @@ -68,7 +69,8 @@ main(void)
>                                         fprintf(devf, "\tPRODUCT(%s,%s,\"", manuf, line+1);
>                                         pq(devf, c);
>                                         fputs("\")\n", devf);
> -                               } else goto err;
> +                               } else
> +                                       goto err;

This does not comply with Linux kernel coding style: please use braces
in both branches.

However, in this case I'd rather invert the logic, remove the braces,
and reduce indentation for the big block:

    if (strlen(line) <= 5 || line[5] != ' ')
            goto err;

    [...]

>                                 break;
>                         default:
>                                 goto err;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

