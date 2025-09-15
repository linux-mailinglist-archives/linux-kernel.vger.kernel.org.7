Return-Path: <linux-kernel+bounces-816277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F08B571C7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD4718939A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A1D2D6E4D;
	Mon, 15 Sep 2025 07:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TQijDgck"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4D62C21D3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922114; cv=none; b=Fir+8I4sdqCo3Gef5gTiwAQYriN7HsnhF7LCVuXCBRzqGZRME+xOeao6IRob8JhOrAc6bHhNImtMD6tJRQjCne17zWyi4DzKEPY96LjnBwtF8hssEJAI1BT4qQ/OyOQIhz1f9O22H6N2+YAwlV24fzH4H5nrztWSMUvTCknrwGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922114; c=relaxed/simple;
	bh=npEkbsZevWwCx0NAWH1qtbK0wmxYxIJb10Aezwv4xIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MxsvICHLzfjhvCLztWQiknPy9NpgcQMqEsPMXk141FUgWJ2Y0MKu2hkMlX23nS67QITw86MW7avHq3zXgbRXHnyKN7n9cSUDuUyNrYw+AKs8UGYO3hoiJo3l6PJJpoax47w/MLhQA0AylxLgKNZPmXIPND6jXIc2PCyqLF9T+EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TQijDgck; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58F7fFhw1510294;
	Mon, 15 Sep 2025 02:41:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757922075;
	bh=tEdZqpOd0p3VvYV6uzHABPpFXlZefqk+wQsFnV5+sps=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TQijDgckIKgT9uwCLGaAqmDcdrBruQN11rlXEFDUuw2T0tih3c4ergAM44IJ6lPu1
	 HP79l0Ed+nbXalOBG+0lqg5eQw4cb1owQbPJProSmPOJ58Y/qjtWq1XOScakMbenBQ
	 ZZx2s9ngiJbH0ONFIi/y6cLyfP1jDvzlPlC0bbtk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58F7fFJB3789550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 15 Sep 2025 02:41:15 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 02:41:14 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 02:41:14 -0500
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58F7fAFY3366317;
	Mon, 15 Sep 2025 02:41:11 -0500
Message-ID: <9fec8944-3bcd-4f89-b7d4-c5f5f9d6c185@ti.com>
Date: Mon, 15 Sep 2025 13:11:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: spansion: Modify addr_mode_nbytes for DTR
 mode
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <tudor.ambarus@linaro.org>, <pratyush@kernel.org>, <mwalle@kernel.org>,
        <tkuw584924@gmail.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
        <u-kumar1@ti.com>, <s-k6@ti.com>
References: <20250904131309.3095165-1-s-k6@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20250904131309.3095165-1-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hello Pratyush and Takahiro,

On 04/09/25 18:43, Santhosh Kumar K wrote:
> The nor->params->addr_mode_nbytes parameter defines the address byte
> count for the current addressing mode. When transitioning between SDR
> and DDR modes, this parameter must be properly updated to maintain the
> correct addressing behavior. So, implement the necessary updates to
> nor->params->addr_mode_nbytes during both DDR mode enablement and
> disablement operations to ensure address byte counts remain consistent
> with the active transfer mode.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
> 
> Tested on TI's AM62x SK
> Logs: https://gist.github.com/santhosh21/8d69756bd54605d79086b00850e1083a

We were facing write and erase failures in NOR flashes without this fix.

Failure log:

root@am62xx-evm:~# flash_erase /dev/mtd6 0 0
Erasing 256 Kibyte @ 0 --  0 % complete [   33.078034] spi-nor spi0.0: 
Erase Error occurred
[   33.086178] spi-nor spi0.0: Erase Error occurredock 0 (mtd6)

         error 5 (Input/output error)
flash_erase: error!: /dev/mtd6: MTD Erase entire chip failureTrying one 
by one each sector.
              error 5 (Input/output error)
Erasing 256 Kibyte @ 0 --  0 % complete libmtd: error!: MEMERASE64 ioctl 
failed for eraseblock 0 (mtd6)
         error 5 (Input/output error)
flash_erase: error!: /dev/mtd6: MTD Erase failure
              error 5 (Input/output error)
Erasing 256 Kibyte @ 0 -- 100 % complete
root@am62xx-evm:~#

But, I just bisected and got to know that the
commit b61c35e3404557779ec427c077f7a9f057bb053d
"mtd: spi-nor: spansion: Use nor->addr_nbytes in octal DTR mode in 
RD_ANY_REG_OP"
fixed this issue. My bad!
Lets drop this patch.

Thanks and Regards,
Santhosh.


