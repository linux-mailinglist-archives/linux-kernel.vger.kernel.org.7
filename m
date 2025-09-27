Return-Path: <linux-kernel+bounces-835074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E93DBA631A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E33D189FC24
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A923278D;
	Sat, 27 Sep 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8F8DSCW"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BBF1F12F8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759003623; cv=none; b=UAY1oFLYZuf14DWDP/By9KbInJ39RLlWHEV8uzPdRRfqTro0yFhWNOZe3Xqo8hpQcdGFeFjtoxT4NHI+tcWxEM6ovKGS2Vk5fBJcQS/1VIbu5Vr1MQFhtdoBLrjkH60jp04al116eJGp7ord8tRwVevFbxrd+6nU1MJlVqGQXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759003623; c=relaxed/simple;
	bh=HL8OHm/tOdgmn/uUV1BO+N8G/bzT1Rw1z+XhcpcLJZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMfuq3LeRwD3fwtzfGWBxdrKhkSOjSWWlR1fzELSyMRM0WQ9ypCsLeEPktGUZDrBqDFXBcbTmRhT7jEQYXkGPqNmsdXo99YmTdlFRPRl92ccOul/zpnD2aMCBnubk+yFx+CoXWxGJy9SRW01hKZSgpNNS0LsLb30TYpA2CrvMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8F8DSCW; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5a392946c4aso1849497137.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759003621; x=1759608421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HL8OHm/tOdgmn/uUV1BO+N8G/bzT1Rw1z+XhcpcLJZU=;
        b=C8F8DSCWRsu4MnphxBHgTsYDsFAv21o942Or2IuRuNLVSEWc0MAP3XMU9CfWDyAdq8
         QFA1iYJ+yaypLLomEUa17hR91kJW2zTRlCMEm/oTs9x2niTOGJSDwlfIJDfUAiKEagos
         r7JtHl7Dw6+7PSqAb9Ad6SXNmhO/K7qeKD1vUNdda2cEpqKODl09mc8l2IuaC1WPdOv1
         ghAQCqt5CAlhkQqkb+FFaCFojBKmj/zF/Qpm/FIyTUfrZwvi1r6ttswG1kFI6pA7vQba
         Q43vaMMKaSkCtbw/ME4QUw0QcjVKEYbFohbxuL1Vf3kC9bNmtAYOdTARKrjTn0npiF4E
         k/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759003621; x=1759608421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL8OHm/tOdgmn/uUV1BO+N8G/bzT1Rw1z+XhcpcLJZU=;
        b=Txl+W/MK2r0hHqyeZur1WH/olApFD7THsfcfctdKNHn8hymisk0V8vXL4dxsSJ01mx
         iGClqC8Mj/2IoHSS8MET7RXITBYHBkBuwGQYle9wQomepTV+yYLQWmsSbrHjjLjSaBSk
         K2CFEGkm0g2YB8TB0v3ER+3ca9rdwtykiyOW6E0egwoo9F2cGLVVKPAHfzkCIwVmJazU
         g/6jp1hKyN5CsFsZ5lQxhXbJYDFO0VJW27h64Iv3tvjbR8+cTFnTQGdYCDboV0unZNyY
         IaWzRR7dcfQowR2NiOq4WremEStcHWRWb7vTriGYLNYOKrxQjQK/ttO9l4CXXyOcl6wf
         ooZw==
X-Gm-Message-State: AOJu0Yyn0j7TDxMAUmBU+X+o4KpzBIKJtLz/0zm/ss98rQj1o1//+sUv
	THWMKSHm3eIyeXpi6MsH2oW3vNRUgH3fttlgxcK34EUHgzKvxvfeXJvGYGO9QUgX2vA4F4Qvul/
	2qCbInnZs0SmkaAmd1U3CQRjsPG/emJw=
X-Gm-Gg: ASbGncsRy/o/HNoF6oAM7fwGBQR3GvSl84X1UGzUD4oYIeSxmtkfGAC9fFWplPHnEbS
	C7Wvcegs9WVUYrSePTHMGi3GbaWRVdBctKXLk2m1bCKYhNardUKY4V2ORMVJoKQgCI8Ylgcz3G/
	nGBrOq7cLoC3khfiIty0WfmsJjTVM0ASLVuKzPVZ/kZgYT3WsLouUY9tyzkdfpxnMq9KQunSwXn
	wVg554DsMYR8cXyxN3CD5mPS9xNC+h5mEhzFcRVxveISqsE/BU=
X-Google-Smtp-Source: AGHT+IFavD4z1GGoEGlY5lI3JUX612+I+UAMojZazeqkDP6BSDuGvbpnL+RUoY1IBixIMQhPSpIruVr/5IWa60JA5b4=
X-Received: by 2002:a05:6102:304c:b0:55d:b35e:7a58 with SMTP id
 ada2fe7eead31-5acce758205mr4579967137.23.1759003620680; Sat, 27 Sep 2025
 13:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com> <BC25CE95-75A1-48E7-86E7-4E5E933761B8@flygoat.com>
In-Reply-To: <BC25CE95-75A1-48E7-86E7-4E5E933761B8@flygoat.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 27 Sep 2025 13:06:49 -0700
X-Gm-Features: AS18NWBOT7tF0SL4tkvmWuhGCT6OBGfRbzY0O05dFjAR0c0T2kS4_McGk5cJnbk
Message-ID: <CAM_iQpWB1Jq88qDd+z7j+y1fEBRtV86LVHneLemHdvq28g5Dag@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxun,

On Thu, Sep 25, 2025 at 8:48=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> > 2025=E5=B9=B49=E6=9C=8819=E6=97=A5 06:25=EF=BC=8CCong Wang <xiyou.wangc=
ong@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > This patch series introduces multikernel architecture support, enabling
> > multiple independent kernel instances to coexist and communicate on a
> > single physical machine. Each kernel instance can run on dedicated CPU
> > cores while sharing the underlying hardware resources.
>
> Hi Cong,
>
> Sorry for chime in here, and thanks for brining replicated-kernel back to=
 the life.

I have to clarify: in my design, kernel is not replicated. It is the opposi=
te,
I intend to have diversified kernels for highly customization for each
application.

>
> I have some experience on original Popcorn Linux [1] [2], which seems to =
be the
> root of most code in this series, please see my comments below.
>
> >
> > The multikernel architecture provides several key benefits:
> > - Improved fault isolation between different workloads
> > - Enhanced security through kernel-level separation
>
> I=E2=80=99d agree with Stefen=E2=80=99s comments [3], an "isolation=E2=80=
=9D solution is critical for adaptation
> of multikernel OS, given that multi-tenant system is almost everywhere.
>
> Also allowing other kernel to inject IPI without any restriction can impo=
se DOS attack
> risk.

This is true. Like I mentioned, this is also a good opportunity to invite
hardware (CPU) vendors to catch up with software, for example, they
could provide hardware-filtering for IPI via MSR.

If we look at how virtualization evolves, it is the hardware follows softwa=
re.
VMCS comes after Xen or KVM, VPDA comes after virtio.

>
> > - Better resource utilization than traditional VM (KVM, Xen etc.)
> > - Potential zero-down kernel update with KHO (Kernel Hand Over)
> >
> > Architecture Overview:
> > The implementation leverages kexec infrastructure to load and manage
> > multiple kernel images, with each kernel instance assigned to specific
> > CPU cores. Inter-kernel communication is facilitated through a dedicate=
d
> > IPI framework that allows kernels to coordinate and share information
> > when necessary.
> >
> > Key Components:
> > 1. Enhanced kexec subsystem with dynamic kimage tracking
> > 2. Generic IPI communication framework for inter-kernel messaging
>
> I actually have concerns over inter-kernel communication. The origin Popc=
orn
> IPI protocol, which seems to be inherited here, was designed as a prototy=
pe,
> without much consideration on the ecosystem. It would be nice if we can r=
eused
> existing infra design for inter kernel communication.

Popcorn does the opposite: it still stays with a single image which is
essentially against isolation. In fact, I also read its latest paper this y=
ear,
I don't see any essential change on this big direction:
https://www.ssrg.ece.vt.edu/papers/asplos25.pdf

This is why fundamentally Popcorn is not suitable for isolation. Please
don't get me wrong: I am not questioning its usefulness, it is just simply
two opposite directions. I wish people best luck on the heterogeneous
ISA design, and I hope major CPU vendors will catch up with you too. :)

>
> I would suggest look into OpenAMP [4] and remoteproc subsystem in kernel.=
 They
> already have mature solutions on communication between different kernels =
over coherent
> memory and mailboxes (rpmsg [5] co). They also defined ELF extensions to =
pass side band
> information for other kernel images.

Thanks for the pointers. Jim Huang also shared his idea on remoteproc
at LinuxCon this year. After evaluations, I found remoteproc may not be
as good as IPI. Remoteproc is designed for heterogeneous systems with
different architectures, adding unnecessary abstraction layers.

>
> Linaro folks are also working on a new VirtIO transport called virtio-msg=
 [6], [7], which is designed
> with Linux-Linux hardware partitioning scenario in mind.

I think there is still a fundamental difference between static partitioning=
.
and elastic resource allocation.

Static partitioning can be achieved as a default case of dynamic allocation
when resources remain unchanged, but the reverse is not possible.

Hope this makes sense to you.

Regards,
Cong Wang

