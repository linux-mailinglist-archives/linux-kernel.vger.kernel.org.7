Return-Path: <linux-kernel+bounces-839796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7D5BB26D2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 05:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6274200E8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 03:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B783BA34;
	Thu,  2 Oct 2025 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QOyO6eeJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8294C1411DE
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 03:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759375265; cv=none; b=gVTGAP6IJY2x1QL9oY8R1hCuMdLHAia8auSe6vAZYho1D+jj+NdiIIxLT+I3hXUKn4LEI7mN9PcoiWbNh2WBuSuXwovFtiGX1C5yEyHp9dkjqelSp08okM0RXLSa9H9j+UBxj0eP18Odi07tVj+aikNUKIQMJ1S0HiSgdTAyOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759375265; c=relaxed/simple;
	bh=4OB98gy4e2/1rS/SKiKX1WzaFtLO7WAftK7JAWaM0DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE3U6O4OeawPd7EqmJ/Elvyh5W4sWSNWn3accbAPA6GqjiOgvihtPw8lYeZDrhh6AFY6gkKr06/8+u8qzAQOcok/G+Vz6OM46tlHYXb51xJR0Qi9ZkuOuuR5GY8ueK8kn3YqjLTm6xrCIaehwyYOqK28sgKRjwNDSgzLtO2541M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QOyO6eeJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Ibs4T023323
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 03:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MadjmTlGyYj9vNqf7FS+yHZf
	TOeoUTWW+o+zA14y1nw=; b=QOyO6eeJhYeUSOYQXBuLGyU0HOrgAnoCNQByx4Jr
	aKyoa7j0shTN+8iOxcTC/Sof6bS/iEAF3sywu+fJoJhkURssGNfShWAxkV2mTBYt
	eO9uZ5iXdX9M0a3/32hjV5URbND8b38gpKjHAUXdrZg65kLNJzXS3owewbGnPMUy
	1NvQKwxSjeiarbT5EsnhCM4uQKBqjwx3vzQBxr2QaIjcCai02HgSZedJjvGsPGVx
	iwynO3huDsJvCJR7MYGo84JK3KX0cE9CSJTXYZriGBldfeqmg7IEhS+w+V7DBoa9
	NETXPyKnkWGfy7M6EeImtiD5ga8yDCvVG4y8RjDXx32qKA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a66jvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:21:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8645d39787bso152550685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 20:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759375259; x=1759980059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MadjmTlGyYj9vNqf7FS+yHZfTOeoUTWW+o+zA14y1nw=;
        b=JzbLKsPqPorBoT3pdVWXwHzLgThP4XJpoKRMpBRhLdo9FWB6OCF/Dt/si3Nxmy7HS2
         lZySvaP2N+z7cKmZYbn/MGCUOV/4bde5OZeIt5Jv6u0H6nUwCSkhX5Lm3dR7hGhuaTjU
         rc0B+8NyXTRj8RTV95D8oDsFYfvmyGs3s3/PLuDEQx5o6sEyzIbrbItIHdk6VZJlPP9p
         ULwQd0xlSsgM0PbbUa1SfYFC+A4IlPF8YcuFk0a+MTOLKWpZpEbCgnImLSLM65dEGAmC
         R4CPYL/sYBcfuwG1c4yu8jgre8JHACqhsBi+VUxOiyXV+kOZhWbopvREbrLkZeTfEszT
         xJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCWznz8J2RhtaNMS2McU5u7w2thSiq5h8rgKkN+WjP/0sRNz76mpXYwpZqIdKSkUBqD2mprCw9nwEi2hCgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGBzjaZx+TveOBhJZx7gz38Ww1HH9YjqWG6wVKBHXZ0qXZKKaJ
	Nu48FRgXTC3XWdgYVHilE2mR10yFiQ3QE07WG7obQDOMBR2f/c7BjJ+i3GexSqKlnOllzfHHpD3
	EuCsEDQwP4JARPWHw39waj1M/swpHbxAg1x+4cZStVIIjNDnj3Yw/fyfZmFqt9Jl5C60=
X-Gm-Gg: ASbGnctqYnjzx3iHvC5NNOGTmL6G7/QeO7mwbylsh3uHoNcS6rcOsUI7b0ogYhcmTP3
	EC4FAFOt+7udVoFfxCWSSh16ib61mU2SqE9FPv3gBMTykQiMg1YaUbvQVsCehE4mHy5fPo5fg7b
	eAoXNTIp1tmqJIgkWvQysUH6dhZPhpKeFvy+RDprXkax3U6j7RLaJR/0H1aCJtgdxhw93uDs0oS
	QqyoFWl09jqwFMoIbGgqgmYpc3NQXtWihvfm+n3EmcePjHU2aQXAGuUv4MmDCagoOr0+Ip217xn
	lk/Wo8McdkqpayQT7LfmN5Typah312jBoMDNSHTcV2CtEzwRpY8KlruW1RfgtxnQUDgrwO9cX5W
	v4g/GEVdHgsRI3z/W1rKV8DJT2ISH0KB5OfOp60tVxgNeRzP/IfWoHGJtkw==
X-Received: by 2002:a05:620a:28ce:b0:809:7ac4:e5d with SMTP id af79cd13be357-873751a3f72mr827104785a.38.1759375259110;
        Wed, 01 Oct 2025 20:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+9KdqXQAvgAy91aCrCBMNPDEVwnU2TL2BXZwwnc5jZ0pwSHdM2Q9U86P8T0TmsQ3kUHLwbw==
X-Received: by 2002:a05:620a:28ce:b0:809:7ac4:e5d with SMTP id af79cd13be357-873751a3f72mr827101885a.38.1759375258476;
        Wed, 01 Oct 2025 20:20:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba4d4ca8sm3459121fa.58.2025.10.01.20.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 20:20:56 -0700 (PDT)
Date: Thu, 2 Oct 2025 06:20:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 supplies to simple-fb node
Message-ID: <pbu36yoruuqmik5pzpk3jcl4a4kpatigrrkoco3ikf4npvm7os@soqqf3j3m7yv>
References: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
 <20250930-sc7280-dts-misc-v1-1-5a45923ef705@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-sc7280-dts-misc-v1-1-5a45923ef705@fairphone.com>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68ddef9c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=4pzNktNMXXEreR8vy40A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: wwm1uXZUPs-tfiACexnQpqTdc7RXkDft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfXwTA262gXANMm
 rn7tFmdUiuxUv/KDTvLA1iw/iOgkR1FrOoW4LQwtqloWXMRMcL1puKQo7BFDkLPxXHm5hhCXyB6
 Z/uueS8GNndI3VEYJuzp68aqGg88q/HFCUACAxJSznLEyHxAVrlIr3XSwfeVXDnPdawt1yMlGHM
 jtRrgAIsp/PWmPasn1kZYGld34lEgzqtFk+kzfjEa9IO5YunOSa0hTQjxNHneNNfjK4iBsrdGY2
 SFfuVUx3pqu5JIvpkAWZQ0UrPCRYUYmcFU0pB4fRbyzU5ugSSn1j4frZ8lCMEXfeiDVHCAwjYId
 ux5aDBpqumbL6IrDhXbNfwn8sdkw4aZAuqrnBAtCKBeiJM+HrB92cfxCYBk2VdGEBTXDG3D/Bnb
 WaWqltBvnGud588wWddgCy+0uDL78w==
X-Proofpoint-ORIG-GUID: wwm1uXZUPs-tfiACexnQpqTdc7RXkDft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On Tue, Sep 30, 2025 at 03:57:01PM +0200, Luca Weiss wrote:
> Add the OLED power supplies to the simple-framebuffer node, so that
> the regulators don't get turned off while the simple-fb is being used.
> 
> Fixes: c365a026155c ("arm64: dts: qcom: qcm6490-fairphone-fp5: Enable display")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

