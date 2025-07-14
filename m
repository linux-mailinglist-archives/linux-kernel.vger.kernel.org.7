Return-Path: <linux-kernel+bounces-730259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B6DB04201
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95D8171685
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84B2571D4;
	Mon, 14 Jul 2025 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7M93jM4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9E42561AE
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504122; cv=none; b=AAq8ixhpgBgaER/86C2UKVRFdq96/UxN7c0kNickO59Xu0EjJNZIIJK8cbXsbtEo11qdi5+jE/zozEBGigJTvQAacFVC+y6BjRC6jkW7v4ynmuJs07ukaYW7zaWZX7qqGjOMuCPKNm0ETjoDgaEJ3Zgj+GWMn6HwxRMfZkabahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504122; c=relaxed/simple;
	bh=hEwuaejv2lup+7bKSClcCKg4jBAz1j/grkIQ5qrq6gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQFeEnxYUqXglShBBrpznSQ4T0YrcfD8sgaRYQlJaDvzFKUTpELoxDvReyJ7dS+m5NuseTgezWggXHN3QAY6P8kT4SA4LqvrnCvrxlKbI28HjZE97b62jGRDDRDqnDak5T1BOnCROHtBlI9tVsAHZtifOUO+FFNn76QGfQwnenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b7M93jM4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752504119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XSp3g2fAIWlkOffxIKmWmNhMdOSyZK3SoWUfVwFhRE=;
	b=b7M93jM4sxvzzx0c3Hnw9j5XMH/Y/qK/bwlsbIIkvwFhuHETZW/4JaGNQZIDFqzHcbF3T8
	+MFGrzv8lRwf4kAF20bPta+rwc8sUv4+I0TuzBuZOFZNapWoXB3jnRGUxooWhEpmcSdkTl
	Qg2+o5OlaGDouVi867Uc85wom+QID/0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-aZySKOKVMtyrprRpPjZa4A-1; Mon, 14 Jul 2025 10:41:58 -0400
X-MC-Unique: aZySKOKVMtyrprRpPjZa4A-1
X-Mimecast-MFC-AGG-ID: aZySKOKVMtyrprRpPjZa4A_1752504117
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45359bfe631so27149945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504117; x=1753108917;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XSp3g2fAIWlkOffxIKmWmNhMdOSyZK3SoWUfVwFhRE=;
        b=tdLvZFePwm/dYWsE9Wjz53/vKS+nWB2fh2G5D9s3hR0oJgkZRL4+ntB8lJkRcwSl17
         wcKuzNNNGEwDNTvWXPZbJCxr02MKcEnL3mXhnIhFj51CRMd9i94jqJ+zXqn+cRpSaszH
         KtbYX08drxkQAiUfZtwS991oTK6MDbpPg+m3a08SNS/3YL/Q84FvGaAv48+cXxVmxlaA
         F5Vs1cw5uYfmbpLwKs27rS3WytchDCHR1lbACPYAFoZd4nIDffrkr17t/fg5MH4sUy/c
         1Fqtbqe3g83mSux5W7PBoCZb+VPJ6jA8cLXe0qWepeKkG1DkaYzhGaoHD0wrTTea4VtS
         Abzw==
X-Forwarded-Encrypted: i=1; AJvYcCXZXn5Zf2HuKCMrxmZ19VnLZDHvBBQq/W0O45MwmEpo+Lv3vVpKkHc089Cl2+uSsI3d9jvZycmGfjbrrYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcYEbiV7zfVPINf8Udi8gzs4G92HM/tPkhl5Hdh9kiBlYpmUA
	rTLGim729bScKQUMxIyqJsWnqctP5QLojG/OQRHtYefab0vba/6EMtVt0zWOpwYV47Hr2opnyTy
	D/GZlk61X0Dzv6jFotkjncBQoww5ZdepwBf+P5ZHfUz8ar6cXKlfAo+osYGrjFaS5MA==
X-Gm-Gg: ASbGnctkLCNrzcUdAd0T5Y1tMIdKATvEQ8G+Q5yNJnP42oPrQ4yr1t8M82Weh/8fn9H
	OUhgXKIKeX+DKON3ztd0XXl1NFCaEcBLjPDZOhBIYynj9RJdp/9BZ6uZ1dPN4XNxLkPAGscr+jc
	tYBIoBRZJWYKxriLaM72KEy/EjNcCmLVRV4gN90wFvHUPlla14xaSOGUZsMRMkFNKutyOE1BeGG
	ssEazb8Mu4LpKZsvoR0zE5DarhNqJ5kwITA/iZ444LNk5S0eoAkdbTI1x10284121LtgNWa4VQL
	jPTn6mf3ciGJZU+TmvF3x1ED5+rBA4Wl4f+G+7g1h5M5z35VqVdQbxS8F6Hn6NoAl+rMwE/I4Uy
	iQoNF7mKGSkyx6Q++ilZjqffEZJOwAPxrKkh4cHnbt3uCFYIyk1FjP5OXynxTi3T2
X-Received: by 2002:a05:600c:a216:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45555e4c191mr83447125e9.9.1752504117111;
        Mon, 14 Jul 2025 07:41:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpAwsbfGFLRxIAqd4lnQYU1wvx/si6+mPOar46wAeNRpM9iaWeamMTKNQf0GzctApu37HEtQ==
X-Received: by 2002:a05:600c:a216:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-45555e4c191mr83446895e9.9.1752504116695;
        Mon, 14 Jul 2025 07:41:56 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm12455795f8f.22.2025.07.14.07.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:41:56 -0700 (PDT)
Message-ID: <88ad463c-b5a1-431a-9a0e-ed7e39e86c18@redhat.com>
Date: Mon, 14 Jul 2025 16:41:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mm/mseal: separate out and simplify VMA gap check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <f010ec1ce65f35dbe1fbd82ce002ea833a7128f3.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 15:00, Lorenzo Stoakes wrote:
> The check_mm_seal() function is doing something general - checking whether
> a range contains only VMAs (or rather that it does NOT contain any unmapped
> regions).
> 
> Generalise this and put the logic in mm/vma.c - introducing
> range_contains_unmapped(). Additionally we can simplify the logic, we are
> simply checking whether the last vma->vm_end has either a VMA starting
> after it or ends before the end parameter.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


