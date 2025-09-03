Return-Path: <linux-kernel+bounces-798678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 320FAB42185
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90D17B8721
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592AD302CB3;
	Wed,  3 Sep 2025 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="m6bXDn8V"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9386302747;
	Wed,  3 Sep 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905707; cv=none; b=h7E/iSy0k/u8bF9XP3Trj3CjQExdFdlU6Y7vh9RDv3TVq3ceNDZjZ8TtY/Q98q8nB7c05/MxXpDz1c5WLLQ7cslngG/nImXTg7cO8NTOOnNuq1Zt/nZmqWdpHsKFzdXXTzi2Kq5wdl8M7aIQBbPTnIkjvjuZqHwEhTGTPpBMIQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905707; c=relaxed/simple;
	bh=lyo863rOkaAcwqGH6a6AfKVlYLoNIOdNlLPVKEI/zGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JbXeQELwiAjMDNyLIl6E5V8qYTtown7lFGlZ9SvLRKC9cWW56eP+08p77FSgwk2FLI1srvkB2f2WLks7C20MDWkrmz7ZNnMgYKyfYiTWSA0uGr/rtDM59l+dK+n+i/xgeShE37659CQ5ecj+lmWrfoTJMXO+B+WRPXw1ReWO9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=m6bXDn8V; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583D4th8003424;
	Wed, 3 Sep 2025 15:21:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	OkV/DeaXa2eIU6w26hvqIdLHtMibXdPwaApwqqLdeuY=; b=m6bXDn8VgVZgJnCr
	34JFmOEJIAaNaUVwkEeVxQIW9bR6uzN5c76vT1s8vnLJORKV+M9g1FFhvbbgqrJq
	JrI+I8nrIwHqabXed9I3RzAQ+m3PBLiE8z+gYvoL9Su8Iq0/UjxWPsVjO89a30hv
	SHXY2o6KR51g9QV9wjkHHbcH9f9m7BANHv/VLO9K41D3MEy9NUxsWeVDCKL3r9sp
	5LfSXj2Uu3qwLrXULX8kFA35vu5fDw/E2GDgxjAXlmrQvPW2s72YSwqFJquwvjA2
	CBnNmOgVH+GDasuSfg5ARyOB0AG93aUdPPvhZ1IRjGM1EQUz+qygK1125NqoaV1z
	SdU9CQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upe7gxae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 15:21:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 924634002D;
	Wed,  3 Sep 2025 15:20:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5F4E32B5120;
	Wed,  3 Sep 2025 15:20:29 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 3 Sep
 2025 15:20:28 +0200
Message-ID: <078fb552-c848-49ef-b917-14aec0e4b6aa@foss.st.com>
Date: Wed, 3 Sep 2025 15:20:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] docs: arm: stm32: fix typo "busses" -> "buses"
To: Akshaykumar Gunari <akshaygunari@gmail.com>, <corbet@lwn.net>,
        <mcoquelin.stm32@gmail.com>
CC: <linux-doc@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250807145119.2214-1-akshaygunari@gmail.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250807145119.2214-1-akshaygunari@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01

Hi

On 8/7/25 16:51, Akshaykumar Gunari wrote:
> Fix the spelling of "busses" to the preferred form "buses" in STM32 ARM
> architecture documentation.
> 
> Signed-off-by: Akshaykumar Gunari <akshaygunari@gmail.com>
> ---
>   Documentation/arch/arm/stm32/stm32f746-overview.rst  | 2 +-
>   Documentation/arch/arm/stm32/stm32f769-overview.rst  | 2 +-
>   Documentation/arch/arm/stm32/stm32h743-overview.rst  | 2 +-
>   Documentation/arch/arm/stm32/stm32h750-overview.rst  | 2 +-
>   Documentation/arch/arm/stm32/stm32mp13-overview.rst  | 2 +-
>   Documentation/arch/arm/stm32/stm32mp151-overview.rst | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 

Applied on stm32-next.

Thanks
Alex

