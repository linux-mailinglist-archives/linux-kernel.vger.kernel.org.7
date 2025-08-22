Return-Path: <linux-kernel+bounces-782627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F6DB322CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C44767A16D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDBE2D0C7F;
	Fri, 22 Aug 2025 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dLb4CQU1"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23729994B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755890878; cv=none; b=XIl5wD6Gb8T2XEQVMZCUT3Bk75+3EaESsRtXpeZLre17oUmajK5ghXRr+5Q5SDDXWA4J3+DgkbZZjGIZnBqxKRvYupO6oQC8QrL4bXSiHwstLF8kopSFul89gxnFA8/Wkz83HSzF5GNsqEu/zvbeWuKe6+vFQkMEZh0nczMlcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755890878; c=relaxed/simple;
	bh=M0P0HQ+EROChtcg44tr/Trj/AZjEl0C4MNocqhQSunQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgDWp1YtuNofmbDZUEC04QGXHwYTR/U6v3B8EB2VY4C828A+Y4gNP7mCxL+isnPIzv/004D+XDUBv+GX1iI6gF78P1Yt7VMeiRlSXtwTXJCGr1X1VHpefanhNhtw0tH8/FnPS6NALb6HplCb7dTFvU4IF64mZ4IParqKCHM/QSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dLb4CQU1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755890874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYNnmeG0XprxKHduPvXJ3NDXo6LkvZ9PXIZw0+i39Mw=;
	b=dLb4CQU1hdQ6WGWVNfKCXMj3e0QSc58PFH34wffAKQg7MGYRyXfGhinDJPLodwwg+E8S55
	COiW8FoozWMKc4A3ZD4LpWWcF1hW5y36YziTryHO0lB+0laZ4U6XnMOQAwTsCqEPrHI8+g
	XRL10qKJMbfZKT2pplmVc6EgeVI0VjA=
Date: Fri, 22 Aug 2025 12:27:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: linux-mm@kvack.org, bpf@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>,
 Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev>
 <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87ms7tldwo.fsf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/20/25 5:24 PM, Roman Gushchin wrote:
>> How is it decided who gets to run before the other? Is it based on
>> order of attachment (which can be non-deterministic)?
> Yeah, now it's the order of attachment.
> 
>> There was a lot of discussion on something similar for tc progs, and
>> we went with specific flags that capture partial ordering constraints
>> (instead of priorities that may collide).
>> https://lore.kernel.org/all/20230719140858.13224-2-daniel@iogearbox.net
>> It would be nice if we can find a way of making this consistent.

+1

The cgroup bpf prog has recently added the mprog api support also. If the simple 
order of attachment is not enough and needs to have specific ordering, we should 
make the bpf struct_ops support the same mprog api instead of asking each 
subsystem creating its own.

fyi, another need for struct_ops ordering is to upgrade the 
BPF_PROG_TYPE_SOCK_OPS api to struct_ops for easier extension in the future. 
Slide 13 in https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view

