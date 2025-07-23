Return-Path: <linux-kernel+bounces-742067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19386B0ECC1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FE771896BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91B279324;
	Wed, 23 Jul 2025 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJa6uzj/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77AF277C98
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257945; cv=none; b=LCYhmZIQWERpRC+OCYUwcU+SOQUf6TyNnJ9Fb1BwIC4jzL1yX+fWKXInPySOjrvksVgcoHcgqL0gJccdSVbsi8cAFaiJSD3bSXFcKq8JFcHHH33KfGZcgQpfqb5hb5ns8HgZJG/V7tQ6iJIw7m6gWtn3p5LKkvXU0rHu19/+mus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257945; c=relaxed/simple;
	bh=oeClgYeFsFo1ZVSnpG93IaIEFfRZTKGpwoSrlVVlogQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sy1hbceqG5i8FxU/GTq2SZ/Qg16Xd/tg4NdKoZaRNo4ToQiv6s7Tjs2PE2alWyT7R/uEXnrDBtfozI/jIZG5R871pnfovStJkd5rxxxibfl8zXodNxXEI8/Nzc946ImkvUcCwSst5b6e5Sl1tRqvHK7VLxoXYUleHvDsCiZ0+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJa6uzj/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753257942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1MDkeWmxyoVFcHmHc5Ml+3hXrUNIffMq/rZBas/7Tjc=;
	b=RJa6uzj/0ngEN/3OTqIqprosRRZcqx3PxODPSuGvvGHLERpfOBgPAsOW2zCWbFWEzMP96s
	uHhXeM3x505Yn8l/BwuXJWl6ddA6VO2k/1RHF5L5rPc86LfcWf8gEDW3jRwBtvYonIfayJ
	VANVbCp75GiasvFVw9rJTX01gGKgt9s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-nTDMPqTrMpeiM5kR-RtJqw-1; Wed, 23 Jul 2025 04:05:41 -0400
X-MC-Unique: nTDMPqTrMpeiM5kR-RtJqw-1
X-Mimecast-MFC-AGG-ID: nTDMPqTrMpeiM5kR-RtJqw_1753257940
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45626532e27so42411945e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753257940; x=1753862740;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1MDkeWmxyoVFcHmHc5Ml+3hXrUNIffMq/rZBas/7Tjc=;
        b=eujyo+7piAfpXkYB14foqueIHCNJGMglWpq5J5Sb8kCswOAVHIoB0nIN8Yg5nxeTWn
         yCRnL7FHE6Ttepr96ywNyKTtRTjhsbfr0wMz1LoFgIRTRKUTniWtw8N/5FBG2BIW+RYA
         phCoJH8px7iXojr/iw91al/l47AKTHCV1/TPQiVSguvPbD+awRODEIA0gNIRk8OQeVyh
         TICuWoQpL9bxAzv+G5gbr3iiBL43jfAHXKDeIErMHTkM9zTv6WFcVZDjenEiwkTrDTY2
         jBV6OUnAt+SC5BM7j85TErPEywoo9M+rePv4j0aTVsU5i8PhltpDeD5Pc4dHtLa5q1XQ
         5h7w==
X-Forwarded-Encrypted: i=1; AJvYcCVPXidrINeZ0wDxrGBc4VL93TppzCGXvsA+J85c4cPkzsSi9KDzsxktvYy86yC3DaWyt36OFfQfkTPpci0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNglt7Bh5bQJXRtqy+ptWi40DudP3rwLCtI+7nwA99bMx4Vrw
	Ni4AKbCNuU4NhauXE7/4tcwaceZFDU1cwtHUFHfERapcL0XNVaPq5D7itImX/rWq4OuutdQzY5e
	xuiXmOnSO/OLc3/tl9eB/M5hBVJt/tseTfqmGshd7tvPF78HCldfgh/evNx69jWud9A==
X-Gm-Gg: ASbGncvpycHniqTenyy8dhdkrF7nWInpAFskbaxDXEKSF64IcEYV5NRzZFUD0uS0jNX
	lCLPJ2GuMyPHmicS4Rco2G51k8u1JIuDygGSulfL5qjT5BBJKDMEUcEmMAhYaLEFTww3PRgB9KC
	Ca0R3aWzbvhEmwcJ5bYkoVrTccR0Ds7Mk87pk/RB16QqkoPWdWCIs126wxxxkoBKzPTQiL36c4I
	03jGC6wmXa/yvMhLoW0CKyPgZfeOfEmDQwwIet65rZ/HazNi3v8vbbCpnxx/wcR7X9IEUBNUAJI
	Rj695XGWkJSO7mBSQmaYxTsws01gwXFSfxJBxknhvFmzqf6TooKQfds3msVkZDmhCnuuwTQRhjs
	qSjP/Ji7tpBconpsRQenDUSqpv7H4sGeS5TUjcpso+2XcrH6DtOcFYLGGvb0XciTbxyk=
X-Received: by 2002:a05:600c:a08e:b0:456:2ac6:ccc3 with SMTP id 5b1f17b1804b1-45868d6b040mr14029745e9.25.1753257939868;
        Wed, 23 Jul 2025 01:05:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrPYLIbj2mPY9A575m8HAPyrIhR31gSEJiKJqJFhiM9K8YO2VigwJNsUvVl2NYwIjh9jmjYw==
X-Received: by 2002:a05:600c:a08e:b0:456:2ac6:ccc3 with SMTP id 5b1f17b1804b1-45868d6b040mr14029325e9.25.1753257939360;
        Wed, 23 Jul 2025 01:05:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a? (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de. [2003:d8:2f00:4000:a438:1541:1da1:723a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586918b436sm15026595e9.9.2025.07.23.01.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 01:05:38 -0700 (PDT)
Message-ID: <119c3422-0bb1-4806-b81c-ccf1c7aeba4d@redhat.com>
Date: Wed, 23 Jul 2025 10:05:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: add stack trace when bad rss-counter state is
 detected
To: Xuanye Liu <liuqiye2025@163.com>, Kees Cook <kees@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250723072350.1742071-1-liuqiye2025@163.com>
 <202507230031.52B5C2B53@keescook>
 <c7a32d87-efbd-47bd-9a18-9eb51e441a7f@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <c7a32d87-efbd-47bd-9a18-9eb51e441a7f@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23.07.25 09:45, Xuanye Liu wrote:
> 
> 在 2025/7/23 15:31, Kees Cook 写道:
>> On Wed, Jul 23, 2025 at 03:23:49PM +0800, Xuanye Liu wrote:
>>> The check_mm() function verifies the correctness of rss counters in
>>> struct mm_struct. Currently, it only prints an alert when a bad
>>> rss-counter state is detected, but lacks sufficient context for
>>> debugging.
>>>
>>> This patch adds a dump_stack() call to provide a stack trace when
>>> the rss-counter state is invalid. This helps developers identify
>>> where the corrupted mm_struct is being checked and trace the
>>> underlying cause of the inconsistency.
>> Why not just convert the pr_alert to a WARN?
> Good idea! I'll gather more feedback from others and then update to v2.

Makes sense to me.

-- 
Cheers,

David / dhildenb


