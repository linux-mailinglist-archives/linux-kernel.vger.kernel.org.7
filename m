Return-Path: <linux-kernel+bounces-839015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 654EFBB0A51
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71B23A3D5C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769FA302151;
	Wed,  1 Oct 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rn8SD+F6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C05926B0AE
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327499; cv=none; b=E1yBlnRSNHBKhjDBj05h4fExe4Cezorlt4LEKqi1bFqqIN1eqxz1hOv9efV1fuSggM9h8iBtRwm6FHJDUx1VRzYo9RAuK8ltfJLjqvU7gAj6ap0uEdtrTlvTOaxJq5kSazkK4CttCOhxasCbeN67udrxXVZhNig/9i5SAi/55jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327499; c=relaxed/simple;
	bh=coR6/87WsIO5GDY0duDk90gtMy4tOpzq37wxhXHlSy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XY8OY/rf3F0jFYYtW7Oxgb28EjwUFGhgQXlukCzrFH0iK8tc1kXvCSTtVImuLuxYeo7ViqtckuqPzPTKHoaBHIeyfyKkWsV0D0OU2VNQo/FtgWBOBCYFP0LG6YnriWYL0lYmuIix4dVsOQEjSu7e5QfYrFOaqYmMKph8+KSEn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rn8SD+F6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759327496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5wPPCW56HYmH+KQxPHAabwefVp7YnLOP8sGF8wH4S4Q=;
	b=Rn8SD+F64H3LalQ97Uj68uAGlvM3zNra7yrF4QvBIEj+gG/CQckIaTk7rNfEclfMIWysPd
	RDBXs36ehrJl9ar7obHE4Nu8+J6mYho1HQaypVIv7oBvX35o03j2ihkUo57TzTCedCLPnj
	jVfCXvbSIodqwd2e3G1DsI3X6Tuoy9Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-wNZVpYyxPNCHgR9rmCuUEA-1; Wed, 01 Oct 2025 10:04:55 -0400
X-MC-Unique: wNZVpYyxPNCHgR9rmCuUEA-1
X-Mimecast-MFC-AGG-ID: wNZVpYyxPNCHgR9rmCuUEA_1759327494
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee1317b132so5685776f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759327494; x=1759932294;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5wPPCW56HYmH+KQxPHAabwefVp7YnLOP8sGF8wH4S4Q=;
        b=uqggqxz3HNB+Si7BltZf3+TVqM61m9Jw1/JGZVGngYp2ea1ZC/gbEqE+1rz0e4q5fE
         oNR1jp0oDS9z5fO8i02SZq6QcpgWpzXrGq3Z2R1OrK1JWRNIgXg+26hm4pJZzCo0nmTQ
         RkDvZRCpPlGc7XiMlegm381ZwFKIA4xa3sWhI5AyFZgM4jPaRCYX8QBqDgy/F69Wpyb6
         KpiizmOYAWRRscQeUbnWRxKRsLiIn+Mg9XpPuAm2xFIyegF5/svdVT8RYXKw70ODKWIz
         pdMNoivy8oPgowXNvmBX1s28fg67erGIvuxKCmlqlkZWP/05IpglRpwuR4eNirzw/Vtc
         cpKw==
X-Forwarded-Encrypted: i=1; AJvYcCWUYuLMHODoKLwSnFhD4c8p+5PVJ+uOYty8HYI5sqlh6+qlH9P2o6SwgbUqoUTvl9ZlJCbNyBW+zEHFPIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUPUL+f1QSDms4WfgW06Jr+jqwXFvlRxzRPGRiZFZBtuaXSz0
	LjPKFTUUXSbp/UNosCHXH1o8Eyf5wsnzRp/elbe4N2WVVr5Rsp0besMJkUMM6Warz5fwY+Uaac4
	pgfoyyLJn40rZZIJAlkzdIwSpo9vS3r5HN3FF4v4jXANcPhzZHqSRM0iyTNMU0ZgFAA==
X-Gm-Gg: ASbGnctJkwI5eNUF+885sXDHINNT9D0U7Q2c9gtyNdlYPbnBdK5a7dYEVRhKpWr9G0G
	yKcMgCnx3JWpPNjHMHij+HzNARhjmdQ0ISTJcvTrvAUwof66wgA4kisMXVy7VO8wG4QLhlm/hW7
	by1fVUaFyc/dG4huIG6bFGWG6XJVd7f2tgYoOPDrHFLeDCTC9hMolcViZW+XY3c1ps0czup2jZq
	RfBxleC8XA/E/UcEnQuTWxC5Z8SNnlj0ORaGOq/sCSSykWbDIRZEbHqy3MNofch/gxx2+cvFT9G
	d5nr0sH0UOmZ2UaNg4Es/YDGh75qzY1PfJBUPxo/7rfL7IbOL0Mjo4/VvgBr3ipKBWeHbuZ8W0u
	rBOwK0HL+
X-Received: by 2002:a05:6000:2310:b0:3f4:84d0:401a with SMTP id ffacd0b85a97d-425577ed6a4mr2490025f8f.4.1759327494286;
        Wed, 01 Oct 2025 07:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENzD4FS17jMrqlPAIsdQn+NVx/5qGSii77YOKVGiC9md7iTCov990k4EcT+GuqiLVYoBJGrA==
X-Received: by 2002:a05:6000:2310:b0:3f4:84d0:401a with SMTP id ffacd0b85a97d-425577ed6a4mr2489997f8f.4.1759327493844;
        Wed, 01 Oct 2025 07:04:53 -0700 (PDT)
Received: from [192.168.3.141] (tmo-080-144.customers.d1-online.com. [80.187.80.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5b63b407sm38795465e9.2.2025.10.01.07.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 07:04:53 -0700 (PDT)
Message-ID: <98cad9a6-875f-49c2-99b2-389bf4fd9b55@redhat.com>
Date: Wed, 1 Oct 2025 16:04:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: redefine VM_* flag constants with BIT()
To: Jakub Acs <acsjakub@amazon.de>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
 peterx@redhat.com, axelrasmussen@google.com, linux-kernel@vger.kernel.org
References: <20251001090353.57523-1-acsjakub@amazon.de>
 <20251001090353.57523-3-acsjakub@amazon.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251001090353.57523-3-acsjakub@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>   
> -#define VM_GROWSDOWN	0x00000100	/* general info on the segment */
> +#define VM_GROWSDOWN	BIT(8)		/* general info on the segment */
>   #ifdef CONFIG_MMU
> -#define VM_UFFD_MISSING	0x00000200	/* missing pages tracking */
> +#define VM_UFFD_MISSING	BIT(9)		/* missing pages tracking */
>   #else /* CONFIG_MMU */
> -#define VM_MAYOVERLAY	0x00000200	/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */
> +#define VM_MAYOVERLAY	BIT(10)		/* nommu: R/O MAP_PRIVATE mapping that might overlay a file mapping */

Careful: VM_UFFD_MISSING and VM_MAYOVERLAY share the same bit, depending 
on CONFIG_MMU (9).

>   #define VM_UFFD_MISSING	0
>   #endif /* CONFIG_MMU */
> -#define VM_PFNMAP	0x00000400	/* Page-ranges managed without "struct page", just pure PFN */
> -#define VM_UFFD_WP	0x00001000	/* wrprotect pages tracking */
> +#define VM_PFNMAP	BIT(11)		/* Page-ranges managed without "struct page", just pure PFN */

-> 10

11 is actually unused IIUC.

> +#define VM_UFFD_WP	BIT(12)		/* wrprotect pages tracking */
>   

This seems to be correct again.


IIRC, Andrew prefers not mixing fixes and cleanups in the same series if 
possible. So you might just want to send out patch #1 separately and, 
send out patch #2 separately with a note under the --- that it depends 
on patch #1.

-- 
Cheers

David / dhildenb


