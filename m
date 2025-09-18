Return-Path: <linux-kernel+bounces-815620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE91B5690E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D3D177FF1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5341DE4C9;
	Sun, 14 Sep 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfN1I3Sx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381901BE871;
	Sun, 14 Sep 2025 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854978; cv=none; b=dDcehig+a79snmTlySJi4kcy6cFSn91p/j9QU7YCiVnb/0NkyROrh0Q0DCs72xTSGs087/uXN7tJBHc7Dsfc/pHzCrzQF5hTikg7MpwygzirCbhIWRIrTuDHoZxpZkBJJpMLVxVWoT43S1Jk9OVgCBH+oAL9DOytmcS/LUocy8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854978; c=relaxed/simple;
	bh=YYDp1ijpwWt09S5HVfnu4kiNUYZD0PpGT+F41GYPadw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AtzFaIqy5v6F6spUhMDSWDtAVls5ondLd1dJAJp6cfT7IAyfeP76UB8V18YvbHHAWqshAo5NtLzYkSw4RRxsn2PZdbpvEYbrE41EqHM3JDbfDB/IHGr5KXwyFFWv4XKHPAt38zqZgZSL4R5RJaZ5GCfyqyAb/0//2RKorq8uffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfN1I3Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC9EC4CEF0;
	Sun, 14 Sep 2025 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757854977;
	bh=YYDp1ijpwWt09S5HVfnu4kiNUYZD0PpGT+F41GYPadw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tfN1I3SxboPtqg8tVy6FWKrpiKrpPQ9z8Cv44K48WXiEcad4ZNNLZydJ65S/qI29k
	 EwBkEyHjGDbdx6IiIbX8u+Gc9sh1/7LhYv0KuDenuZg3dAkx920SCHCrx3ejXdB4CZ
	 kkZv+EZ8tXEH2aLHGTp7G3jfLmgvYXteZnydpp0UsPKMgf3HAzoIv8i/yxHQkoxOSP
	 75VFXHCUQMfSFW3LEOUGVqLmXvVBvEcw/SnA32l/9OUmQ7vCkJ2ODaCUXeNlxE0Rl4
	 8f6jp6BUeK9hULpSdxe6NnOO5CuoAwWTcVvlywnTL2AONaQjHYXi1lA376VzJCi5nx
	 sdvSbzTn6c09A==
Date: Sun, 14 Sep 2025 22:02:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jinchao Wang <wangjinchao600@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Mike
 Rapoport <rppt@kernel.org>, Alexander Potapenko <glider@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Sami Tolvanen <samitolvanen@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Rong Xu
 <xur@google.com>, Naveen N Rao <naveen@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Andrii Nakryiko <andrii@kernel.org>, Jinjie Ruan
 <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org, llvm@lists.linux.dev, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry
 Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/21] HWBP: Add modify_wide_hw_breakpoint_local()
 API
Message-Id: <20250914220242.1e8dc83e011b9568dd7a5ace@kernel.org>
In-Reply-To: <6b5e5d3e-5db8-44f2-8dca-42f317be8e0d@infradead.org>
References: <20250912101145.465708-1-wangjinchao600@gmail.com>
	<20250912101145.465708-4-wangjinchao600@gmail.com>
	<6b5e5d3e-5db8-44f2-8dca-42f317be8e0d@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Sep 2025 21:13:07 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On 9/12/25 3:11 AM, Jinchao Wang wrote:
> > +/**
> > + * modify_wide_hw_breakpoint_local - update breakpoint config for local cpu
> > + * @bp: the hwbp perf event for this cpu
> > + * @attr: the new attribute for @bp
> > + *
> > + * This does not release and reserve the slot of HWBP, just reuse the current
> 
>                                                  of a HWBP; it just reuses

OK,

> 
> and preferable s/cpu/CPU/ in comments.

OK.

Thanks for review!

> 
> > + * slot on local CPU. So the users must update the other CPUs by themselves.
> > + * Also, since this does not release/reserve the slot, this can not change the
> > + * type to incompatible type of the HWBP.
> > + * Return err if attr is invalid or the cpu fails to update debug register
> > + * for new @attr.
> > + */
> > +#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
> > +int modify_wide_hw_breakpoint_local(struct perf_event *bp,
> > +				    struct perf_event_attr *attr)
> > +{
> 
> -- 
> ~Randy
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

