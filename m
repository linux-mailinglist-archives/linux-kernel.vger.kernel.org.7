Return-Path: <linux-kernel+bounces-781229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B68B30F8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7C9A02213
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAB023B607;
	Fri, 22 Aug 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpypsNBc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAC3230272
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845365; cv=none; b=gbKOy5wQdQUjNwVmd7nR4lW3LXrBN1Rt00uGBJkDWHxPtDNP/ch+b7kEpA4eNh4EZUbvZHzheMZsg3Inh0Gg+lSws/bdlUW6z3N81N4iK1s8eRPCL79kD1GmnF7b2gzsqvJXfGWgRQwomH7q6qj9098GoHTHSa6ZMlV7eoUuj+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845365; c=relaxed/simple;
	bh=d51gPt9fVVIQrlb71UzF3auHKTHOiR8lyyNLgba0IKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F79DctCvD5Do7Ke8rCghJLqYXRvJf1ocbDjs141R3d6tbTAa5D1zeapNUuJIU4TTTzL/11mIf+gThGhcrTNDY/Rp79TWSIOBfLkRL5PPDoN7WNWFDV/uNMH5wnazPXHbHzWbkdmYTktomMeEeSLSRHZJ1h24+ZfLNndiZbWllng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XpypsNBc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6b9KU005466
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PAelQyATkPA6YSXiRQaF3kDsfrHXJ4J/shH4gx5CIb8=; b=XpypsNBcuyAp/E9l
	cMSqL9doPX/KQeFqCC5fdM4wqiI1J54UThwJttpQCwPqaSWuP3Exn3DdAtl6z7nH
	dxunfAwgv4QMLgEo2clVv8ZtS7Hl5FjHMy2ujAsTDUJYY0jt6qtfMKI1xgZMo7fr
	K3O//G/YQBO0uqeuP83fdJl+g5dwuMzWisOt+OYY8y37rekTc1VPy0j5gp0cuBBE
	G1Hse0gaaU4//wDwBnX7+uL17KX0/EKFzABR9OY79PS+8tKi+f++eLP3WmpwMSEv
	1Gcl+sbQ4IP9+x+gdEHHa8m3Fc31y/QIxHm42aNykv4nJRwADxGei5WViPKfh+J2
	5Aso1g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cr3yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:49:23 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b49c7295627so12207a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845363; x=1756450163;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PAelQyATkPA6YSXiRQaF3kDsfrHXJ4J/shH4gx5CIb8=;
        b=OCkKyQM1uqGl0u3RvwcQP70l396J7DMWC/NVraRhq2yDNJruMjKyxbhLEj+daypAON
         MHjOJxd9A49jhF/yHTVIVTzG4ZRH72JMdDNpEacnjnsyuoPfxGpXBSJpP+y8VNyI7K2h
         pH/HzVA5OBH1z/BFcu1PPCQMSZHfUvhgMJnFrRT+dzk54DtLfeD3VGBIgjZRGZ8mCKzi
         8/63HER9dwffENM8AYr8yvHvd4TXuB5OXVLTFcVAdxFLv4YqlZKH/lHQOFLX9jSoxltY
         Ak6uJTCfDJsjddjSJ67rgO2UvU5dfikLd34uZXi//ya2uoGr9T00srNR+BPKFkbCd9th
         LnuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsvNK1BkD9Yd5tvnggBCkH6uR/PS9ej57qQqBQNE7K6/Mo2avPPFSoY25jNjlfGwVV1RFRv7hdxlzCtq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSoLbtagWphEJDTGbkAEAX/NAGLbHIdxW1lOoTDA9LDOAYivR
	3CiAgxR8FD2W3RWJ6vJ4aHD2CuIh9Vvuo/2ewbEa7o+e2kntwtuIuLI+QxHW7dNx7LZGYp/V7kU
	KYcESYTSdvUXOPE7b2uk2VbPNvSy35kaL3lavf3WuZ85sl6ENb7ASOlDouh7d1oQzI9Q=
X-Gm-Gg: ASbGncubFTwR+taQRYUAn51KI+LLXjVoCq1YBA5moolQpsOXdS7pY/aGIfDqy3MyXdx
	asO5Z6dUEciKwAxKJjWLKbRBBdEPY5CVVkFGOj6rYOC4T3hY9TRn+BWqQclmVm5mQsAmRSLFV/I
	EV/MeWWj/a2jLwbcJ1S84CTY2k/E54YKVK5Ajv1QKovkMZhyQvmHeUDCuNf8kJmtaLVrSho01Sa
	/uh6tbpq4mnP2nynDsnAcQzVWhmyueLkcqijiIE2+2yhhWixh3pKBCsQ+C2vgfgy6u/EnsEsM//
	x6+mvvnCnTlKS6GLY6Qo8fE1lL21Qz5uLfbcwVdLdV7r9nQt7hIF6sGwj6rp1F4w8m+4JOYXKoy
	BJqR5pg00Ond5sLHjuCOIwDYbiEZv6A==
X-Received: by 2002:a05:6a00:4b16:b0:748:f854:b76b with SMTP id d2e1a72fcca58-7702fc0b4b9mr1451101b3a.3.1755845362729;
        Thu, 21 Aug 2025 23:49:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGw2XinJYhFdfeOr2DKaBI1LxvJNvXAx1nbOyA+a6mHNvNi1D2KrOEAJ42/+JTdElCmxHO/Qw==
X-Received: by 2002:a05:6a00:4b16:b0:748:f854:b76b with SMTP id d2e1a72fcca58-7702fc0b4b9mr1451069b3a.3.1755845362261;
        Thu, 21 Aug 2025 23:49:22 -0700 (PDT)
Received: from [10.133.33.119] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d10fdd6sm10099827b3a.29.2025.08.21.23.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 23:49:21 -0700 (PDT)
Message-ID: <d21c4c74-a36b-4f01-9c22-44bcec3c20eb@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 14:49:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] phy: qcom: qmp-usbc: Add USBC PHY type enum
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
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
 <20250820-add-displayport-support-for-qcs615-platform-v3-4-a43bd25ec39c@oss.qualcomm.com>
 <cueyo7huj2m2yt46sjk3atfktft6y5slhhtslwmi44r7h7lxbn@5zvwxtdmk34t>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <cueyo7huj2m2yt46sjk3atfktft6y5slhhtslwmi44r7h7lxbn@5zvwxtdmk34t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8cgyKaLJw4K83i33SMz_xZVNL5BwrxGk
X-Proofpoint-ORIG-GUID: 8cgyKaLJw4K83i33SMz_xZVNL5BwrxGk
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a812f3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=LJgbN-Jd--P93uwsTkIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX6oMYF0f4FBtI
 h+u8DtjUBId6oM71L+t7vReHOEEXFp46RKByporg6g4yOcSDUJeusgO0m/aOlg82IHjtvU/o/sK
 kY0wLLkmsXItcaPkpPnSMxdK2Ewh10FFuovSWZ25RODcgErSuj4dE4DZxjpzS4wYXGjMeRs+uWD
 WrEcIMCvk1fCQoYxbti+X8/TyXyanXiLGRujFQms5XGSZSnuQZqWOJyGf9yupfQffZYLz9+zuc8
 2chGfEzteVlogKHU2bDVKMzN/0uReaK2+nXxZnc0tdtrVS2pD9Z1ZfV270JLz2RNYLUg5lJrgUe
 JZvOd2Rp0ZoCj8imQYqJriinjrSH2C900rWy6lk09D+yHkzvNbnCAH8ZGQnd+KDG4eXDwknNsU2
 hfEn594dF6kIhl6m8hBRJzwByQQNJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013


On 8/20/2025 7:34 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:46PM +0800, Xiangxu Yin wrote:
>> Introduce qmp_phy_usbc_type enum and a 'type' field in qmp_phy_cfg to
>> differentiate between USB-only PHYs and USB/DP switchable PHYs.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> index e484caec2be20121cfe287c507b17af28fb9f211..5afe090b546977a11265bbffa7c355feb8c72dfa 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> @@ -284,6 +284,11 @@ static const struct qmp_phy_init_tbl qcm2290_usb3_pcs_tbl[] = {
>>  	QMP_PHY_INIT_CFG(QPHY_V3_PCS_RX_SIGDET_LVL, 0x88),
>>  };
>>  
>> +enum qmp_phy_usbc_type {
>> +	QMP_PHY_USBC_USB3_ONLY,
>> +	QMP_PHY_USBC_USB3_DP,
> Drop, you can use presense of DP offsets in order to differentiate
> between USB3 and USB3+DP.


Ok, will drop.


>> +};
>> +
>>  struct qmp_usbc_offsets {
>>  	u16 serdes;
>>  	u16 pcs;

