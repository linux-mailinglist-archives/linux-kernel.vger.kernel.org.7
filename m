Return-Path: <linux-kernel+bounces-615414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD5A97CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 04:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483FE1B6229A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 02:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203FF263F5B;
	Wed, 23 Apr 2025 02:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gcEsVa04"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB22701B0;
	Wed, 23 Apr 2025 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745375054; cv=none; b=TV+rj8glUndq6HeqWzH8aL/twvKuBnZnQnGAbnsrbBsgHvkfImFIjW9qm55ACpPH+OWkg1/CylgFTI15mWpO/KzRcA1yAD23D3y6egmx/BYJvt8csbKRIbr+3C26ssawJItM0t25p/2M+DErxrPaODNw3Q3b8R0Y2C/FmN+ucog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745375054; c=relaxed/simple;
	bh=g2eBraSmadc79i0Y/megN+wsZJtXKstGJ8cKh0tqAAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aXBMlkcXxBDN7r0QdNuB9c/Ug4vOj1ZamxvpMFB9yHa4lMxFylql31U0MbltvGbszcCYHjS7MSHd7qpxqQPptPaoA8LpGHZX+O61vPgiSat4pnqbArLvN7KEdcO2iyoKI1wgP/sPT0aN/6evxkJaqCV99q82GANoY0NYuhUI93k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gcEsVa04; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0iOFC024199;
	Wed, 23 Apr 2025 02:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A3p0shn+EadAgS37YRBKT47mpjkqtQBb46wYknXcv7A=; b=gcEsVa04yMM/LiEo
	biMv9NF5VP2uzwEC5vulbuTJT7OwSiWpOVkYa1HKbnFnDrUTH2RSFtEzgF6cSbpA
	o2CaeQFj3HrrV2RH7EYbpUJuouZ0V91V6023chl4/8e7qdP2NOh9bFGe6RibjLuC
	XIwC8/3aUhsEl8pmXMwg3GY1f1yJRohs+Y5UvESX8SiUgwHFPVBd9/g+V5E22lnB
	YahZRH3UW5j75zasBQHTENqVk8InRbFeSP06+qNfe48QDFaZ8o9X5s5A5Kgb9COO
	D7o1PAyr9eYtg53/t6Aaj1SQQgnyHGen7rGUasFhbgwc0yDReOVv4GC9kVSaeHlt
	f6/liA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh38k15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 02:23:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N2NqTm011450
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 02:23:52 GMT
Received: from [10.71.110.123] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 22 Apr
 2025 19:23:51 -0700
Message-ID: <079bdb90-2dae-4feb-a32e-7a7ce8a3a972@quicinc.com>
Date: Tue, 22 Apr 2025 19:23:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: display: msm: dp-controller: document
 pixel clock stream
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Mahadevan <quic_mahap@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241202-dp_mst_bindings-v1-0-9a9a43b0624a@quicinc.com>
 <20241202-dp_mst_bindings-v1-1-9a9a43b0624a@quicinc.com>
 <e8f2e17c-13c1-4485-8e9a-d67705e461d6@kernel.org>
Content-Language: en-US
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <e8f2e17c-13c1-4485-8e9a-d67705e461d6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XNhPFzHgSVf8tZ7uxJJbchvi4jvQGUkl
X-Proofpoint-GUID: XNhPFzHgSVf8tZ7uxJJbchvi4jvQGUkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAxMiBTYWx0ZWRfX9hDdm3ug2qfK HoTCYPSVU+rvUSU/PtDeRevJkQz9ko8+1GI51wFXfuH+JhA8oBMO4ivYbIwb2S1NdFubtuFOuN6 bmVWIX4Pzoq3Nq0YGlFZs2W3cn2W6Bdi2lWvyt2h2tJTlnHOh5SWEfyCu5ec5sn9CeaSPFyZIe7
 B43rNIM1FhEUnF8RIqRr05n5FbaNT/QTfEenZmaupjziBu1ZK8FffCQqLh+c30n5oOZBe52OSaC /hx43O6bOwwC7UsQRYobfTbALhOoXG6yQaqqGflzmsKOi7zpu3E0PsZyUn2F5AkWNAH9fUyqSeu Ka6f1Oz+/os/fCTbyBJ0OWb6CFkFzwYx3yirpaQ5m7P+KqeUImRS3Y6KGr+gFdqj1/94Ei6rWdb
 QsvOV6HxtCk/b6Q2+4rCdD0Bt4smUgqELJ6n1WeDSsB9QXGL/pxuMD2y+Z+ttuySdpkb/rt7
X-Authority-Analysis: v=2.4 cv=Mepsu4/f c=1 sm=1 tr=0 ts=68084f39 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=wkMkCz1etwRys_XeWVAA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_01,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=964 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230012

Hi Krzysztof

Sorry for the delayed response.

On 12/3/2024 12:01 AM, Krzysztof Kozlowski wrote:
> On 03/12/2024 04:31, Abhinav Kumar wrote:
>> Display port controller on some MSM chipsets are capable of supporting
>> multiple streams. In order to distinguish the streams better, describe
>> the current pixel clock better to emphasize that it drives the stream 0.
>>
> This should be squashed with patch adding stream 1.
> 

Sure, I can squash this with patch 3.

> Best regards,
> Krzysztof


