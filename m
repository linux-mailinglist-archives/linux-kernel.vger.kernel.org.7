Return-Path: <linux-kernel+bounces-734875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FA2B0877D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D45A43D81
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B76D277CA0;
	Thu, 17 Jul 2025 08:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JakZ+thl"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059F21A436
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752739390; cv=none; b=Cpq8JP/SmE1pHqUyTXHF7jqfXj9enEI1OpokWjKSACigimw+wxNE8mx3qYkgTMrmsffUrnQyiTZc0XeCg0um8Td1hIv9FWsfhQAPDu50rfxBQq5bV/k/RnOJW33D/huD0kfOZMfMYrtam+T7YoMrU4Q+FKhSSxeh2Lnf75zDaH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752739390; c=relaxed/simple;
	bh=UvqTp2Zne68B8LzixST7+FuqQVUNyNbaJiuvHRRCg6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XfUT2S1CJCPQSP+Mu2UooJGhJLXolXxiG/6YVm5YjcFQ/A4wstHpjaU/Ii0e0wWARVdLzUBheefzx8r6Z88hFAUnkrY2hT9iz2IrYx4Hvvu/bxCy5TxVWrVfm99U7OfqW4CdVj3sKnYVL28L60HY3lJRE3gdI4jeRB1amqs+lMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JakZ+thl; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6fafd3cc8f9so10916826d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752739388; x=1753344188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvqTp2Zne68B8LzixST7+FuqQVUNyNbaJiuvHRRCg6w=;
        b=JakZ+thl4WFOEf23k4eyxrDSVrTcjfwI4rNjmgMsZgYPlni4APQ6BVelusv1oDGOx6
         X4NEaKxhAs+ZKamnQv0HcA8Hna26Ot5I5bW/M4YpuntbYYd9KgtD6YqbEHRmtboLaBIj
         CR4s35MbCa8FMzWQANUtnuPWx8tx1kJRHdLErP61oa0EBHXnQcel85zePUw5kN2HDrc7
         SPq8TO77w86w4257/47Mt0pGj7k3xdXv+UqSS2MkmktZdUUvCokrLOGlG0ip5IyTOujI
         VBzWDHRsXQaKmrFw42AO1W4Q2RzOO/uM7qb7ZixhWejTEZjPdSVPSYLB5QylpUU+5w/4
         ajOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752739388; x=1753344188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvqTp2Zne68B8LzixST7+FuqQVUNyNbaJiuvHRRCg6w=;
        b=P8NYKjx9K+me2ikafrfj9xnJhxyQfa6M4a7HdsQctfiNfMyFuKzPDNnBXUCRv8/7o3
         Plrh/Muy4rpqcWx4e9as0LdEhg6miowCBj/4V9RhxpgY3SHNMk++vTkDCN0utSpnMJdO
         wOo1K+tTprAGCWXsMBm/6ROFcugZyv0hV2TOwke+pKCzzUBRrGJLJFWcoHfhL28THVJE
         1mMOKC4vrQOh9CAWdB5N5MfVsvk38V2MBjISdnFTLZDV+j9psrgd76SPexk//0EoAzYQ
         8XLZ48aC13IdTALRGe+m0s1DHB95H8d2/R3jTMWbWplAbO2eUWqspRQI5ULZif1uRSwX
         tz0w==
X-Forwarded-Encrypted: i=1; AJvYcCVYGslHVeRrEir93bo8f7n1KNsK+lE7vqndM6ooXBKqoEEr+ncZGcRNJxECIRQ0jpad3KZFNGGDTIm05hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjlaG9c3dU553osVsJE2IbjadAg6vdL1nhQdGk+MhMU3rjO5S
	Dyj4QGkfintSfeuWCyDGhoqO+yoAe3cWNLGu3OfHISLQl/y3FlPuD8coPDeYPOAaSPp81kdx8F0
	Nkg+TWXbP4RDS1N23O6bdX256R16aQ+lhE0vYL3gM
X-Gm-Gg: ASbGncstQm8+Fr4GH/sbIFwn+pZQjyBLxi35r1qsNg19GqAav6fhJF6CV+8FZHStpCB
	S6Q2/BakcV8Po3LNH+VLU3Gd/ksA3LxxAGESF6ym+BUgNyn6J8aDMleH0quTMkxg1yKmeCulTLB
	OaGJw7V5DbgaMxNmFMGrxB4t2JEyPHxkJFNsFs+U+BUKY3stYq/vKDT2At53dOr1tt+6u6T9+nK
	ZlVSEK56Nq6y3HPS2mLYl9cT6Q3QajfsgmRNQ==
X-Google-Smtp-Source: AGHT+IGhEmW+51RpWERFLvt+dUAQEioadtTE9UYDule4uqLjt9tBB5yKwNCvK29gmiFBj4QoIaBP+Xpji8FKv47NtPk=
X-Received: by 2002:ad4:5d43:0:b0:704:e0a9:f815 with SMTP id
 6a1803df08f44-704f6aed334mr84550186d6.10.1752739387636; Thu, 17 Jul 2025
 01:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717024834.689096-1-sohambagchi@outlook.com> <CANpmjNOu2bqqevOcPGmZR1Dp69KFY9-TW3i2i_37BCTcE5rYSg@mail.gmail.com>
In-Reply-To: <CANpmjNOu2bqqevOcPGmZR1Dp69KFY9-TW3i2i_37BCTcE5rYSg@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 17 Jul 2025 10:02:30 +0200
X-Gm-Features: Ac12FXyzyEXffumt-s4OhbkbAxba49Fj3GMtu0oU4c_K0t_UFxZZ3n-qtDrjZ9U
Message-ID: <CAG_fn=VXnaMitRFpxP0Fjy=vWF+rjRfZ0TRsziwKzEVrArXt7g@mail.gmail.com>
Subject: Re: [PATCH] smp_wmb() in kcov_move_area() after memcpy()
To: Marco Elver <elver@google.com>
Cc: Soham Bagchi <sohambagchi@outlook.com>, dvyukov@google.com, andreyknvl@gmail.com, 
	akpm@linux-foundation.org, tglx@linutronix.de, arnd@arndb.de, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:16=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> [+Cc glider@google.com]
>
> On Thu, 17 Jul 2025 at 04:48, Soham Bagchi <sohambagchi@outlook.com> wrot=
e:
>
> Patch title should be something like "kcov: use write barrier after
> memcpy() in kcov_move_area()".
>
> > KCOV Remote uses two separate memory buffers, one private to the kernel
> > space (kcov_remote_areas) and the second one shared between user and
> > kernel space (kcov->area). After every pair of kcov_remote_start() and
> > kcov_remote_stop(), the coverage data collected in the
> > kcov_remote_areas is copied to kcov->area so the user can read the
> > collected coverage data. This memcpy() is located in kcov_move_area().
> >
> > The load/store pattern on the kernel-side [1] is:
> >
> > ```
> > /* dst_area =3D=3D=3D kcov->area, dst_area[0] is where the count is sto=
red */
> > dst_len =3D READ_ONCE(*(unsigned long *)dst_area);
> > ...
> > memcpy(dst_entries, src_entries, ...);
> > ...
> > WRITE_ONCE(*(unsigned long *)dst_area, dst_len + entries_moved);
> > ```
> >
> > And for the user [2]:
> >
> > ```
> > /* cover is equivalent to kcov->area */
> > n =3D __atomic_load_n(&cover[0], __ATOMIC_RELAXED);

We shouldn't probably suggest the users to use relaxed loads either.

> > ```
> >
> > Without a write-memory barrier, the atomic load for the user can
> > potentially read fresh values of the count stored at cover[0],
> > but continue to read stale coverage data from the buffer itself.
> > Hence, we recommend adding a write-memory barrier between the
> > memcpy() and the WRITE_ONCE() in kcov_move_area().
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tr=
ee/kernel/kcov.c?h=3Dmaster#n978
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tr=
ee/Documentation/dev-tools/kcov.rst#n364
> >
> > Signed-off-by: Soham Bagchi <sohambagchi@outlook.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

