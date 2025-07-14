Return-Path: <linux-kernel+bounces-730256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B316B041FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF0F188FD96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE12561AE;
	Mon, 14 Jul 2025 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feRvCEln"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A92C246BD3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504007; cv=none; b=mS2iyGc6X8w8t9DfxN1pYluK2Bpo9s5TvGcyrrx5zgOVkvf3BmQ35dTzwL59DuAOOJ6kLTE4W8qdJqQWGdVXo56HcPxJ/LIzXR36NxAZTA9orrL5/r5Sx8yCAQvBHWe+MgJLTu6rULYpaQXwTth0vlYorR+dHjWfswgnaMhl1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504007; c=relaxed/simple;
	bh=oyfvGg2DL1aFHhuyCBMaTIMnV2Guv0J8oJJm/jU6KS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jmKdANkAQiBnPMLoAyemxRs+ugpMa3CawTST6p7ZwBnC8HESDLjvkGqcwWJvuu1A4kW6AZz9uwDPxmjqjF83zyz5aMnt5kpXA0J3gIuXl92R/x5lEqOBO8tf3QDtUM3c8tfpAiU8TU0tMn2Q2xwUYi9eNRrnMWbgyqP2/RsZ6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=feRvCEln; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752504005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZLxa33erWQTN3e570HsEbSf87tz27RP18qPQR0Fz2Q=;
	b=feRvCEln+8vnYleYGWVJXIHtWtGdinRRVFDWXAw9BMR2LKY2UNUG1k8HtJriLg5mndhm5d
	2uGYXlQgGSJHk3sxf/Gzd5xi/NxMNJRGYHRR7jSkGK6bZmCRwILIHI2EKDI/A6gPo2cEOE
	bqk6rDf9mbTlExrxTwcV6qMaUC304vI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-pwo0fv9uNpqWxwPSQwwH6g-1; Mon, 14 Jul 2025 10:40:02 -0400
X-MC-Unique: pwo0fv9uNpqWxwPSQwwH6g-1
X-Mimecast-MFC-AGG-ID: pwo0fv9uNpqWxwPSQwwH6g_1752504002
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-455e918d690so13837025e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504001; x=1753108801;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZLxa33erWQTN3e570HsEbSf87tz27RP18qPQR0Fz2Q=;
        b=DyopU1KpiepZRTDQT7ntO/HXi2n8xWNnEoyMGt9cbiupd98BD/DWD4drGaZ0W2egAY
         pHqAoQtPTn6i/4Ak4MFIIxg0mWwiGPvqu3RPHuI2ImL0PmJgng0hSD1fjzZKvBsVhH+1
         0IBL4GAQKFJl110cKxdALIbUFeW9g+qQP5LuByFjY/IG2z8Wj9dLm0FbxqeYS91CAJhC
         IB907yH3XfvsMn0bYYzMAFA5ovVrUPaJEpOuVgpICvIUCYS6EtvzbDbMvGWFL0r7NTWM
         HcdcneyPjZFqw5A5USIz53LyKYJmCvBha55P63aMRKoalbo3jGjgVNfgodr+HfY9p32n
         uIqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbAJPI2CFxjg7p28/zxYUPZglnuojwpP6RuLuCcyxHKDV83Weh6goRVdoUezWNj8VFqAPoJ5PURTb20O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykeY407t9MlYZjnx0jOC5OlnR2s2nPRf8ACZGtl84N/xDxyCtS
	8bX6MbhNguG/52JwQ7yraLc0mw+mGq3HUtMLFfxghgRhxD7FVizbrmr5y+FtaKFYXU9VzUHTnVM
	Vc5o7HsRHO3NrYG2yfGbEQeQKRKw3zS1Bde0wMijAIJ51O5j98Ujuzyck+t+wPDylNA==
X-Gm-Gg: ASbGnctDV7AJ8pqe5yzJ5oYYCBAejNk8xop9e79wEw3jTbnn1fike3nWcJgt7U6cmPk
	GzNr9QkHvCThCTevLu2SbkXu9w+NHZQTGbyAsTsyFmWAP/T71pNE2kGUuQbTHD7Gwj4Vo4hIihk
	2vrz22uyfhYq15i6pm8FXSzqv8Da3fiW2MJqjYsg7uwSMI3/HE5KKEFPg8eoZoZBLx1QtNJGuxb
	q7Mmw+NhYjepxPwUgVtiY8lbkq3y6uyGVCYNmOqt1P/THU8DFtf1WBTkKpFAzDXb+SiCf378kzR
	+5SKuEuO2VnI/rezipcLbc57/m/46Z2DCgPC+/nNzU6gs1Bxj6O1+jb+QoLKHTSh7VGhcDF9EYz
	6G3TgMvUd3GMBo9MZA4wLIzv4oh5hI0dmxL2FWqSSK8MvIA1OHw+zQado0Sf1Q0uZ
X-Received: by 2002:a05:600c:46ce:b0:456:21f4:a0a3 with SMTP id 5b1f17b1804b1-45621f4a239mr19332445e9.5.1752504001519;
        Mon, 14 Jul 2025 07:40:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0eMROROoQTHA6Typm5AVxcQMCystkOVfLcE8YYkqQ3/u8zaJ82I+Y7a8SVMD5WD76QbN18w==
X-Received: by 2002:a05:600c:46ce:b0:456:21f4:a0a3 with SMTP id 5b1f17b1804b1-45621f4a239mr19332115e9.5.1752504001092;
        Mon, 14 Jul 2025 07:40:01 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5053725sm177245925e9.16.2025.07.14.07.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:40:00 -0700 (PDT)
Message-ID: <c9c8de37-278b-4d73-97d2-869a7aab3ba3@redhat.com>
Date: Mon, 14 Jul 2025 16:39:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm/mseal: small cleanups
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <4df6b55c407b5e6890429d4d7cc39e8f28948975.1752497324.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <4df6b55c407b5e6890429d4d7cc39e8f28948975.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 15:00, Lorenzo Stoakes wrote:
> Drop the wholly unnecessary set_vma_sealed() and vma_is_sealed() helpers
> which are used only once, and place VMA_ITERATOR() declarations in the
> correct place.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


