Return-Path: <linux-kernel+bounces-808762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC2EB50475
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E2816BB38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D49535A2A8;
	Tue,  9 Sep 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aIblMByO"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9132CF79
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438890; cv=none; b=Cfhau6g+k1g1oLY0I4qyT/82GzXNFFo/TlP11+f4BdZf6foOeqWeEoYivkgR0od3tmwvO4RCScMxjPLwIGceSLXLiCdbpCKUboR8n+cfu7wM+1oGkcblMCIYHnW0uTc2FNsYLlfjDJ8ve+5UmUw356qyzfhVoPXPk/HegUvmxo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438890; c=relaxed/simple;
	bh=26M4MA/dTjFS6RXtLeG5uBUOvfK1ST1woOlsQ4o+SDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYSEqbud+srwCCEZ8z0Rn2rqXaYCFMfV/XCzrxOqBXRymMH6S0xcalL959gMB1NWTLe7ePxn7JRbIEXXC5ChoiRMN9wGRDyJTHOPPYsMLkt3mB5+XAddx8r5D/lixeNonSv7Hn/meDJ2zb2+1U6KeJzPDCdZcKajW+hDQOXYrtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=aIblMByO; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b5fb2f7295so30558731cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 10:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1757438888; x=1758043688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26M4MA/dTjFS6RXtLeG5uBUOvfK1ST1woOlsQ4o+SDw=;
        b=aIblMByO5gCK5F5m9ky91HnUwUTg2uv/odPdrlgFwPiC/8rb0v0aMjiLVLwZ3H/Yao
         4o7sxI90335pVHWUg4mkxK6UexYML0XJ3liLmC0uh4F6fs/wFg+f/6nO4gDl319q5NT6
         nWrtuo4ODAMqf6+bCBz7xyzsWiFVwBDqfV685M+MF/cqrG8OID/8T090gc6BGAYQtw/v
         P7y6jNQ9WToIVd/UtyNIWIkCQVTjWgUX40tIOSaMZs3sqVil5liScnd9GpzaKITuABY/
         FTIZ8ZMHKrJ7U1D+YZte5xQklkQAH1U0N5INJnH5OAoBU+vEtCsdETuGqvaA0C72mDwP
         ke4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757438888; x=1758043688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26M4MA/dTjFS6RXtLeG5uBUOvfK1ST1woOlsQ4o+SDw=;
        b=fwN927SJdoGk9P5pQppEYOoQ218xX3ObY8/tifCC0DxG96kU1zT5R9KwjH6izVufsz
         mP+ewDgeKOO2N2ssFdcfAB7DN+5YIKiFeCXijUHdp6WWwWo8mMxR0bw4k9fYXgIgPhIv
         UPRUfau5t9ej5k6TtPuCnn2rHrMPXJ5VitXiLMIaCLPuE+vbtT+IXXRTYcnFx/Ngbm+q
         xC/4rysVZXiRtf8zY+CfZwHScZ+MyWBA50asGnm6NBlRjDi5PZkwKXW7ataZOqG0KFWS
         IGFoZ6Uidp7aDaW2HiDO9mu8jz9B4ao3+Y++CAocu+RcMd+lwKrXi6FWNBJNnYcrxysF
         DWFg==
X-Forwarded-Encrypted: i=1; AJvYcCULWLSBSf6LmN8SQi5Fq3LBF6lQOC0fn8d+4ZcUyl0zDRR4ufoD0UTZbCFlVHRRXmD0rJwUp9n0fKdVPGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZI/hCmdQhcX/E+8MY0J9CSxdYNPuCbs7EqErG4DNy8x+1PeV
	wwDlU9SvU5BP/GfCnReLqHgOmBKz6ENbGUV4q5XaGoR3sBGqJ7sia4T6w/kSN2U2LLVq3hOcB33
	nwpYcmwVD7PjQHlOeezd2AW4Jya/3MHNaV69XzTW64g==
X-Gm-Gg: ASbGncs1Eb6qbfbfSxwJEH1O9MBPR7QIFHbxD6QFsNcxU6qZ/ocoxkej9bYfa3PgT1P
	vak6ixNN/h5NWZDjY9o76B+zLmqxM+GyTgFWyEUUdefSUKqLHZ/KPM39PfTdNwVlqX6tUQ3nkQl
	KAsd6+9JafS2uvun0+7kBxwXepTsNggPhx+fvid2GXwXYXLYNhketgx5NnjMexvn9XxsJraWcz7
	phX4NuTosCuLaY=
X-Google-Smtp-Source: AGHT+IE7B3CcFEssDe4XL9VRsiu2ZVtPT1/IDpeG+lIelORf8xEKlj0sqrJaLJ7LEospzMuqfY3+hEvX2rVlLb2YGYI=
X-Received: by 2002:a05:622a:5915:b0:4b5:ec8a:a0a2 with SMTP id
 d75a77b69052e-4b5f847e52cmr164807881cf.32.1757438887951; Tue, 09 Sep 2025
 10:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mafs0h5xmw12a.fsf@kernel.org> <20250902134846.GN186519@nvidia.com>
 <mafs0v7lzvd7m.fsf@kernel.org> <20250903150157.GH470103@nvidia.com>
 <mafs0a53av0hs.fsf@kernel.org> <20250904144240.GO470103@nvidia.com>
 <mafs0cy7zllsn.fsf@yadavpratyush.com> <CA+CK2bAKL-gyER2abOV-f4M6HOx9=xDE+=jtcDL6YFbQf1-6og@mail.gmail.com>
 <20250909155407.GO789684@nvidia.com> <CA+CK2bAvxvXKKanKzMZYrknBnVBUGBwYmgXppdiPbotbXRkGeQ@mail.gmail.com>
 <20250909165718.GP789684@nvidia.com>
In-Reply-To: <20250909165718.GP789684@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 9 Sep 2025 13:27:28 -0400
X-Gm-Features: Ac12FXyDOO8j6_d8TOe427ZRqpXdtWpY2e6HlPY_G5_tWsFdybukjZ54PUO6RWA
Message-ID: <CA+CK2bBcX08kqmT3gKERdRDWBrfO2+N_LgQ00D3SRXv=bippHQ@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <me@yadavpratyush.com>, Pratyush Yadav <pratyush@kernel.org>, jasonmiu@google.com, 
	graf@amazon.com, changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, parav@nvidia.com, leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

> Yes, but lets design things to have this kind of logical code model
> where there are specific serializations, with specific versions that
> are at least discoverably by greping for some struct luo_xxx_ops or
> whatever.
>
> Let's avoid open coding versioning stuff where it is hard to find and
> hard to later make a manifest out of

Fully agreed, the versioning has to be centralized (not open coded,
and verified in a single place) & discoverable.

>
> Jason
>

