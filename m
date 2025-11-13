Return-Path: <linux-kernel+bounces-899220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5D0C57202
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E035F3A7EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0472A3396E8;
	Thu, 13 Nov 2025 11:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it6B1BcO"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498E33858A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032418; cv=none; b=qgGNB/k05rdw3LLn84fc6pMPiWnYbi29h95kJf7Z68A/py8zr7VEfYwCtFGJ07WXmkW2ATkNZFAYFMKPjW+cVZ9l3tjX+B66J92PJyx0qaP1QucGx+qdIBzrsc1/gnys+yJnozyS3mQIcB9+ltNJQIw15N6VRAWehAXCynoAGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032418; c=relaxed/simple;
	bh=2nfkUFEyeTPvY9nyDt6tV6x7gYKP6WCBqWyd9cTqSH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxc4+jFPPXiNHy1Awcvc4iWe96JuDINt+JREHng1zrszlvdC+xE/dj8vwIvYFAk8fAXUHqILQ9uTgczCVt77twawFp5fSawNEMTTly95iTh6myr1iwO+Ai82INFPVwsZdQC85C0Q1+RhSLJilgCGMRGnk0eE+s5SDu5xBHtP8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it6B1BcO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b727f330dd2so87550466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763032415; x=1763637215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIw7Xm3oDNehlEieN5CtSC8W4YrmGX9W6qbpU2/TpUo=;
        b=it6B1BcOlwT+csQp4mzT4lztS3UMlTvZYho1Z+xzXsWMa035KmBnBYc+/tUbNNFpTo
         EhsXZKz8heee4+ikTnHYva8qqNU8EgUQUTgi1BBKEQgDRBiT5rR36VpzLBFvGYprMrbf
         G7ELN1PelbmNO5X3AB+KIxq1AulOdq7JI7xi7PY8opm7LClJzDaZ1A59+d2h7Rez9q0B
         uoe44DI1fPv6lvDWkW3o64pTGBoTeDWSGUWZnMqhILC83IuzrPrNRHOyYW5Q9Y0yKFLo
         b5umvjSx6AUQ8Yiwag7bYZNl61MJUq0Zcw56EayKndNZkmmG59xtX/B9SXycAL/llBoW
         Q1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763032415; x=1763637215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kIw7Xm3oDNehlEieN5CtSC8W4YrmGX9W6qbpU2/TpUo=;
        b=SPrUxmyZ7yzSdxRVWgKqx7Gl1rk5EjI8Ylx7zlaYLotfWDMNj2EQnuzIWP/pGlwMgE
         0MQON1tBBD470fKSyjMsveIjOVu4eo4U3/1Jf9xlBy/mcJA3d+jJY7zpBTyZHR9z1cI7
         nkz0WMdjXVW3pG3hCgYoRJRIUW88y48Ff/FjG46wi6FupvNX5ZKZ+/4JPzRSxxlRjjH2
         QwlHD0HXwxoFyeCeS1Z0CGUxpW4NWI1hzF5bXy/w39xI/bi7N6LO6mvPQO5sYyAefzfk
         QM7GIuYvpFRe1nFrKakDbsk3PlzLQ63Ry0GggVtOhQB6YGhb4YZTRh4qUlceQq0tjjei
         QU/A==
X-Forwarded-Encrypted: i=1; AJvYcCWzuxJ99tytSvYAdzHREk1SHbuY6YbWgUtEGIl/Y32YH+Xc8jkGEispH2Kl4k1+FsQdiMck5xaPrQDLa9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwomzwQwJA2qbTCSG3uH2iP1er2mtEB2c2DfPyJv5gGe6lV8sQ5
	exaC41gc9+xb1yFUeEq3cNfgbcXPljMC7BVYP99BLIboOO2PXMecw59BYr6heJah+9YrjeAsb4l
	LqjMCwZEK+0hN0TBzUpYG9KEHVMK/VY8=
X-Gm-Gg: ASbGnctTBZdagvuxdz+IBDcFb6OJsa95Gy1Ievb8d4WZG6H2Pn+KIdkUVjMuHz82M64
	cAKK3hJq4u5d1B7Rchzbpch33EBYcDOs04va33N0mvhxsILXLJGx+haHLTx7u6hLAKfDrRG29r8
	qBNOLOnRWi0qJawvKQFkhP/E358zqZJemUAB6PLTNhWhwqwWaCzj+5KhQGaSnsKmTiOBAi2+Ssr
	UpgRRy17zcqyDGBbu5ta1hD8JkiHgDAL7orPE0MiQIG1uwXsC7P8GElnrgJ
X-Google-Smtp-Source: AGHT+IHvFGA7lSHeo8GRvWzOeGJiPitXnORSPqfM76SMDFCtJZ8hIWpC2PXuxziMqg/v11vbGAIbG+FbSNi74bIYsiY=
X-Received: by 2002:a17:907:7e8e:b0:b73:5d8c:dd0d with SMTP id
 a640c23a62f3a-b735d8ce04amr8301266b.52.1763032414634; Thu, 13 Nov 2025
 03:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113000252.1058144-1-leonylgao@gmail.com> <20251113073420.yko6jYcI@linutronix.de>
In-Reply-To: <20251113073420.yko6jYcI@linutronix.de>
From: Yongliang Gao <leonylgao@gmail.com>
Date: Thu, 13 Nov 2025 19:13:23 +0800
X-Gm-Features: AWmQ_bmPe1Dsb6l-Cx025fplW4DeFTdGrd-P4g6FieNkHhLzgmlN9OMB1pIU8i0
Message-ID: <CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	frankjpliu@tencent.com, Yongliang Gao <leonylgao@tencent.com>, 
	Huang Cun <cunhuang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Thank you for your review and the thoughtful questions.

1. Performance Data
We encountered this issue in a production environment with 288 cores
where enabling set_ftrace_pid caused system CPU usage (sys%) to
increase from 10% to over 90%. In our 92-core VM test environment:

Before patch (spinlock):
- Without filtering: cs=3D2395401/s, sys%=3D7%
- With filtering: cs=3D1828261/s, sys%=3D40%

After patch (seqlock):
- Without filtering: cs=3D2397032/s, sys%=3D6%
- With filtering: cs=3D2398922/s, sys%=3D6%

The seqlock approach eliminates the pid_list->lock contention that was
previously causing sys% to increase from 7% to 40%.

2. Reader Retry Behavior
Yes, if the write side is continuously busy, the reader might spin and
retry. However, in practice:
- Writes are infrequent (only when setting ftrace_pid filter or during
task fork/exit with function-fork enabled)
- For readers, trace_pid_list_is_set() is called on every task switch,
which can occur at a very high frequency.

3. Result Accuracy
You're correct that the result might change immediately after the
read. For trace_ignore_this_task(), we don't require absolute
accuracy. Slight race conditions (where a task might be traced or not
in borderline cases) are acceptable.

Best regards,
Yongliang

On Thu, Nov 13, 2025 at 3:34=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-11-13 08:02:52 [+0800], Yongliang Gao wrote:
> > --- a/kernel/trace/pid_list.c
> > +++ b/kernel/trace/pid_list.c
> > @@ -138,14 +139,16 @@ bool trace_pid_list_is_set(struct trace_pid_list =
*pid_list, unsigned int pid)
> >       if (pid_split(pid, &upper1, &upper2, &lower) < 0)
> >               return false;
> >
> > -     raw_spin_lock_irqsave(&pid_list->lock, flags);
> > -     upper_chunk =3D pid_list->upper[upper1];
> > -     if (upper_chunk) {
> > -             lower_chunk =3D upper_chunk->data[upper2];
> > -             if (lower_chunk)
> > -                     ret =3D test_bit(lower, lower_chunk->data);
> > -     }
> > -     raw_spin_unlock_irqrestore(&pid_list->lock, flags);
> > +     do {
> > +             seq =3D read_seqcount_begin(&pid_list->seqcount);
> > +             ret =3D false;
> > +             upper_chunk =3D pid_list->upper[upper1];
> > +             if (upper_chunk) {
> > +                     lower_chunk =3D upper_chunk->data[upper2];
> > +                     if (lower_chunk)
> > +                             ret =3D test_bit(lower, lower_chunk->data=
);
> > +             }
> > +     } while (read_seqcount_retry(&pid_list->seqcount, seq));
>
> How is this better? Any numbers?
> If the write side is busy and the lock is handed over from one CPU to
> another then it is possible that the reader spins here and does several
> loops, right?
> And in this case, how accurate would it be? I mean the result could
> change right after the sequence here is completed because the write side
> got active again. How bad would it be if there would be no locking and
> RCU ensures that the chunks (and data) don't disappear while looking at
> it?
>
> >       return ret;
> >  }
>
> Sebastian

