Return-Path: <linux-kernel+bounces-813490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1DEB5462A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBEA1C2771D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44374275AFF;
	Fri, 12 Sep 2025 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOgbC9DY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D651272E5E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667499; cv=none; b=cHz0x9ogmh/btaHS+PEiYwfdTVGHr74nWPjNm6zAHt6DnqtBWhITdHoFQJxCPElo08cFsXYZ5a6bAlMplCpdRj391eul+2E1ARsjkD7pC2lFaeGN12jf7Hfz9L2Io/XNBvCMZcq3HoISPyAgPTVZrAa7KRRQKyHL9v5vpFGY+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667499; c=relaxed/simple;
	bh=NiwseN8Swtpmi4KTcVzkIev/tJ4ZogOeZvi0uERJCqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzNDqxEKH+NuFs+NB0myY1ORaqX9WDOQS3w2cqRQG+GOg9QtVJsnAsqo6+WrmPRnvC8BQTndYu4mn3Aefa1rGSEO215GCZvvWWO3DPZNDkekvGpVmeAV4oP8JtFkVPZO/RsdZwnx4TFZuZHh/EyBdLiP405dNNxaK9T+fzQ4TvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HOgbC9DY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hn7Kr/nh5f2HYa1BLbnhmtwigv0AyRCmg2Cfmamfb7o=;
	b=HOgbC9DYfPY9KH/YZCNaSuwj0RpdCrJiczOhM2wl7MdGUYm41Bg4jAgFqwPH8fjSWga8Ij
	T45YQM41GTWwilisTEZpXvwQduoNDMbYzYn+BwvxAx7DoUuDkSS5UYv6Um+PU1SaD6qrj+
	BQkHxiX88+7tl5mycDGgq9s7u+Cdxe4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-1kUvTP_-OwOp9oyLdSovlw-1; Fri, 12 Sep 2025 04:58:13 -0400
X-MC-Unique: 1kUvTP_-OwOp9oyLdSovlw-1
X-Mimecast-MFC-AGG-ID: 1kUvTP_-OwOp9oyLdSovlw_1757667492
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45dcfc6558cso12180315e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 01:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667492; x=1758272292;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hn7Kr/nh5f2HYa1BLbnhmtwigv0AyRCmg2Cfmamfb7o=;
        b=uUzfXT/I2uSF8nDPJkl8bSBz/Am96yhfnGTAx3paOf7ZWi6S+5rCAvJPySxefP+TAr
         xNbVB14sWUqstaUitepLvTRWDpToRbNiaJ+O8jpjYSqVUlcgwP2O9VyZO8k8TIPt1586
         DSLs9qU1HndV1HeFjh/g4d2RS8g/pVF/u3L2gK/0x6FpiDM/ijs6ALz5lfr4V/BRsTE6
         6oauu7sQ0AZkNOoXGIcdyWV1OMwHLWaR1iF4vT56zxtM+wy7Rc72RcGrVUE41VR3/kRV
         ZhFiTQyhC+OJMqma/XZtNCJWacjNbKDL3iN52CoTVwkbK1XGH3KpWTz0Dht7ggxg7tQK
         Fb9w==
X-Forwarded-Encrypted: i=1; AJvYcCUPS2t/9ikwzDd1ZXAJKtw12AGh1t+Mosq7KKTBSL7mHe9Q1DBjAOBvuOTDSEgTxU9SQXlor2oyqe8RO2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW3BtmaNfJGRNdzgD5pn30c9wpsypGaG3zbw/1ax1tAPY1KSQV
	yYPd1ddu9V0vy1GnAtELaY9GQvRRuEKWW/LWjeFF2mpKxE/J2rJqEGHD2wGmTC1+WzqS9jCvjpi
	CphgNzI+YD8WH39Mka7liCKp9Vr5E5CH4Ruazlar0y4t18/0klPdQbBEalqhLAP8Xqw==
X-Gm-Gg: ASbGncv5SIDxNBZr2SwVeb3N5T8FFQ5beLQSsrMs5LdJYq17kQUrqgH31wZuDIzP5LU
	UMHpsRcy4stCF8OPOsFaXfJ/aQliHpCzvS0kAi/B+xZvcnArLktUbdAEPP1GQbtbidbx4DtjmKt
	Q6K+sSc89a9pT8uXRy1A8ar1sVl3LBcM8fpQ9U1dh2i5uW/1af2nGnIAUmaN5JyaVv2ERzy20UL
	vX5XHuukz77u2mMwAyffbxoNR+e4ZikBoZwqR/ZUOBtlBvJTxzyRiMBBNTtJ+K5Vji09tpznz/Z
	ygqm+YWCjA0tKiFgnhzqZuVH9Xksk+3lTOC3JfAHMZVq2n/CwKHbO89K1mzm1pekZgLJyZPTMpd
	+JNtY6ynctvwVp3YAFkOqNGrG2Mm9O/TCYUjmb4T1VpRoSm7973xGxjEFq4xmuEs/yq8=
X-Received: by 2002:a05:600c:3106:b0:45b:8543:c8c9 with SMTP id 5b1f17b1804b1-45f215641e8mr17030375e9.34.1757667491788;
        Fri, 12 Sep 2025 01:58:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT7asuRlOngUhq+KN7NZHT4WPoEbSxl+ImwcRL2D9SEROwR0FuVSp7gxH9NpE4kTPnmjOTjQ==
X-Received: by 2002:a05:600c:3106:b0:45b:8543:c8c9 with SMTP id 5b1f17b1804b1-45f215641e8mr17030215e9.34.1757667491411;
        Fri, 12 Sep 2025 01:58:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e016b5cbcsm57770435e9.11.2025.09.12.01.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:58:10 -0700 (PDT)
Message-ID: <86672d4e-b04f-4fc8-b7e8-a7461bdb934f@redhat.com>
Date: Fri, 12 Sep 2025 10:58:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: vmscan: simplify the folio refcount check in
 pageout()
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, hughd@google.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1757648598.git.baolin.wang@linux.alibaba.com>
 <e475c5ddbb94763b12d396122ade8ee3c711a967.1757648598.git.baolin.wang@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <e475c5ddbb94763b12d396122ade8ee3c711a967.1757648598.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 05:45, Baolin Wang wrote:
> Since we no longer attempt to write back filesystem folios in pageout(),
> and only tmpfs/shmem folios and anonymous swapcache folios can be written
> back, we can remove the redundant folio_test_private() when checking the
> folio's refcount, as tmpfs/shmem and swapcache folios do not use the
> PG_private flag.
> 
> While we're at it, we can open-code the folio refcount check instead of
> adding a simple helper that has only one user.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

Nice!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


