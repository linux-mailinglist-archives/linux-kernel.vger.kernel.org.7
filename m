Return-Path: <linux-kernel+bounces-835939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B17BA8655
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D037D7A16FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB9726F2A6;
	Mon, 29 Sep 2025 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBTBLnc4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88B22F77E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134571; cv=none; b=iMYQlYrm710MFkPKX5iYwp+grTWZ6sR+nyNhqIL8mPPHqBEjMhkztd2ckivmT52BU+zDybyoWrLkZKNrgUNdyDtxCQ9PzoyipvCChDBF0LgcZ5fNL2SbPv7JTtML04ewxX41at6/33LiI/flsQALlsijryy5E6BRfy3yX2pLe/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134571; c=relaxed/simple;
	bh=o88vgL8zu7TzYWSu5tyjoZ5xm71vY6zyJwP15v+qFVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pkn37BGph1wjUjYCs+6FGKmZ2PYEYuZmTdGMI5ZrCN+JGO1YYDdPLOWx19aC1Z4gmTKBRzF4yoy88gaPCpGaMa6tfdc5BjrTb+nPzWuAabREXNag+HkyMFX9JSDMAzOYrC3/tV2O+bFu8TJsLT6Rk23tsdVqRR7RevFUMa2Mw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBTBLnc4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759134568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Hi2iNCAqNq7pguiCgEi6uYcm4+bKrtHHFufNeahe3d4=;
	b=KBTBLnc46C4fwZ5faSrJUMLQyn89JO85ebCAAS7naKf0Rsq6G+Ki/cPyCzQntS5dtoeePO
	SmouOZEvJCvRGwWn2JueN4TEJYcKS87kOm108naxfg+BAKxr8TBJsqn0LMD76EK3kpxO5p
	XSp37hsASVydrgPUxZwnZGNqQisIzUU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-KkhMEVjvPz-zJNpelelgew-1; Mon, 29 Sep 2025 04:29:26 -0400
X-MC-Unique: KkhMEVjvPz-zJNpelelgew-1
X-Mimecast-MFC-AGG-ID: KkhMEVjvPz-zJNpelelgew_1759134565
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e375dab7dso21502675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:29:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759134565; x=1759739365;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hi2iNCAqNq7pguiCgEi6uYcm4+bKrtHHFufNeahe3d4=;
        b=og8oIEZX6fu9RPSZ4Sat5pqKsmSNhCb3AWZO2a5j/xwFdl/dFkBEx4pKTm2eomIPs1
         4iOXMVseol75ysHmzCn8YT260w1e2n2d29kp7gKVV8U9Xgkp2P0kweThPKIUCoonP60+
         rJvZVMTWwcyR653ElqsjZa2lanl731xkljF5R41wCVppA+Mz6OI9ikbew9cejkY293e/
         HDbzjk7sLtenk8Ch3/CvTeVQsVXo2U4sS1bdXw3/YqmdjWioXfUD+WGRwLDqJ1VX1k09
         nXbebkfm8Jvi5w28T06C9FDpoJX7w5YvHBEM/+Hy9lYTW5WDfmeT6hNWdS6aOPP7sBxS
         JxLw==
X-Forwarded-Encrypted: i=1; AJvYcCXj+8oRGu4BqWeFaFtXdP0cQ0N+deIG2GjDgS0FcIlPd6a2CUm9abipLgBTiUlQhQ7gLkYEii+/JsMZhXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCXcoQ2pGq4QxTiRV//CyDSU/CxXN7wrEXE6d/Uff28FhbN11k
	5l0AFfkDMXe9TaVeXbkA19KYfTfwb65qISa8jWBM12+kYIJMpSmPyQ5GfvwYz+DtdZtJ9SSgdJI
	VElE2VGOiF34WMCtzturIhyN41Ojiak94lsxPWSSAF7JZl0W3Fjk19M9H/xa16XK8TA==
X-Gm-Gg: ASbGnctLxwOCBLrgQa32XQD6UW9gEIHZjSivXduZiSpSIwfkyyO/GU8LBL0AjSUpm7x
	czF3buK/U99eoyLa1MAe1j/ONKQ4I7rgZF5Ty3F9cu02gJvXf97/KgjuXRQtqGgPlehDmUvd0Y+
	IJI08wYxvICDrAxlPTBfh9bSRCUj2vokJrioF1u1mY24ug78Dyt/JtAZnB1Ur5l3N+PUeujmSDI
	FH812o7s3+dsLGkBNP1kA7Cp8VO1BpXpYZviDCH4DUpx88BtH71tyVFUXcOD1NxXa5aYUiUNj3F
	4VEb4WwVFlX6m6pCJ/uLAAHrXuqVORPNZVvZxr1SmpcdR5Ar2k1dcGT1QKsNrsEB6lxrDr0LaE+
	3S2BQpQx7PfjcgzEeo5LoTHQaeEABO46jx7FXGIT5XhXUmhJwtsWICOx3NEIZp8Q9MA==
X-Received: by 2002:a05:600d:41eb:b0:46e:4329:a4d1 with SMTP id 5b1f17b1804b1-46e4329a7cbmr68503105e9.4.1759134565397;
        Mon, 29 Sep 2025 01:29:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG44LTMrSDqtdNJC5gLcztZfakoOEQQRrMtffuTK9hpeNWgZ2xEVdwVn1FQvyYJPfNI56NlA==
X-Received: by 2002:a05:600d:41eb:b0:46e:4329:a4d1 with SMTP id 5b1f17b1804b1-46e4329a7cbmr68502895e9.4.1759134565003;
        Mon, 29 Sep 2025 01:29:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f05:e100:526f:9b8:bd2a:2997? (p200300d82f05e100526f09b8bd2a2997.dip0.t-ipconnect.de. [2003:d8:2f05:e100:526f:9b8:bd2a:2997])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e32c31df7sm87789975e9.4.2025.09.29.01.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:29:24 -0700 (PDT)
Message-ID: <a01ccce3-51c9-48a3-9c8a-1651a0f8dc37@redhat.com>
Date: Mon, 29 Sep 2025 10:29:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: hugetlb: avoid soft lockup when mprotect with
 PROT_MTE
To: Yang Shi <yang@os.amperecomputing.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, catalin.marinas@arm.com,
 will@kernel.org, carl@os.amperecomputing.com, cl@gentwo.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250926162034.1785899-1-yang@os.amperecomputing.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250926162034.1785899-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26.09.25 18:20, Yang Shi wrote:
> When calling mprotect() with PROT_MTE, kernel will initialize MTE tags
> for every single page in the affected area. Soft lockup was observed
> when doing this for large HugeTLB memory area in our customer's workload
> (~300GB memory):
> 
> watchdog: BUG: soft lockup - CPU#98 stuck for 23s! [t2_new_sysv:126916]
> 
> CPU: 98 PID: 126916 Comm: t2_new_sysv Kdump: loaded Not tainted 6.17-rc7
> Hardware name: GIGACOMPUTING R2A3-T40-AAV1/Jefferson CIO, BIOS 5.4.4.1 07/15/2025
> pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : mte_clear_page_tags+0x14/0x24
> lr : mte_sync_tags+0x1c0/0x240
> sp : ffff80003150bb80
> x29: ffff80003150bb80 x28: ffff00739e9705a8 x27: 0000ffd2d6a00000
> x26: 0000ff8e4bc00000 x25: 00e80046cde00f45 x24: 0000000000022458
> x23: 0000000000000000 x22: 0000000000000004 x21: 000000011b380000
> x20: ffff000000000000 x19: 000000011b379f40 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffc875e0aa5e2c
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : fffffc01ce7a5c00 x4 : 00000000046cde00 x3 : fffffc0000000000
> x2 : 0000000000000004 x1 : 0000000000000040 x0 : ffff0046cde7c000
> 
> Call trace:
>    mte_clear_page_tags+0x14/0x24
>    set_huge_pte_at+0x25c/0x280
>    hugetlb_change_protection+0x220/0x430
>    change_protection+0x5c/0x8c
>    mprotect_fixup+0x10c/0x294
>    do_mprotect_pkey.constprop.0+0x2e0/0x3d4
>    __arm64_sys_mprotect+0x24/0x44
>    invoke_syscall+0x50/0x160
>    el0_svc_common+0x48/0x144
>    do_el0_svc+0x30/0xe0
>    el0_svc+0x30/0xf0
>    el0t_64_sync_handler+0xc4/0x148
>    el0t_64_sync+0x1a4/0x1a8
> 
> Soft lockup is not triggered with THP or base page because there is
> cond_resched() called for each PMD size.
> 
> So add cond_resched() for hugetlb to avoid soft lockup.
> 
> Fixes: 25c17c4b55de ("hugetlb: arm64: add mte support")
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
> ---

Agreed that the issue likely predates MTE support, but likely in 
practice only PROT_MTE makes it pop up in practice.

With a refined subject/description + Fixes:

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


