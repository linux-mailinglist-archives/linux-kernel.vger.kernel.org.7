Return-Path: <linux-kernel+bounces-819420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF404B5A072
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FAB22A0BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615B2C11E9;
	Tue, 16 Sep 2025 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHZOcV+c"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECC286419
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047000; cv=none; b=VtXV2TrKnTz2ruyuWwf0MKt6Lx3xBclSzitTit6puGB4jkPZ4CEIDgw57roiVEmSS3ccJgHSoOvN+l6eqi0N3/+WloZpIAIQ+2z9rkgNhe6QExq9IvXa8IBJPykJZPAyBqdHBlv0WzSGWn/VNM9Wgi2g1WnraJzh4/HnFw2HhJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047000; c=relaxed/simple;
	bh=MWP0yXO5hqblKAsf86sVb92EBQ6Tee6NsUCw9nEvo9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxruMw3YRGiUdwv/NUkJxR6FCOXDwkEF6iUVmj8ehv9LnXbmshd31MOUDsYC2+lHC5174oBzutbcsl2yhlNYhXKI8Akzawmu9XkdG7UlBxkG6lBaLukdU5QLECVXXivdSqHSa9uPWWCkxCzFN4YScwbyhEEFpqgVncP1aP8G1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHZOcV+c; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2637b6e9149so26395ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758046997; x=1758651797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxUZE7TC0xZyMAyFa+6mdSBsb32RFob5X99goi87Xdw=;
        b=BHZOcV+c6MvOfCF65mjwe2IECKvFxVl2aV2YgpzUCnkCAPcYhJJVMweggAcfmmLOIe
         2RV9aX5ubl/xGN/A9Lkl5iHYRnNCxLahMeFB20QpHZ9A2tT5gcx7soK4U/UpdeuVma3J
         i7n2UtmYDVwc1SaptmDPUfClDnslr+ozNmj5dYzjpjQezKEsa78W3yEy7ZoHBtB5t6LC
         mGTdm6imIgfYUrVjpyDpmmZPjgaLHYwlkTGoOq3oyYSpDSrPFi7DGlmKfh1sENmglEgC
         VTzOtoHzZYMDNNZSWa5FLUzvl8D2OI+o2UaZmkoxNav7lwfybTzYQRQCeac5o7ljViKc
         5rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046997; x=1758651797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxUZE7TC0xZyMAyFa+6mdSBsb32RFob5X99goi87Xdw=;
        b=I0Rn3f0OgGCM92U92LJIBp5AsFM86ZtumgqqUmimB9u4fkP88bwzNknY02c6c30RDi
         8aWxXkzXfnxwUfeeN4ex+1+G3oEmUNfkCGt1pshOArPKWw6JLfn6Zn814yL5zRTf9T2c
         CVcgfWo7w/HE9MIMH1WjiJHiEAQSAsoiU0l2tsw8wlyXwBXrWPnPlQPPFVLiitKCqZpH
         9rhHaR8JNwdczeh0fS7+SCWeexqr9C8vvlSMy0cwsYdnesIpjGkS+9ZiDh0q/q2BgRFz
         H1lzFqWLMQ0yjLo4qCNcBmoD0qoxZ5lyK/d7K+koMZK3ImdD0O0q7CPtiE25NX2pCpGO
         P6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlxOQ9cyhDK26taT4wv1MIiuFg8ntId2IyvA0+dbuJ7l4t/o/RFkcu+2YivR0S0VypA/yZ6h8hj6m1bv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMsWEzYeOU3q2zKFa/bz6Lekk6E6NMCveVUIMx1NwmBEQPCfTV
	/XcwOk2+e3gcB5kFVfXMNYy3Hw7UwobusaGUJFiJYERk/6w5UHlrKkpibQU3PKRh5fk8MFP84Jf
	IXJfSlXX2D2vW3504pKVnnKhiONInaHf9G6lupnxS
X-Gm-Gg: ASbGncvZ3rdGD1XTCyayG6gAsQODmggIdJmX41HWeDlDGIwHLGJtxR0Gqq60fK32QfA
	GwiffrAKIY5ADEw0fbPVmj7L7TJDIBdSXzIDALgHXUvAl/dlB7h9HVWU7Ij62/PtF9XpP0QaZVm
	O3xI0azWSPqpWRugbbuorZZAsCTzvzSz9lhxvrMzd7NEqywt0nT/4UWivbYmunm3Yvffn3dZwTX
	e7t90ymqJg65RxL7qv5FJfmhULNh9JRxGgu7QHHmCcBaiEpvy8jwmg=
X-Google-Smtp-Source: AGHT+IFeMeqAy+cuIfy8BDPUr07CVnLWSx0isY1COTxmQUhbfeHhUc/gJKs+z9vTXpQo6NDvDMpWAnnnlJDkjgySN7E=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-2680120ed16mr333025ad.3.1758046996934; Tue, 16 Sep 2025
 11:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-8-kaleshsingh@google.com> <20250915194158.472edea5@gandalf.local.home>
 <CAC_TJvconNNKPboAbsfXFBboiRCYgE2AN23ask1gdaj9=wuHAQ@mail.gmail.com>
 <20250916115220.4a90c745@batman.local.home> <CAC_TJvdkVPcw+aKEjUOmTjwYfe8BevR51X_JPOo69hWSQ1MGcw@mail.gmail.com>
 <20250916134833.281e7f8b@gandalf.local.home> <CAC_TJvc6aqjBRZ05wyGb49AU+-aKpSph=ZSk3fdV2xraXi-_nQ@mail.gmail.com>
 <20250916140245.5894a2aa@gandalf.local.home>
In-Reply-To: <20250916140245.5894a2aa@gandalf.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 11:23:03 -0700
X-Gm-Features: AS18NWDeydKXZzxWqGElteJppqO6QozHlpb4s_Ylp5BcEhKGMmDvVoyYUojBOGg
Message-ID: <CAC_TJvfAQDiL9PydWnKE6TDMcCzw0xrsLMZVZLe6eO0R1LODhA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] mm/tracing: introduce max_vma_count_exceeded trace event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 11:01=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 16 Sep 2025 10:57:43 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > > BTW, why the hash of the mm pointer and not the pointer itself? We sa=
ve
> > > pointers in lots of places, and if it is the pointer, you could use a=
n
> > > eprobe to attache to the trace event to dereference its fields.
> >
> > In Android we try to avoid exposing raw kernel pointers to userspace
> > for security reasons: raising /proc/sys/kernel/kptr_restrict to 2
> > immediately after symbols are resolved for necessary telemetry tooling
> > during early boot. I believe this is also why rss_stat uses the hash
> > and not the raw pointer.
>
> When it comes to tracing, you already lost. If it goes into the ring buff=
er
> it's a raw pointer. BPF doesn't use the output of the trace event, so you
> are exposing nothing from that. It uses the proto directly.

My understanding is that the BPF tracepoint type uses the trace event
fields from TP_STRUCT__entry(); whereas the raw tracepoint type has
access to the proto arguments. Please CMIW: Isn't what we'd be adding
to the trace buffer is the hashed mm_id value?

>
> Heck, if you enable function tracing, you are exposing every function
> address it traces via the raw data output.

Right, security doesn't allow compiling CONFIG_FUNCTION_TRACER  in
Android production kernels.

Thanks,
Kalesh

>
> -- Steve

