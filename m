Return-Path: <linux-kernel+bounces-830310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF20B99606
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A9A4A3E55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C2C2DE6ED;
	Wed, 24 Sep 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvxyCoHo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DEF2DC777
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708658; cv=none; b=gICORIGz9CCHYCuugy/IuEZSLLOK/relk/5rpNAuSpt356MEbyLvc9xtx0U0uL0hcfMJCNMuqCJoc1RxbTeKtgx5Ruced9LVVOhY4zwhSrGRX++vVwswP4nOBrtjWgfmBtSc+MT2R5UfBRmu7bz8Wad5CxjLAlu5OQjQXxmVIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708658; c=relaxed/simple;
	bh=E6OLrGR7fKOVuBtDAuJ1GSfMcO1NzeA5TV5gNdnp4hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9Z+E0L5TfaE4s1zHHOEoI+js6ZoGZGLLoVsR8HrEL3LMgvRhoBPnkp7X6vrLVNACDOdlJRON9tJA6Tlopas64nfXZYxhD0W/9lDenuasPYeTbmbQwLCs7Vs0r5sQPZ7asroPHWGQ2Fq/j+aQZHipviezKO9J6NduLkfTnpKWd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvxyCoHo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758708652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xiCQ8BU0umsCk09KhhxkGDVC5GBSrUKugfQ68xhIVCM=;
	b=YvxyCoHoun55kcFwoKNMFRqR/25JtfFHATTtTPiNAHNBQo15VzFzvCX1xjYZzeBRfJfglp
	csZVdPWWA/kL07hFw/68rqEquDNbbPC4IrBi/g6bHLT4p/E8477iIwC55XnJMtmSCsa3sK
	Bhucj9ei9SKntB7JxmLwJcV7VvEeaF8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-dzS9Hnn8NRKqdw6k9DjTcA-1; Wed, 24 Sep 2025 06:10:51 -0400
X-MC-Unique: dzS9Hnn8NRKqdw6k9DjTcA-1
X-Mimecast-MFC-AGG-ID: dzS9Hnn8NRKqdw6k9DjTcA_1758708650
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso4307920f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708650; x=1759313450;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiCQ8BU0umsCk09KhhxkGDVC5GBSrUKugfQ68xhIVCM=;
        b=KTOzN3PHFIOO/rILEmUbVQZVcL0+oukeH9f2jCFh+TAKjKLTm81ZbPbI4+PcikWMYM
         LmljIQBbIHGeYete5pNOmTzMBUWdQ4HDJK22zzSkLgwjJtF2EtQOhOcOF+YRUEATTR31
         TZ4Xbz8aD+HcWuCrV4jd8SOmJGYoyqz/6iONxJw4odMozqAIGNZ373AWW0jSBqAAMx/p
         CVZh5w2jRVywboKf03F/+0fZpK5Vsq1A8366uupUbpzokv2PPRNRA+ODPcw2AC1KcMHV
         95W7ufec5Oo4S29UQOYrbTo9Owp6SELHniH/qobVI+fFdBJcFsjHdbaXdTPN2Ti/PfbA
         gbGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMTbsn1cWgW4/lTDwYWo82aFVPRqVEvBAJoIm0Fgtv/xVI2n2PjGh0nUivBZPEbbsq75tLw/W/n1z2UX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwacGbb+U5wCo10B0Tc+JKn+eX7dFGJEs87CzKuHPXPTdVy+U2Q
	sjZDjJHnPUp1rKYr3v5w63+EN8LMaQ2dmM+Lo0lLRrh/2ThLPUw0/mnXCkGyMmzMsC6W8CMriWV
	+wFpoPcL861irKAOE98Qh6/ZP3Ky6NNgmKLpIparW+notWyXcHCBYMhKV8pvMSdYKMw==
X-Gm-Gg: ASbGncsrNZKlz81WVZegWC+rzV28B6bqKYh+sBCBSr65L+e36B1SQUz+HCyPsLzkQ/h
	7u1SfiYYrTNcH3coGUZ3hosJPbiEeNY9P9POqCQAtV0JaZDgyajdH7NkQXlshIQDEZP4JxVhWCn
	CLRrvy9BNi1v7vcCDZMZ8y19Ogz0mHYIoXLEFgkTw5KNlsFuxmgbodgDmkN3vUobS9hlAjV3c8v
	RMJ4jywRWSEjIDTqLEb1gafjBdFoOF1ia/gZOeWo+7siXamTzwt4PXq9jhXkgFSxZgtRth7UAhl
	wENpvn+HqzIa9AeamgZAqD8ItsgRBocw0Gz9JrT0UkG4k3VGBdyo9glT9rGmFfPkx03sj4YpQoi
	UAoHTfoDEeV8x4pjpweMaCvRVaKlUGvYyUw324qpe39fC1LfgBCyiERAeYzELQ2Tvjw==
X-Received: by 2002:a5d:64e8:0:b0:3eb:4681:acbc with SMTP id ffacd0b85a97d-405c523c244mr4992814f8f.23.1758708649504;
        Wed, 24 Sep 2025 03:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIeauiTh4AAMLabIhLe4f2o8VtghIpe344vFSC4Y6rzc2lojFu9KZ5/l8ek2CRup7aJ2viPA==
X-Received: by 2002:a5d:64e8:0:b0:3eb:4681:acbc with SMTP id ffacd0b85a97d-405c523c244mr4992790f8f.23.1758708649098;
        Wed, 24 Sep 2025 03:10:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f14:2400:afc:9797:137c:a25b? (p200300d82f1424000afc9797137ca25b.dip0.t-ipconnect.de. [2003:d8:2f14:2400:afc:9797:137c:a25b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40c5c156a48sm1447555f8f.48.2025.09.24.03.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 03:10:48 -0700 (PDT)
Message-ID: <1282de5a-3dce-443d-91d1-111103140973@redhat.com>
Date: Wed, 24 Sep 2025 12:10:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: abort collapse scan on non-swap
 entries
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com,
 ioworker0@gmail.com, kirill@shutemov.name, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com,
 ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com
References: <20250924100207.28332-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250924100207.28332-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.09.25 12:02, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> The existing check in hpage_collapse_scan_pmd() is specific to uffd-wp
> markers. Other special markers (e.g., GUARD, POISONED) would not be caught
> early, leading to failures deeper in the swap-in logic.
> 
> hpage_collapse_scan_pmd()
>   `- collapse_huge_page()
>       `- __collapse_huge_page_swapin() -> fails!
> 
> As David suggested[1], this patch skips any such non-swap entries early.
> If a special marker is found, the scan is aborted immediately with the
> SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
> work.

Note that I suggested to skip all non-present entries except swap 
entries, which includes migration entries, hwpoisoned entries etc.

-- 
Cheers

David / dhildenb


