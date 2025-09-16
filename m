Return-Path: <linux-kernel+bounces-818881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9890BB59798
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4844A3AE590
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDF430CDA2;
	Tue, 16 Sep 2025 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUp8WxCx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8212B1E0DEA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029250; cv=none; b=Z6Dbq7Z8SunjB9oXgCmgkrUu3imW4QEnAoHi96Y6Ct3OWIcqXwUSVuf1YkNKGZjXBY2dn4NysPlVAHY8nBCztblvj3zrmX3+AdQxqQE+2VyF3l+9iMXCEtEc18WzC3cf3va4Z1DnvnM73yvrYSJajkGGDfPDi4FTyO/uE3Sg6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029250; c=relaxed/simple;
	bh=rpBARihvrxbhwJB5hZAIXVpKLoMJgvQOVm/9v/aFuZY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fA9JjBGmFbe7mFBubWoEnnu5nNRIV4RqaMeicvbnsq5/L3F3fb45XvKgwhKv7zaz39ALb8jELNaQ5uDIqTihK/mrrbPafI20vCWiK6sWVX24JTa6pUDvHNqISG6FIZDAlLWxouiYAHNz+WSiEGUV7qNT269G5hiMmoRHMMAI+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUp8WxCx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758029247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OziYYqf/phI/uMofS11afe/jtpxtKYagV+1tFGU3ym0=;
	b=XUp8WxCxeDbhIoBOBfzwk4HB85/J+3osm2tAjuUpxXMCtqL9kTUpK/27XxAprSNhdTF1g6
	uL/NXwfy1Y+6EHR6uR7iGwchdcY2bDNTTTOrctz4SrzWbiQY3YQZr5rQ4QT7Sr/zS+83hu
	jmmOtz45A9cDHgSyRiWJUm2lmu35ugs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-tJ6yJxZ2Oo-vi9jEyVrQyA-1; Tue, 16 Sep 2025 09:27:25 -0400
X-MC-Unique: tJ6yJxZ2Oo-vi9jEyVrQyA-1
X-Mimecast-MFC-AGG-ID: tJ6yJxZ2Oo-vi9jEyVrQyA_1758029244
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-726a649957dso113087616d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758029244; x=1758634044;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OziYYqf/phI/uMofS11afe/jtpxtKYagV+1tFGU3ym0=;
        b=Y4em+aLLGKAnN2bs16z/in2WbC4OtWsROXYm4yq7tIrjSzXMql2cSZDv7A5Slwa64g
         f4IfAqR2ItzKr1OlmCHy59AldQSeKNHJ3DALYEyBeWcojDoGBKBT8OhNuC6axvMxpvkt
         4LovRt2f2QBZV0lKM+cQ5QoVUKLTTcp8uvrj/hok2mslwAtaQhyDm7xqTmD5eC1hiPv6
         TCOpsuUQzaV9SupYt7hzCOWhGHqdI4Y35egqdEis7sRpU+TOoKdP6yJB3tBXXrr/egDQ
         5qZmztmRalGOM2eMVHtefILqDdtwkGXDHPaXDo9MGo+LjqTMxDqTe3V7IeUX6Lpt0Y71
         tG7g==
X-Gm-Message-State: AOJu0Yz+gB7oZkZ2XUdBZZKMfab1arCKSIzjoir2GX3BL602Z4ygVzZU
	++6zt13aV+yZCLrI4tJaeNq/RkY9TFDSdZE8BVTEScbz0bn+lNuwBhXMzKyH28+7w0+Hnl3NXwH
	mkoNBOoanTvsQFs1gHB7lgqhtj4TsGYmaZAgkSM2fBf2DCnW9i5xJk2V63uMzgR5o1A==
X-Gm-Gg: ASbGncsZ41LLyBle7mzWurowCE1CCbshGnWkyJbBcehJexBDDnO9gy1jwdfkE/6qAmG
	qGBOeoGj1hTyHzBYRtQQDsDtkg4rAMpHmqyTICFYa6v68hs/WeFOFSkJKlI7gnlhOD8Sx+pcpJm
	7xqMFWzQ2kUt+2rtF/uJ0wGroNXdfn9MSZIFkt34eITaIRYn6Lgq58bPF7VUFaGUmnVTlH4Az+1
	hHqTw+R8FVYmPWLaUNwh0i0WbZir+YWwJ/5Cbja5QfOoGqhupCQ6/ALnLFTbhW12aYZMuR5cSIq
	0+uIw9nrFc+d4DKgj05PI0ikiUL4qsjAAgRWgerF509lAxJ4PCepIhfjBDiq4pDYNgPoqV6y+bE
	3DixgxIm80g==
X-Received: by 2002:a05:6214:2462:b0:728:1584:ea85 with SMTP id 6a1803df08f44-767c3a52142mr184200946d6.53.1758029243788;
        Tue, 16 Sep 2025 06:27:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhuIy5My0hOV601YVztHraXdLNNEZANRaxe1R+7Z/1ph0u6KjL8sJvkViMqfK5X5UP7/XiVg==
X-Received: by 2002:a05:6214:2462:b0:728:1584:ea85 with SMTP id 6a1803df08f44-767c3a52142mr184200026d6.53.1758029242208;
        Tue, 16 Sep 2025 06:27:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763bdd36cfasm94349546d6.34.2025.09.16.06.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 06:27:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8b89a9a8-7114-452e-bf7c-86f0cedbe01d@redhat.com>
Date: Tue, 16 Sep 2025 09:27:20 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/qspinlock: use xchg with _mb in slowpath for
 arm64
To: pengyu <pengyu@kylinos.cn>, peterz@infradead.org, mingo@redhat.com,
 will@kernel.org, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org
References: <20250916033903.3374794-1-pengyu@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20250916033903.3374794-1-pengyu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/25 11:39 PM, pengyu wrote:
> From: Yu Peng <pengyu@kylinos.cn>
>
> A hardlock detected on arm64: rq->lock was released, but a CPU
> blocked at mcs_node->locked and timed out.
>
> We found xchg_tail and atomic_try_cmpxchg_relaxed used _relaxed
> versions without memory barriers. Suspected insufficient coherence
> guarantees on some arm64 microarchitectures, potentially leading to
> the following issues occurred:
>
> CPU0:                                           CPU1:
> // Set tail to CPU0
> old = xchg_tail(lock, tail);
>
> //CPU0 read tail is itself
> if ((val & _Q_TAIL_MASK) == tail)
>                                                  // CPU1 exchanges the tail
>                                                  old = xchg_tail(lock, tail)
> //assuming CPU0 not see tail change
> atomic_try_cmpxchg_relaxed(
> 	  &lock->val, &val, _Q_LOCKED_VAL)
> //released without notifying CPU1
> goto release;
>                                                  //hardlock detected
>                                                  arch_mcs_spin_lock_contended(
>                                                        &node->locked)
>
> Therefore, xchg_tail and atomic_try_cmpxchg using _mb to replace _relaxed.
>
> Signed-off-by: pengyu <pengyu@kylinos.cn>

The qspinlock code had been enabled for arm64 for quite a long time. 
This is the first time that we got report like this. How reproducible is 
this hangup problem?

What arm64 architecture has this problem? It can be a hardware bug.

Anyway, changing a relaxed version of atomic op to a fully barrier 
version can be expensive on arm64 in general. We need more information 
to ensure that we are doing the right thing.

Cheers,
Longman


