Return-Path: <linux-kernel+bounces-845373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B43BC49C6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B39189B7AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B62F7AD7;
	Wed,  8 Oct 2025 11:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UProDiaF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10425A2BF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924020; cv=none; b=ZiU6446r1cAfuTcDbUz7wJZrky8FI1kpEN5jZrbdGtI1EKVTMMnirgvH9o6i2jCjnIeMV0vtW4pE9LQN3v4+XdvO5uEq7k4SaNqkhDrEziYpEIDcMOHjIWkqonYoPI2heO3ez1kBYa9TFFxICkOeggK0ONrGj12qZc6IyL/ILzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924020; c=relaxed/simple;
	bh=pOLsyu91bA7BFOduTPfXQwDrZ2/gTjYFrA2eBRm3r78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeO6l8Tt60j6lzxtad7Pa3xpLTGKsajS+6f26F5rH30BQBtSfmQyfwpn+x3czTt3n766kEkLxNf7ZIS9ynVBcCrX7POT4+JXmazz+SKI1HEcoGeTzLHdkR6tEvg15M0UIzSBQWg3IIRfnxPUucnLXajoGnOqkXcKH8dG3Bq1Tsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UProDiaF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890OoV022715
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 11:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zmZqI/hK2QIPAuDXDoC713x1X6hbDw/7hyjWJFFNTE0=; b=UProDiaFd3+bNfr/
	JAMFmeTOf8+SkbvblGKTR06dC1qYCi72cCccPdz1X84A0oBNXWSbJ8NXXh02KB72
	WfE0bPkXgRm49IMMYEmrxBpBP+nVx6z3K2iO45mzz7Wwx+HukjK2twkuu8CIxbxw
	WTBE+B2H7tc839FrzveOhRa4zPiTRyyUbGlBqud1+orHif/6xN8ni/W5G0lZm5KT
	iPJ3GfxERsvCOkLRpg+Sp9XfAasDi0khKs3qMt1RI5Ihf6Oz+xK089HZffFb3er6
	qVOeaokX/617+OZxzQQ4C/tq7XTxpDaE/NiX0t7D/T5oLvwppVw3wlEzzeVVFp/N
	/D25Wg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49n4wktr6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:46:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-819d2492a75so339869185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 04:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759924017; x=1760528817;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmZqI/hK2QIPAuDXDoC713x1X6hbDw/7hyjWJFFNTE0=;
        b=UHj6i0pDf0oaTFPyokKmlG2Otc95+IznZo5pHQ/O1+uHsvDPiKL+drsMZJTp9Igng4
         BhFy/k5SyPIn0vHdyIVqASgPSi2ptikL2T+Dlc6ivHf1+d4XOkrn8aZ4vm2DbC5YWUSf
         PfSYpbyPfuNxEQy8+CZywpt0rUdifdCQzZVzMOtWSp4icNN3UCJs6aAsezvyw4sb7ubm
         oQmFNzTND02uUhrz6fYC21APNlqqzTR8wxzfs47TzM7VC2oWnTZz4dz1gY0b7DQTybYZ
         YsjFYkNQqTdA8NQFsMIDdnFF3YIpVhEj3X85BlW5qcE+c4T728QZwonpK5yavpH0T1kt
         Crtw==
X-Forwarded-Encrypted: i=1; AJvYcCVCOsCbvTnMOrn7+m/Pn0UdhQVZGtqIxaDrF+xqIVi4SftNfEx76/GvOYPJzZe4d2KTgASDQa2VIuaCZE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlu0EdtKVBE22hdHCZolyFM1aXFC01XS41as+GPMhraqxx29pq
	Y7E3TB5JlxGzP6g17a9wJsOlg9fposAiXnIjRppU+OtwMq7N24NaTTAxYwEGlRX2LND6dXvRy2/
	9fy5XhH4mzLbnBNYAInC/WyI0elLmFWlKo1gXDeflVkAJTNfnjxJ6eINBgOf4hvJLSiU=
X-Gm-Gg: ASbGncvu7UWLsSmFwKW6oB3CQLDnkG2AcusMAHTjwBVifgLtE1DAFxuYxMF5PUS5we0
	G4Sv3VvLM4MowRMXf3qFkgDPB2eRC2TqkTwS96crmiX44ImtS922WfGFZ5jqLAajXM8Mj+5UXE/
	mY0t/3HSLsqBGmzukjgR1kPy3oEq9VPRqel6mOcKxjSjtVH0g/IOo7qcN6mNvOMhpA8RyEoScIw
	DRm268OcMk2wF1A+NThhid/5dirwToCz/vZQvyqNqle93Qts+BbmirikiasNyrfWLJHqo6ca7zM
	Ll+5fB/M/cxtjQc0EMwqjNwQ4APN5pHzl6913yJda6V95vqaKjALGcJ173XO09ny6xaZqrZ5mHk
	VkjPKClNRTNLyFSH2Eb0ygsjVrI0=
X-Received: by 2002:a05:622a:4c6:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4e6ead390dcmr28341851cf.12.1759924016817;
        Wed, 08 Oct 2025 04:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhzBijvONPiblMY5efLfCzWLUGbZqk/BjrQ0UR7ejEdPzLuUFe2mN6EtMi9WvZDTQu1j0KPg==
X-Received: by 2002:a05:622a:4c6:b0:4db:1bd:c21c with SMTP id d75a77b69052e-4e6ead390dcmr28341691cf.12.1759924016308;
        Wed, 08 Oct 2025 04:46:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865a83f5fsm1649154166b.32.2025.10.08.04.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:46:55 -0700 (PDT)
Message-ID: <fd49f3db-560d-4633-ab59-fa80f9baf698@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 13:46:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] soc: qcom: ubwc: Add config for Kaanapali
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse
 <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-kaana-gpu-support-v1-1-73530b0700ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDExNyBTYWx0ZWRfX2Yel+rZrAz7X
 S8vb4BCpEd/yGtLdyshlDTalysvenQ/s3YdRrPFbbfx+ZCdV2DqPMKiDx9tTvsyxHfqNszXQwI6
 ogAkvf7kz67xQLSfePNXyCL4fXAubvK30972UbTWcnwWqKXxcBrQu1MtcaPnvhr/iYnPR7Ub2EB
 79pkhF2+4F27kMUWtZNPIZggReFAzxmTdEl/sayuINe7fvyyJQAWgH1EQmZFxqLlV+aNE9fu/Lw
 d3LUSPXced2BJYUgAQhN3SaAmJ9FTo3Aghk2sMSY6unX5gVIMwesJaczDNx+6G2R6Xf4fjM7J0G
 RHh1y7EGDD2R2u+4/NTIuh0BKwC456AciKw0l8FBlLqZOXFV59oWcJlL0JD9eTPfofTmuHlx1JO
 n4vma8leS4JAwXsG48EJMctOAnd51A==
X-Authority-Analysis: v=2.4 cv=BP2+bVQG c=1 sm=1 tr=0 ts=68e64f32 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=WkYBtKvuumTgCfpkg3wA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: QJZAEA8y1uSMk88pDMaIlHkNwNXgv9Z8
X-Proofpoint-ORIG-GUID: QJZAEA8y1uSMk88pDMaIlHkNwNXgv9Z8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510070117

On 9/30/25 7:48 AM, Akhil P Oommen wrote:
> Add the ubwc configuration for Kaanapali chipset. This chipset brings
> support for UBWC v6 version. The rest of the configurations remains
> as usual.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

