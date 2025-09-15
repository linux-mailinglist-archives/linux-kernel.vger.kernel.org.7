Return-Path: <linux-kernel+bounces-817086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A9DB57DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BCC5188B12D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9CE1F09A8;
	Mon, 15 Sep 2025 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrmIUOkm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BBE1C860A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757943958; cv=none; b=GKZ8mziWRFDh+pOjunJnEzu0Dd6tty2dJbffLND9O446i/ktCtT3HnUj4ioB/nFtcV8FFGydW73+CeJzlvDksmKeVMyt0IXXyEYfw6h6eRpnDLayrHh4nGgIU0dkVkHw5qqBAb6yaffmLImgSoJFMVdsBtUlJPYQVLJzZBi5Qk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757943958; c=relaxed/simple;
	bh=I5W/knZo+C+k5MndTDb88L5F795kx9d9lXr20jpPjhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTGBgQYYYuzcTJtLBMnoe8e9kv0U781/JZ1LUpKH/Fe5uqTMaD3X8pJ02LoZCZbzsd5/DhAQS9Cz1JDcNwGG4lIJIjRIjcyH1qaiqA4v3sNuqKUYjcDyCafabNgvSw/tOfWkacLRVybZpHlHMr8POPP4D0NL9Ta1zQ7sm16bPtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TrmIUOkm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757943955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qd22CcRHxTz6S9weuM1x7AkdMNNHqOghUEX9jI8G2J4=;
	b=TrmIUOkmU8DHCIdHuu+0esk3lGUSwawxH1Vk8vaOiNRjXeEaLjhM8rH233RKB4NcPCJpGN
	PoeLsCRB1Z1hC48UXCXGcLe+sITbt4rtNBtPyVJ2Zl7VouWCFFYWZ/MjaNgcEjbudH7eP9
	dqjN0QwG6Ux86rdsqHe1HX4cYDnXzp8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-_4OEqNW0MSSr2Ais-AXhAg-1; Mon, 15 Sep 2025 09:45:50 -0400
X-MC-Unique: _4OEqNW0MSSr2Ais-AXhAg-1
X-Mimecast-MFC-AGG-ID: _4OEqNW0MSSr2Ais-AXhAg_1757943949
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e76416ddd5so2680860f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 06:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757943949; x=1758548749;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qd22CcRHxTz6S9weuM1x7AkdMNNHqOghUEX9jI8G2J4=;
        b=VOJK1tAXqQKnwXcYAuIu7EAQY0TDgqFBrBM/pgB4x7O5tu6PWh5L9pp3ytWpagMMPG
         OvRgkCOu5gDMGrY2Y7Tvm1NVZpNBQnfyioz/w0F9yjE4iJ/QxbUSfaub6hmwhETOXjTe
         9gAbHluDK+a8SvpvHem1HXIl1WjDi0J1wxXQEao3Nt8kKzJK5K42c4mqOGJ+Ov4+Ydrs
         45RvRkdT1wl8J7eUFl7lO2h119DvJnG96b2Gl+XX3BZ23/rTdefQhdRItR1OWWa8rKyo
         kSPkDXUrqkJspauQ2GDZAanpkPhn61oGk60mWGX3erwzaoluxMw6+RVLS5kSdJWf7ire
         ovGg==
X-Forwarded-Encrypted: i=1; AJvYcCXGDl+S9kooQ4x8pj5RnMGGMJGI4F/2X79GHLShOcH0/4eXiAUYGki6HSzX/d7kvlUmLlHsTOnaIyJRous=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncSqCsYJc4CCfy4zs1mNtvmIeiVGS+KsHpcUaQhwpRlHAeY/t
	PrPAEao+vJxhWiwgCppHvRy5Cc3IO4idk7M7psMFY2FumML1S1CtrBJy0eoTzc23RvVbNNeLT4d
	nTzs/7U+nVTwP7kU/O6KvwLgrTa56SS/U2EjgPYrPQdgc6Uq2ZLDdJwbPmoA+N7dVzA==
X-Gm-Gg: ASbGnctdQRqqhAYgwJx0d/rrn2cQJe8drkTC1zK99RWXOSpv6r25OJA9kSBJQpIpvxO
	LfHE6qkY9wpYBNrgBOK+0wwhNn4roFVqgBhvoQWccs1J2PH+Bcq3xlNKtPnDKFn1iFmjlKz/X6S
	a40Gsk1NVi80Tc9k2TpBd3et3MrI73hZfrEyKi3yqIqIAklvDmehTmisUZeJs1+Do9v47Lz24jB
	IwsmzJ5wMQ3qb48gG7pPgjT+D+ypGnZA6jXbU49uX+Oxm2dswlABnkMbk1CprtAjk5zDnIonOnM
	4ymLVziU+p//zYsVJ7zp+TgQZpN5bzFXRGxD2KOaTyCaQcCXjcQcJTM2cBMVMuYuzo6YOAg/UM3
	v3y2RyUMoYBd9Tqv19f6AN21/CASoLCBk0POLUHniUmbNGtVpmZt1/152sA+9i7ckyw4=
X-Received: by 2002:a05:6000:438a:b0:3eb:5ff:cb2e with SMTP id ffacd0b85a97d-3eb05ffcfdbmr1834631f8f.29.1757943949031;
        Mon, 15 Sep 2025 06:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFLyX6UvLCuUUA80n4GoWHIr/EyUeUL4oLh9hf7GfvHPwfVKVtA1c+Ma7f+eiXJQjtzYNjOg==
X-Received: by 2002:a05:6000:438a:b0:3eb:5ff:cb2e with SMTP id ffacd0b85a97d-3eb05ffcfdbmr1834581f8f.29.1757943948471;
        Mon, 15 Sep 2025 06:45:48 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd? (p200300d82f18f900e0ae65d58bf88cfd.dip0.t-ipconnect.de. [2003:d8:2f18:f900:e0ae:65d5:8bf8:8cfd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a066366fsm7321173f8f.44.2025.09.15.06.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 06:45:47 -0700 (PDT)
Message-ID: <2b13e434-192a-451c-a09b-69eb92392a3e@redhat.com>
Date: Mon, 15 Sep 2025 15:45:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 0/5] riscv: mm: Add soft-dirty and uffd-wp support
To: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Deepak Gupta <debug@rivosinc.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20250915101343.1449546-1-zhangchunyan@iscas.ac.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250915101343.1449546-1-zhangchunyan@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 12:13, Chunyan Zhang wrote:
> This patchset adds support for Svrsw60t59b [1] extension which is ratified now,
> also add soft dirty and userfaultfd write protect tracking for RISC-V.
> 
> The patches 1 and 2 add macros to allow architectures to define their own checks
> if the soft-dirty / uffd_wp PTE bits are available, in other words for RISC-V,
> the Svrsw60t59b extension is supported on which device the kernel is running.
> 
> This patchset has been tested with kselftest mm suite in which soft-dirty,
> madv_populate, test_unmerge_uffd_wp, and uffd-unit-tests run and pass,
> and no regressions are observed in any of the other tests.
> 
> This patchset applies on top of v6.17-rc6.

What are the plans for this series? It fails to apply on top of 
mm-unstable / mm-new, so likely merge conflicts when merging through 
another tree.

Likely best to base this on mm-new and route it through the MM tree?


-- 
Cheers

David / dhildenb


