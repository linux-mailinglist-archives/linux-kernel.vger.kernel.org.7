Return-Path: <linux-kernel+bounces-851673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D6BD708F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F4F04FA3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEF92DE1E4;
	Tue, 14 Oct 2025 01:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ0+7vGr"
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070612DCF45
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407061; cv=none; b=R2A85DAWa04sLPB1QkB4Ihvtg59g+JEFzKc+M734JebifgZfU8qIW/qYA+GLAuKmVHo7Xr1sq/fU6EiUazKJrv/KEKn2iLGjUhaqkneYE2X3cleu/IJudg6FgM6cNbRLJsDRdiEhsDLGjl++dZJ+1h+Jl79AwIVDaZqKTOkmNcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407061; c=relaxed/simple;
	bh=OOTR6H6rE4EgVqvj12PYQGMkKkwblBI6CSm6QlAnD5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VO3HLTD/9UUWGtnRBESpIlO8ffRxMFmlDhdGxuKWfP56sLFs41S4DdCM6xYsISMDecYYSj6/2ffkxkEz86fUux8+Es1yUaCHWuLZpZ0DDaAuyHCbx1NlzJEYx0UcL7mXCthuILP2Qv54LL7b/L2ZF5GAGUdwN4J/41QRlTys6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ0+7vGr; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-362acd22c78so40788031fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760407054; x=1761011854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwp5CrjdVG3aBeAI+F3QhhxogWoO/pXLHfY4OvEFmYw=;
        b=IQ0+7vGrrfbcSVzR9coCjC2axifLv0ZJ8tOY1GIZSRj5gVboH8D7MvtclV1GX5j3Pz
         5jw2BQU2HbZ2jyHdK+Q7Tc8f7eg0PaAZFKWvydmIn4Varex8N/xM1zbznOrS2hA68/Pn
         T85+KQRkWb3a6jGdELoGzHzl3PmZJYbAZCyuxcmQixIRAgVomC0mjjLmYrh6t+0lMAPx
         xJ9Bpe7hES64WnB3jZ5W9+1l2clcudXM5O9xydF6cWH+5rLgbe02hMGIWiy/QyWvrf09
         +YwFClRk93n+XcPjU8BwUe1SgQ7pZvUHvMyFtUZHnGF7zQEXT/udoJVE1JRcDAqg4faU
         yYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760407054; x=1761011854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwp5CrjdVG3aBeAI+F3QhhxogWoO/pXLHfY4OvEFmYw=;
        b=Tq/O9OZQ1/EuqZjPsiWtT2PeIu6PDfESC7ri4To3QvlIhHeQvICpl31tlY+GAtFu6L
         VFkSqzLO94f7laQAvTgcsCfUXNbV2kFh/oNPLz4S1i+HavEE5MXNTVMULpzOlU7hI16x
         Gj+FPDSdG7qf4eOaBxBe6ac5OhlfHwmwHepzlNDdKkH/RZKS2SUH6mKmpptfwyxoKjiw
         Ruga15/NouG9AcldaI6Fus6aYtoynYLJhhQL30CFHhTJYQbiEkC70VH+ZYq4j+sRiYNL
         USKaULg4S4qi6dRke3Y7FvFnMe02N4Oeb0VtNQ9dcxJd22+nE4dUVbQGU2VRwd1C3kQj
         MhXA==
X-Forwarded-Encrypted: i=1; AJvYcCVIRgBjz3G3NI1ugsm5d+IMLjux0NjNgcviZ3DqnfDNWJ/dzXnAaBspVjQTrhcRXj+kBEztl4CNLLI2CSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQYWidI+hJVFviq87Cm/lyJ0gNBnS1Sw9CANHsK1q6peRqZ/v
	UvOkDZYvYqO5GFmUvgcZKs+9ri7VzvxPL47TQyKMzmXjgjLqR38YMgyRQnciQFy5erUO0BVg0EI
	fj7BtigyKxKKjZtdESCR/u38XKb0IUUT/UwEwvb8XPA==
X-Gm-Gg: ASbGnctFCDYdGZpAl+eoYGck2uGebhtXS3oUBEcmT4aSIFTCKO0x/C32pcqax6ZQiQA
	/qVySCOWtqpSf1c2R8BjPKvL0/mDMU/ZHJu5rwVbs1m7Z2HGMMNdmMhEMbICESmgynPuMmfU7J7
	/tKdAxoJJKQ7prT+urci5iQGOOO+yeSOzvo59hoOnavURzHqF3pY4inrlJEZ0SMmymI1WgT/z7B
	FB+GhFmFQoEZt9JVf90ILfvV1w=
X-Google-Smtp-Source: AGHT+IFQvjrCENHDymi5ELE9Ce1X2qshEHiV18UvddhmumqfOHhO0xkbBHvFpg+eyabJPfVAQRjhe68InR0xoBL28h0=
X-Received: by 2002:a05:651c:54e:b0:336:df0e:f4ac with SMTP id
 38308e7fff4ca-37609e64b90mr55453661fa.25.1760407053269; Mon, 13 Oct 2025
 18:57:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
In-Reply-To: <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Tue, 14 Oct 2025 09:57:21 +0800
X-Gm-Features: AS18NWDdIM8Jz4xqJOYc2o6-4Tffmio45yh6BrtEiFfzLmytSx6MwmUvQ_ki7WQ
Message-ID: <CADHxFxR_S43zzrStKVvbFjwkqFFOjMY8xcFK41Fc1U2xYvYJmA@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi lan,
Thank you very much for your reply.

On Mon, Oct 13, 2025 at 11:46=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Oct 13, 2025 at 1:08=E2=80=AFAM hupu <hupu.gm@gmail.com> wrote:
> >
> > Hi Maintainer,
> >
> > I encountered some issues while cross-compiling perf (ARCH=3Darm64),
> > particularly when enabling the BPF option. During the build, Clang
> > fails to compile BPF programs due to missing header files. The
> > relevant error messages are as follows:
>
> Thanks for reporting this issue! There has been some recent work in
> this area by Leo:
> https://lore.kernel.org/lkml/20251006-perf_build_android_ndk-v3-0-4305590=
795b2@arm.com/
> The patches are in Linux v6.18-rc1. Perhaps you could try repeating
> your build with this tree and reporting issues?
>

My local code is already updated to the latest version, and the
current commit is exactly at tag: v6.18-rc1:

commit 3a8660878839faadb4f1a6dd72c3179c1df56787 (tag: v6.18-rc1,
origin/master, origin/HEAD)
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Oct 12 13:42:36 2025 -0700

    Linux 6.18-rc1

However, building with this version still gives the same error as
before =E2=80=94 when Clang tries to compile the BPF programs, it fails due=
 to
a missing asm/ioctl.h header file.

----------------------------------------------------------
  INSTALL libsubcmd_headers
  INSTALL libsymbol_headers
  SYSHDR  /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/arch/arm64/include/generated/uapi/asm/unistd_64.h
  INSTALL libapi_headers
  INSTALL libperf_headers
  CC      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/evsel.o
  INSTALL libbpf_headers
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bperf_leader.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/uti=
l/bpf_skel/.tmp/bperf_follower.bpf.o
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_e=
vent.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
11 error generated.
 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bperf_leader.bpf.o]
Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bpf_prog_profiler.bpf.o]
Error 1
1 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel=
/.tmp/bperf_follower.bpf.o]
Error 1
  LD      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/libperf-in.o
  AR      /home/hupu/work/code/explore/output/build-mainline/tools/perf/lib=
perf/libperf.a
make[2]: *** [Makefile.perf:289: sub-make] Error 2
make[1]: *** [Makefile:76: all] Error 2
make: *** [Makefile:93: perf] Error 2
----------------------------------------------------------

However, when I apply the previous PATCH and explicitly specify the
sysroot of the cross toolchain via the EXTRA_CLANG_FLAGS setting, the
build succeeds:

    SYSROOT=3D$(${CROSS_COMPILE}gcc --print-sysroot)
    EXTRA_CLANG_FLAGS=3D"--sysroot=3D$SYSROOT"
    make perf ARCH=3D$ARCH CROSS_COMPILE=3D$CROSS_COMPILE
EXTRA_CLANG_FLAGS=3D"$EXTRA_CLANG_FLAGS"

Please let me know if you need any more details or testing.

Thanks,
hupu

