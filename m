Return-Path: <linux-kernel+bounces-819392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA41FB59FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417621C05394
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D826532D5D8;
	Tue, 16 Sep 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxQ2mHJF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9963EACE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045478; cv=none; b=SMdOWJtnJBuTFk/JTnAoWEGG0FBIsdTJzAcFsxKAfDKhGtRRhee8Im1Kz21fby2Gz/agnlNTczoQtEdv1xLnmH5o4M10kj2E8RaNKFjbUSZhKC3QTZLvf66hjy93sOHgMocW+MVCRodSW8aO447ltdnjFUgtg2B4ylauOyjCZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045478; c=relaxed/simple;
	bh=zTIsny0j4ESzYhGc69c5iIOG8DDTi7Xyon66+klf/yQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvMX/og355byqLKUBOPKmhPH/spITyD6XRBxEHEJpA+SmDy9Dl1EZmuRgIFZLEe0XXV7UdblNmC71cGi3DC5cZyJH+FLiji7lKGkugdoCbYCy//+dh3k1rJtPMxsSRnHiciuF1Wk/JTeP+PEoyFOPQHM8pD93micjoqoGK1DDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxQ2mHJF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-267c90c426dso21325ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758045476; x=1758650276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTIsny0j4ESzYhGc69c5iIOG8DDTi7Xyon66+klf/yQ=;
        b=IxQ2mHJFksAjwiKMp+8HY74q1i9vBJT0GEZMLF0iQcYUBwUXIu8SsvYNCKnPVbkVb6
         rX92i/la24a+ITL+7nzR86R21ihixylJap8q6NO0qi+uwnBWdUn2ZWFSKJ0hWBL9XqwI
         8B3aYWQxL+Pgx276zqcE/M22L+fXa1RC38do2i13fR4Bmic0MKXGkLUsLcXzLbPINtRL
         neng8DiyDR4KyBZJurIOxYIX+ulDzK3sneEe9McmyvZRbZeSHagizaqjDJiMeglmPa75
         XDfLTJG/0JXcWe+bCOEJVdtiHRg+pz3CinydTQzKrG7mzpBNcDBoUQz+Fn5kVtxwDY/8
         Y3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758045476; x=1758650276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTIsny0j4ESzYhGc69c5iIOG8DDTi7Xyon66+klf/yQ=;
        b=dy8UcVIOYRHxotwobOlAB5ohKJiVO7QQe+mjIyZscJCpdvyCyEj+/wZPgifDXrb4Mr
         QZAyowqxmE7NAYB2ZNpHWojYw7iW0zhbFNb45rbbnnKILKctLX4RgF/3dieYXKKHSmDo
         +ctjxa4Sf0eR0jwgEoPDojPbweURm5F47Vkrqhp0tRSjT4YfVZDsMi+a4pATfNXJEL7r
         j2jZsAV1bOuMVAvps3Sc/qtPkSKSzlP14lLPI+J22QIhS+luEkr9Gu5c6AoXjRzTfUNc
         /8OO5nBcIVHX0vfS9byvHDbeEHSook7TeoglQjkXlIFZJhcXQVmFEr6KJU8AWfxVNbzF
         sotQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAXtztgC4A8aFpR3QKfrc7JNsZbUiAC2HJ0Uo5JKdAOxrlLXkEyAGLNYznj3WTRID1C6Qb+PiqkJklC0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9HPQTWIj4Hancpk8fCRanYZn+tHvDP2gYGIOGO+OFpy6831Ym
	HeKJlYcIOoseya21+HgAHkoreuPiLZ6IvJ775/MLQN3ge134zpHHS9a0xS497kx5m2tPNfkZAZh
	3IT+8ZJOU0qiZONuVRfh3UiiBz1dcE9ccQ1rA5D4q
X-Gm-Gg: ASbGnctgw4g1g4C0js4F8s+q+C3w7rAIrVuHLadWUSN5JnmVMfFa/Kkig2TD5BBll2e
	Eo6Z/2yU18J5gX9ZRVPfRNkHvtF1iboHDJXChZYXg/RDKzntgx/xXkp788mo2C2nRN7MJjv+o5f
	IEvNAT7zbnUqfzHXEh9AXgrSCDFAPI3oUK9P3zx3CpPwXGtZrY0O3JMhJJhXiagxYiQj5QHcsjI
	wvZkzYh1fwnoMKiblfr/1nm2y8Gn1BnDANLyaYYG9UqB10LNidH87oNFnsE1VjhyA==
X-Google-Smtp-Source: AGHT+IHGbR0nw70VyQc9zW85E2AhlbNJIVkFU9yxJMWLzRlBiKSa4wpgGT7Ne4ww3kizHSnL1IWHtB6HnScEencWC14=
X-Received: by 2002:a17:902:e751:b0:231:f6bc:5c84 with SMTP id
 d9443c01a7336-26800f6615emr380685ad.8.1758045475525; Tue, 16 Sep 2025
 10:57:55 -0700 (PDT)
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
 <20250916134833.281e7f8b@gandalf.local.home>
In-Reply-To: <20250916134833.281e7f8b@gandalf.local.home>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 16 Sep 2025 10:57:43 -0700
X-Gm-Features: AS18NWDROcLW9crQ0p334hZw_COODCH3F9NCEGYQeh0xi3klCf483KDt2XFW7i8
Message-ID: <CAC_TJvc6aqjBRZ05wyGb49AU+-aKpSph=ZSk3fdV2xraXi-_nQ@mail.gmail.com>
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

On Tue, Sep 16, 2025 at 10:47=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 16 Sep 2025 10:36:57 -0700
> Kalesh Singh <kaleshsingh@google.com> wrote:
>
> > I completely agree with the principle that static tracepoints
> > shouldn't be used as markers if a dynamic probe will suffice. The
> > intent here is to avoid introducing overhead in the common case to
> > avoid regressing mmap, munmap, and other syscall latencies; while
> > still providing observability for the max vma_count exceeded failure
> > condition.
> >
> > The original centralized check (before previous review rounds) was
> > indeed in a dedicated function, exceeds_max_map_count(), where a
> > kprobe/fprobe could have been easily attached without impacting the
> > common path. This was changed due to previous review feedback to the
> > capacity based vma_count_remaining() which necessitated the check to
> > be done externally by the callers:
> >
> > https://lore.kernel.org/r/20250903232437.1454293-1-kaleshsingh@google.c=
om/
> >
> > Would you be ok with something like:
> >
> > trace_max_vma_count_exceeded(mm);
> >
> > TP_STRUCT__entry(
> > __field(unsigned int, mm_id)
> > __field(unsigned int vma_count)
> > )
> >
> > mm_id would be the hash of the mm_struct ptr similar to rss_stat and
> > the vma_count is the current vma count (some syscalls have different
> > requirements on the capacity remaining: mremap requires 6 available
> > slots, other syscalls require 1).
> >
>
> BTW, why the hash of the mm pointer and not the pointer itself? We save
> pointers in lots of places, and if it is the pointer, you could use an
> eprobe to attache to the trace event to dereference its fields.

In Android we try to avoid exposing raw kernel pointers to userspace
for security reasons: raising /proc/sys/kernel/kptr_restrict to 2
immediately after symbols are resolved for necessary telemetry tooling
during early boot. I believe this is also why rss_stat uses the hash
and not the raw pointer.

Thanks,
Kalesh

>
> -- Steve
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

