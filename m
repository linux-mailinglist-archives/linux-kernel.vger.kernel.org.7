Return-Path: <linux-kernel+bounces-749187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12464B14B39
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087991AA3E30
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8469F28504A;
	Tue, 29 Jul 2025 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b="hpFXhVh8"
Received: from chumsalmon.baetis.net (chumsalmon.baetis.net [209.222.21.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92A1A76BB;
	Tue, 29 Jul 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.222.21.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781074; cv=none; b=mxPORfqnrRdtQkjlYw0EsefePrxCEmEeyqIo3YzmVLHRwSffcLEn3s0DJM9ZfD6gdbPwQJIXilkaYq605HAM0IORKhJSJZIVigmr19B61mUDmt+PHtw/UbAYbCOevA3Kgcx25W0Kyef+u+xc1Qb/eO2CwASOV5xZc7pwT0fTyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781074; c=relaxed/simple;
	bh=5f4BpgvVmzCRmDHsN/VvJBuhhWIHDaaAjfV2HvJvoOs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ENGxPGdbNyAblcSGVodAb58BpWXTNUqaDS6foAS7PXLIIkqmr2hP7icsRoQ8/vTGlJTDVaKkj3MsMdIsbZOt6MKpW0TJAEo9Ro0ZXQr2dRJ2u4kT+wnogpXehwnQwxZ9E59J4KUX10sRzT4WgOVF8Fd0I3flBeaRxT+qUcDjjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com; spf=pass smtp.mailfrom=tahomasoft.com; dkim=pass (2048-bit key) header.d=tahomasoft.com header.i=@tahomasoft.com header.b=hpFXhVh8; arc=none smtp.client-ip=209.222.21.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tahomasoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tahomasoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tahomasoft.com;
	s=default; t=1753781067;
	bh=5f4BpgvVmzCRmDHsN/VvJBuhhWIHDaaAjfV2HvJvoOs=;
	h=From:Subject:Date:References:Cc:In-Reply-To:To:From;
	b=hpFXhVh8LgP8dqnxcUgwPNo6gTpGwmpdL+3iJuNNFBFpBGjzSvPtenKS/Y9H3jdWH
	 X/4iWVa8l+2IL96OuJShAyeJHPCwqh9Az2ub+A/Lz7JxMoqm7K6rcDGD83j+lxa/Wd
	 uCSHnl91sS97i1Z1IKre75KtOgyk60OGoIBsWv8CethiTw8QEXtyiKcypi+037gNuF
	 /O6DkkSV8Nz6N/EjDY0V+hUNQibAfE6UCubpHFlaulVS+D+YlWbKbsmPcWSl1JdwBR
	 ZNvHDBz00pwgPYLzjmGSYtT64gVmO8CyajtRGjwVfBKTZ4kg4Onc6if6XGliWFxR/P
	 jEp2aIU1uWMpQ==
Received: from smtpclient.apple (unknown [IPv6:2600:4040:50b7:b604:2ca9:1ceb:f1ef:b736])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by chumsalmon.baetis.net (Postfix) with ESMTPSA id 629C327E434;
	Tue, 29 Jul 2025 09:24:27 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Erik Beck <xunil@tahomasoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5 2/2] dt-bindings: arm: rockchip: add LinkStar-H68k-1432v1
Date: Tue, 29 Jul 2025 05:24:17 -0400
Message-Id: <9E402294-53BD-4BA7-9E0A-EE4B287DF038@tahomasoft.com>
References: <20250729-passionate-jerboa-of-superiority-c7aff5@kuoka>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250729-passionate-jerboa-of-superiority-c7aff5@kuoka>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: iPhone Mail (22F76)



> On Jul 29, 2025, at 04:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> =EF=BB=BFOn Mon, Jul 28, 2025 at 11:07:37AM -0400, Erik Beck wrote:
>> Add device tree bindings.
>=20
> I don't understand why correct patch order was changed to incorrect.

My error. Thank you, and I'll be reordering them shortly.

Regards,

Erik
>=20
> See submitting patches in DT bindings dir.
>=20
> Best regards,
> Krzysztof
>=20
>=20

