Return-Path: <linux-kernel+bounces-740587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037AFB0D617
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B83C23B13BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0B22DE217;
	Tue, 22 Jul 2025 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Opxcb8ln"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C242DCC03
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177157; cv=none; b=rnTaSMHyrvM5yGISQ9nD4Yo8VklBa9URb1VWgjpN4w5h7tVszw4fFI1vHP9cGE1zyTPHK3DQit0J5a7Zxa3z02OPxdV03g3fDErL1W4lsywp+2sg9VkPzzc2EtXY6+6b8Nixc8Ny/X9+KwYrUBfqvG8quMcLG8W9+B68/etQGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177157; c=relaxed/simple;
	bh=0X7mSZFr4n9kIrvMvdwIufpEltafXbdIueSaAC9+zUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2G6BBhWaSLuh/k5r0kXOyMbZ57X9jeiWyJCBfflup4elL/nVVlsB6JwCNY23Oh4LQT+EYGjomfNXPShSQVwaHtGysvESFdS9OCAFEdShSRobAgJjHrkuFr+8JzburU2ggOeW0IpRbStk2x9xXYPGpE/6EI/Idp6bvAOGpt/nCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Opxcb8ln; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M83wlC010598
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0X7mSZFr4n9kIrvMvdwIufpEltafXbdIueSaAC9+zUs=; b=Opxcb8lnO+OHyYKw
	mKisAnKlEieMkvCV1KmS3sb+j40YB1jFd0xVbgNTNxJE3ea+w7MGqzjeuiBp8Bm5
	ZMQYzsHiFUFGJeu9YXwDg+6dO9VAhXOwYhyRRQk4gxo13NVmvp2WaXm+Jr4dKUF9
	TCQVzB82HcYF9aQOT9JHfyCs9XX78EDiJRSB1fv6etQD6GXCp53XQsFYpjewHnmD
	wtNhNOCdHJU5PGTC3HtyWYvLTOHNSqZeAb8mtxjH8yzt9zCTcx0Oc+/uSH3CAf7i
	lADDMuUk2aP+vamD51ur0AZrRl/kplc7OzlKh8SyWNfZlNQYmANmRiNsrMtYi/+o
	Ff3IiQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t189xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:39:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748f569321eso214208b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 02:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753177154; x=1753781954;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0X7mSZFr4n9kIrvMvdwIufpEltafXbdIueSaAC9+zUs=;
        b=P+C3LbpiIZbX4Q/mdXwQxSRNDbEfe5fuMP2AydJUFsfUkRUp55sen/rRiZDmCvkYsz
         GEQSTSEtjjWIV/ihjQOsKOBcLCRAKLNzEUiW9RZhHD9T+K3XhnER4djJ2/xHgjJGth13
         y42WGebl3Y7uvtHgujvtDd4GrXe6ALOSt2+WSRWFGoQIUSp2isuNT4F1UlX+Mn7AD1ib
         0/7ZtQ3qyCcGe2MdR3DqiSAQd5uiWqpwpJVUssCfdEX6x2C5UJkC3uyRRiJRTzRdswOP
         BVcCTs6ByJV38znOiuX601E2mUBstf6cNPT+sjR/9S+J2DjWaQrK5b+AQJmfo0ExbeTL
         753g==
X-Forwarded-Encrypted: i=1; AJvYcCX8D068DCZjNKEJks1vE7FBQrM0bD3OEPgp4N15yfWSbsmLSPMRGdfkObbC5PZon12l+EsZq6+pLgmFO/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwnmFJXVMMcEwJFqT99HGCMvuRzmyhTkZnlUQWtxr7IFAc2C7d
	UCH1q98jSFuCjy3R4oCsEMxj2TqsurwWoXJQ5EoNoF3/Nvtdvbbyne3ilXRP0wNoMwVaus478vQ
	HyLpQihn02RtVGdI2B4D6HNWIF0CHbw5HoW39TdyVqumUKA9meEgVA1UZUUAGugmE/6Q=
X-Gm-Gg: ASbGncvbKqk7wjB6bniIciPr0URrpVwkGR1iG6HgZsxSJq91cIleKYHu8ncqThWVTvP
	bDay3Cq237vPgYP3FkwoKQ9k7fCm5W7PFqkuLioS9SClqSXPMTeabVW08iygle01nwK8RTjiUug
	iVpveESQ6hEnEUX5QhpxBvCq1l6hFMr0yuGV7rXpwt1N57c/BdQg+uQ6I7Ar7RQYz3Hn6X+sf+F
	+qDykER+GxtGlkegx4Hg+j6Nrr+Sjh0zYYT6JKh5mMASFlf7RbkEY0wDiMWb//TPbHMA6yVuiJ0
	l0SWjlIJO1iydQbDDfIqU2bx6b77iHe0EqZjQV4HuQZwPMzuN4QRDoHgZGqt2Vy+044iSrBTroT
	9MViB/DKJ/5y1HsR2f7o0oTL4g4TP
X-Received: by 2002:a05:6a00:4c18:b0:730:8526:5db2 with SMTP id d2e1a72fcca58-756e9fe71a8mr12334506b3a.5.1753177153668;
        Tue, 22 Jul 2025 02:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG309WOl0f0xT5Osz89iIc9rjwEya2Gw7AuRefQ4nhG1+/3l19kPlLrow82m3GRjOtFkvaFmw==
X-Received: by 2002:a05:6a00:4c18:b0:730:8526:5db2 with SMTP id d2e1a72fcca58-756e9fe71a8mr12334474b3a.5.1753177153138;
        Tue, 22 Jul 2025 02:39:13 -0700 (PDT)
Received: from [10.133.33.17] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb67901csm7313456b3a.100.2025.07.22.02.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:39:12 -0700 (PDT)
Message-ID: <66634041-0e31-4a1d-9f1c-920ba583430e@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 17:39:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] dt-bindings: display/msm: Document DP on QCS615
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        konrad.dybcio@oss.qualcomm.com, fange.zhang@oss.qualcomm.com,
        quic_lliu6@quicinc.com, quic_yongmou@quicinc.com
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
 <20250722-add-displayport-support-for-qcs615-platform-v2-1-42b4037171f8@oss.qualcomm.com>
 <e15df8ba-f058-4eb2-919c-bc327290e66a@kernel.org>
 <5ec480ac-ee60-473d-83e6-c2f25d3d30d8@oss.qualcomm.com>
 <b810f0d9-b1e8-4182-9551-601b248d572d@kernel.org>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <b810f0d9-b1e8-4182-9551-601b248d572d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jCYMgQ1SFxvgPZLdoWzGyiDnszJF4bFp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3OSBTYWx0ZWRfXysgnz7s5uQRi
 Jk6LIm5pzwEfGUqQkMD6mQ65zyCXJhPgei2/rfOD1eKFV1RRH+Nljvk2+B5rhgZnZ3I+Qtm4smX
 ESWAKUk1y9n8NYxXjwEfPdg9ABLHGkIXKUAImxy+P82lkftUxapkFGdT2Nd/REIbrUBKQyYRz4h
 a18GX0QDRlexu4AFQWiEGHFAhAZ0BNGCpmjyXiw/rHEqJetJpKffw8d9/dLln+M5YMZ5no2f/bw
 cWgRCFUMRrE0RK5jhKimKAZNjuoPhfRMjxC+ogO7YGht85UXPF6gWoq9eeUeiHhvSBmqaQylh0N
 Q3t+aTfSvNUnWe7C3t68dZ+rr0/zClVaSjRcbfhfFR3IdUk3Q5DrXySzBA/AMe9EpD2KcVn7LPi
 8RwCkctiiOPLrOBMqi03YPrIlmTRBQ3v32xErR3bQ/HHTDIbczowcYp2r6D2injSxbbqN/Wu
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=687f5c42 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=YuxCsFRrSdhSRJBAAjcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: jCYMgQ1SFxvgPZLdoWzGyiDnszJF4bFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=925 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220079


On 7/22/2025 5:23 PM, Krzysztof Kozlowski wrote:
> On 22/07/2025 11:16, Dmitry Baryshkov wrote:
>> On 22/07/2025 12:13, Krzysztof Kozlowski wrote:
>>> On 22/07/2025 09:22, Xiangxu Yin wrote:
>>>> The QCS615 platform is based on the SM6150 SoC. Since the DP hardware is
>>>> shared with SM6150, the compatible string qcom,sm6150-dp is used to
>>>> represent the DP controller on QCS615.
>>>
>>> No, you cannot use other SoC compatible for different one. Look at
>>> qcs615.dtsi and board DTS - there is nothing saying that this is the
>>> same die.
>> Please take another look, we even have renamed qcs615.dtsi to sm6150.dtsi
> I checked on recent next, although not latest next-20250716. Commit msg
> should explain that. Any qcs615 feel then inappropriate here.
>
> Subject says clearly "on QCS615". Patch does something completely else!
>
> For gods sake how anyone can understand this?
Sorry，I’ve verified full functionality with the DTSI on the 7/15 linux-next version, and also checked patch conflicts and checkpatch issues against the 7/22 version.

Based on your comments, I noticed that the DTSI rename from qcs615.dtsi to sm6150.dtsi was already merged on 7/16:
https://lore.kernel.org/all/20250604-qcs615-sm6150-v1-0-2f01fd46c365@oss.qualcomm.com/

I’ll update all related descriptions for qcs615 and sm6150 in the next patch version, and reverify full functionality with the latest linux-next image.

Thanks again for pointing this out.
> Best regards,
> Krzysztof

