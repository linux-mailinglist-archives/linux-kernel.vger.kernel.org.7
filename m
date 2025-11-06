Return-Path: <linux-kernel+bounces-887551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68170C3880B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 14285348822
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0206C1AF0BB;
	Thu,  6 Nov 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cSvjPCbD"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78911A9F9F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389593; cv=none; b=ifcHYDHfm89SGRQfgH/wr4SZDsFcqTwRNGX2GHCKhAsuUuxXAgr7H7C6+l73Ve7L0F/Iey/mmccYy5YH9RrLx35ioAO0uiizYvi12QOz//nb0c+VwqIheAUyIZsVRL2OzVgBw/TLGsAp6ykxASnQ64K9K9GvYQn0IRRhWwXlEGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389593; c=relaxed/simple;
	bh=A3x/VRWhljA1QBA+ZZnWSQnoqe6FVuDQ8RYwhSf199U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtKtXQvVDbWottrBNZI4BGYr5oMo+Tejpos+iJa8MaAy04yEGRB+qTIjWYmxkh4xcmZZ5mOZShv41Y4vkZ790XA3KukHdXvOTSJUTEQfNc7uOem9+fxWAhB5N34ggIQsNNikCVMsMRA4j08ALYZpmEQNruBUQ8UnNpto/4EKcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cSvjPCbD; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso120441cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762389590; x=1762994390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qB7xEdpyB1NMalXP1PSx/JV/NVaBw6TXvhQyAEW2AwA=;
        b=cSvjPCbDLRRrwcN/ZgmejuGJ3eAcHNKY/N5a1MPBP3Pcv3wgm7KgDESuNe0AJ0Xyzy
         KV1xQKJuzHqfL3s3Hdl7wlb0n1fWw1R/WzJd0NxeHbI5HzkAsyhKpN7KfkLDQaN5G71n
         9rziUIcI1/uDebCslTAAA6S6HnlDiRqtVTywmK1UqJ6vYn5kEPia3xoHi5XguSRKFnCt
         xD3pBZMF0huN9ok8XQm416f5YVrYnL0kDyug/c+1ApTeDyMNE/mDHLZbSM6bnBRFcoL2
         oAA2GJzfHJ6fKI9wWgC52Bfp3XdHHUBb8CYCLSuD9FaJYSq6gTuV3pu3BF4i9+02np/f
         1kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389590; x=1762994390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qB7xEdpyB1NMalXP1PSx/JV/NVaBw6TXvhQyAEW2AwA=;
        b=MdUtwtNTqxdV0hv38pCh0LwC80ec/HxsawpBAM6VJUou0Ju/hAq/PlRWnt4qIR0wVW
         ribw5sZW+YvRtvNRTlT/0B4ET70+XQL7DCjmkw3DKc8aR3QRbkTpsMTx+110XAVPcOU/
         bGV2Lutf6SrUQAsIi+w2A3TZ7Ey+OJL/3HpwZhY82NgIRha5neLVhRO0SXHbWMbctX+T
         SaDCFYwTCUWs4lZdPPyXqjE/3Aa4MwB/18yghB7qUygasv+xPYjYmJxbizf2Uy7Szcdm
         q9dTrWRgjo0G0n03JKY9Abgm/AhhwaDfQwD8If5ldvRh2pI1uY3NkvM6naNIaGYeOa8L
         a1jA==
X-Forwarded-Encrypted: i=1; AJvYcCVqFp580j9RI6vlu1LS+2tOZk+CXWHXOMhwlHULQVVkdv8BXEVrSX1eAckOCtIMILBDmh5QGA+uly5ulSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhtX5s2dtIpWz3ylXK/E57K0R/6zxNOeItNWkhoeV655yH/Wp
	MMbDSbPUr+BJ8hb5yom2PdPCt3UevTvh4TZQPzVPCQcnPzYYIpuAmyq9qqeR68GkcraBDcLQ/RJ
	dXQh0OuMgzJCs0KuUoLzPRnGYCwyTD6cLVENKC9tQ
X-Gm-Gg: ASbGnct4HLGOd48TvBCq2XH6qd91lpXtX9StWy0CVQEvcZAViW12x+veoifol99DOpr
	zMJ/PWiqC5uJS7VQ2o/7t+5Q8cgzcFEfKK0Cc5Qm+JisXUdv48PFNS3ZfLAJ3uBbUXIcNUZhW+T
	m+Mwl2EMQBy8X1ISWVCBa1ln6EGUpSNs1OlQ3lumRWWNFyo3lFGZzPzpILyNJ0Sy6DGXA8UrW/u
	ZeNGWZawkC/oqUyIv+HtzRrEep0aPogTqDEhHiKsW0qUiTief/OxpYEftl8mMoqrpQlBA==
X-Google-Smtp-Source: AGHT+IESxNu3DCWnIGyPrBib8D8gpFaENt4OMOL4jxhrw506aLjvpEZ9DVEQvAJ2a/G1nvaS2hjdXcVDTuDbokSzSsg=
X-Received: by 2002:a05:622a:5c9:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4ed813f6bf8mr2933461cf.2.1762389589412; Wed, 05 Nov 2025
 16:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105023925.1447482-1-zeng_chi911@163.com> <20251105044715.71861-1-sj@kernel.org>
In-Reply-To: <20251105044715.71861-1-sj@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 5 Nov 2025 16:39:37 -0800
X-Gm-Features: AWmQ_bn0SXD9jGQRU8p3H2zsdC-whATeFwUjvsd9nXkwe4AS233yuHUdZlfz2Y0
Message-ID: <CAJuCfpEyz6bbPa76fawWbAW=Wj6qDxo8v+RftYCMxE3iiGVdBQ@mail.gmail.com>
Subject: Re: [PATCH] alloc_tag: Use %pe format specifier
To: SeongJae Park <sj@kernel.org>
Cc: zeng_chi911@163.com, akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, zengchi@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 8:47=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> On Wed,  5 Nov 2025 10:39:25 +0800 zeng_chi911@163.com wrote:
>
> > From: Zeng Chi <zengchi@kylinos.cn>
> >
> > The %pe format specifier is designed to print error pointers. It prints
> > a symbolic error name (eg. -EINVAL) and it makes the code simpler by
> > omitting PTR_ERR();
> >
> > This patch fixes this cocci report:
> > lib/alloc_tag.c:776:63-70: WARNING: Consider using %pe to print PTR_ERR=
()
> >
> > Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
>
> Acked-by: SeongJae Park <sj@kernel.org>

Acked-by: Suren Baghdasaryan <surenb@google.com>

>
>
> Thanks,
> SJ
>
> [...]

