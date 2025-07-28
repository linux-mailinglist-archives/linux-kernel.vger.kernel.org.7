Return-Path: <linux-kernel+bounces-747704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC08B13701
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 830037A3C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20B3398B;
	Mon, 28 Jul 2025 08:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLnhYPSh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748BF38F80
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753692797; cv=none; b=rIAoDYbX5ATyZI87iYHQHIzoTE8pVzDIY/wMYc6SOyCwTqISNGcDN44QYO9sAwiRbSrTxnHURjckmqXTry1Qm0THsJQO3jXfhzObhVOit4XtZqPQRF0aTABqivQtZXiDA+R+RaT9wS+R4dzgD9L40Ro1qzhn7aP4CG6Bak04Wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753692797; c=relaxed/simple;
	bh=il4vOSE3j6I1dIWAdghCfEwMIQoWI9tpnUb+KoSJf5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YH333Fe3m2PBsdyDinX1HLABrPSJlRhXULHPEk9OoSBiHVI6awJR7xjRfSSC14yIm1rQlc8w0QCOKpHkWIQL3uFjoRYn5fVzInUC5dJ7o02EYHHE73NimaqiCBklnr4DriMtH0Oo2fyA843DXvC61fNN0iE0C5JIv2Fib+1/w2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLnhYPSh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753692794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1XCo0aUMUj8n3sbzJ3DgM8bPeeh+Iez7uG4ZWkUkWos=;
	b=TLnhYPShbQCGKpk1SWAzh3aV3lNlDyxQGRcbF2GRKKaz7yjJ1SvNsG4mJsJFjLakd7zzIQ
	nr/PNzv5BNQsvbsBYd1/lp6Toh014gBQqdb6+0FRTDv6bTGcM2CipGuO2F+IRFRP4+0p9x
	dtZ7kzERE7dQHI971018geazTZuO3eQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-mQke-3qGNLeL9GH1T7ntow-1; Mon, 28 Jul 2025 04:53:11 -0400
X-MC-Unique: mQke-3qGNLeL9GH1T7ntow-1
X-Mimecast-MFC-AGG-ID: mQke-3qGNLeL9GH1T7ntow_1753692791
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so2090918f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753692791; x=1754297591;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1XCo0aUMUj8n3sbzJ3DgM8bPeeh+Iez7uG4ZWkUkWos=;
        b=Dhl232mGiJN5WIDMmXlTMvtwNYsanNe1u0HPSTih8cY8CbGF9NvfMo/vUroSXGZAPg
         LdMzAFrkaAXHw3nGopVW67S+9qBOFrp56AsfpYaso6mT3r6AtDFfijTVdxSSNIWB4ZqT
         XWyl36rF8yWaeKIv2YiBGGUHmHUoOEwvBfvk0G8xVmFStcUGQ2U4E6h/JW1sL857sDkJ
         q9U2Exq8RM9SlRk4lrlm61KBcWbO7F7e+VFqSo4OqLC26UflunbeV80P1QjkRylQYE5e
         k6nrHUBynJb0x6tVHAlJeJvlvLgvQeNUA1T114BqdXIvPgWq1vm5+oVM3aU5rTEve1H9
         yitA==
X-Forwarded-Encrypted: i=1; AJvYcCV7A0zmphBIDuRc5V3VbDh/Z5+W/HNMjafyqRWO++ZGVPF4ColM8eYPu/g88Hm8fG5C3EWTxZYur1akmdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx49LANWgFwfdeULvYL75h6i2R19ig9k3++M+VQW3b15u5MzG3r
	SrhOdKTf6xqI1dBRsGd5EUxmXOMVQmv8S3OG/JfTvhEUu4HR38yQXVGVzxYMz/pxsVjXZOwsPVh
	HxbSfvNXsL34QyeCMAnjVANr3vfyHIRapiH2JZE3hqs0Vpa7SRgtdRIPvdrQUBFp9VA==
X-Gm-Gg: ASbGncskntPd59nPIW5Gdp7dXC3bg0RUI5sxnz9HO8lCnZeA4DKs9as7rbwbGaJ6wPj
	oEn7aM4H+jFwAV07WaBBhFtl/b2diojijDXcb38pAzmv4YAFC5F3LVhmRdpb5cbREytV66y5QJJ
	plwDdd2ladwI+5z1vulCZuwS2ELYwq23dceclv3OeMpL4wffC1+wLqk8tQDIpemfGL8m+yAqLiq
	y2ie2Cy/J4Uvs32/F8ywV4E0VPRSPdZXKtg+BSpbGVYH1WPFuYGGk66ECf8gjUGJF3XDhDkWKCR
	PfahhIOPnuNc7pqigCrJe6HbT0ail00DSj7AvUD8Prm/gdDrfZ1p3GMx/7xQZyocU8LnuH9KloL
	tvNT6Mso5o5IEMZe28YVZizR8itpL1WGDcT9UPaPeHr3i5ZTCdM1YIpJt5lRnLn8Dq5Q=
X-Received: by 2002:a05:6000:178a:b0:3a5:8a68:b823 with SMTP id ffacd0b85a97d-3b776732ad7mr7200928f8f.23.1753692790735;
        Mon, 28 Jul 2025 01:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAgGlEpI1B/hYr2aQ6WG5yauzlH0r4RATtb79hiUTB2BLgnNjxAj76dShQvRyupenOieJqMA==
X-Received: by 2002:a05:6000:178a:b0:3a5:8a68:b823 with SMTP id ffacd0b85a97d-3b776732ad7mr7200905f8f.23.1753692790222;
        Mon, 28 Jul 2025 01:53:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778ec36bcsm7985259f8f.37.2025.07.28.01.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 01:53:09 -0700 (PDT)
Message-ID: <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
Date: Mon, 28 Jul 2025 10:53:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Michal Hocko <mhocko@suse.com>, Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aIc5XxgkbAwF6wqE@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 10:48, Michal Hocko wrote:
> On Mon 28-07-25 10:15:47, Oscar Salvador wrote:
>> Hi,
>>
>> Currently, we have several mechanisms to pick a zone for the new memory we are
>> onlining.
>> Eventually, we will land on zone_for_pfn_range() which will pick the zone.
>>
>> Two of these mechanisms are 'movable_node' and 'auto-movable' policy.
>> The former will put every single hotpluggled memory in ZONE_MOVABLE
>> (unless we can keep zones contiguous by not doing so), while the latter
>> will put it in ZONA_MOVABLE IFF we are within the established ratio
>> MOVABLE:KERNEL.
>>
>> It seems, the later doesn't play well with CXL memory where CXL cards hold really
>> large amounts of memory, making the ratio fail, and since CXL cards must be removed
>> as a unit, it can't be done if any memory block fell within
>> !ZONE_MOVABLE zone.
> 
> I suspect this is just an example of how our existing memory hotplug
> interface based on memory blocks is just suoptimal and it doesn't fit
> new usecases. We should start thinking about how a new v2 api should
> look like. I am not sure how that should look like but I believe we
> should be able to express a "device" as whole rather than having a very
> loosely bound generic memblocks. Anyway this is likely for a longer
> discussion and a long term plan rather than addressing this particular
> issue.

We have that concept with memory groups in the kernel already.

In dax/kmem we register a static memory group. It will be considered one 
union.

>   
>> One way to tackle this would be update the ratio every time a new CXL
>> card gets inserted, but this seems suboptimal.
> 
> I do not think this is a usable interface.
> 
>> Another way is that since CXL memory works with selfhosted memmap, we could relax
>> the check when 'auto-movable' and only look at the ratio if we aren't
>> working with selfhosted memmap.
> 
> This is likely the only choice we have with the current interface. We
> either need a way to disable the ratio altogether or make it more
> automagic and treat self hosted memory differently because that memory
> doesn't eat up ZONE_NORMAL memory and therefore cannot deplete it for
> ZONE_MOVABLE.

daxctl wants to online memory itself. We want to keep that memory 
offline from a kernel perspective and let daxctl handle it in this case.

We have that problem in RHEL where we currently require user space to 
disable udev rules so daxctl "can win".

-- 
Cheers,

David / dhildenb


