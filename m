Return-Path: <linux-kernel+bounces-758793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4243AB1D3DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D70918C691B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CC24BC07;
	Thu,  7 Aug 2025 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilwVLM76"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8E246BDE;
	Thu,  7 Aug 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553530; cv=none; b=jgFDwj3TXBHCsDOdDwHZGZUh8JwCMbhSsCzLDWdH7r4WubYbEtonxLoSU2W3y3D08q0upWKM76HRvTmMQDtJx5GKppQT86kchGxowjrAp6rFf0VIX4XJSTdKC+ilPVEUfxV+vVxyIMvioMmUcvAXq/2ruw1Hgvxph2v5gJUudi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553530; c=relaxed/simple;
	bh=DDU4mUfLGa/kC/rD4398PtK/yjh8S6aRiKIZIanDiL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+rbhIK3rY68fhaHgCgiZQ5ROV1vQvLJ0L6LaftcMfZSLItmuxzIUO+1/rjb08cS/Wowdoe6oHYWCrd4TnBhK9sULame04L41eFZa5o8oU/zKuCnFn0pVzGqzpjpFZ5pyf4MsKKZI0pd3dqD2xAPLFBRIg48IhNCOqIqjuWKdHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilwVLM76; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-718409593b9so7131267b3.3;
        Thu, 07 Aug 2025 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754553528; x=1755158328; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDU4mUfLGa/kC/rD4398PtK/yjh8S6aRiKIZIanDiL0=;
        b=ilwVLM76HbNieyenFnYK2rY1ysohkjxxV+r9IqqpKmYhtEvoI06Hw2fiZAUjMOip4O
         u2vIKhB/+LXB+8eX1I4HhkOJy+mCgoFNut2Wcs1xOHopiiG2gT9kHdpqLxLOsBIHu2dT
         /be6x5EEkIza5REaIsL1qiX2gbdpITa8Ts2Ly7Ghj4ndjuFlwOwgQ8DIbSLTzozixoN3
         YxVyMdWujf9q92k9np+CasjsS1m5oKmVntLCYRL+88yM1pWVU1KOHpowNEvqUZBRPie6
         /iwZotfpDhYX5xDMOI0pUF7nrFYT+8Lca7nmIWP5iW+OnKhaGu6BEEIx02w/CoGWszdt
         9mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754553528; x=1755158328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDU4mUfLGa/kC/rD4398PtK/yjh8S6aRiKIZIanDiL0=;
        b=ugqbYoZEyt7nepEmgLjoAoWEzGuxGI+8YWdXpc2Zhw9Jy67Rl7eR9AzCETQf92oOHR
         sspGgquR0tl9yRme9xR2j3cMstZ1ZeT4Aa2ywa60Y/r8XZMRwkQCVPhaZCpSYA5Ihh2h
         Pfbi4zRXKOcyl2L1645mEWT/yeOZCPcKHtBU7JuA2c4tHOaiYT5ApXSn8/9yzyYpQ31n
         9z4BNtaQeEqtI+RMtB97J09YpIyz5nsjBgc+1Fsh8J47mC8IopcnxXH2HAsWOfA3/zWj
         d2IGewE4Iw3i/e7HYxY95Ru7qoANkG/OFVzHB92i9zxjSIeyn1EHeUEcjqIrRlJWzJdJ
         wyDA==
X-Forwarded-Encrypted: i=1; AJvYcCVq5pfexFCh0pAojoHHBDOiYDGzcDmdq8XmsV12rpPG3ixwdd27jY6SGudQlXtQ+TUYjHD4Xl7Tnwgm@vger.kernel.org, AJvYcCXzd8M6wFD4Ecvg5GqE9xQBNUyJHm1aiN1LqQW2sBRA2LltgvtseIS53X7r4Wgv7sb9mJ8NFDd2dppTmGv2@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRghpsu9b+ocnq4IexAMMeRP6gWvUGdD9St+mWW1zVbJbGXcN
	aiU63u60wODOI/8CLmFUSeDaU1AOY7h1F9pmpMxIdRuzjR3F6P9VeSh/QLQkkyHDDO55xU89I3/
	j8WBkPKJ5u68hSKwwpicY3rEulxDya24=
X-Gm-Gg: ASbGnctTaSj2NX4yAapcUCDC/zP75lfLI+K7nXJ9Jl2BskrYqOsHxZ9I2TIbL7QC8r9
	b698h2XBvvg+gRJNcOA07/+DdycLtGj6cr6foA3Ct/4Ehh0JqLdAYBco+w1ncFZuX7JIxIuFLsC
	HK9xFxFTFDBZWZrzySLpHf595nsLdO4OztXBsKmOiVCnSH0H1icTWwFOQpw3Udp8uxAhlSlfmF6
	M98sd+eunK8HFGxeed9D/lCa4+IBLNM32AGcVA=
X-Google-Smtp-Source: AGHT+IGZKz1tpSwZENVH7eq2lbQKS/ckKC1RJ5Elh7kv3TzcssZgVYBUSlfRHCr803DVDFTPFP0Xzi7enXaZL6INYzQ=
X-Received: by 2002:a05:690c:6d8b:b0:718:3b9f:f1f0 with SMTP id
 00721157ae682-71bc991cebdmr84514327b3.26.1754553527739; Thu, 07 Aug 2025
 00:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806133824.525871-1-rick.wertenbroek@gmail.com>
 <20250806133824.525871-2-rick.wertenbroek@gmail.com> <20250807-amphibian-fanatic-muskrat-b1365b@kuoka>
 <7ea03b71-d36d-49a4-b848-34eba4c1620d@kernel.org>
In-Reply-To: <7ea03b71-d36d-49a4-b848-34eba4c1620d@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Thu, 7 Aug 2025 09:58:11 +0200
X-Gm-Features: Ac12FXykZEwvQuAbP1opdqmWRhEGs-r5-vMCR-fxkqHt9AuoJgwdnEGvT3Iy_Qg
Message-ID: <CAAEEuhpZGbuGkAKRiYQouAwDwnJbP+9ppi7BtrZekKpp20iOgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: phy: rockchip,pcie3-phy: add optional
 differential phy clocks
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: rick.wertenbroek@heig-vd.ch, dlemoal@kernel.org, 
	alberto.dassatti@heig-vd.ch, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 9:44=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 07/08/2025 09:42, Krzysztof Kozlowski wrote:
> > On Wed, Aug 06, 2025 at 03:38:21PM +0200, Rick Wertenbroek wrote:
> >> Both PHYs can use an alternate reference differential clock, add the c=
locks
> >
> > I do not see any changes in rockchip,rk3588-pcie3-phy, so your "both" i=
s
>
> I meant 3568, the other one.
>

By "both" I meant both PHYs of the RK3588 as the rk3588-pcie-phy is
actually a dual PHY (PHY0 and PHY1 which both can use independent
clocks).

The RK3588 PHY is a dual PHY with two independent PCIe 3.0 x2
interfaces (that can be combined into an x4 or used independently).
The RK3568 PHY is a single PHY with one PCIe 3.0 x2 interface.

The RK3568 already has the bindings for the extra differential clock
for its PHY, but the RK3588 did not, so I added them.

I should maybe rephrase this to make it clearer it applies only to the
RK3588 and that by both PHYs I mean RK3588 PHY0 and PHY1

> > either incorrect or ambiguous.
> >
> > ...
> >
> >> to the DT bindings
> >>
>
> Best regards,
> Krzysztof

