Return-Path: <linux-kernel+bounces-836286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D046DBA9334
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FC1189EF01
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A23305E19;
	Mon, 29 Sep 2025 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="vazqFVDw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AB847F77;
	Mon, 29 Sep 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148890; cv=none; b=Uj0Fa5WvH6/OP1HHeo3P5kigbzyOTLVvJSeAzJMAbhJtLXKeuQt1c193B7P7WEZcoAKUfpzHWH1Z2greW1mkrJO2VajsUyNOjKXdeNEc6pkMtDt3rbqf5qthC0GIUkmQ9jChRTBahqsj51iHB9IC8QhcYe9yoK4Nhsw7zF5laEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148890; c=relaxed/simple;
	bh=8Cmtx7kRed2U7BqgS5jivN6WaQUtTqCZCu6zk3IT+OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EfDaRtjC+I/P3ppyP2ZXy7+BhQnexRZarK1kaepKu33JSp6HZApYrc0WVU6OkzGz1jRlTuY9D0sSn7F0O0lqW4Fs/Rx0xTTuFlyrHVPOKKUkv8F5H0Oj31h6hzpC4Ug9sWGvdAIgrJw2HiFm5aFRibkbRRBros8uJEZVgq/iNVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=vazqFVDw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=8Cmtx7kRed2U7BqgS5jivN6WaQUtTqCZCu6zk3IT+OE=; b=vazqFVDwXNelz4Ve1pgiByWgSm
	/ipyxv8z2DlhL7W7eh7ldmKNbmoLN3nhnNL8UbkEbaaCeJFM+2kPm/PjZEEz/VL4LtnNcMmZ7wxE6
	KUNEjsbE7FCtaj7NfiqYJ5W1q886xuLr4PeaYFC4o96ywnLaKitHxnn1gBysLawts/q5Z+YZHYhEJ
	4QzdDx98RectK4GZ9tmHccCgG1e9mZUhd6vBLK1cAnWZ0cGry758XJyFAnckyNEY0UwrVtfS81Eeh
	hsCxG5319lLAWb7HFlWexLE4RHPTZMYzmwFmCx3QqqJ0El29QLZ28QwdKcs+oSUzdksjrQbE/SZsY
	6k197Q3w==;
Received: from e227-076.eduroam.tuwien.ac.at ([128.130.227.76] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v3Cye-000723-2i; Mon, 29 Sep 2025 14:27:36 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 quentin.schulz@cherry.de, kever.yang@rock-chips.com, naoki@radxa.com,
 honyuenkwun@gmail.com, inindev@gmail.com, ivan8215145640@gmail.com,
 neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
 pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
 jjm2473@gmail.com, jbx6244@gmail.com, Liangbin Lian <jjm2473@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Document LinkEase
Date: Mon, 29 Sep 2025 14:27:34 +0200
Message-ID: <14335288.5MRjnR8RnV@phil>
In-Reply-To: <20250929065714.27741-2-jjm2473@gmail.com>
References:
 <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-2-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 29. September 2025, 08:57:12 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Liangbin Lian:
> LinkEase is a company focusing on the research and development of
> network equipment and related software and hardware from Shenzhen.
>=20
> Add vendor prefix for it.
>=20
> Signed-off-by: Liangbin Lian <jjm2473@gmail.com>

In v1 this patch received an

Acked-by: Conor Dooley <conor.dooley@microchip.com>



