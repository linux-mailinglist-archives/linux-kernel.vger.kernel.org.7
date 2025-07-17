Return-Path: <linux-kernel+bounces-735640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E12B091F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255B616D1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EA329B8DD;
	Thu, 17 Jul 2025 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="QJnXAQNo"
Received: from dragonfly.ash.relay.mailchannels.net (dragonfly.ash.relay.mailchannels.net [23.83.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD1A1DA62E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770149; cv=pass; b=X6bBRQDIwMY/FkJz0vAtOWVucGBoVkhUGK1krZxun1CH5CFBijjgQ8B6rYwlPIT5Fs8dL4qg1m6g0+zcpyrFKkEm6Jv06NYWruLJAYgS4yeR1eLzChn98DJet/1s5VFbYdIrJ48CCvSUba8BAJmXEP1HNQxAo9xWXK4KMT5nJNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770149; c=relaxed/simple;
	bh=TjAUKPg3s94AVD0qrRLkFRg+7hx3mM0XIdYo4zioyzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bX6HWeCoampb/SFwjzwqKr2HB9xU8xiSyVm7NaoDwPOOPYgXyzItJ/KfqNm0/twPrwzpqjH1R0qLPtCGy410DHIxgxpFqZD59ly8wuflNjjyUAy4RWLkfK1dTrOFLwsw7kBN97CbI2sEI1KBljuAIUQ6M0WrUO2LbPCPKLjQdAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=QJnXAQNo; arc=pass smtp.client-ip=23.83.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 5714F903719;
	Thu, 17 Jul 2025 16:35:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (trex-blue-9.trex.outbound.svc.cluster.local [100.110.255.229])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id CB3CD903266;
	Thu, 17 Jul 2025 16:35:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1752770139; a=rsa-sha256;
	cv=none;
	b=easI32EAJmBC0rdmHdg/Iv+EupGxUfEpIEkShOqrpekCFa68Bkh30u3Kt6JHZ5ZqQmuJ4h
	EXi9w7ACojvqHNq5o/Wl/0GqtiVxMD8PzVIDaJvkMNUhCVuQCZ58obNAaX5NqL/VyOSDn0
	0aV/na6bnqAyzjOQXjq/X66iwqOve6RzGkymut73bK/Kqfz3Ul8cVGeGk10/Z0Qn2PeEnW
	eJD8I/Rl31t1doVoIJWBZ3Na2KqKJl2XSuCoSujoNPHvZszb4zNl3UzMTZKtvrxLAG7fej
	0I+nM/C3iRsnFDovz3JOZYb6TFV777muHuxaEP53btHxh3lytENCJ1zKor+b5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1752770139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3KPdk7m9moclQwH9ISuclMP8fjLIKhxZaQ1PFqFVL0A=;
	b=tWAGyMjpS/DeFcG7/4+/gYizbfuC2b+9IL5dplQl8zrq8+8Zqo+arBGdVLpv+9G7JzhuaK
	anvWy1ObYTC6AOLRTPcPifJKZndZgzdDpffd70teNtkFMHKIS+zmrDQztuwN0gYxQhWhMz
	Z3NXfDYPkk9QjZ1z2kp3vFkbWhIWk6aDdmbNHft3C+tbPfy+2ezG/V00ZNAdKYwKMe8oBL
	fBtm/p5FDeEaR20bdfiVwP4KyX5ZIb6ZNfL7AbD2A1ctsyyTklhkshbM3opd+Akz8j1nzJ
	zP5R/8iO75Eb4udlim0mc/LE65hXSPzkA4XcDX9aHk+mObBLbz3ksH8W/Gw9XQ==
ARC-Authentication-Results: i=1;
	rspamd-5c976dc8b-9hw78;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Robust-Coil: 626dcbe431fd644b_1752770140119_3985904764
X-MC-Loop-Signature: 1752770140119:957927492
X-MC-Ingress-Time: 1752770140119
Received: from pdx1-sub0-mail-a235.dreamhost.com
 (sub3.homie.mail.dreamhost.com [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.110.255.229 (trex/7.1.3);
	Thu, 17 Jul 2025 16:35:40 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4bjdp31Nb5zFr;
	Thu, 17 Jul 2025 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1752770139;
	bh=3KPdk7m9moclQwH9ISuclMP8fjLIKhxZaQ1PFqFVL0A=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=QJnXAQNo+o35PCcaBoPhSa8KsmLyQG7i31+c4LMi9BeLQOuMO0IMtUal0m5z1fCf6
	 OQrxlPRBHhbAFkmtFWE+obFZJoPZK32TUUTlh8+CgP9FSxH50YiHGPZWHVx2uiO1h9
	 PU/4fWGgE5wIRxpIBRtvs0BEPIhFzrDRlxbiFsC4gsaTPCfXKtpEM4HfgmXqYNtSeY
	 /94DixDPhwWo7qaKoBQ1aqV1FMfCoXJr5ObvMEyGVmd3D0/crtHJp+DMh/kMKCPQfW
	 yn67tzfncrNJi2Urg8bWtISDejIk/drZFy2MhZkxAm1wocHRPCQT99OGU9n4Kyasoh
	 H53KSNBG1WEDw==
Date: Thu, 17 Jul 2025 09:35:36 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, yosryahmed@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/memcg: make memory.reclaim interface generic
Message-ID: <20250717163536.6jwhdzpb5a4elm4z@offworld>
Mail-Followup-To: Roman Gushchin <roman.gushchin@linux.dev>,
	akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	shakeel.butt@linux.dev, yosryahmed@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20250623185851.830632-1-dave@stgolabs.net>
 <20250623185851.830632-3-dave@stgolabs.net>
 <87bjpjshn7.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87bjpjshn7.fsf@linux.dev>
User-Agent: NeoMutt/20220429

On Wed, 16 Jul 2025, Roman Gushchin wrote:

>Davidlohr Bueso <dave@stgolabs.net> writes:
>
>> This adds a general call for both parsing as well as the
>> common reclaim semantics. memcg is still the only user and
>> no change in semantics.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  mm/internal.h   |  2 +
>>  mm/memcontrol.c | 77 ++------------------------------------
>>  mm/vmscan.c     | 98 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 104 insertions(+), 73 deletions(-)
>> ...
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index c13c01eb0b42..63ddec550c3b 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -57,6 +57,7 @@
>>  #include <linux/rculist_nulls.h>
>>  #include <linux/random.h>
>>  #include <linux/mmu_notifier.h>
>> +#include <linux/parser.h>
>>
>>  #include <asm/tlbflush.h>
>>  #include <asm/div64.h>
>> @@ -6714,6 +6715,15 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>>
>>  	return nr_reclaimed;
>>  }
>> +#else
>> +unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>> +					   unsigned long nr_pages,
>> +					   gfp_t gfp_mask,
>> +					   unsigned int reclaim_options,
>> +					   int *swappiness)
>> +{
>> +	return 0;
>> +}
>>  #endif
>>
>>  static void kswapd_age_node(struct pglist_data *pgdat, struct scan_control *sc)
>> @@ -7708,6 +7718,94 @@ int node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned int order)
>>
>>  	return ret;
>>  }
>> +
>> +enum {
>> +	MEMORY_RECLAIM_SWAPPINESS = 0,
>> +	MEMORY_RECLAIM_SWAPPINESS_MAX,
>> +	MEMORY_RECLAIM_NULL,
>> +};
>> +static const match_table_t tokens = {
>> +	{ MEMORY_RECLAIM_SWAPPINESS, "swappiness=%d"},
>> +	{ MEMORY_RECLAIM_SWAPPINESS_MAX, "swappiness=max"},
>> +	{ MEMORY_RECLAIM_NULL, NULL },
>> +};
>> +
>> +int user_proactive_reclaim(char *buf, struct mem_cgroup *memcg, pg_data_t *pgdat)
>> +{
>> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
>> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
>> +	int swappiness = -1;
>> +	char *old_buf, *start;
>> +	substring_t args[MAX_OPT_ARGS];
>> +
>> +	if (!buf || (!memcg && !pgdat))
>> +		return -EINVAL;
>> +
>> +	buf = strstrip(buf);
>> +
>> +	old_buf = buf;
>> +	nr_to_reclaim = memparse(buf, &buf) / PAGE_SIZE;
>> +	if (buf == old_buf)
>> +		return -EINVAL;
>> +
>> +	buf = strstrip(buf);
>
>To be honest, not a big fan of this refactoring. Effectively parts of
>the memcg user interface are moved into mm/vmscan.c. I get that you want
>to use the exact same interface somewhere else, but still...

I disagree, further this is no different than other callers in vmscan.c
around memcg.

>Is it possible to keep it in mm/memcontrol.c?

Why? now proactive reclaim is not special to memcg... unless strong reasons
it makes little sense to keep it there.

>Also maybe split the actual reclaim mechanism and user's input parsing?

I tried something like this initially, and ended up prefering this way.

Further, this approach limits the reachability of the input parsing logic, and
the interface is already being an exception to the one-value per file "rule".

Thanks,
Davidlohr

