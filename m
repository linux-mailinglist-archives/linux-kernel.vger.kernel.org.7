Return-Path: <linux-kernel+bounces-780697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82285B30828
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1523B8703
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CBD24676E;
	Thu, 21 Aug 2025 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jF5wXqHW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B62393DE6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810871; cv=none; b=SXrDdBb3Hi/QjGsA4Dx92m+uy/gd0ic7NHjyvY7QHS0Ma8Lyhby2hkPT48wI9qi4xO/vxQw09vTwPMv2CWWClG81o093BSIK4QH7n5CaHEySMdKGezLCZDBbPBcVRtonh3FJ1RFH1S79LZH83Cuq5DsI0Fgj4nyUrdQ0hDIQeIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810871; c=relaxed/simple;
	bh=xwuHEDDPdnEPkZcdY9Zso8nS+oaLu0PyT/uLP51cArk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fFei4++kCR0QRxgiBNVIUMM/7SsP7s6N/OxZ+1S+3KW2ErY+f6ptq6j95cDeZe3MkOhpkssAd3+Do+7mS+u58sqSb1w3tqG0jFvMgf4ReRnUznVsVCOWBc2RZ2uhm4ToBjxU1hHO15hrfCa4X39Md6sftbtIYGkJyLoC4N1DH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jF5wXqHW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755810868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ioUI8cmcz7ygE2zmwR75HDYpcdV9VBKvl5HcXVuFUxA=;
	b=jF5wXqHWGKh3E2nVz6mOY3DxqKBYbrkw8NyLKweg7psvGGhd5vgQcWegxp0TEFKMz3qNlA
	pgpP6p9pWVujJwiuSjR3uRt5Ih+W/2FIkuomR7dkZks3lvl/EU/v+6aDX9GbVaZKKKXf6Q
	qIBPk8o4jWPUkdh+MdmjqwGBJqbz/GE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Y6PoXNdrOgWkAbMw5kDrCA-1; Thu, 21 Aug 2025 17:14:27 -0400
X-MC-Unique: Y6PoXNdrOgWkAbMw5kDrCA-1
X-Mimecast-MFC-AGG-ID: Y6PoXNdrOgWkAbMw5kDrCA_1755810866
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9e4157303so950567f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755810866; x=1756415666;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioUI8cmcz7ygE2zmwR75HDYpcdV9VBKvl5HcXVuFUxA=;
        b=ZxkNrzSPryzSLKzxBlkFgTu0QwMUr7M5hd3lYxlq56DhVtvyWHPID15Thai9sv9Wc/
         R93bL20P0yJmJ4usjnXk7rRzsHTdfR9sXzY1PNnaNZ9OyhUoCqWq9Q4t12tZBhJxi7WA
         6ce1Nsfc3MrEwMAQwwwunMB34n/F1A2zpTc9uqfGvHrBRH9cvrzkHITY2gfmyKggIdnp
         hbOXiAU6/erCUatm01P1HqOmZX9187s4vJA1jbaBKCH3zTrG+6K2/PlkPAmD1E1eBD/H
         DFJ+PLDzuj2n2ujyk6iVZp6JYbQwK8vQA4c7l73tP9mE22oeqOHBSivheyE9qXxUb2U/
         HUNw==
X-Forwarded-Encrypted: i=1; AJvYcCVMscf2hthgUrOoVCXvGBif6RzXWgl/grP5zciV16YHoq9he9puASOKWmGugv7aWldhq3dgH4F50guAw8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU98M4R+qVTx5J+jd8d8ROMlmvXGh5IKgHnLDvpe27uUCNAgU7
	SR1N6y9BJK4Zn9lIA0f4hftKX+w3aNiInyN6Jv2yyg8gnGzBRTQ3SB2uU4sMcV3xPrlVQCF5/Dm
	/SsGsuvc0rF2tgZ1rQxIejlQm56AbyNm1jZdDjKCqPmnsfIMpMj8y3gM/r2LGwbqEgg==
X-Gm-Gg: ASbGnctwAweFY1avxK8htzu6d4NmuoItntTkXUoQ2v3ucbHyOmXJPMiFTtGbZpZZnkn
	hx/u+sOK2lbNPYcCNZq9+n4K3qdVUyFbekgUGDe+m/HtP7G37YceJU6AX/aOxixa/YZb0/1Mpwz
	FwbdzLW0WPZaJR68b8BuPIafdn6DUmKt53+SE0C84njGAVoDKAlQSIJjheb4HBr+OfG+wylwKZA
	Q4o5aYJf17m/crf7UKZv0RRgTBTkIEZ4Dm48fEdwysRsqSiIJd7t6xACQSwJ6wiDEW9qJpXG/fH
	IqFuowN11NcpQgDUVUzEvijjs/KJ6ixXjX0tFXdznFRooMRxhPBaz+sUYSyctScwnoH4fhSfjn1
	Rja/8FIFFksVH7rTL/I8niwAcehfQzDYxaIU7piaKUTZMQNBLxxGGhD9CNofrtw==
X-Received: by 2002:a05:6000:2509:b0:3a4:d6ed:8e2e with SMTP id ffacd0b85a97d-3c5dc72c93bmr238259f8f.41.1755810865921;
        Thu, 21 Aug 2025 14:14:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfZR3J8xcLuL0M0XeCzgOw7Ipe4LAMzvYBMQKYFmYgqujJYVfH9z4RtyGRgLllHkn6SQCfAA==
X-Received: by 2002:a05:6000:2509:b0:3a4:d6ed:8e2e with SMTP id ffacd0b85a97d-3c5dc72c93bmr238225f8f.41.1755810865412;
        Thu, 21 Aug 2025 14:14:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f26:ba00:803:6ec5:9918:6fd? (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4c218c599sm3610221f8f.67.2025.08.21.14.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 14:14:24 -0700 (PDT)
Message-ID: <8c6239a9-8414-469c-9b94-a43735b4e882@redhat.com>
Date: Thu, 21 Aug 2025 23:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] copy_process: Handle architectures where
 sizeof(unsigned long) < sizeof(u64)
To: schuster.simon@siemens-energy.com, Dinh Nguyen <dinguyen@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Kees Cook <kees@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250821-nios2-implement-clone3-v1-0-1bb24017376a@siemens-energy.com>
 <20250821-nios2-implement-clone3-v1-1-1bb24017376a@siemens-energy.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250821-nios2-implement-clone3-v1-1-1bb24017376a@siemens-energy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.08.25 13:27, Simon Schuster via B4 Relay wrote:
> From: Simon Schuster <schuster.simon@siemens-energy.com>
> 
> With the introduction of clone3 in commit 7f192e3cd316 ("fork: add
> clone3") the effective bit width of clone_flags on all architectures was
> increased from 32bit to 64bit. However, the signature of the copy_*
> helper functions (e.g., copy_sighand) used by copy_process was not
> adapted, as such, they potentially truncate the flags on architectures
> such as nios2, where unsigned long is a 32bit unsigned integer type.
> 
> This can, for instance, be observed via failures of kernel selftest
> clone3_clear_sighand, which attempts to trigger the conditional
> 
> 	if (clone_flags & CLONE_CLEAR_SIGHAND)
> 
> in function copy_sighand within fork.c that will always fail given:
> 
> 	unsigned long /* == uint32_t */ clone_flags
> 	#define CLONE_CLEAR_SIGHAND 0x100000000ULL
> 
> This commit fixes the bug by always passing clone_flags via their
> declared u64 type, invariant of architecture-dependent integer sizes.

Sounds reasonable.

But is this actually something that is already exposed before patch#2 on 
other architectures?

(I assume above output is with patch #2 but without patch #1)

If so, we need a Fixes:. If not, we're good.

-- 
Cheers

David / dhildenb


