Return-Path: <linux-kernel+bounces-801395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CEDB4448C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5147618968E8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF283115AF;
	Thu,  4 Sep 2025 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsDhFZB/"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3030E85F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007518; cv=none; b=h7p4HGSEbYbu1AVq3fM3MoXfAz+zJ96z5xS1XRSSZmw1UyKwO7eDuVscdkKn3AgvZHuElECSRFKXjYa5k5lPVA+QELzvQeRtL/eyVcjaIS0dKrAFmqyYxlcerFI2MZXzxEbUb0BeNvdpgtBSis/Cp0nvd/kTxplnRZ1vDG36bI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007518; c=relaxed/simple;
	bh=eW65k+VLxlVXZoV17Fj7k9z5JFDPDnN8w2k8mCjd9J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Qx42r0yUPG7A/mWeqnc8IqMsa7GIorQg+cfGCikmb61l5nLCQueJktTWPVDBAS7IYK+pISQhHW4lsEkZ718MaR6lRS9zR4dmgp71SlMWEacicKnJT5wiEh3HJfhPXcSMiuI+HOlNO6c09aVBidTiG+fDNBh3R0KB0sIRajV7YpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AsDhFZB/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e2055ce7b3so534571f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757007515; x=1757612315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UtXXSwtOMhpB/JfdDza+Bmm2bnj1nuhwUXXf1VpvGF8=;
        b=AsDhFZB/Ftbs7s8t/gWSJcLaK6IG/onxH29pXpok4Z63cqy4dksBz3puAbn+ce+Qm7
         UwqcIX1hen/Ef+NF18pk3h58T6e/PnA93gKIZhWsFzI4yZaOkJJmXIZNYcwHMpHHUsYr
         /e4bCbzzQPoB1yaA/Iykg6odbQpJf0prmd0yWTJTW9LJXsMvayiVej4gWoyD2DRvBqrj
         DF2IgkpiOfts0oL4jW8xJyWPR1HT1f5t8JsKwkodmgGyN0B2ASqCZ6plQ2qdyJl+vGAN
         5DrNUbXhyjGW+jEBjVn0kHSOm6WuaBsNdWsn9aJUq7WY64UGC8BsF2za+REbGDcvEuFy
         jMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757007515; x=1757612315;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtXXSwtOMhpB/JfdDza+Bmm2bnj1nuhwUXXf1VpvGF8=;
        b=AoiRXViv8tK533TB7yopU1I49pEO4Ss4J8K99YmWgSN82JoObgegfLpOhsaIrSsIP6
         BWc3sVTZJh96SO5c3e20ie6FSVihooJ0ZR+Godqoxaud1d+V93aKQ03O1RxvNhKwWLxQ
         7HyqO9PtVEZzZ3ryeUNazto7tM2aYYhxxcN2BQb0ZFhXTeFhMh7aWJU3eyx58A4uAeHL
         BeL76a6OBdUIDtm1ybMB696TGPCjnvU91wdZXi6t1XwfyCYU7fxNt4DmV5YRoxybzXvp
         ATEsg8qqPGgPSVAAnxpX+FdPK3j5zBdlbRQqc4GHC4epFoKPH2PBP+SZma81F3/6OQTK
         LjMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpOFwgpRZITgai72LK0y07R/6x2C22pqKWTqs+6K5W585icVCtBy3mbpdwT2pqLFcJQH325mcZ0M/DFlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcAiIzC9MVw8slv527aTO87ZFePLJFo5496RSA0Ssiq2ze+nDc
	FRRwTy2ZdorCMdoIgVIDeuPsgrw5qHls571jbUhOzjFpNzculOyZo92drSWJyG6aI98=
X-Gm-Gg: ASbGncsCNgJ1VbPc8HBfYczxxjDIRV8YD3W35itNZZZ9Mu3rSF0HVbN3PVjippOQL+8
	gHmnAa95hCSX9/TJXFofFoOfzrF4TiSrZ85OpiYMYQUR1+02ifty4dKeI88haoCuwxStvqmXUtA
	CyzErTtBGg3x7Z3fWnOaT5wAF55NLqyfTsqtq3421tYkPzgtveHjbeEyFUPMMsmt9nNAFcCg+1i
	HQX4kHouHtV+StC0uNKL6J4mBjkuSCMyv/3cO2xpqwA6NjdaRtGUQyDNbl4WVK3XKNwBtIYRKqx
	aNU63xq6K+4IwDC24p2i15Q89ILpWOAmzoGtHmrzDRgxiwkKahMFNVRF2kZrStvmiL4GgIKYH6G
	vl4PSDiICkAcloD1kdSa4Rtm1d9GfTVv/O95AaA==
X-Google-Smtp-Source: AGHT+IHfB59Ivm+mMfjEV6WrGYct7tMLyzEnUysui6rpi3Q4B82Cp6TFvFTQAOMx8IN0h9rl8HXcqw==
X-Received: by 2002:a05:6000:2c06:b0:3e0:a5a2:ecb9 with SMTP id ffacd0b85a97d-3e0a5a2f627mr3616989f8f.13.1757007515110;
        Thu, 04 Sep 2025 10:38:35 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d204asm28651472f8f.24.2025.09.04.10.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 10:38:34 -0700 (PDT)
Message-ID: <2be96cf8-39fe-4499-9e6b-97268c685698@linaro.org>
Date: Thu, 4 Sep 2025 18:38:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf symbol-elf: Add support for the block argument
 for libbfd
To: Ian Rogers <irogers@google.com>
References: <20250904161731.1193729-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Haibo Xu <haibo1.xu@intel.com>,
 Stephen Brennan <stephen.s.brennan@oracle.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?R=C3=A9mi_Bernon?= <rbernon@codeweavers.com>,
 Sam James <sam@gentoo.org>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250904161731.1193729-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2025 5:17 pm, Ian Rogers wrote:
> James Clark caught that the BUILD_NONDISTRO=1 build with libbfd was
> broken due to an update to the read_build_id function adding a
> blocking argument. Add support for this argument by first opening the
> file blocking or non-blocking, then switching from bfd_openr to
> bfd_fdopenr and passing the opened fd. bfd_fdopenr closes the fd on
> error and when bfd_close are called.
> 
> Reported-by: James Clark <james.clark@linaro.org>
> Closes: https://lore.kernel.org/lkml/20250903-james-perf-read-build-id-fix-v1-2-6a694d0a980f@linaro.org/
> Fixes: 2c369d91d093 ("perf symbol: Add blocking argument to filename__read_build_id")
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This patch should be applied after:
> https://lore.kernel.org/lkml/20250903-james-perf-read-build-id-fix-v1-1-6a694d0a980f@linaro.org/
> ---
>   tools/perf/util/symbol-elf.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 033c79231a54..1346fd180653 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -873,13 +873,17 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
>   
>   #ifdef HAVE_LIBBFD_BUILDID_SUPPORT
>   
> -static int read_build_id(const char *filename, struct build_id *bid)
> +static int read_build_id(const char *filename, struct build_id *bid, bool block)
>   {
>   	size_t size = sizeof(bid->data);
> -	int err = -1;
> +	int err = -1, fd;
>   	bfd *abfd;
>   
> -	abfd = bfd_openr(filename, NULL);
> +	fd = open(filename, block ? O_RDONLY : (O_RDONLY | O_NONBLOCK));
> +	if (fd < 0)
> +		return -1;
> +
> +	abfd = bfd_fdopenr(filename, /*target=*/NULL, fd);
>   	if (!abfd)
>   		return -1;
>   

Oh that was less awkward than I thought then. Assuming it doesn't mind 
an fd opened with NONBLOCK?

Reviewed-by: James Clark <james.clark@linaro.org>


