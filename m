Return-Path: <linux-kernel+bounces-837034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F631BAB218
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174851924ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 03:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DFB222565;
	Tue, 30 Sep 2025 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K9C0DNLq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CE9145B16
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759201767; cv=none; b=R+Bz/nJNLd7094zAaVhZfzaaAJTtimSP0hXC/6WfHbipABNXGRVd0tSpHpR03QNxWGtZ2UXYxtABvVdC/p8KZ7pnIfG8K6HVljKFXe94jeEh6KNhkAio/301ek83LoMW8GHCH2L82IflOOtCj8OpQhDGMOlTWTa5INxyynFxoA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759201767; c=relaxed/simple;
	bh=ir1Dfv0OQ0zoI8KJx3sq3WxcK7QPjg5Mdm2BRYS2gtc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=Dt/57jhrAz88Zuq/+4KAt74/vAG9CzSadukwfTmMSAvNnW506Votm5okycJXHnKqECEp/LH37Sj8GvbVzn5SzBzNLEpAbMRbgtdiiTOTaFduc5cWuBlVyrMbbFkuXRMJPwfjV8gXMIGD8++MELfTx0Dtl+AH1oJT3h5qEz7A+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K9C0DNLq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759201764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iwEb4teAWr4346aj9TWXwrKmyiXrnoq+5oeysjCLNhY=;
	b=K9C0DNLqkx+ksCjobNMHbb2H6ueX/f6+4crfF2AWHx8qV2WpgIUecypXE1TcURzBeuoWXh
	HpgU6B9uoE79bH0vS2Pl08vrWwgt2Nz0ARU85ul2F9IeDDSadJeaXXR/dQXb8ThNFeYriy
	ITIGczy3EfKLBJcF9Zm8i9BzBLnKjSs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-D1l5CGf7NIaAsbufUGhUWg-1; Mon, 29 Sep 2025 23:09:22 -0400
X-MC-Unique: D1l5CGf7NIaAsbufUGhUWg-1
X-Mimecast-MFC-AGG-ID: D1l5CGf7NIaAsbufUGhUWg_1759201762
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-856d34460a3so1212830685a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759201762; x=1759806562;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwEb4teAWr4346aj9TWXwrKmyiXrnoq+5oeysjCLNhY=;
        b=G54J+3oX8+6YPk8S1zyEtksT5bHOwlmBHDzORXyLz/rB3tpesGTcKjdBnK/JSbzlzi
         twXhOkoJ6dLaDa44M2reEWr65I1F+cLyW3NddhR3fsHrO+Lnj0gKiEX1L+obOBOuiZAk
         P0egF7dVd+w94vSU55l7M/XjTLuEucPw+hL7WbRNGq/OJ8uX89JZOGpx0Z7zNqqn3luX
         C4lKJ9J+ucGpLmTKSvPkfpe+QP/lz3eNdddfYNd6Ck04p/lfug524LW1wscpBTZRF5hK
         p/DgaoDm2oWab0kCPPFObMqANcH2S4BooGoOCknTnQWKlYIoGF5fJeVw9+uRMx60Uuul
         LwHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdBiKuwek+S1g8XqrJt8lpcPK6yLSqQcrbgTxbeVFEMNX2ve88XqHZwBB8hxDI+w3Zkf6jAF39ixqPohI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRqFA3U1suYGeQD2p/5DBPIi1TXy7wtYNSt45YyE+OLP9wohY
	sjZioP96N8k365+G3upqoVMQiqPofQr2N7roUASRB53n3sDT28taWphD7wvhkRr4mwURZMqAotw
	152v0EnJGXZbj0BOAOTEvrrEgzNO5sOJ2jEEG/DdGOrZKWZsjU6GgDSjxHgd5LkhyZg==
X-Gm-Gg: ASbGncvb1/CFXzjE1IYpd/ttwpYkCW6XqQZOvOXzyBvQuQEhRz1qzZ94VdKqfhuu2Zb
	nn4SInl6cg6XqZkp6cH+b1YFbeqR/18PW1jBJxmw1jNA+XpBJcIbiYLSYg9ZOffGJGGm0tY5bCa
	6MtOKDgT17omV6S2TvsQ3BWydgi3A6bAF4ZSZc41kEsMqzD+Vkrgfeujpr1YRaE6qKs2qvYGFtM
	dIiVTU8xXWIVq+98bRItYBv1ZcEf4QcZGenawgZ/UnotNzIrHgO9QVj/UESM7XXq/PvNDytM0Br
	PLVXLlt2yWsgeMG+fMH6Qz1Wj5AqMffYdQtH+lpz9h9BsMy3GarTWxilqQcXeoQw2fYVQy2r16H
	nnOnp/LdNCL/xx+Q5
X-Received: by 2002:a05:620a:29d3:b0:864:2f79:38e1 with SMTP id af79cd13be357-8642f796889mr1864278585a.28.1759201761915;
        Mon, 29 Sep 2025 20:09:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrfCKhr/Y/wkOw2jaIv5WkW15Wiw4mY9uxrImb95PPhVbYjImKJ7OfZvhUBICKaN4VzDYEug==
X-Received: by 2002:a05:620a:29d3:b0:864:2f79:38e1 with SMTP id af79cd13be357-8642f796889mr1864276585a.28.1759201761522;
        Mon, 29 Sep 2025 20:09:21 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e34ef75712sm1741181cf.7.2025.09.29.20.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 20:09:20 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b315b9e6-4373-4891-ac94-48da275f9909@redhat.com>
Date: Mon, 29 Sep 2025 23:09:19 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] locking/rwsem: add DEBUG_RWSEMS_WARN_ON to warn
 invalid rwsem
To: buckzhang1212@yeah.net, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20250929144812.2211-1-buckzhang1212@yeah.net>
Content-Language: en-US
In-Reply-To: <20250929144812.2211-1-buckzhang1212@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/29/25 10:48 AM, buckzhang1212@yeah.net wrote:
> From: "buck.zhang" <buckzhang1212@yeah.net>
>
> Add the lock->magic check to warn invalid rwsem without initialization
>
> Signed-off-by: buck.zhang <buckzhang1212@yeah.net>
>
> ---
> Changes in v3:
>    - Use the lock->magic check in __down_read_common/__down_write_common
>    - (Suggested by Waiman Long)
> ---
>   kernel/locking/rwsem.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 24df4d98f..38d884643 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -1256,6 +1256,9 @@ static __always_inline int __down_read_common(struct rw_semaphore *sem, int stat
>   	int ret = 0;
>   	long count;
>   
> +	/* add the lock->magic check to warn the invalid rwsem without initialization */
> +	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
> +
>   	preempt_disable();
>   	if (!rwsem_read_trylock(sem, &count)) {
>   		if (IS_ERR(rwsem_down_read_slowpath(sem, count, state))) {
> @@ -1312,6 +1315,9 @@ static __always_inline int __down_write_common(struct rw_semaphore *sem, int sta
>   {
>   	int ret = 0;
>   
> +	/* add the lock->magic check to warn the invalid rwsem without initialization */
> +	DEBUG_RWSEMS_WARN_ON(sem->magic != sem, sem);
> +
>   	preempt_disable();
>   	if (unlikely(!rwsem_write_trylock(sem))) {
>   		if (IS_ERR(rwsem_down_write_slowpath(sem, state)))

Just to confirm that this patch will generate the needed warning for 
your test case. Right?

Acked-by: Waiman Long <longman@redhat.com>


