Return-Path: <linux-kernel+bounces-790328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDF2B3A540
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BDB3B6B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C847522DFA8;
	Thu, 28 Aug 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nXKed/BJ"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734E25BEE1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756396832; cv=none; b=UmuYB27od1bBtLaAJkcFNnXOPWntbsPlBgfH4x+NYuOCxS0GdlQr0qkJaHCXX6BmMa1Srodkh7TE5eNKCD5OW4J4NWhSeHv6Px8r33Ycq2Es7zz1hmw7frf2mlvD1LChT+r/leF2obbjyDtXiJoMCYZEtI5/5LGZrH+SVnKY/l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756396832; c=relaxed/simple;
	bh=GdiZynoSoYSdj8ifwkFZD00GJ+PsRsC7/k5NcvagE5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bK7zC4pgE9PX1b2EEZIofL1QMhnZh7SV6ft4+b7a36eQXmGnQanz6nQt8WsmCwn2H5td/vyCCcGqwfr7ymfcGGpkCUuggF9KINwOy9PhH8bnTRgvbVUBOo7WhgySBLUBKHaZGm0fTXSFK9HVws+HJq7Yile/4Me4P2omOhWGg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nXKed/BJ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57SFxaSH1602979;
	Thu, 28 Aug 2025 10:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756396776;
	bh=+aFMOvBq3ZFq1Tp80wQe4r/4UlP4tivV9Yfs3oQewgA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=nXKed/BJz57kpGyG/xMvntEONI589vf4HWNcl5lJfnxVAX9SNZCchCmxqroXc29R5
	 QD5YCxWpKHNoaU+qm9u/9BP5NOzfa5ImkWDlf65UPjAJmbi4TJvvrB+7XKpoEuAJhw
	 EL2iWs1NcEj8yaUF9Yj40ysOEUthbDhikPYypTO4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57SFxZ8I3570839
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 28 Aug 2025 10:59:35 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 10:59:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 10:59:34 -0500
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57SFxTKv593218;
	Thu, 28 Aug 2025 10:59:30 -0500
Message-ID: <670a6d68-3011-4241-a2f9-fd23373dcb43@ti.com>
Date: Thu, 28 Aug 2025 21:29:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Decouple max_pclk check from constant display
 feats
To: Michael Walle <mwalle@kernel.org>, <jyri.sarha@iki.fi>,
        <tomi.valkeinen@ideasonboard.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <aradhya.bhatia@linux.dev>
CC: <h-shenoy@ti.com>, <devarsht@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>,
        <u-kumar1@ti.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20250819192113.2420396-1-s-jain1@ti.com>
 <DC83F2197OLI.2KRLEH7GUBKSA@kernel.org>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <DC83F2197OLI.2KRLEH7GUBKSA@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 8/21/25 17:39, Michael Walle wrote:
> On Tue Aug 19, 2025 at 9:21 PM CEST, Swamil Jain wrote:
>> In an effort to make the existing compatibles more usable, we are
>> removing the max_pclk_khz form dispc_features structure and doing the
>> supported pixel clock checks using "max_successful_rate[]" and
>> "max_attempted_rate[]".
>>
>> Changes are fully backwards compatible.
>>
>> After integration of OLDI support[0], we need additional patches in
>> OLDI to identify the VP that has OLDI. We have to do this since
>> OLDI driver owns the VP clock (its serial clock) and we cannot perform
>> clock operations on those VP clock from tidss driver. This issue was
>> also reported upstream when DSI fixes[1] had some clock related calls
>> in tidss driver. When "clk_round_rate()" is called, ideally it should
>> have gone to "sci_clk_determine_rate()" to query DM but it doesn't since
>> clock is owned by OLDI not tidss.
>>
>> So add a member is_ext_vp_clk[] in tidss_device structure to identify
>> this and avoid performing clock operations for VP if it has OLDI panel.
>> For the same checks in OLDI driver, atomic_check() hook is added to its
>> bridge_funcs.
>> In the atomic_check() chain, first the bridge_atomic_check() is called
>> and then crtc_atomic_check() is called. So mode clock is first checked
>> in oldi driver and then skipped in tidss driver.
>>
>> Had the tidss_oldi structure been exposed to tidss_dispc.c, we could
>> have directly checked VP type in dispc but since the structure is defined
>> in tidss_oldi.c , we have to add additional member to tidss_device
>> structure.
>>
>> [0]: https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@linux.dev/
>> [1]: https://lore.kernel.org/all/DA6TT575Z82D.3MPK8HG5GRL8U@kernel.org/
> 
> Since that wasn't picked up from v4:
> 
> Tested-by: Michael Walle <mwalle@kernel.org> # on am67a

Hi Michael,

Thanks for testing the patches. Sorry, I missed T-By.
Will add in v6.

Regards,
Swamil

