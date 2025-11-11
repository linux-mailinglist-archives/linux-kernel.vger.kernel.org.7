Return-Path: <linux-kernel+bounces-895111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE4DC4CE7D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06DE81898E74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3FE32ABE8;
	Tue, 11 Nov 2025 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsHXTiPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FC81EB193;
	Tue, 11 Nov 2025 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855774; cv=none; b=ulChkpLmKlrQYYlN4DeWD+XdpNfN9fsZ92ZmIqr2u9snWtC323urjAsSXoQ4TBAIzOWGvvBTymgwTcr61pHnlwaxFAS2+ueJD95U0hZQxOW9kXTcw3khAQWx3iXk+usJJWGHHWr9RfB/nh/jFXsuST/5j33SCIF6z2EPcos+t/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855774; c=relaxed/simple;
	bh=CFXh4Xm8/rRJnmZTeq6l2iyIhLTVvDEHDL2vkwX6aOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvURSOGSfO+9TYdleKugGJ8J/CG7H/XSSN9QCNxcKqoVdzDpELwTddK/iUXiB8thVxB61pMeP0EwgYWTQZBfehX5jRR7I+lUx9BRDAJEsLHkqfLs6J8w8LZ8S9oanRANElAjBx5XJtg/8pnhRl2ELQB0ubrtzd9GfmLWqymH9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsHXTiPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5ACC16AAE;
	Tue, 11 Nov 2025 10:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762855774;
	bh=CFXh4Xm8/rRJnmZTeq6l2iyIhLTVvDEHDL2vkwX6aOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hsHXTiPIuxl3XEZab9DppifhvX9IhmmCHPnamXurp6kxrMphi3tcLQJ1NUtS58OZz
	 f+JSJF7smo3VtgE543Pie9v4YYGPWuG2NvhT3H0W08uhmvl3lr1h/xt8eVorJNbm5y
	 b0mnKp98+vXxKIzOXTXVZ4d3QgLONfPzeCEPIHrgAsC9XUNKklJCFx7zOeDoWHAS8x
	 qjBoJ6CzeX5FQ5T5ksXV4Yf3p2ZWxINy6SqNqYVVRTmJuy8iPYJ1iKfbp9cHW94o67
	 9iGz386btTCWoWF5/8aO9CipEAy3auir12Jf/UOhCwfDq/n6jec9gqmyZqyWdAIvCZ
	 b11Cy1I6MqbUA==
Message-ID: <f7eb9c16-b93f-401d-aa69-d45baa5c9432@kernel.org>
Date: Tue, 11 Nov 2025 11:09:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: imx: move nand related property under
 nand@0
To: Frank Li <Frank.li@nxp.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
 <20251104-gpmi_dts-v1-3-886865393d0f@nxp.com>
 <20251105115538.GA17091@francesco-nb>
 <aQttQb5GesjUtBw6@lizhi-Precision-Tower-5810>
 <20251107155201.GA119737@francesco-nb>
 <aRIPAagk2tzqnoSB@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aRIPAagk2tzqnoSB@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/2025 17:12, Frank Li wrote:
> On Fri, Nov 07, 2025 at 04:52:01PM +0100, Francesco Dolcini wrote:
>> Hello Frank,
>>
>> On Wed, Nov 05, 2025 at 10:29:05AM -0500, Frank Li wrote:
>>> On Wed, Nov 05, 2025 at 12:55:38PM +0100, Francesco Dolcini wrote:
>>>> On Tue, Nov 04, 2025 at 05:27:14PM -0500, Frank Li wrote:
>>>>> Add child node nand@0 and move NAND related property under it to align
>>>>> modern nand-controller.yaml.
>>>>>
>>>>> Fix below CHECK_DTBS warnings:
>>>>>   arch/arm/boot/dts/nxp/imx/imx6ull-colibri-aster.dtb: nand-controller@1806000 (fsl,imx6q-gpmi-nand): Unevaluated properties are not allowed ('nand-ecc-mode', 'nand-ecc-step-size', 'nand-ecc-strength', 'nand-on-flash-bbt' were unexpected)
>>>>>         from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#
>>>>>
>>>>> Since 2019 year, commit
>>>>> (212e496935929 dt-bindings: mtd: Add YAML schemas for the generic NAND options)
>>>>> NAND related property is preferred located under nand@<n> even though only
>>>>> one NAND chip supported.
>>>>>
>>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>>>> ---
>>>>>  arch/arm/boot/dts/nxp/imx/imx6-logicpd-som.dtsi           |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6qdl-icore.dtsi              |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-pfla02.dtsi      |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6qdl-phytec-phycore-som.dtsi |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi           |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6qdl-tx6.dtsi                |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6ul-geam.dts                 |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6ul-isiot.dtsi               |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6ul-phytec-phycore-som.dtsi  |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6ul-tx6ul.dtsi               |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6ull-colibri.dtsi            | 12 ++++++++----
>>>>>  arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea.dtsi   | 12 ++++++++----
>>>>>  arch/arm/boot/dts/nxp/imx/imx6ull-myir-mys-6ulx.dtsi      |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx6ulz-bsh-smm-m2.dts          |  6 +++++-
>>>>>  arch/arm/boot/dts/nxp/imx/imx7-colibri.dtsi               |  8 ++++++--
>>>>>  15 files changed, 82 insertions(+), 22 deletions(-)
>>>>>
>>>>
>>>> Was any of these changes tested? Is the driver able to cope with the
>>>> binding change?
>>>
>>> I have not board to do direct test. This format is used at imx8 platform,
>>> which use the same gpmi driver.
>>>
>>> This properties are parsed at mtd common part
>>> drivers/mtd/nand/raw/nand_base.c
>>>
>>> If you have one of above board to test it, it will be appericated.
>>
>> I did a minimal boot test, on colibri-imx6ull, and the board was booting
>> fine, with Linux 6.18.0-rc4 and this patch applied.
>>
>> I am wondering if there is any impact with the bootloader, this DT is
>> used as it is also in U-Boot, and there the NAND driver is for sure
>> different. Any comment on this? I was not able to test this combination.
> 
> Uboot should have theirself tree, which copy dts and not direct use it.

Sorry, but what? No they shall not.

There is only one DTS. For all upstream users following kernel style,
which includes BSD and U-boot and probably many more.


Best regards,
Krzysztof

