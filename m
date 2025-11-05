Return-Path: <linux-kernel+bounces-886511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E93BAC35CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD0144F6D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8BD315D3F;
	Wed,  5 Nov 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj0eShGv"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F62E62D4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348600; cv=none; b=MU/C883w5K6Y5Tmj4XB3OsCQivwR745eWJfkdSx4m64Vruw92xSKaUQvJdlbNO/jNvQEC13QVQm9UAQm6T3q7MXEUgcL19keSQGqJ+aC7XJoDQkbC/vRTAwP/KfK8Lgqt/16y9OUj/twImdgMi5igJUDDuGqZBqsehLzC1HWADM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348600; c=relaxed/simple;
	bh=T9ZjRAlExlBle9Gxw8NV3jtD5WBhEm7/gLkaekpkaEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7y8NUKPcPfHgdvT7vyn+SCChbnz+cbp88vW8hghBEGHPdiB+wA7+GxP0g7qfB138RjjOofGONq3wZ+CkaTO5NNKRG5i92YdE+Diq17F0YSs7PjALRbPkUZkXC06myNKc7hZYtexsZD3NmMrwoYlvtJ0bobHQeCgzKb64kO/2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj0eShGv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-594285c6509so3604498e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762348597; x=1762953397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5VGZrah33ie0BfSxMEnkVJv7D+VrvHZac8M9hCEtR7k=;
        b=nj0eShGvfldYhYLFUmkNAQ4XOJqhn3lpwAqXEMt58DX7XfUWX4b3yj10HeJJOPYt8h
         Hr8yYSAbgN9H9fjdoU4bhsUOxp9sVlxK3P8wxjrKwg78wNMIjryakWULy0c7+jRxE7F0
         PsTjNLUMYw/GYaJ5OzJ7a0KqTWDVcMR2IrdvB7TInnsS7JzqZv8U3VxmOHo6nsos1aTa
         54O1pSX9nJ0geBKr9OoohqpQzcSJmJqIglzF4ME9boWA9yTRyotDc5yFVHCtiy+kVgHS
         9wU4xOYhbRDCuj9TugGvrFK7dui2U4UXA5nM9/VMJkowIiFXzGKU5Q0J4tEUtaV/HAy9
         6aug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762348597; x=1762953397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VGZrah33ie0BfSxMEnkVJv7D+VrvHZac8M9hCEtR7k=;
        b=R4/HviH3MHVV5qmstoQqytvlKjTkoBAkFUNEJR5XpdNL2rPDJavIlbrapjZ2J0V8Rc
         UZ1ETYhELLVcoNe5xA5/w0R05llOhotdbRJEbtVosBWl4Fjtle0aYdmZc+5Qpe6kmBwI
         +2kSLteVyX4MTMrUx5qsACtEBIVK/f/umSizhGp0v9v2ocWFegSqGfx+OPO4mwa6+xZL
         7UcLOib+LsMxjC5qeFe4J07GffOHuQ6MLDNcYPdEjnIMPiYXlpv4lgXMxF40QERqEqT5
         +hNtS62dHD/rQAj+WhofOcYyS7QlF15GwJ5JcJoh5086ArXs6uy97W3oF2J45bxnqJjh
         NpMA==
X-Gm-Message-State: AOJu0Ywc9Ne0xenyHbVZyjn1KcnClg0CHusxXB4OuBfN7rsEg2QH4uD3
	6ePe9CO51o9UUl5mr4K9DW8k/+e3j2L6kaaSuVjdF+XMO0RYi0PGaVrP5zgbAnr2agfVfJJXiRv
	YcVjyDqic68JPDC1CiPCbUAkrNf+Xw+6UEYEyuu8=
X-Gm-Gg: ASbGnctRKiI9KzArm+SczHQA2a0eleS6QHvll7z82GWNmYYHlJI1PLeP3JJMOJQoKk9
	aWGBTD7HZzNJ1BagEKAWHheq1yzLf/vTWmAEJtXGHBzsiP0R0U+2Kg+M2QZsg03+w92XDN6kw2a
	w0//3Y1l47t4rrHu/BvtUBZHvjI8xkuLytbDIMW6n6Fm5CjlGNSJsaqddTkZ71O9nwvHAjj9CnX
	0JlzCwKeUXDbbZHZ5DhsXzYTzaI96xGK4G2NY6cyULBbNP96kmO2RSZI0BhhBFRPquiqP7HsJ7j
	hCM=
X-Google-Smtp-Source: AGHT+IG0YzXWMbTbwUU9D71aDeWBzEJ/KQVWDDiUSV4tlhYSsUwlaA485hhq2+u//XYa9y1WeInKFd1d1BUKtTZ3cIs=
X-Received: by 2002:a05:6512:3e22:b0:594:2bc4:8284 with SMTP id
 2adb3069b0e04-5943d80bfa2mr1150417e87.49.1762348596657; Wed, 05 Nov 2025
 05:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103190429.104747-1-vishal.moola@gmail.com>
 <20251103190429.104747-2-vishal.moola@gmail.com> <aQopoAj3i2jdIX6V@pc636>
In-Reply-To: <aQopoAj3i2jdIX6V@pc636>
From: Uladzislau Rezki <urezki@gmail.com>
Date: Wed, 5 Nov 2025 14:16:24 +0100
X-Gm-Features: AWmQ_bm5zSslRL7odzax1g1yzWcLuJoFdgi4luT5u2tawHzjpU6ps8je4_UKZKU
Message-ID: <CA+KHdyWxjqAxVEBjOun9VxoeErWEyba3OvcJveLqnRuBLk2RLA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] mm/vmalloc: warn on invalid vmalloc gfp flags
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"

> On Mon, Nov 03, 2025 at 11:04:26AM -0800, Vishal Moola (Oracle) wrote:
> > Vmalloc explicitly supports a list of flags, but we never enforce them.
> > vmalloc has been trying to handle unsupported flags by clearing and
> > setting flags wherever necessary. This is messy and makes the code
> > harder to understand, when we could simply check for a supported input
> > immediately instead.
> >
> > Define a helper mask and function telling callers they have passed in
> > invalid flags, and clear those unsupported vmalloc flags.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >  mm/vmalloc.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 0832f944544c..290016c7fb58 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3911,6 +3911,26 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >       return NULL;
> >  }
> >
> > +/*
> > + * See __vmalloc_node_range() for a clear list of supported vmalloc flags.
> > + * This gfp lists all flags currently passed through vmalloc. Currently,
> > + * __GFP_ZERO is used by BFP and __GFP_NORETRY is used by percpu.
> > + */
> > +#define GFP_VMALLOC_SUPPORTED (GFP_KERNEL | GFP_ATOMIC | GFP_NOWAIT |\
> > +                             __GFP_NOFAIL |  __GFP_ZERO | __GFP_NORETRY)
> > +
Also we do support %GFP_NOFS and %GFP_NOIO flags.

-- 
Uladzislau Rezki

