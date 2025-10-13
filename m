Return-Path: <linux-kernel+bounces-849982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A3CBD1882
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BE73A42E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FED2DEA75;
	Mon, 13 Oct 2025 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haucA+u+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2469E1DDC07
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334891; cv=none; b=GfE6FupPNXYi8jt+lZ4zbPBVsj2PnPrteaLc6aA6+rZnfAuzbPQABqGuDpt7D5EOVyPa/FFWnR0ntW+XV7tTl/xLcZCyqgcblKYo39afCwb5XpRC25iqANK23T/NoVw8HiAzZNiiWzNWDw/NkVarT7CC1mN/JOj2+2wAIM3Rv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334891; c=relaxed/simple;
	bh=PnyfKLDjL5zszUCWPbmAcBmZAuXMVTpp9v4ebhO948c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snf9qJN34kFMsIUgbp9lXDJEZxNzmA7tUtSaIY8MuR5eBWWCPI6XvuqaTeHytMGdqhfXqZzVoFx3Na9NJ4Esv3cp9EIEnctORbnGrDlIO0MRRJycXxZ0tlK0e+v2f7L27tlY7mA8fltnm8A1xy4GUkIUXN3OreYj0gbCJywi1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haucA+u+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-27eceb38eb1so40942235ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760334888; x=1760939688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX3t2pHZiWt6LkQqAHwt8UZHWxHzOcCU7wflNA+tGhM=;
        b=haucA+u+Uy4YEljY+nMzhcJAp0o/vKAQz6jg49rMfoufrzSY/yCnErQAxaPVVwPc0f
         PY/PrknSn+duNwUcc+n9yBJmpcMaIk3biN9QkDOXuWT43kYyKDWcLU8PsFb4FMncesKE
         iSDVrYd8n/l2YwUBI4f/3xsZY51jyj322Er2RlkRvemVMrDwupyJpUoyDPsEYIkxQsHz
         CmM4Jpmx7Jdzx8vCrR+FQ/GWpacWDq2vTnANd48GcLEq0UNtVBSDLqHuEBE1gEGH8zs2
         UN5uXCj2ZsYNY0SGi0KyWxY26ztYG9e2f7G0UiD/nvHV8PBwZH1QiB9t3qGJTcgkIPA9
         KU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334888; x=1760939688;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EX3t2pHZiWt6LkQqAHwt8UZHWxHzOcCU7wflNA+tGhM=;
        b=gejZM8j1dLvlmVJasuMP1ix6Ss5mmJO6MRnqKWVwU+ZM1PvM5SxJBDAlcRSpahHCVD
         OPTOiRefpFHptlWDZBpXV6AvLRqCu+RXAEYGuA414PMzNeltla/+6wbF7eb1Zbrr5BLR
         fuTYn4p0VJvJZk0sq+zVa8Y2YXIQ7YaUZh4OZiCTsF/OA8tEnL5BVZLI7jq18gzBRBqY
         0DRJUhiQXA/k2rZhQV+quBR1v1MuBV4SBH2pQDBzB1bYoNzcnDk97LqOSVd8XBRjgZlV
         0BC+qZAxHUFItbek1X6KYobndvydbWo0JYVxo8zj5TVJG7pVh6YixHifQW7a1QvF2gtT
         rzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1Yel8az9T0Ycjwv6vClePX5v7ZvF1b//Px6M+hyeJOe45cd/Ou144r0gi/mb+VBRIeliH2n4tYKP6rz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJEZcDPX7gyvlEtMrV1Nok+aNN8CtkUmrhsO98ufGX/rkrZ85D
	7EC2ko4fSIddQdNq7GLOs0cqmdNal54bE7pWb9BphM52g8MY9qr2d/qd
X-Gm-Gg: ASbGnctb1mTHU+WJ/r5QjNeSNL/qoKLXjecK0fpu1l40FsvyR4OD1jbM6UpHfKiqPQ/
	+yF8adtYEkFU/t1uVEl2dwuEDnzsSw28POFH7XF1SM/e8y6j0SO+B+92EQT78r/Rd4qfJO5Sbvk
	xrBV9WJUzcbVx5qkJjoXqa2vJD88CT/oLJ7iRHOAtp2LqbC/UwXXIrpFSDalracME8S7kjGhMf7
	iLeTbjLUB6YBf4nShafNGalds38aFj/5eq8QpFnaLWjSNIgwmKKNUYZytvPgt2+ZMehlIvUOdpo
	0m/fORPNjsiu+kqar1HKdYNlzeuHKhe+iaxuy7ZbY9EZesrE9eFxt//QBdNCMyLnrF8mZKHUkAY
	rRCAVNBfmw2z5lnDH6YDUqtRt1bFNCSlGVCusqHona6EAyPOgGhtAgEn6UsWHPLXGpT8EHW8B
X-Google-Smtp-Source: AGHT+IFvPbcJ/qqg3bP+8dxEbiH8fhjKd5PuQP1mnfP9fEN5+ciwIEXJQUT05DzmpMJFp7sWOFk9rA==
X-Received: by 2002:a17:902:f60c:b0:28e:a70f:e877 with SMTP id d9443c01a7336-29027379a27mr252255785ad.13.1760334888310;
        Sun, 12 Oct 2025 22:54:48 -0700 (PDT)
Received: from [10.125.192.72] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f89972sm120973475ad.112.2025.10.12.22.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Oct 2025 22:54:47 -0700 (PDT)
Message-ID: <b7d9da0c-ee50-173b-3dc9-adcddc64e156@gmail.com>
Date: Mon, 13 Oct 2025 13:54:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: sched: observed instability under stress in 6.12 and mainline
To: Jiping Ma <jiping.ma2@windriver.com>, kprateek.nayak@amd.com
Cc: chris.friesen@windriver.com, hanguangjiang@lixiang.com,
 linux-kernel@vger.kernel.org, osandov@fb.com, peterz@infradead.org
References: <7cd74213-5654-aac0-54d0-4f4b1a7f0fef@gmail.com>
 <20251013030309.2176524-1-jiping.ma2@windriver.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <20251013030309.2176524-1-jiping.ma2@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/10/13 11:03, Jiping Ma wrote:
>>> Hi,
>>>
>>> I'd like to draw the attention of the scheduler maintainers to a number
>>> of kernel bugzilla reports submitted by a colleague a couple of weeks ago:
>>>
>>> 6.12.18:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=220447
>>> https://bugzilla.kernel.org/show_bug.cgi?id=220448
>>>
>>> v6.16-rt3
>>> https://bugzilla.kernel.org/show_bug.cgi?id=220450
>>> https://bugzilla.kernel.org/show_bug.cgi?id=220449
>>>
>>> There seems to be something wrong with either the logic or the locking.
>>> In one case this resulted in a NULL pointer dereference in
>>> pick_next_entity().  In another case it resulted in
>>> BUG_ON(!rq->nr_running) in dequeue_top_rt_rq() and
>>> SCHED_WARN_ON(!se->on_rq) in update_entity_lag().
>>>
>>> My colleague suggests that the NULL pointer dereference may be due to
>>> pick_eevdf() returning NULL in pick_next_entity().
>>>
>>> I did some digging and found that
>>> https://gitlab.com/linux-kernel/stable/-/commit/86b37810 would not have
>>> been included in 6.12.18, but the equivalent fix should have been in the
>>> 6.16 load.
>>>
>>> We haven't yet bottomed out the root cause.
>>>
>>> Any suggestions or assistance would be appreciated.
>>>
>>> Thanks,
>>> Chris
>>>
>>>
>>
>> Maybe this patch can be useful for your problem.
>> https://lore.kernel.org/all/tencent_3177343A3163451463643E434C61911B4208@qq.com/
>>
>> If I understand correctly, we may dequeue_entity twice in
>> rt_mutex_setprio()/__sched_setscheduler(). cfs_bandwidth may break the
>> state of p->on_rq and se->on_rq.
> 
> Thank veruy much!
> https://lore.kernel.org/all/tencent_3177343A3163451463643E434C61911B4208@qq.com/ can fix the original panic
> https://bugzilla.kernel.org/show_bug.cgi?id=220447, now we encounter the other !se->on_rq WARNING.  Do you know
> we already have the fix?
> 

Perhaps the following patch is more suitable for fixing the previous panic.

https://lore.kernel.org/all/105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com/


This issue has been resolved in the latest kernel mainline by 
refactoring cfs_bandwidth.

As Peter mentioned, we need to submit a separate fix patch for the 
stable branch.

https://lore.kernel.org/all/20250929103836.GK3419281@noisy.programming.kicks-ass.net/

Thanks,
Hao

