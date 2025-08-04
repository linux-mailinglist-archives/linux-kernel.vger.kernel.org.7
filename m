Return-Path: <linux-kernel+bounces-755584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED47BB1A8C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F2B18A3027
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1692264C9;
	Mon,  4 Aug 2025 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BVPG6SID"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42676EEAB
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754329974; cv=none; b=SWlOxdweaS1Sv/glxPf9FV36VJQ4AlI9DtOXYNkUyWuf32D0SnwCLvu/mYpI4d0ubEkPZO1jsKGC8PAGJVviD/n36tv0m5pdrGE4HYxK2v3FPwMx7NrtkddiEQ79SUZVwyCbQGPQBhUNstM2e2j65Sf2mR/LIdpeV7UURKhQiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754329974; c=relaxed/simple;
	bh=MITtmRLgX9iL5YGbpLUrutAFDqPhawvDMsW6dIhPldk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OvuH/934V+PTE9m451zkzTJTV6myeui577yb7BsGTt0n7kgscji/uScIdLrB43aEaeU3s/3GD8M23R9pBmyi8kN22QtOqs8/QWVMgSlx40ZF5+Sbpu3d/st2PyagU2hy90nvxWeaHGE8nkl7rBAFhXZhCdlt/lMEJJnhmDZY3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BVPG6SID; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61553a028dfso4545637a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754329970; x=1754934770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MRofTYFybnWbqGD5aM5QMPfkcPNg289kfNTFul2BGPE=;
        b=BVPG6SID1ElGYlU3KyKWTVkhPIhWJTh5imsdSbbyxd0aDf433faJpozR8jw3SS7pyx
         bSSWxNzxVnOGI8aLkW2oPEcqywCYqH2t1aVflAV4YK6ZOeZwDQZX1y+fdzLcqA+S7+G3
         6sOS44d7gs3+09Vfab0oVqBe/lIttABcV/DOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754329970; x=1754934770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRofTYFybnWbqGD5aM5QMPfkcPNg289kfNTFul2BGPE=;
        b=wdA93IX/Dc6jH46P9rgL6PIX+qpblB7K6BYWb7P4cRkuzx17o+So/oK+XWDR09F4RS
         1vjBv7pPtdgU0UCNWPf44XYZKDTDGQsAGqKf6x5zU7CtvPCMDzLUH4Bh+IHYCDe0CydL
         OlfapMMN8HqPOtXLUYapfEkvxU2xnVWEP/OLyZpBLOM2GVxrrFRLdBdsVJXuZhEEuQb7
         U8ARC6sa4zF9C4bop2NzFY33wEUODjIaC0MuWBNIccNVL4EmiVy/3qwPLSCljPWBmScX
         rnYTQJ6h9fB1xm40e0sJBLX4WTuuXUpZWR7S0EencPSoJkhL1IRcD+GzdS80ADOlX0Dc
         6nNg==
X-Forwarded-Encrypted: i=1; AJvYcCXeg9VqayM7T9wg7aGEkzdJB96KrmninDlvu5QKgB4GWE546H4U+RwyKdWwWFL8M3Q8+QAmVnMMd0aThGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEQ/yJpjg3Gc9TNmOlAcQhpODOKY5p/5HlkVo61UgxbcBUU7wu
	6+OdTsUrOqNuFo3V5+QN7iXrW8sBYQHZ0/x+Xb22dinMTu3PZtEzjDApjADlgWM5XnLx7vcdzXy
	bfaiGnRk=
X-Gm-Gg: ASbGncuQot6mDCYH5XaTAvQxsTrv3EtZSMQlwORxOhHHpNQSz5FGyAhNW00efdT6cdL
	Eo1+E93CeQ30FmoWO8SWLMx/MxpO2W8nuvYGeIxIE3EsFun5DJSK7v89e2Mlw8+mmp7vBGuP4aA
	NJJ/uKdvFlXlYxjfvYbdosnAL3d3ACxI+qNrka+hwQZc6/sMoDSVRm5M6Qn9y3HKUNLHbjUXcJE
	2Gb1E3ACYhYq3KZ7NDK3WSP/du8RhErWJyKWpogTdkJTDDi5HK3mHIHsOuTKPm0rnV8YDPTXGTX
	jBzYlG3AJQ0mGrn+AuSFgeRMBnHXAEM/adu6P5NldHPoATwSMGpd17sh0IBz+h64bVvRv/HFktm
	GH6EiQ+dNi92pCEppFuGgRBFU6ZYlzg1ZrDfpQwVA4X/0DPnjp9vLq+JXAKbJ9+MOQ9B7Udrf
X-Google-Smtp-Source: AGHT+IGEpjCF/Q3LRJkFE8xIc9uTAMula2imPM5EYvFGGQJ78Oquyc+DJwikUAW/z77lfk37GapPbw==
X-Received: by 2002:a05:6402:518d:b0:615:a2d9:61f4 with SMTP id 4fb4d7f45d1cf-615e6ef6947mr9839025a12.15.1754329970331;
        Mon, 04 Aug 2025 10:52:50 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a86758fcsm7205276a12.0.2025.08.04.10.52.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 10:52:49 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so5063658a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:52:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFKTJJLN3oI9OKVs5/KtwG6pct2ALr+HMUid4h1Daac51TAR4zdHJF+JML4AEJJ2O7XU/8RR4GX4E2XFM=@vger.kernel.org
X-Received: by 2002:a17:906:c10f:b0:af9:21cb:23d4 with SMTP id
 a640c23a62f3a-af94017fa1fmr1175104166b.36.1754329969058; Mon, 04 Aug 2025
 10:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aIcdTI3e04W_RdM_@gmail.com> <CAHk-=whgqmXgL_toAQWF793WuYMCNsBhvTW8B0xAD360eXX8-A@mail.gmail.com>
 <20250804125028.0676d201@gandalf.local.home>
In-Reply-To: <20250804125028.0676d201@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 4 Aug 2025 10:52:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_xCaL6piu=nRsAfKFqYG8nZ9a8H9jubPiyJ0j1V9Xcw@mail.gmail.com>
X-Gm-Features: Ac12FXypbVuHvYKSstofiY8xWrVfRI4N3UpLnj8vYr8_uARQCWJ2RFiTV44v0nI
Message-ID: <CAHk-=wg_xCaL6piu=nRsAfKFqYG8nZ9a8H9jubPiyJ0j1V9Xcw@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler updates for v6.17
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, Tejun Heo <tj@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chris Bainbridge <chris.bainbridge@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 09:50, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It appears that Peter never sent in the change of:
>
>   https://lore.kernel.org/lkml/20250716104050.GR1613200@noisy.programming.kicks-ass.net/
>
> Looks like this could be your issue.

Ack. I assume Peter is on vacation, so I just applied that one
directly, because yes, that looks like a likely culprit.

            Linus

