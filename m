Return-Path: <linux-kernel+bounces-850120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A09BD1ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38EE43BA4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8EC2EC0BC;
	Mon, 13 Oct 2025 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDKHGhD5"
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4862EACF0
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342894; cv=none; b=Uza2cGZ+16/6u0VESMlGdgwaKAXZfkbHvbt6E8aeQ0F2UWtt0ZUVXzWstHsR0rGvzf0VHk7TtbcJj70QwbPGBGnZAs9CDZcGxpgCBOjOXhr6a7YoLU8BxSAaaNxrtFq4kYpFVg5nvPoXDl7npHjDFq9yFuVtfA1D/GPEAvBUBu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342894; c=relaxed/simple;
	bh=hxbMiKWHABlxCO+9GLfBy9IZNmOoeNGOwOAu7TFR9YE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iMFskud6bOliR3bhRoV88d72pcV2TT0zGgpnTw8SUArD34OoN6YDNJC1xvZuiZJJ6Mtwv0SRhXtOXENPS5YLH2yDw3hf8d8sCPUiC9XHerBgxOpmLBYPPQdNP2prlmwQj2vS4/sBK9HIq9YJtCT0SEf6bJOtURPyQNNzhiXE+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDKHGhD5; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-36a448c8aa2so33831401fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760342891; x=1760947691; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bz2QGidhgo+X/Fpd+rZ1lAEe7FF+RTcu3YPeYbCkLMw=;
        b=IDKHGhD5RBk86ctzZbtJYCKi+6b01UkELHu8/Merm4de4z674kj8eNlpavEivOhbSr
         MOSDtJFYj7MlPOb3QAuuN9F5dbR1FhSsh2i2iMc/pmK36gvOZ4rjSHmP9DahtTRXE3Jb
         DMkQdRn0/13vPojVy0LZmULpGlW3BvmB6IYeO9GCGE9EiW3NAhOjtFP4M/NStG6nyCdQ
         lilnRDH0RoNSMtJYTQzGKlVwNVLjpm+tLPsxa8MxbdnubQE8n9s0y7MJsQhm2f/4uOcz
         f7VhICo5rGLDLTVMRaJ/gTvQQBlDT8LmG5QtvpuQ3nk2MHJz/neO3mwrGPxrLscIeNuC
         xNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342891; x=1760947691;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bz2QGidhgo+X/Fpd+rZ1lAEe7FF+RTcu3YPeYbCkLMw=;
        b=K1xJ07uNhsNa9ZJqRijaUB58mV7Icoo3qXHPs1ThNsJkVAv4xgoeTlNYoQBtS9smRh
         OgoJowP4MUtwv0NYfzonykEviSI1j68p8dWSwy/rlQaH2PS2bHwMQxOmmXS/ZHLg423W
         t03ScoU8YoUyW8FVPLP7ZP3Rc2pxzlfWGMh6QRigvkGbWOds67L+CFx/2frUJJwiuBD3
         cDZiX3cN5+XqWEFB5qVk4ne9ja7hKO+EmpUiIQA+sXhszpfqwNrfArNdp3Z5QhZn0H/R
         l1H3FmY/zXeZUd7vduCP/qH9widjOJEena+JbJyL7AQMnKKZnkuy8PJA7xnhig/RDIBv
         mjew==
X-Forwarded-Encrypted: i=1; AJvYcCWOCad6WGdMf12Y1KVjVgfVzDVimFGBLr0oGa8Z96VTeNrliJVaKIZM3Og+uOM0YgE2iAws+NAMEdq3ACc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx04KkW/eW6dh4faiHKTzn2E3AWTjdkMC6APW0AzXGwy2MdYN7s
	Rxz5GYAqwjU8PUcYX/6HJ1bt7Jp+x/W0b238GPvij14feGQi2B+G6vXtMzJ6cgWHCRyW/FseEKG
	/mXEvVUHoz0K18fMt/wJAZKfLx+9cgQw=
X-Gm-Gg: ASbGncun4E9A3BA5SR1Fe12hN6kYnaVCLHMIADBkyPCWpcdP7N4SyJvrSVlQRAZ7ooe
	Du+b0n8QP/rsIlEK8Vy3wQd9vIupMQxQfMfzjVruFFFQNdP8axh1zh5yTr+K16CcPSsQ5ajaTcS
	EQOonR2Tr08C/2GdHkgY3623rs4xNpT1vm8uCHl8xtebMhlKZD4HAFW++t83RrSV4V8NTj8Jgj1
	Aezu1ykV8KTDCzm/hF+2VUg1ixPcIe6tCetWQ==
X-Google-Smtp-Source: AGHT+IEdRH2/twiTxUCsz2FNdqKhR4MJ7K55PctExmYC7IkUC3AAryzqJYOqRlICWr6mCwVYMBZBSQTtXPuwhbKdCl4=
X-Received: by 2002:a05:651c:2126:b0:372:921b:4b7e with SMTP id
 38308e7fff4ca-37609e46310mr51245101fa.27.1760342890304; Mon, 13 Oct 2025
 01:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com>
In-Reply-To: <20251013080609.2070555-1-hupu.gm@gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 13 Oct 2025 16:07:58 +0800
X-Gm-Features: AS18NWDWUG__4MWsbz9WXnhdDbqgwYSwIyPc7H86fNfD4Zzu1kXnX_kRb05Hvug
Message-ID: <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: namhyung@kernel.org, irogers@google.com, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Maintainer,

I encountered some issues while cross-compiling perf (ARCH=arm64),
particularly when enabling the BPF option. During the build, Clang
fails to compile BPF programs due to missing header files. The
relevant error messages are as follows:


---------------------------------------
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/crosstool-ng/output/aarch64-dumpstack-linux-gnu/bin/../aarch64-dumpstack-linux-gnu/sysroot/usr/lib/aarch64-linux-gnu/libzstd.a
when searching for -lzstd
/usr/bin/ld: skipping incompatible
/home/hupu/work/tools/crosstool-ng/output/aarch64-dumpstack-linux-gnu/bin/../aarch64-dumpstack-linux-gnu/sysroot/usr/lib/libc.a
when searching for -lc
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-dso_dlfcn.o):
in function `dlfcn_globallookup':
(.text+0x1f): warning: Using 'dlopen' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-bio_addr.o):
in function `BIO_lookup_ex':
(.text+0xdbc): warning: Using 'getaddrinfo' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
/usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/13/../../../x86_64-linux-gnu/libcrypto.a(libcrypto-lib-bio_sock.o):
in function `BIO_gethostbyname':
(.text+0x85): warning: Using 'gethostbyname' in statically linked
applications requires at runtime the shared libraries from the glibc
version used for linking
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
  CLANG   /home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_event.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:5
| #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_event.h:19:
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_event.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
1 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o]
Error 1
make[3]: *** Waiting for unfinished jobs....
In file included from <built-in>:2:
In file included from ./util/bpf_skel/perf_version.h:6:
In file included from
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:7:
In file included from
/home/hupu/work/code/explore/linux-mainline/tools/include/uapi/linux/perf_event.h:19:
/usr/include/linux/ioctl.h:5:10: fatal error: 'asm/ioctl.h' file not found
    5 | #include <asm/ioctl.h>
      |          ^~~~~~~~~~~~~
1 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o]
Error 1
1 error generated.
1 error generated.
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o]
Error 1
make[3]: *** [Makefile.perf:1259:
/home/hupu/work/code/explore/output/build-mainline/tools/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o]
Error 1
make[2]: *** [Makefile.perf:289: sub-make] Error 2
make[1]: *** [Makefile:76: all] Error 2
make: *** [Makefile:93: perf] Error 2
---------------------------------------


This happens because the eBPF part of perf is compiled with Clang,
which by default searches only the host /usr/include/ paths for
headers, not the cross-compilation sysroot. As a result, it cannot
find the ARM64-specific asm/ioctl.h.

To address this issue, I wrote a patch that introduces a new make
variable, EXTRA_CLANG_FLAGS. This allows passing custom Clang options
via the command line during the BPF skeleton build, for example
--sysroot or custom include paths, without modifying Makefile.perf
itself.

Example usage:
  EXTRA_CLANG_FLAGS="--sysroot=$SYSROOT"
  make perf ARCH=arm64 EXTRA_CLANG_FLAGS="$EXTRA_CLANG_FLAGS"

I have tested this approach and it works. However, I am not sure if
this is the optimal solution, so I would like to discuss this further
with you and get your feedback.

Thanks,
hupu

