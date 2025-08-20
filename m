Return-Path: <linux-kernel+bounces-778629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAB5B2E834
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1035E0094
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150326B764;
	Wed, 20 Aug 2025 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nhOltoJ4"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1BD1D86DC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755729143; cv=none; b=oOMprYyPmNaW+0tjRxOJhzcD6pEDxVArNJV+5YAenoIwx5VJYZCWVRo0fg0vCakUKjYSQNSY8b46gQTzd6C4Suwl7qawppDvMfK56Oba35Spz6xXBUwp3iU0YI/jmu42XhTYDaHxbED/2oW4AXvssATSVnNXUffuSow8y/k362o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755729143; c=relaxed/simple;
	bh=N0IRlJS68kXvQ/sl+UPNiKXqYY0HXBsBdYbmkimwi+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CxCBUYgnlK+CRv8lmkC8BgQcQ+tAer+MI74/Qpf1xb6hli86pcUvMELjI02zPjO6v3Mp+WXiMpJlpnkjnULKodnzf/i2s1HvijtKreIF0KCQ2jMDuoEQ+5vcw/6H2uL/if4gf3gWCfOoUZhdhqPyhCYfKMa/lLXzNipfa9Tw2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nhOltoJ4; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755729138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N0IRlJS68kXvQ/sl+UPNiKXqYY0HXBsBdYbmkimwi+8=;
	b=nhOltoJ4OlfQcMaKWmmRjWVkN1LWfrmBEr3jVnKVeFjEL0v3Nf6H2CEUH8t+zgW9CNNX8c
	Gfkq2j6teAdetfJOQQDNE+3LTxJW+W/kyQkUzm6W4VEeS2knQRIkriUxcMmwkGYIEG14wO
	UUM2k+bTZdvN4tGUhY5/NeR/tQ4nAG4=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-mm@kvack.org,  bpf@vger.kernel.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Michal Hocko
 <mhocko@suse.com>,  David Rientjes <rientjes@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  Song Liu <song@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/14] bpf: mark struct oom_control's memcg field as
 TRUSTED_OR_NULL
In-Reply-To: <CAP01T767o1-KyhRLGcm8gXU5GiY8_OtifT6bNVfMuf+MT+3ZBw@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 20 Aug 2025 11:17:38
	+0200")
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
	<20250818170136.209169-3-roman.gushchin@linux.dev>
	<CAP01T767o1-KyhRLGcm8gXU5GiY8_OtifT6bNVfMuf+MT+3ZBw@mail.gmail.com>
Date: Wed, 20 Aug 2025 15:32:11 -0700
Message-ID: <87cy8ppqtw.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, 18 Aug 2025 at 19:01, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>>
>> Struct oom_control is used to describe the OOM context.
>> It's memcg field defines the scope of OOM: it's NULL for global
>> OOMs and a valid memcg pointer for memcg-scoped OOMs.
>> Teach bpf verifier to recognize it as trusted or NULL pointer.
>> It will provide the bpf OOM handler a trusted memcg pointer,
>> which for example is required for iterating the memcg's subtree.
>>
>> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
>> ---
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks!

