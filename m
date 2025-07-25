Return-Path: <linux-kernel+bounces-745177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 793E8B1161A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D823BC0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0F51F1909;
	Fri, 25 Jul 2025 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1raIjIi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784E632
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408575; cv=none; b=J/AkJPTtxc39gyAy6+VmZc1CA6IWqXpXfcNTwvd0b3li2MkE/JMZIagJyCStX/lhky1E8JwzE/SBVLrL5KOPvsqzlLVXvMPbN4tRH3UTwHectUmH6VlUxy3LzTQkKDy8xLA2T/KlIBfSoSOdi9M3h6fvXxy0kB5C/0q/TArphXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408575; c=relaxed/simple;
	bh=BNaw79ZxGkTEeKkkRGmTHHpiAiTq8DxMhK1qbZKSlHI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZgOkURqeeUk4j+Y1vVZqtMopQ8dwSw3zCaclpt+sgDjetRqpGv92pBNcxR/qk0r3sGAybMEteQ8bOKm6JiQmD4nnSCREAF/Ib4sl6NvwAvYQsW3Ao9Xf6ZIl88BF4QWRVNauJPQ5sVWL439jFWYkmHg1rN0QCrLWYvhPJkkHxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1raIjIi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753408572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HX/M0A4s/i+cg+i791MzBz3fGhd28OWvCamyNFpBGKU=;
	b=W1raIjIiEjDdrz+TFBHDdoAu+GQN1rC+/PRIlmz6CGWinPF9S3NatGdj3iOIqg13o9FNUB
	mylDRSnpXIU+16a8PPIqSgxKZMMtQyHLOiGM32xIy9DuZiVqYsPaCRemk98wzW3IhZ+/LJ
	EHG/qf1NbWjDPWkCz5tyr31jLnSaHNU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-TULlQue6OXSSNBpq3nxK1g-1; Thu, 24 Jul 2025 21:56:11 -0400
X-MC-Unique: TULlQue6OXSSNBpq3nxK1g-1
X-Mimecast-MFC-AGG-ID: TULlQue6OXSSNBpq3nxK1g_1753408570
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fac216872cso36434226d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753408570; x=1754013370;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HX/M0A4s/i+cg+i791MzBz3fGhd28OWvCamyNFpBGKU=;
        b=ElSTShaICW7GzJgC1ED+FwgrrjiYfc7mekKwuTv0hY6v42EentPeJkgSEp4gH7hCYf
         qRRHp9HgwyP1rdKjjenFtb+9mbH6/Klmx/t/qO8a0cPyEceStqVFA/644Du+8Ct9WEMD
         w/x8qgwk1Po+hVjlzEoe5iD79RheXSoYHoKS6LhrX+NsSRC87YLMoswQZcy51huwTXZ4
         FCxUB/raSiFxQtMgCed5eiX+4KIu5Eziv5lMEeUQjGD2uO74EjiW6Sc+zmqFkUPyDWsY
         eSX4mUC054nvMqueCPbKTJXz0KAf4+XVFTsRT3Vt+qqOVf/OsF3p4nTOwQLAmVNohX2G
         j8Iw==
X-Gm-Message-State: AOJu0Yz+bqrGSaiZhErue3ytWF7GSeIH43Y0Wq7etYusOuM3JaDCn39T
	Vy8CCKtS40ISYozCg3hLbgaNSUZmideUxu9nnToElRx89WHNziDAcMo78YMNuHj/YBqNQFjSzfQ
	OtUNl1xqce+SQlebT6fiAnIghDaTrnscQUY32u89/KmuvSLYhgdFqgIGVx8ctF5zCjw==
X-Gm-Gg: ASbGncsm/FFAm7Plilddr7r1VvztzCmJGBYuH2+eBm2Sifb8L0gc3hV5STHWK1Evau3
	6hWpYbtUQj7S+X1rNitgpGikalxRPtQPt+N/5FurkU28GSym4t5fIuCQGww22b67Lr3kfamjPB2
	RGMof1QDNRjQAq/JUwssWd5hf9MZtiOhzwV2J2cucSIKvTYaeSR4dWBIa7fCEdsaGITKfTvlp/1
	s2Bto/dWvKLPuowVgXK68w7+Ey3GG+XERdMxNLOUvwVW3+204ULAb113YbgvGn+63/z1iQMMzFw
	GR3cws06yfzPz/+2t5LGkoVL9gLyRGg2nEMRycLtFldwQ7rV17SCgyejcy6Nr/efb9x6fGFc+X6
	PLKLoucWrow==
X-Received: by 2002:a05:6214:2302:b0:6fa:ce27:5975 with SMTP id 6a1803df08f44-707207129b9mr2116056d6.22.1753408570631;
        Thu, 24 Jul 2025 18:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF88ZMD9aIpYyRLTeemGCAYKFRBf7r+s4dduG/5AHuHLCteZ88xEkXMyHvZw6F4f3mNaOEyUg==
X-Received: by 2002:a05:6214:2302:b0:6fa:ce27:5975 with SMTP id 6a1803df08f44-707207129b9mr2115696d6.22.1753408570264;
        Thu, 24 Jul 2025 18:56:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70713e0ff62sm16717736d6.96.2025.07.24.18.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 18:56:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <51ab2b78-a409-4201-97a0-30e976571df8@redhat.com>
Date: Thu, 24 Jul 2025 21:56:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: locking problems in iwlwifi? was Re: 6.16-rcX: crashing way too
 often on thinkpad X220
To: Thomas Gleixner <tglx@linutronix.de>, Waiman Long <llong@redhat.com>,
 Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 peterz@infradead.org, will@kernel.org, miriam.rachel.korenblit@intel.com,
 linux-wireless@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
 John Ogness <jogness@linutronix.de>
References: <aH/L1PCwtwe8Y1+a@duo.ucw.cz> <aID6XPLXuGo+ViTm@duo.ucw.cz>
 <aIEC4t2EICdgomZV@duo.ucw.cz> <874iv2stk3.ffs@tglx> <87zfcurexx.ffs@tglx>
 <aIJqC/0ZPhgaNdkf@duo.ucw.cz>
 <71548e22-9f3c-469e-a59d-f921da59d927@redhat.com>
 <aIKEfIjYBPzlE7y7@duo.ucw.cz>
 <6c5e70a8-2db2-4fa6-8a42-35033e480293@redhat.com> <871pq5qlgj.ffs@tglx>
Content-Language: en-US
In-Reply-To: <871pq5qlgj.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/24/25 6:21 PM, Thomas Gleixner wrote:
> On Thu, Jul 24 2025 at 15:22, Waiman Long wrote:
>> On 7/24/25 3:07 PM, Pavel Machek wrote:
>>>> The lockdep warning just means that console_owner_lock is acquired both in
>>>> softirq context and in task context with interrupt enabled. That can leads
>>>> to deadlock. So the remedy is to always take console_owner_lock with
>>>> interrupt disabled, i.e. with
>>>> raw_spin_lock_irqsave/raw_spin_lock_irqrestore.
>>> So you suspect problem is in the printk code?
>> This lockdep problem is likely unrelated to the IRQ flag problem
>> reported in the original email as it shouldn't affect the IRQ flag.
> Wrong you are ... :)
>
Sorry for coming to a conclusion early without looking more deeply into 
the printk code. I do admit that printk() isn't an area that I know 
enough about.

Will look harder next time.

Thanks,
Longman


