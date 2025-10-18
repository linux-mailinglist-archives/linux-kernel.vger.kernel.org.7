Return-Path: <linux-kernel+bounces-859116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0F5BECD02
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911B51A6271E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35797483;
	Sat, 18 Oct 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFF4qO5v"
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4A208D0
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781919; cv=none; b=O4fsbw+6ziDRKOrPPrHXq0cwfkUibhr9utO9YaIl2o6vlv4HC+G5/o6PcJL1S+TDq0ZQr94SfJN4kndLZASgkjRIniwxJ5VZbTtczGcX5l0sdI5ncvZ83uoVmQ2od2yz2flNyk2eXv7wINAPcIBee4SIZ73bDN1o6wkkq92y1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781919; c=relaxed/simple;
	bh=jILDbtgEGrDjHKsxHXX0Z7pNz2KBcPwl+sHUKqZRRKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o75Kho7SPcfMnwXFmDn7OsYB0RFaJE6PbFTP1OL+YJP+u8nXCVvR8k2qif9LA2m59y+e02FC96GalAqDgTRTMq+maW5dsluhV+6IV6xnwhCVFRqa43i6wIUK+kMAanLCAsQnjlIiOdPMCQvvzaQUsP05Sl6YbIqtOUFHB/X1QMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFF4qO5v; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-36a6a397477so26766721fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760781916; x=1761386716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggNHeadx/yVyQKurytJQB18oAkIN891rfTr0AvhQ24A=;
        b=IFF4qO5vjsFEaAbbw1BZanKcTgRtKoVfgznXA7N343duYlEmYwOqsxojB/F4wk4wtR
         esEtf3sKN5Q9gKaAoALKyZwBixyu77fOii93Fugtw45g8bS4eevkwPIM9F2ECMDtHGzo
         5cCPbIh0Gv4cJJe1EsfesrDnDvnK3R9k4OBCf4NtxR+f2dLh6ylzz5K8b61XqJqXcUjK
         DiTo4mGCaXe1PoXfLViL68OMX/38p4QSVQYNX33rnL1PxkKFtZdm1NsUocnlirGOhiZt
         fCvjjX0iuowgdWmd8O3R9uZT2ib3icf3KZeDL/GWpGYauEZb1FmK/dsV7lddo26QePDh
         mjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760781916; x=1761386716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggNHeadx/yVyQKurytJQB18oAkIN891rfTr0AvhQ24A=;
        b=Ea4M5wNP8prAPNuvieJr3Iext+gK1hCzWo3XfjrGn0n6K1s9Yiibkz9m9DTyEfc3HI
         MQKokUSVOhBfP2UfqptX0oaMCcMqOSnOJDwWAu7OF0bvXWicom0gJ7o5aaFy0Zx9VNP7
         zC0oGqdvBERb5XZSdf6/6BhwLiyidhikIbaAl06of421zJa71bxyiv1YCXy/N3kK03vy
         +YIzzCFxOVkUz2ZRVCYMLTTqG3NtLnKFlxl7b9WMnES1uVT/6AciuSvMqjy5UMJpMpi3
         mUU+XkgjvAfQcVTT8+9spC1uWVY8/6cwOzj00GltovZRRfHISUCYds1kxOS0SB1jVXK+
         aYyA==
X-Forwarded-Encrypted: i=1; AJvYcCXngLUQ/qDfFF8X1rBnpMmdOrt3rk5qfpRKL03DRlcZuGRlPgcRK6aO+mHRT7a1xPkTbKho6kY5uQaUQ5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYfWENpyZd73No5aYjPQS87JbNbY6gf5egqtqoZ3cDX64JHHvh
	cbY+jaxobVj34PBrxhd2mCs4CgJ5kWRdjLKW2yOwbXkNhdrDzi39eIbSZD53apnHxwtrzcvtrWZ
	kbXlDHIoXZoUyXydkR9aOuDtPoWgylyw=
X-Gm-Gg: ASbGncuLDbKocI0y7QQd55kRgtX9LxvPwcbivJrVqd78MPC0GUPvJKFhOF+yQlp7QMU
	BE5tO4g0yy8VfoHMDm21X4IWfvA3myMiIheDyHRV0GnrF6D3hbaiJWJH8pKRVeWOnlZoUZ98CgB
	b0Ch8KD3bF81oN9lB2Aebwjc3DcqpbVCPT+jX5t0GO/kUaOSjn2Ia6lAaMRWnd7Z5q2EHEnBKay
	a3o+EN/jIOJq+yTpqap/f4mRNjh6hymMjTsIXE1+Kdd+fczA2OHOsGTtyhc1ntADdFO4zA=
X-Google-Smtp-Source: AGHT+IHScblRWCo3+/Jkz+NAdGrNeOoTsaOcLasCZZiMglmvRAhrS5MGFRacZjn2a8teO4QOoi32B5GmnOXKY9XQB9c=
X-Received: by 2002:a2e:bcc2:0:b0:36b:ce19:d853 with SMTP id
 38308e7fff4ca-37797a7d1c3mr20823661fa.45.1760781915430; Sat, 18 Oct 2025
 03:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com> <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
 <20251015093037.GA109737@e132581.arm.com> <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
In-Reply-To: <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Sat, 18 Oct 2025 18:05:03 +0800
X-Gm-Features: AS18NWAHkf3xqmS5GJtoX59kNBIpU3xW6dhZJ_FJPAmwFMr--pVGi6SVq85UwHY
Message-ID: <CADHxFxS3kDeSM7NvZHbdoOyqxzzcKeAc1xzr=q_f+T96G9preA@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo, Ian, and fellow maintainers.

On Wed, Oct 15, 2025 at 7:47=E2=80=AFPM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Leo,
> Thank you for your reply.
>
> On Wed, Oct 15, 2025 at 5:30=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Have you installed the GCC cross packages ?
> >
> >  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> >  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-=
cross
> >  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cros=
s
> >
> > My understanding is arm64 cross compilation tries to find headers in th=
e
> > path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
> > distros).  After install GCC cross packages, the headers should appear
> > in the folder.
> >
>
> I hadn=E2=80=99t installed the packages you mentioned earlier, but after
> running the installation commands you provided, I was indeed able to
> successfully build perf.
>
> In fact, I=E2=80=99m currently working on creating an SDK package, which
> includes a cross-toolchain that I built myself using crosstool-NG. My
> initial idea was to install certain third-party libraries (such as the
> packages you mentioned) into the cross-toolchain=E2=80=99s sysroot direct=
ory.
> With this approach, even when developing on different host machines,
> we could simply specify the header search path (pointing to the
> cross-toolchain=E2=80=99s sysroot directory) during compilation, and the =
build
> should succeed without requiring any additional package installation
> on the system.
>
> Based on this, I think allowing users to extend some options via
> EXTRA_CLANG_FLAGS could be a flexible way to handle such cases.
> However, this is just my personal thought and might not be entirely
> correct, so I=E2=80=99d like to hear your advice.
>


Although installing the GCC cross packages allows me to build perf
successfully, I still prefer to be able to pass additional Clang flags
via EXTRA_CLANG_FLAGS, as this approach feels more flexible to me.

I look forward to continuing the discussion on this topic.

Thanks,
hupu

