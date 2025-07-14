Return-Path: <linux-kernel+bounces-730327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704A2B04324
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29FD3AA4F5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A1B260586;
	Mon, 14 Jul 2025 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFL4fyLW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A444D260565
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505901; cv=none; b=DrEsVahKvzF0SSNX+sp/df7gRm2sEuyY4dUrNN072Sk9OtlBMkb9ObweAGcn8AZSwufiso9FGEooYVdOOlDLgTPQLyCloOUPuzEEe+rULQFAu5peir5ltc8cg5DkLYmLym2CoaObwDIviXu2P2nq4+oym/HSuhkFZLb37EHFJH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505901; c=relaxed/simple;
	bh=zLIW6HqANF5Lh6gbqRv/CWMzGrSgqoGlvFrlWrUWz6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQ0Fo9YgMfOJd0Sk+vMPmYUG8e++6wD+GbLTg3T0u8850hjhiDgpZZmvkxJsTb9jzyGoXkbgwOMfOpdu/vdWh0cjBhNB8LtrR5UuL8p6D4b1/pL9L1hSvvcg2kjG9YkcnGYqI09g4HyYLQPya6/sbfVKsYwBdQHhmnuSqnlILD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFL4fyLW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752505898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3V0Xq+8dbavGSR95FwkeP00bDtiVLmH011LXfgV4uo=;
	b=iFL4fyLWpCDd5GGsi72bZY+o1vq4Q9hEEmn31w+qYU/+rFLNrUF2kA25wpdRh0eLWfhbqR
	AYIvRM6meoSn5awUxnnG1cSUMkbxVb3CGMQfPWtCW6LYlP3bssX/YVFgIcVqdi2MYZWdOZ
	cj3bPsI/xdfL730rfZSFqqMkRZMnH+4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-OvAhN1ZTPsKSTUiHDKUjJA-1; Mon, 14 Jul 2025 11:11:37 -0400
X-MC-Unique: OvAhN1ZTPsKSTUiHDKUjJA-1
X-Mimecast-MFC-AGG-ID: OvAhN1ZTPsKSTUiHDKUjJA_1752505896
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45526e19f43so11466515e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752505896; x=1753110696;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3V0Xq+8dbavGSR95FwkeP00bDtiVLmH011LXfgV4uo=;
        b=sAYKUY4YYn0wZJo3xur43UYzI9JGTLqFI+O3etLIzP4woVBmbC5pGHL4suiiaBzT8P
         Nf2VU7YYAoeZbl58iMAVJmdYW66oLJIG47UL6apchPwXIz3hHgySyWSdISSxWDy5H840
         ll02B0bOlIFQgShIYIYO0hmE3EV38cmHDJMXW5V7qbf9TxiLbIvJRkQ++kJN3WQ+rdmV
         ygAASvp68xV8qG01N7gnM6Z0NcfQn7YLGvWiK9/CBqCp+6myaIlUwXBuw9662kF0ppBf
         DKH8qmh5vh+QvX/tnNMr8qB4qqs5x7RfDWMVdfGxjZT9KDaXDYEwgXNwEgTdQemEpou8
         UDUw==
X-Forwarded-Encrypted: i=1; AJvYcCWqibkh97XuSCaV0uhSU76bsV1WXskHLR8rzeNxLzPBU/xthxA5WVw2rUEWT1Iltl2cg7tYPVOfRRzW+7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlk/5g+rh46q160ZPhaXwbMrr6+jW+/HUIFfOtUbqjnEiEDcO
	mRwAcTABzDM3UbjyVG5xsRtd5hM2pUCZL/y9n7oLiAkkKlCoyxXmXlf6bLQNFk5lK/CjJFvKTo1
	NR3qu1MOlierPAEi/18v1QbA3kPZKlbSSX7ehpeJpUQW21928AXlQNHt0cjcuMe0RfA==
X-Gm-Gg: ASbGnctCmc1UKbkOe9r/RIzDMm8yeSZ4nNUuza1lYNmsGfh8dk0+Z8IpOZPXuLQyC/n
	0OE9jViOpPUMgH88SdHJ2gKlyyodA6bpQrhK74TZcufuspfTnxp20i5ViHmNIkrDZfgVEz3zBQk
	sLnl43HWYlK7t7zoop9V33MBCOv1JHQYi2Aul5wrjYlYIKMaTEBrJhmxsKz5Yr668JsjQsYS0kR
	8905nrEDcTDkx3BdCu5rlx8UzFuIWsR9hWxLcqscX5rpUlBmjxocrLkxO0h9PQMX7cnccbinCmu
	c5OtFnjjen9bipfrA2PCh27iLfzHmSGupJC819UNNIpM5E8yDfe7KceO+zhY2Z1a0V8PLmdXbX4
	RucsgqKsv8FM9whHyOLeM8wk2BM4j18gyy/9pMi3/DUlSEeTtpaPfllpGwbdaPN7r
X-Received: by 2002:a05:600c:a00a:b0:456:1006:5415 with SMTP id 5b1f17b1804b1-45610066735mr70327265e9.6.1752505895719;
        Mon, 14 Jul 2025 08:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVJD5Q2P1/rdn5WXQZYGlxSG+y8BpYs/LSeQ1kRwv7bi01EutwSu2cQg4FHnvfOfspx5AGXA==
X-Received: by 2002:a05:600c:a00a:b0:456:1006:5415 with SMTP id 5b1f17b1804b1-45610066735mr70326775e9.6.1752505895272;
        Mon, 14 Jul 2025 08:11:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50ded8csm173054185e9.20.2025.07.14.08.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:11:34 -0700 (PDT)
Message-ID: <2fce2e01-82e9-46a3-b908-cf37a0439e1f@redhat.com>
Date: Mon, 14 Jul 2025 17:11:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/huge_memory: use folio_expected_ref_count() to
 calculate ref_count.
To: Zi Yan <ziy@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250711182355.3592618-1-ziy@nvidia.com>
 <20250711182355.3592618-3-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250711182355.3592618-3-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.25 20:23, Zi Yan wrote:
> Instead of open coding the ref_count calculation, use
> folio_expected_ref_count().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


