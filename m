Return-Path: <linux-kernel+bounces-788034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F307AB37EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 11:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8611BA4412
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142CC3431FC;
	Wed, 27 Aug 2025 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4VOUPqT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA133451B0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287412; cv=none; b=CX34deUW1VoLgDuCytSSeK+gwN1cbgmDU8nGs5W5+uxD9TiSjYrWfa9ZePh8nM3RIHS5kdvvOy/2oQhXvv+z6fo8F8DRvsTcXZEQbcuRCGUVLHAHluN195qNBHpCMLKiTSiZUprG5MPu9oPZPPMsHmDza7XXDAKi2d+mJYBhRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287412; c=relaxed/simple;
	bh=uJqohUgV6MKAPTlNPQKuLxbj5VHA1wq52H5qtgLWzT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkuMZRPd3KNeDgtzczQXzInJ2qtabS5/2kODEs9E/UpYoYr6XZ/qG4J3QO31+meePOnEqieTUshnixKX57/Tsu6hBr4hz0HgHmwptvB/wqR7rrjWByREGiv1Tegbo+YoVtNedB4K+3miUOCfIT/f/iir8U7nNcZvV6Hxdo12ZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G4VOUPqT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756287409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IB58ANfhXIZ53R5kVuf3CfNJ928IdN95VpKDMuZxG4k=;
	b=G4VOUPqTba9kbp9SBR9F235EqTls/99kdKzVzeYfnle5mNnVP6vOcqohKqtzj6nZRQfos3
	XQoSILUzTGfB0mS1bL1TyHgcLasrB7f4E1bGoBV0RusfvZkGRqqQiLmYN+uDhGJlOrGbkz
	5yI7tPYEBT6UMhP1euTeh0PGTHxAIRw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-1AjLpDzVMpWZ44NTgIRthA-1; Wed, 27 Aug 2025 05:36:48 -0400
X-MC-Unique: 1AjLpDzVMpWZ44NTgIRthA-1
X-Mimecast-MFC-AGG-ID: 1AjLpDzVMpWZ44NTgIRthA_1756287408
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7f7b2d52958so144722685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756287408; x=1756892208;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IB58ANfhXIZ53R5kVuf3CfNJ928IdN95VpKDMuZxG4k=;
        b=tTgk3FwCvvoNs6HPpBZNVloCF73TNk9TRkA5mOOLBmHv748w2dVcIQV0vj/2z86FOA
         kjfvOEShySrWQ5/2VAaBg0np6PojZ1ee5uhkYmRXM6jK8sTTn4nG8t6i2k1R+CZDc/Su
         LQRzGmYJAahmw+1yMmA2Y9VUZ1o4pgLjq9h6TqUwQMk5M4QIVbG1i7UwhR+hh9cwdsFe
         sAkpX37WWlMo2S4NZ/01xiYYdo2Mdj7PjEaUJ26yEPqv2lMYNM9Xn7KwVkKv6hx21L2l
         drf06o9nFkVQ2rczcBX0g5GFugqISjdthrHUBlrQLNqZ7YZ+fPkh48n42ssyeMrVb3zm
         xXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0sznrRWq/NXxuinGNbbnKN2oG6SpmG4SKof0PS3DN9F7cj7CdNAY53jcndinPiFJdZW7OF/L8AkOlgcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiPRbUgvzXzk6gz+gpXeq9wdpvN4Ow9Ric7o/gXiHSOUkikYCo
	BKlF24spD+4MxShdCFGgv+Z9qCaZS4hU2jXIzMaV4OStt+0/C9R+P60rvDeuqq2DMmC7K7qd2Jw
	NsghYIUXsMi32LQQu6j0ybh3pjhI/8Gy6YzOOsml/fe9Kce8BPgZ5tXDZCDBQa8+HoQ==
X-Gm-Gg: ASbGnctuaKdmSB1kwZRFbpJFd/6Wg6ywqwzoaQS8ABxfsD/HQcFZsqTcBAQ0gNJUm3N
	eDJz2mL89xtWRXsqQ9/KCRxlKzWkElnzPfjFp6qM6B6I4MzXZrlChoxDsASmfnn/pIy4vfKshxm
	Td/L6xwWpDD+BlxVSCdxvmj/1TXUhobVO4p8Z/iZmzRgWK3p8dIb05bie/W8EC39HYAi6m5d9BG
	LuVjXqHHQ73tNFO9MGWftZSWsXeiogQUkA6/kh436yvnMKNN/aiYvszJQY4nerWOzSihoGA9/7Q
	lSd7VeWC8RzU3pm3XHNlQps9nSDZHkzADZjzf3f+EzdqtjE9DUxnH2joQ0OF9A==
X-Received: by 2002:a05:620a:4147:b0:7f7:b238:feb6 with SMTP id af79cd13be357-7f7b2390309mr145609185a.12.1756287407543;
        Wed, 27 Aug 2025 02:36:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF19mdw9HaE9u1hIUSoVrmuZ9hix/ra7ZUDWgNbmFEd8sI9w87p9vY/6qDxfcqewzc9GjVfYw==
X-Received: by 2002:a05:620a:4147:b0:7f7:b238:feb6 with SMTP id af79cd13be357-7f7b2390309mr145607285a.12.1756287407047;
        Wed, 27 Aug 2025 02:36:47 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e1cd7esm89693771cf.39.2025.08.27.02.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 02:36:46 -0700 (PDT)
Message-ID: <e5783c3d-7eeb-41d9-9fe7-730155f9bf17@redhat.com>
Date: Wed, 27 Aug 2025 11:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] huge_mm.h: is_huge_zero_folio(NULL) should return
 false
To: Max Kellermann <max.kellermann@ionos.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826185515.7fbe1821713195b170ac1b31@linux-foundation.org>
 <CAKPOu+9wz9g0VuYDPiNDYdaGG-gdK86h1gGSCmVPsC2a5f-GPA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+9wz9g0VuYDPiNDYdaGG-gdK86h1gGSCmVPsC2a5f-GPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.08.25 06:39, Max Kellermann wrote:
> On Wed, Aug 27, 2025 at 3:55 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>> Isn't it a bug to call is_huge_zero_folio() before the huge_zero_folio
>> has been created?
> 
> I have no idea, but folios_put_refs() calls it and I don't see why it
> shouldn't be allowed to do that. What else should folios_put_refs()
> do?

Why should it be allowed to pass in garbage (folio == NULL) into a 
function that operates on valid folios?

> 
> (Thanks Zi Yan, I'll send v2 with your suggestions.)

No, use a VM_WARN_ON_ONCE().

-- 
Cheers

David / dhildenb


