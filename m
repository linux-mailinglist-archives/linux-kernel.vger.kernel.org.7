Return-Path: <linux-kernel+bounces-774007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091A5B2AD81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A30A16C9D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816E322DD6;
	Mon, 18 Aug 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ftLynG5m"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230335A28A;
	Mon, 18 Aug 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532575; cv=none; b=XLm/hf/QuYJl408Av7JfBKh+yiajG8g9nq93Ypwkd5KR+dBkNp4WkccE8QFdLh8tHQS5xvVbL4cV5TeeWpSluxATmcscZhg4wiMg7GMmpwspOJBvlvB8vSgYg/zcBOhPN9SIwmlXyR7GJMqor1mtWsPswhPdvGwumlP6QtLbxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532575; c=relaxed/simple;
	bh=SxiNEnTOiIMgcErCvz6/vPTFNfqv77e2dsq9j1+gqLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i+N+z7MoAyBQAmimca8kRhGub+WkKp65Y6paiORUeflz0aEWutL2hWUvD1GPP3xmNLuR8U4BA5x+Mbn4gAaccTw9NQOy6jFwlLEZ5ICH1GjVX+tM5TPA9seVhDX2EtMdQ2UH0Eow50RSwnHluW5EEQp0wXi4F14PyVpFNzjYGcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ftLynG5m; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IFu7li3198155;
	Mon, 18 Aug 2025 10:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755532567;
	bh=SxiNEnTOiIMgcErCvz6/vPTFNfqv77e2dsq9j1+gqLk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ftLynG5mp+hJLRR0WimFRxLw2JCDTNq32taIkyAemhEhTHy+91IcNOwogrU84x4qY
	 PGY3Rm1fy+a6sjmBMqU1+/YbqHwhRJRDKQyEz3GjQDZcRt6gCfe6D2OdCKrYR2t1aX
	 PFZhzafVSE2FobIGI9BQw9BScMzCUOuEsbHpsZB4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IFu7oL622936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 18 Aug 2025 10:56:07 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 10:56:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 10:56:06 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IFu2Qm1274444;
	Mon, 18 Aug 2025 10:56:02 -0500
Message-ID: <146ffb9c-e0f8-479b-b6fe-322786be0e20@ti.com>
Date: Mon, 18 Aug 2025 21:26:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] arm64: dts: ti: k3-j7*-ti-ipc-firmware: Switch MCU
 R5F cluster to Split-mode
To: Andrew Davis <afd@ti.com>, Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <hnagalla@ti.com>, <jm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Udit
 Kumar" <kumar1@ti.com>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-34-b-padhi@ti.com>
 <9a3f4271-ada2-48aa-b99d-023619ec5e12@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <9a3f4271-ada2-48aa-b99d-023619ec5e12@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Andrew,

On 8/15/2025 9:18 PM, Andrew Davis wrote:
> On 8/14/25 5:38 PM, Beleswar Padhi wrote:
>> Several TI K3 SoCs like J7200, J721E, J721S2, J784S4 and J742S2 have a
>> R5F cluster in the MCU domain which is configured for LockStep mode at
>> the moment. The necessary support to use MCU R5F cluster in split mode
>> was added in the bootloader. And the TI IPC firmware for the split
>> processors is already available public.
>>
>> Therefore, Switch this R5F cluster to Split mode by default in all the
>> boards using TI IPC Firmware config (k3-j7*-ti-ipc-firmware). This
>> gives out an extra general purpose R5F core free to run any applications
>> as required. Lockstep mode remains default in the SoC level dtsi, so
>> downstream board dts which do not use TI IPC Firmware config should not
>> be impacted by this switch.
>>
>> Users who prefer to use the fault-tolerant lockstep mode with TI IPC
>> firmware config, can do that by setting `ti,cluster-mode` property to 1.
>
> What a user prefers and other configuration like that does not belong
> in devicetree, which should only describe the hardware.
>
> Configuration should be done using the normal methods, like kernel
> cmdline, module params, ioctls, etc.. Maybe we can even set the mode
> based on some signal in the firmware itself, like in the resource table.
>
Agreed configuration part ,

but as default, what this CPU should be lock-step or cluster-mode


> Andrew
>
>>
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>> [..]

