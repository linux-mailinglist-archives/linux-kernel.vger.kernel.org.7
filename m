Return-Path: <linux-kernel+bounces-887080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDF1C37399
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C0CC3A6B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3304D3328FF;
	Wed,  5 Nov 2025 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn6l5ujV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="stTszuMi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB03346BC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365141; cv=none; b=bJ7fBHdHVw48UxTYq73I93vSPK/LbC5783UV1edgLguF8SdqgkfAztk6bpONE9Zt4GLojy97TQ9tiXV3lQi+fzdYWU1GAeXbQ0e3q1O/a+/kBH1RngfYxTaEqUCANwjzMSAkJ6cTWDkCmAtvG2IakYmFOAfNwLnLFKh88TOHabk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365141; c=relaxed/simple;
	bh=GFA/SoCKJte+TY4BR1jlCSTL+wlK2FwfkRdHB61GmkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZEcjekxOlyCLp9UfdPaCnhycZmEm6tJWz5+mCm5j7Em19TadUgxhyXIFi4YxwFTOpJP+MewidbJ3/iIb1mYOCuovHh1Asl5+t0IG/2xc0soZCIOs7zjUR9bfk0htU8UOkC3uf3aRgJRfbK9Haw/sgtiuxzWJzqmYemyrXYIym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bn6l5ujV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=stTszuMi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762365134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22J/h+lLE1UxeOHhi0cAJU/qaxgcN4DGatLlI0jWwtY=;
	b=bn6l5ujVKtT86oyM5aTI1Srdfk93Kcya5c/URSLQPQ+E+ZBOvIS2rb2IxJ/rxcHxH9vp1d
	Ufdp42h05X1qWBc0efMad7roJPYt3GyOZoOVo3ROC6a7xm8GYZpqKAu4VJiMK4Wnb1b6uM
	YQPZHttOYUZDjRztWFGDLh/usyLlqTE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-WFeOMBTrOsW07ulYctYOZg-1; Wed, 05 Nov 2025 12:52:13 -0500
X-MC-Unique: WFeOMBTrOsW07ulYctYOZg-1
X-Mimecast-MFC-AGG-ID: WFeOMBTrOsW07ulYctYOZg_1762365132
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-477563a0c75so473245e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762365132; x=1762969932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=22J/h+lLE1UxeOHhi0cAJU/qaxgcN4DGatLlI0jWwtY=;
        b=stTszuMisofJDPEodkxvNXsgRu09DWPIb3GXTbSpXlbgsVXQZx+RuI4FyYYM2DblCL
         LmoUU63JZP/7tEDqsUoENTaKnTo49I0GaxAsv7KF/z27ZuLl2Jv+cwv0imN99wRQC+kU
         Mjhax5vCAhqKj1F007czVFFyYa6pw2NYM/uvos5xBidLcgLDLECxybIlKfdHNtk/4oIk
         0tZpxdYwwxikI5I4ONRIu6I/dPFan3gBnrLXDMosK0jBE2ag/kAuDp+0nwq95s6auGYr
         imtCzVcApuyYSki8TqToNElGQh3CpoT2Pz5Zsuk86oALwCPftJVuYEZZr01GWn84eToL
         l2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365132; x=1762969932;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22J/h+lLE1UxeOHhi0cAJU/qaxgcN4DGatLlI0jWwtY=;
        b=KHWoF7An781byttL7he3kXSYwS+FBlyrfcq/3KmnpRPS4KSJMXsl3KT1XbawpSEEJX
         DV73I+XvzqpLZw/DPdt2u4OtY7nUXij01EL0vx0/xJXD2j6WKxYknz6mPdXkhA+hM+PH
         MweFSN0aSieJGfMWy3IEs+VcTERhyEblVnZloyLQeMezPlnOn+7baOGsPsPvDZeLb2KG
         /76uEX8k7aOx4T70d0H2cKT5xBWdD65RvyoZx9QB5Lp8z9Ve7OufxUswzhINRbDS2R6D
         AgHXxYSacADBPjoWLD/kX+OkTLsEUujUdqzKnB2A+7LhUYETx1guICrhPw+olAFdyoSg
         wWXw==
X-Forwarded-Encrypted: i=1; AJvYcCUx/dK6dkP031j/RheHl0wArYq78emYvDZ7epyNPgHeXoCukvSFvY02EnQBV45IRFVftX2YcpRptKfHSMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3ZtT+DMSOmCJJMPuebTzFn1fogq6egUNYqYNZkR2R5ytXSVC
	AzA9G0lv7DKoz516O/R5Jv9AuagCTyz6SULxNZPYDKbZtN40bNWiV2+Z7hBIxf/bEWVacVbIc3n
	N3jHcDGookdraj2qLq45x9xs8m8Ys+GZE4tDsVJvkn8hFgivrZjRgQFpsFUIfjj/jDA==
X-Gm-Gg: ASbGnctF5zYmL+ORIJrsweHx1/iNI7fCmd+dK3E48zqn636FykSHNV8DuMRZOjo9oiQ
	gEqRs0b34defKwddyaPWl6LjL1e/x7N0TkGq6g8f8psfDrHWwFEiLm4Yb6iTUo91ndEXFh/n/rl
	BxcfaIj1JIvKLYa2a78Z1bgOhFVx/vyo2OBY8RN5qWvEnAjVqf6FaBYmIwsCMqRrF+/qk/HAKE2
	OcQDPJT/6ZtB/6hQRZqHDnwrENVsPIgsv7UN3TqX9fUKdrN6MF1csLY9p3TYk/h3TClUgGqgJZ/
	daUyPc+bQKBg1UhSA6LyArS19HnnQSv8Ng4+36FKIKSBXABV5CFW03cpm2mO8wblxxp9TmxJzFN
	xeKtFeidpzJPafj3y4Epyh9FuqGl/rfdIXmnPSS/v511EY2fFtkZF04UVZhKWrynf9mBlXQLmnM
	NyZJjzBlp1wkQhz0uH6v+Rf/E=
X-Received: by 2002:a05:600c:6388:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-4775ce1874bmr31530265e9.29.1762365131860;
        Wed, 05 Nov 2025 09:52:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoDD6xbgf1IJR1sJkj4i5jcg9ZQmi10dSKftCfvD4xCVv4EPQ4q7rEAGjS7V5F+bOGJZiydw==
X-Received: by 2002:a05:600c:6388:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-4775ce1874bmr31530145e9.29.1762365131454;
        Wed, 05 Nov 2025 09:52:11 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558b826bsm47438195e9.3.2025.11.05.09.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 09:52:10 -0800 (PST)
Message-ID: <63653e44-3a30-46e6-8a3e-f62d73f3f6a8@redhat.com>
Date: Wed, 5 Nov 2025 18:52:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] ksm: perform a range-walk in break_ksm
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251105172756.167009-1-pedrodemargomes@gmail.com>
 <20251105172756.167009-3-pedrodemargomes@gmail.com>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <20251105172756.167009-3-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> +			folio = vm_normal_folio(walk->vma, addr, pte);
> +		} else if (!pte_none(pte)) {
> +			swp_entry_t entry = pte_to_swp_entry(pte);
> +
> +			/*
> +			 * As KSM pages remain KSM pages until freed, no need to wait
> +			 * here for migration to end.
> +			 */
> +			if (is_migration_entry(entry))
> +				folio = pfn_swap_entry_folio(entry);
> +		}
> +		/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> +		found = (folio && folio_test_ksm(folio)) || (pte_present(pte)
> +			&& is_ksm_zero_pte(pte));

Same NIT as for previous patch.

Apart from that LGTM, thanks!

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David


