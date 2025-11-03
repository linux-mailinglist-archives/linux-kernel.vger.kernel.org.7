Return-Path: <linux-kernel+bounces-882669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F192AC2B14F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6942F34610A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614B2FE571;
	Mon,  3 Nov 2025 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nkj6ofue"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33E2FABF8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166099; cv=none; b=RrMg0ONcdhSlTFyCsRYViEIdNlnJiziZod3eidr2Mr17V7NglFRNIFlSDn0qXV3udICr0QeSc/R3wQVV296A84zd+BWVqnaH5ZvuVNVtxTkn8YqLa8zP4hJTaCjVsB88CC1DpatR3DnFY94HDabOdvKgQhbELTqNOjkdqq8Szwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166099; c=relaxed/simple;
	bh=tphYS0CtFvaiM9XlNRIZg73HwcFnHcfGYHRI4e6Tccc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nqYji472ymlRI9/fXHA2mZMQ5P7mFKut7KK4nRCf1tU8YkR8haifYIRxD83AYtBINQi8L78R1ugdnQO1hgMlMir3fePaUbyOVkcYVNG5tL7j+U0e5tjj8YLng1KW/dMr4vufvQApYMMm7KkFpnLnR/X9qlsOq0b5pQNQBzSzOdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nkj6ofue; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A383LBe694040;
	Mon, 3 Nov 2025 10:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bbJfcRBmvzB7GPs3ALPm2KF8b3Wy02IooMd1RLjQELE=; b=nkj6ofueew6o00Ut
	4VNte3EvAXkx2fBes4WXEtuB4xN8A//JfPV013JgOuoN/h/69VaW8PRhkzAO0yrn
	6rid8/pAzzXyZ6cuvDatVWFm6+TYh00CfnfTG87QZ7qTwsZr+mPiGs4jOEdBWfln
	pDEz+iwALb8llU6sbY5Eqj7BPBQJ2NTR6ekRRp4Sp9VWZoxyrKfO0VvzvZwbMyF1
	SRNScDpGS59ILhZxr1IQX7153V7OYvrKvEclT7LtZvAwm+o+pnK01Om/Wrx8Y8Cz
	Jdd3OzIuTH4k07INoJE6cl8Ji8cmN0kJHarJsTf7CT1aENFwWqjcAmeCnVWF/cNA
	qyie4w==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ak8ma1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 10:34:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5A3AYar3006668
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Nov 2025 10:34:36 GMT
Received: from [10.206.97.61] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Mon, 3 Nov
 2025 02:34:30 -0800
Message-ID: <45be2cab-d6a3-4ff8-b66e-2424a74328f6@quicinc.com>
Date: Mon, 3 Nov 2025 16:04:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/bridge: anx7625: Fix EDID block size at
 drm_edid_alloc() calling
To: Xin Ji <xji@analogixsemi.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jani Nikula
	<jani.nikula@intel.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio
	<konrad.dybcio@oss.qualcomm.com>,
        <quic_rajeevny@quicinc.com>
CC: <bliang@analogixsemi.com>, <qwen@analogixsemi.com>,
        <treapking@chromium.org>,
        <jason-jh.lin@mediatek.corp-partner.google.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250808064613.2623732-1-xji@analogixsemi.com>
Content-Language: en-US
From: Ayushi Makhija <quic_amakhija@quicinc.com>
In-Reply-To: <20250808064613.2623732-1-xji@analogixsemi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2UQ5bLOB1zZ2Wxzh5yuKL6Ik5XTvNE9u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA5NiBTYWx0ZWRfX/8DwIp48Z1Fx
 bQaJiEEAzD5aggGbtbSba4IHw/w55++E9keIczyXO2kVkTL4+NZ1RH1mcSSSB8/HeCDSzYf6mQe
 aPFq+eWVW8GN8Wm/kH5mSBK/kh5g/7TXymKbfemhZsJUk2GrpY2PQYxZwiuZdjDrZdjDoaQsH3P
 YMkQG62z0tKtr09H9+XhoPx7fy+oq86Mj1nW0oN34lD/UOfniv5YO+uHp6M9I2wJz5lm6oVr9kE
 mVRolR38dTjwf5WWcfh4A+FXb9o6gf6lqcHkekQKZkp8pvuQjrFrAayE+OqmNJMLLIacwAnKQVC
 6nYLc0bBcEJ27N743PWfBwJlVhazCEI3Ea/QwKYEV/uYZ9WrJAIb+gp26JddVFJN2Vq/RrGxgjq
 u/Emahqps8V667CCYunhyoupEI2UzQ==
X-Authority-Analysis: v=2.4 cv=ZZEQ98VA c=1 sm=1 tr=0 ts=6908853d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=bbNUuHX0AAAA:8 a=COk6AnOGAAAA:8
 a=Nas7dopP-U0ihP8ZSH4A:9 a=QEXdDO2ut3YA:10 a=3b-t3vAtY4IUXy2q2Ylb:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 2UQ5bLOB1zZ2Wxzh5yuKL6Ik5XTvNE9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030096

On 8/8/2025 12:16 PM, Xin Ji wrote:
> Since DRM validates the all of EDID blocks, allocates drm_edid data
> structure based on the actually block count returned by the sink
> monitor at drm_edid_alloc() calling.
> 
> Fixes: 7c585f9a71aa ("drm/bridge: anx7625: use struct drm_edid more")
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index c0ad8f59e483..4b5a74e9785e 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1801,7 +1801,7 @@ static const struct drm_edid *anx7625_edid_read(struct anx7625_data *ctx)
>  		return NULL;
>  	}
>  
> -	ctx->cached_drm_edid = drm_edid_alloc(edid_buf, FOUR_BLOCK_SIZE);
> +	ctx->cached_drm_edid = drm_edid_alloc(edid_buf, edid_num * EDID_LENGTH);
>  	kfree(edid_buf);
>  
>  out:

I applied https://lore.kernel.org/all/20250808064613.2623732-1-xji@analogixsemi.com/ on linux-next (next-20250929),
tested on QCS9100 RIDE SX platform.

Before this patch, the ANX7625 bridge driver allocated drm_edid with a fixed 512 bytes (FOUR_BLOCK_SIZE),
while the connected monitor provides only 256 bytes of EDID (2 blocks; EDID_LENGTH = 128 bytes per block)
(It could vary depending on the number of edid blocks supported by the monitor). This mismatch caused
drm_edid_valid() to fail and the system to boot into a fail safe mode.

With this patch, the allocation uses edid_num * EDID_LENGTH, matching the actual number of EDID blocks from
the monitor, and the issue is no longer reproducible.

Tested-by: Ayushi Makhija <quic_amakhija@quicinc.com>

Thanks,
Ayushi

