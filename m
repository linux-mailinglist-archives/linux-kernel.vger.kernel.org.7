Return-Path: <linux-kernel+bounces-721475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B45FAFC9A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 599131BC48B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C2D2D97BD;
	Tue,  8 Jul 2025 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwwrNEEy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC4A2D97B7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974306; cv=none; b=k2XYeOgM+i1TwwD6H6tWmIaU1b9PTRUwq3oVanEJTCKd+4UCDxZHZgFeWowBn/mjsYsRWpxJ4QH28LIkDjuGsQTKUaVq4gu1rCS3fZ4ixqR63rGsvcPkvV8zmgGOdEn3ikmUsKatoQqwBO1hkvTHp78patfXWD9Mm/llza8itoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974306; c=relaxed/simple;
	bh=P+pxE6WaqJCtlIPhTde25jg4Wk2SpGFNRRq9qAcfinM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXh4i0vb5j4aM3D0zZ+BXjpZSHgI2wS8Qb06eT06c9tfdZmBoUGJ3WDYqmi4Ka9ElvocH0Bo5Ia9l1h2ZjUgc70IhW7NODuo/iSehxXfaHfxnLLPKtYKgVNFualTnzqfhFQ1YXc9TdljNkARqEq1YThNcW3x6eav+qa5erUo2tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwwrNEEy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAWFr025574
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 11:31:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tUm412BRbW/zHRuNnheSl3siSXwcdOp9rqnr499LK+U=; b=gwwrNEEydC/VFkSE
	C9qBwaEMdqlXYh4rJWV0wz/+oWpfv9sNEJXK9zzL0X4Hczchu7ChsdPyUZIUdR/W
	jcs4TMcTD/El9/mQrM6qtxA1/WeBEy+TWFBdf0/ghZ+SEzBkfojs/sB6MT1KKwy0
	JatNFxdvM5HNWmhD188G0QK1d0/KkpPRWA5+rvZAPrQWLvZ4KxuOviRze5OsYhdO
	aySsDEJYrWiEnxkc3jp4Qp4b85kkLURUgwdXyeG1qx/uFPJYRsicHT2/8vlx/bRu
	FXKNoDjMpYYYPCaoZh54WoO48OV4YBZSxt4QjZmvaY+YjeBCYfxiHZ3rJ/HMa3dv
	knAAxQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu0wcjq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:31:43 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f539358795so17206416d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 04:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974302; x=1752579102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUm412BRbW/zHRuNnheSl3siSXwcdOp9rqnr499LK+U=;
        b=vhjfMnZ1hKtgd0EF6R93tXkWjQesgsV2lgMMM5Q9P+YMgtGpUT7yR/t72JKIwgCJy6
         wC8fY4ZLis0LV3YLWsa0Ugqn5jQhpHbwJCJc/AM0pH2AseFtGa1blKMq46RsGrG4SGZj
         qjePlBFCmvw3I0flv1+9sinacVTC4sjefxL6gd4KKgzGCbeyD8eFk24hFkkT4FYnG1rR
         LwjzcTZmT9+fgYDS46lP4WHMAjyOUpAaAd1bzhiLWy13sfg2c4u3brKB5cSRp90/P8eB
         GUo7gGjjFJA2E4ihXkB98ab2X3Of1XOn5bAM34mZTwbIIL53NER3cW8vdUFd9kT/EzGx
         G03g==
X-Forwarded-Encrypted: i=1; AJvYcCVKDo4RZBrijtodbIKPmmsDGh1/eOurc+IFFrERR6HPQxjO60JVgEsjm7oM/xJpRz/n1hjoCsnetmoTcto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiU3yU9znNl0PSpmZ2hkfCMOxPhoxqgHUsuBp372Z6nibAdmrF
	Vsy+WRdTS13wRH3iYoloyMQmsyG8gPQx9HCp2PQMQByJ4WYfn4ckHmpE7Sxzr+hI2Q901MFej0F
	74oMsn0zWWZMetJvpyxIrkZZusos4/xmOB1o6Fkae6TWb9NI5cCPq/aKQx4yAiGT56NQ=
X-Gm-Gg: ASbGncuTQ5/3wRgD4KD7kkkHxUZD5DV1Rv2eK+eXkvTtzKSFPdEeYPh8ntHVGfpQJjt
	M+jR4isEjmOAousy2G1k2hEOWPbgmiMUG2DjFgWxewj70veBeN3FD+6XlM+AxilhoLG4lGJL1Zq
	cOzXJ72UgLop9bVZiVJkdB72P1gJs7R9YtLe865hmAEVjEASe6Oc0N5gwWJvceZ0hrnvxvYc3iZ
	CIMkweQxhyxuZSxI6hYfBLb6u0lk3205j1KcLW2kqKIP/qvGp8jvKRsYr9CCXhVLAo5bGQQGfzb
	3HVJ1rM7DTxiBYe4n/YvbEGvH7hB4xBa3dFuxICyfWSzXH8KhqrNtZTgDwff9UYmLFfkVQAX5KP
	f/50=
X-Received: by 2002:a05:622a:34b:b0:4a9:8e6a:92c3 with SMTP id d75a77b69052e-4a9bd3c3284mr46378581cf.11.1751974301891;
        Tue, 08 Jul 2025 04:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXS7HsMKzGHLe7mgZx4hB+HHWETmL2VAFfFIACPNdmtmlGbyoflOmhdiXYt3hmPsI2vMpoEg==
X-Received: by 2002:a05:622a:34b:b0:4a9:8e6a:92c3 with SMTP id d75a77b69052e-4a9bd3c3284mr46378351cf.11.1751974301243;
        Tue, 08 Jul 2025 04:31:41 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b600ddsm877212066b.158.2025.07.08.04.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:31:40 -0700 (PDT)
Message-ID: <97074fed-7b63-47fe-90be-4161a4c7a297@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 13:31:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] interconnect: qcom: Add SM7635 interconnect provider
 driver
To: Luca Weiss <luca.weiss@fairphone.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-sm7635-icc-v1-0-8b49200416b0@fairphone.com>
 <20250625-sm7635-icc-v1-2-8b49200416b0@fairphone.com>
 <3f8bcecb-4c5e-48b1-98be-96f3c0c8329e@oss.qualcomm.com>
 <DB6LPBOU5TDL.13B4A6U4NQQZQ@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DB6LPBOU5TDL.13B4A6U4NQQZQ@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TMHijiaNdenG15FPa99IQcghWYY-IwvS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA5NSBTYWx0ZWRfXzgMoxnhjIyux
 1EGKPw5TY1cHkFXyYHk/ifBE5wxs7/h9DvQRaXvEpmQGHum9PkfsR/BHVftN4pEMzTjMhvgJvQe
 iWgUlnXv4EmxqRS+Mv1To3iLB9V51yEGE8Bmou3NMnL6yrkFpWh/mPfG3/3qNE8SskJO8m9K87q
 EuqmAw6GM6MhXSdp4ACopP5eKpX71IsBA8yB6c4oCWaI9yxT4l+XjS1Kg35NNSqZ5XRgEGgQZ87
 LohWMf3qS2XuEXlf5J+QNZZwVdmGgxAsuA/stLsuD98YPFNnFUrXVtQl6XNFFyqrtbpSTPq0DtN
 wfUF/hTIU9T+4fIn9IlR37kY0psQCMNtG4T4uA6hzIbaQJna3bJ4fibefmL5Z5vCQr/ugkdFLdF
 Jn/Y9YbeK8gwT8vgZgVnEZjExw2hdXtP1jaZg0/A4OrbsZkN752X+QuAOPPGoZLrtG5e0oy/
X-Authority-Analysis: v=2.4 cv=Rd2QC0tv c=1 sm=1 tr=0 ts=686d019f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=qFGWVYr3AIIjfRM7rNMA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: TMHijiaNdenG15FPa99IQcghWYY-IwvS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080095

On 7/8/25 12:28 PM, Luca Weiss wrote:
> Hi Konrad,
> 
> On Fri Jun 27, 2025 at 2:48 PM CEST, Konrad Dybcio wrote:
>> On 6/25/25 11:13 AM, Luca Weiss wrote:
>>> Add driver for the Qualcomm interconnect buses found in SM7635 based
>>> platforms. The topology consists of several NoCs that are controlled by
>>> a remote processor that collects the aggregated bandwidth for each
>>> master-slave pairs.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>
>> [...]
>>
>>> +static const struct of_device_id qnoc_of_match[] = {
>>> +	{ .compatible = "qcom,sm7635-aggre1-noc",
>>> +	  .data = &sm7635_aggre1_noc},
>>> +	{ .compatible = "qcom,sm7635-aggre2-noc",
>>> +	  .data = &sm7635_aggre2_noc},
>>> +	{ .compatible = "qcom,sm7635-clk-virt",
>>> +	  .data = &sm7635_clk_virt},
>>> +	{ .compatible = "qcom,sm7635-cnoc-cfg",
>>> +	  .data = &sm7635_cnoc_cfg},
>>> +	{ .compatible = "qcom,sm7635-cnoc-main",
>>> +	  .data = &sm7635_cnoc_main},
>>> +	{ .compatible = "qcom,sm7635-gem-noc",
>>> +	  .data = &sm7635_gem_noc},
>>> +	{ .compatible = "qcom,sm7635-lpass-ag-noc",
>>> +	  .data = &sm7635_lpass_ag_noc},
>>> +	{ .compatible = "qcom,sm7635-mc-virt",
>>> +	  .data = &sm7635_mc_virt},
>>> +	{ .compatible = "qcom,sm7635-mmss-noc",
>>> +	  .data = &sm7635_mmss_noc},
>>> +	{ .compatible = "qcom,sm7635-nsp-noc",
>>> +	  .data = &sm7635_nsp_noc},
>>> +	{ .compatible = "qcom,sm7635-pcie-anoc",
>>> +	  .data = &sm7635_pcie_anoc},
>>> +	{ .compatible = "qcom,sm7635-system-noc",
>>> +	  .data = &sm7635_system_noc},
>>
>> One line per entry, please
>>
>> In addition to what Dmitry asked for, please also look into porting
>> QoS settings - those will require additional clock references in the ICC
>> nodes and as such, the bindings will be altered (which we'd prefer to get
>> right from the getgo).
> 
> I've forgotten to do this for v2, which I've just sent.
> 
> But we already have the clock references in the bindings, so the
> bindings should be final, also when QoS is added, so just a driver patch
> then.
> 
> I will put this on my todo list for a future patch to enable this, if
> that's fine with you.

Well I'd rather see that be done from the get-go, just in case there's any
surprises (e.g. downstream may not describe all the necessary clocks, as
some were enabled by luck or so).. that bit me in the past on some other
platform

Konrad

