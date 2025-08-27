Return-Path: <linux-kernel+bounces-788847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4129B38AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA19189D5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD4B277C85;
	Wed, 27 Aug 2025 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GgPhCbla"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2B3FC7;
	Wed, 27 Aug 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326777; cv=none; b=UWOQ8gOiB/TCVoLZ16Ply43y/Zd/prbCIpTW9RxO9DW+SnoJH9SCcUcESCWqs+lVV+iQfph9l9G+tV+lUjjDQPh2KtcBT7hyBnT4SCefGpajDUz9lE2fFDLlHgJPXl14ax+wbRwfsjurN5tdyYYD7Uk5/KzxZ3z8fEQgL12pY18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326777; c=relaxed/simple;
	bh=y9997n1KrMbMeAMj+IWy2kERVmk6DJGRSqufvzXc1uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ihHxnlfa+QfPBF3sp1+y7cUdjCQFqA4CpVpwDw4IJFvGF0JmTNoOe9e8enOrE0jlBaoy41lBloghJSPnY2EjEv/C8L5IEwoKio28LcImgy+WtgEIh3UHieETBEYFN+T0dwOpOe/OFOR9HTeqhfn065KZw5mNdMlEPc2M7nWQwe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GgPhCbla; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756326775; x=1787862775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y9997n1KrMbMeAMj+IWy2kERVmk6DJGRSqufvzXc1uY=;
  b=GgPhCbla2GccWEXy7WUaPpRNB0i8jmMVZIbAWomf92a8xmjy7rJHkpCa
   O3jLh4L9bwyzX4NOSlzylctQbpY8NOylJLUxmJV8vssqnO9+B5UwFZWkO
   4CPtypYd/t0/uFXidtafs2lu2CnlGkAmNFc5FTq2uuqsoqYNm+RfVwXIE
   Jy341Qpqd79ixzUTCyvekeyIcApWV3bug4NW/C/EYTyZt78d4VH99pMKk
   y+GeuFsI2L7Z/bUigpl77yXHSXUv0AFXxRCb9aKwxRO0Z/9jYaApYTDby
   UzPlrJZ3/qjd0tjeM51Q+V3hgAWw18GVSGVYLDkT2kfdy0RBs/B6LL2iu
   Q==;
X-CSE-ConnectionGUID: DtXPaCWgQLGobwENlPj6ng==
X-CSE-MsgGUID: a2obzWYWSJm3Ob0XwFZKDQ==
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="51382651"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2025 13:32:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 27 Aug 2025 13:31:41 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 27 Aug 2025 13:31:41 -0700
Message-ID: <af762c93-c9d0-485e-a0d1-7792e6e37c09@microchip.com>
Date: Wed, 27 Aug 2025 13:31:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/32] clk: at91: add support for parent_data and
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <cover.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 7/10/25 13:06, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This series adds support for parent data and parent _hw on the at91
> clock drivers. This also updates all the SoC specific clock drivers to
> use this format as well.
> 
> This is a continuation of the V1 of this series here [1].
> 
> This has been tested on the SAMA5* SoCs, the sam9x* SoCs, and the SAMA7*
> SoCs.
> 
> Changes v1 -> V2:
> - Remove all the small sama7g54 SoC driver changes and put them in their
>   own patch.
> - Add the SAMA7D65 and the SAM9X75 to this update.
> - Add a patch to move all common used macros into the pmc.h file.
> - Update changes from v6.6 to v6.16.
> - Remove patches that where style fixes and include those in the update.
> 
> Changes v2 -> v3:
> - Adjust each patch so they are fully atomic.
> - Add a patch to have the SAMA7D65 systemclocks use parent_data and
>   parent_hw.
> - Add a formatting cleanup patch for the SAM9X75.
> - Adjust commit messages that no longer show invalid information.
> 
> 
> 1) https://lore.kernel.org/all/20230727053156.13587-1-claudiu.beznea@tuxon.dev/
Hello,

Just Bumping this thread.

Ryan
> 
> 
> Claudiu Beznea (28):
>   clk: at91: pmc: add macros for clk_parent_data
>   clk: at91: clk-sam9x60-pll: use clk_parent_data
>   clk: at91: clk-peripheral: switch to clk_parent_data
>   clk: at91: clk-main: switch to clk parent data
>   clk: at91: clk-utmi: use clk_parent_data
>   clk: at91: clk-master: use clk_parent_data
>   clk: at91: clk-programmable: use clk_parent_data
>   clk: at91: clk-generated: use clk_parent_data
>   clk: at91: clk-usb: add support for clk_parent_data
>   clk: at91: clk-system: use clk_parent_data
>   clk: at91: clk-pll: add support for parent_hw
>   clk: at91: clk-audio-pll: add support for parent_hw
>   clk: at91: clk-plldiv: add support for parent_hw
>   clk: at91: clk-h32mx: add support for parent_hw
>   clk: at91: clk-i2s-mux: add support for parent_hw
>   clk: at91: clk-smd: add support for clk_parent_data
>   clk: at91: clk-slow: add support for parent_hw
>   clk: at91: dt-compat: switch to parent_hw and parent_data
>   clk: at91: sam9x60: switch to parent_hw and parent_data
>   clk: at91: sama5d2: switch to parent_hw and parent_data
>   clk: at91: sama5d3: switch to parent_hw and parent_data
>   clk: at91: sama5d4: switch to parent_hw and parent_data
>   clk: at91: at91sam9x5: switch to parent_hw and parent_data
>   clk: at91: at91rm9200: switch to parent_hw and parent_data
>   clk: at91: at91sam9260: switch to parent_hw and parent_data
>   clk: at91: at91sam9g45: switch to parent_hw and parent_data
>   clk: at91: at91sam9n12: switch to parent_hw and parent_data
>   clk: at91: at91sam9rl: switch to clk_parent_data
> 
> Ryan Wanner (4):
>   clk: at91: pmc: Move macro to header file
>   clk: at91: sam9x75: switch to parent_hw and parent_data
>   clk: at91: sama7d65: switch to parent_hw and parent_data
>   clk: at91: sam9x7: Clean up formatting
> 
>  drivers/clk/at91/at91rm9200.c       |  95 ++++----
>  drivers/clk/at91/at91sam9260.c      | 136 ++++++------
>  drivers/clk/at91/at91sam9g45.c      |  89 ++++----
>  drivers/clk/at91/at91sam9n12.c      | 106 ++++-----
>  drivers/clk/at91/at91sam9rl.c       |  63 +++---
>  drivers/clk/at91/at91sam9x5.c       | 125 ++++++-----
>  drivers/clk/at91/clk-audio-pll.c    |  28 ++-
>  drivers/clk/at91/clk-generated.c    |   8 +-
>  drivers/clk/at91/clk-h32mx.c        |  11 +-
>  drivers/clk/at91/clk-i2s-mux.c      |   6 +-
>  drivers/clk/at91/clk-main.c         |  16 +-
>  drivers/clk/at91/clk-master.c       |  24 +-
>  drivers/clk/at91/clk-peripheral.c   |  16 +-
>  drivers/clk/at91/clk-pll.c          |   9 +-
>  drivers/clk/at91/clk-plldiv.c       |  11 +-
>  drivers/clk/at91/clk-programmable.c |   8 +-
>  drivers/clk/at91/clk-sam9x60-pll.c  |  14 +-
>  drivers/clk/at91/clk-slow.c         |   8 +-
>  drivers/clk/at91/clk-smd.c          |  10 +-
>  drivers/clk/at91/clk-system.c       |   8 +-
>  drivers/clk/at91/clk-usb.c          |  41 ++--
>  drivers/clk/at91/clk-utmi.c         |  16 +-
>  drivers/clk/at91/dt-compat.c        |  80 +++++--
>  drivers/clk/at91/pmc.h              |  66 +++---
>  drivers/clk/at91/sam9x60.c          | 117 +++++-----
>  drivers/clk/at91/sam9x7.c           | 328 ++++++++++++++++------------
>  drivers/clk/at91/sama5d2.c          | 168 +++++++-------
>  drivers/clk/at91/sama5d3.c          | 122 ++++++-----
>  drivers/clk/at91/sama5d4.c          | 129 +++++------
>  drivers/clk/at91/sama7d65.c         | 156 ++++++-------
>  drivers/clk/at91/sama7g5.c          | 111 +++++-----
>  31 files changed, 1134 insertions(+), 991 deletions(-)
> 


