Return-Path: <linux-kernel+bounces-781242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E49B30FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E360AA0152A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C0E2E5B15;
	Fri, 22 Aug 2025 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ft3q6spt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7362E5404
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845998; cv=none; b=qDlAi5RQaYo+1wZxlLn8xV+y3Aoe298+sbdvvj2sBC5L6MOHm/oYMTOT4CYncZxyOJ/S6+QJ7zWvINFreb2vC0+fzlYLTymmE35P2YwQfrAFdK2/tjUYmz+g1qsrN+PmcUyhlpqRJuaBW1bq/VD5dbzxkXKhrBLsIydIiKosTPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845998; c=relaxed/simple;
	bh=Lk20aKQPIVL6r16bt6tNOCbWihMefXdn9yhsskDmCEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aH6r+GWufrid4WFyG+faSqWqCNzo1MH+o0LzATJscQTH8wqYYo5wlBnhM9qZSIXU1DNCzWKnQS0wfFxLDVsW791XZhERX5IaDh7DAfaG6R9sy2WbWGTzrxu1EcOMmtTfM/BZIvSzvM2tK4E4T/ztr2C3KZCAziTSGCBUPgYcagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ft3q6spt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uTtE029486
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EvRSbSH/VoxM+9jiAgdHngTIpfLu8E8u5BFgwRNDeYw=; b=ft3q6sptkCQgZIvH
	X+ocxL8DKw1LaFTCRH3oXovsqFPtM3ECG5jSdO54qhWumdGzaRLc7txUhlWo0yM7
	p+nN1PDK+sXom5BuVh3bWH/Oo7eGNFh9BtOmVlah9L6ZCCiHutHN+ZjyNPzvziRq
	B2m2l22Z2d5rhjbKAF6UmL4yOGKXezMEoK1FkhaQpNP3zHx8Scz5bVbQJKSHrjtJ
	gmOFSdH/Ld7ddVIMKD5ZXaKgrSgTc9k0Z2GRk7FBJgakxKS/Nv7btUTN03hofBxE
	/dN99Z0whu7VZniV4GPrDK60bbtVHdKoZUWqLC3WgZbqt6boEWZRdXVA8yPN4YIK
	Qae0FQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdp080-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:59:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-246151af3a9so3426725ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 23:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845995; x=1756450795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EvRSbSH/VoxM+9jiAgdHngTIpfLu8E8u5BFgwRNDeYw=;
        b=Y6HI4h2jI+nd52eKVHgDUS+IBuRld7QMfkcozBYLh3/Qq0ODXd30zpyn0T2/Yg2KFH
         XoDcRspxtVT6jAWADJq3cVaiHwLVVlBiHPYSY3wPdlfJ2ZcZ/zHus6oq60dpnXlrtYVV
         +pJ7yPW0NZanIFuZ2mMTZ+dG3WF3saNhOiU5JbIqMhECgMPZ3AnkfD6hccVUgdN07w6m
         woFhJhQ4QjkgLFDh2O+20IizT6pxcBzd9aUdhMVmDT6Hb30s9GSbTvLDjnw5UrOHWQXo
         09FCB72Fhtfms5O/KPjDWRcUw/E/lGSWNBya+9PWd799bmRvQBgOv94Oki8No9zrA6zq
         Q3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+23BM/lx00vnlhZtu+mOLThsfmTn5EeuB2RczBHnPGxcAHpmY1w34tPzZOtTPlGD3s8fHIef4WVdgH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4h8UjXa1Cd1EOIcj9YxF+CuNL0ioRqvboHL5uX6ingxGH2p8p
	52ilkqWFkMtf8VCAL5JL0b9vAuCE5ZkzrHxEnIYvc+CX56hzPu2olgkdZrY0kafNrJCMZFeRW4R
	nlU+/LWqtwnP8WEuvsnxuEw/GzHwXIMKD7z+6ImHialDGqERPgbGSSkGp5HUdpAvaDKs=
X-Gm-Gg: ASbGncto1aBb8pCYc6CPLTCPrFp3jgXd6mxS2GmUmhU9vYzy9gUu+5zIpFZJV6jBZcS
	0GuVTUUkITA8dL1mx1W1c/pM2gcIu1zUmdSCr+KUJho/j4tLcbRX6D7+3LzKWHCWyzt2lADSbTf
	wAGDTjdfN48usLm6tZCrHFAauLTnYrPWKJLoDp0eR402l83vuO/XVButEgBF5j61CbF5AxFne57
	UuzYJSad5WhGKLhGQZYZ7EBj9DtCYmkG0xAdR0Uvqx/1nmLzEk78nfIxReQhnIPpHTslj7KOuhS
	Wg3Lk9rh3f6Joxa9VjVLjnBFyrqghuKS8CsKeK3Zwg0qh9ik1GCIxTcTY+BOn54aL8sN0wKhKS3
	dd3Za3G8a7T9rdJ/lWJ+wDurn7JrBuA==
X-Received: by 2002:a17:902:e74d:b0:240:52d7:e8a4 with SMTP id d9443c01a7336-2462ef4956amr15460035ad.7.1755845995312;
        Thu, 21 Aug 2025 23:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuEJR2wzIWQjgd8kotlnM7HkI7wYOwYms8taKFwN/LIJRGxlF0bSt7nWjIb6zaFE9ywZO9Uw==
X-Received: by 2002:a17:902:e74d:b0:240:52d7:e8a4 with SMTP id d9443c01a7336-2462ef4956amr15459895ad.7.1755845994827;
        Thu, 21 Aug 2025 23:59:54 -0700 (PDT)
Received: from [10.133.33.119] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed50352esm73974115ad.128.2025.08.21.23.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 23:59:54 -0700 (PDT)
Message-ID: <8922ae6e-9be6-49f7-ac84-d4a1dd60421b@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 14:59:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/14] phy: qcom: qmp-usbc: Add DP-related fields for
 USB/DP switchable PHY
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
 <20250820-add-displayport-support-for-qcs615-platform-v3-5-a43bd25ec39c@oss.qualcomm.com>
 <7b6utbnibia767bp55vhvg6ghdavb66ubdpabyguohuwtmz3mp@unvm36jttota>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <7b6utbnibia767bp55vhvg6ghdavb66ubdpabyguohuwtmz3mp@unvm36jttota>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a8156c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=S4zsw1PvXi1YseiIK68A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: UyIgUQjbOZV4TfMzt6JJQPHlu-e8lXFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfXzK/bMWG7eW6j
 Fl/I2o/4YGFhfx+08OjiRb+mwVwkmkuj3JhMlLcyglACJnQHOQDLKt0lbrFJYbXFqO1twl0H/0l
 nNaGTmBNUoz5wpy1dr1EPMEiRVzoWQrTUysX8ScRAY5P/UBCj8I52mJiYcsgjs5Kpt9HLBOjhUj
 IVTXlhz5gEU95wBk1hE0mzLUIqBTZ5e5pILEaCqn9Gz1jGuUX38K8pxUSmzCXO2rqL/7tYw6A/W
 UgTTQ1ygCHE5OCruXss6KezQRMqdN61wm4zaIbsZGWItpFH5kBOM7mGkLHXe9z/wU5+Lmts2cx3
 LxOzExmySgPWqzsQAcFi1HIAOe9UTOMFh8w1yHoMnlb3AHDJfuq7sDByGuJ10uGRAe0KsBYqZNq
 hrWoy0DS64tlCpKQiIXMqBQaNjOvbA==
X-Proofpoint-ORIG-GUID: UyIgUQjbOZV4TfMzt6JJQPHlu-e8lXFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135


On 8/20/2025 7:47 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 20, 2025 at 05:34:47PM +0800, Xiangxu Yin wrote:
>> Extend qmp_usbc_offsets and qmp_phy_cfg with DP-specific fields,
>> including register offsets, init tables, and callback hooks. Also
>> update qmp_usbc struct to track DP-related resources and state.
>> This enables support for USB/DP switchable Type-C PHYs that operate
>> in either mode.
>>
>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 73 ++++++++++++++++++++++++--------
>>  1 file changed, 55 insertions(+), 18 deletions(-)
>>
>>  
>> +	struct regmap *tcsr_map;
>> +	u32 vls_clamp_reg;
>> +	u32 dp_phy_mode_reg;
>> +
>>  	struct mutex phy_mutex;
>>  
>> +	struct phy *usb_phy;
> Should be a part of the previous patch.


Ok, will move usb_phy rename to patch 'Rename USB-specific ops', 

then shall I need drop the |Reviewed-by| tag in that patch since it will change?


>>  	enum phy_mode mode;
>>  	unsigned int usb_init_count;
>>  
>> -	struct phy *phy;
> Similarly.


Ack.


>> -
>> -	struct clk_fixed_rate pipe_clk_fixed;
>> +	struct phy *dp_phy;
>> +	unsigned int dp_aux_cfg;
>> +	struct phy_configure_opts_dp dp_opts;
>> +	unsigned int dp_init_count;
>>  
>>  	struct typec_switch_dev *sw;
>>  	enum typec_orientation orientation;
>> @@ -874,11 +911,11 @@ static int qmp_usbc_typec_switch_set(struct typec_switch_dev *sw,
>>  	qmp->orientation = orientation;
>>  
>>  	if (qmp->usb_init_count) {
>> -		qmp_usbc_usb_power_off(qmp->phy);
>> -		qmp_usbc_com_exit(qmp->phy);
>> +		qmp_usbc_usb_power_off(qmp->usb_phy);
>> +		qmp_usbc_com_exit(qmp->usb_phy);
>>  
>> -		qmp_usbc_com_init(qmp->phy);
>> -		qmp_usbc_usb_power_on(qmp->phy);
>> +		qmp_usbc_com_init(qmp->usb_phy);
>> +		qmp_usbc_usb_power_on(qmp->usb_phy);
> and these.


Ack.


>>  	}
>>  
>>  	mutex_unlock(&qmp->phy_mutex);
>> @@ -1106,14 +1143,14 @@ static int qmp_usbc_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		goto err_node_put;
>>  
>> -	qmp->phy = devm_phy_create(dev, np, &qmp_usbc_usb_phy_ops);
>> -	if (IS_ERR(qmp->phy)) {
>> -		ret = PTR_ERR(qmp->phy);
>> +	qmp->usb_phy = devm_phy_create(dev, np, &qmp_usbc_usb_phy_ops);
>> +	if (IS_ERR(qmp->usb_phy)) {
>> +		ret = PTR_ERR(qmp->usb_phy);
>>  		dev_err(dev, "failed to create PHY: %d\n", ret);
>>  		goto err_node_put;
>>  	}
>>  
>> -	phy_set_drvdata(qmp->phy, qmp);
>> +	phy_set_drvdata(qmp->usb_phy, qmp);
>>  
>>  	of_node_put(np);
>>  
>>
>> -- 
>> 2.34.1
>>

