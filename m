Return-Path: <linux-kernel+bounces-724388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB739AFF1FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AB35A6214
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E070241695;
	Wed,  9 Jul 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8h/hiiW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6123B63F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752090173; cv=none; b=RoQo7i/FekpxoYYTv3D1c5H6TwYRRIT/YLybKYNgscFp2i0Dc331IbMaiPyGXEDig4u742GLAGLst25U/WJ0aO/+obLfzSzGvSzrQODc+77CXsxMZ8AWXDtmkMz0TSgYeF0Qg31k8q1RDxocqVhNt4ZP0C+MR+zVyahRXXUE5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752090173; c=relaxed/simple;
	bh=3U4WnPLcfs1wyyDmm0SAgoVPgx3FFU+dTf2XoWVK13U=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GLnff95O3BSkxW8eguMZUs2ureqYX71luS1Bv+V/w16XhtxElRrOCNbA3SgmabGVDcpBbGo2t+0pSIkb0lhRhKMIHkKMVq1z/c/f/spd/UbTZ8t1GWSnytuLcnqBQClsppIHgZRglDky6bxtcsnSu+XIBYsf0XSdNqE/ZggbuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8h/hiiW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752090170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vY/q1JNw0QqC4RlP87mu/UsMm3Cj4QXPlhHBZsNSTN0=;
	b=R8h/hiiWr+sTog8fk+31BXfONL8VKxmXkcL/aAtaLJrv73mIS4n19UPzx25VNpumf3KB2R
	Ig+rXEsO0u6TiLOmS69Jb9JT5uuL3AehdqrVTYpqRBZ677Ux2P/zzzILnKOlvOhzP6wKue
	ymlBj4pji0AE2V5zzyKa7nW6VU8y7uc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-HddCWAXHMwGdSbAewD-CJg-1; Wed, 09 Jul 2025 15:42:49 -0400
X-MC-Unique: HddCWAXHMwGdSbAewD-CJg-1
X-Mimecast-MFC-AGG-ID: HddCWAXHMwGdSbAewD-CJg_1752090169
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a58cd9b142so5837151cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752090169; x=1752694969;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vY/q1JNw0QqC4RlP87mu/UsMm3Cj4QXPlhHBZsNSTN0=;
        b=OZOV82d5oudIbeEh4M57zxtMw5ygp/IMKEBXILeyHODH3VwHwpQJrM5dE7qQUARLCm
         otHgzCPiZMYNLW0OrmCunNNC0q+SU6shgmADEoo4ifQmYXMUrsDUd/vaXTBRuwduSi/v
         TTlS1VYrAv7Gh1s4eGfHyiqKI3GlT6QABXK6RqcEqvHwhw2yZbitHMnc/fLH2tDkayrg
         odyiivn50Wsxo7m1mu/fnPC27mUJNJiKdoVjAB5CjHhLzeBx1jU4/2iLVINVAE29ixRH
         XNjX1PTIqjuCZwgdDiYCelRBBrGv4Fl/ryI93KZ8Y3pgMJFjV41IPMtzFFYoMpXo10ph
         4Fpg==
X-Forwarded-Encrypted: i=1; AJvYcCUX0j8K0BFdlHK3JPpL7DaZw4wGPZtdBQwGJlpPmhvoNaUWoY88jMQZIqfgXFoXHgoLgU2Cut9u4c5qt1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEsuVqyzdDgOqQKW7Y9jp74UNxAQ/wRUIhKiWhIe6EOVPElM4
	mxjdeWqvZCoEYnX/vwlaSV/cUr5WDL8ImYRjCV3XP3IOd/77Erb/sKCCeDq7oDhV9Hra4mN/Gcd
	LoBdTaTo9rdD+2nog8IfP0Esn/+v2b5/t5RLW730FspBEWYLgDPcCin+7Iu2OBU7u7Q==
X-Gm-Gg: ASbGnctr610VHhxcJAcUsv5Ztiv0ANxppQIYiZcBZNmIwcPcF6kRZ9FtbmQzVWdY7GL
	+ptQ5mCSvfaTrAVIMR/Nc0yp551AVxmPyvJuh9dZ8l8TZ+QgePMs+EWGBZyhXDgKFzPyzml/mBO
	7xjkgUoHhQppdHhFtZ0mRonSGmF/S9F0mT3AT3gh43rGtikZzasLbMc/1ox1i3gKyUnKk8pZuI5
	f8owx5NeoTK1Ggchk5jXdn2LyoTa1NB1lDMia4HL4oxqdL0iPM90hzwo7AvvYx3Rhc4plxNuBYJ
	Ash9CPAEHXvQBaCmW31Hz2PnDlAprVkxfwyZJzeqRkYVkN4u5U08cRDypdSDwau6auri
X-Received: by 2002:ac8:5a8e:0:b0:4a9:ab9b:6603 with SMTP id d75a77b69052e-4a9ded45e9dmr52625641cf.38.1752090168854;
        Wed, 09 Jul 2025 12:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5TBy0hinNa+OHbIcHtVv+guP6G1qZrwthZ/QVIZFR/lmLzDMo1Tot1Jiix54fZsB4b2YNOg==
X-Received: by 2002:ac8:5a8e:0:b0:4a9:ab9b:6603 with SMTP id d75a77b69052e-4a9ded45e9dmr52625281cf.38.1752090168481;
        Wed, 09 Jul 2025 12:42:48 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949fb04asm103874321cf.20.2025.07.09.12.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 12:42:47 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <700c49da-1e30-4b99-ad41-3b052c80b64b@redhat.com>
Date: Wed, 9 Jul 2025 15:42:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: Disable preemption in
 __mutex_unlock_slowpath()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20250709180550.147205-1-longman@redhat.com>
 <CAHk-=wimw8A1ReDPMyAVPrB3rEzenkk-u21RN123BGmnGBwjiQ@mail.gmail.com>
 <CAHk-=whVBKwK83R_7+52qzZb3DpFWGG8L=V5bDG6VS44e3=1-A@mail.gmail.com>
 <CAHk-=wjT5Y36Xs1zdE1OdM-AwxUMcC9fQC=8r1_GvawP1oqC3Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=wjT5Y36Xs1zdE1OdM-AwxUMcC9fQC=8r1_GvawP1oqC3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/9/25 2:28 PM, Linus Torvalds wrote:
> On Wed, 9 Jul 2025 at 11:21, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> And I suspect it would involve the exact *opposite* of your patch:
>> make mutex_unlock() actively cause preemption after it has released
>> the lock but before it has done the final accesses.
> .. sadly, I suspect we have a ton of mutex_unlock() users in atomic
> contexts, so we probably can't do that. It's not like you *should* do
> it, but I don't think we've ever disallowed it.
>
> You can't use mutex_unlock from interrupts etc, but you can use it
> while holding a spinlock.

I have just sent out another mutex patch to enforce a context switch in 
__mutex_unlock_slowpath() under the right context.

As for this one, you are right that hiding it may not be the best idea. 
So I am going to drop it.

Cheers,
Longman


