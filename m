Return-Path: <linux-kernel+bounces-804949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E84B48249
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB14E7ACBBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D377B1C860F;
	Mon,  8 Sep 2025 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUnxJU6X"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B90146593
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296284; cv=none; b=Ng2QktsfC7x9zQo/v6oyi2GfnMgPyKe6j9BpwXchKkGIJWU2jo0kiGrI/m7hQDkucgVHaBaDvaZLHz/SCgAmftK0LBUrOrTrLE6N+4gXfhiZfg0l70vlSP1eTIAbI/Vb72Kkc2qN2h+OhChv9WNkfDhSDhADfzMyltAq1BW7elw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296284; c=relaxed/simple;
	bh=Koi3RTmDGMcL8Puu/tRkXgzsXrdPRHfCcErBrrllvH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=arV/RKh/RKwjqmDWouz45sBl4p8eMIjB2n1u3LnyNTbLEiJKHicEYnJbntMTP6zXa5ceNTBPkcvthfd+JUuFQbU4vq6Ky32a849nk39M/xeRpuXbVH4WVzX3QBSZnE2u31VTmdmjEXqfWLPeQDqUpIH+g3/3DKr0yu5JQzrd1js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUnxJU6X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24457f581aeso34256615ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 18:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757296281; x=1757901081; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPEvufB0EVqqG+ndG77NaI5/Gjp1FLYPe4dZ5FOTg6A=;
        b=cUnxJU6XIsba0vyMIZlyQnoZ8CW3I+lyFhGzRLYBD7yeUs8iXrAZ7pxszhdvlhjNqG
         XxhOmvXqwDZCaxuZOn+YdMXGwwqvxh01tvMBqzrmXK3bCy+YytTK2Bo4ssYx4ZVg+7HK
         Fc3lxGWfbMPuI9G8Q0vrWDn+QoY3alGJwA7InjO01l8TgqfwkI03R0f7O8H0KwMRvAe4
         dpiy6SbVH/kCGAAj/FaMOmslKuD07mfCrc1nCuj0JALYwUK0CkfeNZXZGbSb0/AfSMHs
         ZviNvtq33n7FIugfMh1l6zG+iUbpiMBWQxSYq/OhIiupO249aDwZacS/8h87liDmJ36A
         ue/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296281; x=1757901081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mPEvufB0EVqqG+ndG77NaI5/Gjp1FLYPe4dZ5FOTg6A=;
        b=c1Qu6rYqKVl5oKomAQajWO5vFL+ZFRNOojxL0YPAqZMK5Yh6OmMgjVCCczzF8ArPAS
         F9fZWQkqSfY3H8YaKEgXqh4p+9pskxQlTT8SYQH7yTDRXufN67L9L1WO78pEz2chU1sA
         obeVsL6UHMP943xU8z9NUzyAnkBvYM9Z478IT4k83kL/50m/xb0stZoy5Vu2WkR0R60V
         rePxNg5RjQbYy/lWaFzGluz7ClIp5ra3BRyb/vXYK61sM+1NBWq4ggBTOnlsZ16z3MQd
         oU4+l2ZLyP+VCcaVwoztYS7ZCbv9ECGqCrviv/CFbbQHTSraZ/CxahqvSeMBr1qaJdBN
         WpVA==
X-Forwarded-Encrypted: i=1; AJvYcCVTGIdUF+Fjnyx5GvCWAV99A0FkdLcYLIM0JXNGGIeF9NfhzYx++nbe5dD9CTx1zaKP3F8wvNtCHSoJI9I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/YdmSVs5/6MsW7XNUZNQJhzflaSSrA0QPmDtMmE+7Qomo8owD
	KbOTAG3vCd7mpSgCjnmqQqXPtL/lhGOOKC64HkKygDhP9sC/+rO3/Qry
X-Gm-Gg: ASbGncstjP3Tch1MqCjVSbJDxx1OJpe+GTzqO4Zwb0YstnuVYFiOBpJS1fSL52a5HZn
	bDdqtFu18IVBAIxrXLxt3m5J/7ojs02v3oL4rt9uz2jJtIZCHHauqQuNdEvjx2bmssitbmZbGeA
	yRU0MZu6cQxjDz6B/pZ1Qc7bea3Wn2i76+WtWc6i7SMMOB8XZ5J6gOplGaPx5LR/KCtp2TUnEuZ
	eM86++X3LAi8JPbH6ymYH+bZNJ/trlJd1+h6nBHTuvnBQsYF2XEnnLmedbuRAk1vGVgmqorjnMJ
	Qzo8BH8zE0KKueZyo6F2o7THDeImL9JxeIEziuJttmY1w/AntPwJhEk8QKrapJEJa7hTa+/iLeh
	aMC4JFby93FvegNDcoR2JomFtlDWz6jqqGnrrmPAWEcGiW6QGlhrc3Es=
X-Google-Smtp-Source: AGHT+IE800VW5xcV/nHB5CXVcEw8AAc5XnqZer6B+ZirEQTtaJjRi9HUD+HyolHssecI2MMyShoh9w==
X-Received: by 2002:a17:902:ea05:b0:24a:fd05:bc6b with SMTP id d9443c01a7336-2516fdc729dmr74978365ad.13.1757296281018;
        Sun, 07 Sep 2025 18:51:21 -0700 (PDT)
Received: from [10.125.192.100] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b0e860ab5sm163709175ad.5.2025.09.07.18.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 18:51:20 -0700 (PDT)
Message-ID: <7cd74213-5654-aac0-54d0-4f4b1a7f0fef@gmail.com>
Date: Mon, 8 Sep 2025 09:51:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: sched: observed instability under stress in 6.12 and mainline
To: Chris Friesen <chris.friesen@windriver.com>,
 LKML <linux-kernel@vger.kernel.org>, hanguangjiang@lixiang.com
Cc: osandov@fb.com, Peter Zijlstra <peterz@infradead.org>
References: <87254ef1-fa58-4747-b2e1-5c85ecde15bf@windriver.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <87254ef1-fa58-4747-b2e1-5c85ecde15bf@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/5 00:33, Chris Friesen wrote:
> Hi,
> 
> I'd like to draw the attention of the scheduler maintainers to a number 
> of kernel bugzilla reports submitted by a colleague a couple of weeks ago:
> 
> 6.12.18:
> https://bugzilla.kernel.org/show_bug.cgi?id=220447
> https://bugzilla.kernel.org/show_bug.cgi?id=220448
> 
> v6.16-rt3
> https://bugzilla.kernel.org/show_bug.cgi?id=220450
> https://bugzilla.kernel.org/show_bug.cgi?id=220449
> 
> There seems to be something wrong with either the logic or the locking. 
> In one case this resulted in a NULL pointer dereference in 
> pick_next_entity().  In another case it resulted in 
> BUG_ON(!rq->nr_running) in dequeue_top_rt_rq() and 
> SCHED_WARN_ON(!se->on_rq) in update_entity_lag().
> 
> My colleague suggests that the NULL pointer dereference may be due to 
> pick_eevdf() returning NULL in pick_next_entity().
> 
> I did some digging and found that 
> https://gitlab.com/linux-kernel/stable/-/commit/86b37810 would not have 
> been included in 6.12.18, but the equivalent fix should have been in the 
> 6.16 load.
> 
> We haven't yet bottomed out the root cause.
> 
> Any suggestions or assistance would be appreciated.
> 
> Thanks,
> Chris
> 
> 

Maybe this patch can be useful for your problem.
https://lore.kernel.org/all/tencent_3177343A3163451463643E434C61911B4208@qq.com/

If I understand correctly, we may dequeue_entity twice in 
rt_mutex_setprio()/__sched_setscheduler(). cfs_bandwidth may break the 
state of p->on_rq and se->on_rq.


Thanks,
Hao

