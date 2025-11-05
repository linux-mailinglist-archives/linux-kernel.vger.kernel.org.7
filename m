Return-Path: <linux-kernel+bounces-886555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95479C35ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A32561630
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7042630FC04;
	Wed,  5 Nov 2025 13:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBWUlveh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqxpsYeP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0BF321F2A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350587; cv=none; b=ef6aXTLaTv6LqGXJdOYD2B9q0A5Wbycpx2MXQ0HvL6OMQ+S2/XlWETBmMIzRrNJFvsAl+h3Ewq3xRY/zPrIJwruZmTNf4r+EY+SiN3MUgq4swnlbq52fE/Y8w8kQzJe7xg7oaFtAlhTRaxG0HwGrAOYB70WqFubAhAOvperMvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350587; c=relaxed/simple;
	bh=kzg8uR0x7L/MsfY3Iy+9dhek3bFid4Ly2GEmcaceXRA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kAt0kb4KY0glBnQUikN0lKcqmh9LzlLux9DSnk0JekejoOQrEdXKgwhJyV5kZUv2Shc0P/rrG+iNyO8ZWHnazK5TZuw/z9nMiBpnhUOqh0aFxoTgb+24FLk+GDFQ7yUtuwkOGzj9p8PVEaJoNP9Xj/8SmgwTSGQXct/HpFlBERQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBWUlveh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqxpsYeP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762350584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uOBuFfF3B0NWyKgpCCN/9jCULZvQio1gCrlthonJhHg=;
	b=bBWUlvehZMWo1WeMnxlSUBzNZ6hGlERVbtZMF5aZQue9CvMiUXUqlpgyaqz0VaLrHlx6hh
	g9AgjQZn9pa0tNfwCE9myTkYDOrNgBJXBg0X9T6PxRlRHQHctJ1nFlqo6ct9oaO5Zdeh1/
	2bFLJVmPXDslDgM6ocMTkk7DlldSXT0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-gpZwCgHEMXmgWo3p315s2A-1; Wed, 05 Nov 2025 08:49:44 -0500
X-MC-Unique: gpZwCgHEMXmgWo3p315s2A-1
X-Mimecast-MFC-AGG-ID: gpZwCgHEMXmgWo3p315s2A_1762350583
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-89eb8ee2a79so3455189585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762350583; x=1762955383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uOBuFfF3B0NWyKgpCCN/9jCULZvQio1gCrlthonJhHg=;
        b=FqxpsYePjyZNTSKTyXjaktKnveU25tv3DXEU9t1uptwOsT9/1nXDeH2YeMgS7ibS6o
         ktfGl3hdhWPmGDrk7g4ye48AYp7+6XnoVo2ZLZSLhZama1KruSqiolTdBItQoIA9LCmm
         kvUzVnOQlRX5xIAncOdImMADkXZylu1O0n8uNH24vYs+oKpEICruetXNFfO7ixkHaOnC
         IfjPmKOs4JUB2GjMM9Te5ySuwc/7O2lbqW29yQamDwyE9jYnA/7ZvDFPc5tM256EZw4y
         lwpMazpuNtMwCRTK/rMNr+UrEg9vJiX0oKrc2oESZDekLgKTSBO7uiH37n/2FbTosyXQ
         Ml5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350583; x=1762955383;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOBuFfF3B0NWyKgpCCN/9jCULZvQio1gCrlthonJhHg=;
        b=KLqfdo9FAsakjgis4puYskzZj39zuiDc3qhRG5mFbX8DTe1FphtwimKddOp45JBXlp
         c//c6hOW/KKRYjdeW5lAd0cthJ08GZ11pHKq+Yaslx4xDL2FzcQjaR17iauQpDfQ6vUF
         CXYlM8dpmfgKaWO1gNJOLAmx5n+0BU+vvmOZslz5w52VaNOSdcvBfhncl/YH5lAUXA0P
         bR0VBsHEseGRxK86DEpdfCMtFbAUlcyYCNnzF+vjk8RK3fHnhtI8FIIHpKoX0y9VsRDN
         bU1dWcUtHnKYdfuYaW/vD99DK2rI6FqXrp2b4j/+3LbG48vI1oLvh/am2ClvOicRdeSX
         vu+w==
X-Gm-Message-State: AOJu0Yzjxj2DqPokJoTs32ulS58BgtIwvnSr04sWP+l6YByhYqxE8uQ8
	E6XfSaN4/DtoRLO/ewHyuEYjnnRnuRFQWSXaRwn+9KM4C/Tg9Dqtjh82FhKXoYdSjvDSMZJZ6XH
	/tlm/EzppxdXnJ1Z6zN1U1V5CXFoAuGYNZeJVRFmhP1iXWjkHJcU3cceSpGb4HMcrOg==
X-Gm-Gg: ASbGncuYXbMkdi0x/VE8kyyWl/QekPPASwj3QLq1jHKA75k0OcYZQymZqcj5hwNo0l1
	rLIOFEZ7XtQyytu1Po4PFpFiYXHW7TrR23bK1d0X5BtXfEuPtpvSiTl8BnlWOdQjao2ArZpGtnS
	nbGJCM3qEyGRkmYSfqeORgB1bHt7qJzqC681zkVyZTqgYLVGKK36MEPrPDV6Yq2ckY0w+nfQzVn
	l35uurq5EY1ZGhXKTpSv0pc3ycbmLJzpdXe7djWb9LPt4HNnAezBDsaXzjOPRphYwwdlY1NF2KM
	zNWHm+Gi3vXrbh+gqaOSBXZBdRu1k2EMXaBynabn0FazqHgDEnAP2QpkOGr5dAnbVubfB+/9m4H
	FVXbvcdqEWTRfb+40RLGTrL+9aCCwIZmmvBukJ+SIaBIhbA==
X-Received: by 2002:a05:620a:28c4:b0:8a3:b6a9:d3c2 with SMTP id af79cd13be357-8b220bb8ab5mr509515285a.44.1762350582339;
        Wed, 05 Nov 2025 05:49:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5Nh03EnLV23RY3CTB4C7BADwRxkNyMDkpsAIitUMoGCnXQW2sEsEnbOV13RAvPiZx15s9jQ==
X-Received: by 2002:a05:620a:28c4:b0:8a3:b6a9:d3c2 with SMTP id af79cd13be357-8b220bb8ab5mr509495785a.44.1762350579049;
        Wed, 05 Nov 2025 05:49:39 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f8284e76sm408417785a.50.2025.11.05.05.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 05:49:06 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <10899bd0-09ca-4fcf-8142-3d5cd6e4fedf@redhat.com>
Date: Wed, 5 Nov 2025 08:49:05 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: Redo __mutex_init()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will@kernel.org>
References: <20251104140023.jV9j77ld@linutronix.de>
 <4207482b-fc63-4db7-ab98-36b31a600173@redhat.com>
 <20251105075729.SJ4cL1rz@linutronix.de>
Content-Language: en-US
In-Reply-To: <20251105075729.SJ4cL1rz@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 2:57 AM, Sebastian Andrzej Siewior wrote:
> On 2025-11-04 11:21:27 [-0500], Waiman Long wrote:
>>> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
>>> +void mutex_init_ld(struct mutex *lock, const char *name, struct lock_class_key *key);
>>> +
>>> +static inline void __mutex_init(struct mutex *lock, const char *name,
>>> +				struct lock_class_key *key)
>>> +{
>>> +	mutex_init_ld(lock, name, key);
>>> +}
>>> +#else
>>> +extern void mutex_init_plain(struct mutex *lock);
>>> +
>>> +static inline void __mutex_init(struct mutex *lock, const char *name,
>>> +				struct lock_class_key *key)
>>> +{
>>> +	mutex_init_plain(lock);
>>> +}
>>> +#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
>> I think it is a good idea to eliminate useless strings in non-lockdep
>> kernel. However, the function names are kind of awkward to me. First of all,
>> it is hard to associate "ld" with lockdep as ld is also the name of the GNU
>> linker. I would prefer to fully spell out as "lockdep". The "_plain" suffix
>> also looks odd to me. How about using the original __mutex_init for the
>> plain version and __mutex_init_lockdep as the lockdep version which calls
>> __mutex_init and use similar naming scheme for the RT versions. What do you
>> think?
> What about
> 	mutex_init_plain() -> mutex_init_generic()
> 	mutex_init_ld() -> mutex_init_lockdep()
Yes, generic is a much better name.
>
> Using __mutex_init() for the basic/ generic init could work but we have
> already users 13 users (drivers/ mm/ net/) and the rust bindings are
> also attached to it. I would prefer the generic/ lockdep suffix.
>
> If you want __mutex_init() for the generic, regardless, we would first
> need to make room and then something like mutex_init_lockdep() could be
> the public interface replacing __mutex_init() in its current function.

Ah, I don't realize that there are users of __mutex_init() outside of 
the locking subsystem. In this case, we have to maintain the semantics 
of __mutex_init() to avoid affecting other subsystems.

Thanks for the clarification.

Cheers,
Longman


