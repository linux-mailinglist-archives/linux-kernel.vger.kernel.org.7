Return-Path: <linux-kernel+bounces-828622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2C2B9505E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 10:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28774441D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87BD31D39F;
	Tue, 23 Sep 2025 08:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0DbxG2S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555CE31D393
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758616630; cv=none; b=p3gn4DLdGxO2rOaL7rhlSO+Uacxo4j0+FUSG66fbdM499AkGXeSdx9zqHxzbKwsH8ZXkj433ZJyByQI0RIBmPJFliVWcbbqqkEBOa2YXvMCpPvULoegC03DnNDAgnVL8SnWXhRbGa6nPGTlFBf4lxmScOFDICOl9NIm4rhaH1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758616630; c=relaxed/simple;
	bh=aRloNIy049X0nvKk4THRNrmGATr+go0k7cbyNj2+wr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=humNOymvagkTUg92Y0lypaqEwt60NU7jW1zmstEWMaRmSaw4LyByTlNUf82V/kI/e/Gb8zKOoLZgVHQAJQ4aQxUBlivno9UK6l3qNLpT/2nPjipJhMs+Mzjhs2MetX8d6dK4e2mZEsaDex3sS7d15UdZ4v1uR3Uak4es5wKMvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R0DbxG2S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758616628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0FichtJezjG8Fw3oNsREz7KtXAArVifFDdwv8D/TDyo=;
	b=R0DbxG2S1/TmUh2Zg6uGZ9y8eXX9JHNN/2bWJhuMsfBfptS4c4v9vbsLPB5hYAw2dJeJ+p
	uTQVXYthIDxQN/gGX9M7F84dSQJ0YAk65ZFF9zhhArnUClTO8rqCkEcDtMgB8MmsRFaePQ
	lGFVAEXnJSTxyPKdhtEBAx5BBLmQ0kQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-9k7R22brNT-6UvpJ3_JQ3w-1; Tue, 23 Sep 2025 04:37:06 -0400
X-MC-Unique: 9k7R22brNT-6UvpJ3_JQ3w-1
X-Mimecast-MFC-AGG-ID: 9k7R22brNT-6UvpJ3_JQ3w_1758616625
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3eb8e43d556so2698358f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758616625; x=1759221425;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FichtJezjG8Fw3oNsREz7KtXAArVifFDdwv8D/TDyo=;
        b=Ns2RsPbGxFSyLt6rZm21OK9ULk+fN7YM9MorEuxssXEAdELuku4E+HwzUdmgo5yfVo
         ix2EU/qhLj2sa/6aUBRcgQX3tdAH85cvz0qXZxU9aZKn+M9/xkWDBtizxhhG9R7H66D5
         rYjaGMdpRuHXfHjc41sIsR6uhXRAYmSGuhsKBKeqaR8+N0ltDYrYJY4HJM/REZkdZwmH
         FNnSqNFpRJ3TQQtX4zNgLsoDv1qsN2Q2Ygld4Hxss9OPZ6Ek1eklRnaO8Qk6kgrbj+jX
         NnU7nz3uesQ/v911CfNU1SoBU3ji5BIMZgcop0/n8xDhSkfxuWdFRpemWNW2eW7qWc8V
         VIoA==
X-Gm-Message-State: AOJu0YwEFx1YSfuHzKUWwJ5FHJ0/J/xBDOZYp8MPadDag65fXmd9R+sT
	XnR+T9eCdFWhQ88+SjIGxQzixfz1IF7EFv12vkh/76qss3MrNgS8SfwP2EYMfooeVtUATQ4H9ZQ
	gy/eT2l9spcCCck3TFm1eb8AV5DmyWiABPFkb+Zvb7vr1TR0st6tzcCcPEL8WiW2C7w==
X-Gm-Gg: ASbGncu3lJh4I2kOs2lOsweoMrsqekUbFmMO2ERLYlpYQoCkeHoRRxzMJJmUP/SNEzQ
	9A8BoHx22anDTVpjtGS8163p7l69rv9S3pwUXOYnJLo8AGA6uL5DAiEq3IVemGhLrfoOHe/G6TS
	oll2bW+ok4fxKw7E0Iru/f7D8c5R5mRlbmvekGYnB4vAxbo8cpCbePz895mWA8s7jPonyXJXOfi
	sG23aQjW0put1tPcAE4xk901j445XAhRnIdO/a9XwL7DgnZW0IVqEFZzrMh4wXVn0azJUJSTIM0
	053MXCYMKPBj9j2dGD0cCWi3NEqawPrK6magQBB8GQ0kI1FNeJTY6E0XX/K95ibFyneVSZAI+wg
	iwIdRSM/+vCztqCfoIpNsZyXTYyC8cEh5dVQnCBwSnyvE9qHgxWl335WV51C6eTpv3g==
X-Received: by 2002:a05:6000:184b:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-405d26c213dmr1225237f8f.26.1758616624929;
        Tue, 23 Sep 2025 01:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEawPPWnpwt5rFwfd2DqihY1bzY492tZVIfX1f84FZQOvJccOmfH7DP+skjktE9t2ycA3257g==
X-Received: by 2002:a05:6000:184b:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-405d26c213dmr1225200f8f.26.1758616624459;
        Tue, 23 Sep 2025 01:37:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:700:c9db:579f:8b2b:717c? (p200300d82f4f0700c9db579f8b2b717c.dip0.t-ipconnect.de. [2003:d8:2f4f:700:c9db:579f:8b2b:717c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f829e01a15sm11575843f8f.57.2025.09.23.01.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 01:37:03 -0700 (PDT)
Message-ID: <bfede7e3-5295-4453-928f-8e7c0bf8f2cd@redhat.com>
Date: Tue, 23 Sep 2025 10:37:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6 02/15] mm/huge_memory: add device-private THP support to PMD
 operations
To: Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, damon@lists.linux.dev,
 dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ralph Campbell <rcampbell@nvidia.com>,
 =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Francois Dugast <francois.dugast@intel.com>
References: <20250916122128.2098535-1-balbirs@nvidia.com>
 <20250916122128.2098535-3-balbirs@nvidia.com>
 <2A0E854D-0B0B-48A8-A87F-E9D38C6823EF@nvidia.com>
 <5b9da42e-49a2-4229-81ce-625ce00ed7b2@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <5b9da42e-49a2-4229-81ce-625ce00ed7b2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> non_present seems too vague. Maybe just open code it.
> 
> This was David's suggestion from the previous posting, there is is_swap_pfn_entry()
> but it's much larger than we would like for our use case.

Right. If we can find a better name, great, but open coding this turned 
out nasty.

-- 
Cheers

David / dhildenb


