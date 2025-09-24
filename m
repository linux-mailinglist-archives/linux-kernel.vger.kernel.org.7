Return-Path: <linux-kernel+bounces-830866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A561EB9ABE5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2691891E39
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86211311945;
	Wed, 24 Sep 2025 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DesiKDyt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0013054F8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758728348; cv=none; b=ooOCultC6K22O1T1usfbDoKHSgoCk0dAYczLB1LMOGyIXknjBkyPVmJlHG/ZPiaFIvAuMIrJ/Kxz5c+h8lKCKWwha060brP4mS+Dkvx7kdlmJcAjB3nbbUii3+/4odK2eypGtGhJOqDeH5cfYKyVgCrNAZkRsfUyswKoO8pkbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758728348; c=relaxed/simple;
	bh=UsXqmKWvjG6h1YBmLwPbbkwWjuTwnzGRTj5iHBI5Ud0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCd+W/e4/NUnKCH1ldx9igluwW6lh+MYHaZPY8F2gujVswJJSQNxbDVz+TGphhDij/HBllCTu/zzylCecnBclMiiFYCyawT6WwFOv33mOkaaTEbC/Yq3RQlob1zUVIisNOggLOuxrFnrGSK48yy8YT6DRdy9nvN0k6Riq/MpsF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DesiKDyt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758728346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I3hnbNQr+CMB/T5Lrt4+Z4OuC6HJ7S7MgiA4J3LQveE=;
	b=DesiKDythzfEMsXjJKtkdWWRYVRFEV0zlaruMTJpFUIVSQlf+Zw5ZlAU7P1Y601p+YHdOk
	3cGieETkTrcphGxihJUmQwA7B39pM14RgTzSkvi8+p/nYTGfSqvFdED3+JeWclsbfAj6l5
	p3kYLzGcLg8LkOk+0+ZX+HEtRsykevA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-vw9nOy77NGWr4LxRh1T5Yw-1; Wed, 24 Sep 2025 11:39:04 -0400
X-MC-Unique: vw9nOy77NGWr4LxRh1T5Yw-1
X-Mimecast-MFC-AGG-ID: vw9nOy77NGWr4LxRh1T5Yw_1758728343
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso1425f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758728343; x=1759333143;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I3hnbNQr+CMB/T5Lrt4+Z4OuC6HJ7S7MgiA4J3LQveE=;
        b=MgvB6NYWjHUsOGmgZM+GaUb3GCN4RsbK/RE/S76rv89DX77vPP2AOIuFHnqI8AgKeh
         ahw3oGMnwDvjDMFlaewOYJKzp2dCTRkndp+NoEIOVT1asBH3A6kqn4pSdQZGmuVlY04l
         EmNp3iePvh2V06weCS9o2njmIuRfZL4xWusH29i6L+EJFJnZU3EvGm0fV6ubr1cZblwM
         V3OTWF1rZGA22cY6Qg4Zye2vIHWFNje712iX6FGVDx8t7ecCR6Ma9f0Dp5Ki4y7I0GUP
         GQqXxc0d4HYScXj6A6hszFnVeb+O94U3hv7FIoIxMw6H7bJM/ipWfWILOs+PhqeQ0DBY
         QS1g==
X-Forwarded-Encrypted: i=1; AJvYcCXgjuxZnS1EbynVZL183a7Y3EBcWRN8D6DAIBp7CxUAPpjsiJPmhlEeFWW9EeuS/xmL7OQT+kiBu+YtGAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLuw8DtAWfi55UT/wrsokiVDT/cc2TGzcX8STMmiaOY2hkbT/
	aZKMihY7xBRn1pNIhloZsM5cMP0bDDjX8hrgVzif7MMkLeLkETGmEH+wPTwgkI9BEqco0BHNjHg
	iVLb+N3BspVgnguXINuNaW9R1o08lGD1T0ZNi4Ijw2mn6jU2QI/Qv10IcLZzYIPehkg==
X-Gm-Gg: ASbGncvL29JWv9i2+jgzZ4r6FNh0Gu0cPXWfGh1Wa9jOsqgFwc6Uva0N5DEOxlVAQEh
	4U2bRYALKvDPLdnm5CTDrBsPFqcYW8jlBQsVUi8DrlQZki0vrbSZly5ZTc4lR9meFjhNJpv7upd
	3TIX2N7eEvhLQJvN4HsGMRdvHS8hQFQTGmahKMyUnY0ERKouKGVgoR8YumLiLOr4tsye3tEeQJK
	C1DFbEaFjRz+gzJiMLR9vzaPtObRs3KYynhdJlXFJvhnWcTL/G6WPdbmylWOqsmyfG/BxKNChEr
	+o4w5BsCTASzJ41UPzMpIRjs/f6HwwYjPFfnb9JNqTd2Ri+G2uupQXvXdIqNgQ7CnJj4nw7Y3er
	WIJVzB3g4DeCMtfnc7h5/i7swrjyiskdnqZiicVnKFOaL0vPX4UqAOsgLH6p044fmKg==
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr389130f8f.32.1758728343226;
        Wed, 24 Sep 2025 08:39:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgd4QFIbHl+KGwltRD/ttCSG+TyRobItnmS8e1jCrWLoT42l4oEjJc1CeO+4N34B2hOAK5lg==
X-Received: by 2002:a05:6000:3102:b0:405:3028:1bce with SMTP id ffacd0b85a97d-40e4886dea7mr389052f8f.32.1758728342727;
        Wed, 24 Sep 2025 08:39:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f3d68sm28588947f8f.10.2025.09.24.08.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 08:39:02 -0700 (PDT)
Message-ID: <be77e0e7-4cb6-4a10-86f2-50e8d001fd84@redhat.com>
Date: Wed, 24 Sep 2025 17:38:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/12] Direct Map Removal Support for guest_memfd
To: "Roy, Patrick" <roypat@amazon.co.uk>,
 "patrick.roy@campus.lmu.de" <patrick.roy@campus.lmu.de>
Cc: "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "andrii@kernel.org" <andrii@kernel.org>, "ast@kernel.org" <ast@kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "derekmn@amazon.co.uk" <derekmn@amazon.co.uk>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "haoluo@google.com" <haoluo@google.com>, "hpa@zytor.com" <hpa@zytor.com>,
 "Thomson, Jack" <jackabt@amazon.co.uk>, "jannh@google.com"
 <jannh@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "jolsa@kernel.org" <jolsa@kernel.org>,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "luto@kernel.org" <luto@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "maz@kernel.org" <maz@kernel.org>, "mhocko@suse.com" <mhocko@suse.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "pfalcato@suse.de" <pfalcato@suse.de>, "rppt@kernel.org" <rppt@kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>, "seanjc@google.com"
 <seanjc@google.com>, "shuah@kernel.org" <shuah@kernel.org>,
 "song@kernel.org" <song@kernel.org>, "surenb@google.com"
 <surenb@google.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "tabba@google.com" <tabba@google.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "vbabka@suse.cz"
 <vbabka@suse.cz>, "will@kernel.org" <will@kernel.org>,
 "willy@infradead.org" <willy@infradead.org>, "x86@kernel.org"
 <x86@kernel.org>, "Cali, Marco" <xmarcalx@amazon.co.uk>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>
References: <20250924151101.2225820-1-patrick.roy@campus.lmu.de>
 <20250924152912.11563-1-roypat@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924152912.11563-1-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 17:29, Roy, Patrick wrote:
> _sigh_

Happens to the best of us :)

> 
> I tried to submit this iteration from a personal email, because amazon's mail
> server was scrambling the "From" header and I couldn't figure out why (and also
> because I am leaving Amazon next month and wanted replies to go into an inbox
> to which I'll continue to have access). And then after posting the first 4
> emails I hit "daily mail quota exceeded", and had to submit the rest of the
> patch series from the amazon email anyway. Sorry about the resulting mess (i
> think the threading got slightly messed up as a result of this). I'll something
> else out for the next iteration.

I had luck recovering from temporary mail server issues in the past by 
sending the remainder as "--in-reply-to=" with message-id of cover 
letter and using "--no-thread" IIRC.

-- 
Cheers

David / dhildenb


