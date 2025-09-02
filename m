Return-Path: <linux-kernel+bounces-795715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8324EB3F6E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 503EC7AD25D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2EA2E6CD7;
	Tue,  2 Sep 2025 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DRlC+lGz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD132F758
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756799238; cv=none; b=aQ7gH+Dev9KHXDhWuf7n6xHHEY7Ew32csknsvGmlSjMjyM71Yx03fxeriY1NK7ht0mkedrOUYoj50pUtTaFgIagHvVqqOxEp1OmwWhZxKngIKvO5nsbJwR8zA8kftZdPKiPVBAi3gHUe84nVrv4WNAiAF0inaVLNZtFKxOJ69Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756799238; c=relaxed/simple;
	bh=KfWpip6LlH5wbDQ2wpKQzlMed040jHVHrCpJ5oDu7yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbA3u6Kscucai8uuWrrJNYczMAN6I0qdBYMcbbEFTNXMrhdLEcLwEkabWwlu58NO52JYKIM86OHPSXngMB5NSsZCiXHC4q7VOJUo1G60w0s6y9VDT+cDyVAvCiLBJmgzJYnYinU+xVlq8PFtRIR91Xcx5LowE8l6ZDK63kUMDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DRlC+lGz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756799236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/4+KrprKnhg+r5+Fo2oRDqAy0SsBH27suggL0lHmufQ=;
	b=DRlC+lGzt+EzhQXngLtQEJIJZMU+aqH5zwEJm6Gn4OH/E6UKJTKSFgGc3R1SnvePclrje+
	dUO3mTgiEsgcN1hbjOuFV+AGMc2Z175Y5CmbHFdnfYK3Dkael82ZCeliFw4XwBTk7LhiPQ
	xjitIflPh7091iwWNJf+uuN2W8rRu3w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-5inPDlVmP1iuL3hBrSVKyw-1; Tue, 02 Sep 2025 03:47:15 -0400
X-MC-Unique: 5inPDlVmP1iuL3hBrSVKyw-1
X-Mimecast-MFC-AGG-ID: 5inPDlVmP1iuL3hBrSVKyw_1756799234
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b9c1b74d0so601495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756799234; x=1757404034;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4+KrprKnhg+r5+Fo2oRDqAy0SsBH27suggL0lHmufQ=;
        b=b+BzRy2793cnYQIgSlb3vLLid5ctvI6fTPL6OzXC2BD/Ntlz3YG+FPgGWYFg2B+CFr
         NFWKBz+izKcmMSVZzmGFULYfK/nbyQwu/yH0P62VHjb1KM+sgUypRQqkonTwno0yaZTI
         XxZtQ7Bl/ByChQgRa0droXDPAJocUWOchSDtZjqbRdKu3AhgPSGumc7HERYTb3gAdtMR
         q9K7h0PtjJsp6KSAZ+0/0q05OPDw7zgBI69Xvukhaykp34xV5gT7AcvZ4hsyMgcCMZ1I
         m4Kt4wKRh1KPOsRLeW3L8/6uZCdZTFGvSqVsSVHZm5vBEXeNX8RSnsj6oIjx2krS6kiw
         xGdA==
X-Forwarded-Encrypted: i=1; AJvYcCVx3H3bUXA9rfvwgeEyK+LA4SF5uu8aMAzMjOYqKYGXbWpxwSNCANTqtNtuRTm4EKUxu3el04oOVmwGVko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFLp1OjqhLKclhnS57JjJ5UaWZssh1XsPEOKbQyRmHMxA+7Npm
	/LR+4iPo6USERq3eX+WFHuB+0RPqbUNKe26xSWli01LGvWx1Y7Vf4mON84JFI0tgPasHDmCY4Mb
	tJ65Br99oMw2uR6f69/iKcR0KORG5kr6WQcW89HAY/I7ptcMQ4SyRyXErnCOL4HNstA==
X-Gm-Gg: ASbGncu1TDnT/8PODLbwt61Zwt26zqjvlw3fLUhA4gqdJl/L0bbGS4InUU1ort5Xv7o
	j2DLrlKWq2yC+o/oPcuMw73I8jJAuzeafWzFGGiPKtMvZyxkIpYFgLAZ1Je/jG/KeMQYFkdc3Zv
	2coqLaT6fDgFjpcKCJemSEQ5TiaEkUeQE+/CsgwMJib1vR5FZ+lMfMZrkIc6IAZ7jlrZZ3dOd29
	ZEm6o6SnwmkukDGoy02xkrFqprSdTIjXw71qiseK0dW5ytLX6hwbHvnjEDjkR7KCNlIS7KIVz8i
	CSqmOJX/x7MuJfcafLZpzg+43AJHXURTL5KWZLrQlpyx7oEZCwJOtGG5IAeHgbpYAKLSoZ2nL17
	PGfLB5536KmHmp90iLRBkKpRod3Gy3suc/4/rhI+AFilPd5atSBE06klDn664125TmSk=
X-Received: by 2002:a05:600c:3b10:b0:45b:8f38:8d36 with SMTP id 5b1f17b1804b1-45b8f388f6bmr44480015e9.30.1756799233977;
        Tue, 02 Sep 2025 00:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt1OMCMxMuZz3NTfIMn17uDdKvWrBYIwYKm/WN6Ey6uFnwE8fHSRWuKYnNl/2ZQ0QtqM12cg==
X-Received: by 2002:a05:600c:3b10:b0:45b:8f38:8d36 with SMTP id 5b1f17b1804b1-45b8f388f6bmr44479705e9.30.1756799233521;
        Tue, 02 Sep 2025 00:47:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b88007a60sm69425185e9.8.2025.09.02.00.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 00:47:13 -0700 (PDT)
Message-ID: <4741951d-59f2-4485-afda-51d554d103f2@redhat.com>
Date: Tue, 2 Sep 2025 09:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/memremap: Remove unused get_dev_pagemap()
 parameter
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: osalvador@suse.de, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com,
 linux-kernel@vger.kernel.org, dan.j.williams@intel.com
References: <20250902051421.162498-1-apopple@nvidia.com>
 <20250902051421.162498-2-apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902051421.162498-2-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 07:14, Alistair Popple wrote:
> GUP no longer uses get_dev_pagemap(). As it was the only user of the
> get_dev_pagemap() pgmap caching feature it can be removed.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


