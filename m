Return-Path: <linux-kernel+bounces-775466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0749B2BF78
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C0676836A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C3322DAE;
	Tue, 19 Aug 2025 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lKzL53i4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934C322A32
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600969; cv=none; b=CLvtpg3KyVWLT7LTm4jME4wQsR9iBd3HCgkMH6pVSKMAPq94podH1DTb59yIHeqfNjhfzRoUdUcwkeFbzMyfIv0gRdmLyPj69J2UMsdZkfQh4doHYUCY3V23qIqFiNVEyg98rMB1Tup1MWIxjBmyp5H2D4ALMIh/8jYym5O86F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600969; c=relaxed/simple;
	bh=QwGOkV1bx4gYciZu9ZTwqCJFEP0Q063FTqp8q8Rpzt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1cB3Qs39j9n+bVbtg0WW9nXUxoQc/bBVZ9nwWDYcWtSRNfaSY+WamuKgxGZPbazpfvhVQcYyN7yoPtnSE/WQ6KR6XVIr37X8bJqZYQDNxpqNdw3OHtixWU+ayqodKtUiAnMUvL5XzlBuqhBP/eMRJkHCG9Sl9GaPc1vUK1fKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lKzL53i4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90X8L032349
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7ghZKUm2aSWn//5Tci+9wfrDSWfLO9oHcOcQ8IQR6Q4=; b=lKzL53i4X+RI5ARV
	H6dGQrFJ5FDOsQfKbKoJAdcIu+/8dkobyoybJx1JjkFSzIC6f+Xwv8DMNGhEEJ0d
	fnYhCiEyndv/Ktj0OVZOFXa3J3Lh5njFVhfyuaqIQghosZIm/YW6pweyW7vnNQCl
	HO7hJ80aHk/ulVaRuPMikMrakI7cYzhPoLeG2pSbHEgVG6196wUZmYBYDZeW2mLR
	fq5WH/v4wsCNoFduSYa2Al6DbUv7xQCShvFy5qAVHdkX+0MUWlgHRvHF0znA/B0V
	T37O/Q1kBZh8Ueju6ywf7DrqxyEKcQgUl1FwmSgS4jNl7m9Fx3+aFC2Q42EjPuPB
	yUDEtg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ug9v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:56:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a88de16c0so119070686d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:56:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600966; x=1756205766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ghZKUm2aSWn//5Tci+9wfrDSWfLO9oHcOcQ8IQR6Q4=;
        b=SrCYhecVEiKRdjb9JqFx2RhNn1t/wt/ybXGuIHUwmzmc8RgVjWGgjvSSBND939lwZk
         BxXP+jzmxYqjESLlPoNJWrrLfLlPxB/6T2WCbHfbHJyvllJELygec0sK78so5tcPEXtC
         dyAjeDFoYjYbksXMpy6405MnrGprb5XQLOZeP6RWdsFgCw4bLsgxHXgx1d1jK6SVm+P2
         OU9fzIscbxWvk+vyvo5/bfe3nE40BYy8mwktCJtq06rSTtsFtxzJ3PI/nVBBodYf0ln6
         EGx/7hACjiq/scqNWNQRxxdH7cWpQeJLYORDKFHyFqZQctWRUjS8dIlkHrkmxUyGiEiM
         xtvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBmj4qzvUpIg8FvbayHJi16NVpnwVL6xSDaELC0WWT3+/ILxff+4+9BT+kUwf5o1l5BseC6MVNVyb7W6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7V38W3wpvCYQksq1wFU0f9wODCbh6My/2OH4BGgj8nq5t7Np
	yj5PdAmQ1eA/G0y14o5USijbuLrqaQrkUi7NmHOeTbGRKQQIAuGTFku7vLVbhd58ubFZioNZ3cH
	ojQK0askppUXkBm8s8n3rRyJerevYhArJnBRefU9AtmXzbaArPrbIlkHf0WUst+hQgAQ=
X-Gm-Gg: ASbGncv+obtM2EClvlqgFCF7wwPqYIeVxdmE1QfaxXqOUrIdl4O7tMwidlvhkc0SQYX
	BExeoWj65SpuShC/27KT7MPpyJKOkU6VCEFLU6Fe1nM+E6DN4ZSJZKTUckVJfUnVPevb64kBuVa
	LLFPy7h4BnQWbLgNrvt+ituobR38dtSQMGwLt3/VsxqN3SkA+liRA3t+ECU8tKIOao5Zto9ls4F
	FVX6njxVLzGSi/IFlYQQMij5FW4V7uVQ8MnmhW37gw6WTIQF+tuF4kf2nCjv0LkMqrVYE+PefrY
	/o/rctQ35R0AsP1CONBkvClK4Qgv+ttaeXWgTfCEB8FmNd6o5c1botweo4mvCEHQl5cJs5I192X
	GbsYUfaveRhXFWyU98Q==
X-Received: by 2002:a05:6214:c28:b0:70b:c900:c554 with SMTP id 6a1803df08f44-70c35d70672mr17885296d6.51.1755600966228;
        Tue, 19 Aug 2025 03:56:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGUxbouQ23f5n9Nb/Ax/PRMhBNA4fuV1P2n23CV0Mrc7Iqs7S7DSWRnZn8F0Lk+cpHItsHnA==
X-Received: by 2002:a05:6214:c28:b0:70b:c900:c554 with SMTP id 6a1803df08f44-70c35d70672mr17884996d6.51.1755600965717;
        Tue, 19 Aug 2025 03:56:05 -0700 (PDT)
Received: from [10.207.49.70] (84-253-220-51.bb.dnainternet.fi. [84.253.220.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3340a41d325sm21592351fa.5.2025.08.19.03.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 03:56:04 -0700 (PDT)
Message-ID: <24392da1-02f4-4d57-a145-6285d46d3bad@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 13:56:02 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/bridge: ite-it6232: declare supported infoframes
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20250816-drm-limit-infoframes-v1-0-6dc17d5f07e9@oss.qualcomm.com>
 <20250816-drm-limit-infoframes-v1-3-6dc17d5f07e9@oss.qualcomm.com>
 <9e77615a-9d5b-4971-b1db-74d6bed39533@nxp.com>
Content-Language: en-US
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <9e77615a-9d5b-4971-b1db-74d6bed39533@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a45847 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=JdIsBVl79nXNK9flUcZCTw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=8AirrxEcAAAA:8
 a=y4d4D-FnMFCReEbV-5EA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: Ie_1X9nY_IY49rQfgFwwpJjDARYVTtr1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX6YMPsfDzxY5f
 mEccsSvbzqUk0pLheZbmwPgXlrEPvNnKvr8YdbR0KOThTkPuw8cV0u37gO4B4dpV4aBDTZiSuYP
 /W9q7QovybKmTSNxKWW1Gni9xsDboLxXb0kZiNyTM3gKvi95zm/Qzh75u8suBWYBZrEYnan8H93
 tJAo9am6eCQ0X1XVKdVsRU3903ND7e5wJQ4KpO12vmQnWl9LMSdDRnD/CtQLLJ5lhHfFqYAm28U
 YdPWQPrgDbS+LqysJ++iZGeGoBvKoFXwBp4tBZv9fGbJFpn3euVbGgLTjJ+q+JRkdQxACRdOpkx
 B5Mnh1/QPRvYFVrPkmrF6+W6KCZMbf12ov0+5o1032D6mnlBXIjF6J2AQRnUQFaqvbNi7/bTCIr
 P9UGPkBv
X-Proofpoint-GUID: Ie_1X9nY_IY49rQfgFwwpJjDARYVTtr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

On 19/08/2025 12:49, Liu Ying wrote:
> Hi Dmitry,
> 
> On 08/16/2025, Dmitry Baryshkov wrote:
>> Declare which infoframes are supported via the .hdmi_write_infoframe()
>> interface.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/bridge/ite-it6263.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> For subject, s/it6232/it6263.

Ack

> 
>>
>> diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
>> index cf813672b4ffb8ab5c524c6414ee7b414cebc018..b1956891a8388401c13cd2fc5c78f0779063adf4 100644
>> --- a/drivers/gpu/drm/bridge/ite-it6263.c
>> +++ b/drivers/gpu/drm/bridge/ite-it6263.c
>> @@ -875,6 +875,7 @@ static int it6263_probe(struct i2c_client *client)
>>   	it->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
>>   	it->bridge.vendor = "ITE";
>>   	it->bridge.product = "IT6263";
>> +	it->bridge.supported_infoframes = DRM_CONNECTOR_INFOFRAME_AVI;
> 
> With supported_infoframes set, the two lines setting vendor and product
> are dead code.  I think it's worth dropping them and updating kerneldoc
> for vendor and product members because they don't have to be required if
> DRM_BRIDGE_OP_HDMI is set.  But, this could be done with future patch(not
> in this patch series).

They are still required by the framework itself, see 
drmm_connector_hdmi_init().

BTW: I don't have ITE datasheet. Do you know if it really supports only 
the AVI frame?


> 
> Reviewed-by: Liu Ying <victor.liu@nxp.com>
> 
>>   
>>   	return devm_drm_bridge_add(dev, &it->bridge);
>>   }
>>
> 
> 


-- 
With best wishes
Dmitry

