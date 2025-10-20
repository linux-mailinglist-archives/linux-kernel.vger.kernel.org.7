Return-Path: <linux-kernel+bounces-861483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F129BF2D83
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0F794F61D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D62C11C5;
	Mon, 20 Oct 2025 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRlIXWdp"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5336B332ED2
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983214; cv=none; b=SHpvVdnwdcZOVNke34q0lW5xJXS9yNvhDozBJxzkbhcjK65tLVkUsN0KQ64gdPx0HYELTvlgYCQ+gxjf5pr9uesuRVf8LTTaXLyIWxdOOpSC2gy+eenJq4qfxnTsqI36rX3LjihSjchdljWKdgK/8ZTYLun7BzIpMubvPuVX8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983214; c=relaxed/simple;
	bh=l0zP/IswWls5tUEjRW4gHHMAJEe54gk5KhQpTRSbZKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3zT6KujqLC+xGCJnB8lhYIeReHgLkN/+VtSd3p2xB1GWeae4y5t0nkwerit1jSQkVUB21fUxJ41G2PwoW584GkIbNtUdPKjYAyEXMDgJcmPB9HsESOj1f0aW2yEkg5xFr2/yNKeW0ywUEqJVivtOe1vZUVbsGRQWUC7jF52AFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRlIXWdp; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710022571cso39574615e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983211; x=1761588011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0zP/IswWls5tUEjRW4gHHMAJEe54gk5KhQpTRSbZKo=;
        b=YRlIXWdpXZZky1S+VQYFWxgAgiquk2WWTh/sda9oeCfMLuXyqlS+0yqkVULqXq1cPV
         HXdf5ySp//CweUuNbjJpvU/jD5Tick/tuagMhLeLRIEh7Gy+x3EKRK6fnHmc2VcHxlbk
         /axAyceLgkAZRBrVLX0FSSH73ctUd6tNZvBEP6UiA9ULz6ipykI5qNINmnLS2slp243G
         BwvmlA8qv1C8Ow5JumRFcs8RuMr9exUZZnVrWZdd6IEBtiOXvAqUJ/iO+DAXFQ0g05Od
         NCwHy9Y1aR8STwfPfi/u9PNn91Wujmm2u2mWfCsdXRhf/fJuZIZamXkYtsE1TDTS2Kw/
         8v6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983211; x=1761588011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0zP/IswWls5tUEjRW4gHHMAJEe54gk5KhQpTRSbZKo=;
        b=wZZzRFHvUp/jgikRV4/KeEahBmvv+ngOJBdgnUqcZZNIbTNa1DRISiGc7gvcGHb0hS
         FpgfPAi9QxUoVvugWTA/hH/vQPCtgjgtgRSnICk/SDRPCXEluVJezn3OiObi9MB6kHqy
         9MHkhaE8PNrsImIoF3eNV46K99mCFFXPJxHc57TJWHuwcIkYcMECi0/j7YlKf767PbBq
         fSBXZvQvj31Fw6v4WqOeZU+eHqAB/T4vuCwIGDdj+akNW25H1rhTADVxoGo2CHhHBJtI
         NR2JSrGGKOUSO3O3oD6P/ObKVRZpMJtXj85IKGrYvCevxbguC7euxLfzZWGLfIb7iAY8
         +vrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+XabWRBZrxusC9379w/Mh+nz/b02TngagJb0UUagziZWlkWcVhPUs6CghTUcdOqo5RSQQ3jWtntPhxdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKm8byBXoJg3SGBfDYcXMCsGrG3Qed9IlmlER+3Tv0cik6PVk
	ZTM7D3K1suOSdl824Qe3K05Dp/W85SWbjAx2qSkhw5QHzI6TEfhGYqJx
X-Gm-Gg: ASbGncs7vYbV22/WZE+m9OvGVPQJgpwWuO4whiSc8DChUyrZqfH9Okc+qnxV3S+UAZL
	YbYPyG9zsdKKEC5FkAZ+3qNzF8QOLOBhroFcTjqHeCq4LQ64oPo1Ut5TU9RnTAwF53QdfqGMHWi
	Z/1pGmaxFYuWPAECbN3AI83qi0zCbyEZv+LQwBh+EmahLs3MlpcYkijPk5/RvNGPvDKB9FZbR8k
	Pl0r3lEXY48R6NW0Eq4NL/rkJPLp5ghc3tMatXi9t+OvqGcHD2QW2LHO2hO2cxJ1FZ8MxdYLgc7
	dUYL6DbputzljmqS7loMBNG5TeFX55gA+XhZ8/D/kDSJCZ8BtndjDDIr40WCxwYLOiHVUmhomIs
	2n7ye99g4yFcVfpoX0uLOtszEipvo3K+ird+IPh2jiNO3lcjs3qjGYSaGkjVUF4EbNA2b93yZLy
	REZK7N3UwJN+FUt/rwta3qrA6a17WBjpkV7IQTx12swI0JCuF55cEmuHcfnjsWk/KUwCo=
X-Google-Smtp-Source: AGHT+IGVeYcgA+CwUr1r7hUy/8iCaT15cDHaEmoGMtDm9YvbEjOd+dz5rkW55YdwDONL4X5PTcG3yg==
X-Received: by 2002:a05:600c:3b8d:b0:46d:27b7:e7e5 with SMTP id 5b1f17b1804b1-47117917572mr126637915e9.32.1760983210516;
        Mon, 20 Oct 2025 11:00:10 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144238easm248496085e9.4.2025.10.20.11.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:00:10 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: linux-sunxi@lists.linux.dev, linux-sound@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 10/11] arm64: dts: allwinner: a523: Add I2S2 pins on PI pin group
Date: Mon, 20 Oct 2025 20:00:08 +0200
Message-ID: <9520278.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <20251020171059.2786070-11-wens@kernel.org>
References:
 <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-11-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:10:56 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> The Radxa Cubie A5E exposes I2S2 through the PI pin group on the 40-pin
> GPIO header.
>=20
> Add a pinmux setting for it so potential users can directly reference
> it.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



