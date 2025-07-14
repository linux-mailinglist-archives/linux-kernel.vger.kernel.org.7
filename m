Return-Path: <linux-kernel+bounces-730654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE6CB0479F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF054E1C22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011FE277004;
	Mon, 14 Jul 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2WVxjyV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345C2749C9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 18:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519272; cv=none; b=h7JG6di5Yf3hpMELigx9x3uqywcr3+SGsfn5Ge1Unq/gfZZX0a22rzGgWwpA/Mn15eCX/D4Z+vFMIL7WSmDcwunzQlNIUIOuy6bDo5vFl3xeQ78WK+W8iTeFxNlcFEAokshgshp0n4c5Os8LSEZtdXGMJSwJGw6i0aPIyRSL3qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519272; c=relaxed/simple;
	bh=OZitEso82ct4GAcibltoJx58ufqyJW2gdlH85g0otZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Luq0nRXix4FSyA97bdJG42U6Ha/XnQsYpqJCBnH2/43xUvetNSqBiYv2Zz8Z4YNUVLUyO5mTw39X9+oc1WgqD+mFoS7y/l3zvsoFjGiKAU+rdjV0wP44U3AwyKD4PQfm03xxgvxZSBmB+9O05LNuFQ19J7iPhJ+SlNyUWa1eUZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2WVxjyV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752519269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ciLGAThMMREY2h/4HHyWdJ++xPniwYsASm//Au0nZ9I=;
	b=i2WVxjyVaG/JW4sAmE9/n34l4fLCQ7V0RV3RUjXrQbRdFFHY3tDTZRMW9PYZhVdXnQPUJm
	2eHeL0goAcbsqSVxRze8/bIwe74NBeaP3VKeqotX8H3s46phwfrL1pHDYYlbgvIxyJ841G
	gAtkj0UX9/jtIyR1ZF1k7tMctUQkdX4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-lyOkm3ZLPTOxW3RCbZ5Rgg-1; Mon, 14 Jul 2025 14:54:27 -0400
X-MC-Unique: lyOkm3ZLPTOxW3RCbZ5Rgg-1
X-Mimecast-MFC-AGG-ID: lyOkm3ZLPTOxW3RCbZ5Rgg_1752519267
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b39cc43f15so2564195f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752519267; x=1753124067;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ciLGAThMMREY2h/4HHyWdJ++xPniwYsASm//Au0nZ9I=;
        b=WhibVCesOEu0YGP47RORYFmrXuLGG81HSf8Z+VbPY6fx56SVGZtw6a5Kb1P8Bj7yuB
         B9Qi5i3vm/aCCa1qYQJOjgCquSN+Y14hDaK5n4MWBsfevla5Qz0wyA4e8L0+lN7YpQvV
         VHxPDVAwuATtbVCNMfzCtgWZW1CsaEAeFRQZhphAaTJ2FF93Aos6AKAbveEOZqmrg60l
         jR0/pTjdg6G1kx/qNro/kHCArNK+r6izFGTf5kRWnj9d+fw7kuSTqdzs7seRbwmgB1U2
         IlWsJ/DH3H1DlJ6/vtX2p0OXJ+Mz8RZMts7LJJY2h7aJUeweeMM3G494Vzf5mxd81A5p
         v59Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpMQEKEkCbrjPzqwxRph38CszCPEyWrvpEnif+QLgm4I2miYYiDy3Hkf8W7p39vcbsmhQ4xBDIq7+ylz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKtBlBaESfLMbgIx0rQyKsJBz3hmxPw+Kvffoa7GUrGUWCfnWJ
	phGfOtiOMK4smaSpXQlR2vC9XrEr8shppeh1UC+5Uzk59/6UoGndRWusBUilW7zPXPB48/wpu5D
	9Ff1ZYvpwFJlew0yCoUm74OMKGq6C0fD0nhY1xTd8CD5Xx5iVyB7rJqq0sXm65txXbw==
X-Gm-Gg: ASbGncvJIGm4pIb3Fp3eePN2e8428bT6W1TXxXjAxtVgSXRp8nZNaYm4q1sNSHCWvVF
	4V+4VeP+lVVI5n4mZrrDDnhpQkgbPNzuTBhzHsQRr8N+j1blhvKFjxoeTP5IBEAABoHX4D1Y2qj
	x0z5d055/tIopTL3AUYADAR4xq/3lejP4Ygx06q7xn7+k9B7b5Hy/igPDv2itdijWPcmKKJRNC9
	vdg75qBScI7pu1M5vzsmD/FIseHcIrs+4tRM0bJN6yGFFRsVhfq0gf7QmaavAwAINb7ip8oejWS
	SuP468mLsEezO+qgcxv3a4472dstm0VRRmpdC8U55c3dFq6hB3Am5fmYrLG2wYt8echy/C9LVes
	cJELhLPhdl+7EYiK0eiczM+vIh00LGL8kLFUk0czI9sdKB7nsb7pAaY03KRUsck+j
X-Received: by 2002:a05:6000:26cc:b0:3a4:efbb:6df3 with SMTP id ffacd0b85a97d-3b5f187d0b9mr12000718f8f.10.1752519266648;
        Mon, 14 Jul 2025 11:54:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaJJiTeODy/grE9uQG0AvoTZwYowHnLLNyNVEuR0M74Pw9NACBs4EqhO55dJs77Vh3QS8gQA==
X-Received: by 2002:a05:6000:26cc:b0:3a4:efbb:6df3 with SMTP id ffacd0b85a97d-3b5f187d0b9mr12000706f8f.10.1752519266254;
        Mon, 14 Jul 2025 11:54:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd466154sm138407125e9.12.2025.07.14.11.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 11:54:25 -0700 (PDT)
Message-ID: <4e02afc2-3429-412f-9fb0-d15cbb30c6fa@redhat.com>
Date: Mon, 14 Jul 2025 20:54:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
To: Zi Yan <ziy@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250714171823.3626213-1-ziy@nvidia.com>
 <20250714171823.3626213-2-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <20250714171823.3626213-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 19:18, Zi Yan wrote:
> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
> splitting unmapped folio operations. Move them out to the caller so that
> __split_unmapped_folio() only handles unmapped folio splits. This makes
> __split_unmapped_folio() reusable.
> 
> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: Balbir Singh <balbirs@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


