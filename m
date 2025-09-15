Return-Path: <linux-kernel+bounces-817413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A96FB581EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB0C93BE85A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD7E279DA6;
	Mon, 15 Sep 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJOCdnrW"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F462DC786
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953308; cv=none; b=mE5ADZtqJVOny4QppHEcsNeY5d7xjQwbRO11JWag2QfxgPR2GnRbA5A4La96QfYBw7GNb2ieRQZD3VqqlLrBHttQZ0cmG1RcJUoF7qmswl3PKLYiWk0vugOc6DHZe6sz0XnQl7AFwr2c3Y9KNlZx39iN87zoonpNyPoscFS3wKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953308; c=relaxed/simple;
	bh=wvm/YDfDjX00lXbYcoJ78OyjAP+EL5Zv1+uQSIz/nGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDUoA8kO7D7ZRDpEoZkB7j6O52RgPvNRJTkiKQ4iO+IZivID51VTmW0EPzKwLfKR7fAezRGMfGmCYCf1BlUa+UY2Ku0KXRvTZiOHALK7qdLjg5GHwU9H76I117KGtZD0veAVlDVImrcv01HSzM/sxCeb35JPIS4ssDMDs4ogkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJOCdnrW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso2428018b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757953307; x=1758558107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIfya/Ph9ELGjBdaFUR3nvvY1YsMWgietDDreu7YMqs=;
        b=jJOCdnrWjKTSoUMHUHJE8+STW1M/PDNoB++lwyu/OnYC0qvU+D1mEiDWQlU1YqmSWg
         6ZlEYEwWXWXxGAFGxMLzRCPs+1S6NvE65VwxYQ9T5l3UEc+8aBgFis0qelrYj94Cg4Ka
         YQ9YjKlC/OjIbGmQFctNZKQflm8aYYeQvvOr2DqS0/QAwCPUbIx+tZ9zSffqsScwo52E
         BGI8UfpQeIz3p/tySxSH3TiN7otHIrSwbrb/3ZW+t2FTcEd++ezsXevvQnEyzsX8DVvN
         exvV2EctCrwdKijPjLE+Siga/B4DvG+4SZCefBDOETXZ0vieUOflOFzXFRoItKAKNCC4
         r/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953307; x=1758558107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIfya/Ph9ELGjBdaFUR3nvvY1YsMWgietDDreu7YMqs=;
        b=uNeknEEW+xQgXZlo7V45VnoHU77yZcB896IAEHlE7nFxQIZTEmv5YStpsI3tvTJENQ
         Qh8tiLaqtRdbyGcAIOB7XJCjmwpefjTP/DO80oPJF6mRsCNwWNS5gLd34aTs4IRWmR/i
         1mHHvrJ327IL2qZ02pU7tBVvd3DS4vJuGTyf/dQtBW6kzxB2SG/9ADrCYDKItfmKMhSp
         9SHgG8C+G5Zc5N6X382GeV0osPdFTUHVu9jv2SO/p4JZCM+/OpWLz70qm2I91DflIlgH
         N1OQkz0HR0gWo9ldsOxPXoHEn0isLlpOc1QaSZheij5IuEjTER4ghCVBC2jQ97apn0gu
         xA9A==
X-Forwarded-Encrypted: i=1; AJvYcCXo8m7i64k5UigHLPrY5/HWmnIrA4uqOPjjtEyFh5ZZYzdCtlYkHRqQmk5kQYnUaE+EtkIm5OBE5CYzIqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi1XWDiwZ9rN1o2AEqq9iUt3meQ9T6xfT+Mp/IMvX+1g/4FwWH
	6v6pWbGx/CFrmV1Z2rhs1WOhx+LMSFq+2sqgFg8CowGo78jlqNyHtwWeujQTZKW44P42e2vJ/xi
	0G8xD9MSjUphiFCye0WAsoQzumoEUUZc=
X-Gm-Gg: ASbGncuWeFxd7qsIVRU8JYJAisaDpkIGShjviimjiGYH+wObK4qFgL/hZCXapSYr//t
	V5Dp/w8dN61H+938OxBYMy01wc7j9jQgtYEVrjIwsh3hmu0wEtIratHAMiG66xlvhV0Udufce5o
	gII4MjO44K1fjniNeIrb4bXloY/3NLh7mXZFz40Mr3GSLDX9UraepKE3H5jvE5duNSt0qDLisPQ
	RLjEk0KuuaU6bouxUJcqVM6iI+hLLtLT4RH3ncp62/v
X-Google-Smtp-Source: AGHT+IG/NjJxAkrJZkQLDxttORDqXURDu/SD6C5XJ2MvnbI8geGiym45rYCoYWZzO4+sr/4nkYyDv4lHCs7QZ3VTUW0=
X-Received: by 2002:a05:6a20:7f87:b0:262:7029:107e with SMTP id
 adf61e73a8af0-26270291299mr8927197637.4.1757953306863; Mon, 15 Sep 2025
 09:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144442.1427943-1-chen.dylane@linux.dev> <20250913162643.879707-1-clm@meta.com>
In-Reply-To: <20250913162643.879707-1-clm@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Sep 2025 09:21:29 -0700
X-Gm-Features: Ac12FXyhfN0doupOcNHY6SucY_kDEUb8JLHHfzwdZNrqaHmihKeH1wZ5muINod4
Message-ID: <CAEf4BzYDgkEwVo3T_jW2QtjXxCxYPxPMC-+46C12Us+9F2bOFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpftool: Add bpf_token show
To: Chris Mason <clm@meta.com>, Tao Chen <chen.dylane@linux.dev>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 13, 2025 at 10:18=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
>
> On Wed, 23 Jul 2025 22:44:40 +0800 Tao Chen <chen.dylane@linux.dev> wrote=
:
>
> [ ... ]
>
> > diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> > new file mode 100644
> > index 00000000000..6312e662a12
> > --- /dev/null
> > +++ b/tools/bpf/bpftool/token.c
> > @@ -0,0 +1,225 @@
>
> [ ... ]
>
> > +
> > +static char *get_delegate_value(const char *opts, const char *key)
> > +{
> > +     char *token, *rest, *ret =3D NULL;
> > +     char *opts_copy =3D strdup(opts);
> > +
> > +     if (!opts_copy)
> > +             return NULL;
> > +
> > +     for (token =3D strtok_r(opts_copy, ",", &rest); token;
> > +                     token =3D strtok_r(NULL, ",", &rest)) {
> > +             if (strncmp(token, key, strlen(key)) =3D=3D 0 &&
> > +                 token[strlen(key)] =3D=3D '=3D') {
> > +                     ret =3D token + strlen(key) + 1;
> > +                     break;
> > +             }
> > +     }
> > +     free(opts_copy);
> > +
> > +     return ret;
>
> The ret pointer is pointing inside opts_copy, but opts_copy gets freed
> before returning?

Thanks for the bug report, Chris!

Tao, the fix probably should be something along the lines of:

ret =3D token + strlen(key) + 1 - opts_copy + opts;

to translate that pointer back into the original string? Can you
please send a patch?

>
> -chris

