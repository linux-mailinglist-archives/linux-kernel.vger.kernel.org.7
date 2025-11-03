Return-Path: <linux-kernel+bounces-883699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E5C2E23C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBC51896930
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1602D0C62;
	Mon,  3 Nov 2025 21:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnhnB48J";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXQNTkaF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8AE2C2374
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204944; cv=none; b=Je1Ye0Mi6VtM5Egi7ju+tsa6l9+v6g7fZoGhM46aMlzymL+z/zT5K9IIxZ3gtAtK9YNtiwyQVAOrSg/9nG8IrLFNQOswL9w07Hh9uwbUsdwGNe1KD3PZQMxfpi4QjY2fOnS44lOTon/qH6phfOvPDME5yWSGIUt6hFzx5Zh4sc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204944; c=relaxed/simple;
	bh=yvav92s90I695dfvmm0uO2fKkLkHr1w5MwyJXtOXQPU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OK6OkgRI8M1fTC/Ta6J42u9TUHdVVg8w0eOCMENyq+8hszaNXZXt3CQVwe0PDL6rsWfFx77rm0OgibOOAciLjEmBW45L0j0KPicb+GZ86gAcd7+dhpevBpidwlgRwhWPI7mAHT+2fGQZSMRFS7ocTyndppGryK7qr5G/VT0plUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DnhnB48J; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BXQNTkaF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762204942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OxO+kRCP7tYkL79BzVRnhF2xUu/q0lLOakroAJsheg=;
	b=DnhnB48Jr5Q8IL8vAfXfwDiGyf5ycb5SuklrMedt1VLYhFEDXHN4rZqiRpTEt9+M5LE50A
	mW4N80rLXF071XxQ/CUPTdF30SfmRJsK45B+5ZlMEm9hH/xg3v0wiA4y/8bPwH+lD0egy7
	EkHXf5zzhlfBny3XlvL9YxTtXOBO/l8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-f35rlvTBO_uuigjtCp_Gtw-1; Mon, 03 Nov 2025 16:22:21 -0500
X-MC-Unique: f35rlvTBO_uuigjtCp_Gtw-1
X-Mimecast-MFC-AGG-ID: f35rlvTBO_uuigjtCp_Gtw_1762204940
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e88c912928so141405181cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762204940; x=1762809740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6OxO+kRCP7tYkL79BzVRnhF2xUu/q0lLOakroAJsheg=;
        b=BXQNTkaFNOe/YDl3GKzv5klOtZZxzzv58GLm0N+7K9t2eKFPqLkOS+SN449HRRDFPa
         C098neh+DXRXKBujjARZM0KdcnJ5o04SI1dia1uBHT2jjTPJ3NBWkk8lfwZPYkIqIMTK
         W9113etR/mldE777jN4MZnd5KjrNDAlOFRJNIzNNVrcdL4JNPvbprNBn9OHPfwvxDsu3
         JwoQJYsI1tKSyaU7hgzLBMfAAdaVfV2PEKLWhU9OHT0fo9O7l3rprnYSLR92/zUbsnck
         9PNLzEFKQ4gJHn+2u+RhUSG5aB2R68mQXpKhOsxFwJCJX1soUZ7e31CLklUv8pNZ87Fj
         93VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762204940; x=1762809740;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OxO+kRCP7tYkL79BzVRnhF2xUu/q0lLOakroAJsheg=;
        b=oOkRU14NOKhBMGyxohk9wh7qp/XCXRlEsPu99bBbXl28tfKTGRlG7/vkAgb2gMpwPd
         BvhY+JHzqSEHLgqtqV1kTPZYckW8EBuXtBAyGWXSlq25Ap79jbpvbZE8ZqK9Z/3dLMV9
         llX0d/6fK511Go0PmBd4KNpDXOTZg07nNBJE94uH0SYh3ljwUnp01xbFsJYSveVlNDT2
         nTJ+UrzaBYjrZ3MwPNK6tKhkREwLrTPA55ayLL3302PAnX9ZVpjjCpr2OSpldmAZVR9z
         Pwl3vsIIaAj8Tl8JjLgbtTTi/msatHZuwd3oey7CoQ3OnDQS6Gh1YHUOxRy4v5kCMz+z
         c2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWFYxi6eCjT+pcghGU2PVj7LUMfTS9dd00j90cTj/anJUEb/HpnltCiYZYOjUwYJXmrOAwoNenWE1clJQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIoC3q+igYgUxrp4WpPyKztMH4VLlATQUuJr+90G92SaEe4M+O
	dIq5/U9h0n2hZlVlzlxdHvL9sUmA6iQKSCmKWWGUIMmGl0UFc1t4vteE+6PbsQ2JtiYl8pHqPBe
	ycCYMID97UU6WJZFV8/1ioClmtZxv6Mjw/J2LK5zf3EIc+r2RsJav9RmRRAt/Ld+WSsjsuExzAQ
	==
X-Gm-Gg: ASbGnculGlI3UssEPKrmTjFhw9B51p6je8KVOyDq5Yi38hUWrFWvGiquB+xMDRHB6Oc
	yF32gZYwa8wQlLcxsZiVcpAvmhR/Tr4DTWmXGAFZ5TvCQlyDrd7zTi5YPwXbj0FPjgA4FX86XlQ
	ED457WN9tgGpJt7bOUXrZwCv7DljqXsLhSWWziS0lUtsR4zSh2rW6LzSOuyGWpf3BSzCJOATKR3
	5qVC3JLumODVEK51KH+Au44giinxKKPjokAxnhjdwzlpQu/JS/Y0BX6sVTO8IIAHm/3tx8e3dWJ
	paSH/+Rhrfv0gxMA5aAdwqq7an4Zb0gf/h6PI4N3Qo24h+qzDGU14A6yueMXQuqlYgYYXNu51jD
	s0YQk+vxqSQ31RDZ7zmbwpklxgsLD+DHAcFCDnaY5bWs18Q==
X-Received: by 2002:a05:622a:a28b:b0:4ed:3d26:e819 with SMTP id d75a77b69052e-4ed3d26eaabmr129471851cf.2.1762204939797;
        Mon, 03 Nov 2025 13:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhi/FTemELwlruuyJdvUCI7zTLA4oiLFMqFF4DsziPGx6MSvrtzoRGxJqvldeeCpTtDz7pKA==
X-Received: by 2002:a05:622a:a28b:b0:4ed:3d26:e819 with SMTP id d75a77b69052e-4ed3d26eaabmr129471621cf.2.1762204939434;
        Mon, 03 Nov 2025 13:22:19 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f75d7aacsm58463285a.33.2025.11.03.13.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 13:22:18 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8bf57eed-0e07-4102-900e-e63c1110815c@redhat.com>
Date: Mon, 3 Nov 2025 16:22:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 2/3] cgroup/cpuset: Fail if isolated and
 nohz_full don't leave any housekeeping
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-3-longman@redhat.com>
 <05281aa9-57c4-42c7-a17c-009d6b22943b@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <05281aa9-57c4-42c7-a17c-009d6b22943b@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/2/25 10:53 PM, Chen Ridong wrote:
>
>
>> +
>>   	/*
>>   	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
>>   	 * only).
>> @@ -2994,7 +3055,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>   		 * A change in load balance state only, no change in cpumasks.
>>   		 * Need to update isolated_cpus.
>>   		 */
>> -		isolcpus_updated = true;
>> +		if ((new_prs == PRS_ISOLATED) &&
>> +		    !isolated_cpus_can_update(cs->effective_xcpus, NULL))
>> +			err = PERR_HKEEPING;
>> +		else
>> +			isolcpus_updated = true;
>>   	} else {
>>   		/*
>>   		 * Switching back to member is always allowed even if it
> This is an issue I am trying to fix, the prstate_housekeeping_conflict check is necessary.
>
> https://lore.kernel.org/cgroups/20251025064844.495525-2-chenridong@huaweicloud.com/
>
You are right. We should add prstate_housekeeping_conflict() check here.

BTW, I found some issues when I looked further at the patch. So I am 
going to rewrite part of it and will send out a v2 after some testing.

Cheers,
Longman


