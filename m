Return-Path: <linux-kernel+bounces-758299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E609B1CD54
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92417724E97
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15102BEC23;
	Wed,  6 Aug 2025 20:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="BV3X5JA3"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951F52BE7A5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511298; cv=none; b=ixxXIgqukOgckSMw3mFGAybufO3guW2a7SY9nwV8RyWZrt6twiHnId6mXBsOFCOGa4EGJFCERSNgnYSfas2185g1hfHfLQ/AhUDEW3R4NAEf3qNl+0CPV2x7UtaCdbQ/AIoFUIcva/bU9I+5AzOgWWVV8S1wF5CJwTZ8YiPmKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511298; c=relaxed/simple;
	bh=ZDHpr0+0p20pkDv2mu3Q9yjs57G8bc2Ou1cKrq4mu+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJieHw+7DrfIpuBPRSIxfzx7Qz5ySLMNaJwWbkAQfE1AyFoQ6p9kzShi3OPZaOMYjdrwCryxeMAi2y/OEcPD2fQ9rmadYUL13bqIJbjU/LB98ls3n1JisoGAlHtpYloC+IqTKKL8/1KKq0bwR5zYvPMmf+IjsBbJPTIdhkZm4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=BV3X5JA3; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4af12ba9800so4189001cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754511295; x=1755116095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDHpr0+0p20pkDv2mu3Q9yjs57G8bc2Ou1cKrq4mu+Q=;
        b=BV3X5JA3dDtbNQxiVnQw1uFN7WwqabrDUNcPeXHfZTHPHAKlHLXxGurjs1DLjmkV93
         tqtLsb8ysYSzBROuOkhmBA/pSY9zwqItwnNaokyLJ+vR+7TXgpz+a8MqzJg+L1P3zczN
         iIVU6OLx92d7v4s+AIEkuX+w79g2pZngaOplGIO71IDwwBANVyaRPgsrpqHXvrHJazT0
         vHSjr5bBkdrHp9SAyiv//bzm5cimoAuNFdmKpPOJNbJ2kZJt4gOvIslC63fhB1G7HrXA
         rTlc1MAA4NRLDHaxa5sX48Jjz5Bsf3p9laLIxUB9aUHYxymqFwyFzRGvyuwPWLJIt1iO
         VF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754511295; x=1755116095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDHpr0+0p20pkDv2mu3Q9yjs57G8bc2Ou1cKrq4mu+Q=;
        b=ArHzgVX/ceDLI07MkfsJy7uunY/aDpkws0x7MEhWW/TCKUFLLTbbxsF0WbQPKERj/k
         VTZQvXZoYVIRqIQvjN3+rx/f2p+KCBFKAo4w/NxaT6Zo6f0ckpWvdqoQLjyYn36XVJU0
         JXVpZeYB/0RPzvovfLyMcN7JQwy+a+q7IS4iOBMHwOJW3n6XBH1Rvhw8RwIYdZMjK1UL
         1T1nv8jF+L7WSMddqAWfcmsTyzX9N/3pVH3SC+m13fUj6cvPOnwHFya6eRbdVNXaht55
         p2VTScBHON00dguck86HfPRYK6rASrtVahkwKljGidt7SM/yUV3RTxuJv9IyvFN0PbCL
         J+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCDjR0az7SrgbHaNGyYrPyxTtXAY3mZ67J2s3nMiWmaGP7dqsvxzlloWPFchYi25BpLvJE+FPZGzGw2ms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uynftNhbRX38Xgymh66sIJyYatqEwo4hz+lfuHrfhbwG7ttP
	dgVsL3xXiWlxEdyMXUi6LRLcUmVolN7H6yqRVqXT1I/XG1bgxnmYX68cE+CV+bBRlWfmeX3Vdgx
	Jn8RtNPjYRphZ3nW87wkUYTBLmld6WabG3QRTz4cj/w==
X-Gm-Gg: ASbGncu+xl8vJdrnPtX7wQ3MoAMGEM3TcV/A9u19BRC3HAcvdVRenqqMk43Pjo9rsLA
	BA+3q98A51rTMRCd8Y8pJETVfiQJUhUP8T/4Hb1UnnULCzDdiSTUlLlZ4iyfDf73coyC7uhAckV
	6ZdRUQXkz+bbnkJJGoqM3G7LKBeRzqeSlSvh3sVC/vHRo+luKHksR9+iZ2k6D+gBqHK2eFsWyis
	cnV
X-Google-Smtp-Source: AGHT+IG1pTZIp3NhezI/eRT45NKH+mtzWFGAo+1iZoAphp7Sfj8eCIzIiMWt+Cx51Yqtbvyg1UAKQ14ylzy/wQGMu4A=
X-Received: by 2002:a05:622a:3cb:b0:4b0:7950:8cdb with SMTP id
 d75a77b69052e-4b09267f8cdmr58173331cf.31.1754511295380; Wed, 06 Aug 2025
 13:14:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-32-pasha.tatashin@soleen.com> <20250729161450.GM36037@nvidia.com>
 <877bzqkc38.ffs@tglx> <20250729222157.GT36037@nvidia.com> <20250729183548.49d6c2dc@gandalf.local.home>
 <mafs07bzqeg3x.fsf@kernel.org> <CA+CK2bA=pmEtNWc5nN2hWcepq_+8HtbH2mTP2UUgabZ8ERaROw@mail.gmail.com>
 <mafs0ectod5eb.fsf@kernel.org>
In-Reply-To: <mafs0ectod5eb.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 6 Aug 2025 20:14:18 +0000
X-Gm-Features: Ac12FXzhqMjLum8cECX_x2Yzk_OzuXfSOe_mHCnoev6H-Zqbf5NvubJCxtWA6gg
Message-ID: <CA+CK2bCwe-9QzEbG60csWAWwKC+XMrv5=3DHOJFkBVLgkzTsEg@mail.gmail.com>
Subject: Re: [PATCH v2 31/32] libluo: introduce luoctl
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Thomas Gleixner <tglx@linutronix.de>, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> I didn't mean this for the memfd patches, only for libluo.

Makes, sense, memfd patches are going to be submitted together with
the rest of the series as PATCH, sorry for confusion.

Pasha

