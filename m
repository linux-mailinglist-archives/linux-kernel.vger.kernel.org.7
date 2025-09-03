Return-Path: <linux-kernel+bounces-798846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD2EB423D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D57D581E92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D671F542E;
	Wed,  3 Sep 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZJdh4oB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F41F3FDC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910033; cv=none; b=M5Np6vVF55BhGwyPIRR+VLgHoIwyK76GvZ9KtnZPER9Vce+vcZ40Xlagm2a4WxGbJepju92oh5wan87dHxB5sT5qXpW5Fsj48Re1PZyyNyT+gzoLPrvZSuGVPoJ3V2AHHNODx5jA6C61OXxYimHs1H2KqtDm6HlZ1O6yVVtteZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910033; c=relaxed/simple;
	bh=+I4ohkWCMBtccEvSiM75dploRMESNyX/6lAQkOZya+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeB2J97AXNO5OpjgIU/I8ViPMPe+dCIKo7lD5xsEHx3k/wFoqAMfMqKxgmC5OYqLmVTwDtqqnquBz/IygH/Cmc2gLnbc7KBzlabnvS4AfAoJG+W1DfQ/c8HM1RCBecmEtsSwqVP4zn1yekEi2DxceId94HomSlPQrGqKyEX8vNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZJdh4oB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756910030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/220hvN5lbAQMJA12z7WMtiNilLFilf+4JhsLwhDHhI=;
	b=fZJdh4oBEZ54v+VNSYWiXdeD0/A+OusZoQAtmXnfTGLnz25u+wP4w+r3sTTTK2NYGq0lcP
	T22oUXKWzwvmw1XjoaPKczksokQlD8FmOYQHhkOd+69D9Wl9smWP4jYGVEY2TJzBdNXqvr
	UA3/7a2PHUvi426NAVTtC3l1ORX6ESA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-o8CnmEBONRe8DTh_B5cOeg-1; Wed, 03 Sep 2025 10:33:43 -0400
X-MC-Unique: o8CnmEBONRe8DTh_B5cOeg-1
X-Mimecast-MFC-AGG-ID: o8CnmEBONRe8DTh_B5cOeg_1756910018
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3dabec38299so1321454f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910017; x=1757514817;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/220hvN5lbAQMJA12z7WMtiNilLFilf+4JhsLwhDHhI=;
        b=wQ7osEWkcvK0T8iThSd6XzPwOVB+3E3AFKPqYtRRKv/QLN5f3jhGmNtVkaSYSFgKUZ
         R9YgMIrl2/I1E4g+1SKwIHMhJWdKqsM8yc1rbg/4sxl1vO+e/vvUpi4MsmOP5kg4smgK
         DGAkNPRKHYZt4rQMd4foVFTNEt4b6dgaL2KnwWnwCG7O0SFOBid64AoLGY+AhhRKtO9m
         ecLyKIQI5LMw4JBaIMZSkt4Qc92y0xgYFTFldki27kbnh/9/sq2gAd75j6VnQBbVnP8h
         /v6oypBOlNrT26p3MLKuUtMQ+8Ub26/HQXWZ/e8Ww6SGkly71Q92byk5NhvLhS1hODqK
         E3Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVXCe7hg3eCtt9MuJuAUNMLcRXc3GW2X/glFe7oEGgcfLdbJCwXG/r7Pzb98kGPIWn2GC13IWN65bjIymw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVKiTzjnA3Se9qZ1UwLeraYm4R8OLIa0llXRvIQiO2JyjNiG1
	8gQHltLxLnSDuAkO8t19LBSAi1TQ2KfEk0zgGQXh4vQKUqmuKVNFJhBo9qUx8u/FlkjgpTMQMd+
	HwVVXfMcl3fCUppTPw6J992a43Ec4ozYZcCbGJRzMVkOEpE7iOT8ohJcut95iT4tpow==
X-Gm-Gg: ASbGncugroAEpYQl/ptU2Npgq5UC0UXk8vpq1KELBuu1cyrHznHi6U/KTXd+gx2JAjN
	Z6Sa9RYTiEcZ/aG9ixwQ5P7Au5AaNPkvW0G6O6u1YJLYDiOnH2/39opMfYcceuyd4WIsmmp9pNU
	+nNCvNTb/5Brw4zdBd9RD23HcZNIUrU6PHAbbqy1IHVsstkdDNe9/lcmJbg/VlbpVs7Ya+1f6QQ
	d2dj94rRK0uoXla0DWIW+luzOSXVmx9eCQVavoCHLEm3reMLhtvWg36gavgCi0W1fieeEhPoZR3
	foV2szZNA0q5YvDpMOMkhjLH4/WCRVsBEhw4S752Ov0TgpJBcOX3CQRmaksWSH+NiUXhyT7xMRG
	DmQzXXqEHd3S4i+qswY01zj4fze9UJSxdoL8e8qPw8M2Ak357FAQBNJGs4jT7SmIWMqI=
X-Received: by 2002:a05:6000:2dc4:b0:3dc:2f0e:5e2d with SMTP id ffacd0b85a97d-3dc2f0e5e94mr2575506f8f.0.1756910017517;
        Wed, 03 Sep 2025 07:33:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4D1SgBSF3QNwERMDvj9DR8nykgfCFIE0z6hJzwxiK3nhnnvUFuUO7W+qHUce+DDdOjsRNyg==
X-Received: by 2002:a05:6000:2dc4:b0:3dc:2f0e:5e2d with SMTP id ffacd0b85a97d-3dc2f0e5e94mr2575471f8f.0.1756910017027;
        Wed, 03 Sep 2025 07:33:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31? (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de. [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6b1cdf05sm186906445e9.1.2025.09.03.07.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 07:33:36 -0700 (PDT)
Message-ID: <5775f660-f83a-4912-9e2d-1e92528f2e29@redhat.com>
Date: Wed, 3 Sep 2025 16:33:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: Drop all references of writable and SCAN_PAGE_RO
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, kas@kernel.org, willy@infradead.org,
 hughd@google.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903054635.19949-2-dev.jain@arm.com>
 <e37bc789-cb53-4df5-8297-3be146d2b620@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <e37bc789-cb53-4df5-8297-3be146d2b620@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.09.25 15:26, Lorenzo Stoakes wrote:
> I know it's a small thing, and subjective, but really would prefer a cover
> letter to a 2/2 replying to a 1/2 :P
> 
> But others may disagree, just a small trivial plea :>)

yes, I was assuming that I didn't get CCed on it. :)

Anything with more than one patch should have a cover letter.

-- 
Cheers

David / dhildenb


