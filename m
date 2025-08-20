Return-Path: <linux-kernel+bounces-777004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B46B8B2D3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CB89586135
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6902797AE;
	Wed, 20 Aug 2025 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pPBJM4Ik"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686B19047F
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755670676; cv=none; b=SJ23QBO+Xa6fk41a6h+mIx2/i8NLQQZ84+H4vVbwSa+eQIWCG8ZR/H9vqxDcfE+O7tgtH2p8tDB20f0YgPesBgeNMwThVj9pru3cxU7e8vltN3IDOhd45lxA90oBzpMzSj9GpBMsjWFdmn6hvdU+xmVWyba4JGZl/ATst8X6rgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755670676; c=relaxed/simple;
	bh=acxMMGd2x/HKWGU/E/B1l2IvWsTnQwauMXyl3r65/5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0wJDn2PFzntloKF4yqhnDA3O62se+0b6s6SGszMWnWysQU0TrYrZXq9/WiAje15gKKsa3W1FpwVGK78cQ93w/2ccXur187KdSrL+OYm8m7tUHj9dq8s1baTgtIp+IOThKjc9eudHLHqYzE7m5ixHS2cVup6vKd9fYyZOAe6WwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pPBJM4Ik; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1p2rF005901
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/bkq+cHdJt1KbvcxQfB2RcSUjegt/SMBaHSxlr5BbPY=; b=pPBJM4IkUCc7AjW7
	5WE+DTBsliH63oe2SkgY7IWE7ea6YBExexcpAEv4g2cxsh5z440YLP5GHikjCcRH
	sP78jWNxVbTnLOJNOYQJhHFwuLhbrNmWlEN3o4P76SDKg60VgeEDWN+6hfzRN9+R
	UDRivJivIbkejr8DpPcpRM4SK9Pg8fE+qJK7K5VCfy4wXVcBiKqZtni0wlqiGL2H
	Vt8SFuYzPGFv/ikxQrF2ToxtUpmv+bwgfSmXUs7hP5efZA9JD/pJTu7BINgSdaTw
	utACXgdJXiUw6cxSSPQZZ7pnZejbW65wLVwVY8c9qt2Di5ZzuokdOyuGxdn+lOQg
	KyXKCw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cgkr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 06:17:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244582c20e7so70541975ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:17:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755670673; x=1756275473;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bkq+cHdJt1KbvcxQfB2RcSUjegt/SMBaHSxlr5BbPY=;
        b=b0vPdUcBFYVEZ5AK2WyFCsCiM2fGbbXlj8fgnlkbEHoL0Ld79nEtF5mDpFWWxp+mjB
         wr50TEZ1SzI5n2GbngzDtJaWTvR8JSvUH7aiV3v4Ic3e1T4ZbsEAxXt8bWlma/k9CZDA
         NC4o4tvSkyvtq+peUPhhgsrwuMxT+TuXw5/Fvqqu9J+2XBW/wKhf6ldwSQVunEmfaqpz
         jm3jAcKD9T0/k+EuT6BqLYZzV+KX4wiwhdsoMhBWNDL9A2Jxz717DQOdq0+RiSJepB8M
         4TpYs81bzuxXhZupMNS7CniejCilpbJAExNX8mrxl+RXX83kVd3/ARiIcUltcmDwudqb
         hmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfgw6uW9WWwOwTyGExLoxEc/i9osI9SAIxHmInM69wM/vA5Hb4ey6TvZyr+kfKRNpIzERTTSqzlEnmgUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjsBm6ycwUVyTj2QNFoQVlzv2sDcGVsk2jBHUScjOypQAUe8+p
	PTliHi7txE3ZPH3rmHO6KHV6d19/cksGL0Vlv/9qwiKGbqGW6+lujUp4kvJqAZJDvrNadmW4KQM
	B1etIhEFyRdphIC3okU61dwXHQNkL/OaibhEiBc1JBmg+vI29axgwZWJJqou9oP9EuOY=
X-Gm-Gg: ASbGncuZizQQDPoS0vUjmiXwlKXruyYpD6OXvenOlhF+9WnXxZq+HMbmkJZ0Gs54mxt
	Y7S4Xrjv2prg0ThHvUO9li4RTp4NpN/mCGp/8fMk5HA7oExQKl99sVkxI6BsSPSH9TntVqFVNhl
	ZJwtDWD0rZsULvEvNEjwWVz0s4SUK+F78FjvTn0gTuEDa8TscL5mC2RCgWJnnDEVH1ayp7xdo3x
	CYPV6yjbtUjw6irxPSPRY7sFqKNBXlZa/7wb6OkE5BAa24V8Gg94UcBMIGdCJzKXtf7DBemjMDl
	pW9a5OJ3qD4pZAmOcnSV/wvCMeUzO1oHrosP0zw5DumknqU8xIUrL+5xbzfzp7qvSF5BHShh5+p
	jNHCnFBPoB2j8P3kR+3C0piyYzjPPzg==
X-Received: by 2002:a17:902:db11:b0:244:99aa:5484 with SMTP id d9443c01a7336-245ef22750bmr21232865ad.33.1755670672773;
        Tue, 19 Aug 2025 23:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsKwESvuXAmKPzOJGduohtMXI7XkJlUbHq5xijCZfUS3+Y+d26WTnyjnHki+tQuTQXR8vTwA==
X-Received: by 2002:a17:902:db11:b0:244:99aa:5484 with SMTP id d9443c01a7336-245ef22750bmr21232595ad.33.1755670672285;
        Tue, 19 Aug 2025 23:17:52 -0700 (PDT)
Received: from [10.249.96.170] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e8ab7b2dfsm2046761b3a.38.2025.08.19.23.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 23:17:51 -0700 (PDT)
Message-ID: <33468410-69e5-4144-88e0-cc34a736c0e4@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 14:17:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
 <20250819-glymur_pcie5-v1-4-2ea09f83cbb0@oss.qualcomm.com>
 <6zlydkdgmowqg7cv5eeoaf7mrpnhzokyvhh5xasvznqaxnhdji@xol3jiz2lzld>
Content-Language: en-US
From: "Wenbin Yao (Consultant)" <wenbin.yao@oss.qualcomm.com>
In-Reply-To: <6zlydkdgmowqg7cv5eeoaf7mrpnhzokyvhh5xasvznqaxnhdji@xol3jiz2lzld>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Lws_ZfFN0E6ncHHHCKGnlhe48VJDoKIh
X-Proofpoint-ORIG-GUID: Lws_ZfFN0E6ncHHHCKGnlhe48VJDoKIh
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a56892 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=sH0VmbEyIx9rPeTW6gYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXxFmz/Np3MHC/
 jUlPdDUr92t2R5QG5TIiDfWSNnR2gJzqtqINrBGnCk8SK9Qk3X3++OmfozAwGEYrP0V7ifLdrSN
 CoOdYvwxXv+ivbTlsvirfxQBG10quLf01WWc4iuWH8vG8OC2QeEvzLtxk2YbGEpwdm2oAGTkpOO
 9tl/Z/8i00zKokZrhMKRQw2Rr+YuwheBcXJpsvLQdm+zE8EpMo2x6ExchvHE3Os8nOXXSL+wv9d
 WwIxd421wC/2dsweE/UZN2WZGA/DG8NSYghGbDKibmf7AF8XYzsMKfJxMEsHsPkzYdBodFQY0hi
 vWUPgfaas5TPLbV+A559lcBWjZyxcnqXQXSn4DkEs67xOT1iQR17D6fRLWXnmYvhxuN0i+qc7d5
 gZJ+K+mEFi0ye+LMeBAdHZjzobdN6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On 8/20/2025 2:43 AM, Dmitry Baryshkov wrote:
> On Tue, Aug 19, 2025 at 02:52:08AM -0700, Wenbin Yao wrote:
>> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>>
>> Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.
>>
>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index 95830dcfdec9b1f68fd55d1cc3c102985cfafcc1..e422cf6932d261074ed3419ed8806e9ed212c26c 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -93,6 +93,12 @@ static const unsigned int pciephy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
>>   	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
>>   };
>>   
>> +static const unsigned int pciephy_v8_50_regs_layout[QPHY_LAYOUT_SIZE] = {
>> +	[QPHY_START_CTRL]		= QPHY_V8_50_PCS_START_CONTROL,
>> +	[QPHY_PCS_STATUS]		= QPHY_V8_50_PCS_STATUS1,
>> +	[QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V8_50_PCS_POWER_DOWN_CONTROL,
>> +};
>> +
>>   static const struct qmp_phy_init_tbl msm8998_pcie_serdes_tbl[] = {
>>   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x14),
>>   	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
>> @@ -3229,6 +3235,10 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_30 = {
>>   	.ln_shrd	= 0x8000,
>>   };
>>   
>> +static const struct qmp_pcie_offsets qmp_pcie_offsets_v8_50 = {
>> +	.pcs        = 0x9000,
> Even if the driver uses only PCS regs for 8.50 currently, I'd suggest
> describing the whole picture here. Otherwise it might backfire later, if
> we add offsets for other blocks later and they won't match the ones used
> for Glymur.

OK，will add them.

>
>> +};
>> +
>>   static const struct qmp_phy_cfg ipq8074_pciephy_cfg = {
>>   	.lanes			= 1,
>>   
>> @@ -4258,6 +4268,22 @@ static const struct qmp_phy_cfg qmp_v6_gen4x4_pciephy_cfg = {
>>   	.phy_status             = PHYSTATUS_4_20,
>>   };
>>   
>> +static const struct qmp_phy_cfg glymur_qmp_gen5x4_pciephy_cfg = {
>> +	.lanes = 4,
>> +
>> +	.offsets        = &qmp_pcie_offsets_v8_50,
>> +
>> +	.reset_list     = sdm845_pciephy_reset_l,
>> +	.num_resets     = ARRAY_SIZE(sdm845_pciephy_reset_l),
>> +	.vreg_list      = sm8550_qmp_phy_vreg_l,
>> +	.num_vregs      = ARRAY_SIZE(sm8550_qmp_phy_vreg_l),
>> +
>> +	.regs           = pciephy_v8_50_regs_layout,
>> +
>> +	.pwrdn_ctrl     = SW_PWRDN | REFCLK_DRV_DSBL,
>> +	.phy_status     = PHYSTATUS_4_20,
>> +};
>> +
>>   static void qmp_pcie_init_port_b(struct qmp_pcie *qmp, const struct qmp_phy_cfg_tbls *tbls)
>>   {
>>   	const struct qmp_phy_cfg *cfg = qmp->cfg;
>> @@ -5114,6 +5140,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>>   	}, {
>>   		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
>>   		.data = &qmp_v6_gen4x4_pciephy_cfg,
>> +	}, {
>> +		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
>> +		.data = &glymur_qmp_gen5x4_pciephy_cfg,
>>   	},
>>   	{ },
>>   };
>>
>> -- 
>> 2.34.1
>>
-- 
With best wishes
Wenbin


