Return-Path: <linux-kernel+bounces-887081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7144AC3739C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347CC3B8F12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830DB33858E;
	Wed,  5 Nov 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1KtziRg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESSXNzuu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998773321CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365161; cv=none; b=dDZZa1hT1nlx+UoTiT5y3KPO3cfJyUnb3XibNSlN0p9jQnqNG0ALJzrD+sY7jBO+TJKUkjdlMYVgiVOvFNXJmcVBqLDOeRN5WJG2CPMh9x1Lku9vRER/GRGjweNA2elvHrAziLL0F7T0Dog8gewFtIxxfvgXZ1bF41OiJK6aEm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365161; c=relaxed/simple;
	bh=qAO6sKLqJAuhuFMS0nTc5qL5SijD8xdb21cODc4sTyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtUwGxUBM32/E+GFMXpk+bW55Zjndh0NAsEOlh8zwbnknn7uhs0Zv7mJLpffBfED1MY7v+H+MFsI791fs4yLPJGGXhQMZun/c4N2SWq3nGxgWC7uyEb5/02UiA5+yaF1NnCH2CSiavRmeuR17we95M8i1H6j9jcaC3PsbVb1dkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1KtziRg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESSXNzuu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762365155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1/VwlemY7chU8yuS08ctMQeHC/LeJ5gQNjv4ZI2xH84=;
	b=Z1KtziRgN01EwD5KaIPzEnS60m+44WZoFnWIwb0IIofeGJ+7pdvwj6PfmcWbYnaqx4LRDo
	AdipBfdSw3ijwdzAllH1kPUWw4qBtu1JfOWz1QJIFjTUZobQkOgXrZ+sRgPh8aZQ72VClq
	TsaluBP/Wb3XCRkI94rt9lnGlBH540k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-RemtCCfeN-2HLbCqk36ujg-1; Wed, 05 Nov 2025 12:52:31 -0500
X-MC-Unique: RemtCCfeN-2HLbCqk36ujg-1
X-Mimecast-MFC-AGG-ID: RemtCCfeN-2HLbCqk36ujg_1762365151
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4773e108333so669225e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762365150; x=1762969950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/VwlemY7chU8yuS08ctMQeHC/LeJ5gQNjv4ZI2xH84=;
        b=ESSXNzuuKvNhvmUs2rS7hPI3A+hyXD6KaFawiF8R6BhTR2LJMVI5n/uI2bVaMer2j1
         RScMf8r8/Qckyt/1C3O2hoSpzCiCdIG63n5VVoXiJSiYiKPcXnfdTpRMrFdBINZEPtfm
         Lym1SfJ149emXXrDi3+z2UQU1VPv5uoA8kuVwyMkrnMwodoIriz/9nCxiN5IEJMbNfSN
         +Kb/rbn5/yoQb6liGOrEW27om/0JDnz2xWlHaQL6DpuEaHH+vtqmbbR3p6dlDOJcIQiu
         VN2x9HctXX9/xstYcFbAzEhGSOQKEhsbRHvHsXLwVmQMc1sHZeF8UyAyUeNIDhnUMRFJ
         8ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365150; x=1762969950;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/VwlemY7chU8yuS08ctMQeHC/LeJ5gQNjv4ZI2xH84=;
        b=GOk0KYB3WrmwV7o4gufWnokCyY/y7z/scPhOXGYJqKGkVkvdffAa5WwR0uak2ghqHs
         nOojydxV63wZeSTkXp05biF7E6jgWrN1120J0TFPR23AN0ZJCCizJRLE2obsfre7A/fY
         bwuTaBpkQuxFfVP+jgPWk77zPC4ga9OC9H/NcP+rYW7CNqhTAF7Da1NNTGBgZx0oKOoy
         fvxv13f3sfC6s/jTwoVHcnqOfSUMBSHdCboHy1ebGIAwIEiYgKr1XOOvSHBAtvydtTVv
         KcbTGbT65p9bxedhTSibvkOTgapdyf61hx4HKI2ekbog96FBVs8syQ2wFFZYtNGbMwDR
         ENFg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ3258PbrDFkoIPHfOdMqY4YboeMvloq31ISG79BQYBabnPPQGN5hFQ0DknZ4qonvW0b7eCAaUUdWCgyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7W6J0FE3SiKzTbgex9t3SjmqXDSECk/u51SiJzwOpy9S1vfJ
	0xuvKY8n/zcMmrAh80mRPIZlxBUOJn7LHLeus0EkzZ1ASF684z90CydodvaxzKwjeANkUbAw9Bx
	6Fi95u9jjjyzmfg4aC+IOXQdTDUU4jn/C5Fk0dChncGrqIZZKgKyO008Kr1mZ/ij6JQ==
X-Gm-Gg: ASbGncu/x/fWP/vrWE3jAGOgRqkdseDGgKa+9oiXkxCb1rw+WVzpj7JKODvm+Lbv/9O
	WFv5AmKNrCN9JItucKVltUiKlDuW5UuA+EIgRppLYJle1Upb81EmQdVo0ACIij8cMWBhn/JHSJW
	2lcrCjR9rKkesBgWvrmKnovvq1Rsrgf8sNO+aUmEIl823nDejm53v5ShUoFhCtP7tStyXEPmnWp
	B93jKnHQn9e7F4aaE4Nn7tNer9tRQh8VElznp2/48STr1COlP33GenG02PfejAB9ce5gYK0KGG4
	nPd96ts171OSPYaOjhqXR6eWM2TAdbGiVJotzbfBwsbko8jI1JY/RWEmcUHYV6k945JOFq9Q6tF
	KgyeaGcNKDHbOc4dQxAYS8jAh5OFNCmw29oBSry0VG9bLIxE2liC3voL/+4xrzbqkI7aCajceP/
	tz8rto8wWuuUaaSKN7qk0UA2c=
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr37489695e9.6.1762365150532;
        Wed, 05 Nov 2025 09:52:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/hxcE6W/i4TxLbbTb+RXUoGbnNDf+haHkh+i8Ym8sAzhoEf+Xhdsyx4l4V7qg7Ksy3FgPeg==
X-Received: by 2002:a05:600c:5403:b0:477:3543:3a3b with SMTP id 5b1f17b1804b1-4775cdad69fmr37489485e9.6.1762365150157;
        Wed, 05 Nov 2025 09:52:30 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce329a4sm60618105e9.14.2025.11.05.09.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 09:52:29 -0800 (PST)
Message-ID: <db8a72d8-a6af-4a0c-b571-050403371a7a@redhat.com>
Date: Wed, 5 Nov 2025 18:52:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] ksm: replace function unmerge_ksm_pages with
 break_ksm
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251105172756.167009-1-pedrodemargomes@gmail.com>
 <20251105172756.167009-4-pedrodemargomes@gmail.com>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <20251105172756.167009-4-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 18:27, Pedro Demarchi Gomes wrote:
> Function unmerge_ksm_pages() is unnecessary since now break_ksm() walks
> an address range. So replace it with break_ksm().
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

(make sure to not drop these when resending)

-- 
Cheers

David


