Return-Path: <linux-kernel+bounces-745335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD22B11895
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1611896329
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 06:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B0C288508;
	Fri, 25 Jul 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="azZIm4M5"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48015A41
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753425549; cv=none; b=MCSTwZs9tFOeTl4hkYoUsmzxLHqlDUNCSpOm5Wil/Xi6mzw1xG51nle5lCRXCYupiNv41hElqhJ8r1LBev76U0GMSHX+e+nWglEEWbfT2Nl1mqXiii2IH5dNwi6tLALt/cOgCj0lefqzZJYRD1oDlNJitR9sE3R8W6mE/2MjOEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753425549; c=relaxed/simple;
	bh=SGFb+mRHVwHmlxEO3z17lABhyFV2Je+wkO/IZuYWNbQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W7pBkQ705Y1Cejf4BYfp1bqd0iVvY/Pwb9zpSHF1mILQTsU1WuKspkXDRU9iMaR3AwH76nN2asOWdbvfHnSTVT1rIlljnzh0RTYhpLudIlkmMiy88OuETONSmMU9sh6smUS2Mc2g+y/c6Lnq4Utun4/uMjFbUGtGxbtngIUMWFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=azZIm4M5; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753425544; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=wNk6OPC1lu+j4/4Da2MNU71TbjdMfdCtRWdTsm81wLI=;
	b=azZIm4M5d9SY/RSxRzqBgwR8gT5QZAbvwVUw07yjPdUOsXpuu+MIgBKoiMRpjtEANVBfvpJoNeykV11d/uDOMShlZHMCxMV54tWPBLabYjTcL7eFpV/mLRI68RNEfl/vkV5xWB6cM3MEI4VuQlrZ6X+Ff3otkEaEb4dHEgg219o=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WjwBKdi_1753425542 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 14:39:03 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  lkp@intel.com,
  akpm@linux-foundation.org,  y-goto@fujitsu.com,  mingo@redhat.com,
  peterz@infradead.org,  juri.lelli@redhat.com,
  vincent.guittot@linaro.org,  dietmar.eggemann@arm.com,
  rostedt@goodmis.org,  mgorman@suse.de,  vschneid@redhat.com,  Li Zhijian
 <lizhijian@fujitsu.com>,  Ben Segall <bsegall@google.com>
Subject: Re: [PATCH RFC v3] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 counting
In-Reply-To: <982da1b2-0024-4c01-b586-02c0b8a41e95@fujitsu.com> (Shiyang
	Ruan's message of "Fri, 25 Jul 2025 10:20:44 +0800")
References: <20250722141650.1821721-1-ruansy.fnst@fujitsu.com>
	<87cy9r38ny.fsf@DESKTOP-5N7EMDA>
	<85d83be2-02f8-4ef6-91c7-ff920e47d834@fujitsu.com>
	<87wm7y3ur3.fsf@DESKTOP-5N7EMDA>
	<982da1b2-0024-4c01-b586-02c0b8a41e95@fujitsu.com>
Date: Fri, 25 Jul 2025 14:39:00 +0800
Message-ID: <87v7ng3hbv.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shiyang Ruan <ruansy.fnst@fujitsu.com> writes:

> =E5=9C=A8 2025/7/24 15:36, Huang, Ying =E5=86=99=E9=81=93:
>> Shiyang Ruan <ruansy.fnst@fujitsu.com> writes:
>>=20
>>> =E5=9C=A8 2025/7/23 11:09, Huang, Ying =E5=86=99=E9=81=93:
>>>> Ruan Shiyang <ruansy.fnst@fujitsu.com> writes:
>>>>
>>>>> From: Li Zhijian <lizhijian@fujitsu.com>
>>>>>
>>>>> =3D=3D=3D
>>>>> Changes since v2:
>>>>>     1. According to Huang's suggestion, add a new stat to not count t=
hese
>>>>>     pages into PGPROMOTE_CANDIDATE, to avoid changing the rate limit
>>>>>     mechanism.
>>>>> =3D=3D=3D
>>>> This isn't the popular place for changelog, please refer to other
>>>> patch
>>>> email.
>>>
>>> OK. I'll move this part down below.>
>>>>> Goto-san reported confusing pgpromote statistics where the
>>>>> pgpromote_success count significantly exceeded pgpromote_candidate.
>>>>>
>>>>> On a system with three nodes (nodes 0-1: DRAM 4GB, node 2: NVDIMM 4GB=
):
>>>>>    # Enable demotion only
>>>>>    echo 1 > /sys/kernel/mm/numa/demotion_enabled
>>>>>    numactl -m 0-1 memhog -r200 3500M >/dev/null &
>>>>>    pid=3D$!
>>>>>    sleep 2
>>>>>    numactl memhog -r100 2500M >/dev/null &
>>>>>    sleep 10
>>>>>    kill -9 $pid # terminate the 1st memhog
>>>>>    # Enable promotion
>>>>>    echo 2 > /proc/sys/kernel/numa_balancing
>>>>>
>>>>> After a few seconds, we observeed `pgpromote_candidate < pgpromote_su=
ccess`
>>>>> $ grep -e pgpromote /proc/vmstat
>>>>> pgpromote_success 2579
>>>>> pgpromote_candidate 0
>>>>>
>>>>> In this scenario, after terminating the first memhog, the conditions =
for
>>>>> pgdat_free_space_enough() are quickly met, and triggers promotion.
>>>>> However, these migrated pages are only counted for in PGPROMOTE_SUCCE=
SS,
>>>>> not in PGPROMOTE_CANDIDATE.
>>>>>
>>>>> To solve this confusing statistics, introduce this
>>>>> PGPROMOTE_CANDIDATE_NOLIMIT to count the missed promotion pages.  And
>>>>> also, not counting these pages into PGPROMOTE_CANDIDATE is to avoid
>>>>> changing the existing algorithm or performance of the promotion rate
>>>>> limit.
>>>>>
>>>>> Perhaps PGPROMOTE_CANDIDATE_NOLIMIT is not well named, please comment=
 if
>>>>> you have a better idea.
>>>> Yes.  Naming is hard.  I guess that the name comes from the
>>>> promotion
>>>> that isn't rate limited.  I have asked Deepseek that what is the good
>>>> abbreviation for "not rate limited".  Its answer is "NRL".  I don't kn=
ow
>>>> whether it's good.  However, "NOT_RATE_LIMITED" appears too long.
>>>
>>> "NRL" Sounds good to me.
>>>
>>> I'm thinking another one: since it's not rate limited, it could be
>>> migrated quickly/fast.  How about PGPROMOTE_CANDIDATE_FAST?
>> This sounds good to me, Thanks!
>
> Gemini 2.5 gave me a more radical name for it:
>
> /*
>  * Candidate pages for promotion based on hint fault latency. This counter
>  * is used by the feedback mechanism to control the promotion rate and
>  * adjust the hot threshold.
>  */
> PGPROMOTE_CANDIDATE,
> /*
>  * Pages promoted aggressively to a fast-tier node when it has sufficient
>  * free space. These promotions bypass the regular hotness checks and do
>  * NOT influence the promotion rate-limiter or threshold-adjustment logic.
>  * This is for statistics/monitoring purposes.
>  */
> PGPROMOTED_AGGRESSIVE,
>
> I think this one is concise and easy to understand with the
> comments. What do you think?  If this one is not appropriate, then I
> will go with "_NRL" as you suggested.

In fact, we still count candidate pages here.  Although there's enough
free space in the target node, the promotion may still fail for say
increased refcount.

---
Best Regards,
Huang, Ying

[snip]

