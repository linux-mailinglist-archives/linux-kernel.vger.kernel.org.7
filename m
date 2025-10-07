Return-Path: <linux-kernel+bounces-844441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A70CFBC1ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DB13E2E72
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BFF2E6105;
	Tue,  7 Oct 2025 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJnC7Yow"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBD2E5D32
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850611; cv=none; b=vAxSk+e19iaOf+0CSRX7w2ySMCu2F2TX+0BNYBAu6F94e9xenK/Qoh6U995LRXsFP96cr3Pnel0Rl4R6XTmskyfWqFRjQ4sCgrMUNeCJWYUPwGpmrb9fNAxqLLwjUJ2pg8VHOL6MLqekavU8us0cnwNhpAv+h/BT5jX4NApH2cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850611; c=relaxed/simple;
	bh=Qaixh/0h0CexTahBH/Nbesb7dLvjfql5jNJYxSlQ13U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmXFD+LrsSCqmOw/jT3/HXe7uy+OB+F1epQvE4fRd6o3XOpelEaPX8bdteOk331f/FID8E3ZonFTKtVQYPpKSXoRFsWl5couCDwBjJw9OeonGLTn9Eth6TUgFBoMY7cFtfOQ3tAGXIGASBVvmJ50efo4UYtodBxHChV3pkqLeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJnC7Yow; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1081446366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759850608; x=1760455408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UwG9PZuipETG7rnRpTzxcF+1B6JYfXyf2MeSzyquatI=;
        b=HJnC7YowAeXIjGVV3b79yxEzh66wwgYz5lOP7H9oHGT53cWPxcWC8X0L43Y/+GRnxv
         rl+tIcVIF0h7E3los7tb5XtGss78iKsQh+mVpEus4vf9YdwaqxxeoYo2hmaloPdaqtzq
         u415566smcfxQbq5BJVb860TVewDNSE4++jSI9lVDzpFducGS8/SgCVoQ4aZS/PwOvow
         5DloB9NC3fYWZg1z3JdDRy40RcKUUQho13o3kf+T2vydQMi/D4IcFG+CXLk5IBTSKr5K
         wsDwz7tcwe2FxIyeYyiy6shqjKdFMb6D63GnWn/vSaNUmavHAsi2MTxAfHHMCSQHZcPL
         NKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850608; x=1760455408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwG9PZuipETG7rnRpTzxcF+1B6JYfXyf2MeSzyquatI=;
        b=St2L4Rlc/VzBpBX9pETYTDCXLDEX66K7nG49PwaKGM4h+oeN9O31rqOkybbW9Meeea
         TcHTY4FirKmocdwEOtum/Hw0DqE9WkU20Gtb/GbdnfNxUzn+sMREvI82gPyNT+Wa5uSg
         GqWnYS94jVkBslBn86/J8VFRQqSZPGIxnxFrlDKo8bfiRvd+KlZjnHx4UnywCGqq1aLd
         0co5TEn1nyoGjJekIPz9jcSzlAV6dtOnWH/uwkThWo1i9lIVSku4VQAyoaRLzGLYYDWx
         UOMGoeQ/CVMW0D1PrHmR7DZ2CdczIyCERUGD7ixFwASyFm2B4YrukGdxZdD/frXQT4E8
         uzig==
X-Forwarded-Encrypted: i=1; AJvYcCUwLePli64UkaCyU2/5D8SGNTqwf48M0DWGXMymMjw+nfO4SLfN+XgJaAr2rSPnjx3UkCbSon+2BVIcAyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZ/675eTj8taC5zWbt+K05JV5nyCRFbAXVx3TcK5gO4zYlDr/
	g68UneEtsJV13JKEzvFwp3hRUNKnI3jeM6gj9/BavJmikabgRckPm4tPQAX7UB3HJVjLcAa6YvL
	YMy0+JhHHW5Q2x8DShKoZQE0dzqPLI9kFTtJwEcVZjw==
X-Gm-Gg: ASbGncvXV3sutW3kL4o+xMQgfs461EFhCkQoNXtnkIbnNkdBkCF551t0cMRKUI4/qGb
	7/gO/IrtQSwI8dGbgLPMRmzdQ+UusQc8W6jqvygxF8gTGu6yvqgX2LKjU2yXpBY0iZ5rFRhTeTv
	i1+YljADioUPGaOpRVJAsI2RhSRdlTZDCKLMfAK5ePTzicbpdjUHJqeYsdFOCWL0x+3lKf2CaUI
	3WeVFIVnA/6Zso2lxHU3QSFzBXioiM+MD40ExLK5FF3NrFpJmKWL8+315Lp/RnLmin12RsJTw==
X-Google-Smtp-Source: AGHT+IFY9nkxh1XrpxsOJhE6hryneAH5gLOUnE5EpF4NzhHNwlkHm8SbyiGn3ZVrorhgVsPBNdhy5CzpeJS0xykTtj8=
X-Received: by 2002:a17:907:97d3:b0:b04:67f3:890f with SMTP id
 a640c23a62f3a-b49c3d753d4mr2301349966b.33.1759850607427; Tue, 07 Oct 2025
 08:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006104402.946760805@infradead.org>
In-Reply-To: <20251006104402.946760805@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 7 Oct 2025 17:23:13 +0200
X-Gm-Features: AS18NWAxqcxGakptEBnQb48nrcpm15RhoPtf2PjFIcOjN0vV7OYV5xWrjVCaxFw
Message-ID: <CAKfTPtB5i+5rqkuU8Q4D9fUGAnjKCqNR_y82ZAHHgJdFgcOTnw@mail.gmail.com>
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related locking
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 12:46, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Hi,
>
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
>
> I would like to queue them into sched/core after the merge window.

Acked-by: Vincent Guittot <vincent.guittot@linaro.org> for the serie
in addition to the reviewed-by for patch 4

>
>
> Also in:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup
>
> ---
>  include/linux/cleanup.h  |   5 +
>  include/linux/sched.h    |   4 +-
>  kernel/cgroup/cpuset.c   |   2 +-
>  kernel/kthread.c         |  15 +--
>  kernel/sched/core.c      | 327 ++++++++++++++++++-----------------------------
>  kernel/sched/deadline.c  |  20 +--
>  kernel/sched/ext.c       |  47 +++----
>  kernel/sched/fair.c      |  15 ++-
>  kernel/sched/idle.c      |   9 +-
>  kernel/sched/rt.c        |   7 +-
>  kernel/sched/sched.h     | 198 ++++++++++++++++++++--------
>  kernel/sched/stats.h     |   2 +-
>  kernel/sched/stop_task.c |   9 +-
>  kernel/sched/syscalls.c  |  84 ++++--------
>  14 files changed, 373 insertions(+), 371 deletions(-)
>
>
>

