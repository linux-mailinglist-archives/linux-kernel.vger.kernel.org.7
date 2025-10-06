Return-Path: <linux-kernel+bounces-843356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFC4BBF021
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E47C3AAA80
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794AA2D29C8;
	Mon,  6 Oct 2025 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IC35IayU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A552D480F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776254; cv=none; b=Z+kKHscwXv9qrGhAdsHoefKNLNngUikKFj0ciZ9ZWa898cY4TxqA1D6sNeTaMU9rmPf7SPUYs4M+94CquPh8gORAXl2B5ncvW8KRNXDRTGE/PkqMkN1LoHb8wR9OLIRBYtLGnPtxcbbsszhy4tp/PzSWUDoZPGQVLDWARIZpPiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776254; c=relaxed/simple;
	bh=X+tr2XCMAwHWnWxqVZBnbFYTPqk7n2BMKLPVD5KgGbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nch8nLYsKMCoaaJ1KOrF73idHWZge4l684BNX5w9OakzHTTU0SC5S3hoD93KjBzlcB9hNnP2hOmNOipOt0Szn/sf9agT4cI/KOu5tlfN0nFUpbt4Vut/JG/IvhYQ1Eyi3oQ1IRaBZooKUziiP9eRzX23UvzEl0NVvi33seCoZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IC35IayU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d67abd215so47255ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759776252; x=1760381052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfU14AJ/OtVXCKIuNIoZ3YvQpeardzrp+WTaVRgC7ro=;
        b=IC35IayUmtlOOVcQK9TOjkJq6jouUPxESDNtQ6U8kYxl5b+FkDPDbvwgStlR1OhN3k
         7AgRBMzsFUEcTSzAlQfhEkhUTxN3B06amEFWK/LiMIGfdSWH2eM4GbSLQb7q8HEbv5b0
         E3SxfWKa8HuW9b+xvZpgih8Y/bccE9RBrNhlE5nUjsxcCRJ24cIe/9/XgjMJhULhzlWN
         AmbKTrwb3SiNO5kC1kx6Ovwj1vDqnt/nOlHfEZsgzAhztYYOuUn7hOkAh7AIiq1xmtF7
         yDaHwEkb9vRk5ev1wJz+EFvDJomt+zy1TcKuBATjB7z6dYiWccJCSEoj6Bv2ILmzr6S7
         jbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759776252; x=1760381052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfU14AJ/OtVXCKIuNIoZ3YvQpeardzrp+WTaVRgC7ro=;
        b=bnZU4cjq94ZLc4hTGtT4AezR1K2MhkOq8jgPZ5ST7IBwAbLje+bGHz7eIhA84YKmPy
         mZ/rysfv4Qghs+ftgVPBheQYiziToNbB8mGMoLSUdzA8A8wcLNV1mcgArS1Q+KTK6fg1
         pb6eW5p2AWfhjKQpa7vWnK1ckL+aAr3o1w24YSN3kBe6XUqNgtApsiBQtH9gwrEU3cLY
         qzKIz/KMQr2fb0DFDNo2XqqemXV/LCcpde/NNH/2OQILGRw5Dd4tUnx/R8NCtm2v1Ax/
         3zs2At/KrPPe8BnsWE7lBIoIrh0vkwVn3l9CZDUXYObDFjMRbmUZFFlX2eWlFqVJOmzs
         8JKg==
X-Forwarded-Encrypted: i=1; AJvYcCW8SxNR/uaniC/VNaqQLl6G9++JB+bmyeOyxTGJKCNrE1Lbn3korM+KrK776ABv9E0vT84Jrwfmh3vFmIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2I4wB8eU1QJc5s5Jxssh2KLwq9+Pa9i8RSMvCmh+/cgo3SQOb
	FRWfyfHVXC+Bb5/mA+Z2DM5ZC7O/0VnkaSaSgsjINh136J2+o81ljnRoYGTqhcLal7uv8D1E5Bm
	GeWs97/jUfMcgJnuyR0ik+rVyKSEuh4E/BIntF/P8
X-Gm-Gg: ASbGncsqTDkSLL/CiJhIcnKohgZAEhuI46FDYqzQ293O41Vrx4lcOEKfUHI8Sfv/QfX
	xG79WfmYLnbY6bISbTNdgsJa86PdKVqjGdIZLW2eGjwOmM8TPtWlR5BRlUQNxs8eDY6XBffjov0
	Ckdbh04KIqG8YNhXCOLxZla4w0b/TpWzkKTPU9y5h5gEXlyzOtmmEj3CwUCwzBOYrTW0fhaBmM5
	BZiq/YS9t7YqIxAK6UfL6L3ZCI4KbO6hPK6EXi7KmxY6M1kV3RxUsrC3pyuBwg/uXuJksaS9oHP
	sAQ=
X-Google-Smtp-Source: AGHT+IFpGJ2JxtcXytazlwdhNBLV/UnZbGjs6PEoqdns6ICcJmkmM6fBOQefYc1xb6BGnq6H8F/rjZaF8EhbBxDMHJA=
X-Received: by 2002:a17:902:ebca:b0:268:cc5:5e44 with SMTP id
 d9443c01a7336-28eca403720mr613875ad.6.1759776251590; Mon, 06 Oct 2025
 11:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005212212.2892175-1-irogers@google.com> <aOQMzhBqoL8qs5t2@x1>
 <aOQNXBje78z-gPpi@x1>
In-Reply-To: <aOQNXBje78z-gPpi@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 11:44:00 -0700
X-Gm-Features: AS18NWA2nRhvenrr-oaT4z6skmKoU7LQlxZLxJeDsUQTuyT0uJIBjvusq8prB-Y
Message-ID: <CAP-5=fU6U7SBx7tWq-Pemxh3RACS8gxX8oM6p9+M8PMAtB_6FQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/11] Capstone/llvm improvements + dlopen support
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Li Huafei <lihuafei1@huawei.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Haibo Xu <haibo1.xu@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 11:41=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Oct 06, 2025 at 03:39:13PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sun, Oct 05, 2025 at 02:22:01PM -0700, Ian Rogers wrote:
> > > v7: Refactor now the first 5 patches, that largely moved code around,
> > >     have landed. Move the dlopen code to the end of the series so tha=
t
> > >     the first 8 patches can be picked improving capstone/LLVM support
>
> > So I tentatively picked the first 8 patches, will test it now, hopefull=
y
> > we can go with it to have BPF annotation...
>
> > Wait, will try to fix this one:
>
> > =E2=AC=A2 [acme@toolbx perf-tools-next]$ git log --oneline -1 ; time ma=
ke -C tools/perf build-test
> >                  make_static: cd . && make LDFLAGS=3D-static NO_PERF_RE=
AD_VDSO32=3D1 NO_PERF_READ_VDSOX32=3D1 NO_JVMTI=3D1 NO_LIBTRACEEVENT=3D1 NO=
_LIBELF=3D1 -j32  DESTDIR=3D/tmp/tmp.w26bDGykTM
> > cd . && make LDFLAGS=3D-static NO_PERF_READ_VDSO32=3D1 NO_PERF_READ_VDS=
OX32=3D1 NO_JVMTI=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1 -j32 DESTDIR=3D/tm=
p/tmp.w26bDGykTM
> >   BUILD:   Doing 'make -j32' parallel build
> > <SNIP>
> > Auto-detecting system features:
> > ...                                   libdw: [ OFF ]
> > ...                                   glibc: [ on  ]
> > ...                                  libelf: [ OFF ]
> > ...                                 libnuma: [ OFF ]
> > ...                  numa_num_possible_cpus: [ OFF ]
> > ...                               libpython: [ OFF ]
> > ...                             libcapstone: [ OFF ]
> > ...                               llvm-perf: [ OFF ]
> > ...                                    zlib: [ OFF ]
> > ...                                    lzma: [ OFF ]
> > ...                               get_cpuid: [ on  ]
> > ...                                     bpf: [ on  ]
> > ...                                  libaio: [ on  ]
> > ...                                 libzstd: [ OFF ]
> > <SNIP>
> >  CC      tests/api-io.o
> >   CC      util/sha1.o
> >   CC      util/smt.o
> >   LD      util/intel-pt-decoder/perf-util-in.o
> >   CC      tests/demangle-java-test.o
> >   CC      util/strbuf.o
> >   CC      util/string.o
> >   CC      tests/demangle-ocaml-test.o
> >   CC      util/strlist.o
> >   CC      tests/demangle-rust-v0-test.o
> >   CC      tests/pfm.o
> >   CC      tests/parse-metric.o
> >   CC      util/strfilter.o
> >   CC      tests/pe-file-parsing.o
> > util/llvm.c: In function =E2=80=98init_llvm=E2=80=99:
> > util/llvm.c:78:17: error: implicit declaration of function =E2=80=98LLV=
MInitializeAllTargetInfos=E2=80=99 [-Wimplicit-function-declaration]
> >    78 |                 LLVMInitializeAllTargetInfos();
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > util/llvm.c:79:17: error: implicit declaration of function =E2=80=98LLV=
MInitializeAllTargetMCs=E2=80=99 [-Wimplicit-function-declaration]
> >    79 |                 LLVMInitializeAllTargetMCs();
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > util/llvm.c:80:17: error: implicit declaration of function =E2=80=98LLV=
MInitializeAllDisassemblers=E2=80=99 [-Wimplicit-function-declaration]
> >    80 |                 LLVMInitializeAllDisassemblers();
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > util/llvm.c: At top level:
> > util/llvm.c:73:13: error: =E2=80=98init_llvm=E2=80=99 defined but not u=
sed [-Werror=3Dunused-function]
> >    73 | static void init_llvm(void)
> >       |             ^~~~~~~~~
> > cc1: all warnings being treated as errors
> >   CC      tests/expand-cgroup.o
> >   CC      util/top.o
> >   CC      tests/perf-time-to-tsc.o
> >   CC      util/usage.o
> > make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build=
:86: util/llvm.o] Error 1
> > make[6]: *** Waiting for unfinished jobs....
> >   CC      tests/dlfilter-test.o
> >   CC      tests/sigtrap.o
> >   CC      tests/event_groups.o
>
> Guess this will be enough:
>
> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> index 565cad1969e5e51f..2ebf1f5f65bf77c7 100644
> --- a/tools/perf/util/llvm.c
> +++ b/tools/perf/util/llvm.c
> @@ -70,6 +70,7 @@ int llvm__addr2line(const char *dso_name __maybe_unused=
, u64 addr __maybe_unused
>  #endif
>  }
>
> +#ifdef HAVE_LIBLLVM_SUPPORT
>  static void init_llvm(void)
>  {
>         static bool init;
> @@ -90,7 +91,6 @@ static void init_llvm(void)
>   * should add some textual annotation for after the instruction. The cal=
ler
>   * will use this information to add the actual annotation.
>   */
> -#ifdef HAVE_LIBLLVM_SUPPORT
>  struct symbol_lookup_storage {
>         u64 branch_addr;
>         u64 pcrel_load_addr;

Ah crap. Yeah, it's a PITA trying to keep LLVM and not LLVM builds
happy. perf_LLVM* fixes this by possibly always punting to the
dlopen/dlsym version when HAVE_LIBLLVM_SUPPORT isn't there - hence a
lot of the comments I've been making. I forgot to rebuild without
libLLVM and so missed needing the extra #ifdefs. I agree with the fix
but the fix can be removed in the (now) later patches that use
dlopen/dlsym.

Thanks,
Ian

