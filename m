Return-Path: <linux-kernel+bounces-824830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56810B8A3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7194E16D792
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98941317706;
	Fri, 19 Sep 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Kcju0aV6"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4C3191A4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295006; cv=none; b=ryrSqX9jknQyD+9OA1th9CiQAkWxaeN9rPUY8Jr1ejWBN6Wi2yZi/+WJ6LLP43juX72LiiBUyTACKhDtA/qsHtI64kRsBWVwkQ8vOoFXU/hdFYK6h1DUN1NfMt6Mzeic2jkumzucmQh1FPFdU5VPwlB7rVxb+udv5aZwyv9bAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295006; c=relaxed/simple;
	bh=MBEz8RXYzBwUKjqcpO6m1S1L/vf2PlfzBnblLtchFjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivmadL1XHGvXxlthxDuDP4EGU4E+bIfQEeB0FYRvGMFlEi3Lbqi7KlKxs8hev6vL5JbYFOuQQeOaEuXlR5jPJ9JTtN4OYGiQFxgy5vu8EZFr92XzvEnlbu2H6Gr5RLL6AHFPg53kbhNQQZi2rGAqXUIavUyq9+sQx0P1ol0yg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Kcju0aV6; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b0e7bc49263so390398466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758295003; x=1758899803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ijPwj25hBppnDZqrRier0Caz6J09Oc9+1PKFrQHHzIk=;
        b=Kcju0aV63lMbeyHWFR7ZeQFCxp+AvZ5uNi9i8LaQHgUXx7x9bu24aPBnLCV8uba7px
         8aI+w+MhEX/QiOrQuXkn5dH6n63Yl3WarJaFNoXy2c/Zy75WFL1oonbTQcSQN4dLmwOa
         vqKLptxvRc6z0ItQMB6JeuQM3CVBce5doKktLwvrjGgAvw3OWcVgyVDDgWHB/PSaa+Qm
         vZ97iNNv5BhfsIjnrxkQ3ZP/8M3VXmzck/DmwaHy3VTCGUUlasFVhTFY8a5w7m88mv/b
         PR4KIRZRzNbCzfZcN1D9YLXwUgdOAj02i5mq5FI7zo5D//33dY44Pym6yrcz7G3RkXAh
         xv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758295003; x=1758899803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijPwj25hBppnDZqrRier0Caz6J09Oc9+1PKFrQHHzIk=;
        b=Ha4QOblu0HZcZoymAAhblmxP7p8xc7oIM9mrHAgE8vj/trIJ3N+c+R+BrvpGXJYrGY
         7NTeKhOsTBNswsonSSdqudgKPenfP8HUU0hEenSehwjwetKd6cYdzjLEpVtYTH+3Ddk2
         z7u9R3T+VvY2oC7CJU5zeCcxzjVqjW1GhIeZvD1fnr6nfNjpkZ1Jx7d2O+vqyx9GXqsz
         ze1VmSXpSpSHl+kIX+5G1j4HhZ8OXOEjV2FWpkiboXGBKYnfP6BNmBdWxebsNK0I8wAS
         dN2rFMR0UGi6ZnJZadJ7SZ6YKhjJbUbKK8diYv0TzhcOQN8g+2lB1Lz/oVBr/mLy9ss4
         1W7A==
X-Forwarded-Encrypted: i=1; AJvYcCVj7Glm/8q00YIpCZ5mAAEMoZJcP6RQO6m29gH2iLR8AgGIqNNFNf3glVSXvKP0SRyd7wv52tBoeSK8ck8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEDxgno09t/5uaP2zDFswUsMY4vDTLtZj53yYEU+CpkAk88L8B
	6IEiduUHj/NSXOEeqDaCQLi08IH0ZBVubG9SMfm+x4fKA+MCTBgRUsW5JXRMGD/sUryz2tIwI79
	oI3WT1QBzQ4tLaZPWO9yefvH7kBQJU8yBDwXWjZnTJX/JH6BGTc12l1A=
X-Gm-Gg: ASbGncvbB2ErWw150G9Qcn1iTfG171c6ynsmdzsKIHEUfQzoj4n0/LGQeXecfq7f2hd
	9PQDKvZqX5l1axrqt+Qr83nVF3a2/JRIAsEtxHbTzXwgGiNUvUK1Ea9t1i1kOotgfA/Ll12CO0x
	IZ3Kb99CLtzW3T5QnAYr6Q9FH4TpSk9Xzuhr9/hOJZqkAspGYKGn4EOlxjePFudlw4CQAbR4fKJ
	SqazBpmwzNfLFID3LI/QwGb
X-Google-Smtp-Source: AGHT+IF6UGP2FSCpYV4aGJCearePygV7NEC6vUV6OVyhG9NqmICeOxoUMsieRKfaZTAtoZ+KR+iLQWjqVyfj4YqWs1I=
X-Received: by 2002:a17:906:c10c:b0:afe:9552:9f44 with SMTP id
 a640c23a62f3a-b24ef97c072mr335299766b.29.1758295003232; Fri, 19 Sep 2025
 08:16:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGis_TWyhciem6bPzR98ysj1+gOVPHRGqSUNiiyvS1RnEidExw@mail.gmail.com>
 <20250919143611.GA22933@redhat.com>
In-Reply-To: <20250919143611.GA22933@redhat.com>
From: Matt Fleming <mfleming@cloudflare.com>
Date: Fri, 19 Sep 2025 16:16:32 +0100
X-Gm-Features: AS18NWA8E4DxqgFwVl9yYfN4mZhKTi3riS7U_zjM5hmDTHAUOid0Mp2QxGGX1O0
Message-ID: <CAGis_TUp9_V-kBn9CF55f08NVR+Bx3iyP=O=+PH0QAf73eGY2Q@mail.gmail.com>
Subject: Re: Debugging lost task in wait_task_inactive() when delivering
 signal (6.12)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>, 
	kernel-team <kernel-team@cloudflare.com>, LKML <linux-kernel@vger.kernel.org>, 
	Chris Arges <carges@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 15:39, 'Oleg Nesterov' via kernel-team
<kernel-team@cloudflare.com> wrote:
>
> Hi Matt,
>
> On 09/19, Matt Fleming wrote:
> >
> > Hi there,
> >
> > We're running into an intermittent issue where tasks end up in a state with
> > p->on_rq=1 and p->se.on_rq=0 when delivering a fatal signal to a thread
> > group. The thread handling the signal sits in wait_task_inactive() after
> > sending a SIGKILL to all other threads, most of which pass through
> > coredump_task_exit() just fine, but occasionally one thread calls into
> > coredump_task_exit()->schedule() and never comes back because of the above
> > state.
>
> I guess you mean coredump_wait() -> wait_task_inactive() ... Sorry I have no
> clue at least right now... And I don't see any problem in coredump_task_exit().
>
> Stupid question. Any chance you can reproduce, figure out the pid of that
> sub-thread which fools wait_task_inactive() and, say, do
> "cat /proc/pid-of-that-thread/stack" ? Or any other info, everything can
> help. Crash dump? Yes, you have already mentioned this is hard-to-reproduce :(

I do have some info. The callstack for the lost thread is:

Call Trace:
 <TASK>
 __schedule+0x4fb/0xbf0
 ? srso_return_thunk+0x5/0x5f
 schedule+0x27/0xf0
 do_exit+0xdd/0xaa0
 ? __pfx_futex_wake_mark+0x10/0x10
 do_group_exit+0x30/0x80
 get_signal+0x81e/0x860
 ? srso_return_thunk+0x5/0x5f
 ? futex_wake+0x177/0x1a0
 arch_do_signal_or_restart+0x2e/0x1f0
 ? srso_return_thunk+0x5/0x5f
 ? srso_return_thunk+0x5/0x5f
 ? __x64_sys_futex+0x10c/0x1d0
 syscall_exit_to_user_mode+0xa5/0x130
 do_syscall_64+0x57/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

do_exit+0xdd is here in coredump_task_wait():

                for (;;) {
                        set_current_state(TASK_IDLE|TASK_FREEZABLE);
                        if (!self.task) /* see coredump_finish() */
                                break;
                        schedule();
                }

i.e. the task calls schedule() and never comes back. The waiting task
sees p->on_rq=1 for this lost thread and spins in wait_task_inactive()
forever.

I have been able to use drgn to inspect the live system when the error
occurred so if you have specific things you want me to look at the
task_struct state I can try that. Or if you would like me to grab some
diagnostic info whenever the issue crops up again, just let me know.

