Return-Path: <linux-kernel+bounces-861619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDA3BF332E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8EE3A5B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE002F7477;
	Mon, 20 Oct 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crxxkVGZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8001EDA0B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988335; cv=none; b=V0wuIbVYEntFcbGdoh/D7xWcm6OKDFlA6l4ZDlKb6MzCIcE6bWcbVozzAe74bNmwJ7eQ1DhiF+XwIMIVIfg3684+K0BuPOP9yN+EpXmDiME3irHBEaULCZWcKvje922Otve/65dKy3XLeuJjVnpcxW3YO6wFX9sdpg6k/L++izY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988335; c=relaxed/simple;
	bh=Wbm1ygRsjezHORU08fF/499OQmmFQus/opuJpZ42+1M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QaftptLVl8znvUtAggIsVE0BmssbYPPuEisFJEIlL/6/JE1c3k01Jl2d9BAwWKXDmiiRUrP+3OP+iLBmU84bKN5OZBfuTHurq4KBCv572h8R0pnZ1nCYOR9N2cEqrFYfSbxTkeWQ1iIOjVXmaTWu3f58PRedKbJIeoxtJ27Ho7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crxxkVGZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760988332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U4JESqtwQUS70W7By+0xAr07eVoyj86fvuT0XAPYk34=;
	b=crxxkVGZGhik+pVYmbMmGov1VfYYlu+LHY11uqLZB9p9Ve67RSMso+y5YfXWWkts9TcuC0
	dzEu4qhg33WvyaV/LeM0BlZi42fhwzQWrsI5LREXTyS2yP5DChuo44GVrwcv5L8FhGlfsC
	HhTVt8+pdbCTSrQP1olO3kS0SXXzYYQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-3VQeGlyqMXSDE0S-R7yKpQ-1; Mon, 20 Oct 2025 15:25:31 -0400
X-MC-Unique: 3VQeGlyqMXSDE0S-R7yKpQ-1
X-Mimecast-MFC-AGG-ID: 3VQeGlyqMXSDE0S-R7yKpQ_1760988330
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2909daa65f2so49399045ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988330; x=1761593130;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4JESqtwQUS70W7By+0xAr07eVoyj86fvuT0XAPYk34=;
        b=eRct5quQXjzkoKVvdti42VRvNReBiDXFApKh93/qafwFMjBsVD4W6SH4qJ5hlthuvu
         4LdGy8B2PlJ+wmG2aLKlGif4dm7lRNI4taqkJAnG8K+QwikXo3qR52ELbTPahPoBrJXX
         OeUWtKxjP2R9bZmGcHwHqaTIB/qPZqpkqQdVGHvVMfKVPLG1uxFVEkZCmASSwU3V5xrU
         facCsci/f0t1jJpnngDAgK+EnNZGVnZQz4anw3F/FvjXxE7h2czInbrUuBGviE1s5M4Y
         /3R7dz7IuqEssEfBgRy1DKcKZXpWxgEzgw02DSBdga/bv738Y85H3RQZXmST94DxrSiP
         JVbw==
X-Forwarded-Encrypted: i=1; AJvYcCV861G+d4S4YVsQulm1oS4JR70tlYaZ/mzaQc+rygPEPRpc6KUSl75GiZ+HpahVO8TkKy8wTT2cfUk2B3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/9Fwgz4uHGvmtUZTzyFvos5UJLUSGg9WDQoZBCvB9gpShOFM
	GIelUnmd3TCn6Omenqr8ABHYDIJaFG1Z3tuSG86RYZgY4COX4AjvXLluMRJBgnVAFc5ZCDuzSxT
	oIkeDCXUqxXP8PxSG9rjHq8WMl5PXUGIVK0KrS6/GrlqFKAq5F/cZSWVPCZXOeXqmtA==
X-Gm-Gg: ASbGncsOm4y7Litz0nZTsIsdD9lp2WLIn2iaQCQucHD9r0Z0ZGC6QCQ3R+11aMPGvaC
	QC1JWck1t32bnP9mBv042JgISs42PMZXCHU7sNNnxfLTJzGsaPPk4gEcg9LnEz7Uh1BANbBUGiP
	1lkAHZNfJl6BTnmSM8LB06abLGIPKcd5RY65jVB2qP6DN/JKryRNONHHAK+NoPOfua0Q+zaYQr9
	ITjEcnS3xSoWxx1lxUXJdESJ6H19gCZM2Y1jPVBhZRNXH/zU0JPuIt3ZseoK6E9y5AsAfiv+/q/
	sH/m/GhuTYbIZBjWmHK7XGB/ed+KkIPEBKGuPDg1whpQCZF3++GocV0XO3Fh2ZCaziO2U2aTJez
	0FPbnykr7dsVRZcT5VUDHYa/KEV3D8jlLafC6Pm6Bk1rZIQ==
X-Received: by 2002:a17:902:d48d:b0:28e:cbbd:975f with SMTP id d9443c01a7336-290918cbc07mr183114355ad.1.1760988329927;
        Mon, 20 Oct 2025 12:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7MxRvQT1Q80b2Ca4WrbvNmJOsadkDAbT1SVRanvNr5ICan1Hwu3+VuUStpIJbA59QNwxJpw==
X-Received: by 2002:a17:902:d48d:b0:28e:cbbd:975f with SMTP id d9443c01a7336-290918cbc07mr183114045ad.1.1760988329584;
        Mon, 20 Oct 2025 12:25:29 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292a8c8e231sm33579975ad.36.2025.10.20.12.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:25:29 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <05900ad4-fdbd-4505-a080-1e71bedb5f4a@redhat.com>
Date: Mon, 20 Oct 2025 15:25:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cgroup/cpuset: Change callback_lock to raw_spinlock_t
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>
References: <20251020023207.177809-1-longman@redhat.com>
 <20251020023207.177809-3-longman@redhat.com>
 <aPZqk4h0ek_QM9o5@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <aPZqk4h0ek_QM9o5@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 1:00 PM, Tejun Heo wrote:
> On Sun, Oct 19, 2025 at 10:32:07PM -0400, Waiman Long wrote:
>> The callback_lock is acquired either to read a stable set of cpu
>> or node masks or to modify those masks when cpuset_mutex is also
>> acquired. Sometime, it may need to go up the cgroup hierarchy while
>> holding the lock to find the right set of masks to use. Assuming that
>> the depth of the cgroup hierarch is finite and typically small, the
>> lock hold time should be limited.
>>
>> As a result, it can be converted to raw_spinlock_t to reduce overhead
>> in a PREEMPT_RT setting without introducing excessive latency.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Is this something that RT people would like? Why does the overhead of the
> lock matter? I think this patch requires more justifications.

Yes, I will push a new patch and cc the RT guys to see if they have any 
objection. I had seen that callback_lock was changed to raw_spinlock_t 
in one or more of the releases of the linux-rt-devel tree before the 
mainline merge.

Thanks,
Longman


