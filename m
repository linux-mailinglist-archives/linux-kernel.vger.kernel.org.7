Return-Path: <linux-kernel+bounces-898120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FECCC5469D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE963A9A81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278152C0F97;
	Wed, 12 Nov 2025 20:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI8K9vEG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kw0RuamT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB02E263C9F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978706; cv=none; b=RRNBmk5S1G3HTqEPJbSWhwcaoGALga22EzlGp1WjMldSL0LZOFXpXKmFKn5Yu9k7bBJjag/PoMj5AOa2+hf9lcM9ZFWOABlGaEqiGfife+Ermp4bePPa2Wqxhj+5u7JOh2oXzOep4mkkMp1W3tyqmy+KwCDB3LXrTWw3Eco/CHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978706; c=relaxed/simple;
	bh=R0NjxuliBgbPkUjoVxV/GQwermGfgOh84UIqfogg6Q8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Tlbf1MXJ/S7nL7DW6oY26+cGi2dYMld4TUO9dIWwEmN1Z+PpQo+XMtGuAKZkC/jm6vVqUJNBlAPWug3ptZOBDk1t3cGbhSlw6ZX+hOiv1QoV85cPTMpWHJRZ4E1sI9XHQDM6NA2OxifTgTa+ZdUew3xIQbTXMeYuIt93UTc4Nik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UI8K9vEG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kw0RuamT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762978703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PiNpCdZq1yfcHhaQQsyCMfmIiO/UkkDH35120jYscgA=;
	b=UI8K9vEGLvSWWTVuJaPv71TxiaruhHChA6YRiXjQfy5UmUsNlp8h8R880Hs+l7/KdBQqLn
	MfIzdozaKA2aA4Fp16BiFgyOaNbY9uG1Yq1djQzEHkAIoW18wiw96DjPHHaqoZWY30mPR9
	2J/sWrnFfVa/2CkJvv/myI4/R1Pc7FI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-6W4r6MmTNl-keCLasjnwIA-1; Wed, 12 Nov 2025 15:18:19 -0500
X-MC-Unique: 6W4r6MmTNl-keCLasjnwIA-1
X-Mimecast-MFC-AGG-ID: 6W4r6MmTNl-keCLasjnwIA_1762978699
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed74ab4172so1155661cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762978699; x=1763583499; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PiNpCdZq1yfcHhaQQsyCMfmIiO/UkkDH35120jYscgA=;
        b=kw0RuamT9bR7PKCMVEk5oSxaxHTjhr1O320Swyjo3YvNmpY62gflAZzhay0NJgxb5Q
         yPi2IO+kmwF4UiMex9moU/L9XDgZI8Pysp4QeMUt9p5QQWF+mXbW4YM6lgGJqY50cLYo
         nrRj4EoRsEmQLKm9isxeKc/DOX41+5qYWOYUr5+lamp/EEwAQmNH7VSoMOCzW/l3JUC0
         mlgv8iCYjJJkxeSusnaUqtWRk53s/QHe9NwJLo/J2I57wWljW4Jlt2nWMptKDU2PPoU0
         qhZuzpzKodePbY4LYeT/drm/OilrSE29hNiJ3JMc5Lpe3h5VyjLAWfHDAPiLtCKRE6N0
         R75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978699; x=1763583499;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiNpCdZq1yfcHhaQQsyCMfmIiO/UkkDH35120jYscgA=;
        b=qxg10sqlkPB2G+8bfbQrmyUKJmv4VCKTS1YVKQyNlTTGl1ToNhZKYmFup6Cx4lcTno
         2SGOdfdA1sd7h6SzgzZDMLY4aYFIGlK/MUVxCvS3Ic5PvU8qr4nkzLI0+UWW0N70Dn3t
         qTCptM4GsBPvCUj4ySI+qdsezou1v7ireg+kqmVVNEsRS916sci0POiabYI4TGCa1Gdx
         U0BEtNGIBNMOcZBtZzoiJT68IfBQwhQe0A0CiDhXQmzXwruMZvZN+B6MjLfvU4tVqBJ/
         shbeYeDc+0QCFRaEG0RlAIF0e73A+QcjyKHT3RYKI5pt5B+Yro+XbK1CsJMhimbR+MmC
         C6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtCMZEsaOt17b1Sx59L9vG9HKFcH/2gL/dSZQU4n5ch/YGOmR9GS6ahV+I30aPgcjVBpRI1Crh7KNNEFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOUD3/ICnZVkf/JwD1LnG5mNkrk+A94nChglh4saSrnpNmDpIJ
	lM3Ru3nAbyGKq+8QVTgsnU1+O44SWbUtcK0LhmherjsZ5iAJCU9tZg/YSezKQQt2+4DmLwjR5aI
	AVeH2k1hNzsL8n7iGaROr3z4xb9sAAAie7ttLvfXpruYanx1rU2xRIjYcnbhYcz7Uww==
X-Gm-Gg: ASbGnctcvExIqrMgi61TGHaXmVqyuLueokYfQZmlCfaq/08xvgewCS26x0zXbpCPBlT
	48L1iQzGhonwSSZDzRAKjOEjUVcwYplDpRZacDAN+YuqtL5suXrBDligf//dHcaZlVsZg5ZUdOw
	qkIN8ICQQV0kGtHuqKV3OMv5pxH63mY5lJ+hIzWylLlRFEBB27k7ngIZE195nH7GBISO3MGbYsV
	9gQLiSWd1TC654WEZyk2WlmpVI0gMyJ22/K4F7FCj5UQW+vWHRLqnFWDIEvbrxvxPaIn34zX9mp
	vWmBkqgh75QMvvNAn6MK8d9uvMJdZO0lX/5lqibNK+8zhKMGh5r29+BACvucnmIcpxU8wKkCY6q
	5rQHtYPvFWQ1PG2MP0iT2dH8QuGlhelpHmLH+Wnmtr9bfZg==
X-Received: by 2002:a05:622a:54e:b0:4ec:f34f:f7f6 with SMTP id d75a77b69052e-4eddbe34594mr55363571cf.64.1762978698914;
        Wed, 12 Nov 2025 12:18:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfJnTBGSA2/ZdUe+2Kwow914SDODXO/M57MSGE/+FIMwjvG6SblDsSpzNVwFL52eipuYAbVw==
X-Received: by 2002:a05:622a:54e:b0:4ec:f34f:f7f6 with SMTP id d75a77b69052e-4eddbe34594mr55363141cf.64.1762978698461;
        Wed, 12 Nov 2025 12:18:18 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede87e2a78sm14921cf.22.2025.11.12.12.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:18:18 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3c449d75-2a44-4acc-b3f6-0b2c261db1bd@redhat.com>
Date: Wed, 12 Nov 2025 15:18:16 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 02/22] cpuset: add early empty cpumask check in
 partition_xcpus_add/del
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251025064844.495525-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/25/25 2:48 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Add a check for an empty cpumask at the start of partition_xcpus_add()
> and partition_xcpus_del(). This allows the functions to return early,
> avoiding unnecessary computation when there is no work to be done.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6af4d80b53c4..3ba9ca4e8f5e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1345,6 +1345,9 @@ static bool partition_xcpus_add(int new_prs, struct cpuset *parent,
>   
>   	WARN_ON_ONCE(new_prs < 0);
>   	lockdep_assert_held(&callback_lock);
> +	if (cpumask_empty(xcpus))
> +		return false;
> +
>   	if (!parent)
>   		parent = &top_cpuset;
>   
> @@ -1377,6 +1380,9 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>   
>   	WARN_ON_ONCE(old_prs < 0);
>   	lockdep_assert_held(&callback_lock);
> +	if (cpumask_empty(xcpus))
> +		return false;
> +
>   	if (!parent)
>   		parent = &top_cpuset;
>   

partition_xcpus_add() and partition_xcpus_del() are supposed to be 
called only when action is really needed. The empty xcpus check should 
be done earlier to avoid calling them in the first  place. So unless you 
are planning to change the logic that they will always be called even if 
action is not really needed. If so, you have to state in the commit log.

Cheers,
Longman


