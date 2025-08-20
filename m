Return-Path: <linux-kernel+bounces-778643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AE6B2E862
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696F57BD35E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B372D9786;
	Wed, 20 Aug 2025 22:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpRvBiAR"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0633229B2A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730615; cv=none; b=YK8zwPr1C+5hRInwCJ0NyoRi7Vz1dLZ1GiZW5cWDn+zRI4VskG9VJttQT+QO1L3t8hqTDHnFkd+tYPnY6nQek+wSMKem+hRXRWOOiWXYIWmqgcQRxNOANTqXsMuLZE5Rhk1GbmZdtW0MKwbEj1W7RgIKe/4o2LL0JwAZx0WZyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730615; c=relaxed/simple;
	bh=/yswtVJ1bkFnVVjnsjbnou4NZos15rlVgZSi2sK7VLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF2MIMm+h8EBTWbOCu9NyXKrxiCGVlLyf+esylFHYzNh4S+BuRpSUWJXhpuXTQMMZ4srVmVgbX/rZKGEnw7F4MRiOHYXlKoxd+bIheGFHgNaDPPt7yumaTg3hhHFg74b007HMQvxoX/ThOzoVvx99S8yQklanMu+Ct5Qxc2wtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpRvBiAR; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e56fe580b4so1771465ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755730613; x=1756335413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqijktqL5QSVl4d9uRAFgyOKB/qUtj5ueyBzLO6jfXw=;
        b=QpRvBiARjh6W2CXsBgzmQ0RnHJ21RRkBHNMfngX0t4mvCnPNG+moE1NCQIPu7WeKBY
         MPvH3Qb81p2hjEdmc9Gz1iN/YljhvM2ukiOULv/ALWM29QVETmKc4K1cMWS+6He7vRml
         eyMtDe7T/3SdvL6Z2ib11JXsXaZXq2a4V1R1Uh5FIPPgiR3CIINIXZz0rXuznYx4RUml
         LYHlfZlyC9Kv959VwCxgTmQO8LWAnjb2R5d5ikDdcpapLs2f5VPhOXdgfW9Rz4mAldvB
         BOJEHtfZChAliVDujt+FIZqKfN+cFdPGBT7x9uu5jKEzj91yeb8wvaQemfc3lkOPEbCH
         qBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730613; x=1756335413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SqijktqL5QSVl4d9uRAFgyOKB/qUtj5ueyBzLO6jfXw=;
        b=nFQbHXjv1P1htQI9fundv7yelJT1J/DZs+CiXSoU7qsyyrZVv/tAwpypv63U9d6ecK
         ktJtuWIKXee6Fu6n+w1Oa+Z6Lg3ZHsU9qDJjIZakmrmz1k8FacEPLmk3AiJIm9JB6TsF
         J+7gwg2SDaMnGt1vxVT9L7Fj1qyMVQ+VS29dapi/zngwTIOgNZiX34GygrwJ6h01TNnh
         hbRh3ouavypeSKJSDq28DytHWRkdBORMHUtjMCgOH+dPTTujXj7BxEiX6kU76l1As7MQ
         0qmaVUfdimn+zzkqpvc5ZGynKBToanH5gPijTkEMwl3b5oCYRwbmmOC3WGMynT8K068L
         +hHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmAnaf0u9pTHnX2YU2Sxk/D9kOwgYfOHnnr94GV896tsj7NUqsfK9VFn65nlZTMrxzk2p3gbVS6AAvpgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEj9j1XLSzu/RUZ0bBzb9X26P0yW1cn6OtmLdoLLOPTPcJ9SPi
	eSFRHCGx5kV5hGpVmnPZo8t0CIWu4/X3eDBrU+qDF1NbTdWEvmmelg6cMHeidDv/O/20Q6GrOky
	fQ/IFltZ5jWzJrRLxKVc+fxfjRinvrRkAG3qKvoM=
X-Gm-Gg: ASbGncuaED0xxUox3Lsnfq4x+6bTT/IEofHiay/NAZmvRFg/XTxf6+8413RYLOPmsGn
	TRK3zyUhMJl+Cl7+S9l0JZlZYUXnMrJsPaOZq5Ig+dJtuXWB9eB5YCc/OfUCFrzqAUsfLqXuwWy
	DCxbI3/0SAyvVMElM7UH4156szGa8P45O/UHy1ijlkPljYrfZCgUOWcMWfETFvryDapnq5rwioV
	E8a8e15OrPoEnpmQUdO7go=
X-Google-Smtp-Source: AGHT+IHqhFqF0ldEvreg/zhfn5bJC9zhoDj5P0JECW0SBkkVMdAh6s8W9uc7MbYxkPrmre9Wg9hXsJZ9FhvxeMhipnQ=
X-Received: by 2002:a05:6e02:1609:b0:3e6:65d5:2278 with SMTP id
 e9e14a558f8ab-3e6d3b83b12mr5701655ab.5.1755730612828; Wed, 20 Aug 2025
 15:56:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820181547.3794167-1-nphamcs@gmail.com> <20250820224659.88528-1-sj@kernel.org>
In-Reply-To: <20250820224659.88528-1-sj@kernel.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 20 Aug 2025 15:56:41 -0700
X-Gm-Features: Ac12FXxvh5FV2ONZgUx83BQVRwVMK28b4ENt2qAqzERkh1Pfrd5_5j4HG2TtHZo
Message-ID: <CAKEwX=NLvQyZTqv15kACZP2wErO9hyv9W+0j-BWrgOh5ZX1LJA@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: reduce the size of the compression buffer to a
 single page
To: SeongJae Park <sj@kernel.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosry.ahmed@linux.dev, 
	chengming.zhou@linux.dev, herbert@gondor.apana.org.au, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 3:47=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Wed, 20 Aug 2025 11:15:47 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
>
> > Reduce the compression buffer size from 2 * PAGE_SIZE to only one page,
> > as the compression output (in the success case) should not exceed the
> > length of the input.
> >
> > In the past, Chengming tried to reduce the compression buffer size, but

Yeah, this should include the reference below. My bad. So it should be:

In the past, Chengming tried to reduce the compression buffer size
(see [1]), but

Andrew, would it be OK if you fix it for me when you put this patch in
your tree :) Or I can also send a new version if that's better. Thank
you!

> > ran into issues with the LZO algorithm (see [2]). Herbert Xu reported
> > that the issue has been fixed (see [3]). Now we should have the
> > guarantee that compressors' output should not exceed one page in the
> > success case, and the algorithm will just report failure otherwise.
> >
> > With this patch, we save one page per cpu (per compression algorithm).
> >
> > [1]: https://lore.kernel.org/linux-mm/20231213-zswap-dstmem-v4-1-f228b0=
59dd89@bytedance.com/
>
> This is not mentioned anywhere.  Probably you added this as a reference f=
or the
> past work from Chengming?

Thanks for taking a look, SJ!

>
> > [2]: https://lore.kernel.org/lkml/0000000000000b05cd060d6b5511@google.c=
om/
> > [3]: https://lore.kernel.org/linux-mm/aKUmyl5gUFCdXGn-@gondor.apana.org=
.au/
> >
> > Co-developed-by: Chengming Zhou <chengming.zhou@linux.dev>
> > Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> Acked-by: SeongJae Park <sj@kernel.org>

