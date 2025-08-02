Return-Path: <linux-kernel+bounces-754246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D957BB190F0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 01:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC093BDBC2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE127A919;
	Sat,  2 Aug 2025 23:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="L5GwLM9P"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79308221736
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 23:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754178050; cv=none; b=angGOsWjjizYn/vCusnDOO9yRo2KRCyMX7YYTWT6z6v/KFDRQ0eaBwlSWUOhScGBodwUqH9n3eIsI/g1LEv8HTUbMR9ybLKgM6luQr3u0vbAJuf1Gm/NtFP67XVtEzGjb7FZt52gBrFH3MOiDe+Em7MyYMu61G2EsPFCCZQbyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754178050; c=relaxed/simple;
	bh=JuDgEE+wyALjlXEPLq5/uDToxeWVIRpzyYUtDB1K3fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AMAJd8L6mbD4BoU+ERA18uYdYDMqnSYPYilifckdIMNyrnSr1f4eQ4B+UCZGBBgZoihKe4tUjjnlBnHifZsKg9uk/8X/gHE6MDMDXHtr8zWYgFKe/DnWBKxsae2DepiqJmEDhEoqn1oGRJj3d/9PYGaHWz8eYaiWi9Y/bmVcSlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=L5GwLM9P; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab63f8fb91so15979801cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 16:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754178048; x=1754782848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Kwf5emshHgumx5UQOn1IaM+oO2QbnhutbCNNGQmoso=;
        b=L5GwLM9PsG2Nt29xfWCfezz5rV7uMZu7C8ALXsk/0vBvupwhmKLmG3p/8NMJaxHChX
         eotAtl4o6/zWLcdWa1gIq2gwXuygxIIxAz/3r1gXN8hE+xTjEqNzbKtoeMyRhXBGhWsV
         /W55c7d6XlZER4YGMxxFxtxQlznuDMq4tX5Q5D/Uke6ZkRBuXMSEQhy9QKOUhqD8lPyN
         LSCxfFbwGRZJN6EKBBV4QR3RQ+f0amnDPK+53NIaR4vqpdFZELHxkf2G1uLzd9yCPNyJ
         s6lr7hBkXkdFNlK+mtdx1zOsMVtQ8MjZw+XPAkHm9uldWKmoN+ZRoK9LLzJLZaKiOc0m
         ORKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754178048; x=1754782848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Kwf5emshHgumx5UQOn1IaM+oO2QbnhutbCNNGQmoso=;
        b=HC5ZNVrtu9ZpzmWO7U2Q3DlD5MyVgfd8JiQCKjECvHn0TaiUL9doso0M0Jn/yTXPzc
         8apws089FGNAeWSbgHIrcXGe+jh6h/r1qg3MJNPigilMpPXGvVPIOjsHrRkSMLpf2VPA
         0C3aZ1mSv/X+9I80F1gNpWXsayY1R0pUqwny6gTjxUM5ReZrYlJOzAr7nRequgtuI8PJ
         DxlmAx3O05LWPtI5RcJsi8izEC1E8xujM6ML4n/dF3DrSO761n5ae9q5hgKmuS9d9ilP
         Hz1lWsTLmqGRM/hwq62/0SEajpFeec/cCPYTc489q0xbV6p9zUCnpWHrpbjsrWonbrHM
         3VPw==
X-Forwarded-Encrypted: i=1; AJvYcCUKQ6jNIw9ybiwSTqXyOBkxg6hXAD6nZDi2voIEwn2XEYsTtd7FxYw2Cz2FTFbJbdK965J0KDIsB+5Jw08=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNA+etWmRm71ZOxp3K8IseAatx0w6REmc7O/SdeE05EjhmrwH
	M4SPKSsO1Q2sH8ACL7TWybomUGTNvRsyeoFF7axJDfBiQvJT5Q/xPFW0O8G/71DZSysCcilMAjW
	CRQuUFGbfeRa8F1H9KJnquBOlGaheB28gQ46P1qJNxw==
X-Gm-Gg: ASbGncvGIWEBrTeZYVouOWMgwE87b0hwv4jCjUkW5aDf27NprFDe5pg4iubWfy2sCpJ
	g00PryqgReINSwTulclC7ugiTvoyy6A4JfbPopNA72RUMLt3s2F6xOgnfCeyTokUzcGjPoONH05
	jSGitbpiQAe2Y8gCrPUc7INCpmDesDX2gTyeusZTFABO9jPHPFAFk/63UJgx4uK254ZXdo+0z0z
	kxQ
X-Google-Smtp-Source: AGHT+IFpEg+BtKr96Wd9jX6hc7J1lAyOtlKRV5n6zcMT8sF5wnH7KyD9LNxhPu7rDIt4u7A627QHbMmxIWZ6L1slTdA=
X-Received: by 2002:a05:622a:5591:b0:4ae:6a54:b989 with SMTP id
 d75a77b69052e-4af109e000cmr81212541cf.15.1754178048447; Sat, 02 Aug 2025
 16:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
 <20250723144649.1696299-5-pasha.tatashin@soleen.com> <aIdOcmTl-zrxXKAB@kernel.org>
In-Reply-To: <aIdOcmTl-zrxXKAB@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 2 Aug 2025 19:40:11 -0400
X-Gm-Features: Ac12FXz8HYSIPcbtEM3vy-98nOIq6tA9NVRJ7b2LiTxllNWUeuS6IULQVPJlPpg
Message-ID: <CA+CK2bBiEUqMotOZJa-DuAfZVXYn97F1byvjg-ezXYexHrgLOA@mail.gmail.com>
Subject: Re: [PATCH v2 04/32] kho: allow to drive kho from within kernel
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, dmatlack@google.com, rientjes@google.com, 
	corbet@lwn.net, rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, 
	kanie@linux.alibaba.com, ojeda@kernel.org, aliceryhl@google.com, 
	masahiroy@kernel.org, akpm@linux-foundation.org, tj@kernel.org, 
	yoann.congal@smile.fr, mmaurer@google.com, roman.gushchin@linux.dev, 
	chenridong@huawei.com, axboe@kernel.dk, mark.rutland@arm.com, 
	jannh@google.com, vincent.guittot@linaro.org, hannes@cmpxchg.org, 
	dan.j.williams@intel.com, david@redhat.com, joel.granados@kernel.org, 
	rostedt@goodmis.org, anna.schumaker@oracle.com, song@kernel.org, 
	zhangguopeng@kylinos.cn, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hi Mike,

Thank you for your review comments.

> > +     mutex_unlock(&kho_out.lock);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(kho_abort);
>
> I don't think a module should be able to drive KHO. Please drop
> EXPORT_SYMBOL_GPL here and for kho_finalize().

Agreed, removed these exports.

Pasha

