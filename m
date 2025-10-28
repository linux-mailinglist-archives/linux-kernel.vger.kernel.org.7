Return-Path: <linux-kernel+bounces-873518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1396AC141E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 284F24E9863
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65D302779;
	Tue, 28 Oct 2025 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2rsvr3B"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209E82E6CD2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647622; cv=none; b=Ch6ap0IHG7z5TdyinzB5NXkiTW+qcz5/1XjuFjqfZT5Z+Sqovy3cJvYPzUUzBzlUhcE4TuQmVrt6mf2IAESgWUSdUke/HP0HW73IpEW3En89eOWpbLyFe3Y/tG82qNNcg5pqFuTEwWGC7jiMh2SJfOXQ9ZV7c+I+Flpsuq7c8jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647622; c=relaxed/simple;
	bh=jfnXEYrHXZSPtQmk7wsHM/xN8Pr2jjG6r0cZoWL4ZjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekUcKGdT9bqxjbYW5yGKaEyxbFhe6LhWEJDDMsrCch3dPqemxpIOZNKOkJIs4/bPeKur/rC3irnDC+YbwnKmmgOwO0HDCEdtsQgy8cPgNrGFvFToXw9ZOkp0R1dKSuFSBjiZS4QuDo6PhMTXhjWN8rxPePXBmeoPqjl7A7xJcIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R2rsvr3B; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so4000574f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761647617; x=1762252417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cki6A/3DOrWXLjn1KekLtiW9w70bgZ5ARJRJ40RY+CQ=;
        b=R2rsvr3Bzz1cqIbH0PZ1e2XYk9fJhp9wMrr6qhi/9EHg+PYBohD75vN3++yn5Eawpu
         i3sCNE/yS066r4Ues3wKoIUNoG01I1/t4kWrfKIdeCGV0DM59NTiZ42wYP2DBE7OByLZ
         C5mvcNoKOrqU8owjNclWFG7OSF1eyesZAIE3B5chHdEZV5lTcQK2t9mHo0T4hPMCjU14
         cKVn5h4oaQffMkU6/8tUZ1EpZAsVF5W+L44KbNVZlCPqPAEgmf1QJZ5QpFPDcpTOFFc1
         p/8XjdFI9M3kfLqpQ6JXJgPaJ3VSb/v1njbSzfwPxHQTfbuM6DjAk4k/PnUtnO2/PXmc
         3kWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761647617; x=1762252417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cki6A/3DOrWXLjn1KekLtiW9w70bgZ5ARJRJ40RY+CQ=;
        b=lOXdEQ3+FJD8TuQjEz0rFSP9WJz8IJdU6Cah8x2Z3MPqvTjGVFrFZykGufinSEo1hq
         525lqEJqQm1St8kYJA0YSni4UeHa/qqsYIewng+ME9IrYwPdocjJqWbbwloPz0iytOnL
         hyBPtj7/XtOXV02bz3a79OgFq38ZTk2V/Iq96OVF02/n+9UMxjBX/LAEreNoX5rjjAjP
         hWCUm3+HzNoPR+DyxKIamItV6X94Dojv2kUNyrVYL6VrMA3+u/KwDLWLKyppk7SAfnIc
         g+44EX45GKQP4Z4L7l9gh6C+rXpO9JAuRBroillOOQmRQlmVSn2krD5ZakgptqYHAvVU
         ZPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWXoXcynmioFr7eCu545wUWi1F1t0QmWezVwchpThYohMSexQL5DnGB8AJHfcuZS11xOSXynn9h1ftRlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv59NUDkpQzm/Q2sxGn+uMGtp+nlqu0E/bmBRleIrDqGYbNjka
	ubPrWuYltJZ8cdgUDgnjkAr7Nu93wCxMi39YdJfc7u+ZmZsSpBg6LF7oxhou34j0XjQ=
X-Gm-Gg: ASbGncuAni8+6q9z4hKYMTAhVRqVYxiaq/DPe7yybKyMZu1Zl7t/lSVdlO5IPTEmEJT
	1cjT/5bbBix7nWrw96Zj62hdN4tku5WMkvUwkzxEOkZaZ5CcBU5+3QLDzBbK7La38j/gMESyWl7
	a/Zg2/YjWoOJ//np3mGmVhX1T6rshds8WaDjI/0b1ofRHZrvJwTy4e8Cjm1IhvA36B2+3so4pW4
	n2lmIEdDtElCsdTeGPdBuqAXcjZnYgqm1C+LdphpLAMyPGbCZ/+warIor7/JzAyQAFPs9h1ICMS
	uqAMmiTcTelHgyCc4M3BAIyTTnS1ShldYHyoSbMluoWTncJA44ABjKp/J2GowfV1EVbV+NSn5uQ
	RzgfOi0ePe3vTDsP9I5OZFgRKu21BIT2M42XqerlMKY0HLAMLoZPBg1LM7KnINzc3GGT5gEWV5t
	SjSIUrnA==
X-Google-Smtp-Source: AGHT+IFCUgcaVi5csDzOmM6gRSPXUaNzMWqWGnHVf7wRbZPsIEmEq7Xm+UHnjx1AZJXjLSFKzZVqnA==
X-Received: by 2002:a05:6000:2c13:b0:427:167:c2c3 with SMTP id ffacd0b85a97d-429a7e9327amr2062485f8f.48.1761647617367;
        Tue, 28 Oct 2025 03:33:37 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm22789655f8f.5.2025.10.28.03.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 03:33:36 -0700 (PDT)
Message-ID: <17f00d4d-5cbf-4c9c-a51a-f0ae34f181cf@linaro.org>
Date: Tue, 28 Oct 2025 10:33:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf dsos: Don't block when reading build IDs
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
 <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com>
 <aP1kSdZJKYIpnRia@google.com>
 <CAP-5=fUiO1uypnsw=G-FFj0xE=uCowG5FetaC9JGygOxybuGGA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUiO1uypnsw=G-FFj0xE=uCowG5FetaC9JGygOxybuGGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/10/2025 4:52 am, Ian Rogers wrote:
> On Sat, Oct 25, 2025 at 4:59 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Fri, Oct 24, 2025 at 11:26:18AM -0700, Ian Rogers wrote:
>>> On Wed, Oct 22, 2025 at 8:46 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> The following command will hang consistently when the GPU is being used
>>>> due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2)
>>>> being opened to read build IDs:
>>>>
>>>>   $ perf record -asdg -e cpu-clock -- true
>>>>
>>>> Change to non blocking reads to avoid the hang here:
>>>>
>>>>    #0  __libc_pread64 (offset=<optimised out>, count=0, buf=0x7fffffffa4a0, fd=237) at ../sysdeps/unix/sysv/linux/pread64.c:25
>>>>    #1  __libc_pread64 (fd=237, buf=0x7fffffffa4a0, count=0, offset=0) at ../sysdeps/unix/sysv/linux/pread64.c:23
>>>>    #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
>>>>    #3  read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:880
>>>>    #4  filename__read_build_id (filename=0x5555562df333 "/dev/dri/card2", bid=0x7fffffffb680, block=true) at util/symbol-elf.c:924
>>>>    #5  dsos__read_build_ids_cb (dso=0x5555562df1d0, data=0x7fffffffb750) at util/dsos.c:84
>>>>    #6  __dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:59
>>>>    #7  dsos__for_each_dso (dsos=0x55555623de68, cb=0x5555557e7030 <dsos__read_build_ids_cb>, data=0x7fffffffb750) at util/dsos.c:503
>>>>    #8  dsos__read_build_ids (dsos=0x55555623de68, with_hits=true) at util/dsos.c:107
>>>>    #9  machine__read_build_ids (machine=0x55555623da58, with_hits=true) at util/build-id.c:950
>>>>    #10 perf_session__read_build_ids (session=0x55555623d840, with_hits=true) at util/build-id.c:956
>>>>    #11 write_build_id (ff=0x7fffffffb958, evlist=0x5555562323d0) at util/header.c:327
>>>>    #12 do_write_feat (ff=0x7fffffffb958, type=2, p=0x7fffffffb950, evlist=0x5555562323d0, fc=0x0) at util/header.c:3588
>>>>    #13 perf_header__adds_write (header=0x55555623d840, evlist=0x5555562323d0, fd=3, fc=0x0) at util/header.c:3632
>>>>    #14 perf_session__do_write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true, fc=0x0, write_attrs_after_data=false) at util/header.c:3756
>>>>    #15 perf_session__write_header (session=0x55555623d840, evlist=0x5555562323d0, fd=3, at_exit=true) at util/header.c:3796
>>>>    #16 record__finish_output (rec=0x5555561838d8 <record>) at builtin-record.c:1899
>>>>    #17 __cmd_record (rec=0x5555561838d8 <record>, argc=2, argv=0x7fffffffe320) at builtin-record.c:2967
>>>>    #18 cmd_record (argc=2, argv=0x7fffffffe320) at builtin-record.c:4453
>>>>    #19 run_builtin (p=0x55555618cbb0 <commands+288>, argc=9, argv=0x7fffffffe320) at perf.c:349
>>>>    #20 handle_internal_command (argc=9, argv=0x7fffffffe320) at perf.c:401
>>>>    #21 run_argv (argcp=0x7fffffffe16c, argv=0x7fffffffe160) at perf.c:445
>>>>    #22 main (argc=9, argv=0x7fffffffe320) at perf.c:553
>>>>
>>>> Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>> I'm not actually sure if this is the right fix for this. Commit
>>>> 2c369d91d093 ("perf symbol: Add blocking argument to
>>>> filename__read_build_id") which added the blocking argument says that it
>>>> should be non-blocking reads for event synthesis, but the callstack here
>>>> is when writing the header out.
>>>>
>>>> There was also an is_regular_file() check added in commit c21986d33d6b
>>>> ("perf unwind-libdw: skip non-regular files"), which presumably falls
>>>> afoul of the "which unfortunately fails for symlinks" part of the other
>>>> linked commit message?
>>>>
>>>> So I can't tell if we should add the is_regular_file() check here too,
>>>> or just set it to non-blocking, or it needs some extra state to be
>>>> passed all the way down to dsos__read_build_ids_cb() to do different
>>>> things.
>>>
>>> The fix lgtm but I worry about making all the build ID reading
>>> non-blocking meaning build IDs getting lost.
>>
>> I'm not sure what non-blocking means for regular file system operations
>> on a block device.  But it may have some impact on regular files on a
>> network filesystem.

It depends on the filesystem, but I think the assurances given by 
O_NONBLOCK are very weak anyway. It can be practically ignored or do 
different things in different situations. Especially as we don't handle 
EAGAIN or do anything fancy we shouldn't use it.

For our case it looks like we should always do blocking reads but make 
sure to not open a non-regular file.

> 
> Agreed. Prior to using blocking we tried to imply from the file type
> from stat, but that skipped things like symlinks :-/
> 

Am I missing something here? is_regular_file() uses stat() which returns 
info about the target file, rather than the symlink, so they wouldn't be 
skipped. lstat() is the one that returns info about the link file.

I tested is_regular_file() with links, links to links, pipes, files and 
devices and it works as expected and would avoid the need to use O_NONBLOCK.

James

>>> It seems that generating
>>> the build ID feature table is unnecessary if we have build ID mmap
>>> events, including synthesized ones that will have read the build IDs.
>>> I wonder if a better "fix" is:
>>> ```
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index cb52aea9607d..15f75c70eb76 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -1842,7 +1842,7 @@ static void record__init_features(struct record *rec)
>>>         for (feat = HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat++)
>>>                 perf_header__set_feat(&session->header, feat);
>>>
>>> -       if (rec->no_buildid)
>>> +       if (rec->no_buildid || rec->buildid_mmap)
>>>                 perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
>>>
>>>         if (!have_tracepoints(&rec->evlist->core.entries))
>>> ```
>>> that should disable the build ID feature table generation when build
>>> ID mmaps are in use (the default). Having the build IDs twice in the
>>> data file feels redundant. Or we could do your fix or both, wdyt?
>>
>> I'm ok to remove the header feature but I think it should update
>> build-ID cache even with this change.
> 
> Yeah, dropping the feature writing also impacts updating the build ID
> cache because:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/header.c?h=perf-tools-next#n338
> It is kind of strange that writing a header feature does this. What if
> I want to write a header with build IDs but not update the cache? It'd
> make more sense, I think, for perf_session__cache_build_ids to be
> called explicitly. There is also the global no_buildid_cache
> controlling behavior:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/build-id.c?h=perf-tools-next#n43
> But that's kind of a hack as we may have >1 session such as with TPEBS.
> 
>> I'm also curious if the device has samples actually.  It should be
>> checked by dso->hit.
> 
> In this case the header writing is happening after the samples have
> been processed, but it looks like marking of samples doesn't consider
> data addresses:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/build-id.c?h=perf-tools-next#n55
> just sample->ip and the callchain. If the marking was updated for data
> pages then just writing build IDs for marked dsos would make sense.
> There could be callers not marking dsos so they'd need altering, or
> two versions of the code.
> 
> Thanks,
> Ian
> 
>> Thanks,
>> Namhyung
>>
>>>
>>> Thanks,
>>> Ian
>>>
>>>> ---
>>>>   tools/perf/util/dsos.c | 5 +++--
>>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
>>>> index 64c1d65b0149..5e1c815d7cb0 100644
>>>> --- a/tools/perf/util/dsos.c
>>>> +++ b/tools/perf/util/dsos.c
>>>> @@ -81,13 +81,14 @@ static int dsos__read_build_ids_cb(struct dso *dso, void *data)
>>>>                  return 0;
>>>>          }
>>>>          nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
>>>> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/true) > 0) {
>>>> +       /* Don't block in case path isn't for a regular file. */
>>>> +       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=*/false) > 0) {
>>>>                  dso__set_build_id(dso, &bid);
>>>>                  args->have_build_id = true;
>>>>          } else if (errno == ENOENT && dso__nsinfo(dso)) {
>>>>                  char *new_name = dso__filename_with_chroot(dso, dso__long_name(dso));
>>>>
>>>> -               if (new_name && filename__read_build_id(new_name, &bid, /*block=*/true) > 0) {
>>>> +               if (new_name && filename__read_build_id(new_name, &bid, /*block=*/false) > 0) {
>>>>                          dso__set_build_id(dso, &bid);
>>>>                          args->have_build_id = true;
>>>>                  }
>>>>
>>>> ---
>>>> base-commit: a1d8548c23076c66d96647f5f6f25aa43567f247
>>>> change-id: 20251022-james-perf-fix-dso-block-ca1d8437bbc0
>>>>
>>>> Best regards,
>>>> --
>>>> James Clark <james.clark@linaro.org>
>>>>


