Return-Path: <linux-kernel+bounces-757992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C3B1C96F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C169174DFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C6828FFCD;
	Wed,  6 Aug 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AVYKFz1j"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CE928D85D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495921; cv=none; b=ZEt/+TtUxVdKJS60BdTw19yfInp0Hzr0y1ohzRY8h8jiAGLSaTFpQxfx0c2zCSjGw/0kA/BRrUpZe2PifxzyoLDQ1HgG+fqf+AeWzCq3QMhI+GP38Z/szHZiJL3VJb2H+O97S4eR7hGwlF6uBJgSU/VUqCpHZVGBYHIeaQvRgXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495921; c=relaxed/simple;
	bh=unBw+GnMWnnx7sxRmdXg/LrEJMSOpQKmyIAZWWmxFYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgX3t+aMbfv0nLtIpKWApEv5xVucngWs+FmJQQ5g/45e1D/kJeMc6MNwsJMF9Y1jz+TUwpK5hzUvz9t3EtKQQRyWUjKPSar290tPF2Tf7DvvYRYpmApVT3sBNiJTUFm0HGmP4OTBfg3KyoZVLX2d1soHvynqodIScVJD9fM8d1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AVYKFz1j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576C6Hs8025397
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 15:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QNS/uT0UsRLTZGD2d6XkWPD5SB9JWddvW75QWH/H0eU=; b=AVYKFz1jdDIocdhe
	0o5fmMz+DfjGieO6x0g+rQWNH5CaTK8jk7KRHLUEISUv8IEDX2O+f8VVue8xWmpc
	8OwMlUTuzuVivad8WHfjixUvac4VTIyiMT2UwiuuBf0w1LMStUAhV7Nfq4TfdgTF
	58nAu6jegsO4PaWqb25GfMeisXKhUFfHW0SHQ52xgr4yjdIuNWOrGKGxd3+qSeFe
	509UJeVj5T09RmA3gKSbgyU/0pR6oeon8uOf+iHHo53iiXoHCAacxCeuxoZzxrtj
	xBMtA3/Euf7oMzFiFCnC1CNJY4W7ZjKQ5udtDyN2sGp9S6SFW/fSazgsK1w5XOIF
	n1WscQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvyucxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 15:58:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e698aaff5bso177785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495918; x=1755100718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNS/uT0UsRLTZGD2d6XkWPD5SB9JWddvW75QWH/H0eU=;
        b=er1fPiAYOXOUI9PgIzB3BsL1P+0OL7bLTJ7pAU9hMLf2K4oSsJENFksdKPUOUr+r7n
         k5ENa/i3TJNj2qZtY+X05Vfe6GcnRAd1CwtauARTDRkF5jQMHNV2HLDz/77B/HqO3W4C
         0qNbIYFb33YtMEiuSarzP3zvwdiGJ1rCzpdVU40GVo4Yc+GCDcAA57TUyA0sygzRBa52
         QuNsDVYrjcBHMPJyjzKAcMltqzxYhysyT0JtxIe69IVo9GbbXooOMD3Dcoxze9wT5P4o
         92NdEgsxRHJQDm7VAkI2jCkferuEfmvLM9lcHmcGYy6JPepv2wDs1ouuzABBqv6axmKC
         z57g==
X-Forwarded-Encrypted: i=1; AJvYcCVXfh+wdjNHXcSWjCsCjfS8zK3PMPG/mnkwIpgIOVyopiLP+p5ZAs7HmCKorGiCYwtrLXcYApUUpoEJl78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT7LZ5pH/WoqwcVvO4n6qqsKlgw6Fw2XGrEsTz3Cfk0iJAit0w
	5dOg7gDSFP+xaBI+I64dsDWYCWYs3V1qigwXkGFiff4IRxKq2HWW/NbpHWPPf1UDvncYGTgrv+M
	ZWRYDS1J/ber7nf4qcxCxLkd+tDtmxV7GkE6ye6pQQEiI8qyHVMAfX/2pPNTieXFsqQg=
X-Gm-Gg: ASbGncvOdkUcVkByJCItDIKHsVv/pv37iSmvL13qymKH5z2/Ii3Aiz5fMTrNrOroulb
	pJMlEYZ20v6oTvQX2MprQSh6XFenYy7CH1kS+a73JE+qafooMpegkb0tE9grBPyB0V0EF78+n+4
	eW2U/l3ZPRHPh3WIjjWVDSz+C6/Lmmd4OLASG/yoqs8bFbftz+PlpX3GDUTQQNvWEjxv1cmpZ6L
	OJxeMv1JWtlunbFqpA+1RJJE1JITpS11tF7pV3/f+LsFjT4331EpQjbptmPoiuywpNMnGkI/yyH
	lWi0rd7U3otdYE8WvZS+zPfU77MOE9PeJEfGnQ9rbKUOsEay4JQvjBgarQb4L9RIhz6uRtXuSCD
	3B7cLPp7G1S1LOI0Dsg==
X-Received: by 2002:a05:620a:2584:b0:7e6:81d9:359a with SMTP id af79cd13be357-7e814df0c35mr241157685a.9.1754495917409;
        Wed, 06 Aug 2025 08:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2XRnua00uhBgXJfMjuaXYjlV+/ag9i/MerbwZyjSbEZJVYDAvoxc5k5/SUInzS+jgdX/iJg==
X-Received: by 2002:a05:620a:2584:b0:7e6:81d9:359a with SMTP id af79cd13be357-7e814df0c35mr241144185a.9.1754495914102;
        Wed, 06 Aug 2025 08:58:34 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8feaf2fsm10329223a12.38.2025.08.06.08.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 08:58:33 -0700 (PDT)
Message-ID: <f368b6da-1aa3-4b8e-9106-3c29d4ab5c5e@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 17:58:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 4/4] phy: qcom-qmp-ufs: read max-microamp values from
 device tree
To: Mark Brown <broonie@kernel.org>, Nitin Rawat <quic_nitirawa@quicinc.com>,
        vkoul@kernel.org, kishon@kernel.org, mani@kernel.org,
        conor+dt@kernel.org, bvanassche@acm.org, andersson@kernel.org,
        neil.armstrong@linaro.org, dmitry.baryshkov@oss.qualcomm.com,
        konradybcio@kernel.org, krzk+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250806154340.20122-1-quic_nitirawa@quicinc.com>
 <20250806154340.20122-5-quic_nitirawa@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250806154340.20122-5-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ozw1JIhH79Wmx62YBE3FWoY_kI5pIvOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXweImp/51AWta
 EO7IQjd+W2lGWnl72oxJJUZQZM0BZ9liMzRAG9uZaKWYtfC8Rl6giTuIglJfy1U9ycpymZx1TSR
 eQCYvtHdxRoAeeObMwQyrP77P3bF/YTEbkW9xvgckZEa8CGXO8ssYTO/6VJTUOzdYm7RRV7gkCG
 COa5vqsP9xm6gIa6M4VEAugU4koFUXRWc9SduxLJjrBUxYLPyLE2TvzTT6q4iJEgHK65nDkrfkZ
 kkTR5+20UjUC4gh/QsICcUA+YmJRVIdcfFIkMSgWXceBoo+u3rsLq3RbcBEZnZ2z5mmpDl0V77n
 zcAPoIl/KC7bmh4SS/38Bc0jbkBxS34FyWsDf5EsByjbCPTb5Mvz9IEIzmsGC8IBzGOi0K5co/X
 eORn5wkE
X-Proofpoint-ORIG-GUID: ozw1JIhH79Wmx62YBE3FWoY_kI5pIvOu
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=68937bae cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=LTPa4ebz5QvcgEhxLXIA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 8/6/25 5:43 PM, Nitin Rawat wrote:
> Add support in QMP PHY driver to read optional vdda-phy-max-microamp
> and vdda-pll-max-microamp properties from the device tree.
> 
> These properties define the expected maximum current (in microamps) for
> each supply. The driver uses this information to configure regulators
> more accurately and ensure they operate in the correct mode based on
> client load requirements.
> 
> If the property is not present, the driver defaults load to
> `QMP_VREG_UNUSED`.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 9c69c77d10c8..6e116f7370c3 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -39,6 +39,8 @@
>  #define PHY_INIT_COMPLETE_TIMEOUT		10000
>  
>  #define NUM_OVERLAY				2
> +#define QMP_VREG_UNUSED				-1
> +#define MAX_PROP_NAME				32
>  
>  /* set of registers with offsets different per-PHY */
>  enum qphy_reg_layout {
> @@ -1894,15 +1896,29 @@ static int qmp_ufs_vreg_init(struct qmp_ufs *qmp)
>  {
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  	struct device *dev = qmp->dev;
> +	struct device_node *np = dev->of_node;
> +	char prop_name[MAX_PROP_NAME];
>  	int num = cfg->num_vregs;
> -	int i;
> +	const char *supply;
> +	int i, ret;
>  
>  	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
>  	if (!qmp->vregs)
>  		return -ENOMEM;
>  
> -	for (i = 0; i < num; i++)
> -		qmp->vregs[i].supply = cfg->vreg_list[i];
> +	for (i = 0; i < num; i++) {
> +		supply = cfg->vreg_list[i];
> +		qmp->vregs[i].supply = supply;
> +
> +		/* Defaults to unused */
> +		qmp->vregs[i].init_load_uA = QMP_VREG_UNUSED;
> +
> +		snprintf(prop_name, sizeof(prop_name), "%s-max-microamp", supply);
> +		ret = of_property_read_u32(np, prop_name, &qmp->vregs[i].init_load_uA);
> +		if (ret)
> +			dev_dbg(qmp->dev, "No max microamp for %s, using default %d\n",
> +				supply, QMP_VREG_UNUSED);

+Mark

do you think having this in regulator core would make sense?

Konrad

