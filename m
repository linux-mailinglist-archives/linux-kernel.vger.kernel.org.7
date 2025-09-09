Return-Path: <linux-kernel+bounces-807196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C02BB4A171
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3FA4E1798
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8C256C9E;
	Tue,  9 Sep 2025 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="uUz7NHrn"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBEA79DA;
	Tue,  9 Sep 2025 05:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757396761; cv=none; b=o3k/eUbk2Fd3kmQq/a1tI0OvFNsjoNy6VBqFcBPFox39/lbHMAHXaNClsFjXbb235zBmS/4VLzxzrxvbHL7mY+U/FYPd6umRuIYCIhCNhbYUP6i1CzWbWIZyrB6W++hFhpkweIjQWQQWkMJX8XFBB2QBzvLVou/ExvLK3lwXmZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757396761; c=relaxed/simple;
	bh=yJ/Rw85OvrNUxbRZVTZePsmYWNdIjtDRbL5OuuCOY9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OwK3Qo/4FCseIAEs6/icxI0JfSJEimPw0DUfuCQKcePw7aeoo0CwAuRITbc+2ziRvz23OLYUB5OjrGs7Ldvcq9k7iCwBinIvvsITaGfgABbUedLXku6HP2S4ZMmQSjZGC6xPIuFLWKfOD+VFMx3QILWfj+27rubyRidadoMG+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=uUz7NHrn; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1F941A075D;
	Tue,  9 Sep 2025 07:45:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=LkLVFVapCS9rw4tYTMr2
	CibTaZYukraHmu1rfU3DbGs=; b=uUz7NHrnIBGmHpnIKXyOM4UxmmFh1Zqu9t1h
	yVIROpTaOy+PFq5XcYYX8S6My57dyRzoDaQz5I11Sf6PiXYfl/Vgm19GwxUxS9Di
	XX30dMJEY7bc1D62Q5ZwqqBu3t28TbjkkEbTavu4ufdGyeqdcVaGs2qg//mz6XMD
	s6kSKSlwG+nJoltHJ3wG17NUEVYHK3yq3LzAkLnUvCenk07Nknc7Rjz4kD+EDa5e
	miZQT2aNhxZBrL7LBD10iOUTDHqoolrV6qNkGVAfD8oAbLeDUiB4hWXd8LeaO7tn
	k8LIZknlVpswq6lOBXwlunn8ZxgM1uJsMi+sJ2bavoA3wPCDzve+rP/poyb6lOPo
	mPMifIfgeFFK3TFMq3p/nR/EFQmyBka3CH1t43icEJgIm3XxjqPrDBCsf3rI0OoA
	tjo0BQov2cUEx0ubZlmHyMQ9nLDvApq/thofET/rdmhIDAtv531FbVkJlZcBxJsR
	fCJST1vm21JIw1NHlT8fmB6z88JwtoHFQfN5kBqGFOYLn2Y3le9CWxFV69cD8ccN
	T9K1+Vgxp7S0XNncuAacseZnLqMRWCf0OC8dTtCAoBjUCP/tvBz+dcFh6GcogzAp
	kuW6n7gBwY1iibfT4UuZ7kfvTJF09Gz7SGOwDicACUZ9GBc+9Gq/o9VIe4kd3TqF
	HcQ24zo=
Message-ID: <e79a6234-73ad-48f3-a3f4-3b05f309737d@prolan.hu>
Date: Tue, 9 Sep 2025 07:45:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM: dts: imx6-cubox: Replace license text comment
 with SPDX identifier
To: Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250812-cubox-dts-lic-v3-1-1eb7ef334934@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250812-cubox-dts-lic-v3-1-1eb7ef334934@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E627462

Hi,

On 2025. 08. 12. 20:39, Bence Csókás wrote:
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
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

So, Russell, are you happy with how this patch looks now?

Bence


