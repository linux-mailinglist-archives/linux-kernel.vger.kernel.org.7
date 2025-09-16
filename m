Return-Path: <linux-kernel+bounces-818006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65206B58B68
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA256460BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A63E1E285A;
	Tue, 16 Sep 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/MrJOWW"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EBD2DC763
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987229; cv=none; b=nUKVvNyznNXunAbakxzm4F5w640b0AfpsJ1Q52QD/lCtWXqa279bT7Y8vYmE7riqIzvtaxNn0N2O3so+mKEfKDiKyl9RQPUe94eJ3y0yi6uvkqw7O58eGr7RXPEPLpn7eSixmFXO8iYTQNJPkSMAfMbNX6W0LUdB5pOBv1BJyKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987229; c=relaxed/simple;
	bh=1MM4695OvRU5sCCjXqK9K7dBH/cGZGrNsbJDPGrHf6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV26sHreoY/vSLrzJUvKYqSGKjJx+9cI7rOTRO7f3aEifZ3/fgXugZaDRa0QtiKEDoekFalN8GcH0Z1+dLZ8xRINMwDi+Puw9MbsFF6XdVuJIhVJU3ev4MHyhgM8kZ6qmVoLVceo6cN31fn8I5Pt8KgVk4qSqPTpXhCTWiU+UK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/MrJOWW; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4097190a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757987227; x=1758592027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RiFj7ZcI9WNx+PCt1N/twq4GLIPGrm80taj6KBbbDlU=;
        b=i/MrJOWW0ARBQ6Koe2636KlWgk01WSy/v5HPod1fklMXRBltRxyUdDSgGwlxLEOft6
         wHAiQi9Eyi9y3TA61abCcFZ5HdqP/KV+UZilbgsn5tVw42YYnwHvbigGHqml2mlMsM8k
         KDJpadWRnqq7qDWWX1D31Pvam2SfXGq+usCtxXq7jYWdzMwqmWbtCa+8N+HPhJsttIOQ
         muBAAogRGDlkl6oOol9L6OXV3RPtcM0hXfsvs0qCv8OPXr9hdtxpgD0hCHoZCQKaH6o6
         SctaznAZkuz8jR1LYE/EvHpBvgCjPHJe+JwKVMRtclwVHNmXFcnzFGrT02DqrrH2mWQS
         T5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757987227; x=1758592027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiFj7ZcI9WNx+PCt1N/twq4GLIPGrm80taj6KBbbDlU=;
        b=fj2da1i1TMUfjR/UxDejwH5TvPyw1FM9GbLI5pzzyRxOkr91j2r2r5vASDhA07qxnm
         wLhgrCr6WY6BBFB2nGWUaob5eUuJ98aOydv9zuEDsRYoR51VfDADi3JuEe4dDJF4ZsWw
         /rXk5/CXlARlE8h+hZZTTtVGIrsMLyRDK0HnH3RqjlgwW0ljHN/LFhtPlIHqU91tpOfU
         b9QvJvYx6So3ghFf3MwDcPwCSGRu4vYNgACyJCyTcd1OcFdaNtx/omkfoytx//m5tl1F
         VxdMOVPt8l9dnQZYSPtZi2Qaqm7SdwMftvM/lxcgoSi5BO7g2oblHeXn+ViAPct1mWgS
         u/OA==
X-Forwarded-Encrypted: i=1; AJvYcCXjA/yg0q7n+99/tl6mkxhIg7D28DlgCp8isPXELUzQOht3vBbua7nL/ZNlM5clV1jYk1JV/fVvb4Bkk1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpR8PqN4uQOSlqWIQjBL8uhsUB/n3JKqAvBy6wN/9PvETetCu0
	0B5DUeWtGLv7NIoLRc0AlH6YT9ukACt2Z8PjmoEmFsnLTaAZDGQa3BkNSEqIjU23U+pDOg==
X-Gm-Gg: ASbGnctLD7tJCGshGqeileAfNrB5tz7J9EcTHIlxdRIEBh3KdJAagHHSUXsMDhkvsPv
	ixP9lXNQyZYIyO4gL/EwB1oz0Exb8pg53sce/oUhhyE3ThOvVG1ykDOa8WxzZ5HSE0tf1awVIpv
	iqvuiGu/aKvcmFwaXBDHnuBOHSEtFaKTbc6JrfZwPDU2mg7xhqWsjiLNNXH8E9Hy5psXhPLjKet
	jaVBz2+BbeHN7JVvaFRfzBzK3/PYNFCMjG7sqDmD/xXERruhyWPa0RYnAJWXhBozgFsSYVsEROm
	SxNnv+wTy5tBtFbnQu3FBa0QeCtc1Ucw0CGVwQ4HdfKhD/CbGIaxOazhdu30jcjFm8/0c63foMa
	GPNox317gVcqtqe8Spm0=
X-Google-Smtp-Source: AGHT+IHJPmOLXIdspKyA83O/BAcGlrfnU5dISVvn02DWV9qPvrZzZVyEnyHMg3+oATLbcf7uKM0HhA==
X-Received: by 2002:a05:6a20:7f90:b0:249:fd42:fa33 with SMTP id adf61e73a8af0-2602a28e8edmr15663072637.4.1757987227306;
        Mon, 15 Sep 2025 18:47:07 -0700 (PDT)
Received: from [127.0.0.1] ([2604:a840:3::30f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793b5fasm14930150b3a.16.2025.09.15.18.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 18:47:06 -0700 (PDT)
Message-ID: <7366f87a-1924-4dac-8945-389e6674213f@gmail.com>
Date: Tue, 16 Sep 2025 09:46:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
To: Doug Anderson <dianders@chromium.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
 akpm@linux-foundation.org, catalin.marinas@arm.com, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, kees@kernel.org,
 masahiroy@kernel.org, aliceryhl@google.com, ojeda@kernel.org,
 thomas.weissschuh@linutronix.de, xur@google.com, ruanjinjie@huawei.com,
 gshan@redhat.com, maz@kernel.org, suzuki.poulose@arm.com,
 zhanjie9@hisilicon.com, yangyicong@hisilicon.com, gautam@linux.ibm.com,
 arnd@arndb.de, zhao.xichao@vivo.com, rppt@kernel.org, lihuafei1@huawei.com,
 coxu@redhat.com, jpoimboe@kernel.org, yaozhenguo1@gmail.com,
 luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org,
 yury.norov@gmail.com, thorsten.blum@linux.dev, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
 <aMfpwYPX6_i6ROOY@willie-the-truck>
 <20250915103506.GA3245006@noisy.programming.kicks-ass.net>
 <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>
Content-Language: en-CA
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <CAD=FV=Vr67+uRK2bYu34MDXRJN4w_VH_EO7OW4eVLJ3wqUUBog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/15/25 23:42, Doug Anderson wrote:
> Hi,
> 
> On Mon, Sep 15, 2025 at 3:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Mon, Sep 15, 2025 at 11:26:09AM +0100, Will Deacon wrote:
>>
>>>    | If all CPUs are hard locked up at the same time the buddy system
>>>    | can't detect it.
>>>
>>> Ok, so why is that limitation acceptable? It looks to me like you're
>>> removing useful functionality.
>>
>> Yeah, this. I've run into this case waaay too many times to think it
>> reasonable to remove the perf/NMI based lockup detector.
> 
> I am a bit curious how this comes to be in cases where you've seen it.
> What causes all CPUs to be stuck looping all with interrupts disabled
> (but still able to execute NMIs)? Certainly one can come up with a
> synthetic way to make that happen, but I would imagine it to be
> exceedingly rare in real life. Maybe all CPUs are deadlocked waiting
> on spinlocks or something? There shouldn't be a lot of other reasons
> that all CPUs should be stuck indefinitely with interrupts disabled...
> If that's what's happening, (just spitballing) I wonder if hooking
> into the slowpath of spinlocks to look for lockups would help? Maybe
> every 10000 failures to acquire the spinlock we check for a lockup?
> Obviously you could still come up with synthetic ways to make a
> non-caught watchdog, but hopefully in those types of cases we can at
> least reset the device with a hardware watchdog?
> 
> Overall the issue is that it's really awkward to have both types of
> lockup detectors, especially since you've got to pick at compile time.
> The perf lockup detector has a pile of things that make it pretty
> awkward and it seems like people have been toward the buddy detector
> because of this...
> 
> -Doug

Should we support both modularization and changing the backend after 
boot, so that the user has the choice?

-- 
Jinchao

