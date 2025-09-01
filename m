Return-Path: <linux-kernel+bounces-794039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5228AB3DBE8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 176644E1B55
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6242EE27D;
	Mon,  1 Sep 2025 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I14f4/Vu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83226F29B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714035; cv=none; b=b3O1uzXGZ6BScMFJSbtAUyaHrCcpsi2ymUnZU54ccGFCTUV1UDLO5K1up1g0+aPo13LW+6MQfsSSJskI4UGYRCQS1VIANaGMWnsZLC3bgtpixyAnKQs1AmECbFuvusH63VjPxma6Q16Cz8CtzKzAUfwa8YGPuyqrFtIWCzmVulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714035; c=relaxed/simple;
	bh=/D0E8RaiUkiq7srEUeuQ4rLaksbm6VHHVwHXk4eRMt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJOWirT7LE7vee4/nn3T8M2u9U3C7Nu4RT/MMn/o2cAoUP7ePNaU/WFjT9BPt1jXPx26BNNjzx7JRLgCSFcxh6ATRprGTwikZIuZGfelbv+mXk2GkkTrFUSgdNBWunuYyc/1NDxdosWRHdYt3DndAQ1wQEb6V5PAFFfbSponq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I14f4/Vu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756714033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kVLhREYblbo3zV+RJetjUr2sHUhQc5+2HE4X6CHGYpc=;
	b=I14f4/VuZLWfut4F3D4D0ohrOBhrrLw/2KtToJcuGEGew5oQbzX6JNb97eVGjMRB5Su8sk
	mo2AIzcBd8SrElbL0ehRPaa+VZxB0xnfPK3MSyvu/7JHgINx4cAZxJgc0DIGmCrnVw6qEF
	9uaKKix2/88a9d+UA7HbklJusoOgc8U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-O9l6Qca2MCqJh1VxP7Mipw-1; Mon, 01 Sep 2025 04:07:11 -0400
X-MC-Unique: O9l6Qca2MCqJh1VxP7Mipw-1
X-Mimecast-MFC-AGG-ID: O9l6Qca2MCqJh1VxP7Mipw_1756714031
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3d17731acb6so2114251f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714031; x=1757318831;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVLhREYblbo3zV+RJetjUr2sHUhQc5+2HE4X6CHGYpc=;
        b=R75K3nFOKIkj2I7LOVlOtwPdX2NDYLc3R4WxaWZMJU+GjxFDhh8u9FPuWk2BmmGOsq
         p/1DibOkg6m7/cd/s2QIzLSAMessLSlZn6cC4do0Sx1zgNHh+1lfU/frj/JuPQF8l0Vj
         H60HPL9GkFyJQB+J7D2SPLhiYndpUXOkVlyi7Rg6NW9Y/PeqWPkDNh/D+04Wifbkvr4j
         3y6qfFrBqb2K7EyTvDJ42a5rRX6rlh5NsJ6sWWVxXoHo7YMimaqEA/ZtlvuoK7iD/WKX
         ZV6Lfr8TwiLf3fxtFUjy9CuNFjPF3CvDRc4Y+AedsysT3/OtG+cFKAiplu04/eFvpRrc
         C6wA==
X-Forwarded-Encrypted: i=1; AJvYcCV7hUU5P8Fa4w9P29TiclQ6y1W4/WoxlIbbdIqvcr/huONpU05gtUotACimI7hUusvnGm9EP5SzvCxJYfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOphlqo6Fq8AZTJq+cassE8WKELQo+YR0wDLzg0STOAtprw4gY
	HKslThlZZzvoqvZcEz6/2lqyNY4oihfjLxZpN1OeXQOxtZ2TUDJt7mtK/Klg0Ln0B0LEPNWec4t
	yV4wGobM9y5Yfy+oUQYU/2kOEOlfcjzNbxYCCvhrp/wQ5bGUw/GP2aFD9w5Q7RKy5Zw==
X-Gm-Gg: ASbGncvhx/8yH+T6T9dQONGPa5ehPKTOh0FMOtIwyaJm2QQ4wBDh3l97vqV6lJCotPZ
	TRgLrXoWZx2CCSD6iQAViGDiR97Sjw9k/uG3GrauWBBAoY/96NqgxInilVRQ19I9WTFM/D0HYvb
	lmLv2Vyej0M1dxAJBCTiq/drn6T1rt/Ji6Oex9q5dfhMeLfOwphudIDUu9Ke5ur4CUepGWBOauQ
	C/CdeaYutA9xses7vs2wjalHW1ThR4nWHjE2HV+047NVS/Iy61nhlXGO+fyb6e7gkQpk93AVZhe
	0ICVbX/jpTXZm12t4w0frJeTJq7BRP84zppYiX3PUs4igzK9+uSP5UFnMIrWDmawG/Txxo5rFTI
	ZmXVDxzvW/cgcy4iojTCHnuR/TOFHmKzbHED3TvUrcU7s+mxTBs2J9DK4ecwXgpGFHvo=
X-Received: by 2002:a05:6000:2005:b0:3ce:fe6a:a9e3 with SMTP id ffacd0b85a97d-3d1dfc0734cmr5474543f8f.34.1756714030686;
        Mon, 01 Sep 2025 01:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIYzH3ehFZlr9zFSuAWEjoTKdXRfZkW00Auw9hUewKGpPrV3x2/KRj/mcz8/n6ea855oItyA==
X-Received: by 2002:a05:6000:2005:b0:3ce:fe6a:a9e3 with SMTP id ffacd0b85a97d-3d1dfc0734cmr5474502f8f.34.1756714030230;
        Mon, 01 Sep 2025 01:07:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34491a7fsm13866834f8f.57.2025.09.01.01.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:07:08 -0700 (PDT)
Message-ID: <80f0df00-645e-4fc6-9886-03cc56699991@redhat.com>
Date: Mon, 1 Sep 2025 10:07:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] mm: Revert "mm: vmscan.c: fix OOM on swap stress
 test"
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, Shivank Garg <shivankg@amd.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Keir Fraser <keirf@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Frederick Mayle <fmayle@google.com>,
 Peter Xu <peterx@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>,
 Alexander Krabler <Alexander.Krabler@kuka.com>, Ge Yang
 <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>,
 Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Konstantin Khlebnikov <koct9i@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
 <bd440614-3d2c-31d6-1b8f-9635c69cef7c@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <bd440614-3d2c-31d6-1b8f-9635c69cef7c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.08.25 11:13, Hugh Dickins wrote:
> This reverts commit 0885ef4705607936fc36a38fd74356e1c465b023: that
> was a fix to the reverted 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9.
> 

Likely checkpatch will not like the long commit ids.

> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


