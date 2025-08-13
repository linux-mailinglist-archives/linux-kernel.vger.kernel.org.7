Return-Path: <linux-kernel+bounces-766948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E1AB24D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45393A4940
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0472F6591;
	Wed, 13 Aug 2025 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="GhwELWec"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0162E62B0;
	Wed, 13 Aug 2025 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097900; cv=none; b=YDmJE1XoBYRJni05+1/ZJdoA8lOOy2uBR1fKz397vkN5y1/TLULd2KOqHPhXTJzbdgFijykpZu85h9barl98MojQ+xIPW9sUksCv0qtL0oJmQjMPmul7Y0oB4YnkaMBHRLhhjJZGSzDiCphNAbhcTXUrWTawUOPiv1NmQrtPwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097900; c=relaxed/simple;
	bh=Ye8Jm7fIId7BXsl1A0b32tlcCGzocCJI2em4ZIJ0umU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CX+asvFryyTSd4T5Jj+4mMD2njhDySZD/sLidtIuv09mEDoC7BY/vNvu4z8CrznHnwbGEOFtAnV2xGD7LhBzEdypuohSuazsIv2YYZgSq7NRFXqGx9IhtYBdsyl0pEZEA9geF8tUj+YQP6I9D8SSKrd4X3Mkz4ra0D3d+hfEHxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=GhwELWec; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 63AD7A061F;
	Wed, 13 Aug 2025 17:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=rNKKXxK3P24jwoIEtT+P
	8L73dlGuPGKm5hmRD8zmlCs=; b=GhwELWec6dChTfssS6ZlxRQM/JsDcZG2MQAz
	3LqA3VnhCkgYaxF8VI3uZLy5zBLXdZY2WbIn5ehRc76dVH3QaB30Kf1sxnJz4JB/
	0OjOkod2zRuBAF66hEQj0CPrvisnCdS3XBEh1wRCbRThtUIVR/EIgCW1sZdHNXNQ
	VICPbcwIkTaE4ePoxvlB/VroUPyvhj7AmPeAfgNOTSpnks4hRRv1kqG0TklOVb1O
	yXODS6Keq1L5q1yGcnuTVexr/tLU2Q1y7ou00av8G0L5ul4qdxvLJH2WOgOoINih
	44yEDbIhiKIgI9eUWDSZsxl8pvpbyHEGDiLQ6NxVsKVrVh8ewSr5zO5WinMltcLv
	P2ubxLeumsokN6iVjwc5SlaCUkFPr3YGrxR0imLKDn4dZ8VT+GRudc/5QRTCLj7H
	/GCCy6F3wmxDP03pDiQoiZV84H8/R4uUMQtUyQOt1FaFxzdpLINUqOAhPf4vSxKd
	Z2g8dOO0G8efXcmgYzjiSVvIVMP4dd/4AyRxNwNknauaoOa45aW9cypveDMnlcvy
	scKFVA1gXA729gBxFddEA4oMX8PbkYUynn9/lDC6jE4OvWPdrXDUA/V8wjULe0Yc
	/MekLncNFC7niwoeJGWg2RAJ1cQRnvt9PuU9s52PQzKvJZ9frLT3msiysDRQVXpO
	vECn6GQ=
Message-ID: <58709258-9154-4ec1-b64c-5be161b061e8@prolan.hu>
Date: Wed, 13 Aug 2025 17:11:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: imx6-aristainetos2: Replace license text
 comment with SPDX identifier
To: Heiko Schocher <hs@denx.de>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	"Pengutronix Kernel Team" <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: <devicetree@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"Erika Unter" <e.unter@denx.de>
References: <20250709-abb-dts-lic-v2-1-adc5e4781f65@prolan.hu>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250709-abb-dts-lic-v2-1-adc5e4781f65@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E617765

Hi Heiko,

On 2025. 07. 09. 9:28, Bence Csókás wrote:
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
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>

Do you agree with this change?

Bence


