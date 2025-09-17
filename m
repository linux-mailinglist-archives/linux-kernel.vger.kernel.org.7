Return-Path: <linux-kernel+bounces-820682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F1BB7DD29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45097A3D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270C018FDBD;
	Wed, 17 Sep 2025 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6d3KpTU"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282EE337E8A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112496; cv=none; b=kg1T0euqU9CpPIV2Lp+zBmZF7Yp0eKe85nZqt6O6H9xi2jxAcEiaGQxhiGLH9G+1IKE4IZwS0x7kzC8f4CxVRPTvMBme+5eKE1J+VVNMSLvKFAibTjkcX6cVmaRFzgvPNpwAyOSZAW6Fb03TpMsiuiOxn1KfKKoNvac/ZmcAAkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112496; c=relaxed/simple;
	bh=dIHZ2ja5BcqyFYZHTMC9NB4DPw2yeBGuLWIA863z9c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0edUgYOs1aD4v3zhy9bZiv/OTzFSvKdodh8W19MPRNEcQYGln/Uet+/sjVTgsWd8D0v9w5Y7VQrBq+Y+JeP/LkSNNsWjkSgRjvSj76skQ5+0E2XukByRP4jeTxHMNR+TeWrEtifm0sF6+VTUpNvxbpihTR89aAKouoRceHoafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6d3KpTU; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so5337499b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758112494; x=1758717294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=utS8lVVKosLlcozLvz8gzAcyDlCOQkj/lxegrEe9iDQ=;
        b=E6d3KpTUeJysKM4pzb8m0yv/z2EQ222aW7cv5V9dICRWdW8a5jshxgT/DS1a9x9+g5
         5rQ6AF//a9cfADYms5s/lVT4MZkfWA4p91SOR0v5MEgr1fo/Eo/GHFkDOMpKWWEfweEU
         aeYhuvKKVq7aGyTXxu7nGaU8hQ5oY2HGScnbGKSMHVSVirVOzI3iN3dg/c7ttJwocATZ
         u6gajZ1kKxdRzcI0HAaoSaGnlUwQPAoAwWVdA21N7BxuWLRTnwxZn3i7yNiPon1CSvT/
         VYP/IJhKcEzHa3lAiK4FUpga9EXIvb4At24JaJ8c7R2WWFztw51qKtgRUQBVSWh9OlLM
         rMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758112494; x=1758717294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=utS8lVVKosLlcozLvz8gzAcyDlCOQkj/lxegrEe9iDQ=;
        b=qVsnf01nFZEY19XXWIbCbYXJBbGQClyflccN7j3c7I0hx6HWwSC1l1+WXohyanCpyO
         LuvwfIwwaWgedLzz8JFjpAhjaP733SlD58A8BTdXtL2eO7fvQuqZp2r7LZdlNvBCzG/7
         Zym1sra+/ITKtNW8LIkG5LIhfN8oj/3oFWdIp45S9kEE24pGn4yf/C64LcjNmQph0tuk
         NtTzh8rA5NbCce5t/qbBRZOLc8Vl0uBC/A0GrQReL/qJ3TS6Zqsv00T2H6DGdezDKTqy
         QXw8g9mwaiVzfnOruHRqFpK6QQOJmpH/3BG/0/fPuIkTRdgvDDxAO6Z4Cz6s6Dr+OwLT
         ljrw==
X-Gm-Message-State: AOJu0Yw1VDktUuM9xkIE89IjHqF5K0uAqdLpW/x8tJpivev74JyHop9I
	BWkcy1XpkxPjBzukKQxy8HWCs1SbKw3A6o5ldo7ZJ5gRJY7hf+agUuZv
X-Gm-Gg: ASbGncu4Hh1+oDqZ3v/BpSA6KPXxaqAZSyOlxQ/FqGdmxZuT6VVVmjJIKRgXi8+pOmk
	pjohuE/UtgBgOyBw3vROdt20EEYN+vk1KhgV70hPKifEaSGtH1PYC6ffbt0/yM9W0RfTh6WSniM
	Rquzj7HW6cV6VMIXeUxJkVGRSY3QVPRusDSG6XHe4Mfj3T8XJ8Bhs8LENQTSwdqy8V5kXwi1cNP
	X2f4K1tFj3s7GCIGxjPaE06a5bH1bnnutiwiCSkmv7zZN5dBHVHobwFpdHwNTvCJ1vee/xKstmI
	vXkcaKc0weLVTMsVFMvP5Xn6SW4oA27ERZBSKDuwAGy09eRoQyhsCpdLA2228x8y6Xwo4m2+ano
	J5ppI4YvhTAYJ9VIKePAsFQ==
X-Google-Smtp-Source: AGHT+IGeKFbSBQzcjeErNPgTvys2M7mfX8aKe2x/3shc2eZK33DqdVGYJdaiODyVtgcaSRi+Kz/18A==
X-Received: by 2002:a05:6a00:a589:b0:772:553:934b with SMTP id d2e1a72fcca58-77bf9e4b797mr2202682b3a.31.1758112494267;
        Wed, 17 Sep 2025 05:34:54 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77b794f627esm2565787b3a.53.2025.09.17.05.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 05:34:53 -0700 (PDT)
Date: Wed, 17 Sep 2025 08:34:51 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
Message-ID: <aMqq6zr7_dJveu3o@yury>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-19-gmonaco@redhat.com>
 <aMg5EzmxG3hG7aJK@yury>
 <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com>
 <aMhcYCCJDFWoxcyw@yury>
 <aMlJqDjWNyak07LX@localhost.localdomain>
 <6aeda48661359eedd232c9bb0c337d93c36dae70.camel@redhat.com>
 <aMqdzQcwvkjl5WNA@yury>
 <1d15af4ab9f8f63dafbf4810a76eb3d547217596.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d15af4ab9f8f63dafbf4810a76eb3d547217596.camel@redhat.com>

On Wed, Sep 17, 2025 at 02:08:06PM +0200, Gabriele Monaco wrote:
> On Wed, 2025-09-17 at 07:38 -0400, Yury Norov wrote:
> > On Wed, Sep 17, 2025 at 09:51:47AM +0200, Gabriele Monaco wrote:
> > > According to what I can understand from the standard, the C list
> > > initialisation sets to the default value (e.g. 0) all elements not
> > > present in the initialiser. Since in {} no element is present, {}
> > > is not a no-op but it initialises the entire cpumask to 0.
> > > 
> > > Am I missing your original intent here?
> > > It doesn't look like a big price to pay, but I'd still reword the
> > > sentence to something like:
> > > "and a valid struct initializer when CPUMASK_OFFSTACK is disabled."
> > 
> > The full quote is:
> > 
> >   So define a CPUMASK_NULL macro, which allows to init struct cpumask
> >   pointer with NULL when CPUMASK_OFFSTACK is enabled, and effectively
> >   a no-op when CPUMASK_OFFSTACK is disabled.
> > 
> > If you read the 'which allows' part, it makes more sense, isn't?
> 
> Alright, my bad for trimming the sentence, what I wanted to highlight
> is that with !CPUMASK_OFFSTACK this CPUMASK_NULL becomes something like
> 
>   struct cpumask mask[1] = {};
> 
> which, to me, doesn't look like a no-op as the description suggests,
> but an initialisation of the entire array.
> 
> Now I'm not sure if the compiler would be smart enough to optimise this
> assignment out, but it doesn't look obvious to me.
> 
> Unless you were meaning the __free() becomes a no-op (which is true but
> out of scope in this version of the patch), I would avoid mentioning
> the no-op altogether.
> 
> Am I missing something and that initialisation is proven to be compiled
> out?

When you create a non-initialized variable on stack, compiler does
nothing about it, except for adjusting an argument to brk() emitted in
the function prologue.

In this case, non-initialized struct cpumask is already on stack, and
switching from

        struct cpumask mask[1];

to

        struct cpumask mask[1] = {};

is really a no-op.

Thanks,
Yury

