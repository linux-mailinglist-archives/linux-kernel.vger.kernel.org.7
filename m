Return-Path: <linux-kernel+bounces-785541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF8B34CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC57A29AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C851629992A;
	Mon, 25 Aug 2025 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="KOTwHdFw"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DF28688E;
	Mon, 25 Aug 2025 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155134; cv=none; b=OR2dvVpb1z4uiSly72RHS15Mh2Fi5/2kRdbmUkGazoSTUNCDAfsLbREll9KC/i3Hmm2l07ig9VPugyJWH3J+Pl4vdA0t+y/DPvaESLwlutOITVuiTB339JQhDQeSUZdPfBNH+52JEIQqxCmqd4QP4ieH1D2jKDTJCacYb21o3to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155134; c=relaxed/simple;
	bh=9DEL2Oo+Nr3m/HuNqtk5iDSfuOk2l+HqodByEWatvqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NOcgyHtE5S1kKiT09m8X7409Il+2n7bmUhJHk0uxH1DT2/Qcg6U/KJEWrCuX0xkqISkRsEyeKTGxQcUz79UPi0I9MpUzQXAOZcp2BwnSTEFVqO+P9f7IX71mOS0C5tYERm2m0Sa3kJrbxOcpx9lCS1m+ji7A3nmnmQxclVe36hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=KOTwHdFw; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C277FA0D0C;
	Mon, 25 Aug 2025 22:52:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=Qx/nBrJgEy4ACj8BLrfZ
	hPmHWNsIJJlIdSPVY29XGDo=; b=KOTwHdFwrlssuKhGmYQi1pNHWmLpcDzUjzuD
	5aSkfx5fPlX5pUFG2CmstfASRrQ63+dQM5mTlVid5T6muXMYB1NQQUAAIcxcfrzy
	wHUURmxj/lFJZAf9AZ1E5GPMpW8r0RLdLBSOwLv/moIdG/Q3qaT908u6u1oIgu9b
	PskeO6wLgT32xzj9mL/h7ao0HKZxhnR/sjaTDQ2sG3vLM4aOncH4LGfBi7Jx7DV3
	LKXZRwYxi9Q5XbgRNzrXFTTkRSG1Y5FAbUa1UB7b+nUTSwWc1gTqNOsr364oQfPL
	bctg3oo0ldAphuHR+xxR6pWRCdWendzWdkuHtkXYvmZdnkyoZUElOPHQgszzQzeo
	CrN51MHMVNPoIq5z/1oRqDhsoVFxFXAcYLVnYeE7H4GvXVtuMemZhTqD+BA/6NwT
	SqTUsy33vVPmSFJjmn/tvfSVIgrlhtwm6JkSpb07cPbNQMeKU/GxTB2LFnXGrdr/
	wAwHDZztY0tpsDvixH8M6s2lGM/0u1DDmCxHziFGkzW/J6/LevhVXjR4FN7XRU0w
	IxboxRGK2GlTkinQ2lm+ZQT8pormbrRNl14AqXHt6qooU9worejDL6dKUzG5O3S3
	+0g/e1RMg1vpECBPGfocTU2K7/5W0JRByN/Hk/LW6RsMP3DFBCW8B589f4RdeBzx
	KjxnBXU=
Message-ID: <8d951db9-80a5-4209-ada5-6bba854e994d@prolan.hu>
Date: Mon, 25 Aug 2025 22:52:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: imx6-hummingboard: Replace license text
 comment with SPDX identifier
To: Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Rabeeh Khoury <rabeeh@solid-run.com>
References: <20250709-hb-dts-lic-v2-1-a168bd9d24bd@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250709-hb-dts-lic-v2-1-a168bd9d24bd@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E60706B

Hi,

On 2025. 07. 09. 9:28, Bence Csókás wrote:
> Replace verbatim license text with a `SPDX-License-Identifier`
> 
> The comment header mis-attributes this license to be "X11", but the
> license text does not include the last line "Except as contained in this
> notice, the name of the X Consortium shall not be used in advertising or
> otherwise to promote the sale, use or other dealings in this Software
> without prior written authorization from the X Consortium.". Therefore,
> this license is actually equivalent to the SPDX "MIT" license (confirmed
> by text diffing).
> 
> On top, half of the files have the fragment "either version 2 of the
> License" for some reason, and not follow up with "or any later version".
> So the resulting SPDX license is still "GPL-2.0-only".
> 
> Cc: Rabeeh Khoury <rabeeh@solid-run.com>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

So, Rabeeh, Russell, what do you think? Is there something else I need 
to change?

Bence


