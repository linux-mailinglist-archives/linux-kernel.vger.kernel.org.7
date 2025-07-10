Return-Path: <linux-kernel+bounces-726089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92707B007EA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6665048494E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810827A131;
	Thu, 10 Jul 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YbVO9sH1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F346F27A455
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163137; cv=none; b=brJ4uQ1BPXuwOF2RtgC7X2jg6XQUr8BrpGhxN99y9QZ3w9WtRAqNholPikI+o26P44qS35GvoQ69yYHR8nuwE24cW5lHMAxGNgkHGfLsSt6/Bx66s7VzDy+14s4Z2qNLv4tNNDWEyugJUVQ3UE5oPJQGEz1jfkKbNn65g76S9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163137; c=relaxed/simple;
	bh=sGyW1kSOut5qnGoQXMuK5P6jRPc8V1H7nGlZRurAXYo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=p1gHjBD8m6sejodZQDiNe/n8prbG96PVdXbz0jxL29/7xswe+mEBT55AriKrpuvwOw8yMqggztJToJj9M1EcdQi5vHkJbYv9MDK3I/ZyE9nbewh2XiQ6XzJx3c7nUfqU0n37C9KFH/6gWlHdb1FWKz2zND71vkt7d1r0lRxFR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YbVO9sH1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ka4ByCtzYh7nc643rftFY6Eo0Hi9GztYYANcPpx7UHs=;
	b=YbVO9sH1l+3LqJUykl4NZxrtF5BaODmSzuBbvW+jpVdtb2p66a39oeKFVSqPtDYnRbSYnH
	rDDppYGcBTdKfXmVCsqMYLWaiTkbOGG5cJtQgOf0F4kg0jLMQ0LnYMQ1nhGS2ckzWB5LzT
	OQQ9MhCYuISdZxR4RVrhCu03QQLEvSw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-05PNQWgONkqDSO0N-3e-Lg-1; Thu, 10 Jul 2025 11:58:53 -0400
X-MC-Unique: 05PNQWgONkqDSO0N-3e-Lg-1
X-Mimecast-MFC-AGG-ID: 05PNQWgONkqDSO0N-3e-Lg_1752163133
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7d3cbf784acso276519985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163133; x=1752767933;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ka4ByCtzYh7nc643rftFY6Eo0Hi9GztYYANcPpx7UHs=;
        b=hx/x3d+cL2XYK5UCLiuCFGYGhUIpUwwptI/24xMVOBVMPzbqG9Lp80b6GMziKp9q27
         HYEVR5pRjOW1FAkp6R3OV1cC9ZjDVF/uUFcfoWuKzIZStIXWFFBAuZqomAubb+nhSfbL
         GbuU4pZpm954z11HVZcyWTcGZ7IZlW+G2xF+n/zhQRRGYIBLUgObKwtAjysrTQTlnrq/
         ekx4ecT05ueRQnY7W/rUiUKr467EWZSOsCJVgPI/JyLjeRC+zOhXZAqJRdFC5PP4vvND
         3LidfHeFoPZ1uU6QHgO+kWg289U3Ckjr9Tvms38VwqILALMpeyA+FpkUPAN+f5bcEFYa
         TJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUynHEyubL5n7JuGPhgf8PQc30KFZFWy7jFD3vk+UKzSCmW2tO/x54UMHD4pYw5jpgNjYut7x7UXIecko4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7d8er/UAdvVdZhHRwoNXQsFbcuj7HBRDT8DLjb14idLUgaMBe
	u2qFbp2/+s7sbFWXzvM11aIVOoaDg7aJq5h2pFTeHiIQE0Ocje5BwHIsLSt21C1RPRU1CCusVRQ
	590c7aGfFX7pLaPd7J4pjAuwgzN5frLYWFNZx5P0QKFebqzVl619wyyAFnF03dad7zQ==
X-Gm-Gg: ASbGncvjlgO9AM/EHf+gluL+Wm3wSAjqpOWRpH/cQ10Wn07KsfFGoauMzNi+9U/jWWH
	weim69nlCIWfqUl4rV97KpOlg2aJSX6/ImMCMblwkSkPEnPIJVD4R9mg8PLzraIZzPtx88/Q6rf
	50PZ5yeA0BWXzEGdxuJOcwv0NZI632SgwXMCgH/Ptai59oVc2W029hKU93lZKL1ctZdCu7G05K8
	1k2GC1PuVJ9FuNG6pyqhotpOyi8XebgOyG6xpKdwnYie/G4O5Mw79qCnpLpVRbzVXN6tchn+OxE
	uQCuzVBBxVRCrkooqP36NW+8zliNRczGmewIm+2O3FZHdmpw0l6oHTf7pJbEd/7PTAGt
X-Received: by 2002:a05:620a:4514:b0:7d3:d8d6:1c89 with SMTP id af79cd13be357-7ddecb24767mr3989185a.43.1752163132733;
        Thu, 10 Jul 2025 08:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6ZEutdU/L1TXcRGdT1iCHfaOFeZ2TnV322Bgnpr39I8tzeW4PxYiQFJoGSxI5uPsE5bdvkQ==
X-Received: by 2002:a05:620a:4514:b0:7d3:d8d6:1c89 with SMTP id af79cd13be357-7ddecb24767mr3983785a.43.1752163132216;
        Thu, 10 Jul 2025 08:58:52 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f81easm110505685a.41.2025.07.10.08.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 08:58:51 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <103a68e9-9627-42ad-ae86-3b023c3230d7@redhat.com>
Date: Thu, 10 Jul 2025 11:58:50 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
To: Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Waiman Long <llong@redhat.com>, linux-kernel@vger.kernel.org,
 Andr?? Almeida <andrealmeid@igalia.com>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250707143623.70325-3-bigeasy@linutronix.de>
 <2f0fc991-0e70-4bb3-bdcc-f87293cb6471@redhat.com>
 <20250708134708.Rgh8nHcx@linutronix.de>
 <20250708190605.GF477119@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20250708190605.GF477119@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 3:06 PM, Peter Zijlstra wrote:
> On Tue, Jul 08, 2025 at 03:47:08PM +0200, Sebastian Andrzej Siewior wrote:
>> On 2025-07-08 09:43:44 [-0400], Waiman Long wrote:
>>> This looks somewhat like what the percpu refcount does (see
>>> lib/percpu-refcount.c). Could this be used instead of reinventing the wheel
>>> again?
>>  From the comment:
>>
>>    * futex-ref
>>    *
>>    * Heavily inspired by percpu-rwsem/percpu-refcount; not reusing any of that
>>    * code because it just doesn't fit right.
>>    *
>>    * Dual counter, per-cpu / atomic approach like percpu-refcount, except it
>>    * re-initializes the state automatically, such that the fph swizzle is also a
>>    * transition back to per-cpu.
>>
>> but I leave it up to Peter if he considers merging that.
> Basically what the comment says. Trying to reuse things ended up in a
> mess. It really isn't much code, most of it is comments.
>
I got it now. I am not against adding a variant specific to this code 
giving that we want to fix the performance regression ASAP. Merging it 
to any existing set of helpers may be something we want to do in the future.

Cheers,
Longman


