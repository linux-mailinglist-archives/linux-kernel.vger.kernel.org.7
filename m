Return-Path: <linux-kernel+bounces-862506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2D2BF57A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA973B66CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154732AADF;
	Tue, 21 Oct 2025 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PPEXYGax"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC02E762D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038517; cv=none; b=nW7onlTUJECo7nJPFCpIQyoN8Tbjf07ETAGx8J1AeKSGJxfCvYUyIwk6X+3Ycv1EbIB1NE4mtBVVIdBFayOMYOq7KhMHWyv7AtbX7z8oU30yveQNCIdes+rmZho5jlfvvE3Qww/9K6vViy+M0uNN96tBL/Nqfy5LjVLR4ijGlOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038517; c=relaxed/simple;
	bh=kFNf9brByz6v5/4GXE00UOetHqmlffTFffnrz4dzNy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TRpZqm8BQGQjUB+9w6DfsE8fowmZwccvdFaPE+oQobA/4R4YhvHtY7CY5WrEfL7TxXcGUrFGTZi80YZruGzlAt6muydIfbZL4/WZjhLJ6c07B1GPILyloUHg492RnDTstvBoaS7frTAMitbshrxCFhRTNVJ9X2ledDCiyUadUMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PPEXYGax; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8OdkC024237
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gtYgfBJiMiBp1ITu/OF7uYQwL1eNKdtPSXCX6k15khQ=; b=PPEXYGaxg6HgnYS4
	pID3Cvgf1vrHAo6whXQSqPz5HEYgczqmuNMybSojMbxt+dkucqgzJoodUEPOlL3s
	l4xoc7KNPWDo3VYnt+31ekIiDgoDWSiYvzgLo5P63VXkqC1l5fMPvlkgl4MxDBxi
	cNvZlhoDSaSWZowEbSlJMTLWXqf/gRmCz3amorDn1Vf/06fg1kPx+7SCP8CoZymH
	cs1QYfWEXUxbLPvpJju5LR62nXAhiAmvVsbcLZbhNoi2j665vhQUu9nQys4RA30E
	5nXrPO/7LLmt7dn8PXH/YivfNAJ8GnphdP9FyLr8u8LQfdUJlh82wWyRuwUDdUwV
	eJDRKA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w806ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88fed0dfb60so196694585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:21:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038514; x=1761643314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtYgfBJiMiBp1ITu/OF7uYQwL1eNKdtPSXCX6k15khQ=;
        b=hExpPX09oLSQBvzVMOOzzhA/eE/99gPtKi8mhl3+g5XPa3AqSKuhx43RyQSDfzGqc9
         bUUHRwhLnW6rbrEO4XO2b3FgUtc1skZyoH312t0/BVEJVb++Q3OtzBD6CetWoSrRufi5
         8eu5NtuvtqZ++KaNjZ148CMCQXT0iR7M0Tf6itDsWlxs/tQXDjjbBBl9QqT+D5mUElD6
         WOMrJQH/reQLodd7sKCduJpy/Xa5JP8HBfUODlR19SvM7ckuTZfJqN5B/kYVCYbrLrph
         RXfeoWGWcdfMyWq85h5EqZxYyj7EQ0agOKzvsvEG920DaNGl3FTG4tDFzNv9yL79QtiV
         /qaA==
X-Forwarded-Encrypted: i=1; AJvYcCWT8z+HBI4ZKGwLCCEZVbqZ7ruQSGZg6rDeg0qWOz/gCBWhZT33ZaSnb0JEe940kKv566PFqrKxdVSgd0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXTn+6fm0W63TA6x2L+cs/EXNK2X85zHufsNCh/MYe3MNqjjO3
	fNwp502bZ5kmlsY8mvt1oj3rRigJjTeMM5/W7DszXcwgP2ojY80FkyWeucnotTBWXQx8Fso5O6I
	P7LDpuo4chmof3GPj9Eq5hE2qpGRGWCnYGY7yk3Ogp9hDaXw6EtYHGoN/yKU77VWNBtUAbhxHl+
	g=
X-Gm-Gg: ASbGncsdM88Po4MMHWk57ELBhlDYMc+5WelMvmsz96nuRSveHVY0JvBzQOVZfYBeISE
	kesr3VaU0aZ3+UMDP0+5GXYxqWRrX3CYs8JQbwgYT9o18Vl3o9XDyibNlSUTX2fpnFtr7/eYZJ3
	s71FHluhxL630w/YynrcKICU5tA3VbbZxnpsOV5w7dIYa1As3zyVAs0qIuCMav3Sz0SADeO+UvW
	AH9dZdpLnM7WxtPWmCA7CJlYFW6+Gv4NC82q01/PsxrXZGIOga1shAH4S+3KI4HhsEYRt2csJlR
	ZcQf6LYHUlLCCIl6n6mj+8ZyOqkMIxIDv7vqzUShcZcosi2uMCD1v5xdjLWJKJtIb7YUOIKrTFO
	0tRrDIZXDk4PZgu/5URM2XqISke+k7foVc54zMuZubWbwQ/eE29Io22ga
X-Received: by 2002:a05:620a:4556:b0:862:bd48:923e with SMTP id af79cd13be357-896e1f22803mr204773285a.4.1761038513681;
        Tue, 21 Oct 2025 02:21:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyRgyrhR42atC+DLLdSulKMeyUrebbaa2AH53YBYgQ1Ndfz9lEI8czuvc0fAlmCABfGCmvBg==
X-Received: by 2002:a05:620a:4556:b0:862:bd48:923e with SMTP id af79cd13be357-896e1f22803mr204770785a.4.1761038513109;
        Tue, 21 Oct 2025 02:21:53 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8581780sm1010151266b.31.2025.10.21.02.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:21:52 -0700 (PDT)
Message-ID: <7bed8dcb-279d-4bc0-bc9c-706ab598bb2f@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 11:21:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: qcs615-ride: Enable DisplayPort
To: xiangxu.yin@oss.qualcomm.com, Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
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
References: <20251021-add-displayport-support-to-qcs615-devicetree-v5-0-92f0f3bf469f@oss.qualcomm.com>
 <20251021-add-displayport-support-to-qcs615-devicetree-v5-3-92f0f3bf469f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251021-add-displayport-support-to-qcs615-devicetree-v5-3-92f0f3bf469f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX94KLpw4XHRou
 /hb09Qd1O780IQme2/NOam2hvQamZpueTgMTsEmXAoGGVxkW7C6JzqnhavAi1aKA84ihG0BKb64
 zasTz2mKRYoX6/+EUAevrnGRlNlunGMUxbBseGzOy747Dnef1GNDWrffTJzsu2VacjKKry3mw+f
 YxA4+VRKDcsvFvK91HiuDK8Cco8OHrs/zobkWkZn+/pXk1NliMi+3Q/TlViEOX2X2M15kzZdemN
 nJPZQnAO11gJdD8pUW9alNKGqKB+zggJkWtiy5ypu0+NkA8ZWRAzLI3i/2eL/kMsWW0DNioePmP
 2owWhy33AL4Ueg1yy8V8TbJW/CvTo64iLoT+VPTgf9S4TItfw0Xq8ZdyRxjZX0cZbQ4qtietcUy
 TNf9605pLaRnbXAl9vjD0CccCh4lfg==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68f750b2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=jvkLkXCew81jr3KDB_IA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: UTgSpoyk3-w0rulQKs0V45j6Z0ejTOy5
X-Proofpoint-ORIG-GUID: UTgSpoyk3-w0rulQKs0V45j6Z0ejTOy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

On 10/21/25 5:18 AM, Xiangxu Yin via B4 Relay wrote:
> From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> 
> Add DP connector node and configure MDSS DisplayPort controller for
> QCS615 Ride platform. Include PHY supply settings to support DP output.
> 
> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

