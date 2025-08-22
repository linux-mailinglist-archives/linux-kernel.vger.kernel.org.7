Return-Path: <linux-kernel+bounces-781405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD4FB3121D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771DB568E58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985F42EBDEE;
	Fri, 22 Aug 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="axp2p5FV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD9C2EBDC9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852204; cv=none; b=i3cyVZ2dSFQJ2uRyNSpZUuBNvsn7B2Lww7X8nGpB5/mnhgjAfu4i5KiSfIgl2jCZed015eKtjrzhKGZNJOTsVUYKVEMhTdn6SUg03jzVGy3lGU79uCCkKRTb2mrgVLihbtItgj79djQQ7hcsyOccqI60RXQ9/CubBMP63Zf5skg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852204; c=relaxed/simple;
	bh=R5q219oQSBpeOcalKWFQBiSMO34ZKgzRjyeY80z0OQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZMoDDjc8tBDzPwhn3DnpuC/VxqA4Z/bljY3krFA6p+HcDUjVxaoKhDezr4QdKjLvWrouIQB/QH8YcbHy92+qEABY+xDIzwF9LisYA9J6nQYN3Q3h4Kv1tRB3NQM+DxzXVjrQvxbRogEsW4CK6DAF8dpa4SVZj8mozDlON1Qz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=axp2p5FV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UJ0g005615
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	prp9ElU8fS7+zbL7ub2mUXEAEbk0qpOcYYPRR8CM44Q=; b=axp2p5FVzEy9YAcS
	QpKxjbGkrARU1RbimpueVhli6iCQEpUDyqcg494lAA22Jsblt0Th/sBfiscGIE69
	1cMrxA9iLjFC8wqeBW3j+iVi4qMr7244u1I2nLm0h8ZcHGhRtGUE91bywbj+wAC+
	dS1OXqb5MHjUQgLEWmycT0onvSSvjEhCGo3MvcxRyatfJNxu//k0NhgqtqE48r/o
	IQxgsdFIhbVJrbr+U3VeiDUKJ6oh2ETrWciK8ez1kn1/YDad6B5nZdZUNVYnfMn2
	t4hhYkryc5kLI8EpPH6r4NFTYV4FS6Ojkiu8Keq4erueicN48lcstEy2lB1MfY/4
	iGR/rA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52drek1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:43:22 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244581a191bso5000875ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755852201; x=1756457001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=prp9ElU8fS7+zbL7ub2mUXEAEbk0qpOcYYPRR8CM44Q=;
        b=mPRitkLvdrHhJCWyZuxlCBdczNIe+9Sqy5hW0oS8/VyB6zXirLFhZhPB3ahP9FEc0T
         sC40V0YpkarWGWqRnZzc5uPyuZjX4RtoEaKrxkg0FAuu3kKlsm5+EzNJCFS4skoJEGx7
         L5nyK3vzZhjSmIX3/b9A8RNWgsfiprCQsOcHLB7kM4utaAPyRhLGBuveYij3XTp8Xb4r
         qwi90MWORyJuf3XcP3lxKJInLi7EF6MBU0Vckk+hoBi9yvmm5n6Lh8nunWInN1uBEw6s
         nrewtBZSHLn80pJ3Zs6rRKrPRpH2BkMnf5SF49w4cUxxJKpGOEPgzrGL9PC4WjiDZI8h
         IcGg==
X-Forwarded-Encrypted: i=1; AJvYcCX9oc6Rmlz9IAFcJJ2sO6YOnZ7/rPjBI1SOqvOOH1U7sIsqifr27Wzdv1Rse4NpVX94p7/pgdnTg3ti5xU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuoTk+zYqusjxNG3xS0B9UnuqA6eWWjP15lKqQv1Gqi4ov+Kq7
	NlZxX5pP/mQyqTaR+7QE6hbTa1RN1naR7iGC5EU4kt43KW5rFk+WdNYI7ho9sV9sO94N3o8lpDG
	DCbNcKyLB7gdFqkE8KJcf3aWat7xLJGqgdsSs8N1XjQcOLdJGmrhhpHSZrwptk7b1N2o=
X-Gm-Gg: ASbGncuJg6NNF67/ljKiKyn2y+3VPCC+us3o1Bk7V2TqUo4SBT34lJyV/HbTDU5x62I
	Q2yYnGAgF/rx3ciWFLk1Q7XCa/iQqmnDUGTHi2uFGMErc2HMNNOqsV8yy8vSqiOIo9vlvXbIquE
	Nx627XbmZQLNIAtFqJcsTtV4baTwHd3JkRa3KIGaT3sdo5BcOiM/Nq9C1taXD3MzOE7BfU+cfJy
	xF30ehR7SYcD4UOAF8ZJFaHYCI8Hye5NTaNCMiXc3YHt+8DzQdOw6SNIhwzdXJHaeveSImv0uBw
	BlAein+ZSrXntpafH7muwdp1zAG0WXiVocArK7ideXRUaRT99By4fjJWzpZh+XSaV6K1XJL1Vgf
	mmg2iSVttIK7bJRrBP8mIkmIzQGDiFw==
X-Received: by 2002:a17:903:1d2:b0:240:3e41:57a3 with SMTP id d9443c01a7336-2462eb662c2mr18144915ad.0.1755852201141;
        Fri, 22 Aug 2025 01:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEXolhUjPQKDUCRG284FJEb8zvrf0fcnVfDTTz3DHtqN0qA20e9P4wmEWvBmU3EEicTDFcdg==
X-Received: by 2002:a17:903:1d2:b0:240:3e41:57a3 with SMTP id d9443c01a7336-2462eb662c2mr18144665ad.0.1755852200709;
        Fri, 22 Aug 2025 01:43:20 -0700 (PDT)
Received: from [10.133.33.119] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c7588sm77576235ad.101.2025.08.22.01.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 01:43:20 -0700 (PDT)
Message-ID: <2e3c1559-7da2-4c6e-bcef-eb1e8dfd4c31@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 16:43:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/14] phy: qcom: qmp-usbc: Add DP PHY configuration
 support for QCS615
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
 <20250820-add-displayport-support-for-qcs615-platform-v3-8-a43bd25ec39c@oss.qualcomm.com>
 <su3zkeepxaislh6q5ftqxp6uxsyg7usxmc5hkafw7yn2mgtqeu@wua72odmy7zp>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <su3zkeepxaislh6q5ftqxp6uxsyg7usxmc5hkafw7yn2mgtqeu@wua72odmy7zp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5bJEoU6TDVb3
 UgFYixanVDk3woIjiiTb1MlfEGw6AI9254naAWktyfntgAMrZ4xSDGO0M+F5CA/btRrXxqnJTj6
 8PWU7hXtqC8Iaa9/3SBr49sbJTx1Z/ykSz4EkzhL8hSMbQTHo2sVsf7uqq2eHbZ1CrxTJBbIC86
 LDa2krpQtcYV3HTzXdNXe4X2B6I8J5LjxPOpg3/haDRes3hC6TDmuB/JqY8ISPtCjV4wNrTs2MY
 GVw3WpWnbBRUWVO8b9LlG8+9p8utEt6c4dogBalsQo6RZLpku4ygOKAdSFzHf71KRhESq0taBDf
 kiXCe60l/M9JcOjK1gIGGPxokrcl11iaJncqTjSwvNnoruNcl8lmW8Sl9aLuQga9lXfSCV2cLaj
 YSdHva668UsDden9o0RI4OtZMgJM2w==
X-Proofpoint-ORIG-GUID: UhqVwA8__uM_Nc6I9jAq9aRApGCDPZA3
X-Proofpoint-GUID: UhqVwA8__uM_Nc6I9jAq9aRApGCDPZA3
X-Authority-Analysis: v=2.4 cv=SoXJKPO0 c=1 sm=1 tr=0 ts=68a82daa cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=B0UfJI3MrboyiCAuw3UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013


On 8/20/2025 7:16 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:50PM +0800, Xiangxu Yin wrote:
>> Introduce DisplayPort PHY configuration routines for QCS615, including
>> aux channel setup, lane control, voltage swing tuning, clock
>> programming and calibration. These callbacks are registered via
>> qmp_phy_cfg to enable DP mode on USB/DP switchable Type-C PHYs.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h |   1 +
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c   | 251 +++++++++++++++++++++++++++++
>>  2 files changed, 252 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
>> index 0ebd405bcaf0cac8215550bfc9b226f30cc43a59..59885616405f878885d0837838a0bac1899fb69f 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy.h
>> @@ -25,6 +25,7 @@
>>  #define QSERDES_DP_PHY_AUX_CFG7				0x03c
>>  #define QSERDES_DP_PHY_AUX_CFG8				0x040
>>  #define QSERDES_DP_PHY_AUX_CFG9				0x044
>> +#define QSERDES_DP_PHY_VCO_DIV				0x068
> This register changes between PHY versions, so you can not declare it here.
>
> Otherwise LGTM.


Ok.

This PHY appears to be QMP_DP_PHY_V2, but there's no dedicated header for it yet. 

I’ll create |phy-qcom-qmp-dp-phy-v2.h| next patch and define |VCO_DIV| and shared offsets with V3 will be redefined accordingly.


>
>>  
>>  /* QSERDES COM_BIAS_EN_CLKBUFLR_EN bits */
>>  # define QSERDES_V3_COM_BIAS_EN				0x0001

