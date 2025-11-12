Return-Path: <linux-kernel+bounces-896456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8250DC506AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 04:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D443AC034
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E990F2820DB;
	Wed, 12 Nov 2025 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aYbAzKEa"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE022A4F1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 03:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762918095; cv=none; b=chV4e7xL2xjVylF6+J39iZUo90pD6GMMXe8ybHGnvgF7BU+iF0FuqOLSD563yt5UcuwdCQUfkRUy6i2JkDoRtpHBRexmabrB8QRpqofRpyMBCAtjvzXWxcNGPCDHqV8lojgL9SFQQAeIrHLPc0WKKGKxCGy6UGhVKQ08vnkVlKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762918095; c=relaxed/simple;
	bh=fV2iMTMramtjmMeD00HnxbCHxEQvqSmy+lvFzGovXXc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=e/ZLvF3mG+0DnQgxHzXvjgl3FJShcbZnBTaPeuJjpN+mcobQ1LNttc0nPRLcaTT/TW1gf5cF4tAqlO1h6CtMAPqALe3IQEpIXNWtMttzXs7rUi4anuVP53ex2xRfED10cZIq0AiY7aIDI/opAJKM8PrJurTlFvq5o3XV6WHoIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aYbAzKEa; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso221909a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 19:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762918093; x=1763522893; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MvXqIM2Kx1gC5Q1+jYgAsgab/53O5lp19dTKMbp8FHM=;
        b=aYbAzKEayV9u9ZGSTcM/+lnl91Bx9q71av84J4Dkf+oiHoc4KX2MboRZEZc+Kc355g
         isCReynfavRg84I5UPjxcZRvgSPcUmJ+eVUe4nAWKtLtL9jR7t0+E23TvORtdwd24LHv
         gcB26mq3TlgIzUMBQJgBXUV38/5S0O5rUdLrg7t2pp7K2navVP6ITs9fsDdCdZGgsxuK
         +8TryJvvkZgCgxKtV78rNZcUkfJscgnfh35Kb7hRLjRGnEtubUeoz59m3srvaWdMiiEE
         Ng96TQijtWgog2dy0tn/eMP+hFGwmrp+KJDknyDPn+YeUw2jvgG/nb9rJ3Uun8iC6e8U
         y2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762918093; x=1763522893;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvXqIM2Kx1gC5Q1+jYgAsgab/53O5lp19dTKMbp8FHM=;
        b=ZQM5GfJlOHg9ZbpA7jO0+zYpY6z2UbjGErM3o8gmbYsisXkt+xSsc/zb0C7OK0En1N
         aJoekNk/0TUILH1NLGSVHcx/fvrn3aKnuIAnlYC+c+7kFMEnzMujWsbwsG8Z48xSeVLc
         SFdyaoR8TQuSlqyo+TlTnKqC5ORsA2opITYxlPLQ7iH2WvEPc9JVLcKWC1gbnG30RS27
         6Ih59eW7XCfOOBpfENR0fN8nT+ydvTeCeazIvaXSBTe4ZrPLtaOR0QGqtzPh2IRAwV2x
         faIE0kHmmNbyj7VRQzBhaljfCr/V74+uUWxmKka6Je+2gTNgzOw9kyuOAlCI67CW2ZjO
         dt8A==
X-Forwarded-Encrypted: i=1; AJvYcCVkZTnflBd7/29FfMINsQbrW8I8hHcEQcAVZsJmbp3TKO0/BDUub8YxAdyqFmZ6AjKVnT1tLQIffJZ6wNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3YarPRM4UDPxOJWUX1IsjlUWaaZI8A9fI27WAl+WYz0NzfJ92
	oIU9s4fc90pbCikcwiFdbYYT4gihcucsxHQ2aZihmQH/jp5RrMh3kJtj8wuUTPRGJE8=
X-Gm-Gg: ASbGncugKQFwu82k5/Anrycya73cjWFAx/b7q8EZnM/j/6XBitAbuM6i49Z9vnT//+s
	0gPHMPL0QrrzafRw0FELj88qL8cZ4DLwM7P6Mn8Uj/bAfW+izDNWb/FiSOhhBqoUJjW4skwtvco
	JxdV2WA1aig/5DBxaz1g4lIO9asCutCDE5cBbBHqM5WaFoM5RupeY6oTVZdQY3BeIyzDDALLmLO
	cKZA1GIxRyNddVu7OsxiOKxbOCM0/EvXb6OD/H3XhUBxIBD9EOCYAB7ja/Sb3mjh8wctNIrni/q
	PmFVP7E8tCjYm0ej6rUJLoWHb+GXjLc/UHwisnTJ+Rde15JbOareMGOUbcQXFabMGQ2URCjZz9q
	J+mg6FRkHTL/hNotk7HneTOEei5jYLevojxgCXD/z+C8Y1wIhSLhJuREPJ4D2ovrj3G6EqWo+ye
	mBJBgqe2el8z6B7rrnj9FNt9J/PaAYP9X+854Ppa4qXHFadXhUy/p+6A==
X-Google-Smtp-Source: AGHT+IHjQamBj3bCLsY01rrfJ1JjY59qu2CtviaxITwggjQ7mKKSi5jsY53X1IycsXPEkh4PpaYpUQ==
X-Received: by 2002:a17:903:fa7:b0:27e:f018:d312 with SMTP id d9443c01a7336-2984ed2b587mr20220615ad.1.1762918092891;
        Tue, 11 Nov 2025 19:28:12 -0800 (PST)
Received: from ?IPV6:fdbd:ff1:ce00:1b26:822:3294:d7ca:6065? ([2001:c10:ff04:0:1000:0:1:d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd0c41sm12843415ad.87.2025.11.11.19.28.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 19:28:12 -0800 (PST)
From: Liangyan <liangyan.peng@bytedance.com>
X-Google-Original-From: Liangyan <liangyan.peng@google.com>
Message-ID: <b079b4f1-4d11-4137-8204-16935dc12129@google.com>
Date: Wed, 12 Nov 2025 11:28:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v2] perf/core: Fix pending work re-queued
 in __perf_event_overflow
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Liangyan <liangyan.peng@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, zengxianjun@bytedance.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251109103253.57081-1-liangyan.peng@bytedance.com>
 <20251109164122.80138-1-liangyan.peng@bytedance.com>
 <20251111133023.YqDNgQak@linutronix.de>
Content-Language: en-US
In-Reply-To: <20251111133023.YqDNgQak@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/11/11 21:30, Sebastian Andrzej Siewior wrote:
> On 2025-11-10 00:41:22 [+0800], Liangyan wrote:
>> We got warning below during perf test.
> …
>>
>> A race condition occurs between task context and IRQ context when
>> handling sigtrap tracepoint event overflows:
>>
>> 1. In task context, an event is overflowed and its pending work is
>>    queued to task->task_works
>> 2. Before pending_work is set, the same event overflows in IRQ context
>> 3. Both contexts queue the same perf pending work to task->task_works
>>
>> This double queuing causes:
>> - task_work_run() enters infinite loop calling perf_pending_task()
>> - Potential warnings and use-after-free when event is freed in
>> perf_pending_task()
>>
>> Fix the race by disabling interrupts during queuing of perf pending work.
> 
> Makes sense. Lets it does not overflow in NMI, too.
> Either way I suggest to trim the commit message and remove the
> backtrace as it probably does not add any value.
> 
> Sebastian

Got it, I will remove the backtrace in the following version.


