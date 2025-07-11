Return-Path: <linux-kernel+bounces-728073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4F3B0236C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E791C23548
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D762F273E;
	Fri, 11 Jul 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y+POjVBR"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2782EF2B9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752257722; cv=none; b=AWu4haZuyZITmZOJ04g9eHCqlU8IIqMBqvVbDZbEMUGHQBVaVK/XPbpTaOO4FHs+LOqJwL4ht32Qi2w2b1gg/SCxTH+bS106ghZmblFUUlm6gl4tMODMlGef2wJT30NcDUGwr1Y2QSdIX36p3eiu3H8cgfHLF8EQUFfYtJik0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752257722; c=relaxed/simple;
	bh=i4q8ecDX3sUGA1MLG8h4tOnFmYn0XuYJcSIMOO9sLLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGVJj/1kZhY9cE+F1oP+TLLo7OShVyZe5+0nYpb/AEoZ+yFgQ8Ce37job/9+WirgbOsuGIH0kpoXeFZnk6moNemGH0INwrDECTsZlQ1zRxXVdtcTgOQMeQu1xHKUzSAzfxyfRqsAG4t6zjUO1rt1EMr/WphSTNyDcgG3easxPRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y+POjVBR; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso30156011fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752257719; x=1752862519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4q8ecDX3sUGA1MLG8h4tOnFmYn0XuYJcSIMOO9sLLY=;
        b=y+POjVBREK/2j/fBXbbuU78AHzy98MPxVnMfpwLdpp1tT73QnN2I+MSQLSuljMLBBF
         w1aS87Cl0qGbmpQmNjBUBRY8RC0BQCjtyiG3EeVNKm5tiLPizj5BTaz8ohlMtUK7t8If
         XIg6V4rWSzg3sA0vboVNP1OsgMi1KhbRPqTF5LA6dLTPtX2DwwBG1JDR7Zvv2HJ8aCUp
         3P/qG7Xf/Xx6QWwMo8CzqINMyA1ctPO8AViCddyrCkvO+KzXbxdhQZPm50nWFrhqqBmp
         sbNgRJrhGdwefOIuydN2ZHzjDrpXD1pUj+EZKY5xUIGcqtyfw98+o8nBGGC+Eht79TnT
         vQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752257719; x=1752862519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4q8ecDX3sUGA1MLG8h4tOnFmYn0XuYJcSIMOO9sLLY=;
        b=BGyV7mHtXGNgEoBQ0BSG55mvZ6rV17KX8knKR9y2yjBalfr+yqR5oboZRqpBrhFwBs
         zO60u6FhmC8PPxKj7x0RV3XxbXJjHaMxU/RtH1yU26oUxtcZJnBO7T0k5IlMB532doh2
         ZpoJzqvLAm51UfbgtrTEsmJ2uwM2On8BcVqJrXAHJVnwMQTeKIOBMcSfLfz8rkv1+caw
         5Mwndox9LaAY3EjCO1atrUjabOjSROYUw9yD2eDpe4uelVaqO6tjjb6VunlxZ454/ZbJ
         xYnAK/b3ae8ZD54ypIslRrNLpRVK3MoVliLVQLS1qGX9eN0V07TsZva1wFRuHd//X1B1
         iHsw==
X-Forwarded-Encrypted: i=1; AJvYcCX7tTMw5lrBsOWQqQn3v3cfZDDpm73h4oKbKQsvJ2A4Ahmg24PC1XpU3DPht5kwbFH99voXTy49JXsfQig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNsf/URNtIQh++2arb1j0FgQB53YTFHXwAqcHRbVdbLsZgHe4o
	p59CZVOEiICvUCPk3OayjA2rFSilpsf+CfMzwiT7f3uWX4Ep46ch/8Zo+pqFakLkKyhyNmaViPc
	TjIJ6b6aogiW3zzp5Ix0slPNCAdRsJVU5KKyuRboJ8A==
X-Gm-Gg: ASbGncssgACXtdBfP3nz5godwtxOD+O/vJtTpigShRes/HsJCDC9Bezav7Ru8xPXDvg
	l1Jj3ZIo+f4sEq9KPcowQByjtljjavafV2m9i3gWJT13wJwo+8toxkWwzMl8OO21YRggCOYt41E
	Td8u/woc+PayPMnmY30aYKuwbDO5Dqg63q/GVQABuWEb/LeaKNqx2mNI6IRv3w5VPWv6AwrOrMZ
	Xv4xCf13wOtXB8Ixg==
X-Google-Smtp-Source: AGHT+IFtq0bcfpLwnjm7lAoyNxi5hVnB1TfQxkFuJUC5AXv/cwm7YJlwpXzO1clCMxtNVbmVPeTDx2oSZPEXUcqu/sw=
X-Received: by 2002:a05:651c:b0c:b0:32b:968d:2019 with SMTP id
 38308e7fff4ca-330522ae9a3mr17428231fa.18.1752257718550; Fri, 11 Jul 2025
 11:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707165155.581579-1-paulk@sys-base.io> <20250707165155.581579-2-paulk@sys-base.io>
 <20250708003236.059ba94d@minigeek.lan>
In-Reply-To: <20250708003236.059ba94d@minigeek.lan>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Jul 2025 20:15:07 +0200
X-Gm-Features: Ac12FXytqUPkCHhoaHentXWpf1pNxNpNZTLS_vr2xp21e1XJ93lgB-y8FM3uD_g
Message-ID: <CACRpkdZjbGLiZYLYxz5UoMXyuhv7vBipy7YRkhMYUfZLgXr_ag@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] Revert "pinctrl: sunxi: Fix a100 emac pin function name"
To: Andre Przywara <andre.przywara@arm.com>
Cc: Paul Kocialkowski <paulk@sys-base.io>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 1:35=E2=80=AFAM Andre Przywara <andre.przywara@arm.c=
om> wrote:

> > Fixes: d4775ba60b55 ("pinctrl: sunxi: Fix a100 emac pin function name")
> > Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
>
> many thanks for sending this, it looks good to me now. I just wonder if
> the original patch can be still backed out, I think it would be still
> time before the v6.17 PR?

Yeah I just dropped the patch :)

Yours,
Linus Walleij

