Return-Path: <linux-kernel+bounces-814738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274B0B557F9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A8E3A76E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926731A04D;
	Fri, 12 Sep 2025 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojia2Gf6"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57892D6E4C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757710518; cv=none; b=Xw/55sD1XOQYTZvXhjCyQTYDcr6HoaiPBNpJUG7Y5HHiUDhG4qf+17s7uSAxrDFq1KFljaCeT/5KuhHY0RFA0ScnibrF1Hy/R/HT1z+MeVLSzxrr/fNj9mdJAJKakUeubJfIktqSxn9eTZeNI1OXlB+12IBclnLy5s0AvFrNWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757710518; c=relaxed/simple;
	bh=a3zbhO7avmRivgJdN1bTarTT6jvnyHqHhhGhbgz5SOM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo+fpWA5oaJtcIjWP5Wa9konA6o2o/z2BXTphIHLNSubgIds0wFHN2N2GHAnHqnAzRGbn2RCu4gREIFKNDRaZha5yAUanngI6P8EnWiOdIbiqU3LR+u1KsHR/7zQmgp33Cufg+xnPid6KJyJYPTqqHqGqxCZtWM5Q9Q5ZyWYIjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojia2Gf6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3d19699240dso1945144f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757710515; x=1758315315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H8aqhiiMcUtn0FeyGFmgA1u06OS1EcQ/EDH2tzgYHHg=;
        b=Ojia2Gf6OnUKzuANlqNgyE2d4Xd58JUfZ0FhiwOFS8pIIyU2N8+4g5tEolJDHVOXnY
         2wY3y8xSrPcPth3y1/M1jR6+xqkhqymvYFlzzoL4LxTLgojNtaNfNvkvyF9Nc9zYvATL
         jG7Z2jIGvRlF6Uo/o/PF6uTCnpmDZeKWG0d1Npe9iHRf+ahE1OB7jdhWt2B6MV1hKYyT
         xs0X8Qcv4y7NXU/QKJ2K6/rM4Tqe7ZcF1YjziQvjvaCqW/1X5f4LTk2vSUXzokaHzt8g
         nK9N+DncjdfjJ8mwwWyGuB6LHUbvEbdpEHXsUa+tnPOvgXprFDl9h6NJScq4Ez+XmTi3
         KAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757710515; x=1758315315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8aqhiiMcUtn0FeyGFmgA1u06OS1EcQ/EDH2tzgYHHg=;
        b=stmj1x76o8N1m0NnL1s3Sd/F1c+rKJr1tRNboHrrGs578DfU/AQb5YpT5jtKp0wZDU
         dW8TZX5jvB7xCyo74HcIqEV1rEKTQA8f+CsGoRqoTXemDxn8JFfZAeOEbgg9EPoPvPOb
         wHmeV0Sm9XsUuUS1cA1mVWaAixEzQDDylZVB3ClyKXF0DqWnm03s3f8+Y7X0cjBCIdkD
         WnyiQ+Nl2JJIUhP7SoNZOMhqSYvJpbwFWRGm2gOiPH8G9uY4uABfXVS8iHNuOu9ECBC5
         1W5Y1TdafkkZt7shgVTG+okdQdXC2ApvCbscw8Dozu7H58E+M7YDejJVE90LQIpvPKsz
         2spw==
X-Forwarded-Encrypted: i=1; AJvYcCXOA7BGIZ4QzM0ANeBKcD02cx/f9glx/NO5n5byeyPqFhdPxcz4LJ1NaF6ZjzmmrUxENh2vc3RZ2FRVR/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0YHhzc670h5YD7U3oE1mERgTBva9MMmSdKolj+H57f3AXHhGY
	/Z+uTDLMS9D6inVmrjiUzCmey2UW19lnpxY2s6DrkC5QHk6xem/h4NLu
X-Gm-Gg: ASbGncsL6vC0z3GyIkDd/cO+Kzi1sYnUvtG+StANfGPEkseOXjGOI0SE7zJJh09v14W
	S7qg64kEH98/4Iy2S9Tf0udsGgXdF6tzy/hMmMFuhWNb5thQ5OtcM7bVvxn+n4XjaUOE8OLpNd+
	uTNgZgKRctB1nzj1BRW5WsKXh4rVWjWieCfHnufaqU1GeTRoivR5Ti+KVLGpV6nr/3aqIMLKXNe
	cDZNROxsRJsYfyCCim3lgdYq97pq63Uf3Gh4+6T0SNllDAQzmVtwGGKAroq/2ZPUjp6+yYJmasT
	7hmHPAbvyVg1iCYMGe0ceuADIHDIKThGhWZQi2oGufNFYEQcZgdlFuaaKPktRdja9GKuBY5fLsP
	W4l1J19uV2njGzL7qf4PduNUVWBCAwk4OqZ6eB8Q=
X-Google-Smtp-Source: AGHT+IE4Ui/OWY5Blho4xzlZ3PsVi9ZXAjNk3hNnkkFx7iqGYbpT09JBBVUN+5Q6z4FwWeQdMkMI6g==
X-Received: by 2002:a5d:64e4:0:b0:3e1:ca94:3199 with SMTP id ffacd0b85a97d-3e7659f3ea0mr4309536f8f.14.1757710514978;
        Fri, 12 Sep 2025 13:55:14 -0700 (PDT)
Received: from krava (89-40-234-69.wdsl.neomedia.it. [89.40.234.69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d822fsm7872682f8f.53.2025.09.12.13.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 13:55:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 12 Sep 2025 22:55:11 +0200
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 0/6] uprobe,bpf: Allow to change app
 registers from uprobe registers
Message-ID: <aMSIr1oItIfWQd5R@krava>
References: <20250909123857.315599-1-jolsa@kernel.org>
 <CAEf4Bzb4ErWn=2SajBcyJxqGEYy0DXmtWuXKLskPGLG-Y9POFA@mail.gmail.com>
 <7f591ac9-d3e0-4404-987c-40eceaf51fbb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f591ac9-d3e0-4404-987c-40eceaf51fbb@linux.dev>

On Fri, Sep 12, 2025 at 01:28:55PM -0700, Ihor Solodrai wrote:
> On 9/9/25 9:41 AM, Andrii Nakryiko wrote:
> > On Tue, Sep 9, 2025 at 8:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > 
> > > hi,
> > > we recently had several requests for tetragon to be able to change
> > > user application function return value or divert its execution through
> > > instruction pointer change.
> > > 
> > > This patchset adds support for uprobe program to change app's registers
> > > including instruction pointer.
> > > 
> > > v3 changes:
> > > - deny attach of kprobe,multi with kprobe_write_ctx set [Alexei]
> > > - added more tests for denied kprobe attachment
> > > 
> > > thanks,
> > > jirka
> > > 
> > > 
> > > ---
> > > Jiri Olsa (6):
> > >        bpf: Allow uprobe program to change context registers
> > >        uprobe: Do not emulate/sstep original instruction when ip is changed
> > >        selftests/bpf: Add uprobe context registers changes test
> > >        selftests/bpf: Add uprobe context ip register change test
> > >        selftests/bpf: Add kprobe write ctx attach test
> > >        selftests/bpf: Add kprobe multi write ctx attach test
> > > 
> > 
> > For the series:
> > 
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > 
> > Question is which tree will this go through? Most changes are in BPF,
> > so probably bpf-next, right?
> 
> Hi Jiri.
> 
> This series does not apply to current bpf-next, see below.
> 
> Could you please respin it with bpf-next tag?
> E.g. "[PATCH v4 bpf-next 0/6] ..."
> 

hi,
the uprobe change it needs to be on top of the optimized uprobes (tip/perf/core)
but the bpf selftests patches could be applied on bpf-next/master and disabled
in CI until tip/perf/core changes are merged in?

thanks,
jirka


> Thanks!
> 
> $ git log -1 --oneline
> a578b54a8ad2 (HEAD -> master, origin/master, origin/HEAD,
> kernel-patches/bpf-next) Merge branch
> 'bpf-report-arena-faults-to-bpf-streams'
> $ b4 am 20250909123857.315599-1-jolsa@kernel.org
> [...]
> $ git am ./v3_20250909_jolsa_uprobe_bpf_allow_to_change_app_registers_from_uprobe_registers.mbx
> Applying: bpf: Allow uprobe program to change context registers
> Applying: uprobe: Do not emulate/sstep original instruction when ip is
> changed
> error: patch failed: kernel/events/uprobes.c:2768
> error: kernel/events/uprobes.c: patch does not apply
> Patch failed at 0002 uprobe: Do not emulate/sstep original instruction when
> ip is changed
> [...]
> 
> > 
> > >   include/linux/bpf.h                                        |   1 +
> > >   kernel/events/core.c                                       |   4 +++
> > >   kernel/events/uprobes.c                                    |   7 +++++
> > >   kernel/trace/bpf_trace.c                                   |   7 +++--
> > >   tools/testing/selftests/bpf/prog_tests/attach_probe.c      |  28 +++++++++++++++++
> > >   tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |  27 ++++++++++++++++
> > >   tools/testing/selftests/bpf/prog_tests/uprobe.c            | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >   tools/testing/selftests/bpf/progs/kprobe_write_ctx.c       |  22 +++++++++++++
> > >   tools/testing/selftests/bpf/progs/test_uprobe.c            |  38 +++++++++++++++++++++++
> > >   9 files changed, 287 insertions(+), 3 deletions(-)
> > >   create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write_ctx.c
> 

