Return-Path: <linux-kernel+bounces-886400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28996C35712
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9964FD8E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94F31195D;
	Wed,  5 Nov 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGJbevnC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAZjwInq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333BE2C08B0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343036; cv=none; b=m6vc9UWxwoIvT83xupjE4OigcK9sKC1LCpJpuwXrKzfZYi9Fto1PE7LnVerOfGB66Rz3YBGLEWvVGs/L0mUeFs9xovbd/JovuuO5Wn/60pTiOJjGryvzTS8tHZJSF9Uut22irdTJays6lVgVR/q5mQd8ux14KyMp/VJEgQX0Qec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343036; c=relaxed/simple;
	bh=FjSBFrFK6vQr258PJBQglftj1YX33rYk17AwEBtK9IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wk0WtkWCyrySYUIUnCzP9ZoSZNTIkUaElFzwdC3djYzmZ5794g+wtWwuT/NVNj5F6lRS9cO66QpcZZvHgqS9g0JFmp6QLXU7ljByJUg8U26f0ubI4gYDR+FNmwd1Oo/A38y8oZ65ygM8rKqnC7d/DclHt5BMwCHassRbBpGtVM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGJbevnC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAZjwInq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762343034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klnCOqdIdlHY6mc/bR248n8wJUIpm2Vh5Q48weSXZPE=;
	b=LGJbevnCt+0GbzikKP4aC7Qnxlo2zo/9J0ITKpX/i3ct+BpM2hAWlA4xh8EjtO8q4W7nvp
	rT0Hr8Eg767bnPwkP5Kim0aSa9yjN+om59Facmm7CsExzkoQ0MYJCRjjQP8ewXj8g44coX
	zQUQddxcfRIrGKLP7J/fCetR8l+PRWU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-OsjWxaPRNxaOIDtsyTQTpw-1; Wed, 05 Nov 2025 06:43:53 -0500
X-MC-Unique: OsjWxaPRNxaOIDtsyTQTpw-1
X-Mimecast-MFC-AGG-ID: OsjWxaPRNxaOIDtsyTQTpw_1762343032
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-427015f63faso3680853f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762343032; x=1762947832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=klnCOqdIdlHY6mc/bR248n8wJUIpm2Vh5Q48weSXZPE=;
        b=jAZjwInqIzlCKoWvxmYdO3bACYSwMZfsF8mOit+wcv/uOWN1Qkr0EarN41zFhFgJxD
         ab/6wQMTkv4r+cOzH/kgQREIti27vzg0zkCDC+ULsnWar57zGQFFKueUpAA29AImMgHa
         CWl3VbGRddk8+q1lsh2buLu3V6n1v2zaU++W81eKdo2nor/gJ7gM03QyrQGi3myR1Zrg
         y7Nvsi9qeOhNyE7O3wpvMR32Y1jhtvJ7b6Njxam1yA+OF8YyZ4/6P5SpbCa1Km6AB9C1
         bmoxYfdZtXJRim0tR9S3A2jTsEnDaqibMfc9sU2F2tdvIoq2JMugAhQlgVC2In9JnJ0+
         0XgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762343032; x=1762947832;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klnCOqdIdlHY6mc/bR248n8wJUIpm2Vh5Q48weSXZPE=;
        b=f6/2Ptj/u9Zb6xCzCuUl1/AUSrqBrn/3oZnEJItvJ/9A3X7VYTu75/WQ5584BtJ57c
         bfUqLSx5V5mbTOq+0gmsDMoCERSJOj2A3xLKFWstCKQsXGVeGzKulhh5h+4PY5zXtEgp
         AyZGrkvdSIqto70gPLiABZbxFAlI3cYR6a1CuNtpkwyixJrSV0jgPclDZY1GW14ddij3
         qMnkecTUMB8nMauT8u2SGtVPcMUJw/P7AY/Rk/GAxRfuSf+bTZU/wAq36dKfpoio7+Eq
         ws8LAg257Et5glVCxct610ae0aGq2DEjrfWoXE1O8AqIz1Ds6WVk8L5YgMwFZwHQ9HYM
         ZBLg==
X-Forwarded-Encrypted: i=1; AJvYcCUE1KjXFVjaiA0rQvlBo9+JET1Vehk2+oZlh9AUyJZthoG2m/MpvLosN1p+C00858zM2iwIhHZEPoi68+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGrRqf/UT2HecsmfyMOHgV4VOya21Boboy5Zg2LXBnmc3yuTOS
	6va8Mbrz32WYDpeRUgrCoVgO9rAhYrbjxnOt5tWYQQU983VeFrZ9P/pJYoPNreShfEBVEJ8bGd6
	UCGcEYGK3rIO+XLM0d8ufe0f3tv4tPuzW6krHUSfuitJyHMXGyJ3KCdUPNRYL2zhqpfmy5+u6fA
	==
X-Gm-Gg: ASbGncv6jPjSk7I5mSCsr1sWdA1HUWNT/YsJpGzV43/cCD3PNgnZ+t+KjLh3QhZPchW
	hfds2hepIJs0x855+HkPO9cJ/gfYlywJD3SDPsjSqFgb8sfPsNjnTCiEtfQIbBD7zypVhwx4Llw
	X+84/tK3bHqou7MVoJBzY6oUz03SdPfPVOUkOzaAyijTBiqMJ3uOWdVAcm1ycb9s44S/+ct4Hgj
	H0wd0zkHyOIcGbV9LUkfrNhsAmQ/oG81Fd4fgEaApHKlJgpHPHvVpBuYce2yAzd0qd6ouNlShZc
	9QydR2T2VfXiZQFbZ4mYjqPoVO3cuKMu0cgZnELt6aq4vSYq0eYXdYQ9JYi2dXdick9uESLxL0U
	JfVxb6RZC/1Twt0YsoZjo+YPIPXSxOJLkSqOteBXgTltHFpG03IQOn9bXMSRCmzFaV/Zypd1oFG
	UrxnGaDnOAEavrTPXpPKpt7js=
X-Received: by 2002:a5d:5d0a:0:b0:429:d2a9:5dea with SMTP id ffacd0b85a97d-429e32e1778mr2767704f8f.15.1762343031802;
        Wed, 05 Nov 2025 03:43:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd+fmDakXbZEyKRhdg87mxQDe9DRgIxrMqS8HdOHW3oWAXWsvoavSh7hxbMrysYBkKGmrGpg==
X-Received: by 2002:a5d:5d0a:0:b0:429:d2a9:5dea with SMTP id ffacd0b85a97d-429e32e1778mr2767679f8f.15.1762343031390;
        Wed, 05 Nov 2025 03:43:51 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efbesm10423127f8f.8.2025.11.05.03.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 03:43:50 -0800 (PST)
Message-ID: <58d3c50f-2b4a-4053-a846-613434d5bcd9@redhat.com>
Date: Wed, 5 Nov 2025 12:43:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mm/hugetlb: refactor sysfs/sysctl interfaces
To: Andrew Morton <akpm@linux-foundation.org>, Hui Zhu <hui.zhu@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Hui Zhu <zhuhui@kylinos.cn>
References: <cover.1762245157.git.zhuhui@kylinos.cn>
 <20251104150618.0606afefb2a9e226aaa6ce77@linux-foundation.org>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <20251104150618.0606afefb2a9e226aaa6ce77@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 00:06, Andrew Morton wrote:
> On Tue,  4 Nov 2025 16:37:41 +0800 Hui Zhu <hui.zhu@linux.dev> wrote:
> 
>> From: Hui Zhu <zhuhui@kylinos.cn>
>>
>> The hugetlb.c file has grown significantly and become difficult to
>> maintain. This patch series extracts the sysfs and sysctl interface
>> code into separate dedicated files to improve code organization.
>>
>> The refactoring includes:
>> - Patch 1: Extract sysfs interface into mm/hugetlb_sysfs.c
>> - Patch 2: Extract sysctl interface into mm/hugetlb_sysctl.c
>>
>> No functional changes are introduced in this series. The code is moved
>> as-is, with only minor formatting adjustments for code style
>> consistency. This should make future maintenance and enhancements to
>> the hugetlb subsystem easier.
>>
>> Testing: The patch series has been compile-tested and maintains the
>> same functionality as the original code.
> 
> Thanks.
> 
>>   MAINTAINERS           |   2 +
>>   mm/Makefile           |   2 +-
>>   mm/hugetlb.c          | 852 +-----------------------------------------
>>   mm/hugetlb_internal.h | 113 ++++++
>>   mm/hugetlb_sysctl.c   | 133 +++++++
>>   mm/hugetlb_sysfs.c    | 629 +++++++++++++++++++++++++++++++
>>   6 files changed, 887 insertions(+), 844 deletions(-)
>>   create mode 100644 mm/hugetlb_internal.h
>>   create mode 100644 mm/hugetlb_sysctl.c
>>   create mode 100644 mm/hugetlb_sysfs.c
> 
> Seems a reasonable thing to do, although those who work on this code
> should have the final call.

If we limit the move to the core sysctl+sysfs code, leaving most of the 
actual logic in hugetlb.c, I assume there won't be too many conflicts in 
the near future.

Hoping for some comments from the hugetlb maintainers.

-- 
Cheers

David


