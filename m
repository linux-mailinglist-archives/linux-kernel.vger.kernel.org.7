Return-Path: <linux-kernel+bounces-774616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA792B2B516
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4648D18A1BD4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD827C158;
	Mon, 18 Aug 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEjs35mY"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AAD27146F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561030; cv=none; b=ozSM695SUvvBvqj8/J0AuFT85xqntZoEpgtvuWwcvaAoYt5VtIgkCmDZZeJLKobrDV1lKrqmz/pplNha/gEBPJb0wddtGXlufOQG2fDPI70PWMUsYkX4/Sw86GjXD25Pbf8zI/ycsKsnU8uCu03l6oeFhzZ59bTlsgCxaiNUwEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561030; c=relaxed/simple;
	bh=LcsNuZAmmSgBbn7Rx/F0jKuldnOTvv9gOB0r7oIHRPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fiw/b614HeKVxeYBpNphzKFQFN1E/SK6DQdUqp5ZmH3/hJu6Go1iK1klzwmeKKveOBm33G3qVlKtEYa6TjXI8FX+6HQ/CadcCpkbjwWS+czSn9Z6/OoUudT2nsxe1SCI7TAF88O8sI6F/UeqZfMJKSG6aJ505ZA/C0e/lvVx5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEjs35mY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55cef2f624fso1979e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755561027; x=1756165827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcsNuZAmmSgBbn7Rx/F0jKuldnOTvv9gOB0r7oIHRPo=;
        b=kEjs35mY/abuBvRXcO10QPH8S6ZRk31NPSrdR0MCCAQkyIIOAv/SfHtJ4N/US1LPef
         i/I8jM0Mhxy1gBQ0AzsabvyDg8xjtqck/Nfh9Yx1IZv20xHuokHS7WLRbTNmYN9BUDil
         xwh1f8zGh7cEjQhwq8p8n1PGZ+HMFyvCqzZXCYhunBemhUojKo0yfHyFOvzj2McBqINc
         pPrxjwXNu381/fHTr6R50CLBIJfn7UBbKeDdUxmyAMpMH38GONFiZwgjtAgwDkj5PeA1
         Vz4vhz19VZ2UESv8chQbJ0WP9FyBv1m5C8qBhVDMHHABH9RQd8c46T/ZJ/8Guhbqvf5m
         Y7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755561027; x=1756165827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LcsNuZAmmSgBbn7Rx/F0jKuldnOTvv9gOB0r7oIHRPo=;
        b=Nx658Hv/W8eix6SvW0t40CRDgLybnsR/suhjZFM76c2fRLPCq9393K3V+xBI2jqe1G
         lEcdnnBlfUBQ/GQ07V9FNii/flETsWg/ya7FRVBvCxh2o/YWLuKx4y1hFsUsdipzycek
         reqU+giCPPennV7weEJo42tB81CGhNABiIUMgvrZ/UIzroCSn7lqEREryOB0sjPLGk6u
         dqUHp+Ff7TN6rIY4zT83eOD8zqZQvcp3RaytEMnfMc7TLLkwH3Nho7hZALaiQK3YDmvq
         cVmoRiwzVeSEoRhwY10CgLrscwb+wHdGcDZoBMmTePOLCp34+88FwMrv6vKBefRgKAi0
         JgZw==
X-Forwarded-Encrypted: i=1; AJvYcCWG3saKSopdbf7YPiE81QBuflo4pHNXg4Lv/0GHAoI5wu1YJ3ZWUZUXrABaTjsV4spiPHBtgxbSlLA+arQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm106ArGMEjmM/r1WBtzAqOCKyeqdkdPuzIyCK99nAeXAGehMa
	ajL7VfmWAbgJn1yvUyOeQi8Avz3Np+R06UKwWEbnUkKsOL4BP4u6JnuZrRf2A6warq2Ee0BIaEr
	VSH+dGs8hp922UdghwM4sxDpDfqv2+LrycwJ2+ILs
X-Gm-Gg: ASbGnctJSo0CKSbxNjvhE011Nxz9+d2BrFYA+SVpItGuyHVp7OGEN3+zirkoM3wxmuf
	O9yh74dVo40PemCNyBPvFMazhRsn9yVJtdpNdCSSVVtc5kbvY4ocT5ZK8qrYY7sYAlpOMFYiLXC
	CFkcdtWpMiasOGODPQsEQZFlsExDhfbGGqqj7B8qyvN1vFnsVJ1NG4Xs1VP4oagAGI9i2pb8byy
	R480IxP3Ww06g6osYwvQuy+Qljuq85h86ne/rqYup2S
X-Google-Smtp-Source: AGHT+IEz9461t1FLeYjqAPV9IC+YLeWd69snIPkzWT8jdh/N0oHfH1jree3Vr3yZo117hlh5lONNshD+tvF4WSbIHxw=
X-Received: by 2002:a05:6512:250d:b0:55b:7c73:c5f0 with SMTP id
 2adb3069b0e04-55e0095dfb9mr92067e87.2.1755561026720; Mon, 18 Aug 2025
 16:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <353e0195a0f44800c0b5aa4a6d751d3655d9842b.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <353e0195a0f44800c0b5aa4a6d751d3655d9842b.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 18 Aug 2025 16:50:14 -0700
X-Gm-Features: Ac12FXym-AdI0-6m9FtombEI_KXbKYd4WM0Qi3aWvTpPx0DSoGpMt0F2tRTsGrw
Message-ID: <CAHS8izNEVecwoh+f1nUBmTOGHKS+A6Up8R-0KTFMSwPn4+VzdA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/23] docs: ethtool: document that rx_buf_len
 must control payload lengths
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Document the semantics of the rx_buf_len ethtool ring param.
> Clarify its meaning in case of HDS, where driver may have
> two separate buffer pools.
>
> The various zero-copy TCP Rx schemes we have suffer from memory

nit: 'we have suffer' sounds weird, probably meant just 'suffer'.

> management overhead. Specifically applications aren't too impressed
> with the number of 4kB buffers they have to juggle. Zero-copy
> TCP makes most sense with larger memory transfers so using
> 16kB or 32kB buffers (with the help of HW-GRO) feels more
> natural.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

