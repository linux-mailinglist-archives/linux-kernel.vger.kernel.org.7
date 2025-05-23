Return-Path: <linux-kernel+bounces-660740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0C4AC217C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 12:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256E33A15BB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FA8228CB2;
	Fri, 23 May 2025 10:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WL1ujVP7"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840C1C5D7B
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747997311; cv=none; b=FX/7RZU1k9lkGSMYii5a6BCWDAdBjKQt7z1Q1Efz7zeN96gNHOH6Bmm35AokZ2hN+SA20HOOzYnk9GyyctgLzKeArfG/6G9g8U6fkI/oz77Oo9n21H+3c4WQvQuDCJnCnSI1yS4yzmUyT6S/2cQck1V1PthtUnQ31g6RwfNidqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747997311; c=relaxed/simple;
	bh=XSkjldj97M+e+of8exBXRT5HBVLvhJohJVhRpJQP3e4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU9ryw1Rtz81idRUW3/lu0fmmi6Ax1u+fcANCnwE9/HqOAWcmLsurQ65hXCyncnx67rdo8AD540EJ4JXZlGIdnnTUhT/UAFJFWZXVE7gy210Dt50iI3VB/2RckHzcvI7UFe/4O1dA1GGQjDBq3UIu8lnk6yJHLvVHHv1xANxsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WL1ujVP7; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so4796514f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 03:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747997308; x=1748602108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=voTvJwrPQGdruYP3pP85QbrJKMnqHgErZTAD/Bt3JTY=;
        b=WL1ujVP7glMXqYU5DDByo8KfOXPc3ZQp10JJPv4askDNPAxOMQpKpL0lYKLiN/GygZ
         F1FVoLPmHeAcdXfAdSJN4tHuXebWHuqxYmE++bF6boKI5HOHlQtqk2VBntFcwzMjk+YZ
         P30ItrfxIMSlSeNoRKK0n1GNvZGQJ0XLSE0mhcSCapg/9/IedJbREgc+VqwVR+V6vDBe
         o4HTBhK+JFWYZpy+M7cy6/SsXmUZoRVJ3C86NHd7dcHu3TXZAVFTpQ2egMwZGtmYsAKR
         iLBQiJvleYkf8rx8JUldeyfPvSbeN6V1lBzc5yzVR4J7HkXmEvM392kN377JcGgCVVbR
         poeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747997308; x=1748602108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voTvJwrPQGdruYP3pP85QbrJKMnqHgErZTAD/Bt3JTY=;
        b=Xkh2qkRMHzFsiHFQcRLlH+74TvslJGf78dsHCa+jZnNyxXnF+S3+hbts8V0Ub3zP72
         3iNFszIVsAAFqjzdd97Y8JQ5JV+FV7u0OLH1GJ6imh4INKGo24+HiCuNHjsIYxp9V7Wr
         Z1BJphgi5yeB3Ai19+BsBhxURGYJWjN4+RUc2u84SLhcGE93S/zWlSbOxwijyG9Oke9P
         +g7+BDKZgU+fLxdghMWad0+6uzyf+2d22xDMfy4MmdA9lDT/bHdI/qGLceM9xAXwAgy5
         YfPO79N+Cq8wvuHmmLNC58ttrVky1VuDxsO16FIE3svE9JhyVmvMuvyIvffqs/5HWzAx
         rTyw==
X-Forwarded-Encrypted: i=1; AJvYcCVUphqhbP24AeAZLRX7G3Qa+Pw74apA7Y1z6Y+3xQZMjRlhpmlYHUw3eCStvt5jyyJMKprBN2Xpr3jY4mA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivSJKwhun2ix9ys+WPBtcs0QM/Zpm4thW1SLxZshwpEVludFP
	tyr/mWTl+h1Wno4QR1qRPAApgjwMKgZUPZ1Ik+ueYJZRofdy13o9BjdVILGy4za48/I=
X-Gm-Gg: ASbGncvpaxD+jlcXcfEUHByPwBKV7ai4gjIYOWJIoZRUJhYTapY3HCiJfqsKjRASB7+
	VdrS6LSGb6D38no902dH916u5nICgGZX6KyoygPsKKA+I+Uwbdgg1k9etO7O3onoDy3S0SE7maK
	nR+OJRgihi/IHLJthph1ZRmmy4hcomhnfiUKnHtA81+t7eJJABCzG7jwp1WfORcJqa8I8HQj2rt
	xT8uFXxCnqmyjyQY2GHB3tF4wjYnf9yv5RN6SM3BclbV1GiOq7VlF2eOe1RmsC59/EszFz7m/hU
	3HbJegN97lb+W2SHfktljbA5gLMcdct1ODRyjsh50Xbly9JTkHKV0v/U
X-Google-Smtp-Source: AGHT+IHx452QUcQ50JNdz8iXNSQilMKwUd4fVnA5wB1quLhPZnMwRd8x17z5rpX7t8/Vn6MdMihR6Q==
X-Received: by 2002:a05:6000:2085:b0:3a3:ec58:ea41 with SMTP id ffacd0b85a97d-3a3ec58eb7dmr11166636f8f.48.1747997308045;
        Fri, 23 May 2025 03:48:28 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3674fed67sm21892603f8f.89.2025.05.23.03.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 03:48:27 -0700 (PDT)
Message-ID: <4763aca8-a140-4291-b12e-e03cc0d82bdd@linaro.org>
Date: Fri, 23 May 2025 11:48:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf test: Support arch-specific shell tests
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
References: <20250522171044.1075583-1-namhyung@kernel.org>
 <CAP-5=fXDaKueO9HE-Gr3Q7R6qm2EjwnL845nh7R2OU+DCfrhyA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXDaKueO9HE-Gr3Q7R6qm2EjwnL845nh7R2OU+DCfrhyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/05/2025 9:09 pm, Ian Rogers wrote:
> On Thu, May 22, 2025 at 10:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> This is a preparation for shell tests belong to an arch.
> 
> I keep repeating that I don't like arch and I think ideally we'd be
> getting rid of the C arch tests. I just sent out a patch doing this
> for 1 test:
> https://lore.kernel.org/lkml/20250521165317.713463-2-irogers@google.com/
> We should be able to make perf, tests, etc. dependent on a PMU rather
> than an architecture. This means that running perf built for ARM will
> be able to do things running on an instruction emulator on x86. It

In this case for Arm SPE and Coresight you can only generate trace by 
running on a full model or a real CPU, so I'm not sure if we could ever 
get close to running on just an emulator.

> means the tool, the kernel APIs, etc. are generic and new
> architectures like RISC-V can test things. It means cross-platform
> (record on 1 machine type, report on another) can work without
> tripping over load bearing architecture ifdefs. It means that we

I have thought about adding some generic decoding side tests for SPE and 
Coresight, but couldn't really get past the fact that you need to put 
the trace dump _and_ the binaries traced into the git repo. Not only 
would this benefit testing on other arches like you say, but it would 
also lock down that decoding of a known file doesn't regress which we 
can't currently do by generating new trace every time the test runs.

If we ever added this they would be separate tests though so they could 
go in the top level folder, where the ones in the arch folder would 
continue to do record and decode. Maybe naming the folders by PMU could 
work, but you could also have both PMU name and arch name folders like:

Recording/requires hardware:

   tools/perf/arch/arm64/tests/shell/cs_etm/

Cross platform decode tests:

   tools/perf/tests/shell/cs_etm/

Which would mirror how the source files are currently laid out:

  tools/perf/arch/arm/util/cs-etm.c
  tools/perf/util/cs-etm.c

Thanks
James

> benefit from more testing on generic pieces of code on all
> architectures - like sample parsing. We can always strcmp the PMU name
> or the architecture at runtime.
> 
> Structure wise we could have:
> tools/perf/pmu/ibs_op/tests/
> tools/perf/pmu/ibs_op/tests/shell
> 
> It feels noisy compared to just having the shell test in
> tools/perf/tests/shell skip when the PMU isn't present. There are also
> things like library dependencies that aren't clear when we have >1
> directory. I'd prefer if new testing followed the existing model
> rather than this.
> 
> Thanks,
> Ian
> 

