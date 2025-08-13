Return-Path: <linux-kernel+bounces-766989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD7DB24D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1763E3B3B64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAAF238C3A;
	Wed, 13 Aug 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="c1mbcx01"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E63B1EDA2A;
	Wed, 13 Aug 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098975; cv=none; b=mExCkFnvShlBGnDvpM/VJ3ycZwWSHrGdSAB2Vmazjwprr1oOEYsGowN1/MuDd8y7ePjEC8E92SSkJ4TIeYozgaIRo8yk9xyIkiGG/zHp0uZQBegd9DP1E1BaxmTudgFpln4qKg51Wh/6XnpsvrPQ5thptg2+svSWNEoYyScV0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098975; c=relaxed/simple;
	bh=MR0DcSztgKA4jVA39j6euLbkCbLBnVIqd8/aw4ObGKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MANKYlOQYjQqiS2B1KT2YsqtgHN5k0XN04CoroFIt4S0ox1srql45bxbUfGGdXmPbTxqx8elNuMTPiM5pAYqbNVI01PXPIll6B8q1Yfczto5oEE31tFtBbWO7twhv5rFanXqdPtL8e+fqBV2zrHvvlwnKSa3RgzAnNt+8judKks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=c1mbcx01; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id DBF74A09CA;
	Wed, 13 Aug 2025 17:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=EmjzUDwTEf/ZVzLY6NpU
	Z7nq/gf392CNl+RtZjfZyd4=; b=c1mbcx01jkNEjwmMwbywiKqeRa2FdI/RIrSg
	umyluj/3Jz/VgcmHExvEZ83/8clhYcXKnl4CNtKXLL4C6sVBzFUAIjIVFkIWmX1K
	nWxzKsfWoB2/JqsuF2IIcTMZPu//8sLeZn5YkTpFL9NA7G49np1e6iNV5ZAawslC
	aYeBn1UUll7OpxgQEapTQLW2IvXkuxUx7CcI436lWs8HpoCDSVjfI95sFiaW+Rap
	cZdezw/NX7gwsL05oWWbrOrA4eMYPVc9ZfqGn8+XcpyGsXdQGcT7bCkPEU6VzfVr
	w0toicu09s82GfT4ds9Z0yrh6gGZqg7ZE8dChtnkptX8Yad++Oov3h0tfpBRO6dl
	pdDztiYuLU/yn1hM2KPBDRir09691LBhPlb5uLBiK0a7O+5a96VbYeMcTtGqDTOc
	QGVnKDOZAXKZifJdHf9FInn4bG3oeC/EUXYmmTzS/OU+/GYRT348fgzEPKePlQ0x
	Oft+ihlf9gHnF6ddkab0qJp4lGIZtsSGCoiKo+gbzTp60ug2CtIs2AWFlfUajqkQ
	HbV/8dWEvFk14kMYJZ0wZUs/umE/Hn6BUZgkKFEt3MQxVS1dprivtz0x9x/2nOhr
	yO+W5k22H7qaRqWDAj7B2hWObNHnV2mPCF2UGFLW0mlB4RQH4SKWHYSPLpqJ2Swd
	nrQGohI=
Message-ID: <db71a9dd-72b0-47ef-a7f0-bd527262c4e9@prolan.hu>
Date: Wed, 13 Aug 2025 17:29:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: imx6-litesom: Replace license text comment
 with SPDX identifier
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Marcin Niestroj <m.niestroj@grinn-global.com>, Piotr Figlarek
	<piotr.figlarek@grinn-global.com>, Marcin Niestroj <m.niestroj@emb.dev>
References: <20250709-litesom-dts-lic-v2-1-b907084ced96@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250709-litesom-dts-lic-v2-1-b907084ced96@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E617765

Hi,

On 2025. 07. 09. 9:31, Bence Csókás wrote:
> Replace verbatim license text with a `SPDX-License-Identifier`.
> 
> The comment header mis-attributes this license to be "X11", but the
> license text does not include the last line "Except as contained in this
> notice, the name of the X Consortium shall not be used in advertising or
> otherwise to promote the sale, use or other dealings in this Software
> without prior written authorization from the X Consortium.". Therefore,
> this license is actually equivalent to the SPDX "MIT" license (confirmed
> by text diffing).
> 
> Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

+Cc: Piotr Figlarek

> ---
> Changes in v2:
> - Fix msg
> - Link to v1: https://lore.kernel.org/r/20250702-litesom-dts-lic-v1-1-401e4d141bf0@prolan.hu
> ---
>   arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts | 38 +-------------------------
>   arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi  | 38 +-------------------------
>   2 files changed, 2 insertions(+), 74 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts b/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
> index 5e62272acfba..7a4127670a6f 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-liteboard.dts
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>   /*
>    * Copyright 2016 Grinn
>    *
>    * Author: Marcin Niestroj <m.niestroj@grinn-global.com>
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
>   /dts-v1/;
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi
> index 8d6893210842..c387753f833b 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ul-litesom.dtsi
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
>   /*
>    * Copyright 2016 Grinn
>    *
>    * Author: Marcin Niestroj <m.niestroj@grinn-global.com>
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
>   #include "imx6ul.dtsi"
> 
> ---
> base-commit: 66701750d5565c574af42bef0b789ce0203e3071
> change-id: 20250702-litesom-dts-lic-ad9774ebde3d
> 
> Best regards,



