Return-Path: <linux-kernel+bounces-879904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056BFC245DF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4729A3BBFDA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06671335562;
	Fri, 31 Oct 2025 10:09:00 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408E2EB5CF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761905337; cv=none; b=ACOlgnFgEgc4TsaOGKqKZcpge+lcZEFdxxu+Tfgmi/ZL9qv7mBsH4OnOnLSJzSbbMaZelwWLvdk49hokj1di2y4hd/LcBGhzGr7/YIUDqWWvt4lWbtkRvKhHooD+CeXrS5oAaZ+Tbuasrfp8ktrniSngIYt25WaIgoi0wWbU6xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761905337; c=relaxed/simple;
	bh=GXjp8ZBy18xilUA27OFjILAOQ0YF4cNrnmbDvM8+UwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEpaECOKNMZFn9n753IKq+Z17G9i6aXnLtnoZCeQRjjxGVSLm4ANzcVM/8aAH35qReH4RjbCbNhMB/r8fK5QBaaY0D/6HP+4z1ZHwAdIjuMfagmi4llHxTXPQpuT1bk26bDUOQDjI9+wq+AUndYUmB62XrUKdXo4QMUaH7juvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-934fb15ee9dso759457241.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761905332; x=1762510132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3JTKGjcvpUO09DKaENRtxv+sRC+3x6y4adxr9X/nJ0=;
        b=DraRqzg/gyCWyKCdZWTE9TRSYILFOrqlQvqBxkMXw37djs8vcmSqZ239sIjuMXFa/z
         Xe6bYsJaxgLDokNga9jY4dgjk59KFy6oA5yDjySCl/6lCwQd5fQH5o7aF0HDjS//TEXu
         b3NU8qvgC0IcScdh29SlEeiBycwB725+txBPQAxDU8aTAh2OKVOxz/opxMTXDVFkL8BN
         Fm2g9ktxKb3Q3X7hXfLtKCuiEYsBa+UHIa2bR4moEJYHFYJiPsRIl+bbX7391zIkLtQD
         Q1vcEB4FOYfiLyx5NokJuU12amnvjO8CSpTrY8ha+WsZduxv4mySu0SB94qDkMhPPvI8
         uVjw==
X-Forwarded-Encrypted: i=1; AJvYcCUKT9pkbNK5phaQKZIzco/HWfCORjwNOcpVJKF9+bZhBXbWVqu65Uzz94rTt7iHj/tBqAhvkglSundC//0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4N/U2R+51ttSJEbmx3GynruK8UQszYmNv7o5MssoDvbKgbCkI
	lcpJEqJueQtauZ1rZScMj7WVJQLi5le/TTKvZqfykITEVHIxxZGqneXIQj3hVOHa
X-Gm-Gg: ASbGnctMkFbacFnnI0d1rGceTZwNfgKr8NN3EUesfoZbj7r9i0hMwy/fYNx5IwniE+x
	zoKYsFdjJp+Zgpxs2HDDOJr2b2GQPB9BEZwytY9HZSgQ/1VEou3ugkivPf33471gSzyo7lqPI9l
	aN1NbKpZEYUhTv7xcfi58Hy1GtxfVmVXbqlE9ERQ87Nkv/uUoRhPoJfXROd+UVqXDTfTw+Pbv+h
	QnJV3z+P4XQFgIwNz4+2bqRwITEKdsleIPNz+JT0/8cBgTHSPlDhOh5LOsg30GcroIIr+1qvBzJ
	21hXefIoExSbrPc1HtMtQIEmuoR/+rF3j8JL+GmK1K7okXwu2giIpOSGwYRXJ0CaZDDZLxWBalV
	Jw5uFJ9yjG4pCoQRHDmizJBY+D2rMG/B291OEoAmz5xN8CkagDPjadGkCSyJgT3HSGQdTO7q/dW
	aNk9CQm1jaMgZxBjFiiOK/bGd3QPwaBn7m9UeNhQ==
X-Google-Smtp-Source: AGHT+IHIvYEGk6clj0ZLX43Pm1NtxkkOH9i/TOVOgvfnH3sBeOt3Wp8kpFm7sINpK5FAp9EDgeM9mQ==
X-Received: by 2002:a05:6102:442c:b0:5db:3bbf:8e62 with SMTP id ada2fe7eead31-5dbb11f0c91mr725539137.1.1761905332294;
        Fri, 31 Oct 2025 03:08:52 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55944b612e1sm488489e0c.16.2025.10.31.03.08.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:08:51 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-934fb15ee9dso759438241.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:08:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMKbQn6l96kR9BS3WB4B8u7A8elnmKjILW1xcVOg093oelyd162i614MWh64/3IvLTc/4kIGkcFJEBK3Y=@vger.kernel.org
X-Received: by 2002:a05:6102:6216:20b0:5db:b35d:abcd with SMTP id
 ada2fe7eead31-5dbb35dac5dmr303555137.8.1761905330752; Fri, 31 Oct 2025
 03:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2fa899eb-60b6-4637-9035-aeff78e261fa@web.de> <CAMuHMdX-uKt3-Lb2NaxmONEqWdtFgTOqXEo1nOfGq-R8ysHfcQ@mail.gmail.com>
 <33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
In-Reply-To: <33199802-d83d-48e8-9032-f1c4c61cfee7@web.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 Oct 2025 11:08:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXL+YXxwAM+HkawzTMxL2ez5O4bQ-j-LCCXTjz=NoLOKQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmfYw_9WSYikEEtVKPAs2-VGkHCdHdb26XN5HT-568_sb09UKD7rIRpQBo
Message-ID: <CAMuHMdXL+YXxwAM+HkawzTMxL2ez5O4bQ-j-LCCXTjz=NoLOKQ@mail.gmail.com>
Subject: Re: [PATCH] sparc: time: Use pointer from memcpy() call for
 assignment in setup_sparc64_timer()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: sparclinux@vger.kernel.org, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Andreas Larsson <andreas@gaisler.com>, 
	Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Finn Thain <fthain@linux-m68k.org>, 
	Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

On Fri, 31 Oct 2025 at 09:46, Markus Elfring <Markus.Elfring@web.de> wrote:
> =E2=80=A6>> +++ b/arch/sparc/kernel/time_64.c
> >> @@ -760,9 +760,7 @@ void setup_sparc64_timer(void)
> >>                              : /* no outputs */
> >>                              : "r" (pstate));
> >>
> >> -       sevt =3D this_cpu_ptr(&sparc64_events);
> >> -
> >> -       memcpy(sevt, &sparc64_clockevent, sizeof(*sevt));
> >> +       sevt =3D memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clocke=
vent, sizeof(*sevt));
> >
> > IMHO this makes the code harder to read:
> >   - Only 0.15% of the memcpy() calls in the kernel use the
> >     memcpy() chaining feature,

It is also less clear the passed size matches the destination pointer.

> I obviously propose to refactor this implementation detail.

Oh no...

<other-bad-ideas>

The above function could be shortened by writing

    (sevt =3D memcpy(this_cpu_ptr(&sparc64_events), &sparc64_clockevent,
sizeof(*sevt)))->cpumask =3D cpumask_of(smp_processor_id());

And after introducing a variant of clockevents_register_device() that
takes the cpumask as a parameter:

        clockevents_register_device_with_cpumask(memcpy(this_cpu_ptr(&sparc=
64_events),
&sparc64_clockevent, sizeof(*sevt)), cpumask_of(smp_processor_id()));

</other-bad-ideas>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

