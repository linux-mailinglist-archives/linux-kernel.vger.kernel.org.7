Return-Path: <linux-kernel+bounces-812144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B37B53392
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05413A0274A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86F3326D77;
	Thu, 11 Sep 2025 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKcBWjJY"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E323112D9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597017; cv=none; b=LEVcfHavb6reIdAeAHu1ine2t0Y11WI7bsBSg5asDz2aFTnO4mNqx0YRUQ/TSXiPpYGyx+G8qd8eBEdSPGca9bgvnyKzm4q2e+Fx7qOXv7NhXFEmLFDFvZLnc+KB3bVzSTTZdNqcS8vZ0qmvaQHW4YLKUChQFugi3sNa78Acn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597017; c=relaxed/simple;
	bh=ILd6AoO/Vzfm3lniJYA7jVJUimFQ42DfyFd54iH4owU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+bYouUnzEmMD3E0Z3IL+1x1YvSQtaWQFgtiG7BbtYHlwuCkqNkRvTHyhMLe4pn0staNtazdNrDzNusBc6eYPhLpFF0Za2vmgFhp4FcohIiwh2AZNnkkvM84L0fK0TGe9YYywXE4ROd0fFhH0uwcitqAL9/zRG74xGTk8TXZMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKcBWjJY; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32326e8005bso630382a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757597015; x=1758201815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6ymZmvGcwqVr201+2/9iequakcC0qkHxj9+m5M5hyk=;
        b=GKcBWjJYfPvyFfGG+9963ltE6xdz5Vc2NewPd95vRS7iMsefJIA4mE3vfE42h1lP8N
         V7reqFQVxf7Gq8dd/GJI2JUkjo1pq+eHc95+B2RcK+tvWN/CydtmZlhiHI/XYHKw57su
         HHfBhnYiSMxuWM2QK1FwdYkDBXZ/avK9CGFmb6snkI40IVX2L5OHQ0LVfxXk3eJlcMn7
         qYCPXJeHxMfr5ihvHcXCkzlX4ZulplszSh33SWm9jrWNEY2la5aLzFUYcb6Or94VfNp7
         K6H0eQBkEaGBvSkC+r496xjH78PrTiVl0VF6rekBJ6Xc5dcbHUhTdmvXMjvdJ90n7FrL
         /sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597015; x=1758201815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6ymZmvGcwqVr201+2/9iequakcC0qkHxj9+m5M5hyk=;
        b=IYl8MHzJvsFewgzuN1p1xrKcjFp53LntagKCT96k5ioyxQIOtnrDtUYzsRSzQyBuLq
         AlDAMaDGxImpqXFApht6abBzohBd325UnRVAOk1GLP18ih0qQ4996orvhCqsneooU4W6
         v0kcg6YOcoxfph0Qjj1DPrOvjLFqMKCy8y7gRs8jftL7MbOjANy6Ro5Zxs+dhFPkD9sA
         WURdXoNity/d4i/EJOcXZyIKcoFIbcS2iMoqbFkko4oqP29O1gBVhZebosEIdBeBNlHI
         J+j/C7AvU/a0sCIxbk1WSymWzHU6TaNdwrBXz6x2NxrtQPNYm46W6s/O/FJpe3SXrapJ
         RxUQ==
X-Gm-Message-State: AOJu0YyoM3Ib2OwfWQOcsDnsQ18fv8WjXJ8hLrPMFRksOhlh7QXMSqHV
	aPNUJ3ADMJAG+qKofUH6tGjO8fqDyBF5ePePbfdgT7c67xX7kZ9mNT6JMJm4Nx+ZuYVLvPhuCav
	ZepkITBQfOuU6HRN+ylQqogfr+WO2UAw=
X-Gm-Gg: ASbGncvzVXgTRt7MmdcJryc7gWMT/uVjN5vcMvcAykmQdRGDMVMsQvzWO+OvIbmPh3w
	1ORdA7jMUr2YJ48ayeV+MHXR1ZGGqBZRFPBOcf2FhdiLkrRWWKaM22sSUu/gidlanQX/DUGGhpH
	Yrv6zbTb1T2RrLXLtVSN/a+KQYp+Jc3PznFmZOcfRHB6MB7+t/JDPkRDL3fHpMc7foiIOewQZLZ
	nTGXMW7jYV8ChbNiSynEnZQjkBW
X-Google-Smtp-Source: AGHT+IE0fCHUJBZyLWfLL6NHxo0c1V0gVO6H2lI8rIpZlNULNyRYtxb1MghxXTwxbDrWyEB+kS+XLAcH2klufL8f6Zw=
X-Received: by 2002:a17:90b:1802:b0:32b:ca6f:1231 with SMTP id
 98e67ed59e1d1-32d43f05005mr22897820a91.1.1757597013058; Thu, 11 Sep 2025
 06:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEjxPJ4-+WfGPLev5QU_+_NgBx68zdBBQ6x_+aonzbk4f9BNEw@mail.gmail.com>
 <20250911130653.967139-1-zhanghongru@xiaomi.com>
In-Reply-To: <20250911130653.967139-1-zhanghongru@xiaomi.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 11 Sep 2025 09:23:21 -0400
X-Gm-Features: Ac12FXxczdBxkZ0DHcWwMtzZjg9qMvci9_-8tA8VfmWk7TD-1Qaz5Ek7HY0P9Ho
Message-ID: <CAEjxPJ6upN5e7XD9HC970pKvHox-qPjZLdzm=bV-tu8GgFrYoA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Make avc cache slot size configurable during boot
To: Hongru Zhang <zhanghongru06@gmail.com>
Cc: linux-kernel@vger.kernel.org, omosnace@redhat.com, paul@paul-moore.com, 
	selinux@vger.kernel.org, zhanghongru@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:07=E2=80=AFAM Hongru Zhang <zhanghongru06@gmail.c=
om> wrote:
>
> > >  static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
> > >  {
> > > -       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - =
1);
> > > +       return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - =
1);
> >
> > If you are making the number of buckets adjustable, you should also
> > change the hash function to better deal with multiple numbers of
>
> Thank you for the advice. When running the test model, I sampled
> /sys/fs/selinux/avc/hash_stats once per second for a total of 1800 times
> and analyzed the distribution uniformity of the hash algorithm using the
> sampled data.
>
> Baseline: 512 nodes, 512 buckets
> Comparison: 8192 nodes, 8192 buckets
>
> Metrics (Average value over 1800 samples):
> * Bucket utilization rate (higher -> better, same chain length assumed)
>         * Baseline: 52.5%
>         * Comparison: 49.5%
> * Max chain length (lower -> better, positive correlation with worst-case=
 latency)
>         * Baseline: 7.5
>         * Comparison: 11.4
>
> Experimental results show that scaling buckets and nodes from 512 to 8192=
:
> 1. The distribution uniformity under the current hash algorithm does not
> degrade significantly;
> 2. The maximum chain length rise significantly, potentially degrading
> worst-case performance (ignoring other code in avc_search_node function).
>
> Details:
> url: https://gist.github.com/zhr250/cb7ebca61ff5455098082677d75b1795
>
> I will modify the hash algorithm in the avc_hash function and collect dat=
a
> again to see if we can achieve performance improvements.

If you look elsewhere in the SELinux code, you'll see that others have
been converting other hash tables to using the jhash functions, so may
want to try those here too.

