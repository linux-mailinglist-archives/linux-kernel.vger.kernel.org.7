Return-Path: <linux-kernel+bounces-855622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41273BE1CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E00A5350B39
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DB82DF6E3;
	Thu, 16 Oct 2025 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4bJPn/D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A432D3EE0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596947; cv=none; b=sTpbaDH3aD9uZgYq6uXq6turSdXG4RHHgW7o7ihU5TFrsR6Q+ovKuMIhUtTaQhi6Q7tMCmL3lwSAd5cFg2WkQaHnZNfbLWrdxXDNm2X0qCm6Ht1yO+3zYPz+8tJvpvY0Upjrj8o9KAiREvAWl9f/xoKCvl3OHH12lO1+ezOksOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596947; c=relaxed/simple;
	bh=Xwymle1RI5deN1YZysEWyTkaWWkdCc1UvMTlc0d69Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krMKZMa+kltRRbsGIZW6e6vcq85rcapFLfYuyoPgeY6Ay5YtVJT5Y1L3YDExECbkamgx7/HL93mBcvRqkNX9Enzt6hwSKX1jIbiWBmFS42Vr4MjWY3HBu48XyWg0UjTE9BKj3QbR24Ua5JaGGoOwnsr22+9WtcYZHh1AP/L9kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4bJPn/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3FCC116D0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760596947;
	bh=Xwymle1RI5deN1YZysEWyTkaWWkdCc1UvMTlc0d69Rs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f4bJPn/DpnUgA7kotw1MXERFp/4DM7MKCgNaU6MFBEUIc0ONsK0C8ggnZbDxnGrgF
	 tR2OtQxrBnPYCWinlOtBtwtDjSl020CPuvLETp5fANNiTf5Bfs6Hzdnoyl9CKyrtgQ
	 NzrcYMsDv/UemkZFTBxEg8VFiAxfpttKdmCV8dC8nWl0zkkLZay3Yg35RkRyqRTkyT
	 J85LosJyuWOck/ArSWO8v8f/gMj+bHLbA4LL5uK/xViAQyWaWRTYfCGAM5ZFR9Y3e9
	 Sb9riU0oWUI9afqOU9oSYVjpwZxELTn2HusteZWC1lYj7dzuXvGR9k8oX05iQj5nt0
	 9FsKAr7t4tSJQ==
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee130237a8so224018f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:42:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyL5uPqUtc7CVC/Ap8x8hdM5n0SLFJUvjn/Mt7Vn/i9Kd2yJox6XcyOgAp+SdKFmNnKdfYcBtxmj7CYCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6bEHFNuGJWXuA5r0XduaRgeDbzAMx40uw0eElgQ5IKsYrxCjd
	FaVBIGPIuh39kx7rGVT7IYGAaOKE8XkzIrUwf4M2mDyW1vhGgEPrWM6op2vSleCjXEPHNU9el1w
	Q+IJPHC2a14P1yj5/kMYGT5SE3PDwfK0=
X-Google-Smtp-Source: AGHT+IGMu6/5tkdwgl3TJA54YC+DSQnG+626+3ajWtF+4ixc5KZNJofj28aYCYE+Pd1fkwBRWHURZ3ViZoPyv4GSZyg=
X-Received: by 2002:a05:6000:2385:b0:426:d57a:da9d with SMTP id
 ffacd0b85a97d-426d57adaa3mr11257702f8f.59.1760596945568; Wed, 15 Oct 2025
 23:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015064759.2993842-1-rppt@kernel.org> <CAJF2gTTgG2DhqLC2B6URsNusjzcwCaxi-k=MUZTc1FTEHbaf+g@mail.gmail.com>
 <aO-O_2lhxZ8I78cl@casper.infradead.org>
In-Reply-To: <aO-O_2lhxZ8I78cl@casper.infradead.org>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 16 Oct 2025 14:42:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ0mcU56XKFcXcxDPv0bXGWm5WXHHpTP9YE2GK67XF7Pg@mail.gmail.com>
X-Gm-Features: AS18NWAu7sEuMJK-AO5mkdGBB98AzUtrOqZ7rI9LP75NnkmgevB_U4njX0yf2U0
Message-ID: <CAJF2gTQ0mcU56XKFcXcxDPv0bXGWm5WXHHpTP9YE2GK67XF7Pg@mail.gmail.com>
Subject: Re: [PATCH] csky/mm: fix build errors cause by folio flags changes
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:09=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Oct 15, 2025 at 03:51:53PM +0800, Guo Ren wrote:
> > Thanks for the fixup. If you want to go through your tree, please add t=
he tag:
> > Acked-by: Guo Ren <guoren@kernel.org>
>
> Why haven't you merged the original patch from October 6th?

Sorry, I didn't pick that patch up and just replied to the acked-by.

I'll investigate it tonight.

>
> Message-Id: <20251006-csky-folio-flags-v1-1-a91dcbdbf988@linutronix.de>
>


--=20
Best Regards
 Guo Ren

