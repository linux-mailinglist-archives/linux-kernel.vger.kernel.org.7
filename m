Return-Path: <linux-kernel+bounces-636827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478A7AAD054
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 23:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9104F16E42B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A6021CA0A;
	Tue,  6 May 2025 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YDwjjDti"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42CA21C9EB
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567709; cv=none; b=KGuA8qyDAy3dGTdRPdx0ylT+YJZROUeigQQb1Zas+R8gfFG9FWGBMWBQ+G3+RY+jZPjdZc7vK0/RoYbs/O50kurRb/6ltlODocWdEibnSGvBnVXZefK3vt1CZpUpL5Eb+QYW6Hn/grj3iopbWXFEYgeDZ3imYJwX0f54eqF/a3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567709; c=relaxed/simple;
	bh=9Py2oVLHloj66xUiBl2POuXmO5mcK7wpP1uDUE0NvtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMqUbI00J7RUgh2JuxTkCYoqjkJUlNUE2EU+H81AqONEloATkmDYyeWCJuSN3BZcgTEHY/SzVZM97stMnFVJcEcnaFA+viYqxDrV5q2q8mtMZn0xo1MH9wDbZLXUdveww3z5Fyq9F7ld9UdichZyX4Pa75FoR5iygNK9N1y8Q5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YDwjjDti; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5122286-68f0-4173-8549-a0705c4ca4b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746567694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ReRcs50Y2MVdPcjHGR1u+evgYlPhmw1Q5xKyWbX3gxE=;
	b=YDwjjDti3JF6hcqRA6FBTwpeyU6orKRjCOb+GtGFeXhi7HZ/9H/5TGf8RCxSasdsqyQY2r
	q89Km0DLHpywgMuUjwwVyq79HXEkxtk0B/rrbHKnIyDEhLaJfISAXnK/S0h4psT8kdFSCR
	fGbNjitCmcPwYHbtoX2ejddpzkYytVA=
Date: Tue, 6 May 2025 14:41:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpftool: build bpf bits with -std=gnu11
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250502085710.3980-1-holger@applied-asynchrony.com>
 <7326223e-0cb9-4d22-872f-cbf1ff42227d@kernel.org>
 <913f66a8-6745-0e30-b5b8-96d23bf05b90@applied-asynchrony.com>
 <CAADnVQLpyNiyghWLMq5AxkBgZX4J9VfX5j4ToNh6UsrQ=4yndg@mail.gmail.com>
 <2a8208af-bc4b-f1bd-af0b-f5db485ed1f0@applied-asynchrony.com>
 <CAEf4BzYLYJtcehZhB22YsxRXZBcVnunNx-rm9CfTcDZFiY10jQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzYLYJtcehZhB22YsxRXZBcVnunNx-rm9CfTcDZFiY10jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025-05-06 2:04 p.m., Andrii Nakryiko wrote:
 > On Sun, May 4, 2025 at 3:24 AM Holger Hoffstätte
 > <holger@applied-asynchrony.com> wrote:
 >>
 >> On 2025-05-03 04:36, Alexei Starovoitov wrote:
 >>> On Fri, May 2, 2025 at 2:53 AM Holger Hoffstätte
 >>> <holger@applied-asynchrony.com> wrote:
 >>>>
 >>>> On 2025-05-02 11:26, Quentin Monnet wrote:
 >>>>> On 02/05/2025 09:57, Holger Hoffstätte wrote:
 >>>>>> A gcc-15-based bpf toolchain defaults to C23 and fails to 
compile various
 >>>>>> kernel headers due to their use of a custom 'bool' type.
 >>>>>> Explicitly using -std=gnu11 works with both clang and bpf-toolchain.
 >>>>>>
 >>>>>> Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
 >>>>>
 >>>>> Thanks! I tested that it still works with clang.
 >>>>>
 >>>>> Acked-by: Quentin Monnet <qmo@kernel.org>
 >>>>
 >>>> Thanks!
 >>>>
 >>>>> I didn't manage to compile with gcc, though. I tried with gcc 
15.1.1 but
 >>>>> option '--target=bpf' is apparently unrecognised by the gcc 
version on
 >>>>> my setup.
 >>>>>
 >>>>> Out of curiosity, how did you build using gcc for the skeleton? 
Was it
 >>>>> enough to run "CLANG=gcc make"? Does it pass the clang-bpf-co-re 
build
 >>>>> probe successfully?
 >>>>
 >>>> I'm on Gentoo where we have a gcc-14/15 based "bpf-toolchain" package,
 >>>> which is just gcc configured & packaged for the bpf target.
 >>>> Our bpftool package can be built with clang (default) or without, in
 >>>> which case it depend on the bpf-toolchain. The idea is to gradually
 >>>> allow bpf/xdp tooling to build/run without requiring clang.
 >>>>
 >>>> The --target definition is conditional and removed when not using 
clang:
 >>>> 
https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/bpftool/bpftool-7.5.0.ebuild?id=bf70fbf7b0dc97fbc97af579954ea81a8df36113#n94
 >>>>
 >>>> The bug for building with the new gcc-15 based toolchain where this
 >>>> patch originated is here: https://bugs.gentoo.org/955156
 >>>
 >>> So you're fixing this build error:
 >>>
 >>> bpf-unknown-none-gcc \
 >>>           -I. \
 >>> 
-I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-sources/include/uapi/
 >>> \
 >>> 
-I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-sources/src/bootstrap/libbpf/include
 >>> \
 >>>           -g -O2 -Wall -fno-stack-protector \
 >>>            -c skeleton/profiler.bpf.c -o profiler.bpf.o
 >>> In file included from skeleton/profiler.bpf.c:3:
 >>> ./vmlinux.h:5: warning: ignoring '#pragma clang attribute' 
[-Wunknown-pragmas]
 >>>       5 | #pragma clang attribute push
 >>> (__attribute__((preserve_access_index)), apply_to = record)
 >>> ./vmlinux.h:9845:9: error: cannot use keyword 'false' as 
enumeration constant
 >>>    9845 |         false = 0,
 >>>         |         ^~~~~
 >>> ./vmlinux.h:9845:9: note: 'false' is a keyword with '-std=c23' onwards
 >>> ./vmlinux.h:31137:15: error: 'bool' cannot be defined via 'typedef'
 >>> 31137 | typedef _Bool bool;
 >>>         |               ^~~~
 >>>
 >>> with -std=gnu11 flag and
 >>
 >> Yes, correct. This is the same as all over the kernel or the bpf tests
 >> for handling C23. I fully understand that this particular patch is only
 >> one piece of the puzzle.
 >>
 >
 > What's the best way to detect (at compile time) whether bool, false,
 > and true are treated as reserved keywords? To solve this properly
 > vmlinux.h would have to be adjusted by vmlinux.h to avoid emitting
 > bool/false/true *iff* compiler version/mode doesn't like that
I ran into this when adding GCC BPF to CI [1].

One can do something like:

      #if __STDC_VERSION__ < 202311L
      enum {
          false = 0,
          true = 1,
      };
      #endif

But in case of vmlinux.h this would require hacking bpftool, and so for 
selftests/bpf we decided to pass -std=gnu11 [2].

[1] 
https://lore.kernel.org/bpf/CAADnVQKNqdLW1bpvCpVV3yNizwra0cCkBnAbsNp3rTmi8WFcvQ@mail.gmail.com/
[2] 
https://lore.kernel.org/bpf/20250107235813.2964472-1-ihor.solodrai@pm.me/

 >
 >>> ignoring an important warning ?
 >>
 >> Nobody is (or was) ignoring the warning - it was under discussion when
 >> I posted the patch. After reaching out to Oracle to verify, we have now
 >> added the BPF_NO_PRESERVE_ACCESS_INDEX define when building with 
gcc-bpf;
 >> this resolves the warning, just like in the bpf self-tests.
 >>
 >> You are right that such an addition to the in-kernel bpftool build is
 >> still missing. If you have a suggestion on how best to do that via the
 >> existing Makefile I'm all ears.
 >>
 >> As for the remaining warnings - we are also very aware of the ongoing
 >> upstream work to support btf_type_tag:
 >> https://gcc.gnu.org/pipermail/gcc-patches/2025-April/682340.html.
 >>
 >>> End result: partially functional bpftool,
 >>> and users will have no idea why some features of bpftool are not 
working.
 >>
 >> First of all this is never shipped to any users; using gcc-bpf requires
 >> active opt-in by developers or users, and now also warns that such a 
setup
 >> may result in unexpected bugs due to ongoing work in both Linux and 
bpftool.
 >> Like I said before, by default everyone builds with clang and that 
is also
 >> true for our distributed binaries.
 >>
 >> If you think adding the -std=gnu11 bit is inappropriate at this time 
then
 >> just ignore this patch for now. Sooner or later the bpftool build 
will have
 >> to be adapted with BPF_CFLAGS (liek in the selftests) and hopefuilly an
 >> abstracted BPF_CC so that we no longer have to pretend to be clang when
 >> using gcc.
 >>
 >> cheers
 >> Holger

