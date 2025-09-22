Return-Path: <linux-kernel+bounces-827910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67934B93673
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA0917A587
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670002DEA68;
	Mon, 22 Sep 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnP47hnX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC025A34F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758577906; cv=none; b=CAX/sbm4w9b+m5+Yk1k8EEayVx9LyCIYhTUA7kUfmlEYojZwydI54BO8N/WP0Cz9TdxcPaZRuo0ulwfUL+MylIS7V0D1CHi4qGdXGUR1hLrB4kZG9O3wEveor+gVUOD6OthQ89AxGu34fMUztxA/BHQo3hq/boMZJEtVZZF41O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758577906; c=relaxed/simple;
	bh=IO+2VJI4ZMWwrOEJVHLzPh+dWD6p3JDoCjrwZpVkmHA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W8kPpp/2TxLG/893dawOwoPIhPsqrvUox2w9vEVZ9qG9W407/u7Wz4FLGKUBvBOOzVuXsOXO62wId/jKv3I7BYprTqZq8+jnp3cg08t6pOKzzkgTDdwmYso/6N8oqHyKLeWAoLiUJ3l+EXCwN5gMaLeXIVMFc0qUfEeJnhNWVl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnP47hnX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758577904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FEinhsYu5ZAzzk9ZjrHV61k9LGkgCm2NxTV8yeK83cc=;
	b=hnP47hnXJOhxb3/VmTwR7sAj+ymhfMGtm/GL4R5JlMvdjiUQe9aV0I6j5GZ5o35mR2OhXs
	8noZK0NTTzTSjk3uj2UWYh9naSvhbXcc4VTry5hn3dafERUk4zpipdsz42NvlBeXLsLscC
	5LKG16WlD2z4HIokLDUhXY+jP5QdrNA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-c7WeH9-OMx25AhfeVAHS1g-1; Mon, 22 Sep 2025 17:51:42 -0400
X-MC-Unique: c7WeH9-OMx25AhfeVAHS1g-1
X-Mimecast-MFC-AGG-ID: c7WeH9-OMx25AhfeVAHS1g_1758577902
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-81ea2cb6f13so962822585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758577902; x=1759182702;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEinhsYu5ZAzzk9ZjrHV61k9LGkgCm2NxTV8yeK83cc=;
        b=Av5mOK0zK5riIf1rHjT9aLIfgIgNaaEkdRLj6u+gz0IoBy9R/cxwTxTXsVwngQv8wM
         43S0W5/Gzijsna/JD7y8BXF/KxwgGUr6YR/MFa6GKpWsbyiSfBkbc6IbmfqwJy6J5/Km
         M2Fax+LrqtKcMn9dek0CaIuBBrL3zR0lGQi6jryomQJ9U61f9FE10qKfOy4r0tiEvs4j
         vCisYXB9kJa3BgScQ7/c8txGyxbeeVwnFor35h+12ukXKFwR/x2496uWEh1hpNhgPxR3
         VHjoYFCQdd6R8ChbqLfTdU2EM+1lXR3Je5NUwvQs05wdeomMveaRgKziKv5Bb2NzW3W5
         IGNA==
X-Gm-Message-State: AOJu0YwttH2znT6KluKWcgplhJk4oNXY9FO2nLUUysRT/TWxATQNg3Su
	aQTQujsjY2XAsSNHQlA30IIgVJyhJHTC46VZIU0IzrYslTCopCO6R3M9zmCC/I0KI2e4yarLyaR
	cKlPn3EtKo33PstEKrbfJbobjQwkODTSrJ0NzkLSjXuttkle+TDUMiDHASgtxm91dXkNK+8DWPA
	==
X-Gm-Gg: ASbGnctblcuk7d3ZPtOJEZuHQIXpDNaY96vnQ0oUNJx2YMDwNM5+yIXL49laRcDr2kD
	9QG9L2qAiCJceLtyFLlpfmT0QY+LLEm3NN86NgZ8fftt4v//O4pCjxXaG5S2ExpJV9AgjYvEWX0
	umNlkRm1GxylI76JhSfLxoQo+C4bbSqrxjL6Qz5/vwZBRYB0Uo+8ZymPCh04vW8L4eACjodroDw
	oUBk84SDVmoV1ZwQObeAgy7v2v5vBvrruLsnKPCndMNsMnY6h6NtX4GBxYx6hhVvUT0Uj6+9OCC
	fN/0rw/FVnDrNvQQAYlIx+/cisOPTrse82/Pq0Agl1MAZwa7awWW9/VsCEWNt0S6yXkvgsgFbRH
	bboxQoRpK3uA=
X-Received: by 2002:a05:620a:2687:b0:833:b213:c062 with SMTP id af79cd13be357-85173701bf6mr62639885a.40.1758577901710;
        Mon, 22 Sep 2025 14:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJb1ojM9Iwcf/vhwYlmDHzcaqEu1qarCseJ6sSvAXpTXynFpjhKro6kJnwCmmx+9EwGXyDTw==
X-Received: by 2002:a05:620a:2687:b0:833:b213:c062 with SMTP id af79cd13be357-85173701bf6mr62637285a.40.1758577901241;
        Mon, 22 Sep 2025 14:51:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8363198b0fbsm869143885a.50.2025.09.22.14.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:51:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f1545ac2-9a4e-49e9-b918-205f617ec900@redhat.com>
Date: Mon, 22 Sep 2025 17:51:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] PCI: Protect against concurrent change of
 housekeeping cpumask
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, linux-pci@vger.kernel.org
References: <20250829154814.47015-1-frederic@kernel.org>
 <20250829154814.47015-3-frederic@kernel.org>
 <458c5db8-0c31-4c02-9c41-b7eca851d04a@redhat.com>
 <aMwQcVZeTwuk2Q8A@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aMwQcVZeTwuk2Q8A@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/18/25 10:00 AM, Frederic Weisbecker wrote:
> Le Fri, Aug 29, 2025 at 06:01:17PM -0400, Waiman Long a écrit :
>> On 8/29/25 11:47 AM, Frederic Weisbecker wrote:
>>> HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
>>> therefore be made modifyable at runtime. Synchronize against the cpumask
>>> update using RCU.
>>>
>>> The RCU locked section includes both the housekeeping CPU target
>>> election for the PCI probe work and the work enqueue.
>>>
>>> This way the housekeeping update side will simply need to flush the
>>> pending related works after updating the housekeeping mask in order to
>>> make sure that no PCI work ever executes on an isolated CPU.
>>>
>>> Signed-off-by: Frederic Weisbecker<frederic@kernel.org>
>>> ---
>>>    drivers/pci/pci-driver.c | 40 +++++++++++++++++++++++++++++++---------
>>>    1 file changed, 31 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>> index 63665240ae87..cf2b83004886 100644
>>> --- a/drivers/pci/pci-driver.c
>>> +++ b/drivers/pci/pci-driver.c
>>> @@ -302,9 +302,8 @@ struct drv_dev_and_id {
>>>    	const struct pci_device_id *id;
>>>    };
>>> -static long local_pci_probe(void *_ddi)
>>> +static int local_pci_probe(struct drv_dev_and_id *ddi)
>>>    {
>>> -	struct drv_dev_and_id *ddi = _ddi;
>>>    	struct pci_dev *pci_dev = ddi->dev;
>>>    	struct pci_driver *pci_drv = ddi->drv;
>>>    	struct device *dev = &pci_dev->dev;
>>> @@ -338,6 +337,19 @@ static long local_pci_probe(void *_ddi)
>>>    	return 0;
>>>    }
>>> +struct pci_probe_arg {
>>> +	struct drv_dev_and_id *ddi;
>>> +	struct work_struct work;
>>> +	int ret;
>>> +};
>>> +
>>> +static void local_pci_probe_callback(struct work_struct *work)
>>> +{
>>> +	struct pci_probe_arg *arg = container_of(work, struct pci_probe_arg, work);
>>> +
>>> +	arg->ret = local_pci_probe(arg->ddi);
>>> +}
>>> +
>>>    static bool pci_physfn_is_probed(struct pci_dev *dev)
>>>    {
>>>    #ifdef CONFIG_PCI_IOV
>>> @@ -362,34 +374,44 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>>>    	dev->is_probed = 1;
>>>    	cpu_hotplug_disable();
>>> -
>>>    	/*
>>>    	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
>>>    	 * device is probed from work_on_cpu() of the Physical device.
>>>    	 */
>>>    	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>>>    	    pci_physfn_is_probed(dev)) {
>>> -		cpu = nr_cpu_ids;
>>> +		error = local_pci_probe(&ddi);
>>>    	} else {
>>>    		cpumask_var_t wq_domain_mask;
>>> +		struct pci_probe_arg arg = { .ddi = &ddi };
>>> +
>>> +		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
>>>    		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
>>>    			error = -ENOMEM;
>>>    			goto out;
>>>    		}
>>> +
>>> +		rcu_read_lock();
>>>    		cpumask_and(wq_domain_mask,
>>>    			    housekeeping_cpumask(HK_TYPE_WQ),
>>>    			    housekeeping_cpumask(HK_TYPE_DOMAIN));
>>>    		cpu = cpumask_any_and(cpumask_of_node(node),
>>>    				      wq_domain_mask);
>>> +		if (cpu < nr_cpu_ids) {
>>> +			schedule_work_on(cpu, &arg.work);
>>> +			rcu_read_unlock();
>>> +			flush_work(&arg.work);
>>> +			error = arg.ret;
>>> +		} else {
>>> +			rcu_read_unlock();
>>> +			error = local_pci_probe(&ddi);
>>> +		}
>>> +
>>>    		free_cpumask_var(wq_domain_mask);
>>> +		destroy_work_on_stack(&arg.work);
>>>    	}
>>> -
>>> -	if (cpu < nr_cpu_ids)
>>> -		error = work_on_cpu(cpu, local_pci_probe, &ddi);
>>> -	else
>>> -		error = local_pci_probe(&ddi);
>>>    out:
>>>    	dev->is_probed = 0;
>>>    	cpu_hotplug_enable();
>> A question. Is the purpose of open-coding work_on_cpu() to avoid calling
>> INIT_WORK_ONSTACK() and destroy_work_on_stack() in RCU read-side critical
>> section? These two macro/function may call debugobjects code which I don't
>> know if they are allowed inside rcu_read_lock() critical section.
>>
>> Cheers, Longman
> No the point is that I need to keep the target selection
> (housekeeping_cpumask() read) and the work queue within the same
> RCU critical section so that things are synchronized that way:
>
>      CPU 0                                          CPU 1
>      -----                                          -----
>      rcu_read_lock()                                housekeeping_update()
>      cpu = cpumask_any(housekeeping_cpumask(...))       housekeeping_cpumask &= ~val
>      queue_work_on(cpu, pci_probe_wq, work)             synchronize_rcu()
>      rcu_read_unlock()                                  flush_workqueue(pci_probe_wq)
>      flush_work(work)
>          
> And I can't include the whole work_on_cpu() within rcu_read_lock() because
> flush_work() may sleep.

Right, you are trying to avoid flush_work() within rcu_read_lock() 
critical section. It makes it easier to review if you mention that in 
the commit log.

>
> Also now that you mention it, I need to create that pci_probe_wq and flush it :-)

OK, another wq :-)

Cheers,
Longman


