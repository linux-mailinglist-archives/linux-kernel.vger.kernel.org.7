Return-Path: <linux-kernel+bounces-891027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6702C41A37
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A271A4EDB1A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF2B31961C;
	Fri,  7 Nov 2025 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHjxLduA"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C13230EF87
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548811; cv=none; b=ncfLnQByJwJcD91DsCaIPhBHSCpwUWwFv745XUGz5bZERgC/l+2iDTQxhkkalXVfmemUZ6gH/NRaRZFEjoH4kVm34nN2T9UG36+YE09fhO71P//EUFO1YP7FSCqgBSftGr43UpVCztr1NJyXHuuBvpdABWgThBERZc1eSbEuUDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548811; c=relaxed/simple;
	bh=ljO4JvzYez1krH2vOKDSHh0LKeuwRchWTqG+Aa5yOl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQPvlM4avrnO/DXSp83HluXB0b5LwaoTk8+V8wZ3eT5NOvT71mgW6vLMT+pHkmiD7sP/hMmsHuqrsUv/mbnF9a8aTBqW9OrVKH4QLO6K8R0gh5ftnGCiNXVhlbZ3u484DniFQfW5bK4HTYrESSyCHu/2XHmRzOL4QfXUiQgX6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHjxLduA; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63f2f1ac9feso190132d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762548809; x=1763153609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndAmh0MjfxVBBMOro9qnccRFjet8LAlaiu54q/obIYI=;
        b=KHjxLduA0yJRF9gYLLhzLwSA3XQnvK8Umf+c8k/NcwFCLaz7HlWp6KD/O271uYQ6sc
         vpyDmCs+Gywp3opLba6Vdc/lsMqjWOoruiqOysJ9KxfWH2zmwQz/XK0OfeB1qB//yMp3
         y5Nn+pzbqs3apkQlT8zGQ5refWJXFxbl/9Mmc8Rp8O3wDzp9POOhUGdyTixMbDFVTgi2
         Dhgz9qhXlzzan5J76fdyU3RHQGozEFIF7LLdOcnbW6izx7aCuqvNGXGtTYFK/xMJQ2Yd
         FjGdwIzG0AN5pObeDa6aDa2g7t2hR34uGCOSOSxHeXjnSIowi7pYQO6K85E4I0LV6KeW
         WTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548809; x=1763153609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndAmh0MjfxVBBMOro9qnccRFjet8LAlaiu54q/obIYI=;
        b=jimt82usdx1NtDB9eJ7otYfbo6XSr1F/QTcjdTCXYJJf3oa3cW2vwy7HVtZR3vdfCD
         CZ23LSEOl8RNijqX17ThqILru4hI+QlN7AvEub2lBsugIPN9jveUhk0ZdLo/0sg8hT2A
         eOM2oeI/qSDD4jev6bLAoJMuLIilFRBF9ioqn0g5PipGNokOih/FR5v65wlqU6K4yp9Z
         XNCkaFXhCAQso0Da60t1Y1VvHVxwXJg06A2fwOZtW1/by6IMyCsKVHVEnPwnpzJ1E0TN
         S2kV00Wbu/TZrHj5Md/5QDAjI6wXZZMXbqHoUSt7zeajMi9kCvUTGtLFeBFDJDz5V5Wm
         YnRw==
X-Forwarded-Encrypted: i=1; AJvYcCWBaEiHDeDzjXBtW4U7yw7+zh5yKNHw+sVMnlF4s5wHNuTXhnQD/9tzx5f2B17abJLFkahcAtTh8c/VvC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Sck0tnJfedsezUgZZ4guHdP/R63hP6GDjqN+QoZxH/cc8lKn
	3ejFFIUkDFwHBo98z7FPxA8zydj+/pk2tuV3lH3XtstNkv0yWiOrcjVAX7x4BxSGE6voQeGqnmQ
	vMYGo4jCiRgodj8/T90yj2MDSng0qB4E=
X-Gm-Gg: ASbGncsdVqdA8hr5ixjDxjg64y59vxrrFwAQ974Chox1aW0ajbjRb1r5cfXCFQA1hqz
	8UfZtppmY6S6EC4BW5iFebNeKPxJKJZXW2NDLZcij3WlHMHdi/QT1P+JqLjjCyopJNeU0RMGeBs
	1v7UK7KhW4PysvS0EkLGFFw7g2De/xth2guWYezlMHsZMk13nxstv1mrw6uRoBb9xazMEuWXfgN
	E6kHop2iQflk+q58qXdQjIDZxLZshbiZjk42Tt7tBXL3D31UUMkwRi7gs0xUYRJw0hhgkW6VHIq
	xNZnJADT7kiz3s9f10r5jA==
X-Google-Smtp-Source: AGHT+IFA5LRJyKMNpiLJ6acp+jtqn28437tPxYxfpfcUscZsu2WEuoubDNLDYs74uabDBYBM/7EmlyOaY/35gs8ZEr4=
X-Received: by 2002:a05:690c:a:b0:786:4fd5:e5d4 with SMTP id
 00721157ae682-787d54166b6mr4447577b3.6.1762548808930; Fri, 07 Nov 2025
 12:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
 <20251105-netconsole_dynamic_extradata-v1-2-142890bf4936@meta.com> <jejsptfg7cqmbcm467tb72gg3mwsqge6iz4qy4wy5ifev2sgim@hukyfgsr74xj>
In-Reply-To: <jejsptfg7cqmbcm467tb72gg3mwsqge6iz4qy4wy5ifev2sgim@hukyfgsr74xj>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Fri, 7 Nov 2025 20:53:18 +0000
X-Gm-Features: AWmQ_bmKloNJpWlaMH-L-FWBG3Z5z2qrAABsdDUdzzHSOuB9z0bXDZ5dbKaYqbQ
Message-ID: <CAGSyskXmLQi7urQodZVNF7n6j2OTVB4yGoXDQrHccsM0kniSkA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] netconsole: Split userdata and sysdata
To: Breno Leitao <leitao@debian.org>
Cc: Andre Carvalho <asantostc@gmail.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 1:23=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index 0a8ba7c4bc9d..e780c884db83 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -50,7 +50,8 @@ MODULE_LICENSE("GPL");
> >  /* The number 3 comes from userdata entry format characters (' ', '=3D=
', '\n') */
> >  #define MAX_EXTRADATA_NAME_LEN               (MAX_EXTRADATA_ENTRY_LEN =
- \
> >                                       MAX_EXTRADATA_VALUE_LEN - 3)
> > -#define MAX_EXTRADATA_ITEMS          16
> > +#define MAX_USERDATA_ITEMS           16
>
> Do we still need to have MAX_USERDATA_ITEMS cap with your new approach?

That is a good point. I did think about this and ended up deciding to
keep a limit as a safety measure against userspace creating a boatload
of items until we run out of memory.

>
> > +#define MAX_SYSDATA_ITEMS            4
>
> Can we have this one inside enum sysdata_feature?
>
> Something as:
>
>   enum sysdata_feature {
>       SYSDATA_CPU_NR =3D BIT(0),
>       SYSDATA_TASKNAME =3D BIT(1),
>       SYSDATA_RELEASE =3D BIT(2),
>       SYSDATA_MSGID =3D BIT(3),
>       MAX_SYSDATA_ITEMS =3D 4  /* Sentinel: highest bit position */
>   };

Sure, I will do this in v2.


> > @@ -1353,22 +1311,21 @@ static void populate_configfs_item(struct netco=
nsole_target *nt,
> >
> >  static int sysdata_append_cpu_nr(struct netconsole_target *nt, int off=
set)
> >  {
> > -     /* Append cpu=3D%d at extradata_complete after userdata str */
> > -     return scnprintf(&nt->extradata_complete[offset],
> > +     return scnprintf(&nt->sysdata[offset],
> >                        MAX_EXTRADATA_ENTRY_LEN, " cpu=3D%u\n",
>
> This is confusing. It is writing to sysdata but checking extradata entry =
len.

My understanding is that extradata is a way to refer to both userdata
and sysdata, and MAX_EXTRADATA_ENTRY_LEN is the maximum size for both
(and the arithmetic used to define MAX_EXTRADATA_VALUE_LEN and
MAX_EXTRADATA_NAME_LEN also applies to both). Do you want to define
separate maximum sizes for userdata items and sysdata items?

> > @@ -1533,11 +1475,11 @@ static void send_msg_no_fragmentation(struct ne=
tconsole_target *nt,
> >               memcpy(nt->buf, msg, msg_len);
> >       }
> >
> > -     if (extradata)
> > -             msg_len +=3D scnprintf(&nt->buf[msg_len],
> > -                                  MAX_PRINT_CHUNK - msg_len,
> > -                                  "%s", extradata);
> > -
> > +#ifdef CONFIG_NETCONSOLE_DYNAMIC
> > +     msg_len +=3D scnprintf(&nt->buf[msg_len],
> > +                          MAX_PRINT_CHUNK - msg_len,
> > +                          "%s%s", nt->userdata, nt->sysdata);
> > +#endif
>
> I am not sure I like this ifdef in here. Can you if userdata or sysdata a=
re
> valid, and then scnprintf() instead of using ifdef?

OK, will do that in v2.


> > @@ -1594,12 +1547,20 @@ static void send_fragmented_body(struct netcons=
ole_target *nt,
> >               msgbody_offset +=3D this_chunk;
> >               this_offset +=3D this_chunk;
> >
> > -             /* after msgbody, append extradata */
> > -             this_chunk =3D min(extradata_len - extradata_offset,
> > +             /* after msgbody, append userdata */
> > +             this_chunk =3D min(userdata_len - userdata_offset,
>
> Please assign this "userdata_len - userdata_offset" to a variable and giv=
e it a
> name, so, it help us to reason about the code.

What about:

int data_remaining =3D userdata_len - userdata_offset;
int buffer_remaining =3D MAX_PRINT_CHUNK - this_header - this_offset;
this_chunk =3D min(data_remaining, buffer_remaining);

>
> >                                MAX_PRINT_CHUNK - this_header - this_off=
set);
> >               memcpy(nt->buf + this_header + this_offset,
> > -                    extradata + extradata_offset, this_chunk);
> > -             extradata_offset +=3D this_chunk;
> > +                    userdata + userdata_offset, this_chunk);
> > +             userdata_offset +=3D this_chunk;
> > +             this_offset +=3D this_chunk;
> > +
> > +             /* after userdata, append sysdata */
> > +             this_chunk =3D min(sysdata_len - sysdata_offset,
> > +                              MAX_PRINT_CHUNK - this_header - this_off=
set);
> > +             memcpy(nt->buf + this_header + this_offset,
> > +                    sysdata + sysdata_offset, this_chunk);

I realize we have the same NULL pointer arithmetic problem here. I
will fix it by checking if sysdata or userdata is NULL.

>
> s/this_header/this_header_offset?

I just realized that this_header is not even necessary. I can simply
add header_len to this_offset and get rid of this variable altogether.

>
> Now that you are touching this code, please review these variable to keep=
 them named correct.
>
> Maybe adding _ptr for pointer, and _offset for offsets and _len for lengh=
ts?

Once I get rid of this_header and add the _ptr suffix, I think it will
be much clearer.

Also, I find offset and this_offset confusing. What about replacing by
msg_offset and buffer_offset ?

>
> Thank you for your work reasong about all of this!

Thanks for the review!

