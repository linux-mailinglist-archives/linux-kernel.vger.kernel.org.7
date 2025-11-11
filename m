Return-Path: <linux-kernel+bounces-895166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27100C4D254
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EC9D4F87FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC334F486;
	Tue, 11 Nov 2025 10:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Wl7g0p"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C834F255
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857538; cv=none; b=lLjB9yrzQOpDeUP+5TiPijnGlhvXOVO0EzLBHqApoEABwY7PMvrq16xdFIaOuGyDSmmR6O2XVI5l6g/K2vKa7Wj7Ksl+WBScXaN/62WUNwa5IlhmCnvaDRqUGlFh1+PiEwwVx9NgDb8POaTafwblynwpN/CLGdkR/fRG3/9NQvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857538; c=relaxed/simple;
	bh=O5hSvrZ5NtQmMb20B6inDgRRpZm/LjVqfNIdDi6Qrsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbwSD/Ypec8zQ4zZHjLtCt4wfqeHhIMR01YnQX+dMAi38dufDkSzsgbr7htDdYXHS3yHrsyEHU9v+oiioME0bmh89EBhUd+li9DxdYdQg+jmZ7Ph7STjk2F9cTH5qWVtNEh/VEZt57Yl32EwRmpgP1XpCgMdWLplBj4YjO2Pld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/Wl7g0p; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b71397df721so458132266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 02:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762857535; x=1763462335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWaDqifCzTUEmxDcL1a0AAX24KjwxYVqnZdZsggRtpA=;
        b=i/Wl7g0pcNEVlGX4HB+Ak8Xpp1X3y+T+lTAkUX/mvG73vyyOabpbe/LuzC3mJaaHDd
         bgwLlloCnh65FbkxV0YJUdDv2s4Np9y12CtHeweyWNUVVgkmDak8uFmcN8FLl1XXzeV1
         oWqrDcOIcKkymD/IMmumXtgpeEyw0XqORJ3bM9cVqBRVBX/yjz7nWD6fyV7Gx8lR0qob
         P/z/hMS46KVRTWtXiJ+rfLqUvScA0XS5zdShX0PSlD1Vw9724Xunutj9gQj31RQc8V/5
         rjpGnm2XIuo0PmyNdUzAB1nFmNAcu7pOz0mfJWgXFSZKv23bBsVWAQBehdE1bfGIsOtk
         RMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857535; x=1763462335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gWaDqifCzTUEmxDcL1a0AAX24KjwxYVqnZdZsggRtpA=;
        b=nxKfiH18K8ol2SqguzjTvGzGculL88+N4SrH00TUn9HkLtWdoSg7pVLyOLR4a7jIfs
         QKBolooxD2csVPuWyaXBV2IEZOZub4Lsmr9ea3JpvdD/esjL8mNVDxOO7ZwrP7ERaW5B
         ZhMqpo5LNTIiTSvHzUKlnb59ksvxb825lJ4tZqxERt9YzpZG88uwqszGVDbG3v62nHuN
         a8E0/t8HDfFc/om+z7xjK+6iFacC0h2im1tlp4TZDUZliW+9JZxrHncT5tnYmo93Sw3N
         3Jhhq1oqaRyrA+MNU752cQiSjLoLPvHdCSHGapqjVlnM5aePz3grsQb+OtTJ1qzV5qFX
         XhUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdXTb2Au6kTht5RlFWwqKs9t7ERapc7wHTA6lkWlaPGXaI1Z9Mxim4IrDYSPkGio+5lvHaKpUHYRa2Lxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz4zsiaVnEhn6c8nY+x7wEK7BnG8e1Y/lcmvecgpHf8a+m5H6f
	00gm+lDjLS9S3r+aWUsiFx8hQGpfHBOrXjHQP92r1dMNZwoJ3j75Ywwl/r/FnhoQEX2QMY2E4+i
	XhjjtYlyf2KxUwQZixSmRB5ldA26FL1Y=
X-Gm-Gg: ASbGncuMHccdqLWpgAwKOzu3M0rl1FJYGMGJ6S2Mq/kUMtCu3u9PwZRxfWQTn7A54jd
	lFJv+Fsv28vKXWB4UcHeN8kMc3MN4Q9XndgeUOL6pgkWWTicJLyriVbvpmJQM9pIOc5OC16+H67
	/Tb3ZA86BaQLxB7zvMvkjFyaxsRosmFKuRpIDPdD8xK5UqR5VdBcOahbX/sA4e/flohQIIYb3oP
	pnxZpTD6mcoiKX0Dx8pKckciyw/mR6k6k6+GnVsp6aY3JrVWlEbfKWUGb6J2kRMUbTqH4r9sA==
X-Google-Smtp-Source: AGHT+IEMIpryibnM9iQKFE02l5VsRmIUq6YWhbumv4J4Nbo9bRfNm0UoT3YpV34bphX68kVePuRIljgGzakkrpjrPEs=
X-Received: by 2002:a17:907:7ba4:b0:b73:2bc4:ebf with SMTP id
 a640c23a62f3a-b732bc41087mr12957966b.2.1762857534366; Tue, 11 Nov 2025
 02:38:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015114952.4014352-1-leonylgao@gmail.com> <20251110183854.48b33b50@gandalf.local.home>
 <20251111081314.j8CFfAD6@linutronix.de>
In-Reply-To: <20251111081314.j8CFfAD6@linutronix.de>
From: Yongliang Gao <leonylgao@gmail.com>
Date: Tue, 11 Nov 2025 18:38:43 +0800
X-Gm-Features: AWmQ_bkXTkkKFQDSYB12CftXRz5KwgLvgCm2SiXmqDL3Wvm20hSm1tBdpgZSm1E
Message-ID: <CAJxhyqD1kUmraC-FxvkyMssKWdyX4BkpKoH7Agm7c2FYTd6EjQ@mail.gmail.com>
Subject: Re: [PATCH] trace/pid_list: optimize pid_list->lock contention
To: Steven Rostedt <rostedt@goodmis.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Yongliang Gao <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>, frankjpliu@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven, Sebastian,

Thank you for your review and explanation.
You are absolutely right. I overlooked the case of PREEMPT_RT. I will
look into other possible optimization methods later.

Best regards,
Yongliang

On Tue, Nov 11, 2025 at 4:13=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-11-10 18:38:54 [-0500], Steven Rostedt wrote:
> > On Wed, 15 Oct 2025 19:49:52 +0800
> > Yongliang Gao <leonylgao@gmail.com> wrote:
> >
> > > diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
> > > index 090bb5ea4a19..62082a4f60db 100644
> > > --- a/kernel/trace/pid_list.c
> > > +++ b/kernel/trace/pid_list.c
> > > @@ -138,14 +138,14 @@ bool trace_pid_list_is_set(struct trace_pid_lis=
t *pid_list, unsigned int pid)
> > >     if (pid_split(pid, &upper1, &upper2, &lower) < 0)
> > >             return false;
> > >
> > > -   raw_spin_lock_irqsave(&pid_list->lock, flags);
> > > +   read_lock_irqsave(&pid_list->lock, flags);
> > >     upper_chunk =3D pid_list->upper[upper1];
> > >     if (upper_chunk) {
> > >             lower_chunk =3D upper_chunk->data[upper2];
> > >             if (lower_chunk)
> > >                     ret =3D test_bit(lower, lower_chunk->data);
> > >     }
> > > -   raw_spin_unlock_irqrestore(&pid_list->lock, flags);
> > > +   read_unlock_irqrestore(&pid_list->lock, flags);
> > >
> > >     return ret;
> > >  }
> >
> > Unfortunately you cannot do this because this is called while holding t=
he
> > task pi_lock and rq locks. In PREEMPT_RT() the read/write_lock_* turn i=
nto
> > mutexes.
> >
> > Sebastian, is there any equivalent of raw_read/write_locks() that can b=
e
> > used?
>
> Nope, no read-write lock that can be used in atomic sections. Well,
> there is RCU.
>
> > -- Steve
>
> Sebastian

