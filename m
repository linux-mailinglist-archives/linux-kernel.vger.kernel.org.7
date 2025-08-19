Return-Path: <linux-kernel+bounces-776505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ABEB2CE42
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158475E363F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B30343209;
	Tue, 19 Aug 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w8juffTo"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F73F30C36E;
	Tue, 19 Aug 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636480; cv=none; b=dkAzWBhMFEwH06n/M2Jjn1/z/cwmJjkZgnZz+Af8GK9tO7DbzlXSlJnRUGQGRy5SWJhMPnygsX8Pv5Of+ucwyMzcaG8HKWm0o+X/bOEeHUSHEE9KPUsqJICQrs7Sz0ckIfAFFDs87l2kb7ArXc5Dx89vfKkBK4xDcISGSKsr/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636480; c=relaxed/simple;
	bh=rZKXiseSnpS0hEdhK0+cUyUK3qXOByXmJNN2AiTy/3Q=;
	h=MIME-Version:Content-Type:Date:Message-ID:To:CC:Subject:From:
	 References:In-Reply-To; b=ZLWZ6Nvry4zDIVXZypCsL6uQ7x7FThZ3Bup0DTu/Zv1fRgwRyGdT1W6fZngUlWETSJFhwgI+22f1//9b7I5nGPeIY084dEtYNZhQcI10Y7VuXMoU/usLjtGjIPyTSc/+CVibL5rkh00sWcsbMABCrLhm8phqN9NxvpcLhLwX7Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w8juffTo; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JKlmZW3036127;
	Tue, 19 Aug 2025 15:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755636468;
	bh=rZKXiseSnpS0hEdhK0+cUyUK3qXOByXmJNN2AiTy/3Q=;
	h=Date:To:CC:Subject:From:References:In-Reply-To;
	b=w8juffTo+pGNMf1xoRk/8cjRqfejZO8YpqMmfdSWRByw9zHQBKqaxJlkKYwM+yocC
	 p4BMKQzR+mpEILNmIvX3xnDrAa6ePA7ckitdHJEnYgQHEeUOFK/q+l+8cqZemx3BRT
	 JW0KVvcgHqZ/ZSUmVxwDiKzokslMcRaUQgrcNX5Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JKlmnk1534906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 15:47:48 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 15:47:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 15:47:47 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JKllt63304944;
	Tue, 19 Aug 2025 15:47:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Aug 2025 15:47:47 -0500
Message-ID: <DC6P6R1L2ZED.2UR8XRHH5RPJ0@ti.com>
To: Michael Walle <michael@walle.cc>
CC: Nishanth Menon <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <d-gole@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <detheridge@ti.com>,
        <matt.coster@imgtec.com>
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j784s4-j742s2: enable the
 bxs-4-64
From: Randolph Sapp <rs@ti.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250808232522.1296240-1-rs@ti.com>
 <20250808232522.1296240-3-rs@ti.com>
 <20250813151819.5rthljjrpryfwezz@skinning>
 <DC1HU458W3QA.YLONSMYKK0C4@ti.com>
 <20250813181300.xfpsu23arx7xy4fy@anointer>
 <DC5C5JA237HD.1ACBQVG1LYQ7Z@walle.cc> <DC5T752T3P8B.1UC57G2GH35Z5@ti.com>
 <f0353dea24751f2f2ad6e7735232b933@walle.cc>
In-Reply-To: <f0353dea24751f2f2ad6e7735232b933@walle.cc>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Tue Aug 19, 2025 at 1:38 AM CDT, Michael Walle wrote:
> Hi,
>
>>> Apart from that, we now have two series which partly overlap.
>>> Should I repost mine, as that's more than just the DT entry? (Which
>>> doesn't work as is, I'd guess.)
>>=20
>> Ah, I don't see that series on the linux-arm-kernel list. If you can=20
>> forward me
>> that I can work around whatever you've got.
>
> That was the one Nishanth mentioned earlier:
> https://lore.kernel.org/linux-arm-kernel/20250716134717.4085567-1-mwalle@=
kernel.org/
>
> Also this:
> https://lore.kernel.org/all/DC5KCSEUZQUJ.3KPENNUQBUFM8@kernel.org/
>
> -michael

Ah, alright. I'll hold off on this series until the AM62P related sections =
you
were proposing are picked up.

