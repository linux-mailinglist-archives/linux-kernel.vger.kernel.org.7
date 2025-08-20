Return-Path: <linux-kernel+bounces-778639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B24EB2E858
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAB8189AB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D662D9EDF;
	Wed, 20 Aug 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UB9hHzzT"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A0284894
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730310; cv=none; b=Uz1Un5//IfQn+EHGA1zsT6WWCY6ExK5yUT7evhYtBODp7fVo/xCv4R4bShfH/lq6NiaTZINdhTE5ain2tbwAAjbNyrsbyUmSiTXnVRCQlwwlYAA3Qrmeldg936Wi9uqIr6bQ8WjntLYeDfTpurmwaDRduHQon3xpTxQbtTavnI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730310; c=relaxed/simple;
	bh=qvvuIz19HGC1hOLci1Y9hd0AIbbn37AkPmcNmEkMdTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Siymb3XVW8dLrH5lrkeGRya1QoPAPIa/mn7YyeCo5gAtnk+5dbvLpgRmcCZKYUChf5uLo849BExKG53WrN9mqAp2Tx+9ZZNvVchAnTGDIp6pR7JGmrSHpHYySA2uFUcU21+ZJ4Jzh4/+xhpsA0I6o815e7C4oOcPBAXZWebylX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UB9hHzzT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b29b715106so73341cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755730308; x=1756335108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvvuIz19HGC1hOLci1Y9hd0AIbbn37AkPmcNmEkMdTo=;
        b=UB9hHzzTaJmPUi9zCbIdPAVON+3+3T9QmJROyC2PQ3nrMT0+s0tIeoR64I/Mgblrc9
         GDojHAMA40aN+MwVZ5g9shjRDRjsRLdm4eawKMVlcFuSI4WdpjxfopegIF2ROhT760oW
         yOXiGhJwyOWTSi5rehdZOdxANknsr9sOVBbu+nW4kF8ZPNlzlt7NXhv4YLYOy93w/G1D
         /nwt35FAp2ViXSrWDwAGMSVTq5WY0N2x2cuFvGn/Vj0MbGptFJ+tkxWfgvTwDVsOqSAL
         JgYrc7tVllqK0d1p/YqgD0QsfUIE0jwpN+0EySRaqq0dH105aERjRXbHlM76+Hl6RIg1
         cZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730308; x=1756335108;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvvuIz19HGC1hOLci1Y9hd0AIbbn37AkPmcNmEkMdTo=;
        b=cl8dOnosvL7DpKvPnIAx7vpxFgKjwORZiWmvDRE6QE59Bm259HCqUPQZ9fCQDnr/bg
         TRKY7gM0SKp5rR0I9/mBvu2cPIn3HvsEWa/5aV8Eh1ehlbfzhTVZP9CiweoQErhpFYA8
         4d9z/48kz89udZZEth4H8Y85HqV1AjY9O1+/ohjgXT4Dm8+EPvI7pCKDKcnpBozrtPxn
         BVo/dMfIQoxm5a54N0X8a9yib+jSfzWivYAmBJ4QjRfxA7zdEZEhOiBGaHwwdDPSifCs
         vFevWXEVAf6MWuqF2i5Vk2pn4sHCDrB0RQFRW0b5ITsSFJy9Ia/hEahbdKJp9N1eDuj8
         AiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa9JjzAmq5czdCqGxFQp/SaiyaBnVGJYFr3NSBzYflpEWVcOF6xAE3QH0Lu+gMKmQ+A5m32OxNhX/kQ4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26Wo3WwPc2rTAnnvKjOaU/MkfTnZwMhUiqUNB8cgUf12KQbm0
	AHMfPjCn+4AI/3GTVAHj7jXTDapz28+FoG11K2zuPm0pDjt5rOOYJ/IT8VAZKJB68NWGApLnsFr
	EfaqOpkhMcunoV7B17lCxpOC1EsI59RuYjP05Y71X
X-Gm-Gg: ASbGncsdiu0k5ApRtplhtqpoHSB/hwbl7awZIbcYDd101hZkxYfntqh0aHQxl4HxFlb
	r1YZwBLX22q48jIve1lSqPalioNrJi0XcVgi/8tsitPI+KfYnrz+ZkxS6Bn7Bg46nw6iyz/tc/6
	GQn5mpLqzh+KTy+g6ygN09boNbnDgcEKfpUmkmCvR9duvHBDWG6VeZKSNb0O4nFxzG3fVaUv3k6
	GCxELEolIXxt2x60HbMGHOniX/hqeYBqKo6QG50VCl7vUCHhebDAI4=
X-Google-Smtp-Source: AGHT+IFnucqctbq+X2MkFIfcQxZd9U9ajSEePzBmifl2qKpLWyoa80CJHDHVTlJtgs6cetttll6Fnn+54EACtnz3c6w=
X-Received: by 2002:a05:622a:241:b0:4a8:eb0:c528 with SMTP id
 d75a77b69052e-4b29fa23c6cmr537741cf.15.1755730307790; Wed, 20 Aug 2025
 15:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820171214.3597901-1-dtatulea@nvidia.com> <20250820171214.3597901-8-dtatulea@nvidia.com>
In-Reply-To: <20250820171214.3597901-8-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 Aug 2025 15:51:29 -0700
X-Gm-Features: Ac12FXxgjSFgx5660hALKbajeFHBX9DsXuvcIjQ739CmkZy1azdx8SzH1hWqlKI
Message-ID: <CAHS8izNRcVcAfBBaDwZvPYrs4cK2NYqyXOq5+6sbsbSfpgc7Xw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 6/7] net: devmem: pre-read requested rx queues
 during bind
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, parav@nvidia.com, 
	netdev@vger.kernel.org, sdf@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:14=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Instead of reading the requested rx queues after binding the buffer,
> read the rx queues in advance in a bitmap and iterate over them when
> needed.
>
> This is a preparation for fetching the DMA device for each queue.
>
> This patch has no functional changes besides adding an extra
> rq index bounds check.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

