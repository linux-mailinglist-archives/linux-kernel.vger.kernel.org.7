Return-Path: <linux-kernel+bounces-750554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC4DB15DED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3CC454386F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CFA26CE1D;
	Wed, 30 Jul 2025 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ge/JYU5y"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314B1F4CB5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753870601; cv=none; b=C6IZ52i1kQY2Fi2o68qxUft+UgDnLCx++zsLZbjmc5d8I61dUbF9CQFHqEyTXatcPuVOhRQYb7sBWNwzZ2ykYfyjWmf4tx2kIQD1Al/Wq+wY3QmMqCvT+UrS0h4BIVbzL2A0haTAVrbDIpf6UIZ9u29a2STBJGET4H5Ea0V08eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753870601; c=relaxed/simple;
	bh=OKZEZ8uKTHFd9U7xhwU10+rhsz0RHGEoOmOnRQYJ4do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIiDBDXW4UWYx3yuj2GM/JGxsBeB0LVQkFLI+Innv+zplVGUwQBs3KfemSfTEZpj2L0e0Z2o/03xrRgLcxoZx5TImDOSvk5IISanEGwsEHBqOOCELoUOb3LTLFZkgKlc0XLHFNLxAY1xQHqRS89EmgvzY7s5srSoOKPTxunnnAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ge/JYU5y; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747e41d5469so7064560b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753870597; x=1754475397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sHw6GGmqEGRpQxczV7g/BJPiov824rESP6HM1uzbgc=;
        b=ge/JYU5yte7dOBVXZ8ieJvP1oMhS5vesemw88qmxEX3NQsJojNjsLqLPPLDlQeK/zp
         drjYcxw7bvV4qzGaWzuUByzuBez7u7A9nsgvVSe2O24HsPfVpCO/o45PhR1rLNDdYYHr
         Tp7jyVc7VirHC8O6hYsbZJR7eVBW4658NuXao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753870597; x=1754475397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sHw6GGmqEGRpQxczV7g/BJPiov824rESP6HM1uzbgc=;
        b=kJzk7kdh0O7a/w1p4H/RGlQCUVZRgmwckRy9lfp6AshEYuvtNNsfK25GtrTmYvUm8b
         9m6Y/jwyhKvlLMMrra8L8IBqz5rPxgH9Xlw641Vrg2H/b7j57wV/hNE74oEVMgoF+yz8
         StX3v/X/EmPnEI+5YrgPPtdxZh20KkRPyhN+u2HVvrW8qyzC/6gTljZMwNU1QalEo1dN
         P3ASIisMbmoLcSgRuR4Ei+Ka5jUdcPCH3Tid/oBRmrSlk8fxIUGxGK/vCZoQ6nKRVprC
         EqZNy4s9GRFe01i/ObofWA8coZ5C7tTkMYW2uciYjqOo+SjUiEYJUFVc1+f4m1HAL8pb
         OEKg==
X-Forwarded-Encrypted: i=1; AJvYcCW0y6GHrQBp0qhdarnGeHg4MFk15XRUuz+4FJEyX9LyCXZJaPtugAJ0twG+uBSImPPbnwI06cHbtwLDqj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymyzCuzUTNsHE4p54Hp/OQhjdMNdaNxPCGkdDFC69wBTaWc8R0
	KcXaLPikwgolcH0lJSVupacBJc9FlNlZbsOTtP3tdFbJxKPtDu4kmJlTVkc+uXAXIw==
X-Gm-Gg: ASbGncsklqxuQURhMLbamCaXXGPG0R+SSFQZzlDTf4FEgKWVSdSpfnwQ6juKTbNnf0l
	exU5xMzE/kR9rLlFoJ4ly2MjUTnBHOH5RRogbXcc0tErc2QRRv2rgeN7WO4IkhL6idqthzNO0RW
	zg4SXoX8qwSz2ZU3bGhXK/N05zfMJY3L/g8s8VpcY2nuDmcUvN1SsnZ3Csz+GuyRUiyfK7ZUnj8
	M6eMgqhlQFzypNnlBdSLcglUidbznxqIqKsrgyPu3knUb5nq3w4TPL3yYRmUmf+2vF5ggdPVs6n
	0XewsNLpv6vj3+XuGjxzIbF1vxJDVEzY75XGS234h+HMPfK2k8xfzXssL+aHGSVhhQAiAfn5NjJ
	B/rgJlx4m3ABcSzmA1M5PW6iU
X-Google-Smtp-Source: AGHT+IHNQjQSUT/rMJdhfO5bGU/WSsb6pbgn42uk+iUW8eu1U+6NPjwhrYq5A0sIJX+HIo05lL49xg==
X-Received: by 2002:a05:6a20:9150:b0:233:5292:4841 with SMTP id adf61e73a8af0-23dc0e7c7d9mr4625645637.36.1753870597166;
        Wed, 30 Jul 2025 03:16:37 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f7f6b63c4sm8798352a12.56.2025.07.30.03.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 03:16:36 -0700 (PDT)
Date: Wed, 30 Jul 2025 19:16:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
	Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <npvzweqkpwqgcjzmb4h7ymp57m5kjrziwyl7pqeb2pgqeysbma@op25ggpv7ce5>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
 <tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
 <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
 <28364352-99b9-405f-831a-000ad090dd12@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28364352-99b9-405f-831a-000ad090dd12@linux.dev>

On (25/07/30 17:36), Lance Yang wrote:
> On 2025/7/30 16:51, Masami Hiramatsu (Google) wrote:
> > On Wed, 30 Jul 2025 16:59:22 +0900
> > Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> > 
> > > One thing that gives me a bit of "inconvenience" is that in certain
> > > cases this significantly increases the amount of stack traces to go
> > > through.  A distilled real life example:
> > > - task T1 acquires lock L1, attempts to acquire L2
> > > - task T2 acquires lock L2, attempts to acquire L3
> > > - task T3 acquires lock L3, attempts to acquire L1
> > > 
> > > So we'd now see:
> > > - a backtrace of T1, followed by a backtrace of T2 (owner of L2)
> > > - a backtrace of T2, followed by a backtrace of T3 (owner of L3)
> > > - a backtrace of T3, followed by a backtrace of T1 (owner of L1)
> > > 
> > > Notice how each task is backtraced twice.  I wonder if it's worth it
> > > to de-dup the backtraces.  E.g. in
> > > 
> > > 	task cat:115 is blocked on a mutex likely owned by task cat:114
> > > 
> > > if we know that cat:114 is also blocked on a lock, then we probably
> > > can just say "is blocked on a mutex likely owned by task cat:114" and
> > > continue iterating through tasks.  That "cat:114" will be backtraced
> > > individually later, as it's also blocked on a lock, owned by another
> > > task.
> > > 
> > > Does this make any sense?
> > 
> > Hrm, OK. So what about dump the blocker task only if that task is
> > NOT blocked? (because if the task is blocked, it should be dumped
> > afterwards (or already))
> 
> Hmm... I'm concerned about a potential side effect of that logic.
> 
> Consider a simple, non-circular blocking chain like T1 -> T2 -> T3.
> 
> In this scenario, T1, T2, and T3 would all be dumped as hung tasks.
> However, with the proposed rule (dump only if NOT blocked), when the
> detector processes T1, it would see that its blocker (T2) is also
> blocked and would therefore skip printing any blocker information about
> T2.

That's not what I proposed.  The suggestions here is to print only
"is blocked likely owned by task cat:114" and do not append the
backtrace of that cat:114, because it will be printed separately
(since it's a blocked task).  But we should do so only if blocker
is also blocked.  So the relation between T1 and T2 will still be
exposed.

