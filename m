Return-Path: <linux-kernel+bounces-589228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A282A7C361
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 21:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A6D178E53
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 19:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF2121C17B;
	Fri,  4 Apr 2025 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWM0A95p"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051D1F5423
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793276; cv=none; b=Fa9GW9lXh1Bs/slECRFSGrqqL36CIxgk+gzilFb6ZXJA3XUan61g76gEw9jvagd+EsSGlB8nQ5UGlPEMjdQtWbbuIbbk14+Ov+21tm07i0Wo0rN9XLzZJluqZdjLCaXeIX2sQt69OxMbS0fGw9pzkyZTLoTE7NO1Ljzsg7y7Mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793276; c=relaxed/simple;
	bh=1pLMCas5pwDT0a+/nUAiGb02bobVqC03NTC9w4ajQfM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UgtAgzldRcfB2pbxJi0GyLeZcpoNXvEHJehnogKQdrMczaBQQnbSZZnMR0pJzzv+LsVdad0CbsKsVuibNGhtsyupztHxTse47kDv/m710n6mkByxCrCMFuYTahU9MUBbVq91Zm5miS9EIsJDJsdFbNuZjrNRqhCc0mEe4//nlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWM0A95p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743793273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1MMtNiDnolUZJhUSU3/9gDr+oQodav3erGGx1lsb/g=;
	b=jWM0A95pR0JmHQg9BVGRDbjVJhXtsf2LRWMDVumAaVvCwLpJjBbUyfCadaUVuo4TfkPovT
	NaI/D31prQHDWRrQLLL9csbka1O4X0oy0oE/dd3u7Wzi6rTZjoh4RKkTgu3jPCyiOuCbEI
	TzCnDSNNAYuXDuMRF0saxIy207AL4Vg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-QP4RGgBTOsm9qjD8iAWP1Q-1; Fri, 04 Apr 2025 15:01:11 -0400
X-MC-Unique: QP4RGgBTOsm9qjD8iAWP1Q-1
X-Mimecast-MFC-AGG-ID: QP4RGgBTOsm9qjD8iAWP1Q_1743793270
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c5c77aff55so551379185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Apr 2025 12:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743793270; x=1744398070;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1MMtNiDnolUZJhUSU3/9gDr+oQodav3erGGx1lsb/g=;
        b=gHGKg7qnFF4BdBuRalr3Ss0kf4sWwmVtoZr75SIMjkBpO+UM1Uv5wlXf8hNCRmRzdc
         XdYmrIt5jWPiBcJMvXW1HjCfAayO4MJZBRgg8TDeSQKmbui9N7wG5Fip1yqdMK4KZCmA
         htRurpJlTZsnizYZEn9TUUw2bKpsR6iq6A4TkDH6lV5EHxVr4CkI3n/tuNsMQFfRnm4R
         de4cDk0cYYvt3yRX0NycGdhnPbebrmUg7lL+xwHkUPL6jpZtbsa7Ao3ktqgYsgjWSOuz
         Um2ib/kamTLQojItTdQjdg09T6Vv1D9PrFhbOhKypmzsDCDQwnKpr3AKJG2VgvZAxhQn
         umfw==
X-Forwarded-Encrypted: i=1; AJvYcCVReMYN0LZrLJVbBLGatXr2gcHdYHwUBOyN7KBkCIKDDi85HqcXaX1edinAwYsNlr7ZrGAIEPd46Qow6SI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3I3nXR0qaZtjFks3TQwjTPkdx+WqGQnoXH7sa2W4/WcEZxdgI
	uVszMgbLDM/wH6VGVcUfIpnbnNXEUceA6EyznruM1hH4q1r1RQVv5T546T+Dj3Tc0lAvKQvMSdV
	FH8NHCiJl02SJ1PhbFGuboLmSp0Nm6NrlSaG7qganzrLGeyMxF4jXazAOsYZeGg==
X-Gm-Gg: ASbGnctUKis3dWY8BUPqDqzpqKfpGCKRE8rHVRXBzBhnHtc/6G+oN334NhXctiLxMpk
	OPNlm2TdVltNIgrRVYMjtreCXWaK2J/yQMZprdqE/8q4GeQ22AfgvB4/G3N5H3KCbRzho90Z8wn
	EJavV5rM5ZSl6EpRRrwHDCtz46yb8nruXoVg3YFgoHNcQtLzCwvoiB9gMGnqUK4Js10Y2vhicTm
	F0PacdWiLHqCzK7VwBax7OqOU8oMA93fz+fiQd4F1H3zUoDebAl5FaaVqi7IVtTTQQBTVZ1smyQ
	3zkUQ0GWyitzSxbYdjQo2DpK50XbgojABXeK+LdM6rp1xhW5grypUzzo139+jA==
X-Received: by 2002:a05:620a:2846:b0:7c5:3b8d:9f34 with SMTP id af79cd13be357-7c774d71e83mr623397485a.34.1743793270582;
        Fri, 04 Apr 2025 12:01:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2pRizqiBzi0bsE2Dny26nsl1JiAGoprEnqGYgEVCSGkEWDheGOUcCAScM0Ciy8R9ST8/yug==
X-Received: by 2002:a05:620a:2846:b0:7c5:3b8d:9f34 with SMTP id af79cd13be357-7c774d71e83mr623393285a.34.1743793270255;
        Fri, 04 Apr 2025 12:01:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e5dc169sm255423485a.0.2025.04.04.12.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 12:01:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <89775280-c702-48cf-b430-07231759a8b7@redhat.com>
Date: Fri, 4 Apr 2025 15:01:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <tj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250404012435.656045-1-longman@redhat.com>
 <aopkqb4bd6sag5mgvnvmoojlsz47lxrgxav7lsywkzeqtb5pco@ptxoqnloplzi>
Content-Language: en-US
In-Reply-To: <aopkqb4bd6sag5mgvnvmoojlsz47lxrgxav7lsywkzeqtb5pco@ptxoqnloplzi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/4/25 2:26 PM, Michal Koutný wrote:
> Hello Waiman.
>
> On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long <longman@redhat.com> wrote:
>> 1) memory.low is set to 0, but low events can still be triggered and
>>     so the cgroup may have a non-zero low event count. I doubt users are
>>     looking for that as they didn't set memory.low at all.
> I agree with this reasoning, been there [1] but fix ain't easy (also
> consensus of whether such an event should count or not and whether
> reclaim should happen or not). (See also [2] where I had tried other
> approaches that _didn't_ work.)
>
>> 2) memory.low is set to a non-zero value but the cgroup has no task in
>>     it so that it has an effective low value of 0.
> There maybe page cache remaining in the cgroup even with not present
> task inside it.

For the test_memcontrol case, a cgroup is created but no task has 
already been moved into it. So the memory usage is 0. I agree that if a 
task has ever lived in the cgroup, the usage will not be 0. In that case 
memory reclaim is certainly justified.


>>     Again it may have a non-zero low event count if memory reclaim
>>     happens. This is probably not a result expected by the users and it
>>     is really doubtful that users will check an empty cgroup with no
>>     task in it and expecting some non-zero event counts.
> Well, if memory.current > 0, some reclaim events can be justified and
> thus expected (e.g. by me).
>
>> The simple and naive fix of changing the operator to ">", however,
>> changes the memory reclaim behavior which can lead to other failures
>> as low events are needed to facilitate memory reclaim.  So we can't do
>> that without some relatively riskier changes in memory reclaim.
>>
>> Another simpler alternative is to avoid reporting below_low failure
>> if either memory.low or its effective equivalent is 0 which is done
>> by this patch specifically for the two failed use cases above.
> Admittedly, I haven't seen any complaints from real world about these
> events except for this test (which was ported from selftests to LTP
> too).
>
>> With this patch applied, the test_memcg_low sub-test finishes
>> successfully without failure in most cases.
> I'd say the simplest solution to make the test pass without figuring out
> what semantics of low events should be correct is not to check the
> memory.events:low at all with memory_recursiveprot (this is what was
> done in the cloned LTP test).

Another alternative is to modify the test to allow non-zero event count 
even if low is not set.

Cheers,
Longman

>
> Michal
>
> [1] https://lore.kernel.org/all/20220322182248.29121-1-mkoutny@suse.com/
> [2] https://bugzilla.suse.com/show_bug.cgi?id=1196298


