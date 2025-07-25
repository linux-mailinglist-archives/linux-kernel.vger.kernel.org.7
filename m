Return-Path: <linux-kernel+bounces-745665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6982B11CC7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC481C82DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FD82E11CA;
	Fri, 25 Jul 2025 10:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Gszfsmcv"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29D232368;
	Fri, 25 Jul 2025 10:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753440574; cv=none; b=A9MUs+7NEQu+lvoxZer07uR6eGc/DlQlWUcQvderRMv7YhQNhWBjgIOzS9dbV71O5dBFgUBNOReS9Mqpmz0whbAfMZ/dDlj2+3v3/jHRiuqt505Zvd25MsiBy+09RQHUDdKE1ptM/GrLDCmjNuFnLQoV/62wYkL+c/0h6ZpGPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753440574; c=relaxed/simple;
	bh=k1eCvJHtqFybyrGjvwFhvZTDeblqmze+kBTFJoffxPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sru6hCuKC2EWcPl6Ty4rPUNZFhIUdNxYtFE1/BV2OVaGNVAq52fzT7qEL7aKuPi/JsDtub4gC2hNqxgmgi5Pxx+r5APKwYBd1yiSkGy9WDC3qWKoBrScIxeo3gWLdF3MRuMajyqN6f7LR8ewKJKEasp0gTMLObeRz8yxYHyniw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Gszfsmcv; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56PAnQGY2164129;
	Fri, 25 Jul 2025 05:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753440566;
	bh=Pr/6oSAqPnzYKPrrPRbVgCiKh0qVmQrFdTLVSe8INZs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GszfsmcvHy6Xqg10sI/4FGHa6nXKEGw5pili1Qh/XAtrjH9hain81E9XdqUW+GLBf
	 InMiSh5ZC88O+NIS1bYV87nN7Xx22IOrI5W4AmZv91r/5GJhSZdBKkv+ZY0JDyQWva
	 N/0YzhPjf1m2t3TzI9qyOALO0ATfdhGMAUbamBpo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56PAnQvY3172460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 25 Jul 2025 05:49:26 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 25
 Jul 2025 05:49:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 25 Jul 2025 05:49:25 -0500
Received: from [172.24.18.25] (lt5cd2489kgj.dhcp.ti.com [172.24.18.25])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56PAnL3J1927218;
	Fri, 25 Jul 2025 05:49:22 -0500
Message-ID: <6a8545a6-14f0-4da9-a15f-504f0f3791be@ti.com>
Date: Fri, 25 Jul 2025 16:19:21 +0530
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
        <devarsht@ti.com>, <u-kumar1@ti.com>
References: <20250716060114.52122-1-j-choudhary@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250716060114.52122-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 7/16/2025 11:31 AM, Jayesh Choudhary wrote:
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

For series

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


>
> Changelog v2->v3:
> - Cosmetic changes like adding padding and new line before child nodes
> - Using standard node name for regulator and bridge
> - Remove "regulator-always-on" for dp-regulator in am68 and j721s2 board
> - Remove interrupt-parent from dsi nodes
>
> v2 patch link:
> https://lore.kernel.org/all/20250624082619.324851-1-j-choudhary@ti.com/
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

