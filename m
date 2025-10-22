Return-Path: <linux-kernel+bounces-865553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B823BFD7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7278A3B8FE9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7143F35B142;
	Wed, 22 Oct 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j88yYiUQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B50835B132
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151726; cv=none; b=RqQrQgEaWToGMBfYw/X0jBGHWbaAMGevGBu5JaORAXYJO0/AjMLFErnZqJyFnx5iNDX9bWR0Cxfd2W9SVj/RXHgnNOeAlh9t6+205Sf7DDuUphyQ3hlOAxJHJqGLfHzBnlhwvz45/8+NFrULFINNOEnnxQZxEuCvBL+3cvCfsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151726; c=relaxed/simple;
	bh=3HUrOy3HliEzxynSTd2AGPEdNfQmqeEcuJoORxQB0DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxtiIWG0FchiMByLBrqD1XArjpXyFJZbIVl1qAV9FKLtwYirvEpsA4eLVa9nIzZbv6h8gqQpsR6Vrp5AukaFTYeTUR00UYKbObAUEXTReZ9QuCpZ+l/tRHjJU8Mj/Oi5LxWdZg0R98fAnP0zqTdD70AWjxFsMdYP9jn0s2wSMnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j88yYiUQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso6648827f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761151723; x=1761756523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkGmrtBUxnIumAL8xu9/6QKpgwGH5LjIxRJ/PIq9w9k=;
        b=j88yYiUQYyC10kiCa9WxLaaa5F7AyE4UEJYnQSjTn2uIvz8kspqXoPYaMTW2tLwMiS
         jLu8TFmugt77ECz/I2dB1QiFwFxDGVKpkidhOp0mI9LtJu5mf7GAdEv/NLVrK+aAnIR8
         9D3yeR1RZlSPLSYd6/RrbwEqEer7WuCR1eYduNMZwPmhtMZ6EgMM2iR7hVP65ocQL8dt
         qIboEkNQKi6f6vpeFBya9uNVdo/b/kmBDKqgiAQ6h/Y7de4OsKcXMDIgzK+gd0lp1b+D
         jz0hOBOD8ODJkCJBhtuQ2lK6I+xsaVFHWmNoNOGACxjf30+k8r68bujpglgUrdQPPF9U
         2YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151723; x=1761756523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkGmrtBUxnIumAL8xu9/6QKpgwGH5LjIxRJ/PIq9w9k=;
        b=uqWnczxeXKZkrlDwZ3iJU3RkVRdIQ33F0YwkTWk8cgFbtS+b8q1yjLodTVgSOtIxi5
         jWGYdyE4PR8K5NUIqD2409b43hKULQ/LVcxsboQO/gMM0E6hj6hFbuQPa/Ges1RAqbuo
         TtbzjKQ+VtYCsByA6atEBRp7EqqI05b+VeKzCOubJd5SHcJtRUoJsrOxC+G9Pqq14o+j
         OsAp4o/+4m5rZjPIRW2pLEOrR9pQsIXU086LV73ijyiegHmsXU95pAxPi03ZJNIOUhgi
         cbCx26oXbX9gNm40pzLzcXTm5RwchUyBMB7WwZ4flfhdLR7N70+JjxtzYwKfX12s3twh
         X/gA==
X-Forwarded-Encrypted: i=1; AJvYcCVFn/y1TzIx2cz+IwRFcgmqYS1O1FU3mNZ28+6dIJOhCJPg6WeASOY+0KNOnrVEIR6LW+y8ogU8Z1UDplk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO5Cj5bhIeomUHraX9zC0PjLpahOqKAmJkoFOEgpCVukzFozsd
	0+dplNBFSoxVMF7dagC9JHO3ejNETsuvPYztp7V5mwzyFpGV+UbMHUty2YNuGIRClgT3t/fkaeU
	TVIE0kmdQdxNZVwQDSDkmckZw8brOcDU=
X-Gm-Gg: ASbGnctMomC1xKxrMx+csnUbiJ+bHwl8Q23zZeoq/eXSHUZOsYCIZQ8pwws94tDNsc2
	F4c4eI7+XlwhIHl4JZczOHQKm72PCVoyKhM7IzIpi8gThIqMOgXoY6LXAgs82xu6g87i3G1xA4y
	XPclfEfd531RG5pqVwSK8DZ1axagbMC4Q3Vz1rpGnzVW/kdRifcUh07gV1Fdl8NFB4SpLdE116o
	mhKPFL45Ob4o+KD7zu7UMllq1eUdpwVgxgAxoWdU8M0ltEG5fDjnV12169uPQigHX3/Xg3JOAaE
	pRRcjuwhYAiMdU71Y/tS+R8Z7sAa
X-Google-Smtp-Source: AGHT+IHGQIWEFvzltLOJQOUIBl0GmO2xOGuzPoNl+eqhJzTaJN/V9bP/9n1hi/0plGJ1ExPlMoQ5BrW5WAhxCBHLYSg=
X-Received: by 2002:a5d:5f82:0:b0:425:8bc2:9c4b with SMTP id
 ffacd0b85a97d-42704d83537mr12406127f8f.6.1761151722349; Wed, 22 Oct 2025
 09:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022071825.238909-1-jiayuan.chen@linux.dev> <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev>
In-Reply-To: <6aa7fafd-30b1-4605-8b80-4a158934218d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Oct 2025 09:48:29 -0700
X-Gm-Features: AS18NWDmayCCUbz8NqfwUZbauZk3a75e37wRBA-4fyqo7UIquVdyDsJAWiI6ZH4
Message-ID: <CAADnVQL7RtTFsr36hbT331X6XQHat4XKRcun=0e5jPohX+TF0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Guard addr_space_cast code
 with __BPF_FEATURE_ADDR_SPACE_CAST
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:33=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 10/22/25 12:18 AM, Jiayuan Chen wrote:
> > When compiling the BPF selftests with Clang versions that do not suppor=
t
> > the addr_space_cast builtin, the build fails with assembly errors in
> > "verifier_ldsx.c" [1].
> >
> > The root cause is that the inline assembly using addr_space_cast is
> > being processed by a compiler that lacks this feature. To resolve this,
> > wrap the affected code sections (specifically the arena_ldsx_* test
> > functions) with #if defined(__BPF_FEATURE_ADDR_SPACE_CAST). This
> > ensures the code is only compiled when the Clang supports the necessary
> > feature, preventing build failures on older or incompatible compiler
> > versions.
> >
> > This change maintains test coverage for systems with support while
> > allowing the tests to build successfully in all environments.
> >
> > [1]:
> > root:tools/testing/selftests/bpf$ make
> >
> >    CLNG-BPF [test_progs] verifier_ldsx.bpf.o
> > progs/verifier_ldsx.c:322:2: error: invalid operand for instruction
> >    322 |         "r1 =3D %[arena] ll;"
> >        |         ^
> > <inline asm>:1:52: note: instantiated into assembly here
> >      1 |         r1 =3D arena ll;r0 =3D 0xdeadbeef;r0 =3D addr_space_ca=
st(r0,...
> >        |                                                           ^
>
> I think you are using llvm18 and earlier. Why can you upgrade to llvm19 a=
nd later
> which should solve the problem?
>
> > Fixes: f61654912404 ("selftests: bpf: Add tests for signed loads from a=
rena")
>
> We do not need to have Fixes. compiler is also moving forward, we cannot =
support
> really old compiler and it is no point to have __BPF_FEATURE_ADDR_SPACE_C=
AST
> for really old compilers. So at some point, __BPF_FEATURE_ADDR_SPACE_CAST=
 will
> become default.

+1
and this is not the first time we're seeing this type of patches.
Upgrade your compiler. That's the only way.

pw-bot: cr

