Return-Path: <linux-kernel+bounces-781378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A2B311CF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 414561C8738E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0212EBB85;
	Fri, 22 Aug 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oMob5sME"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6B42EA475
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851137; cv=none; b=Eq+bwQKoJeNnnhynq9BLkUmgWu5bVTYHq9TTQ+7Q4aKJliZYr0+2Mlhzsa4dPpeUhsakCKGlPgRWmd2dz9vuVj9qZZHKkzLLxyUn2ARoWsW/xWq9CKOwqhT+Q+D0CU7vCzrKrcHxJdYgro7GlGgtlCpt9K+6CfX9jRC5UfGsQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851137; c=relaxed/simple;
	bh=zlLmFvLNDW9vN7b5IXbmzEIC4ELhBoJQAVXG/6TWmus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxvWfWBMtpqQhy1xmFhnViYL4Y++8kyge2pU7b8ooqUfPUGQca0w2AlIFL4DHYQLrNum1/Qtyw4QC9j84NJB7ANU2bew3DWatB8yCZsfx+HLCsWDtSDIOtqnGIWwixloCr6MaEJVot8l7KTn1Aj4U9C0msxFDHuhUMWYWjTxE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oMob5sME; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1783303b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755851135; x=1756455935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6gsZaSXQ47LkCep2YQ4+/o/o27alg6LEKbwJk8ujjM=;
        b=oMob5sMERBfqA8dXLxAwpbNa7M6lHgymHVDMCO0hAaJYpc5SYjGQvozXO8kBi0mod2
         222F/JLi+BTWxucgJ83GqaGcgJz4S/e9psI88R55iVol7g3IxnVRvsTvqSEUQMTVfeb+
         ruCbq0fT2MX5TYxNT3XUQ5/qa8UswtyyNwDvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755851135; x=1756455935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6gsZaSXQ47LkCep2YQ4+/o/o27alg6LEKbwJk8ujjM=;
        b=Ix1t3bAJERFoosVKOkS68swNvE4gsrntqvWG5JQ77VY5thG9jFnD6kZmOh2oawkMEW
         vnO98HQNOtWixAtOTzTXtVqbrB6Q6Gei55G3DEHUomPXAlV2s50uKEMZW/q7fbZnQSqT
         uQsZNo+8ZE5NNSXlqpSsK+yflzHM2PJ5RzhkG7TClpFQyz3kOytKG6q2YRAXQQy4CpTQ
         z8x+I2ZkMWKtCrqikxUZfI5Wzbz1iuWanxTbb1Bq+Hnj/p1weaXSLIkAMJydTGVvZdSH
         3jdP9lFhv26vDgBVz76RUAlomAnEPh3u3HyJWCK1LRT5JBRRZMb9etLToQ8DGvemCaXy
         4svg==
X-Forwarded-Encrypted: i=1; AJvYcCWN1pg53/iW8RAO0CqUQYQIJhA3chO/hdAaD/FCMmvhtmBaKpq/7UhYMcJVgEQ281Ib+n8F1cPawkXTq3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBzOZ7POY+ezGYGblYH1c8cw8t+gVWtIyQ6HVceuM9LKuK0kV
	AGXNmcP2niqynLmj3uTD2fT91GMVZiLBDbHZyBHlewY+wTuwvu2YeHuINBxfQraJ0g==
X-Gm-Gg: ASbGncv7b5d8LqRZd8AY3cT06p02cgOWrvo2L1Dpp6xHkfb1Uup54x4ta6Di7DuxXsu
	EHfLMcr59P+7M4ZkWHnVfAlUVDPCHYiPotQkHs6Jb44y9EFdv1yTZ55EkX57amj/yxB4jBd/tuM
	DMPyzeGF1b70o8AEiGC8c2ubh03TEuP7jwqkM+xKXwr1Ep9ZAbEW7AtOypJkBDg4j2unN9k9Dzf
	F4DOAeT4kJg6fXy4HCGkpuHQ7zy9BnaCflFzpXT1iCT0kz3NsOlUr1LlNIKMpc5hRjq6cjicyiH
	k2ONWWO8/GgQLsS9ZNsOOhk5P39KIPDTpTA+yQqrsDJ0aGpghQhi3qWGJ4rlDPc3vi6jrSNrs8P
	urrv5rgyW2tG5qjEYpDZqXQREgw==
X-Google-Smtp-Source: AGHT+IEpxfwjdV9ouQebW2LxlFa+cZmxXdr0EhECma1StQf8MlFvFhPTw888sARkRnBbURAQZ8iZfg==
X-Received: by 2002:a05:6a00:3cd3:b0:76e:3d16:6e7b with SMTP id d2e1a72fcca58-7702f9ede7bmr3258059b3a.8.1755851135040;
        Fri, 22 Aug 2025 01:25:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:2920:8e55:4590:b98f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cdfsm10103999b3a.63.2025.08.22.01.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 01:25:34 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:25:27 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, 
	zi.li@linux.dev, anna.schumaker@oracle.com, boqun.feng@gmail.com, 
	joel.granados@kernel.org, jstultz@google.com, kent.overstreet@linux.dev, 
	leonylgao@tencent.com, linux-kernel@vger.kernel.org, longman@redhat.com, 
	mhiramat@kernel.org, mingo@redhat.com, mingzhe.yang@ly.com, peterz@infradead.org, 
	rostedt@goodmis.org, senozhatsky@chromium.org, tfiga@chromium.org, will@kernel.org, 
	Lance Yang <lance.yang@linux.dev>, Eero Tamminen <oak@helsinkinet.fi>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH 2/3] hung_task: extend hung task blocker tracking to
 rwsems
Message-ID: <twh66isgxspp72gz7u6bbfxkcyzxgggzqfma7cl37xrvd5k2aa@ibfr6ogn5ylk>
References: <20250627072924.36567-1-lance.yang@linux.dev>
 <20250627072924.36567-3-lance.yang@linux.dev>
 <CAMuHMdXR72M+oiJ_WmuHC0Xkq2m4=zqhP8DtW40mHyJTCdS+ew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXR72M+oiJ_WmuHC0Xkq2m4=zqhP8DtW40mHyJTCdS+ew@mail.gmail.com>

Hi Greet,

On (25/08/22 09:34), Geert Uytterhoeven wrote:
> WARNING: CPU: 0 PID: 39 at include/linux/hung_task.h:48
> __down_common+0x13a/0x1be
> CPU: 0 UID: 0 PID: 39 Comm: getty Not tainted
> 6.15.0-rc6hatari-00018-g194a9b9e843b #1986 NONE
> Stack from 01633d00:
>         01633d00 00366e9e 00366e9e 00000000 002c9762 00360cb5 01633d24 0000873e
>         00366e9e 01633d40 0002e0d4 00360cb5 00000030 00000009 0039c79a 00061408
>         01633d78 000028e0 00360cb5 00000030 002c9762 00000009 00000000 00000000
>         7fffffff 00000002 1185d266 01633eb0 01326c58 00000080 01633dc0 002c9762
>         00360cb5 00000030 00000009 00000000 00002014 01326c00 1185d266 01633eb0
>         002c93ea 00053d60 00061408 01326c58 0038db90 0038db90 01633e32 01633fb8
> Call Trace: [<002c9762>] __down_common+0x13a/0x1be
>  [<0000873e>] dump_stack+0x10/0x16
>  [<0002e0d4>] __warn+0x7a/0xbc
>  [<00061408>] msleep+0x0/0x2c
>  [<000028e0>] warn_slowpath_fmt+0x42/0x62
>  [<002c9762>] __down_common+0x13a/0x1be
>  [<002c9762>] __down_common+0x13a/0x1be
>  [<00002014>] arch_local_irq_enable+0xe/0x22
>  [<002c93ea>] mutex_lock+0x0/0x28
>  [<00053d60>] other_cpu_in_panic+0x0/0x26
>  [<00061408>] msleep+0x0/0x2c
>  [<002c97fc>] __down+0x16/0x1e
>  [<002c9832>] down+0x2e/0x30
>  [<00053dac>] console_lock+0x26/0x4c
>  [<001aae4e>] do_con_write+0x3a/0x16d4
>  [<002c93ea>] mutex_lock+0x0/0x28
>  [<0004fa70>] __add_wait_queue+0x3a/0x6a
>  [<001ac520>] con_write+0x1a/0x30
>  [<0019cafa>] n_tty_write+0x2c6/0x35e
>  [<00199456>] signal_pending+0x0/0x26
>  [<000aba2a>] __kvmalloc_node_noprof+0x3a/0x114
>  [<00004cc0>] io_uring_try_cancel_requests+0x98/0x318
>  [<0004fb2e>] woken_wake_function+0x0/0x24
>  [<0019a180>] file_tty_write.isra.0+0x144/0x1b8
>  [<0019a206>] tty_write+0x12/0x16
>  [<000b97c2>] vfs_write+0xec/0x148
>  [<00028000>] fp_getdest+0x1b8/0x224
>  [<00010000>] g_trace+0x16/0x28
>  [<000b9916>] ksys_write+0x54/0x8a
>  [<000b9962>] sys_write+0x16/0x1a
>  [<000093da>] syscall+0x8/0xc
>  [<0000c001>] arch_dma_prep_coherent+0x51/0x58

I'm struggling to make any sense out of this backtrace, this looks
like random ksyms names.  Any chance you can get more reliable/informative
backtrace?  config-debug maybe, or something.

