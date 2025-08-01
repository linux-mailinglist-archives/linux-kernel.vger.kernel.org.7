Return-Path: <linux-kernel+bounces-752951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F324B17CE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A087B025E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E701F4E34;
	Fri,  1 Aug 2025 06:26:34 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E911E990E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754029593; cv=none; b=mj3OyEDTqXqNdItAuXWia0rQvEcQAceCVbsoYDrxSO9Um3pE4zq1wGDdHbEBmyVtkL6YI2qbrwL0PDtFwsyV22Gw/6RMy8FE0+g4+yr0HFeaDy9g5EzWhNPUbuLAzlF93fZzxoMao1ItuR+yr84kUhFnECnw6Vs3QGzo5YzVHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754029593; c=relaxed/simple;
	bh=PbG8XQYG0g35yJ9gdzlcsnnlLyMa3IkLVqr15YnaMcI=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=i0jNjNSahcpTtuaoForOzj5F/I0wVLuWjY853yIR152VgcEkpUDm/AKp7W/sqe7UJy+csKgOrbl4lw4o19xXY0vzoHi+SHOjWVK8MM8eHdbCKlBXW/4os7BrtfomgjpQojpqhNcVb6ZXjdvGTNeFFERafNTlAsE29+7pgMaI/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4btbSR0xLFz14MCN;
	Fri,  1 Aug 2025 14:21:27 +0800 (CST)
Received: from kwepemf500018.china.huawei.com (unknown [7.202.181.5])
	by mail.maildlp.com (Postfix) with ESMTPS id 10BA91401F2;
	Fri,  1 Aug 2025 14:26:21 +0800 (CST)
Received: from [10.67.145.254] (10.67.145.254) by
 kwepemf500018.china.huawei.com (7.202.181.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Aug 2025 14:26:20 +0800
Message-ID: <8c6eb963-0a3a-8b75-8ab4-a0b2e10f3d40@hisilicon.com>
Date: Fri, 1 Aug 2025 14:26:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <yangwei24@huawei.com>, <yaohongshi@hisilicon.com>
From: wangwudi <wangwudi@hisilicon.com>
Subject: Question on the scheduling of timer interrupt and FIO interrupt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf500018.china.huawei.com (7.202.181.5)

Hi, all
When running some FIO tests on ARM64 server(Kunpeng), frequent NVMe interrupts occupy the
CPU, and the CPU's hardirq load is 100%. The watchdog feed interrupt arch_timer cannot be
responded, triggering the hardlockup.
GIC driver uses GICV3_PRIO_IRQ to set the same priority for arch_timer interrupt and NVMe
interrupt. In GIC spec, "If, on a particular CPU interface, multiple pending interrupts
have the same priority, and have sufficient priority for the interface to signal them to
the PE, it is IMPLEMENTATION DEFINED how the interface selects which interrupt to signal."
Shell we consider setting a higher priority for the arch_timer interrupt to fix this case?

Thanks for your help.
Wangwudi

