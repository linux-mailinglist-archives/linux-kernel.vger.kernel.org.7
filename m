Return-Path: <linux-kernel+bounces-726886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7FDB01262
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59279587E03
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB91A7AF7;
	Fri, 11 Jul 2025 04:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnYhILwn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FA22110E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208967; cv=none; b=Y+jfOnWHXEfJgJAhjiCyS7+FcyWTqzvqotytYHxLwYIDrBWv/GpLxKiVwEXPEIlNkJGebQgX1A6V0OZm1gzgbrHzHql306+tGEDHyOTKAq2ajYgaKbN9bMGCxX3hU+EBhytXEB29e++PN73KpHKH3AF2uBWYKEA/sFTBxppSJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208967; c=relaxed/simple;
	bh=mAvGes/H3e7vyzm+H/aPrH/ncF1XHZOYx2GFJyUWSQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph6PNs2seYYFnQSgLVg/bo7jOCORFrxYc1NYyZA4MrAQEBgk4dSCdynMywr8HTl+N8y7LDKUC9aykH8+yPqmVNRnxdyS7oS+bwvMvFeb7Ajvo98y4zpP8unNZYgn85FRSq4dOx/gdzlnQwzmlfHNa2IEtmtK5ccv6bYXmJDg2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnYhILwn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752208964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=If/5UB61e2uhkmoPY7NnwrYxADXd+FZxWUm6GwDZ55M=;
	b=GnYhILwnwtkRenLMFdMu7LNEwOueQDdcghyVgOjQo4PzigDTEB/1SoD3Bl2oRD7v6lPnun
	zKRNe8ikaeKEt6Pb4zpa0EbhQk/yCT0NoS0Gp1YoXAUyAKlMcssCOB5JsA+c6ZOkwku2jL
	XyjbAA97NgZqRuP/my5Q2rbyiIAyRTk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-wq6qUY1UOI6WSNEMAZGQCA-1; Fri, 11 Jul 2025 00:42:42 -0400
X-MC-Unique: wq6qUY1UOI6WSNEMAZGQCA-1
X-Mimecast-MFC-AGG-ID: wq6qUY1UOI6WSNEMAZGQCA_1752208961
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-23507382e64so17256165ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752208961; x=1752813761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=If/5UB61e2uhkmoPY7NnwrYxADXd+FZxWUm6GwDZ55M=;
        b=UQKNO4fQKydV6jf/tI91LxKU1eRQnbYZXX1LtiF3xiRaX6Si52SgHhZtvFEi977/4M
         qTVnlSCP6fxUKaEOxklHGqLHF0ycPDyy5Dq/o4e3Ax/frsV0xWpKUturrJqucxnn/dnY
         iXAfemGkBeoFYok+1JidNMYoWc0BBWlWSuijpsLlORPQT+jj9aHB4VTjtt0CMnES7xpl
         uhglYB3J813vTUd5osws4QxukPPLxiodDTyhHdS8oDu66ywATWm0zHGbQcFhfAZBKsok
         0qO2jp5+uzqt7B31DecTpN+3Rl5dbIGQ7MGKgpbcXgc/r8qacJ1OIT2jvbaG7aO8Q51L
         lTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCaMhzSp0h7iUE1UjKJ7p27XXTsC+2sPhG+B5AVE1Ubd/KycsrVb2Q6aaMlvKgpPzj++uifgDgjPhY5rU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfUhBtJbke7FF9UymPzS7YIFR6uM7fvFBMFokKgKDtudfgYzcS
	TRCPUd98aE/GKDkn8k+1krBjcPP4xLBBJrU07p1KIce8KBQ6ajauEw7iWnQFbQYH13l8Xunfw2+
	QqgoGQ7CjX7abMtImeqEvt2S8XjIDeb+aBwlJ50vp0lxhtapfLymwZ0VQQb2syDIXbg==
X-Gm-Gg: ASbGncv6lZRfPx1LdDzSuIEGZ2gXnIjI4AsZjG/HVq26bDCDfFz5GUkL19mpnee6Uvx
	jH0+c0GQ4jmEzLX1MfB7jHWiyhtcCrwcJ34ExYfuURC2F6iEcQsYCDwOUWt5zWYMW2NMyK5ziRX
	v3tHcQM3IerWr8femANQIS1K3RIwIxXNLUpHXFKJOjjI2cN+8W8ht5GZMj4+6PPhm1EUdrQUGNT
	l9WPjdqrMGZN5wFMKds1Z23qZbgFcee+sR9HbhLFQAp6XfxF74V3nXVS+/ou8R7jwop7ZAwGnW7
	kCK5MlwCKpNI5MgXaxfOgL1F8+rK9LSXiB+GQ6n0qBRcC6VVXrIsRK5p1dlg6qE4AswkY4pJCeC
	DiNQ=
X-Received: by 2002:a17:902:cf0e:b0:234:c549:d9f1 with SMTP id d9443c01a7336-23dee3a6040mr25269495ad.47.1752208960905;
        Thu, 10 Jul 2025 21:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEceQJQw9Quj4aBv3qS+MmneGwIAixnuZknrzMzoYVfnNj+UGg775KAKT4tNEkyT8JSIPKn3w==
X-Received: by 2002:a17:902:cf0e:b0:234:c549:d9f1 with SMTP id d9443c01a7336-23dee3a6040mr25269255ad.47.1752208960547;
        Thu, 10 Jul 2025 21:42:40 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b01dbsm36977215ad.85.2025.07.10.21.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 21:42:40 -0700 (PDT)
Message-ID: <5147e48d-2376-4b0c-adff-b8663e56f152@redhat.com>
Date: Fri, 11 Jul 2025 14:42:34 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cacheinfo: Add arch hook to compress CPU h/w id
 into 32 bits for cache-id
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, sudeep.holla@arm.com,
 Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, WillDeaconwill@kernel.org
References: <20250704173826.13025-1-james.morse@arm.com>
 <20250704173826.13025-3-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250704173826.13025-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/5/25 3:38 AM, James Morse wrote:
> Filesystems like resctrl use the cache-id exposed via sysfs to identify
> groups of CPUs. The value is also used for PCIe cache steering tags. On
> DT platforms cache-id is not something that is described in the
> device-tree, but instead generated from the smallest CPU h/w id of the
> CPUs associated with that cache.
> 
> CPU h/w ids may be larger than 32 bits.
> 
> Add a hook to allow architectures to compress the value from the devicetree
> into 32 bits. Returning the same value is always safe as cache_of_set_id()
> will stop if a value larger than 32 bits is seen.
> 
> For example, on arm64 the value is the MPIDR affinity register, which only
> has 32 bits of affinity data, but spread accross the 64 bit field. An
> arch-specific bit swizzle gives a 32 bit value.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   drivers/base/cacheinfo.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
Reviewed-by: Gavin Shan <gshan@redha.com>


