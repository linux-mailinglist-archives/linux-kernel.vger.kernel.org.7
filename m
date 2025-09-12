Return-Path: <linux-kernel+bounces-813911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 514F2B54CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F01674E1109
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0AE306D2B;
	Fri, 12 Sep 2025 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKF/LsS/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B63019C0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678593; cv=none; b=j0Q5RF7t3TIMInO1FgwR0QFAtb9GyyRmohyJGCRL+Vg/KUPyQfaHJQlXLT3QD/qw/RNfRQqddM62oUp2QmepTQk4h4EShUhzQL/hznDiZjBGIVrAwkvDwXIGDyIgVEngaJ5bGwthaiKHXwDV8Y+JgFdsbe6qUhisPYcf2WOBPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678593; c=relaxed/simple;
	bh=edwJBANlYBATMWqJfznmjfQe9Te1sboPmlsb4rcp5wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXcr1uNgdld2wIaARjlK04nN2XsKPhjvsgmWCw5jp3c6+Lg5rVjFiGrjzZNnOX9N5ZKLPFSh+Ty7supKTRFrZwfnjvgn/KYiVbAPYo4X48NvXR8x+49lWqyg6EaPX0dXMhKPjMdDn1dwHPKD7wc0PT07YAPXp4K01fBPF+mCbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKF/LsS/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CBBR9I017560
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zMKtRR1gvr98NkFlahada0nc1pCDoOH4s0Uqq/hc/XM=; b=WKF/LsS/PAUWM2XV
	I1POHixo3Ch+L34iRRQ9hJZf4lUjKxqL22xSH/dQJk3dm+diZB053n756JOTq9MX
	qAbeTu2VcYx+0bN9xLevJI19AnRWr7O6PZ5gQzGW1jgnhYdm77qR8KeJWCigcvdW
	4WNl7IJaf7CdKtyzK9dyIsk5pSErrCEIgLNUw05hdHtN1izh3lGaeHVA8YefwlPu
	hVLLG6ySFRFT4HVLLyywvm1ei9BIrlisdVK2b3GJZpvryZjCjN0WKDFPyvOGW1zu
	ykOL1P3SNSnL3prr6NDwIm4xi55i0pj73PHhsLLBt1haGjYFL9KthsYrEVzJueeU
	t51ydw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494jdx04bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:03:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32ddf3d2d4cso222578a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757678590; x=1758283390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zMKtRR1gvr98NkFlahada0nc1pCDoOH4s0Uqq/hc/XM=;
        b=kQxdB2yZf6VHWm2H1ptxUTWepX5RPV0pU78MuwhmLuBKdDQGq01e79G987vlyZMbZ9
         fbgiIHNx8TTFJRZ15/puCVsbbeqXyif0jemPggR2yxcXai/vCTEjHE6nlIkrrSbvQUpT
         L9AQNIKJDzuW7fl9wrQeK/GFDPUpIyRD31nodBsiosQ3fkjH9vxw5gqsDtgyLzc4Q8Nb
         VlrJCWOte/KI2ECG8NF2qF1j6dfl4jY8ThaCPKegd/DtyLQFWWIlcnJpesoHPXhSkltR
         gN61nJ7QHOanpi/lvigromVMtet5syDeLmLm+qzaZJoQGCigztGjAHYqyfLlZnglb2AG
         vpuA==
X-Forwarded-Encrypted: i=1; AJvYcCX0l7EVy2K0XMyChn3xb0JwjSqr2S8kOqSLxa5HACJ2z0kya1fAlnk2tE5n0oTBNgCJxPLnuYo+qhpW/9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEp6XY7w2KFkhRgqp13Tvv2Bca0mfKHgZC700oEQ7N4FewoOc
	HB18VHx2V/zfWeQGrbVC/3D5ZkH4ddZ2jZm3A8qtVYp2sHo7GOUmLlY1XPBmgEaQNV94ZweOjnK
	q9dW2vcz+dZIGrYojJSQ8dg3J4WyIopy4PbhiIGoUHQ/YVa1nfDQttFORvenlLkHmdf0=
X-Gm-Gg: ASbGncurd5GtE9WPE11CmY6GBIUjb2fa4SQvHKZ1qrPF2htCjEkPnMMuDEIsNZ/3L/b
	A4QeL+Jb+g167YRByxjXSf33GDXENPOT28BlU5ckwPUJO7Rc4tSdSA6jurWqKusNfrnGX3q4yfP
	YNXktnqcfUHIx3EgtBL7QNqdlYn79RyEHGVcqXWommQgMbf7X2oXPcSVg5gVi2aNiblbdhoUmyS
	N8w1iYI1y3PtUkyDjnZLM07R+B2dOYn1ynwrS+WUuJuDjcBYUX8VK19iRebPrtgFW/Wc9ivfzQW
	2rjjZoO3h2LDlhi3eiHgfob1k8xxRh0iMiI7NtQ+ZJI41tcN0zRu/a9mTLiiUfRbj1d6tFeArCc
	batbOQLSQj5CqvxcbsXyj4EB36yCqvA==
X-Received: by 2002:a17:90b:1d07:b0:32b:9416:312d with SMTP id 98e67ed59e1d1-32de4fcc070mr1755258a91.8.1757678589761;
        Fri, 12 Sep 2025 05:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLbeV2EFA9K8UJYz1maZdy+AMfW1DBGrroF29kzoSYpUtUZhd3N4o5LVMtPmgZDxe9yHDhjg==
X-Received: by 2002:a17:90b:1d07:b0:32b:9416:312d with SMTP id 98e67ed59e1d1-32de4fcc070mr1755211a91.8.1757678589043;
        Fri, 12 Sep 2025 05:03:09 -0700 (PDT)
Received: from [10.133.33.174] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776075fdd83sm5311370b3a.0.2025.09.12.05.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 05:03:08 -0700 (PDT)
Message-ID: <cf6c2c2f-9878-4181-a3c8-9692423308bd@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 20:03:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/13] phy: qcom: qmp-usbc: Add USB/DP mutex handling
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20250911-add-displayport-support-for-qcs615-platform-v4-0-2702bdda14ed@oss.qualcomm.com>
 <20250911-add-displayport-support-for-qcs615-platform-v4-11-2702bdda14ed@oss.qualcomm.com>
 <nfugwwknnlxls75yo5rex6ggu5nzpq6enyx6e6nfnfei3icxjg@t7dnzcfcjw4o>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <nfugwwknnlxls75yo5rex6ggu5nzpq6enyx6e6nfnfei3icxjg@t7dnzcfcjw4o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDEwNiBTYWx0ZWRfX7lijEJ69prWz
 FSZI7wP9raHEizNRi8hWn0ACLz1xTLZhI8cIt9dPlT06Jg4D5VIjUnI38NfBPPudJm5g6SIMPEB
 w9dupVQYZjTQ8+weUc5YzsfMzDgEcL3dVfN9DZjSCwr7LjQxYhLebb6H55lHAbp/AjkVSV+bkdC
 CPXyOp6MWLYWGKdUgYy76xtxHG0ofSTRlVedG1cJA4ZbEMibtL58+ieAibHCdjSt0AbMCcFINBu
 Bas1ycZfWYmjGRTbsz5HIjrXo0+b+9o+Et1uiKJt8G1fw1mPpQR9ukicolVbOZhDfPxFkQz3iGf
 +ba4/WLx1scXVr9icjAJ89qi5pCgKWO9Ay61M56aVFp3mbHfDtht7jCT4Qd/sKV3rN5l/HcgVt8
 gdwisimk
X-Proofpoint-GUID: GOoyhA6p2ckoRHFul4temMxyvQY-DjYf
X-Authority-Analysis: v=2.4 cv=JMM7s9Kb c=1 sm=1 tr=0 ts=68c40bff cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eXWC9YIREg2_PHQc8DoA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: GOoyhA6p2ckoRHFul4temMxyvQY-DjYf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509120106


On 9/12/2025 6:32 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 11, 2025 at 10:55:08PM +0800, Xiangxu Yin wrote:
>> Introduce mutual exclusion between USB and DP PHY modes to prevent
>> simultaneous activation.
> Describe the problem that you are trying to solve first.


Ok.


>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>> ---
>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> index 613239d15a6a3bba47a647db4e663713f127c93e..866277036089c588cf0c63204efb91bbec5430ae 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>> @@ -1061,6 +1061,19 @@ static int qmp_usbc_usb_power_off(struct phy *phy)
>>  	return 0;
>>  }
>>  
>> +static int qmp_check_mutex_phy(struct qmp_usbc *qmp, bool is_dp)
> mutex has a very well defined use case - a sleeping lock. Please find
> some ofther name.


Then how about 'qmp_check_exclude_phy'?


>> +{
>> +	if ((is_dp && qmp->usb_init_count) ||
>> +	    (!is_dp && qmp->dp_init_count)) {
>> +		dev_err(qmp->dev,
>> +			"PHY is configured for %s, can not enable %s\n",
>> +			is_dp ? "USB" : "DP", is_dp ? "DP" : "USB");
>> +		return -EBUSY;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int qmp_usbc_usb_enable(struct phy *phy)
>>  {
>>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);

