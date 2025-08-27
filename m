Return-Path: <linux-kernel+bounces-788277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71D8B3821C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F17188EFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934AF302778;
	Wed, 27 Aug 2025 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lR8vuIvd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9F28C847
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756297073; cv=none; b=ekWSuWCJdo6zBAg1KOCLE6/+U4bAGNzK84gxH6Pq9ZkeVA4qsgbGKwuQ2QBGEsUoYzfVJixzgMDW3DaBzWUgIh8n/yeItEEc3+vguKo24jqfzn2Jcgau4UHmw+7ELRondKotGxIbSn6Vri7EAjb4l5vkLudQPCFIEWsMB8fId5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756297073; c=relaxed/simple;
	bh=xB63zHf8WWsvv2dV71RhZN1tcOaGZ44qUPczHpUw1A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXVbrHxvKnKrhvbKmOYAQNJE2vY6qitcYknZDx+6BvyqK1v1zd21kMSzjTnUylb66KIWjv64oa63M4CZrlE/W4FYFisTHjONBU1QD3xTtnpMiVKKyoYAZz+350OeDsGMkEvK3sKPFW0eRSexyemtaEK/tLp3YDEBJE0ftrHcZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lR8vuIvd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kCE1027278
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X8RSqvNCRDDgijasg0nbutFMmtBqyja8T4LtC7m2lA8=; b=lR8vuIvdVjrFz78j
	ZphFCEx85h7qmFpG4lXcHddG6+Uo/V6xt+7hh51h9rUmisheQ/iPYr0OHEDEYnsM
	Wt9dfgxex3zll6bUY1mXRrVSULlVA1pFczVpGvBsM9QtZ+j9WdlF1XvhxgvYMthp
	r2NY1ev16MXzsOTvfUjrWyfo+tnHs7TdEIINU4XQac0ygWRPBBci1JV7hjE7VGEM
	1W//Rw9/SIszUvctz6T6wpKOCoR6IpbB8wDNmFpxQEl/pQCeRogqEW2LXLimkmPS
	RLJvSgZPvb+6nYNgNhVO4HdLoUvX+u3wgGinYyuXSD+old4avxQkFK9T0vD0pIx1
	1OaPMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48se16ukkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:17:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2465a387372so14403195ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756297070; x=1756901870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X8RSqvNCRDDgijasg0nbutFMmtBqyja8T4LtC7m2lA8=;
        b=qW/RsIVSLmYqNzydAjiTCUj9wQnhww3i3hTJa/PMLwy5hZ0trRMnwrglTBRcaaNYAm
         h9U2Km34hMnu6jGYrGNclA/wT2w+hHF0achukF5XOF2bMgEm5tYeprdlDwLbl6LYo12N
         3egrXDtGDix72nVBCk04C+QnjgeDfqoz93824kh2S78dbyUl0U2wG29NG6/6yqUPKqbf
         S7687P1gQlXN6PsfIXELjw+et335DdKEB6GmFiTgB7Tjw/M18TgLKYENl6oRpLa8ca34
         XT5Av/aR0LcCXOcVIf1ofZiZrvrh3w+HQmKHzT+GhBmzgssaO2e2/rQAvmDabF/k/g7C
         KyGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDvfLDxzS1weYycGvV+ECHPuHvhTFEfJmiZ4VoGVisEUbOgQRzmjgQdF55FbMlo/SmvhDlJSmrKeVR0sY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIUNChV44hx0HBI7/LJjS5K+0cDQvXtVij3jo3XEW7zLsf8y0C
	fRH+ryvL2O/yo0vC6jqk78KRWjsau0bxTDv6KCey2TvSi3aojLufx8DgN8Cy6SVmbVOuG/xALnm
	QLsIvKkbc4zHRVgSOHUpSr7A4gOh5ERaOJa6morRnAWsUhhQoGmUo9A4RHjGeHiot1oo=
X-Gm-Gg: ASbGncuSsl9leDcyf24pIC0kji7WOQN2SXTMJ+kUC6NHDIg9nB1YPRN/rPpWMXpWwiv
	kQsprKqJiMVMYBGi8V5fy7PW7+MIX87Co63eyD7ueTcdjNLzv2DUAnl3uLnPwGA0xph5OcO0RdC
	w3u7dBz4UuTEKiLj7BAiEX9JxbJgXbHdY0AUTld8IpGbR4zrlUyrbZ2z18nG5owae2tZU171/oX
	qGd62k6CJ2BfeWV4ZGC7Q+7TjslUmZWxUyc09Ml+BazeiQhNDkM0/8qE8a7B2UR4KpF8f4eT0m+
	ikVJfDvcOyTJyIGvgp0Dj+KK5eSota1pYTkpl04WAFBfyYN5fPGB/MD0sSKztw/AbUGEZFOhNUY
	5Fea+jOxU9me+dVkZxt8vX0wNX7WdZg==
X-Received: by 2002:a17:902:fb8b:b0:248:bf0a:a127 with SMTP id d9443c01a7336-248bf0aa1bfmr1663425ad.1.1756297070528;
        Wed, 27 Aug 2025 05:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWwdfvw8f7MeJn13rr7IAskUSFh8jN+On8IyJ79l4iyWHwbCU7vdfd6HxX6olsZxDiEsjN2A==
X-Received: by 2002:a17:902:fb8b:b0:248:bf0a:a127 with SMTP id d9443c01a7336-248bf0aa1bfmr1663025ad.1.1756297069957;
        Wed, 27 Aug 2025 05:17:49 -0700 (PDT)
Received: from [10.133.33.166] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcd3285sm1910956a91.14.2025.08.27.05.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 05:17:49 -0700 (PDT)
Message-ID: <9bf7f51b-dcfb-4ff8-848e-dcf144936f2e@oss.qualcomm.com>
Date: Wed, 27 Aug 2025 20:17:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/14] phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP
 switchable Type-C PHYs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, quic_lliu6@quicinc.com
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-9-a43bd25ec39c@oss.qualcomm.com>
 <3pr7ninjxr4pgsz56dr6ojjmx27fzzszmtt6mx4r6qaqt25tnc@nrgx5qiqc7z4>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <3pr7ninjxr4pgsz56dr6ojjmx27fzzszmtt6mx4r6qaqt25tnc@nrgx5qiqc7z4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XrMPJF_aV_BUvEV870ffGK0WRdYaPCy6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDEyMCBTYWx0ZWRfX8qS9AptjNneI
 prDZcb6GdFq6ZVA+fLPVCEnKZ+2FXkNM9dqH9z2aPNasrxTbO7LCIDcSRBNo4Vjw3y2lhp8mGM/
 Iz8VW6I2QFR4VbPQUUxuu7uQ7RWQBcAVc0pC1nVpiyA2oC85R6pwp3wr88NXnrbHBn0BOgYLUUc
 /UEfD3smcDMk1gUPnV+BnBHCaV9bX0dy3K0364zrfTWJJP1aFyTdb1E/CLn7sqrABj1HtBUoEAC
 ydwfvwgVNExPf4HRJpbRKhaH83O0WCEZIGSF9J2UUvaMIH81LYEGo4Wr7b0fnjVknleuAD4pCD2
 qeQxzvrzR6qVAcrhzvFOjD9JdTKFupkSf94rVGSTZNiEincvhomWtAKfaa3v72h9W1LrvTHQkgr
 Zy55XCXy
X-Proofpoint-ORIG-GUID: XrMPJF_aV_BUvEV870ffGK0WRdYaPCy6
X-Authority-Analysis: v=2.4 cv=CNYqXQrD c=1 sm=1 tr=0 ts=68aef76f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=eEvFyuGTnR1_S7nXHuIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508260120


On 8/20/2025 7:45 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:51PM +0800, Xiangxu Yin wrote:
>> Define qmp_usbc_dp_phy_ops struct to support DP mode on USB/DP
>> switchable PHYs.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 163 +++++++++++++++++++++++++++++++
>>  1 file changed, 163 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> index 1508a4a5f57aff85318485b79528325f28a825a4..a1495a2029cf038bb65c36e42d0a4f633e544558 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> @@ -22,6 +22,8 @@
>>  #include <linux/slab.h>
>>  #include <linux/usb/typec.h>
>>  #include <linux/usb/typec_mux.h>
>> +#include <dt-bindings/phy/phy-qcom-qmp.h>
>> +#include <drm/bridge/aux-bridge.h>
> This one is not necessary yet


Ok, will remove unnecessary aux-bridge related part.


>>  
>>  #include "phy-qcom-qmp-common.h"
>>  
> [...]
>
>>  static const struct phy_ops qmp_usbc_usb_phy_ops = {
>>  	.init		= qmp_usbc_usb_enable,
>>  	.exit		= qmp_usbc_usb_disable,
>> @@ -1095,6 +1248,16 @@ static const struct phy_ops qmp_usbc_usb_phy_ops = {
>>  	.owner		= THIS_MODULE,
>>  };
>>  
>> +static const struct phy_ops qmp_usbc_dp_phy_ops = {
> Please try restructuring your patches so that there are no unused
> warnings in the middle of the series. You can split the next patch into
> 'parse' and 'enable' parts, then squash this patch into the 'enable'
> one.


You mean it's better to define and register new functions in the same patch 

where they're first used, to avoid unused warnings? And for things like parse_dt and phy_ops,

it's fine to split them into separate patches if each part is used right away?


>
>> +	.init		= qmp_usbc_dp_enable,
>> +	.exit		= qmp_usbc_dp_disable,
>> +	.configure	= qmp_usbc_dp_configure,
>> +	.calibrate	= qmp_usbc_dp_calibrate,
>> +	.power_on	= qmp_usbc_dp_power_on,
>> +	.power_off	= qmp_usbc_dp_power_off,
>> +	.owner		= THIS_MODULE,
>> +};
>> +
>>  static void qmp_usbc_enable_autonomous_mode(struct qmp_usbc *qmp)
>>  {
>>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>>
>> -- 
>> 2.34.1
>>

