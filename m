Return-Path: <linux-kernel+bounces-833791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB12BA314D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638CD4C6D05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7977821D3D2;
	Fri, 26 Sep 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9oB+WLx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1D2750F3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877890; cv=none; b=CC4jNk8bFNi97FulyfWxXdNGk7Atmyll8WaL2S3E8EHcdo027QD5VICKt0jB/WdOx0PP/l6u/hekzlthMeiVKOyM3i1hORWoqX/4gna7ckz19GTtb3i3ALvy9qiQs3ESRz4dxYVBS6AUUr2JPeWSIl7vJ10CQm82ILnHcHc60ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877890; c=relaxed/simple;
	bh=Q9cVFgVDTi0yD7DcpxpXPEPBn9ZNBsja6Uc9akvcPeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISYQ4oBihKZyM+B04DEgbYh1FFTT1ZCP/5etlscug0bUBhO6wZdf4xhkiqdPDvIw4aKqmKnH4b5QH+98z220gaSsgQ2ihI0wLxxd0Q+9XI7ca7iLb+v6FNJ8ks7JB6kMHJEi7dZZp4S4RdQjbQ1dr0zIo4kTKJAhQp5vZG19aAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9oB+WLx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vciZ011609
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gwMS6RiPyG3muvL8gIEP/IdyDMuWnY9zWPsqgfT3jmo=; b=F9oB+WLxy1WCJolY
	iB/ozRPi7vxUVIRFRX3X/ivZ4qQXI6SmV1PMp/HN5MO/laRuVL0oe3s+eSEdwyZx
	/HWxVHMJ4qdHVTnNZqYRKFXaB+WXSfslX8zPnWIm+mb+0DoETeAsXohp837HzIBb
	cQLRno6uFVWLieYc2fTgJ/mILdVqW5Erw7ieelW/RmgqG1CKvtrc8e5mtxMCFU0O
	TqpV54PPNaniH4yGkrbhXWeigTuWf1VEQOK5900tHbkxH8aEoN/C6noGQaKaGXgK
	Vly7x9/wXGZGoHwvQrX57iSsYuy97Vw9OpBeJ6Yr47XYHbpvbKDfXK1jL9Ww3t1A
	jyY/yA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0q281g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:11:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befc3aso2183860a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 02:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758877888; x=1759482688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwMS6RiPyG3muvL8gIEP/IdyDMuWnY9zWPsqgfT3jmo=;
        b=eK+QIAaWpmfingFQi0OckAIHOlPDnkO+Oo5dWCy5iPGNyLaCrkwv8mKegNNUgqvxKb
         LYPKcIMNCFxBcOLQHo1c3UJ0iEHmxHjvQQ+XzqlakA5uG7BvRyF6it/QEarZntdpAjYv
         eYvm1i7Mtgu/VttW5rG3rx3IlP1sTovvTkSfTgOJ9PIctC1fP9GQcX3I8X/qOFrDT0Cg
         ibPXxCVgRwPV4ClMzq0jGeOFqo/v/ZfQA+BawZxi5KuIGMLeQMfjYosP+6cf0S2kUqSk
         WmYBPxLiKgaYSWJokDff9xAn8vICxzBqNRFj0OOC1Z3Gbop3104AQEPbqzHsbUWPb/hF
         OMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsuY6ppML2CGIJtF5xJNRPNsS9NuLSDntAS3PMIk8xxFt7czNQNwFB2At1wFZohNV639Rzv5tPJgA/85Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1pk2yBgMoGbuwXntrh9fFP3J60YvGLIv5s8RFV79KsoFE6Fj
	0LOC6Jqp6OubFsuJGeSNVswtca4WXcEvtDHuAgvLVQAUGNAM8GdIKLCTUDMch7SGTxNExHAcTSP
	1FJWOHgtqZzak2QcHPiZD9oylK9P9/jaDgq0mBr/v1XzL4xnYTJM2zH7V8y7ZjUhRutI=
X-Gm-Gg: ASbGncvC6VVw4aSJFrkzfF6V2p4rSXQFU0S0IiYptQyBpEnMQ6uWuynx/DqbOSEGsJS
	VhiExqqgiZ658ritMsVeu1x4qkDreiFzxQLs6vkYVdAVK+yuQlxjG826h6Sdxbbbq1LVmm3Mlm2
	2VK+s3IAT2l13rpKWAJOcdk0uPDaXdpp+B07sl/TUIRJj/Vh2gpvdDRL09WdpvvsA9jPpj1+HST
	u5RE8VaCr8AJxJLkoM91+5B0WeZs6pBRzMNDLsNsBQBhivE2WFn7zwfd8a15A16e9yHMO5+xiOe
	i0Ff+u+wMJ+pnitr2mrm5uoaCIfeur//6atHUnwa7ipeNp1xvJ+wETrErhTECdbqGhX7m+vwpwH
	ZA+eKKq6isJdPiLCkz2sh+e7zlgfxyxjB8kZ2
X-Received: by 2002:a17:903:948:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-27ed4a093cdmr79278925ad.11.1758877887581;
        Fri, 26 Sep 2025 02:11:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqnSucq9QwwfydAdBOvQY2cA+Yy4I6IVDVeZYCo0AArAOV4CXOKIvi2P5d2LMNwXIVWHyGeg==
X-Received: by 2002:a17:903:948:b0:24b:1625:5fa5 with SMTP id d9443c01a7336-27ed4a093cdmr79278595ad.11.1758877887091;
        Fri, 26 Sep 2025 02:11:27 -0700 (PDT)
Received: from [192.168.1.10] (syn-076-033-021-145.res.spectrum.com. [76.33.21.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69b0685sm47455865ad.116.2025.09.26.02.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 02:11:26 -0700 (PDT)
Message-ID: <60c65d7c-1564-40a1-830b-1c9931776fb7@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 02:11:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/20] arm64: dts: qcom: kaanapali-mtp: Enable more
 features
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-14-3fdbc4b9e1b1@oss.qualcomm.com>
 <ejcchgc3isc5f6tmiqbxqihmk5efmbcyhv3ehuoerb5ulkd5an@g7a2wc422l6n>
Content-Language: en-US
From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
In-Reply-To: <ejcchgc3isc5f6tmiqbxqihmk5efmbcyhv3ehuoerb5ulkd5an@g7a2wc422l6n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: UNglbsJaWl5kP5riiDicYDfDbivaYJ9B
X-Proofpoint-GUID: UNglbsJaWl5kP5riiDicYDfDbivaYJ9B
X-Authority-Analysis: v=2.4 cv=aZhsXBot c=1 sm=1 tr=0 ts=68d658c0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=jL+KNGaHzx0ZtsbCBWd7sw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=8xtE-M9Tj1n2mnedfNEA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX0aelloNFCB56
 MOUZPYmXd01E4SIDHoFxuIE+oP9ePGrY0ffrAu2wWaRUBhg4RS6kCrPBeLfwQkhYs++3qEQlkAe
 fWl7hVmATvEf9SRj0Ammj35V3TYuZrNA+QfsBhKTUX/RFVojJOnijP719xGqHXSS74eVyqidEKP
 asEd4F6igKMmAAh91w9NwiJza7CFIc+sCFR2QF4+DGi8LU+P4uJZeWPQ30JDqCVXZS2bXzbJ5V+
 UP06zKG6teeTWTf1hRIyD7roQQcDzdw5JhpyFLGcygtQmunB1fSnwRGK1MtkZ13u7CBMhKXa7Rl
 Qx8sGGoc5wgjYnRKQQbGhZJU4B5ttpRfxhbpYCwclIX9OsctxKZ3gGtDVXUqpAhiYq4o0/uf4BV
 CoXK+5q03GWwqK0y0sQFKsxfUleLVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171


On 9/24/2025 7:09 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 05:17:31PM -0700, Jingyi Wang wrote:
>> Enable more features on Kaanapali MTP boards including PMIC peripherals,
>> bus, SDHCI, remoteprocs, USB, PCIE, WLAN and Bluetooth.
>>
>> Written with help from Jyothi Kumar Seerapu(added bus), Ronak Raheja
>> (added USB), Manish Pandey(added SDHCI), Jishnu Prakash(added PMIC),
>> Qiang Yu(added PCIE), Yijie Yang(Added WLAN) and Zijun Hu(Added Bluetooth).
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---

[...]

>> +&usb_1 {
>> +	dr_mode = "peripheral";
> 
> Is it really peripheral-only?
> 

For this initial submission, we haven't yet defined the USB role detection
infrastructure, so it didn't make sense to include dual-role now. The
controller supports it, but without the connector bindings and role switch
implementation, it would be non-functional.

Thanks,
Ronak

