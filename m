Return-Path: <linux-kernel+bounces-841030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056ABBB5FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 08:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEF83C6161
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 06:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919EF214A9B;
	Fri,  3 Oct 2025 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vea80jMh"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6621254D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 06:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759473849; cv=none; b=YajZRbvyDZy4NuUKyLHR8VSHNZBLxxcagOs2b6LX4x23ydQ6OPqlffPlcGhnZiJ7uhBT5CtCpY+9PiEJd1cX1nvia0bwPwtQFq97s9IXF/QpD7hukcjOJJWkr1hqT0zgYaR+NRb8Cr2tK0CgEmeqpgfyA1OqHfXTQ9G5HOP0rUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759473849; c=relaxed/simple;
	bh=eguH9qH82jQam+LusgD1a2RBGg96J5X715GsFtIhrUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CDsNRiqWmluA5DeirAD8bpOUTVvtLRQqrBI7jI/8D7Wg1MYcDjfNZRD6SFRpIiRKFTt/Makl1El0PQFN3qerFMRfUAz5wIgqNIEaop1ugh3LfiDiVCZi0i7fEjsoC104LRoasoZBr1sqWCSrMdjLlKQCLivm2z0hnEY8qXkABKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vea80jMh; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5515eaefceso1696798a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759473847; x=1760078647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lxoZhcm+45awcJ5tS0EZt/FOKikJk2GmhaWWoUmXFQ=;
        b=Vea80jMhV3lZj0WeyQxXiBMR6VGAj8ONzNqxs7lMeqipbeD4eduD2cYKpp3iJM6Qny
         PDASaDnwy3A+9MVkyqryjDgeVgxxj0fvpsQV2jnyEsJKLhu88GvPtz2mQ6/uXh8uZ3po
         JKy+hodpqT8Zc7olPTp/W2/d0NGBZ1BOfFQlSZdEZBIPUjmsbLVndIS7jN4fr6inutac
         +cCrfzKslsXPAWE2kFl6q8OFs/MT1MjBs5Uj2cbfZyGqdFVtQ8Vkxir01Jw5qS6ItR3d
         J5reoSzPBS+xbJS7VN0M2Dj6HW9OLE3O9+Tf1Ovsc5jeR5aj+9Ij345+QZ/xpYUmD6kt
         Me9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759473847; x=1760078647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lxoZhcm+45awcJ5tS0EZt/FOKikJk2GmhaWWoUmXFQ=;
        b=QBJFPJu4pe8ayWsQ2lsbEE/dl7xP0P1a+tHFlboIMg93soCPbM5GI0iaczAbpkEGew
         XRzaltXf3dvnDUGGG7TuVMtpakLszx4u0JRhtzOOW7rXF8IQg2z9G/isj0cO79fseJcM
         Y3lrjDZdX7FqK9ysOdsbzBH9OM+ffufbi2bv4LKWoxsAmJI//7scs5S1vsx4qbkldhAZ
         6coPGmSaXPaHIDdTRO28u7zEJymIXD0RHUwMAoJjMHWxvswgjg2iXpSFUZ4C+TkLDy6z
         vzkbRTSpQK3xieW7buQYnlS5OvRlY0TwLBL6HWOTngH0oL6wz+h5svUqJcZDZJFYnF9B
         OUzw==
X-Forwarded-Encrypted: i=1; AJvYcCVEdietWjc72cpXiTl1Bp45GKVRJZOCvis7YBo6hw2+zhDjrcXCcs1oYuq4YeP5MJ4pegPpE6+Imvwin80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdW4+XHzzedjcsMYdRQOlKBXMFY2IxjhN/INU/hyE8633cGfrj
	N1JzpiUvSvGGiArQVRqnGKtKCADks5xXmxnKd3rSwPcqGPtzB8h0ybEw4n2CwRWa9EXA9CeQCO8
	N/nJWFhFzdjhkulai7hEjY+dHtRmAlSU=
X-Gm-Gg: ASbGnctdHVRTCgSsveYtyZ4EqDDaVg97r8P9a0QegFzKY9yE3Ohyrn9rD1zzNM9seG9
	vBb+fw9p9WZZVKbEXJfvfm8m6/IKeonazuEVCn2H65VMJ8owjH7hBfcdMxBW8yjawwo0S5TfjGD
	VTaMk0UsmQ+4lw7UlJJk2KGbpaV0sVvO0CQU27KkNMp6AGU9PzmxkKtWiByxoKTTTJ4OkIj3IhI
	hB63m+ixyh5qL6KvrTusE4rKJJl1GGQ8ntz/yT43meiLsvxvJXIl7W95hsgQEML+kOXebQ06NA5
	La+qNJnbkmdBYUoB
X-Google-Smtp-Source: AGHT+IH7EjoN/pYt2rJ3ou+7MhyHKCK0+9xq28i/uCdlwnAan+AYidcbSeE3JkgMW3BnaAZi4vYMBUXR9jk2WUk4WIg=
X-Received: by 2002:a17:903:38d0:b0:269:8f2e:e38 with SMTP id
 d9443c01a7336-28e9a565f18mr23717585ad.6.1759473846705; Thu, 02 Oct 2025
 23:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002180541.1375151-1-kriish.sharma2006@gmail.com> <m3o6qotrxi.fsf@t19.piap.pl>
In-Reply-To: <m3o6qotrxi.fsf@t19.piap.pl>
From: Kriish Sharma <kriish.sharma2006@gmail.com>
Date: Fri, 3 Oct 2025 12:13:55 +0530
X-Gm-Features: AS18NWALVmSDyc-JP5tcvAszj5MCQYRzNJOCS8DFUVpSMuiDdleIE5xAhDioBp8
Message-ID: <CAL4kbROGfCnLhYLCptND6Ni2PGJfgZzM+2kjtBhVcvy3jLHtfQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/net/wan/hdlc_ppp: fix potential null pointer in
 ppp_cp_event logging
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: khc@pm.waw.pl, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for the clarification.
I can update proto_name() to return "LCP" by default instead of NULL,
which should silence the compiler without changing behavior.
I can send another patch for this if you'd like.

Best regards,
Kriish

On Fri, Oct 3, 2025 at 12:04=E2=80=AFPM Krzysztof Ha=C5=82asa <khalasa@piap=
.pl> wrote:
>
> Hi Kriish,
>
> Kriish Sharma <kriish.sharma2006@gmail.com> writes:
>
> > Fixes warnings observed during compilation with -Wformat-overflow:
> >
> > drivers/net/wan/hdlc_ppp.c: In function =E2=80=98ppp_cp_event=E2=80=99:
> > drivers/net/wan/hdlc_ppp.c:353:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   353 |                 netdev_info(dev, "%s down\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/net/wan/hdlc_ppp.c:342:17: warning: =E2=80=98%s=E2=80=99 direct=
ive argument is null [-Wformat-overflow=3D]
> >   342 |                 netdev_info(dev, "%s up\n", proto_name(pid));
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> It appears proto_name(pid) never returns NULL there. Despite actually
> saying "return NULL", that's right :-)
>
> Perhaps you should change it to return "LCP" by default instead, and
> not only on PID_LCP? It should silence the compiler.
>
> This ppp_cp_event() is called in a few places:
> - ppp_cp_parse_cr()
> - ppp_rx()
> - ppp_timer() (with a known protocol, though)
> - and others, with PID_LCP.
>
> Now, before printing proto_name(pid), ppp_cp_event() does
> proto =3D get_proto(pid), and dereferences it :-)
>
> The pid seems to always come from ppp_rx(). Fortunately it's checked
> at start, and it case of an unknown proto it goes straight to rx_error.
> --
> Krzysztof "Chris" Ha=C5=82asa
>
> Sie=C4=87 Badawcza =C5=81ukasiewicz
> Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
> Al. Jerozolimskie 202, 02-486 Warszawa

