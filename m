Return-Path: <linux-kernel+bounces-861315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F8FBF25DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29393ABAEF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D528640C;
	Mon, 20 Oct 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci+iD7PV"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE551F875A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760977052; cv=none; b=ax/slsLMM1PUda7z2t94O7lm7vHJkwHUA96uBBFiEd233Fb4LB8gY7jHbyYzBqeOhl3Jgr2mh9G5BlUm1Dn1egKYsfEfMC/wnr9WHpZFfFZNeNGzm4hxeOQ5zGIgFEWpVgw2BE/l4kaXFHOdKjD+gIFaaxFGUb9V3E7F7W4ccQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760977052; c=relaxed/simple;
	bh=ULurqNgTjIRm8jXItaQmTq6l/zmGPnpuvlJ/4FEyZY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3HqRZR02X3neMZFv+F/SdPTHnu4aCf6mua6Egbju2ZAxw3WG/vC7HbjciL/27Cvo4UrRoTETBka7jJVyySn5lBzAyIPw7ECRe/OsHjqLK/e1vWC9Le2kFOKpustYTzeldoInbp6nkid/NY5TxmXtVt6g6chlyCJN+oj783JA5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci+iD7PV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so3995070a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760977051; x=1761581851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JV3ElJ0PE7M/5axYF+HEhAt8OP699X7xWQsv/feFME=;
        b=ci+iD7PVtHiBERs6XyLwgVIb02uilqDcfkFSgew8sk8cTVqVbeNWfDswWGeOJk0B94
         Nf1vB3cn8gLn5dLQ9xjq9YbMXDcV/14b1LvmSpn2D3lfIRPrqyyxlQQ2aYHwnUYNRjgQ
         7wuDczftRGd/q49WTl15/dRkuVPsaLgUjg98kXBt75kHR4WmUhrucMEWg4pJ/jLKaCk5
         NnqixYopplIu9mzLvMMU5sjJljhYALekZGNQI6M7ex7XcFvKeHaK8PqukbAWMzJ5SQ17
         +maN4LRWYUxOqSReG+FHCI05EsafguMn5BRJWgWoqVW882/vp6kXcw7P0Fnf/cnWATXY
         yWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760977051; x=1761581851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JV3ElJ0PE7M/5axYF+HEhAt8OP699X7xWQsv/feFME=;
        b=T2TblErE9k4+n3jW4ZBeU0+4rHZpI+dL6Bg7R96Nq2obbCae3KcVfGQeVBZoVWhikq
         pIVKnTkr/MzYEWpKWyMAYQzDdTGuG8YxLyYEVb7Vhbb3WqsCcaBTbY9cje09dgvHBvOo
         xPMGEstawnJgTkieoLKT4oYOBSvHC7MvcNW6MNCHC6oemmG7dxXPHzntXaYZv9lLL4SU
         ERwlsZ5/JPtwAkg/sZ3gbQwo5k0UUzRwa9ovEAre54zFMuESreqglriPJ+O9P6XrlWK4
         BuxMTo0BqS9Hj0Sccytso2WSR8ECke2kgEd+K3XAixxU9eN1NY/WJyoqxXdbSGQ65VUj
         YcoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXViYA/IhgKt83x0JDbgnVAq+yjl2rqMJmi1xuH+7CMJ/JvU2+4O3HDAiOgQQSoH+yFxFC2mvk7U+M+Hj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QEGMEybJo0OZx3ju+76SFqsNJ1cNEVt2JikL33Dsrc/bZWd9
	1Mj0GvYIvfrI9FssUXhgmybG7Zl9g6/ZRGeysmVs9p3DjsVJSME+NAzTC/pAqaaX4ey9Foi9+5z
	rNlRW1b9P6rYRi5i7kaY2CPDl3SPKo30=
X-Gm-Gg: ASbGncs+9SUbE3NHCjO36DgEsjg6ZeBFWXRnh9ziOcGPqrKfzTvTxIh2p0uTPhWCyB7
	FYyPZcW0Zaiog2DWEg+dmP6TLzHjW0y2v+bBixksRogzk0LenzSCRCf3gMsT4cOXeeX/Z4ZtnTB
	wTANVgJhW+iUHMYOHJV7Jt+q6Bb6VRmyW6VHhvrTy0lTuPk3Ox5m/sE6DXN+BvO/1HLEWwzL+mQ
	vM1MgCAni6s+igUXaJe8tISOgU7j1JQhdLFYdCpQc+mJwEBpTjUYjXH149RNX2KAiXbJ/WYmfJq
	4CrSTlyxAmk=
X-Google-Smtp-Source: AGHT+IGbh3vIY6677DF9brRXSRdqlbWv3B0n8wxI06Wzk1E/BOpWWUwdp56dVrMID+U6pR7TEAzyQ0+fm4lNYwaxZ54=
X-Received: by 2002:a17:903:138a:b0:290:567a:bb98 with SMTP id
 d9443c01a7336-290cc6da1fdmr167710265ad.57.1760977050441; Mon, 20 Oct 2025
 09:17:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQ+pXhEsumx6NapCU0sCJw9vdB3TdLMLtCoHa7_sqCRH1A@mail.gmail.com>
 <20251019223006.26252-1-nooraineqbal@gmail.com>
In-Reply-To: <20251019223006.26252-1-nooraineqbal@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 Oct 2025 09:17:18 -0700
X-Gm-Features: AS18NWBGqjFbbLYWqoMHdvc1S5PFT_whCkYbB4vjL2fGXEzy9hWRYir83-8Tb60
Message-ID: <CAEf4BzbtzHsa8DASzOg-Xqp8_-vG5ekC7JXhwuyZqPhrckU1hA@mail.gmail.com>
Subject: Re: [PATCH] bpf: sync pending IRQ work before freeing ring buffer
To: Noorain Eqbal <nooraineqbal@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, david.hunter@linuxfoundation.org, 
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@fomichev.me, 
	skhan@linuxfoundation.org, song@kernel.org, 
	syzbot+2617fc732430968b45d2@syzkaller.appspotmail.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 3:30=E2=80=AFPM Noorain Eqbal <nooraineqbal@gmail.c=
om> wrote:
>
> On Sat, Oct 19, 2025 at 1:13 UTC, Alexei Starovoitov wrote:
> > Why do you think irq_work_run_list() processes bpf ringbuf in
> > the above splat?
>
> In the syzbot reproducer, GDB shows that when bpf_ringbuf_free() is enter=
ed
> the ring buffer's irq_work was still pending when the map was being freed=
.
>
>     (gdb) p rb->work
>     $5 =3D {
>       node =3D {llist =3D {next =3D 0xffffffff8dc055c0 <wake_up_kfence_ti=
mer_work>},
>               {u_flags =3D 35, a_flags =3D {counter =3D 35}}},
>       func =3D 0xffffffff8223ac60 <bpf_ringbuf_notify>,
>       irqwait =3D {task =3D 0x0}
>     }
>
> Here, `u_flags =3D 0x23` indicates IRQ_WORK_PENDING and IRQ_WORK_BUSY
> are set, which shows that irq_work for the ring buffer was still queued
> at the time of free. This confirms that `irq_work_run_list()` could
> process the ring buffer after memory was freed.
>
> On Sat, Oct 19, 2025 at 1:13 UTC, Alexei Starovoitov wrote:
> > Sort-of kind-of makes sense, but bpf_ringbuf_free() is called
> > when no references to bpf map are left. User space and bpf progs
> > are not using it anymore, so irq_work callbacks should have completed
> > long ago.
>
> You're correct that normally all irq_work callbacks should have completed
> by the time bpf_ringbuf_free() is called. However, there is a small
> race window. In the syzbot reproducer (https://syzkaller.appspot.com/text=
?tag=3DReproC&x=3D17a24b34580000),
> the BPF program is attached to sched_switch and it also writes to the
> ring buffer on every context switch. Each forked child creates the
> BPF program and quickly drops the last reference after bpf_ringbuf_commit=
()
> queues an irq_work. Because the irq_work runs asynchronously, it may stil=
l
> be pending when bpf_ringbuf_free() executes, thus creating a small race
> window that can lead to use-after-free.
>
> Adding `irq_work_sync(&rb->work)` ensures that all pending notifications
> complete before freeing the buffer.

I think this all makes sense and the fix should be good. Please add
the above details (perhaps in a bit more condensed form) to the commit
message.

>
> Thanks,
> Noorain Eqbal

