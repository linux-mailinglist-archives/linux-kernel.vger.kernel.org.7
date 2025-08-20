Return-Path: <linux-kernel+bounces-776956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6790B2D374
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920D1580A38
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72151284682;
	Wed, 20 Aug 2025 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpRRz5vx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60FB283FEB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755667258; cv=none; b=gE4HemKwy0RPYwbMlWii0xOgF9G++W92SwGKyoyIe8HkYl53eIcUl7OHrpkqpOm1bl+zYCdLN7aGpzXWmKJmhIosGpVMIs8GQFy5xuHz/477b7qLD1NZSxGJMOG+cIgRwpov/VKTFLY4ecvsYeJaR4gH+EBTFTVYmyQW8z1EUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755667258; c=relaxed/simple;
	bh=6TKSY4/lXffBk1bEYwJHXHjTL22/Z+F6xZnTu/DbjOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuM9eYpMgn7H+WgKvQPqLoAHYef0RY5zw9cZkR/+z7xGWW4kT4mI3jLicx2khqfx/L3fF9/IfX2CGcTf15V6K+8t5JLxbcT3jWdMiBBqzXdCfq1bIfQYrPP3FS8+bdc8Hqg5gyE1gNf2V6tnO7TAIRxixqV64CfJaa80S+VZRls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpRRz5vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF1AC116D0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755667258;
	bh=6TKSY4/lXffBk1bEYwJHXHjTL22/Z+F6xZnTu/DbjOU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JpRRz5vxQrSl1MEhicY96+FjdH34XIXty52P5tXseuN6137NrzkFqtXtElyCdGCyu
	 IbtwUT2WOjIz7VixXUR8JU0l2IJlVOM3wLNbIfPmjTL8zH7vQ35qoxyNhVQKY+TChp
	 B0KoS8DJU1JKshRIc79/EDWETAzB1Cm6+DsU9KyDz1Ouqrw/T669Bm2qUjgUVzvy7y
	 4eYw/rPz3dRNGrQH20rG4MEb3r5iQbHcWRLuO7/Dd1JRvRIMzDLdKbEIflG5AQf6uP
	 0mSYCWlfMTTAZYzyOJUFQ4fzhfgjx0vFx5XUFj+nKcoXrGqaTzdEDCOVQnBslLBk6B
	 6EyQvAh2leiPw==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459fbc92e69so49085e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 22:20:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrb7J8e6ew9lbneWNMFIXxjtcezfbslLwBw/k/ERThqvXyz0r2JmZw1aowCVhNPbDPDa27LSaP2+hHCVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOdFmyfSCLE61g4Di4LkNfW2Uk4PJk3mohtIE+Xcr0s2Od/lh
	bymTXu2THqNU3QNqX9xfuYLueXeKY4FMzj90LSkCjDtxv3DmNpvlxeDTDS50uB+cgtLzvMHMitd
	RtHMKQfnNzNdx8QPoVA/2HNtOKysL1/gfNtYRcSgA
X-Google-Smtp-Source: AGHT+IEjZhoG+qzilq/U1vimpZ5Ew1PMM+qqCYeoSrlPd47GMSymNL5JWRWRWqBhefqEc/wQHyGffXE5TpqEHU9miRQ=
X-Received: by 2002:a05:600c:3f05:b0:456:e94:466c with SMTP id
 5b1f17b1804b1-45b47d0f6f0mr916805e9.3.1755667256993; Tue, 19 Aug 2025
 22:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819193404.46680-1-sj@kernel.org> <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au> <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
 <CAF8kJuNJ8s2D9NBdXDQ4vpBP0a-5k7r_=DdFuJJ95nMKmm6LBg@mail.gmail.com> <aKVYyGWiWRYgxfE-@gondor.apana.org.au>
In-Reply-To: <aKVYyGWiWRYgxfE-@gondor.apana.org.au>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Aug 2025 22:20:45 -0700
X-Gmail-Original-Message-ID: <CAF8kJuPPsLzWu8+xm2A_UPHMBhb7OTjJNErM1Kp3hPmvHXNDUQ@mail.gmail.com>
X-Gm-Features: Ac12FXx3s2d7JOW1u4QIm6NEM1DfOmwb4PMZclWUcMRycrx6dr8sdVcaQX0qtfg
Message-ID: <CAF8kJuPPsLzWu8+xm2A_UPHMBhb7OTjJNErM1Kp3hPmvHXNDUQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Barry Song <21cnbao@gmail.com>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 10:11=E2=80=AFPM Herbert Xu <herbert@gondor.apana.o=
rg.au> wrote:
>
> On Tue, Aug 19, 2025 at 10:07:57PM -0700, Chris Li wrote:
> >
> > But if that error case can never happen, we should convert the crypto
> > compression from returning error number to bool instead. It does not
> > make sense to return a free form error code and also demand the caller
> > does not check on it. If you insist that the caller should check
> > return value like a boolean, just let the API return a boolean.
>
> No we need the error value for other things, such as asynchronous
> return -EINPROGRESS.

In that case it is fair game for the caller to check for the error
other than -ENOSPC. If the return value is -EINPROGRESS during
synchronous crypto compression, it is a bug. We are not encouraged to
use WARN_ON, then having an error count to check that something truly
unlikely but possible to happen is better than folding it into
incompressible and pretend the error never happened. At least we can
know such an error case happened.

Chris

