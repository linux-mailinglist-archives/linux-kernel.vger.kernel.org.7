Return-Path: <linux-kernel+bounces-799444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1197B42BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7279D1BC7600
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6762EB5BF;
	Wed,  3 Sep 2025 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAMjJzOa"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7432F755
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934761; cv=none; b=P7S6xxWkaDqPuByVt3kWltrWltKfNS3jgN8765TxjnfWrsZmjwJjCuioCD2hXdbXLQGgajuP4Ae7O7mCio79JuQxEWZfeepHem+QrEdPmJ3YL5NIXAlT/oVUy92HqyhEacP/lU4wKJ7/xgv15PbiNgqz6gvXcsXxtnou3lAJ3B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934761; c=relaxed/simple;
	bh=jyHBAuDVftkRx0HBy4T7ggJt08EctxvHcJYcUPC2i88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErsXOu/K1H+ACoq3cBD9eGn149RNhb5N+VGE78OPK38KdIIqgEJMlaffbooi0iA4M5hmcUj5wbhfxLoXjgBAhh9H5llII6DZTTjGjRc33a7/WquqNiQoRNWCV6mJaA4VfRwiL4K46gpBQ211mRSFOlCCdoYK3x/c8fJScM9xsKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAMjJzOa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2489acda3bbso3394825ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 14:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756934759; x=1757539559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xEQt+L8Ho3n2dPxDKsBxoMXt7ItKZIAEGKvH+NsNm8=;
        b=LAMjJzOaIqEdVaPpci6dJE/0TNuTZsAGTvvMEQIjmvg8KcLsUhZh+FMYJwrA9WQOX/
         +kity5DCNVeabDifZU5MY17qNmUIxjY6Ph1l93uSbnUH3OXi2DazexyDePyNgK0ZKGzI
         K2aF6QOFHvE9+LVYzQ/pC2+wVQrutGlsMFTORYfLwywOGps7blAP7X0Zzq15BjjamH8A
         q+gopzWwI609s2g2CXKNprhdnMSX9oc4CXO+c4piuECJL7r/5T4CutbNfnmbzB1bkw6/
         mGKEQnhCIz6gDW+VARtxIr2qijWAU6rUvmJ6oYcBIzTEwJ6Gzdcgrm93e8nOrwrsSbeP
         5ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756934759; x=1757539559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xEQt+L8Ho3n2dPxDKsBxoMXt7ItKZIAEGKvH+NsNm8=;
        b=Y6AAeGmaVylz0+TvXqslaZYeEL/lYYxoTuHkcso++pEFKgMq4nmYzoAx/NPL+WXehC
         6E5znaLft7kjC44M5uv6bxCOb3foDhzSALyrHRcSYslqcCWOUg8O6wGcR2OquXWyfg53
         scqkv/URbTI4pHVm52z8mc00EYdRNC+diiYCKtzeyFiWF0Zln0FLznb6LXCGfieehjUl
         84gvA0OKNnkcV/AIgjUjrvYb0WkEIn5m0zdiFjcOOSdcBoGt+QkGTM7NV7YbmIErXrSH
         EGQstxmchWmfEugx+AIaSsI+GkjEjSrtY80Rybjv8GbN4rr2yA2+8Bt72TP9c/Cuic0m
         Jgcg==
X-Forwarded-Encrypted: i=1; AJvYcCVeVK/DxN59RZgAhj6u65BH8asXczC/p/ZwJJkZZc+qwXICNcfliVUyMMMuFUEIlE972G3LPDe8HmwWStM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznsABu4Eq+qI3h95X9vD66y+YVQcZukC4+jN2mpxkBih3+QtkG
	O805pJMC2Oa20I54OL6ZZnNbJomcYSy4dXz8zKTL+YkiJHJ8not9RYeFLuK/nLuBb46CyFkSP3j
	oAX8d4zFKbe8iQj6JuYABBMocwm1FsokoEAPx0AwS
X-Gm-Gg: ASbGncs4KQxS5PYRgQ9f64avposnH9xpYR17lQm78rSnWwEMzpU6VpGkeXRwrbLFAaX
	wT9Mzsq9GL321Na9tbz1L4twwtPXheYN7fsPTwolKMlC/MgKjn4s+a8V1iGUi9o9lhuew48AeqM
	7758G2ur6dB4yDFQlftz7Q1sh/kaTJdp+y39dMXRNR0wHY/MIsxAowSYnnmvwouvc+xoBMCtiob
	wGaSK9xww94y/85yvKO1yxldn9ksHwfJrhE4xaKQRzXSLER7BTkcVUfflySOkGNEg6jssa4mnFn
	MquGbLdYOLU=
X-Google-Smtp-Source: AGHT+IHRfpHto8LlfSXKfbZf0SFWi7fFWtwcv3b9CN/dPfI2rbOx8GpveZ1gaLb8oE0c41ec9Cq4gRO9FlgchlHavYg=
X-Received: by 2002:a17:903:ac8:b0:248:75da:f791 with SMTP id
 d9443c01a7336-24944aed0c1mr217213335ad.47.1756934759252; Wed, 03 Sep 2025
 14:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-0-ef3a9eec3ef3@arista.com> <20250903-b4-tcp-ao-md5-rst-finwait2-v4-2-ef3a9eec3ef3@arista.com>
In-Reply-To: <20250903-b4-tcp-ao-md5-rst-finwait2-v4-2-ef3a9eec3ef3@arista.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 3 Sep 2025 14:25:47 -0700
X-Gm-Features: Ac12FXz2G10zJlTs9-Is9rvwM0S7wxPXm9bN1bbgkTiJ4ZOjmq8xmatzEdvjbDs
Message-ID: <CAAVpQUCiaQ7yr+5xLYVaRp6E2pzNDwSiznEOkmd5wS-SAosUng@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
To: dima@arista.com
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, 
	Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:30=E2=80=AFPM Dmitry Safonov via B4 Relay
<devnull+dima.arista.com@kernel.org> wrote:
>
> From: Dmitry Safonov <dima@arista.com>
>
> Now that the destruction of info/keys is delayed until the socket
> destructor, it's safe to use kfree() without an RCU callback.
> As either socket was yet in TCP_CLOSE state or the socket refcounter is

Why either ?  Maybe I'm missing but is there a path where
->unhash() is called without changing the state to TCP_CLOSE ?


> zero and no one can discover it anymore, it's safe to release memory
> straight away.
> Similar thing was possible for twsk already.
>
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Change itself looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

