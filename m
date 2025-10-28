Return-Path: <linux-kernel+bounces-873182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB07C134FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B52D5040F2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31997248886;
	Tue, 28 Oct 2025 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClAmDygP"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2A1DD0EF
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636715; cv=none; b=MB4vjpfanYbDnHY2nqvO8YCSO74tk1RP520bhBJ/MMAAUFw/3Bo6iY1My6SxV6mZGJrnH3dzE8d6c+v2IA0xzp5PC3mYo6yHjAC59TT2vFmGp9u3wZCtggC9DDpjx2Vv0k9coCC0fiLluF16iQKZyOodAeYTPm+ctQXIyPnKAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636715; c=relaxed/simple;
	bh=Dfe/mLr6wtr6mqCakN+DKr6GBe5kWFN21TshBy4+f+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYyBpBN2LzI0bTk0VQeCknz2Kg6z/hQ1OMNHSxXZm0B5LsVOppmCmZBxN4vscSa38FFFnGmCdWyHOTl8ebIMUdavkEwBDBBsqBlPdhonLncMSXw/sAK1hFMomQPjMqjoWCG89PQdz+1MymvLHlG0xMbW8jfT29vvIlx939o0czU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClAmDygP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so7268732b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 00:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761636713; x=1762241513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1jVKUZWZOQbIruQCfEfK99fHy3fvzla1FjfuRBvkyY=;
        b=ClAmDygPdHYE5Wj1KmIrV/iy9fOo4Fbrgv3xblSmHKLugjpl6MPZDFqZa5txsz+CiH
         EM5s762d1OFjLAstiCo6WERSj7asEFoeEAX4LN2C/AO7F6x0StaONZj4z10msHBmy3oi
         r9lkIaZDNctSLBpmzZmKk7h6ud4vpqweoTEKZzyh6HiONuUNsSPKAAmBPfV8sICXRw/E
         s/JzduDtESlhXBYAEd2xp483/UCx0B6hL2E/5PNnqW84MuiN9gpoAMCkb9loMc/Pkibd
         JTZZq49+DLsMD36Qob7dt2aujQitcQtUufF5Q/JMeCqZQr1j7vWoObbZODWeQPXZL+HZ
         6D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761636713; x=1762241513;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d1jVKUZWZOQbIruQCfEfK99fHy3fvzla1FjfuRBvkyY=;
        b=gdPsEYmsC7Ocv7pDW2ox/64LoRz0vNejdqLF/lVswudwpaPci/kCH39fLiNdE9GqrW
         wvATFkOOOIIgqA0Urg3DRUKL2RiBXYM59mUrKgRKvUQPZNM4qWhmNPmxgXxyAphuRtcy
         JXkiMn5cgLnzrnimp7PaCEuI0MmZr5R7BFColFOVvfxB16L4+oJ8mhpjXmkfD5B7d7H3
         VnFUtqw7m+S4/K0aZfBPV8+98qnmISqNm6MCKlgtb2K+rpDavliIhRO3vUOxGKdlopEJ
         kpm5qnURsjBZmnjeKwbYV7XuoNd+05fVI9nMbkzpXwg7vgQlWVD/v9hJX61T7p6L4jsn
         Wpew==
X-Forwarded-Encrypted: i=1; AJvYcCVvw1x1tLUCSjVfWIkQMwMAv51/LCkqhwng0fDXgQoNNjjVrBy9NEj1VkEsCoTlID413zcoxPiX4v8XMWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7utMEeSxilMv7TUHyFlcwnvszF5uCMNyn0pFGd2iD9PLdYKHp
	jL38/lSGQ4VWSz2jZwiXF035JE88h76Nss5GFU+blmNpmPXli7i4Z2vh
X-Gm-Gg: ASbGncslTkBN8OCH+TSkQkJaSGOMGwqUtvrTaVsjf9RyNe9NvZyOM7yoIF3lW4RlHVj
	WnzOePnCnATKmrI8Ylmsomv2/TJX1Ai6GclW/ovrW1lu1Hc98kVJLPJKLfiGycNHguPti/37nJR
	URCAooj9OHsYyUhy6QGrPtLJVykBN71gvCjwwuSqGJP21O5YyzHwKALGGbmJNX1mqYeSTej9ATd
	NbH7NGjLCpYjidwjnFflIsXz+zIy7cYLxwwNFUoJ5Q+BoTuh0C/5VbdnaBfGFQAVTv0ZwAIteZB
	mKcNAOD/YR/qZECo0WjYHwU3Oy0tSm9CPkObPu2LKTxhT0F55Rp/ROPKiHG+Kg9GRxfaEauprcV
	NKIH07xg/Wf4I+NY2nVmG2yUMVQ7xrTmtkHspKn/mxho4ceiY56AuwIB3AGZbfggxpGAJunbgmK
	Wo0ZBY/qSVj6NcoyI92RN9
X-Google-Smtp-Source: AGHT+IEZX02rLyVssIesr7oD/n6emPWveW9hcH/mjFcCMF3WJlFMxXGlsW3W91+QXh1Fj0GpndGNJQ==
X-Received: by 2002:a17:90b:35c4:b0:33b:ae39:c297 with SMTP id 98e67ed59e1d1-340279f5bf4mr3283799a91.16.1761636712981;
        Tue, 28 Oct 2025 00:31:52 -0700 (PDT)
Received: from [10.125.192.70] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3402915612esm950635a91.2.2025.10.28.00.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 00:31:52 -0700 (PDT)
Message-ID: <b495827a-0ee8-512a-edb8-cd79c84d5a6a@gmail.com>
Date: Tue, 28 Oct 2025 15:31:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] sched/fair: Fix non-empty throttled_limbo_list warning
 in tg_throttle_down()
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
 Hao Jia <jiahao1@lixiang.com>
References: <20251027090534.94429-1-jiahao.kernel@gmail.com>
 <20251027120211.GB33@bytedance>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20251027120211.GB33@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/27 20:02, Aaron Lu wrote:

>>    *
>> + * THROTTLE - invoke in throttle_cfs_rq_work() to ensure task dequeue
>> + *            during throttling, and in tg_unthrottle_up() to ensure
>> + *            task enqueue during unthrottling.
> 
> Thanks for adding the comment for dequeue_throttle. One nit is:
> dequeue_throttle is used for time accounting purpose so it would be
> better if you can make that clear, maybe something like this:
> 
> invoked in throttle_cfs_rq_work() during throttle for accounting
> purpose, and in tg_unthrottle_up() to avoid throttling when enqueuing
> tasks.

Thanks, will do it.

Thanks,
Hao

