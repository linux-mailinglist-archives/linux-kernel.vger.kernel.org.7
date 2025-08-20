Return-Path: <linux-kernel+bounces-778406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D648B2E52A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96C25E3B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B227B346;
	Wed, 20 Aug 2025 18:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iSpcbWo5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419D27AC43;
	Wed, 20 Aug 2025 18:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755715479; cv=none; b=HgLHLs/Fgp0/KKlLUVMo0Dj16fVTub7Cno3hNeIkte6R44ReekjwfYhW4Q2PcGRTG9HARLbK1gjavAeHes5K/LvBlpoQwW2MHzIDYndgGACLSSATjWe2hjmMCToqQr2DzBLXTqpu2iOjVo0YhPJpUjgNHz7BS921WE8N1xFp5sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755715479; c=relaxed/simple;
	bh=nZXyMjXfjfonZjntCQB/rkh/lTmenS8hVoqEoNgSb8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E9+G4pRbC/ehwCKySeNFOAz4WRtuUHW5U+ovqhLDgQhhJmTKnImmdRmXYCG3RAuR/F0ypTvVHVbkn2iTqpgOB0Oi0CnIRMXTdVlG14W9+N9JDX/ztwY4jlI+i6czpG/h5Lvqer0QVNB5z8wzJFVc1Ob9GMwrc3u7HVctfrAKLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iSpcbWo5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KI3s8H024699;
	Wed, 20 Aug 2025 18:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oU3RzcwgQI0CWq+2Q2K1VuYbAkBVJTWgG3DGEyHS02c=; b=iSpcbWo50HZkG5rZ
	/sXsbi/15o4Drb7GN28LF5H7VG4UmC0O/JNbzwHyTNhJdTE2fFuDnxwLsc3WXJ+P
	LYtNf9LhbKSjDwl6/2xY0YxdTUms+152CM1mDOZK+LcKY+OiMwj2V6UjMCbEXUfT
	KD0tM0HvtrQB6BGbkh+n4uA7F+U9K7hg/7bO7fZygHG1sq+mBGwzPPqtwtzlq0Lx
	HRKnqdltSkxhA3ujTSWNP6N5mYzOmiYgSSxntGM/BkQ0dfZtDphdXwMC8zvzmEo5
	eqwfob5VH0Dthu7W/rewd2upTUZw8oY4oZ1T2PnADf7JjnXBUJiw2hbOGL/XWE5m
	ozSkDg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5292u6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 18:44:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57KIiR4v020150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 18:44:27 GMT
Received: from [10.47.235.76] (10.49.16.6) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 20 Aug
 2025 11:44:26 -0700
Message-ID: <e5c5c2da-ae77-4738-9f0f-33c51111f91c@quicinc.com>
Date: Wed, 20 Aug 2025 11:44:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dt-bindings: firmware: arm,scmi: allow multiple
 instances
To: Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi
	<cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <arm-scmi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@oss.qualcomm.com>, Nikunj Kela <quic_nkela@quicinc.com>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
References: <20250730-8255-scmi-v6-1-a7d8ba19aded@quicinc.com>
Content-Language: en-US
From: Deepti Jaggi <quic_djaggi@quicinc.com>
In-Reply-To: <20250730-8255-scmi-v6-1-a7d8ba19aded@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a6178c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=3H110R4YSZwA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=7CQSdrXTAAAA:8 a=eJACeLvMHX5Tr_f141cA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Gfx79Z3p15FZVuGHGNK6gkDxZjIEhC8g
X-Proofpoint-GUID: Gfx79Z3p15FZVuGHGNK6gkDxZjIEhC8g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX1i/vcratP6U1
 +CmWibHTAgimaMXKVZcJiARfmfWH3pHkJm+2PJoF79AFyP9HCLEolKq0/5rAOwIRyXopeoIvgcz
 Oe8VI0T7z6PldPW69wFf9i/KduW7uCIiIIn8aQ3t5EAVLn5Fh5MNVD1d4J5/1L7DHYiA3s9Wgt8
 fxRf2t54H4XeMLYrWJinj0ftMSXlfyUODJL74gAagMPqRbGGGyebHa4PzclwVTnS8SSaQIU9+jy
 HyOPZxgGGoIhxTOCMHiS34OzQlBXbgfnGom/KLJA7y7QKw//O+kwNf6nUJwp38eVyqumeAiVOKt
 HVFN9gQsLsI25wPWGgjOx4BySaKJ1NrBVFMUWX8pbC3JECk9gM2CCpUYyoKx2dkouoPT5iM3VPK
 tLLuWsSfScbRtuaELEHaiQO+0fdlQw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013


On 7/30/25 14:30, Deepti Jaggi wrote:
> From: Nikunj Kela <quic_nkela@quicinc.com>
>
> Allow multiple SCMI instances by extending the scmi node name to include
> an instance number suffix.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> Signed-off-by: Deepti Jaggi <quic_djaggi@quicinc.com>
> ---
> Changes in v6:
>          - Dropped 'this change' from description
> 	- Link to v5: https://lore.kernel.org/all/20250423005824.3993256-1-quic_djaggi@quicinc.com
>
> Changes in v5:
>          - Added Reviewed-by tag
> 	- Link to v4: https://lore.kernel.org/all/20240910163456.2383372-1-quic_nkela@quicinc.com
>
> Changes in v4:
>          - Dropped 'virtual' from subject and description
> 	- Link to v3: https://lore.kernel.org/all/20240905201217.3815113-1-quic_nkela@quicinc.com
>
> Changes in v3:
>          - Added Reviewed-by tag
>          - Removed the patch from original series[1]
>
> Changes in v2:
>          - Fixed scmi nodename pattern
>
> [1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
> ---
>   Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index abbd62f1fed0993ab98fa44bdb9a0575f8e1c78e..be817fd9cc34b14009a3b1d69e78b802215571b6 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -27,7 +27,7 @@ anyOf:
>   
>   properties:
>     $nodename:
> -    const: scmi
> +    pattern: '^scmi(-[0-9]+)?$'
>   
>     compatible:
>       oneOf:
>
> ---
> base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
> change-id: 20250728-8255-scmi-ed963ef8f155

Gentle ping!!
Could you please review the patch?

> Best regards,

