Return-Path: <linux-kernel+bounces-842613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80EBBD273
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 08:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C39154E622D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 06:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E524B253B67;
	Mon,  6 Oct 2025 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbTswMxO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714F2494F0
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 06:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759733224; cv=none; b=HLPsNziheaFLEdEKmOOBNiqevmHnm8SLWWPHGoYx1HJdcBWTsa5yKGmijXgecb57lWaDZIFo1lnmys9u4iXiCcQS87ka5fw/SVCThSQN5cyzl13w1Uajmo5grsHIZ0kbhGdSk/afFcH4l0LstEy9bQzpFZGrt7ctQffNgdGAqI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759733224; c=relaxed/simple;
	bh=H0xeRQe6NBx9NWU9/4LhO2sXUTNv70Aytpbo8aqwhQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BANPMmpFJMOKgdu3GWpP3nT4n0RnzT8siqAj6M5QH/bKpPy8ObNTUixmfdbrZY3vRovqG8+nS/GFKsL371hniWH37LvZN2zf+kYci9QEnjur6PfXt6lAGFtiXuQJ1Wt+smJPx35Tt2VbbGsLNJs+hDhDFHo+AN/KheGzps3+S14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbTswMxO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759733221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FPuQyz7shwzMNySRUVtO/p0q34+4ONGwrtRGbC9zHCs=;
	b=DbTswMxOaGzx94pIIKA2JCPaK4/CUlUbx+3PpxKP9n8N68cPewcBkCMr13JRf5KkwklkxL
	X5NewJG42fqS58uwZhhO2eECPnnkwRCK2eH93uKLjtF5pfV5gvflG+mrtmO5UwQzPizDYw
	2nL8NbLFso8ggcvxxdh/bfIsISFq2tc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-XEAcRmA7NrWU_9MmV1zesA-1; Mon, 06 Oct 2025 02:47:00 -0400
X-MC-Unique: XEAcRmA7NrWU_9MmV1zesA-1
X-Mimecast-MFC-AGG-ID: XEAcRmA7NrWU_9MmV1zesA_1759733219
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so3153615f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 23:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759733219; x=1760338019;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FPuQyz7shwzMNySRUVtO/p0q34+4ONGwrtRGbC9zHCs=;
        b=oBvn9f2F9O5uHp1lgCgulnvT31tIvtJU/CdS1zdx26VkwduVNY/rejuYi5HCHgdzL5
         wDap60X5yYvG67mQHVYzmlg136r4gwhHb3sUbZq9kQgQxBcgnR9uxWk+/3WA84i9U7Qe
         yPTDG2zTxbJNRIQbMmQ7pu5QDzZrXmRsvCALehYHx9u+L6iBVd7CyfqxVNF91ydkm9r3
         fCIDnGTnVPvxvUYBCGARhUtzOm4jnI/Zf/RnunZ2eW84W/ul/rikBeXTwXU0qfUTcl2a
         fb5b8aFKZ2q2SNyWngcERxQH5g/V69bA94uMjjs3sVfNuVgnZgEcaVCSpn2fbaA870sQ
         2vZA==
X-Forwarded-Encrypted: i=1; AJvYcCVmwMmEN4a54XDFnGSG0PyKqMGvJvRnZGk/4VKc3b8LpH8Za+5tpcsSZdf/5smCYiy93MTfhd/toJoFlJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjev8jKP29qc2SVhtNATsZ4F6vD2430FMWRbPNRhGa5oxWr2tR
	5pFhXPxRHS0fOUhqw40fvZB9+Vpycy/sChn+zMTd5eAWx0XzDDyOur01rVTmYc88cc3F7Y+tLRj
	+gb9YHBJNyK8Uibj3R+D99SMv+T6uVfupXZxqJv/gqZcP81qdZ/SIpiULOl7v2Mlqyw==
X-Gm-Gg: ASbGncuqGaEHBl1gPgaSSwYiLW7Ldo4pz/02viiHgmsMMmF7RvobB427SbeDQVaAkBc
	TO11H5u0y7lmClm/iOp79eRaJDTWom5rLQFHB6fXW/X1N1R+3ChBV71T02YMBc5URHkc3FSVl1S
	5T0aIU9byLxfuv+oaq+34GvapWW9UIsGc+VAz25amWxOzmSu4bXCtTMDOBl2x+obsSc73YDGHth
	28PHSYOm9nCkwr9nMWWfrULbaGxSXLAx0mQ7Yg8dyAnp8y9HPBVgs+4zpPgRJL3db5xhWASsGk1
	q0UpcV0riI33i4jZ8kcKOmKE+z7CxTEblgbQZuRRFCVRtdepSyypn3Qqg4guv2kC6O01YUNvuu9
	Fw6lg28Lr
X-Received: by 2002:a05:6000:2010:b0:3ee:3dce:f65f with SMTP id ffacd0b85a97d-4255d2bb045mr10090420f8f.14.1759733219107;
        Sun, 05 Oct 2025 23:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQ4/pWaVB8kQDJnaq36idFEla4MhditXSnHOrwhfk8GEocayvX2aAoNNFYRmvRvmugFJYAqw==
X-Received: by 2002:a05:6000:2010:b0:3ee:3dce:f65f with SMTP id ffacd0b85a97d-4255d2bb045mr10090400f8f.14.1759733218762;
        Sun, 05 Oct 2025 23:46:58 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e77972d2csm105996535e9.5.2025.10.05.23.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 23:46:58 -0700 (PDT)
Message-ID: <35a274b8-dc9c-402d-9ca1-24f7d3c94584@redhat.com>
Date: Mon, 6 Oct 2025 08:46:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/vmscan: Remove redundant __GFP_NOWARN
To: Fushuai Wang <wangfushuai@baidu.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org, mhocko@kernel.org, zhengqi.arch@bytedance.com,
 shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251006014948.44695-1-wangfushuai@baidu.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251006014948.44695-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.10.25 03:49, Fushuai Wang wrote:
> The __GFP_NOWARN flag was included in GFP_NOWAIT since commit
> 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT"). So
> remove the redundant __GFP_NOWARN flag.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


