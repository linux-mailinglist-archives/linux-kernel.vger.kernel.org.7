Return-Path: <linux-kernel+bounces-775179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 673A9B2BC3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095D91BA4114
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B311DC9B1;
	Tue, 19 Aug 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+vdBjnv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB531195F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593547; cv=none; b=rCQMcHnp8Mllkm9uX44WlpWnGxKuFBprY5LDAVcoMnbRH9lrbLFTkuUacaYNPtgIZ7n3MWGMTF0DOWpaFad3+First5GsDQkjMilvsU9nRMANOhuJT83ER9lUZxSB7jJ1+ZFq9ifkmTGsfa7vYwFOibK7JfLb8JLIMF9zjYjeM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593547; c=relaxed/simple;
	bh=8qynzOk7SZnrvjGgxkgy4gcA54/cb76Z2k4kAl/qmG8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WjgKfBVNtcB5HLcZ1kVG+PULZ5wXmVvPBLsqtbHoFgScH/j2XBM72OZZdcjGLiK1XiprQIvFGGDqG5u6ssFxXwP6UqIJHEdsJKmdJlKHslkRy1Ohvkc7IwKLk0vw1SrfmQdhd7cJacZzUia/gqR/KWQYO9VPu4htEoLNLwhXWQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+vdBjnv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755593544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nMfPJVhYRkgSNVdCJ+8WIDN5pU06wtUOa0gmbNr7//Y=;
	b=K+vdBjnvtYwT4r+mguLTgTWiXfAl0NJ2K7mpx05IYgwCWouhxrcjRLSkDxZn6cqPhV9HbR
	DCnAY4qGI3QD+3hcwa5y4+swRUi2LaMTRwRQOZfMMoNYwcqyzP9qIyFeDAGMT9RV9njUu7
	zUvkx+XnHTuV9v/GIKyO6V5rleIZ8Us=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-O0D5vtUCMlmbMYreyQJ1rA-1; Tue, 19 Aug 2025 04:52:23 -0400
X-MC-Unique: O0D5vtUCMlmbMYreyQJ1rA-1
X-Mimecast-MFC-AGG-ID: O0D5vtUCMlmbMYreyQJ1rA_1755593542
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41b88ffso2289202f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593541; x=1756198341;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nMfPJVhYRkgSNVdCJ+8WIDN5pU06wtUOa0gmbNr7//Y=;
        b=NjJ2ewC0oXXtpnxqWJ1ZW0KocS1BHKmLADy+FJYjEDUITJINu4n5ghGS47DuJb7dqr
         0iHKy3KuxdwX5DK66EKhkqIN1gUHjHscNeyDCA7o0s5mJEuZbYGNGOu6O9JPmgGANcin
         c1ZMBLnNqhp82Yfnfkdd2ILDEeaubgvtKwUK0cMWnWJzJxPrh5qiOleMlEaoWLGBg74x
         hSmwX13GGLigF3HQos28ZqZAmyyacAIz9Q+e/iDjFrCf6lpMJ3Z9LvaUDV2KWjgV8crY
         VlJ/rj5lHycDvOkZBxHmvBps2tSQHl9/lQRPiaHupunFZlT202n2fYICTJJ8TTJylrt3
         6ebQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHTRkP+3jgvZzbsS33iwliuqs8cC8UftCqo8ZpkPiAThRmE3DrcglO9Z9Pfec01GMY/0QYTfQ+iigyBsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzcmEARZStOMUBMCSLC8AoL4II5UvR/Wx1LqgUpjIJuNScn5X
	cL1aevUpR1IGwIWq5J7CnN+ztVKkxEc0WJJEfVW62nAQeLaBwoFtvoGscqxzp3nJYL2755LDVBf
	2RNKwbJjmYlQJSc+HSCgCBG5utSC2gAd0abGJHUjK09tY3bsUES9jNDzpwXnJloNCIhdEqEqeaq
	4etpGEX57HNr1jg0vHB4BFesdQhSdhXAhCFE6di0oGE8xNz7QsYg==
X-Gm-Gg: ASbGnctiyLp0C4g3umZVdp2aTje0EjBtGIXcwTtv59QchBZr9fSd0DsKjECOHf1R1M1
	Z+wtEcAfiOUAUeC6J3aEZ8gNw8wZ/prFPAbZ6rC+g8QaqWgs9p5tpoCNvpPbmoa5AaJN9PboZHw
	97ZjFetnQoiq826gnN8j4cwMGafo/UC0Fds4whqUdSDKvipEYhbxffNYZOWYafXRY06gb3GpwLc
	eicbfyaj/TtyULWEvcBJ5Ni1SqLkY2o0elO7voTEUES5cUY2J7V9bpRlvgCuYd2AUMb9SGsN4dr
	n3eukIUauN+ynB9SpuZS/S5S22RanrXQ/JMHBNJ3sWcBsmWBI47+lRqcPBBw0U/AmKfSTnuKtjc
	YKApSZCU3apoNy8/kf86uVy+m
X-Received: by 2002:a05:6000:2505:b0:3b7:886b:fb76 with SMTP id ffacd0b85a97d-3c0ea2d9d46mr1227382f8f.12.1755593541028;
        Tue, 19 Aug 2025 01:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpsMozyolYxcGFZmKu36kwDoYOrtqJwrf9pgVmUIrcL/pxQqqlkI/eT/OMvf0Yme3WAqAf/A==
X-Received: by 2002:a05:6000:2505:b0:3b7:886b:fb76 with SMTP id ffacd0b85a97d-3c0ea2d9d46mr1227342f8f.12.1755593540507;
        Tue, 19 Aug 2025 01:52:20 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c57aa0sm2801982f8f.66.2025.08.19.01.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:52:19 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>, Yury Norov <yury.norov@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: simplify sched_init_numa()
In-Reply-To: <aH37LDGeNHoT9abR@linux.ibm.com>
References: <20250719210753.401129-1-yury.norov@gmail.com>
 <aH37LDGeNHoT9abR@linux.ibm.com>
Date: Tue, 19 Aug 2025 10:52:19 +0200
Message-ID: <xhsmh8qjfith8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 21/07/25 14:02, Srikar Dronamraju wrote:
> * Yury Norov <yury.norov@gmail.com> [2025-07-19 17:07:51]:
>
>> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>>
>> The function opencodes for_each_set_bit() macro.
>>
>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>> ---
>>  kernel/sched/topology.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index b958fe48e020..7dc3c79aa480 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -1932,10 +1932,9 @@ void sched_init_numa(int offline_node)
>>              return;
>>      }
>>
>> -	for (i = 0, j = 0; i < nr_levels; i++, j++) {
>> -		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
>> -		distances[i] = j;
>> -	}
>> +	for_each_set_bit(j, distance_map, NR_DISTANCE_VALUES)
>> +		distances[i++] = j;
>> +
>
> Dont we need to reset the value of i;
>

That.

> Also now we may be iterating for NR_DISTANCE_VALUES instead of nr_levels.
> It should be okay, since NR_DISTANCE_VALUES is just 8.
>

DISTANCE_BITS is 8, NR_DISTANCE_VALUES is 1 << 8 aka 256.

But here the use of for_each_set_bit() means we'll get just one extra
iteration compared to using `nr_levels`. That said, since we *have* to
compute `nr_levels` to allocate sched_domains_numa_distance, IMO we're not
gaining much by using for_each_set_bit() here.

>>      rcu_assign_pointer(sched_domains_numa_distance, distances);
>>
>>      bitmap_free(distance_map);
>> --
>> 2.43.0
>>
>
> --
> Thanks and Regards
> Srikar Dronamraju


