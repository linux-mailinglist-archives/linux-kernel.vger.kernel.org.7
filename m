Return-Path: <linux-kernel+bounces-747803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C5B1388C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94B53A1CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E22561D1;
	Mon, 28 Jul 2025 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YHE4xx0K"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3723AB9F;
	Mon, 28 Jul 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753697088; cv=none; b=VSGqgSypri+9pGKQRpFj7P4HHo6k49B55/hk90kClUxSYG48OaF4KXK9nLAWEWdqc/OEmID3ZTgqrn0lcjQj60iX5vQkJNIdSsExKxt99PTObRC/D/rtjQwP2o2XNzGuH1OxKRUeWP2Ycn6xfS7UkcrHywu8hur4EzXuYww5P58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753697088; c=relaxed/simple;
	bh=3X625z+16rlrSUBwNR6x75g+YtnDwZWLVEY9cjb2y/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EynRJiAofEfninDR9HlJ579GXk7bh+uvBI2gEjke3xtBvzpkCpzcoe3bbj5rgo5KtOOg1QiZ8JlEVcSloltETj64iSgQjeO6uo+qNdver/OALw36VV1tOE4jCEe441I0SXZRWhXZhd6XVhW75wkkTCi20gizjrDlSueHjq6C5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YHE4xx0K; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56SA4Poj2280777;
	Mon, 28 Jul 2025 05:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753697065;
	bh=4MeCrGZ4jM/mwWrVgLXe9zoaYmXCEGbQlg3VQ9zWfSU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=YHE4xx0Kc2dPbn0pH/EfQnaq8+UU4zfyDALAB0pIR8bJOnLZBfsHAS3XwxKGzUcRs
	 O2OnFBhkyL73APrxAKYDoCoDhwd1Ks99RWiQjmDemWqfZxOlOXtyAovG+YVUwFaq7q
	 BbwCTbSoqY2AMK8lQ8XmM5Ub1B9pIFvNW9W8pZ5w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56SA4Pn3212206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 28 Jul 2025 05:04:25 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 28
 Jul 2025 05:04:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 28 Jul 2025 05:04:25 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56SA4LtQ1566557;
	Mon, 28 Jul 2025 05:04:21 -0500
Message-ID: <b9ae56bf-dd61-414d-9d52-30cd6e4642db@ti.com>
Date: Mon, 28 Jul 2025 15:34:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Add DSI display support for TI's Jacinto platforms
To: Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>, <devarsht@ti.com>
References: <20250716060114.52122-1-j-choudhary@ti.com>
Content-Language: en-US
From: Harikrishna Shenoy <a0512644@ti.com>
In-Reply-To: <20250716060114.52122-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 7/16/25 11:31, Jayesh Choudhary wrote:
> Hello All,
>
> This series adds the dts support to enable DSI on 3 platforms for TI SoCs:
> - J784S4-EVM
> - J721S2-EVM
> - AM68-SK
>
> SN65DSI86 driver fix that was essential for display is now merged.
>
> There is one more series relevant for driver that makes CDNS-DSI driver
> work better:
> https://lore.kernel.org/all/20250618-cdns-dsi-impro-v4-0-862c841dbe02@ideasonboard.com/
>
> I have locally tested using kmstest utility on all 3 platforms.
>
> Changelog v2->v3:
> - Cosmetic changes like adding padding and new line before child nodes
> - Using standard node name for regulator and bridge
> - Remove "regulator-always-on" for dp-regulator in am68 and j721s2 board
> - Remove interrupt-parent from dsi nodes
>
> v2 patch link:
> https://lore.kernel.org/all/20250624082619.324851-1-j-choudhary@ti.com/

Reviewed-by: Harikrishna Shenoy <h-shenoy@ti.com>

Tested-by: Harikrishna Shenoy <h-shenoy@ti.com>

>
> Changelog v1->v2:
> - [4/7]: Add gpio-line-names
> - [6/7]: Remove unnecessary clocks from TIDSS
>
> v1 patch link:
> https://lore.kernel.org/all/02f1912f-0a05-4446-923a-7935ed305cb3@ti.com/
>
> Jayesh Choudhary (5):
>    arm64: dts: ti: k3-j784s4-j742s2-main-common: add DSI & DSI PHY
>    arm64: dts: ti: k3-j784s4-j742s2-evm-common: Enable DisplayPort-1
>    arm64: dts: ti: k3-j721s2-common-proc-board: Add main_i2c4 instance
>    arm64: dts: ti: k3-j721s2-common-proc-board: Enable DisplayPort-1
>    arm64: dts: ti: k3-am68-sk: Enable DSI on DisplayPort-0
>
> Rahul T R (2):
>    arm64: dts: ti: k3-j721s2-main: add DSI & DSI PHY
>    arm64: dts: ti: k3-j721s2-som-p0: add DSI to eDP
>
>   .../boot/dts/ti/k3-am68-sk-base-board.dts     |  97 ++++++++++++++
>   .../dts/ti/k3-j721s2-common-proc-board.dts    | 117 +++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  39 ++++++
>   arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  51 ++++++++
>   .../dts/ti/k3-j784s4-j742s2-evm-common.dtsi   | 121 +++++++++++++++++-
>   .../dts/ti/k3-j784s4-j742s2-main-common.dtsi  |  39 ++++++
>   6 files changed, 463 insertions(+), 1 deletion(-)
>

