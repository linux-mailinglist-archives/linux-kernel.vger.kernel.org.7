Return-Path: <linux-kernel+bounces-725268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87944AFFCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785201C861E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A029928D8C2;
	Thu, 10 Jul 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FYLR1k1l"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6BF28DB49
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136952; cv=none; b=pWLrAa+OvU/oYlhZN10FxB1FmrOKwaUpneBLDBidRwSoPHCG4NaR+D0ldjY3bigfy4HXAIDtjpg7T6VzT3sOWNWQ/lBIgtntwVDaSTBrf5HYrIYmVXibkNJPnyjhLOfY2oMccSAHnSaBJa/0QdJmpgP/RoZBnn6Dm/NX8Tmqf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136952; c=relaxed/simple;
	bh=um4EKtYn3ZwSbNfVcZhtD/u/A8h869sBadoquzfhOCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlRJoE50N57zkjSd2DOFUl/dHcNTnIhXw6PZfOCuMd+FfEpRyos8VQ584RJIB9vidm155JhTK1Vlspgpnj23zDm4lSKdt3SDs320JaMvoI1lBsgYl1mZDZx8ZdiOQFhooHjSYUKZSASTnBrIY16nUch/loJc7rwPQ8Eo5aLpLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FYLR1k1l; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so5294051fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 01:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752136947; x=1752741747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbMjrJbm+vCEXbCzlc+pe2ZZgUE7LGCN4UW3uV+MEfQ=;
        b=FYLR1k1lIpqAAhHdy/DuCpWlTZYMDf36jK08E4Aiy6e8Qp1WueacaObbssQcodHWB6
         DXw+Ql++9MvFnpeBn75hvozyb2e22FVSopS2/eBxrjgwsjW3mgA9927I6r8Ra7cQrlBs
         MqoFtsBCWA+5CoIHhGjNwkJFO+SqkdLA9F6Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752136947; x=1752741747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbMjrJbm+vCEXbCzlc+pe2ZZgUE7LGCN4UW3uV+MEfQ=;
        b=ApyMVYUUt5TXsxWYVPy4JPdEhi8pqI6EeF8C46GTCcNpDrouDIOFR4TiB+FUvcpXaR
         uBy+FSUU7gXHMj2n3qCb3vnSIbrlK0eFzpF4oBPOHOvegJ6kccUOnfUa6CdaC0AuyF99
         9HbCyzWmH5Fsd2Z3VDacDQxFoYMEHLzpbDK5Z4jYpqVJfhlDcu9erhqRQFAMyS4wA1ek
         AmKmbwD2nDydve22KmkAQVlwAai3f77GjdnWoo/lpwiiwd3fZbQYNYYFpEldhWFaJKhK
         3hUydCia4qUPbGON9eP9wBsuXMtz/biHJhuYW7zbeZpZnw3ZPG/bp6hHBuTQJHknsj7r
         Uppw==
X-Forwarded-Encrypted: i=1; AJvYcCUGR708UtOk0LLUDLxhztTBSc/5TeEppzwp838zD1cz+qvZ5K0XWYCFYkiRHCUB0ZS/HS1Spg7ZYhfHl1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyle+gWwmMbVthcN6qN+f3SWK9k2KH/Yahq8Tyqp8AtAWG/hyxx
	k7a1p+k0SL/23/uQuRd8X6zG0GiXph8BM9j/uPCVUgQmfffrEiiJSFpb+H9ai08tyTjFKw0PPrt
	2ebRQgKr1Oehj9VjmKVwANyMX//4Z6QycKIJLd94w
X-Gm-Gg: ASbGncv2Tp49VAB+KGjShectn7xaRIoCBIy4VcepxFzqHtMHI4tDfM7Re9t0GuZSC0G
	74/WBgG4Dl0cmBVDbZba7nQcuu8y/70C3MOtBwjCk7LDWLJNHm0WYG3tr6eSJe23W2W1xYMUoex
	khUrvFzgUk4MRehGhQbbqyrSO7JDzrZcoAYCYtLGc+Qxq21Yl8ZZeA81KIoMR+GnxgxLSyGTo=
X-Google-Smtp-Source: AGHT+IH98HyUSFcxzn0ZLDTDXzcG2xAq4tfunT0Q0Flrc8e1qgVm3bYMsY/33vj2EMiqcDSWrQ5h5u7h7vcdWubER9k=
X-Received: by 2002:a2e:a99f:0:b0:30b:b956:53c2 with SMTP id
 38308e7fff4ca-32fab95f588mr5305791fa.11.1752136946822; Thu, 10 Jul 2025
 01:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610063431.2955757-1-wenst@chromium.org> <CAGXv+5HDAZ-MBBMk00O+cdcq55KnsKdEAMD7E2uaAf=2LY=1cg@mail.gmail.com>
 <5ee16a72-01a0-4f2c-9bcb-e4b4b069b2dd@collabora.com>
In-Reply-To: <5ee16a72-01a0-4f2c-9bcb-e4b4b069b2dd@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 10 Jul 2025 16:42:15 +0800
X-Gm-Features: Ac12FXxsLgCZAUA9cokLqBFuaQ1ZCvwcmNm2Lv9LiZZijxwC0ttVDjqCnXtUfEA
Message-ID: <CAGXv+5E=xLJg9Y4OProhrH3ROy12J+3gNc3eiebGeJuEVEq+zw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] arm64: mediatek: Enable efuse GPU speed bin post-processing
To: Srinivas Kandagatla <srini@kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lala Lin <lala.lin@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Srinivas,

On Thu, Jul 3, 2025 at 7:48=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 01/07/25 11:15, Chen-Yu Tsai ha scritto:
> > Hi Angelo,
> >
> > On Tue, Jun 10, 2025 at 2:34=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.or=
g> wrote:
> >>
> >> Hi everyone,
> >>
> >> This is v2 of the MT8188 efuse GPU speed bin post-processing enablemen=
t
> >> patches. In v1 [1] the change was made to the driver. Angelo, the plat=
form
> >> maintainer believes the change should be made to the DT binding instea=
d
> >> [2]. v2 adopts Angelo's argument.
> >>
> >> Patch 1 updates the efuse DT binding so that MT8186 is a base compatib=
le
> >> with no fallback, and MT8188 falls back to MT8186.
> >>
> >> Patch 2 updates the MT8188 DT to follow the new binding.
> >>
> >> If possible I would like to see both patches merged through the soc
> >> tree once the DT binding maintainers give an ack. This avoids prolonge=
d
> >> waiting for the binding changes to land and uncertainty about whether
> >> things have fully landed or not.
> >>
> >>
> >> Thanks
> >> ChenYu
> >>
> >> [1] https://lore.kernel.org/all/20241223100648.2166754-1-wenst@chromiu=
m.org/
> >> [2] https://lore.kernel.org/all/11028242-afe4-474a-9d76-cd1bd9208987@c=
ollabora.com/
> >>
> >> Chen-Yu Tsai (2):
> >>    dt-bindings: nvmem: mediatek: efuse: split MT8186/MT8188 from base
> >>      version
> >>    arm64: dts: mediatek: mt8188: Change efuse fallback compatible to
> >>      mt8186
> >
> > Friendly ping. Please take a look and see if this scheme is to your lik=
ing.
> >
>
> For the whole series
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

Could you merge  the DT binding patch so that we can merge the DT change
ahead of -rc6? Or alternatively could you give an Ack so both patches
go through the soc tree?


Thanks
ChenYu

