Return-Path: <linux-kernel+bounces-847908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A76DBCBFFB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 890D14F7833
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951E275AF5;
	Fri, 10 Oct 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnpTac5Z"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8B2750E1
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083093; cv=none; b=W1f2GoWvFefxmoJxDfo4i+KHnz9EqYOULtbC8rieBNKPq9PuqYegMU7a4G7tK2tmSC669dpsbE7gpovqCkk1tCa9wG1isvJdwZEmmft727k/FCNyULrC9m6bMb3zvF1VcNIZFs6yDmN7YU3AmQOv74rk10CIYv/HrEnCtikevHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083093; c=relaxed/simple;
	bh=/EqQHNRDCS2YqzBq0RkItK1pvs5vi0KLmvOMTFqnmTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzL+xLt/tl8sT9UAo9VBAl4K2jKWoXdVgWbOT1itYUxCA96Zkn5xX+UP0ptzEwGepPhSf1aTUaZc/qRrZ2HtlEHJEwjecPFT+BGdGH9+0FZMvv2eOmY54p2IM94Tib97IegAaPDdJjyu/WoVJaoF4FyYVmsUcEsRPiTO/ShWDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnpTac5Z; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b632a6b9effso1149462a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760083091; x=1760687891; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Nucw4E7LkwzxjCbFb3F737DKijbeBN9zMwZ0PDOoZQ=;
        b=LnpTac5ZvTS/UYEVB7W5KdB+cWLKdYtewYzALu7433gOuYAcGX1oFy0Q19ip8xcFCa
         VPvqP8SCUx+/XjNgHL8vB33TujuA0mC2YoXnFFaGf/K6hmYJQSStvsPkmYHDHvwWGBB9
         H25tihr2gvHnD9+QUe7VqDsb4j4ikRlvsXp8WF71t3vbG8l1ehFojIQi9pYHpBP7W6/A
         vqU5elROKHmEcCx+LOrpJDHvz4jqYqj6ZObpvjQ2rw6SyAsHiWwVY1K5mSEmwywqFgpO
         xN/78d3SCni1185cDyOSCn+FmZXFwCwbuKfofh82uNWMtcsHZ4vfgd8JPfiDTxs1PC8C
         1iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760083091; x=1760687891;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Nucw4E7LkwzxjCbFb3F737DKijbeBN9zMwZ0PDOoZQ=;
        b=P3Wr1kv/KFV56TmIZj8y3lPG2ZEYPeY5bAz0YmpZ44njkR2nqLQvLEVNt+LUIhZO6A
         abNkwbhw3KWw5QhHAFIQKvHkhjcQc+AAx5xnOe/WR+iOIdU1WLnTX9EYvWNTJ3f3KN64
         tnGCfNyOsHnRHSSbqmaJfKdhCvSOLQULhdiIdQ2E7oSV72YV4kxvzbzHMw4anG306XK+
         /VRmMxRGhAx+6xKtYAFblJgUK+TF3bvzOY8vyJ8ZIQHuwdviEnHfVHc5+e2VMdHBhUd1
         mpNNUacC24EarHFQtodhwE7YyRoZ5YnsuiEeDGJOWbWOvj/Syc3B/EY8D3+cI/CSNt/6
         sX3w==
X-Forwarded-Encrypted: i=1; AJvYcCUxtdq5f/QoNG8iLJZXkLo+vcFIRnVgYHKC90GDKwAWdQcxcl/d+tSMxrTYGg5nMJ/EAfKI+MeuUYEdQB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAbkFYSC2ALmLYViY5+CaYPhHOkCWZTUW9yAEv4TdOV6fgaMDp
	LquCSJYFphTbuVTxdfS/4X/1cSlvjHsKwNK1H/mKKq4T2ttsWGO9+xVd
X-Gm-Gg: ASbGnctiv8qzXCLkYdjVR4Ol2FDHvrUpAJzJMRltM19qfs7RpE3M1LmSZ9iyMMq3vW/
	V3kfFq2pcneBaj0k/M99KCj2TCKMwX5pwnO8E8f/viGMJKg3BVgrHDJSVVa/lXiN5MjToRWlQk8
	Jb5nLgWjEXVq3eLMQsiQNckdTFic1uWNtY55H/svajQtgH3SBQ25s8awHnz7rUEuKOp4RlYm7Um
	9Vx2MLgCsyYbHKD3DgJKuF7MKU+HzubVZZuCw3QnNbvYsJMoOdjxSGooxfzK8kW/WBpOi37LTEP
	fXst2uYea5ZlQSCEyu62hwmsmmNuE9o80SO1J3P6P5a2K7xe7YQa8l0ziQFqAI+9bspE3tKc84K
	Ic3eZc7PLDm3e+j7TEuoQq8rbxRMN+9HV1oVCMiTfik6fy4eDMO/IW+G5CDFzm+IcgYY=
X-Google-Smtp-Source: AGHT+IFeywA6gB4/SQbmJGvT2KY5YTMhXWywBtcaIqaAsauF4r7EzLqcGRXLsSas3aRqscvIRrL6Qg==
X-Received: by 2002:a17:903:298e:b0:28e:756c:7082 with SMTP id d9443c01a7336-29027374b38mr134966335ad.15.1760083090502;
        Fri, 10 Oct 2025 00:58:10 -0700 (PDT)
Received: from localhost ([103.121.208.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f070ecsm49587725ad.60.2025.10.10.00.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:58:09 -0700 (PDT)
Date: Fri, 10 Oct 2025 15:58:03 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Marco Elver <elver@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/23] mm/ksw: Introduce real-time KStackWatch
 debugging tool
Message-ID: <aOi8i1Y0decaamaX@mdev>
References: <20251009105650.168917-1-wangjinchao600@gmail.com>
 <20251009175107.ee07228e3253afca5b487316@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009175107.ee07228e3253afca5b487316@linux-foundation.org>

On Thu, Oct 09, 2025 at 05:51:07PM -0700, Andrew Morton wrote:
> On Thu,  9 Oct 2025 18:55:36 +0800 Jinchao Wang <wangjinchao600@gmail.com> wrote:
> 
> > This patch series introduces KStackWatch, a lightweight debugging tool to detect
> > kernel stack corruption in real time. It installs a hardware breakpoint
> > (watchpoint) at a function's specified offset using `kprobe.post_handler` and
> > removes it in `fprobe.exit_handler`. This covers the full execution window and
> > reports corruption immediately with time, location, and a call stack.
> > 
> > The motivation comes from scenarios where corruption occurs silently in one
> > function but manifests later in another, without a direct call trace linking
> > the two. Such bugs are often extremely hard to debug with existing tools.
> > These scenarios are demonstrated in test 3–5 (silent corruption test, patch 20).
> > 
> > ...
> >
> >  20 files changed, 1809 insertions(+), 62 deletions(-)
> 
> It's obviously a substantial project.  We need to decide whether to add
> this to Linux.
> 
> There are some really important [0/N] changelog details which I'm not
> immediately seeing:

Thanks for the review and questions.

> 
> Am I correct in thinking that it's x86-only?  If so, what's involved in
> enabling other architectures?  Is there any such work in progress?

Currently yes.
There are two architecture-specific dependencies:

- Hardware breakpoint (HWPB) modification in atomic context.
  This has been implemented for x86 in patches 1–3.
  I think it is not a big problem for other architectures.

- Stack canary locating mechanism, which does not work on parisc:
  - Automatic canary discovery scans from the stack base to high memory.
  - This feature is optional; a stack offset address can be provided instead.

Future work could include enabling support for other architectures such
as arm64 and riscv once their hardware breakpoint implementations allow
safe modification in atomic context. I do not currently have the
environment to test those architectures, but the framework was designed
to be generic and can be extended by contributors familiar with them.

> What motivated the work?  Was there some particular class of failures
> which you were persistently seeing and wished to fix more efficiently?
> 
> Has this code (or something like it) been used in production systems? 
> If so, by whom and with what results?

The motivation came from silent stack corruption issues. They occur
rarely but are extremely difficult to debug. I personally encountered
two such bugs which each took weeks to isolate, and I know similar
issues exist in other environments. KStackWatch was developed as a
result of those debugging efforts. It has been used mainly in my own
debugging environment and verified with controlled test cases
(patches 17–21). If it had existed earlier, similar bugs could have
been resolved much faster.

> 
> Has it actually found some kernel bugs yet?  If so, details please.

It was designed to help diagnose bugs whose existence was already known
but whose root cause was difficult to locate. So far it has been used
in my personal environment and can be validated with controlled test
cases in patches 17–21.

> 
> Can this be enabled on production systems?  If so, what is the
> measured runtime overhead?

I believe it can.  The overhead is summarized below.

Without watching:
  - Per-task context: 2 * sizeof(ulong) + 4 bytes (≈20 bytes on x86_64)

With watching:
  - Same per-task context as above
  - One or more preallocated HWBPs (configurable, at least one)
  - Small additional memory for managing HWBP and context state
  - Runtime overhead (measured on x86_64):

       Type                 |   Time (ns)  |  Cycles
       -----------------------------------------------
       entry with watch     |     10892    |   32620
       entry without watch  |       159    |     466
       exit  with watch     |     12541    |   37556
       exit  without watch  |       124    |     369

Would you prefer that I include the measurement code (used to collect the
timing and cycle statistics shown above) in the next version of the patch
set, or submit it separately as an additional patch?

-- 
Jinchao

