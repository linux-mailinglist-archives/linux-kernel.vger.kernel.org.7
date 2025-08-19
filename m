Return-Path: <linux-kernel+bounces-775043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F081B2BAA1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746E63B1CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED903112A9;
	Tue, 19 Aug 2025 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QleqGxFt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC91F0E34
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588164; cv=none; b=Lg14FYrCqJ9zgBmxdF9AnNHxdxP5HttmT1yLvfHvOV++RlOTSAj0nQ+wfSo2GX1Zx3NCg7t+rvJqiOClxcx+ZAuqcxt+1AD8yGqgQFfCcovLHRYVVI5VZIIfdd8mmcq/yYNUbdIE00d09TVdj2lQoZv1zzfMNkm3VpW440Fn0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588164; c=relaxed/simple;
	bh=JPYE9ljppi9H0rZ/04MBoXd7FsbA7EWFF1JZKBwgJ4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZG/eIu5/UBNJV1bht85UkQW8hdcG6tgzRHs6qyGh4+R8jwm0cOeJeYjnElcmPujlsMmpTIo+3Qq/qGtxGwF65uUcUnoQsogEnKZTuY/FUrJ7tKLJ/MfNFzrcA3ZIH63iBaeQDUaiVEQG3gKFPE7FCrKNo378m4FPVXmAMzelYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QleqGxFt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755588161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Qq11idoUrEtRas34sML4LIAF5KXTLr/TpVdlfAMSXiU=;
	b=QleqGxFtHQOpeVuwjz2DgdcXA8+mN+dS16H8fp7BD6/fxbGSok5bzCGe6fUH2SIGzX/Qw4
	MrLTfhtBvJi36L+ETpvTuW/z/6MRdCRFbz/GKV+5E1pnn+Xh3q03ALrfoTaom/aj3XMRGi
	l2PEdwB7TeDfb7e+slwn55/mSjlJt1g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-PBlPPQv1NT-rcscg5kwGgQ-1; Tue, 19 Aug 2025 03:22:40 -0400
X-MC-Unique: PBlPPQv1NT-rcscg5kwGgQ-1
X-Mimecast-MFC-AGG-ID: PBlPPQv1NT-rcscg5kwGgQ_1755588159
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso17594965e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588159; x=1756192959;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qq11idoUrEtRas34sML4LIAF5KXTLr/TpVdlfAMSXiU=;
        b=o/UNWcPKy3ut80rizNi4zg0n0PZnUT1ZT5brSQtAmebDAEIom4sqIBVOphHKDueJG+
         nOct4hyt3AfJ7+d4JrA/S8I+5tP4v3EWoBGBJ7Pxt3lEsYv5Rqa/PVBU0CefH62K4B7q
         /uZZFZ1uArOKynMkhIX6Aq+gk0OHzpQnqvt9GRK7ZwkEY+1edDMkVxQXyaWA7J86zE7a
         2sxjwt/NDoHUn5GAcJeGiiqF1nfJokas9iR6baVG5w3ZT8kncJG6IYpryMihNzBJ1StC
         u+xb3FFp15MRuU+tOHfvaHUJxGoR6/XX6+KN/JCUH5RQpa2Ty4/sQoTPrb32lXmOsHS4
         x5uA==
X-Forwarded-Encrypted: i=1; AJvYcCXl2gsyWrGFiOtsHT2C40jCRL6SXxWspDKHX1ZFQm2ch9C2I/Df540UKXAf4XYALwrXCh2aMzzusnlpYEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzROVafkmY6XbUpova0meGFhgdp3YjZpwwfzFqLIWnTv9AuwosY
	ScKU4x73NQGRXtzjIVzmc21x0YKaCFFUhLq1G3hOisZDeNL9GyJpml8pmv9+tpqJ3uFch5yf2H0
	/Rn3tW0Ac38WQTmxts99X/zjY9UOMBsKacazlchdeMsJ5nBETlae3vEsCXBCqifIkPQ==
X-Gm-Gg: ASbGnctm2gCEWQ42cw+5CGIXJjUO0w2Bm7wTsqFXO+h94yrWMqo+mE9Yiyjaa7fiAzX
	E+vdzCpuS6OCUIvlJ8P8GGVOoMNXaMgq62FswKdrM/APR9+OVRGndzPE8I573w+b4YjG+aykwNU
	AdKIch3PxqDlgF+mudpDFpqV/rpt89cRqQnq9dKQbHlBvRP/5cZ6eacSQWf+TAvFHArTKmhefHB
	u0ALgVBHS6QDQdBM7pJCzV8YJjAN/w42MdjTOeUNHF/9CNJWw2zmi66mvN7iG+Gzh6aL078anoR
	y5YkTFGxPKWbM+YwubmY1kXZOo7oZyenpuydFWup9R84zAZVoaHxO+ZDyk8jvSoER2VoWSBEVrT
	3UgSBmKcBErJf9MnrL2tjE6IGJ28EPkNnONjm1rTUdPFgZXyAFjGe+8r/C92XQnv6Tvk=
X-Received: by 2002:a05:600c:45d2:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-45b44ed5e18mr3769315e9.8.1755588158973;
        Tue, 19 Aug 2025 00:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJIJ7GjSEIbfIOjgirt0dW2oC4TdNAvOum9QL7SYZbXtP3+sR+MrZHQGDCjlim6GzCoEKspg==
X-Received: by 2002:a05:600c:45d2:b0:456:19eb:2e09 with SMTP id 5b1f17b1804b1-45b44ed5e18mr3769095e9.8.1755588158501;
        Tue, 19 Aug 2025 00:22:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6c324fsm196778995e9.1.2025.08.19.00.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:22:38 -0700 (PDT)
Message-ID: <a2c15b46-f829-489a-b9fc-cb2f5517736a@redhat.com>
Date: Tue, 19 Aug 2025 09:22:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: add available_count and total count in
 trace_cma_alloc_start
To: Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
References: <20250819032654.4345-1-gxxa03070307@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250819032654.4345-1-gxxa03070307@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.08.25 05:26, Xiang Gao wrote:
> From: gaoxiang17 <gaoxiang17@xiaomi.com>

Nit regarding subject:

"mm/cma: add 'available count' and 'total count' to trace_cma_alloc_start"

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


