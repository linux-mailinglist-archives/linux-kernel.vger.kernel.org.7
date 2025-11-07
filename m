Return-Path: <linux-kernel+bounces-890774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D784AC40E62
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C6E0350575
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4118331A4A;
	Fri,  7 Nov 2025 16:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HY1jJp4k"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3630C61C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533276; cv=none; b=A5J3pQddSo0SzEvMkDXOOOk6SNOQeQF9H6TMKCssT1srHE9AD3gNER/jdiCuq4QgYToK/L25b8wTug9ZxGz+ScVV8BBtPh8OwGASNE9Z9z/xzBu9f74FaOo5Kgc26iORirAlAp3ujdXrNf3dMNiVLBAnnPF5zGySe1kILSfqFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533276; c=relaxed/simple;
	bh=d/47TYkjEMLXtX4t4ZX9yfnVLo6hbFvwaZrWlGu6Vyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l89jbuMwk32z5eTb8FbFlbUUqKgnMQ4j1MstXmfAVoUlpZsZaH1o+0za9hvJsdmeyMw2tHrWg4vxPcycGxTr1Q2WZFD8d7BOwO/zDc+wm9eAxxbDnKuTjJe654er9QSgSTrKNZciY2CRhv+obbbHOZ/+I1Cimh2S3uhErklQ5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HY1jJp4k; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso767095b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762533273; x=1763138073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JqLak/jfCX9SGb1FCs6K/y+jVBV6jjnaDsVxIe2L6n0=;
        b=HY1jJp4kkxlMl1XLdjiAPs56oxM/0hyu1F2tgy0NAPk3GUHQ4EaCQw+XIcC7toM/sb
         /pzX2ta5j2weLAcJ9O/ylmdYJ8gYpOWMXAuyphynkxfxGid9kFvSFT0NlFVQkJm6TghH
         TbeY7H3PhNo6jwUHeqNIf2QBFsMjpJBjMl0S2u+jMk0oAkO0jdl9xSefoQekgG4Bn9tp
         b3+LqL9H46Lds/TCPspbgc/JjOB9L6WhgcjEJRniSBgLJPq4LDk+iFzCsyhet86fouXr
         Osqdi6pXx5Y+DN/sSJOG3/7FYyzMbo/ymWzpDcqGcsq2C7bx1PjKnuQx8/LzhxPaAdF7
         i5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762533273; x=1763138073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqLak/jfCX9SGb1FCs6K/y+jVBV6jjnaDsVxIe2L6n0=;
        b=eObMFozB2JiA66qDeXISTMLetXWDBGWpNSZGWIJW8vmkkdu2nvWeTkgtQlnWCcfcND
         b+tjvptKH++5ucwZJVQ9k844T19JmF90eNG+gkLs8d6IHusO9+z/hBrYBnykNzgaTz7x
         PW70sjw5zKuwaIe04Iyl84DxAsS3f24B0OV3J4ZmtrpWl1Udi8ePp4/TR/9pd0fQfFUL
         +k6KVXcPLDuTw8SitKouf+0NEKVUZN8g3KwLnZ5/w4tv4/PIdnN3GJZo+W0cjDhIvU8V
         u+4sIV0lRx+/+CqfVVGf1LSrHiRSkMrIvwbP+6O2Y78y1O4wfsGcS0WEdoXQAS1M5zp6
         sbuA==
X-Forwarded-Encrypted: i=1; AJvYcCVWl2fvXf94RPGDScH/T9afNvnmgYDODW2XKW1wfP+kTb8Gjhh0qc8lUcFrNyScjnkjVEsxlUlR+V5t08Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4jO+YkiaEuHiOCNTsdeSwndAe4hLY7aYrD0/tOCB/6rLhbwOt
	XWi/c8zbwX+ANiuy9ldN09hPHVsT7KZI835S9r+62O8wL7Y6xUWyhC8B
X-Gm-Gg: ASbGncsB3GXr0J4vNXSfCYdWh3+hnP2GMhhrdy53xxI4rt050xRJ17sOXJpBpsuo99m
	8hbMI1tn0oA9of4nRb6OJFB3UIhnhI65yGuJYhG7w5eq66im9l6wqvUzUd7jm+Pt29mFUtGJ8/Z
	O51JP2ptTJRBsOhlhCMEXqxhGxjRjR96z9jZFXmp914gYpxV19enIFWAdeKiNzRTV3F/mFqPqIZ
	V3P4WbFw20HYF/ckEhOUQzc+R8alECskfHxhrx3hhOGFYT8nXOs7V7SESwfjGwZmPEsOXCkvuOX
	uZby/wyH5qTlvBZgE+nAeR4dtuObyLH9XPM6TxU8ELDNuNktKRtZCrvrUCf9YSDU6SiIlUzuiwL
	NLpgfQisyhqZ5H9nsc0UPgJLrA4Ggr1jPeR8AE7cG//5vQcPjUXoyNNe3iDtguKjR+XMdScrprc
	I2qjWUWnjU4/peWfWdC2gevhrPiSAjcgcnJT/ouGRz334=
X-Google-Smtp-Source: AGHT+IFnwQ/WImm/C+/qPggS8zhJNo1gfsDpe/BSoNdEd3IY9EjFMukzBP1w3IzjMAKSy446Tz7DtQ==
X-Received: by 2002:a05:6a00:94c4:b0:7ab:2fd6:5d42 with SMTP id d2e1a72fcca58-7b0bd5ad1abmr4812086b3a.16.1762533273200;
        Fri, 07 Nov 2025 08:34:33 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5a517sm3354317b3a.57.2025.11.07.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:34:32 -0800 (PST)
Date: Fri, 7 Nov 2025 08:34:29 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lance Yang <ioworker0@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>, Jan Kara <jack@suse.cz>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH Resend] mm: Refine __{pgd,p4d,pud,pmd,pte}_alloc_one_*()
 about HIGHMEM
Message-ID: <aQ4flRonlCygowKA@fedora>
References: <20251107095922.3106390-1-chenhuacai@loongson.cn>
 <20251107114455.59111-1-ioworker0@gmail.com>
 <f0efca40-aa3b-41ba-a8e4-c9595c19778e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0efca40-aa3b-41ba-a8e4-c9595c19778e@app.fastmail.com>

On Fri, Nov 07, 2025 at 01:50:06PM +0100, Arnd Bergmann wrote:
> On Fri, Nov 7, 2025, at 12:44, Lance Yang wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> > On Fri,  7 Nov 2025 17:59:22 +0800, Huacai Chen wrote:
> >> 
> >>   */
> >>  static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
> >>  {
> >> -	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL &
> >> -			~__GFP_HIGHMEM, 0);
> >> +	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0);
> >
> > I looked into the history and it seems you are right. This defensive pattern
> > was likely introduced by Vishal Moola in commit c787ae5[1].
> 
> Right, so not even so long ago, so we need to make sure we agree
> on a direction and don't send opposite patches in the name of
> cleanups.

I took a look, this patch is the direction we want to go :).

> > After this cleanup, would it make sense to add a BUILD_BUG_ON() somewhere
> > to check that __GFP_HIGHMEM is not present in GFP_PGTABLE_KERNEL and
> > GFP_PGTABLE_USER? This would prevent any future regression ;)
> >
> > Just a thought ...

In this case, I don't think the extra check is necessary. This is a
remnant of defensively converting callers to the ptdesc api from
get_free_pages() variants (which masks off GFP_HIGHMEM internally).
I doubt we'll ever be changing those macros to support highmem.

> I think we can go either way here, but I'd tend towards not
> adding more checks but instead removing any mention of __GFP_HIGHMEM
> that we can show is either pointless or can be avoided, with
> the goal of having only a small number of actual highmem
> allocations remaining in places we do care about (normal
> page cache, zram, possibly huge pages).

+1

I'm not familiar with which architectures use highmem or not, so
theres likely more cases like this patch that are remnants of the
ptdesc conversion.

git grep "pagetable_alloc.*GFP_HIGHMEM" shows at least 5 references
inline that can definitely be removed. I'll go ahead and clean those up,
but I'll leave the rest to people more familiar with the architectures.

