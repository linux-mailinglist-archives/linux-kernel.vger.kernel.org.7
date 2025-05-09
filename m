Return-Path: <linux-kernel+bounces-640967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FB1AB0B74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 09:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7552F3BF109
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 07:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32506270541;
	Fri,  9 May 2025 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DNEvEQuq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F88F64;
	Fri,  9 May 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746775120; cv=none; b=VRbAnaJx7/akXPkLl/+oNuQ8jDYBn5zQttjNIblR56GnwzCksU0NN3Yc50GhQxJqOCmGvJK8RncJ5rTbfnU8xB/MwSZlebon0f1zGycWCKgWhTvHQpGUjbOR7isAcYNo7wc7nMw8VEGRcApLRT+H37HHIMmOLOvJFFjyAG0Kcfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746775120; c=relaxed/simple;
	bh=WdgrOy2RPo0nCk/bcC2ywsBSNqyV335TPHHX0q4PyYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CLr3y741uJcaNe0JDiDqwxnstbm85zBrJk72G+6Kf99lQMnEyOnApvHQG/lvPksWFB6h+GrpcVtjHCH4NTEcUzjQjaXi+OkVTHnX5YKhathoSXgXd0X2W1mVl0biFY1Odw2DnRunlY4llNwlLKDidV00nYx0+78m5s5AGdGv78M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DNEvEQuq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5492cSE5009191;
	Fri, 9 May 2025 07:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3C07s+uImPI8s4GiBFJp/oMOL7Al0jdDsxGtkQVfuls=; b=DNEvEQuq2pKOTfoq
	5tnhPaz5QHUHz67+WtBDjrmZ5vbhniM5u/umXjnjrZZ2CG5PWCBuNyfAnHJV57Zx
	TIzoaEWv6Inu2SMSInme3vdOuAWLc2azLwatBdHwVK8DzMEiAzPz1uft2Js4tflv
	uaZcay4ljPeY5cUzcHnwqjypGCgYT5xiD/daeJwIdBv/Qb6741gQkYeYwgEG4Whh
	51aKsZEcQhlutUWptDo9eex/iprI+OJqZYt9e5vhNufroSe/ZYYF2EdIi54tYsoj
	6J0BPOkiS85YBmsNbgnxOj3JdhR6P4ufG12GvUEi/amUG64GcXThpNA//QAxP0jN
	nuRDWQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnpeupbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 07:18:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5497IRnc028657
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 May 2025 07:18:27 GMT
Received: from [10.216.57.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 9 May 2025
 00:18:20 -0700
Message-ID: <9245741a-a4e4-4be9-a630-adbb5c07a0b5@quicinc.com>
Date: Fri, 9 May 2025 12:48:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qcs8300-ride: Enable Adreno 623
 GPU
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        "Abhinav
 Kumar" <quic_abhinavk@quicinc.com>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Jie Zhang <quic_jiezh@quicinc.com>
References: <20250508-a623-gpu-support-v3-0-3cb31799d44e@quicinc.com>
 <20250508-a623-gpu-support-v3-3-3cb31799d44e@quicinc.com>
 <954547f9-3bdf-4d26-a7bc-54c8a288d542@kernel.org>
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Content-Language: en-US
In-Reply-To: <954547f9-3bdf-4d26-a7bc-54c8a288d542@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2OSBTYWx0ZWRfX1uw/gMpw9rru
 G10Ki5WLjGwS6c2DwGS79s1IXbDKfbVcHgd0aE5V06jI3pTw3quztESA8Rteqb6hB4XwYH7llR8
 WNWsaDu8DvMKpY9FGUcWkhERNAP8gVMtfYmPqu+sYYQ3YRxRr5JRUUsYdAKHkBY1vSKcJFZKbrG
 WwEho7HBtTXkuusCGooev4cKusbLbkAiFaQqBtkMSVn9c1XzFhL4U57JzxpOO/0zqZ1lREM/DOE
 e4jrlcZIHzxzQ0uZJvXBMdyoyPDjC1CXCAC45FvDneYi3tN7UGzWsHPFyiQIbFdT0vLxz80uSkn
 hJeSYJ4C0FMhf0dAbGoaSrPP5ZwrCq6kbEhB8kTh4RVkQ7GcFX2aZaURZClvAzcaWibn3K0VLLb
 hoJz5PBVk2wTlwehVwTVzpwx4DPa0Yb08wXHazcWiI+mkDTGTMLl/hWWjZDV/ELhDqJ3kFPU
X-Proofpoint-ORIG-GUID: f9XKnAjWlHp5fLqYmrHnjDycq9jTMTOx
X-Proofpoint-GUID: f9XKnAjWlHp5fLqYmrHnjDycq9jTMTOx
X-Authority-Analysis: v=2.4 cv=Yt4PR5YX c=1 sm=1 tr=0 ts=681dac44 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=KKAkSRfTAAAA:8 a=OqMYrAO4_3c4-Z3rUcIA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=737 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090069

On 5/9/2025 11:14 AM, Krzysztof Kozlowski wrote:
> On 08/05/2025 18:19, Akhil P Oommen wrote:
>> From: Jie Zhang <quic_jiezh@quicinc.com>
>>
>> Enable GPU for qcs8300-ride platform and provide path for zap
>> shader.
>>
>> Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Is this also real review or you took it from entirely different patch?

Why? There was no change to this patch.

-Akhil

> 
> 
> Best regards,
> Krzysztof


