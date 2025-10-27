Return-Path: <linux-kernel+bounces-871569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 819D7C0DAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 297284F8987
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7AA30FF3B;
	Mon, 27 Oct 2025 12:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6eRaNEn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596A30FC16
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568725; cv=none; b=hW1SEUv/6pS7ob4YT+oJpjmyHOEadAGVztMAmp2fgU7Jf7QDtdus9h3kVwTHBrmjowVpoNt+FYa91RVVRqAwvNHnTEbe+hem53uk0jYB1QZ6lc6tKAEZh6aOkMaI1haPeI2ztDXDPKpDNK5QQiY4gehmRQpGLzQo4eTRvxjMYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568725; c=relaxed/simple;
	bh=jkimlE3A59Sa174fi2PtZczhP/TbkMPiz9cHBMqY8UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cn7Qr8SAHgnNVfoq/k2gveQAXo+WdWwNr+cjmhuPKNGnB1xiDHjydYo2LSBp6tXMeEIeOdcFJxaWQzGnVpTTGHC/9pkptPTGsNA3TEWrkV+g9XTkk1Xfs+3qftAYcQ7L0d08YyRtZRHS5RBHdmwfFkiDm0kL4B6aiaJaDIFXGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6eRaNEn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761568723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4cvIQRmqmBNV8P6YdgjJbon9LLe8l/9b6yM7q+yxHTQ=;
	b=c6eRaNEn3DkmXxywCs1O2CdnP4uVd0uKWqn8MuLxzrLgdAQolpaobJhMWi8VS0JUkr8Qpt
	UoFYqTVUzS8EijmomEI0MjvaTYvZTvy+27EVmx2ybQTMKgs7VXXc9dEDafQ6364giwt3kH
	IA01NMC0f0p6dCq3j974ufLpu/lOgF4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-GfY4iOP0PH-bUoHrWG6ULA-1; Mon, 27 Oct 2025 08:38:41 -0400
X-MC-Unique: GfY4iOP0PH-bUoHrWG6ULA-1
X-Mimecast-MFC-AGG-ID: GfY4iOP0PH-bUoHrWG6ULA_1761568721
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e39567579so24147255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568721; x=1762173521;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cvIQRmqmBNV8P6YdgjJbon9LLe8l/9b6yM7q+yxHTQ=;
        b=CZhNEYJ1fPNoDzOKrCpWj1D0HH9VKYgRpMh3/K5lQibIQCR2sH9tn8tHIylUOF1hqc
         f6YuaCqi/NG8e6WLtcpp43T/huYOgUAtJ8kYPSfBvYnVjXXhi/Hk9BJWjbM7jGosgRMx
         SDg6+K0sYKdDPHUnX8fWc+Qd7SKBYZEVIp+3CG/lZfX8XZ4661uaFYuqsCMNO5x7vdwa
         DNYNUZJOI/1CGW9SUzx6F3Ey2k36Td0QseWmTmKUhvi3BadliuIZ7LlsEAkH7KTnX+J6
         UUeYB4RDMlxmjQGMx619IeB7ldkqE1kYOr5inVwh2eUwFZECgfczbCeV4qlJykiMyl0K
         OLiA==
X-Gm-Message-State: AOJu0YwyghLRR3olV5QPjq52Z0ahDV6HaT/MuaoEsKRRjlT9vJhfxflu
	DA5EE09PTk7/LjiGnMsNGZfzzjrrBpfyugztxx9EdYJfv3QfmMGEatcutJzBZRnXF6NXO9uSSxJ
	N9Mg/LvwDSduMxXvFm56KXkwin9n660BlF4ENdF4Sc7Ne/NULPokv8F6dyOjocrDMXw==
X-Gm-Gg: ASbGnctcRXjXvGFlsCyj2NdiD4w25/x65c85lDukCdLGqnPP8g8EMYyrNfWnj2boKOx
	fwZ9ve+JCSZRu16EzjTVx5WICCxCRTCVFhjIyY/3HnFx5BiAf6r5GuKdrBhDS0MzftcCDtp3kV2
	LJw5FSzI6DOQSssRfMWzqZP3wpkdEY+TxyvM5HyApSApQQ8EY5TUAurTtWv0Q16aNoSRzzDQS5E
	LCOd2YfPVFqnXoxb2eUuxNMBwefoj1nF7YWt9XVbDIFJT5DLeaEuq8PW14bIiE7ZOeZxr8SAJlT
	4Qs7Nn/fcAp3HEnLYYlFScv1ZoH5yH9CiUWM8oQ0JmiqGbzMKarmBXkn7wi9WVRG4ERnaVfE4Xb
	/sqg7dMOLe3sWf5kkK0l8bByqux/NL94=
X-Received: by 2002:a05:600c:3b03:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-471178a3ff6mr279997745e9.18.1761568720548;
        Mon, 27 Oct 2025 05:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9bbdh4PWkc2jU/rl4KkAQD2PqCSpwK7SfjvxDRuSE3bTT/1W5umiWwesFjMbMJkHNKlChlg==
X-Received: by 2002:a05:600c:3b03:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-471178a3ff6mr279997395e9.18.1761568720112;
        Mon, 27 Oct 2025 05:38:40 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f1cf.dip0.t-ipconnect.de. [79.241.241.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd489e6dsm133581265e9.6.2025.10.27.05.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:38:39 -0700 (PDT)
Message-ID: <7df81ee0-1161-49f4-a93f-4d9245d48e1d@redhat.com>
Date: Mon, 27 Oct 2025 13:38:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] x86/xen: use lazy_mmu_state when
 context-switching
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 David Woodhouse <dwmw2@infradead.org>, Kevin Brodsky
 <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
 Juergen Gross <jgross@suse.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org
References: <20251015082727.2395128-1-kevin.brodsky@arm.com>
 <20251015082727.2395128-12-kevin.brodsky@arm.com>
 <f0067f35-1048-4788-8401-f71d297f56f3@redhat.com>
 <348e5f1c5a90e4ab0f14b4d997baf7169745bf04.camel@infradead.org>
 <70723f4a-f42b-4d94-9344-5824e48bfad1@redhat.com>
 <cbe0d305cce6d76e00b64e7209f15b4645c15033.camel@infradead.org>
 <fcd7b731d38b256e59edd532e792a00efa4e144e.camel@physik.fu-berlin.de>
 <9faf750e-2369-4fae-b58a-ed9052cfd6f6@redhat.com>
 <1d9f416fd3665faf27841b6305b1e8d661427125.camel@physik.fu-berlin.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <1d9f416fd3665faf27841b6305b1e8d661427125.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.10.25 17:51, John Paul Adrian Glaubitz wrote:
> Hi David,

Hi,

> 
> On Fri, 2025-10-24 at 17:47 +0200, David Hildenbrand wrote:
>>> Please have people test kernel changes on SPARC on real hardware. QEMU does not
>>> emulate sun4v, for example, and therefore testing in QEMU does not cover all
>>> of SPARC hardware.
>>>
>>> There are plenty of people on the debian-sparc, gentoo-sparc and sparclinux
>>> LKML mailing lists that can test kernel patches for SPARC. If SPARC-relevant
>>> changes need to be tested, please ask there and don't bury such things in a
>>> deeply nested thread in a discussion which doesn't even have SPARC in the
>>> mail subject.
>>
>> out of curiosity, do people monitor sparclinux@ for changes to actively
>> offer testing when required -- like would it be sufficient to CC
>> relevant maintainers+list (like done here) and raise in the cover letter
>> that some testing help would be appreciated?
> 
> Yes, that's definitely the case. But it should be obvious that from the subject
> of the mail that the change affects SPARC as not everyone can read every mail
> they're receiving through mailing lists.

Agreed. One would hope that people only CC the sparc mailing list + 
maintainers when there is actually something relevant in there.

Also, it would be nice if someone (e.g., the maintainer or reviewers) 
could monitor the list to spot that there is testing demand to CC the 
right people.

I guess one problem might be that nobody is getting paid to work on 
sparc I guess (I'm happy to be wrong on that one :) ).

Regarding sparc, I'll keep in mind that we might have to write a 
separate mail to the list to get some help with testing.

> 
> I'm trying to keep up, but since I'm on mailing lists for many different architectures,
> mails can slip through the cracks.

Yeah, that's understandable.

> 
> For people that want to test changes on SPARC regularly, I can also offer accounts
> on SPARC test machines running on a Solaris LDOM (logical domain) on a SPARC T4.

For example, I do have a s390x machine in an IBM cloud where I can test 
stuff. But I worked on s390x before, so I know how to test and what to 
test, and how to troubleshoot.

On sparc I'd unfortunately have a hard time even understanding whether a 
simple boot test on some machine will actually trigger what I wanted to 
test :(

-- 
Cheers

David / dhildenb


