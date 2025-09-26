Return-Path: <linux-kernel+bounces-833985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D108BA3849
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46CB14E1467
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A66158DAC;
	Fri, 26 Sep 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XI+/tKbG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7D248F48
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887057; cv=none; b=KqenrMuKfvHs++YQYgd/6I1Xuko+5Ld2sVo6T85Uvhv4jgfLM05/fmO1TF2OH8VVGJiTflEyoT5maDV4+E+m1xIndc76R+piTgA3g+QJhJIgjFTUuRmCjJSzt84VmVnPE56LARA1bM4CTQLJV+l4wSzMLHxjwNhptv71q4xeJQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887057; c=relaxed/simple;
	bh=GzNoxw3QHFN9Jy6yA0tYzF4CAq5XgTljFmNprpaPjYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GkfJuE4BdhDQxJQRt6G0DQXMrSCeodb87OSSL9i3F4n1PAywR3f19rHNSf12Dr6TIP9Ibr4Xr8LcQKYoNnzwBACHd0C/xjd2E+VTTCQdkmPatJ7088u6r8bI68NZpVA9VVG6Wu2UJxWeHiHCfu9VPJqS26+4++dmrhdkU3qF0Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XI+/tKbG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QBa6Ex001346
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GO5/qjL9gup48kS4ZY8HeZ4gTiSMhzKkkdJq/GGpOkE=; b=XI+/tKbGDd5Un8t1
	Bp31FyP+Dm4Hg9Uut20jaKpDxdPgUvqmWnrFH6aQh0WIHgcLwqwn+rz06u+F4dxK
	72RUgdpKjoUAJix8KtWIstENZtlgIxcGTq8TvaiBY0143Mq/IgSbaHtfyrBhorBZ
	ou5P2+S3v5rhSrwHJOPQ5+vGCr+H0nHfLxpKMAcgpyj246g4TKtZw4ijt+soFKO7
	ofquTePXuyc7R9hgQZ/ZTyvHu4ESHhTn25S8ib590sKeeYGIvMmpkt+Sae2lfxHI
	Xu8jj58Wl8B7Eh8MAgWMwOuydiOBheA14CAT4W2G2XFCpUF+Ms6xweZkpCUz2Zgd
	QAh1fg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49dt3g80gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:44:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4cb12718bf7so5615001cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 04:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887054; x=1759491854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GO5/qjL9gup48kS4ZY8HeZ4gTiSMhzKkkdJq/GGpOkE=;
        b=kO+D2YJJtR1NnlSTBOGxjK65SvnUHvkj4fUmuH/4/WryReRA8Y9CFUc0MI1OJI66uo
         e5nka2qwPf91Un7TjVuLSDlHmIVvb6j0Aqow0aoQNCvts74bzd8aE34v+PigTR9g5lyu
         EKDaSZ5oWvHMCWhqm2xsSj6RfMecPHgFhMR3fUL8Yb5GzyrjXNTsnJEaj2sLlxpaNDLP
         Cvm3zJcIeioqo2xqArUGADCfSa5uycPEwAwrhIYftKcjrhVwDQB60JeuKnjSKqeplu3+
         1ZsuCdXBpGlC+i8cnilO4itIeuu4OwPJtGN08011qiXCfV1+ZLuFuBhQ7/Lfwo1FJWIW
         vN1g==
X-Forwarded-Encrypted: i=1; AJvYcCU63+7Ps2N+bLYTh/NYuO6r/PDxUWRtkdnOjVoRmaAyQLphn55HMv2iX5JXI4jNz83GRlp/59oQi0XZFRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFYKwu4P4OP4t/mw6KKmxmylkm1Q0og8LMANYYWzuALdbu/nC
	ikPcqLRh9FKOMYtCdcjaoPL/uPndDCm1EESKPuoEdEpw3oDMBu7W8bOD9TMCX9keYwzsnznpcbk
	7i2+H9RpHdKT969JEmrZL1BoECbLi3OaY6TpFYSY+nESRhknrr6F/gQq2GFHZGdDJix0=
X-Gm-Gg: ASbGncu/2KItIW93gHT6wk74jMDXKXBqsBxMc32cbnNhV4BF94wjRuaC+V1P3NiXz0R
	HGQEaXfi78Ho/iyGyPSOH6IErghzIBXFEpYRZ5NIGei7ZNFVLaDe8mnjQP+iNuIQTxmOjjV1J+x
	aFxNKMCbdZnvXLjZD+4R8TqfDh7H7HDVhep0yv4j3qLlql2ACz11RlFvDZ0W2w+vHs0Vv36YVX+
	m4s0CcyJDT5bOhJZEJ0xyT0fW0TbmAzJ8VbBV6AYNv/5tdBo1RcaTfobTFTwXDJ3k9K3qlSyofe
	Ku5Y0m89PBfQftKELKol5V92hOOMigef1YHWdOSssoBnOxnXxNqRbsGA10Lov/cpCEC+tCQCquF
	GomHVNfqKGs1nx0SK0RmpYQ==
X-Received: by 2002:a05:622a:11c7:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4da47c0d937mr52987071cf.2.1758887053809;
        Fri, 26 Sep 2025 04:44:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz2XpJ8zkYTrM3z+ihZ+zL55IFpqfrK3wxvNiZMDU7ItXJekbmq6vrYvuyQSWMMfHjzIgsig==
X-Received: by 2002:a05:622a:11c7:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4da47c0d937mr52986921cf.2.1758887053288;
        Fri, 26 Sep 2025 04:44:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f6904sm345662566b.66.2025.09.26.04.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 04:44:12 -0700 (PDT)
Message-ID: <95ca9b61-ffbc-4996-b68b-e550e9ee5fe8@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 13:44:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] arm64: dts: qcom: kaanapali-mtp: Enable more
 features
To: Ronak Raheja <ronak.raheja@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-14-3fdbc4b9e1b1@oss.qualcomm.com>
 <ejcchgc3isc5f6tmiqbxqihmk5efmbcyhv3ehuoerb5ulkd5an@g7a2wc422l6n>
 <60c65d7c-1564-40a1-830b-1c9931776fb7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <60c65d7c-1564-40a1-830b-1c9931776fb7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=df6NHHXe c=1 sm=1 tr=0 ts=68d67c8e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=oYxpnEykKrceSWoAYDAA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: SFO5APwBKMzGlFDuqWRbZlmMltHYMPxb
X-Proofpoint-GUID: SFO5APwBKMzGlFDuqWRbZlmMltHYMPxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDEwNiBTYWx0ZWRfX4+h70/FenEje
 sI/5592+DFKPJ6u4BiNyuNSMqtZXThuTaJ0or7L6QSGMsvKZQEIobNfkOdYLF0nNBzs7qGMfb5k
 KFULYoj/5b077AdDqDigrgeU8hJUF9OuFrpB6pWZMcP26JEbBoFFFyZixZHCWhi6dAWr0cIoypU
 Ka+Fq1vRPtY3SDPVhQVOnOeFZvD5wMxoGO5kbDeSezO6h8sXYUhhDAKJrOHH75//7MYCSwtsYSA
 GWGd+6pMj/qxtyj4IdAcd8lHUsDlnsD1Y2P7gKkmObjlnj0wCG+FgGuWSc6fO0RBY1HFz+ee2Wm
 0U7qCcIXyWHfuQLKrtiqQW4oGoZJO29Nb/Ca4irAIQ4vFZl/KYOI/+MwbjANJkE5xk8QDCUfWC+
 77Gcz+s2sJI+mTjBGP5FoEUcefX+eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260106

On 9/26/25 11:11 AM, Ronak Raheja wrote:
> 
> On 9/24/2025 7:09 PM, Dmitry Baryshkov wrote:
>> On Wed, Sep 24, 2025 at 05:17:31PM -0700, Jingyi Wang wrote:
>>> Enable more features on Kaanapali MTP boards including PMIC peripherals,
>>> bus, SDHCI, remoteprocs, USB, PCIE, WLAN and Bluetooth.
>>>
>>> Written with help from Jyothi Kumar Seerapu(added bus), Ronak Raheja
>>> (added USB), Manish Pandey(added SDHCI), Jishnu Prakash(added PMIC),
>>> Qiang Yu(added PCIE), Yijie Yang(Added WLAN) and Zijun Hu(Added Bluetooth).
>>>
>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> ---
> 
> [...]
> 
>>> +&usb_1 {
>>> +	dr_mode = "peripheral";
>>
>> Is it really peripheral-only?
>>
> 
> For this initial submission, we haven't yet defined the USB role detection
> infrastructure, so it didn't make sense to include dual-role now. The
> controller supports it, but without the connector bindings and role switch
> implementation, it would be non-functional.

I see an internal patch adding pmic-glink.. and I see no reason this
wasn't brought together with this version

Konrad

