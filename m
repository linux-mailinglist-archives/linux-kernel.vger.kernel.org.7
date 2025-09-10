Return-Path: <linux-kernel+bounces-809695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522D4B510D3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E40D1C82B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41A30BF54;
	Wed, 10 Sep 2025 08:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aOtwg19t"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52755309DC1;
	Wed, 10 Sep 2025 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491999; cv=none; b=Hhs0CC2VtrhdTBjALlroyvKmA12TGYTjahw20gSWGEEW2ZO+7n45igybmdQP/iKxXIlHeDpqFazjMyV2H+QeQPUut/i3Lk3Jfk1Q8iMgZfGtTQ1/ovJYkGMB1btRmiadkpqVhNd+yFS3q6o4vVG0jzs6esM4lb5JcUY7HOflYnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491999; c=relaxed/simple;
	bh=Min/oUK1IjYy2zjjsm99t5UdssIAo5Q7COKge1q2Jc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S2egFOSc7F55nUFwepdC7yTfh+LAlB6e2DELmNZS9kyj9lSVC1D0xPO6h+qhtejsI7hnSJFYwalD8d0sIG/1djt+V2yx4FSJX7gNJTagqIRkbGIHnrwX0KG6AsN0mUTAAGZL5F2d1brnyUZSPu/uS+kWtGMxaAyvcKbUi25/35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aOtwg19t; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A8D2nH096182;
	Wed, 10 Sep 2025 03:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757491982;
	bh=1/Ia8Am6A4Q5h2HLCTZ2gWNNiYWFkY56ClV3qRWN/i4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=aOtwg19td0Q39TSiegwX4xTkPqGc2q+g1HbfpewQKoPf3vmmUIHRPIHxivY12Z1Ox
	 O8rgPk84wMymjJKjI4NEWBHseWU4xJYLJ6Jg49l4AB4dMXmOr83MAljfrYQczVrkAV
	 4k6xppmYPJY/5EvmI0fm16Lt3AKl+qPyb8X4QVLQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A8D2OP3777245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 03:13:02 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 03:13:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 03:13:01 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A8CsBL178345;
	Wed, 10 Sep 2025 03:12:55 -0500
Message-ID: <fa31edd5-faec-4bf4-b001-610275eb8339@ti.com>
Date: Wed, 10 Sep 2025 13:42:54 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for DSC
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <sjakhade@cadence.com>, <yamonkar@cadence.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devarsht@ti.com>, <u-kumar1@ti.com>,
        <s-jain1@ti.com>
References: <20250909054622.1439487-1-h-shenoy@ti.com>
 <20250910-silent-classic-vicugna-fdc1ab@kuoka>
Content-Language: en-US
From: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <20250910-silent-classic-vicugna-fdc1ab@kuoka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/10/25 13:29, Krzysztof Kozlowski wrote:
> On Tue, Sep 09, 2025 at 11:16:22AM +0530, Harikrishna Shenoy wrote:
>> From: Swapnil Jakhade <sjakhade@cadence.com>
>>
>> Add binding changes for DSC(Display Stream Compression) in the MHDP8546
>> DPI/DP bridge.
> Also, where is any user of this change (DSC)? Why are you adding changes
> to the bindings which no one uses?
>
> Best regards,
> Krzysztof
>
Cadence MHDP has DSC IP which can be enabled, DT will need to define DSC 
register space

for using the feature, was planning to  post DT and driver changes once 
bindings get accepted.

Warm Regards,

Hari



