Return-Path: <linux-kernel+bounces-751560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE9CB16AE4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CD218C57CE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084381D07BA;
	Thu, 31 Jul 2025 03:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XDByhVAn"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155B2E3714
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753932727; cv=none; b=mxZ8XfLOsY10/rmV88OW1v6ILSvu0SCUMId9crf5/xQ/eNwZyEsglNSyEmaPCzadl9Tsgp3SSnfijtcsQKyL4uR4++0N29o1C++9f112zqxTrkxJkQw2oRoIv2Hdhftj2F9jPhWhqpXvZarz9YUav6uhKKkJC6KGLdIaB2dwi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753932727; c=relaxed/simple;
	bh=Mk1jtVdMFICQYqvr3NVsuaBwvlBUb5R4AA0hIY+x+to=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyEGmtLpVIg3UjAlwMLEQ+lzpTTD/nJtwb30jgBy2cVOgirV8pihrfVC5NzbLoXFZ9ZVt7bZoe0tSdfFV/yjaRbpt5nSxMf2DrgNYhFf+GkQ5ToBGXiWN1pOp+Z4osOrIctZj0jvMTKyAiEDw6Rnf+fmcM4LkOiwXiby3M9fLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XDByhVAn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61592ff5ebbso708296a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753932723; x=1754537523; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tEx1n4Xdo4vPfU6fqsOXhSQlqDl3czXM7n2tf/QEaa4=;
        b=XDByhVAn6NyipAQb95TT7ng34SR6gdWOjwtKdMEzJr3en/+6Tc6VF3+vmq1iNKaLdf
         HbsZZNaCdetxmQfZ2g3oB7aYbDfbmfXvYrwzABEasR2pNOgfbCu5piPgNO9X2Z185bvj
         kQpLXZkEIVbXGvX+eUYOw1opIrb/NJkOjwEeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753932723; x=1754537523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEx1n4Xdo4vPfU6fqsOXhSQlqDl3czXM7n2tf/QEaa4=;
        b=kJ51+KFeGWUngAY2hwYJM5U1en8x1X49D1awVPXQLSJx9ZW/jFXHXbuvAqJo4KuSpy
         gBr1MYhKFF+CDbq8N/uLd2VXoWWZgTYDf5Fv/z2bAGjSy6F3UEG4FqY6tmpNbpj6qY/g
         B+67WLhAMNBnuVBtqfBevpBony87Hf+pZav/vVJ76bFCks8DIgrmZ5FbdeNz+1a2nO4L
         mYZj918BZaQuhgB25ChD9dPgGwM4kJzhYqlwO0SPpRkZnCIwT8vDsTY1pSCtE0fbW0Aq
         G6oBdinudI7nX21Wu38xoxebQrQr2dlJZRZXYKVMfMAsLEuLicEpdKgYMlen6rJqP87+
         isuA==
X-Gm-Message-State: AOJu0YzCY2BV7Sbe37sbrVlQYJZKtsBjUzJynCO8hLlqNIqx2uhgCQu6
	/pKqJoFETrfH12aVagShO0vdHHUPgiXEUVbWKDHuUngX8d2wLdDjwo0o6aTAN1l9tFKVJRMa9t7
	wER/rQ/M=
X-Gm-Gg: ASbGncvKuFu04iC38+jQ0DzpXUwmbshAy9o0LVW4jJRPIKZjdJwlcvoZ5fVLH7lINLJ
	iD/WJ0adR9kVRPtCrmZWAK0uUXM+1YPHD8s8nIcdKWyvbAxZAsvO1p7FG2XRazAJSfz1VVrwi6A
	ngxt+alZ79EYb16iKnnJ8LJuoPAD+gH+hU0ImfDaiNPDbNmCGkpm+bRjHc7iQbz8oYRJZdqcGYz
	sWkoq/zUno6zf+8uZPUbFAQoNqH0Njx9tpaFTsgary8dSdvBym4rGWKfHstxVtGSGUpImEecoIi
	sY1hEfp2bIpRD2H+0AIumfZtpbkmLOP1waUdIYhdpeZjlFk4R0qVXxMnJzy8jHadPoQS6ey4Coa
	C+wX/E0U2Ki8fJx0TNs+CY+/8nlTbS8htyonYY4isrr3iWi8ZIs+JxkNnxdZpS2jJl0IeOzpp
X-Google-Smtp-Source: AGHT+IFCH1xLKDNIeOdLnfLc4o5JfuA8qQRelTgN1q+k0SqVr4GFe3pz6XyLi73UGYgi4CFQykaeTA==
X-Received: by 2002:a17:906:7950:b0:ae3:5e27:8e66 with SMTP id a640c23a62f3a-af8fd78e917mr694721966b.27.1753932723015;
        Wed, 30 Jul 2025 20:32:03 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a243742sm37740966b.132.2025.07.30.20.32.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:32:01 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-615622ed677so624604a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:32:01 -0700 (PDT)
X-Received: by 2002:a05:6402:50c6:b0:615:916c:88bc with SMTP id
 4fb4d7f45d1cf-615916c9385mr3906714a12.4.1753932720904; Wed, 30 Jul 2025
 20:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIcdTI3e04W_RdM_@gmail.com>
In-Reply-To: <aIcdTI3e04W_RdM_@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 20:31:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
X-Gm-Features: Ac12FXxBro9jgTGdqHI_lqShGbOkjmp4jaIDjakoKlvTsAT8EJHEHVSqnO2mhJE
Message-ID: <CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler updates for v6.17
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Jul 2025 at 23:48, Ingo Molnar <mingo@kernel.org> wrote:
>
> PSI:
>
>  - Improve scalability by optimizing psi_group_change() cpu_clock() usage
>    (Peter Zijlstra)

I suspect this is buggy.

Maybe this is coincidence, but that sounds very unlikely:

  watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [kworker/0:3:7996]
  CPU#0 Utilization every 4s during lockup:
          #1: 100% system,          0% softirq,          0% hardirq,
       0% idle
          #2: 100% system,          1% softirq,          1% hardirq,
       0% idle
          #3: 100% system,          0% softirq,          0% hardirq,
       0% idle
          #4: 101% system,          0% softirq,          0% hardirq,
       0% idle
          #5: 100% system,          0% softirq,          0% hardirq,
       0% idle
  Modules linked in: uinput rfcomm nf_nat_tftp nf_conntrack_tftp
bridge stp llc ccm nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet [...]
  CPU: 0 UID: 0 PID: 7996 Comm: kworker/0:3 Not tainted
6.16.0-06574-gd9104cec3e8f #164 VOLUNTARY
  Hardware name: Dell Inc. XPS 13 9380/0KTW76, BIOS 1.26.0 09/11/2023
  Workqueue: events psi_avgs_work
  RIP: 0010:collect_percpu_times+0x2f6/0x320
  Code: c0 0f b6 c0 c1 e0 09 41 09 c5 e9 14 ff ff ff 49 8b 0f 48 89 4c
24 48 49 8b 4f 08 48 89 4c 24 50 e9 6e fe ff ff 4c 89 c0 f3 90 <4a> 8b
14 ed c0 3c 20 93
  RSP: 0018:ffffd4d3cc113d60 EFLAGS: 00000202
  RAX: ffffffff93b26880 RBX: fffff4d3bfba0ed4 RCX: 000000000000622d
  RDX: ffff8ced1e597880 RSI: fffffffc6684cefc RDI: 0000000000000000
  RBP: ffffd4d3cc113db8 R08: ffffffff93b26880 R09: 0000000000000000
  R10: 00001386e5a9adc7 R11: 000000000000eda9 R12: ffffd4d3cc113dd8
  R13: 0000000000000006 R14: 0000000000000006 R15: fffff4d3bfba0ec0
  FS:  0000000000000000(0000) GS:ffff8ced8a8f1000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000027f400c50010 CR3: 00000001b641e005 CR4: 00000000003726f0
  Call Trace:
   <TASK>
   psi_avgs_work+0x31/0xa0
   process_one_work+0x135/0x220
   worker_thread+0x2e7/0x420
   kthread+0xbd/0x1a0
   ret_from_fork+0x133/0x160
   ret_from_fork_asm+0x11/0x20
   </TASK>

and yeah, the laptop was dead at that point. Thankfully it had been
alive enough that the watchdog messages made it into the logs.

There were more than one of those reports (34 of them to be exact) but
they all look pretty much the same. RIP is always the same at that
collect_percpu_times+0x2f6/0x320, but that's just the instruction
after the 'pause' instruction that is from

   psi_read_begin ->
       return read_seqcount_begin(per_cpu_ptr(&psi_seq, cpu));

which is from that __read_seqcount_begin() code that waits for the
writer to go away:

        while (unlikely((__seq = seqprop_sequence(s)) & 1))             \
                cpu_relax();                                            \

and clearly it never does.

Why? I have no idea. But hopefully this makes somebody go "D'oh!" and
send me a trivial fix.

Please?

           Linus

