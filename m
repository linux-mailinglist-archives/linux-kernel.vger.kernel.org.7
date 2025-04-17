Return-Path: <linux-kernel+bounces-609418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3758A921FA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2393B899A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27148253F05;
	Thu, 17 Apr 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKmO/jBy"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926F3253F1C
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744904989; cv=none; b=VZhoyMPRLXZGCuUcXBbOuuhPuYo42Lu6L5tIawi6fpbSkDh+HpU9CmbbgeJiLd4i1rtS2k3jgunALDr57UMUib/n2K66GSF7mIz7oX/19mHcal70HRIvityrmJ70tuikyfcv2rqTktaLv6GDs6Pty1zPEJE0L9hdsTRHEHn7ApY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744904989; c=relaxed/simple;
	bh=g8NXQzi2AmZwVhtTfHlJcrowEKvgjPLLT105OqqZEIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWtPbp8RfUG2j6Vud0sZJmEGk++YPhl96Yx5pITb+rO0cu5oHAQVOdRHRWYp7hbVosbyhAmzeO/oyiAHwWKflRvkQsd6wiNuTXZZ1hoMnkC1lhZbSvQ7XGrMUSax5WZLDGW767LtSlYghPHqmrOZ4sMICJAYD982KXwDbuIENFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKmO/jBy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2242ac37caeso169505ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744904987; x=1745509787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyGX6F8mw+QO6Ue+GZurb/6Buesyo98UCvqCcv58NC0=;
        b=LKmO/jByLPzHtk+V5LAHwGFWRzYvRcwipLNENa+ekvcfUi47LNqQjNgPi3VIFJUJkA
         FFNbZmj8fbRQA27fhSwcn5SZ/WlSKHhwabNRxPs1xclP96HQ6ge1DfNbQ/FXxcU4e1j/
         DEDM1N2Y9P5Qrmm3WW9QPEPWz+8yTV1zMncSP5DShSwHwbZIKCvQ5NgRf2YmNWwqe89j
         aWFfRqCO4y+vXlNNEAdd6nYZqgSSdVEvfp72/XK4oTuSICW0IUNdZi0TfSf4Dnxo8TIc
         tImJDkse4lj89w6baVt7MsZmo+WEVxjamZ7P4wN/v14cIsEKHtCI2jt87xgHHE2Veu/i
         cpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744904987; x=1745509787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nyGX6F8mw+QO6Ue+GZurb/6Buesyo98UCvqCcv58NC0=;
        b=PC03DaOTayHdWCIOXPjYu06ZF/rBX0u9dUguN5IOS9mmS0Ka85+8Adk7PKtIeEivPB
         Z/EavGgkarrqaxzXbFb/WTCVppNj2AjAKuWUTojgfyc3SrKLbppxDyatAko7FgfmO1o3
         I3xSTpZ7ejq2if/mdDP6N6S8+qUIY9OsDL1HZyDgThHLbgXqUSnSGtDlXyTGSkbsBPFI
         6G2IF8txNOgkOSwp7y+R4V+pyuVvIZCZHo0m0bg63zz1lbwQKS5zuUqpQuBmhferP4d4
         EE8UH3Kt4CrdYW0s1Mhe5jnvl5dSFUmatlodJR1IsL46ylzjf7te2xaJZ8N2tywH4335
         x88Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGWJrxUnBBEkPI4XaUiWBisHON2d4ED0E2pLNwZHBAruifVeRLS1dwLGvmc5OZyW6IhlSAyZJxj/l7U3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiMc7sT8eMojZdNij89CXRxAIWe6RkBbGcs3RgZBVAFQAP0FWf
	eyt7/JT54gDvYs/PE1HxwYwNrazQ8z2tXoTOYfMJuhYTmWg+JN6OYRvY1y1fcNwLKYdInVZ1ZNu
	zLBkV9P97dhmVZjkuOVoDJQ9eYJoPmYoVl/3x
X-Gm-Gg: ASbGnctSIyLKoyH4hnpz4WzRG2gIBVj1+1meum97kdgaIx9vHL94i9k7CMFWVU2430e
	poL/io37laiUBrp9bwAHn0qjluAi3fCSVX62qRh9hy21rxW1Jo2TL8ISjXCXYZ6VjA/ldO2Oy2d
	H3RnjrOdBreLGL9QHsp16L2GEhWkezpZEd9c5pTDdnCpb0Zp0Fv6oNGWQjGVXTdg==
X-Google-Smtp-Source: AGHT+IEKbdgo54sZ9vRJfKwjfKyD3QxiKT9UC5JvB+alX+u9U1kJA3jCrOugP/FsZ+n8XgB5fmlQbfd05KM4Y71BWag=
X-Received: by 2002:a17:902:ebcd:b0:223:f479:3860 with SMTP id
 d9443c01a7336-22c41286b2emr3071185ad.18.1744904986501; Thu, 17 Apr 2025
 08:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aABlDyhAYz95vOM1@x1>
In-Reply-To: <aABlDyhAYz95vOM1@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Apr 2025 08:49:35 -0700
X-Gm-Features: ATxdqUEc5PZGs_Zl4NEBlADoVnKMfJWjRjcgj_nbyoQEbH8QUfkGjF2DgBO5y7U
Message-ID: <CAP-5=fXeykYoqLJ8t6Gq31cO8eYGOnppgc86PHfWnBoz4xgw-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools build: Remove libbfd from the set of expected
 libraries to build perf
To: arnaldo.melo@gmail.com
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Quentin Monnet <qmo@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 7:18=E2=80=AFPM <arnaldo.melo@gmail.com> wrote:
>
> The tools/build/feature/test-all.c file tries to build with the most
> common set of libraries expected to be present to build perf, and these
> days libbfd (binutils) isn't one since it was made opt-in via
> BUILD_NONDISTRO=3D1 on the make command line as it has license issues.
>
> Fix this by removing the tests from there.
>
> Fixes: dd317df072071903 ("perf build: Make binutil libraries opt in")
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

There is a wider set of cleanups that remove BUILD_NONDISTRO and
libbfd that I posted back in January:
https://lore.kernel.org/lkml/20250122174308.350350-1-irogers@google.com/
These changes are carried in:
https://github.com/googleprodkernel/linux-perf/commits/google_tools_master/
The remaining use of libbfd for BPF JIT code disassembly is converted
to using either capstone or LLVM:
https://lore.kernel.org/lkml/20250122174308.350350-11-irogers@google.com/
Namhyung had concerns over code like:
https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/too=
ls/perf/util/capstone.c#L23-L132
where structs and enums derived from pahole are declared rather than
gathered from a #include. Doing things this way was deliberate in the
patch series so that the code could assume capstone or llvm support
may be present, falling back when not, and that the build wouldn't
need to have support for a no header file option that could do nothing
(this option would always be to try to fallback on dlopen and nobody
could create a less enabled build by forgetting to have a header
file). Theoretically the structs and defines, incorporated by way of
pahole, could change and a header file dependency would be robust to
this. In practice this would be an ABI incompatible change just as
changing a function name looked up by dlsym would be. Namhyung took
onboard my suggestion that we could reduce the set of structs/enums/..
for capstone by disabling the `print_insn_x86` when using dlopen, but
I think such a change should warn the user of reduced functionality,
cleaning up the warning would just bring back the code as I had
proposed:
https://lore.kernel.org/lkml/CAP-5=3DfXL0hXFT+t6gHp2RFd4dKnebSkd+rewudpmden=
tKGPURw@mail.gmail.com/

I think the patch series should be a priority to land as:
1) there is substantial cleanup wrt libbfd, libiberty, .. with
dependencies being factored out into their our C files;
2) the dependencies on libcapstone and libllvm are broken at build
time, allowing distributions to ship perf with a more minimal set of
dependencies and then later get the faster code or better support by
installing the libraries - I think ideally we'd do the same for the
libpython dependency as Namhyung has done in his uftrace;
3) the series adds BPF JIT disassembly.

Maybe this can be an occasion we respect the opinions of the patch
author and land what may be just a good patch series, but not quite
perfect to someone else's definition of perfect. We can always put
patches on top to make things perfect and discuss the merits at that
moment.

Thanks,
Ian

> ---
>  tools/build/Makefile.feature   | 12 ------------
>  tools/build/feature/Makefile   |  2 +-
>  tools/build/feature/test-all.c | 19 -------------------
>  tools/perf/Makefile.config     |  1 +
>  4 files changed, 2 insertions(+), 32 deletions(-)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 57bd995ce6afa318..da025a8040a9a154 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -42,17 +42,12 @@ endef
>  #
>  #   All the others should have lines in tools/build/feature/test-all.c l=
ike:
>  #
> -#    #define main main_test_disassembler_init_styled
> -#    # include "test-disassembler-init-styled.c"
> -#    #undef main
> -#
>  #    #define main main_test_libzstd
>  #    # include "test-libzstd.c"
>  #    #undef main
>  #
>  #    int main(int argc, char *argv[])
>  #    {
> -#      main_test_disassembler_four_args();
>  #      main_test_libzstd();
>  #      return 0;
>  #    }
> @@ -60,7 +55,6 @@ endef
>  #    If the sample above works, then we end up with these lines in the F=
EATURE-DUMP
>  #    file:
>  #
> -#    feature-disassembler-four-args=3D1
>  #    feature-libzstd=3D1
>  #
>  FEATURE_TESTS_BASIC :=3D                  \
> @@ -71,8 +65,6 @@ FEATURE_TESTS_BASIC :=3D                  \
>          get_current_dir_name            \
>          gettid                         \
>          glibc                           \
> -        libbfd                          \
> -        libbfd-buildid                 \
>          libelf                          \
>          libelf-getphdrnum               \
>          libelf-gelf_getnote             \
> @@ -102,8 +94,6 @@ FEATURE_TESTS_BASIC :=3D                  \
>          setns                          \
>          libaio                         \
>          libzstd                                \
> -        disassembler-four-args         \
> -        disassembler-init-styled       \
>          file-handle
>
>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> @@ -119,8 +109,6 @@ FEATURE_TESTS_EXTRA :=3D                  \
>           hello                          \
>           libbabeltrace                  \
>           libcapstone                    \
> -         libbfd-liberty                 \
> -         libbfd-liberty-z               \
>           libopencsd                     \
>           cxx                            \
>           llvm                           \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index b8b5fb183dd40693..76724931f68e1b92 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -110,7 +110,7 @@ all: $(FILES)
>  __BUILD =3D $(CC) $(CFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bin,%.c=
,$(@F)) $(LDFLAGS)
>    BUILD =3D $(__BUILD) > $(@:.bin=3D.make.output) 2>&1
>    BUILD_BFD =3D $(BUILD) -DPACKAGE=3D'"perf"' -lbfd -ldl
> -  BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D2=
 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) =
-DPACKAGE=3D'"perf"' -lbfd -ldl -lz -llzma -lzstd
> +  BUILD_ALL =3D $(BUILD) -fstack-protector-all -O2 -D_FORTIFY_SOURCE=3D2=
 -ldw -lelf -lnuma -lelf -lslang $(FLAGS_PERL_EMBED) $(FLAGS_PYTHON_EMBED) =
-lz -llzma -lzstd
>
>  __BUILDXX =3D $(CXX) $(CXXFLAGS) -MD -Wall -Werror -o $@ $(patsubst %.bi=
n,%.cpp,$(@F)) $(LDFLAGS)
>    BUILDXX =3D $(__BUILDXX) > $(@:.bin=3D.make.output) 2>&1
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index 03ddaac6f4c4dfa2..1010f233d9c1ad49 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -66,14 +66,6 @@
>  # include "test-libslang.c"
>  #undef main
>
> -#define main main_test_libbfd
> -# include "test-libbfd.c"
> -#undef main
> -
> -#define main main_test_libbfd_buildid
> -# include "test-libbfd-buildid.c"
> -#undef main
> -
>  #define main main_test_backtrace
>  # include "test-backtrace.c"
>  #undef main
> @@ -158,14 +150,6 @@
>  # include "test-reallocarray.c"
>  #undef main
>
> -#define main main_test_disassembler_four_args
> -# include "test-disassembler-four-args.c"
> -#undef main
> -
> -#define main main_test_disassembler_init_styled
> -# include "test-disassembler-init-styled.c"
> -#undef main
> -
>  #define main main_test_libzstd
>  # include "test-libzstd.c"
>  #undef main
> @@ -193,8 +177,6 @@ int main(int argc, char *argv[])
>         main_test_libelf_gelf_getnote();
>         main_test_libelf_getshdrstrndx();
>         main_test_libslang();
> -       main_test_libbfd();
> -       main_test_libbfd_buildid();
>         main_test_backtrace();
>         main_test_libnuma();
>         main_test_numa_num_possible_cpus();
> @@ -213,7 +195,6 @@ int main(int argc, char *argv[])
>         main_test_setns();
>         main_test_libaio();
>         main_test_reallocarray();
> -       main_test_disassembler_four_args();
>         main_test_libzstd();
>         main_test_libtraceevent();
>         main_test_libtracefs();
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 9f08a6e96b351707..7e9aa3d910c2cdcc 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -917,6 +917,7 @@ ifneq ($(NO_JEVENTS),1)
>  endif
>
>  ifdef BUILD_NONDISTRO
> +  $(call feature_check,libbfd)
>    ifeq ($(feature-libbfd), 1)
>      EXTLIBS +=3D -lbfd -lopcodes
>    else
> --
> 2.49.0
>

