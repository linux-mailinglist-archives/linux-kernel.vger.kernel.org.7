Return-Path: <linux-kernel+bounces-843892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC32BC081B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 09:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99A518994C4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1E3255F57;
	Tue,  7 Oct 2025 07:43:13 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E816825524C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759822993; cv=none; b=NEwwKePGDAcrPfyRvzlWT8HS6EqXSwqWvTT0cqG7HrmGMHo/f9w90XvBTiaJEvFVIJ6PwgnuUz7eaa0XGpS6GK0gmzcrK31qxmkSYk/Ayw2g8BIa/k9hufU9hx6lvR2sFvjfkVzAVJi18W6FQNX3pBDOrPVYwRRWtdBbPjjFvaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759822993; c=relaxed/simple;
	bh=yD3QIkLWD6CmpQEwsafFM6XowJaBglaGuKWBSqHUs7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qU8ja9aV4qHJIoZlJKabqWiA2LU/rY4WZvpb2TTPoqB9oDUEpYKC8dSzEBbIROhSd7aH22wp88AFHjRHXc7vSUcz4+u4P8YuNC4Krl8B3eaIbQbLd8H/6pamzNktf8veevGblzpJ0XhoJMN8/TNhppJO/n7pQhWbeIMR+micog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-580144a31b0so3051387137.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759822991; x=1760427791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7xFWmE6FERg0BV2hLFsu2RpZYyTvYQhUdrHdelRqPs=;
        b=CyjrRYz8nrAqekSLeta6LEFDIX8MNViw5i1xNcygfLBhs9uuK1cIZAlRxbmzd0Xq9O
         knpHt/CuBa30QZgluKJdM4Ixzg45nKCB8WcQir8QWYYIUxxLnyuG2yNduUrJ9WUhqIln
         hg8nAKe8QmX8hmcbFRPuUuIpf84JTWkgt13LwyLYvqL3bP65FbaqpthLXnSXI7YiMrQI
         h1OabA52vML5TmHgZJ7Y/6uUYo61XRoGTJRiz5WtYzdryWApodAifKEUyEBe5cDho1gR
         vl0eDujF68IfF2hN9ckSEJuzBpLwW3g3HN15h96WdRX3w/RpOb+SwmyWCyQhx2sqCDJp
         /TxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXt6iASomMbVADMfPxjg9VWqwpMSTc6EbZHEvV2g5zEkGqnguXd9NE9dNf8LMka1K7YUWhgJ0eHx3paew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4XdVptnl+NeOmtUH01NNv4OKhH4l1m0SO93uNtoX1wjxs0WoG
	2HfYcbqKs9xUonSJgWZ/Ojs1JRXLtRMviaI/5y7ievc9yOvVGfkcCqejSMEz8UDl
X-Gm-Gg: ASbGncvzKqsPUWrVNIBdpSxB1ykPdr+csD9Dkg3OjY8+XP8KaKFsSFhdecJZn8bsNBR
	dFbXt4dZkBV/q/rczUzts/Tz5w5h4ZY59W2zULSxgqzIJpNzubTLfKUIJwYUUMEo3S0/+XRwYwM
	/H5JFtEWAwDoA3jssAN1eNVR/IWIqaybuScut1jcTEUo0ITqur9h8RzTNN63GYNvEa9PTy2YRI1
	iZVKnbzR/XR9STX6OHSNY0jJ0/TQFRRw9JjG2mz8wbSONCRREdfutAEMSCEuBcQgltCh6YCBx9v
	zkUJVybt6IR1LaHanxg1NxZpFitzNneAAbefNXcXSnLzFP3ETeofDtFk3AoDGKjwAX+gxLMLP9s
	zRu0f0+fPyQyqYlYHbnaau6HwCEH09AINR0lE3H/f2alIEzOakawYqyEg2R4+4zU+TsoIjw8+UD
	X/9SmxTru0
X-Google-Smtp-Source: AGHT+IFcgo0EHII76QWggcLJk8uyawzxGZYC2y24vVnYE+kxUrR+kXF8dpNxCA+rVMKaHwuwSiLtUw==
X-Received: by 2002:a05:6102:508d:b0:527:4938:9e32 with SMTP id ada2fe7eead31-5d41d058863mr6258826137.13.1759822990621;
        Tue, 07 Oct 2025 00:43:10 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5d39fb8e2sm580997137.16.2025.10.07.00.43.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 00:43:10 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5a0d17db499so5513143137.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 00:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ0DO2DXAuo7Scf0ELPAtbtMpEJPhIYHSa3CaBSpLdO+b6QzMUw6dRGuX2hSdqWsgbqyVWKhRe/06p1A8=@vger.kernel.org
X-Received: by 2002:a05:6102:2acb:b0:5ca:a978:8a with SMTP id
 ada2fe7eead31-5d41d1728f1mr5458809137.33.1759822989670; Tue, 07 Oct 2025
 00:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <949f096337e28d50510e970ae3ba3ec9c1342ec0.1759753998.git.geert@linux-m68k.org>
 <mvm347wjj90.fsf@linux-m68k.org> <CAMuHMdXdeJ6Bq=zA7QcN82YNaZW3R8ebeXpGzqHus-KPkSj5XA@mail.gmail.com>
 <20251006180201.GA429708@ax162>
In-Reply-To: <20251006180201.GA429708@ax162>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Oct 2025 09:42:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUi09MEU+AUE7C5OtJzO1ZiQ-1OVVi9EWNxt7vHA3ZvVw@mail.gmail.com>
X-Gm-Features: AS18NWD5V9LmBNtT9znIAEdUf0-LOhM5TAhAk1S7CGHt0o8L8arsWU6hMHw8j3s
Message-ID: <CAMuHMdUi09MEU+AUE7C5OtJzO1ZiQ-1OVVi9EWNxt7vHA3ZvVw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: uapi: Strip comments before size type check
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-m68k@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Nathan,

On Mon, 6 Oct 2025 at 20:02, Nathan Chancellor <nathan@kernel.org> wrote:
> On Mon, Oct 06, 2025 at 03:20:52PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 6 Oct 2025 at 14:40, Andreas Schwab <schwab@linux-m68k.org> wrote:
> > > On Okt 06 2025, Geert Uytterhoeven wrote:
> > > > --- a/usr/include/headers_check.pl
> > > > +++ b/usr/include/headers_check.pl
> > > > @@ -155,6 +155,8 @@ sub check_sizetypes
> > > >       if (my $included = ($line =~ /^\s*#\s*include\s+[<"](\S+)[>"]/)[0]) {
> > > >               check_include_typesh($included);
> > > >       }
> > > > +     # strip comments (single-line only)
> > > > +     $line =~ s@\/\*.*?\*\/@@;
> > >
> > > I don't think you need to quote the forward slashes in the regexp.
> >
> > Thanks, you are right!
> >
> > So far for not just following my instinct, but looking for similar functionality
> > in other scripts like scripts/kernel-doc.pl...
>
> I will fix this up when applying. I think I am going to adjust the
> comment to
>
>   # strip single-line comments, as types may be referenced within them
>
> just to be a little more verbose about why it is being done.

OK, thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

