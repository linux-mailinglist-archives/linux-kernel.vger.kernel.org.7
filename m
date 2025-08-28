Return-Path: <linux-kernel+bounces-790562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED4DB3AA40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518AF7C3FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013930F7F0;
	Thu, 28 Aug 2025 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RSZz0nYs"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2626F2AF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406828; cv=none; b=hOvT9g7Px9VmzlywFinEjl5SI9H8yM8/b6/4RKMO4O2j4ZetwaAbdxWlwz5aef0CtG6vaT9LXLziMw9xUlvgEtFTi5/CzPKDlouxViZTNtzwACSbOZ7FabWy+f/U9ipZBPfDufY0fJr2M75KGfEpv870Mt7zM5EnUa4FttGKnVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406828; c=relaxed/simple;
	bh=KHlidwqQkhRRqz68j9Qh09NEV+gPpDi3h+EEr17Y4rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds2iUV7B86oah7oAJEGLc1rngeJ9nlXzFHz8u58KJhho5sZNguazm1Tn6KA8LNgJcTNmix93Ww87wiAjXxbBQLvhM00ufsiv0/VW72ntSfdSC7u4Iqa+DRJ/QcF0e13rqqf2DRzWgCsrPlxHVPZoJpACqgABbu9HNSe9+w3raNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RSZz0nYs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb731ca8eso207032566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756406825; x=1757011625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zk4/XHzh8fN7NJt1U1cc1xXgNC+2AfvluqXsOt7pkrs=;
        b=RSZz0nYsnvwMLYGv/WteuEMRaXsMKN1XF3kM9YGVl33eru2yuXVcBWvxMXkKtMp6Jn
         3StxHfXZH0ntovUM5txxKY0/B8E09DFHe08EcGkl1faxDwaFno9JGs111We8oCjS/nUc
         O6BXA4A042rY8qfiYafGYOrNKICLbiCQCOOXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406825; x=1757011625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zk4/XHzh8fN7NJt1U1cc1xXgNC+2AfvluqXsOt7pkrs=;
        b=LYB3gkodOFWc+LGQqWRWrCrIypsY/cQmNSYXEbrlJBWBqL1BJfM9yvtcrvPRs6to0d
         PoArNhqwblAE5B85Wr/nqW7l94wiYbMbY8qjAwoP8/X8WFTTM2wJuv9yqaR5vYS9SIN2
         dpzBx95jCC2Y+85Ve7xBwMxpgaCfEGQ2fMVILTTpRvg6bUsz26etlqdza9gMbElS8Ejd
         g56GTyk02Q2E+ipDKQuH0lKTSCBKmuTpGy0RcWwGbhMjw+LNhyWIw8/1Zlm69c8RYdV9
         izrq1t++hK93L4jKeCdka+jUgLyh4vpydKTYRAMbzwnNddVMTdvzgk2Zw93wGR6iQrpq
         UyRw==
X-Gm-Message-State: AOJu0YwJ7jXMfAbxTP7VoW77iBas/8usTrcMOr7/NvthwGYWMpJ8YdBJ
	AHWU+zRXhooOSdPdB8pP+gUssl3xvekeixMdhiIDZZjdRoADVF5sOUWUSv+QimP2TwhTpXL2mZ5
	4aRqjgyw=
X-Gm-Gg: ASbGncv3oIAqh/AQBltLSdX4jJJqXI58rwd1Z11MwPkEcgc0NJpwS+/0EfG09yP1F2C
	pPFrWV28lskxtbILgNMrrQhoWv69dev9yEK/dPQZplLhX3lc6Fyu4uF683BNz2+YkkViwfsaaQ3
	3fnkIxz3uPyMFr7Juui8U5oi5WhZF1h3lOKfuh5ARLcP89jnny3fJFPttkA3sjT8YXeKAs0bQe9
	cSx6jJdxu96iseA6+07/C6igmhU50PH/KSdWllNUaB5qyNqKGmpMyd3ylF7yr6+DxkeJpe4OlAu
	0TjmVP5S94b48zXsrg9nRPHPZdnBJKqqkSog6z1cBY3GnoDve/2IoyvM161nOTgfz8Visa/MTkd
	PX4QgwkTEmHjnuUhRq2Nq+rt9YLXvH5i2aV9U5+RYDME9A/EzlmGTTyp87vD7qpLbrlPkNfm4Al
	+rR4lTnRk=
X-Google-Smtp-Source: AGHT+IFlUivc6CBfkTbJVTICfySs8LmIfG3Rj8fvAiZ8IX/bRzJcx8dmoiWzv8XId/gylqxBhCSZ1g==
X-Received: by 2002:a17:906:4ed5:b0:afe:84ed:614c with SMTP id a640c23a62f3a-afe84ed65a3mr1114778466b.24.1756406824972;
        Thu, 28 Aug 2025 11:47:04 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca3cce4sm20939666b.45.2025.08.28.11.47.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 11:47:04 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61cd3748c6dso2350949a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:47:04 -0700 (PDT)
X-Received: by 2002:a17:907:d8d:b0:afe:a121:c466 with SMTP id
 a640c23a62f3a-afea121c81dmr1115762266b.18.1756406392000; Thu, 28 Aug 2025
 11:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
In-Reply-To: <20250828180357.223298134@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 11:39:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
X-Gm-Features: Ac12FXwObny_n6wQ-ugpdD6HjGwdsHVCsiy2fjxZ8DxqXIznImh_eKBzj6tMsaI
Message-ID: <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 11:05, Steven Rostedt <rostedt@kernel.org> wrote:
>
> The deferred user space stacktrace event already does a lookup of the vma
> for each address in the trace to get the file offset for those addresses,
> it can also report the file itself.

That sounds like a good idea..

But the implementation absolutely sucks:

> Add two more arrays to the user space stacktrace event. One for the inode
> number, and the other to store the device major:minor number. Now the
> output looks like this:

WTF? Why are you back in the 1960's? What's next? The index into the
paper card deck?

Stop using inode numbers and device numbers already. It's the 21st
century. No, cars still don't fly, but dammit, inode numbers were a
great idea back in the days, but they are not acceptable any more.

They *particularly* aren't acceptable when you apparently think that
they are 'unsigned long'.  Yes, that's the internal representation we
use for inode indexing, but for example on nfs the inode is actually
bigger. It's exposed to user space as a u64 through

        stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));

so the inode that user space sees in 'struct stat' (a) doesn't
actually match inode->i_ino, and (b) isn't even the full file ID that
NFS actually uses.

Let's not let that 60's thinking be any part of a new interface.

Give the damn thing an actual filename or something *useful*, not a
number that user space can't even necessarily match up to anything.

              Linus

