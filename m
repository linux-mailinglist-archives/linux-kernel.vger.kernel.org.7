Return-Path: <linux-kernel+bounces-645652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC5AB5119
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EECE7B6AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 10:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A323C8B3;
	Tue, 13 May 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCQ+vAGX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D323C4EF
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130716; cv=none; b=kap+xqTihkAGFdyP0ALMzDsUZbgtdosN1B5gzOLV+Oyo2mhQmtt2x3wjrpTAqPNOYyeumtIPiZmrENiFe/Xb5eij90CilYrQjD5IQg7MzxDmJUWYrspXAJcP0SEK2RIUegoDsARPEwyBOGvZhEvwCL8j3/NzbNfsgYYxN9lIY3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130716; c=relaxed/simple;
	bh=YyD3v+WbDOQFTp5vyVVkGFcEv8zLO8rvXwKavSyvh2A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y9I80rFzYgUydWYdWCegZM4ulWTanBttl7lMzeabKZ1uU7jNotnCsm1J+UpAymBdO58wVzPDim5l4yYJGVPtmKW4nS8oN7qSVrUoaAwUXzEqTSKHOX/bgAPZf3HQ07H960Cl0yfI5Nx1WBMOohUT7A7ip9Xgtplp2Gi40GzEx9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HCQ+vAGX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so61518425e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747130712; x=1747735512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QhWWECWorCHcz5PzgCKOupXyhBCwucZ82R9EPkot+ts=;
        b=HCQ+vAGXLH6Klu2UDCbHFN3AoJpvYn9pJflm4owV2XNYZEAkExUGj0Nn27uvDWExP/
         +cUM1FxgxNqpv7edhP8FEX/Myl/HJz7rGy2BnGLKDhFRRlsKF+JloQD5fW3dvIud1m2l
         mxHS72ITUAXZSD8Vi/ohBFzNlZEQWj7nTJPdGsfcwPK4SGGZYslhq1pjidvIPL92Ih63
         W95AKBH9fJ5shK2jb48tM3M/AQT4qVcF7U7KyYz2MVBhYP3kYaAEeLaw8FfbXrxWVzJE
         0CpTl72/rlWxOueuEkmtGqBxy0Eb7/M+QKmRB6TH2UY1Ua3IoN9IEMycSdCt8nEDRMfr
         3hmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747130712; x=1747735512;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhWWECWorCHcz5PzgCKOupXyhBCwucZ82R9EPkot+ts=;
        b=gA/g6/loGXDDWDuMm1Dhi3IZCvPMqhkQtt8tflHwLxT3BAT43+SPMT6kxan1YgzcAP
         WO7qL5BYfiabpY/89ub0Jz57U33IbZ5pFnWhiYcJJ4BhzwNPayMHZqQKIUFtDTlbhvzq
         d3chcfMGW6KjKUx5iH6b8T+zW1uDPwyyyN/OQuGqfQUq46WUIHAPAu7mPk54A2zYSFd5
         B87TlnAU0anKe8vC+UlCpBzzkfX/EK8O6fJ2BA7levjifVWnXOjq2rok0BgYptV1vsCH
         KRAm06lzg0H7SMr+kDqS0G5+7aW2voM9x3HjcM/k+H4y2qq+0eWAyEFpUNfJaxCjcL/n
         C+eg==
X-Forwarded-Encrypted: i=1; AJvYcCVQYIT4DCfPCFxa8iCtyr7IXjYIlAj0yTSwzw35r9oZ7A173HwBW85+tThGAU6xDmB2ZKczcOd9saMIhzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEjjR/tRy9lO/XzLlTE1UkbrQnGgeKh+M+h8yk1CeJtza04R13
	wbd5SoBpR53VpnlUfEcLR8rVSJWB2gd5hw9pmEd7WzgnqzbS+Whs7Q8u3l14myA=
X-Gm-Gg: ASbGncujclTju1+sOBomxkBdM1mMCioXGKypybWTTmSBnARRTe9KHtUTEVOjieZtaUo
	H2r83F2oF2otK+R7hRQrS5OK7ffGTjZ6Otj/l+oZp8PlZf3io2AUI+0CAd4q1Y//9CaqoDjACAy
	lm9PWVp83YrevN1DILoGuhmge4cyC3rtakHd2O6SPbUC5hH1u3VxFzzho/cm0z3MSw1Gp+xgArG
	oUrU6SvEIvxwRJY5PC5bKYYqKh3ckWiR7+O1QPFAxx18CcUKXjAnPXiVqm5L8W9qqdiXQsznfIs
	XiG1tRZp8HR1ttmgIawQVRmmNkNwUlWcFhlxMIiO8/4m5aVXgT5OunWHVYSEhnQAf+WFr3Pvi1v
	ToUVVRg==
X-Google-Smtp-Source: AGHT+IGreNqiZTNFJYJ0Z2EWc1VR4VeNCPalaZtbjoH/OGKpMcfIXGmmyv6G5eCyqWl40Jr+k15oPA==
X-Received: by 2002:a05:600c:b85:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-442d6ddebf5mr145115085e9.30.1747130712234;
        Tue, 13 May 2025 03:05:12 -0700 (PDT)
Received: from [10.93.3.9] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d67df501sm157613475e9.12.2025.05.13.03.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 03:05:11 -0700 (PDT)
Message-ID: <de9470c6-de22-4136-b390-6dcc056495bd@linaro.org>
Date: Tue, 13 May 2025 11:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: make -C tools/perf build-test failing on aarch64
From: James Clark <james.clark@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <aB6vFFcRErPVt7p9@x1>
 <95bd54bf-09b7-4444-94a7-87ab9a3035e6@linaro.org>
Content-Language: en-US
In-Reply-To: <95bd54bf-09b7-4444-94a7-87ab9a3035e6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/05/2025 18:46, James Clark wrote:
> 
> 
> On 10/05/2025 2:42 am, Arnaldo Carvalho de Melo wrote:
>> Hi,
>>
>>     I noticed that upstream is failing on aarch64:
>>
>> acme@raspberrypi:~/git/perf-tools-next $ uname -a
>> Linux raspberrypi 6.12.25+rpt-rpi-2712 #1 SMP PREEMPT Debian 
>> 1:6.12.25-1+rpt1 (2025-04-30) aarch64 GNU/Linux
>> acme@raspberrypi:~/git/perf-tools-next $ grep -m1 Model /proc/cpuinfo
>> Model        : Raspberry Pi 5 Model B Rev 1.1
>> acme@raspberrypi:~/git/perf-tools-next $
>> acme@raspberrypi:~/git/perf-tools-next $ git log --oneline -1 ; time 
>> make -C tools/perf build-test
>> cd17a9b1a779 (HEAD -> perf-tools-next, number/perf-tools-next, 
>> number/HEAD) perf test demangle-ocaml: Switch to using 
>> dso__demangle_sym()
>> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
>> - tarpkg: ./tests/perf-targz-src-pkg .
>> make[1]: *** [tests/make:351: tarpkg] Error 2
>> make: *** [Makefile:109: build-test] Error 2
>> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
>>
>> real    0m12.130s
>> user    0m12.653s
>> sys    0m2.091s
>> acme@raspberrypi:~/git/perf-tools-next $
>>
>> I noticed that it is using some files from outside tools/, i.e. kernel
>> files, so I tried adding those (and its dependencies) to the
>> tools/perf/MANIFEST, but stumbled at this point:
>>
>> acme@raspberrypi:~/git/perf-tools-next $ git diff
>> diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
>> index 364b55b00b48..3fe627c4b599 100644
>> --- a/tools/perf/MANIFEST
>> +++ b/tools/perf/MANIFEST
>> @@ -28,3 +28,6 @@ scripts/bpf_doc.py
>>   tools/bpf/bpftool
>>   kernel/bpf/disasm.c
>>   kernel/bpf/disasm.h
>> +scripts/Kbuild.include
>> +scripts/Makefile.asm-headers
>> +include/uapi/asm-generic/Kbuild
>> acme@raspberrypi:~/git/perf-tools-next $
>>
>> To test it directly:
>>
>> acme@raspberrypi:~/git/perf-tools-next $ sh -x 
>> tools/perf/tests/perf-targz-src-pkg tools/perf
>> + set -e
>> + PERF=tools/perf
>> + cd tools/perf/../..
>> + make perf-targz-src-pkg
>>    ARCHIVE perf-6.15.0-rc5.tar.gz
>> + ls -rt perf-6.15.0-rc5.tar.gz
>> + TARBALL=perf-6.15.0-rc5.tar.gz
>> + mktemp -d
>> + TMP_DEST=/tmp/tmp.wzVpK2Gmvw
>> + tar xf perf-6.15.0-rc5.tar.gz -C /tmp/tmp.wzVpK2Gmvw
>> + rm -f perf-6.15.0-rc5.tar.gz
>> + cd -
>> + make -C /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf
>> make: Entering directory '/tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf'
>>    BUILD:   Doing 'make -j4' parallel build
>>
>> Auto-detecting system features:
>> ...                                   libdw: [ on  ]
>> ...                                   glibc: [ on  ]
>> ...                                  libelf: [ on  ]
>> ...                                 libnuma: [ on  ]
>> ...                  numa_num_possible_cpus: [ on  ]
>> ...                                 libperl: [ on  ]
>> ...                               libpython: [ on  ]
>> ...                               libcrypto: [ on  ]
>> ...                             libcapstone: [ on  ]
>> ...                               llvm-perf: [ on  ]
>> ...                                    zlib: [ on  ]
>> ...                                    lzma: [ on  ]
>> ...                               get_cpuid: [ OFF ]
>> ...                                     bpf: [ on  ]
>> ...                                  libaio: [ on  ]
>> ...                                 libzstd: [ on  ]
>>
>>    PERF_VERSION = 6.15.rc5.gcd17a9b1a779
>>    GEN     common-cmds.h
>>    GEN     
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/arch/arm64/include/generated/asm/sysreg-defs.h
>>    CC      jvmti/libjvmti.o
>>    GEN     perf-archive
>>    GEN     perf-iostat
>>    CC      dlfilters/dlfilter-test-api-v0.o
>>    CC      dlfilters/dlfilter-test-api-v2.o
>>    CC      dlfilters/dlfilter-show-cycles.o
>>    CC      jvmti/jvmti_agent.o
>>    CC      jvmti/libstring.o
>>    CC      jvmti/libctype.o
>>    MKDIR   /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fd/
>>    CC      
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fd/array.o
>> make[4]: *** No rule to make target 
>> '/tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libperf/arch/arm64/include/generated/uapi/asm/unistd_64.h'.  Stop.
>> make[3]: *** [Makefile:108: uapi-asm-generic] Error 2
>> make[2]: *** [Makefile.perf:973: 
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libperf/libperf.a] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>>    INSTALL 
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/cpu.h
>>    MKDIR   /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/
>>    MKDIR   /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/
>>    CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/fs.o
>>    CC      
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/tracing_path.o
>>    LD      jvmti/jvmti-in.o
>>    CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/cpu.o
>>    LD      
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fd/libapi-in.o
>>    CC      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/debug.o
>>    INSTALL 
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/debug.h
>>    INSTALL 
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/io.h
>>    INSTALL 
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/io_dir.h
>>    MKDIR   /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/
>>    CC      
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/cgroup.o
>>    CC      
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/str_error_r.o
>>    INSTALL 
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/fd/array.h
>>    INSTALL 
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/fs/fs.h
>>    INSTALL 
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/include/api/fs/tracing_path.h
>>    INSTALL libapi_headers
>>    LD      
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/fs/libapi-in.o
>>    LD      
>> /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/libapi-in.o
>>    AR      /tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf/libapi/libapi.a
>> make[1]: *** [Makefile.perf:290: sub-make] Error 2
>> make: *** [Makefile:76: all] Error 2
>> make: Leaving directory '/tmp/tmp.wzVpK2Gmvw/perf-6.15.0-rc5/tools/perf'
>> acme@raspberrypi:~/git/perf-tools-next $
>>
>> I think this is related to:
>>
>> commit bfb713ea53c746b07ae69fe97fa9b5388e4f34f9 (perf-tools)
>> Author: James Clark <james.clark@linaro.org>
>> Date:   Thu Apr 17 14:55:50 2025 +0100
>>
>>      perf tools: Fix arm64 build by generating unistd_64.h
>>
>> Can you please take a look?
>>
>> Thanks a lot,
>>
>> - Arnaldo
> 
> Hmm yeah looks like it's caused by that. I'm travelling tomorrow but 
> I'll try to take a look.
> 
> Thanks
> James
> 


Sent the fix, hopefully 3rd time lucky.

I know there is the build-test target but I had let my setup bitrot so I 
wasn't running it. I don't know if you have ever shared any of your 
docker containers that you use for build testing?

I will also try to get that target added to our CI. We're only running a 
normal build and then "perf test" there.

Thanks
James

