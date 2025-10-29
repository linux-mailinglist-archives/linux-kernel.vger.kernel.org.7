Return-Path: <linux-kernel+bounces-877098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F2CC1D30D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB343B6855
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C34535BDCE;
	Wed, 29 Oct 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gbNivlUO"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2EB35BDB2
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769576; cv=none; b=ph1HY6JajJvIwaaiVzJw4hwZc+r3O+fZvkhn6nL867rOiXcjWDfaS2N633XMoOUBSF9OrIBkY9NqvG+cg9loP16jR0++bSGYfY9y6HmrF5XIupgWdzoWfM9qiWTSU4HRVOuxSfn04cf/v60mFoxvT9XjV5wWt4FTJ+d2YgAD8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769576; c=relaxed/simple;
	bh=g8udJnBf5qbbGeAHshH34t9fLGoHs/m2ZKo5Ipuc9QU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hn3SfgQD2TMCcZpZfI3PThxUUvoz80EhwFe1FMDPaIn2htPYQvag13ZP1aCbIAR0RYEEwcHe3Gjm9Gbu2ffsPv5eyrcrmVc3eJ39rW0lNSzUj4bfytKl5k6CX1zW9Tx82rC5ZMquTi356bKwqHCOu1aVCpGASK7Opr51A64/Ajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gbNivlUO; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761769562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LQMYVbeSSNK8HEpygcBXhLqfLwBAFQnmbjr1eMUwF0=;
	b=gbNivlUO+akpnki/DzJK4tKIph6Rnah2FtAYOZAFV/5Wv7eVnDwIZPm8p3A2ydfKREWBhG
	3FthTNlzbIfe+q5R50wA4HQ5Vk39t3AnmZyZ82mAHwVMj6FtGgEUrXCsjHi9Le98UFePqh
	M5/4hadwC/JHzm9H8+Xd3qivsGT3owI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
In-Reply-To: <aQJZgd8-xXpK-Af8@slm.duckdns.org> (Tejun Heo's message of "Wed,
	29 Oct 2025 08:14:25 -1000")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-3-roman.gushchin@linux.dev>
	<aQJZgd8-xXpK-Af8@slm.duckdns.org>
Date: Wed, 29 Oct 2025 13:25:52 -0700
Message-ID: <87ldkte9pr.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Tejun Heo <tj@kernel.org> writes:

> Hello,
>
> On Mon, Oct 27, 2025 at 04:17:05PM -0700, Roman Gushchin wrote:
>> @@ -1849,6 +1849,7 @@ struct bpf_struct_ops_link {
>>  	struct bpf_link link;
>>  	struct bpf_map __rcu *map;
>>  	wait_queue_head_t wait_hup;
>> +	u64 cgroup_id;
>>  };
>
> BTW, for sched_ext sub-sched support, I'm just adding cgroup_id to
> struct_ops, which seems to work fine. It'd be nice to align on the same
> approach. What are the benefits of doing this through fd?

Then you can attach a single struct ops to multiple cgroups (or Idk
sockets or processes or some other objects in the future).
And IMO it's just a more generic solution.

Thanks!

