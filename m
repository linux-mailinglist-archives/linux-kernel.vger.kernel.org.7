Return-Path: <linux-kernel+bounces-817242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C8B57FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B43A81AA0321
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA2E341ACF;
	Mon, 15 Sep 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n72ouBc2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270411A295;
	Mon, 15 Sep 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948109; cv=none; b=SzASLxIV50c4YkqhfmGO+38qjzdPPte9XCPUeSuZSKOH9IrlCPDt/XSQz67AN0fLHwO8uEh0k2oshfs5QVG9UXF9W7IKg2sHOsTHIotkEuWcX04It7HcZM1tfMNbbfwBc+WYwHgu6SD9SFJwb1JbwldSZnDHGNpec1c7vcASRJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948109; c=relaxed/simple;
	bh=EwNwBb1ZMwIRBiUXSFpclOvP5L0lGkCC606UBB6bd7E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=JEmhyrD5nqXFyERheuBr9iXTJWt8DbV1JT+WacLg22m9kXA3OfO05vnYmYmCXEdBwbEwgIr9Netz6SENJXc6Ym0+sY3xiexDvEBuWkkMUOS7+RILMybS34Hv/MhXINc5vjwvVZRF1YyKofU8EUlZIhPPrnQBjefGXV4YhI5dMf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n72ouBc2; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757948108; x=1789484108;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=EwNwBb1ZMwIRBiUXSFpclOvP5L0lGkCC606UBB6bd7E=;
  b=n72ouBc2/HcJizy6WQP6lM0l/3HSH/w3SMaOPR5f7k7MG7xIuyPeUowb
   wSoRF5M/XUDvP5iptJLRvPNEt9C/jrnUbXo9M0ZVJz/F/jtFv/sCMcb92
   +U5csg76Z1Z7siNkq9sWwJt/gKlVAoN/pHhhIi+RT8znQ02zgInPU+Bor
   IKM0Dl+uEnpazvZT6e9eSEzE3z73afBK6rdWiA0oO4lbU2ibx8ZknbodX
   zL9a5BIjNAzamA0tVpOTD+Mhf468NVBL6sO+RrFctZUJxGT0OKrfWk8YT
   kPBW57KBBEvyk0uri4GIbwFXy7r2J4nStQy7zIZ1N1SpAHZsm7SHoqKUB
   w==;
X-CSE-ConnectionGUID: V6We0pr5QIOXx8mFDIxkEw==
X-CSE-MsgGUID: 2WzlJk5dRtitwyzzXmjgJg==
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="47066873"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2025 07:55:07 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 15 Sep 2025 07:54:59 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 15 Sep 2025 07:54:57 -0700
Message-ID: <272ffdb9-9d7f-4a48-9968-7de1d32d721e@microchip.com>
Date: Mon, 15 Sep 2025 16:54:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: at91: clk-master: Add check for divide by 3
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: <Ryan.Wanner@microchip.com>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20250908200725.75364-1-Ryan.Wanner@microchip.com>
 <1882cb12-cb65-423a-bacb-3965ba845ab3@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <1882cb12-cb65-423a-bacb-3965ba845ab3@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 09/09/2025 at 09:57, Nicolas Ferre wrote:
> On 08/09/2025 at 22:07, Ryan.Wanner@microchip.com wrote:
>> From: Ryan Wanner <Ryan.Wanner@microchip.com>
>>
>> A potential divider for the master clock is div/3. The register
>> configuration for div/3 is MASTER_PRES_MAX. The current bit shifting
>> method does not work for this case. Checking for MASTER_PRES_MAX will
>> ensure the correct decimal value is stored in the system.
>>
>> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Added to clk-microchip, on its way upstream.
Thanks, regards,
   Nicolas

> Thanks Ryan, regards,
>     Nicolas
> 
>> ---
>>    drivers/clk/at91/clk-master.c | 3 +++
>>    1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
>> index 7a544e429d34..d5ea2069ec83 100644
>> --- a/drivers/clk/at91/clk-master.c
>> +++ b/drivers/clk/at91/clk-master.c
>> @@ -580,6 +580,9 @@ clk_sama7g5_master_recalc_rate(struct clk_hw *hw,
>>    {
>>    	struct clk_master *master = to_clk_master(hw);
>>    
>> +	if (master->div == MASTER_PRES_MAX)
>> +		return DIV_ROUND_CLOSEST_ULL(parent_rate, 3);
>> +
>>    	return DIV_ROUND_CLOSEST_ULL(parent_rate, (1 << master->div));
>>    }
>>    
> 


