Return-Path: <linux-kernel+bounces-786642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F76B35F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E5C2055AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF4F85260;
	Tue, 26 Aug 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Foa67trJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0018B12
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212530; cv=none; b=KWltnwcxNV0h/rz59JtWRtyfByGgBm5IDJ3i49M4EeWqEqBGyl8SnJek+zBkZvQJqpsCgSfmpBnBooi8nvPSV69mWeY7aYGMvYHT0pD2N+76hXpc8q94SzTWvCgfaI5OPPz9xewSmiLvCRCsNC2IQhNfsh7F4LNJYxAB9E0+Hgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212530; c=relaxed/simple;
	bh=xHu8ylmXaUlWHZnZOyPJsheqcs05Rfzlnkk0oWmYNSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIhCa6fmhqQ0U+85DC38Fn6UzORmpTh0xDtNOZGMeGbsy5dDpnVR4vIwLeOHIP6UJo261szUzPdaXMj5FIhrPNZsmUy7GNkEBMXcm84cTxOFoqcisIfVcUr4A6zjF4ckFNHmZUwu0bTJ4F61rjMCtou8Dd68605zjjHfJCkvToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Foa67trJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756212527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WzXAZ7DFQn5tEjgSe5zwh5V1BGLVH0hi4yYzCVLl8IM=;
	b=Foa67trJ/E/XYqqbDi1Y8jWfVGo1llDCOc02War/QySVmcdyM/2yMLxbz/gIYpqzTcJt5Y
	lSiYMBQ0S8n/kOKS+NJ/oPrPSfewWdBa94yCQv2+A05KwAyHE0zR1sW9D9XmeTR160WdLT
	yRE5FKGTLn/Zy/GFL8qFI2qglAY67AM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-wA7s68e4O7qrYJm7h4D6zA-1; Tue, 26 Aug 2025 08:48:45 -0400
X-MC-Unique: wA7s68e4O7qrYJm7h4D6zA-1
X-Mimecast-MFC-AGG-ID: wA7s68e4O7qrYJm7h4D6zA_1756212525
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b05d31cso28685975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 05:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212524; x=1756817324;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WzXAZ7DFQn5tEjgSe5zwh5V1BGLVH0hi4yYzCVLl8IM=;
        b=VRKJqXSiO2I/iBrDTZPhV8qSsMlES/BcWXgwynvzhEgDDjQmIkkDd6o25t6mkkTG0N
         0PPQhA+J/SxLRDjqCkgMsZwYkpTa+0OwZxvxD+Krc4yu2N+kGxkl2zrbvJIqCWY7BUxS
         cRTrRaaVCGPaXJRHI3a3d8cgp0m9PuRk8cTks0lNccYIOYE4uL38X7ApPEXYDSV3rEPn
         NHB6Cg4BIMaaSHJfMTmMsnwQtb2rqszmV2gAt08MK9a25DlIQZvhUqMS4nWtcHDqbZ01
         GCTHMG+PFdVho+2X+GPxITq68DUBjOILNE6ZSb5nB2bGFpcqt6I6qmFts3pMYcI8VgXI
         XeBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyMTcbAaJCT71rB+lCVD6yL0UKG2PgoGnmEs6qG1//9dhHTC/0GTtL9cdZwSJQqCwMPg3ZyqjnqsblKPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWS05EGzkqUCQfPBPZwl1SY4DkMIxQ1cvuYmIV31P3ft3n0j6Y
	pS9aEBh+sBb+DFrdhkHZI1yD9mZ+5TyzfI6fKMbHYEi/Lm05QulEr0H9hvdJZezNtSrwD9w61bJ
	ge2X4bwAPQafwe2Py6mMMIGtsq1ffCmvToGB0uNXeZ8QHY5MxhoHS7bDByT1C3nDvdw==
X-Gm-Gg: ASbGnctZ/sCgjxRGrJehytEq9xrendTZZRtbrTPnx1oGF9O+AYghCpAqGFjGrZk9Kuz
	UD5RXKw0Z242OGr5JaMAHS1cbxEukvntFLr+WRuRZ4ux/THopt44OmgsY4de3FmLr1Udh7mxN31
	y4+qvzCRGhf5sXkuMNHlX2FNsS+hmuslU4qH6EuiPl137b3sytCfWDC6w19B8o/rGR6L9kLz9KZ
	/4AC/jKmKfit3Jfr9n+M8Fc2eNkrsIMi18gpPNTFRQ/8/0FHcAySI7e7SfqYVZ+tGAwlTiirQbQ
	BHbeSaW1w3vEWe6MBJkJanN7Pnd+kI3joQOTWYsdLpAIvMaIqQ4Hjdz4lRfIS61mBNPjPYTh+w=
	=
X-Received: by 2002:a05:600c:198f:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-45b517a0878mr130096445e9.13.1756212524179;
        Tue, 26 Aug 2025 05:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2YoOcVF2P973BH13lOX6E+LS8uY2syMjE17Nq71FWv2KBY3X93wWZAQgPt8EZXrsVzrU55Q==
X-Received: by 2002:a05:600c:198f:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-45b517a0878mr130095885e9.13.1756212523643;
        Tue, 26 Aug 2025 05:48:43 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57492878sm149364615e9.19.2025.08.26.05.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 05:48:43 -0700 (PDT)
Message-ID: <84ae113c-3bf0-47cb-913b-45c75241a805@redhat.com>
Date: Tue, 26 Aug 2025 14:48:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: add bitmap mm->flags field
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <9de8dfd9de8c95cd31622d6e52051ba0d1848f5a.1755012943.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9de8dfd9de8c95cd31622d6e52051ba0d1848f5a.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.25 17:44, Lorenzo Stoakes wrote:
> We are currently in the bizarre situation where we are constrained on the
> number of flags we can set in an mm_struct based on whether this is a
> 32-bit or 64-bit kernel.
> 
> This is because mm->flags is an unsigned long field, which is 32-bits on a
> 32-bit system and 64-bits on a 64-bit system.
> 
> In order to keep things functional across both architectures, we do not
> permit mm flag bits to be set above flag 31 (i.e. the 32nd bit).
> 
> This is a silly situation, especially given how profligate we are in
> storing metadata in mm_struct, so let's convert mm->flags into a bitmap and
> allow ourselves as many bits as we like.
> 
> To keep things manageable, firstly we introduce the bitmap at a system word
> system as a new field mm->_flags, in union.
> 
> This means the new bitmap mm->_flags is bitwise exactly identical to the
> existing mm->flags field.
> 
> We have an opportunity to also introduce some type safety here, so let's
> wrap the mm flags field as a struct and declare it as an mm_flags_t typedef
> to keep it consistent with vm_flags_t for VMAs.
> 
> We make the internal field privately accessible, in order to force the use
> of helper functions so we can enforce that accesses are bitwise as
> required.
> 
> We therefore introduce accessors prefixed with mm_flags_*() for callers to
> use. We place the bit parameter first so as to match the parameter ordering
> of the *_bit() functions.
> 
> Having this temporary union arrangement allows us to incrementally swap
> over users of mm->flags patch-by-patch rather than having to do everything
> in one fell swoop.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Incl. fixup LGTM

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


