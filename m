Return-Path: <linux-kernel+bounces-796115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F86B3FC1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA1C3BF74A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EC280308;
	Tue,  2 Sep 2025 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3Wf+yRT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D3272E46
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808465; cv=none; b=qM4jP4NRBb3Y4ZVFSH1JdOetFWSFTzx3EsGw97/XPlnNrQ4Ev0K3D4hVJy+4ZeECT0ck9TJ7kEzNOldu/9pD1yhFbr5+vXNwXPx1DxIYvk7nbxwdIOFvqrzi1y76pIBWkXT2fv78lN7/yjqney+GkDtZhxSm8Lx4k8Sv/f59YDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808465; c=relaxed/simple;
	bh=y6SLbaxPdkvj8zqQndfmS3UrHE+50KcgPaXq/Cyv/80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2bslA8uUH/+J+8no70HZhk3GrhLmhRj0qfzE1vdayew7+08z51QutzwJtcd2T0rxBbkY8MMzVGc5DnAhx9W6uUkiGkgKP1lLFVRv4RWOlv6bB2X9i++s+A4SRKD9FqClfEaIU9I72LNv2eMHJ4zpWNLMjCOn597+zGb2TMblqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3Wf+yRT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756808461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9qIySCE7Ux2ipEebq38nCfiWFRGG96PftTSkzMOExs=;
	b=T3Wf+yRTbT985jJYm05H027oU7xIzOfM4WrZIOD+xlnv/TVr/qdEEmX3cxLTbV5RsNAxUp
	YNqEZvobA2qxU2XH6UOYCZqd6kAbAr98gfseS7+Bs67WWBaLEu1fVQQwhMiu2v58J+QRJ/
	hp6Xd6z2Ssb2Ws1xzxOTPFW+Q8le7sw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-CaEm2Zd-PZ-o2a3_JrwRlQ-1; Tue, 02 Sep 2025 06:21:00 -0400
X-MC-Unique: CaEm2Zd-PZ-o2a3_JrwRlQ-1
X-Mimecast-MFC-AGG-ID: CaEm2Zd-PZ-o2a3_JrwRlQ_1756808459
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b9635bcc7so3531395e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756808459; x=1757413259;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9qIySCE7Ux2ipEebq38nCfiWFRGG96PftTSkzMOExs=;
        b=e+8CS6w2BCiwrCJW8ESMmrA1MNTbVdrmqzTRi5poput/WSK/nmdTy0vtK3lNNHOALD
         Du8Gjfddy5KbWYXqr7R82gqDtv1NQMoGDRYLb/uJTf0AIej74RJbqaFkkIhn4ytR29od
         9D1X1UtG0baZXtnn/4hpIfTJMO99GerA2rIi9himJFXbwBikcczO/Mgg/oNfMgA43EQ8
         bCi/hcis0okzTVL9XA6HluewqPCjPyNaL229J/D6OjQsfLrDd6O+b7SMLtGJ1JfnvytV
         IWXEa1/Xmn68iPdpTrwBffQhIX3q5hmXOzG+c6GN9Y9NamBBe6bgYIfQ0d7+OTkMB3IG
         bdnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDNzpci6Uzci/AXTCZDeYwWuF3VNiG9OplCXQgXTaeOsThihb1jKtAplu0qS5U1De79C2eobNb7ltJ/8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPIr/vmqrLLOF5U+b+muxU0nKfeX75nuxjIKUUqiEPhKdMjj/k
	bKdjg8udaU2cgeLrrZb3w1FdGGAYC7BwrKTiR44i781Io/zZQKzWqtzDJpuHbNjpK0XjfNrFu3s
	nfTynOSZjJHVuZOK4qlnd3hs7ny+TnmJifNQ5FeXNqDuG28owrNdPUYRP6p/hCs0rww==
X-Gm-Gg: ASbGncsxF8FexKui0kDI1Z1c6jkTws+eWvj9M2B7PJD6bigQLhtSJa4pLYyY15Uz0Ot
	x2l198F7SbrxqcT9Whfe1VnADPAfJLoG+UZM9nS2W6q5J7N9oouCxJyAt2alds041Y+GLsvok5X
	3HE/VXyVRlkR29QIwFc1X0JyFH4TKN9imTGBB3mvaQRc8ab7FtZKjwNIyal4DL6sOw2Vgd14qEm
	droZ1dernIJU9pOKoNEZsp4qBtkZNr0DIGEP718ln434Gnj+ouaDNbUgfsqN4sBEr7KaNeUK4G6
	nj4lwxAKZKFpgTHRzy3ntn45jCSrKRHL178xFY97XUoAFq4MigGV7NM6D+gsV6y0cLP+DryGmZ/
	UMFXx85Mg9jhv7ofMG1j1GqTyU+OpEoecFztjE4Shn+zFg5fr71ItaAP84GQhB/UL3Ik=
X-Received: by 2002:a05:600c:524b:b0:45b:8482:b9b9 with SMTP id 5b1f17b1804b1-45b85e429f4mr92046545e9.35.1756808459494;
        Tue, 02 Sep 2025 03:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrbdi+SLi7paUDVyuKl1DBRfmshZxP1c1y9/M75LD+3bSDY+4Id+uLzePCwr0Ba3fLwGatbg==
X-Received: by 2002:a05:600c:524b:b0:45b:8482:b9b9 with SMTP id 5b1f17b1804b1-45b85e429f4mr92046165e9.35.1756808459039;
        Tue, 02 Sep 2025 03:20:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f30fe02sm267724975e9.18.2025.09.02.03.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:20:58 -0700 (PDT)
Message-ID: <ed486d6d-1664-43b6-9d5c-696305f833b1@redhat.com>
Date: Tue, 2 Sep 2025 12:20:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] mm, swap: rename and move some swap cluster
 definition and helpers
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250822192023.13477-1-ryncsn@gmail.com>
 <20250822192023.13477-4-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250822192023.13477-4-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 21:20, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> No feature change, move cluster related definitions and helpers to
> mm/swap.h, also tidy up and add a "swap_" prefix for cluster lock/unlock
> helpers, so they can be used outside of swap files.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

[...]

>   
> -#ifdef CONFIG_THP_SWAP
> -#define SWAPFILE_CLUSTER	HPAGE_PMD_NR
> -
> -#define swap_entry_order(order)	(order)
> -#else
> -#define SWAPFILE_CLUSTER	256
> -
> -/*
> - * Define swap_entry_order() as constant to let compiler to optimize
> - * out some code if !CONFIG_THP_SWAP
> - */
> -#define swap_entry_order(order)	0
> -#endif
> -#define LATENCY_LIMIT		256
> +#define LATENCY_LIMIT 256

No need to touch that line IMHO.


I enjoy the new function names.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


