Return-Path: <linux-kernel+bounces-723561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6285AFE87B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECDD6E212E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427102D8796;
	Wed,  9 Jul 2025 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1D5Iv2I"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE772853F2;
	Wed,  9 Jul 2025 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062349; cv=none; b=KKwqkegvRjkYNOXAMDMCgeHtTB60AUm9T1mOk0gUVexVfY+9TfXlyL4MEnTEUvQeuZNL8axgUZUr0eaNhS2dSsg8wFJ3mWe5aTG2nU938YdLQO/d4zKRkcvZfJC8915dw+HfPZAUdQSnzLekL+v0uCiip0cFsbBqKs1FiECXfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062349; c=relaxed/simple;
	bh=bgR5awQX0vKasE3O7EHtXSFXPFtLWKVOsswzgDdWlbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZDsaewGaPXw+lqr2PF4DK3oq2hJEyMT99xTOTeMbFbEDPB6hO0DsELlWy/LXKS75dK8xAEIktKN/KJvfuNB5lOLKqriwKFGsU+h/LvPFuOYiUxD+k1IA4+GoLS6KMtGBFBx8FB3itAyvAj4aGR4y+yemURIR4/eTryb4Z8I5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1D5Iv2I; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553dceb342aso4822269e87.1;
        Wed, 09 Jul 2025 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752062345; x=1752667145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cok7uU2jUvW7fnecoEr7WpQIhsCNVnn9HvuxNqMoKcs=;
        b=I1D5Iv2I1T4dGkV2tzZaRRzzfdEF54JDCjsaY57SSXNtV1KpG6n6YfXhH/9cXuLzDE
         a/8uaL37pqVRIuOuQIDaHqquKBeIPxFq4raEErRmAKFwFEBY4cpN40TtAgqDv3/YVJ+t
         xyfbwBaKMfHHG71ZFZCh1WGMh5vM8MiK3JHpfsQsVyckcy+yoOlUdAB4UTYYIKurOTdA
         bSs1XDrCxIzR+I8fgwkkHXXD+IuozNqLcGhxqGVMpNfnOsboEMvFVVECec79ZTTJzwDo
         ksxYrzQqCw/xUimavoAI1iEYM+qyqzW4ilzFIo+bQzFXzbZ5ZIxgB++73LJ7BWmKGZ/2
         yuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752062345; x=1752667145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cok7uU2jUvW7fnecoEr7WpQIhsCNVnn9HvuxNqMoKcs=;
        b=SQ8iuAtNsGA/mqOIhBX8ipFBKcncu/H4GWlOGNzHs1Nvyw6XdtVmYcZH5vekVzDQqe
         CG3yvJ88e5FltYSk9Fx7o8O2B3qxqNJompX1gXmE0hAhNTL4otUyz6Ttjr0e7i0g4Pgx
         SKAljt+3KpdYJi05RxoxC4VtJ0jFVnTq5ynR8gRVXTmC86UTrdfuliBn4oI3v9yT5IHL
         MVBnuajRqBCIJz0T9J8CDT9+XBSFqsL2tnkaBdNOh2h2tNGoC0chSB6AISzo1OxBhlhX
         +fLWW+/6srjXLikcRxbbWTF0G3AbKSa+201Gi21aULiBwxDIdeJRfblzu8EB15tsluNG
         f+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Xg5wgh8xmoF8aY2zTqA6uPaswmMTHWSFKxGI1BoRmwthVSFFUHlR85uDhfz8jnO26sRh7HEnto9EInR4UdU=@vger.kernel.org, AJvYcCXa+01+isGvDJAsNabG0TIhzqQHX2+vrhBnjtT99OgsvLJ3w0rVg2BRxMalIWEVLRIZeYDhiCuTkuOBVDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+ClSfbOauFecGSvqqVHSzWSzVYuXoDnKcxS0qTIDJq1ItriL
	chrXv1g5h1LMKGkqXXRm+ScNerhVOlgzZTwBt/0D2vTkbpTFuOC/zBJM
X-Gm-Gg: ASbGnct41XFteylh++nkr2diLpYhXASqfDTMcCZ1L9J/e3tIG1jlMh+VGHr6RpCJ6z6
	9X3PYj0gD24563sSzZF8IDHtRY7LWzVyjWuw5hlR4LL3i7KJSjZmamofAKiwTg1TSIfqidZI7BS
	70ZCQmnQhEacDjPKPnQC1caKB5Tu/ysmDeRRBKBj1P67cWXxKwAzI9WRsEOWciJKTde9fL3sVBe
	pbN+5d/uWKIuGP7Gcq1tMAkNL6TuQBvmN0QQtFZT4JP9l5gx4Y/OWTsSYvs5w2dasIw3Iy/r7f5
	PdzMUf0HOlEIDSULiZHsG1Ag4cRo/kxK38ncR7KUXQbftkIEuTllsrvk5NDxDGbe1eZ42BD0ycA
	kuwAzaeCv0Paq8l07UaE7Bvb5mX6jpJpYGcNpoLfX3mZ2jJls5A==
X-Google-Smtp-Source: AGHT+IFC8/vApe5HFeNaNKqi+jWCcD3kQruu4TovfGc8AxarPCJVnGOQYHuNec4peOG7S/XWGGoTrA==
X-Received: by 2002:a05:6512:3f0b:b0:553:2e27:6769 with SMTP id 2adb3069b0e04-558fa86e7cfmr643645e87.7.1752062344958;
        Wed, 09 Jul 2025 04:59:04 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384c8c42sm1981269e87.237.2025.07.09.04.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 04:59:04 -0700 (PDT)
Message-ID: <0206a7fa-ce7f-46af-8f1d-f9dedbb0a3d8@gmail.com>
Date: Wed, 9 Jul 2025 14:59:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: add initial scatterlist bindings
To: Alexandre Courbot <acourbot@nvidia.com>, jgg@ziepe.ca, lyude@redhat.com,
 dakr@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 rust-for-linux@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Petr Tesarik <petr@tesarici.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Sui Jingfeng <sui.jingfeng@linux.dev>, Randy Dunlap <rdunlap@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>
References: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
 <20250626203247.816273-2-abdiel.janulgue@gmail.com>
 <DAZQ9OGC1648.2WWABTO7A7UU6@nvidia.com>
 <DAZVUN9N4GBT.38B6BX4CN516F@nvidia.com>
 <DB17XMDHU5M7.2M2KN9A8TJQOB@nvidia.com>
 <DB288AEQSBTC.63WK79TB77TW@nvidia.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <DB288AEQSBTC.63WK79TB77TW@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 03/07/2025 10:03, Alexandre Courbot wrote:
> On Wed Jul 2, 2025 at 11:37 AM JST, Alexandre Courbot wrote:
>> Thoughts? If Abdiel is comfortable with this I can submit a v3 with this design
>> for review (putting myself as co-developer), on which Abdiel could then keep
>> iterating, as I suspect this would be easier to understand than this long email
>> :).
> 
> Figured I could just as well share the code with you and save both of us
> some time. ^_^;
> 
> The top commit of this branch contains the proposal discussed:
> 
> https://github.com/Gnurou/linux/tree/scatterlists
> 
> The sample code has been updated to add dummy examples for the 3
> use-cases discussed (reference to an existing `sg_table`, refcounted
> reference, and owned data).
> 
> There are still things missing, including the typestate on `SGEntry`, as
> it wasn't necessary to demonstrate the basic idea.
> 
> Note also that if we decide to only support DMA-mapped SG-entries, we
> can remove a bunch of code, including the one that maps a `SGTable` if
> the backing type implements `BorrowMut`.
> 
> For your consideration. :) Please feel free to take and use anything you
> find useful.

Sorry for the delay, just came back from a week vacation.

Regarding your question regarding why I dropped type-state, I thought 
the general consensus here is to drop this approach:

https://lore.kernel.org/lkml/DAC20AXGABW2.X147X4JPMRBS@nvidia.com/

I think I might have misunderstood after re-reading it now. What you 
probably meant was to have no intermediate state from initialized to 
mapped to create the sg_table?

Anyways, thanks for the code above I'll look into this in detail and 
pick bits to integrate into v3 :)

/Abdiel


