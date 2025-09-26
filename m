Return-Path: <linux-kernel+bounces-833467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34FABA20A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 02:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1A61892F25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 00:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66D7DDD2;
	Fri, 26 Sep 2025 00:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTZFtog3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444BB4C79
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845677; cv=none; b=FwFHK3iXDIaVtHTRdu/IoR57iDnn/nEYGIUqeJYJlYUoBhjT8ELQ2gCNBeQyNZeBabOpEFj41mTFEif15glBDf2m/WjD6VLg/+1+eGj0dmnHi2eQ8rBoNcsYr4ecjlSVnYQvWH1cfBETEL6PqimFgAwMxqQiD3WXW9dFWr4FeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845677; c=relaxed/simple;
	bh=81r53nq+yKoXBaJ4jwvZf/v4iOezccpg3MNQTvV2+X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JS2HEuhnNtu5vDtFhWYvFxNYeHol/xMK9uXq3o2/qOsRCI/byx/YaIEpzwtY5ChyJ8PshRLk8+TSz49F6jz0YkPG7ZffQjycLt7CAMwz8ouZzxeJURWmnUjDTlDOSTxqlOEf6Yg86hRCss8cJ0SGtMrq2ZL6gKNY35NF0RTSaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RTZFtog3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIPpof000869
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y9aVQL6fEAcMEMTP9D/9Z6oTfy+cY28XMdggMyG2w/o=; b=RTZFtog3ulZxflRw
	CVYRks4Vr+AFqtvRb2kti29vCk19UwRstvMPlqFZakQgnHKJBcKuBm2qEEB+n1bx
	ikU5b8JQzPbne7dxrVJXIAlC/PUDsjYrZYkx3LKq8HNvf8UzsfnTLVARh4ehBetw
	Vs0WmegRNIP12xSGOqMJqc64YMhV8EvldY0JoaRdJaKRdrJDgVIUcCfQ1cCihINt
	h8247sc7y7UiTy7sKudy8cFnTkckARR0QwyBMGo6GBOYX2piLZEo+xaKiOI3iioW
	QCTH2+253rOeFFlqMcpFQEppiPq0B0OaQ33xaCrs7mgX3QneJs4ajd/kN6yF9cIQ
	CKRnCQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0trrw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:14:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-27c62320f16so18165025ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758845674; x=1759450474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9aVQL6fEAcMEMTP9D/9Z6oTfy+cY28XMdggMyG2w/o=;
        b=IGmideb8WbarSEUL6UaNiCR3veiWjD9B19DmZzrYn33/5HGGw0EhvawEd3AcNqUrgC
         RW5CtV8MG1XY1D8fmvdU48oRZJbzw9yQllj41Qa+hZo0dCQm1HUbj+Sh/kn3h3714W6k
         3NN38fBMX+WYKBNwwt92mpRFPD6cYNzm+y9KvXE6m3ajoWSYK1yTlXSHsk9jEQBUqcRN
         Vhn1mk6JG+SShwiplMueVr5DVEC/qGPKhLDhdd8328tH62epQMpZOIzvlXnshwjmPo0+
         8LG1SjGno2iQPWrljeyrj3zQk0m33FEKFAAYsj5ZlAdessj8uYxJIKh5sKgjBLaB1l/3
         Q/iA==
X-Forwarded-Encrypted: i=1; AJvYcCUeA3mtTEu+BSj85q4utznz3BLYGW9gIUwAPdwdTj52jd6rMUy7WDnwxwyPxeQigQg3dEQ99+SIigFLABs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQAFgO+3tzMp1SJdcPjlOrYuWoW8MzxAhFAC1sInpadwX1wph
	354nmYP1MyzQ84fueq1o8fyke1jKdnz4ddSns6MOjIyGpmOlG8CYs71gyvCfdbB8DrR4zyuaU/E
	l64haZu8ySKrfsQd6bnZhInf/oVntdC4scblIdhRimU3akvf1INt95Yk7hM0hdjSzAGE=
X-Gm-Gg: ASbGncufXTZGDXq7meHhXHnWjDn0YZkr1qzcSehHMBMaSUSQLoMqLzcUAG4eQbNTH/e
	HNuYyhtfoVQaj9Bq5BoD+DGVuyarjTgL9wPCTEmuDlcxB+FOa/nNZR3LurGHnoqFQ8YJO1wJXf3
	yNxCPqoYRpIp+87RRl873we70jKAUf6lIPwVdfs9tX9l01mE0xMPSUKtPWSZcvI18G+9lnn4bSr
	w4z33VPYGJIClruPMTt0XBirRWrwIQ5907o+aDmCn6VeTgymTr4ogvmQ0BQ6dFkQZyNW/FYKZfn
	pFtwlPS46nWmne+DgSj7bTSbv+3dTCMLIJAe7wJH26AsCHp7ZMah/YnIqVNLWl5pUGTgk4qAtvR
	M100wRVM=
X-Received: by 2002:a17:902:f544:b0:246:7a43:3f66 with SMTP id d9443c01a7336-27ed4a06c04mr62262985ad.7.1758845673482;
        Thu, 25 Sep 2025 17:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6RS0Z+VcLwtx06uS7E/LrV2b7e5WIQiC7s7bIX/lu3xtr100NQaYggwOJ4VVgTNHsEDWRcg==
X-Received: by 2002:a17:902:f544:b0:246:7a43:3f66 with SMTP id d9443c01a7336-27ed4a06c04mr62262565ad.7.1758845672931;
        Thu, 25 Sep 2025 17:14:32 -0700 (PDT)
Received: from [10.73.53.199] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cf181sm36713155ad.28.2025.09.25.17.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 17:14:32 -0700 (PDT)
Message-ID: <5e9e2824-923c-1328-dd7a-a8b496c44a70@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 17:14:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
 <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>
 <oecyjwj7ouufjbiq2fpvlhhuaof5agm22fdsruf3ppayiu4kkm@wvi4no53x64y>
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
In-Reply-To: <oecyjwj7ouufjbiq2fpvlhhuaof5agm22fdsruf3ppayiu4kkm@wvi4no53x64y>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I9Vohdgg c=1 sm=1 tr=0 ts=68d5daeb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=INxguLwuHvTa_v7rZvUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: ujn2MMX3222NxS3pSwc4M5lxMNVZQsjY
X-Proofpoint-ORIG-GUID: ujn2MMX3222NxS3pSwc4M5lxMNVZQsjY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX5lAFx6z7J1pP
 q0SOUHMx7v8D9mNDgWX7j5iaRFCjse5S6XL8WaPSLPAUDQ25fa4YzhWKQKTkGlLz8dpsClwb7Kw
 vyJqIJqeXQVbRkHj0OqslZGnrum6hFcpOQ+hkqDZIfIT4dLgx9AMMoutI6GQe2OJVJ3amnqVUsH
 tYuM1+CIJvYrMnZxEjmgXxFjbInrIuXokS9jGrl+u0vUABUV3UY+40F8FGMzXTBRoQUV1xtRzcP
 3Tf28jefojft9vdlIifxe5orn5ahZMKokAeC1j5J7vGp5KDN2Hl89vX7yV79+6OMKdavxdZux8y
 V+sRMJvBKDp/t+JFkRckY7C7VJp7BNG1Qwy0sIfCA3tbJKPYy6JLh//v0UhvHQgAy3LTmKQf/1w
 f0bDQmUbDG0vRriFmTyAzA4D/I9/ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171



On 9/24/2025 7:54 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 07:28:47PM -0700, Wesley Cheng wrote:
>> For SuperSpeed USB to work properly, there is a set of HW settings that
>> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
>> these settings follow the latest settings mentioned in the HW programming
>> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
>> new ways to define certain registers, such as the replacement of TXA/RXA
>> and TXB/RXB register sets.  This was replaced with the LALB register set.
>>
>> There are also some PHY init updates to modify the PCS MISC register space.
>> Without these, the QMP PHY PLL locking fails.
>>
>> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 311 +++++++++++++++++++++-
>>   drivers/phy/qualcomm/phy-qcom-qmp.h       |   4 +
>>   2 files changed, 314 insertions(+), 1 deletion(-)
>>
>> +
>> +static const struct qmp_phy_init_tbl glymur_usb43dp_pcs_misc_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_V4_PCS_MISC_PCS_MISC_CONFIG1, 0x01),
> 
> Why is this V4 all of sudden?
> 

Hi Dmitry,

Will fix..

>> +};
>> +
>> +static const struct qmp_phy_init_tbl glymur_usb43dp_pcs_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG1, 0xc4),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG2, 0x89),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG3, 0x20),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_LOCK_DETECT_CONFIG6, 0x13),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_REFGEN_REQ_CONFIG1, 0x21),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RX_SIGDET_LVL, 0x55),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_TSYNC_RSYNC_TIME, 0xa4),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_RX_CONFIG, 0x0a),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_TSYNC_DLY_TIME, 0x04),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_ALIGN_DETECT_CONFIG1, 0xd4),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_ALIGN_DETECT_CONFIG2, 0x30),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_PCS_TX_RX_CONFIG, 0x0c),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_EQ_CONFIG1, 0x4b),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_USB43_PCS_EQ_CONFIG5, 0x10),
>> +};
>> +
>> +static const struct qmp_phy_init_tbl glymur_usb43dp_pcs_usb_tbl[] = {
>> +	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
>> +	QMP_PHY_INIT_CFG(QPHY_V8_PCS_USB_RXEQTRAINING_DFE_TIME_S2, 0x07),
>> +};
>> +
>> @@ -1667,6 +1899,12 @@ static struct qmp_regulator_data qmp_phy_vreg_l[] = {
>>   	{ .name = "vdda-pll", .enable_load = 36000 },
>>   };
>>   
>> +static struct qmp_regulator_data qmp_phy_vreg_refgen[] = {
>> +	{ .name = "vdda-phy", .enable_load = 21800 },
>> +	{ .name = "vdda-pll", .enable_load = 36000 },
>> +	{ .name = "refgen", .enable_load = 936 },
> 
> Is this a meaningful value?
> 

I need to adjust this value.  I just want the load for the regulators to 
be in HPM, and after taking a look, looks like based on the rpmh 
regulator table, I need to be voting 35000.

Thanks
Wesley Cheng

>> +};
>> +
>>   static const u8 qmp_dp_v3_pre_emphasis_hbr3_hbr2[4][4] = {
>>   	{ 0x00, 0x0c, 0x15, 0x1a },
>>   	{ 0x02, 0x0e, 0x16, 0xff },
> 

