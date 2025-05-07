Return-Path: <linux-kernel+bounces-637926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A40AADF2A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 14:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D6E7A9D19
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 12:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7388D264A9E;
	Wed,  7 May 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PEwP1aAD"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A892325E815
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746620992; cv=none; b=STsrAF2R6AK9xuHGL32IgNMAfNeIFcoZI00BCnIYx2xDorJjToxD/ZF/p+lvSwDzL8HIdZt6Gyd9wVhe8tUg7kzRjsixIgCsC0kYw8xvgLgolhxUimVO8G9M/O5bCZnkA5ZfGRx5e0bV4Un7EuaulHoohCi1vq7VvYFpq94Q6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746620992; c=relaxed/simple;
	bh=Mqaui1F9/bOT/JMKClMuGVkx2vOY4zGOZ5ph/2yYf6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHoeTPiHC01phrCJ1rRgSnF8pakaE+vqotTMnnlPYC1X0rHXCCLbYACQoHHbEdMcil9mGhd+hso5TPC0evs3yz+mXVjfQ9Z1Qm//0L74RUZCG2PvZlRMfoCKvy5XB98tPa0d5/GoiscmoChM7xwnVuZOtgAf2FSNScWxPNpkoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PEwP1aAD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fbfa0a7d2cso590754a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746620989; x=1747225789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZW0x6+aPcBTGf4RTVQ8qhVtJhNXiKy2eXwn1Y4GghS4=;
        b=PEwP1aADFuIaRTSntQhykyjqBYcV858AXTJdBoF0vhOJ2NnxgFwT9S8QzO6/8u3TOX
         YXD4/bPwrqnTmZFsKlA4nGKofy/QJj+cfTLQw1hh07Z5sRfHM9GQJ8dB2iQWcv6i2sBT
         W8oHd1QIsuQLaDNOIwpDO23SjAVdeUkshwbyrFQQtSpmpwKyP9yW87HHOgfyxnPDRyYq
         j/nMHNJEUi2sVU/dP35gqIDKdsfWlFqWzCL/z9PLr8f1IcYkwoZTfJ2zatcIA3DU9S93
         ySS9oacZGkqQ8a3yXGmVdRyv9rOHoZLziVQEbEVr8eeeM7XdJ+iv3Uy3OFJSXJ8ZpqGO
         yqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746620989; x=1747225789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZW0x6+aPcBTGf4RTVQ8qhVtJhNXiKy2eXwn1Y4GghS4=;
        b=WSNHrUy8UQ0IYSeKri4+AXFVPW5DXx9jnPcIbvbfVIwFpAoJ+OdZ/VttgBN7hKNdLn
         NRJhfqx5C7RoDc0tb1egMpuJNuIo0cK8/gDGJjSVqElyg4K/vJ+sryMNQeHD8CvS0bId
         dBcHR1sgmJLpBcsI2bmQkiOZMvBnS70oZyS3m8lYzO86pCpryAqjlsSpMDhrM3IhqudG
         jyoiM5UvTpTO4T9+w5BQupxBfwmIrL3APolrcJ8aLq7inNYF6oeyp0dOc8B9hf/xB6LB
         wbglqwOAqvjU1+lWX4XIy/BE7AznRIAEUDgSlFM3X6ECWZXqw27blD3sXyv69YLP5XVn
         0BmA==
X-Forwarded-Encrypted: i=1; AJvYcCVo8/ZulfLZl6kP8MTVYa3y5luj4uuEO+9SS8IehPX+7+5r7doWFpAav1QZnGdVXTGU9onaYeWlPjeKcws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvUKWq5dWhYfxt6MuvPeuZ95Qd4IAIBHQcKtC0AoBIMBhDTEx
	3dpc5HMP2eMcTjWsASMgI9zlxqMVB+365zw9wTRiQi8KvhKn3kznb1TXDS63EU4=
X-Gm-Gg: ASbGnctq2Vhgo/y1QWs3+/1hHSREq4yKUu4InQ+v8GjehJ6kA9fSVbe3itXQUXAm+gp
	PwPZ2b/qmQt2vyyNqglflkaVEt9OjVtw0pIEObjna5x30ZIzPU8/9SRGtaqcvUvToBIJ2lsM04r
	rdBZmSv9tJI39dWOECoGlMrS3e/jWKi82umcHOSSyTYGNge/U9NHXK5bQU+99CJa+tU8orOnVon
	uwBIdRqQX+sr6tqH5MzUN1JSdsNP6O6gDEqPHqUMHVT6Ps+dy67YfdGPugO1VhPg+MaWdC+lhLh
	jKBwV69UCOo6Dmw8VBOMvVxodM1+fUhuynFoLzrn
X-Google-Smtp-Source: AGHT+IFcaF2HbosKXMSG7ssx4/Idj9ECcUf+SjKCY6flcCBO1BJAIS54Xv8b1MSnCIFm4q1ZvQeSUQ==
X-Received: by 2002:a05:6402:2804:b0:5fa:aa28:b10 with SMTP id 4fb4d7f45d1cf-5fbe9dcd645mr2810548a12.13.1746620988876;
        Wed, 07 May 2025 05:29:48 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa777c5c3asm9429175a12.21.2025.05.07.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 05:29:48 -0700 (PDT)
Date: Wed, 7 May 2025 14:29:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
	laoar.shao@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
	david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
	ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz,
	mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v3 2/3] treewide: Switch memcpy() users of 'task->comm'
 to a more safer implementation
Message-ID: <aBtSK5dFmtFXUaOE@pathway.suse.cz>
References: <20250507110444.963779-1-bhupesh@igalia.com>
 <20250507110444.963779-3-bhupesh@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507110444.963779-3-bhupesh@igalia.com>

On Wed 2025-05-07 16:34:43, Bhupesh wrote:
> As Linus mentioned in [1], currently we have several memcpy() use-cases
> which use 'current->comm' to copy the task name over to local copies.
> For an example:
> 
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  ...
> 
> These should be modified so that we can later implement approaches
> to handle the task->comm's 16-byte length limitation (TASK_COMM_LEN)
> is a more modular way (follow-up patches do the same):
> 
>  ...
>  char comm[TASK_COMM_LEN];
>  memcpy(comm, current->comm, TASK_COMM_LEN);
>  comm[TASK_COMM_LEN - 1] = 0;
>  ...
> 
> The relevant 'memcpy()' users were identified using the following search
> pattern:
>  $ git grep 'memcpy.*->comm\>'
> 
> [1]. https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/
> 
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -53,7 +53,8 @@ extern void do_coredump(const kernel_siginfo_t *siginfo);
>  	do {	\
>  		char comm[TASK_COMM_LEN];	\
>  		/* This will always be NUL terminated. */ \
> -		memcpy(comm, current->comm, sizeof(comm)); \
> +		memcpy(comm, current->comm, TASK_COMM_LEN); \
> +		comm[TASK_COMM_LEN] = '\0'; \

I would expect that we replace this with a helper function/macro
which would do the right thing.

Why is get_task_comm() not used here, please?

>  		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\

Also the name seems to be used for printing a debug information.
I would expect that we could use the bigger buffer here and print
the "full" name. Is this planed, please?

>  			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
>  	} while (0)	\
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index bd0ea07338eb..94a941ac2034 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -214,6 +214,7 @@ DECLARE_EVENT_CLASS(block_rq,
>  		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
>  		__get_str(cmd)[0] = '\0';
>  		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> +		__entry->comm[TASK_COMM_LEN - 1] = '\0';

Same for all other callers.

That said, I am not sure if the larger buffer is save in all situations.

>  	),

Best Regards,
Petr

