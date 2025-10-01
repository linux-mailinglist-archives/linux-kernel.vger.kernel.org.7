Return-Path: <linux-kernel+bounces-838678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCE5BAFE84
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F71B16EAF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823D82D9EFC;
	Wed,  1 Oct 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cr1g3ir5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB22857C2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311831; cv=none; b=a2o34B6ZB2xeKDUygro0YsEWvvEZf9lrSmv2qdHzUjKlHXOg8JZZUWaxYjxDCgJKdAf2xZD+u0vY6Tjp2CU6O5aOhOS9XFXuo7Sn4wwo9Jumg0bGu0UVonwOK5dIjPvCaMNcy01ANIgMd5Y4Lrlt9rOjRk15CRd9+SgSVBpbiXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311831; c=relaxed/simple;
	bh=tHn3o3WJq/LqaWYy+jXpfPTAUaaZDDHkkIq1jK99V5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMX3WNi0ViXHR9emK9xnyTjrjguu4JG4A8JjIIXFpH4Jlh+LGTUXN1cMlMBAyHmn29cbzGfnimDr9quqYXVUbP2jzSaeEneN7z1S6qHEzfeMll8HxlS2vtAL6hgSMSNkxRI0TK9N6TPnPOyCiGLucQ8Vsjzu1pUAfTyEZXkXen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cr1g3ir5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5918X68C024448
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N2j4IW5NnafXAEbG+pjQfoEONtDY8QkYi5eJLubVjC0=; b=cr1g3ir5UkiwEBvm
	MF19xEjjZNFLpWiia40lSVhQJTEc/LnUBzjVmNmES0Org2hH21Pcot5oQIn6Z9mQ
	RuNTu13ANd3FIpC2NErDG1DK+9d9ibnw7f0Bl8ZWKLUSk283Iz/GNwl29XmC/Xd3
	wPBG5gr7LbO9RTs/8SsFC2oDoH/nCu/Z6X2JgH3LVnAiHe195pbrv7VG34rC1Q3s
	iY53lsuoBS7eNdx8HgMUZOlAXd3NoIYOi1+vQSdAX0YORyd3RaluYOTBye6Z1hCh
	QDcFDYCttVQERidFCO/7vyP/rwp9yghkSyLmxDUs/mgBy0iWRsn46dwQYc8TxzZr
	xX+HPQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e59n4f3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:43:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8703ba5a635so50072085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311828; x=1759916628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2j4IW5NnafXAEbG+pjQfoEONtDY8QkYi5eJLubVjC0=;
        b=wrAtQPitmcDhJ9PAVqo1UW9bbGrAlzl1Qcy7cgT2yCrrJp88QaS9MHtHkTzC/wY0Yt
         CE4umST53n3GONilI9cbpu/WvKOEvUo47AwlhWHf3Pw89732wz8rsUAWueUk/RHLzyol
         ftOBFg0n9h87p631/OZkUm+N+SpjRSVA5FhoJIUK9JS2zFdVMzJ8v2qnh8SIENCrVNVA
         XhH6KzcLc6wUqvKIpJnP6NtERicY7QQQgGlPnu15eJphJVda8Ko+PuyyPuFPo5japRkI
         ky34Cy0UgyhqPZcPIWpO7mwd9JFYz2nAK0dXyp20Y3MMW+iZQBugTbRLi39mKVlaNQ3y
         TkBg==
X-Forwarded-Encrypted: i=1; AJvYcCU5ESuXi3wMz6CS6TisCsOj2BY6lRJSuHtLseJDQGwYr+BnUjAed5K6UBn2MOv+v3pTnJGB6hEx3ZaFgPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk2eOMN+tK5b/pnkw0OWN7Vldg+ufS39JyUtrIWzc20uK2jxp5
	UHymIkrbNbt4NHbGPrHYcKiJwieiqivdE1L2dBzNYdhy6CruuUy+FSzmdekkU1Udr7shP4fMFss
	cgq0yne39R31eSlmWM87LokJfOttSTBbfPaQMZZdm+temIISl/XZ5/9FNLuaSHTlj6S8=
X-Gm-Gg: ASbGncupiqXClsc1yHeO5HkUfdCZfnFwuD/O12nxxL3WuOvF5U23Xf+QSaaLzoJ1VUB
	U1UJMMPN0neK3Mrh+KcW771q6mERK5+o20gfgqrBRfL8jckzkuibGUCotuJw2p8I4u7R4h7DReo
	QnPuGwEyLLfXHMXgYHOunqGfvfHo9w/6XMMiVPKwiakWs8BdfHy+AzbWJS7WDs8rCqMIRHV1dcs
	dIMH5/q2fc2+10sI6v10VjsNqAxUUhbx6POqJK6qoclM6fBXvGg+FS+Xl3dOufyuMT73l6bTWR7
	uAgR2Ms+FC374m4uD+H0PVYBgJp4StBXFa/WwBVdZAN7ZuAuPYtifxoQqzKSy6vMnd52EA7eW57
	TeI8qSkMt/tndFIPrrtylO+kzZ00=
X-Received: by 2002:a05:620a:17aa:b0:856:40d2:b1a5 with SMTP id af79cd13be357-873765c02d2mr274221485a.13.1759311828467;
        Wed, 01 Oct 2025 02:43:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQhu+9IequlFgOauptmEqJZoeziWIrkfkjGafmFpxFA4oL+2QREZWtpjKdLAbnfpl7vBk6qQ==
X-Received: by 2002:a05:620a:17aa:b0:856:40d2:b1a5 with SMTP id af79cd13be357-873765c02d2mr274218385a.13.1759311827918;
        Wed, 01 Oct 2025 02:43:47 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e60de51c5sm648473466b.15.2025.10.01.02.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:43:47 -0700 (PDT)
Message-ID: <869d1f94-9d66-4045-abdb-6e88d504a884@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 11:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: lemans-ride: Enable dispcc1
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
Cc: marijn.suijten@somainline.org, swboyd@chromium.org, mripard@kernel.org,
        abel.vesa@linaro.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        robin.clark@oss.qualcomm.com, jessica.zhang@oss.qualcomm.com,
        abhinav.kumar@linux.dev, sean@poorly.run, airlied@gmail.com,
        simona@ffwll.ch, alex.vinarskis@gmail.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
        quic_riteshk@quicnic.com, quic_amitsi@quicnic.com
References: <20250926085956.2346179-1-quic_mkuntuma@quicinc.com>
 <20250926085956.2346179-4-quic_mkuntuma@quicinc.com>
 <v4b35cmwbkoosdgs3d6ftml4yvdkyh27q65ssqojplb7uyniwp@wuxbeof7cikr>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <v4b35cmwbkoosdgs3d6ftml4yvdkyh27q65ssqojplb7uyniwp@wuxbeof7cikr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: n4tfWHJ_6O-c9F7BQEjPv5SIU6JkMYzu
X-Authority-Analysis: v=2.4 cv=O4g0fR9W c=1 sm=1 tr=0 ts=68dcf7d5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=ANimo7j06tBtS7Sznz4A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: n4tfWHJ_6O-c9F7BQEjPv5SIU6JkMYzu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfX/Mf6QjW92bJT
 ojUwoBVbxysp1r1s9fVY6SymLPXXu924mhayKyykZKTnD3MTOPO2/TC0DYXF8LgoPqcRlfmSpcq
 4ef2Jx9KvmjKEp87X8TdqHVTVlYjDUah05IZ/1xs/f70dIrVUu0UjGIEl5ZNS4KbnUi8JiNJLtA
 2LTcf3dxVzTYmLcT5T8Mbrm3LQzO/XB3TsSxh5DbyW7i+kQ1lwv2CrIYcl2fXsQqIkytf70WX4C
 gxZw19tLQrv5IhgeuB8f6k90BieYkx29wueRyPmr2PFpVKwDf/J/bo/9pSTANN9++4rj52aRgwY
 X7TQe63OnSdMe8g8c3eNS5hy0XP4gTtFPR+vV9Fpjmeh+gW40zNFCm7BAfcVonP2bxnFf84e7Tf
 XoDP5hiw+XJBmEhPGp2FQ0AeoIQN8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270001

On 9/26/25 3:53 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 26, 2025 at 02:29:55PM +0530, Mani Chandana Ballary Kuntumalla wrote:
>> This change enables display1 clock controller.
>>
>> Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
>> index c69aa2f41ce2..d4436bc473ba 100644
>> --- a/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/lemans-ride-common.dtsi
>> @@ -436,6 +436,10 @@ vreg_l8e: ldo8 {
>>  	};
>>  };
>>  
>> +&dispcc1 {
>> +	status = "okay";
> 
> I think this one should be enabled by default. Unless Konrad or Bjorn
> disagrees, please fix lemans.dtsi.

Of course there is no reason for clock controllers to be disabled

Konrad

