Return-Path: <linux-kernel+bounces-798263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED74DB41B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D98683556
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0602ECD35;
	Wed,  3 Sep 2025 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="HgaM7Alm"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47AD2D7D2F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894316; cv=none; b=G7X/A7uZKwjcIJyCbDtbxktwG4P6SI2wzoxvDDb9tjW83gILICWRG433IAM6TXxp5IGJe99BiAtcm+2m6mqHEbMSuxAgfLkr3He7LwOG3daiGdxlbzCrp7/Btnq2gHvqny/unTBIWmVSn60U5ys+q0zp8xswdLVTRUilxwn3UYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894316; c=relaxed/simple;
	bh=ZWM+I7gOKWzcFzvY+hdqKvup4xsslWjbk9vdkN+t2Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUBq3tKFLkcpJXIWWEZuccHXiHt5ZeIJBn5iRRZrEOkE317bfZy34fGB16ZiZd582NEftGUXek6C1pISG/apJeZVKRtJYnFKGox1KGCgOWjcT/cyBCK7XVb4uWa9W72zmw5bhLV2LSVWATon1zHMgx8lg394veApTMLFuC1yFgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=HgaM7Alm; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5607a240c75so3067786e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756894313; x=1757499113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uaEC72YkdU0dzg1YAuuKkN3WkhmBtHuuoh/1oBPlyDY=;
        b=HgaM7Almdmo4mR9m242m2BYDdG43c6Sn8rx9i+d4c1S4cjKxQBPP9rx2rzDrwyQwZ5
         WElEHiNbGkSlpxTuh2yuj8/8AIkp+V2jUj4hEXIMHrHO7AqaPTzE/LRRbvK9TQEXUiI1
         MYnqldIva2B6znGqZHOOHcdX5d+Mg/D2OS2RJiBvWR8O2HpeC3nim6PziF6ZTXl4yN6h
         pNdJheX6ym19bGjLb251tiVYKUFTDDUwHxXYtPru/U3o4JgHofNhHC8JLFNZTIvPgTnn
         GK+9h2NyvXq6G96Xgb6z9tC+qBxFgRfGEZ7OuGy4N/JuPOj3MM6+Ncpwzz8t5NshCC2u
         +6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894313; x=1757499113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaEC72YkdU0dzg1YAuuKkN3WkhmBtHuuoh/1oBPlyDY=;
        b=q4f3RzbQMqvs/wZVORyz+KB2tmllyg/vjizl2NzCLvwr7utBvXsBGYPg7XE3c8Cx3Q
         Ob+H2/3xj+RyDL9E4gi2M/U90kPWfAPnxJOOQZvpi6n7JHVai8FJQdAJRQxzseALmuty
         BQK+4AvybOvX7P9fNZI1wsw7xGW47cxVnx/a363EjvpNtR66+evkM490OmK5eY3Ulz2w
         75IarsBCBXLjhzVg08IahJs4DsHtX/aHzROzQ7Y+/qSZe569sUs9pApA0A4PfuB9E6Gm
         6roeVb0mHSSYNaqR6Sn3/uSmAIRTV89FT54B0M8g/d/RerZxK/8qAiLQb/+YgpIuig72
         DqrA==
X-Forwarded-Encrypted: i=1; AJvYcCUPlRil0RiEgGhMn582Fn8bJw4289WcF2ShpRjfVp9EuKbIiKJ+WWm/kU/v8qaXOqUhNkgflBOT5pzxtSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ZV8ecSBXQqc+jowyC0INBIGCSf/ew2x45P2gSP84mPEMipLl
	/11XIGrlTPdoM9kq6L7v7giZcxYbB7jAJSdPAxjiYmb+DS3aHaNB+U2caR+ovKLtFc0=
X-Gm-Gg: ASbGncs5AOJ1DGcEGtpeVWRmtfqOn8Um7MODHB5tA1caENV43bsK5K2Urv8bi+pTphd
	zoZQlSXGnk5uH0H47yO5KFTmZNxe1X5tRf8bpPMpr2KerPatlUB3oZ6Fms3tcdQhqziGDKPEi8q
	Ug+M9TRh9LhYGwTId6WIuGmaLgZ101Xsf6zzDw1NtjAwuo8gXSAIXmIUSSuT5PCOog91twMql1I
	PYrxryO+xwcgdD2adVD2KG+6A+EfyJ9IKt5J4y9tBLgi5vV9GgbIpLiLVfcMghwE+rW7rvrywe3
	U5rGtHzFFBUwJNQl1O+yD4Nchaf8tkkK9x9vu8ST35qfIeko251RPsStfhenDtkmN/ArQvcMe7/
	Xu/C/svEQdDNKtb+getDyskxv04FeHvxzs3LwQ3GJGe0zlcdKGWn3rE2diioYq5Zdi6JAgbWsg3
	MUPppINDrC1R4S
X-Google-Smtp-Source: AGHT+IHqbWry8xvL9J/n0nJMx7Sm8XKZqsiZtmb0vZ5EuUF59SiOy4XjuOBRm6SxlSbxf5fnxVNO0Q==
X-Received: by 2002:a05:6512:3b0d:b0:55f:5685:b5e9 with SMTP id 2adb3069b0e04-55f708b3332mr4752512e87.8.1756894312876;
        Wed, 03 Sep 2025 03:11:52 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acea03csm417484e87.90.2025.09.03.03.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:11:52 -0700 (PDT)
Message-ID: <fb8b827e-9aee-4aea-8291-30e5e4c539dc@blackwall.org>
Date: Wed, 3 Sep 2025 13:11:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
 <20250829084747.55c6386f@kernel.org>
 <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
 <aLdQhJoViBzxcWYE@sellars> <aLd2_um-oWhS23Md@sellars>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <aLd2_um-oWhS23Md@sellars>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/25 02:00, Linus Lüssing wrote:
> On Tue, Sep 02, 2025 at 10:16:04PM +0200, Linus Lüssing wrote:
>> On the other hand, moving the spinlock out of / around
>> __br_multicast_stop() would lead to a sleeping-while-atomic bug
>> when calling timer_delete_sync() in there. And if I were to change
>> these to a timer_delete() I guess there is no way to do the sync
>> part after unlocking? There is no equivalent to something like the
>> flush_workqueue() / drain_workqueue() for workqueues, but for
>> simple timers instead, right?
> 
> I'm wondering if it would be sufficient to use timer_del() on
> .ndo_stop->br_dev_stop()->br_multicast_stop().
> 
> And use timer_del_sync() only on
> .ndo_uninit->br_dev_uninit()-> br_multicast_dev_del()->
> br_multicast_ctx_deinit() and
> br_vlan_put_master()->br_multicast_ctx_deinit().
> 
> 
> So basically only sync / wait for timer callbacks to finish if
> their context is about to be free'd, on bridge or VLAN destruction?

You should make sure the state is sane if the callbacks can be executed after
br_multicast_stop(). There are many timers that can affect different aspects,
it might be doable but needs careful inspection and code ordering.


