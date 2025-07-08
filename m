Return-Path: <linux-kernel+bounces-720722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D215AFBFB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A33B3B692B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C361E285A;
	Tue,  8 Jul 2025 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hSXvYdwi"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7A1E0083
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937256; cv=none; b=ANgHSvI/Lgb8262tmVzN4wobp15EZVLmedCeEym16vJiRRKY7CTiErkoAMyFBP76MYpA8DQ+3krPRiBo4m9mv3R27eQBz9PrWXutzFrUHx0Lze6b6lj8GvMd36sBXQzPeAXic/8tFe9Th02SDZLhx++IgPNF5D9j/aDYJ/h7Nbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937256; c=relaxed/simple;
	bh=YwPaOS5x2EKb8tK1pFEOHeYDlHV/6GGZzy/egOu7TaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGnHlbOU06ooNKj1TaQp4292maS3GGYBpQ0JOWxMwnKAJcjt15QMkYLpf8+33muU/SUrYH0ic/FY+4pU+iAOLXhxVQTtqdB67sQR3drqhQ+vf3Q1NojZy/HxESm4jI0Qt+g637zqE5f9p/xWZQZ4ogtPDdfEVGGtKyko7XeCEq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hSXvYdwi; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751937250; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=81k2TnA3ySuIrcjJ0C2twsaCPzS1HHoYg9nA+iYe+As=;
	b=hSXvYdwi87kyF07xumYFfzevEth82QdjlkUhNXqWXLW8FeQhQDteTFybWuhQEUjFJlIA/OwXOWP2khEnOv1sNw6iO5D0X+5IpNH+9d7DwFTVPE4HT4GtsHaqBkopTFdGn+ZUQLYoU+h3VA+9vXPEljxvIZIppGC/0Gk994EfY64=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WiIL1OC_1751937247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 09:14:08 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,  "Huang, Ying"
 <ying.huang@intel.com>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "Yasunori Gotou (Fujitsu)"
 <y-goto@fujitsu.com>,  Ingo Molnar <mingo@redhat.com>,  Peter Zijlstra
 <peterz@infradead.org>,  Juri Lelli <juri.lelli@redhat.com>,  Vincent
 Guittot <vincent.guittot@linaro.org>,  Dietmar Eggemann
 <dietmar.eggemann@arm.com>,  Steven Rostedt <rostedt@goodmis.org>,  Ben
 Segall <bsegall@google.com>,  Mel Gorman <mgorman@suse.de>,  Valentin
 Schneider <vschneid@redhat.com>,  "lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH RFC v2] mm: memory-tiering: Fix PGPROMOTE_CANDIDATE
 accounting
In-Reply-To: <e71873b6-78ac-4555-a6a5-e9b5fb3f9112@fujitsu.com> (Zhijian Li's
	message of "Mon, 30 Jun 2025 02:11:30 +0000")
References: <20250625021352.2291544-1-lizhijian@fujitsu.com>
	<e71873b6-78ac-4555-a6a5-e9b5fb3f9112@fujitsu.com>
Date: Tue, 08 Jul 2025 09:14:06 +0800
Message-ID: <87tt3nxz4x.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> Hi,
>
>
> On 25/06/2025 10:13, Li Zhijian wrote:
>> V2:
>> Fix compiling error # Reported by LKP
>> 
>> As Ying suggested, we need to assess whether this change causes regression.
>> However, considering the stringent conditions this patch involves,
>> properly evaluating it may be challenging, as the outcomes depend on your
>> perspective. Much like in a zero-sum game, if someone benefits, another
>> might lose.
>> 
>> If there are subsequent results, I will update them here.
>
> I ran memhog + pmbench to evaluate the impact of the patch(3 runs [1] for each kernel).
>
> The results show an approximate 4% performance increase in pmbench after applying this patch.
>
> Average     pmbench-access            max-promotion-rate
> Before:     7956805 pages/sec                168301 pages/sec
> After:      8313666 pages/sec (+4.4%)        207149 pages/sec

It's hard for me to understand why performance increases because of
higher promotion rate, while the expected behavior is more promotion
rate limiting.

> The detailed logs are available at [2].
>
> [1] https://github.com/zhijianli88/misc/blob/main/20250627/promotion-evaluation/reproduce.sh
> [2] https://github.com/zhijianli88/misc/tree/main/20250627/promotion-evaluation

[snip]

---
Best Regards,
Huang, Ying

