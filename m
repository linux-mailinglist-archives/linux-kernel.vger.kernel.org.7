Return-Path: <linux-kernel+bounces-769399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F775B26DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3144A7A7615
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1CD223DCE;
	Thu, 14 Aug 2025 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WopLbjAX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1677A13A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755193553; cv=none; b=XIdp+Jc+HJzFwXiBiba4Ss8bHZQyHzjCbfQ+EVpnwaenj+55c+OCiGhs+JKjOxvVWSY6CRZqPXkupufyoFM2DlPmXiei8Wn0vT+T/Y1A58rH+6lwsnwts9s0YylpxVmxny4DoJMdGrjkcphUJndNAHMEZzONzX2TUe7x+6nTeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755193553; c=relaxed/simple;
	bh=N6GdDA80btzjqCg7tM9oIOW1G5wmOjvhLBYDY0STrWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GolQb8Mx3OTpReGUK6mji5nSOnsxwe/QCYU015dybCx62iRqJzU/T+LUDZGDW/e9upHKhGOl7gO102v9gG2DM5M5MHl8ZkSgJU+Wn9He4IqZ8VfhviokwGUc/sqv77x4gm3FfXhbAbWlyLvFY/c1FHoZL7r3ip9iNusACPce+ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WopLbjAX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755193550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLmNK2SIpYyqqZwufDdaR6EabRKEXax8n5yifa2/bJk=;
	b=WopLbjAXIsrckrErBOnUf4i25SDspm0lrcdyve8RLNjQX7FNVPYi2bTHqpsp65v59McK/p
	h/z18hmky94R5pjIVXGynrlAibPD4cqLNrjBcf786tz9B2zif6TkYboOCwnBntMxw3lkuN
	veYsNJaKvOrUCpbqn8Na5vMuYA3iwRk=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-3Qi5NmQYNhO1dduGJdFiSQ-1; Thu, 14 Aug 2025 13:45:46 -0400
X-MC-Unique: 3Qi5NmQYNhO1dduGJdFiSQ-1
X-Mimecast-MFC-AGG-ID: 3Qi5NmQYNhO1dduGJdFiSQ_1755193545
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-55ce50aa2fdso558358e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755193545; x=1755798345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLmNK2SIpYyqqZwufDdaR6EabRKEXax8n5yifa2/bJk=;
        b=w9yKzTEpPm4THodby0co6XiG9zs8kq/Zt9SV5tTHqA+c/ZRoqqGagnFfuw3hhMBt/d
         yfFW0u3yBIoej9irE3F4KTIg78+BgNHZkIiXB+vUWhMYYGbE8KM6q37IT/smlazkvEA0
         TWrqxZqt2KrpqD+JxvxwQiH9kvqVTH4B8I3YalXaEjBNkYf7Vxtei0CsPkze0a0gE7tD
         riAVZfWO1PbZMUHPMF1Zj8xb9lRU0uUJGvBbh4ZnP2nm0tnSyGK3ZmDfR2fcH0Dh2MNA
         odOngq9xU0to0SEFrTqEs6vmup+f1wu4rSNls5oBSZOPPNBvYoCZNxu+dWTH7wB2VBwx
         PoIA==
X-Forwarded-Encrypted: i=1; AJvYcCWYuIVvH8kA4zKhW143HWdu5OnmT1vhlZhp6ZSx/5wm3i9qOjb0ClB/2FCUlovisD3bvrYJea3V5Ti+jl0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0QNu0zgUNds/JoEYHj4duP5ftBYhq0Dcu6imO3M8R8R0c7WcS
	9D6/Iotrnp/RsCvBoJ/+6Q9j3+0IDJSJMEini1YHEcQeP1D1CLs1Cgvum7BAFgfLp6021txoT+z
	vpA9EQ/QIiHh5hf3dsEoWi+cS1Cs4M2QKB+SpzOn/9pmo54QQCFNpd6e8zcEgrW22
X-Gm-Gg: ASbGnctHjzjwP8ZobpaYcepvnFQclRoZL2XkSPopVPqFgZvp/icn3ExdQwd87BK7pbj
	+kxgSFbZgwpljq5CKGgx+/pK2p/2lZVDqbp/q4MLY0VXau3oHP0i34We20iosZTIn8ZDuAPp5xX
	/EIKviwXIk/PoJP3A262IqizYkhgygHOWcdY49XaLlHAJHr+O0RSakDtn5pKwlT5hoH4pgd6Rlm
	TyWDC3frkWgDzLqx/QvcuTtaHlC/HU2JHiQgHPLbaddIxAi0RCO8k+vV1CjttqEOahDWkZbbSiS
	eQ+gC9IWMjmCCrG6u38vof49tL8Ydk6XwOiORN6WdNEAAXDfsNxRoUQq0UmaA+wkDg==
X-Received: by 2002:a05:6512:400d:b0:553:663d:736c with SMTP id 2adb3069b0e04-55ce50419c0mr1337022e87.15.1755193545057;
        Thu, 14 Aug 2025 10:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoGvy/3lqn2+KUjafXY/lDwg1jbWintZjZ67vF2LurnY6HesQlq/ETXwqXt9X0M1k2WOx1GQ==
X-Received: by 2002:a05:6512:400d:b0:553:663d:736c with SMTP id 2adb3069b0e04-55ce50419c0mr1337018e87.15.1755193544623;
        Thu, 14 Aug 2025 10:45:44 -0700 (PDT)
Received: from [192.168.1.86] (85-23-48-6.bb.dnainternet.fi. [85.23.48.6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cecfd842bsm15668e87.36.2025.08.14.10.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 10:45:44 -0700 (PDT)
Message-ID: <2982b6f1-7c14-46ef-afb0-7951f7cdc2aa@redhat.com>
Date: Thu, 14 Aug 2025 20:45:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: use current as mmu notifier's owner
To: Jason Gunthorpe <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>
References: <20250814072045.3637192-1-mpenttil@redhat.com>
 <20250814072045.3637192-3-mpenttil@redhat.com>
 <20250814124041.GD699432@nvidia.com>
 <2da9464b-3b3d-46bd-a68f-bfef1226bbf6@redhat.com>
 <20250814130403.GF699432@nvidia.com>
 <67b6e041-4bea-485d-a881-cc674d719685@redhat.com>
 <20250814141136.GG802098@nvidia.com>
 <c7bbbbc8-b9fc-40f5-b86f-e43b9a85aaef@redhat.com>
 <20250814172018.GJ802098@nvidia.com>
Content-Language: en-US
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20250814172018.GJ802098@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/14/25 20:20, Jason Gunthorpe wrote:

> On Thu, Aug 14, 2025 at 08:00:01PM +0300, Mika Penttilä wrote:
>> as well as hmm test module with :
>>
>>          * Ignore invalidation callbacks for device private pages since
>>          * the invalidation is handled as part of the migration process.
>>          */
>>         if (range->event == MMU_NOTIFY_MIGRATE &&
>>             range->owner == dmirror->mdevice)
>>                 return true;
> If I recall this was about a very specific case where migration does a
> number of invalidations and some of the earlier ones are known to be
> redundant in this specific case. Redundant means it can be ignored
> without causing an inconsistency.
>
> Alistair would know, but I assumed this works OK because the above
> invalidation doesn't actually go on to free any pages but keeps them
> around until a later invalidation?
>
> This is nothing like what your case is talking about.

This one is actually pretty similar, MMU_NOTIFY_CLEAR is also fired in migration process
(split case) and invalidation handled part of the migration process.

But I have already a working version without any of that.

>
> Jason
>
--Mika


