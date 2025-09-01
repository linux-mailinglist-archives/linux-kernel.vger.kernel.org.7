Return-Path: <linux-kernel+bounces-794040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B57B3DBF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B64168D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6F62EFD86;
	Mon,  1 Sep 2025 08:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bI2mHmKh"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41C2EE289;
	Mon,  1 Sep 2025 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714140; cv=none; b=ujKlKQ/SujIHmm65GjqCWAs+tp7Dv1Gmgbde6Pqt1zNOgNMTwnASHaV1nNSrE1SE1C2NDcAH9T+kW6LIf8IoKyL7mFsLbTkeM4XoPmR4VgS9no74LAqjI0ItVVczCxsJK6UxQPFD+6hyeRmDc6M1LORQgeT4kMI2R5naCaVtfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714140; c=relaxed/simple;
	bh=lQFCBESfCD6ZlEd+cqgBBiwcFPKbRecod7f5lgntivA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aJGe9iHfonViDT1R4fKFyyFGdsIb0djteh4VGM+pndtmg/pD75Jo1u5eQkJMWrt3eokicwXb97V0d3qlWYh/x2eDpU+tM4iUUQWTTgGlwcdH0+SysuGwgnAFyMkxoARyPJSj9Yo5q8cnjsUJ5QYDGEIN22MLWCGG6A8PgxWQPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bI2mHmKh; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58188pCQ2327447;
	Mon, 1 Sep 2025 03:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756714131;
	bh=6cM/Eb/zYRQtpmXVh1mowJsQxkbwkg9juaU7jUzz+Fo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bI2mHmKhuTOB1xH1UTA2uufhRkvs4mJZnaOUOiBKF7VKBUnW2g48bsIusZLu0pf6B
	 KO/IWggKRbQ5UecATekgaDZWROFiTu+NFWK/vENmds4Ftf+ZLa2yGTwjgW+xMVsVS9
	 FXtWx/8Z9al+giT1Sgx2hHCzEyK0cUL+ZGrn7Yrg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58188pYT1398511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 1 Sep 2025 03:08:51 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 03:08:50 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 03:08:50 -0500
Received: from [172.24.231.157] (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58188lWl1864683;
	Mon, 1 Sep 2025 03:08:48 -0500
Message-ID: <25f630c5-8692-4063-9bfc-9f805fd3d3a1@ti.com>
Date: Mon, 1 Sep 2025 13:38:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: dts: ti: Add bootph-all tag to USB PHY
 controllers
To: Nishanth Menon <nm@ti.com>
CC: <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <danishanwar@ti.com>
References: <20250829074700.1531562-1-h-salunke@ti.com>
 <20250829120347.v2mhce4tntnewrm7@mushy>
Content-Language: en-US
From: Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <20250829120347.v2mhce4tntnewrm7@mushy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 29/08/25 17:33, Nishanth Menon wrote:
> On 13:16-20250829, Hrushikesh Salunke wrote:
>> This patch series adds the bootph-all property to USB0 PHY controller
>> nodes across multiple TI SoCs (AM62, AM62A, AM62P, J722S).
>>
>> The bootph-all tag ensures that these USB PHY controller nodes are
>> available during all boot phases, which is required for USB DFU
>> (Device Firmware Upgrade) boot functionality.
>>
>> This series is based on commit:
>> 8cd53fb40a30 Add linux-next specific files for 20250828
>>
>> Hrushikesh Salunke (3):
>>    arm64: dts: ti: k3-am62p-j722s-common-wakeup: Add bootph-all tag to
>>      usb0-phy-ctrl node
>>    arm64: dts: ti: k3-am62-wakeup: Add bootph-all tag to usb0-phy-ctrl
>>      node
>>    arm64: dts: ti: k3-am62a-wakeup: Add bootph-all tag to usb0-phy-ctrl
>>      node
>>
>>   arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi               | 1 +
>>   arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi              | 1 +
>>   arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> -- 
>> 2.34.1
>>
> 
> NAK! please do this for the boards that need this capability. bootph
> property at SoC dtsi level are mandatory components for ALL bootmodes
> and all boards.
> 

Thanks for the feedback. As suggested, I will update the patch series to
ensure "bootph-all" property is added only to those board specific dts
files which actually need it rather than the common SoC level dtsi
files.

Regards,
Hrushikesh.

