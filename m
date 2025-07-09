Return-Path: <linux-kernel+bounces-722790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64AFAFDED3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58A53A98CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B5026773C;
	Wed,  9 Jul 2025 04:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j+k1uB0Y"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF18479;
	Wed,  9 Jul 2025 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752035498; cv=none; b=GWYPpWO32uOlXjPV7QlvhZTm1yBgr30tC2OpfQW5Syj2OkPJhL2l6LdTOsswXGk9/jSFjz2kIn9/RfCXabQnJp6qrLkClHO2wEdQDVNEMo+0100Yt5j6n2Xl5itj8LcFnLQfGjinNBpNZKk3J3Nj2ZZibKfBWCcAQy7vobhp/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752035498; c=relaxed/simple;
	bh=QW6FLKLQfY2KXZxf//CBL9WLbfjYou5RTHQZjz9pexo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K9CYQx5Y2h+Jt4rpwHddHXNFpqNYJmFTUHSblEF58fp2+pRkfatd+oS+Ekk5UdalfpdBepF0LKf52EUAS+GRdoTj3b0sthQiamDnBvTAnqzW/0SZOGa5KEdo/Fhdiz7TyYgXcJt4ngrwM0E2IKmogRYTQ9+2ga6qp1Tc7dGy4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=j+k1uB0Y; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5694VTDj1097362;
	Tue, 8 Jul 2025 23:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752035489;
	bh=7aCkvXG+MKXaSJ9xOt5eq6LqiDFxhDDJkRJ+9+GQMMc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=j+k1uB0Ysvn6ghoyNS6FLYzyJH2szOhnMXzwGDbVwdHJPTXlbQtx0AWOyoxhTZ9IM
	 J1hF0KwB1rqlo4/0/nlpOgq3GrlYYLf3boVFEWp5TyYFj2y4pwxBQ4bDl+JQxnk1ID
	 3Q8GoEijTDYU/VCysbDhTXoWg/BZmr2CS7WTnqeg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5694VTcC2109600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 23:31:29 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 23:31:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 23:31:28 -0500
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5694VP9j3284330;
	Tue, 8 Jul 2025 23:31:26 -0500
Message-ID: <f2c47f1d-02ab-4a76-b232-0647be27d044@ti.com>
Date: Wed, 9 Jul 2025 10:01:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: ti: k3-am69-sk: Add bootph-all
 property to enable Ethernet boot
To: Chintan Vankar <c-vankar@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Nishanth Menon <nm@ti.com>
CC: <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20250708084252.1028191-1-c-vankar@ti.com>
 <20250708084252.1028191-5-c-vankar@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250708084252.1028191-5-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 08/07/25 14:12, Chintan Vankar wrote:
> Ethernet boot requires CPSW nodes to be present starting from R5 SPL
> stage. Add bootph-all property to required nodes to enable Ethernet boot
> for SK-AM69.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> This patch is introduced new from this version.
> 
>  arch/arm64/boot/dts/ti/k3-am69-sk.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index f28375629739..a1a16151015e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -568,6 +568,7 @@ J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
>  			J784S4_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
>  			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
>  		>;
> +		booph-all;


Please test your patches!

>  	};

-- 
Regards
Vignesh
https://ti.com/opensource


