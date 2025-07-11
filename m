Return-Path: <linux-kernel+bounces-726741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC70B01096
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B860316D4A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782C53C463;
	Fri, 11 Jul 2025 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QpqmL3Wn"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268292770B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752196046; cv=none; b=qC4PDw9fZrAN7NzsHrMackPNaM37sim5fp4hE1AsDTj9nCLAVu3YTCCzf7iQorlB1HHKUJq6Cp8s4/tFY7y6OvSQz9BqoPxqpULSGEwL3l5KjiY23AYQzQl2rPkgqLSa4S29NNdthCdj062ECMOKJCg4x5178f3qgrHv+QoPouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752196046; c=relaxed/simple;
	bh=YRvwCC2Ha4y1rPhJk146f/loFd2WpTlx2lEwZSYmXVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFnt/1SjnGw+34v6zdYHl4nwHj8Zlb+i4reJHQTSZVB3DTxycQ6WZMFjApFgAbIUO0lF4sOvXPLlsaeCoBmg2Ztk1tPTJSH0OTRjsK+rCoajAhdY5Lb8pSTx+K9t+6s4Iv8z2unCTUL6jZUjrd8Mzig58l61E7etXrw+wssl9n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QpqmL3Wn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313336f8438so236299a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 18:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752196044; x=1752800844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTpOdXsMQLzrcYHow8zySMbXm3VVzD+3w6bdwbkL+9A=;
        b=QpqmL3WnTWY+aaZ+yV4l7EgGxPehD6XOjs6EH7y0GrZjD8yooRqtleAsbpvZyZCkxL
         TiSFp9LXn3bT6TydLbO4DZmGlyWBaTAuFDjILoCkvnCcf5jAIUq9tT3ttuPXfWyzv86E
         Aio6eznbgcs00LgmqLxWEQiqCSXHqMeLyyIo2nR8gqUHmF0PX6j9aDs/y+IXSykxtT7c
         v+Vnl4gQwmib8+qQYbARNwvsZEEt3+OBholzuMUA4katZR5m+/2OB3GISvwxVaMEyyEM
         LtxGVg0DXTuKEpVu9KlJu/go6FGz6BNaIAxE9XOXIcjVjLqT9BfPtPKxwTvx9e45VM1v
         A5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752196044; x=1752800844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTpOdXsMQLzrcYHow8zySMbXm3VVzD+3w6bdwbkL+9A=;
        b=KJCx60gTI1sVuGpMBFKpBP8QvnUj6I7EmTAjnVGNcnxp57Ct0G1O2VQFRCsM3N4sqh
         q0dJd4njxTZlz+iXVri6/d+bn/9FCAUThp6nSHg+6m8MYkU6sI1lEFG5pm/jTcwsAimv
         uEsMGVab3V1q6PEEXibMqTO7VO+oxMUHOCP52ymasLvG/1yE+pV3CVjQEIokOm6+YqyK
         K0sCuzyfSV/erQBd7N1c/VlxBzkwqv+wgLW81VgIEXpGEJ9NgViZZFHpTZaB4N0AOQmX
         YFwk4riaeGtHerO2GyRESqQitsUj8PI6bgpdsu+qYTC9eau4BqtMSXZFcuKcIDq9mXJw
         c9+g==
X-Forwarded-Encrypted: i=1; AJvYcCXfzc5FGElee/EYt9RkBCFfhzzyVMRFMV7jE7OStNY8QZ/1MHhzVuwB1asygfL5XhKaUy+qDgJezk5Xcmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK9hV4LBv51Qwe4I+xqfHUubWcH6I+QnL/SV8fzRwY8uMya2Uy
	49lBMkQ3LSElhgGPuAfGwIYSu9sD1wtT8L4PWZtXHfJVEe0WoEVEl5pL6/iv7MGmNTJ1+E579HT
	85Olqh+S5Vivw0K9M+8gh7T0+KfoHgMAGBPXh12FCyg==
X-Gm-Gg: ASbGnctg2PgDjHw2QobvN8B773DFn8xbl/+7Sa+KXnrpGS2xWbcm1NDafKqSLcU0GpG
	F/MGSPup14wxTIwyI7Qq8hyh6yt9ioMMnzKdbzMChg5RmDhPRtU3qUx85WwAmvip5J8b/nKfJco
	8Qa9ccL6dXjg5TrrgsXStPmXoyAdCvY6XqDknQZwfITCo0PV8AUrr/E9ildxjbFVXMGL+dlqyCY
	b8pnqY=
X-Google-Smtp-Source: AGHT+IG152UMqrIIRd2Xd90YPDSf5pEnbfvoOgqoYDrpOcF3WJk5ojY35gB4oWHE2yxNeXBAd3hQBEsb+k4GAvmvpHo=
X-Received: by 2002:a17:90b:2711:b0:311:9c9a:58e2 with SMTP id
 98e67ed59e1d1-31c4f563077mr309964a91.7.1752196044222; Thu, 10 Jul 2025
 18:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711002322.1303421-1-cachen@purestorage.com>
 <CALCePG3a6wG+3Nu7-JHha+LMtyRRNF3sXp13sS-=Xv1pvsX09Q@mail.gmail.com> <fhy4rcjrwwmlebgoiwepmga3fovxdvqeylsub6lk3opl2fi2td@ucuwdpu4ua7r>
In-Reply-To: <fhy4rcjrwwmlebgoiwepmga3fovxdvqeylsub6lk3opl2fi2td@ucuwdpu4ua7r>
From: Casey Chen <cachen@purestorage.com>
Date: Thu, 10 Jul 2025 18:07:13 -0700
X-Gm-Features: Ac12FXw6y-q8rSNhM9jBT1X4xydypPX-JJoJktrjXOfl29h8h5Mx4Q3MEQyzFt0
Message-ID: <CALCePG1h8NE010EGpBh8CxhiWqr4-GantEJ4P0Dnck+cnioBiw@mail.gmail.com>
Subject: Re: [PATCH v3] alloc_tag: add per-NUMA node stats
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: akpm@linux-foundation.org, surenb@google.com, corbet@lwn.net, 
	dennis@kernel.org, tj@kernel.org, cl@gentwo.org, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	yzhong@purestorage.com, souravpanda@google.com, 00107082@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 5:54=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Jul 10, 2025 at 05:42:05PM -0700, Casey Chen wrote:
> > Hi All,
> >
> > Thanks for reviewing my previous patches. I am replying some comments
> > in our previous discussion
> > https://lore.kernel.org/all/CAJuCfpHhSUhxer-6MP3503w6520YLfgBTGp7Q9Qm9k=
gN4TNsfw@mail.gmail.com/T/#u
> >
> > Most people care about the motivations and usages of this feature.
> > Internally, we used to have systems having asymmetric memory to NUMA
> > nodes. Node 0 uses a lot of memory but node 1 is pretty empty.
> > Requests to allocate memory on node 0 always fail. With this patch, we
> > can find the imbalance and optimize the memory usage. Also, David
> > Rientjes and Sourav Panda provide their scenarios in which this patch
> > would be very useful. It is easy to turn on an off so I think it is
> > nice to have, enabling more scenarios in the future.
> >
> > Andrew / Kent,
> > * I agree with Kent on using for_each_possible_cpu rather than
> > for_each_online_cpu, considering CPU online/offline.
> > * When failing to allocate counters for in-kernel alloc_tag, panic()
> > is better than WARN(), eventually the kernel would panic at invalid
> > memory access.
> > * percpu stats would bloat data structures quite a bit.
> >
> > David Wang,
> > I don't really understand what is 'granularity of calling sites'. If
> > NUMA imbalance is found, the calling site could request memory
> > allocation from different nodes. Other factors can affect NUMA
> > balance, those information can be implemented in a different patch.
>
> Let's get this functionality in.
>
> We've already got userspace parsing and consuming /proc/allocinfo, so we
> just need to do it without changing that format.

You mean keep the format without per-NUMA info the same as before ?
My patch v3 changed the header and the alignment of bytes and calls. I
can restore them back.

-       seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
+       seq_buf_printf(buf, "<size> <calls> <tag info>\n");

-       seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
+       seq_buf_printf(out, "%-12lli %-8llu ", bytes, counter.calls);

