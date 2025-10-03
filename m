Return-Path: <linux-kernel+bounces-841221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D81BB6887
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 13:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C66719C4499
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 11:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37127EC99;
	Fri,  3 Oct 2025 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKFd9BLK"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1F2E9EC3
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759491076; cv=none; b=UdaDWD9Fw2yqh5f4WTrXqHeGvgcwTN7MHGxChmg1ZrWbtE1Qf4asKsvxQ9QgL0fKxD5QhVLpg5fCeN+/XoNDfXQRj+SL3+kOs9ymAZ4dquRutOlQ/pOSe2iGGGBGJY8ysHYvsAdDKs0xHWGSCH1k1caf83x+wCDBxHBxIqylnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759491076; c=relaxed/simple;
	bh=PIkT1+0gw+lXsm9sS5Wzvn/5CTdfZq6wWYlHqXPd8eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hoZtxsPDnzVhARWGFdFR3aUpBm+ZXKEte+ZCOs5eil67S65POnvhhrgPq/Onj0p9WvGaga8He/HVcPqfAYrp9TWe4J/y6wLq6U20HR7SdBmBb8a62ICCHTx68u1p2GIYKDzgxmlN5dvVeakQW8PMGbk/sDM1KcZPKzWFSLbCj5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KKFd9BLK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso1344566f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759491073; x=1760095873; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ibN5rbc8ghQl0pJHE5O9fPExmoZbJHmxkhtyV7wHyf0=;
        b=KKFd9BLKI830t1400/+UlbeoejmruXkswx2DR9repOqitlMXHJDsAtzqD7xcaQ8tcJ
         Iqu+Fg5w8LjybhA04Ub8PBcfXxlKdiWyqsFqpxWLWBgjw0UiXYDF8MLOR57Eur5kGShV
         qPdgmkA4U89wAlhYXFv+INCksdQO65b9qp4kOOtXDT9EAo+eLKWehe3kc0GoOUxJZ1ll
         vhJkzpdDo8yBBkHHrpjgRFnPg3+qheL+q52AB4pMOyKMZNoU5rsV1QcX1HGk0lHOpfBs
         V5q2VvbOpC1BvgtCQkziewE0bAcVW97uvkXeWNnbeD9fUyctOp7jJHjgV7FF/Rsso7Ll
         s00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759491073; x=1760095873;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ibN5rbc8ghQl0pJHE5O9fPExmoZbJHmxkhtyV7wHyf0=;
        b=Qk18w5jFOmi+y5jBdHpxCDTxvNaTKNfcCvYWva0dx+Wn+/98Fokli6HyMgq+riNNXg
         CXJNiOoWU8fGhNlMraUU/9c8DZs3KEdpN2aaFCxJZ0ZZXZkr19DwsgR+v1s1bSkUstu6
         lO45NB7xzBjJNP07iAst9lrCHsUN5h8RPZCx7synqlOSX6Av/jAkmuJKxoEKu3vHdeGQ
         0Bos2Zbfl+vsGFVC/SNT2P6+RlkGNwp3mEbAuRPDYxV9K9zHvpd4fJxdHCpkoArbA11v
         LRXuizALciGdp/eLvGjrIkTd0qMboMhRGWXbQpUVsRspOuV+HOum2i9WC4hFKJ+LCF2/
         2xFg==
X-Forwarded-Encrypted: i=1; AJvYcCUuO6csF4sO2QGyL/nGRyL7N1QxRg1E7TaRbjN9nROuHHKYFDrQ0hCCE7TvsiOdmHZ7T8z0NzgjTbeMkiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAj3hzv8D5VhlckAHMehsyI1GMOOiP2trXPk07gKGWLAQkZWgF
	HfDxWDsG80n/cHkFms5iEyMAIj073bVXV9diKAMSThBpkvM3zzyfYPAx/Ufq8MJ3FQM=
X-Gm-Gg: ASbGncuCizgWtEvk/eeNlPO0osSr2HTYzB1FdZCCasQY6yTD4ignL4BP+WlHYtEQ/TO
	z7yMAKp8obL8XMwKQO5sLeGJbpXDjJ1xTd5S24+f8kCLZnflLeimNMXC7zydarw6BaXELTztPJW
	6ARuJdwiVzNshmUTHw1B/hsoEM0SZIwZ/nHW1HEIHyTtoKGhGwjC1B0N/4GQxsoAcqEyP8ATO0p
	2dBj47Cx07LSeQaHq9wWHiQdv3VWsT3fuQjn4Vgbg2uSWIPOCmHNEt2Ak1G1ZVIbXWGXOiwbjUh
	3ow7idf6pOIX2KFCz+o22M6NdTPMCKlfV7j9cEzwgIjy4ge7MgFMUp34nvy1miusMNuzRYb/08j
	UtSglfS3dFDSd7dRNPcauWTnVPEmoWPMkYQV2hkl6TvEdIDgyRvkoXmah
X-Google-Smtp-Source: AGHT+IHO5l0fSYL4lKyVqheYc51Yp0SHNdYSpIW0cATJRdXWA33ZbEKx2wK2487Gs5sKnFqQcspjKw==
X-Received: by 2002:a05:6000:2c0c:b0:400:ac58:b35f with SMTP id ffacd0b85a97d-4256714cc0dmr1579028f8f.21.1759491072634;
        Fri, 03 Oct 2025 04:31:12 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4cc3sm7599429f8f.55.2025.10.03.04.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 04:31:12 -0700 (PDT)
Message-ID: <640baace-99c7-435e-a754-a46a49c32deb@linaro.org>
Date: Fri, 3 Oct 2025 12:31:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf stat: Move create_perf_stat_counter to
 builtin-stat
To: Ian Rogers <irogers@google.com>
References: <20251002220727.1889799-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251002220727.1889799-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/10/2025 11:07 pm, Ian Rogers wrote:
> The function create_perf_stat_counter is only used in builtin-stat.c
> and contains logic about retrying events specific to
> builtin-stat.c. Move the code to builtin-stat to tidy this up.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/builtin-stat.c | 60 +++++++++++++++++++++++++++++++++++++--
>   tools/perf/util/stat.c    | 56 ------------------------------------
>   tools/perf/util/stat.h    |  4 ---
>   3 files changed, 58 insertions(+), 62 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ab567919b89a..75b9979c6c05 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -676,6 +676,62 @@ static enum counter_recovery stat_handle_error(struct evsel *counter, int err)
>   	return COUNTER_FATAL;
>   }
>   
> +static int create_perf_stat_counter(struct evsel *evsel,
> +				    struct perf_stat_config *config,
> +				    int cpu_map_idx)
> +{
> +	struct perf_event_attr *attr = &evsel->core.attr;
> +	struct evsel *leader = evsel__leader(evsel);
> +
> +	/* Reset supported flag as creating a stat counter is retried. */
> +	attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
> +			    PERF_FORMAT_TOTAL_TIME_RUNNING;
> +
> +	/*
> +	 * The event is part of non trivial group, let's enable
> +	 * the group read (for leader) and ID retrieval for all
> +	 * members.
> +	 */
> +	if (leader->core.nr_members > 1)
> +		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
> +
> +	attr->inherit = !config->no_inherit && list_empty(&evsel->bpf_counter_list);
> +
> +	/*
> +	 * Some events get initialized with sample_(period/type) set,
> +	 * like tracepoints. Clear it up for counting.
> +	 */
> +	attr->sample_period = 0;
> +
> +	if (config->identifier)
> +		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
> +
> +	if (config->all_user) {
> +		attr->exclude_kernel = 1;
> +		attr->exclude_user   = 0;
> +	}
> +
> +	if (config->all_kernel) {
> +		attr->exclude_kernel = 0;
> +		attr->exclude_user   = 1;
> +	}
> +
> +	/*
> +	 * Disabling all counters initially, they will be enabled
> +	 * either manually by us or by kernel via enable_on_exec
> +	 * set later.
> +	 */
> +	if (evsel__is_group_leader(evsel)) {
> +		attr->disabled = 1;
> +
> +		if (target__enable_on_exec(&target))
> +			attr->enable_on_exec = 1;
> +	}
> +
> +	return evsel__open_per_cpu_and_thread(evsel, evsel__cpus(evsel), cpu_map_idx,
> +					      evsel->core.threads);
> +}
> +
>   static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   {
>   	int interval = stat_config.interval;
> @@ -736,7 +792,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   		if (evsel__is_bperf(counter))
>   			continue;
>   try_again:
> -		if (create_perf_stat_counter(counter, &stat_config, &target,
> +		if (create_perf_stat_counter(counter, &stat_config,
>   					     evlist_cpu_itr.cpu_map_idx) < 0) {
>   
>   			/*
> @@ -794,7 +850,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>   				continue;
>   try_again_reset:
>   			pr_debug2("reopening weak %s\n", evsel__name(counter));
> -			if (create_perf_stat_counter(counter, &stat_config, &target,
> +			if (create_perf_stat_counter(counter, &stat_config,
>   						     evlist_cpu_itr.cpu_map_idx) < 0) {
>   
>   				switch (stat_handle_error(counter, errno)) {
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 50b1a92d16df..101ed6c497bc 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -716,59 +716,3 @@ size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp)
>   
>   	return ret;
>   }
> -
> -int create_perf_stat_counter(struct evsel *evsel,
> -			     struct perf_stat_config *config,
> -			     struct target *target,
> -			     int cpu_map_idx)
> -{
> -	struct perf_event_attr *attr = &evsel->core.attr;
> -	struct evsel *leader = evsel__leader(evsel);
> -
> -	attr->read_format = PERF_FORMAT_TOTAL_TIME_ENABLED |
> -			    PERF_FORMAT_TOTAL_TIME_RUNNING;
> -
> -	/*
> -	 * The event is part of non trivial group, let's enable
> -	 * the group read (for leader) and ID retrieval for all
> -	 * members.
> -	 */
> -	if (leader->core.nr_members > 1)
> -		attr->read_format |= PERF_FORMAT_ID|PERF_FORMAT_GROUP;
> -
> -	attr->inherit = !config->no_inherit && list_empty(&evsel->bpf_counter_list);
> -
> -	/*
> -	 * Some events get initialized with sample_(period/type) set,
> -	 * like tracepoints. Clear it up for counting.
> -	 */
> -	attr->sample_period = 0;
> -
> -	if (config->identifier)
> -		attr->sample_type = PERF_SAMPLE_IDENTIFIER;
> -
> -	if (config->all_user) {
> -		attr->exclude_kernel = 1;
> -		attr->exclude_user   = 0;
> -	}
> -
> -	if (config->all_kernel) {
> -		attr->exclude_kernel = 0;
> -		attr->exclude_user   = 1;
> -	}
> -
> -	/*
> -	 * Disabling all counters initially, they will be enabled
> -	 * either manually by us or by kernel via enable_on_exec
> -	 * set later.
> -	 */
> -	if (evsel__is_group_leader(evsel)) {
> -		attr->disabled = 1;
> -
> -		if (target__enable_on_exec(target))
> -			attr->enable_on_exec = 1;
> -	}
> -
> -	return evsel__open_per_cpu_and_thread(evsel, evsel__cpus(evsel), cpu_map_idx,
> -					      evsel->core.threads);
> -}
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index 4b0f14ae4e5f..34f30a295f89 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -223,10 +223,6 @@ size_t perf_event__fprintf_stat(union perf_event *event, FILE *fp);
>   size_t perf_event__fprintf_stat_round(union perf_event *event, FILE *fp);
>   size_t perf_event__fprintf_stat_config(union perf_event *event, FILE *fp);
>   
> -int create_perf_stat_counter(struct evsel *evsel,
> -			     struct perf_stat_config *config,
> -			     struct target *target,
> -			     int cpu_map_idx);
>   void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *config,
>   			    struct target *_target, struct timespec *ts, int argc, const char **argv);
>   


