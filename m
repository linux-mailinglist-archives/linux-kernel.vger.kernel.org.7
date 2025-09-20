Return-Path: <linux-kernel+bounces-825918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CD9B8D1B8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 00:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8D9178DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 22:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48E4285069;
	Sat, 20 Sep 2025 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J9Fmyf5x"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAC19309E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758406222; cv=none; b=F+WpXoEriE0oqq09PH28lPDebowGuh6pEWuy0vPVZEf3ICVXpndXyKf6CO15iosSdfbXl5YZgUOfoSzTglSZUnx6LGDwz8/l9aGOSapsORL7BjR7P+UWrwzDwdejUKMIFE28fPAFOpjnYKAC0IwihS8cZ68jwyiFOc7t6TzwuIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758406222; c=relaxed/simple;
	bh=LY3ujSSp4ssjDboMxWkSkt2y4GVfW7/lwkeP03NUrWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO83aCAnTGmMdx2qoejLPGj5jyM8bDLbd97lfnhuODgYiwq7+JHEIq6DH4ek9SR7WfoBcmc88kROQKwVfXIT9MnGVcvn5hG+yE/UizbDT3w+iGY2HNFR79WTlpCdWCXYRIGXWJiPZ1XnGnlVG//qG/KB7npbCH11XDGRKSnMjWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J9Fmyf5x; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07ba1c3df4so602560866b.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758406218; x=1759011018; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iuOT5FcGvpbq5izggBkx/dpQo/nFSfgwh6uOm9NZ/Mg=;
        b=J9Fmyf5x/ulE9vYgwv1IIxaVcIkxMVop9CMmBnr1Jx7oIIuATLlHkl2pcT7kKG4vvs
         QLgp6nPQ6lwNq6+10TRfOtH+XbtAsBx0u/SGBOhsSQbikb76igPq9a7hwtzRcKq6fU4E
         dVluuoy8Hu3B1lheW8c+u4YQ41MH1xClR7acm73IfpUVlSIsjIa8zkQUpVsp9eqmnAwQ
         5OSs1thBMXbZ1ZB+qwrBDT2hOHPDMjebajfQJ8RrcMgsOI/HMCclDJZX21ksecK/0x4d
         wDYD7FYqbTSAYbbLK6+EX64JXeS0SiFYJsZHAmfiGr5vJzpLOSrmRvPlKZtojQxNMr9v
         3Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758406218; x=1759011018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuOT5FcGvpbq5izggBkx/dpQo/nFSfgwh6uOm9NZ/Mg=;
        b=hLeyM+qn6HO5hZZEczYbXPoml8FI91qHAzWmZ93OuxmgtrHzRo4j/aAP2TboRYj8W9
         oTl+MjiVbQdFM/em89Fe1zFa+WjXVX3/cickS5UOyMkR7zw8eDSGdEwlUc6gISHyWCw9
         PTQtl3MYFSWgVLbvPhG1tvndsu2c1kq+N8yfWTCCoS7X1uQYJ/phZhcZjluzKv2pf83k
         eCGK1ImS6vbXDDlnFqTgHwY/blRedWaOfanl/CwOdKn141LPZhR0ind2PYc6WAHeK7dX
         Buh6SRyg7n548KWf4OTnW1jr5rdKKsmFLEyX2umqXoiVUGw2shK2/HA08RzSSBZsfLre
         E90Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0Vy9RATYqzDqjI2zsDIKEGjnWrPcgYzUcm/h+dpNq39bhNNOaWxogawwAmtKutzAUxn7fctzfi8ZTx7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtAPoLVhT8RrIzn3u/im8zO3o73cuVUogDUkgX0hjtQteKs90b
	wvWp61iLOKal1umlpzG6koQZUg428ELm1MO/9U3oktDAvx4YhUCgshnt7CB6fuwtnFLyu1gXadn
	dW/yBUKozs8klafBXTVfbNOqN1aa8vmuifeF9QC9VxQ==
X-Gm-Gg: ASbGncuGOF3fFdmf9eL6tKAaZ0+WGNABmGuwU7jxA/wvCsMSMVsqNt547hIYdjnlQ8D
	LKdJbJePuMyIs3n7VffuuzF8bdT3JS3ee1EAY5gV2ZuWaJjKiSO/v8AUclkgpeQP7TZ4q3Xg3il
	YDrBlIdcg82MwIPuS7NnHEsBmrwsBltetmx0MbaQ3sewYcO4cqSfZrwqaIQ6Nq2Qxba5PT3mHhT
	SNg86oqqjQG5sxn7FGsXWhA7+DaMC+qTg==
X-Google-Smtp-Source: AGHT+IHXhsI4hda42JjoNr9cAmqiaihGUywDLTqyq7u++xty2ZCVqSKEj2SD6SYsm2KE2zwUrp/7NPMAXkOp7AygEpw=
X-Received: by 2002:a17:907:724c:b0:b07:c94c:ba16 with SMTP id
 a640c23a62f3a-b24edd54a3fmr923990666b.4.1758406218497; Sat, 20 Sep 2025
 15:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGis_TWyhciem6bPzR98ysj1+gOVPHRGqSUNiiyvS1RnEidExw@mail.gmail.com>
 <20250919143611.GA22933@redhat.com> <CAGis_TUp9_V-kBn9CF55f08NVR+Bx3iyP=O=+PH0QAf73eGY2Q@mail.gmail.com>
 <20250919161353.GB22933@redhat.com>
In-Reply-To: <20250919161353.GB22933@redhat.com>
From: Matt Fleming <mfleming@cloudflare.com>
Date: Sat, 20 Sep 2025 23:10:07 +0100
X-Gm-Features: AS18NWAL6GI6XKBuoa9CCanGknXIpYlquJCzZBZvwnlkfbM1vxd0nIWcEfnFL2Y
Message-ID: <CAGis_TWHJva-gktrsvO9=m5mEFf4zzcN=rNEt+5+moqz=C7AEQ@mail.gmail.com>
Subject: Re: Debugging lost task in wait_task_inactive() when delivering
 signal (6.12)
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <jstultz@google.com>, 
	kernel-team <kernel-team@cloudflare.com>, LKML <linux-kernel@vger.kernel.org>, 
	Chris Arges <carges@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Sept 2025 at 17:15, Oleg Nesterov <oleg@redhat.com> wrote:
>
> OK, thanks. Nothing "interesting" at first glance.

Chris (Cc'd) and I managed to get a reproducer and I think I know
what's happening now.

When a task A gets the SIGKILL from whichever thread is handling the
coredump (let's say task B) it might hit the delayed dequeue path in
schedule() and call set_delayed(), e.g.

        dequeue_entity+1263
        dequeue_entities+216
        dequeue_task_fair+224
        __schedule+468
        schedule+39
        do_exit+221
        do_group_exit+48
        get_signal+2078
        arch_do_signal_or_restart+46
        irqentry_exit_to_user_mode+132
        asm_sysvec_apic_timer_interrupt+26

At this point task A has ->on_rq=1, ->se.sched_delayed=1 and ->se.on_rq=1.

Now when task B calls into wait_task_inactive(), it sees
->se.sched_delayed=1 and calls dequeue_task().

At this point task A has ->on_rq=1, ->se.sched_delayed=0 and ->se.on_rq=0

Unfortunately, task B still thinks that task A is scheduled because
task_on_rq_queued(A) is true, but it's not runnable and will never run
because it's no longer in the fair rbtree and the only task that will
enqueue it again is task B once it leaves wait_task_inactive() and
hits coredump_finish().

> > do_exit+0xdd is here in coredump_task_wait():
> >
> >                 for (;;) {
> >                         set_current_state(TASK_IDLE|TASK_FREEZABLE);
> >                         if (!self.task) /* see coredump_finish() */
> >                                 break;
> >                         schedule();
> >                 }
> >
> > i.e. the task calls schedule() and never comes back.
>
> Are you sure it never comes back and doesn't loop?

Yeah, positive:

$ sudo perf stat -e cycles -t 1546531 -- sleep 30

 Performance counter stats for thread id '1546531':

     <not counted>      cycles

      30.001671072 seconds time elapsed

