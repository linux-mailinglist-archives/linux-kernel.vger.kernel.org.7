Return-Path: <linux-kernel+bounces-859840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 642A1BEEBA1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 21:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32E2C4E431F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 19:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8471632DD;
	Sun, 19 Oct 2025 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="3d3YEfJ9"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FE413DDAE
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760900676; cv=none; b=hi3o54AT/+5UgcLykobi+VoEcy7Jjc6wQEE3bbe++bQxPK/Wgv/TLeRtTwp4k13Gx2KDnhnZB7qaXlwglYKnCtjoqiePraiv2GmaWMBeV9VhNuRQzmw6bPA8/0K0TsnaR9I2sLL6sDHW/vGWLrUwnW9o3BgrRTD9sEee74C0gu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760900676; c=relaxed/simple;
	bh=BpRp6fgEgQJuVGW3a0ocxmCp7ucLIm4d1XmPkFqcwOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBA/S07cxMuMNHh47WWilotbAJv2wtYOAhFP6hWgOQ+ZzozB8z9eQJCAQRg2POIcQfsiyaJITIZ/famJTXEel+JaEgeDw6Z4jkMB7pK/fHz/Nc5I+Kq3ezlRbcCXRTKNlKcz/W+nhetcGdAJAc2FgCrwpw35RvoXDgnJqKyZI7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=3d3YEfJ9; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-783fa3af3bdso21094557b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 12:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1760900673; x=1761505473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeYCvC20ICozsgTwQqf2izmvTctGrn01AWEb3/XCnqw=;
        b=3d3YEfJ9aJR5UWXek2i1ZVHUGsP9lP/ggG3hseHIhXB9Q2cLE/eiK07jLrcqjaASdq
         2kofFpkMo6BEqnARkMCwVEVR5n6chMsibmTgPxrhfEafwXhNp2DAn1b6itnDB6OPFrLi
         C9ExutbDZkY0wlHX2qPdx2fGg2olYe5Z2Kv7Ks6ZMghGKzW1z3rinihKCjrwkccQrlkK
         C/58ZzPpSGavipFGGw89Lix1vVbS8tGB398+u8zLX+GCBfFLFg/iPt8jM+qaORvJ8foJ
         CFfptkb9kHkkH0z7F13qghyOAp3/ItcciggZTVaizFH33qEwPzkRnjPBwnGwEXEIH0TF
         yZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760900673; x=1761505473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeYCvC20ICozsgTwQqf2izmvTctGrn01AWEb3/XCnqw=;
        b=lsa6///mRkfF1WtGNBII7dG0D1X6Hec6MQdmE/aLjuQNlJCjjI3/rCiofwf4e8w06X
         zvJs6EnDXNqZxAI/r+OxSe49ZDuFnKb+38HIvYzLRuzKluhMEFVGPTw7sYdH3c6WaJ/7
         B0+ocPZGqyXMUKEdkCzE/v8jWuslFyMiM1Mjm6ZiKqgi+dWREe6ymbjQiPcLsv79Xaoh
         eUDUUz5qZtOVA/iPLrrtwLxTmJOfGQmvwRB7FCy0zh0djNW7R0KRlRUdLFtF1Io+/qGN
         W+y0e3MoAc+0GWrc29qptg+NQaLnla3LXPQWB/WzOjAXKjLIRujzW10+JCfRspABEeaL
         2Xmg==
X-Forwarded-Encrypted: i=1; AJvYcCUMAkpA8xWdAD7pycQgODdZuDLh3zz8/02NvZOFM6j0qCsHxRm9WwR+vnJvk5xebfB3hW2oLRuFy4D2HFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynYiFzS11aD0xPaq7E0Oao0bVlX9nksHJeL0KqbxpzkyAhhOH9
	Wb3nmAhXecQaQ5UVzJCA6IQLNKoORIOnF5fTe4GFeTcy5hFakVYZTsBbhmWsiWqWex63A/lotHt
	7vrlT4tQbe3vbW1qZUw3wnqm++IH+YnSrgDLAOLykSQ==
X-Gm-Gg: ASbGnctrDYbVXa10owPbRMc0qRiHIaoYAbZJ3WmKxp5TP+s57+19Y099sLITQCUSdxB
	RxwrHUNDtH3XGBUem6ONU6wnJdsjtLOrpF4RHn9JegK90ZkyLTn7lQlTg6xWg0U8YvnUCfPbPtz
	u+rMCc4vxx2xc92+afJvVnBtHBQkah6MV8FZsOIhJeOVJr5Eb0drzgrtiWKYLB9N8Iqs/QZ8aJ4
	ujdam8K5/5YsGhVT9SIjoSxGU5gVo8SStIqvV6SHwphS9sGgfwSK3AHi0G9J5U=
X-Google-Smtp-Source: AGHT+IER9KulLoujMk2GEbTzX3NN7vIbveUsxcHTAqM55q0WXEH/l6DxMF/VhDwwNIq1+MDih3R7dyO0bS7rvmSbtgE=
X-Received: by 2002:a05:690e:408b:b0:63e:2284:83c6 with SMTP id
 956f58d0204a3-63e22848539mr6620905d50.49.1760900672686; Sun, 19 Oct 2025
 12:04:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017093214.70029-1-arighi@nvidia.com> <20251017093214.70029-14-arighi@nvidia.com>
In-Reply-To: <20251017093214.70029-14-arighi@nvidia.com>
From: Emil Tsalapatis <linux-lists@etsalapatis.com>
Date: Sun, 19 Oct 2025 15:04:22 -0400
X-Gm-Features: AS18NWDx67qGjf5v9glUm72CG0k0R38tXMBBhQDUtWSKsUuHHmtNZ9AKmos4kEI
Message-ID: <CABFh=a578RNXxjtze1TxAcPBkx9_M58qBc=6E4o-uFJx0DB4Jg@mail.gmail.com>
Subject: Re: [PATCH 13/14] selftests/sched_ext: Add test for sched_ext dl_server
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>, 
	sched-ext@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:38=E2=80=AFAM Andrea Righi <arighi@nvidia.com> wr=
ote:
>
> Add a selftest to validate the correct behavior of the deadline server
> for the ext_sched_class.
>
> [ Joel: Replaced occurences of CFS in the test with EXT. ]
>
> Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>
> ---

Nits listed below, but otherwise:
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Code review aside, on my VM the test alternates between 4.81% and 5.20% for=
 me
so it's working as expected.

>  tools/testing/selftests/sched_ext/Makefile    |   1 +
>  .../selftests/sched_ext/rt_stall.bpf.c        |  23 ++
>  tools/testing/selftests/sched_ext/rt_stall.c  | 214 ++++++++++++++++++
>  3 files changed, 238 insertions(+)
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/rt_stall.c
>
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/s=
elftests/sched_ext/Makefile
> index 5fe45f9c5f8fd..c9255d1499b6e 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -183,6 +183,7 @@ auto-test-targets :=3D                        \
>         select_cpu_dispatch_bad_dsq     \
>         select_cpu_dispatch_dbl_dsp     \
>         select_cpu_vtime                \
> +       rt_stall                        \
>         test_example                    \
>
>  testcase-targets :=3D $(addsuffix .o,$(addprefix $(SCXOBJ_DIR)/,$(auto-t=
est-targets)))
> diff --git a/tools/testing/selftests/sched_ext/rt_stall.bpf.c b/tools/tes=
ting/selftests/sched_ext/rt_stall.bpf.c
> new file mode 100644
> index 0000000000000..80086779dd1eb
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/rt_stall.bpf.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A scheduler that verified if RT tasks can stall SCHED_EXT tasks.
> + *
> + * Copyright (c) 2025 NVIDIA Corporation.
> + */
> +
> +#include <scx/common.bpf.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +UEI_DEFINE(uei);
> +
> +void BPF_STRUCT_OPS(rt_stall_exit, struct scx_exit_info *ei)
> +{
> +       UEI_RECORD(uei, ei);
> +}
> +
> +SEC(".struct_ops.link")
> +struct sched_ext_ops rt_stall_ops =3D {
> +       .exit                   =3D (void *)rt_stall_exit,
> +       .name                   =3D "rt_stall",
> +};
> diff --git a/tools/testing/selftests/sched_ext/rt_stall.c b/tools/testing=
/selftests/sched_ext/rt_stall.c
> new file mode 100644
> index 0000000000000..e9a0def9ee323
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/rt_stall.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 NVIDIA Corporation.
> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/prctl.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <time.h>
> +#include <linux/sched.h>
> +#include <signal.h>
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include "rt_stall.bpf.skel.h"
> +#include "scx_test.h"
> +#include "../kselftest.h"
> +
> +#define CORE_ID                0       /* CPU to pin tasks to */
> +#define RUN_TIME        5      /* How long to run the test in seconds */
> +
> +/* Simple busy-wait function for test tasks */
> +static void process_func(void)
> +{
> +       while (1) {
> +               /* Busy wait */
> +               for (volatile unsigned long i =3D 0; i < 10000000UL; i++)
> +                       ;
> +       }
> +}
> +
> +/* Set CPU affinity to a specific core */
> +static void set_affinity(int cpu)
> +{
> +       cpu_set_t mask;
> +
> +       CPU_ZERO(&mask);
> +       CPU_SET(cpu, &mask);
> +       if (sched_setaffinity(0, sizeof(mask), &mask) !=3D 0) {
> +               perror("sched_setaffinity");
> +               exit(EXIT_FAILURE);
> +       }
> +}
> +
> +/* Set task scheduling policy and priority */
> +static void set_sched(int policy, int priority)
> +{
> +       struct sched_param param;
> +
> +       param.sched_priority =3D priority;
> +       if (sched_setscheduler(0, policy, &param) !=3D 0) {
> +               perror("sched_setscheduler");
> +               exit(EXIT_FAILURE);
> +       }
> +}
> +
> +/* Get process runtime from /proc/<pid>/stat */
> +static float get_process_runtime(int pid)
> +{
> +       char path[256];
> +       FILE *file;
> +       long utime, stime;
> +       int fields;
> +
> +       snprintf(path, sizeof(path), "/proc/%d/stat", pid);
> +       file =3D fopen(path, "r");
> +       if (file =3D=3D NULL) {
> +               perror("Failed to open stat file");
> +               return -1;
> +       }
> +
> +       /* Skip the first 13 fields and read the 14th and 15th */
> +       fields =3D fscanf(file,
> +                       "%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u =
%*u %lu %lu",
> +                       &utime, &stime);
> +       fclose(file);
> +
> +       if (fields !=3D 2) {
> +               fprintf(stderr, "Failed to read stat file\n");
> +               return -1;
> +       }
> +
> +       /* Calculate the total time spent in the process */
> +       long total_time =3D utime + stime;
> +       long ticks_per_second =3D sysconf(_SC_CLK_TCK);
> +       float runtime_seconds =3D total_time * 1.0 / ticks_per_second;
> +
> +       return runtime_seconds;
> +}
> +
> +static enum scx_test_status setup(void **ctx)
> +{
> +       struct rt_stall *skel;
> +
> +       skel =3D rt_stall__open();
> +       SCX_FAIL_IF(!skel, "Failed to open");
> +       SCX_ENUM_INIT(skel);
> +       SCX_FAIL_IF(rt_stall__load(skel), "Failed to load skel");
> +
> +       *ctx =3D skel;
> +
> +       return SCX_TEST_PASS;
> +}
> +
> +static bool sched_stress_test(void)
> +{
> +       float cfs_runtime, rt_runtime, actual_ratio;
> +       int cfs_pid, rt_pid;

I think it should be cfs_pid -> ext_pid, cfs_runtime -> ext_runtime

> +       float expected_min_ratio =3D 0.04; /* 4% */

Maybe add a comment that explains the 4% value? As in, we're expecting
it to be around 5% so 0.04 accounts for values close enough but
below < 5%.

> +
> +       ksft_print_header();
> +       ksft_set_plan(1);
> +
> +       /* Create and set up a EXT task */
> +       cfs_pid =3D fork();
> +       if (cfs_pid =3D=3D 0) {
> +               set_affinity(CORE_ID);
> +               process_func();
> +               exit(0);
> +       } else if (cfs_pid < 0) {
> +               perror("fork for EXT task");
> +               ksft_exit_fail();
> +       }
> +
> +       /* Create an RT task */
> +       rt_pid =3D fork();
> +       if (rt_pid =3D=3D 0) {
> +               set_affinity(CORE_ID);
> +               set_sched(SCHED_FIFO, 50);
> +               process_func();
> +               exit(0);
> +       } else if (rt_pid < 0) {
> +               perror("fork for RT task");
> +               ksft_exit_fail();
> +       }
> +
> +       /* Let the processes run for the specified time */
> +       sleep(RUN_TIME);
> +
> +       /* Get runtime for the EXT task */
> +       cfs_runtime =3D get_process_runtime(cfs_pid);
> +       if (cfs_runtime !=3D -1)
> +               ksft_print_msg("Runtime of EXT task (PID %d) is %f second=
s\n",
> +                              cfs_pid, cfs_runtime);
> +       else
> +               ksft_exit_fail_msg("Error getting runtime for EXT task (P=
ID %d)\n", cfs_pid);
> +
> +       /* Get runtime for the RT task */
> +       rt_runtime =3D get_process_runtime(rt_pid);
> +       if (rt_runtime !=3D -1)
> +               ksft_print_msg("Runtime of RT task (PID %d) is %f seconds=
\n", rt_pid, rt_runtime);
> +       else
> +               ksft_exit_fail_msg("Error getting runtime for RT task (PI=
D %d)\n", rt_pid);
> +

Minor, but why not

if (rt_runtime =3D=3D -1)
        ksft_exit_fail_msg("Error getting runtime for RT task (PID
%d)\n", rt_pid);
ksft_print_msg("Runtime of RT task (PID %d) is %f seconds\n", rt_pid,
rt_runtime);

since ksft_exit_fail_msg never returns?

> +       /* Kill the processes */
> +       kill(cfs_pid, SIGKILL);
> +       kill(rt_pid, SIGKILL);
> +       waitpid(cfs_pid, NULL, 0);
> +       waitpid(rt_pid, NULL, 0);
> +
> +       /* Verify that the scx task got enough runtime */
> +       actual_ratio =3D cfs_runtime / (cfs_runtime + rt_runtime);
> +       ksft_print_msg("EXT task got %.2f%% of total runtime\n", actual_r=
atio * 100);
> +
> +       if (actual_ratio >=3D expected_min_ratio) {
> +               ksft_test_result_pass("PASS: EXT task got more than %.2f%=
% of runtime\n",
> +                                     expected_min_ratio * 100);
> +               return true;
> +       }
> +       ksft_test_result_fail("FAIL: EXT task got less than %.2f%% of run=
time\n",
> +                             expected_min_ratio * 100);
> +       return false;
> +}
> +
> +static enum scx_test_status run(void *ctx)
> +{
> +       struct rt_stall *skel =3D ctx;
> +       struct bpf_link *link;
> +       bool res;
> +
> +       link =3D bpf_map__attach_struct_ops(skel->maps.rt_stall_ops);
> +       SCX_FAIL_IF(!link, "Failed to attach scheduler");
> +
> +       res =3D sched_stress_test();
> +
> +       SCX_EQ(skel->data->uei.kind, EXIT_KIND(SCX_EXIT_NONE));
> +       bpf_link__destroy(link);
> +
> +       if (!res)
> +               ksft_exit_fail();
> +
> +       return SCX_TEST_PASS;
> +}
> +
> +static void cleanup(void *ctx)
> +{
> +       struct rt_stall *skel =3D ctx;
> +
> +       rt_stall__destroy(skel);
> +}
> +
> +struct scx_test rt_stall =3D {
> +       .name =3D "rt_stall",
> +       .description =3D "Verify that RT tasks cannot stall SCHED_EXT tas=
ks",
> +       .setup =3D setup,
> +       .run =3D run,
> +       .cleanup =3D cleanup,
> +};
> +REGISTER_SCX_TEST(&rt_stall)
> --
> 2.51.0
>
>

