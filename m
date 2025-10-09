Return-Path: <linux-kernel+bounces-846552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D2BBC8543
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493EA19E223E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF742D641F;
	Thu,  9 Oct 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIWlk2jV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AED29BDA4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002489; cv=none; b=t+kv05Wt1CCsWr2/0EFWVrDCLRhKWrMamYSY+5hZZANpqABQmS88ghNp4bSLHd9LsDf1jO6/PtvnJ7Vr9bwMLORbP/0Efm5l41DLyf2xfVn3xdi+JgBPMq744rOMclVECvOiTRXFOzSvpL7lowP4Zuj41Y6kwSYzCXsk7oZaduY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002489; c=relaxed/simple;
	bh=ppU7TQ7sRAHJRVmmmcoUMrmL6g3xHPg/L3H/sH8JcZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj3ve9Yx8cYFMkLsU+ywlSGqChFuoV81SZYZk8JgK6Ui9MR5ivJuYmWEoj7WeCJkt6KYlhjA8Csa2mNBEmX4/4hMTSRFf5Hrfn7YsmiSAalwi68O8SU/Kv4vlkvFiKBDL/KWTfkLc1gRyx4dO75puQnkE+NJdMaDJJFhcrYzYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIWlk2jV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760002487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Kh8JGXUB1NsHJYxaM+Pss4KMWF9Q9wo9txu36JERlj0=;
	b=WIWlk2jVPqrgeciQ9puXKhE9NxQNxlGlwJqi4I9XEfYHA45nNOFTTPQK2jNoy/jdxPV3q9
	/0ymKMeB53Xp9hgd27WvNafzcJo+ygV4PK4M6lsBJCDcRnnCfb4kNYCbdEHdBtPI2C7gKa
	RfPf5XlzsJgcmSKhbrF/4GIpgeJ9FnE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-FmVXdjxrPNWlWqxNFn816w-1; Thu, 09 Oct 2025 05:34:45 -0400
X-MC-Unique: FmVXdjxrPNWlWqxNFn816w-1
X-Mimecast-MFC-AGG-ID: FmVXdjxrPNWlWqxNFn816w_1760002484
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso5210635e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002484; x=1760607284;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kh8JGXUB1NsHJYxaM+Pss4KMWF9Q9wo9txu36JERlj0=;
        b=P0TnkV3AEZnNvcaVYv326634TPYGVXe2bZ5HJ+t3LwX/Ss0fezX3RDySeu6kn6MBbS
         Q0o8n1Q0KYD53UmFrd2z63XSoT/mBRqpBMDG+8oNzmASHU6jHOU/6oJNlC+RzXu7dfzX
         Zd157uTIJM2IvD7L37GFPG3Vy2jPF/MOLbs80ulw0LqElGJK4FZ6AjfxVjN7PW6C2VaA
         wKHHfOLabkhnH80DKWejD6LqHUF+fjBz6SNRkM4hLJ2sV4RhvNC94Ek4VCYwK9qox0Gz
         hZOATmNxuSpjagKqCo0hV2FAWandRwd3wRkCGKHbKTgfCrXoail7BwJqkzOn4rpggc/V
         NJXw==
X-Forwarded-Encrypted: i=1; AJvYcCUO9EpHw06MNdy7GMqnBDtlcVYWItkmPguuIZWjCdIa/cjYlQiyuUoueO779u0wUAWS41gqJeqCDyXvtzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk3yF1df1hU6sGqHu+TcJ8m+scGT30a0u4PN6ooUWenL5DEIxr
	pwbSPpqLkVpiejinOMVjLUEytibRI2hBkXsv1d+5ZpTWZQ6OLgnl3DlFI26FDoOAcXfFUYyqusE
	jgchvXe84trR3pvjnptDSDd8SkejEfIfX0YqybS60Rz1muDHD8fxgweAkKeg0Zbi9AA==
X-Gm-Gg: ASbGnctwcYaxnydMfBZ7Y2CZNHytjWlbP9tjGWpZPlyK/JcSl2ZH9cG4HcsW15q0p2s
	sipCCJA04y5CkmQBIT+5Rp9D2zIhUpVSW8B7N9UXC+/5sj87sEz1SBVSwhiGd9dquxiejtI2jZn
	wZGZS8EPMwOkOsDijLicq1RxEFZthyANSrsqHoMIome0JeF+08G4F7SJW36lX0SF9XQLuKcYR9q
	MgxG+4hwsb9hOrNlGGqg5m1rIFA6QiUZqGKLiQmRMWTcJfU9hkqW0jwoBs5xBy0OhK7TYcJatZl
	mfBBq04olTBB0Ft/zKEOZXnYUMtTt5qoBQ66qLmemHUJ+KYGQ6vA5mwAsskb1q6YQna9PV4bBHB
	VW3BD73A4
X-Received: by 2002:a05:600d:a:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-46fb32e4c1bmr5153275e9.1.1760002484187;
        Thu, 09 Oct 2025 02:34:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyfdLHmeLVcS/24ELo6N5hr/uPsFsSPCfyzvUigm3fcqdF/w8z07IDJSwlfvj+lOzROactJQ==
X-Received: by 2002:a05:600d:a:b0:46f:b32e:4af3 with SMTP id 5b1f17b1804b1-46fb32e4c1bmr5152945e9.1.1760002483746;
        Thu, 09 Oct 2025 02:34:43 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9bf8288sm76286315e9.2.2025.10.09.02.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:34:43 -0700 (PDT)
Message-ID: <5c6aa34e-9f07-40f3-bd5c-2ad3242b31eb@redhat.com>
Date: Thu, 9 Oct 2025 11:34:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/18] mm/ptdump: Replace READ_ONCE() with standard
 page table accessors
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Conor Dooley <conor@kernel.org>,
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>,
 Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Dev Jain <dev.jain@arm.com>,
 Lance Yang <lance.yang@linux.dev>, SeongJae Park <sj@kernel.org>
References: <20251009015839.3460231-1-samuel.holland@sifive.com>
 <20251009015839.3460231-2-samuel.holland@sifive.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251009015839.3460231-2-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.25 03:57, Samuel Holland wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
> anyways default into READ_ONCE() in cases where platform does not override.
> Also convert ptep_get_lockless() into ptep_get() as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Acked-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Link: https://lore.kernel.org/r/20251001042502.1400726-1-anshuman.khandual@arm.com/
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---

I'm not sure why I am not CCed on the full series given that it 
apparently has LOADS AND LOADS of core-mm changes in it.

get_maintainers.pl is your friend ;)

-- 
Cheers

David / dhildenb


