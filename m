Return-Path: <linux-kernel+bounces-796966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AECB40A1D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E677B63AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99D732A81A;
	Tue,  2 Sep 2025 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVHxZHZV"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBA2D5C8B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756829107; cv=none; b=gHsW2MyklJxYeM2JCnrDAXwrdbd5RY/xGTcD+X8WJlBuYo7rP37ethqVRyf8tRGCxgcya/GWNakODBFUiLsAjJRJ+9cDjGetlLbbM2fwFyZHanErHCpAscWE9QsCiYjyfac3hM6w/JGoaYaVAaC3gi1PU24ss7ilipmnaRJ7+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756829107; c=relaxed/simple;
	bh=z50NzjcKlPivT1ks2KKwNwrjRHBj8L5rO2tH8V9fz1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnqGqf5sSY6VzzSDWxdtVVjHU+Q0a7RID9KdKcNNFeZtAOhuXjrseyf0oP2Wh2ORsbufbNhB+ApobI1uw7oL9Qq9okRkj/dDtiPVBKyOmrZA5SaXjzr1hF2HWDR3AHiajzr3hIEA2kh2oKHoAiGgNPsvZc6T3bmF4Z/Pdxs6Ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVHxZHZV; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so20176355e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 09:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756829104; x=1757433904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3rIC2TE2Lyn58cUZrFIvfw/WbAh8YL+TOd39koE7a4=;
        b=ZVHxZHZVKRexzSUMsT0t+rr33EokETt0o75gpSLsoSo0OXKV2nJgr1r8H6LZ2t/R4y
         3EeMh2zx8mu08CDlc+gXtHuDGilDqL1Rc1QAUAyr5/fgTDNSNUWBAmApB66YkjY+h8kG
         SgDLteQqymS9r3kOnpd52TSmBNQQuAG9VcFqRy7+JbezIIXdUgXSOgcODY95oH2lQCDd
         pGL/FLzKYf0pDROm+Pbb2X1uyPDyQxDNIG5EOJ43ZkJiH9DzfvsK9PPjrYz1Kerd7IHK
         mFKdVi1Cy5xvhOwAkiQdaZ8e8goQUvTNAtoHoALxWmNlHOhqoqQV5Suruu4GE2KGrnt6
         ls7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756829104; x=1757433904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+3rIC2TE2Lyn58cUZrFIvfw/WbAh8YL+TOd39koE7a4=;
        b=vcNCw+E+x5OKNKRc8FzRIO9xSr/gwSJrd6JcCcmHQJn95HQB92jP7C3AZ7MzV3hTLB
         tEJ2YM1Xe4kTfULu/ncjhcA5yVrpSm4FF5l3cTyPM2jHl5hzW9xKpWYwSu6GNrgamOjr
         /0YRBddauzQZaXs+UMH9AAy6PRlevfHRXL+6pSXcSZG9uO3ucCitro0F+1DXFhRWa1tb
         L/junPMkLvabTqcblok1GZj4IsUeURfz82QgE9tq85uHhWcavZ4G1bcgwyl/Bi3hxpod
         2MYNnlf/VQU04oPjPfC7G3dafVc1nvefTGsVbxZKoeb8ZsMM5ETKAes44t+kkruG/z0E
         5F4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQaTIB4IE0egr/a66vHAgP1l41m/48JEotRkXRB1WigJpI51lkwuhmaxaoyZuU0JFebB1YdPEBJO8zmJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6eRyx7fGGkP1CDTl1ocaQcqq1fApQmlnZw5wnYf8XE06dlmKH
	aDKoM1Whsi7PUDC2eqVhZZT20N7ZZE8wGWrPSw1SPm1/YW8ATaXIFdLMJwl1V7LsA7m2NwtSmos
	Rp71v8n2wTsHs4QdeZ1pIEDCInuAKhKU=
X-Gm-Gg: ASbGnctm0NUQH1OdONkGqXQUmE0JBlK1HLRkzUwIuudcKW6trO4F4auKY7+roon1Zey
	yZt8uf8Ld9oIFk/+ot9ZJytlXiucVIo5BFLtCvXnBbpvu3uICMy0K1rC69hResVPRxMQgweY4CW
	sPRBP+MOxrCTFIZNhEClYtrAIGY6F/obLGFIvCQz+kngT4Xms3z5ypJotlsnq82XqKgvxlcGFoq
	8qVAdQF50dRCCK8Y0WxRws=
X-Google-Smtp-Source: AGHT+IGVdYfyHeOQlWseAO6wwVyx+XSvElrXvSZ8VCvcISgW3WvbxYWlotIaV/UMbovpIf+YYKVvaG8TmiV/16XZfPs=
X-Received: by 2002:a05:600c:4515:b0:45b:8078:b31d with SMTP id
 5b1f17b1804b1-45b85525d8dmr96717845e9.6.1756829103761; Tue, 02 Sep 2025
 09:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901191307.GI4067720@noisy.programming.kicks-ass.net> <20250902081915.GK3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250902081915.GK3245006@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Sep 2025 09:04:51 -0700
X-Gm-Features: Ac12FXzbsndI341Y_g4qCBycCZgZoQBBkF7KK3sMlRUSsTRJyiFZllL9SL-mdEQ
Message-ID: <CAADnVQJ2zm7BRb3SuwcmCQ5SBULznbUq777vMCHkm9UbPkaAbQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86,ibt: Use UDB instead of 0xEA
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, ojeda@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:19=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
>
> Because this is all somewhat magical code, and this change is a little
> on the large side, it as been suggested I 'upgrade' the Changelog some.
>
> On Mon, Sep 01, 2025 at 09:13:07PM +0200, Peter Zijlstra wrote:
> >
> > A while ago [0] FineIBT started using the 0xEA instruction to raise #UD=
.
> > All existing parts will generate #UD in 64bit mode on that instruction.
> >
> > However; Intel/AMD have not blessed using this instruction, it is on
> > their 'reserved' opcode list for future use.
> >
> > Peter Anvin worked the committees and got use of 0xD6 blessed, it
> > shall be called UDB (per the next SDM or so), and it being a single
> > byte instruction is easy to slip into a single byte immediate -- as
> > is done by this very patch.
> >
> > Reworking the FineIBT code to use UDB wasn't entirely trivial. Notably
> > the FineIBT-BHI1 case ran out of bytes. In order to condense the
> > encoding some it was required to move the hash register from R10D to
> > EAX (thanks hpa!).
> >
> > Per the x86_64 ABI, RAX is used to pass the number of vector registers
> > for vararg function calls -- something that should not happen in the
> > kernel. More so, the kernel is built with -mskip-rax-setup, which
> > should leave RAX completely unused, allowing its re-use.
>
>  [ For BPF; while the bpf2bpf tail-call uses RAX in its calling
>    convention, that does not use CFI and is unaffected. Only the
>    'regular' C->BPF transition is covered by CFI. ]

I cannot comprehend the new scheme, but thanks for heads up.

