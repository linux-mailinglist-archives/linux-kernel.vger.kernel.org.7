Return-Path: <linux-kernel+bounces-850110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FBEBD1E65
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28E0D348C27
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4C82EA484;
	Mon, 13 Oct 2025 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNFK1D2t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92934BA46
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342441; cv=none; b=Z/dkxiY98nwgK/5b+sTOlQnOYsoa4eXby7o/1DMcdoA4HK03L1riMyFtp3wV4hWkzJKToev4jKXkU2b5a1Oqea6M3wvRrcq9VlJp287m97N8ksvvWn4a4QpkVGL2tydkF40yJhttyVotilemhmSud5mQGM5ZRr3xp0ORgK1N4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342441; c=relaxed/simple;
	bh=SuXUK7thIil3HeLMi2saExfN6uS86mD5Laz4k8k2p54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0L0PdpwSYen5sZ+D6zr8LD+tCmzvqoyIZ0Upf1lgUpQPTVgxtSpngewlpF95RtxLte/6q7UhnNeTqcf0UqDes5FbW8tnUkZ7xgP4KAlC9CUx3MM2y93oTef+r8e+i6SoX3MI0pxHUiPeCPGVydsarcJfXrWWKhGJQZ+JW+XKdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNFK1D2t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760342439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IFlHlO0O6C3nxG+D2VSZdFcVU1iu/EmHMNhuweyTS0g=;
	b=GNFK1D2ttWSAyogXT7J5cT8vHfqMUeItE3U0F/OfloKRrEc+Hfbwz3MBG9jETVqMfi9TIY
	nev4+GKao4qFGHK7zij6VDGFWV2EPa49SqNQUTxjpQUZ5VNuS+GEOyDXRIjmQA2BQAJbKz
	udzDoMjgEPbpIQqq7W8M00bvXflU6Oo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-dL5FL0gMMOi-axmew2W7VA-1; Mon, 13 Oct 2025 04:00:37 -0400
X-MC-Unique: dL5FL0gMMOi-axmew2W7VA-1
X-Mimecast-MFC-AGG-ID: dL5FL0gMMOi-axmew2W7VA_1760342437
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso722495f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342436; x=1760947236;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFlHlO0O6C3nxG+D2VSZdFcVU1iu/EmHMNhuweyTS0g=;
        b=e/Sv5uRGen5wq4GBjlEqegyRj09EZ/g0r27juo3mX+NnQ48VJSez85/e9wkhlcYmWI
         oKuX71QoRw6ghRLD+mB7+apOfruUZpfFMCB9vyuR2bJDKRBqVqbldUG8vPwfPhjyOhc1
         3v6YXPs4x8p1FDpvUNbVb1pEfaxnGAxLYsRTp6zmX59iCdncH2vzxjopa7lBza0FTaEw
         U1m68OuKCMOD20bGbOklmiRxrommATVwYdQxdUVM8+TDOl+dqJxYnkr1ALoSyOiVlDeF
         C50XGqe8TvUlTpXNzdg7S6Fc5iZPSnizVl6WtItkmO77kMeazD8ustt5fqfiw06s4H2q
         3zzg==
X-Forwarded-Encrypted: i=1; AJvYcCUBiiEuXIjs7j3qtl0dGUJNSXOQ/vp3SdPezdIGyV9180zyqN2bAEsbFN4AsvsBnZIUlrrU8ues4In8apI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNRSD3D/4XRTt+W2WpYU5LlwxWTWCKPu19KFWjG8ig5J0GJdKl
	/6onXMlGI5LIXf41fI+6za90DRwxbQJhYHg+P1Dkc3AvvbOEQ90JFeOaf8r44pAq3sTQRGXCYJw
	iODxv8C4brUD4KOoqgjbsfCpaRXyQmDOH4/wiOjgBrRaqXWbT3vu3GilJBtCEXVTMWQ==
X-Gm-Gg: ASbGncsbD0xHh4jsVOC19hf7FGNfNJlxMewgIgmpK1rs1iBXlid2DctPmwmvWETEeYU
	kttgExCgsYQ0/v+qON6pgyI6U+z5gntVk/B7u8EV1cO6gvBJ5p7JgfG+fP6cJKxrvTormU7E5yC
	R7un1R4hByYbmjiUZvk7UcToq5STqq+Yd7gyTO8b2B4KsEcHPR6W8bITqO3kJoIew/1N57T+Uyh
	4hra8X+vqNS8A0hWa6mpTzDLPRPB8qffLtWQhUya6cKZwfl4GGKm83zVxHEGmImikza1PYayLuC
	Kr3BP8K96ucA0Yv82VJc6tSeA/XfeSG4zF/l/rtulwoKyuZ0z39yNHL5Q4tCpncJqC/1gOJQ5mD
	vFiU=
X-Received: by 2002:a5d:64e8:0:b0:3e9:4fe4:2621 with SMTP id ffacd0b85a97d-42666aa6354mr14480212f8f.7.1760342436488;
        Mon, 13 Oct 2025 01:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM9zKgvCFHQqK79PNBLR7HvOrjaBc3GJvkWurJxkVUOipNzIMh+6r3Gzlkx5gnE7FnQ21SMg==
X-Received: by 2002:a5d:64e8:0:b0:3e9:4fe4:2621 with SMTP id ffacd0b85a97d-42666aa6354mr14480169f8f.7.1760342436014;
        Mon, 13 Oct 2025 01:00:36 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm16718144f8f.35.2025.10.13.01.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:00:35 -0700 (PDT)
Message-ID: <e28a62ae-5482-4bda-bb00-fd8a5083fb31@redhat.com>
Date: Mon, 13 Oct 2025 10:00:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH v5 0/5] kdump: crashkernel reservation from
 CMA
To: Zhongkun He <hezhongkun.hzk@bytedance.com>, jbohac@suse.cz,
 Baoquan He <bhe@redhat.com>
Cc: kas@kernel.org, riel@surriel.com, vbabka@suse.cz, nphamcs@gmail.com,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, akpm@linux-foundation.org,
 Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
 Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
 linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.cz>,
 Muchun Song <muchun.song@linux.dev>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
 <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
 <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
 <ctrpw2ppozwtsj7544jx45kpexmaackpzzyeyhkqsjrf7cz2tc@7fmuzvy7uwec>
 <CACSyD1N0fb1H3_ssEyaAMh=2shQy-64gG_t3MqkedwfOLEExEA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CACSyD1N0fb1H3_ssEyaAMh=2shQy-64gG_t3MqkedwfOLEExEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13.10.25 06:03, Zhongkun He wrote:
> Hi folks,
> 
> We’re encountering the same issue that this patch series aims to address,
> and we also planned to leverage CMA to solve it. However, some implementation
> details on our side may differ, so we’d like to discuss our proposed approach we
> have tried in this thread.
> 
> 1. Register a dedicated CMA area for kexec kernel use
> Introduce a dedicated CMA region (e.g., kexec_cma) and allocate the control
> code page and crash segments from this area via cma_alloc. Pages for a
> normal kexec kernel can also be allocated from this region [1].
> 
> 2. Keep crashkernel=xx unchanged (register CMA)
> We introduced a flag in the kexec syscall to dynamically enable
> or disable memory reuse without system reboot. For example, with
> crashkernel=500M (a 500M cma region), cma_alloc may use 100M for the
> kernel,initrd and others data. This region could then be reused for the current
> kernel if the reuse flag is set in the syscall, or left unused for dumping user
> pages in case of a crash.
> 
> 3. Keep this CMA region inactive by default
> The CMA region should remain inactive until kexec is enabled with the reuse flag
> (or fully reused when the kdump service is not enabled). It can then
> be activated for
> use by the current kernel.
> 
> 4. Introduce a new migratetype KEXEC_CMA
> Similar to the existing CMA type, this would be used to:
> 1)Prevent page allocation from this zone for get_user_pages (GUP).
> 2)Handle page migration correctly when pages are pinned after allocation.

It will be hard to get something like that in for the purpose of kdump. 
Further, I'm afraid it might open up a can of worms of "migration 
temporarily failed" -> GUP failed issues for some workloads.

So I assume this might currently not be the best way to move forward.

One alternative would be using GCMA [1] in the current design. The CMA 
memory would not be exposed to the buddy, but can still be used as a 
cache for clean file pages. Pinning etc. is not a problem in that context.

Of course, the more we limit the usage of that region, the less 
versatile it is.

[1] https://lkml.kernel.org/r/20251010011951.2136980-1-surenb@google.com

-- 
Cheers

David / dhildenb


