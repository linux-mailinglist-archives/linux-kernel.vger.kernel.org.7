Return-Path: <linux-kernel+bounces-781291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6D0B31099
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E765A600F88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A922E88AC;
	Fri, 22 Aug 2025 07:37:16 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD70922DA1F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848235; cv=none; b=Cj7O5byTuuQms/hjSqwQl9HF6jaVlOVXpW7iAZgHcIOWUavAbE8lQaSpvYxYexs4zlJ+crLg/ZT5aSmMJU8FmQfdSd4GsRyDAuq0UNrcCru1uvOGN5/Qb0kOzRZo0B5HZ/FWC6g7+p9+LI1mn5KNKHAY16jgRW2csyIQNwZMaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848235; c=relaxed/simple;
	bh=krPOIuAnX1YAn/LSlLgHFThnWB2dzMlHdGdTX+Q+fpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QU6nsiq50Y4fRoEXFfvPM1io94GtM7KwbD6+sjEKLf2Ik2NVKcEwPABHQlEObNi4Ztc6dBgqOYDhn6QtK5yPMtwEvtZD2HSsqD+aUiZFN3+s2NM9ijZgNsjLqcz+uwDPadsbGJPnFMV0R+cxfmUCKe6knuG5kBKx0lnhPhavPNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53b17552198so603131e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755848232; x=1756453032;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FARPr6rK+Mbgdw6vlFkXYOZ64JiCWby6oGm3JaoyMM=;
        b=EqYdI+nS08b9+aX1hjkpWQVlOJpXgc6IifgG6RwpsK0k1gKwHWi5nMFuM187PsOM0u
         0qdLb1dPI5FWi5uRln0F3PlCRcwQ+xi3qwfiVrA3MEZAcLoFg9T9TqOua313QGhZjyh4
         2ssnxXt7eZlsdtS6zeCBwrBY4GpXJwjpoTBFUJa0/pjM7TzwBxFjOgxTSAEmnXLwOIML
         9Dd6uZKXOPMt30V80kEEkGMVtbhRk6EkOYdSjbbUZwJKkKOzooGtQLH+g8YPEeiV7H/m
         mhqhMYQxdT6JXLQUoJuuXsgp2WIvpY+mAX6x2E9kES7edrunWwOnM4XRjF/VvNbAit3A
         iXEg==
X-Forwarded-Encrypted: i=1; AJvYcCV7BnfQOpvt8ZJJSFcVXY2ZVrnU/gh2lN4/jx8jkHUIgvlPoaAVsIsSIS7wG6WZDCjwbeGfWCU3mQcGuAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSe1NhLpWTu41rFo9MtzFgxzOd3bFvr77Taa9CsYB6ScapH39
	E1yYW4BfwxLQN8gCL2yMH+vEht4oTBt95zemaTBSSGm5xH9vPJt0LVFXQiBtoTau
X-Gm-Gg: ASbGncsTRgSKukkXgS8OdsUddsdYrkNoQ/UBJ7YUmhZ5kNTeScqYQCKAYJ7zmmNRgMz
	fLxOgvEbqkSS1DG0VmG8cloAkK+Yc7Vcwt8F9HYfRnGPftUZ1gAl1eVEabIoSv+fk8QpAzjJISl
	nK4q/mpej7mpyxVu9xyGNE0SkW8fMJ66wbfyD8ZtbvnZwZssLuVhcMp3znwQjB7oAv9Z6jLmRvN
	UvmdjJLbnLcQ1dVwA46QqkSIkd/CI4dw4YGOPhoM79p7dKnkfUr0SYG64cjoJrUUXuZt59IRKbj
	eequPDLFHI0TzMn9vIqw2nL7Y8FWRV3C6GOjcqUq9wc5Ra2lkXi5UyhoqtMW5wGxA8v5pWjrgX5
	0GvVafXc2yCPp1/rU6x1rNDikp/rml08ekOrLdt5T4qlgr/L0U+r5t+H8op6b
X-Google-Smtp-Source: AGHT+IEKrc3utV24tBWZ1g3JES8MaOF+SJVBlSWQHk530WPhefkZdfE3+o6VXaFWMWMXbRljtuFwYg==
X-Received: by 2002:a05:6122:8285:b0:53c:6d68:1cd5 with SMTP id 71dfb90a1353d-53c8a45b6e8mr613060e0c.15.1755848232290;
        Fri, 22 Aug 2025 00:37:12 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53b2bd9a854sm4207608e0c.11.2025.08.22.00.37.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 00:37:12 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8901915d04fso432531241.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:37:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhfBBobfx7rU6prhNJSkShmZk38vMpttnCUhAflETMNUFVJWv3/yA7KPKjx/qi3aNaqIGZlv90ka48oJg=@vger.kernel.org
X-Received: by 2002:a05:6102:292c:b0:51a:4906:f198 with SMTP id
 ada2fe7eead31-51d0f712425mr493191137.32.1755848231779; Fri, 22 Aug 2025
 00:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627072924.36567-1-lance.yang@linux.dev> <20250627072924.36567-3-lance.yang@linux.dev>
 <CAMuHMdXR72M+oiJ_WmuHC0Xkq2m4=zqhP8DtW40mHyJTCdS+ew@mail.gmail.com>
In-Reply-To: <CAMuHMdXR72M+oiJ_WmuHC0Xkq2m4=zqhP8DtW40mHyJTCdS+ew@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 22 Aug 2025 09:37:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHFQcvHzYSQjXZduPUUiStS4Yyv45k5XNY2MeDjSjW0A@mail.gmail.com>
X-Gm-Features: Ac12FXxI_L5Ws2KwGrFXrK6I6fkxlxM84gwL4BbWTbOUZfcpCqY9qguqBwYwQ8o
Message-ID: <CAMuHMdUHFQcvHzYSQjXZduPUUiStS4Yyv45k5XNY2MeDjSjW0A@mail.gmail.com>
Subject: Re: [PATCH 2/3] hung_task: extend hung task blocker tracking to rwsems
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zi.li@linux.dev, anna.schumaker@oracle.com, 
	boqun.feng@gmail.com, joel.granados@kernel.org, jstultz@google.com, 
	kent.overstreet@linux.dev, leonylgao@tencent.com, 
	linux-kernel@vger.kernel.org, longman@redhat.com, mhiramat@kernel.org, 
	mingo@redhat.com, mingzhe.yang@ly.com, peterz@infradead.org, 
	rostedt@goodmis.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	will@kernel.org, Lance Yang <lance.yang@linux.dev>, Eero Tamminen <oak@helsinkinet.fi>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Aug 2025 at 09:34, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, 27 Jun 2025 at 09:30, Lance Yang <ioworker0@gmail.com> wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> >
> > Inspired by mutex blocker tracking[1], and having already extended it to
> > semaphores, let's now add support for reader-writer semaphores (rwsems).
> >
> > The approach is simple: when a task enters TASK_UNINTERRUPTIBLE while
> > waiting for an rwsem, we just call hung_task_set_blocker(). The hung task
> > detector can then query the rwsem's owner to identify the lock holder.
> >
> > Tracking works reliably for writers, as there can only be a single writer
> > holding the lock, and its task struct is stored in the owner field.
> >
> > The main challenge lies with readers. The owner field points to only one
> > of many concurrent readers, so we might lose track of the blocker if that
> > specific reader unlocks, even while others remain. This is not a
> > significant issue, however. In practice, long-lasting lock contention is
> > almost always caused by a writer. Therefore, reliably tracking the writer
> > is the primary goal of this patch series ;)
> >
> > With this change, the hung task detector can now show blocker task's info
> > like below:
> >
> > [Fri Jun 27 15:21:34 2025] INFO: task cat:28631 blocked for more than 122 seconds.
> > [Fri Jun 27 15:21:34 2025]       Tainted: G S                  6.16.0-rc3 #8
> > [Fri Jun 27 15:21:34 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [Fri Jun 27 15:21:34 2025] task:cat             state:D stack:0     pid:28631 tgid:28631 ppid:28501  task_flags:0x400000 flags:0x00004000
> > [Fri Jun 27 15:21:34 2025] Call Trace:
> > [Fri Jun 27 15:21:34 2025]  <TASK>
> > [Fri Jun 27 15:21:34 2025]  __schedule+0x7c7/0x1930
> > [Fri Jun 27 15:21:34 2025]  ? __pfx___schedule+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  ? policy_nodemask+0x215/0x340
> > [Fri Jun 27 15:21:34 2025]  ? _raw_spin_lock_irq+0x8a/0xe0
> > [Fri Jun 27 15:21:34 2025]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  schedule+0x6a/0x180
> > [Fri Jun 27 15:21:34 2025]  schedule_preempt_disabled+0x15/0x30
> > [Fri Jun 27 15:21:34 2025]  rwsem_down_read_slowpath+0x55e/0xe10
> > [Fri Jun 27 15:21:34 2025]  ? __pfx_rwsem_down_read_slowpath+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  ? __pfx___might_resched+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  down_read+0xc9/0x230
> > [Fri Jun 27 15:21:34 2025]  ? __pfx_down_read+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  ? __debugfs_file_get+0x14d/0x700
> > [Fri Jun 27 15:21:34 2025]  ? __pfx___debugfs_file_get+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  ? handle_pte_fault+0x52a/0x710
> > [Fri Jun 27 15:21:34 2025]  ? selinux_file_permission+0x3a9/0x590
> > [Fri Jun 27 15:21:34 2025]  read_dummy_rwsem_read+0x4a/0x90
> > [Fri Jun 27 15:21:34 2025]  full_proxy_read+0xff/0x1c0
> > [Fri Jun 27 15:21:34 2025]  ? rw_verify_area+0x6d/0x410
> > [Fri Jun 27 15:21:34 2025]  vfs_read+0x177/0xa50
> > [Fri Jun 27 15:21:34 2025]  ? __pfx_vfs_read+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  ? fdget_pos+0x1cf/0x4c0
> > [Fri Jun 27 15:21:34 2025]  ksys_read+0xfc/0x1d0
> > [Fri Jun 27 15:21:34 2025]  ? __pfx_ksys_read+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  do_syscall_64+0x66/0x2d0
> > [Fri Jun 27 15:21:34 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [Fri Jun 27 15:21:34 2025] RIP: 0033:0x7f3f8faefb40
> > [Fri Jun 27 15:21:34 2025] RSP: 002b:00007ffdeda5ab98 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [Fri Jun 27 15:21:34 2025] RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007f3f8faefb40
> > [Fri Jun 27 15:21:34 2025] RDX: 0000000000010000 RSI: 00000000010fa000 RDI: 0000000000000003
> > [Fri Jun 27 15:21:34 2025] RBP: 00000000010fa000 R08: 0000000000000000 R09: 0000000000010fff
> > [Fri Jun 27 15:21:34 2025] R10: 00007ffdeda59fe0 R11: 0000000000000246 R12: 00000000010fa000
> > [Fri Jun 27 15:21:34 2025] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000fff
> > [Fri Jun 27 15:21:34 2025]  </TASK>
> > [Fri Jun 27 15:21:34 2025] INFO: task cat:28631 <reader> blocked on an rw-semaphore likely owned by task cat:28630 <writer>
> > [Fri Jun 27 15:21:34 2025] task:cat             state:S stack:0     pid:28630 tgid:28630 ppid:28501  task_flags:0x400000 flags:0x00004000
> > [Fri Jun 27 15:21:34 2025] Call Trace:
> > [Fri Jun 27 15:21:34 2025]  <TASK>
> > [Fri Jun 27 15:21:34 2025]  __schedule+0x7c7/0x1930
> > [Fri Jun 27 15:21:34 2025]  ? __pfx___schedule+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  ? __mod_timer+0x304/0xa80
> > [Fri Jun 27 15:21:34 2025]  schedule+0x6a/0x180
> > [Fri Jun 27 15:21:34 2025]  schedule_timeout+0xfb/0x230
> > [Fri Jun 27 15:21:34 2025]  ? __pfx_schedule_timeout+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  ? __pfx_process_timeout+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  ? down_write+0xc4/0x140
> > [Fri Jun 27 15:21:34 2025]  msleep_interruptible+0xbe/0x150
> > [Fri Jun 27 15:21:34 2025]  read_dummy_rwsem_write+0x54/0x90
> > [Fri Jun 27 15:21:34 2025]  full_proxy_read+0xff/0x1c0
> > [Fri Jun 27 15:21:34 2025]  ? rw_verify_area+0x6d/0x410
> > [Fri Jun 27 15:21:34 2025]  vfs_read+0x177/0xa50
> > [Fri Jun 27 15:21:34 2025]  ? __pfx_vfs_read+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  ? fdget_pos+0x1cf/0x4c0
> > [Fri Jun 27 15:21:34 2025]  ksys_read+0xfc/0x1d0
> > [Fri Jun 27 15:21:34 2025]  ? __pfx_ksys_read+0x10/0x10
> > [Fri Jun 27 15:21:34 2025]  do_syscall_64+0x66/0x2d0
> > [Fri Jun 27 15:21:34 2025]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [Fri Jun 27 15:21:34 2025] RIP: 0033:0x7f8f288efb40
> > [Fri Jun 27 15:21:34 2025] RSP: 002b:00007ffffb631038 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [Fri Jun 27 15:21:34 2025] RAX: ffffffffffffffda RBX: 0000000000010000 RCX: 00007f8f288efb40
> > [Fri Jun 27 15:21:34 2025] RDX: 0000000000010000 RSI: 000000002a4b5000 RDI: 0000000000000003
> > [Fri Jun 27 15:21:34 2025] RBP: 000000002a4b5000 R08: 0000000000000000 R09: 0000000000010fff
> > [Fri Jun 27 15:21:34 2025] R10: 00007ffffb630460 R11: 0000000000000246 R12: 000000002a4b5000
> > [Fri Jun 27 15:21:34 2025] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000fff
> > [Fri Jun 27 15:21:34 2025]  </TASK>
> >
> > [1] https://lore.kernel.org/all/174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com/
> >
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Lance Yang <lance.yang@linux.dev>
>
> Thanks for your patch, which is now commit 194a9b9e843b4077
> ("hung_task: show the blocker task if the task is hung on
> semaphore") in v6.16-rc1.

Sorry, wrong email thread.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

