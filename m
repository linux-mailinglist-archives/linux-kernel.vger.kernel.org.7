Return-Path: <linux-kernel+bounces-794596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEF6B3E3AD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8B61898315
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEEB326D59;
	Mon,  1 Sep 2025 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oN9NZVgu"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49CE2EF640
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730997; cv=none; b=GFg7JgBp5jnsYh5bUUHDfwGEYyfPdnj/YvNMXsK1JLoxVD6XlpzYCeexcKOjnJ9zCr5ZGCuV7bZI7AfCXskq0/UwblxKvIHvA7RYLHD3bGUox6PSXJqTUPHiRO0Y7YZOVaGg1SMtdQ+4gpy9VfsYMesHkJsbvwg3Yg5sUgqxlhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730997; c=relaxed/simple;
	bh=61kd+4Uh5eUaetLQwDmSpGhLikrHVTzdJBd+QsZ2wK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e++N3NT2ObUWp4gzlmfAWumuNW4yfd0sAPuoS5zDmfJgYbROrd7LlseT5AJ5+AMq8NyV/tWhSV3EEe5ktFZPFFPyojjij6S5wTdbw/eTo4r7pMjzF7QV+pHtg+SuHyE/Z7RvFcfHkgDLQQ90JV1+8dCs7DyVhIsGIST3cUMJSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oN9NZVgu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t3MQM1w3G9lfKRXuWcixWsGlqJJzDy54KOrmwwhieUc=; b=oN9NZVgup+nTqj9469cHbgMJmj
	pRuonB78Gb1VntfuZRq0k3nTtlYyeX7zSwdjbunEiUthcygKkQC1MDgzmXOzeShfbWKf+b2X5kyzg
	xpNnfO5BiuJfMh3/27v9wjLedLWhlPvsEVSqfQ2JF68yssB6yS24by3U6M69CQxOlClQ/0YWqho5f
	qEI7aBXtVCuCR6kIQU3be2zbvupbwvjfKBxspURQkvjHvi3TNUjNuavLAOC47OfowZta0qydoX2SL
	eo0/vKiNhI9rsSiti4EMOxDE/JNN0uswSUQhj60RLtHAGPPfJxTSOzUkpww0Sw2eCTXtn3j2/FKrU
	x/mSXSQg==;
Received: from [177.139.20.31] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ut3yJ-005Hj0-9N; Mon, 01 Sep 2025 14:49:19 +0200
Message-ID: <64deb0ae-5641-4ceb-889e-0ef1087175fb@igalia.com>
Date: Mon, 1 Sep 2025 09:49:14 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
To: Borislav Petkov <bp@alien8.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
 <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
 <61725722-f933-447c-a041-71b2d28e7f90@igalia.com>
 <20250828182037.qkdKVaTN@linutronix.de>
 <c61e7737-bfc7-4de8-962e-652aa3dbfd40@igalia.com>
 <20250829061624.sC9Bavj9@linutronix.de>
 <20250829100705.GBaLF7ycOvksu9H6KN@fat_crate.local>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250829100705.GBaLF7ycOvksu9H6KN@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Em 29/08/2025 07:07, Borislav Petkov escreveu:
> On Fri, Aug 29, 2025 at 08:16:24AM +0200, Sebastian Andrzej Siewior wrote:
>>> No objections merging Waiman fix first, but we are still in -rc3, so maybe
>>> there's time for the rework in this cycle?
> 
> ... and you can rework all you want. When your solution is ready and everyone
> agrees, there's nothing wrong with queueing it ontop or delaying it for the
> next merge window.
> 
>> On the regression list, we this one fallout in the testsuite. I would
>> like to get an easy fix for -rc4 and be done with it for this cycle.
> 
> There's absolutely no place for hurrying things, especially for self tests. So
> take your time pls.
> 

Sure, I don't want to hurry things, I'm just trying to understand better 
the rationale of having this for the next cycle, and if I would have to 
wait or not till the next kernel release to send the patch :)

