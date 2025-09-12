Return-Path: <linux-kernel+bounces-813909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0791B54CDD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1481517B6BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2F23054E0;
	Fri, 12 Sep 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LThO0WJb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAC305047
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678505; cv=none; b=EYm2/eJh9dddamLpdGM0QHnSrp9O+GNtYrLzroYn4iH3P5vPIG+yoBeRiZKj/2e0xXOdsxK2jm+fVxQwFR+OG7uqZ4rEQdGVSdYn70e10/WDnNI5yF5egOlYDbaZZi2F8NKy0eCBXCFSUkYoYZ1J6EPdv6dkIGETrGcbb9kFMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678505; c=relaxed/simple;
	bh=/8AAvLpDLUvNLFNqA0jzZmGl4oPLi2mhb27u5pyxvXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDyy81RzIXziqC7m+kSw7FiDl+xOE0uXo13xPrU+TJODsS3zAQZR2rBwkmVihs82DyNyDnL+pfE8oP9G2Z0Xwqi7Jn8evyEE4zmU/2Wnx5LHis/CUOocLGrhC+CO3KsjlG7kKNt1oYCKrHrPCJ7V5KagK9djYzRuSgrjjhdXPOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LThO0WJb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fP6s023486
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tR4WV22vf2t/EPkoMZ6ryeD+FVZWeK5RDIR27BMiiCM=; b=LThO0WJbd+uPPfql
	1T9rEvTNfMVif9MJ3ij5xNWCkqiPRYhUWsu++34zYOfSEnJdUDTfwdZBGx5u8VfH
	xmpwjPI4+cVMRRDpIOXYXMLZa05jPm1I1MCntLGcOMP8FcTn5SY554s4VLfwP0Np
	2rtES9jCBlUL1CAihVaHgQ+7dLHSMx3u92rkbEcbqTmzyt0mn74Uv8y4yPw9GDn5
	vLa9znZ/rkzy+eokbXzq0LrydSNBvamx3xMhXAm5cX7MZqX0LaHMnc2GCXujp43K
	1HmLkdiWKvBp8YRYurXbcUTShfrnenWbAVcBVy/FYfaGG4JAhy4qnoyKeqrLEJJz
	UHa/1g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2fnff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:01:41 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54adb3d19cso131525a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678500; x=1758283300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tR4WV22vf2t/EPkoMZ6ryeD+FVZWeK5RDIR27BMiiCM=;
        b=VlnibnPetbP5NvNvUHrEkmfPq5kdxzKJCgBD6F0kxdfaZOWdHXXemfOXRQN4JIhY5U
         AAuMTYY0mTTiAFXWecyM8kRQiTVjnxTfTl7FjfLWN6OMXEzWB08q7vHvraoX5/PPju2W
         EPjfpChckyMD1O7VlCf3VSt9R1a1YzAw93n5x1s8zhSM8Od5E7wXOXHV0nVUyEWWcyv6
         /L3SL5EW5LwvtEMyHWncVeAPe+iiU4AzIfqPU1fu9IfI0YDrM/oiYzvFFCuXb4D/6AdG
         TkWscIW8wNurIjaG9LJ/LLgF4pUY7j8vx9lcW0Bg3LJTxT6Tf/BA0jBBjw5+273sLecO
         4h8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3MZlt5of6z8YuS+/HBu5T4UmVzJbctp9RiakQs4OVNzGTQ1c/Lsqb0dREDD1AUJkenQLoE4w/TiUrEeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAkUrxiIIr6sangoAnQ5+1I5Zg5e8ZOOF3VHlpE7DJ/XBfjpA2
	Ol8ZJX4p+HjCVSoJIB8Fp1t761i326tKHyYR/B4dFUDPdBrsqGEOTFnoDod4Z7zFu84k67LA/xv
	sADCO+Cs9aRPTe5QyukjaAlSgkP4VP0tqpRgHuKcQ9zMeaELkC6aCos48jstcmYKTXAXULDNRbc
	w=
X-Gm-Gg: ASbGncu1jNG0XWRldl2iIZP0dUhHILz3EcA1m8ELJ2DqRNQdzvhQ+YX4rllvnBXI2BE
	1cjNXN2lMqVhq6b3uo6sORs7dI64JEqJAAaJPGjCi1wiTHeLkvjtjOWclCZJcAjRBKy48Gi9aao
	aaNgiq+YIZ2nnLNodaoG1iWAgLLRT3jEYhnpQo6iPDopIRrxFYWCAStO8WGqtR4tKBy9YSjKq8W
	H9mXyX91J4cZOBxFnR7UMLNw0QgBb2YaRpD2d9dfFhoVSg0TItFShOKKqvE3L3tLm8oiSTCy41j
	QXrNqXZTNobHodJ/OBMEP9OkbIlUv0M430LHTStGMe67qwMpqTxqe8VIamNfdNQAXci4zFqNX3q
	6+98G4AzGbAdMqz3jhMuTm6bxKVKJzg==
X-Received: by 2002:a17:903:1ce:b0:25e:8089:5070 with SMTP id d9443c01a7336-25e80895390mr5790335ad.1.1757678498768;
        Fri, 12 Sep 2025 05:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRWUteHVEdJSYAR1rniB1eDfwR2hwSrNL/NbjOkI3aWK1MO0R3uv5T0gv0XZ2mKId4uJql1Q==
X-Received: by 2002:a17:903:1ce:b0:25e:8089:5070 with SMTP id d9443c01a7336-25e80895390mr5789845ad.1.1757678498117;
        Fri, 12 Sep 2025 05:01:38 -0700 (PDT)
Received: from [10.133.33.174] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6cc5sm47586865ad.27.2025.09.12.05.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:01:37 -0700 (PDT)
Message-ID: <9fa9f9e4-b7fa-42fd-b367-9d52e0f1f184@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 20:01:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] phy: qcom: qmp-usbc: Add DP PHY ops for USB/DP
 switchable Type-C PHYs
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-10-2702bdda14ed@oss.qualcomm.com>
 <buob3axokndjfuwvv5j5zee4e66tf7t4ficz6fend5yadw4j6e@czus6n6zfor7>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <buob3axokndjfuwvv5j5zee4e66tf7t4ficz6fend5yadw4j6e@czus6n6zfor7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c40ba5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=ctQwHQabY_GzZcauxAMA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 5Dv-WMfdfJ93TcG7tNDz9A2HbnmVVwoW
X-Proofpoint-GUID: 5Dv-WMfdfJ93TcG7tNDz9A2HbnmVVwoW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfX/oQkUtqxk8PX
 Tnveitr8U/ZcRr6fqlWrUak5y2juQ+GRKc7XlNS2WdimyKiGOpakYUNR6nNUpS+8aFXQiF1LAUe
 fZ7flHTy6jFt9TzIwDV5sFa8lzwqHG6lJ9d0El/oZp5viquTXY7G4wvw6/XZeG6t4TP4JqCSjEc
 oY1WUsyET1ZTrINZfWEAXJN2ZH3wzq4fQYLimbjbncC912BL004UJQZJC7cBp2WIloHRJJkOPmP
 h3iPo/383Ou5/zh/kD31SBg4c+5mifRrg5bR9+LeWl2sSOkdKIo05GZt7dWpJdiBxh5SYMgPNym
 PSrTXtLPPAoQGnsmNLO9o6kxgdNUdEXed1ORqHyMZc9eamwQjMoqos2E2KTjDIe1Sx46i/OLnFr
 kdpC7Txf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094


On 9/12/2025 6:31 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 10:55:07PM +0800, Xiangxu Yin wrote:
>> Define qmp_usbc_dp_phy_ops struct to support DP mode on USB/DP
>> switchable PHYs.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 192 ++++++++++++++++++++++++++++++-
>>  1 file changed, 191 insertions(+), 1 deletion(-)
>>
>> @@ -1669,6 +1832,23 @@ static int qmp_usbc_parse_tcsr(struct qmp_usbc *qmp)
>>  	return 0;
>>  }
>>  
>> +static struct phy *qmp_usbc_phy_xlate(struct device *dev, const struct of_phandle_args *args)
>> +{
>> +	struct qmp_usbc *qmp = dev_get_drvdata(dev);
>> +
>> +	if (args->args_count == 0)
>> +		return qmp->usb_phy;
>> +
>> +	switch (args->args[0]) {
>> +	case QMP_USB43DP_USB3_PHY:
>> +		return qmp->usb_phy;
>> +	case QMP_USB43DP_DP_PHY:
>> +		return qmp->dp_phy;
> return qmp->dp_phy ?: ERR_PTR(-ENODEV);
>
> We are not expected to return NULL here (and dp_phy can be NULL).


Ack. will update.


>> +	}
>> +
>> +	return ERR_PTR(-EINVAL);
>> +}
>> +
>>  static int qmp_usbc_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> @@ -1743,9 +1923,19 @@ static int qmp_usbc_probe(struct platform_device *pdev)
>>  
>>  	phy_set_drvdata(qmp->usb_phy, qmp);
>>  
>> +	if (qmp->dp_serdes != 0) {
>> +		qmp->dp_phy = devm_phy_create(dev, np, &qmp_usbc_dp_phy_ops);
>> +		if (IS_ERR(qmp->dp_phy)) {
>> +			ret = PTR_ERR(qmp->dp_phy);
>> +			dev_err(dev, "failed to create PHY: %d\n", ret);
>> +			goto err_node_put;
>> +		}
>> +		phy_set_drvdata(qmp->dp_phy, qmp);
>> +	}
>> +
>>  	of_node_put(np);
>>  
>> -	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
>> +	phy_provider = devm_of_phy_provider_register(dev, qmp_usbc_phy_xlate);
>>  
>>  	return PTR_ERR_OR_ZERO(phy_provider);
>>  
>>
>> -- 
>> 2.34.1
>>

