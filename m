Return-Path: <linux-kernel+bounces-745444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2162B11A16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B557AA34C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E472C08A1;
	Fri, 25 Jul 2025 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Edw+uyb4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C6E2BEFFB
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753432723; cv=none; b=ut5Do0SL0W2H786aWOi+YU+BUCeN+EZyklI/eFtjo8Xkq+Zp0eD1RxprKHXVi/9igS5+C3l76P5G2G4q9GMnaZ7vPkH/3mxKQm+IgZUvHzhIvXa7ZwGUapYzEdOr8bolORmaEu3rp0zmkED5Fw8YE5LTGxx06hC+MOsqP7hB5UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753432723; c=relaxed/simple;
	bh=p/sPergCSqvqBREakhNKoleZIUie9w55wmYdj8MbWVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cux0Vazz8lQfIn8Q++yR9dEeodjcqlkKCZbIFn7KBpxBddRmrBWZwgfbpnCR5kdP4Bt0nXPeRMWs0M6EeIDMsQpt8+TwdMjmkDUkG1wSZFZpcERj510b4d20bG0ph227Q1MgkrV/CTSoke9Qc0NJozvHwO69XTN+NXrHBSIlLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Edw+uyb4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753432720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l839FtmJfD9QeEUNEIgs65whKDPvocBigZOfnNQ86T4=;
	b=Edw+uyb49mgfOzMnK9KBaRYjkK351nsoG4d+fdiWp5jKZi0piQzodvmIOVMwBjPcR7IwuD
	Zr0ZSXn5S0bLUjYYowiIdji/J554Ekauz2NMlkanx9E9KTw8i7TiOpLjKJ7SOPrFjZN21R
	uqrG1Oy4b6r+inNwDJfhcu7i/4XegLg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-Szf04da7OyyX6XlSEAV5CA-1; Fri, 25 Jul 2025 04:38:38 -0400
X-MC-Unique: Szf04da7OyyX6XlSEAV5CA-1
X-Mimecast-MFC-AGG-ID: Szf04da7OyyX6XlSEAV5CA_1753432717
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3138e64b3f1so3057094a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753432717; x=1754037517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l839FtmJfD9QeEUNEIgs65whKDPvocBigZOfnNQ86T4=;
        b=a00Ogfefma7Mc9dnAWO08gCTg0pAt6vf2InAgyFkpzrDG4jeUlL92ZmTFtMRA7ICPA
         IVyLr2zok10/3BQ+Jg0W2CpUuwIlF7mWPmGAMXfdg/1A9HbfcM8QdYA6+SeI5aWOLbr9
         qE0gd8D8Fglq/5cA5/E0VnT4BSoTNN7hUSkopU2cFHVVY2dcLcpzcVb98Vc+0z7keQwl
         /6eaHvGnOBksGH0K1m7VfjnQyWu7LzvRl+DESBXNL6WLFH1N6hJsEBTlflaH6BBVL70d
         DPYb/xyw+H0VN5BtSxhXS3ud0C4dpG5mBzToxfzBmT48uH4Cojyxsl4jCfuUdEJ8lqAX
         OdlQ==
X-Gm-Message-State: AOJu0Yz2mgERoBvTka6ISH6y2Ikc5kRK4WDO+mv7lTqTPkuGWk+kUrJD
	sFzkuyBcbLnGUthhmK1mpVOfqaLg9eRDmzfVaD8x4CMIOpn1DB7tMIKM8AmAj/U6ViQDA2fJCsQ
	BZFDUaLEnAseIq8A5kvkV1xa+WfUaO6TQ3hC6+qxv7LAwtWbgFpSR4GRJtD0THjjk8miUYGBo6M
	QQ5oJS+3B9pu+FR3AzN3LpDstIYLxbvlanHmTRbVsK
X-Gm-Gg: ASbGncv6ihjxbYz7hQWp934Mb4RwVzgpJVTmWgweQlftv9dVh+Yg/JkLz3/fkaVhJ25
	MfioM8hYp/TGD3xTZDl6b4ct4vmMRYS61zaeRt/coSxUQcaubhWRY21UrPrC9DfOYCwaiktv6wb
	4/xnIB38/8M8TiZdyPri8o
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id 98e67ed59e1d1-31e77afec2fmr1638824a91.28.1753432717342;
        Fri, 25 Jul 2025 01:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8BbwGTpiFIgHKfWf4ykhdVvu66EB0IkDK+M3uuBHxAip1Ohv9ZFi2p5wZH0IQqVXbSMfAhFdTeSqW8PM8WX0=
X-Received: by 2002:a17:90b:35cb:b0:312:639:a064 with SMTP id
 98e67ed59e1d1-31e77afec2fmr1638806a91.28.1753432716948; Fri, 25 Jul 2025
 01:38:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuBnDVaiZ6Mqhr=4Y2quAsqeZoGfJ158xJ1-Q5HHw=cBw@mail.gmail.com>
In-Reply-To: <CA+G9fYuBnDVaiZ6Mqhr=4Y2quAsqeZoGfJ158xJ1-Q5HHw=cBw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 25 Jul 2025 16:38:25 +0800
X-Gm-Features: Ac12FXwqAD8VmCJzAPOUYLLys8jDigRvmsJk7uLS2PNwF-x1PPSwDp1GEdHtbVA
Message-ID: <CACGkMEtWyJKqQr2yRyhU5=5qg+EH06FXsHRabk3da5iwfCA4FQ@mail.gmail.com>
Subject: Re: next-20250725 i386 x86_64 virtio_ring.c error variable 'id' is
 uninitialized when used here [-Werror,-Wuninitialized]
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, virtualization@lists.linux.dev, 
	clang-built-linux <llvm@lists.linux.dev>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 3:43=E2=80=AFPM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Regressions noticed while building x86_64 and i386 builds with clang-nigh=
tly
> and clang-20 toolchains on the Linux next-20250725 tag.
>
> First seen on the Linux next-20250725
> Good: next-20250724
> Bad:  next-20250725
>
> Regression Analysis:
> - New regression? Yes
> - Reproducibility? Yes
>
> ## Build regressions
> * i386, build
>   - clang-20-defconfig
>   - clang-nightly-defconfig
>
> * x86_64, build
>   - clang-20-allyesconfig
>   - clang-20-lkftconfig
>   - clang-20-lkftconfig-compat
>   - clang-20-lkftconfig-kcsan
>   - clang-20-lkftconfig-no-kselftest-frag
>   - clang-20-x86_64_defconfig
>   - clang-nightly-lkftconfig
>   - clang-nightly-lkftconfig-hardening
>   - clang-nightly-lkftconfig-kselftest
>   - clang-nightly-lkftconfig-lto-full
>   - clang-nightly-lkftconfig-lto-thing
>   - clang-nightly-x86_64_defconfig
>   - gcc-13-allyesconfig
>   - korg-clang-20-lkftconfig-hardening
>   - korg-clang-20-lkftconfig-lto-full
>   - korg-clang-20-lkftconfig-lto-thing
>   - rustclang-nightly-lkftconfig-kselftest
>
> Build regression: next-20250725 i386 x86_64 virtio_ring.c error
> variable 'id' is uninitialized when used here
> [-Werror,-Wuninitialized]
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> ## Build log
> drivers/virtio/virtio_ring.c:2113:40: error: variable 'id' is
> uninitialized when used here [-Werror,-Wuninitialized]
>  2113 |                 BAD_RING(vq, "id %u out of range\n", id);
>       |                                                      ^~
> drivers/virtio/virtio_ring.c:2077:19: note: initialize the variable
> 'id' to silence this warning
>  2077 |         u16 last_used, id, last_used_idx;
>       |                          ^
>       |                           =3D 0
> 1 error generated.
>

A fix has been posted here:

https://lore.kernel.org/virtualization/20250725083635.73355-1-jasowang@redh=
at.com/T/#u

Thanks


