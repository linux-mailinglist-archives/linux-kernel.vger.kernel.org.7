Return-Path: <linux-kernel+bounces-721119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAC8AFC4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0070F7AEB1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C2519E992;
	Tue,  8 Jul 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cFEcL9Qh"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB6828724C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961782; cv=none; b=cDysCYnQbsBiRaUBZUpHqsxhAkKW+x+H/bRRoGD7mIF+pstn5u8vn3cpHr7giANPHvgtkK8E6rsjUv6u7MrbaElitOiLKulzI7Eu1eSizqWZKAhuSbNK6mI27dMHXLes8JLUskZI2nG9iNM7QbxHQVpJgnlTL2EdLOeHxmhXbPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961782; c=relaxed/simple;
	bh=BYX2nKw8V8H9vqiU/XTUcWHzYRV0LYBrsdNAvHDZ+P8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEOpJfEf8/lKPBjOCzdsYjGNEfhM0iw2EdlrnNCBRetkNEwvVb4wmh4KoJeECvUejcGlvUtV/IF3VoS9fQTePO61tOaMHh75camsMHk8r602dnyo1bAZC831y1ll17lg+IIya6d3oDAe2tZDwXbpZjRJjQUokJBpNFBiu29N/WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cFEcL9Qh; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a818ed5b51so31065881cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751961780; x=1752566580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYX2nKw8V8H9vqiU/XTUcWHzYRV0LYBrsdNAvHDZ+P8=;
        b=cFEcL9QhPreK03FJp85LGP36od+UoZlqG5lI/nP0gB2lGwAWFnBm++xYmG7gxUUYcr
         vbhvY4RwxkRTDOzWuWq/enwZGw0ykAE4MBrz5kGKHW4YzoEwZRt3kRzdV4a7nUCzbYEd
         p+P192OLWib1/j+J4GiSjmEwOsAm/1AatC1h0GDkm6WtTh/QcpDbTcTQ7Dq2mqi0wYka
         4d7y3c+uVP02f7U7f6H4H5Xph6Y9aSck9kSuSdV6KTkRdpRLV3hbMEgcZQ8NmsApk5LP
         hnhwn1BzEuGCOKc8rmmetsQGIHj7xwzj1mG4pxwTksF1SqNCJNW7rg5Dog1ZHjuoB5Vh
         Z0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961780; x=1752566580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYX2nKw8V8H9vqiU/XTUcWHzYRV0LYBrsdNAvHDZ+P8=;
        b=DWtLSYutmT6mS4P+XcvdeGyWlqUc+7kzEXNhHtIpnRZumUvU1Un0x45JtVaCE2tbbY
         01SaZiK7W/UvpQ6ganaB6u65eVZUhsvTgYisw8cJtz5lULYTF1gQLI2NLrFFmd1lTYX0
         7B/0B2ZZRZeJEjdYbIQHYIUdHxyMK0fU3s+2zHNiCQHHEuE1U78GgyC2H10i9ddhONQa
         OmvZ0V4aiKX/1abEnq4eAsinz4QD3SlIbkm11K6fQT8fmFjfj+yAngsd+dRUqz4micpZ
         IUUi5FZgLOsg/bH7msN2X1D2TKl3qGxylIYyaXDEdN077M1Sh1g0mC2VWFkJ5wlvVmQa
         iaWg==
X-Forwarded-Encrypted: i=1; AJvYcCWgkOpeJ/cJiqvbJ4YTqqE0qy4zo9agJschJqKXzYo5daFeIbsEuIV9r1+MkyPBD7Gl6Z+uB2vOukO7Gi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZfBk33UVF7ZJz/R9NQFQ3UUxKqV1MJ5ov04unDaXA9drvTwN
	bMjCAaGjiQa5+bsxQWmK0jysaRYWMTIYOMFRnGQ4l1NNOvrfrkkUCx7tFdCdrOX5pPcujz00hXd
	RPK45ZsUAw6KWC3UnCckx52btmTMcoSR6c7KtfRnuf8OCr6DIYzy8Dz92
X-Gm-Gg: ASbGncsx4gsxb4quxghhFWKvqizGA6Db5DuS0bJ8Wy6y+gTU3fIk/S2dR/Rr9eQnbO/
	MudiGGZXh0agapkAmMFF/SioldezOC499w22rP1YtPoZtn7paeoS0euXWi6fJYM+dZnHR/2t7S3
	auRqgO1uzXZMPZP95EXsa39BJeNldFeqyst4KVhXykxPc=
X-Google-Smtp-Source: AGHT+IFOm/hoK8xA+2yvFbXSCCAzHPZ+sPNLb33EdBRk3X7TrVVP1viWYkerVhornPqbNaQVP3obbbaW2qn/ZYkLjsY=
X-Received: by 2002:a05:622a:11ca:b0:4a7:62da:d0fc with SMTP id
 d75a77b69052e-4a998692482mr204480061cf.12.1751961779405; Tue, 08 Jul 2025
 01:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALm_T+2rdmwCYLZVw=gALPDufXB5R8=pX8P2jhgYE=_0PCJJ_Q@mail.gmail.com>
In-Reply-To: <CALm_T+2rdmwCYLZVw=gALPDufXB5R8=pX8P2jhgYE=_0PCJJ_Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Jul 2025 01:02:48 -0700
X-Gm-Features: Ac12FXymQQhYAGhjIWe-pEhGq4VdaeDatIELFoZWKE-dIJxatFkR6SO2JgRZscw
Message-ID: <CANn89i+7m8koanZk=47FEhmTHUmOmu-yfViRPayjUct+voQiEQ@mail.gmail.com>
Subject: Re: [Bug] soft lockup in neigh_timer_handler in Linux kernel v6.12
To: Luka <luka.2016.cs@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 12:54=E2=80=AFAM Luka <luka.2016.cs@gmail.com> wrote=
:
>
> Dear Linux Kernel Maintainers,
>
> I hope this message finds you well.
>
> I am writing to report a potential vulnerability I encountered during
> testing of the Linux Kernel version v6.12.
>
> Git Commit: adc218676eef25575469234709c2d87185ca223a (tag: v6.12)
>
> Bug Location: neigh_timer_handler+0xc17/0xfe0 net/core/neighbour.c:1148
>
> Bug report: https://pastebin.com/06NiBtXm
>
> Entire kernel config: https://pastebin.com/MRWGr3nv
>
> Root Cause Analysis:
>
> A soft lockup occurs in the neighbor subsystem due to prolonged
> execution within neigh_timer_handler(), where repeated neighbor entry
> invalidation and associated routing operations (e.g.,
> ipv4_link_failure() and arp_error_report()) lead to excessive CPU
> occupation without yielding, triggering the kernel watchdog.
>
> At present, I have not yet obtained a minimal reproducer for this
> issue. However, I am actively working on reproducing it, and I will
> promptly share any additional findings or a working reproducer as soon
> as it becomes available.
>
> Thank you very much for your time and attention to this matter. I
> truly appreciate the efforts of the Linux kernel community.

Please stop sending duplicates, and 'analysis' AI generated.

If you really want to help, please provide a patch.

Thank you.

