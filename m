Return-Path: <linux-kernel+bounces-880104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A551BC24E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9AE324E9BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7023346FB0;
	Fri, 31 Oct 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxjP3pYX"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E52E2F261D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911862; cv=none; b=W2aYXnMa4RdwbWxVjMCJy3MVwBc1l4VmSkhChEFY8lPK3J6+bgUe5NA7yxOYASv+1UXU5MXI8nwcPAOEEbNk8qqS37Wrd1mv7gBanChAI1L9iCapjsojE7nOtmBq9vTgTYukDAydXR5W2J4iUWbBcJQIiv29lLgs1qu+9StohG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911862; c=relaxed/simple;
	bh=dY7Z2MmzbkxuT2iz0v8W7dJrKa/ZUWsqjm3RZImAMKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjc57/B2DkjWO78TQwYIqP9x9wl+xC06NwCsrF4l786j7lcW7NYQ0JlSCrxTg6ddxrjzMcdquMH5OPpxJRkBevSF0j1LiRePeXQ3HW+2eDGIA8r2W42glPgFt57qlkfebhPwsvhtZcRO+vUS3a9dvBTcXC/b7GwTm3zdX3LM090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxjP3pYX; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88025eb208bso14089336d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761911859; x=1762516659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dY7Z2MmzbkxuT2iz0v8W7dJrKa/ZUWsqjm3RZImAMKI=;
        b=DxjP3pYXQ7QFxudyd77Mn/kCPI8enwMFwwRFZnX6iUS1WwndD4Dwp2U46xMVMgImfC
         8ncyr+Spxr/RpJA0cmupLwvHvwO4l2ROZoFT2F501FV2DU84342kuqtxw8yGO/LiIRCb
         NrEtqO7tNbjPqZm7TQAcYIg2IJzt6LyPRNO+H2BuZjy+Z+g9mzjOgp2vA4oZwdDG1fLW
         Ls489DBUfEm9Em+0PUSfDVmdTGO4gCf+CSQer3WskUJxfex48HHfSTF7bGLgx1EP9f6w
         xPX713vHvYo/N34cy8izqWVvbPrd+jBgo417365bZBJAnlWeoO4xLWcbvC6xHM1oMs5S
         A07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911859; x=1762516659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dY7Z2MmzbkxuT2iz0v8W7dJrKa/ZUWsqjm3RZImAMKI=;
        b=ObEiUi83eNctj0QpRv8LLoN8N2LCudGMxjjWaBMpgjhofQLVWIGsOI9ecW+CddhmzA
         4nbjcqMzAsSwByIPiY3Vb6BsPR45/qyC0OSVesSxjuHYFHKs0TzcvuEYd+xxG8dizHiA
         /az1yCnrGLjos1LmXBz/I7tpo371Qx8U98I6KKJswC4ys5534NDeIV+CEwv/7Go+SV4a
         S/tWgHLngj+mUmkLhYXUU1sBSvCtCo2mllYlqoe1vR5xJ0dYXGhUvDHt4UyjHEgGB6ib
         Og/tMXjk+lFuPcSTZZ9nIj/cNsubxuUThiPK4PD6p+WmJ9sZef4+lYKQawKyjs8HkNrZ
         0TbA==
X-Forwarded-Encrypted: i=1; AJvYcCWO10ZhRCMc7lw/DkQP63qMUZkvOQy5a26pyVCmrM1m+KyBrWQTUpHYLM//uBDGbeBI3/GwL9D97szigx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpV6OHqLiWk6lj411RulY2jD94e2otYsu6Uaooik4gYofNgGm
	5Qsf+7foXEJl6Mk8gWHBNab95mPRtCGhI61EI4g+lUJVy1FOhE7SEMU+mNiPrhEALuR61vm2U8O
	ctF1ySyqf7Atm2fvzyYH3+O2eUCOAs5NHNvIMsHaD
X-Gm-Gg: ASbGncsb4sdbdbDcJcM2+LFXaqt/DiucOW/jtlJuC8oRZ5+x6iPbewLsapMrq4Un6SN
	nZO/Ap+j0WR85EqW3f+lO1HpEnp5v4NjUk4Is/GKC5R8xy6/rN2gJpjwpkUxAT34B3yoP65XjVV
	PAF4Cly2B4uQprPbNpFzVug+B6YsG6j6+3TZzNuEazdmj3ZCRfnuQDyNS7LjUW9MvoA5yOnLi+g
	adEEgt+JFbzlblrRBKWtY2kfS2pHv0f79bz8cE49+cXtpQq3etCIyXwwp+epVWOtPZW8CvFD79q
	Q6oZBqxt+apa6E0=
X-Google-Smtp-Source: AGHT+IH/WfUBbYgpcQjhubmZPkjb99DuZN8mTUPRUydXIR3zlsXxfvRxJAbboXz8gq5VWvs192w21z+0QLbcg/B7x0M=
X-Received: by 2002:a05:6214:238e:b0:880:219c:34 with SMTP id
 6a1803df08f44-8802f316e39mr33232076d6.21.1761911859273; Fri, 31 Oct 2025
 04:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930115600.709776-2-aleksei.nikiforov@linux.ibm.com>
 <20251008203111.e6ce309e9f937652856d9aa5@linux-foundation.org>
 <335827e0-0a4c-43c3-a79b-6448307573fd@linux.ibm.com> <20251022030213.GA35717@sol>
 <20251022143604.1ac1fcb18bfaf730097081ab@linux-foundation.org> <CAADnVQ+o4kE84u05kCgDui-hdk2BK=9vvAOpktiTsRThYRK+Pw@mail.gmail.com>
In-Reply-To: <CAADnVQ+o4kE84u05kCgDui-hdk2BK=9vvAOpktiTsRThYRK+Pw@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 31 Oct 2025 12:57:01 +0100
X-Gm-Features: AWmQ_bmooBOl4Jc73SKfuTO-ZNCvAEqNx0sukASP61H3kOcFqYTjm6P9qzvWG3E
Message-ID: <CAG_fn=UQYdGqiMbFxp+XTgP=zkZgDGgdcA74Zcs9HTo+zd3oYA@mail.gmail.com>
Subject: Re: [PATCH] mm/kmsan: Fix kmsan kmalloc hook when no stack depots are
 allocated yet
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Eric Biggers <ebiggers@kernel.org>, 
	Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> What's puzzling is that it took 9 month to discover it ?!
> and allegedly Eric is seeing it by running kmsan selftest,
> but Alexander couldn't repro it initially?

If I understand correctly, Eric was linking his tests into the kernel
(CONFIG_KMSAN_KUNIT_TEST=y was implicitly set because
CONFIG_MODULES=n), whereas I ran them as a module.
After the kernel booted up, the stack depot was already initialized,
so the tests behaved just fine.
KMSAN also continued to work normally on syzbot and report bugs (see
https://syzkaller.appspot.com/upstream/graph/found-bugs), so it wasn't
really obvious that something was broken.

> Looks like there is a gap in kmsan test coverage.
> People that care about kmsan should really step up.

You are right, we should add KMSAN KUnit tests to some CI (wonder if
there are KernelCI instances allowing that?)
I'll look into that.

