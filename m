Return-Path: <linux-kernel+bounces-814946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FAFB55ABC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E7FAC7BCA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52C3A1CD;
	Sat, 13 Sep 2025 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EX2o/wIe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD61E515
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723618; cv=none; b=Mor+2bRhr/83JOyIMePsP3wIw/mRgT41qD3E1zNbllOCm9HvEABbVaMh7Ymh9UBB5Xnd86jI22s7dIryhtkuaHYZBMOnUm3hf48ZGd09RgT93xG6DXQkuYuQPUKF1GAk1EGfAULweDC5ToS8NBjo85xavwrRfYTI8PfjJgywgzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723618; c=relaxed/simple;
	bh=6ixjMQGo+mF9rxxhZunX9VzR5bs0JXrtOuI72NkTM98=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gu8BOoD8pfu7ef6habJr65Udwgc3jZ4zH/psRNBi7GTh82W58VyKY1z+RJfKj1/AlIx1j6uugODTo8LXgbfhZPQDMVIVJ1bapNeGoQuiUpAA68RnJcylYZGsFK1s9xEa7XcwhrYWr6Kuck6Y6nTNf68hASZYn69YXr7iN3NPk/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EX2o/wIe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757723616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
	b=EX2o/wIeA6yu+Srg3Sxs2Y8vBkgsMaktHFj5GL3p7M1mFpdOiBZpNaSq1GHJqpr5Ku8IFz
	lAykwWGVWFypGy+7l551HJ7+pyYsrdoHcuyxDYZcMY0fB0/XeWe5V8A0sHe6tyX/kROj8d
	nEPzfWQqiGv/dpeyzGGCpxH9ALjz82c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-VhCw77buM1Wq9JnykviIJw-1; Fri, 12 Sep 2025 20:33:35 -0400
X-MC-Unique: VhCw77buM1Wq9JnykviIJw-1
X-Mimecast-MFC-AGG-ID: VhCw77buM1Wq9JnykviIJw_1757723614
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ee6cd9a3so53727891cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723614; x=1758328414;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncBfGy8EE17qYCVshxa8cc5ygoQQollWUOgPghVnN+8=;
        b=J+7v63xb4BLr2zx4GLN1BOOENOmmPfCUYH/Wr3XILr2EPjdLPCvg3lMnIwT7WKuhiR
         dtcXJ+M2lQVJyqqkhKFyQTZStdaZZ/RWG8EUVYQAfuuaHzb22qwsMy7eT9Us35dV/gTJ
         nh9kRKZcQ3xb4E+bzj1c8pWKR3fOzsdBZ/N+wXXkWpGVAV4aFbsBv1c8mVJ3Zunnx9m9
         MZJhZa1zWttz2zqpt9ouEfntOWNNP3F67QdfuQ9W1FSSGbG3ilsLd3u9mq2bPY7dkBHX
         5Ww1sckbReRcdF90sBN4e4zyJaLcnJpPOsABZlNFO/b5f+FlrNgGnSnzwrdp7sSe9LQ8
         1EZA==
X-Forwarded-Encrypted: i=1; AJvYcCXIfj+W/lcCRNDViOBJH71ng44qnPsAJLCxIkIQ0Pc5HsZ7xKPL4jdRIdXcNTNh2WLOZKIHF7ne+RojYyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFlQhzw1eSHklsRRWu8OPFma1WOFaLnc33jwDaYVu9d0OB9+2/
	W5rc+rRX2+7OZ3761zZYUdiOKzw67tD/iMRmO2VUy+OWk0I6I6bVBZuow2Lerq1eyJ23EImZU0p
	Sy9k0+e6fafGm4S2jVlNRuJRnsfLfzTVcPu9zdnC12x7lHu2aXVZm3Cy9OmzS4gysig==
X-Gm-Gg: ASbGncvCbI2LrfjqcLVgv/dvpckQguocLVkT/3b8z0qPWRn4Fy1sGTubc8PjhRS5cjA
	4qlndFxIPppSTv8tK/9uGxuzP8QKaStJfghocYC5+tD+dKLInRJJkFJIAZQTTRnz4K9SvlN7+8N
	j18den8KKjn/CuAjGPlwOQ9MxQfk2+Ia+mDL+MZ42Xmy5VPiQ4vHftzYyAcgZBpkmKfsUkgyJiF
	S4t79NI/ta4ViEBTOLKHGIyqiXiPVoOkOYO2sBcWFqDHJ466bKA+6wBhzvZqBzbivmEUgBSn078
	foZdpdHaFCJHzZ7UXl7ItU6280xRW9u1wtfaCeFmXFNgt7WtA/izZhEhGZhBowK+TPb3p1fwxRO
	srHzW2HLEYg==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076391cf.79.1757723614314;
        Fri, 12 Sep 2025 17:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRq8wbBNQnbSCZtG/tvewoa9dvMcBJkb7MXthP0yviRVZ6G/ctSPGgxUCMnelFEMNwo4BLAw==
X-Received: by 2002:a05:622a:1a05:b0:4b6:2f52:5342 with SMTP id d75a77b69052e-4b77d1ab3a1mr68076091cf.79.1757723613947;
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639b99de1sm31462791cf.8.2025.09.12.17.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:33:33 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9d06c0d5-e20c-4069-adca-68a2c4cf6f4f@redhat.com>
Date: Fri, 12 Sep 2025 20:33:31 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-nfs@vger.kernel.org, linux-aio@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
 cgroups@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
 <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
 <20250912213531.7-YeRBeD@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250912213531.7-YeRBeD@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 5:35 PM, Sebastian Andrzej Siewior wrote:
> On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
>> On 9/12/25 2:50 AM, pengdonglin wrote:
>>> From: pengdonglin <pengdonglin@xiaomi.com>
>>>
>>> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
>>> disable preemption, which provides RCU read-side protection. When
>>> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
>>> manage RCU read-side critical sections.
>> I have some doubt about your claim that disabling preemption provides RCU
>> read-side protection. It is true for some flavors but probably not all. I do
>> know that disabling interrupt will provide RCU read-side protection. So for
>> spin_lock_irq*() calls, that is valid. I am not sure about spin_lock_bh(),
>> maybe it applies there too. we need some RCU people to confirm.
> The claim is valid since Paul merged the three flavours we had. Before
> that preempt_disable() (and disabling irqs) would match
> rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() were
> different in terms of grace period and clean up.
> So _now_ we could remove it if it makes things easier.

Thanks for the clarification.

In this case, I think the patch description should mention the commit 
that unify the 3 RCU flavors to make sure that this patch won't be 
accidentally backport'ed to an older kernel without the necessary 
prerequisite commit(s).

Cheers,
Longman


