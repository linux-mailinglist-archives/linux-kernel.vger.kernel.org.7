Return-Path: <linux-kernel+bounces-726910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ADDB012AF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655611C40322
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1251C4A17;
	Fri, 11 Jul 2025 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHOzUjeM"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA214A60F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752211662; cv=none; b=hEnLuLTeHxBAIEa9SnTrBVNNs8T7sfPPjv25JDfQpXT+35c+sflfnmL4y0gJopx/pnVm9/pwGXPrPKZoQIVWuQ+MOM63BmmPsv/Af5hAWe7YGizJUD5MiRDsR1wiJW+1cWpd2+4yVVgdoIq5omOS66bpN3mO+ec7as5MtMaqG8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752211662; c=relaxed/simple;
	bh=AC51WPFHbWvC28PVORv0zti0mOgNGlDfQicmKj6+9ys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCW/a6j2Lsu2xedCTie2+wPoisBi9VSbcC8NHdA1SwqjYF/CgH9jYAxKsMCeS/1dv7mQ17SgWNiwrQpd/aNOOm1loKIfvpo3pb6EdfgCugQefzMEIHUJx97YcVdUnmwuXfAXFIUvTW3QFzlu7tkOY3KwSdmH6gwfUTNfWq56lKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHOzUjeM; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-23636167afeso14970325ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752211660; x=1752816460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEGAwmchIcAI8RRmUq1fpR/mb7uxORFOkM7RcXyqrs4=;
        b=IHOzUjeMAV/A3SbfmHhmgo7wOTtwsrfBx/qxn6u14YqXqurJjEF+TOutFD+46GGkIS
         oDxpIE6MdzQBjN8icKi5s6yPKzgMc3pAjS0aLgD7J7p17p7iZLJMU+eg3kiNyBHtew0O
         vCrWtv9QyWgQhu3nXNDNBFOQdWE351f84OfDQglPC+bbxvwAAH21wft4TwzekkZDCiFI
         KRmtk+5NBRZ5O3axHD1BhUhSDumrg4hmzOzd7+S7WzMIFtNOdeWq6mpbG+CRfmKNYlq0
         UGNH9jdnMiJiRF/7zZq/XVsPBw4ubs7wPRziXq0RAtLBwN2aEDcBXobqnMt44fB6+uQC
         3pWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752211660; x=1752816460;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEGAwmchIcAI8RRmUq1fpR/mb7uxORFOkM7RcXyqrs4=;
        b=R5C/7i+fU5n2xsJgaOAz8cJDR9NDFsjHXQdXt0FMdSrVPAhg0PZfpGALoDGMhmhNtF
         56uxbGTGr8AvTUayBTZgBjovt4pd/OX4zOfRnArMCtZyb62dXoGlzaU6uBJ1D6wvgO8L
         srp4zyIbZ0jL/zJIW7pp3JDfRG+IjaSgvvNCMMp8gFyXYLXhKsK97wpc3Ul28BCroIwH
         p6Dntgt5TtitFjpfy1XGPXDDv11s3O3azXX7SkTrArhaGeCEbITRKZTiUDvrXBWx6DWv
         JFzM1hWSpwcLR9kDxNWKucz35g+Uj3L3pwqr7eF2jwggbwLjtafD3bVXNXAob6dexbHn
         u8Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW4fk5dZGihgGj4RwF7CqflVH+aBtHY+ngOOzlf+9Z+AmTakQxLRxH0ZsXKmKukQmbx6opnK0Ic2btDnSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYFr+kDdG4Axjxuy3XwPPI3yOo53dg9I7A6hGGDveyNRS6FT2D
	ua7SXLdRO2ac3HI9Rg/4KXNXJz3ui0kErd+K5GJUJ1Zz5uaRfdl+sj2h
X-Gm-Gg: ASbGnct7LV3PGAsC3BPKCjMwi7H6wPqavnZzMK4NDJcoXt89i6EkymBCBrZeJ7XpnFh
	fUwMdp+VVyL4/e2epG5LSwwLDok9Y9sYiEXgzHmJkNLMufGeHjQR2ovzohC7kAqdlnoQz+umyEM
	6evvFGYuWNiZRBweuNXZI2LduRBI4qvc/nUw31BgqIAcFkr+1tJSoKxrXszMashZDXswCe9pIAz
	979tB03dntwXVczNLMm45hN1EXU9cChzOppBp3xzcFY+BULxtqRShUv3Q+fKozRkGGJ7R1rjuDE
	xKXjjKOg8glpNX7DByIISDzRNbJTh5TC7OEUht2HsIMnjyfOjFTNy0xKJpZtYszCpt+o+tDFky0
	XF5yF6B6I5MBliup8iANktsxhLpzI5YC1g3wyt3DYdnrOdc80DGnE0+U=
X-Google-Smtp-Source: AGHT+IEmtUKg1mllhmFUS5+13NYo4pEn9kSfQjbzR6Ad9DGhMQuXzMOVxx4xpdsZRvDRWjC+6n0cUQ==
X-Received: by 2002:a17:903:11c3:b0:234:98eb:8eda with SMTP id d9443c01a7336-23dee26dd48mr27454625ad.28.1752211659840;
        Thu, 10 Jul 2025 22:27:39 -0700 (PDT)
Received: from [10.127.192.248] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435f371sm35675855ad.237.2025.07.10.22.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 22:27:39 -0700 (PDT)
Message-ID: <e065c6df-f0e2-e9e6-bf20-959b809d2c7e@gmail.com>
Date: Fri, 11 Jul 2025 13:27:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] mm/mglru: Stop try_to_inc_min_seq() if min_seq[type]
 has not increased
To: akpm@linux-foundation.org
Cc: yuzhao@google.com, yuanchu@google.com, shakeel.butt@linux.dev,
 mhocko@kernel.org, lorenzo.stoakes@oracle.com, kinseyho@google.com,
 hannes@cmpxchg.org, gthelen@google.com, david@redhat.com,
 zhengqi.arch@bytedance.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 Axel Rasmussen <axelrasmussen@google.com>
References: <20250703023946.65315-1-jiahao.kernel@gmail.com>
 <CAJHvVcgoGwnk4TdZxj=Lvhny4sus0eZ=MbuWEVK0m6fACLFRow@mail.gmail.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <CAJHvVcgoGwnk4TdZxj=Lvhny4sus0eZ=MbuWEVK0m6fACLFRow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/11 06:49, Axel Rasmussen wrote:
> On Wed, Jul 2, 2025 at 7:40 PM Hao Jia <jiahao.kernel@gmail.com> wrote:
>>
>> From: Hao Jia <jiahao1@lixiang.com>
>>
>> In try_to_inc_min_seq(), if min_seq[type] has not increased. In other
>> words, min_seq[type] == lrugen->min_seq[type]. Then we should return
>> directly to avoid unnecessary overhead later.
>>
>> Corollary: If min_seq[type] of both anonymous and file is not increased,
>> try_to_inc_min_seq() will fail.
>>
>> Proof:
>> It is known that min_seq[type] has not increased, that is, min_seq[type]
>> is equal to lrugen->min_seq[type], then the following:
>>
>> case 1: min_seq[type] has not been reassigned and changed before
>> judgment min_seq[type] <= lrugen->min_seq[type].
>> Then the subsequent min_seq[type] <= lrugen->min_seq[type] judgment
>> will always be true.
>>
>> case 2: min_seq[type] is reassigned to seq, before judgment
>> min_seq[type] <= lrugen->min_seq[type].
>> Then at least the condition of min_seq[type] > seq must be met
>> before min_seq[type] will be reassigned to seq.
>> That is to say, before the reassignment, lrugen->min_seq[type] > seq
>> is met, and then min_seq[type] = seq.
>> Then the following min_seq[type](seq) <= lrugen->min_seq[type] judgment
>> is always true.
>>
>> Therefore, in try_to_inc_min_seq(), If min_seq[type] of both anonymous
>> and file is not increased, we can return false directly to avoid
>> unnecessary overhead.
>>
>> Suggested-by: Yuanchu Xie <yuanchu@google.com>
>> Signed-off-by: Hao Jia <jiahao1@lixiang.com>
>> ---
>> v1 to v2:
>>   - Modify commit message to make proof clearer.
>>   - Use one bool to detect any increments in min_seq[type], suggested by Yuanchu Xie.
>>
>> Link to v1: https://lore.kernel.org/all/20250630080603.36171-1-jiahao.kernel@gmail.com
>>
>>   mm/vmscan.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index d48e8d365502..d5b6924aeb8f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3919,6 +3919,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, int swappiness)
>>   {
>>          int gen, type, zone;
>>          bool success = false;
>> +       bool seq_inc_flag = false;
>>          struct lru_gen_folio *lrugen = &lruvec->lrugen;
>>          DEFINE_MIN_SEQ(lruvec);
>>
>> @@ -3935,11 +3936,20 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec, int swappiness)
>>                          }
>>
>>                          min_seq[type]++;
>> +                       seq_inc_flag = true;
>>                  }
>>   next:
>>                  ;
>>          }
>>
>> +       /*
>> +        * If min_seq[type] of both anonymous and file is not increased,
>> +        * we can directly return false to avoid unnecessary checking
>> +        * overhead later.
>> +        */
> 
> I think we can make this comment (and probably the commit message) even simpler.
> 
> try_to_inc_min_seq (and inc_min_seq) are both called under lru_lock,
> so I don't think there can be any concurrent modifications going on.
> (Note readers don't necessarily take the lock though.) So I think we
> can simply state it like:
> 
> "If we didn't change any min_seq, we can return immediately."
> 
> This patch had caused me to think we can do even more to make this
> function simpler, but I spent an hour fiddling with it and I don't
> have any concrete suggestions. So, I see no reason to hold up this
> patch, it seems straightforwardly correct to me. Any further
> simplification could just be a follow up patch later.
> 
> You can take:
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> 

Hi, Andrew

Could you please replace the V1 version in mm-unstable branch with this 
patch v2?

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-unstable&id=0163463f9dcc965060c5f51de69727d1b21d2b2b

Patch v2 looks more reasonable.

Thanks,
Hao



>> +       if (!seq_inc_flag)
>> +               return success;
>> +
>>          /* see the comment on lru_gen_folio */
>>          if (swappiness && swappiness <= MAX_SWAPPINESS) {
>>                  unsigned long seq = lrugen->max_seq - MIN_NR_GENS;
>> --
>> 2.34.1
>>

