Return-Path: <linux-kernel+bounces-842792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C01BBD9EA
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1D66349F36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7E2221D87;
	Mon,  6 Oct 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YfI5ule6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D721FF33
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745309; cv=none; b=W0Wu13NmenXhCx/QLCkh0hEAcAb2kGLiOOpx96dGkcjqx0B08XvmSXVvFQrV8q/k85wbKXbh3FOYKMXpnkRbtkMJYZflnzRlt8f43k0fsiCos/ZL2IA17WFSJWYNWW/epQhFfZwc5VQTCDJH55WNUjWbUTb/6yC2WPpm6aYD6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745309; c=relaxed/simple;
	bh=rrCYAYkIIKFxZzj6px2XfJmTeYXc7E9PYfMHKcIzPW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKlb7D26l0bx2yFfpL5ZLukcDgY08a5futxeq2mr5+HxYQl/2sXPz8X2CKRNFjhiJUYSxB6TyMWThw1F+B63mVYjWn8q6/DYVg5f+Ux9kj4iYmG8aZIB/0rnY5mYAveAiWJM04o6TcdZBuTIZ/qL1rd5TDwhWoFrDhBDlccG654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YfI5ule6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5962dl58004643
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QRxl7sNo+3DrrqfT4zz8oVLcU0vJGKPO1RsVS+CbIJY=; b=YfI5ule6kP9JUqOq
	0V/aCsHHGfHDFgLPWiT1BFjvA+8l+1xEg/ctS3i2cfNI02OmWr79FINs0Gno9zKj
	4cd5/aUDM667tNjkUpsYHgR27f+SWOWeV1Kge3Go5an92KPh9RfDNJ0/4OPYwaZU
	Kf98yaYEvGnA57SZTC6DeneYK6E2NMoAr3vFri0t3EIg7qGrDBnKnmIleLdJ1t0a
	e8i5wDGJhkCrZ940YaV9yVQxVTXudAiibMi5HKgr0wcsBoOjTN01eCSycVdO3TMn
	Eao/YWyzXKwN8h3F8ktg8U6Ro7lWSttMiuxcZuBLFumk8THQ8JjCaID/s85kvio2
	T8EumQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn3s6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:08:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85696c12803so205760285a.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745306; x=1760350106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRxl7sNo+3DrrqfT4zz8oVLcU0vJGKPO1RsVS+CbIJY=;
        b=h2CoXNtdHD9GehjSuyi0VSEnm1xQ4cot8s6vNFKWNuj47GYDvwnt3Y+1fbv/Cu962+
         zPjfGgSJpJ1XRzaMdGlMWw+AdoJyepcQpySXB1azFe3/SLbpS0DnCjbklOH8CXOfTwJg
         NqdA/oGKAh16kPJvQMXuP4ZRvo9U3gWvWzQGN9Y4gw+A2sO1VUAnfSoze6GmEnT6Ebvk
         4aDlyEAvfKMMlHHJ5teaDvjycP2y6TTmnYOhy8xY/Yk2+nBAYrZNw4FITWG3Fzmtq9XZ
         BK1KVI/+19f/T3WmORhhLNvk4NB4966yuRyXoyra+LXLMAGBJhtKYdFaaFdItnOsKcmz
         9nRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+8lwFVDdykDvw+Vrt+mhdWGeXMBgtTMHBXP0ZvJNchUrz4pxU5b5Z1D+O4uVoaFeIynN9juRvAjvXNpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSOkv0lwZehtRAvCn+QCdgmWEJtZXs9HotW8p1Dnaju9L+xtyw
	hgHM2TDpPa34V9IjCk4ps6O8+j4AWoLvbQnJ/Zib+ol238a0NHciImn+nofaDuOXfbaWrXnLIYx
	Kggo+u//uRXPJFqAwjy3BRFyRDWqxa7hW89jXMwn/rBfT4zkQV1WTh9OrpK5bbgPfnevQB9tcRI
	Y=
X-Gm-Gg: ASbGncuB2QtVZzOp4tg1HwBWkvD3Q/AVtHKLVZjRI8SNXpc2cgqLzkIKGZ/BxU/ErqT
	L1+b/j6ySSEm851XmYNA2IREopr2Se1QeCovNEvbqoZqgsb/5gdboO3ZEAJKs5GGzJQsMQw15iA
	uKRVzO6bi2qRuRk5OXAr3RJ7DnBcP7POo6PNG2mbF9Is7jJJwMlfFBaXJ1OkkMJvY9P2HzvbHV4
	XOeKiNDRDozqWRnH2H5EzzawoRQznvUwMWMKoz//44jMZ1RtXFvgQSw+v5wB3d+Iyj0SDafWjM7
	cssQe2Cdvww3nn0DNX/SxomQIe3pNkTLtF1qwX+4jtS2GUuQ+JLo/0tF1xMu/KaTSxHX1ySTGii
	1pfiO1i6IyJctn7fJwgf387bbk70=
X-Received: by 2002:a05:620a:4546:b0:85a:dcb:a0fc with SMTP id af79cd13be357-87a3808f27bmr1139715385a.13.1759745305955;
        Mon, 06 Oct 2025 03:08:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFimCYf0SKFbzC3NSXsI5tRolyrinxggfXfZDYyrYmKlPpBtRE4B1n+BKu5V1NHf8AkVOgEQ==
X-Received: by 2002:a05:620a:4546:b0:85a:dcb:a0fc with SMTP id af79cd13be357-87a3808f27bmr1139712585a.13.1759745305366;
        Mon, 06 Oct 2025 03:08:25 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b5acsm1107908066b.60.2025.10.06.03.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 03:08:24 -0700 (PDT)
Message-ID: <74446713-15a1-4706-b3c7-801724467575@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 12:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] phy: qcom: qmp-combo: get the USB3 & DisplayPort
 lanes mapping from DT
To: Neil Armstrong <neil.armstrong@linaro.org>, Vinod Koul
 <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Xilin Wu <sophon@radxa.com>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250930-topic-x1e80100-hdmi-v4-0-86a14e8a34ac@linaro.org>
 <20250930-topic-x1e80100-hdmi-v4-2-86a14e8a34ac@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-topic-x1e80100-hdmi-v4-2-86a14e8a34ac@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX3Xx9mZTX2zzo
 9vwFl2I/jtA+SzKJEDjxCrcMZNqWzobtdMLRfngq25qHVqFT2w7TKq8hx9VYLDVrHz+tNR5q0/C
 hTJROKZXvV0HLzkRRAoWetdcZKo97wg6Y7tFtGSLu/pxHsPM9thTtMnjXy/TlalG6ibtBfWCfID
 zwippUuDuL4Ko6NTHYnDyB9gx3wvYtUYJedS+TWFvZyH4l7E48dMXhsHRMQWApZrN5dg/0WvO9q
 /4N23cL/lu4Z5oytXDiwFiADgUxBbNfLC2gqRrRZCjKkq1tX47qXumn7ktt5dWFqbmnFBYOajvt
 sedSOkyouOnC2wCsh7rzgISQ2k4vDenvVuyN588TDjLmFPdnr0XYps5nAOxcy805eIjAbeX103u
 T55Vwln+OMGCQ6rYueu3WbfuqndIlA==
X-Proofpoint-GUID: wf1QrHuSM4cXl1bFm940uPIJJNKo2neb
X-Proofpoint-ORIG-GUID: wf1QrHuSM4cXl1bFm940uPIJJNKo2neb
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e3951b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=eg4Xx4S7Erm8exKiWv8A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 9/30/25 9:39 AM, Neil Armstrong wrote:
> The QMP USB3/DP Combo PHY hosts an USB3 phy and a DP PHY on top
> of a combo glue to route either lanes to the 4 shared physical lanes.
> 
> The routing of the lanes can be:
> - 2 DP + 2 USB3
> - 4 DP
> - 2 USB3
> 
> Get the lanes mapping from DT and stop registering the USB-C
> muxes in favor of a static mode and orientation detemined
> by the lanes mapping.
> 
> This allows supporting boards with direct connection of USB3 and
> DisplayPort lanes to the QMP Combo PHY lanes, not using the
> USB-C Altmode feature.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

[...]

> +struct qmp_combo_lane_mapping {
> +	unsigned int lanes_count;

"num_lanes"?

> +	enum typec_orientation orientation;
> +	u32 lanes[4];
> +};
> +
> +static const struct qmp_combo_lane_mapping usb3_data_lanes[] = {
> +	{ 2, TYPEC_ORIENTATION_NORMAL, { 1, 0 }},
> +	{ 2, TYPEC_ORIENTATION_REVERSE, { 2, 3 }},
> +};
> +
> +static const struct qmp_combo_lane_mapping dp_data_lanes[] = {
> +	{ 1, TYPEC_ORIENTATION_NORMAL, { 0 }},
> +	{ 1, TYPEC_ORIENTATION_REVERSE, { 3 }},

This is not corroborated by your bindings change ^

I'm also frankly not sure whether it's pin 2 or 3 that 1-lane-DP
would be TXd on

> +	{ 2, TYPEC_ORIENTATION_NORMAL, { 3, 2 }},
> +	{ 2, TYPEC_ORIENTATION_REVERSE, { 0, 1 }},
> +	{ 4, TYPEC_ORIENTATION_NORMAL, { 3, 2, 1, 0 }},
> +	{ 4, TYPEC_ORIENTATION_REVERSE, { 0, 1, 2, 3 }},

Would it be too cheesy to check orientation based like:

static bool qmpphy_mapping_orient_flipped(u32 *data_lanes)
{
	return data_lanes[0] == 0;
}

?

> -	ret = qmp_combo_typec_register(qmp);
> -	if (ret)
> -		goto err_node_put;
> +	qmp->qmpphy_mode = QMPPHY_MODE_USB3DP;
> +
> +	if (of_find_property(dev->of_node, "mode-switch", NULL) ||
> +	    of_find_property(dev->of_node, "orientation-switch", NULL)) {

of_property_present()

Konrad

