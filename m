Return-Path: <linux-kernel+bounces-840451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A83BB474D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00702165B96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E83242D83;
	Thu,  2 Oct 2025 16:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5mBxDn6"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BA52BD03
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759421598; cv=none; b=qODc991ALBl6QLECxH6ssKJ4jn21X7T3AYzEXndQmxwsj2k7E6ak0/uWUSUDj87awbIo4hXL8hj3xlStvYa0IInLKOuT3LWbvlSJCEy+QMpyOVrdcN+j0iCiEOyhsoOOL84BEGGdR7uVbn+NyKvNimxAHLeNgtxNr78VKo8Cndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759421598; c=relaxed/simple;
	bh=hGfU1yhbnCZ84ewuKao69g7BMYAcq101c3J1bO68wrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IUl0dZiUBIiUM+BQzG0b5fjkZMeu4vCEa+Z0MFs9m7shN5TAa/zs2gHDrmeFHtm3DxOhj96ZwdLS2O2v05sIcGl3jh3OP/MPXzXf0kwOzc0ec5z08I7btSSUMAKfMS5q2OJPKb46KQhKe4aBorv1fTUZYyTrLE5UT+3hSaY7FS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5mBxDn6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so1393270a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759421596; x=1760026396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pfpv9Ws6opjG70klRtML+18CndAMxlSA0S6MmozsFQc=;
        b=L5mBxDn6n+9K33N/+Hs2lwVbL3EnI0atwk7gZHVAj2M/br6oEL0AePoLpsXfpfvAbB
         WjJhtNdS9U9kxaUVjaya3Qb6U5jaQI6AKEc13QhSK2bXn7JaIFQZD3RKULeuQns4FV2/
         bdB+FdRapM2SxRvP0bKFJ2vy+yNxRA/scuyBX9e+IrrKqPSuQSNVQd5C0NZ00U3SaElV
         LEfbdJ7QalvQsnFTqneLg+/qbKH4qGXImnKqbOsvNF726X5vH9xarOn0Gt7W58wnMdOd
         XLq46t05tw24QNDDpLeUZfbU246Kfssk87tSIkPs0ASJtHjHk35o1mAMChzu0V0ewu7Y
         WQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759421596; x=1760026396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pfpv9Ws6opjG70klRtML+18CndAMxlSA0S6MmozsFQc=;
        b=dnD0Ql3XodW/5LH7DgV5FTnRvbjcOUavh0Aw0yKSfIt6xUCMZrodJmJYSu84pFdM3w
         hmfzsYrv4NWr6esWsL1VB+BwHDcWfmtyGSBblPjzPZZhyArQvwWBtek2gN8/xLyw2gN7
         VYFAft85KXzK2wltCkCehQzO+OzPKdc2fma77t8KecXomtoiIFGbdMbhPVNtdWn3UKnF
         2zdOxI7NYj1q2WsPjTQplMHWBjVz3QLdT62EongJySxKgiPno9Yi3F3ckUBGkg/b1MQH
         J5H0mLp2LG2l1HkLgRciVSfjMtiXChsKM6rQ78zeXXjiI+n0jnXti2xR++mz8p7yVEQu
         yqIw==
X-Forwarded-Encrypted: i=1; AJvYcCWRl9hODT6sEhDJ415o65KbzL7dSB8gAF1eQCF099AfwJDIXf2brki4dRQdFhMaUhbE1KBVMV6jQ4bXC3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpU9i4GVU6X2tDyUQsQWev1YTDLdKkeM8ltPaVe9wrIxQ1IiE
	vaM3ARlEE7LNF/wmpoAcKPFoinhSCu7qN6/Jh+IXYPjRIc27oNse5U6KYximJfDgT0I+IM6kXRG
	TPz9mSvuxk0rM9QAKkg+HTpUCrPHBT8c=
X-Gm-Gg: ASbGncuV0ug9YXx/PEMUYKuQMN6CdPCed4w72ZR/5buGCuPHyrm7lnClxXrXThq/MxY
	hHxFlqAuekwBIM03yJUeFloEonsNQrRDpKlK8xfEoSZ4WtmQdonxFkltxEhacy1dSPf4MAo0MiX
	FHunReTTdVRl1slfaNEmxqWKmogFpO7xjRltLR00yCizh5W1PaADfUEPwlVzy72XPG4rOcbgzEF
	cMUHWUaSdM5wqDADg+JCH75pWrLo4M=
X-Google-Smtp-Source: AGHT+IF4j5Oy/cj2sLIdeJT6gDlzG6+flxX9HW+fl8QxbxeKGqg9nWOHLaalR2CshCm5u1hDWhg+3/kuF91PrIwrXhQ=
X-Received: by 2002:a17:90b:1b50:b0:32b:bac7:5a41 with SMTP id
 98e67ed59e1d1-339a6f78db8mr10131352a91.37.1759421595750; Thu, 02 Oct 2025
 09:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826080430.79043-1-dongml2@chinatelecom.cn> <20250826080430.79043-3-dongml2@chinatelecom.cn>
In-Reply-To: <20250826080430.79043-3-dongml2@chinatelecom.cn>
From: ChaosEsque Team <chaosesqueteam@gmail.com>
Date: Thu, 2 Oct 2025 12:18:11 -0400
X-Gm-Features: AS18NWCAGgq8apfWOuA8iyU1tOuOEz9oCEny61T7R6S7aPV7MOW49Gwe2lLLTC0
Message-ID: <CALC8CXdNYGy2itPVkmuS3grfCof9ggHTRVyps85_9X2WwREpXQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: skip recursive functions
 for kprobe_multi
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	yikai.lin@vivo.com, memxor@gmail.com, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Indeed, it is so long. Sir Dong, of Meng.

On Tue, Aug 26, 2025 at 4:05=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Some functions is recursive for the kprobe_multi and impact the benchmark
> results. So just skip them.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v2:
> - introduce trace_blacklist instead of copy-pasting strcmp
> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index d24baf244d1f..9577979bd84d 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -19,6 +19,7 @@
>  #include <gelf.h>
>  #include "bpf/hashmap.h"
>  #include "bpf/libbpf_internal.h"
> +#include "bpf_util.h"
>
>  #define TRACEFS_PIPE   "/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE   "/sys/kernel/debug/tracing/trace_pipe"
> @@ -540,8 +541,20 @@ static bool is_invalid_entry(char *buf, bool kernel)
>         return false;
>  }
>
> +static const char * const trace_blacklist[] =3D {
> +       "migrate_disable",
> +       "migrate_enable",
> +       "rcu_read_unlock_strict",
> +       "preempt_count_add",
> +       "preempt_count_sub",
> +       "__rcu_read_lock",
> +       "__rcu_read_unlock",
> +};
> +
>  static bool skip_entry(char *name)
>  {
> +       int i;
> +
>         /*
>          * We attach to almost all kernel functions and some of them
>          * will cause 'suspicious RCU usage' when fprobe is attached
> @@ -559,6 +572,12 @@ static bool skip_entry(char *name)
>         if (!strncmp(name, "__ftrace_invalid_address__",
>                      sizeof("__ftrace_invalid_address__") - 1))
>                 return true;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(trace_blacklist); i++) {
> +               if (!strcmp(name, trace_blacklist[i]))
> +                       return true;
> +       }
> +
>         return false;
>  }
>
> --
> 2.51.0
>
>

