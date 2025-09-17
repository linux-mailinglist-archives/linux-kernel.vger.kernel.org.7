Return-Path: <linux-kernel+bounces-821470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B13B8154B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 20:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD611BC7878
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C223002DE;
	Wed, 17 Sep 2025 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tZiROv/G"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1FD34BA4C;
	Wed, 17 Sep 2025 18:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758133445; cv=none; b=t6mZ194CHvUTnrTx9nfjEbMneFL/OL93WK73wEFdSnHFDRFqyGg2Kq3s4EeDcy38lVDg/66nZQeImSAGGh5nAWHKG/f+JaCTjFYILTIW30aM5FPXgwiBgYsCJaaaDpupNuhGbevnr+6wORos+EwrXQAqTFQ0LUZWDjdl/MaaZJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758133445; c=relaxed/simple;
	bh=KQBYLBTGVcI6B/UU8+PuP9ANhqubXd++Fn247awfx+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eC0r4D/TU7j7qTyzx7MMiVDHBqA4LEbTWw6WzWZ3jrnqWWkPBZs6SFS3vVGcw6wpLtJTYpvKcN6QvmwGBXrvTKbc/IAC11NN9Vw5tc61dfR84jzvuyf0bbCxcPKu5fXo9sKXOSUOUgRhaJTTrGCCd8eW99nd7WkvpPHoTzb1CHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tZiROv/G; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758133443; x=1789669443;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KQBYLBTGVcI6B/UU8+PuP9ANhqubXd++Fn247awfx+M=;
  b=tZiROv/G5T5hSfAw8BT0EFgHSYRbJPD4f4En11zg/onExBVnL39fzSoR
   c497FEYwN9E92pYEsdylqC/3GbX6tbWqrEYft3J3pJGrI1dpT1Cpp43nc
   utUeFIEEANASZxghCsQDwIeREmWntR5IrZUx1VxlRp8UM9UiLhh2QDHQm
   pyrCb8GZofVh2Md7KYx3q0n5r8x/tzp/nGISWudoWWIC2ShJJBTSbxCio
   giVszUy8w8/dh5rYQIdsXJ704eRVFb4PcHhGK+rqLXdesPoobDfxDoh5y
   +OwJshwWu2xMjlVY7GlC8nL6ExS80jk7SKgAnx0NeSDDbBT0bu4AcSWnf
   Q==;
X-CSE-ConnectionGUID: 5jJN7IFvSvKlx8qiM0vY4w==
X-CSE-MsgGUID: RvhQqBJPShSHvESk7QwlQw==
X-IronPort-AV: E=Sophos;i="6.18,272,1751266800"; 
   d="scan'208";a="214017525"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 11:24:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 17 Sep 2025 11:23:40 -0700
Received: from [10.12.48.170] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Wed, 17 Sep 2025 11:23:36 -0700
Message-ID: <1a740af5-78c9-421f-a58a-fd4a2066493a@microchip.com>
Date: Wed, 17 Sep 2025 20:23:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] ARM: microchip: clk for 6.18 #1
To: Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, SoC Team
	<soc@kernel.org>, <linux-clk@vger.kernel.org>, <mturquette@baylibre.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Conor Dooley <conor@kernel.org>, Claudiu
 Beznea <claudiu.beznea@tuxon.dev>, <oe-kbuild-all@lists.linux.dev>,
	<llvm@lists.linux.dev>, kbuild test robot <lkp@intel.com>
References: <20250916080545.9310-1-nicolas.ferre@microchip.com>
 <0695ca65-536c-48d9-ad1b-49452e67a6f9@microchip.com>
 <175808457715.4354.11044142356915096975@lazor>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <175808457715.4354.11044142356915096975@lazor>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Stephen,

On 17/09/2025 at 06:49, Stephen Boyd wrote:
> Quoting Nicolas Ferre (2025-09-16 06:19:11)
>> On 16/09/2025 at 10:05, nicolas.ferre@microchip.com wrote:
>>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>>
>>> Dear clock maintainers,
>>>
>>> Here are the first clk changes for 6.18.
>>> I don't think they have conflict with changes for the deprecated round_rate()
>>> to determine_rate() topic.
>>> They are in linux-next for a couple of days.
>>
>> But... this series depends on this patch:
>> https://lore.kernel.org/r/20250827145427.46819-4-nicolas.ferre@microchip.com
>>
>> Which will be part of a pull-request to-be-sent soon to arm-soc (which
>> is part of linux-next, so the build error doesn't appear there).
>>
>> Once the pull-request is done, do you prefer that I do an immutable
>> branch between CLK and ARM, that I queue this at91 PM patch into the clk
>> pull-request or that everything goes through arm-soc?
> 
> Whatever is required to build the code should be included in the PR. If
> the same commit goes into arm-soc tree that's OK, just make sure the
> branches aren't broken if you checkout a commit anywhere along the
> branch that is sent to clk or arm-soc trees. Broken includes
> functionally broken.

Thanks for your quick response Stephen. v2 of the pull-request has just 
been sent.

Best regards,
   Nicolas


