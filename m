Return-Path: <linux-kernel+bounces-736561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B7B09E92
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C39B1C43750
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31C929550F;
	Fri, 18 Jul 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdMJlKtd"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3405521884A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829308; cv=none; b=BuKJIlDOvJGpOaKjCZm4Di1HCScigBVTY0R/VjHRLNe99DpbdPeGCT3kAlcnx44PvNlRSdKSTAMYzfDrb8zRw0XT2xTTrNUR3Q7l1rDnYeFAfWRKQIDRaLtGHjavpWFjnVFR5ro+/rOBbvY6jLVAYrAKFXYIaxsQVJWYQEcudNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829308; c=relaxed/simple;
	bh=172zSNbQ2OjuCZti0MPT/DioCdRQyClir/2Hzax3Sxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+dpMmNaAxDjdTDQq5YxiEaL0nTE03gJkBBJIAulS8w090K0yZWYaXH7JjsTUz9yLrwPz2gU8QS8VPywWDGwtOrgJyH8kbgqrqzQwpQOToFVS9OV1bCuo4N49EIgrK/c5sLAsbjDQViKGf+h26l5SNBqkT89MG9BQY87D40CKYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdMJlKtd; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b7123edb9so17519971fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752829304; x=1753434104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BZvVB8KHfqnURklsVNa0wO8BYTAoXLlI57P4SQd+WkI=;
        b=UdMJlKtdkYyq/xpFMYfuQVpEj4CKJgWXnogLYCilnthqJ911SAoCWXPF50V4bkJ7wW
         kNPtFju8eH79nlgP95lY76xLrrNiyPZ/zjeqoZDtJ5VzaE9mxjlcnsNffKoTSwXv2sRt
         jEck0CVeic2biwWSNsJKF+SBNo8cGUnVoSLUbJwLT7qNLRHFVH1QqTMHHTXyMRCmBIxX
         vb7Oletaz6tm9BCIg+xzQ51fjEH7gzD7uAMBZ2X/RO7sUhv60f1Rsur2PxIFJRIKqO5m
         C+SeaSE1aXjA8KZz85j7bUOn0571wwzR+EQz1GLvsz5IRe9jGPLPTlLC7zwhzc/2oYlO
         QhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752829304; x=1753434104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BZvVB8KHfqnURklsVNa0wO8BYTAoXLlI57P4SQd+WkI=;
        b=Mf+GOQBKkh53XOF3luEpD/v2Tr/L4VN1Sbr7tV9FJD6v+XdgAlwWlZMWJ9O0362zNB
         IyRrtpboc6WqTHPjASFLir4Y1+mdzahLOYx9Ac6CiWvh5rjTy91M9LEn44unt/z6uP6v
         XFO9JSqQhZCu8wa04df9n6LivbANvPXr/GhPUPrt3S9nwhjNIlcoO4QyhR/sEan9ScTp
         zl2ffo2ZvYLlq2F74wTXijCmD64nkIS/ScEJ5wEvIej+MQl4+xJRNnaI8kyZP/zYt5BC
         r7GTBx1Ejv5znuk35cfnaWeNcX/z033JhT3y2USDlcfM2DozD+COBeVVn91v6VoHVnl7
         SR4w==
X-Forwarded-Encrypted: i=1; AJvYcCUj7UARm8qzzAoUYD8dSdhfedDb2dUATsFNHeVP/PBOnrXkZcvDf8eqbHiodBnnPYhI85IFpybO5N+6Ctg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE7RqOyMZgaiO4+RARO0LN2qcLwFlw8f1YRlbtHx3gg0JFqKZ6
	YVQ8gIg01gym4WWabNExHvBUVyGMx08FJp8bTOwx3lteuXIDyyB4WiQWF+lewprpxjMnEDuc2LZ
	qDXcfyZuk8aXVOtdIpyl3VyrNK7mSfMA4SRk4wmSC
X-Gm-Gg: ASbGncvbzxlaeXJXPuiSyMyleStJk78F1JsOfR7wtqSBtB+PKZj1Tlght4u6FBDXjNC
	qwGTzkfn7tXX8ZHgYnw/FJ25GybxyLAVWr0OxuUBJKOAbCzy+y/IwYVlXqvXg1S4B++TJ1PYeuf
	v6y62D0izdF6ZxIpGqU8WzbkcoY4iVK1nZLDUAk6Na3/n1rK0q2BYQoPFsAoYugm85Vfv/hL3iO
	i708OVm/xbGAbJRt/2U06NZwrbE/uUA4tB2czE5
X-Google-Smtp-Source: AGHT+IHz41omBM3EJNsz9YZ4DE9kPlfpx7a8t8bM3oVutpTgEHroSPSHD30u+wYNJ8gIfTcRTEV57FiwP3uZqaHEccg=
X-Received: by 2002:a05:651c:220f:b0:32a:6c63:935 with SMTP id
 38308e7fff4ca-3308f4c018cmr24134481fa.4.1752829303101; Fri, 18 Jul 2025
 02:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747817128.git.dvyukov@google.com> <138c29bd5f5a0a22270c9384ecc721c40b7d8fbd.1747817128.git.dvyukov@google.com>
 <CACT4Y+ZcQV3JWEaeh7BXNwXUsoH6RcVRyG2iNUA+_mrOBOHfNA@mail.gmail.com> <CACT4Y+anDdNU9rh1xsDRs7vZRfXbbvjFS3RRBu1zVejrp11Scw@mail.gmail.com>
In-Reply-To: <CACT4Y+anDdNU9rh1xsDRs7vZRfXbbvjFS3RRBu1zVejrp11Scw@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 18 Jul 2025 11:01:31 +0200
X-Gm-Features: Ac12FXwsdme_Wpq72Sz3nmMRplge0sC8bmFGJ13SZH4cOn42Tc00ZirJFEn7AZs
Message-ID: <CACT4Y+b0cdGZwqmZSikxam+ASp9LXMuT9f8iifnmNed+PjamVg@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] rseq: Make rseq work with protection keys
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@kernel.org>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 11:17, Dmitry Vyukov <dvyukov@google.com> wrote:
> > > If an application registers rseq, and ever switches to another pkey
> > > protection (such that the rseq becomes inaccessible), then any
> > > context switch will cause failure in __rseq_handle_notify_resume()
> > > attempting to read/write struct rseq and/or rseq_cs. Since context
> > > switches are asynchronous and are outside of the application control
> > > (not part of the restricted code scope), temporarily switch to
> > > pkey value that allows access to the 0 (default) PKEY.
> > >
> > > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> > > Cc: x86@kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")
> >
> > Dave, can you please ack this patch? Ingo said he was waiting for your
> > review before taking this to -tip.
>
> Are there any remaining concerns with this series? If not, Thomas,
> Ingo, can you please take this to -tip tree?

Gentle ping. What needs to happen for this series to be merged?


> > > ---
> > > Changes in v7:
> > >  - Added Mathieu's Reviewed-by
> > >
> > > Changes in v6:
> > >  - Added a comment to struct rseq with MPK rules
> > >
> > > Changes in v4:
> > >  - Added Fixes tag
> > >
> > > Changes in v3:
> > >  - simplify control flow to always enable access to 0 pkey
> > >
> > > Changes in v2:
> > >  - fixed typos and reworded the comment
> > > ---
> > >  include/uapi/linux/rseq.h |  4 ++++
> > >  kernel/rseq.c             | 11 +++++++++++
> > >  2 files changed, 15 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> > > index c233aae5eac90..019fd248cf749 100644
> > > --- a/include/uapi/linux/rseq.h
> > > +++ b/include/uapi/linux/rseq.h
> > > @@ -58,6 +58,10 @@ struct rseq_cs {
> > >   * contained within a single cache-line.
> > >   *
> > >   * A single struct rseq per thread is allowed.
> > > + *
> > > + * If struct rseq or struct rseq_cs is used with Memory Protection Keys,
> > > + * then the assigned pkey should either be accessible whenever these structs
> > > + * are registered/installed, or they should be protected with pkey 0.
> > >   */
> > >  struct rseq {
> > >         /*
> > > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > > index b7a1ec327e811..88fc8cb789b3b 100644
> > > --- a/kernel/rseq.c
> > > +++ b/kernel/rseq.c
> > > @@ -10,6 +10,7 @@
> > >
> > >  #include <linux/sched.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/pkeys.h>
> > >  #include <linux/syscalls.h>
> > >  #include <linux/rseq.h>
> > >  #include <linux/types.h>
> > > @@ -424,11 +425,19 @@ static int rseq_ip_fixup(struct pt_regs *regs)
> > >  void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> > >  {
> > >         struct task_struct *t = current;
> > > +       pkey_reg_t saved_pkey;
> > >         int ret, sig;
> > >
> > >         if (unlikely(t->flags & PF_EXITING))
> > >                 return;
> > >
> > > +       /*
> > > +        * Enable access to the default (0) pkey in case the thread has
> > > +        * currently disabled access to it and struct rseq/rseq_cs has
> > > +        * 0 pkey assigned (the only supported value for now).
> > > +        */
> > > +       saved_pkey = enable_zero_pkey_val();
> > > +
> > >         /*
> > >          * regs is NULL if and only if the caller is in a syscall path.  Skip
> > >          * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> > > @@ -441,9 +450,11 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> > >         }
> > >         if (unlikely(rseq_update_cpu_node_id(t)))
> > >                 goto error;
> > > +       write_pkey_val(saved_pkey);
> > >         return;
> > >
> > >  error:
> > > +       write_pkey_val(saved_pkey);
> > >         sig = ksig ? ksig->sig : 0;
> > >         force_sigsegv(sig);
> > >  }
> > > --
> > > 2.49.0.1143.g0be31eac6b-goog
> > >

