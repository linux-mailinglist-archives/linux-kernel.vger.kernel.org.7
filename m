Return-Path: <linux-kernel+bounces-893322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D45C47110
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF32C1893DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8CC311968;
	Mon, 10 Nov 2025 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDjJgD6Z"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0768A307AEA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783238; cv=none; b=S/46yZ6qWr9yBCsgkePF/IOImGDwmr8f+zOG/ctPRuyj3NAQjoc3G2UorbyrQ5KkeZ9gYXBMLIxk9fiYBqoVUTkIvSj5O+HX4GxovTNcxoQDuPm4/LuJOcBj+fJFRNFQLcj+fhsAIzp/ysW+QITAEvB82oo2ZAeBI6YekOS++0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783238; c=relaxed/simple;
	bh=5aIm3j91ZTCbpZvr139X78Yr55miWzCUn8iBZ96dngk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4O3yMuvkhLKs9gZaB8Cg3INqBw+N9dySqsowEPOGB7MskLrv3e7uzWHJvchIr/Ev4e+SHMlOfcKlixtXnR3C4vFvJFLFeAyo3W/5rnBAaQ7ygaBTvanPrghhF37vGi7jiVqtU9eRATuo/S+Tpg5mHMeakkxxVXsoXnU2x395lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDjJgD6Z; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-471191ac79dso32216685e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762783235; x=1763388035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4l3M70pV0c14d1SIvE9JX7nk/ZPCIDubtc+GHmzBoAE=;
        b=mDjJgD6ZBSqE6ASgwmbRwIqap1HTPLTvPtkpg04BgPLog7uu/d4rVh5ugZ22FJTVYp
         1fphAVckJ+nNmocwC2uVE08mpw6yctDwsITrupyWTROhUPcexPMswMnATZE1gr+OaI2O
         gpXYOShowB3MMmxh9Cn82qRhyeMTehUk37IJ30rEpf9vABbDkNco6Fk7ddHnauR6ONyI
         gaNKjFe9XJcR/L4r0n5nPfJ0FgFzZZN+/D0xwZ/4e6dEOEhqC1JvpOEt3y2RkXUX4/li
         UqqThtMnR3y/K4bRe4W7OzFzJC/wXcOQv/zKPbNmlh46GIkZGZCKCkuw3odeZf2IO2q3
         gU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762783235; x=1763388035;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4l3M70pV0c14d1SIvE9JX7nk/ZPCIDubtc+GHmzBoAE=;
        b=uQKqnGGcAFSDE+oAOArkzukaqnSEon0mHjQL0bXMmkO2d5laLqQOzSpd0coTUgTusP
         Wu8a19ToCYy8tOtpZUFJ60gigGPtYrapXj9t0QaezZBAVruH0b3yiB/MK5H/JjPNwDkM
         /+SmCaNss5juuOaMa/WQYPWdJPuLc7ndrmGMyTQHYp1HbDm1xIcPpDipcoQ5CpJBc5w8
         uYyuxgFmJ15jF/gt2JKGhOOP3JDU4hu4kC3USseGpz7NyzCoaDR5bcitwgih3OUEHFQ9
         amYm/a8M9nfccY7fOyg1N24ieVwAkk7RSjCTkZzWsjmjOotRQzVJs4/lETEl8FMyEjY7
         FXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOMbV1VCHyPPq5DzyYXGYJ65E+ETLB34ukZ3Ih7SPtGMEHj6iRE+/3W23gt4nfL21W+LgCJdC/xXQcfOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5TGwFyK8nA/OH+1ZSztMRInD/HfhDWC8RRTRVvbkaxQgJn2ms
	YYI/Qy2bKI/uiyBYZ8K3iZKHTPp621uDUIVkjirBl7kt4n0zGjaRRIzC
X-Gm-Gg: ASbGncvfxew4yGXT+FoQH6qrrOhrfshP378cUhyxm4BSIB5SXrPBg3A3DY3/wya8KgB
	6SgG35SSV/gLoLG0YcIEorSZZLHy80/iVx1MMExAIWJH4ZhWTH4Z4YuzSNqVrOkL2nfp5YqMgTO
	1wkwivEkHM0nSE5Vs5vkvnvt32kmjOEhOFDVXA/JDKoIuOERRu8JC5S3SgBDvlMYq5V51cDWsmu
	i2yGXXLaieGJvXE05Dh4la4GChvLm7OgwVFRdSKetQ5Xel0FVoQbw8XeTa3LbQrtO7iPRTT201C
	He0mXhILRrPBif/d31SoIm5M3fksZ1Y6sg3Fum1ZFzJhdRl4ZNIiQFwjT7AMPUgSvqH8hDNDjXM
	4hV3FqJrApOVsnDAJyM3M4CwvI8/k6tOlTS8WABiCBnrbwU4OzXESTQmljcvW9Q11wfIAIsf2TF
	q2ZYsga4c9f5REG7gUv4WrHlBf9K6bc4zsfopsXB/VWSYb0MgUX0woM1D4EplZZVv/cmT45DAeo
	uSnWRKzzJYP3dl9tZLkfTWMNdYwv1j2G9xdXHU3EIt800HNhpREkQ74RzGP
X-Google-Smtp-Source: AGHT+IF4UYzYuQ5gtNvkLSNSf73n/ZiCTwtuvYmTJtVCw6+PSGNCr+TyxhYSZT5k12Csb6f4YHcj2Q==
X-Received: by 2002:a05:600c:a6a6:b0:477:79cf:89d4 with SMTP id 5b1f17b1804b1-47779cf8b43mr33422025e9.31.1762783234986;
        Mon, 10 Nov 2025 06:00:34 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc33c8sm318303885e9.2.2025.11.10.06.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 06:00:34 -0800 (PST)
Message-ID: <9b622374-778a-4459-aca9-4eb406a58516@gmail.com>
Date: Mon, 10 Nov 2025 15:00:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
To: Matthew Wilcox <willy@infradead.org>, Shivank Garg <shivankg@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Branden Moore <Branden.Moore@amd.com>
References: <20251110113254.77822-1-shivankg@amd.com>
 <aRHs3pA2kOr_uD3k@casper.infradead.org>
From: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Content-Language: en-US
In-Reply-To: <aRHs3pA2kOr_uD3k@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.11.25 14:47, Matthew Wilcox wrote:
> On Mon, Nov 10, 2025 at 11:32:53AM +0000, Shivank Garg wrote:
>> When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
>> text sections), the pages may still be dirty from recent writes. The
> 
> That explanation derails my brain entirely.  Text isn't writable!  How
> can the pages be dirty and file-backed text?

Files are writable :)

