Return-Path: <linux-kernel+bounces-808583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35595B501E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 524A17AA038
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CAD27466A;
	Tue,  9 Sep 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TCqAfMX7"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3871A7253;
	Tue,  9 Sep 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432949; cv=none; b=HjtN28VBjNQNxYWz00NPe6zb6ofmj91ntcfuqSzRqZCNVK8i1ltwAVZYZX+JjSf9nuSgQ/YXmCl6bIGtkmD/uQwY2yHiJxqmYJAGWkiZTCYrdQD7rk67oqNkAjSyejx0kjxMqyyzG4zCpiPKZjVX3u7A+y5ZyyS+5UqbASUWbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432949; c=relaxed/simple;
	bh=dHDWslSUN5qjeF54dGcCHKAmPaXKcOdd8JVtArwQHwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QQi20OQx52Zyblt8hU4fXV1/SzGPq7lDEAdmqlm6YgOsTe4Exf87k7bTpITuWv+rVuxOOvQsxQu+9X7wU//gLFaNhRozKls710nhYHOaccqAZG9iPPE04I0b+64+7G9dnkJLOwu8Ed6VseINSLbc4J+CJjHrJif5PGIhalGXrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TCqAfMX7; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 29FD9A09D7;
	Tue,  9 Sep 2025 17:48:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=kH++1lRd3b590KtsiJ2D
	GXmZpkwvUsmHCqZRXED4GfU=; b=TCqAfMX7NO3TWA7vFyNOiUSla1GlfKUSPtYl
	wdZ1JPQSS9MvP/QTzGcSyKx5FDr6B4yim9+RftMGuqx6UwkA1dIrKdEZOS5F6hPL
	j44u9gRKE5TiDng3lY8jOy2yKXjJyEhoUjz8Vd8YHyy1Wtve1JZFVGRMM0LPrs4i
	H6K45Z0WiVV0iXf5Vu82DWR/0Ic+BIRhRs//mCd1DgCi21DGLhpjOdfLZgKJp7H8
	tElGF6gUYcFHQFeidp+GZWrHvca5RLG+3YBCXxBR66d0VZtpwT4GlThNLlLFLUDO
	AmcfISk945iKEsVEhxhHTl54lSRGMhkxEzUFXd42MMrnpgsnAAu4HOq+DfzQT90e
	q8FLU/owU0Vdg+BgWRTVz1NkT4+Mb3M9CJQ9BT7UrOKH5djtTDrOehSVwUkYEP64
	LDtlSKJliHgY6rzunur9xFXINR5UOPN6aI4BRv8fwoHXeuNd8YaaMP7Y7uHRyIzW
	jMs2abbwkYXHfQAAqwvyhDgknrb1YEblPDZpQJhOHGxThXaGiu6cNMS/F2erw3Er
	QqIIJBWFHUaaCCBFq0iDvbS0wplWphEXyHA65mdnbLcpsYUNd9YQcXzZYeSBLdtT
	Rxzs2iVkHQaot20y4TWUphcn/oYuiMJMi9YA4Vw6RIEetZfDdhWlntaampQP/EML
	GvjVSdQ=
Message-ID: <b48844bc-07f3-4fc1-8486-8968bf6d2362@prolan.hu>
Date: Tue, 9 Sep 2025 17:48:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ARM: dts: imx53-usbarmory: Replace license text
 comment with SPDX identifier
To: Andrej Rosano <andrej.rosano@reversec.com>, Andrej Rosano
	<andrej@inversepath.com>, Andrea Barisani <andrea@inversepath.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob Herring
	<robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>
References: <20250814-imx-misc-dts-lic-v2-0-faff7db49a5f@prolan.hu>
 <20250814-imx-misc-dts-lic-v2-2-faff7db49a5f@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250814-imx-misc-dts-lic-v2-2-faff7db49a5f@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E627464

Hi,

On 2025. 08. 14. 9:47, Bence Csókás wrote:
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
> Cc: Andrej Rosano <andrej@inversepath.com>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

+To: Andrea Barisani <andrea@inversepath.com>

Andrej, Andrea, do you agree with this?

Thanks,
Bence


