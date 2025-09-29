Return-Path: <linux-kernel+bounces-836170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BD1BA8EC9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DEF1896231
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB4E2FDC29;
	Mon, 29 Sep 2025 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfE83TzP"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D6A34BA48
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759143102; cv=none; b=CyJF/nObayVhxLUkx+dTOekhorkXWkLSt2d2BQ8EqrF0LsxWqQaUYTLGQkQqGHxLDU96SgbAqF7RXpE2/5OLR7UcykpSrKRubgkF1LmpkXDCySrj4EDdaHM02LWkj9YDrDM9iHd6ywtyN+ysZTEtU040tMtIbIzHdJUQZkatkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759143102; c=relaxed/simple;
	bh=LzEZ2/dhCjTWdQftkSSjdob7yAZT7nHLYi+hulrrV30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=szixCzdQslDAhzb59C93ljfaZqkxx152QF7AjmsdpL1rpXWdK2INoX0n7oqcpXImR7bOYQA+Oa1ys8n4x2apODJ4Myuwt3NY7a10K/tpH5wEa6GpPmFYBJCCRra1j8mUeRUS+WOcO2tv3T3fbBqfT1sD0wTQfdxFCTgImrxlAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfE83TzP; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eae48beaaso4460777a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759143100; x=1759747900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pQyMa9IZafjPV4fHO2pn7TEdK9WnUbPn3gYDAoIk10w=;
        b=gfE83TzPs6TmyrnYxLpp7bahvVoH/v6cnIxbK9jTjdz+BH/7cNj2rTSODtHwTJbLdT
         L/6nhgHcJ5QQWZhi7Gp+026vMmFu7Bso6v7/mTYujl3JjKrt8Ofyzyp+0dkHpxNNCqLu
         iLneWxG2QLiVTfrb1AuCg6PuSiqT6ltcCsw8fdYidenkCk7oGy1CuD2VY2e0ipzhW/QY
         qZx3AsafUR1dXglpatoAfPvt8XWQddSZKrgRKzxQVo5SNnFRup1W31awYR3bmRzi/p0z
         FcvtIyxKfvFoRnzbHiQqI08efaykXfPmuoOxoArE2yRo9EYpoEWGyw7+gs18/yOj68Qr
         5wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759143100; x=1759747900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pQyMa9IZafjPV4fHO2pn7TEdK9WnUbPn3gYDAoIk10w=;
        b=Hv4k7iGNwOs8dfCc8iFWdpX5Xt5FYpTqhGfbFYAENEqT6tkrT+A2Rti8r06MChwn3c
         5+CoNpHwE0+9T9W/8vvOw8DNSDGhp6ewkp/nIL1xk2cAZDgJhpD5yjaag/RgKyiq1aVs
         zZjuVFCdO4Rfm3D5rfC3/vw628qdgOgbUFbU1zcIO1/d6jHBA0osOIiN9AO9zbqT/1dQ
         7t0rGlEUjnHCs+mgSMertuPPnCasK6Y0NWZaiGQ45edbpvtXpo63ndqdPqd3BcxmtgFJ
         ORPiTPiaI9eDagknBxtOSvpJd87soLabkk6Rgwb2nEbCmlOsRbOOscQC50xruY8W0AJm
         c8+g==
X-Forwarded-Encrypted: i=1; AJvYcCUvy/4OyTuBlrV8Ts0zh14X+3QgFHoXz0kEDjzOafGnuUGaLIH2GzSEhM40zQVHGitwsBcFky2i7/f4774=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7i3mFOJwt1zKyzeHEck8sGTQsapx3bElQa/68PsP/r567/+8
	RdIEs6xMBLFzWH0HYeKQSBGNTpt888UQ5rOw+bXC/ezzWMoT6oJKyjhbTZ2RJ7B8lQLHtS2oJD6
	YIQ5d6buPSvuWOLg4ObIzJ+WABA==
X-Google-Smtp-Source: AGHT+IFxJJNxe7laPnxH4NpYyZ4avyYjDRc1ZldL5pKLhexm/Zv9qltc/dxoYUE4isWavpY6yHz7A+0cmp5pTsD8pQ==
X-Received: from pjbci3.prod.google.com ([2002:a17:90a:fc83:b0:330:62e1:cda6])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5548:b0:335:2bdc:1cfa with SMTP id 98e67ed59e1d1-3352bdc1ea4mr12877758a91.24.1759143100344;
 Mon, 29 Sep 2025 03:51:40 -0700 (PDT)
Date: Mon, 29 Sep 2025 10:51:39 +0000
In-Reply-To: <d2fa49af-112b-4de9-8c03-5f38618b1e57@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com> <20250926163114.2626257-2-seanjc@google.com>
 <CA+EHjTzdX8+MbsYOHAJn6Gkayfei-jE6Q_5HfZhnfwnMijmucw@mail.gmail.com>
 <diqz7bxh386h.fsf@google.com> <a4976f04-959d-48ae-9815-d192365bdcc6@linux.dev>
 <d2fa49af-112b-4de9-8c03-5f38618b1e57@redhat.com>
Message-ID: <diqz4isl351g.fsf@google.com>
Subject: Re: [PATCH 1/6] KVM: guest_memfd: Add DEFAULT_SHARED flag, reject
 user page faults if not set
From: Ackerley Tng <ackerleytng@google.com>
To: David Hildenbrand <david@redhat.com>, Patrick Roy <patrick.roy@linux.dev>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, shivankg@amd.com
Content-Type: text/plain; charset="UTF-8"

David Hildenbrand <david@redhat.com> writes:

>                           GUEST_MEMFD_FLAG_DEFAULT_SHARED;
>>>>
>>>> At least for now, GUEST_MEMFD_FLAG_DEFAULT_SHARED and
>>>> GUEST_MEMFD_FLAG_MMAP don't make sense without each other. Is it worth
>>>> checking for that, at least until we have in-place conversion? Having
>>>> only GUEST_MEMFD_FLAG_DEFAULT_SHARED set, but GUEST_MEMFD_FLAG_MMAP,
>>>> isn't a useful combination.
>>>>
>>>
>>> I think it's okay to have the two flags be orthogonal from the start.
>> 
>> I think I dimly remember someone at one of the guest_memfd syncs
>> bringing up a usecase for having a VMA even if all memory is private,
>> not for faulting anything in, but to do madvise or something? Maybe it
>> was the NUMA stuff? (+Shivank)
>
> Yes, that should be it. But we're never faulting in these pages, we only 
> need the VMA (for the time being, until there is the in-place conversion).
>

Yup, Sean's patch disables faulting if GUEST_MEMFD_FLAG_DEFAULT_SHARED
is not set, but mmap() is always enabled so madvise() still works.

Requiring GUEST_MEMFD_FLAG_DEFAULT_SHARED to be set together with
GUEST_MEMFD_FLAG_MMAP would still allow madvise() to work since
GUEST_MEMFD_FLAG_DEFAULT_SHARED only gates faulting.

To clarify, I'm still for making GUEST_MEMFD_FLAG_DEFAULT_SHARED
orthogonal to GUEST_MEMFD_FLAG_MMAP with no additional checks on top of
whatever's in this patch. :)

> -- 
> Cheers
>
> David / dhildenb

