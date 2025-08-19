Return-Path: <linux-kernel+bounces-775399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5185B2BEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DDD3BA370
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4902275B02;
	Tue, 19 Aug 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w6njBmZN"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076C2236E3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598538; cv=none; b=Je4d/CZvESqpd0Ke/y2siS1SdSfxsO0Vu2oQTXPBHV8SuH+4zX6s6nSiaieyQb+OLs0Wgz7hSzTd+K4QN2Z98SJ2SFKYflb8iJthw0f/tvC7Yw5PiYWVT19o34sKLIxtqdrLEcptpHuAiblzrjW/tzNuW1Q+TviS0gTBkJM5v1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598538; c=relaxed/simple;
	bh=nJQl9Ch0Uy/oTrJe71EX84ynhFQzPWraVK/yHg1T1hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gHTe7oHsa/jjhbAc50AAPFQuWMC6x1jpvns5zUROMNULU1qwtDKJH7uyD2Yv5+hMBztaGYCammsQ0Gr/PNMOwMnGKwncCRbNE4LE7IXcWYTZLL4S9m4t37cX11ZmVs6RWYUlzkB5uYWyHGJAHLD0hsIT+dwmLQ0xZip3VYPDZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w6njBmZN; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JAFRD63379172;
	Tue, 19 Aug 2025 05:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755598527;
	bh=vmqOt1qwxreP164gTUMizrtv+rOPrzbBFfbunezxMlk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=w6njBmZNGqy/ECKVZ8/lpw2s3Y0du4nFdlNVCcCVtBZybbPbvbEx2/UcJx1DY/xp5
	 SFzEQw+maoUpjTN/pTHqGpgLwAnRDifIiaNb3hiGndnWPq+01WmeVAAcyXVRJmvC7f
	 GxppNTMX0NYVx7l55R21K2n3n1reKvC76vSTRa+0=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JAFQr1333086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 05:15:26 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 05:15:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 05:15:26 -0500
Received: from [172.24.234.212] (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JAFNTe2555595;
	Tue, 19 Aug 2025 05:15:24 -0500
Message-ID: <a92812be-7370-4c55-8c3b-728834bd83c1@ti.com>
Date: Tue, 19 Aug 2025 15:45:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: multi_v7_defconfig: Enable more OMAP related configs
To: Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Davis <afd@ti.com>,
        Udit
 Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250806141808.4013462-1-b-padhi@ti.com>
 <133a5da2-d161-411c-9cc9-0bad46ab981d@app.fastmail.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <133a5da2-d161-411c-9cc9-0bad46ab981d@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Arnd,

On 06/08/25 21:11, Arnd Bergmann wrote:
> On Wed, Aug 6, 2025, at 16:18, Beleswar Padhi wrote:
>> From: Sinthu Raja <sinthu.raja@ti.com>
>>
>> This allows us to enable various peripherals in the TI OMAP family
>> platforms like AM571X-IDK, AM572X-IDK, AM574X-IDK, AM57XX-BEAGLE-X15,
>> AM57XX-EVM using the multi_v7_defconfig, instead of only with the
>> OMAP specific defconfigs.
> Hi Beleswar,
>
> It's fine to enable drivers that are only used on a specific
> platform, but those should generally be loadable modules, not
> built-in.


Sorry for the delay in getting back. I have sent out an v2 with your suggestions:
https://lore.kernel.org/all/20250819101137.2878336-1-b-padhi@ti.com/

Thanks,
Beleswar

>
> For the generic (platform-independent) options, I would
> suggest splitting them out into a separate patch, so you
> can describe better what the purpose is, since this is
> clearly not just for OMAP.
>
>> IKCONFIG*:
>> Allows reading the current kernel configuration through /proc/config.gz
> This one seems particularly unnecessary in a "defconfig" build
> since the configuration is already known based on the version.
>
>> THERMAL_EMULATION:
>> Adds emul_temp sysfs node under thermal zones to allow emulating
>> temperature changes.
> The documentation for this option suggests that we probably
> don't want it enabled.
>
>> FANOTIFY:
>> Allows sending open file descriptors to userspace listeners along with
>> file access events.
>>
>> USER_NS:
>> NAMESPACES:
>> Enable user NS to provide user info of different users for different
>> process.
>>
>> POSIX_MQUEUE:
>> Supports POSIX message queues for priority-based IPC.
>>
>> BSD_PROCESS_ACCT:
>> Enables BSD process accounting to allow user space program to write
>> process accounting information to a file.
> I assume these are all in order to run a particular userspace
> distro?
>
>       Arnd

