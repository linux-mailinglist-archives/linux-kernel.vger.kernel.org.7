Return-Path: <linux-kernel+bounces-758281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C37FB1CD32
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD817243FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7152BE056;
	Wed,  6 Aug 2025 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaCWjWb1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21D2BDC14
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510814; cv=none; b=TMNs6hQRCYw2aPNpzHZdATXzFdSBynjl6IkOrChCbbmdidzNE6j0T8b6WmITRARc8GA8+tIlDeoOuM28xr1z3UAvvw0Uz1u5sRhpvu3m9BvVo+ohJmB+MEHKvYlKlEaq+v1Z4VwSC0kwv96ugsGk6gWiVlqBRCwrvN7nWsusu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510814; c=relaxed/simple;
	bh=oDhl1RzuETY0FwG8M0s8oNKabYqkLwB2c2rXcIXJzMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5d5lNLGp5ZzxBAoWwr01ll0NIC+DXk5V0AK/hq+9LNiXbPodk6AlhIS3BAaHNlwXmU6bsh7t/0jnP5em9qHotP83IqVhGKxO+UT9ie6ovgeEjfNy7xxfe1Uudcs0630gb+KHCSpN2q2Y+EBjeNA0A4gKTOGEd/gy3xfCFHBDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WaCWjWb1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754510810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GJ5H/AIPeHLukWekWKnQHiPq6Mf8Cz48drJCJ8whLqI=;
	b=WaCWjWb1cuf/sPBWR9n60f8Whbbs5heYrBqQ0tVFTEHpm/o75Q6JTlulcdhM9E7V/VoUuf
	L+QZn7gyW6YXFz0j5Y7hFZVBKemfLunxNBWb0fFsbEFjBhrXX3NMDNLwnAbmDMWTQ1euRv
	wpWVr3fGzaUJmEBoAlzeZncOCYklUJw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-Ci2LoOtPO0CwyTD_QMCfZA-1; Wed, 06 Aug 2025 16:06:49 -0400
X-MC-Unique: Ci2LoOtPO0CwyTD_QMCfZA-1
X-Mimecast-MFC-AGG-ID: Ci2LoOtPO0CwyTD_QMCfZA_1754510808
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7865dc367so81337f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510808; x=1755115608;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GJ5H/AIPeHLukWekWKnQHiPq6Mf8Cz48drJCJ8whLqI=;
        b=PzP2SO++/n+WFEBdTgf2Hqh/ZiPsZy4JD4U7atMj5v0uI7+rZBDtEH+O7saSvN3OKJ
         WRIPgFhKWO25jAT1EXpQwov6tEIGFikEoeBzpjDEJwbhI3l4VnyePHmSX7fds4THsqyG
         Lw0CAgY7IYx+1VJfQ0e34hyLA9n279GQUsq6A5Iqm/McuTFHXdCB3NSag4jauzh4oWNF
         UKp681TtBOz1f7uNfkvMTggn6stMkMqLI1vnuuvR9FY7ruCila8T0mxEEKtQq3pzgC7Y
         qUodXWzEglhh7WUG50xjDQ4ydhlqRcGDtcW2CyGZm52eX8WzxPenieWcodzPBpEXDQHZ
         PlRw==
X-Forwarded-Encrypted: i=1; AJvYcCULjPBXpOmt4njHygh+mcVdLS/U0bSyztcE14dj5ee9Fii7yk4AwXEUMfYmZEMPvQg/S2CMPJRasPpxIMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsMhP/BZ/00eunWetI3w5DxtGXIWcnOyEr1Yjv/u+iqPhf6ak
	7oIjqyGlDSWRLIzv81w+1aTvo00AT6JL2mB2CJ0d6kt8xuME+4lHVqF1mgh0LCibFqdaS5sqG68
	pKkli7zLC+OLbu5GUjtzJcKrx+SoYciD58X5CdpxNx7PXrEDGPBKx5C63bUAbHy5vpg==
X-Gm-Gg: ASbGncs1IiKmtXGgj2OAKwk618UarbqujRexo/0mSX5QqbPuD/UlZSsW+1ez9C1Aujj
	ef3oLFVEzPtVKiicPxVLubeQRdN2GSpd9vcP9/8/P1UfOVgZWKsk6bx3KSSRN7EAraDaGwD7MH6
	gigUa1l9DsRoe5OflkUmrEmIhx+Kp7uC4qhoJezp8EXq+7SaSGHmdHd4wGdiPdW0i8UgMDJSKTl
	rrzVSUBuFOQJac5EE1xCWZuak6v2xZx4pxIiOV6idwHOWo6L1CjQOVnYbZGdcQ4FK8AF8nfMwz/
	MvfEbQd4bG5fxwsIsc+bi0HbQdQ9xomQqfnO6lc/Gl0NLUDu7mwb6SvqSTL0vKVfi6v1jzY=
X-Received: by 2002:a05:6000:2485:b0:3b8:d901:fa33 with SMTP id ffacd0b85a97d-3b8f41ad591mr3232092f8f.42.1754510808098;
        Wed, 06 Aug 2025 13:06:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwKvTA1/FVCHzgwsnSeHG/W2ZTK0EicBHSibWy5AFsnV3x3+BVIKtUS15h4G7Ic7YZPZtoXQ==
X-Received: by 2002:a05:6000:2485:b0:3b8:d901:fa33 with SMTP id ffacd0b85a97d-3b8f41ad591mr3232078f8f.42.1754510807673;
        Wed, 06 Aug 2025 13:06:47 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f974.dip0.t-ipconnect.de. [79.241.249.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9074sm23670680f8f.17.2025.08.06.13.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 13:06:47 -0700 (PDT)
Message-ID: <ab2f8752-6bac-43c6-b889-f5940a6c94af@redhat.com>
Date: Wed, 6 Aug 2025 22:06:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm: Correct misleading comment on mmap_lock field
 in mm_struct
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Liam.Howlett@oracle.com,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Feng Tang <feng.79.tang@gmail.com>, ahuang12@lenovo.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250806145906.24647-1-adrianhuang0701@gmail.com>
 <9305bdaf-9455-4c26-befb-471466f952ab@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <9305bdaf-9455-4c26-befb-471466f952ab@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.08.25 21:07, Lorenzo Stoakes wrote:
> On Wed, Aug 06, 2025 at 10:59:06PM +0800, Adrian Huang (Lenovo) wrote:
>> The comment previously described the offset of mmap_lock as 0x120 (hex),
>> which is misleading. The correct offset is 56 bytes (decimal) from the
>> last cache line boundary. Using '0x120' could confuse readers trying to
>> understand why the count and owner fields reside in separate cachelines.
>>
>> This change also removes an unnecessary space for improved formatting.
>>
>> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> 
> LGTM, so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


