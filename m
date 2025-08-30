Return-Path: <linux-kernel+bounces-792847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F33B3C9AD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C521F7C6DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C58C2459ED;
	Sat, 30 Aug 2025 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je8ZcyER"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1304126BF7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756545363; cv=none; b=LuP1zLr/Q2/ZGaR4DB73kfOMlYFqLueWeb1iOayeRVYjBBD0tESBANhG+SheVY+Zk6SxjQPyg9JW5iSYtVfYXNAQeP1N2YVlRiBx8+EjX0MSxBW5GmTPLZvTCfmG0t4E0vHHCoHawnKbOuoUEURF0p0yJMS6D1ZeChgjmNUec7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756545363; c=relaxed/simple;
	bh=YRi5JrxRQGRuc1OXQ5+MrLyGvG/x2aV3dyn56nfMQcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rC37fuZJA4tlNJjj7n4/5qzFYcUzviMQVY2WSMIoDU3rZcdUp865op+v9qN+HQaDcFjyLGND6exhhlG1B8c3fQAWraYhbPd+12h6T2X6FeTyYC5ajumc/FqXadDhNuAqY2BapHo9Sn5vLnY/g273xUJLLLX4M449Yje/NF8H8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je8ZcyER; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afeceee8bb1so426336766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756545360; x=1757150160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrj9R3nVkaTCZLJYA7b22S0d1XHcw58mLf7q8CNp5Vc=;
        b=je8ZcyERdjkvkli58R0ZtFJqY4sRUpZx39gillBDD1Og+0ZbsGtmgmdzzWkkWQvjMR
         wYCa48cyFR96fp0jb39xklMxDlziaeDGotzA4cTUAioA8Csn8gyuRl+vZfF22nG/q+t6
         RHxsKk+hg+H7kM3ifs3BodIktvgsvcqgviFZMd/o5P5BFWSHY/lPKfah2NYqMZUBlims
         L62Ww0oGN/1rnXTsG5wTKg9XS/I0PYCYStL0QyQtEcV/N17QppZTSYd43cBXin2QpfWs
         cTzOtfsaofsDIVqr5874j3nfpnRwD9UWWHGS7fY5pndQ2Fo2KwCahBdI0DGcsoTh+7lV
         6iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756545360; x=1757150160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrj9R3nVkaTCZLJYA7b22S0d1XHcw58mLf7q8CNp5Vc=;
        b=htSlG6cy0rjXZfoB6Qih36t5jK3SNqKXzZGovaPmcAX8T0UoGQ6GFbv2TmNHUX1VQa
         yc6S+eY/9MBOvBIogmwLQeHuamAsqwHQpLfsv1uGijzYjEJBPpafHXQSm/PvxzIcnajr
         fZiYpOhj3o1z9BOQ+VL8wOh9HDSvl6GIkdZTVF/wTFl2ljkew9VXaZg9+smp15QYblDi
         haShdPoxhlOv+hDqQo3Z/HGiWfSeRdGDRecqIcrFSrBF3n9Dp68Gjd7AvrgAoxf0vepl
         XUK2GXnt+Za1MCv+sLw3goqjUerubj2WkRmc77T799WbKrtrPVwVcx+Cq7GMwRPPpnOp
         ARcw==
X-Forwarded-Encrypted: i=1; AJvYcCUBE8CARREvhZU+DLnZHPOrjYf9Ym+aqXpt5vtDTJR9fZZqO5elnS7lBa8hpWZAQJ+abQuYqq9t22fa8FU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0T1wa4D2osSTqNy37TKoR0dvS72vzJ2fl7mO4zbOXs/9+sGnj
	oiXusHIQms+6XAmS/WpWwy/zQddbJgmCdHi2ogjl74hQQCFcbnwbX140EVTZgiR1OTmAijhmGO4
	854YaX7L8PgFy2zmtWEh1OzcejzhUPwo=
X-Gm-Gg: ASbGnctXcUZnJrOjMZMpKSS0zI0OI36jItuMXOSo9nXeCYCZ0rjEiLpbuJ6inGOr6p9
	B37vwTbJLjYVQbrs77bhPnY56dSV/BE9mB4wANXcLJFldtdixtOmpCNrbIBEmkjipyplIzQv8/P
	E3LE/byZbYCdIRrz7r2Yx2aZ3FaEPmcywTL2gy3zAzGLjGlMq2Np5SE3W4lke3AOAGcnzWONt89
	EBYomY=
X-Google-Smtp-Source: AGHT+IH9Mnc3Jo4dFBP4EcrvdRwA6ZQe5nYKI7QDpn+yKhW058nEwxO/7jFBqsHG3REkSIbr+V+6R6Nev5+FZGGP4E4=
X-Received: by 2002:a17:906:eec3:b0:afd:c31c:2488 with SMTP id
 a640c23a62f3a-b01d97307b1mr132813266b.39.1756545359885; Sat, 30 Aug 2025
 02:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010324.15595-1-jefflessard3@gmail.com>
In-Reply-To: <20250829010324.15595-1-jefflessard3@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 12:15:23 +0300
X-Gm-Features: Ac12FXwVYX6_QmTb_9V6PmqXP6kE5VSVEOYLzIX_7sRnLLzSVY461Jeb42eGx1s
Message-ID: <CAHp75VdF=_LQbHJozUGExCmDd4UW4oJ0-deT=aEdnQjCOotsVA@mail.gmail.com>
Subject: Re: [RFC PATCH] auxdisplay: line-display: support attribute
 attachment to existing device
To: =?UTF-8?Q?Jean=2DFran=C3=A7ois_Lessard?= <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 4:03=E2=80=AFAM Jean-Fran=C3=A7ois Lessard
<jefflessard3@gmail.com> wrote:
>
> Modernize the line-display core library:
> - Add the ability to attach line-display's sysfs attribute group directly
>   to an existing parent device (not only via a child device) using
>   device_add_groups(), allowing coherent integration with subsystems like
>   the LED class.
> - Implement a global linedisp_attachment mapping for unified and race-fre=
e
>   attribute access, context lookup, and cleanup, shared between
>   traditional register/unregister and new attach/detach paths.
> - Modify sysfs attribute accessors to retrieve context using a consistent
>   to_linedisp() mechanism.
> - Add a new num_chars read-only attribute reporting the number of display
>   digits to allow static non-scrolling message from userspace.
> - Ensures thread safety and proper list removal for all attachments
>   operations.

Thanks for working on this, can you split it into 5 patches?
More comments below.

> Backwards compatibility with existing users is maintained, while enabling
> uniform n-segment sysfs API and richer information for integrated drivers=
.

...

> -#include <linux/container_of.h>
> +#include <linux/list.h>

Keep it ordered.

...

> +static const struct device_type linedisp_type;

Why? I don't see the use of this in the nearest below blocks of code.
Can you move it closer to the first user so we can see the point?

...

> +       scoped_guard(spinlock, &linedisp_attachments_lock) {
> +               list_add(&attachment->list, &linedisp_attachments);
> +       }

{} are not needed (same rule as with for-loop of if condition with one line=
r).

> +       return 0;

But in this case you can simply use guard()().

...

> +static struct linedisp *delete_attachment(struct device *dev, bool owns_=
device)
> +{
> +       struct linedisp_attachment *attachment, *tmp;
> +       struct linedisp *linedisp =3D NULL;
> +
> +       scoped_guard(spinlock, &linedisp_attachments_lock) {

Use guard()() and drop NULL assignment.

> +               list_for_each_entry_safe(attachment, tmp, &linedisp_attac=
hments, list) {
> +                       if (attachment->device =3D=3D dev &&
> +                           attachment->owns_device =3D=3D owns_device) {
> +                               linedisp =3D attachment->linedisp;
> +                               list_del(&attachment->list);
> +                               kfree(attachment);
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       return linedisp;
> +}

...

> +static struct linedisp *to_linedisp(struct device *dev)

As per above.

...

>  static struct attribute *linedisp_attrs[] =3D {
>         &dev_attr_message.attr,
>         &dev_attr_scroll_step_ms.attr,
> +       &dev_attr_num_chars.attr,

This needs a Documentation update for a new ABI.

>         &dev_attr_map_seg7.attr,
>         &dev_attr_map_seg14.attr,
>         NULL
> };

...

> +int linedisp_attach(struct linedisp *linedisp, struct device *dev,
> +                   unsigned int num_chars, const struct linedisp_ops *op=
s)
> +{
> +       int err;
> +
> +       memset(linedisp, 0, sizeof(*linedisp));
> +       linedisp->ops =3D ops;
> +       linedisp->num_chars =3D num_chars;
> +       linedisp->scroll_rate =3D DEFAULT_SCROLL_RATE;

> +       err =3D -ENOMEM;
> +       linedisp->buf =3D kzalloc(linedisp->num_chars, GFP_KERNEL);
> +       if (!linedisp->buf)
> +               return err;

You can simply return -ENOMEM without initial assignment.

> +       /* initialise a character mapping, if required */
> +       err =3D linedisp_init_map(linedisp);
> +       if (err)
> +               goto out_free_buf;

The __free() can be used instead, but for uniform handling it's
probably not needed here.

> +       /* initialise a timer for scrolling the message */
> +       timer_setup(&linedisp->timer, linedisp_scroll, 0);
> +
> +       err =3D create_attachment(dev, linedisp, false);
> +       if (err)
> +               goto out_del_timer;
> +
> +       /* add attribute groups to target device */
> +       err =3D device_add_groups(dev, linedisp_groups);
> +       if (err)
> +               goto out_del_attach;
> +
> +       /* display a default message */
> +       err =3D linedisp_display(linedisp, LINEDISP_INIT_TEXT, -1);
> +       if (err)
> +               goto out_rem_groups;
> +
> +       return 0;
> +
> +out_rem_groups:
> +       device_remove_groups(dev, linedisp_groups);
> +out_del_attach:
> +       delete_attachment(dev, false);
> +out_del_timer:
> +       timer_delete_sync(&linedisp->timer);
> +out_free_buf:
> +       kfree(linedisp->buf);
> +       return err;
> +}

--=20
With Best Regards,
Andy Shevchenko

