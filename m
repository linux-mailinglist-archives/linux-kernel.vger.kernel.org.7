Return-Path: <linux-kernel+bounces-888919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B69F2C3C3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38BAC1A47AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3BD34A797;
	Thu,  6 Nov 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="dYB09okS"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863A34B1B8
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445199; cv=none; b=jtpTcIvKFHodSC4lmxi3f5oJHOIIkdQ9nkA/KYY8xaoRQdVPd8sR3BLApst/95+GJFay5vwwRZJ4kQdUKwiHYKIPYsjda0Lzg7G5yC1gJmIdFLL6QMXAlMvCg37PGtB5onD7KfsZJLvqj0FfUqYK7hbNB8GOmiZ1S0g6Til8oQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445199; c=relaxed/simple;
	bh=t9SJynQEAxXwDz665Hktn0v/w6F828+jFZpWD9D6oRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU8aE3wKqNuiJP5HRpYBZiwLg4kCyUdZ/OT4vL6HvPrciyN6YlwrGTAQ/00fPErzhLgM917DzD0e8jeaScvmXm/wBOWAzK2W2JEz8IMHWCyeEfNGphmwy+dEWVAJMb/Lbcv0vXvHU1F9jaZxq29EIqVkpW5jsM+fsg7ZmDoPAjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=dYB09okS; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-880570bdef8so13539766d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762445197; x=1763049997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qlags31RcfCKvG92vgNW4kmUAWjqVO/1QLHXyW672fQ=;
        b=dYB09okSUPYRKgrlsW5eiI6X/dgKOeYlLoJQ5F68FrAc6OBckYrwbr73i0oTBktwE4
         kDByjnvaIbLHWSBcmjdEit7lnhMkcfE1hN9vIUGzw1oDfrZlI1wXToXvZUSXlG4KmiZq
         XNA8SbsJO+M0xe3shj9hgBr2m2Pd5M1v4d9yLVNf7xAB2W75JQJQ2ArfZ9k5q7lxivrw
         BJZ+BFdJIcXxWcL0fbi1ST1ylbEGNPk+bW4DpdLmHTy2xphT3gUHSK2KMzzskOkM0yHJ
         S689mmElHUPL8P7OOhqiPFd4gy4Ia55zBOjgvOweRFIqt5k1tner2RqB9M+nT0szhyOD
         YdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445197; x=1763049997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qlags31RcfCKvG92vgNW4kmUAWjqVO/1QLHXyW672fQ=;
        b=UcO5BOgkPt7JnCA91B6mYCKzupQBxUOxFMEsiUe+UTj01WMhSq8ShQgSFDUAUI9IhM
         k8wc7s7HYGqBxJ1vYZPNPXUrdG1sMtleDEVqZ29oZEgMjKc2WPdzcLM/2fm6RQ2RgtmN
         nO8hvP7HuLuJw6wgBcPGPPsRZKPKutfOa1a2lvXMstOS6Rnsl3SQszecRVyNAM62JC/U
         YO/A65qlXHiw+63ljZXzimFv2drxrJVjTr2+VpqtVEn4GU/LLJHGP+7vQm20qYsNWcRV
         rzTurw7s/gg49AkFnNtCaVdR8q8iQPD1EQR2ve1gBVMNelI/6VwxnVghLMybVmosOzWh
         0chQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2a2FDOzK8IJycgTeESNv0G9kLuiYvekkKPf+yO/VomyD+kfLbfOwE5tX0MwM2ahJRwfCCw+SmaX0yUTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xSaSHrcVnrjg0RhQ3mcEiG4rNkTsH6H5kyvDSOu+83wNafKD
	C6tlsfZiGMkAytsQ1A+oIboRLl89GARNZ5FpOT82ykXmcReMpBnuWCjOBEMgEm0I4BU=
X-Gm-Gg: ASbGncsLaC2vpoUQhzMu/ygWyu8j//eg2nKtjmNJfWi88JIRlP3gnmDTRTxw2Jwee/L
	728896H8H3k2Ch1EFjySeygOkwVN//kFFfUE1ZmQ0blpacc/go8+/nBnjU5tuBDgA7aZgII9XOW
	TlyR01v3p4VnT4biO3n+yfYo2RIOML/7DFK0Xqvhs/46Ho3LMkUc6PUQimNy45h3uHGbOBjqPet
	dWZvqdRpl+cmsQvx7E6Jf4e9F4D/zInnbqM5Xz47lwsuhJ5lYDQc/Fvco/+NSNuuMselgQZJ6Ak
	I0ITyNZPvGPZTlySt47JhkCTYaauzaAeXTabOskN7sTE3hwfiPgWnUyaHkcCnZNBYk+0Y5ryMwH
	Nkr2GcmUcMRk7EFo2Im25PxucUnxjvHbj1knOZ7GQdyQ+BMEzZ4/P/6fJ2Xpt4Hv0kvBov2idOy
	rtqiQA9+tYVMOZ1ncgHf3zbE9IFzeHNelB0E2KapbPlV4RIq+lj4/gb1cOfHk=
X-Google-Smtp-Source: AGHT+IHsSxe5JOoiqI22nTLPJo6OLJlkjEqsT6Afcf91+ImeIdz/5SsDaK9sk7rEW7EEqspIerIC6g==
X-Received: by 2002:a05:6214:2243:b0:87c:29c4:4bec with SMTP id 6a1803df08f44-88071188f19mr107210016d6.54.1762445196690;
        Thu, 06 Nov 2025 08:06:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm21241056d6.56.2025.11.06.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:06:36 -0800 (PST)
Date: Thu, 6 Nov 2025 11:06:33 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v3] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <aQzHibKYKy0SQU1z@gourry-fedora-PF4VCD3F>
References: <20251024192849.2765667-1-gourry@gourry.net>
 <2de17512-3df3-4ee4-9912-8a8f7ca5b648@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de17512-3df3-4ee4-9912-8a8f7ca5b648@redhat.com>

On Mon, Oct 27, 2025 at 04:43:25PM +0100, David Hildenbrand wrote:
> On 24.10.25 21:28, Gregory Price wrote:
> > We presently skip regions with hugepages entirely when trying to do
> > contiguous page allocation.  Instead, if hugepage migration is enabled,
> > consider regions with hugepages smaller than the target contiguous
> > allocation request as valid targets for allocation.
> > 
> > isolate_migrate_pages_block() already expects requests with hugepages
> > to originate from alloc_contig, and hugetlb code also does a migratable
> > check when isolating in folio_isolate_hugetlb().
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> > ---
> 
> Nit: trailing "." in subject
> 
> Acked-by: David Hildenbrand <david@redhat.com>
>

Hi David,

Do you think i should just staple these commits together at this point?

https://lore.kernel.org/linux-mm/20251009161515.422292-1-gourry@gourry.net/

If not i'll drop the '.' and just resubmit this with tags and just
update the commit message on movable_gigantic_pages to reference this
commit and your notes from there.

~Gregory

