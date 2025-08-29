Return-Path: <linux-kernel+bounces-791173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C746BB3B2DE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 996734E1BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134D22D4F1;
	Fri, 29 Aug 2025 06:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hXp00+zS"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C01221F15;
	Fri, 29 Aug 2025 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447392; cv=none; b=OmQAJecJN5xdgpkDc/ZN/ZEWbpy59QVQH3CX9zXY246yuVrr16odv50OuQi2hYk7ZiF7orBJeQksh+On385CNXp2iDPX1brTUK5J2UF5yN1GisXD3s2uvjKYZtdqQzf6difns1XEBoIYLlOvXxLu65dt4X6kBM0O/pXcLsIRpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447392; c=relaxed/simple;
	bh=FaCbYkm3D+dAUgz/KUTMt7nQlTsb/6sXwJR7a006pDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DGEfXTkAewBDlhz4oCYkPnCkVDFcLFoN5+sETBJEdwhvLz3kGBha6KbkO2bRNhogrA/mQ7RamF3sPdmCjwyD37pTd0PSF+TbNxUaLYeAYQAVD/nAQJmR4RK0mKXl7j703mBZoNUo01tpR1CFDRICJYKP488K3AQzz1BXwmtwEOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hXp00+zS; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T62t3B1686363;
	Fri, 29 Aug 2025 01:02:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756447375;
	bh=FaCbYkm3D+dAUgz/KUTMt7nQlTsb/6sXwJR7a006pDE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hXp00+zS9Co8zbtsZ/N6SdXSl8ghhRxsSsaoDDnPxJ255qssrT+8JjY0E8QNc1atr
	 SVbAWldeSH8dYe8HNcV6WaG+515tl02vEThND6k1nVI5AqZdIbpNd2pLkYicktMTlX
	 M0njbjPkYPV7VdRe03Wx9WdqWIex/rMghn7ag1oA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T62s533438457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 29 Aug 2025 01:02:54 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 01:02:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 01:02:54 -0500
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T62nvC1872968;
	Fri, 29 Aug 2025 01:02:49 -0500
Message-ID: <877c2edd-851d-4722-8bb4-94fdc3c058a0@ti.com>
Date: Fri, 29 Aug 2025 11:32:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/33] arm64: dts: ti: k3-am64-phycore-som: Add missing
 cfg for TI IPC Firmware
To: Wadim Egorov <w.egorov@phytec.de>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Matt McKee <mmckee@phytec.com>,
        Garrett Giordano <ggiordano@phytec.com>,
        Nathan Morrisson
	<nmorrisson@phytec.com>, John Ma <jma@phytec.com>,
        Logan Bristol
	<logan.bristol@utexas.edu>
References: <20250823160901.2177841-1-b-padhi@ti.com>
 <20250823160901.2177841-19-b-padhi@ti.com>
 <b745deb3-b625-472b-b55a-468eebbdfb16@phytec.de>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <b745deb3-b625-472b-b55a-468eebbdfb16@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Wadim,

On 28/08/25 17:12, Wadim Egorov wrote:
>
>
> On 8/23/25 7:08 PM, Beleswar Padhi wrote:
>> The k3-am64-phycore SoM enables all R5F and M4F remote processors.
>> Reserve the MAIN domain timers that are used by R5F remote
>> processors for ticks to avoid rproc crashes. This config aligns with
>> other AM64 boards and can be refactored out later.
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>
> I am not sure you need this patch, because you are deleting everything you add in patch 32.


I am also including the "k3-am64-ti-ipc-firmware.dtsi" in patch [32/33]
which has these timer configurations.

This [18/33] is an intermediate patch. We are putting all AM64* boards
into same configuration first before refactoring everything into a
common file [32/33]. That way if there is a bug someday in the future,
due to added configs, the bisect lands on the [18/33] patch and not on
the refactoring patch[32/33].

Just trying to keep every file same before & after the refactoring patch

> But I tested the series on our hardware, so
>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>


Thanks,
Beleswar

>
>> ---
>> Cc: Wadim Egorov <w.egorov@phytec.de>
>> Cc: Matt McKee <mmckee@phytec.com>
>> Cc: Garrett Giordano <ggiordano@phytec.com>
>> Cc: Nathan Morrisson <nmorrisson@phytec.com>
>> Cc: John Ma <jma@phytec.com>
>> Cc: Logan Bristol <logan.bristol@utexas.edu>
>> Requesting for review/test of this patch.
>>
>> v2: Changelog:
>> 1. Re-ordered patch from [PATCH 28/33] to [PATCH v2 18/33].
>>
>> Link to v1:
>> https://lore.kernel.org/all/20250814223839.3256046-29-b-padhi@ti.com/
>>
>>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 24 +++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>> index 03c46d74ebb5..1efd547b2ba6 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
>> @@ -275,6 +275,30 @@ mbox_m4_0: mbox-m4-0 {
>>       };
>>   };
>>   +/* main_timer8 is used by r5f0-0 */
>> +&main_timer8 {
>> +    status = "reserved";
>> +};
>> +
>> +/* main_timer9 is used by r5f0-1 */
>> +&main_timer9 {
>> +    status = "reserved";
>> +};
>> +
>> +/* main_timer10 is used by r5f1-0 */
>> +&main_timer10 {
>> +    status = "reserved";
>> +};
>> +
>> +/* main_timer11 is used by r5f1-1 */
>> +&main_timer11 {
>> +    status = "reserved";
>> +};
>> +
>> +&main_r5fss0 {
>> +    status = "okay";
>> +};
>> +
>>   &main_i2c0 {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&main_i2c0_pins_default>;
>

