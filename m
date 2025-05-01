Return-Path: <linux-kernel+bounces-628145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 059C3AA59A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 04:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DF31C043BF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 May 2025 02:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715122F77D;
	Thu,  1 May 2025 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng1gdj+m"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FDC2ED;
	Thu,  1 May 2025 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746066494; cv=none; b=MOrGS3h/yUR6laHgm7MC6zgyIkqChJwMYyxhPXIfF8e0M5JFPN+hxL5P7L55V9fYhJ4kjLaRGi575dqasT93qBu6drdzMAzl1kvmenuvpRewpIkQikepA+xFPGuHij4/IvdZDpcjy9DIPZIfXyGP5Xus0ocq3bPhmtxhAUQRxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746066494; c=relaxed/simple;
	bh=KS3jY52pNk1u+R98uW2AGXONrX6SST8hjjbpixLZpKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ehk+KIFAObSEiyUBMC8TdxL46hXiQb/jqno7F5CG+MQ1xN07YTOR/brwZszimXUdr+OszmUULTO03bPYlGTW1MXpf9LEmrvh0calvP/8xqm5WdohfTVxX8jjUGtfyfnGtBXfLpKro/0mCRqlk7SHjy3rUw7JBQioEaya4GR/r/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng1gdj+m; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376e311086so812058b3a.3;
        Wed, 30 Apr 2025 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746066492; x=1746671292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wuDFqbRXFCtvuYfSRoxmShCxI97f/W/BJry3BtFDZOg=;
        b=ng1gdj+mqFN6tP4buTJ9CHnczTLYgek1GopixjC4+sZun7SgWoAB0shdGNofnKlG2I
         K78/8g8fF6cV0Lx2Lrwmup8Nc7Le/IqQD9Q1Gy89p0i5Q6zDLrWy1IB8/LK2kpT2WY61
         GVHlqdQ3tXnnSjoc+sRp0J0bc2r27C7wiepYfLR9I5KHMLdd3A39kmmD6P7AFeIuEBWw
         UX+Ub4n6bu1Bho+W6kA910vdU9EOsk0xNBAT+NxXp4NChhIOOopXsEW5PfxJM1Yo1BZN
         KnbtE4pEvGTnvRTI4vLxBhI8g1jxIhDq3tj6MIFpb2E2CNIFco15ws4dzlhrjl7T5P6N
         F2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746066492; x=1746671292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuDFqbRXFCtvuYfSRoxmShCxI97f/W/BJry3BtFDZOg=;
        b=JKLjYpiR3AWjiSUxffEgwLVhX9rWSH75z94m0mmMD847JLen/w7BZn7UZyV/6BJYa8
         0OXVsZCUREKw3l0SzxIe2IYICfYzkPklr4skdjIe99tBQmmEbPeayikICP6dzXi2pQJu
         ixJYGldvI/9VM/k6ajvRMkuagYKCpWjw2V5X7U8ZYnZPy+2BxSAZkOyxaiEoVXqpaswf
         CkSd6WzNmhw/kk+/B6M30+pwiiDRwq5vVpqdM+8Pu9yFotiUwn3WRrWbEenw0Dz4tJDh
         m36N0pVyRbEZFEt46oOwEK2QLKQsLgUSQNAb5WBtrYkH6qrRU/5/s96raANyY1hj0bpT
         LCcA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Xo5O7PCS3KsElsUYukjP7vyxR2+Ziq8E+j8SFMV8yXTn7LidTJ4DG6cVvAUiy2XVKX7cL0ROonVJ7MiBkZn1tA==@vger.kernel.org, AJvYcCU8ygDXWaStrv3WFadbkXHMsH8WttQDawPgbt6C2jY9o2Bn8N3jb+4vcCvYl6mmrjopey5DNB4QNeFDkKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpVNH3PRwmiiUc0gdCFyyepd7bxZGQu/oLqrf0UfqW9s+VbW5
	dCDI8zKcPnEXPc1f3rlVZAEyYU3pHqRZQo4UzkY1qvnSTCifqkMA
X-Gm-Gg: ASbGncu3jMSeHUqwfaowlEiafqC7ixCqHQInB0JyIk8XStNdAIGmyKxjYmb+Zm1I+9X
	4GhOebe9JZhDxuFs3TDdbRV1YFg0GmPm7ixbUqy+S0fhzlSeHzyM483j1Yi0qQKfpzTf7u24peo
	JCe3X29U5TWNN1jB3Tc4uaUG7kUHKOO9KuwZPh66RImusOy8YnEJy4K6nrqOg0fNNY+lOZ58B+z
	z8ntsFVQlIbCqh0VEq+VgEHC0DWVbm6UyU6DWVBijGTWroOjK0AqisICxQQqVV+OTvJYQvYto0T
	Jw3geRVNC3acL/NdhUGGdXWGlAu9hcSRpStzMvbdvObzdUj/fqN6ErX1Q/5VA2Trf536s9VDQi3
	gCRqYoflcyMng9D58yFhR
X-Google-Smtp-Source: AGHT+IHSUuYkAEPRGmBH60fgQ/qhdV9lXL7ezCt14vJXCVSitBPDLh7ivb0/DiM4akorhIqk6GPFbg==
X-Received: by 2002:a05:6a00:4653:b0:736:4b85:ee05 with SMTP id d2e1a72fcca58-740491e5825mr1164872b3a.11.1746066492303;
        Wed, 30 Apr 2025 19:28:12 -0700 (PDT)
Received: from howard-ubuntu.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a8fbe7sm2459599b3a.160.2025.04.30.19.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 19:28:11 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gautam@linux.ibm.com,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v16 00/10] perf record --off-cpu: Dump off-cpu samples directly
Date: Wed, 30 Apr 2025 19:27:58 -0700
Message-ID: <20250501022809.449767-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As mentioned in: https://bugzilla.kernel.org/show_bug.cgi?id=207323

Currently, off-cpu samples are dumped when perf record is exiting. This
results in off-cpu samples being after the regular samples. This patch
series makes possible dumping off-cpu samples on-the-fly, directly into
perf ring buffer. And it dispatches those samples to the correct format
for perf.data consumers.

Before:
```
     migration/0      21 [000] 27981.041319: 2944637851    cycles:P:  ffffffff90d2e8aa record_times+0xa ([kernel.kallsyms])
            perf  770116 [001] 27981.041375:          1    cycles:P:  ffffffff90ee4960 event_function+0xf0 ([kernel.kallsyms])
            perf  770116 [001] 27981.041377:          1    cycles:P:  ffffffff90c184b1 intel_bts_enable_local+0x31 ([kernel.kallsyms])
            perf  770116 [001] 27981.041379:      51611    cycles:P:  ffffffff91a160b0 native_sched_clock+0x30 ([kernel.kallsyms])
     migration/1      26 [001] 27981.041400: 4227682775    cycles:P:  ffffffff90d06a74 wakeup_preempt+0x44 ([kernel.kallsyms])
     migration/2      32 [002] 27981.041477: 4159401534    cycles:P:  ffffffff90d11993 update_load_avg+0x63 ([kernel.kallsyms])

sshd  708098 [000] 18446744069.414584:     286392 offcpu-time: 
	    79a864f1c8bb ppoll+0x4b (/usr/lib/libc.so.6)
	    585690935cca [unknown] (/usr/bin/sshd)
```

After:
```
            perf  774767 [003] 28178.033444:        497           cycles:P:  ffffffff91a160c3 native_sched_clock+0x43 ([kernel.kallsyms])
            perf  774767 [003] 28178.033445:     399440           cycles:P:  ffffffff91c01f8d nmi_restore+0x25 ([kernel.kallsyms])
         swapper       0 [001] 28178.036639:  376650973           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
         swapper       0 [003] 28178.182921:  348779378           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
    blueman-tray    1355 [000] 28178.627906:  100184571 offcpu-time: 
	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
	    7fff24e862d8 [unknown] ([unknown])


    blueman-tray    1355 [000] 28178.728137:  100187539 offcpu-time: 
	    7528eef1c39d __poll+0x4d (/usr/lib/libc.so.6)
	    7528edf7d8fd [unknown] (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528edf1af95 g_main_context_iteration+0x35 (/usr/lib/libglib-2.0.so.0.8000.2)
	    7528eda4ab86 g_application_run+0x1f6 (/usr/lib/libgio-2.0.so.0.8000.2)
	    7528ee6aa596 [unknown] (/usr/lib/libffi.so.8.1.4)
	    7fff24e862d8 [unknown] ([unknown])


         swapper       0 [000] 28178.463253:  195945410           cycles:P:  ffffffff91a1ae99 intel_idle+0x59 ([kernel.kallsyms])
     dbus-broker     412 [002] 28178.464855:  376737008           cycles:P:  ffffffff91c000a0 entry_SYSCALL_64+0x20 ([kernel.kallsyms])
```

Changes in v16:
 - Add Tested-by from Gautam and Acked-by from Namhyung.
 - Rebase on the perf-tools-next branch.
 - Edit the commit message of patch 10.
 - Fix a bug caused by the type change of struct perf_cpu.
 - Rename test_offcpu_over_thresh() to test_offcpu_above_thresh().

Changes in v15:
 - Fix workload recording bug pointed out by Arnaldo.
 - Rename struct stack to struct __stack as suggested by Arnaldo.
 - Delete the extra offcpu workload now that recording workload is fixed,
   use 'sleep 1' for testing instead.
 - Add more tests for the off-cpu-thresh option.

Changes in v14:
 - Change the internal off_cpu_thresh_us to off_cpu_thresh_ns, i.e. use
   nsec instead of usec

Changes in v13:
 - Move the definition of 'off_cpu_thresh_ns' to the same commit as
   dumping off-cpu samples in BPF, and give off_cpu_thresh_ns a default
   value before the --off-cpu-thresh option is parsed.

Changes in v12:
 - Restore patches' bisectability, because the ordering of patches has
   changed.
 - Change 'us = ms * 1000' to 'us = ms * USEC_PER_MSEC'

Changes in v11:
 - Modify the options used in the off-cpu tests, as I changed the unit
   of the off-cpu threshold to milliseconds.

Changes in v10:
 - Move the commit "perf record --off-cpu: Add --off-cpu-thresh option"
   to where the direct sample feature is completed.
 - Make --off-cpu-thresh use milliseconds as the unit.

Changes in v9:
 - Add documentation for the new option '--off-cpu-thresh', and include
   an example of its usage in the commit message
 - Set inherit in evsel__config() to prevent future modifications
 - Support off-cpu sample data collected by perf before this patch series

Changes in v8:
 - Make this series bisectable
 - Rename off_cpu_thresh to off_cpu_thresh_us and offcpu_thresh (in BPF)
   to offcpu_thresh_ns for clarity
 - Add commit messages to 'perf evsel: Expose evsel__is_offcpu_event()
   for future use' commit
 - Correct spelling mistakes in the commit message (s/is should be/should be/)
 - Add kernel-doc comments to off_cpu_dump(), and comments to the empty
   if block
 - Add some comments to off-cpu test
 - Delete an unused variable 'timestamp' in off_cpu_dump()

Changes in v7:
 - Make off-cpu event system-wide
 - Use strtoull instead of strtoul
 - Delete unused variable such as sample_id, and sample_type
 - Use i as index to update BPF perf_event map
 - MAX_OFFCPU_LEN 128 is too big, make it smaller.
 - Delete some bound check as it's always guaranteed
 - Do not set ip_pos in BPF
 - Add a new field for storing stack traces in the tstamp map
 - Dump the off-cpu sample directly or save it in the off_cpu map, not both
 - Delete the sample_type_off_cpu check
 - Use __set_off_cpu_sample() to parse samples instead of a two-pass parsing

Changes in v6:
 - Make patches bisectable

Changes in v5:
 - Delete unnecessary copy in BPF program
 - Remove sample_embed from perf header, hard code off-cpu stuff instead
 - Move evsel__is_offcpu_event() to evsel.h
 - Minor changes to the test
 - Edit some comments

Changes in v4:
 - Minimize the size of data output by perf_event_output()
 - Keep only one off-cpu event
 - Change off-cpu threshold's unit to microseconds
 - Set a default off-cpu threshold
 - Print the correct error message for the field 'embed' in perf data header

Changes in v3:
 - Add off-cpu-thresh argument
 - Process direct off-cpu samples in post

Changes in v2:
 - Remove unnecessary comments.
 - Rename function off_cpu_change_type to off_cpu_prepare_parse

Howard Chu (10):
  perf evsel: Expose evsel__is_offcpu_event() for future use
  perf record --off-cpu: Parse off-cpu event
  perf record --off-cpu: Preparation of off-cpu BPF program
  perf record --off-cpu: Dump off-cpu samples in BPF
  perf evsel: Assemble offcpu samples
  perf record --off-cpu: Disable perf_event's callchain collection
  perf script: Display off-cpu samples correctly
  perf record --off-cpu: Dump the remaining samples in BPF's stack trace
    map
  perf record --off-cpu: Add --off-cpu-thresh option
  perf test: Add direct off-cpu tests

 tools/perf/Documentation/perf-record.txt |   9 ++
 tools/perf/builtin-record.c              |  33 +++++++
 tools/perf/builtin-script.c              |   4 +-
 tools/perf/tests/shell/record_offcpu.sh  |  71 ++++++++++++++
 tools/perf/util/bpf_off_cpu.c            | 119 ++++++++++++++---------
 tools/perf/util/bpf_skel/off_cpu.bpf.c   |  98 ++++++++++++++++++-
 tools/perf/util/evsel.c                  |  41 +++++++-
 tools/perf/util/evsel.h                  |   2 +
 tools/perf/util/off_cpu.h                |   3 +-
 tools/perf/util/record.h                 |   1 +
 10 files changed, 324 insertions(+), 57 deletions(-)

-- 
2.45.2


