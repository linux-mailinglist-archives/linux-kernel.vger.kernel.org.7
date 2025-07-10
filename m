Return-Path: <linux-kernel+bounces-725680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F93B0025F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44FC162E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF40E25F96D;
	Thu, 10 Jul 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hFU94fcN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689A25DB0B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752151618; cv=none; b=WLONOiZqqqSOkJj1+ps2+PlNQN+Jye60KgoN/4tzJ47GHEemlxvejSTpo9apnmKfvA3Q7wqnImggLSGFoUPzKI+mojPQ9zAC9vGLtPiOuKwRwHsonQuWypHVRjbqLTvPN67km4T1aWPm9E/m7Gv0UUoEceTqIACTPjgmDmvwR+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752151618; c=relaxed/simple;
	bh=na+u8g59eooGkQR29QZfM0thwy/I+CVeSWbBhPqsdd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ea/hNZ5P4M7125da1+PmQMYENrJ2dau9kyDtGD9Galvz3P5GqU9UT7emBNEuwMQsBGPOz5FTVJvLKeMSnSyRHzZ2j4C6+TZM3szJ96kbw4QuhWqwsI1vd7rGywLqvmV6ePkWJe44nEs3q0Njy1Nhd+V5mTun2Rz3RpDXzvinHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hFU94fcN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9YAvd002616
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JtA4kuwweCCzbSwKPwc94SCzNcShIngig3W8sfl7IDU=; b=hFU94fcNH0RxHwCg
	HFGHrz6MPMYYMndzbGlACDmvwsDGTYSijgIVdSvK1+4Q6rm4k7EAh02keip5wKfv
	oJ27WAMVSi+ZeYZSjdGXHj5aH9XnBsptU438zEAHuzr1O9J8drCeEJ3muG1qXSh3
	/MlAPX9kqou7Aj6Q6kWFQ+mXImW4jQnmweZIKVzUC5KYA/0bMPm8qPWeczWlf/6U
	DYKCMmowZznvWV89fjL7N8a9rgDK/e3L7n4iB5pVv5ccRCtFMUGkaBrR5VfgiGrB
	YQG892Xi12iv70HKn/uPZn2RS8hwxz0vhG/Hxe6nmQms38szSwQStWYvqsKkx7Fh
	/6Bfow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bg8j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 12:46:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d097083cc3so24418285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 05:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752151614; x=1752756414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtA4kuwweCCzbSwKPwc94SCzNcShIngig3W8sfl7IDU=;
        b=sth/yogzl6gVExafca9U5Hl5HAg1YA0AvesxIFpZuakMTRSJtzbZ/1GjqOqm1xgt/n
         zLLBrsVSU3nX4LccWzh6apcVH0ZAuvDIrGFF91L8vink1Yig8iWyQYwjfLQxHMMcsmyC
         LSrINyqDVE96xvDesVIsJR4Ti+Mpgci9+usuNmkyfcFpmWuX9dAnLxNQ1t395EDjq6nQ
         aiS08YtOl2NgVozXrGKvqMeqYjCb0cItTRN1CGeSVpQXHRIlSbhVIb/txXksFrmA+Xu3
         6MZ0QbjVspfU9TOJpxNe7e5dH7xhkM94MBFO7xurqKx2olVQI7vytJAP+kUib0gpjQGg
         74qA==
X-Forwarded-Encrypted: i=1; AJvYcCU4rr3v5AF3l1AH13rahKooMp0prnMMF2l8fGsWG6Kl9fDfNZxRP9MieXRgq42T/IVHsjZflSYxzuXa9wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo6s56eezga6lV4/HmnR17loXkpvD7GE/eIo/p6fpOyxRZNwvp
	UN3Rl9MX4U/3e1vTGXoI2yqb9I9NYJ3ZEgkBt4A4IEuhxoRfxdHQehjC6s13zqjGFkRseqwQm39
	U2UiDjgGoXNPqzSPF8wAECFBmFYMH8dwLFSIJdvKacVLxQ1u4oZVW+o1NgW8H2/jpEr8=
X-Gm-Gg: ASbGncuisDXeOgIjFNkA6NJ6FJe1eAjVBGfzioPTByQqgxNCwYYcaM5ubDZsUw3YhxQ
	EcjPBHSZe6aDmW5lbZ9ljP3w5BmohUvQRperSl/Ehk3HAWaWl9u8jOs7dquybXpIcSBvZng9xDm
	TCZNuBgOwJkIR1iXgRpntCSMcUfgBQBMrryywI1DQoQSR4g5w7lym9INxz97stO74olyL03ee55
	ETgGctTUkHNmgdEyp2z1OuMrP4D3qJPQjoGyY9kDnYDV4E7xnx5FFImdrjqR2AbgUvxypCMArHf
	Ci9/46UvewOpGdT/kty2FyyiwRHkjKwyRPXge8sFOCPS2iCMQhb2InyE24eOmgM3AjdNy45XlfV
	21O8=
X-Received: by 2002:a05:620a:488e:b0:7d4:4aac:33cd with SMTP id af79cd13be357-7db90552afbmr345643285a.13.1752151614540;
        Thu, 10 Jul 2025 05:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2fKFA127cNTfsAIaYwVMHS86Ycrn1vr4U6fqBaR9/PrG8hz7GzSfVNTjRbbEfFWJGJLsDug==
X-Received: by 2002:a05:620a:488e:b0:7d4:4aac:33cd with SMTP id af79cd13be357-7db90552afbmr345640985a.13.1752151613874;
        Thu, 10 Jul 2025 05:46:53 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7f15803sm127935166b.70.2025.07.10.05.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 05:46:53 -0700 (PDT)
Message-ID: <f80d4e32-0f28-4a90-9db4-05c95e260658@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 14:46:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] bus: host: mhi: Need to honor sys_err at power_up
 state
To: Vivek.Pernamitta@quicinc.com, Manivannan Sadhasivam <mani@kernel.org>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vivek Pernamitta <quic_vpernami@quicinc.com>
References: <20250710-sriov_vdev_next-20250630-v2-0-4bd862b822e8@quicinc.com>
 <20250710-sriov_vdev_next-20250630-v2-5-4bd862b822e8@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-sriov_vdev_next-20250630-v2-5-4bd862b822e8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEwOSBTYWx0ZWRfX9zWuZ3/Xyin1
 DUpJlKFaLjIb9GsSN30L4B+vB7a79Pp6h9Ir6m8cxpJilbZZaxT8a3VGbuNKZdRu8+OChFn52Tb
 dN908bZAZOq3YJlJBYQ+CljVDSNxZPskcTwYsjHN+yQMwuObMGQweYvfOjYX0+o51nj273bhy0K
 R73e73icqrHh6ubYNo1hgGjbvV5M8BeUnDLiUtq97FDhEe5fTNzV79n41RWBzKWqi0y127f5wY5
 hDVJmLiE5WLTRfMfPBYg9JeMr84Li5HvXsTRGeSEC2Os3gHLiLpuGkzfSlhcAIwtTZ9yODVJE9f
 +XHnUoHe4SZLITTilcYn4y+V08DA2wTWVWu4O+kmGaA6MGrxL+XWkYMu94eLCkY5KQOVL2NyRe/
 DU/zXdmfre685D8RiRUmfyXrezyKAjqA2excu/XpewAW6pBBqqP9LKhTSvXmVyZA0BUcrm0r
X-Proofpoint-ORIG-GUID: lHFIIVZyCxh1Y318Hbn1avqvvQ85qMss
X-Proofpoint-GUID: lHFIIVZyCxh1Y318Hbn1avqvvQ85qMss
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686fb63f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=oYOKNLqQD3L5wEaBywQA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507100109

On 7/10/25 10:58 AM, Vivek.Pernamitta@quicinc.com wrote:
> From: Vivek Pernamitta <quic_vpernami@quicinc.com>
> 
> In mhi_sync_power_up() host waits for device to enter in to mission mode
> but SYS_ERR is an valid state, If device sends an SYS_ERR host will bail
> out for wait_event_timeout() as MHI is in error state and if MHI is tear
> downed sys err cant't be serviced and mhi can't be recovered.
> 
> If there is any SYS_ERR, sys_err handler needs to process SYS_ERR state
> and queues the next state transition for device to bring in to Mission
> mode, so mhi_sync_power_up() needs to wait for device to enter in to
> mission mode.

This is very difficult to read, please rephrase the commit message

Konrad

