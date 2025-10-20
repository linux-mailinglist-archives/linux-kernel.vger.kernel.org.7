Return-Path: <linux-kernel+bounces-861478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 645DEBF2D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C29424E8223
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762AF330B38;
	Mon, 20 Oct 2025 17:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3yeKzs9"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38F32ED59
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983123; cv=none; b=iLTBYPjjrpCBJWaC9R6fUfHrN69fL9U88+rTUpwxNV5ZB1dmjNyi3YCTE4Ime/vEHi0wNTPJQGkbLbS9+5C8bORNMUU0psH3q2bQ8A84B47BhqhgZLgI7twBhLDfxk+yBzF9NFKOZrTopwyoq9whKSqNdSUmYPkvPxUWJdMKaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983123; c=relaxed/simple;
	bh=V0ywM16huaA6vxoSrQo9VcxXEvOPk2Rt5CdRZIoeNHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MbVkQhQKyh1FCim2cF+SHTJStXxPy3LR4NKk5AM4IHVvWWeE+YA6HnUvD2YdfrdZhTZYGXGAMIsO+Xa2W82DZtzsNzFhpoIsk7UXDuZeNiXb6Zq2AJ1INZjtyMPMqLZLUl0WExpYByCkEZPvj/Wx0D6zR8GWhGYcUVX2bhUuovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3yeKzs9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4283be7df63so1239231f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760983119; x=1761587919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0ywM16huaA6vxoSrQo9VcxXEvOPk2Rt5CdRZIoeNHY=;
        b=c3yeKzs9FPBDpm8NfVTZjIYNE6HCojwEl7itqNZrHDIWTKGQXhd2ltwrRkFF8QCtQD
         Ny9+scbR1rdywhRHMBiNfWPOQzcqGGadc2c+aHUcB43siKJXSuLZyUBYOzZ36lTOxwnj
         ibGvhkO4KHt6Wgi7t56hlv/L877HrL3iq220+uWlidFv6c8QZEzaCv0/O/SdWbvtYuk9
         tv09hFo9/cjPwzt+UEzVwEWeWPdOH3Bx2HPjCIEb89ZOSZ6Htrjr+vnlHpwy8FcnTNyB
         WuHdhsRb3qMjs3lH2jtsmBPiCxoqZLJ6xH4OHZh/7TodH0DycyKrwd7fMJSJuOPVz8M4
         sfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983119; x=1761587919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0ywM16huaA6vxoSrQo9VcxXEvOPk2Rt5CdRZIoeNHY=;
        b=HCpDTekpP4fuJMbqYmsHEmvwz9yxcVJarw9aWngMOSs7M4K54DB5DmVqx2l5+VrA9I
         K3/36kPcwVHsYb9F5GbkHns6ad7oRcq+c6cd9UApkDMBCxL+vRxT2FvIuaKAWdEYF7zV
         CbWbaE1ZL3WxoiF5CRqTy45EWT7JLtq2MTmH/AjW3N+vG6bIZgt61TMEjW0DVKNhS0Am
         811ssrCQtsWJbVyrja48RvdyNsyEGM9SHYGUQP53o85M7h4a7uJZKIwuJKZJc8kKaSmt
         ARdiWw6Giqd2+pFMyyx+dSH5aReDYeNy46GXJOUEZuCr/hw3uG8MPl7Ydc+qYqAEJD4b
         RGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTOf3VWmGW5cbfcQfCupd87lKoPrvRtOx526vb3RYI1Vcsp2HF6ldUmcfGh2mQlfAWOcESt8QD5r5cXfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+nKCM9lHlKmu1QbGYn873qoasQ1Y1ACuRuX5bR2WauxtIBuDC
	A4KyYz+42CLSYXbPeN1Vtj1at8QumEI7xqFqD8lTUj1sVXdm9jPAJ+D+
X-Gm-Gg: ASbGncvvkf20l9/by2SKcBXWR14iz/i9tSArEJFhfKNwChoXQMK948ab2OkdytxnHr7
	h0GYSxDG2aUtWMQI78MApAT3wWGwErzBuhGS1yHeoGHisQBhI0dcCZ7wCPDbjA0I9E01OyC5N/x
	tbStQxVb2svKScxxMaDw+bPyTPjorIiI28rE/SfQ1KRcnfR+o1wrBVpgfn1Bt4halEAcuc+92RX
	WdPLctrfyHTMb3m75pz0mzfHSwLvBd9OclPbmZSWfy+QUBwHml+K/By82hb7jsfxDrYZu0+f9Xg
	I/6TWhBaXr0B8EdIa+j+uctsJ0hq4qRAWikGaD4d7xdrYw6nyNB7peVYofRK/Tv2E8ZDDLkCbRy
	BpKOVF8U6tdUuC/+JJb/8JAcfgi3njzKMLXoVDsuIzN0Btbb9PKx8nevdq7NaLDj0WtVcf/JvOZ
	+tvke+82KqiYGaqfqwJojkOXYINgMthhxQAnQfMfJXiq48sJvcm4mcv5Ghq3KOH8UL8qjTyNZ5s
	GyYQQ==
X-Google-Smtp-Source: AGHT+IFevLoNtuerBsIw1VuRArXCqqtvXfnOs340pTPBnyLhuRUJ7DD12vxDIIoA4Zumvg8MBc0QBg==
X-Received: by 2002:a05:6000:2406:b0:427:a27:3a6c with SMTP id ffacd0b85a97d-4270a273c43mr7686143f8f.63.1760983119338;
        Mon, 20 Oct 2025 10:58:39 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0f7dsm16168108f8f.4.2025.10.20.10.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:58:39 -0700 (PDT)
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
 Re: [PATCH 08/11] arm64: dts: allwinner: a523: Add device node for SPDIF
 block
Date: Mon, 20 Oct 2025 19:58:37 +0200
Message-ID: <22871360.EfDdHjke4D@jernej-laptop>
In-Reply-To: <20251020171059.2786070-9-wens@kernel.org>
References:
 <20251020171059.2786070-1-wens@kernel.org>
 <20251020171059.2786070-9-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 20. oktober 2025 ob 19:10:54 Srednjeevropski poletni =C4=8D=
as je Chen-Yu Tsai napisal(a):
> The A523 has a SPDIF interface that is capable of both playback and
> capture.
>=20
> Add a node for it.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



