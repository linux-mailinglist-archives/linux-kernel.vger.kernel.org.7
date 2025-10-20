Return-Path: <linux-kernel+bounces-860299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A9BEFC96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 373A94E81D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27802E0B69;
	Mon, 20 Oct 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3hGRfM/"
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB13A8F7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760947394; cv=none; b=Q31uKX9IkWG565mNAXh1AjwojKf0YBpdcOROy1t+HJcB8n1Lx3w1DCbL1hZPvbo3VKqIMeP0Ddpirb/LX4Nd3J0tZ0pj8hZYqtRePmH1JXd0s6XKCT+oYR4FaFmnTMU4VuzWIkgVuZdDQZNkx71wSbnbaWPQG1N0fhR5nhWUIak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760947394; c=relaxed/simple;
	bh=zSrHgFoFLOuMfBq+ow59MxETNiEc7Ug75WckEpH0B1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPQW6/+K+U4Ty+mLXu874D4zuU7PEKInbfHahiZ49gPcXayKXnWx1Mll60SbH0MOT8lJqwjvxmjIggqOwS4jea4s6QfwHEQplhxSdNXNQ2096sAQiBmUgySJ7l5NlnX+fsT9EiRX7yRcBxzWbMRRREnFxKVDbEGCcAfxxEn4vMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3hGRfM/; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7a9a2b27c44so3055150a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 01:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760947392; x=1761552192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KViY3RZGThzhrj6fWVe1XUp0201BJSec3EfLEu40ZP4=;
        b=J3hGRfM/RJk/toV1V/m5yeWxruG4HadpeLFi0EHfgcdcJVkuBMT4CJ0Tmk/yUBk1tC
         LDg2rcXcVLgLEYPs5ZB/TvgJYz2q2TkEsKpa1Dza0XzbSmL1wZqi87xmCJ/FWOctPau+
         P16CLfwww/EF8fDDaCSednINEcUdDfrzB2xoqptcU1bCtBYea0j7cT2W13umS5D2AYV5
         L67U4xkUdsSpnBPsnAz82ye/6TRn1qsDi3PUgmE0X4SfOjgAC8WPuWHhCUatU8veb5i8
         kXcLJs3ethOM7x+4W0gmAhOb242sY9VRRtEWkbqT1kQ6eltlLyLyjRynXJNRvO6h1e8p
         OGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760947392; x=1761552192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KViY3RZGThzhrj6fWVe1XUp0201BJSec3EfLEu40ZP4=;
        b=Phpr860DmStXNvXZsnyjYHQxB61RbN+j0gGnq0JM0OH1TgjvfHJkoK+8fkTqD4zgCF
         YqWhwjB4UO0d7DmSM9xXfcthWQJAniw1YIQ83NeV4TxRaZ3kJnCoJ7OZ1+p8Kms8zWC9
         NO0q7Ce7PsKt4zjxFtXOaDOwGicVIC1Q0PalZWf1hsB47ZHurrbe/BHqgKZPOPHAOZ9q
         1Xmqs72lrLDKficjOS+m61UcwfGVxQ4ojwfIIYpThyiJgeqg7fUej6f5rzZGl7Uqn/6v
         S6kFJ35pD3Oh6smqtU7NMD0CXqc/lZyEjcK9Q+xy3X2vEd//8d4Dj78wWIRYS8QCDyxD
         mO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQVn07d3Z/7lhABaCiMgSahrxD8EZrg6ffPitcOjKPDmlnxWiX9Pj94uwCfclVT0iruodfo3Q0DfQEeHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/72vkqL458zIGx/mQXCRAlQqYrrlQzcBVs53HVKAbAX67vurO
	FDD06YNwT3q4oaZ69qWDHtnnoKXpQKkK6qC3Dsvt1NUgFt4q83tVT0/uJHKJjMsZnz4FplIZavm
	lzF8d8QIr5cClPjF1cTjIl/TiLxC3Lpg=
X-Gm-Gg: ASbGncsX0RZK+F1zRiGc0MCu5W+vG08hqrMAKewXEQgd9dhLtpLAOyPH2pVxL7UlKqr
	hf8twfzTtJTdGSJL4WR4ErUnpCpc6RymACbE+uc+QyX6kSbdY++sTZBgDnz9qOAAcz40d2EoFhV
	nB5AvGbQKKZkEDP06VbIlBgonXo2A00yzJYs4v6m+IXcpiuLA7V1Gn3Q433c46QJf59oKtfKho6
	B5u0139qM7RZhMD3JK6OXdHie9BQf87i6N7K8WaMui/D0TNlc6X9KYU2Ggt
X-Google-Smtp-Source: AGHT+IFrxgQq6FNZjWNsabTJQdU5Xs0avQkPCZRU83HNIJglyrvEYlBJqaN4elUocNpHwxjNqmdvpiJFgA8xvl/dosM=
X-Received: by 2002:a05:6830:6733:b0:745:5748:b328 with SMTP id
 46e09a7af769-7c27b5e213bmr5437222a34.2.1760947391690; Mon, 20 Oct 2025
 01:03:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com> <aPW3rilb8DtFDIMC@google.com> <CADHxFxQF033b97sBx8rtRHAo5Ou5Uc3WLUH1Y5+qA3f1i2MMjw@mail.gmail.com>
In-Reply-To: <CADHxFxQF033b97sBx8rtRHAo5Ou5Uc3WLUH1Y5+qA3f1i2MMjw@mail.gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 20 Oct 2025 16:02:58 +0800
X-Gm-Features: AS18NWDnZMZHqbYH3qe8wZocpzunzmeo2BMa6O9uF8rZux20-oSim6ooTsO5dwo
Message-ID: <CADHxFxQB0n4P-BZkbJfqtvfHHo=JZWtgAEVnedZcQOkCwqJWEw@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support passing extra Clang options via EXTRA_BPF_FLAGS
To: Namhyung Kim <namhyung@kernel.org>, leo.yan@arm.com, irogers@google.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When cross-compiling perf with BPF enabled, Clang is invoked during the
build. Some cross-compilation environments require additional compiler
options, such as `--sysroot` or custom include paths.

This patch introduces a new Make variable, `EXTRA_BPF_FLAGS`. During BPF
skeleton builds, it appends user-provided options to `CLANG_OPTIONS`,
allowing extra Clang flags to be set without modifying Makefile.perf
directly.

Example usage:
    make perf ARCH="arm64" EXTRA_BPF_FLAGS="--sysroot=..."

Change history:
  v3:
    - Move the variable description comment to the top of Makefile.perf
    - Update commit message
  v2:
    - Rename EXTRA_CLANG_FLAGS to EXTRA_BPF_FLAGS
    - Update commit message
  v1:
    - Introduce EXTRA_CLANG_FLAGS to allow passing extra Clang options

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 tools/perf/Makefile.perf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..c1a66cf3d1a7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -35,6 +35,9 @@ include ../scripts/utilities.mak
 #
 # Define EXTRA_CFLAGS=-m64 or EXTRA_CFLAGS=-m32 as appropriate for
cross-builds.
 #
+# Define EXTRA_BPF_FLAGS="--sysroot=<path>" or other custom include paths for
+# cross-compiling BPF skeletons
+#
 # Define EXCLUDE_EXTLIBS=-lmylib to exclude libmylib from the auto-generated
 # EXTLIBS.
 #
@@ -1249,6 +1252,8 @@ else
  $(Q)cp "$(VMLINUX_H)" $@
 endif

+CLANG_OPTIONS += $(EXTRA_BPF_FLAGS)
+
 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE
util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
  $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-- 
2.43.0

