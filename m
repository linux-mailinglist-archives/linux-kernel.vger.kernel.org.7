Return-Path: <linux-kernel+bounces-849359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D865BCFEB9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 04:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5557C349517
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 02:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9B21D5174;
	Sun, 12 Oct 2025 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cerwEU3u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D60B3398B
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 02:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760236285; cv=none; b=dzsI6HFRzIsAJKmIauEJL2ugLphxvFVEOb8kCrhA+4QxxQYnEFutUqy+H8mlT/tPuTMCYrB77+uyLm/3SOW7uOwpkcgTkKHtF9evTpt7TSLNDkaWYtnPJRue7q6U+Q+mp1byCh6dUOas/m9psyyLuhITB877auHsdyxcmyN1ulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760236285; c=relaxed/simple;
	bh=l7rSw51HVVDUeWtxRvKBKLJ6CNxGhzR/CcWNOHEaFF0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DsULAhVuXWC3dFSvjsxtooDPJym1G14KL14DdZeVqJM/lzP7E2lAiDUI+37P1IPmFxxbI9U2UBmR4mBq7A9IQa+2Zy6T5WgZ8IldGgK1onIKMj8XVYgC3OodzSNmticz4mfjBJfbAgQNjO8tvPFV8yrGehb2tKqaHjg/BG8qda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cerwEU3u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760236281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANDZ/rFmKG4qmurj0/jTIlbT5FBdoiK7XWV5SVqAIis=;
	b=cerwEU3u75vcCWSPkf+9Jj+4OE8D30V0IgTN2zmwrXVRBB7A2k1in5TX50lRc+6WLTgmKC
	DDRE0fGQUwEdj4pk0zSv2IWqAskVBqeBxqsRZ4DFlZa/lgPvXnyQNlOvDfYwW83wEuW+IW
	uQGUl3q2OFpGdJbSrc/v35qCmkWVqeg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Xd2pp6nlOf6iXJ2BRCtlGw-1; Sat, 11 Oct 2025 22:31:20 -0400
X-MC-Unique: Xd2pp6nlOf6iXJ2BRCtlGw-1
X-Mimecast-MFC-AGG-ID: Xd2pp6nlOf6iXJ2BRCtlGw_1760236280
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-85dd8633b1bso2265465785a.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 19:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760236280; x=1760841080;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANDZ/rFmKG4qmurj0/jTIlbT5FBdoiK7XWV5SVqAIis=;
        b=CX7PClb1ynP0QrmlRCguhXBWPgauxbxTpJKZBr70Un7RigN7wQH6VxtzgsRZWDk7b4
         wpCgEdldubWf8IMh4rt48pOWfAtrLNcEXTpTduryK3TgBzxyzsFTcMRTZZvhhujO6a2S
         XNMpoDwUosnLjKbWWof5BvADJdDuYbwfd3g//awX7qRGcNwFoQK7BNpwLemI9AFh2Vum
         QaQQS+cWGz+AS5a1W0i3FZ0wL+/4GuBlt8IKXN8r3LRzcqrpvqKeqhwxFNpKfbycyoVj
         wfE7tuC2l9tok63PAIXYxCwYXT0wZMC6DcEjWrSMUmlJpUCT3ImZnq0tVhBBKdG/p3nx
         +Jgg==
X-Forwarded-Encrypted: i=1; AJvYcCUj2aw3BuN5AMxuo5vMBvYGYjzpnExeX4KiVd3WUvKyQFd9cu32l9tfrVmutyst6p7qi0hjZnWpczy8/Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhWySMt22ICZNEZLi0TQOnbjjSgY51QtmB5MVI0aJAb2kPfdvU
	m/FvuvR9mzoGhvOZRs9yG37CsoQtw/erAzDBD4b8fCU15MiWIvJWnNWjSKXDMyVHUzwr+GICnUP
	TSGGfHdPU406LF/7RqM0N7tW5lZ31I/rozwGP8z2UR1ibDCjODDypB/EGTwMoQQxinQ==
X-Gm-Gg: ASbGnctKU7yJ5JHUcxHi2MS5kboygoqbF0RS2i3HKa7KcFnfJZNaHVizTO2aHYR4Dab
	okk5+wQWsLXB8Alvl+E7suGL5WnlDxMFz2TVqR4XBJPTpVtAesN/wvdSSo3Z9nfAMZzpLhAETsH
	YgA8tIBZCZXNTeuZoWAbGxWY8G60GY+d0Ri9doA1cMt2/hDaVzjwSu6j//AwPwxWAE5wRW1TxS2
	3pSTZT4CHbnTjw0KQ55lErHLlVF/ZqpZPTXYmqxqJCadEeROMF4/z/dZ+0p5THzSXkrQ7aqiqUX
	apfxRE2HOqPT/SL46k/mqPbA+mrUeu8LXEsc8zohUmf8MnoOi7GMaPCE05k9cisuVXN04l9uHN/
	M5HaZWwRLzPo=
X-Received: by 2002:ac8:7d94:0:b0:4e7:20ff:f6a4 with SMTP id d75a77b69052e-4e720fffa61mr10796121cf.22.1760236279855;
        Sat, 11 Oct 2025 19:31:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYNybsHlv/tGtfXco8Tock5SYweIbYfS3o3L689rKkOFFdn9GyUFbtfrWjD6Y/9bMhNbv/vQ==
X-Received: by 2002:ac8:7d94:0:b0:4e7:20ff:f6a4 with SMTP id d75a77b69052e-4e720fffa61mr10795961cf.22.1760236279485;
        Sat, 11 Oct 2025 19:31:19 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e70d134a3csm38910601cf.9.2025.10.11.19.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 19:31:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <957be7c9-7860-4824-b491-88cb9741dfab@redhat.com>
Date: Sat, 11 Oct 2025 22:31:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lock: Add doc comments for spin_lock_irq()
To: Daroc Alden <daroc@lwn.net>, Waiman Long <llong@redhat.com>
Cc: corbet@lwn.net, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 "open list:LOCKING PRIMITIVES" <linux-kernel@vger.kernel.org>
References: <20251010215403.743811-1-daroc@lwn.net>
 <4482c890-f082-4946-b6ab-a7b57b02db22@redhat.com>
 <20251011142804.29da9591@azalea>
Content-Language: en-US
In-Reply-To: <20251011142804.29da9591@azalea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/11/25 2:28 PM, Daroc Alden wrote:
> On Fri, 10 Oct 2025 23:15:50 -0400
> Waiman Long <llong@redhat.com> wrote:
>
>> On 10/10/25 5:53 PM, Daroc Alden wrote:
>>> The commonly used spin_lock_irq(), spin_lock_irqsave(),
>>> spin_unlock_irq(), and spin_unlock_irqrestore() functions do not
>>> currently have any documentation; this commit adds kerneldoc
>>> comments to these four functions describing when their behavior and
>>> when they are appropriate to use.
>>>
>>> Signed-off-by: Daroc Alden <daroc@lwn.net>
>> This patch looks fine. Just wonder why just
>> spin_lock_irq()/spin_lock_irqsave() and not
>> spin_lock()/spin_lock_bh() as these functions also don't have
>> kerneldoc comments. Also spin_lock_irqsave() is a macro and not
>> actually a function, maybe we should mention that in the comment.
>>
> Because I had to research spin_lock_irq()/spin_lock_irqsave() for a
> recent article, and therefore felt confident that I understood how they
> behaved and what should go in the doc comment.
>
> If you — as a more experienced kernel person — can describe how/why the
> _bh() variants are used, I'm happy to add doc comments for them as
> well. My current understanding is that they interact with whatever is
> left of the "big kernel lock". Is that right?

"bh" in spin_lock_bh() stands for bottom half which is essentially what 
what is being done in the softIRQ context. So spin_lock_bh() just 
prevents the softIRQ code from being executed. This is my understanding, 
but I may have missed other use cases of spin_lock_bh(). Others can 
chime in if there is more to say. Anyway, I am fine with adding more 
comments to spinlock code.

Cheers, Longman


