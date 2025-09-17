Return-Path: <linux-kernel+bounces-821449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1F8B8148F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B242A09A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925422FCBF3;
	Wed, 17 Sep 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCSBhNH5"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137C27875C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132125; cv=none; b=igq32RU97q/Ies33xzQIHSldQN888lFrsRRHCmEscSBPQYm/NB5hsk+NFyToPK5/8oIPV8bT0tE9I33XY1/Qx9zgE45OfhtiGch2L1XKEPtzSZEm18ZGH8Ziks8YHisbEhdUeEeV9Ga4XOOOt4J7kTBTMzJ/t6Al74wEBOPRR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132125; c=relaxed/simple;
	bh=MR7me9ddvBdxz1R7VJ9TE4auhiMxLnXpZatJz+0tS1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Dqq0xApqKn+2uEDHjvPPyy7f+ZKOINyaxfSXc0nlgUJyrxCwKQQ/6h/iBwXR8jB9kZsa+3LA1DW3cnHbowNxwBNqOKe4MEawcESQNhcqMOsqgX9dRFT7DgnmG+csE0zpR5ESa5jnY3YQpd65aFLLwxfpZGyN+l/lmJOnksscwgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCSBhNH5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-265f460ae7bso15835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758132123; x=1758736923; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LpVnJg7BE6WNY6BkNM5SQ8FquyypWzYqNeLwrVEDJI=;
        b=nCSBhNH5/ohkbuPh/E05osEVeBZcvYxFG/PIlDIIty0OkCVlbEKgvLjT5Y4UifuOXh
         /8RBiqUFBi9jtsG2P0df0Z5VUEVMPeMkR0AvLRhFWRMPAU9L+KBhTUJPSdXeedTMdcns
         rTPxdR0mW5pn3X0nNwXkrsHD8WmRgO9jgYkooFbkQlskETSFFG1O28wZfnKBGxZmXvI8
         UJquXodfFRTIV2Piui9Z5qDzn0SjENSosWw2+h+nRSuVeYL9+KSFbExYNa2FqlqoJM1o
         PyW1BUJ+8tvZMgx5uiJMjz8ihh+/OmyK516sTLJsJQPlso6IwNDzqt9L3PP84YcFC4QY
         D5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132123; x=1758736923;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LpVnJg7BE6WNY6BkNM5SQ8FquyypWzYqNeLwrVEDJI=;
        b=cBm70F8x3UYAb/pjcBVY9dcj7oEKuEMM7emN4UMeAMBEldEyn9A74jcKl10fNljEpf
         NZvcTrYDdk9hD5XAvm93/80FSLO52XgkEYc5cQzIjI3JvlPd4yLEGnpo/AwYV9cXJGHq
         8mh3kWNxQpFH+LClAjH9Avcpli+D10MPVsm6om0Ljd/ODLuNA64yZm6GUNWsHL5arwsS
         lIaoDuACBzCtyyquPmzb/rxaEwOUN87WMAzyFOl92RBhst4AwAxIGIuSrF5uR7c0rCF4
         Y5/PR8QYfFKsrjh5yPDC7soWXoa8U9dQ6FYe8MLvZJbp+QB0nGoJDoNkvGHZTUFFB+Y9
         mEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZMZJDcuebedxXNNs5aHPqaD29lMrKsV3O4XfksCeyb9NAjMVWv4rbOZ0x85JcPV06pczPRuCfQTDRoII=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjj280Lf2p9mOa96ZPUBupwg38evqnf0otI1wr9EwinHubu7mG
	I2J6TG3Mnt8Nqr/3xEGvUaZnFbfqZCtEQ+MxUfDnrAs/Dgh00IiU83zbOXeq6fcNdcpt+ZhBIec
	LbJ06+1P4pzpxLV24kuhuCujkqDw8vS/Q5/oBUUP0
X-Gm-Gg: ASbGncvnJIkyJ6vli/r+JgyNrYEuKup+bLUfMw5yhBF7I599TAZMJIN8OqsD1C9P+42
	Kv22FCo868ygnwMBOM3CeTJRIZTz2tjf2wVCQag3OvQyyd4gFmk60MJ4Ur5AruuyYOsoy+pMhXG
	SmebOHZJFRx2mxubCLhQL1V9nRs/MDBWB5XVA1ezPhjiGVQQXT66vOe8y3OXPLeND4mP/oJKbPM
	U54sstqyBTXVndHiB0XMW2upTbx5Pth6ihA3yWYq2s=
X-Google-Smtp-Source: AGHT+IHsmHdvZMcRvp+Zf/B1ALEoNlY544bh43DMH3sInLwSSM/ydTSsyOG4UunNcNDYlmxDU9Pj3qaz5euIVLNRJSU=
X-Received: by 2002:a17:902:e74d:b0:269:7c50:85c8 with SMTP id
 d9443c01a7336-2697c5088camr1081935ad.2.1758132122681; Wed, 17 Sep 2025
 11:02:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908181918.3533480-1-irogers@google.com>
In-Reply-To: <20250908181918.3533480-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Sep 2025 11:01:51 -0700
X-Gm-Features: AS18NWDSO69vOJi_QuT9wnuWijuWihHXf63iPttiEUjqSzmXhj9Zliv9BTm3bnY
Message-ID: <CAP-5=fVX+bLBRJCiziDi_hBySgv2NFtDoghtpheSSxVAvvETGw@mail.gmail.com>
Subject: Re: [PATCH v1] tools build: Make libperl opt-in rather than opt-out, deprecate
To: Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	James Clark <james.clark@linaro.org>, Tomas Glozar <tglozar@redhat.com>, 
	Quentin Monnet <qmo@kernel.org>, Leo Yan <leo.yan@arm.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 11:19=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> If libperl is installed then the perf tool build will build against
> it. There appears to be limited interest in the scripting support for
> perl so let's make it opt-in and deprecate it.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> In the future it would be nice to refactor the python support, for
> example, so that perf doesn't steal the main thread which UIs like
> textual assume they can have. When such work is done, any equivalent
> perl work will be a challenge and it might just be best to delete it.

In:
https://lore.kernel.org/lkml/aMrk03gigBlGcYLK@x1/
Arnaldo mentioned:

> Maybe we should be a tad more cautious and start with emitting a warning
> that "libperl is deprecated (holler if you disagree if you use it!)" and
> then make it opt-in, and then remove it.

With this patch applied you need to add LIBPERL=3D1 to get libperl
support in perf - there is no warning if libperl is missing, but
building will fail if libperl is missing and the build has LIBPERL=3D1.
The perf version output is changed to:
```
$ perf version --build-options
perf version 6.17.rc3.g8eca69269947
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                 dwarf: [ on  ]  # HAVE_LIBDW_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_LIBDW_SUPPORT
          dwarf-unwind: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
              auxtrace: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT ( tip:
Deprecated, license incompatibility, use BUILD_NONDISTRO=3D1 and install
binutils-dev[el] )
        libbpf-strings: [ on  ]  # HAVE_LIBBPF_STRINGS_SUPPORT
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_LIBDW_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
            libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
               libperl: [ OFF ]  # HAVE_LIBPERL_SUPPORT ( tip:
Deprecated, use LIBPERL=3D1 and install libperl-dev to build with it )
               libpfm4: [ on  ]  # HAVE_LIBPFM
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
             libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip:
Deprecated, use LIBUNWIND=3D1 and install libunwind-dev[el] to build
with it )
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
```

ie there is a tip saying about deprecation and how to get support back.

Thanks,
Ian


> ---
>  tools/build/Makefile.feature   |  3 +--
>  tools/build/feature/test-all.c |  9 ++-------
>  tools/perf/Makefile.config     | 12 +++---------
>  tools/perf/Makefile.perf       |  4 ++--
>  tools/perf/builtin-check.c     |  2 +-
>  tools/perf/tests/make          |  8 ++++----
>  6 files changed, 13 insertions(+), 25 deletions(-)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 649c5ab8e8f2..9c1a69d26f51 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -80,7 +80,6 @@ FEATURE_TESTS_BASIC :=3D                  \
>          libelf-zstd                     \
>          libnuma                         \
>          numa_num_possible_cpus          \
> -        libperl                         \
>          libpython                       \
>          libslang                        \
>          libtraceevent                   \
> @@ -121,6 +120,7 @@ FEATURE_TESTS_EXTRA :=3D                  \
>           libbfd-liberty                 \
>           libbfd-liberty-z               \
>           libopencsd                     \
> +         libperl                        \
>           cxx                            \
>           llvm                           \
>           clang                          \
> @@ -144,7 +144,6 @@ FEATURE_DISPLAY ?=3D              \
>           libelf                 \
>           libnuma                \
>           numa_num_possible_cpus \
> -         libperl                \
>           libpython              \
>           libcapstone            \
>           llvm-perf              \
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index 4419fb4710bd..e1847db6f8e6 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -7,17 +7,13 @@
>   */
>
>  /*
> - * Quirk: Python and Perl headers cannot be in arbitrary places, so keep
> - * these 3 testcases at the top:
> + * Quirk: Python headers cannot be in arbitrary places, so keep this tes=
tcase at
> + * the top:
>   */
>  #define main main_test_libpython
>  # include "test-libpython.c"
>  #undef main
>
> -#define main main_test_libperl
> -# include "test-libperl.c"
> -#undef main
> -
>  #define main main_test_hello
>  # include "test-hello.c"
>  #undef main
> @@ -161,7 +157,6 @@
>  int main(int argc, char *argv[])
>  {
>         main_test_libpython();
> -       main_test_libperl();
>         main_test_hello();
>         main_test_libelf();
>         main_test_get_current_dir_name();
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5a5832ee7b53..0f4b297fbacc 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -817,9 +817,7 @@ ifdef GTK2
>    endif
>  endif
>
> -ifdef NO_LIBPERL
> -  CFLAGS +=3D -DNO_LIBPERL
> -else
> +ifdef LIBPERL
>    PERL_EMBED_LDOPTS =3D $(shell perl -MExtUtils::Embed -e ldopts 2>/dev/=
null)
>    PERL_EMBED_LDFLAGS =3D $(call strip-libs,$(PERL_EMBED_LDOPTS))
>    PERL_EMBED_LIBADD =3D $(call grep-libs,$(PERL_EMBED_LDOPTS))
> @@ -829,17 +827,13 @@ else
>    PERL_EMBED_LDOPTS :=3D $(filter-out -specs=3D%,$(PERL_EMBED_LDOPTS))
>    FLAGS_PERL_EMBED=3D$(PERL_EMBED_CCOPTS) $(PERL_EMBED_LDOPTS)
>
> +  $(call feature_check,libperl)
>    ifneq ($(feature-libperl), 1)
> -    CFLAGS +=3D -DNO_LIBPERL
> -    NO_LIBPERL :=3D 1
> -    $(warning Missing perl devel files. Disabling perl scripting support=
, please install perl-ExtUtils-Embed/libperl-dev)
> +    $(error Missing perl devel files. Please install perl-ExtUtils-Embed=
/libperl-dev)
>    else
>      LDFLAGS +=3D $(PERL_EMBED_LDFLAGS)
>      EXTLIBS +=3D $(PERL_EMBED_LIBADD)
>      CFLAGS +=3D -DHAVE_LIBPERL_SUPPORT
> -    ifeq ($(CC_NO_CLANG), 0)
> -      CFLAGS +=3D -Wno-compound-token-split-by-macro
> -    endif
>      $(call detected,CONFIG_LIBPERL)
>    endif
>  endif
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index e2150acc2c13..7d6ac03a7109 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -17,7 +17,7 @@ include ../scripts/utilities.mak
>  #
>  # Define CROSS_COMPILE as prefix name of compiler if you want cross-buil=
ds.
>  #
> -# Define NO_LIBPERL to disable perl script extension.
> +# Define LIBPERL to enable perl script extension.
>  #
>  # Define NO_LIBPYTHON to disable python script extension.
>  #
> @@ -1103,7 +1103,7 @@ endif
>                 $(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfe=
xec_instdir_SQ)'
>         $(call QUIET_INSTALL, perf-iostat) \
>                 $(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfex=
ec_instdir_SQ)'
> -ifndef NO_LIBPERL
> +ifdef LIBPERL
>         $(call QUIET_INSTALL, perl-scripts) \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)=
/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
>                 $(INSTALL) scripts/perl/Perf-Trace-Util/lib/Perf/Trace/* =
-m 644 -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util=
/lib/Perf/Trace'; \
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index b1e205871ab1..5457762f7dd5 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -49,7 +49,7 @@ struct feature_status supported_features[] =3D {
>         FEATURE_STATUS("libelf", HAVE_LIBELF_SUPPORT),
>         FEATURE_STATUS("libnuma", HAVE_LIBNUMA_SUPPORT),
>         FEATURE_STATUS("libopencsd", HAVE_CSTRACE_SUPPORT),
> -       FEATURE_STATUS("libperl", HAVE_LIBPERL_SUPPORT),
> +       FEATURE_STATUS_TIP("libperl", HAVE_LIBPERL_SUPPORT, "Deprecated, =
use LIBPERL=3D1 and install libperl-dev to build with it"),
>         FEATURE_STATUS("libpfm4", HAVE_LIBPFM),
>         FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
>         FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index c574a678c28a..b650ce8864ed 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -73,9 +73,9 @@ make_extra_tests    :=3D EXTRA_TESTS=3D1
>  make_jevents_all    :=3D JEVENTS_ARCH=3Dall
>  make_no_bpf_skel    :=3D BUILD_BPF_SKEL=3D0
>  make_gen_vmlinux_h  :=3D GEN_VMLINUX_H=3D1
> -make_no_libperl     :=3D NO_LIBPERL=3D1
> +make_libperl        :=3D LIBPERL=3D1
>  make_no_libpython   :=3D NO_LIBPYTHON=3D1
> -make_no_scripts     :=3D NO_LIBPYTHON=3D1 NO_LIBPERL=3D1
> +make_no_scripts     :=3D NO_LIBPYTHON=3D1
>  make_no_slang       :=3D NO_SLANG=3D1
>  make_no_gtk2        :=3D NO_GTK2=3D1
>  make_no_ui          :=3D NO_SLANG=3D1 NO_GTK2=3D1
> @@ -118,7 +118,7 @@ make_install_prefix_slash :=3D install prefix=3D/tmp/=
krava/
>  make_static         :=3D LDFLAGS=3D-static NO_PERF_READ_VDSO32=3D1 NO_PE=
RF_READ_VDSOX32=3D1 NO_JVMTI=3D1 NO_LIBTRACEEVENT=3D1 NO_LIBELF=3D1
>
>  # all the NO_* variable combined
> -make_minimal        :=3D NO_LIBPERL=3D1 NO_LIBPYTHON=3D1 NO_GTK2=3D1
> +make_minimal        :=3D NO_LIBPYTHON=3D1 NO_GTK2=3D1
>  make_minimal        +=3D NO_DEMANGLE=3D1 NO_LIBELF=3D1 NO_BACKTRACE=3D1
>  make_minimal        +=3D NO_LIBNUMA=3D1 NO_LIBBIONIC=3D1 NO_LIBDW=3D1
>  make_minimal        +=3D NO_LIBDW_DWARF_UNWIND=3D1 NO_AUXTRACE=3D1 NO_LI=
BBPF=3D1
> @@ -143,7 +143,7 @@ run +=3D make_extra_tests
>  run +=3D make_jevents_all
>  run +=3D make_no_bpf_skel
>  run +=3D make_gen_vmlinux_h
> -run +=3D make_no_libperl
> +run +=3D make_libperl
>  run +=3D make_no_libpython
>  run +=3D make_no_scripts
>  run +=3D make_no_slang
> --
> 2.51.0.384.g4c02a37b29-goog
>

