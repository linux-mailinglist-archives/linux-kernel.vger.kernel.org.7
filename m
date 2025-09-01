Return-Path: <linux-kernel+bounces-794501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FACB3E2AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723283B8F0E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408722727E0;
	Mon,  1 Sep 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+s5Pljh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF76C31355E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729522; cv=none; b=hBR2YeO+5kEuBxDKVJLCFztN2Q9XHOIRF5ooC5r/fHXsmi3Ss5t0VGBE5P6yVQi/mK4RpfYKppRDYQYq8KosLq86wZliNeeh7XKd+68jfdz43+hj0FyFPnCx2CY61YI9iVs3PppKUq4hDXo9qx7tyW1X8pm0MIzLj6anwi9fP1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729522; c=relaxed/simple;
	bh=vvT8E59Qgse03jpTj3BGdeYp8ChJbxDxfLdL+AMnkZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccCJzAv5qIbq3fpEkF4KMXBPp6FOo8T8RS1cyKgBr0dGLCgFs4e9nDeZiWRYX/j/rSRzqezzpo/8Si/dtLwnVwFOTzPOZR6gI81nK9GoptPUbN1Lms02VEiG80MLfU4BNQUcgLvfSocp0xU1cS/MCprdct3vIpsOpCHShmeQiF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+s5Pljh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756729519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ry3HTsvjDYn6ZhWkEuXZ7HIdFuNl7/b7zLeVSRNzby4=;
	b=f+s5PljhWQ2mvi86o2wC+whlY9Z9dih0SpRtWq/tg4YwLw/FHCXG6klictWrp/yYMsOaKA
	TsgCSbTW/Z58oaRD0P8A3BaH04CMN8g1eyiB2qBNspyKMwzb3Fp0ggK2qQBdgpbPQEazdV
	MTnZP2rstkZ89npOSTN2BUsVe9vzKCA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-Yi54rIWQMoGTTj4C9Fj5QQ-1; Mon, 01 Sep 2025 08:25:18 -0400
X-MC-Unique: Yi54rIWQMoGTTj4C9Fj5QQ-1
X-Mimecast-MFC-AGG-ID: Yi54rIWQMoGTTj4C9Fj5QQ_1756729517
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b7c01a6d3so23693665e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729517; x=1757334317;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ry3HTsvjDYn6ZhWkEuXZ7HIdFuNl7/b7zLeVSRNzby4=;
        b=eY0ps2SIDTIk5canBYth+Wz+QEtUPWXfzjAwXmujAXADi1X571BGpIzgsu8dsOzp5f
         RD5zBs1vMfDeGGzvGvq91cInr5aGMQKzbMC0uM9n0OePOx3kV0nf2qgPFL9aTUKnkec+
         4iiLqVcD3bO+lbaisQOJqEHjKNwL0ntrY2Q1BPLxFPnYBHUvJwGdQOp5mOXGs9mHuOJc
         IAAMH455nWjb+WyG3fhrcs0bKxwUopwu5G8yr8VtfHLTNhaetBdBPkq0LXg+j5zLbbSJ
         toYGv6w4WAWetCcOZKGui7HvPfzaxKLRw5vq1iZ8I4CkKFBnIxfzypVozISWCWDDcpMk
         1CYQ==
X-Forwarded-Encrypted: i=1; AJvYcCULTGDsd4oXFb2wiLYePDJuawGbmHb37m/5dB0v15mNH7PAj3l3m10c0NV1cvI5GfFaKoelGcFerQGB51E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsyq+/kBIuf7i7hnIsrhAbSuO1dFjskRiN5TRQLFwFa0DZWass
	Ogw8nwqEdHq9HDEr08ZquqmQqBfTAgSq9RtUqTV/zSCJwo3+VECpyvriT+uCJnx/a+vQ6uoYiqZ
	sAehIhbeRvZp2KVwYvQdqjJAOAtRh0EdyD77VGGa6+YVGoGBnjZPa/Vq/pyXRqTWj+g==
X-Gm-Gg: ASbGncuifdIFpbgKB33JPpk5MGdQVX0cFpIPGjhmrOu/Ob9QYZ3g2JGnBga+eLmLi92
	0KddgEhuzSQNFb4hZ0RgXyVdrg8Ujx+FuLJDK0LwiYefDp3q2gEmaarEApSb2tlJJjxb8Dq15IN
	z/J+PTLts1BkZ3iBPrrQtPWxpyUI5jRfr37QKmBYAeqgf20K6xKLTv5LmmVDgGRZ6LvRs0WIz7m
	rWBX0HrSOXysYfEgvosCKg/uYfvzrRmKs9oarTQl+H+1+XHJHUkvBxj/GFC+NSM8q+uu/uvMcYM
	MI/nHp4jXcZOknB2ltw9zTmAW41x+8rL9fsBLOs7VazhHm2Vv07D4dtpwKBfRxbcFSfWsVCOM47
	THuJlHf7TaUTHC+KSoFMVgx74WX5y6rvtUnX0cLTivZo5qvtWgW3jXWHzXbi1L+MjIuE=
X-Received: by 2002:a05:600c:1e89:b0:45b:88ed:9558 with SMTP id 5b1f17b1804b1-45b88ed9bc3mr51982075e9.30.1756729517120;
        Mon, 01 Sep 2025 05:25:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMGDtOgsZk0c5UDFaUJZJgP3BXCuLTMzz4/00ieMVST2ui2ccALyIM8NlgAkQyyG7Klnzysg==
X-Received: by 2002:a05:600c:1e89:b0:45b:88ed:9558 with SMTP id 5b1f17b1804b1-45b88ed9bc3mr51981875e9.30.1756729516581;
        Mon, 01 Sep 2025 05:25:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm237238175e9.1.2025.09.01.05.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:25:15 -0700 (PDT)
Message-ID: <dc21e54c-d7ae-4d7e-9acb-6a3fa573b20f@redhat.com>
Date: Mon, 1 Sep 2025 14:25:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] cgroups: Add support for pinned device memory
To: Maarten Lankhorst <dev@lankhorst.se>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 =?UTF-8?Q?=27Thomas_Hellstr=C3=B6m=27?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?=27Michal_Koutn=C3=BD=27?=
 <mkoutny@suse.com>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "'Liam R . Howlett'" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: Michal Hocko <mhocko@suse.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20250819114932.597600-5-dev@lankhorst.se>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250819114932.597600-5-dev@lankhorst.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 13:49, Maarten Lankhorst wrote:
> When exporting dma-bufs to other devices, even when it is allowed to use
> move_notify in some drivers, performance will degrade severely when
> eviction happens.
> 
> A perticular example where this can happen is in a multi-card setup,
> where PCI-E peer-to-peer is used to prevent using access to system memory.
> 
> If the buffer is evicted to system memory, not only the evicting GPU wher
> the buffer resided is affected, but it will also stall the GPU that is
> waiting on the buffer.
> 
> It also makes sense for long running jobs not to be preempted by having
> its buffers evicted, so it will make sense to have the ability to pin
> from system memory too.
> 
> This is dependant on patches by Dave Airlie, so it's not part of this
> series yet. But I'm planning on extending pinning to the memory cgroup
> controller in the future to handle this case.
> 
> Implementation details:
> 
> For each cgroup up until the root cgroup, the 'min' limit is checked
> against currently effectively pinned value. If the value will go above
> 'min', the pinning attempt is rejected.
> 
> Pinned memory is handled slightly different and affects calculating
> effective min/low values. Pinned memory is subtracted from both,
> and needs to be added afterwards when calculating.

The term "pinning" is overloaded, and frequently we refer to 
pin_user_pages() and friends.

So I'm wondering if there is an alternative term to describe what you 
want to achieve.

Is it something like "unevictable" ?

-- 
Cheers

David / dhildenb


