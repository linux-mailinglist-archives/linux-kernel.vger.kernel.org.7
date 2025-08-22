Return-Path: <linux-kernel+bounces-782468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A057B320B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70E0AC67C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0FB30F548;
	Fri, 22 Aug 2025 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c87zeZya"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CDC19D065;
	Fri, 22 Aug 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881202; cv=none; b=L0wLp7skj956JZdhThZ0WrRFxNtFDFeozIRQPQ9lc+NtWCk4TxFvRmm/4BCTyAZdaEwdEWu7NKYOgrIuJPw/as0ulEiW6pBdcSpXBVVpmKtI0Id7MQgT5yIdcOlKMI0CYl2RQCMcTPb2SImrL/dZYZ8L05rluUToWNxp4X08MhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881202; c=relaxed/simple;
	bh=xZw3xCmdaTgqysDoX1I4kHuuzOlYOaqK/aqxfrjdNaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mIsHp0fiexjmIRBL7PkH4bNo6k1fUFuJ0KHtoPpn4DQFwtVGIwO4NP8Ci3kd4+3KBd2IaT+cNfTW/eUFALQcb1rH0Us6jV6peh8tTlHdkk26MjbX79SLj0kba2MDowZT64qUdePQhyB+RUY4QfEXUfyS6PFeob/WlqVZB2YW6kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=c87zeZya; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57MGkSQ0767275;
	Fri, 22 Aug 2025 11:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755881188;
	bh=xZw3xCmdaTgqysDoX1I4kHuuzOlYOaqK/aqxfrjdNaA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=c87zeZyaCR8hFditjjF7r2RqT/oHTT9shI6qp/bFHOAsZPlR7/oGlEH8bzdThZRvH
	 CJJwP5uGO/hOjlZ0bU44neg9GvNsTx9BgIEfitf7Y3odkZAX2+WTARWt/Pti/faD8N
	 SDub5M6rdOQ3BTBWOFW6YdRdtch22OLldoQKMihU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57MGkSVc3042487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 22 Aug 2025 11:46:28 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 11:46:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 11:46:27 -0500
Received: from [10.249.139.51] ([10.249.139.51])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57MGkKN83835587;
	Fri, 22 Aug 2025 11:46:21 -0500
Message-ID: <0f2060e4-269d-4865-806e-7ace5c3cdabd@ti.com>
Date: Fri, 22 Aug 2025 22:16:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] arm64: dts: ti: k3-am62-verdin: Add missing cfg for
 TI IPC Firmware
To: Francesco Dolcini <francesco@dolcini.it>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afd@ti.com>,
        <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Hiago De Franco
	<hiago.franco@toradex.com>,
        Jo_o Paulo Gon_alves
	<joao.goncalves@toradex.com>,
        Stefan Eichenberger
	<stefan.eichenberger@toradex.com>,
        Max Krummenacher
	<max.krummenacher@toradex.com>,
        Andrejs Cainikovs
	<andrejs.cainikovs@toradex.com>
References: <20250814223839.3256046-1-b-padhi@ti.com>
 <20250814223839.3256046-19-b-padhi@ti.com>
 <20250821061214.GC7503@francesco-nb>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20250821061214.GC7503@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 8/21/2025 11:42 AM, Francesco Dolcini wrote:
> On Fri, Aug 15, 2025 at 04:08:24AM +0530, Beleswar Padhi wrote:
>> The wkup_r5fss0_core0_memory_region is used to store the text/data
>> sections of the Device Manager (DM) firmware itself and is necessary for
>> platform boot. Whereas the wkup_r5fss0_core0_dma_memory_region is used
>> for allocating the Virtio buffers needed for IPC with the DM core which
>> could be optional. The labels were incorrectly used in the
>> k3-am62-verdin.dtsi file. Correct the firmware memory region label.
>>
>> Currently, only mailbox node is enabled with FIFO assignment for a
>> single M4F remote core. However, there are no users of the enabled
>> mailboxes. Add the missing carveouts for WKUP R5F and MCU M4F remote
>> processors, and enable those by associating to the above carveout and
>> mailboxes. This config aligns with other AM62 boards and can be
>> refactored out later.
> Are these memory ranges fine with 512MB DDR memory?


Yes, they are.

DDR memory range: 0x80000000 - 0xA0000000
Carveout range:        0x9CB00000 - 0x9E700000

Thanks,
Beleswar


