Return-Path: <linux-kernel+bounces-777854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E18B2DE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FDD564F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1A261388;
	Wed, 20 Aug 2025 14:00:50 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BD258CDA;
	Wed, 20 Aug 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698450; cv=none; b=Q1QvMhzTqEIU/1xjbHp4KDwWes7Byj/Mck7gkkUMCp1c0nuz/EOFpNIu0ElSZX4yrlheX2c/vxNyPrfm6cGajoC/3wKxGuUCMnmrryxPGXu726Qfja6f1Thq508vi6aFFNVVyfk0hrLFOKOPIVTIJFvPaudqSJE5ESh3v4RLNzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698450; c=relaxed/simple;
	bh=mNqh/E6C/UGtQoRqGV0+5q3dZr6YlIvSPfgJjvnf2oY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=YvZUdx+C3bNGJ3nD180AzGycxkTE4V1jqHLNxwz1NOWW2Mx4PM2QmV9tOBbOG77JXmsqpuhKt2azRDvxO3EZhGPZKK1qKrnBqdHMzL3Gk1E9j4+j/yas5Q6c1hDRINnpdc5PdWz90ZhaX3vO+Ccj7zm9P0KqOmQ3nW+ys7GGE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 035682D5;
	Wed, 20 Aug 2025 16:00:45 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 16:00:45 +0200
Message-Id: <DC7B5N92V9KZ.34OXBFYOIEWBO@kernel.org>
Cc: "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Tero Kristo" <kristo@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "s-vadapalli" <s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j722s-main: add legacy PCIe
 interrupts
X-Mailer: aerc 0.20.0
References: <20250819111317.1082515-1-mwalle@kernel.org>
 <ae898bf0-705f-4e36-9664-37c401f5fee7@ti.com>
In-Reply-To: <ae898bf0-705f-4e36-9664-37c401f5fee7@ti.com>

Hi Siddharth,

On Wed Aug 20, 2025 at 3:52 PM CEST, s-vadapalli wrote:
> On Tue, Aug 19, 2025 at 01:13:17PM +0200, Michael Walle wrote:
>
> Hello Michael,
>
>> The kernel will try to map the legacy interrupt pins, but the
>> interrupt mapping is missing from the device tree and thus that
>> fails with:
>>=20
>>    pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=3D-22
>>=20
>> Add the node for the legacy PCIe interrupts to fix that. This is just
>> compile-time tested.
>
> INTx is not supported by the driver as explained at:
> https://lore.kernel.org/r/be3e3c5f-0d48-41b0-87f4-2210f13b9460@ti.com/
>
> The patch to fix the error displayed in the logs was posted at:
> https://lore.kernel.org/r/20240726135903.1255825-1-s-vadapalli@ti.com/
> but wasn't accepted as-is. A different approach will be required to fix
> of_irq_parse_pci() instead as pointed out at:
> https://lore.kernel.org/r/20240729080006.GA8698@thinkpad/

Thanks for the pointers.

I've just checked the J722S errata sheet and there is no such
erratum. So, is that sheet outdated or was it fixed?

-michael

