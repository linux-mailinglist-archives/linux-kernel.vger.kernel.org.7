Return-Path: <linux-kernel+bounces-852280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D6BD8955
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C7C24EF52A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082312EC0AB;
	Tue, 14 Oct 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HNOVm7Nn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5F2E7F2C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435583; cv=none; b=sYEl0fnYWU4+374dvZ09NLfh4H6nnYRFnk1vSCwWc2py8u0bj4uH6svGsYpVfIRxTYb7xujuc5VjoupRcDmAlrcZv17m+TxrFZeOQZ0B3/BhY//eylksp9R+Gyj/Lb/8QjlM9Ppfok6Jh6mkbVESbaE6Wj0ur4amAiQZUOsDKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435583; c=relaxed/simple;
	bh=gUfKWkkU/Gl5PN2qM9TecVGml7FKvbb6D1xfgGMKKXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dw3iXX6/fTpb7NK/V6WsBF8jfL0hM+1XR9zyuUhXJBVv0rMiL94v1twNZ5DulWxG01GFt9ClXZGq6Wk49zfEh1G1xMsOj9ay3xocOprZC3w0ZG9MxNxH67paZP3DMxZEW9iWLJtTBzGGZkArpp5ECS6x98ZP8e1cTV4QITFrfwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HNOVm7Nn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87JFp031017
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F0bffc/XzD9MvQE2h6D3BwBGaZfZTTXTRLHrFoBclpY=; b=HNOVm7NnkRJjzTul
	4m27bq5RnHkIE3pKfuThw6zYZRcYVwqQJ4GLjTZ2Vp7Km/aUk7yILUKO3HKu9+qI
	u0cfEd2rMsLDqe2JzDWL7AVj9HtcYNfQ2VBGAQXvVckTmyn37lKPPKEfy03646At
	0Mc2Z4WC03US4WqVvLrAUKMLsAG8zZ/5cYEn8t9e/95ZWXFlxhi4v0gKmYUI3sD5
	mVhFvSwg17f3htGliHI27DkfXtPkzQjWL7TO786c3ZfsHkQ0RbazZPMW2o7k6lw8
	XILciNaxVBqsFMNLYQlvfjbMdgxQZR+xsRmAUrB0boAsouwPJUFz+zFGv5swGZC9
	Bo604A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0qyne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:53:00 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-85a8ff42553so251986885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435579; x=1761040379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0bffc/XzD9MvQE2h6D3BwBGaZfZTTXTRLHrFoBclpY=;
        b=kCwwVAoQVI4xdjL4CuFKwgiJsUeV6F0JfzdocsE0WralSk2qvDyixa2wV4XuzIy0/7
         4bKQEfEQb2ZKe907/JOe0p0HRrY/dT4KJPjqzZttLx1B/CZk2Yvf9FbZEn1O4k6edc+H
         CZJjr2bc5bw4eU3gvjXN+W/polB42DruLNPXsNhSV+UQyygUprosDng739BTVAVfAb6q
         7ON+0WEWYpDUhsKl0dDCjud38Bk8spX/yn/wXswt31RHwK5ysSRX17cManfaM4Yl6E+5
         2OVnvw2Nd9MkTqhXvlwojGVtzBIsW2b3YQSaCU5A+PM5l4orvnwwJ5Rn6tlo2gBBx+2h
         mbRg==
X-Forwarded-Encrypted: i=1; AJvYcCXcspWR0fL/5tNYUIdmfhD5kuIvi5DtQ2UmIWRefQv7fRhqcszDZTlrCwqTAGHnZKLjWfTG7EqypzEsRPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbCqdEgnN+C+jYLyrpmfUi/7FIoHmaQomY3OUbksp7spu28gy4
	JyTs3O2B02InleFYjDaqPHX3Q9i8+h9gjdzmayP025u5iPO023ocrBmWk+uFksz06Yoyv0JWz4D
	Dxuv9WxT/YtzxfKt4+9/NXmTVkGn9lhhBOQ1ZA3m3XBdAeRb+Av3k1STyCHo0szb4Tzs=
X-Gm-Gg: ASbGncuxvxPh9tJS4mm968FR8pVvvYLSruoHl0F5plE1hIoeBeGoT2MwSKZTsOS0+5B
	Ts3gnabz8JBOv7thG8MnxMIo/yZ66nln+I1/rGWn3HSMHntPmKYdit5224Kq2w5IcxKHfT5064x
	OCTpdJAev5Y5FnygpiKRrFLiEIt4qILOpzM9K3QQAshuHgCPt/87e+AT7ptM3fitAkOj8c7Ej6/
	3n0FoOqbUZh6ISy3q0eGTxdYWpF0azdoc+c6Yfs0kwuIU/W+5ZysNlXcfQhr4+aiwOQp7NlZ2AT
	/BSbseokSdmSf4aNuzOSbSaXa1NT/rl9iRPdRto9sNmn0kszi0tWrsIkAiS9G3oNKW0J7915Ho0
	onOZrYxemYPaVSLnqmXLIIg==
X-Received: by 2002:a05:620a:7012:b0:862:bd48:923e with SMTP id af79cd13be357-88352d9a2c4mr2163600285a.4.1760435578885;
        Tue, 14 Oct 2025 02:52:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnUhF01Zofq6EjRpw5993//+lfD9xui8peDVWDyOkLe4ZPEIW0HfK9WyJ8gfgXNrAo6KOw/g==
X-Received: by 2002:a05:620a:7012:b0:862:bd48:923e with SMTP id af79cd13be357-88352d9a2c4mr2163596985a.4.1760435578438;
        Tue, 14 Oct 2025 02:52:58 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d65ccfe0sm1114443466b.25.2025.10.14.02.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 02:52:57 -0700 (PDT)
Message-ID: <509e9902-2f74-484f-b5ca-e1605a221004@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 11:52:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: Enable DisplayPort on QCS615
 Ride platform
To: xiangxu.yin@oss.qualcomm.com, Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, fange.zhang@oss.qualcomm.com,
        yongxing.mou@oss.qualcomm.com, li.liu@oss.qualcomm.com
References: <20251014-add-displayport-support-to-qcs615-devicetree-v2-0-1209df74d410@oss.qualcomm.com>
 <20251014-add-displayport-support-to-qcs615-devicetree-v2-3-1209df74d410@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251014-add-displayport-support-to-qcs615-devicetree-v2-3-1209df74d410@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX4p8GKl+w2+wm
 EPihZfOf2bl0oHcTQpzvJTrMnd3y7Y1464cmpgXXMhDd18ZDeIOaapzDXK2x7S30Om+aLJU+9xo
 E4VG2uXx7SA9x+7E2tkCeWXFxn07r/3KxfAxVAPvmFoMHRX9ffrK7VlFd4mtmz6ZXH66Uvl4b4p
 JAmtO8mtB8hBPYrP6flfQcJz88fdn9R7iQd2H6SElmnO576ZepA3NHis+LKGACuA1VkGpnNy4Vb
 5cltxfHueM9DbMuRdr6RYwu2LwV5jU+3DVTwBo01yxguqMlsGiyVLWx3HSORbfCy0RO1M2ZZn9e
 HxPh5V5tu1ob/9QuLkDQfwMzk+V/oUux5V72aQ15q/8XiBl96zkYwo05UEMKgTRUikywjHBYpSb
 ls+q8cBDYeLoF1AfV73x1NXV00ad0Q==
X-Proofpoint-GUID: aW2l22cC6ax2rk0LVG_-jg_sJIFrkHyN
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ee1d7c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-JAsjFMKCY2WfoXnbYkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: aW2l22cC6ax2rk0LVG_-jg_sJIFrkHyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

On 10/14/25 11:42 AM, Xiangxu Yin via B4 Relay wrote:
> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 
> Add DP connector node and configure MDSS DisplayPort controller for
> QCS615 Ride platform. Include lane mapping and PHY supply settings
> to support DP output.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---

subject: "qcom:" -> "qcom: qcs615-ride:"

[...]

> +&mdss_dp0_out {
> +	data-lanes = <3 2 0 1>;
> +	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;

No 8100?

Konrad

