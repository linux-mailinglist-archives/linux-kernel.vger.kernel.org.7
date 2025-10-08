Return-Path: <linux-kernel+bounces-845339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E1EBC4834
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2DB19E178E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FC2F6561;
	Wed,  8 Oct 2025 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3pCEMDQ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA72F618F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759921813; cv=none; b=B1pPoH39hejHebU00egogEwmBp79iH0cFm8KX8ZQBjznlDUmtiFIJveU6YNBjcz6FcV5EH0kTzUkFFztpsdw8s5/4vdjLPnQFQWPwNGrBz+Sm/Rx0LNEGNiIQIRJ4Umavd7ElXaEpIvI4nPgSP/shC4i62KB8t6G1PhHQ+Y5A28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759921813; c=relaxed/simple;
	bh=Hc9v4R2rZeWS6dhtjrba26/RGxHd6MKWKm0ydk+IG8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svzKhxqa8vL9flWtYYdgHjGXacYZI36P1ACDc30jc9whcKnDrNsl9AcAKjDqi80d/6ijzISb2R3mMCmZRtgEvi+jbVPwH6A8P+bnGDju8YKiTrTNZIlSoGkHV0WDtpvVqvO+JHzSQMd/g3TUFQ9HbVwGjTfrEvuAQjnerTuwEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U3pCEMDQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so2288297f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759921810; x=1760526610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOoCoo/kRZ9H2eYNIlPbfERHPSdBnOUarDV0tF/Vsy0=;
        b=U3pCEMDQ/WqeBM8hQfnfzwat+VF4i2qoSxyZ8MAtW3AvlvVVW66eYShQEfSYYOnS0B
         6MU63fw6aNHFWMfCUnGfdEHNyu8AdWET8cX5bx9G8YZyBqhgFiA1lJ92Jw9394fHSu+R
         VzkwkVhQOXreIoB7xn9tgrePlAXrjE19MqE/dgAIzRnCWdyzcjbUocg8NB5vqs6q4GkW
         +hV+8hvkvtmBrBOVOLjgb/LY5YRigX2G7kExBbdaEuabMQ39TxcgHPjoJC3joGfZpd3p
         CTEej2M2/pv/QXiOUBBsXPIjbKzn9Vm4ZsEvZU6NuW7lPthm9y7adaXfUuzuw6c0+Sub
         Z3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759921810; x=1760526610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOoCoo/kRZ9H2eYNIlPbfERHPSdBnOUarDV0tF/Vsy0=;
        b=o5jnuv22Z8z5oYgw8lkduZaU+OSJ8dq8hbFpfUmhIO61lrkeHLCLkiBnBiEXYCImgX
         0VKGXhT8NloudRuCmjgVzMp5OrOSXS77wJGiYUOmT6LlxwmImpjlThCzm0Zkn5mLQceT
         YZ3c0F0pVMHIGnnCOQB8YvDjjBq5b/1w/VpRJLhmt/AS/r/0s7gOo8rEE+peWsXlawRa
         8+xF9OligmnOUdie6DRLAkPTwWQqvLTDBbIdayKOHt0ehV/TOL+iNhr9llvXCkrCCkfl
         Dmn/QP90QEesnEj1UJstJ98qKlBJg8sNCvkou22HCELIKiVdg3VVsScBL69a809vP7m3
         iSbg==
X-Forwarded-Encrypted: i=1; AJvYcCVfbcUuwaWQWPFrvAaZkY5T7cpprRTzx4YL+Bn8UoPNHAc2zL0+McrabCbtJBvs6XVlkkRsRumrj4tMbt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2FY1GXY6LxESwqwO3SNZIlkEEanG5c9o6kUzgJKvcFn13vj7
	85pBuDFbr+RBRuII3DSp83DyftoOfsUVeUgQ3Ze2ROMeUjdexajmf/IuyBKC3dgbMO8=
X-Gm-Gg: ASbGncurYCABe9oXiJQLG3Ny38Jqw1A3EpiCrLqv85KQLsbUydc7UBeq+ZzzVY39p+5
	N/5YbG4XwjJGcs4BKj8/i/26vJZOD0AbHw9KXiv5o2BT6DzGlDE4ZbHWKT8bajx8IFsTPQ8CeQr
	SmpY/u/+1JmnQShnvJrcy3S27/yHgRNRK8wDojUrFSAy6HTzHPEpK0boujWQnxPXdCXkfN5datt
	At0WKw03Jgq1jSSt1luM1s9e3LicvaUDylLQMpSAzirp/Q/ezobLZFLYpGILF4uUIatdIOJNWtb
	Z5oTTZYXATS8FzoJ6PKiEpUNFv/bQaGdNgLw+SxHmXgthmNADoAd2FuaO9FoGwUJZGGO2EsoIhz
	0NuQN7r+QilEzo0oujb/z1zSknuj0IJtjUnMG2ECaKbm2NQSJhKBkvi0S
X-Google-Smtp-Source: AGHT+IF8pm2Ysws9HfcmS5cWanYD1JrHATnvRtGm0Fo22qsjus/ifCiHFP30UTcyrVr2FtN+/LKHoA==
X-Received: by 2002:a05:6000:4301:b0:3d8:3eca:a978 with SMTP id ffacd0b85a97d-4266726d56emr1504591f8f.21.1759921810043;
        Wed, 08 Oct 2025 04:10:10 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f011bsm29928260f8f.46.2025.10.08.04.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:10:09 -0700 (PDT)
Message-ID: <fcba9459-9a5a-44c9-976a-323a6f4e0429@linaro.org>
Date: Wed, 8 Oct 2025 12:10:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/27] perf jevents: Support copying the source json
 files to OUTPUT
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>,
 Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <20251005182430.2791371-1-irogers@google.com>
 <20251005182430.2791371-6-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251005182430.2791371-6-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/10/2025 7:24 pm, Ian Rogers wrote:
> The jevents command expects all json files to be organized under a
> single directory. When generating json files from scripts (to reduce
> laborious copy and paste in the json) we don't want to generate the
> json into the source directory if there is an OUTPUT directory
> specified. This change adds a GEN_JSON for this case where the
> GEN_JSON copies the JSON files to OUTPUT, only when OUTPUT is
> specified. The Makefile.perf clean code is updated to clean up this
> directory when present.
> 
> This patch is part of:
> https://lore.kernel.org/lkml/20240926173554.404411-12-irogers@google.com/
> which was similarly adding support for generating json in scripts for
> the consumption of jevents.py.
> 
> Tested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Hi Ian,

This commit breaks the build on x86 for me, but not Arm. I also had to 
do a clean build when bisecting as it seemed to be sticky in some way.

It fails on the empty pmu events file diff check:

diff -u pmu-events/empty-pmu-events.c 
/home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-events.c 
2> 
/home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log 
|| (cat 
/home/james/workspace/linux/build/local/pmu-events/empty-pmu-events.log 
&& false)
--- pmu-events/empty-pmu-events.c       2025-10-08 11:49:46.341849139 +0100
+++ 
/home/james/workspace/linux/build/local/pmu-events/test-empty-pmu-events.c 
  2025-10-08 11:54:40.619999115 +0100
@@ -19,239 +19,8 @@
  };

  static const char *const big_c_string =
-/* offset=0 */ "software\000"
...

The output continues with the rest of the diff, but I assume it's not 
important to reproduce the issue.

Thanks
James

> ---
>   tools/perf/Makefile.perf    | 21 ++++++++++++++++-----
>   tools/perf/pmu-events/Build | 18 ++++++++++++------
>   2 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 7d6ac03a7109..278e51e4b5c6 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1272,9 +1272,24 @@ endif # CONFIG_PERF_BPF_SKEL
>   bpf-skel-clean:
>   	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
>   
> +pmu-events-clean:
> +ifeq ($(OUTPUT),)
> +	$(call QUIET_CLEAN, pmu-events) $(RM) \
> +		pmu-events/pmu-events.c \
> +		pmu-events/metric_test.log \
> +		pmu-events/test-empty-pmu-events.c \
> +		pmu-events/empty-pmu-events.log
> +else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
> +	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
> +		$(OUTPUT)pmu-events/pmu-events.c \
> +		$(OUTPUT)pmu-events/metric_test.log \
> +		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
> +		$(OUTPUT)pmu-events/empty-pmu-events.log
> +endif
> +
>   clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean \
>   		arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean \
> -		tests-coresight-targets-clean
> +		tests-coresight-targets-clean pmu-events-clean
>   	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive \
>   		$(OUTPUT)perf-iostat $(LANG_BINDINGS)
>   	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '*.a' -delete -o \
> @@ -1287,10 +1302,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
>   		$(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)util/*-flex* \
>   		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
>   		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
> -		$(OUTPUT)pmu-events/pmu-events.c \
> -		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
> -		$(OUTPUT)pmu-events/empty-pmu-events.log \
> -		$(OUTPUT)pmu-events/metric_test.log \
>   		$(OUTPUT)$(fadvise_advice_array) \
>   		$(OUTPUT)$(fsconfig_arrays) \
>   		$(OUTPUT)$(fsmount_arrays) \
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 32f387d48908..1503a16e662a 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -1,7 +1,6 @@
>   pmu-events-y	+= pmu-events.o
>   JDIR		=  pmu-events/arch/$(SRCARCH)
> -JSON		=  $(shell [ -d $(JDIR) ] &&				\
> -			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
> +JSON		=  $(shell find pmu-events/arch -name *.json -o -name *.csv)
>   JDIR_TEST	=  pmu-events/arch/test
>   JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
>   			find $(JDIR_TEST) -name '*.json')
> @@ -29,13 +28,20 @@ $(PMU_EVENTS_C): $(EMPTY_PMU_EVENTS_C)
>   	$(call rule_mkdir)
>   	$(Q)$(call echo-cmd,gen)cp $< $@
>   else
> +# Copy checked-in json for generation.
> +$(OUTPUT)pmu-events/arch/%: pmu-events/arch/%
> +	$(call rule_mkdir)
> +	$(Q)$(call echo-cmd,gen)cp $< $@
> +
> +GEN_JSON = $(patsubst %,$(OUTPUT)%,$(JSON))
> +
>   $(METRIC_TEST_LOG): $(METRIC_TEST_PY) $(METRIC_PY)
>   	$(call rule_mkdir)
>   	$(Q)$(call echo-cmd,test)$(PYTHON) $< 2> $@ || (cat $@ && false)
>   
> -$(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
> +$(TEST_EMPTY_PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG)
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none pmu-events/arch $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) none none $(OUTPUT)pmu-events/arch $@
>   
>   $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
>   	$(call rule_mkdir)
> @@ -63,10 +69,10 @@ $(OUTPUT)%.pylint_log: %
>   	$(call rule_mkdir)
>   	$(Q)$(call echo-cmd,test)pylint "$<" > $@ || (cat $@ && rm $@ && false)
>   
> -$(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
> +$(PMU_EVENTS_C): $(GEN_JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) \
>       $(EMPTY_PMU_EVENTS_TEST_LOG) $(PMU_EVENTS_MYPY_TEST_LOGS) $(PMU_EVENTS_PYLINT_TEST_LOGS)
>   	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) pmu-events/arch $@
> +	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUTPUT)pmu-events/arch $@
>   endif
>   
>   # pmu-events.c file is generated in the OUTPUT directory so it needs a


