Return-Path: <linux-kernel+bounces-867341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B0BC02531
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121B63A3A88
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F1E278761;
	Thu, 23 Oct 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RC/JNjOg"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C5279335
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235746; cv=none; b=F7jYBKpyBsXwsuTEbHeA4T5Qak4texJ7wLb1l9UT0UM+3FVkBJAQu05VHB6T9HbaL8joT9t59e4KnLukRWSbLob0oay4Iq7jqj+pOzrAG+8L0BTMcWHBp+R0vqXt6n0aIs/qdZAt8M6skR+wGTa6p4jf9JIhNCAy4bCvVwA6vcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235746; c=relaxed/simple;
	bh=iicqHqIRyiknDU8aj031heEdaLM9JecB5tKouPwEMLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DKnzrsXM1ihfygmBHbzdLUBttJn3lEvRKQ301bB6R4fOyyn0Ywt7qkpp6sWo4fTQGAci64axAuPj3EhMeHM7BdFkX4L8KbNlTWQ+zK2+5kefvu+WLuIagA2v8Kjyp12Gp/xKDPe7Ab6uTyXgkAQeR66pfzqQbdP/JPifN5/Yj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RC/JNjOg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-290d48e9f1fso205565ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761235745; x=1761840545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DD2FrCR3h7s6+/jsUTtH0YJbnzDwL7eNDOT6HMeIno=;
        b=RC/JNjOgm05YAUJPBXCD9Dfg7J5D+NfWFiOYy0tM2iQtTLKe0f8SVPLPenMX6qMTub
         pQ91uEAdlp+l0B8AkdzG74TYyf2HBozh9rpnCRfKUfo14xWS9hKgqzu7O7O20+OgurUa
         ZZhT+vtzL5JFPrAk5RZ7dkMLd4mm+kKRkSnxBDqaUbAENU8r4Ozml6fcx88iqevBTs/9
         KkpdEnxIb7BK2dgDXtgDO9BYVeMx2AOczyRtct6QFowgPrCCHp+Ki8J24reDOYPWzQ02
         PDliRe5DY4j/vt63eeTSlHTLiG6tiUWLFM8m2Nab6RkHL1vtgE9lLBi2WKJIlIdE1NN7
         rkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761235745; x=1761840545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DD2FrCR3h7s6+/jsUTtH0YJbnzDwL7eNDOT6HMeIno=;
        b=hcMherY1QFg1PiLFV65VzKejP+fWApgMhQyx2qLTRJuj8fiAj5+G8nLFRP+QTuVqFh
         i5CvBmJZrzLoq6F/PIk+s2y6bFDEy9gKQhRwZ8YNgJDFZU1gAS/+r5Hd1/KdFTt7yNGM
         c51gc5FOQT9C3nHBZ9yOBOVPH5WRZDfrijVhMKUEpJ5SdvGD8Yq6Q0rrPEBr6k3vfAuN
         e070FZaj0sAsXwoE2vuksvfmBwNZxkp+ndVBn8628mL4ftqEGI8ZOtQeTm3B89U2pOFF
         GttB6PCMsjtH4vLvPFplE7o0S2wyAUclAINQmf7UtOB+SsPcGmEL4QcN6yQvTGsTgWjq
         oSoA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ziV0w1CfPGMuw0zw1Sh/qc98CbMsbEQMPgCkQAyEYLNSelTK7YrIfsfIivN2eaqAZosnTagmnLwAnmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv6VbQ3EHb8K/pnOjnG7Q3winXEWchwN6q0hOeb5739LRPE1ca
	tPZjMiEQ+vISglMDinjYuKEa8k3wd0RNEpptoZ9Yt/4pVnXTNa1mw9T8OT+5tQzgUr/Ypz0Z1zt
	+sPJcrO6vYMtX3KgbDe6HP9x4MaQ9ws1UiaMH/4Zm
X-Gm-Gg: ASbGncu4tW3hYk6nU1htEZPWLHyOC8RBvsVw1T7MGsPMdAG1VOrGbWI4rFY1E6NA5mO
	yEpg/t3ntFAuuQMUKKAIIqRaFjAwPDKi1pR7FmY5tBAJVnTbgYSnHLAwoU//YcPiMKHKMc65lmD
	UwJwTtfnzGPM8CqVmnRazuf5/h77LWTMnRPIub6YD0nB43BB9bz+Zey/6CLrjEsa7r2KOSR4sIy
	gUsM2vO0eWb/E7vaxamuq9XQO+m7vTOLei3eQ5rhM22N0TlWODLviFnbd+QygNXQG+b3uishhWk
	FzfCXaHZya3ISrw=
X-Google-Smtp-Source: AGHT+IFm2MFLeK85YermsOMu5zYpTpjbtEK4xI00o5TLBfizVMtB0lHY5AA/2uze9+mJDbIqCwZ3M48UjYiYnpTrzDk=
X-Received: by 2002:a17:903:1c2:b0:290:dc44:d6fa with SMTP id
 d9443c01a7336-29487303b51mr523455ad.16.1761235744060; Thu, 23 Oct 2025
 09:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20251023015043.38868-1-xueshuai@linux.alibaba.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Oct 2025 09:08:52 -0700
X-Gm-Features: AS18NWDd7pnd6R6MJu2L_vLKwKGtCotRaE8bGYrXMIICN6v6EliIOYkLKsl-DF8
Message-ID: <CAP-5=fWupb62_QKM3bZO9K9yeJqC2H-bdi6dQNM7zAsLTJoDow@mail.gmail.com>
Subject: Re: [PATCH] perf record: skip synthesize event when open evsel failed
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: alexander.shishkin@linux.intel.com, peterz@infradead.org, 
	james.clark@arm.com, leo.yan@linaro.org, mingo@redhat.com, 
	baolin.wang@linux.alibaba.com, acme@kernel.org, mark.rutland@arm.com, 
	jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 6:50=E2=80=AFPM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
> When using perf record with the `--overwrite` option, a segmentation faul=
t
> occurs if an event fails to open. For example:
>
>   perf record -e cycles-ct -F 1000 -a --overwrite
>   Error:
>   cycles-ct:H: PMU Hardware doesn't support sampling/overflow-interrupts.=
 Try 'perf stat'
>   perf: Segmentation fault
>       #0 0x6466b6 in dump_stack debug.c:366
>       #1 0x646729 in sighandler_dump_stack debug.c:378
>       #2 0x453fd1 in sigsegv_handler builtin-record.c:722
>       #3 0x7f8454e65090 in __restore_rt libc-2.32.so[54090]
>       #4 0x6c5671 in __perf_event__synthesize_id_index synthetic-events.c=
:1862
>       #5 0x6c5ac0 in perf_event__synthesize_id_index synthetic-events.c:1=
943
>       #6 0x458090 in record__synthesize builtin-record.c:2075
>       #7 0x45a85a in __cmd_record builtin-record.c:2888
>       #8 0x45deb6 in cmd_record builtin-record.c:4374
>       #9 0x4e5e33 in run_builtin perf.c:349
>       #10 0x4e60bf in handle_internal_command perf.c:401
>       #11 0x4e6215 in run_argv perf.c:448
>       #12 0x4e653a in main perf.c:555
>       #13 0x7f8454e4fa72 in __libc_start_main libc-2.32.so[3ea72]
>       #14 0x43a3ee in _start ??:0
>
> The --overwrite option implies --tail-synthesize, which collects non-samp=
le
> events reflecting the system status when recording finishes. However, whe=
n
> evsel opening fails (e.g., unsupported event 'cycles-ct'), session->evlis=
t
> is not initialized and remains NULL. The code unconditionally calls
> record__synthesize() in the error path, which iterates through the NULL
> evlist pointer and causes a segfault.
>
> To fix it, move the record__synthesize() call inside the error check bloc=
k, so
> it's only called when there was no error during recording, ensuring that =
evlist
> is properly initialized.
>
> Fixes: 4ea648aec019 ("perf record: Add --tail-synthesize option")
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

This looks great! I wonder if we can add a test, perhaps here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next#n435
something like:
```
$ perf record -e foobar -F 1000 -a --overwrite -o /dev/null -- sleep 0.1
```
in a new test subsection for test_overwrite? foobar would be an event
that we could assume isn't present. Could you help with a test
covering the problems you've uncovered and perhaps related flags?

Thanks,
Ian

> ---
>  tools/perf/builtin-record.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index d76f01956e33..b1fb87016d5a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -2883,11 +2883,11 @@ static int __cmd_record(struct record *rec, int a=
rgc, const char **argv)
>                 rec->bytes_written +=3D off_cpu_write(rec->session);
>
>         record__read_lost_samples(rec);
> -       record__synthesize(rec, true);
>         /* this will be recalculated during process_buildids() */
>         rec->samples =3D 0;
>
>         if (!err) {
> +               record__synthesize(rec, true);
>                 if (!rec->timestamp_filename) {
>                         record__finish_output(rec);
>                 } else {
> --
> 2.39.3
>

