Return-Path: <linux-kernel+bounces-841150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537BBB65AB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6979D3AA37F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84F2877F4;
	Fri,  3 Oct 2025 09:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLWmjelF"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FC823AE9B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759483217; cv=none; b=VmsT1VcVw7EMbgFA7ffYC26nFnwLluJrYLo0EOyN2xaCq9vIc8BqvRnP5TyY04ytwdn4HWx5/+G7In0WxT20p+3V419npPFiNR1LVqqwjzesYEbIiNJoRsRTHy9i34vYv+YhlVGAVYmSgOLor4aCrpqjGBLKnH3Wn2ckrmjEVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759483217; c=relaxed/simple;
	bh=+SLJ7EfScV6sMH/JMesT8stk7T24TwrdUWoRJeAo79s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgP0xJqVUhYI0f/xkbbTKn78lKnldURkkBDcRXlVF4X3UphtH9TDxCrVrVtQJnZk2WtQmxqIs/hEShiNDY3gZ7efK6a2pYMw9SajausV5X/ZtNTXprk1qx0Ru8cwe3vZg1Wgmw1enNOF/oLTDmAUDgznZmFKpBvHe1mevfC3BrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aLWmjelF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1797691f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759483214; x=1760088014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bqv2200rRXJ/QamD+MMfnrrG8n7+Od5t42rq8XoC83I=;
        b=aLWmjelFexeVaLyPTHyWH5XnWye+P0kfsOc5scTMolCYNzWfl4EvtpOhVUxCkWnAvb
         hlkidbMZ7uZQ7mdjhj+Hni5E7J2gl39Cn8+Jfx9USCSszg5PA5i2PTzxq4iLnyZzGdKu
         yvD+XcJFUewR2koCTJcjT0Cw1OCilwVbaySKuFGyIPreionlOl33qrTwEbA0YKZFTNPc
         gIAaHTuhb/wYodv6yzw6yNwF11gNWkfoeSBytAZU4481huwuljSkNLH4HUwfNpiH/C1G
         lKC1qjz5dWoEG8mXQ+7/JcLDOqT3PoxpNZIPL5MYeeP57D45kGgFYPtJTxdZgrEKgYD8
         QsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759483214; x=1760088014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bqv2200rRXJ/QamD+MMfnrrG8n7+Od5t42rq8XoC83I=;
        b=fIIiLMc6e8iR38CuSDEf9P8VBy5otO7DlMsJ4H6VIy6vcKH41MHPj+sIKBbJh8KgCT
         IQtXqOpIx+RROwHegskaODcdPWl2W555F41kjoT2mOrmK4tBU41LO7ClNF/d/iiHmgDZ
         2MRUkHq5FWjJILDnuqKX/TRu9i6ZXNLvcuwdApn623zoe8IAvzFPgwT2KvLQY8kQemzo
         dm6MmoZQI0ooCUee/n6/a087bufq73ruHibFgvfiZMzq9NA2eNAARHa5ZzzPg1t4sLG/
         XJT3SGptdSLIOJ9h5xEMu54P1jm4QoU42MzbklReETN/Jemw+fzAvTaay4V+hJlilKqh
         LAYA==
X-Forwarded-Encrypted: i=1; AJvYcCU91hPPHnxxE2PkMKtxV1PInoC7CaNYPJyfGiiYB3YJmVg7Pu/blWixsn0JrL+p+Zm3JnaqLMaq2WT5Vl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+PviMljw87TBRfYlha2nhPkRU+H7iwwG9hvK7n/GKmPM3tN/V
	dphrjlk0r2HwSNBYxo/GsUXJyw5X5+nzYUHMu2o4/6MxhHOODHFDsEK5USi3lfNl2zY=
X-Gm-Gg: ASbGncvlkOybGb8il1cDvK2X9pTGipkb7LHW1NCMDy0jIuyEqkNQJZfRw9f2xbukvuU
	Bi+PB0P2CmutUE/e1M2lffTNJkTAgJNFCPe76DnGIkiqiPByjS9rkdLLiPBFmfj5JwF5S1iDslH
	Js1roMcGK9iIURbQozWTd4uwjttS0Aq3LBy23UK2vk9wV0rikvthDHXaom4L3Tpu/ZRiCMnawas
	EVrqYFXzlVYGIyhaObmBgVasIKtAwR/BqJ8EutGgSLwLz0GL0kB3r4jdjlHtiaY/2Wz7hhkAnKA
	24jXjG3cPqDxYwy6CbxlV0/G/W8/zMTn3HtzvqIuJO61uaqoEh9G9mTII+TWwCkgVrCJwfG6tX5
	7pkK3DAkom56XXWy5S4Kg6uXclEdIScFtXppETULWfWgvYTw7wjDT0XWv
X-Google-Smtp-Source: AGHT+IHpYgt/4Fafg/5Gnz394SePFpGL16C42FqwGPTOfqs6EHI3VgunwlusPKdKsHi77r25Xg4O/w==
X-Received: by 2002:a5d:64e3:0:b0:3d1:61f0:d26c with SMTP id ffacd0b85a97d-425671bea34mr1495147f8f.54.1759483214391;
        Fri, 03 Oct 2025 02:20:14 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72362344sm22502505e9.15.2025.10.03.02.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 02:20:13 -0700 (PDT)
Message-ID: <86331395-140b-44ca-8351-8bc5c511e211@linaro.org>
Date: Fri, 3 Oct 2025 10:20:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/28] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>,
 Leo Yan <leo.yan@arm.com>, Vince Weaver <vincent.weaver@maine.edu>
References: <20250923223312.238185-1-irogers@google.com>
 <ca47d298-331d-420c-8c4f-83cd29bae902@linaro.org>
 <CAP-5=fWUYH2eji2SNp37_2uHu55qEfRxuhhROYsMZeCixjda+g@mail.gmail.com>
 <CAP-5=fWUVycpDss_+MNQ_DM93AYKWED8aYOUBKLziYTOn68QJA@mail.gmail.com>
 <cf050a7f-b341-4e14-bc46-8bd30e366b19@linaro.org>
 <CAP-5=fW_WfAzb=qm+AnA-xSn8MOHjmTMcpEvXB6uVi+0Cr0=fg@mail.gmail.com>
 <CAP-5=fV0Qqi1m72-7us9rw7K3hbh05fAzutVtcazY7iTu3g3+w@mail.gmail.com>
 <CAP-5=fX0bOj2kEJYmRs33RpL0ODaOy2wCvDzwLDmNxurVRpGew@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fX0bOj2kEJYmRs33RpL0ODaOy2wCvDzwLDmNxurVRpGew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/10/2025 9:10 pm, Ian Rogers wrote:
> On Thu, Oct 2, 2025 at 10:58 AM Ian Rogers <irogers@google.com> wrote:
>>  From bisecting, this change came from commit 9eac5612da1c ("perf stat:
>> Don't skip failing group events"):
>> https://lore.kernel.org/lkml/20250825211204.2784695-3-irogers@google.com/
>> Taking a look.
> 
> I sent a fix:
> https://lore.kernel.org/linux-perf-users/20251002200604.1792141-2-irogers@google.com/
> that makes it so that only if all events are unsupported that perf
> stat exits - this is addressing a bunch of latent issues and fixes the
> perf-tools-next regression. I don't think there is a difference
> between v3 and v6 wrt this behavior, I think you were probably just
> cherry-picking the v6 patches onto a newer tree. When those 2 patches
> land I can rebase this series on them and drop the first patch of this
> series.
> 
> Thanks,
> Ian

That is true about the cherry picking. I could only apply V3 to 
perf-tools and V6 to perf-tools-next, that was just a guess without the 
hash in the cover letter.

I did test both unpatched perf-tools and perf-tools-next to confirm that 
the original behavior was the same in those. Once I saw it was the same 
I assumed the difference was only in the V3 vs V6. But you're right it 
could be because of the base.

I'll retest with the fix applied

