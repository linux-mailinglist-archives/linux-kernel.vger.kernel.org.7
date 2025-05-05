Return-Path: <linux-kernel+bounces-631778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF13AA8D5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F41173509
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC11DED49;
	Mon,  5 May 2025 07:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t5NOcc4A"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D31DDC2C;
	Mon,  5 May 2025 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431419; cv=none; b=YXOsecre7BChYZ9XzyimSNFwRSbHMLVvuHeZ1wI8pcxX3ABfj/ndG+VLHkW4wG5CbfRK1webiZin2+VfU1ruKM0rVReOa0WRcHIE7kbKnUJQzfp+8wYYihGSSYT5yfBWDmqc5/mdbCCNJliHRWmtE4RWecvMIZAV9JHGnqpGjNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431419; c=relaxed/simple;
	bh=8ctXOMeS1LPtoldoIrh31Q77Yd6gwu6HLyjZWl8gxo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GFEj3ewi6JnvAFPPwtyDLoFTQVMUlMQCsNaWr+za4nRLMJy00OdAD/lpM+MlWam2PwBN9LUqcEztjxM6iOLihIBPDsd2VxzoPGUp4JPoApxG7GyEQ5CqZSc0c/Fl5JVD2l+Mj6N4vhE5vPnJadducC8wG3L7D9TGEC9P/RrQ5Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t5NOcc4A; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5457nOll716797
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 02:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746431364;
	bh=5Ii9h9rPzROGPRkouzthetaV+45FxhY90QOk8t0nqok=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=t5NOcc4AkykTBetmD815dXZgKQT6FypKLSXNv8PzRCUkpEQBeB2ShPwrsvLWs0Iro
	 ArOJwiKxnKdxee9m6P3/eQZ/CAKe3YZPpTf8KAIQsVgK/KSXw9vlanZoPsb1lMxsWX
	 imw5Ni2+NvFoTfmjVFJ+mYL/53paBSoQD6oQj/64=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5457nOBi019555
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 May 2025 02:49:24 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 May 2025 02:49:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 May 2025 02:49:23 -0500
Received: from [172.24.227.193] (devarsh-precision-tower-3620.dhcp.ti.com [172.24.227.193])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5457nHUY087427;
	Mon, 5 May 2025 02:49:18 -0500
Message-ID: <5fd14448-27d9-43e6-8526-fd93483b94cb@ti.com>
Date: Mon, 5 May 2025 13:19:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v5 2/3] drm/tidss: Update infrastructure to support K3 DSS
 cut-down versions
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <r-donadkar@ti.com>, <j-choudhary@ti.com>,
        <h-shenoy@ti.com>, <jyri.sarha@iki.fi>, <airlied@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <dri-devel@lists.freedesktop.org>,
        <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
References: <20250429143656.3252877-1-devarsht@ti.com>
 <20250429143656.3252877-3-devarsht@ti.com>
 <f729c0d6-45a0-4610-b22b-92c03f534bf7@ideasonboard.com>
 <1f8c43cd-8c26-4e42-b144-b91f5ffc2e2e@ti.com>
 <88993439-bfdc-418c-95c6-d6d8bdb5b87f@ideasonboard.com>
 <466254e9-145f-4839-9451-a5f282ff02e9@ti.com>
 <ce831f65-67d0-4f4c-9f08-3014b1d00dc0@ideasonboard.com>
 <ca008cb0-bec6-4b10-b6b5-0f29648f76c0@ti.com>
 <ed82e498-b3af-46f6-97ce-3a2f47872935@ideasonboard.com>
 <ead31912-d1e5-4813-99a7-5cd2754672ef@ti.com>
 <d4daa87f-3556-4b46-a0e0-d90f9d14a097@ideasonboard.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <d4daa87f-3556-4b46-a0e0-d90f9d14a097@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Tomi

On 03/05/25 14:14, Tomi Valkeinen wrote:
> On 02/05/2025 14:52, Devarsh Thakkar wrote:

>> Hi,
>>
>>
<snip>
>> Ok I see what you mean to say.....although functionally it is working
>> fine but from readability point of view it is confusing since both
>> functions use same argument name i.e hw_plane in two different contexts.
>> In that case, I would propose to use hw_id as arg name for all
>> dispc_k3_vid* functions, will that be okay ?
> 
> I'd prefer to have all the dispc functions take the same kind of index.
> 

Why? Even all dispc functions are not named with same prefix.
1) dispc_vid* functions act on VID* base directly and here plane
indexing would be w.r.t which VID* base we are using e.g VID vs VIDL
2) dispc_k3_vid* functions act on common region bits which are related
to VID pipelines and plane indexing would signify vid base w.r.t common
register space i.e. COMMON_VID_IRQ0 vs COMMON_VID_IRQ1.

As they both act on different register base and refer it in different
contexts (VID* base vs COMMON_VID* base)  and have also been named
differently anyway, I feel it is okay and legitimate to use hw_id for
dispc_k3_vid* functions (which would signify vid* indexing w.r.t common
region) and hw_plane for dispc_vid* functions (which would signify vid*
base w.r.t VID* regions mapped in device-tree).

Regards
Devarsh

>  Tomi
> 


