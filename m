Return-Path: <linux-kernel+bounces-887634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A85C38C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198901A24CCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953262459D7;
	Thu,  6 Nov 2025 01:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/LN3e8i"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5822144CF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394187; cv=none; b=uZ+wuoRO9YAh7LUF1/bNLhIRGujRVQonBLtwg7AxGr20AfgbbFsGUn470ud1fGpg4xmzBfc9JntsxMgJ6Ht9Nqhf9Fj3YqSCl9B3UeTV3VP5wZawv8gVd3DAp1xATMw5mDKG1KgfTZEMytD+WGbVPz9566IS3leNTldQrUC56YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394187; c=relaxed/simple;
	bh=jLw7k/KAz5FUEjGhd6v3ts9iOCpt5gHWAPtf5CRRl8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXBuxv18bi+KlZfdJHjlad0L2OmC/bAqpC7Y6gcPnsThL4lmpwEOjVGTOzhl+VFUYxc9uswpNl+t8i+GXrvefRDh8d/Df47EeOb8FELZnHO7J30082bJ51GD8Z4cZ8A/5EI2AdWvzknlORblg/QBb2eFCs2w3Y/yIN5FObbYPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/LN3e8i; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ea12242d2eso94401cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762394184; x=1762998984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUatHznZUYVcukINaQffbDk6qMtXMnZNYeCcDgim0vc=;
        b=H/LN3e8iVZU1vF8Ko6HoNITQ7O0K/zgXfrs0Wxo82wsqa+eUtEh5cE1fUl6wPJNspH
         tF7Y2ZDBKCxgVTr1NGmiQv9jWuK6braoULKx/HeGHHWOmPRJGEQEB0Y6fVfuwEv/sjiM
         whuoMfzIaZ5ayaAAdUvYhqIoueVIdt70xGglZisTJUwjxAE6TJInnTR+ksyy+XuTnwRz
         V7bWWIB2nlmnbDGVtdFYhwdcQ9t4VCb6lXHUElTwRMxd+fZpmqYQ/SUJRyoAjbBAtYha
         YVhJ/4O8ROjLvQtTGz/F0mXRMtoFkUdS53vP435+1WD4n5Ag64BNkg443NhiSspUSVEN
         R/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762394184; x=1762998984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUatHznZUYVcukINaQffbDk6qMtXMnZNYeCcDgim0vc=;
        b=pvzhSuaNhOaWvurNs6xePlysTNXHYUXt/RudOfpLHNptgPPqLXiWssUyL++iL5v/8H
         AkQajGwsahvVWMkpubL8osjSnxryatX8RApftiChDdIMzEEODVz0iYci0YaAubI9JgX4
         OwZ6RGLeFvBHCChMBYdf5FTPQR3KlaUYdPkYpjm7AN1oP0isebcFyASvsTP+FyCw31Q2
         mqjKRc6Twm/zAqTl4U6yKCvZMa6HhXy5Tgk9C8wuOt3+jvAoHaucEPSg+ADUSMPpa53b
         i7cF5ytdy5KD0v1G1i5rH5IZYlfNC1HC7SZmy9VAA8uvRNjyw5g0gg2ZTdQ+p1aR+rui
         gpKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkfp4nmVsYB+l4rz0Hveqa/xINuvOslXQrafwpAtS6xhFZCrwoc6Om0EFgf6qhJ/WEZ+OQPeByWHuxQb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZMz6Icoi5VR0LsrrX+FddOeZOQ5bTQB6f7qUGK0QQ6EGgYL5
	eRztiHppID+PXrxDE0V9fOiCLb41KlggkyTEXeXjPJFrXwS40oOGSoZ2qrQNr3YjgA7/jOX/hxm
	HLjuNFtgD64ghnNmvqvUZr4msWXPIupyDvgAHHc1u
X-Gm-Gg: ASbGncvTofHp0+48afwavLH2+A5OirYG2vL5aQ/fxb3HQi4fxWdM1aVKRVdkPhyfpiD
	UBMQbYc229nBlhpH14ly8ajqxdGO1BltzIIO8lCdWaDfBGkBLeJ/qpQI5A/ynVp1pRZcBsVYVIt
	dZ1gqRW0bVu8d4Sgil3JA8Xg1IelrJe8/Sb61WA4xTF2kp1alfaWqUctxJJ7EiH9/UCt27HpwlI
	GDdoA6F5DsKM8mIOUJqmW/S1nGlr56uQOQnokJ4xKld43zXGQfBhRIcpyoyuyDlb+1RYD9RDC4E
	iBR+Z3LTxsZmlW0rxBAZ1/P94vCu
X-Google-Smtp-Source: AGHT+IHibGvmFnDlfr24rRt2tIra4G1k1r3PX3TWXENAKkaEvVbOFGfGF4YxKvcB5vtfTr1sBaCrevD27B/Da7aRkrQ=
X-Received: by 2002:a05:622a:15d0:b0:4b3:7533:c1dd with SMTP id
 d75a77b69052e-4ed82b51179mr2027741cf.1.1762394183935; Wed, 05 Nov 2025
 17:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com> <20251105171142.13095017@kernel.org>
In-Reply-To: <20251105171142.13095017@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 17:56:10 -0800
X-Gm-Features: AWmQ_bmWD_sYB6gVzqw7Ayfki29RE_amHqVThrUXCC1Sw1ZxmeZGu81hIcUYDwE
Message-ID: <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 5:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  5 Nov 2025 20:07:58 +0000 Mina Almasry wrote:
> > NCCL workloads with NCCL_P2P_PXN_LEVEL=3D2 or 1 are very slow with the
> > current gve devmem tcp configuration.
>
> Hardcoding the ring size because some other attribute makes you think
> that a specific application is running is rather unclean IMO..
>

I did not see it this way tbh. I am thinking for devmem tcp to be as
robust as possible to the burstiness of frag frees, we need a bit of a
generous ring size. The specific application I'm referring to is just
an example of how this could happen.

I was thinking maybe binding->dma_buf->size / net_iov_size (so that
the ring is large enough to hold every single netmem if need be) would
be the upper bound, but in practice increasing to the current max
allowed was good enough, so I'm trying that.

> Do you want me to respin the per-ring config series? Or you can take it o=
ver.
> IDK where the buffer size config is after recent discussion but IIUC
> it will not drag in my config infra so it shouldn't conflict.
>

You mean this one? "[RFC net-next 00/22] net: per-queue rx-buf-len
configuration"

I don't see the connection between rx-buf-len and the ring size,
unless you're thinking about some netlink-configurable way to
configure the pp->ring size? I am hoping for something backportable
with fixes to make this class of workloads usable.

--=20
Thanks,
Mina

