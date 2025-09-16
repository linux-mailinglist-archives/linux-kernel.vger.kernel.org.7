Return-Path: <linux-kernel+bounces-819516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF0DB5A1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 22:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8601BC786F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83722E7165;
	Tue, 16 Sep 2025 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIsO8RsE"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8272DE1E3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053324; cv=none; b=PqELe3qWXj7hy8vghmmV5GjEpR5n29zxKIiAMpo1ZMKW3eCBbBgGLkIXNFz/SQq32wXNnNuDILjfPWBLzhxBG8iRTQ6z5U3igEyGM01KvKJ9PXqoThWEUPmHIADOYlHuT68ZjygxT4B95D77pJ7Ol+r+QkPd+EBSiwAWRKr13sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053324; c=relaxed/simple;
	bh=G6CklpEIQ7Jb943ATNScD0+tWQkQ7nBD/btfivKvGhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5HylhJnWjVQQ9L2ikp8tE+lDOzyZYMxWO433/1DQAdQNUBZH7dd5Dc1uwYttzqXFKMy5KgkY7LTzWjIaSGdjOEi4czVvOMNe3uVbSGhhAksvodVnHRreXZ2u3FQpMnFcbub8xHp2E9gC5Q/6J+W0/edWRBLtQum6Bvhjys8dDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIsO8RsE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-265abad93bfso42445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758053321; x=1758658121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9Lkzd2qHU0WJpoFh7WhpO5uCyrQhSbia0bX3ioP2o8=;
        b=zIsO8RsEJUD145hvelYKaRsx+Qzp3myczur3fTapMhPMe8OLfWYGEiqq+GcZGCrZbh
         6t2PEOuPETyirK648hJm39rPPifyTwFGUkvxjnXUx+6x7ySOVRPYM3RsNrUqR/1eP9Xs
         IT1EYvr8SVx5HImaqGGOixVUpRYlu0fblK6fLIyEermjTwmzKjetgRXUhLJAnq9e6jLr
         ViZMKxZ+ER0UVe1W6adZTxDTdi0t5hdouLsnkKJpGq93pgRVet6eQqE8aMfV1qs7SekM
         6dhu9MdNDUF/n+arUEFaJlawiZmrobf8Oa+9uqwKRTSc7qFjzy+KhkCh4LHgwSI8y8M1
         RsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758053321; x=1758658121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9Lkzd2qHU0WJpoFh7WhpO5uCyrQhSbia0bX3ioP2o8=;
        b=bM+BN3HXwu0S+903B3bX/NSbG8hYSbPeJeo60/63+ZasEYAv359W2jJRD8gAu2oOfH
         K06il3M3PRnEPFNrL5zsWMC60/3K+FCnCvVUwO+KOWgC06mmvDBGy0R2zUfY2sXFsWPq
         t8Cq8EpvMNNsGGwzTiMDJ3P/D1Z0RtwP6d8fYmJ7TDuFr6saLSVMQOCWgYYYJRFO9PoH
         wuA+rU7/+h8d3D1MRQ+vUxH1dkl4jmlYYocJF/zeizhKej/PjBbdcQMiw8U4gOEfV3OS
         s0MFy5wO864vjGDLEIF7/wC02Y35Oz9YNV/MnO3Irtj/h7rYaMGgDtoSGtWghP7rcNsc
         js2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPk8HW7LOBYq/zSnnpVUnR6B+Je5goCRwGIHFo6QOEQn2qK8/Ykzo+amgDkQJ6K3PqjUg9Q5OKqgknZ7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKBYWPwyheqkQHjZ6ed5LAYu7xOMrgwb0kA8ZNgAqkbH4fn8xk
	dDt4eCdPy9Ixd+jSWVKhLoXA39DMxE+ZT6n58tpLUWuqitfyATIadrqpGiDk0b7tkaDwTeKGM6G
	+UYxLgBAgc9yW/TfLuq7k6rfEjJOnoyODYJnvhiZ7
X-Gm-Gg: ASbGncvCXOYIb6i72V+3NmgtI6evVRA9KIiTAhFqxT7lyWt++L614Tcnn7TgnTsMEzn
	R4/nhp0KeS/ykU4GWGlFB52FfAAQdFOWrSOWzCHcdXNXv0dtORn+Y7ujLuXXHCRMT1/YV8EO+pE
	Em5Tmjhz3Ht+eXqfxSYJZ7+NaPpg+WL2Na6YGyJZ7VOjYXYfZSPKr/BCwrGwuNuMpi6Vx1l4746
	EMWbYq2UBvgqS9DE8GJWIC0+rs1XXEFYQZ/iIbCCEi5V1Uxx1s=
X-Google-Smtp-Source: AGHT+IHB+zIC9M5csK1y9pYvqYGZ9e1a8g5vFs0VSlYor4LBlSAEw+sh6AmBy5K67UD64uBbR+RJ2cXCghc/d1plz/M=
X-Received: by 2002:a17:902:d2c9:b0:266:b8a2:f605 with SMTP id
 d9443c01a7336-26808a2fc00mr122185ad.3.1758053321270; Tue, 16 Sep 2025
 13:08:41 -0700 (PDT)
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
 <20250916140245.5894a2aa@gandalf.local.home> <CAC_TJvfAQDiL9PydWnKE6TDMcCzw0xrsLMZVZLe6eO0R1LODhA@mail.gmail.com>
 <20250916145146.046f56a8@batman.local.home>
In-Reply-To: <20250916145146.046f56a8@batman.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 13:08:29 -0700
X-Gm-Features: AS18NWCVdunjcrUP7tBqVqoMShUmOYlO_Ndh14lC0p7nbWIxXHPwlnQ10YTDEow
Message-ID: <CAC_TJvc2MwQHvY_ry=a4CGA_zEw2TE8R_K520Eizjt83At0N_Q@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 11:51=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 16 Sep 2025 11:23:03 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > > When it comes to tracing, you already lost. If it goes into the ring =
buffer
> > > it's a raw pointer. BPF doesn't use the output of the trace event, so=
 you
> > > are exposing nothing from that. It uses the proto directly.
> >
> > My understanding is that the BPF tracepoint type uses the trace event
> > fields from TP_STRUCT__entry(); whereas the raw tracepoint type has
> > access to the proto arguments. Please CMIW: Isn't what we'd be adding
> > to the trace buffer is the hashed mm_id value?
>
> Ah, right. Can't the BPF infrastructure protect against it?
>
> >
> > >
> > > Heck, if you enable function tracing, you are exposing every function
> > > address it traces via the raw data output.
> >
> > Right, security doesn't allow compiling CONFIG_FUNCTION_TRACER  in
> > Android production kernels.
>
> Does it block all the other trace events that share pointers?
>
> Like nmi handler tracepoints, x86_fpu tracepoints, page_fault kernel
> tracepoint, tasklet tracepoints, cpu hot plug tracepoints, timer
> tracepoints, work queue tracepoints, ipi tracepoints, scheduling
> tracepoints, locking tracepoints, rcu tracepoints, dma tracepoints,
> module tracepoints, xdp tracepoints, filemap tracepoints, page map
> tracepoints, vmscan tracepoints, percpu tracepoints, kmem_cache
> tracepoints, mmap lock tracepoints, file lock tracepoints, and many
> more! (I got tired of looking them up).

Hi Steve,

I see your point :)  I'll use the raw pointer and handle not exposing
it from the BPF side.

Thanks for discussing.

--Kalesh

>
> Again, are you really protecting anything if this one trace point
> hashes the pointer? Most other tracepoints expose this. If BPF can
> access a tracepoint entry struct, it can access the raw address and
> break KASLR.

Thanks,
Kalesh
>
> -- Steve

