Return-Path: <linux-kernel+bounces-829340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D8B96D85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 150E77AD0AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A435B328594;
	Tue, 23 Sep 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IxSv1tFb"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A3328562
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645240; cv=none; b=LVV587bXNRD8Xe4GKBsWLVMWnOv/9f/s/MTGz+gKVnaCagmW2iNX0MaUY86NJNMqIVdOF65Flv31ExH4l0QNM/M1mx9NnZdGx44mhfK5ugmdWEPt+ICTQe11f/J5E0slfYUHWopBrzCxdh8MlRcnzzaknr9Z3sTmEo4AvSo5nLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645240; c=relaxed/simple;
	bh=oQO5uXI6/yKG4Ie6ao7EnmBkagYnHlh4OZll8X7T5H4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkfNzXrtFjt3oboaygT/q+xYLMbJ2hKUABEkFhAJomzZ1M0dhc7k2Gq26JMgGq70hsfQVS9q4tvxk5HYDFKTrYTz7vJoufto1Npf+njvH9t9hWCOm4JOiuYx9bxFB5gwyS/byO+eVlauref2G2MsjlBUI3CKMx6jqn9yfnIrlk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IxSv1tFb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6A1F3C00787;
	Tue, 23 Sep 2025 16:33:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4701860690;
	Tue, 23 Sep 2025 16:33:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8CC2102F1960;
	Tue, 23 Sep 2025 18:33:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758645227; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Nf6TbTTKpnL7mG5m//aAjoL13/cGP7KHINrrFH8p8l8=;
	b=IxSv1tFbbPL+umkvEM7djR6Yg3cz7Q2UpQOiuIDLVBOMNmPas+rqfuSPpYEwwmPnwbbhX7
	iyU8gRAEFEJxOGVjk8oFOFWqQuy193oS6ZkWZpkcspm4SOvyMGLSOcQiClfSkZGuzzMd/x
	mLJHUPoAEORo8qPGaXuGZD9o2RMTCUz/YiULpu35NKxe33xKoLQGEGmuntusBxIE+/PuAx
	bvmgZZ8PVFakA5zNOGZgzYYrnHournuWPnsbUmBuK43eReNjZ28U2VPgEmhK/7LSESXVZ/
	wngvVxssQbdW6trXKSOS0w4l66tKt7FP4VecgcIMU7IYm57HE55YXPI6spxjHw==
Message-ID: <bbcca781-9ac4-4eec-b3fb-ff4e01950127@bootlin.com>
Date: Tue, 23 Sep 2025 22:03:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] ethernet: eswin: Add eic7700 ethernet driver
To: weishangjuan@eswincomputing.com, devicetree@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, vladimir.oltean@nxp.com,
 rmk+kernel@armlinux.org.uk, yong.liang.choong@linux.intel.com,
 anthony.l.nguyen@intel.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 jan.petrous@oss.nxp.com, jszhang@kernel.org, inochiama@gmail.com,
 0x1207@gmail.com, boon.khai.ng@altera.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 lizhi2@eswincomputing.com, pinkesh.vaghela@einfochips.com
References: <20250918085612.3176-1-weishangjuan@eswincomputing.com>
 <20250918090026.3280-1-weishangjuan@eswincomputing.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250918090026.3280-1-weishangjuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 18/09/2025 14:30, weishangjuan@eswincomputing.com wrote:
> From: Shangjuan Wei <weishangjuan@eswincomputing.com>
> 
> Add Ethernet controller support for Eswin's eic7700 SoC. The driver
> implements hardware initialization, clock configuration, delay
> adjustment functions based on DWC Ethernet controller, and supports
> device tree configuration and platform driver integration.
> 
> Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
> Signed-off-by: Shangjuan Wei <weishangjuan@eswincomputing.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>   drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
>   .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 230 ++++++++++++++++++
>   3 files changed, 242 insertions(+)
>   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index 67fa879b1e52..a13b15ce1abd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -67,6 +67,17 @@ config DWMAC_ANARION
> 
>   	  This selects the Anarion SoC glue layer support for the stmmac driver.
> 
> +config DWMAC_EIC7700
> +	tristate "Support for Eswin eic7700 ethernet driver"
> +	select CRC32
> +	select MII

Seems like CRC32 and MII are already selected by STMMAC_ETH. I guess 
this is inspired by CONFIG_DWMAC_DWC_QOS_ETH that also seems to have 
these unnecessary dependencies.

Maxime


