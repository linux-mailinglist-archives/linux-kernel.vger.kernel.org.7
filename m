Return-Path: <linux-kernel+bounces-747993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65569B13B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD1E188B5F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC23267732;
	Mon, 28 Jul 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sy6Z739l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10CD266F00
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753708479; cv=none; b=ZblhtDjIyXZWmqQjThyuYeS9s88K2MTmNNvCWOg8CmyU0b2DXzWx/Cj7cwdqihh0VG25SybRJuL06vGiAoheJIbf5YOUYUigcZFBUenVlTfGJnPYe1H5c5jItH+35EdMSV5n9soKFi9JL8siWQYjAazol5AnWOTgB5hcvY02tBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753708479; c=relaxed/simple;
	bh=2daA3AvHNrdtZAsQNYo6fk97zmvbFtSiUvYOSs0DJDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RG7oU50KoE8krY/VtjcdjlJjmpUF1i9eMEfzbXeqM3jjTGlf7v6SR5KXDoa0GXZq9bPIk2r3zp19+QPFRkhZKbDGUj4R+n+4Zqm+xe3XWBWv4Yd27BqVuLRGwdhLJ8yiYg9Z70rPNiinWzmFUOnGQBEMKE+SEKid3Hmbt7O5Afw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sy6Z739l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753708476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LvmPhToHOR6HSgjCI2OnycSjK9gNQAEM8DewQu7Vi+A=;
	b=Sy6Z739lbOxhTtHTWRuozjcbCtsySEdBEcOE7UevKGuQHIbpzPN5raE9CGswdBpy7lOtPR
	7zcKwJSoO6tjuJ9+jiuiLwMWgIJWYHNNSZFI4AgNcbspKhOKZXfui9Kc7f0y/ygxlSxPid
	GxIsMf+/qwD+NgKKB04kF+JGuP/tyGw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-WbNcjbjLMsm8Pa4wPq9myQ-1; Mon, 28 Jul 2025 09:14:32 -0400
X-MC-Unique: WbNcjbjLMsm8Pa4wPq9myQ-1
X-Mimecast-MFC-AGG-ID: WbNcjbjLMsm8Pa4wPq9myQ_1753708471
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-555024588e2so2583575e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753708471; x=1754313271;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LvmPhToHOR6HSgjCI2OnycSjK9gNQAEM8DewQu7Vi+A=;
        b=UyVwWf6iMuBoN4k3UF/bzSGrW7fS4EIZtCHmK/o4e0G5K4CMOt1jafCXl8H8vi60vI
         6P/cqi1rn0EZOdAYcx0kpSn6W5mgzXbSdILD9N8ymsaHra18VXwLvp8cxv/ptF+fY+QW
         EGFOq9ps+6Z+Xchtmmg6/jC5FOuPm7TZfAcqtVC1Zr9IZBrJzoLnwc/hMcqPdgFMpMt0
         f/lhcXRSk5r+EYGjWZ6FJUEGZQ6pDZPdJqjXRfUPd5X24v65DtUxBxEZ34hhlRLcSAr7
         0LcI0DpEYoP4u63IQ5AMvDElztDprYt1Fn5286pQIfzbwhOff6AyjL6ke5CYp5c+HeQQ
         6t8w==
X-Forwarded-Encrypted: i=1; AJvYcCUkCIRVRg/oP9lTLz94iMyQjtUl1MnLYkXSYUlQwLJxDb7BcE7GNBzPmYNtyDC2xxHEJD1zQ+ExDjCF6aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaRgmV8fm931jrFRDJgBWjGvgLvw0JcdOpa4Dk4HWEywI1QuPI
	whjPSagLSMSICVKLQMSzOz3mfY5P7z9SyaDrvMUukP67fQ3HyKLBQTZZNLdaDgAUbPU6PL/pGNZ
	v7yWEM2+BSKdojcaH+RdXm6cZDWAFaVHP277LL2cdcjelG+3VQzApJ+NH91wpwEZ0MzaKo/+dgZ
	Cj
X-Gm-Gg: ASbGncuwtxc1B3ZIhY0rEAvjF59GgPT4IAAtKu+/qkEg8bV+0/57+mY7v2BQ94ORPOG
	w5ZfWnL0WDvOIHF2evjPa1F3FivZjUPY95G1OoV5w7FvwtF69rCPHrTzxy5MXyslxM5p7ExvS8G
	pNGRb4vFp7o9z9AknYmHTMoxCeg73XsKXervvBusaTLrM+j11osnrO5UwdIpeTTYaZ4VMYkpHzQ
	dfxQaBhhwjkWFR0L217v2eJhrCLapEkH36ZHty1J/J7DNtZx9eDXAM5ZeInLIqprfsQkVK8+8gE
	J/hsaZyUT9t9EuvUdjSreEeFs+ecX/V8q1GpKLkF/CYNstMDApxglWk/viVui0wCD3NpcoYdn4G
	6aYZKFKHmxoQQvChQYySU/CBfj1oY1pYE9POGUPKOZB12m5pxlBKcgessBLG4WaBU18Y=
X-Received: by 2002:a05:6512:130c:b0:553:33b3:b944 with SMTP id 2adb3069b0e04-55b5f4d844dmr2964880e87.54.1753708470800;
        Mon, 28 Jul 2025 06:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7cooNi7EIlieaXAkiyUszr7FMSt+00vQHmfmy7Zn4/r9Ui1z6R8+K731nkAB9nSbSvB1iwA==
X-Received: by 2002:a05:6000:248a:b0:3b7:8737:7f1d with SMTP id ffacd0b85a97d-3b787378026mr3011013f8f.46.1753708119115;
        Mon, 28 Jul 2025 06:08:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abeb39esm97528125e9.13.2025.07.28.06.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 06:08:38 -0700 (PDT)
Message-ID: <3e88642f-3914-42b0-b864-4ad374b659b5@redhat.com>
Date: Mon, 28 Jul 2025 15:08:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Michal Hocko <mhocko@suse.com>, Hannes Reinecke <hare@suse.de>
Cc: Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <aIc5XxgkbAwF6wqE@tiehlicka>
 <2f24e725-cddb-41c5-ba87-783930efb2aa@redhat.com>
 <aIc9DQ1PwsbiOQwc@tiehlicka>
 <79919ace-9cd2-4600-9615-6dc26ba19e19@redhat.com>
 <f859e5c3-7c96-4d97-a447-75070813450c@suse.de> <aId16W4EaqjANtKR@tiehlicka>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <aId16W4EaqjANtKR@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 15:06, Michal Hocko wrote:
> On Mon 28-07-25 11:37:46, Hannes Reinecke wrote:
>> On 7/28/25 11:10, David Hildenbrand wrote:
>> And to make matters worse, we have two competing user-space programs:
>> - udev
>> - daxctl
>> neither of which is (or can be made) aware of each other.
>> This leads to races and/or inconsistencies.
> 
> Would it help if generic udev memory hotplug rule exclude anything that
> is dax backed? Is there a way to check for that? Sorry if this is a
> stupid question.
Parsing /proc/iomem, it's indicated as "System RAM (kmem)".

-- 
Cheers,

David / dhildenb


