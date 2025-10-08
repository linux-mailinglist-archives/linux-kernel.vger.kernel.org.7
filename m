Return-Path: <linux-kernel+bounces-845297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1FBC44D8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8FA3BBD78
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AEB2F5A18;
	Wed,  8 Oct 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2LN+eDG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCA027735
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919157; cv=none; b=IQxjRh0nhrg8qoL7PfsTXavNddlh1Gc+Ae9C5+RCArw4EpWssRBJ/xkydFg/rkPbucjc1fB75B7HFoDbzw+L+Bq3KEUyBsOQK+PezRRydPM6kE/V3xyB9J+vU53MoCg7y71aH+KL8IKcnDVnwNxP3vN62QYKHf5TOCfXYUcVOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919157; c=relaxed/simple;
	bh=E34Zld38RymgCHbVOkwgQQsAZwmKPw2U/Ze+q0jJ7Bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tr+9rMh0ZR/zf6j+Qejnwn4YrRDbOwG5XUy5hfbER+1/EsMD+uK3TV2jG0wDblgLcjlsbREFi/E2eaY2r34FpzPeMJ+AB+48aCjXaDpAHgJW9JE+3o5OcGLRp9nAqv7embd+DlLz07XlR1fb8AuKicGHs0yakj6A5mWnoCU8P1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2LN+eDG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759919154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iNni03cCLoKxNAy1iFCW07A1GVi+OBHHW77MJibUk4s=;
	b=R2LN+eDGdFwVjFrGZN/wgkGPyAtCszhsAm/uR3UIpl1rRWr69pprVE8LxIpPk/mcLdXgot
	JT6uyQW2cQbGF+Y5V9iy+Ua8dUcc+m143gW8wB6sNqrgCUxsI7aCYNTw5mNLv+OMYky9+Z
	ocn+37tBazzw+8dr/WRrmcCEODLcprI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-w01XZuXNNnyI96nquVkQxA-1; Wed, 08 Oct 2025 06:25:53 -0400
X-MC-Unique: w01XZuXNNnyI96nquVkQxA-1
X-Mimecast-MFC-AGG-ID: w01XZuXNNnyI96nquVkQxA_1759919152
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee1365964cso5272764f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 03:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759919152; x=1760523952;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNni03cCLoKxNAy1iFCW07A1GVi+OBHHW77MJibUk4s=;
        b=TqfFCbjN2GwZpqsM2XwcaiBnGq+EqtmPZUHl0P6KEWuddU2tea5jshGH7ut7bt+kdC
         p0J1M7VOJOu6VLyE5JM35UvsWMPMCgQWjhVuHvg4tV5rYWTZ0AFXJgtW1pAsc8gGI8EZ
         h+fFjRXV8ux+jabfJw389raUfbf2Df9F+eK7NGAjSRSQESw5N8FzuIZFSmnLyPVio8vB
         7vmkTXZth9hWR6or/VA0F2NUPftyg7tktiOeGZUutANJSJ1/t9it248Gr4uq0JSomSHS
         YsbVeEUGMr08o3YvacHZBCmH3rSw1lsagA2ZqrH+CpCDEF3Cjx7bP1bGXuJxpLF5r3AW
         y48A==
X-Forwarded-Encrypted: i=1; AJvYcCW89+1rTVYS2fFt7l+01tf8tOmtsEvCISnZGpx0QTjf8GJC4rHMe/F2aBBfQ4W9i3MI6a35kK/O/qwt0ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YweCxMBKUuYKj3/TQWt4drc/YINWf/yQXuUSJ6y9tHS9LIHHL1P
	DZWEToKlvkrTbuG593AG4SAWWxDU5XlTHSJ0OB2bDYsUpDjev/3SV9F8HN6X+vmySKNCc1dAHAF
	05e1xOIcEHEifYPlQxxcYQk6fHEr+CmZAML1QPVKuh5OvGDaZuAxuozOMgM1l5gpbuA==
X-Gm-Gg: ASbGncvMyx17/NQZ3D87r02SGXTLwej45lLHsrgUt6xQDhNgWunWDQrXqKkxN4FDzqM
	cQqJB8IGDUyDrZtGZv4qcZU38FuyVqRD0APA7R6gXVeCzPyW6gCJRlLI/yey9mTJthaGXEj1o7b
	wCNay23aOGAQcAvfQBPiAHin3IJApU5LnpXb6qHyj0i0bdwfUIPxIiFjDHVgWd5NnPJpHasyqIl
	gCkHUKVT8InUAYPJJKF9qsPkZ+2IL+8qrJENI18Jm0rCa+Hswuy2mAl7ntM7eCja1jg6zZqZMVD
	2PQWdqb8FaNH9dzpsn563rimKBz+lYUZunt6l03SzRbL2CkVjhoTYh6xuNnw3uvxcFPF4V9KmUA
	iO+glVs0u
X-Received: by 2002:a05:6000:1887:b0:3eb:7f7d:aefb with SMTP id ffacd0b85a97d-4266e8de95amr1808498f8f.53.1759919152108;
        Wed, 08 Oct 2025 03:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNJ7WIcGiUsbhNPfzekdhhO4y7C0sfjWAwPmH1BooPn1e7YhqMEXDmldhm8SRwWWNQWwAtgg==
X-Received: by 2002:a05:6000:1887:b0:3eb:7f7d:aefb with SMTP id ffacd0b85a97d-4266e8de95amr1808480f8f.53.1759919151732;
        Wed, 08 Oct 2025 03:25:51 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f011bsm29758943f8f.46.2025.10.08.03.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 03:25:51 -0700 (PDT)
Message-ID: <77e6300f-dde7-4790-9c4c-6b3e7d40516f@redhat.com>
Date: Wed, 8 Oct 2025 12:25:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] mm, swap: rename helper for setup bad slots
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ying Huang <ying.huang@linux.alibaba.com>, linux-kernel@vger.kernel.org
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-2-74860ef8ba74@tencent.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-2-74860ef8ba74@tencent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.10.25 22:02, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> The name inc_cluster_info_page is very confusing, as this helper is only
> used during swapon to mark bad slots. Rename it properly and turn the
> VM_BUG_ON in it into WARN_ON to expose more potential issues. Swapon is
> a cold path, so adding more checks should be a good idea.
> 
> No feature change except new WARN_ON.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


