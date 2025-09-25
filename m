Return-Path: <linux-kernel+bounces-832079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF88B9E492
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB1C424DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F82C2E8DFD;
	Thu, 25 Sep 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MpxISx3D"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8B2E9756
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792119; cv=none; b=Mn7nm1bgUF86Yqc11xNYjp05OjdIjmBdnLu60Xas0+ZW+e5MfyDbEoudfKaEk/v2YYZxV9VRxZOqx+Q8Hl5q4Fbm2G1BiZtc1mULxAvoN9FDLuhJ1I3UA0zU6FWeBmzPJ4zK3fIH8V3sWELt0IbyAzppMieD1/zZ9bafCAjIG2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792119; c=relaxed/simple;
	bh=YuN2jxSdm0ZZkGMeRrFad1MgrLUBYsgNVOQsFLIGfZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mh8HITT8BEKebXKeCReQbhmkob99p6oCdaewZaMBPHnoa/p8+9K+KcoK7uCCzTsa7eydKiPEjft3Nj5+mVuwN+Rmdtf0CJmDP+NZmzuzXvFVrOksUSi8qE+/kqmDZ6MBaIVFKrzcXXVXyVn8xSKai8yFY/3gAhaiajeZ3D1h1OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MpxISx3D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0MCNA002079
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qkY6Gkhe4/YsWoOULLmVEty3WERnlLeTlM1ZWPHFrjQ=; b=MpxISx3D5ylLI7z7
	xry39xZ8wQkjCX0D5Tav+KZW74WENGTIphUInpXBVPNrEK0J5iIKevLedCaQqrxb
	Mr/Y/F8WbfyqTQ0T/lyCFh+VxB75TTdEmUzXZno0OqkHBlruo1yyrwDi5xv4xQsq
	puJV1fggyRt+nU4IauL1ESO4wcE9Y8d2/SMNUsE1WlysrIVB2WXoUwRfIBlzUg+J
	MjYSlAlcRch9h3eyALoo/aEFlGSjH6N6fZKOyhay4fadPgF3qvc5m5hdDRWTL0uF
	yIiOujlPGMoh+GuZdbulCMsQEuK2b4hEYRx4CT6LGtf1zIDvcpkuG1ZFVut0GwVr
	8k+sZA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98qham-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:21:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7f5798303b3so1789176d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792116; x=1759396916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkY6Gkhe4/YsWoOULLmVEty3WERnlLeTlM1ZWPHFrjQ=;
        b=nntn00vm2HGJmYtLnHH0n4sFNjooolIl7D6PsfflhahXQjJ/Zb4oBbFPfXkZysl1p1
         oV0T+3HCTcrAazojOJqySZB9Kjob5VCRhKUZRTq6hqQk3NFRrtkeFJtBPRM6szAf5Sv7
         qJfNxB6igRuIuTPEw5S/pAophENYtB3/lcQmpbNzGRCaqdKT7/Lw6EyBhF+YjqUafOrU
         MM0723SkEwZ8i4ZRjenvI7+CCFXHTxv5evFzHMmGAMLKhg4z7bRkpuu9Ph8BfEvIDpyG
         S7j7EeVNU3IurAmxfg/QyeN6blTO2Am8eJsfCpM92Tz4mV4bVY7M8buNdEAeYfGXxs+/
         r7tw==
X-Forwarded-Encrypted: i=1; AJvYcCX7gWZ2246wQVEpJbrcEBEGfuKnQmkZO8ZB6oDr8tv1F8c+80D07yBNuNsh7QBd3+v8y5XaKr6H8+TDiBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMCDBI5ni9j9++ALayYlafrK4m+WmGxuQ8Wfpn5fXr4/9zZMs
	kj0tjeCjFXZXH8r7gzXrL+xnPE4bBRZarHn83sXUf5DGjuBJycH4UydwNObbvtghJY1FrKGErNh
	/QKX8hj+opgXHUjWbc6Jt30TztZO1FVWBOZwpnY3bdGkLjFkE+4Nx77OaAPUA10T9F48=
X-Gm-Gg: ASbGncu8/oBMGYGPGM4PGappZSEMkByRZ63BwZJXG+Aq8wPEbIby4yjJgsBt5/uqU2I
	ib+318g52sSxTzx9EziP7EWK3ohG5eAO7/2+43zZHYBpkJ+DITOWEfH9Ni33C0fTAHXcYTk5Wih
	rsG9W/oV485WOQLYjY1OL6BM0MCsy7OtV/eijvVefg+WroPy7/ishIgE27vlPH+6396+llGRhKn
	mEeUuvy5kdxAmBCan6tjzjedOr/iSIHBy9gLOWHGnXzfTMr11SVoy//UJ937DduSeisoSfuM7n0
	xL97cZkC3UONSU1Hg8qocVKETcYgjEf8wUzgQDjURBnQUuJ375ZOQWAYVA4HIMCJAiwyfnnZ0pb
	dQA8mxFOOlZ64O54Prt2oTA==
X-Received: by 2002:a05:6214:e42:b0:78d:8226:756b with SMTP id 6a1803df08f44-7fc3ed8a772mr26720296d6.5.1758792115674;
        Thu, 25 Sep 2025 02:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwGMmaaEcZzBvc/SySDy9DSNDQiiY1yU0ffafhsYtzP+HwoCnQGiPWpwjVLzKv+RZ8tvroZQ==
X-Received: by 2002:a05:6214:e42:b0:78d:8226:756b with SMTP id 6a1803df08f44-7fc3ed8a772mr26719976d6.5.1758792114882;
        Thu, 25 Sep 2025 02:21:54 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae2ff1sm901820a12.26.2025.09.25.02.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:21:54 -0700 (PDT)
Message-ID: <3d808b73-7c6a-4b24-a3a7-b7fb798e24cf@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:21:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: sdm845-oneplus: Document TE gpio
To: david@ixit.cz, Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding
 <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20250925-s6e3fc2x01-v1-0-9293016768f7@ixit.cz>
 <20250925-s6e3fc2x01-v1-6-9293016768f7@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-s6e3fc2x01-v1-6-9293016768f7@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6xKhQZYxC9rw6pSoSe7MReJDV5jISCLJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX+zC4SsltNaxE
 Y9be7juXlCszyRgkOL3N1jXVo2fItsK0wwYbV+OtFtaW6XNkfpIY1pDCoazrf9FcdckC5O73LYY
 IsBqUuINjVK5144Wn80jfasp4/Yrx2p8TbnBLe3hQjmzwObTD9K8kGdd0nGPricALWBEHu6kqeh
 /31FlrfGA0WjMB1ACAwt2W7RdQwh3KjZZOphZJ0RRDQB9VDoDIi8dDT+7KPH/ib3lv4vrPqNc4b
 z2+alIVKAAYYqjU1UP+SxOjh1Zh50cs2wY2KyNBX/wuo0zo+ugz+AQgzcUIPHUqUp3OZZptf9ch
 BrydNuASKX04ou1XL/aT0VDtc7oxgZbhIjAAcnX1N8MLBnQnYSDVihVRHhchS/DQjJls2aJ9H0q
 kwaBjrRT
X-Proofpoint-ORIG-GUID: 6xKhQZYxC9rw6pSoSe7MReJDV5jISCLJ
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d509b4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=OZMW2xe04SQmtW8ssQgA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On 9/25/25 11:12 AM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Document panel Tearing Effect (TE) GPIO line.

"document" is a keyword in DT context, perhaps "describe" is what
you're looking for

with that changed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

