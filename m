Return-Path: <linux-kernel+bounces-778637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1602B2E851
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6E35C2C61
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004852D9780;
	Wed, 20 Aug 2025 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjWsvsE7"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03B918FDAB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730151; cv=none; b=Y6Rb5CZrKgHfF0Fkb2Qk1I6QV/Y1bsCaABcVoKltttvkmhyLwGTK1lLaQZYqaI3c6H20nWzIzRwysanvcANMi3+F72ovSpfrnWxZ/MqShMO8vLkOBKkmyPEBBiTFeRlzUpRJqMB/cnvIr5UHbBqNp02tEslVPUhzzzcOzzFv3cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730151; c=relaxed/simple;
	bh=D5XMdSUaoflvoWDHrYNuRLgXNYvL1UIYdqWuCZ7I1zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNGPJCETwtCJFzb14dF3iDuj7yNFQyRxrGKGbS8fybWEJON7PELiRucaN7j0huHV/jgZcnnYlJvYclBpxkWXygeRkBm+hEN2UnMXjTbqNZshEceA27C9sWFrmG7s5nbFkB0lzMyUV0VTwVb5lLxm8gpM1MFUGsFEkr/Pg4qU5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RjWsvsE7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b29b715106so72591cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755730149; x=1756334949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5XMdSUaoflvoWDHrYNuRLgXNYvL1UIYdqWuCZ7I1zU=;
        b=RjWsvsE7yb7wZZOS/zb5AFBNhs+5wwj8zWWE2NKlv2O7E/0i7v7mhpVn57H5Go734U
         hqdTSnEUH/GOjEac7hFqWp8BACQEoal9V+BChJdjq87iUcHEAIP7giE/n8+4o6gzsxfd
         dY5OQXF5W8vmsDbpcIhwBMWnpw9298jIZIAwVTLwG28u9JPn0+Yf/S1WRPrhUTxa24tB
         EwTt7Ki06qK0wz2Sgejhg3ncPD5GzgmpXhvvjVA38b2/i7EV7RtbXBzyVzXQXoyZhIsC
         6fC0K6zP4YNAFrBi6mM5QP7xaxCGcsPtSi873/1N0karPz5cNcTvWIcOaRp+VCQvhXha
         ULRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730149; x=1756334949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5XMdSUaoflvoWDHrYNuRLgXNYvL1UIYdqWuCZ7I1zU=;
        b=IrQGyLwc32cwcB7sReiiqlkQrYj+BPXqmBqiyQ7hbMWxUuLDYG4z6USWRCKYmWEdJn
         2h0G9Hnf0jkNTUESkMtzVU/St85brZu1lrExt8yiu5jb6QbKhZwinP26wM9NnDxrCd2y
         OgauEDwbtFbNIivijB+3L5aVtgvkkSsf4sNq9tzdv5ESscuHAHYsCu4zldLfrTgrQeHJ
         g7QlCHqLTuoWwnd8tLeSnc89GmOn0zCky+291QcVmlIa/NaMKjE4fEG1kq23hQkcB5eu
         G5jss3wkcLNTL6AjWO81HGjpz9Dlm+0YzxK5nTY15RfNf7RU8BPsys+s0kxqpXuEPAHy
         ohxw==
X-Forwarded-Encrypted: i=1; AJvYcCWyiYRHdBugxx0l5cvVnpxYrIw9CMHfPhqzBphYhu08uRPTmOH5nPK9uL9A+npcW3TA+97lTgluD87H3+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGx1CtKjceYvep5FD2G2+TJ/uM2Nm6KOXPKKRKrPPjupRvndws
	rK1f+UKgAdD03JeM2XVZ4OxUU1DEtSce+U2B2+1mLzOVgED7yFboWqpjGhZfkjscyC4oMv8CSF7
	tAOC1fJfshDiWwYwJIYAVREpnHiME2CzwBi1bBfF3
X-Gm-Gg: ASbGncsz77qKGzo6yC25P6xc6m5zmrlWsXhlNf6R8vdiuEafUxYolOyGLsWNAD8YxDZ
	0kxe47oovKxLAdeY+qRnzMAsk9HHLX2w0sgMYBriUpSCYDHnz3T/2iqBVdc1mekgzwjPuhNTXQ6
	cCRjXDLhASAeV5mY4ZmPaECGX99vSp+1V4G/RPEsYTw6nYWVkcsgYDOi9eqiO4RXLL/BlXVD91u
	hrpMKmtZMLIlKSRhirHTtSSeBq1iOD6UJk2Qu8iHi9D
X-Google-Smtp-Source: AGHT+IESA+eP6kM9nwktT60dNHPMQb0J22hBZaWkw6tfpY+brU5rfimYiJQUSNMYeIZIN8n5YRzXVvto0cY6pqWxHH8=
X-Received: by 2002:a05:622a:c2:b0:4a5:9b0f:a150 with SMTP id
 d75a77b69052e-4b29f790b96mr833291cf.16.1755730148497; Wed, 20 Aug 2025
 15:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820171214.3597901-1-dtatulea@nvidia.com> <20250820171214.3597901-3-dtatulea@nvidia.com>
In-Reply-To: <20250820171214.3597901-3-dtatulea@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 20 Aug 2025 15:48:32 -0700
X-Gm-Features: Ac12FXxVnl6sM0_WZDKM6qKI7HAYHIkAelNoq7Ld4ak_A5zT0VD-rswwR056X4M
Message-ID: <CAHS8izNto5Na=jAyXhvm0ocL4mA0pUXmXMcn4bwnNvQbA81hzg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/7] queue_api: add support for fetching per
 queue DMA dev
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: asml.silence@gmail.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, cratiu@nvidia.com, parav@nvidia.com, 
	netdev@vger.kernel.org, sdf@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 10:13=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> For zerocopy (io_uring, devmem), there is an assumption that the
> parent device can do DMA. However that is not always the case:
> - Scalable Function netdevs [1] have the DMA device in the grandparent.
> - For Multi-PF netdevs [2] queues can be associated to different DMA
> devices.
>
> This patch introduces the a queue based interface for allowing drivers
> to expose a different DMA device for zerocopy.
>
> [1] Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switch=
dev.rst
> [2] Documentation/networking/multi-pf-netdev.rst
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

