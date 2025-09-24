Return-Path: <linux-kernel+bounces-830888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC3EB9ACBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512522A4A51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1CF30C347;
	Wed, 24 Sep 2025 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJxutCxs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2626313260
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729632; cv=none; b=JOeN3Zeswfrp4AkO+oIL4U8JZQYr4eksCHNwB9rYnxgRlnXl0hJ51fI14sXKljz4+9wqn+O13lMQXWpld8Dapcl9prea05CMUSfjf+RlQXwZ+0NsaXjkoQl0yT59jmJvBcVhfUan54LSges1K89uvLxtmj8AM3ICxfazZ5TfdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729632; c=relaxed/simple;
	bh=jEEjzmNz+gmk5ZgeibUNddmKR2RxdfJxzRrshLcdK0s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iex8rOdQr1Pm+VguGJeByHYbpIROCAhtSr1Mccwu3rtIDMbEE3uglL4N6VnqMsnXLCwcnufoUCu7JDi64aTzVzjGCz/4F7I7pAaoAibCmSUvtXGP1izBfKgl13gXMJO3YTGmNp8oZ4BCRib1+mTNHv6w/s7z7tzyPSXqNaz6KIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJxutCxs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so43179315e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758729629; x=1759334429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=750rYEAHSQ0UWuveAndSH+YLhrYLDuMy4II+d7YdJQE=;
        b=lJxutCxs3RZMFeCOOS2VTbsDXy7S9D/5OVh2iuo0bwAN3PJRKHX9n7hVerFj11aX3s
         96KTehdHee/QXiBSGdzxgkdEAGsXVUyoGCjqjPmhdPsgnRAkD9NJ8FTuNhThGx4St3Wp
         239cC1fzNJi9dWsrYcB+P8OKPOuxVfx9STNs6bOx2hrn5jlqvDVBJjhqiTt6SkEOjCbY
         LiiYxml+zSh8kXr9uzJ3vk0ZlHzbcW5hJwlPfMONE7XDz8ACoiN0KhUes4o5yttog3oV
         QkNNlNT/p0zo14xF3L8xD7CIW4yqlRHxNwqEjcNwZhS0L7QFLhmF0P9HGXX8IdLHmveB
         ZPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729629; x=1759334429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=750rYEAHSQ0UWuveAndSH+YLhrYLDuMy4II+d7YdJQE=;
        b=OknHv3RuTGz4h67eqMUCRDKYNQIR+DOAQ7R4j/58du4K8NzLLQrw0Tf4+lU9w1FjYG
         jWL8UjFsxBGAV4nuKjVUsJkL3OKn31XSv3p/vheMpwVNjKoLf9Wf51kvc+EVe2AOaOhv
         6f2IOgIg1w9L516x5/fcA3hjoHuuvJb7GfVgZaGI8On2orlrYSknvz+9+4Hc/SFp8B5j
         ObVBnRpYnvyFIuPop6S7ggK+tE8+OQ8wmmfqQfddXNqWqemkPPfy3bMMkcYQ81u2VB0C
         A9vIHcqgpI6L4VwzJ24DoYMFhjpj0Uw7LsncYql2XncNhEx46H59v9fsZ809CXpZzHjB
         x30g==
X-Forwarded-Encrypted: i=1; AJvYcCULS4XAJ2GfYvBrxwzK+besPNwqaAmGq5UrMTP0/RIXPKHhzgr4kcwiJzHkMyhlPIOw4ORcA2FzxbIzXrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrhVez2Y3M65KyFc7rx+yc0hy3P+m9q1YgKvpjTPeo0UK0tTpq
	2P9hFpJllvoH/jK+2gHiW2OndiU+mzHSF303vh4pgrMF7Uptsx3Rxh22
X-Gm-Gg: ASbGncuU61kv/dDwAvCdHu3VBEwXyFkt/pWDjPptvzmGVIDQ+0w5t+5nRprBjw4Pa/c
	MmQXL/HgrAHbtJ4bplhCyec5BghsAgyQoZwZvcaXvWCXDt7ouRES/DKVV0GKicpGAp5MSgEzxno
	RIL17WHlg5sR+phKKiWRo+eqAaeSSO0siXmk6Rzz0VjG7nWEkhtcPH1+RxTzQyJCrKThUuchx3C
	VYztxU3kcvuZ02es8WQTRCuSztxELHhVhqTHwVUk8kO7y/xojdo5Ccxf7X0SAV1gdLseYuDOKbj
	K1fIQ7mTc3i4sEo8v+8US+Nv19V/lEcM1Xb+UAC5ITBMOc2TEHgpw3pUFefPyfTmbC9eZM5k
X-Google-Smtp-Source: AGHT+IGS1uVQdvHmWTJ9aInOCYB0BEj+cPbPcp0L0eplHLPsYT5p2wId+q3+D0Z2kfEz6FOGX5pf3g==
X-Received: by 2002:a05:600c:1d16:b0:45d:f7cb:70f4 with SMTP id 5b1f17b1804b1-46e329bca25mr3761415e9.13.1758729629203;
        Wed, 24 Sep 2025 09:00:29 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm28837786f8f.18.2025.09.24.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:00:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 18:00:26 +0200
To: Steven Rostedt <rostedt@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH 2/9] ftrace: Add register_ftrace_direct_hash function
Message-ID: <aNQVmrGCW08zF9Kp@krava>
References: <20250923215147.1571952-1-jolsa@kernel.org>
 <20250923215147.1571952-3-jolsa@kernel.org>
 <20250924050415.4aefcb91@batman.local.home>
 <aNQCDwYcG0Qo00Vg@krava>
 <20250924110703.2a0ced1b@batman.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924110703.2a0ced1b@batman.local.home>

On Wed, Sep 24, 2025 at 11:07:03AM -0400, Steven Rostedt wrote:
> On Wed, 24 Sep 2025 16:37:03 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > I have bpf changes using this that I did not post yet, but even with that
> > there's probably no reason to export this.. will remove
> 
> I'm interested in seeing these patches, as the ftrace hashes were
> supposed to be opaque from other parts of the kernel.

branch:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=bpf/tracing_multi

used in this commit:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf/tracing_multi&id=8814108949537edaae84fbeee1cbc28280590b7f

background.. it's poc code for bpf tracing-multi attachment. Most likely we will
go with Menglong change instead [1], but it could use this direct interface in a
same way for speeding up the attachment

jirka


[1] https://lore.kernel.org/bpf/20250528034712.138701-1-dongml2@chinatelecom.cn/

