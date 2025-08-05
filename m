Return-Path: <linux-kernel+bounces-755962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACB4B1AE1C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2075A189CCC4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE8121A454;
	Tue,  5 Aug 2025 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTiE9Y1k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133052135A1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374737; cv=none; b=IgFyUGdcG8+ZJJja/I9NnaEOt9hZ6uJSusFdaTRR1UdBkWk4LRPcBUCBh0Nazrl8sDsyjg+uNaZLuBERZiZGHKMW2HuTBPEe3SHyMxGeCO5NkbrHqBpKB/x81VS2+4lk0kD46/fi/RB7jVZxSWLKlFkdaUB5Tcl0hGw+z4on8q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374737; c=relaxed/simple;
	bh=I74jssdw+SpC/LfqUPup9AmRrmac+MtCVJLk6doKASc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iGndgiFXSJ7gsYrpzNaWT8aeNd3cXp833sleglwSxcoK5IQiZm0nNaDDh4ZoGKi3bhcKQMEba3pr0rC0AnrfdvlbfZ7+PUx0JWm7UYanNRrzJanBmF4W7HgdXWHpFj009rop2RmQqpHdKIsQ1x1+x4WmFzg2ovDQabbqdJe4MyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTiE9Y1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754374733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vJ1eNsgcn/sAni6mkXijStzdoI600KWnpZ9DrmvA1T8=;
	b=GTiE9Y1kP87+0mE+G2qKJmz0Fn6CV9tZNCPt2jtfoG8GIoXclvGz8J1h6jKxOhFd8p8XNJ
	XqgcdiT1GGyFhEaT5+QGil8CuY21llv96BxjaP5CXCklsmYM0Cb342za9K1j9xrMdGNDs3
	mf3wMzaOmesipN/7vzt86pfJjQAu+9o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-hsw2cY3ePHCy7nKdf4Cs3Q-1; Tue, 05 Aug 2025 02:18:51 -0400
X-MC-Unique: hsw2cY3ePHCy7nKdf4Cs3Q-1
X-Mimecast-MFC-AGG-ID: hsw2cY3ePHCy7nKdf4Cs3Q_1754374731
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b081b2a94cso19479091cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754374731; x=1754979531;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ1eNsgcn/sAni6mkXijStzdoI600KWnpZ9DrmvA1T8=;
        b=atW4iA3El7rTd7wiSnfRtQdmlaOIbn4bMkfZ7kGhxyBETeqqCwE4mXjGPBkUfwmst3
         jVDsKAJJUKXx/2jPKW/8cR05fJVgdegSRpphEaeAKlyXW7sGxg5zTB2uBsXv49SXdTlH
         QVwZPtRaCnnk4VHnNpjLp/qzAgsQmB2zapsbuypzzdhPJygYXxAPrNEylC0rA7/nC9XC
         60CnhFbX1S/+IcX5yY0oi5OxKxycbT6gQCbkzDosbru77MEsXqv4wSUumnR3fG7HuAb0
         xXvMZ3+O5a4PLKHKzp4QId0WKCCbtunW71hatgdW1aaIPSMhikVfmqkUxelUwmEOc+Xj
         IyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV96nmYO/ZBjxYEJUxqHArZbP7QU5/SvXn0Se7DT2nIM2iFKhOR9eP1oJet9XryQDCpj7S9WiZ1A/A0Gho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqZrqe1KX079uNz2PefrqUi9sLsiVKKY5o/Pa/DEzbSQPdCC1
	ob1RG1qbmggb8DaxMi2YjUEfiG3f1woI51te0SKtadIE4nrWkDgSQYGHwvoWU9Y59Uq4Wu9dQ/9
	U6TsmjrDO2NSljYxnMmg/AocdZ7CHFIbHh+EvfoTOtwcNHHk6cX+P9S6W40XaZqhDYQ==
X-Gm-Gg: ASbGncvENwYCv55rgbYXB5pvUhpP5Jm6yWmgDmRhdheFid3YAzqMmaZ0GDl5Fde8U78
	eSTq0eauvDa2umd7MQMIjoEqskCSjMFP7NRAxlGjFx5qeSjAgnTJ3Lb0LF6S79wKLddTLRXuwWW
	5AsrDVA9ONDhgeNFBxgBu/SjxJQLgx+5jpn3f6WejRFnEnsxrgcK9ARWxPYG0475L974dm5u1BR
	8H1nNcu0crbDSbqILPAbUgS+wRL7/98ML12l8qQpakf9ZkVrs1QcRHD/aD0rcezKuXUpx7/xiDN
	eBvaC0jOSKaJjwT2ZG1hLV4MAEh+fql34LtL4wkZYOBH4+WG2pwZyAJQO3caZRAn2Q==
X-Received: by 2002:a05:622a:1a96:b0:4b0:8822:443f with SMTP id d75a77b69052e-4b0882245c2mr1837501cf.18.1754374731262;
        Mon, 04 Aug 2025 23:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9eaYCUZBrblo1oRVSbdJ7BzN0HK/JTOAD5cc/KJrR9x6Z1tgaDU/5IdS8zKXHi5VNZgTAVg==
X-Received: by 2002:a05:622a:1a96:b0:4b0:8822:443f with SMTP id d75a77b69052e-4b0882245c2mr1837281cf.18.1754374730790;
        Mon, 04 Aug 2025 23:18:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b076710ff1sm14137741cf.52.2025.08.04.23.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:18:50 -0700 (PDT)
Message-ID: <580bf2db57cefa07631e73e5af453228cfb3cecb.camel@redhat.com>
Subject: Re: [PATCH] rv: Support systems with time64-only syscalls
From: Gabriele Monaco <gmonaco@redhat.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, rostedt@goodmis.org, 
	namcao@linutronix.de
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Aug 2025 08:18:46 +0200
In-Reply-To: <20250804194518.97620-2-palmer@dabbelt.com>
References: <20250804194518.97620-2-palmer@dabbelt.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-08-04 at 12:45 -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@dabbelt.com>
>=20
> Some systems (like 32-bit RISC-V) only have the 64-bit time_t
> versions of syscalls.=C2=A0 So handle the 32-bit time_t version of those
> being undefined.
>=20
> Fixes: f74f8bb246cf ("rv: Add rtapp_sleep monitor")
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
> This seems a little ugly, as it'll blow up when neither is defined.=C2=A0
> Some #if/#error type stuff seemed uglier, though, and that's the best
> I could come up with.=C2=A0 I figure anyone without either flavor of fute=
x
> call is probably deep enough in the weeds to just figure what blows
> up here...

Yeah, this is getting ugly.. I wasn't fun of this ifdeffery already but
a few of them seemed acceptable, if we are really expecting any single
one of them to potentially not be available, it isn't looking good.

What about doing in the beginning of the file something like:

/*
 * Define dummy syscall numbers for systems not supporting them
 */

#ifndef __NR_whatever
#define __NR_whatever -1
#endif

#ifndef __NR_some_exotic_syscall
#define __NR_some_exotic_syscall -2
#endif

The negative number would never match, we may add a mostly
insignificant overhead checking for it but we keep the function
readable. What do you think?

I'm not sure if we can get the compiler rid of it completely, but it's
probably not worth it.

What do you think?

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index eea447b06907..c1347da69e9d 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -127,7 +127,9 @@ static void handle_sys_enter(void *data, struct
> pt_regs *regs, long id)
> =C2=A0	mon =3D ltl_get_monitor(current);
> =C2=A0
> =C2=A0	switch (id) {
> +#ifdef __NR_clock_nanosleep
> =C2=A0	case __NR_clock_nanosleep:
> +#endif
> =C2=A0#ifdef __NR_clock_nanosleep_time64
> =C2=A0	case __NR_clock_nanosleep_time64:
> =C2=A0#endif
> @@ -138,7 +140,9 @@ static void handle_sys_enter(void *data, struct
> pt_regs *regs, long id)
> =C2=A0		ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
> =C2=A0		break;
> =C2=A0
> +#ifdef __NR_futex
> =C2=A0	case __NR_futex:
> +#endif
> =C2=A0#ifdef __NR_futex_time64
> =C2=A0	case __NR_futex_time64:
> =C2=A0#endif


