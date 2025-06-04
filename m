Return-Path: <linux-kernel+bounces-673654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3525ACE440
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 20:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E57C16200F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 18:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697C1F3FEB;
	Wed,  4 Jun 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c40QDRH+"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089E7149C55
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749061056; cv=none; b=tSJ2707YFXE31jsXD7yyD4l5md8ox8nuUYb1VPeji82YWW97LLPh+87hKPIxlvcCV/7yTArVOfd/SuRChkK74DDNeH8Ujlali727FHy4JJLqwKbt2pCJ5nrr76+6TS6XAuVsO1U+wtJWY/IXSuonUWe8UL90ulBeTvd9meHhuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749061056; c=relaxed/simple;
	bh=psoh91nI2uI0Sy15561N6TGZ7CCZ0e/7pFH5VDdguCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvNRDAY8lJAnK5HLoAf0lon0YgIauSIk+HhF9u/hopyj01FOEzdvqRwTAiiO62kYiGZwuJs4/1p4HyiCcLHtH1ZebP4LY/Zppq5TvJYZC9NWJ8/9F77yEcX7CVtKmPJZt/DmfVSaRJtMFdvpy55p49mMp9niNrXmw7qQZ4ZkNzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c40QDRH+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-602c3f113bbso126515a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749061052; x=1749665852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj/ZRM00Y6bck08t7l8DzmjqoE1Rg6EPcxweeTc+cRY=;
        b=c40QDRH+22d6Vb+dLa9JAyCadQjzz8TWWI/+xtM4PRnKRdyLCtul9H2PA2cw0wFjDy
         8Mi5JLtbf/5bBlZv15800JQ4F2atvHRJ8OxnVZfV+PXfAHXVNzz7JCMqfRaKSYGfXswa
         4kZpBlqKWrObb19JF/WauAKZMdlh0KeAJ34utdKOkwbUh/F/1UQVdGIX0q9sivL2C+ah
         OhNlLL76TWN94+Rsu2Bg5kLJ6xNN5oBTNfV9Gjqd+HBpLk0OFt/zBaJGGCp09ciEEauM
         g64fQidv59OvNFVPtaZ0irdHX4+zZkyS4AwfIjs1ANz87BKG5pPSGTA2MCt9oFfIe50+
         9GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749061052; x=1749665852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lj/ZRM00Y6bck08t7l8DzmjqoE1Rg6EPcxweeTc+cRY=;
        b=iiCdV8iEKc+D42+hDzumnc9OB9aKXMwNLhV+ZXhXqn2dCn/IsYDi5JnJu5/nfQGYPW
         J0zpbwxuib+oqceSvTCk0bY6oeBJTNYDMKcOA1alnwXg8LAB5qvmDD3a7obn8ZFhEaVb
         U6mI/IUBeVULeFjO7pPIks40HFUgRzoFt6thzCPxnhYcIxpD5FOt0xpXjm8CUMAQO2PB
         TsD7zIpVu2e04WW71YuFsMOfWpejII/2uef6DyGf8btmwhevSvwJjjEYoAxZbkSTpNxy
         JGlwdWC+lv7sXQzAcT16cPjGX4D1vVRBDvElf+77GAYsser+Jxoe2NDXsNJy2l4he7UK
         iLYg==
X-Forwarded-Encrypted: i=1; AJvYcCWCHb01DsCQNCJEWm7Kxg/r4S7p7PzkhnLTi0Pei0BaMdl81IpcSzplEO0tA46fNs2NjY6sxY7cOsRfUgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/C2h/+OmvCwQ3LF4DX5aG1Y8jWheViSU7mkKtIZ1JWPAuAgH+
	v1ll6XhGCT/xAwNIGZD9wL3DQSkA2u/cd4sVkvapX+e9Z9/QBnPAWvlRGC5b1azzcgxdDd39Iua
	LJ9cG9AzLvKXO0oKF/okY5Qn58ixzRrEeUKhK4n1Yi3uvsWygTnPu+o51W/g/8w==
X-Gm-Gg: ASbGncuMqDigCkoblg6T74NycmE9XNWw7A66JWbFH7nxbSOLUXCKWw5fwA2K2LGXAy5
	R6wfC8a7jEhTt4Lp8sFFGRZ/zcgom1zR1wvBrSAzjk/et62RJEHk98acOGUA1KorXj3rDlyZX1L
	PuF/RCvHpY2olb8XF291DyPhadr4oMWcyTkHad5JKgyUYDpfJQT3fpFURCD53kG4e+GzmVTx8=
X-Google-Smtp-Source: AGHT+IEEYnFIfamNc0xCTG14sb0jyvopHlMsu5d+GsAMF5NnKMqT1Fw2V2XC4qCaskaDO8Sd+9KklLkmaA/Y7an7mAA=
X-Received: by 2002:a17:906:f295:b0:ade:5ba:40e6 with SMTP id
 a640c23a62f3a-ade05ba425bmr78144366b.18.1749061052080; Wed, 04 Jun 2025
 11:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521225307.743726-1-yuzhuo@google.com> <20250521225307.743726-3-yuzhuo@google.com>
 <aC9lXhPFcs5fkHWH@x1>
In-Reply-To: <aC9lXhPFcs5fkHWH@x1>
From: Yuzhuo Jing <yuzhuo@google.com>
Date: Wed, 4 Jun 2025 11:17:20 -0700
X-Gm-Features: AX0GCFupmXsRt1tE_ch4UHdMNbeRq4klRtHqLWhzFMfMGav7I8d9s-ouD80bzCs
Message-ID: <CADQikVDs3msXqZ6tyoXR0WeN4D_9snxWyk2kXeDw5iAs+BHFuw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] perf tools: Add sha1 utils
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	James Clark <james.clark@linaro.org>, Tomas Glozar <tglozar@redhat.com>, Leo Yan <leo.yan@arm.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

Thanks for testing the patches!

> In file included from util/sha1_generic.c:18:
> util/sha1_base.h: In function =E2=80=98sha1_base_do_finalize=E2=80=99:
> util/sha1_base.h:77:21: error: comparison of integer expressions of diffe=
rent signedness: =E2=80=98unsigned int=E2=80=99 and =E2=80=98int=E2=80=99 [=
-Werror=3Dsign-compare]
>    77 |         if (partial > bit_offset) {
>       |                     ^
> cc1: all warnings being treated as errors

Oh, I didn't see that on my GCC 14.2.  A quick fix would work:

--- /dev/fd/63  2025-06-04 09:54:42.344516115 -0700
+++ tools/perf/util/sha1_base.h 2025-06-03 15:43:39.194036707 -0700
@@ -71,7 +69,7 @@
 static inline int sha1_base_do_finalize(struct sha1_state *sctx,
                                        sha1_block_fn *block_fn)
 {
-       const int bit_offset =3D SHA1_BLOCK_SIZE - sizeof(__be64);
+       const unsigned int bit_offset =3D SHA1_BLOCK_SIZE - sizeof(__be64);
        __be64 *bits =3D (__be64 *)(sctx->buffer + bit_offset);
        unsigned int partial =3D sctx->count % SHA1_BLOCK_SIZE;


To test it, I added -Werror=3Dsign-compare to my local Makefile.config to
force the error.

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d19d1f132726..9909611be301 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -225,9 +225,9 @@ endif

 # Treat warnings as errors unless directed not to
 ifneq ($(WERROR),0)
-  CORE_CFLAGS +=3D -Werror
-  CXXFLAGS +=3D -Werror
-  HOSTCFLAGS +=3D -Werror
+  CORE_CFLAGS +=3D -Werror=3Dsign-compare -Werror
+  CXXFLAGS +=3D -Werror=3Dsign-compare -Werror
+  HOSTCFLAGS +=3D -Werror=3Dsign-compare -Werror
 endif

 ifndef DEBUG


While testing with "make -C tools/perf -f tests/make make_debug", I saw
similar compile errors in libjvmti.c:

jvmti/libjvmti.c: In function =E2=80=98copy_class_filename=E2=80=99:
jvmti/libjvmti.c:148:39: error: comparison of integer expressions of
different signedness: =E2=80=98int=E2=80=99 and =E2=80=98long unsigned int=
=E2=80=99
[-Werror=3Dsign-compare]
  148 |                         for (i =3D 0; i < (size_t)(p - class_sign);=
 i++)
      |                                       ^
jvmti/libjvmti.c:155:31: error: comparison of integer expressions of
different signedness: =E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99 {a=
ka =E2=80=98long unsigned int=E2=80=99}
[-Werror=3Dsign-compare]
  155 |                 for (j =3D 0; i < (max_length - 1) && file_name
&& j < strlen(file_name); j++, i++)
      |                               ^
jvmti/libjvmti.c:155:68: error: comparison of integer expressions of
different signedness: =E2=80=98int=E2=80=99 and =E2=80=98size_t=E2=80=99 {a=
ka =E2=80=98long unsigned int=E2=80=99}
[-Werror=3Dsign-compare]
  155 |                 for (j =3D 0; i < (max_length - 1) && file_name
&& j < strlen(file_name); j++, i++)
      |                                                                    =
^

I've just sent a separate patch to the mailing list:
https://lore.kernel.org/lkml/20250604173632.2362759-1-yuzhuo@google.com/T/


> Humm that part is the same as in the kernel...
>
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ line=3D$(ctags -x --c-kinds=3Df =
include/crypto/sha1_base.h | awk '$1 =3D=3D "sha1_base_do_finalize" {print =
$3}')
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ sed -n $line,\$p include/crypto/=
sha1_base.h | awk '{print} /\{/ {c++} /\}/ {c--; if (c=3D=3D0) exit}' > /tm=
p/original
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ line=3D$(ctags -x --c-kinds=3Df =
tools/perf/util/sha1_base.h | awk '$1 =3D=3D "sha1_base_do_finalize" {print=
 $3}')
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ sed -n $line,\$p include/crypto/=
sha1_base.h | awk '{print} /\{/ {c++} /\}/ {c--; if (c=3D=3D0) exit}' > /tm=
p/copy
> =E2=AC=A2 [acme@toolbx perf-tools-next]$ diff -u /tmp/original /tmp/copy
> --- /tmp/original       2025-05-22 14:48:31.338406860 -0300
> +++ /tmp/copy   2025-05-22 14:48:58.401603439 -0300
> @@ -1,3 +1,7 @@
> +
> +       return 0;
> +}
> +
>  static inline int sha1_base_do_finalize(struct shash_desc *desc,
>                                         sha1_block_fn *block_fn)
>  {
> @@ -13,10 +17,3 @@
>
>                 block_fn(sctx, sctx->buffer, 1);
>         }
> -
> -       memset(sctx->buffer + partial, 0x0, bit_offset - partial);
> -       *bits =3D cpu_to_be64(sctx->count << 3);
> -       block_fn(sctx, sctx->buffer, 1);
> -
> -       return 0;
> -}
> =E2=AC=A2 [acme@toolbx perf-tools-next]$

There were some other fixes that I made only to the perf tree version,
while maintaining verbatim for other parts.  Here's a script that
retains and compares only the copied parts.

  # Ignore everything after sha1_transform
  diff -u -B -I "^#include " <(sed -n
'/EXPORT_SYMBOL(sha1_transform)/q;p' lib/crypto/sha1.c)
tools/perf/util/sha1.c
  diff -u -B -I "^#include " -I "sha1_zero_message_hash" -I "^struct
sha1_state;$" -I "^void sha1_init(__u32 \*buf);$" \
      <(sed 's/shash_desc/sha1_state/g;' include/crypto/sha1.h)
tools/perf/util/sha1.h
  diff -u -B -I "^EXPORT_SYMBOL" -I "^#include " \
      <(sed 's/shash_desc \*desc/sha1_state *sctx/g;
/shash_desc_ctx(desc)/d' include/crypto/sha1_base.h)
tools/perf/util/sha1_base.h
  # Ignore everything after crypto_sha1_finup
  diff -u -B -I "^EXPORT_SYMBOL" -I "^#include " \
      <(sed -n -e '/const u8
sha1_zero_message_hash/,/EXPORT_SYMBOL_GPL(sha1_zero_message_hash)/d'
\
               -e 's/shash_desc/sha1_state/g;
/EXPORT_SYMBOL(crypto_sha1_finup)/q;p' crypto/sha1_generic.c) \
      tools/perf/util/sha1_generic.c

And the changes are as below (including the quick fix above), with one
changing the sign and integer type and another fixing type mismatch from
const u8 * to const char *.

Should we send another patch to the kernel tree version to fix the sign
error, or we add rules to allow perf tree only changes?

--- /dev/fd/63  2025-06-04 09:54:42.344516115 -0700
+++ tools/perf/util/sha1_base.h 2025-06-03 15:43:39.194036707 -0700
@@ -71,7 +69,7 @@
 static inline int sha1_base_do_finalize(struct sha1_state *sctx,
                                        sha1_block_fn *block_fn)
 {
-       const int bit_offset =3D SHA1_BLOCK_SIZE - sizeof(__be64);
+       const unsigned int bit_offset =3D SHA1_BLOCK_SIZE - sizeof(__be64);
        __be64 *bits =3D (__be64 *)(sctx->buffer + bit_offset);
        unsigned int partial =3D sctx->count % SHA1_BLOCK_SIZE;

@@ -95,7 +93,7 @@
        __be32 *digest =3D (__be32 *)out;
        int i;

-       for (i =3D 0; i < SHA1_DIGEST_SIZE / sizeof(__be32); i++)
+       for (i =3D 0; i < SHA1_DIGEST_SIZE / (int)sizeof(__be32); i++)
                put_unaligned_be32(sctx->state[i], digest++);

        memzero_explicit(sctx, sizeof(*sctx));
--- /dev/fd/63  2025-06-04 09:54:42.344516115 -0700
+++ tools/perf/util/sha1_generic.c      2025-05-16 10:52:59.219531034 -0700
@@ -27,7 +23,7 @@
        u32 temp[SHA1_WORKSPACE_WORDS];

        while (blocks--) {
-               sha1_transform(sst->state, src, temp);
+               sha1_transform(sst->state, (const char *)src, temp);
                src +=3D SHA1_BLOCK_SIZE;
        }
        memzero_explicit(temp, sizeof(temp));

Thanks!

Best regards,
Yuzhuo

