Return-Path: <linux-kernel+bounces-827205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22FCB9126F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFC13AE7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6453090E4;
	Mon, 22 Sep 2025 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bLJsHIFb"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FA02F619A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544820; cv=none; b=GojoOsBPtsyoyii7/YuNamdt1inC4ioBjgmEZsNX8UeR2xAVwiM/cZs5ZLd6WluV/R77w+JfWv6C+9v6sGNLp47iOeh0NooJTPP1en5XQRm5QPsUfuVOBWhQARYMwkpFXgVfgu4pDoB4CnIodFGAAfPc2xDTuUbUO1Yyj+h3pag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544820; c=relaxed/simple;
	bh=oLCLpX2jtMBtuMbPjtYboKL7moJwuIOjpinv3gJLa8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHLicC4I5WQOQiolIpPqmjXI6jglHuaDkK7ZupaQJRMMp+fUe4t1Rctkvu2c3QloZdOcvDER5zeLhoSJtEoRWwiuxLkmEb4UPOVxdwpPK6J9rPAu6NqxV183d/1tFlBn4Fl28vjIBygxsUHWJcrFOXdDKxO60XYpZoQigljeSdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bLJsHIFb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-267dff524d1so31665415ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 05:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758544818; x=1759149618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RdyyD1EXBlvIemsVmbrmNlfheta51vslsx7KshN1DY=;
        b=bLJsHIFbEM09XDe59YEhHFRoweCw4Hlh0gyDmk0YX3VIE+Euurz0ASBSt607Q7SksU
         LZrONtaVQjKTGMzcm+l2804kwwN6tW+Un50YmwLh5d09RpLhfh/TwLVaZy7zhF6JLTKi
         hioel4qtYy997x7911FbeABAXMR0csN6WpJS+EplzTiqjn9CazKbeEumEqrXfmPRBr0m
         Q8X16pkhSiidubs7plksfnGfs5p3WlikFMVmmk9qEclW3vMCzCZXm3qtNqENsaXEtX0N
         iQjZ36l9+b0joXLKM3n/v87VTHO3NjKk1unILsTgxmylwLt78jb1zCcmPvu9HyBzdRlk
         DpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758544818; x=1759149618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RdyyD1EXBlvIemsVmbrmNlfheta51vslsx7KshN1DY=;
        b=guC28pQBNpH2SsUIL0HfXXE+Ye1jBMmLcitnV4ioCN4zD/KIQ8e3SVu8faWOfllIIB
         aM/sEq0RcmhrEtUBo5k5+Gc8J1AvMkFFCxY1IPPefiVVjnfvuto0z+O2Gaik5oj1+E29
         vDtwjHljOvpAs8V+0Yccp5UlNhmLONWi4qan73zJna39X0wa2SuwBMtxxsoaXKpcpYDc
         xR+gwRw2U2KtqvPsgAjLyPQ4sxcCnisnIBYLHsrAL+eJOVSQuaMVnN5Rr3sCRY7pT4YZ
         H48LT8tCA6daBcOXxVo+5BeOv3vq5PFcnX+KX3sW6/SM9T1OUrqJOVGs8m8aZUoZlUcV
         yYyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUorNFcqZYLH6tyVR69ECAdFz+JFn19+QVWlh9x+N61+AQcWfa7zwSbDP9nzgShe1+kVsCh/MtvYoXQzbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8yGBjADKW7os/bgobYvwLgjr8usCStL/UEq41cpxyMGN5mrJa
	R5pSLWJjRrYMOKj0DyrV31orMVY+3J7CpGpVgcG1pdstCwiAfIdzL+xRb8C9lnMqMHI=
X-Gm-Gg: ASbGncsr0plqm2u5wNHJye/1tmDyMqPdsRcrrFPNDjaUTtd6JbpKHz3tL+azr8XeaPq
	7DP3lwGiymZCenvgY7j/gtQIZbFfJAbjp+Ovyolk83SX7O3S24/SZ9UbvoNYFcdZfZUJ1qo2s9A
	OtQPLzmRNgejaYUpDO38pqpOnWy5ui43ZaZ+MOgF/VkXW2FIHtZkyc9/zasU3IzDoxV8pUCYWHj
	kR46/Ja0cgZk5M2Lj4YXzBXvV81U8/p87gFKOUQZEEDufTlWLzKdvDnTusssBPdocYr0L3cjPkd
	yd+Ig24/rWsB4tI4TzP03cslqtT5o+U+zbqHSojIQOy/zKMe+cg9Dgl79LoZ1V5PzO1eaDxfaVh
	QsaQD89JhpZViFGzkdJ68R++BmNa4hk9Bhl8q7vuMrlV7Q/SkaUOzx775qjyeLQjYqwo=
X-Google-Smtp-Source: AGHT+IGfbvFXQmlQnTmGZle857UzvcerOSlhtVzVL5bbYLCJzE9eOizBiElU/zVb+pH3vZvphyUhdQ==
X-Received: by 2002:a17:903:4b04:b0:23f:f96d:7579 with SMTP id d9443c01a7336-269ba516bb2mr183605025ad.37.1758544817789;
        Mon, 22 Sep 2025 05:40:17 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980179981sm131280655ad.54.2025.09.22.05.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 05:40:17 -0700 (PDT)
Message-ID: <fd12dd70-5de8-43bb-a4d8-610b5f5251fa@bytedance.com>
Date: Mon, 22 Sep 2025 20:40:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Suppress undesirable hung task warnings.
To: Lance Yang <lance.yang@linux.dev>, mhiramat@kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 akpm@linux-foundation.org, agruenba@redhat.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
 <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <b31a538a-c361-4e3e-a5b6-6a3d2083ef3b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/25 7:38 PM, Lance Yang wrote:

Hi, Lance

Thanks for your review and comments.

> Hi Julian
> 
> Thanks for the patch series!
> 
> On 2025/9/22 17:41, Julian Sun wrote:
>> As suggested by Andrew Morton in [1], we need a general mechanism
>> that allows the hung task detector to ignore unnecessary hung
> 
> Yep, I understand the goal is to suppress what can be a benign hung task
> warning during memcg teardown.
> 
>> tasks. This patch set implements this functionality.
>>
>> Patch 1 introduces a PF_DONT_HUNG flag. The hung task detector will
>> ignores all tasks that have the PF_DONT_HUNG flag set.
> 
> However, I'm concerned that the PF_DONT_HUNG flag is a bit too powerful
> and might mask real, underlying hangs.

The flag takes effect only when wait_event_no_hung() or 
wb_wait_for_completion_no_hung() is called, and its effect is limited to 
a single wait event, without affecting subsequent wait events. So AFAICS 
it will not mask real hang warnings.>
>>
>> Patch 2 introduces wait_event_no_hung() and 
>> wb_wait_for_completion_no_hung(),
>> which enable the hung task detector to ignore hung tasks caused by these
>> wait events.
> 
> Instead of making the detector ignore the task, what if we just change
> the waiting mechanism? Looking at wb_wait_for_completion(), we could
> introduce a new helper that internally uses wait_event_timeout() in a
> loop.
> 
> Something simple like this:
> 
> void wb_wait_for_completion_no_hung(struct wb_completion *done)
> {
>          atomic_dec(&done->cnt);
>          while (atomic_read(&done->cnt))
>                  wait_event_timeout(*done->waitq, !atomic_read(&done- 
>  >cnt), timeout);
> }
> 
> The periodic wake-ups from wait_event_timeout() would naturally prevent
> the detector from complaining about slow but eventually completing 
> writeback.

Yeah, this could definitely eliminate the hung task warning complained here.
However what I aim to provide is a general mechanism for waiting on 
events. Of course, we could use code similar to the following, but this 
would introduce additional overhead from waking tasks and multiple 
operations on wq_head—something I don't want to introduce.

+#define wait_event_no_hung(wq_head, condition) \
+do {                   \
+       while (!(condition))    \
+               wait_event_timeout(wq_head, condition, timeout); \
+}

But I can try this approach or do not introcude wait_event_no_hung() if 
you want.>
>>
>> Patch 3 uses wb_wait_for_completion_no_hung() in the final phase of memcg
>> teardown to eliminate the hung task warning.
>>
>> Julian Sun (3):
>>    sched: Introduce a new flag PF_DONT_HUNG.
>>    writeback: Introduce wb_wait_for_completion_no_hung().
>>    memcg: Don't trigger hung task when memcg is releasing.
>>
>>   fs/fs-writeback.c           | 15 +++++++++++++++
>>   include/linux/backing-dev.h |  1 +
>>   include/linux/sched.h       | 12 +++++++++++-
>>   include/linux/wait.h        | 15 +++++++++++++++
>>   kernel/hung_task.c          |  6 ++++++
>>   mm/memcontrol.c             |  2 +-
>>   6 files changed, 49 insertions(+), 2 deletions(-)
>>
> 

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

