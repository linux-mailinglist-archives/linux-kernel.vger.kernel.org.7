Return-Path: <linux-kernel+bounces-806288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47AB4949F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E154440C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2F430E0D2;
	Mon,  8 Sep 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OR4rNB/D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9E30B52F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347240; cv=none; b=DEAp2hitMeXolgVlXdhEHLsVBLkPQw066b4Xaat/HkSPc48436MyUwfRmqyTkeHFwL3///B7ixggEdBd1qDxjhlYfmOECiSjC2gvanlEDykFtxqteZqVeLKQAu04JVuRLI7eT/FWMhpmoJNyk9CItm+erDuhiYrj90bSbPPsICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347240; c=relaxed/simple;
	bh=hUf69ei8+oxGPKa9Hh2o6rXQ9Bg3n+Tgs/uT7fTz0Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMxkjwdojb2Mb4zI5R4DE8Qnpyyih+2o6xGsPr6H4LU+BtHSLJHF1yrAF9IhhmQIWBJR/wppslLsdyp1OCEuvHNBxE/gxaI6tTQqg+IfXz+xrHJiHq6t/TUlvbMELQreacgBm/YhbCNtXz+/zjYjnW0jKlmVNcssBso2fveF5uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OR4rNB/D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889Aorl029406
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 16:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xc0j/77qsOdE0gVrqewVxZfIulHPYV4m7E+uvvmVExo=; b=OR4rNB/DiTh4OldM
	d3m+n7LiRR5GMwtNPs7RljCjkUGi4vMkRfbjtRzkNwQtDYK/DKb2uV1Ba49TLdr5
	ddtlZOtDAhfldbj/uocjYnQFycfJzeREUDPA9a9BMPrDSzHJt8lES9pebvsFcen8
	Qh8ZhyRIDma1Z2ezbBq4lCW2WYsjr8QOX3fJcQTvwKvbWRB46qgr7vVRAMjEWisp
	0r7hHJZORNPlQuMU9jo/6Il5wQp2DK0fyT3Sf4g8WePveJO3CNtZsqHTvRD+dT/k
	dHzO82BMdg5fG7GJ6eTozjNfcgHsTDmDCOxGsEH9X7TYv3M2eZPt6fDUVVSRxQmf
	wumztg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by8w72f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:00:34 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b48f648249so17200971cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 09:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757347233; x=1757952033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xc0j/77qsOdE0gVrqewVxZfIulHPYV4m7E+uvvmVExo=;
        b=XGofvIhGUiFhC7iESChBPYHfMDssokWg2IVh0a8ilrVci9LGY8Pm49d5g9XbQBhO/q
         uq33f1oTDqsud8raP2UMXFCFHYO8QY047QAidFQaJt17EXA3aVpiXi5S+USZyPMSj2Uo
         CG85mHVTVkZP4pj7h7ktY5xTKAYoq1fW3u7f6qzhRenNtwE72COUs7UH4zYjgohtWZQB
         1CJ4Tc3/dAu7JJ53i9A95W5+FMgiJqeQnm8zoe/LinBA5jG+kji9CrLp6INVL4MUOVhQ
         VyLnMtwf+/c4wdYGiGpZPfGLABb8eHoyF4iWJhbSLfzlxeqKz0BcL97YZOhVoBR0QzAc
         rEBw==
X-Forwarded-Encrypted: i=1; AJvYcCXWT48FUw6vomuiv1M9AvNcrh9JMz7cnbCb1zJ0FKfYDtbKJnt0bxmKaNM2EG+6x2uilmTQ88ifTersjRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGwq/W4EC2IY0DYx/WQXT2VuM6WcVM0WiSqctrhK3ls3VHJP0Y
	YmYFfrO6Z09DVzWaujAPy4h31jEiZycGo45JyH6TIiWelaUyyeiAyEj2LcneCIfHurif12Sk1G5
	lEsL90xMYciXObkZblDyTZ7db0gqblMQTWqFb6y8FBBd0X1wLVHfVZFpHH9mIEuCvCpU=
X-Gm-Gg: ASbGncsCMOy44DAuiOIBxB+znvKT6obI/u9H1j5QPVAFSw6YvCi2wPiXW/hC3/DEXHg
	gu1QOFLr3/lr5lYY0hz9LVej4gxaAg8B4W6xtuYvvLEZxA3hA0N/A7GK2jIrDM1uI/k4Zug/eW0
	ih9gbMEW4v1c4tK+Ma8UhzW5x5JkHXSs14jg8Udm9wACIJezh2gEXVyNEZZ7NLG19IEJyvFQyMs
	dKNM0AK2IXAUA+o7p7QMIlOiwohR5r946wERzax01Z1M4HZj8BvaI1kqunexAmd5JpQJyE5TiBo
	pqz2/8nyyzoMlFp6F8a4COm16qiZdEvT5/DCdd4S3mxTBQag7ucE4FmD0K2T73JCl4gOuPHfwHa
	EqRUMsJm/m8NmS9tIe54ffA==
X-Received: by 2002:a05:622a:350:b0:4b5:eb40:b1c4 with SMTP id d75a77b69052e-4b5f842e182mr68490471cf.10.1757347232869;
        Mon, 08 Sep 2025 09:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUGKT4VnKZH4NpDMrzjB7IPxdNCW57On+HkFQgeAEe31+OJFi1cLKvP2iWscgUTS994/45vg==
X-Received: by 2002:a05:622a:350:b0:4b5:eb40:b1c4 with SMTP id d75a77b69052e-4b5f842e182mr68489611cf.10.1757347232058;
        Mon, 08 Sep 2025 09:00:32 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040f1cf4b9sm2132882466b.29.2025.09.08.09.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 09:00:31 -0700 (PDT)
Message-ID: <9e1e68e9-8bf1-4529-a2c0-3ecb2474d8d1@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 18:00:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] arm64: dts: qcom: sm8250-samsung-r8q: Move common
 parts to dtsi
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250905190931.27481-1-ghatto404@gmail.com>
 <20250905190931.27481-2-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905190931.27481-2-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68befda2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=pfkhAzNcYGw44Ndwwm8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: Lrcf4UHbv5Babzw_LNYfUWzrDd-N2gLT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfXzZmEkbiRMi1w
 f/yZdNH5mPouC+eeKDy1s/vRtrK8m8V/hN43d3Wi038hPKbd9xL3bvh6DhYeWYD3b6RxVFXBbOY
 mXlwO1kn+mtIhrlqNaltj+TFytcU8bd6FMwHw/IqMATu3RPGqtWkO4T9yf9E8nSGNT+v8iTYFTD
 PxNNzcpPkQYCqRVQ18tULNVfGZ25tWJWw5D7V39IblCFq3y/wD5O1ZQZ0/cTYgyCP7WgDHn0LzE
 iCg/fBapAIfIT4gRo1PSrnykgIKoJl5cjSjBSTReDdFloS11xYfmmUPjjShV/WaM97ZgvUqtK0G
 eXNjeD6A3abUL4qHfYl28eSwVwgAdYgOygDLhWdJSCOrIxloW4E7Po/x3R0I9NiGXXIjP8wLo6E
 g2N2ojd3
X-Proofpoint-ORIG-GUID: Lrcf4UHbv5Babzw_LNYfUWzrDd-N2gLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

On 9/5/25 9:09 PM, Eric Gonçalves wrote:
> Move common parts of the device tree to a separate dtsi in preparation for
> adding other Samsung devices from the S20, Tab S7 or Note 20 families,
> creating sm8250-samsung-common.dtsi. Also add support for UFS, USB and
> GPIO keys.
> 
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---

FWIW next time try:

git config diff.renameLimit 999999

so that moving code around will hopefully generate a smaller diff

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

