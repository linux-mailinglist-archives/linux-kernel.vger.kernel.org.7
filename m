Return-Path: <linux-kernel+bounces-809867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C32B512FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B854E42D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE10314B88;
	Wed, 10 Sep 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cuRXfXXn"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185CD314A64
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497436; cv=none; b=eU8gT3w0YsRs5AHfVLfpbVDLyf/0XsJf4wO8COrHcyKohHzgiW9HhSKo1Pz/fl7h2xs/MNbPGKC+WW0dL/4zA3edeJ6LNL6UKDEZwMh0l5iwRdiGExei4lGgYTIiLkDOfIKxabWzmGhLunhAYcowLqJQdbuULxd+LJCPhu1GROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497436; c=relaxed/simple;
	bh=u6EG6vSoRy4kPnyCmp45B8043Yx/hFJztAr/bGgmt6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UJtGjVsWQy3lVJyBEH85W8WmcL0iGTNBZI5NovWI8xrftC3rVg96wnBWwsAZzTBECqNnZTxIo60jfInstXiq/4NxRY33Ep2SOTOPcq0RK4xSGcFiRG4XYowB1xctHWB+e8rK+oqzQFDrFCv/z6vgPKKV3amUhSEk0nnCWJSRb48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cuRXfXXn; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A9grHe034436;
	Wed, 10 Sep 2025 04:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757497373;
	bh=dyv3kFridXyExxHMMNoTnDYngAzvq7DH8iZrAUtCx80=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=cuRXfXXn9f6MkdZzQEJCUKOrYBK4ijUoxBfeGdRQT9wanwswoJbwQ5OrAK67QtiyH
	 22tf7sa6HGa7OzXV3i8XiR9ICXbhVTlO6F1hd9hq24uuzE7c1q/YZQbTg96n7r9c1I
	 917KWvtQs+SEmlalQA4P6+gMQmN2jmjCaZAR689Q=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A9grpj280139
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 10 Sep 2025 04:42:53 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 04:42:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 04:42:52 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A9giAJ287029;
	Wed, 10 Sep 2025 04:42:45 -0500
Message-ID: <a8a0af57-7576-41fe-b5a3-474a06d9de88@ti.com>
Date: Wed, 10 Sep 2025 15:12:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] drm/bridge: cadence: cdns-mhdp8546-core: Set the
 mhdp connector earlier in atomic_enable()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <lumag@kernel.org>, <dianders@chromium.org>,
        <andy.yan@rock-chips.com>, <linux@treblig.org>,
        <viro@zeniv.linux.org.uk>, <aradhya.bhatia@linux.dev>,
        <javierm@redhat.com>, <tomi.valkeinen@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <u-kumar1@ti.com>, <s-jain1@ti.com>,
        <lyude@redhat.com>, <luca.ceresoli@bootlin.com>
References: <20250909090824.1655537-1-h-shenoy@ti.com>
 <20250909090824.1655537-4-h-shenoy@ti.com>
 <bnydasal33cfzwddq6djfjgfb6viavpfpkuks5j7mpmvihckui@o7jvkwmskcuf>
Content-Language: en-US
From: Harikrishna Shenoy <h-shenoy@ti.com>
In-Reply-To: <bnydasal33cfzwddq6djfjgfb6viavpfpkuks5j7mpmvihckui@o7jvkwmskcuf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 9/9/25 19:44, Dmitry Baryshkov wrote:
> On Tue, Sep 09, 2025 at 02:38:21PM +0530, Harikrishna Shenoy wrote:
>> From: Jayesh Choudhary <j-choudhary@ti.com>
>>
>> In case if we get errors in cdns_mhdp_link_up() or cdns_mhdp_reg_read()
>> in atomic_enable, we will go to cdns_mhdp_modeset_retry_fn() and will hit
>> NULL pointer while trying to access the mutex. We need the connector to
>> be set before that. Unlike in legacy !(DBANC) cases, we do not have
>> connector initialised in bridge_attach(). So set the mhdp->connector
>> in atomic_enable() earlier to avoid possible NULL pointer.
>>
>> Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 20 +++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
> It looks like you should reorder your commits: first apply the DBANC
> fixes, then drop support for !DBANC.

Before dropping !DBANC support, we can't change the connector to pointer 
cleanly

by cleanly I mean,the driver should be build correctly after applying 
each commit.

So, if the patches which fixes the bug of NULL pointer de reference due 
to DBNAC

are applied before dropping the code related to !DBANC code will result 
in build failure.

Hence the sequencing of commits.

>

