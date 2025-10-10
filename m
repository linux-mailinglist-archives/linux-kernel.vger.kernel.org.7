Return-Path: <linux-kernel+bounces-848038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A0BCC4DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 11:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B91F35398A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C319126980F;
	Fri, 10 Oct 2025 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A4tpXjne"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22230217723
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760087955; cv=none; b=cwd4iHeZs4UuMSUDq49ZVtEUkwCPK2SjTZpRhJBZYGICsuxeAzrpspsVAAMsKe46JXwLJVdE7iTPTcBxGisUGyJi4v78IDSg34xOMbcf73i/Q3xx2aQa3S3X0xGyCRwa6qW5dZhc0R1ce/Ff750j4HBxr+NegRAv/DDzUEpWlnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760087955; c=relaxed/simple;
	bh=Xm+1TY5t79UQY1hLrjlbMY1PDOL1H8FhJ1aTR4/SCC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n8bODXgjZHgMIEI2TXnvDxKi8gR+A9FoUtvb+6qg8hkwkGlPJrpG0YVaSflkg/MfqIDQQ4hPUSQSTPYs1pzEbZgXxRnN9yzyeQW7l3hDM1pQmCCJCGhEGkXaJMJieD8J1SCqHOWvJQURyROp8oCJNrbTtHHrDvvadry92YJ8DMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A4tpXjne; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59A9IKge214724;
	Fri, 10 Oct 2025 04:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1760087900;
	bh=g7S9k+GdBnz1gdhj6w15J3l9vOBpsMlvKBQ8ER1cXgc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=A4tpXjnezqbeuZ8ZVxE1MJ6QfNCAwKOdX0Ema3Z+5+QGwkAT4hZ3H6pvOBA3PIgEI
	 I054LOiBEizAJWqyu8HH7ZlXNDMn/gEIWVRA6Yurgw3s6+MwXba/MzbvPR1iXZgpbU
	 P1l1yij00KUytSwaHEQowTu2oZsQDdFrWUF5j/nA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59A9IJMo955820
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 10 Oct 2025 04:18:19 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 10
 Oct 2025 04:18:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 04:18:18 -0500
Received: from [172.24.235.208] (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59A9IBTm1660954;
	Fri, 10 Oct 2025 04:18:11 -0500
Message-ID: <429400d3-e369-cf6a-3e9c-3d00622d7f29@ti.com>
Date: Fri, 10 Oct 2025 14:48:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 3/6] drm/bridge: cadence: cdns-mhdp8546-core: Set the
 mhdp connector earlier in atomic_enable()
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>,
        <simona@ffwll.ch>, <lumag@kernel.org>, <dianders@chromium.org>,
        <andy.yan@rock-chips.com>, <mordan@ispras.ru>, <linux@treblig.org>,
        <viro@zeniv.linux.org.uk>, <aradhya.bhatia@linux.dev>,
        <javierm@redhat.com>, <tomi.valkeinen@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <u-kumar1@ti.com>, <s-jain1@ti.com>,
        <lyude@redhat.com>, <luca.ceresoli@bootlin.com>
References: <20250929083936.1575685-1-h-shenoy@ti.com>
 <20250929083936.1575685-4-h-shenoy@ti.com>
 <gtj43rfr2dgegutffma34w5bhvdmvx44jhwxgxb3ficqh5tm53@2iyr6ho3qfdh>
From: Harikrishna shenoy <h-shenoy@ti.com>
In-Reply-To: <gtj43rfr2dgegutffma34w5bhvdmvx44jhwxgxb3ficqh5tm53@2iyr6ho3qfdh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 06/10/25 04:42, Dmitry Baryshkov wrote:
> On Mon, Sep 29, 2025 at 02:09:33PM +0530, Harikrishna Shenoy wrote:
>> From: Jayesh Choudhary <j-choudhary@ti.com>
>>
>> In case if we get errors in cdns_mhdp_link_up() or cdns_mhdp_reg_read()
>> in atomic_enable, we will go to cdns_mhdp_modeset_retry_fn() and will hit
>> NULL pointer while trying to access the mutex. We need the connector to
>> be set before that. Unlike in legacy !(DBANC) cases, we do not have
>> connector initialised in bridge_attach(). Now that we have the connector
>> pointer in mhdp bridge structure, so set the mhdp->connector in
>> atomic_enable() earlier to avoid possible NULL pointer dereference
>> in recovery paths like modeset_retry_fn() with the DBANC flag set.
>>
>> Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")
> 
> This Fixes tag means that this patch can be attempted to be backported
> back to v6.5 (even w/o cc:stable, etc). I know that it is a pain, but
> please move all Fixes to the top of the series. Yes, you want to drop
> non-DBANC case first and then fix everything. It doesn't look like it is
> a correct approach for the sake of maintaing the -stable branches.
> 
Hi Dmitry,

The patch which drops non-DBANC case can be moved after fixes, but for
making fixes i need the pointer structure so adding fixes tag to PATCH 
2/6 "drm/bridge: cadence: cdns-mhdp8546*: Change
  drm_connector from structure to pointer"
Let me know your thoughts on this, will re-spin accordingly.

Regards.

>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
>> ---
>>   .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 20 +++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>
> 

