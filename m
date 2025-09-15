Return-Path: <linux-kernel+bounces-815937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB36B56D31
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 02:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7047174310
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 00:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7D1B7F4;
	Mon, 15 Sep 2025 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="Nf17uVjF"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76EA18E3F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757895124; cv=none; b=V8+pZ/oS1ZWEdmcB8YA1iB/wJYn5DL5s9PzUZfW9zFsqAj+8ewaU8m8cnYZ0GTxKOqIQtEL2txFOBWsyL25/BOGZQyihH/i95MgT4pFHcqLddgBG3jqJp3cgKQP5SyQNzUnmzBdHJkM5JCRBPKqISjdNjGsFV5NHDZDqbMesO2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757895124; c=relaxed/simple;
	bh=K4jUtbsS31F+nKu5HmQ161GmYG+pjA6bgHx2t2beidI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mg6551OywUvJm8JdQvk+YWrKBEMHgSlPJZbywOTyJTSi1IvEXh4LtF8c+Q/VX/6BtO8Fkvn2igQRELkwU160rDAZ/+4Rfxzhzc+AGYNU0FseBOjJo/RL3YIst3oGqR1buXzcxJx+pq3p4ptAZcglnLA3jihuW6mY7WpLuMgzrMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=Nf17uVjF; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757895119;
	bh=5wZeKHLWAwfFq1meT4JSzn5DJcnCf93wpV/LX6CmoEk=;
	h=From:Subject:Date:Message-ID;
	b=Nf17uVjFlqDqlWbDdHCRSiw0DMiyfF5GsFJS1IL6H9NG5wxqD5FChmNXDVt8Nknyu
	 +Kd8Q/8mzbHfyddj733Dh4Qfrofp5aKja1Bx5aryoIdTrr+XV6JaTiGV80jzYJfKoE
	 5fssC25DRGUHEVzSrQehw4sr36aBxtScIE2VG5b4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68C759C500006D5A; Mon, 15 Sep 2025 08:11:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9332576292041
X-SMAIL-UIID: 82896157B1B5426AAAB2321325B5AA6B-20250915-081150-1
From: Hillf Danton <hdanton@sina.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/14] slab: add opt-in caching layer of percpu sheaves
Date: Mon, 15 Sep 2025 08:11:37 +0800
Message-ID: <20250915001139.7101-1-hdanton@sina.com>
In-Reply-To: <bbdb72e1-ada9-44e2-9ec1-53fd6ed92e84@suse.cz>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 14 Sep 2025 22:24:19 +0200 Vlastimil Babka wrote:
>On 9/14/25 04:22, Hillf Danton wrote:
>> On Wed, 23 Jul 2025 15:34:34 +0200 Vlastimil Babka wrote:
>>> +
>>> +/*
>>> + * Caller needs to make sure migration is disabled in order to fully flush
>>> + * single cpu's sheaves
>>> + *
>> This misguides, see below for a workqueue case.
>> 
>>> + * must not be called from an irq
>>> + *
>>> + * flushing operations are rare so let's keep it simple and flush to slabs
>>> + * directly, skipping the barn
>>> + */
>>> +static void pcs_flush_all(struct kmem_cache *s)
>>> +{
>>> +	struct slub_percpu_sheaves *pcs;
>>> +	struct slab_sheaf *spare;
>>> +
>>> +	local_lock(&s->cpu_sheaves->lock);
>>> +	pcs = this_cpu_ptr(s->cpu_sheaves);
>>> +
>>> +	spare = pcs->spare;
>>> +	pcs->spare = NULL;
>>> +
>>> +	local_unlock(&s->cpu_sheaves->lock);
>>> +
>>> +	if (spare) {
>>> +		sheaf_flush_unused(s, spare);
>>> +		free_empty_sheaf(s, spare);
>>> +	}
>>> +
>>> +	sheaf_flush_main(s);
>>> +}
>>> +
>>> @@ -3326,30 +3755,18 @@ struct slub_flush_work {
>>>  static void flush_cpu_slab(struct work_struct *w)
>>>  {
>>>  	struct kmem_cache *s;
>>> -	struct kmem_cache_cpu *c;
>>>  	struct slub_flush_work *sfw;
>>>  
>>>  	sfw = container_of(w, struct slub_flush_work, work);
>>>  
>>>  	s = sfw->s;
>>> -	c = this_cpu_ptr(s->cpu_slab);
>>>  
>>> -	if (c->slab)
>>> -		flush_slab(s, c);
>>> +	if (s->cpu_sheaves)
>>> +		pcs_flush_all(s);
>>>  
>> Migration is not disabled.
>
> Can you elaborate how it's not? There's a comment above the function saying
> "Called from CPU work handler with migration disabled." and we have relied
> on this before sheaves. queue_work_on() says it will run on the specific
> cpu. AFAIK the workqueue workers are bound which is effectively disabled
> migration (we hold the cpu hotplug lock).
>
CPU affinity and migration_disable() are two different things regardless of
queue_work_on(), no?
I think you are right in accident rather than by design in this case.

