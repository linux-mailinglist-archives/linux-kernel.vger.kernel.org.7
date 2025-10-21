Return-Path: <linux-kernel+bounces-863067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B55BF6ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 345A94F736A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD24925BEE1;
	Tue, 21 Oct 2025 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YLZptD3k"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422033344B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054989; cv=none; b=k5Gml5C2t5UJ4QbfxXi8wkqD8h0ZZVtg1TrvjB23tYO6AldPB9Gl/PYQ8x90kyeBe+rWlFqIto5kSexwDgE8rr9h9N//4zmIQgRprgPdCjCyumMKgOe0x0pCv9InAftggBPhu/+jCANTR/dDIrQ2xm3gXRXf1W1XRPcFMAXp4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054989; c=relaxed/simple;
	bh=1tI47LilJz0LTQhKkkRNDAAgdtyxYGXBPiVxjWz4Qzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMZXtiPEkmHQAdwdAZbVF2Q75HScEIPXLwYNeBlp/mi2UX25JgP3ks4a4hU3WgYDUScyjDB09mR0VNGHViSfpvCYN3Utrb7LrK0113ze+lMdv8GX0vFJCcU5svpDy2K6B0WdfM3O16fpvaycyJX8SVKmKq4RCDNJlQ7LSZOF9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YLZptD3k; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471b80b994bso38149665e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761054986; x=1761659786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7mUzjaKTsWvab8967NYueHb3kzfIltPZrtuhl7WWYQ=;
        b=YLZptD3kMby1/D3JvdWyyfE6PdpbiEY3RXux7VdHLXnhvR+JOEHhurV04+KBm0n14s
         rFcJl2yDXdX+31NgbjZST+85RQ62zANghVBa39QVexP3xJWw0Szj1YcntgMN54ZtTmAy
         usmtdchJjawVXpIoW6TuEB9oyQazfSYpqwn5h1ByvD8A7EK3I6joBE/P+tLK8S+YJWKv
         t/c4VvmqdCckbKfE0gnPxkCeLjElv1ZwSKAPsGUlMieJ3N0m9LgcUWNlm0wHR223gNas
         Z3nbKEb51hI2Tj0im0FJm2yCEEPn7OaIejEEZ8fSsjxQ1ZNKkQmghQYjUp8Ij+p5pRXA
         HQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054986; x=1761659786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7mUzjaKTsWvab8967NYueHb3kzfIltPZrtuhl7WWYQ=;
        b=bNtOiDS1hcCojSz3TNQFt04fvJmpQG88z9xFrwSTtYH0vSdaI0ts/z7N6aaOESmqUa
         x+N6gGRnyVv4UKbI33QMVZ9lWfAu5yDbaGuKDQwnZ/6NyQ1EVRSfyP5JTVj4d3hvp7xP
         i7Njh5/TNZHvJJBPjLb7NAxbT02QeOvvaroob9pZbaC7mMjfC/Gc+KxxiD1R7wPbFotD
         ry6+a1fQNwcTF+xqGPgwTcQpJS8Lq3r2bW8CI0RrAlmf8oVrKcq4dARrbYLjQyrj7T8M
         JhBDXXTN12bU8WgJsfKTsw9QtuBXC6dcax5Xw45WGxOsfnNpT6QJEc9El1btaMJ9IJlR
         Rjxw==
X-Forwarded-Encrypted: i=1; AJvYcCXUlYRTAIZiiA3PKoxc+q0FcvTgfxHV0SFby2QudB9RtOgwz1KwAh19XoF0j+Rjmu3wEIL9Yt5tVaGU7WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOS85+GCVOZ9SuOm0dgMr4PHI/C/3YnplekHOjlhLp8zLtUk0
	fVdMplMh701Jgh6V4/jbA6syarHRrW17/swPRlBaHXS6HQZycy5kKQZ4zlyvG/p3JVI=
X-Gm-Gg: ASbGncv8zJT3ZMbKjAZOEnxf60F19Czaw8VPfpxxaWdXdyj+BcIQYbH7UQOMRjkbu7E
	kyKLBzgOLz8zsa6jfNxEH9kUe4yp97sNmmwDQMNQBH0iyqvAm3YGrzEpZOZGgklqnDsJUJrMa9A
	i0a6Ysve43H8d4IKZd81P+jFRHhmi3MReslg4iCfbcVxf28t7UvcteiftE6E3ki3OagBZeSsOzl
	d0ZlrCm1xf1ww+cC+3OmsFgVpgbXjIJO+aJLsZkdpJD2+hj7PVItu6PG32x42qNQF561vjHbb64
	viCOFu1pShyTddvx3jyHEb+ovATl04exF75v7+xa043SDORAt9+vUSE6M1wlIHrDwhhFxQomMLP
	hnCtGAhasyy04RKKDYD0kgXJg2yfCTRskgm/9bSck6n4BMVKqIhxYeAyOmHxS1nL5ggdjZL1Tsf
	RqctA1F66Zq3i+g5ta
X-Google-Smtp-Source: AGHT+IEb1H3ulA1oy86fPg5f6/ZN58UzoPvfyonUAjv57eqjyMVYWPMETrF6iJBsZ3aFzdD6CZxkfw==
X-Received: by 2002:a05:600c:a214:b0:471:ff3:a7fe with SMTP id 5b1f17b1804b1-471179123b8mr86323045e9.19.1761054985605;
        Tue, 21 Oct 2025 06:56:25 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c2c9dasm17383885e9.4.2025.10.21.06.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:56:25 -0700 (PDT)
Message-ID: <aac9daf9-126b-4c55-8d29-8e456b305cc8@linaro.org>
Date: Tue, 21 Oct 2025 14:56:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] perf tools annotate: Align the symbol_annotate
 return code
To: Tianyou Li <tianyou.li@intel.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria
 <ravi.bangoria@amd.com>, wangyang.guo@intel.com, pan.deng@intel.com,
 zhiguo.zhou@intel.com, jiebin.sun@intel.com, thomas.falcon@intel.com,
 dapeng1.mi@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <aPW2iiNeheOxDGw8@google.com>
 <20251020073005.957524-2-tianyou.li@intel.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251020073005.957524-2-tianyou.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/10/2025 8:30 am, Tianyou Li wrote:
> Return error code from the symbol_annotate previously checks the
> evsel__get_arch from '<0', now to '!=0'.
> 
> Suggested-by: James Clark <james.clark@linaro.org>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tianyou Li <tianyou.li@intel.com>
> ---
>   tools/perf/util/annotate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 39d6594850f1..859e802a1e5e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1021,7 +1021,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
>   	int err, nr;
>   
>   	err = evsel__get_arch(evsel, &arch);
> -	if (err < 0)
> +	if (err)
>   		return err;
>   
>   	if (parch)

Reviewed-by: James Clark <james.clark@linaro.org>


