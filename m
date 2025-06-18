Return-Path: <linux-kernel+bounces-691958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5955ADEAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 13:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2434E189E316
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jun 2025 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7101829ACEA;
	Wed, 18 Jun 2025 11:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaNvWuyx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1971027EFE3
	for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247668; cv=none; b=RKsB03Ad8O8zO5TQxnGd4h04pU5r8PbqspsbsKF4w8We4UKRV9M/Nn7Fgv0s/oh2wKYrQd42sPwVWpzShEao+TwzK8sDC2xHhTkCPkjvKPWQ5yrS2Wnx2UZlW+FWXnLVXRkRNqXmlgOGAtK+mEeaSSfdhVv7JAbv0KMEgl2FSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247668; c=relaxed/simple;
	bh=PsGsoQX1+7+uBNf2AE0d24qnM7gwvSE1vZ824x13C2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKd30j0tZur1uiRwt7FNt0T94fwhuBbF6H8LaV2MR2wIh8gk6+8jdKZhmeg1aRbJPldcphIr8TmUSEbdw2RTq2OqSMU3Gd9xicjO6xQc+9kT/EHFpaRFD3r1dzaCLVBn2PHIgBXJGwtlsHCvA9SZZdNubFVllycYmE3QSYZCLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaNvWuyx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750247665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DOpGfej+wKG1VgbU16FOUc0UnKXyUIhgPDNTdOtNZD0=;
	b=VaNvWuyxwlNgKqKklY/YSK7ER+cdhK00Axb22L/qAuQOVtEHJsOrNtULXU+Q3wogb+HSaO
	4O7h+13HF0syy979iknPtWylKXDzLcQkJ4E0MtQY6nqp17rd2Jhw01XxoxclpHyMWzx17d
	dgXraKv+d7ruzpvdzhmNqp6JX/YEF8c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-CNHq1s_-PACBedJBfSjcdA-1; Wed, 18 Jun 2025 07:54:24 -0400
X-MC-Unique: CNHq1s_-PACBedJBfSjcdA-1
X-Mimecast-MFC-AGG-ID: CNHq1s_-PACBedJBfSjcdA_1750247663
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a5780e8137so343769f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 04:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750247663; x=1750852463;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DOpGfej+wKG1VgbU16FOUc0UnKXyUIhgPDNTdOtNZD0=;
        b=UEbzveurRi/Oaqn3a4D4v2LwPzmLR/K0PlOUS3QtuLUT5DQo0f3jTkRTD0YIwX+OP8
         SQxzukDaynOXMXE1ZRamZ014CEO7d4vcIu3W/mLZ5kXGDtoNzvG8z3pyIYfPhQD3vZ0t
         YYjTrqLAPPeLxMcOKEFj54A0fCDTMVexptlhWRcW6CuNWraun+kwB8wZN8gnEWr5pihj
         SSZeZsFuSwnUs4UcWqvKaAJrzuwterQ4zYVLDQ0WbqBAzvIQdOmMsMmedbm8sUpWeZiS
         5VrcwKATJ3+rxGmY93Yyclik+tl5igeHRBEvM/jluxqk+9LOtBByyCbRVDct/cPGQK+G
         F/fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPgx8bNEbhwt99AONHgNWfZxwLJO/YSDGHeIKVy7MlZNCbepm+8Bk3w28s7u+ZfY18xBQx5el9VNueDHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaXMaNlvasquuJ5Hi3SvXhiX1cqyP28kPXOfTMlFGN584FzS8q
	W1neyPLfsPlJgsMbBdvA+Nxew4dsEM6im9Can0oj3mH+rPS9WZbKpNYCD+GSC3be4bFVMX1W/jU
	8lE4eDwFNmztmKRGJ8PhFC9prmcFUfKxH/gvok6IZ1i47mCNb1cr+vnZTU93ZjkfbiQ==
X-Gm-Gg: ASbGncs/vwhNKzfxRLX/KhuXCPv8M0UMFwYEy9ljpd3UpFjiCu3NuZwsFIspM/vHIqR
	HKSKqmOLM4YmicSjfR/oiFa55l1u8nu1Irru04Uz/OKbpF+Xt2dPrzFrjxurZe58ibs+6/aeXMw
	C3HCgQ6WyW8ZEu91i3Bn3o4/dt0LJPy2c0032ghA3zK9iCfN53YIe8bBHcToB/cM7pQk5WyYF3x
	tHqWG87OXWT+LpqhESMoXFPnlnrIiMt+byuolfQzuHYf+0g0sbMkzj+814V2QgYvu/tP1BhJWLF
	FFlapTlr73pjLnkRpTXqr9PKi27KKuoDzrhz4/hypzzByRkteGoX48yOwmgftSwM5CQFJMfEP0E
	deJ0mgiLv5oCa8qjaq9dQozj1r6xOIDx6DEuWc/7ITRRaQdI=
X-Received: by 2002:a05:6000:2912:b0:3a4:f70e:bc25 with SMTP id ffacd0b85a97d-3a58e27010emr2270305f8f.27.1750247663135;
        Wed, 18 Jun 2025 04:54:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuRFbotFuND835d6U8YkfRTmqYzSB0JPy+NFDmJbKVME80bESVN6r6F3K7HXj+5H5asC46Dg==
X-Received: by 2002:a05:6000:2912:b0:3a4:f70e:bc25 with SMTP id ffacd0b85a97d-3a58e27010emr2270258f8f.27.1750247662637;
        Wed, 18 Jun 2025 04:54:22 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:2400:4052:3b5:fff9:4ed0? (p200300d82f2d2400405203b5fff94ed0.dip0.t-ipconnect.de. [2003:d8:2f2d:2400:4052:3b5:fff9:4ed0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b5c372sm16341652f8f.89.2025.06.18.04.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 04:54:22 -0700 (PDT)
Message-ID: <345a04ad-cf25-4af5-802a-bc8826d37b19@redhat.com>
Date: Wed, 18 Jun 2025 13:54:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] PM: Optionally block user fork during freeze to
 improve performance
To: Zihuan Zhang <zhangzihuan@kylinos.cn>, Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>, rafael@kernel.org,
 len.brown@intel.com, pavel@kernel.org, kees@kernel.org, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
 <20250606082244.GL30486@noisy.programming.kicks-ass.net>
 <83513599-e007-4d07-ac28-386bc5c7552d@kylinos.cn>
 <cd548b13-620e-4df5-9901-1702f904d470@redhat.com>
 <a4370ebc-b1ce-46ba-b3a4-cb628125d7d0@kylinos.cn>
 <aEvNqY5piB02l20T@tiehlicka>
 <ee1de994-e59f-4c6c-96f3-66056b002889@kylinos.cn>
 <775aaf10-3d19-4d5a-bf2b-703211166be4@redhat.com>
 <7d70334a-2e0a-4d1e-b4d0-64d0e3aa5439@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7d70334a-2e0a-4d1e-b4d0-64d0e3aa5439@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.06.25 13:30, Zihuan Zhang wrote:
> Hi David,
> 
> 在 2025/6/16 15:45, David Hildenbrand 写道:
>>
>>>> [...]
>>> In our test scenario, although new processes can indeed be created
>>> during the usleep_range() intervals between freeze iterations, it’s
>>> actually difficult to make the freezer fail outright. This is because
>>> user processes are forcibly frozen: when they return to user space and
>>> check for pending signals, they enter try_to_freeze() and transition
>>> into the refrigerator.
>>>
>>> However, since the scheduler is fair by design, it gives both newly
>>> forked tasks and yet-to-be-frozen tasks a chance to run. This
>>> competition for CPU time can slightly delay the overall freeze process.
>>> While this typically doesn’t lead to failure, it does cause more retries
>>> than necessary, especially under CPU pressure.
>>
>> I think that goes back to my original comment: why are we even
>> allowing fork children to run at all when we are currently freezing
>> all tasks?
>>
>> I would imagine that try_to_freeze_tasks() should force any new
>> processes (forked children) to start in the frozen state directly and
>> not get scheduled in the first place.
>>
> Thanks again for your comments and suggestion.
> 
> We understand the motivation behind your idea: ideally, newly forked
> tasks during freezing should either be immediately frozen or prevented
> from running at all, to avoid unnecessary retries and delays. That makes
> perfect sense.
> 
> However, implementing this seems non-trivial under the current freezer
> model, as it relies on voluntary transitions and lacks a mechanism to
> block forked children from being scheduled.
> 
> Any insights or pointers would be greatly appreciated.

I'm afraid I can't provide too much guidance on scheduler logic.

Apparently we have this freezer_active global that forces existing 
frozen pages to enter the freezing_slow_path().

There, we perform multiple checks, including "pm_freezing && !(p->flags 
& PF_KTHREAD)".

I would have thought that we would want to make fork()/clone() children 
while freezing also result in freezing_slow_path()==true, and stop them 
from getting scheduled in the first place.

Again, no scheduler expert, but that's something I would look into.

-- 
Cheers,

David / dhildenb


