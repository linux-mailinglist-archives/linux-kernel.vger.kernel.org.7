Return-Path: <linux-kernel+bounces-873084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB0C1308C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758B11A27476
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6406529BD96;
	Tue, 28 Oct 2025 05:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Od5+Q6EN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37439277819
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761630907; cv=none; b=PJmJDO6V3Q7HSvY1+nR6XnXZNIUpw5pUcb1DqJogqaOFsVC88Hs8lc7Gq6lt+Zos0N3dHa89FFeIodGuo1nODXW6JkVY8I++VvacjwTChdRKIb15LyHaPChPR9iDf3zgEBm6Nx3RCilyanc9799hXF18V2ePB3lRl4rztHiHxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761630907; c=relaxed/simple;
	bh=wbrzyQzJ/ISMxfjHCPJo4dCOxW5GR5mv8F3Pvly+tfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZ8J0/TrI2CGXD6G9frryicLkpIEoI4qGq+jXBSWXUd+tSWsrkyscCRUwERPwpYSeCpey2R6fO748cjFMCknV3x4SnQh/6LkbpqwyaVpF0HIOMyX4McFdDd+dixRPbbtIaiq7CzX0lh17eDdPZS87N5JD1O4kq9xHJPjqZjbvng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Od5+Q6EN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RMDPFi2752101
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hVbVyBqtSeMwHa5ZCMjstEwuUlHs1J5AbZsAqxmUJpM=; b=Od5+Q6EN/hVcROkv
	68QhvL9ePE1pHjnXWh+zV9xtdoG9kqSXFOH2ATTmCVE2mHk5ToP/thq7TldSQHJZ
	nx7RovXoZL7Qfmap5TTVF10lORG29RNRbed7jbaq0rS1RGQNNTVIBIJYHajuUB/m
	EituOtTvHoaWS42QNop+O8QvhZJ/P4ndH4vH2J1Bb/sj6Az8YsgUYTVMy+bpTeSD
	3OWQDjccQoBpbj9f6mWDLjk1Frh3ZBJ3LTpeavIplBzLLVXduP1GREB6lAtHfjL3
	mxiJ6s3qPTeTZfZuVkiEZl79DNr3bvmpGMGa39W4Bp5OtG/lBJj2E/fd+At76jaV
	bw7PcQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28swjt7n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:55:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29085106b99so54007935ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761630904; x=1762235704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVbVyBqtSeMwHa5ZCMjstEwuUlHs1J5AbZsAqxmUJpM=;
        b=QEyD6/aG9yo0P7DL+o22FQGU3ez3nGCpGt8ai32t90EYdNgNhTBOSLVucKjqfAjKlg
         9p+2ED7NTEfbxJ6di4/cecv/BKYOFrC2n+Loc3mtGVRgjgo2j7tyk+9HZGW0VX4YwRRe
         U1ACf7ozkDWZecpeUYSoiv3nfK09Wn7CU/gQbAN9B/qetKtxKge8pHSofyI/0fQb0wWE
         yqEDl41bufGGGic8DGqXvC4yAhVfUHSvtzEvN/x7FL33xSAyVDJ34ZuZ5KdDEt/zN8C8
         Pab826MWOHB82zPs6gT1Gr3lVCB6c471KT34Ct7XI9LlUN7nnbc9xMSXlu34Uwyz68ek
         6VQg==
X-Forwarded-Encrypted: i=1; AJvYcCVFPf9qOJvi/56DlMrfS15RnaEAfgn1JTy/f1FKzhJGjsvOmPR4wJ9qPuMSdvM4UJx191qmcj1O5PL+4Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRvsVMjF3Qc7FFGBdbs3UpYoROi8UkloxlTo7cv5S7M1kZ85L
	FvBRW8f6RwfptQwPR35ZpCAIaK73wd/DDuDhDNceY1lTaa79j3IKMJNFkVCyRuIqMuYgbEmehy5
	bkf6hgja2a0FcGWcqufPDETHDKfgVwr/cTORt54myC6aivSIrFFqs21vA/DK6wOYjdHE=
X-Gm-Gg: ASbGncux5wvBHa8arzSQFu97mJYeQfW2sqZ+hHH3b/QI+Jp0RNm+Y0DtX9T6zi0a2V1
	C0tjdEEFCQNMy3272Ntmt/Xl/COxkFnlO39guM3Alqi13s0VeR4DBybFJVONW/uvKaycmbLR0WW
	XQPxiId7BhuuDRrmMzsyHKJdFjuAJapxK62Eogfe7bxQHwKNG8VgH6EEZvSUDgdgMrxcKljnx7O
	ExDCJV/B4F4SEWapBzQbs+6Qv8Vff6vwGYkMBwCPGOsYxuHVsddRDnljJgX2K3GKseJ70UMHcib
	a0RAWlauXFJqaD8vG5YqmEdVUAmGQLs1xnEvKfPT4PnqwGzmkkgiMVRja7EpAqWLBUIOTB2TDsA
	9t7cWZ0akr+uNFniQfC/RnZJEtrX5d0uFzX7EcoalYTXdxiDZSyXipiERmFy4jolX+hw/e5M=
X-Received: by 2002:a17:902:cec7:b0:290:9576:d6ef with SMTP id d9443c01a7336-294cb67481cmr35489585ad.54.1761630903950;
        Mon, 27 Oct 2025 22:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlNN7tbxAtF8QwpzLzr8V1BNKo9CW6ELJvgyAYmlxy+kOCt0Ww5BoZG9W1Wv8WH/BdO4oLiA==
X-Received: by 2002:a17:902:cec7:b0:290:9576:d6ef with SMTP id d9443c01a7336-294cb67481cmr35489155ad.54.1761630903456;
        Mon, 27 Oct 2025 22:55:03 -0700 (PDT)
Received: from [10.133.33.222] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3405sm104695945ad.2.2025.10.27.22.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:55:03 -0700 (PDT)
Message-ID: <89ae527a-c4b4-4294-93ae-e9afffb11f7a@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 13:54:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/5] dt-bindings: display/msm: Document MDSS on
 QCS8300
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar
 <abhinav.kumar@linux.dev>,
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
 <20250911-qcs8300_mdss-v12-3-5f7d076e2b81@oss.qualcomm.com>
 <20250918-spectral-seahorse-of-witchcraft-69553c@kuoka>
 <b745c515-2264-42aa-8d92-663efc7f6276@oss.qualcomm.com>
 <6c195b42-d994-4d24-9c40-48d8069304e3@kernel.org>
 <rkuihu3pmhexeahfch6j7bvwn5rn4ecccbhamluh7fas5qgaup@av2foeiwmcz3>
 <8a6861a0-f546-475b-907c-65b691d1d340@kernel.org>
 <cwuecyparlinhtdqckff7vdqpkio2kk7dwemzfao6qkhnuzhul@mfyqdphfvbdg>
 <drmrkeukgua3w4p3jixdwq6dvj4xj36vvgk2kvwvhpqfk6le5g@tschh7rpsg4a>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <drmrkeukgua3w4p3jixdwq6dvj4xj36vvgk2kvwvhpqfk6le5g@tschh7rpsg4a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: PRcRgujkE71cPu4U7tOIRM2VqkA2hDLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA0OSBTYWx0ZWRfXzzT6JEpTCBxh
 0/9iq9TQJvy9ruFTQ0Mu1rD6r0i5oeWPYE1K4ql7aoQZy9yHnZZQocteEvdnOPIn99awNCZMaXT
 yHAY5/M0d7z28estbOTfz2bChxSCNZgYNHC4lzzg3xGJuBUwBli/n6hZvr39UnIza5vennmeok9
 UFZ1KCnIGF+ZzrIg/Tf0zHZ7qAS+dYkTvzlk86sqbSDxeCXGiidhmZB2DPLJlK2cUhGglY6hNEl
 VBlQ5ln5GajIe2Gg+qnttvAerFIYgNbYclQhL9jYGgORln3o8rCWt+czG5GVS6SRoo1eOSub14F
 5ju/KQaIGYeMQNQ17gu0RJzQgiO6ha+JOzu2QnV2PrhmVCgYOectBtZOFXnYjjB70xUw9xA3Y4z
 3caGecadXVqIOebm2PcylZXPBP4C6g==
X-Proofpoint-GUID: PRcRgujkE71cPu4U7tOIRM2VqkA2hDLV
X-Authority-Analysis: v=2.4 cv=fL40HJae c=1 sm=1 tr=0 ts=69005ab8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rkEqYQ_PoaDmHDwLzVwA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280049



On 10/27/2025 7:52 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 08, 2025 at 10:40:39PM +0300, Dmitry Baryshkov wrote:
>> On Tue, Oct 07, 2025 at 03:43:56PM +0900, Krzysztof Kozlowski wrote:
>>> On 27/09/2025 08:26, Dmitry Baryshkov wrote:
>>>> On Fri, Sep 19, 2025 at 01:34:39PM +0900, Krzysztof Kozlowski wrote:
>>>>> On 18/09/2025 13:14, Yongxing Mou wrote:
>>>>>>
>>>> process in other patchsets and in my understanding on how to describe
>>>> the particular hardware block. The changes were reflected in the
>>>> changelog. If you plan to review this patchset once you get back from
>>>> your vacation, that's fine. If you don't plan to, I can ask Yongxing to
>>>> send v20 just for that number.
>>>
>>> Solution for me could be to ignore Qualcomm patches till they reach some
>>> sort of maturity.
>>>
>>> I am not planning to review this patch, because:
>>> 1. I already reviewed it, so not really necessary, but even if I wanted:
>>> 2. It is gone from my inbox...
>>
>> So... Should it be resent to get it back to your inbox or should
>> Yongxing just restore your tag on the grounds that the changes were not
>> significant enough to drop it?
> 
> Granted the lack of response, Yongxing, please send the new iteration of
> the patchset.
> 
Sure. Thanks for the reply. Should i add back the reviewed-by tag or 
just resend the this series?



