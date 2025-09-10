Return-Path: <linux-kernel+bounces-809512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D396B50E88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18214833F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 06:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35A303A1A;
	Wed, 10 Sep 2025 06:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="X+03SsaU"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119EF2773C9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487233; cv=none; b=e+yVMPkA9XY+xJCsgcrHAec8H5J5DwlCU2UqPfWxc2nEsfpy7NoRw5UbyIdE+TRh8DtmA30s+oDKLcfu1neDdYBLxnT/tQ7ZX9Asyek2UcrxRQ+qvlaQT1VTFmhJIcJG8lElge5eak3KGMFzVh3efpev0QMkxlshXZPS17pUHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487233; c=relaxed/simple;
	bh=ahBCd4v3Y3Hy+9eZhfS/meSLZLldCa8IFQTVi71bMhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UoA82VhgtxVJm71X1Bf1VK8YkxTtj+d5aiJmnkJjctdssIbfqIOwvLALKDyUfz0O0pfat0kQkZP/PiwBrUiZjN/mxK2+AzUPlRAcv8kjvMlF7aCJH8Wo4OZwo4ZIEjkuKIDRgfaOqhNCI94gs9djvrf/l1zlYJyXxbI2h1d3AIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=X+03SsaU; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=3QtE
	MO80KSRXHHcQR8iUtZcbvRTUZ2MQ4g/xitu0XMA=; b=X+03SsaUtrd32NsYB/ek
	Utpb54jRVdJDLObVVwoDyiusfnS9O2OyeGgQiBpDjgotrjKW/0x5pZScoBm6XFSa
	moWMpTEnJzn845L+uck2N1Pv8KtIBPdx+MXXg/YRTJ289Ms4Emvu8qc3otno6ane
	OgePiIUXNIV76JoX8RyBMwC0B2u0YVIgV7Jt0v2QMtBwVrB3nVKW02con7gKwmLF
	pdCYGFN/U9HXgYqk6RNRe+f4LZp/uDhZS6T+etrY7nL8zBYQg90JUdISfCWI8A3+
	J+S48TZAzOcQtmu5BtZtw0MfR/LaAYZYhuG97/alxh2IJiuS6Ygd7nkR3RWHnK6v
	cA==
Received: (qmail 500977 invoked from network); 10 Sep 2025 08:53:45 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Sep 2025 08:53:45 +0200
X-UD-Smtp-Session: l3s3148p1@OJ+94Ww+VOwgAwDPXyerAKQ7QDbxBzog
Date: Wed, 10 Sep 2025 08:53:44 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Durai.ManickamKR@microchip.com
Cc: Frank.li@nxp.com, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, Balamanikandan.Gunasundar@microchip.com,
	Nicolas.Ferre@microchip.com
Subject: Re: [PATCH 2/4] i3c: master: add Microchip SAMA7D65 I3C HCI master
 driver
Message-ID: <aMEgeHLnrDyGjYM3@shikoro>
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
 <20250909111333.170016-3-durai.manickamkr@microchip.com>
 <aMCZw2v8Ey6aGbqk@lizhi-Precision-Tower-5810>
 <3229da67-9d67-47ff-9f01-0d71bfabb6a6@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3229da67-9d67-47ff-9f01-0d71bfabb6a6@microchip.com>

Hi Durai,

> 1. To introduce a Microchip SoC specific macro to add Microchip specific 
> I3C changes to the existing driver. But in this approach, if suppose we 
> have a changes in the i3c-hci driver, we have to adapt the changes to 
> our IP also during every kernel updation and I donot know whether this 
> is accepted by the i3c-hci driver maintainer.
> 
> 2. Otherwise, creating a separate platform driver by reusing the 
> existing i3c-hci driver.

Usually, 2) is the way to go for the reason you gave above. If there are
fixes to the core part, you don't need to sync with your driver.
Maintenance burden is lower for most of the times.

If the hardware is so different that the modifications to the core
driver turn out to be more complex (and harder to maintain) than a
seperate driver, then 1) can be an option.

Without knowing your hardware, from the description above I'd think you
can reuse the existing HCI core driver. It is mainly about not using
stuff like DMA. Maybe that can be handled with newly introduced quirk
flags.

> I raised a query few weeks back to decide which approach to proceed 
> before sending this patch to upstream. But i have received comments like 
> "its upto us to decide which is best way". I dont have much idea on 
> which is best way to proceed and maintain.So, I have decided to go with 
> approach 2.

Your patch looks like approach 1), though? You don't hook into the HCI
driver or am I overlooking this?


> >> Features tested and supported :
> >>     Standard CCC commands.
> >>     I3C SDR mode private transfers in PIO mode.
> >>     I2C transfers in PIO mode.
> >>     Pure bus mode and mixed bus mode.
> >>
> >> Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>

Please delete lines you don't quote anymore (here, the whole driver).

Happy hacking,

   Wolfram


