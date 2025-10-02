Return-Path: <linux-kernel+bounces-840531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0ABB49F7
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A7593AB859
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA31D261B60;
	Thu,  2 Oct 2025 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gAyHH8Qr"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C1442A99
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424944; cv=none; b=gV/HD0euTH/SY/9dnSfT9Pb8uaz/ThUslf/ETTMAeCuchW3ajpbWKujrnm/VNRBawvziqZ0Zf/YDnXg1jCMLrVu5cCsKvJ9eoxFiN/DK1Z89Hn7fXzD3/u420MSIqDbGA/bDx6NE0BZhAdzCMAmLcySG8smoTtnVMRFRw9sFzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424944; c=relaxed/simple;
	bh=UosIEFOqEfLBW1M4HZQz2PsAAPsmXv6z/NJn78iqWTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tk/UB9gv49i0zT2XG0lN6j0QvINhatdkmpdha0stI76BfXQI4AjzbckIdyHDfdfKWNmajoTuAPgfjL39lrbKHCDSQ45OAtUOSqedJ0eXbPe7fsqirfXKMNnsrrOwMzA2WaWkRdR/Lnl2dzjwW8dmPLeW+IGOxIaw/ts5T24RkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gAyHH8Qr; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b3d21b18e8fso108645066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759424941; x=1760029741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+9vf4Jwiso9F3Y02vPP8NSYVqJvXagA/c4Pp2UKX20=;
        b=gAyHH8Qr41MZsrUgzXRQiyvPY4e+SoGF1bza+Y+jpcUmGeo8QC6MO2eKfOdMfa2j2b
         wB8l/fBJAm6hNGQ+qRCrmJQ/67pRrdMlgX8uovHoCrBG1jwPoXjS4tCmKy6Kcu9nMGSM
         PA+CNQ1zkQH6FovBAKhgs4bsi9/YXhzzoFuWXaHrSF1owjBI7dbgxs0I4HDszMbE+QNl
         K4XyEWaa0VSs1+zWydvtCAMvNyhZ0VT24rYrUYNAQS98Yh23y9ICbkciTi0/NT8Luuhs
         L0AgOpb9Y/YAvzYNpYd1UsgYzWUGm4iSgpMkIHzfyHURXLP+Tg7z8Cqu13n/XGb+ybLN
         A2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424941; x=1760029741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+9vf4Jwiso9F3Y02vPP8NSYVqJvXagA/c4Pp2UKX20=;
        b=VSDgFFUsGLEZ6Xnrd94zkxeQ1Hz9x1WXIGW6DkviUbkCRuM+J82JqN30b9QjULaVa3
         PosH6oz8VHxO6Lb+WNzQRokK5EEyYTO4fSRvv+4aBASJBzFHZ12dk8UGigEb/N3XgsIY
         tnZ0xzQvWz4HVR9/KYEYhTR/s3rg0pylUJsBZfhbz0mUY1J0pYOuG43H6Eoa4M23A4Zm
         Cjva41WlKsJyzWBImOImk8SiN4eBRs+xFKnYOK+O2OPTFXyzqBvljRrGiY+Ry7n/9iPp
         MMdMpz6pSZewoAWmPjhlHO0b2jb9uQqeW9jQt+YEpQQgHwMMDcprTX46mC1GT4ktyvar
         3ZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXjF9GahxqDy2mV4YmVIShHGvhd3lXwx0V4UeR1TdtLiqSJH9dYAk8gmIvfzvprZKktTSUtfdcG+APYA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC9+vd7W1MC6FPaGeH21TjkT5DJfPU8RCPIQYLyCP+dMhEwAQE
	dNle+99xa4PbNFyj0+/CeuCav+xRore8Gnb4QpO0EbCZ1gvOaCam8SRgUG8PvW6H4yBDKeIk06x
	HYgjN4vqi43pAXw==
X-Google-Smtp-Source: AGHT+IGKMxTwF3i3+/qTvA5h7gHpdu2tX1PHS/EAhbrLp6zU/xDFnlc2KHFRVhsXz5+haLREIW8oS2NfjBoTGQ==
X-Received: from ejdf14.prod.google.com ([2002:a17:906:84e:b0:b2f:99d7:b88d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f82:b0:b40:8954:a8bf with SMTP id a640c23a62f3a-b49c1b6d3cbmr20560166b.2.1759424940627;
 Thu, 02 Oct 2025 10:09:00 -0700 (PDT)
Date: Thu, 02 Oct 2025 17:08:59 +0000
In-Reply-To: <19e5012a-3c58-4696-9e4e-39e2b7d2b5af@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
 <20250924-b4-asi-page-alloc-v1-5-2d861768041f@google.com> <08338619-6aa1-4905-bdf8-bf1a90857307@intel.com>
 <DD7WQ97R8OG6.1CA5E2FU5ISMZ@google.com> <19e5012a-3c58-4696-9e4e-39e2b7d2b5af@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DD80374YZEWM.1L31D2VUKK80C@google.com>
Subject: Re: [PATCH 05/21] x86/mm/pat: mirror direct map changes to ASI
From: Brendan Jackman <jackmanb@google.com>
To: Dave Hansen <dave.hansen@intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: <peterz@infradead.org>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, 
	<mingo@redhat.com>, <tglx@linutronix.de>, <akpm@linux-foundation.org>, 
	<david@redhat.com>, <derkling@google.com>, <junaids@google.com>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <reijiw@google.com>, 
	<rientjes@google.com>, <rppt@kernel.org>, <vbabka@suse.cz>, <x86@kernel.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu Oct 2, 2025 at 4:40 PM UTC, Dave Hansen wrote:
> On 10/2/25 07:31, Brendan Jackman wrote:
> It's actually anything that has _PAGE_PRESENT in cpa->mask_set. There
> are a number of those. Some of them are irrelevant like the execmem
> code, but there are quite a few more that look troublesome outside of
> debugging environments.
>
>>> Also, could we try and make the nomenclature consistent? We've got
>>> "unrestricted direct map" and "asi_nonsensitive_pgd" being used (at
>>> least). Could the terminology be made more consistent?
>> 
>> Hm. It is actually consistent: "unrestricted" is a property of the
>> address space / execution context. "nonsensitive" is a property of the
>> memory. Nonsensitive memory is mapped into the unrestricted address
>> space. asi_nonsensitive_pgd isn't an address space we enter it's just a
>> holding area (like if we never actually pointed CR3 at init_mm.pgd but
>> just useed it as a source to clone from).
>> 
>> However.. just because it's consistent doesn't mean it's not confusing.
>> Do you think we should just squash these two words and call the whole
>> thing "nonsensitive"? I don't know if "nonsensitive address space" makes
>> much sense... Is it possible I can fix this by just adding more
>> comments?
>
> It makes sense to me that a "nonsensitive address space" would not map
> any sensitive data and that a "asi_nonsensitive_pgd" is the root of that
> address space.

OK, then it probably just sounds wrong to me because I'm steeped in the
current jargon. For v2 I'll try just dropping "[un]restricted".

>>>>  static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
>>>>  {
>>>>  	unsigned long numpages = cpa->numpages;
>>>> @@ -2007,6 +2033,8 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int primary)
>>>>  		if (!debug_pagealloc_enabled())
>>>>  			spin_lock(&cpa_lock);
>>>>  		ret = __change_page_attr(cpa, primary);
>>>> +		if (!ret)
>>>> +			ret = mirror_asi_direct_map(cpa, primary);
>>>>  		if (!debug_pagealloc_enabled())
>>>>  			spin_unlock(&cpa_lock);
>>>>  		if (ret)
>>>>
>>>
>>> Is cpa->pgd ever have any values other than NULL or init_mm->pgd? I
>>> didn't see anything in a quick grep.
>> 
>> It can also be efi_mm.pgd via sev_es_efi_map_ghcbs_cas().
>
> It would be _nice_ if the ASI exclusion wasn't so magic.
>
> Like, instead of hooking in to __change_page_attr_set_clr() and
> filtering on init_mm if we had the callers declare explicitly whether
> their changes get reflected into the ASI nonsensitive PGD.
>
> Maybe that looks like a new flag: CPA_DIRECT_MAP or something. Once you
> pass that flag in, the cpa code knows that you're working on init_mm.pgd
> and mirror_asi_direct_map() can look for *that* instead of init_mm.

Sounds good to me. If "The Direct Map" is a gonna be a special thing
then having it be a flag instead of a certain magic pgd_t * makes sense
to me. I'll try this out.

