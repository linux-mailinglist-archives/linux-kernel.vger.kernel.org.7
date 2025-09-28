Return-Path: <linux-kernel+bounces-835610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE60BA796E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 01:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2901894444
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 23:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF1128D83E;
	Sun, 28 Sep 2025 23:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isJpxh5Z"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D725BEFD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759103025; cv=none; b=hgyJSF7WzN7ibxpWT2Y5dPPtskqI/9/t+wak2L74n1ZERYtgkMRXofbT0heXwag5L7u/4fzaANXApSmUd0lvQ/ESNnq4L/ihckv39OI7R2gEZ2UNFsZ3/Tc4o+VsOp7wgYWkJLFZ8jNIDnGMqRy8RAVEgiIo2dMpM5q1ZpLb4NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759103025; c=relaxed/simple;
	bh=xhLv4RXf0zFjN1H+SpDyp/WVnL1lk114bfcCwgo3L1w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=psCTcrkB5lQa4X5twOyV+zWpcuD0C4oEkT+yjQXbU5nx0azPHRb16pshCSLUwCBtFKUWZZGwiUKLl5EmTByBM7sHYbLJ0QhFrBLwVA/j/WapOvdIad55Vb8eH8R5MXUBdfBajM+Ca3hElTYsDG/O2tKbe5sG/tEdSDj6bT4fQxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isJpxh5Z; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso5219566e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 16:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759103022; x=1759707822; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYuGJU4VUHZh3LQSBZZJ1m72z3IXmhn5eD65/qtg9hg=;
        b=isJpxh5ZYCN1oUtNDxTpou4bmmz1g8VOGAhDVloC8sOR8FMr0nl0AVI6LYd+tEfpXG
         QT+Itpj9BE3MUxaJPlSvo+iHcC1Ic/hEw0rGQ5t6VFoENSky/i+VTDDaF4BIxN4ZTB2U
         EEV3z8eQUk1jdBn7NbzNf30V1Fqz+pdLIZH5czoliKv+bgr1pERfUrabYYJWxEIKTKFg
         dZ+uFdsscq4y98GMy9FensCsw0MvK69OR3JCXvJ5/Zt90GPKKRyXko5Bg/kRJVz/Qc4z
         nUyLkaIgelmv+VsTjy+W/30Eb63VBRRz+cUWk0bsldBYMnLaoX0Esu3nNUP9FCqXGyoh
         YV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759103022; x=1759707822;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYuGJU4VUHZh3LQSBZZJ1m72z3IXmhn5eD65/qtg9hg=;
        b=TOev8xmiwVQo9dinNqu7cgjDce6zx/0/2L8ORfMTkD2bNDWSme2JUwUOJn8pOVHvU0
         pheWizn3Q5D4bnbgFcBPgtuktyNhSQyVfjCoEuHMPgMhd0oaMhbie3c7aNEoeh5FhzDP
         yk740iKtjezhOmnh63uRDEj23wlpoNNa3t+xLwXvemjPU1yenqrvU5CjMYGVejBd3OaV
         UjqNnX1Yfu8Cit3wiNjW9enErOm5DNkF701kxkIiwqXTTMc/7sK4Ex/G9bY6Qnq8EXTI
         cHdxKh4u5Yn1+2W/vypNfEdOY9I3rPb1UJ+UjxfBDSPxjgYA9g+hvcU/OasbALVzL4rN
         SeUg==
X-Forwarded-Encrypted: i=1; AJvYcCWi+FfeyWudpp/4J2YlVBLdF0VnFlQYCJYk1EZqnziE8vWpnDxiqafURc8PgVrhEdQwySYLAXpA6m+A/tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB+GA3Pa2hPd2qDM4WwQmQr7oL1Q5j0UWusr4StdGz41BBCAju
	UqXtNrQ7DIW7i/404yQ3nQ7832XPdpM0ueizzKnvb8iJUyIPEDcZOJJA
X-Gm-Gg: ASbGncvwi77gI93SihUVk2oG0o5Op7+MQRlmui0Q2prcTTUzF6d2BVQQwLroajCdR/9
	jt1OaDbV0h0tjSL92lj9dn/yZROqNGIrS+oGNInFV6jUfEeGL5e3ME4T6gKo4sJW06kg4NBAxf0
	yGptWTQ3u9dkifhm1/WGs83hiu+Wqg6oLheiiudyJtzYbrQYm1231LrzwsngZvb2heEO7v72Alr
	PRSrywImGgfw+EAfZ2pBZKhyF3bVRWA0COVmtgZ8nY26IgBV/qsByW6pUvOVEPVFGMfE7YLudQH
	f51MlmkaIEp80ACgjCpK5loR5xPH0IBCuJATYzfI90RKCWAVPHcJW9tmJybcUqI+erE2WfwFZ4i
	4/bs618Mbv10k2fFacz6ATIaha6+kpdJ9OJbI2XsEiH9mLIAomt7HnA4rmA==
X-Google-Smtp-Source: AGHT+IHR/3oBhcou/nqFCZJEmzF9GzjQUOYYNk7PFauGlRhY9drF2R0iP+r/p0o6ucZSI3AqqdXoWQ==
X-Received: by 2002:a05:6512:3ca2:b0:55f:6adb:b867 with SMTP id 2adb3069b0e04-582d3111187mr4279256e87.45.1759103021915;
        Sun, 28 Sep 2025 16:43:41 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5879e9b80cesm512772e87.112.2025.09.28.16.43.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Sep 2025 16:43:41 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/2] arm64: dts: meson: add initial device-tree for Tanix
 TX9 Pro
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <CAFBinCDQc=2xrKbGunSKJjLhGd0bCGN+3oYd_bg0ySs+WHxZjA@mail.gmail.com>
Date: Mon, 29 Sep 2025 03:43:26 +0400
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B97C24A-A1C0-46F9-BC74-3E7D2119B6D6@gmail.com>
References: <20250927125006.824293-1-christianshewitt@gmail.com>
 <20250927125006.824293-2-christianshewitt@gmail.com>
 <CAFBinCDQc=2xrKbGunSKJjLhGd0bCGN+3oYd_bg0ySs+WHxZjA@mail.gmail.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3826.700.81)

> On 29 Sep 2025, at 1:12=E2=80=AFam, Martin Blumenstingl =
<martin.blumenstingl@googlemail.com> wrote:
>=20
> Hi Christian,
>=20
> thank you for the patch!
>=20
> On Sat, Sep 27, 2025 at 2:50=E2=80=AFPM Christian Hewitt
> <christianshewitt@gmail.com> wrote:
> [...]
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-tx9-pro.dts
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2016 Endless Computers, Inc.
>> + * Author: Carlo Caione <carlo@endlessm.com>
> Is Carlo really the author?

He=E2=80=99s the author of the original device tree that 95%
of the content for this one is taken from; as is the
case for most older Amlogic hardware. The decision
on which bits to copy and paste was all mine, but I=E2=80=99m
not  sure that skill deserves too much credit :)

I can resend with my own name (or mine appended) if
that would be preferred?

Christian=

