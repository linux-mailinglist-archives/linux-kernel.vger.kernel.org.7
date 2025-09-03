Return-Path: <linux-kernel+bounces-798580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B395B4201D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A914C166534
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E892741DA;
	Wed,  3 Sep 2025 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="scnU/fUz"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44A275B12
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904068; cv=none; b=Zg3w7zmD0/KSS3I9T0IwRf6fFHO47ydX+OF0rDBKNzuWJe4OZ4j7Dvfqjg7ug3eNzer0nej86jrNy3lMzqdApyXLtnAhW4GQfzdKiXjWBQ+7+LX5/2abaCOLkFAzGRKF7hmLPzI06GA7gWSxOZBJ2X/Rs8PhofNvJV3hZvEk3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904068; c=relaxed/simple;
	bh=rFtol2NY43ydgBTC7EwJRX2ILJ8oTstrkvPf9c2P/mo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEftytlsA5x6zg0uKccRgH03W45PsI1BPqI8vpie6GKgZC1HOejbNGtiknbJh3XGc/tqPYQrGrLC1olmr/w4tZ4SOZ/aq1szGasgqhwRzLwlPkYfcekzxE9mV+T1qVPjrnT+H7UAQX2GRyPPetYvVfHOFfvZbVrR/kxfHsHiEsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=scnU/fUz; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583CsLH92832602;
	Wed, 3 Sep 2025 07:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756904061;
	bh=NLuQseDYhWEMMHG36lWPn4i2gWh6Al0pz5nJt7HHLSo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=scnU/fUzQFsnpPQdKGiu1LWhWANKUakivU4aZmVhatDYKkaARq0X9ejRPreWoeS1S
	 gMUuX1kap2A3lKuJpF1MeOGcOB7JRUuXFFHXFkyJzBriinSxKxsdxI6Q3WAOAw+kuQ
	 R74rmpyFmdG/KFIMpv59Aav1njfiWIAX5NAmB0f4=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583CsKYJ088085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:54:20 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:54:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:54:20 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583CsKhI1587569;
	Wed, 3 Sep 2025 07:54:20 -0500
Date: Wed, 3 Sep 2025 07:54:19 -0500
From: Nishanth Menon <nm@ti.com>
To: Harikrishna Shenoy <h-shenoy@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <tomi.valkeinen@ti.com>,
        <r-ravikumar@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com--smtp-debug>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e-main: Update DSS EDP
 integration configuration register
Message-ID: <20250903125419.3ua7cwbqpwot5o67@linoleum>
References: <20250903105922.2602183-1-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250903105922.2602183-1-h-shenoy@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 16:29-20250903, Harikrishna Shenoy wrote:
> Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
> TRM Table 2-1 MAIN Domain Memory Map.
> Link: https://www.ti.com/lit/zip/spruil1/SPRUIL_DRA829_TDA4VM
> 
> Fixes: 92c996f4ceab ("arm64: dts: ti: k3-j721e-*: add DP & DP PHY")
> 
> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index ab3666ff4297..3fa7537d5414 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -1863,7 +1863,7 @@ mhdp: dp-bridge@a000000 {
>  		 * the PHY driver.
>  		 */
>  		reg = <0x00 0x0a000000 0x00 0x030a00>, /* DSS_EDP0_V2A_CORE_VP_REGS_APB */
> -		      <0x00 0x04f40000 0x00 0x20>;    /* DSS_EDP0_INTG_CFG_VP */
> +		      <0x00 0x04f40000 0x00 0x100>;    /* DSS_EDP0_INTG_CFG_VP */
>  		reg-names = "mhdptx", "j721e-intg";
>  
>  		clocks = <&k3_clks 151 36>;
> -- 
> 2.34.1
> 

Please repost with CC correct mailing lists and please use valid email ID.
./scripts/get_maintainer.pl is your friend.

I am not sure if u-kumar1@ti.com--smtp-debug is a valid email ID :) and
LAKML is called out in MAINTAINERS file.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource

