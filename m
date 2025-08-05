Return-Path: <linux-kernel+bounces-755916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5A6B1AD4F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CBA73BC167
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596F218592;
	Tue,  5 Aug 2025 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G3Z6h5jZ"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61132288DB;
	Tue,  5 Aug 2025 04:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754369788; cv=none; b=uAQTCk29RcEpfY1rn3ibrwyC4wFJhz/M3CIChjym44P6/7IYUSj3I5ReSpFM7QNWs+OCqZkHH+VjZHsbA2qVZ3XSI6bM5FswugpuWjfY1o2Soka0WudVIJmRPPGIlthuARwqlFcY1rgI3j8xKt2e9N1Ad6QFJTgYAUHAxv1mFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754369788; c=relaxed/simple;
	bh=4UMJ7AYTejC0cbJn4XRjuEKExVDbgONFQ2SxHGgIoy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LxdDCKfrPFLAL7JKXR/MuM6l7OSrKBonAy0ef9IBlHKFP976j6RMuecDwKgc4tzJY4T1YXGmP7IVGkWOGBMg9pC5LA4n9cN12TxSPTiroE9qW9/qN7KiDXd+jd3YhZ+LGDRk5f+M8ZwNdejRB/NnblfJcn4rTz07zvCrN6jGUqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G3Z6h5jZ; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5754uGaO206029;
	Mon, 4 Aug 2025 23:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754369776;
	bh=DRU7MBSf2wWijMMbUefq1mXuYp0x7VCTRKxEugD/E+o=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=G3Z6h5jZvN1fnqoWcZmjOkbHJQKq+XtmD+mb6onaxsjXu3J4ysgPJXkjThlWOZCFV
	 XMhcQiI5LUdSMwsYyzqEioeQwHpRTrybU9n1oLqpYsaQ5B79rlONY0xCFpVnej78/0
	 0+5xB/0UkLSLwqxkliMf+zKyd5GqUhVNbY3PdkkI=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5754uGEV2542974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 4 Aug 2025 23:56:16 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 4
 Aug 2025 23:56:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 4 Aug 2025 23:56:16 -0500
Received: from [10.249.145.16] ([10.249.145.16])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5754uBGR1259545;
	Mon, 4 Aug 2025 23:56:12 -0500
Message-ID: <dcacfd08-8a2b-4da3-a7b2-42150540eaab@ti.com>
Date: Tue, 5 Aug 2025 10:26:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j722s-main: Add E5010 JPEG Encoder
To: Brandon Brnich <b-brnich@ti.com>, <linux-kernel@vger.kernel.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Udit
 Kumar <u-kumar1@ti.com>, Darren Etheridge <detheridge@ti.com>
References: <20250804180106.2393256-1-b-brnich@ti.com>
Content-Language: en-US
From: devarsh <devarsht@ti.com>
In-Reply-To: <20250804180106.2393256-1-b-brnich@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Brandon,

Thanks for the patch.
On 04/08/25 23:31, Brandon Brnich wrote:
> This adds node for E5010 JPEG Encoder which is a stateful JPEG Encoder
> present in J722s SoC, supporting baseline encoding of semiplanar based
> YUV420 and YUV422 raw video formats to JPEG encoding, with resolutions
> supported from 64x64 to 8kx8k.
> 
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> ---
> 
> Changes in v2:
>   - remove invalid clock-names attribute
> 
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 5cfa7bf36641..fb24c14614b4 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -385,6 +385,16 @@ c7x_1: dsp@7e200000 {
>  		ti,sci-proc-ids = <0x31 0xff>;
>  		status = "disabled";
>  	};
> +
> +	e5010: e5010@fd20000 {
> +		compatible = "img,e5010-jpeg-enc";

This is missing ti specific compatible. As we don't use the IP block
directly but there is a wrapper used to integrate with TI platform, so
it is better to use TI specific compatible too to account for the future
compatibility as discussed here [1]. You can refer AM62A device-tree [2]
for references on this.

[1]:
https://lore.kernel.org/all/50d97c30-4926-0bbf-1209-dfd25043e359@ti.com/
[2] :
https://gitlab.com/linux-kernel/linux-next/-/blob/master/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi?ref_type=heads#L1150

Regards
Devarsh

