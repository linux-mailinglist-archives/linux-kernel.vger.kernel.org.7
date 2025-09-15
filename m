Return-Path: <linux-kernel+bounces-816580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA962B575C2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623C4188D39A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90E2FABED;
	Mon, 15 Sep 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZBc6wlxT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86B92FB08A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931144; cv=none; b=kAU0raC1/lfoZzbviFMhoITC3a6rXyqw4b1fSmELbWWnOtzdHhHqtno8bPqIgvtLnmL+cbMADRCle2uQ/AjCI5SawRuI3CR/kRyVGht6aFS9Dj6IJgOCVddJulnwmKbmkPCA3ybVqXyAk2qxuJeBqWznfTznTSSn0hWwnUZz4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931144; c=relaxed/simple;
	bh=jG342V/c+j5CoBX7FP4+dyAJiibjxkiQ+yvM5FWlx9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns+M86B4yc9UIN/gt4YTPQUZYP7j1XN7mSslfWeNhCSm75PP/rPI9pfnTJl1E4uugKwlhCwkP6Nwp2cgJKkATru8j69ZhX4w7pf6laMM3yjnryk+NsrT/MbGqybzx9vHTVD39Qu3JMv71/t4ol89bj6PzU/tPZhSSRiri4ZV7+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZBc6wlxT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8FhVk020564
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sKD/3kPWUFAIEKI0UmpKQAcxh9lP5Wru5KsNYI2Yxfo=; b=ZBc6wlxTY2NrEsig
	4fQSCUgYY0661833ZRKf3dhutGaTAzFuHKLF3C1rfXISL2/jQUDk9D013zPWen2u
	wZIPk1j2YBJ/R2kQl07dACQ8jGwRzyItehxgwlk9Edh24ZmWGBY6yc0NnX3mcafn
	0HNtDPxk0fs1714LQ6pRoeqkF0tzHWRE4bSyy6Qwq2eP4gNuu37lfyKUwfMoHrVE
	QTYIw+5pNEaUPbC9mwZ436p61Q2YDL6KYHHsKtmRQiCjQnjU/soVB0yVci1F8tab
	OV68RFIxLx7hl3P/HKZr13Nn2vxowr3nXiMCJpb/wjfLKTnd2EgynxizCnhZNmG4
	B0N/Yg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950pv4hf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:12:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54b301d623so663639a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757931139; x=1758535939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sKD/3kPWUFAIEKI0UmpKQAcxh9lP5Wru5KsNYI2Yxfo=;
        b=X7jxglnutzEI4MEh8QkiOjiNQjW/WJyH6bnx5Mx2BuSVVRk8w3WIMsOokLWfFmmu4d
         +4L6DvDLeIMm+QiwNuse6WH9U64gu0JeH2zJzjuz/9NESzRBbH9Gl1Z4SEX0n6JKmfKK
         RIEwk1Gxr6XpwWu12tIK6FlkiQqGk8shr4yNEy08iQ6wlp8SprgVb7FICWOVva8tf7Ot
         dyiHOAC1olxBm3nrMF9SlXszBcf3qWlhx2IljZhzwZsKbk9dSGQuMtNVpKmkCJpac+PZ
         N0hF8CoowQGAHgDsAdo38B1cCSysX8m1RbJHqSdrT/GmgcJ27jhH99/s8rpdSmymN93I
         dqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6L04G1WAaq45sz/x4AMxSuIKSDqvbl1Q9zx0C3ZXO+zrs77DWJy6kMHSWn5n8uyUefVnrMHvXolIrHgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpC21FipFt8P+a1eO++mxnuh8V/8cNobXprki+On9fYg42wZG2
	nz6PBp8R55T+c81H+SCWeHIyzXAEcjnsWPn2QpaslBkwOwTPfBp+dDl7G+x4zljzRJlUOON6QVS
	t/K/bj0BrnwB+SsrxCM/mPecG46gbB4c09G6FmEHVuvMnI2kSQtShnfLbn1HpJRifh50=
X-Gm-Gg: ASbGncv7POOZCZVawTWnxn60z2VuSy32i8UNq38/34fxmjBiJ+kdjuVPhgvXRPWzp9J
	Q1V2SOTrVLRL2JA9fpUS7HzDC/8r+K2tcBPRe/KsE8E0NX7GadRCPk+BTm4PPa1lW72S66Q3nBL
	tuUMHffTwFlmqX06GP2gL9J6GQ0N3Acm4uVQ/As+sm90YCFzunc/vNbZWvsEuOatHIgLkUQLSJt
	HkI0iY1Dfh7xj17/YGvUvU6PIO7+jahoj5anFj46LKi0b1XfEr4DWypPdECvlg7iQkFATuqxFUQ
	jWgg64F3apqg0ppCABH5p8yLmQHKHlqxIsj1p3ZzB+Tw2YaJ/I9p3UhCfIIQ/HvlMUVarEoI8LP
	pwfZf8fc/GNImUpnhWoI0IgWoZr6eVZG3dKA=
X-Received: by 2002:a05:6a21:328d:b0:264:10e4:f87 with SMTP id adf61e73a8af0-26410e411fbmr1664433637.4.1757931139305;
        Mon, 15 Sep 2025 03:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZXxZBGVcbThhG/IvVDI3mpTgc5wznmZnjs66RxbpQzCycjFMO9w4+/RnbJr+43MLjBFNnw==
X-Received: by 2002:a05:6a21:328d:b0:264:10e4:f87 with SMTP id adf61e73a8af0-26410e411fbmr1664402637.4.1757931138808;
        Mon, 15 Sep 2025 03:12:18 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b03cf65csm8329380a12.16.2025.09.15.03.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 03:12:18 -0700 (PDT)
Message-ID: <f030649a-9505-4bda-9ce9-00eeee8d3b06@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 18:12:10 +0800
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
 <cf6c2c2f-9878-4181-a3c8-9692423308bd@oss.qualcomm.com>
 <q4dplt6fq3cneludcuhxevklaj6omeio3cjxw2owt4h3wistd6@arv23ri4cl75>
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
In-Reply-To: <q4dplt6fq3cneludcuhxevklaj6omeio3cjxw2owt4h3wistd6@arv23ri4cl75>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: g8sJg98S6DqU49MHrlZA7NyueMZitOeV
X-Authority-Analysis: v=2.4 cv=PsWTbxM3 c=1 sm=1 tr=0 ts=68c7e684 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=CZmHqXGeirO8O24YQhMA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: g8sJg98S6DqU49MHrlZA7NyueMZitOeV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX32rhQVpXU6Xo
 69u9sdmO5Uhp6LhQb4qVO066LIeoBQJeVz1JvXmJ6UWdmNBMeQLqz37j2WO5OUw805RkYLF/ClH
 vuZORWdu7SRUtBOxpBnFNXuLQJrot99s9MJ2po4sv2ua0aws2pr1tnyzLZr3JOrqqPjUJzfelxj
 jB1II0MghTMIJopTDgmKBoLx6ZINiCGLbjnnOm7AvMBPXX6TfEQuUcd1htJkXbktqa2uHvI0DmQ
 QOc5Ub4MVI7p/N1OCZ7Ex8w9hpggRGJrgQYcZB+bs4uWX8P3Cm2Br2nDC7uHHOgUNuW3iRxwJ30
 GTQxWxeHi+qRZCymXiRWO9C3Es03J/1+2eXCOWWasvLZf0g2r4ydbs7oilvi4UmFl676TYbPlP0
 WIb3Nn5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130029


On 9/12/2025 8:09 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 12, 2025 at 08:03:01PM +0800, Xiangxu Yin wrote:
>> On 9/12/2025 6:32 PM, Dmitry Baryshkov wrote:
>>> On Thu, Sep 11, 2025 at 10:55:08PM +0800, Xiangxu Yin wrote:
>>>> Introduce mutual exclusion between USB and DP PHY modes to prevent
>>>> simultaneous activation.
>>> Describe the problem that you are trying to solve first.
>>
>> Ok.
>>
>>
>>>> Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
>>>> ---
>>>>  drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 21 +++++++++++++++++++++
>>>>  1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>>>> index 613239d15a6a3bba47a647db4e663713f127c93e..866277036089c588cf0c63204efb91bbec5430ae 100644
>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
>>>> @@ -1061,6 +1061,19 @@ static int qmp_usbc_usb_power_off(struct phy *phy)
>>>>  	return 0;
>>>>  }
>>>>  
>>>> +static int qmp_check_mutex_phy(struct qmp_usbc *qmp, bool is_dp)
>>> mutex has a very well defined use case - a sleeping lock. Please find
>>> some ofther name.
>>
>> Then how about 'qmp_check_exclude_phy'?
>
> qmp_usbc_check_phy_status()?


Ok.


>>
>>>> +{
>>>> +	if ((is_dp && qmp->usb_init_count) ||
>>>> +	    (!is_dp && qmp->dp_init_count)) {
>>>> +		dev_err(qmp->dev,
>>>> +			"PHY is configured for %s, can not enable %s\n",
>>>> +			is_dp ? "USB" : "DP", is_dp ? "DP" : "USB");
>>>> +		return -EBUSY;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static int qmp_usbc_usb_enable(struct phy *phy)
>>>>  {
>>>>  	struct qmp_usbc *qmp = phy_get_drvdata(phy);

