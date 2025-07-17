Return-Path: <linux-kernel+bounces-735475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB61CB08FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E022D562A41
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63032F7D04;
	Thu, 17 Jul 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qp8yUsY2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F36835963
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763768; cv=none; b=OVD3jDN4CTxmeqpTfuYAMQzT4t7NtYRMc6D2hwR7gTCoMp0QFFDvgyoiNOEs1FSwGJZThiwZoo6faTCw42sUtGwqlpxg1BSAmYkUk2HfSmONCY/6PQqQX4Pkl4LdPskpUn5h/CxkAHmqeJfjNiBOX4ufLro1OMsawgAZ6G/5lgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763768; c=relaxed/simple;
	bh=9PlOtQKEAFzO2DSgkIw78BvyzS4Qv6lnHCyvnagNDws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rucxalp6mRBNOTNkcyAa3AHfEXeYU8xIegeitI2cg7o6wRYXtlSLTg6kzy+KosrQK27ZGgGt21rgVZ9xzOt3s3VaNdkFg+jI5+eiomjsz3GwBjLoPT/kLmygYYC4DS+vkUFoZ3FIoSeh5h8NSK8SYPVXDku89ykMnxW9uNpwWDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qp8yUsY2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752763765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yQMb1+wS2eSkfpD8lt6I9j+fSyOXG57LWL56PdFfPuE=;
	b=Qp8yUsY2rExIKFlLtAD6ee1lVg+3QMb9em7fACHAjUtXsf2tSjr/1FMA7AtbDV/A9Vp7ap
	RzcgdMWGkBzk1Rl8F4ovu9DwuZgabnKpgBEgmho67oIUE2ysIDcGIlbQdFm/m+6B1Hvz97
	3ajNY9C8oxppJExxBzbdUlGn2URVfcE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-t-rF1cdDMYWA6CIUm07F0A-1; Thu, 17 Jul 2025 10:49:23 -0400
X-MC-Unique: t-rF1cdDMYWA6CIUm07F0A-1
X-Mimecast-MFC-AGG-ID: t-rF1cdDMYWA6CIUm07F0A_1752763762
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b5fe97af5fso510962f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752763762; x=1753368562;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yQMb1+wS2eSkfpD8lt6I9j+fSyOXG57LWL56PdFfPuE=;
        b=TkFw4JvolQYoNlZHzfsAk49mcw42K4q8RKuYrdsKSU6pEqTFkj6xg3S5S/7fgbCmzC
         JOLtDa3hWZexiNNc4z+tdIJOODIqnjDO0xxKySaNEs3a5TzflIzTuzc4gjFNBHnX6odD
         EHlO8H1MZUKUmlbWE1TNxBwAPiYaU0zwFYl9o8acgEPUss2KdMQixcz4lZKZPwA4dQlT
         KVIUstZsA/6Sisow1bBaLSeTfje24M4/u8vpvQv9sqflCL33Zx2aEv4IliBryLYeSbut
         GN9Z+Rln7LPm//lH+otdrHdxyEFkhACJu5BOG3NpQWS48ZQNeB1q5pyAdoxZLXfvVsP6
         kFYw==
X-Forwarded-Encrypted: i=1; AJvYcCWvnNz6Yy2kEjAC/5Kc40qM7EmnLae0sljLMgQwbSpkOTJf5LZbzPJqvaNysH1vRjlnqhP+kbJj7J+K5Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjj8L8rB7BMTYduUAWQBGDFaEi5sg86MjMO40ErwUTqw37gHrk
	h2WVkTir+zIsC1ulA8D1nklqObi3T393M8o6GLHhnsv5/xph3o/C7DNmkJ5TDCxWtDd5yEmH/MY
	Tl3Yf/uNbw+adPggvYeSL/BcHc9Gh/tUJAcOBfyfUMXAsEQf0Tr/gbMqnSys0cjkBBQ==
X-Gm-Gg: ASbGncviU0aMGSbPTbScSAkWnnX+GU3bBq8kjplyDjNvUNBSm4d/UwV7N5kMxFNAN5Y
	1Co4RIJwHuvvqvcTJ4hYep+KfTPI4x8rmJVHoPJHsyjO0ypk5b7KgA/DcekWmJNBsHGx+TSEvjq
	n7Uxg2UdHKev10MjMiFqCPVLRdmyiH7+kBi+Y3Pp7FW2c/v7mWoTzaTqsK0KAtPU1rvnQmYTi3J
	xh0GGFtoi85UZA8JsnfYyTfjKNKqUXgo/HlOXnubzGH1i8vcBXEM8k4Z5/KzehMT2wzmQdi7zQo
	Z6L9VcYeEhed3Myqo39pvhymU9N5QvxHK6TiH5a2J9CKC5zxDaK/3SjYbMhL56Web914dwiVCce
	HVJmaJOUvyWjp9sQAjiwFy931ZGV1MxSW5vcH98xlRjxTV3aAuRQt/iTT9AKgejAK
X-Received: by 2002:a5d:5f46:0:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b60e5127efmr6440737f8f.31.1752763761797;
        Thu, 17 Jul 2025 07:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB4BzQwt1uA6jNvYg9KXjg5Sb8H9BF6TM/n/+bMIra3u3HYiMpTsglgidO4NGId3V6f70EZg==
X-Received: by 2002:a5d:5f46:0:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b60e5127efmr6440707f8f.31.1752763761405;
        Thu, 17 Jul 2025 07:49:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:2b00:b1a5:704a:6a0c:9ae? (p200300d82f352b00b1a5704a6a0c09ae.dip0.t-ipconnect.de. [2003:d8:2f35:2b00:b1a5:704a:6a0c:9ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a62sm20800473f8f.40.2025.07.17.07.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 07:49:20 -0700 (PDT)
Message-ID: <42db9f05-11cc-453b-8259-39cee70f137d@redhat.com>
Date: Thu, 17 Jul 2025 16:49:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
To: wang lian <lianux.mm@gmail.com>, akpm@linux-foundation.org,
 broonie@kernel.org, lorenzo.stoakes@oracle.com, sj@kernel.org,
 ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: brauner@kernel.org, gkwang@linx-info.com, jannh@google.com,
 Liam.Howlett@oracle.com, ludovico.zy.wu@gmail.com, p1ucky0923@gmail.com,
 richard.weiyang@gmail.com, ryncsn@gmail.com, shuah@kernel.org,
 vbabka@suse.cz, zijing.zhang@proton.me
References: <20250717131857.59909-1-lianux.mm@gmail.com>
 <20250717131857.59909-2-lianux.mm@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250717131857.59909-2-lianux.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.25 15:18, wang lian wrote:
> Several mm selftests use the `asm volatile("" : "+r" (variable));`
> construct to force a read of a variable, preventing the compiler from
> optimizing away the memory access. This idiom is cryptic and duplicated
> across multiple test files.
> 
> Following a suggestion from David[1], this patch refactors this
> common pattern into a FORCE_READ() macro
> 
> [1] https://lore.kernel.org/lkml/4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com/
> 
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


