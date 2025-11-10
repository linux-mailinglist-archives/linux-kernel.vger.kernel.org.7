Return-Path: <linux-kernel+bounces-893353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 865EEC47226
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68B664ECE96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541630F948;
	Mon, 10 Nov 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qyBPhK5x"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456BC312813
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784453; cv=none; b=atjisLQbYPNLZVGynPc7HSc7OZ+BeHXQGm1MvQOJp1ezpd1hjF8MaSPcp7jlcOIB4fg4nleQQBIbdr5G5ARycVBdCuwyR6pkEValS+ae542mC6FRJbb8KBXeGzb24ShSbkX1GgwQIbytNvhIBMxnvrvLu7G1TnS80dP1WYiAQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784453; c=relaxed/simple;
	bh=NNX4YwfbpIjbVMlqqRAZFK/rjF2rsLaDpZSxNsu++z4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IDu+n3Vs0rqoasT4AmVJMLoZoiaBWiG/cobqQWdJQdm1GbBySyyQT3kH/eAPtvkqUMgxOAUbSSGge2NyhGuNB8nDUXVdmRLwMMYl7SCYGmvYSVlxv3NMUpTOOr5RXQmp0UCVHMfIUjZLAJ/74QoWPXSUNwTP/E2rfggDkuPjkjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qyBPhK5x; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 935BA1A1997;
	Mon, 10 Nov 2025 14:20:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 68A04606F5;
	Mon, 10 Nov 2025 14:20:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E61FD1037176A;
	Mon, 10 Nov 2025 15:20:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762784447; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qVFaf8sEXNFtXFfauM+GPT9QQM5aXDcG/Czx3sxbGcU=;
	b=qyBPhK5xijkVBYuiiiJ93gWfLswu+waOMsjs3SOjZANMNDIQ7dh6H74pyiv33ltRLImsXY
	L8ykDqoj2g9FFeqf32XNfFN7S8MbWEcZstyw6CchbLqTVxlrzV5Z69IhRZ1TUnJvsW0W5w
	A6wcK2zSRoqE74UM9t+IETbFJk6irUl8F6hc51fOx/+KSdYGntxtgkJvQUz8Fpxhy5Pewb
	GYnafd+rpnIVhnNyvIjIQzX8EU0ix3JMs1Pntz7DZoJYnTiflv0c4yybR1+Wl3cjX1CupL
	u3IdlhKacvYjwzIFrNLY1sJ2WIbOdZSS0+bR6NGdXAt4SB3//6DerOIqB3MI6g==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Josua Mayer <josua@solid-run.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rabeeh
 Khoury <rabeeh@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>,
 Mikhail Anikin <mikhail.anikin@solid-run.com>, Jon Nettleton
 <jon@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>
Subject: Re: [PATCH 2/2] clk: mvebu: cp110 add CLK_IGNORE_UNUSED to
 pcie_x10, pcie_x11 & pcie_x4
In-Reply-To: <481bf79f-0cec-498f-9827-f4c6dfd6c14e@solid-run.com>
References: <20251030-cn913x-pci-clk-v1-0-e034d5903df1@solid-run.com>
 <20251030-cn913x-pci-clk-v1-2-e034d5903df1@solid-run.com>
 <05d450d8-8df9-490f-ac53-3f45544f1c29@lunn.ch>
 <481bf79f-0cec-498f-9827-f4c6dfd6c14e@solid-run.com>
Date: Mon, 10 Nov 2025 15:20:45 +0100
Message-ID: <87ldkermte.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Josua Mayer <josua@solid-run.com> writes:

> I missed a colon in the subject line "cp110:",
> should I roll v2 for this?

it is up to the clock maintainer.

>
> Am 30.10.25 um 16:33 schrieb Andrew Lunn:
>> On Thu, Oct 30, 2025 at 04:16:26PM +0100, Josua Mayer wrote:
>>> CP110 based platforms rely on the bootloader for pci port
>>> initialization.
>>> TF-A actively prevents non-uboot re-configuration of pci lanes, and many
>>> boards do not have software control over the pci card reset.
>>>
>>> If a pci port had link at boot-time and the clock is stopped at a later
>>> point, the link fails and can not be recovered.
>>>
>>> PCI controller driver probe - and by extension ownership of a driver for
>>> the pci clocks - may be delayed especially on large modular kernels,
>>> causing the clock core to start disabling unused clocks.
>>>
>>> Add the CLK_IGNORE_UNUSED flag to the three pci port's clocks to ensure
>>> they are not stopped before the pci controller driver has taken
>>> ownership and tested for an existing link.
>>>
>>> This fixes failed pci link detection when controller driver probes late,
>>> e.g. with arm64 defconfig and CONFIG_PHY_MVEBU_CP110_COMPHY=3Dm.
>> Seems like a reasonable compromise, given that TF-A could be classed
>> as broken. This must also prevent suspend/resume powering off PCI
>> devices, and then reconnecting them on resume.
> Currently pcie-armada8k (unlike e.g. pci-imx6) does not currently define
> any dev_pm_ops - so we should be safe from any power-management.
>>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>


Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


>>
>>     Andrew

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

