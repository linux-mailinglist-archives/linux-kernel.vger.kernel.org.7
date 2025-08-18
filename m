Return-Path: <linux-kernel+bounces-774067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F8B2AE3E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 180D94E294A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B5341ABD;
	Mon, 18 Aug 2025 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KwHagKGV"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7995335BDE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534765; cv=none; b=CAlbmdslOdVhv2XqgrDsIJKgUd0KpCUWJVi0hrRpwI/ddNs1wILhNdMwMw43iw212pDNs9Bub9qP0eZ0MUHN4RHOZET/a/FvVkaGxnSzkXSzKCGGztXloCe60to9cgWCtcu033ny0b+VuDtpf+iouax/RbFap755z38ifJ3PlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534765; c=relaxed/simple;
	bh=g9SN5xmqbpq88QtLkj1Fl2e7nlIcxSCkoV9Qkug1WLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbJBGdLGoftXmkdNbcQHjf4oE8HGGBZy9iGHMvsLmB/4J57PcIJ1Q1SaReresBqjG+OSEZxZ8QIgbd+z+HZqJb9hpbSExlha0eTwnhify5ZfXzdySj76Hb2ou6wGPCN/byNBUrMwhxwDHR1tX1Wa5em3X8znzr/xjZYIOJO9mAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KwHagKGV; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88432e60eebso99703639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755534763; x=1756139563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ntC7EoOgFPYWmn/kl+XayyvV6WCpKaQ8QN9jhl3W0oc=;
        b=KwHagKGV+odrEjElgsHyoYL9ugu9ewXCo35H7oYDRzTeUDlKMJJsuDODT2lk1vwMNP
         9qPD3pFcTlzdULkzrsJhXLJeEtTdYhbNilvV0GLjRw90TrFhmTsQDb+PXMTFSv+lwcQI
         XP3BxDp6KghkJ13QfsiJF996x8IF6BEqSqjAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755534763; x=1756139563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ntC7EoOgFPYWmn/kl+XayyvV6WCpKaQ8QN9jhl3W0oc=;
        b=DvdA/TozPbJyuDUKWoFvpEgowdqhIiIUscdy449Chiti7lM7ej6qlFJFhu3ju4kgIe
         /BzCOjUbsp1z/IMH+6zHw1ZlmAByKF01AAf6kc2ZBQ3CRrBStmWnmI+ZIAkSKNnnH9ya
         4ZLld0nJKq2UEoiwP0FQXcXVvxzVcmxDQF28vkOwh3Y6wMp+U0BaeyKczLsSoNtLVKKQ
         2jmD/rrCLZomL3efQLgQw+WdvGt66ckg6zQQ0fwhgCH3TfG/OtViAJQs9RZXaX7gQhKi
         aKodHlmnEHUU/b+WqpcDU0jSdc4Upx5x0xTTYESU7wR20Na2NUSzZf3r+nyZ8ZNxqM6c
         yTOQ==
X-Gm-Message-State: AOJu0YxLHj7MbxX+1hUB97LOzPeUo7FSDbSWf0bd+GCdru7RsE6vicRl
	TOueUXXIwe2IomcmVrGPq+1qsatOZWUz+39gIFyYbhanMtV+vVDIdwniQwtdyLQFZjI=
X-Gm-Gg: ASbGncvCCoNgQ2luNMfBblVXrFWXZbX+0mjvxKUhvScm2Rrxjjjs66A+i3sfSdtVe00
	wsdlVrEI2YmCX4C+Q5Fbe2EM3yrjfq+zi0Hjyu0w7Is0bB26L0CB2HOAbeOA/xZcyCaztWCoPr/
	FowpnV1w2Lfgk91I4ap+ck+ESCJsGTSo9cXb8OhEng4Z0DZ0LAXa6Mvv7RMSxAIOQRUF4gCQ6cA
	TaQtGXefSgD3l+cUJ7THx0gRBQWNMECn+cNT4K9uuSMHdBKJh5OX5dYU3/SPGINCMQLrAi0U2T+
	5oAepHmKHgvaJgcn44nxEVMxvdF9/9xz8WzbpzErBasvdfqUhelNsqhFLnBproyOO0FciH5w+F5
	tiaurwtLlAIH7kaJc96QAIPWF+BydvYzoR9o=
X-Google-Smtp-Source: AGHT+IHgg2qIQn3xXshhFvkUFW5Rviw8PPMHY9fVWzLdQzkPLeNNzXlM2TGiJH1UIVmxe7rjBkvSDg==
X-Received: by 2002:a05:6e02:1a6e:b0:3e5:4b2e:3b00 with SMTP id e9e14a558f8ab-3e57e80e257mr235375945ab.4.1755534762819;
        Mon, 18 Aug 2025 09:32:42 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50c9477ef61sm2787685173.8.2025.08.18.09.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:32:42 -0700 (PDT)
Message-ID: <1befd7ab-f343-450f-9484-0cef21fe2da8@linuxfoundation.org>
Date: Mon, 18 Aug 2025 10:32:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kunit-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>, David Gow <davidgow@google.com>,
 Marie Zhussupova <marievic@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250818120846.347d64b1@canb.auug.org.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250818120846.347d64b1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/25 20:08, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kunit-next tree, today's linux-next build (x86_64
> allmodconfig) failed like this:

Thank you Stephen. I did a allmodconfig build on 6.17-rc1 base - didn't
see the error.

Marie, David, can you take a look this. Looks like conflict with drm
in next?

> 
> In file included from include/kunit/static_stub.h:18,
>                   from drivers/gpu/drm/xe/xe_bo.c:20:
> drivers/gpu/drm/xe/tests/xe_bo.c:610:48: error: initialization of 'const void * (*)(struct kunit *, const void *, char *)' from incompatible pointer type 'const void * (*)(const void *, char *)' [-Wincompatible-pointer-types]
>    610 |         KUNIT_CASE_PARAM(xe_ccs_migrate_kunit, xe_pci_live_device_gen_param),
>        |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:210:38: note: in definition of macro 'KUNIT_CASE_PARAM'
>    210 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
>        |                                      ^~~~~~~~~~
> drivers/gpu/drm/xe/tests/xe_bo.c:610:48: note: (near initialization for 'xe_bo_tests[0].generate_params')
>    610 |         KUNIT_CASE_PARAM(xe_ccs_migrate_kunit, xe_pci_live_device_gen_param),
>        |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:210:38: note: in definition of macro 'KUNIT_CASE_PARAM'
>    210 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
>        |                                      ^~~~~~~~~~
> drivers/gpu/drm/xe/tests/xe_bo.c:611:45: error: initialization of 'const void * (*)(struct kunit *, const void *, char *)' from incompatible pointer type 'const void * (*)(const void *, char *)' [-Wincompatible-pointer-types]
>    611 |         KUNIT_CASE_PARAM(xe_bo_evict_kunit, xe_pci_live_device_gen_param),
>        |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:210:38: note: in definition of macro 'KUNIT_CASE_PARAM'
>    210 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
>        |                                      ^~~~~~~~~~
> drivers/gpu/drm/xe/tests/xe_bo.c:611:45: note: (near initialization for 'xe_bo_tests[1].generate_params')
>    611 |         KUNIT_CASE_PARAM(xe_bo_evict_kunit, xe_pci_live_device_gen_param),
>        |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:210:38: note: in definition of macro 'KUNIT_CASE_PARAM'
>    210 |                   .generate_params = gen_params, .module_name = KBUILD_MODNAME}
>        |                                      ^~~~~~~~~~
> drivers/gpu/drm/xe/tests/xe_bo.c:624:51: error: initialization of 'const void * (*)(struct kunit *, const void *, char *)' from incompatible pointer type 'const void * (*)(const void *, char *)' [-Wincompatible-pointer-types]
>    624 |         KUNIT_CASE_PARAM_ATTR(xe_bo_shrink_kunit, xe_pci_live_device_gen_param,
>        |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:223:38: note: in definition of macro 'KUNIT_CASE_PARAM_ATTR'
>    223 |                   .generate_params = gen_params,                                \
>        |                                      ^~~~~~~~~~
> drivers/gpu/drm/xe/tests/xe_bo.c:624:51: note: (near initialization for 'xe_bo_shrink_test[0].generate_params')
>    624 |         KUNIT_CASE_PARAM_ATTR(xe_bo_shrink_kunit, xe_pci_live_device_gen_param,
>        |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/kunit/test.h:223:38: note: in definition of macro 'KUNIT_CASE_PARAM_ATTR'
>    223 |                   .generate_params = gen_params,                                \
>        |                                      ^~~~~~~~~~
> 
> Caused by commit
> 
>    444be9072fca ("kunit: Pass parameterized test context to generate_params()")
> 
> I have used the kunit-next tree from next-20250815 for today.
> 

thanks,
-- Shuah


