Return-Path: <linux-kernel+bounces-839847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 551FBBB291C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 07:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A851771E8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 05:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AD7258EF0;
	Thu,  2 Oct 2025 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="VJBT3LE9"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B977081C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 05:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384754; cv=none; b=eWYrTpdqBTTDPFcrMKlg7jHGKoJV2szn11QeliHQgPoOhqljqLLL+Iux5b/pBZa+ZHjVCGtm/viNSjz9dmsNYCy4RI5K50B4emsEUzkVeprq16z0kJsm3P3mLLKp/fU9CkXwynWxeLt5tdVVYT9jmd1bPq9fGB7xl/R2VQ8H0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384754; c=relaxed/simple;
	bh=AeB0HHotof3x6PRuqVzycIKpOT8KClTH51dxePL52+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqWK1SJG1lrEgy2rp2/ACu9YfcS5PfrOxCD3XLIsN1WgC05b9EQhKzPecAOfnmHEXfUbmotaCFOZFJwD1IqWWezkfznA3QZ/9ZOEuQZxwEiMf4cNMa/eJRn915CMSV/1NYlV750kJl3r5VXngxZJJCqI/Wv4l0sUDhhmWdvEcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=VJBT3LE9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-78127433a32so559319b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1759384750; x=1759989550; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BXQ4CxsL43Ogr7PGdYvnAsJB0DrK7fOoXfrDbIjb6PY=;
        b=VJBT3LE9rLaOhihjwUUuWf5dvthcRz8EwNfWxeCysDM9f0sj0ks3tPx6sWVirv9I3R
         9Om+fPFeUGKCbKXbMpkg02IhILPI9MosOEEX1/z4lDzvk2+FCChpHC0qz8+Z8YWUWqeJ
         werLdH7pe6DCXej+KJFongzU15ZZ9BX/odwwTuJqfxt2f7njE8jUnKj0xzhKiBSkRWrK
         dJqIbegjznAK8Q3ZH/73PuU8Xii4TPOQT3ecZJ7FsF+8eJeufwFOX0ZAnQYpNPOKVKzE
         8kTSEzHZt5RpIrkQ8NDuwXkTJ+RSe9AWoUnXZGsIH/W6oaXK1BrGxKf8H1QoDtzxEQd0
         0PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759384750; x=1759989550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXQ4CxsL43Ogr7PGdYvnAsJB0DrK7fOoXfrDbIjb6PY=;
        b=QH1o7Lr+TIArX6i1vF4fQ1zlJkFsYsq8HZiWSDpW9wEBPuO9x5+AltcAMFpm1LGtHw
         uORgwRGizPCdtkqjdj6E0WYSwWHOMTYNKst76lDSFyeDD6np1xOt4ujsLdyY3xWxLgea
         VXkWI79FhFtl5CYVvSuZdKvUStunU/CKFCBm8iUlrLz1ZjTv8pKz62Aw7PC4MbHjtldt
         tYz/sFZw3Y5QOZiZFjehAHLWtu2N+IRttUPRJHmj7LSZ2HSfx6gaa1CDivCm7BleuEKL
         dYKzbofc+rV4T5PBF82L/qLCiPrdvTPcDZY9YPJzpxqtRz4W0s9vW7Vpr7r8bGF2wf5q
         3nrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlEkN+FDm80tQyOHoKcCUZlFM0Jup/hu54Di80D0GO+YOAR/La2DWKDINddVDBrKvoSI6jAdbiHbiAIDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH4Z2O9FzKzv4vmK1ZjH6RrWyEW+dxP8QLxgaltggPYyU9rCNc
	oxgMGhivPKdghagrAxQnNxnoQ9SysejbwbAyayTcEyKrb1TSnxENNdHB4Cl1ocT5rCc=
X-Gm-Gg: ASbGnctvyXE8IlWl7TeZ7pSLe9qr2l4bXJl4rLjf+NAlWWcpB+rFQKjJsAknZ1olAAR
	KvIGFD349y5RCmVA3Q/uuvcPoN1AXmkql923nKMGmrr90vC8LAH/FyALl1+e8PQETusEK/thT3E
	AWsOCXQWLRtFJchwcc+6J0J9CjVEKrzp/zhYhaJttDRbU/JQ8XitxdvZegiK9UFPooymUl1kTwk
	4Xb0MWDLExKGjH9m+bYOK6mk9oMR5QaIutytMW67tDIgdZH/W1lh9+roV3NeZxCG3oUbWDOssva
	rtzE2NZeTbpYd1qYC27CWpA21g69Ckus9JigBrSet4rN9mZNSUeUninO9aCaOT/NI0CeNd14Qgo
	UqDXm0ccPnIzLfMJ9qGqRoiIp7LBzKGIqeYoi4PohNw==
X-Google-Smtp-Source: AGHT+IGPHPH5CNK6OnAVQsGHVb0wf2L07EEb0sQQNxOC4B5rGlQB8izduq3JkiRv+opeWyP/xM1ghg==
X-Received: by 2002:a05:6a00:1888:b0:77e:8130:fda with SMTP id d2e1a72fcca58-78af3ffee29mr7483708b3a.13.1759384750327;
        Wed, 01 Oct 2025 22:59:10 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:cf18:a2b6:6082:9df8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020537d2sm1382753b3a.58.2025.10.01.22.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 22:59:09 -0700 (PDT)
Date: Wed, 1 Oct 2025 22:59:07 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andy Chiu <andybnac@gmail.com>
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, greentime.hu@sifive.com,
	vincent.chen@sifive.com, Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v 2/2] selftests: riscv: Add test for the Vector ptrace
 interface
Message-ID: <aN4UqyjyW-CFH5PE@ghost>
References: <20251001111451.299163-1-yongxuan.wang@sifive.com>
 <20251001111451.299163-3-yongxuan.wang@sifive.com>
 <CAFTtA3MB0Oxe5Wy_Bq-uhijz2h6o0ZWezvoJPiXdjEmcGd6S4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFTtA3MB0Oxe5Wy_Bq-uhijz2h6o0ZWezvoJPiXdjEmcGd6S4A@mail.gmail.com>

On Thu, Oct 02, 2025 at 12:53:13AM -0500, Andy Chiu wrote:
> Hi Yong-Xuan,
> 
> I found some issues which deserve a re-roll:
> 
> On Wed, Oct 1, 2025 at 6:15 AM Yong-Xuan Wang <yongxuan.wang@sifive.com> wrote:
> >
> > Add a test case that does some basic verification of the Vector ptrace
> > interface. This forks a child process then using ptrace to inspect and
> > manipulate the v31 register of the child.
> >
> > Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > ---
> >  tools/testing/selftests/riscv/vector/Makefile |   5 +-
> >  .../selftests/riscv/vector/vstate_ptrace.c    | 132 ++++++++++++++++++
> >  2 files changed, 136 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/riscv/vector/vstate_ptrace.c
> >
> > diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testing/selftests/riscv/vector/Makefile
> > index 6f7497f4e7b3..45f25e9dd264 100644
> > --- a/tools/testing/selftests/riscv/vector/Makefile
> > +++ b/tools/testing/selftests/riscv/vector/Makefile
> > @@ -2,7 +2,7 @@
> >  # Copyright (C) 2021 ARM Limited
> >  # Originally tools/testing/arm64/abi/Makefile
> >
> > -TEST_GEN_PROGS := v_initval vstate_prctl
> > +TEST_GEN_PROGS := v_initval vstate_prctl vsate_ptrace
> 
> Please s/vsate_ptrace/vstate_ptrace
> 
> Otherwise we will not get the program compiled
> 
> >  TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc v_exec_initval_nolibc
> >
> >  include ../../lib.mk
> > @@ -26,3 +26,6 @@ $(OUTPUT)/v_initval: v_initval.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
> >  $(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
> >         $(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
> >                 -Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
> > +
> > +$(OUTPUT)/vstate_ptrace: vstate_ptrace.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
> > +       $(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> > diff --git a/tools/testing/selftests/riscv/vector/vstate_ptrace.c b/tools/testing/selftests/riscv/vector/vstate_ptrace.c
> > new file mode 100644
> > index 000000000000..8a7bcf318e59
> > --- /dev/null
> > +++ b/tools/testing/selftests/riscv/vector/vstate_ptrace.c
> > @@ -0,0 +1,132 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <asm/ptrace.h>
> > +#include <linux/elf.h>
> > +#include <sys/ptrace.h>
> > +#include <sys/uio.h>
> > +#include <sys/wait.h>
> > +#include "../../kselftest.h"
> > +#include "v_helpers.h"
> > +
> > +int parent_set_val, child_set_val;
> > +
> > +static long do_ptrace(enum __ptrace_request op, pid_t pid, long type, size_t size, void *data)
> > +{
> > +       struct iovec v_iovec = {
> > +               .iov_len = size,
> > +               .iov_base = data
> > +       };
> > +
> > +       return ptrace(op, pid, type, &v_iovec);
> > +}
> > +
> > +static int do_child(void)
> > +{
> > +       int out;
> > +
> > +       if (ptrace(PTRACE_TRACEME, -1, NULL, NULL)) {
> > +               ksft_perror("PTRACE_TRACEME failed\n");
> > +               return EXIT_FAILURE;
> > +       }
> > +
> > +       asm volatile (".option push\n\t"
> > +               ".option        arch, +v\n\t"
> 
> As mentioned before, please use ".option arch, +v,-c\n\t" or ".option
> norvc\n\t" and +=4 when advancing the pc

arch -c should be avoided, there are cases when it does not always avoid
using all compressed instructions. norvc should always do the right
thing though. There is discussion at [1] about deprecating it (along with
all variants of -ext).

[1] https://inbox.sourceware.org/binutils/7ecdc846-0822-4666-957f-ff818786fb44@iscas.ac.cn/T/#t

- Charlie

> 
> > +               "vsetivli       x0, 1, e32, m1, ta, ma\n\t"
> > +               "vmv.s.x        v31, %[in]\n\t"
> > +               "ebreak\n\t"
> > +               "vmv.x.s        %[out], v31\n\t"
> > +               ".option pop\n\t"
> > +               : [out] "=r" (out)
> > +               : [in] "r" (child_set_val));
> > +
> > +       if (out != parent_set_val)
> > +               return EXIT_FAILURE;
> > +
> > +       return EXIT_SUCCESS;
> > +}
> > +
> > +static void do_parent(pid_t child)
> > +{
> > +       int status;
> > +       void *data = NULL;
> > +
> > +       /* Attach to the child */
> > +       while (waitpid(child, &status, 0)) {
> > +               if (WIFEXITED(status)) {
> > +                       ksft_test_result(WEXITSTATUS(status) == 0, "SETREGSET vector\n");
> > +                       goto out;
> > +               } else if (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP)) {
> > +                       size_t size, t;
> 
> unused variable t
> 
> > +                       void *data, *v31;
> > +                       struct __riscv_v_regset_state *v_regset_hdr;
> > +                       struct user_regs_struct *gpreg;
> > +
> > +                       size = sizeof(*v_regset_hdr);
> > +                       data = malloc(size);
> > +                       if (!data)
> > +                               goto out;
> > +                       v_regset_hdr = (struct __riscv_v_regset_state *)data;
> > +
> > +                       if (do_ptrace(PTRACE_GETREGSET, child, NT_RISCV_VECTOR, size, data))
> > +                               goto out;
> > +
> > +                       ksft_print_msg("vlenb %ld\n", v_regset_hdr->vlenb);
> > +                       data = realloc(data, size + v_regset_hdr->vlenb * 32);
> 
> realloc may give a new pointer so v_regset_hdr has to be updated here
> before the next use
> 
> > +                       if (!data)
> > +                               goto out;
> > +                       v31 = (void *)(data + size + v_regset_hdr->vlenb * 31);
> > +                       size += v_regset_hdr->vlenb * 32;
> > +
> > +                       if (do_ptrace(PTRACE_GETREGSET, child, NT_RISCV_VECTOR, size, data))
> > +                               goto out;
> > +
> > +                       ksft_test_result(*(int *)v31 == child_set_val, "GETREGSET vector\n");
> > +
> > +                       *(int *)v31 = parent_set_val;
> > +                       if (do_ptrace(PTRACE_SETREGSET, child, NT_RISCV_VECTOR, size, data))
> > +                               goto out;
> > +
> > +                       /* move the pc forward */
> > +                       size = sizeof(*gpreg);
> > +                       data = realloc(data, size);
> > +                       gpreg = (struct user_regs_struct *)data;
> > +
> > +                       if (do_ptrace(PTRACE_GETREGSET, child, NT_PRSTATUS, size, data))
> > +                               goto out;
> > +
> > +                       gpreg->pc += 2;
> > +                       if (do_ptrace(PTRACE_SETREGSET, child, NT_PRSTATUS, size, data))
> > +                               goto out;
> > +               }
> > +
> > +               ptrace(PTRACE_CONT, child, NULL, NULL);
> > +       }
> > +
> > +out:
> > +       free(data);
> > +}
> > +
> > +int main(void)
> > +{
> > +       pid_t child;
> > +
> > +       ksft_set_plan(2);
> > +       if (!is_vector_supported() && !is_xtheadvector_supported())
> > +               ksft_exit_skip("Vector not supported\n");
> > +
> > +       srandom(getpid());
> > +       parent_set_val = rand();
> > +       child_set_val = rand();
> > +
> > +       child = fork();
> > +       if (child < 0)
> > +               ksft_exit_fail_msg("Fork failed %d\n", child);
> > +
> > +       if (!child)
> > +               return do_child();
> > +
> > +       do_parent(child);
> > +
> > +       ksft_finished();
> > +}
> > --
> > 2.43.0
> >
> 
> Thanks,
> Andy

