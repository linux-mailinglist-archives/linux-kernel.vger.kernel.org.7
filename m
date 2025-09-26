Return-Path: <linux-kernel+bounces-834126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E18BA3F08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC837A781F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E7014B96E;
	Fri, 26 Sep 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BqhSdEwP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32238DDB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894523; cv=none; b=JtxnqoWz/g46v8bs/LO+rA7AUUfVnE7k5VvatArWvY0dhzpWl9TupV79gDot6spK1I39S1I6XUhOavCYVQ1pEt1w1yVb0lwVBgFLW00cfouiJ+O6AokOyETMgelO249OtVcghNU/5cmoV0DZfW37rQoSWqU/t0XoLgvqKb8dDYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894523; c=relaxed/simple;
	bh=Aarm2UM5jytnaVhQwMjukWEv9YRVwIRMFnv161NzwC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ubo+BQseGtp/rotCuY7k6gSJH+w8tmSD2xwuogkiGsklKlbSbc6yOUpYSEj2EiZZR21ecLkctlpoYr6h5sh13OWXqCrXrhQ6bw3+Z/Ph2GS34SNXPAizf9ZB3ptYMl8jxM11FwYGdzrPqh4WJEQsu8NdtUNRw5DBBIUO4+tX19k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BqhSdEwP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q8vgFl016018
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wWKAboNxmC/SVuUy6iZnuitUhacsSjdsbUrvric+Plw=; b=BqhSdEwPlmBAHBUL
	4s9CBwdEMGkCimFDq+9p5T9HiVz+zOqzTLVHi8aoDFx1gLTHcCdwd+h1vkffV4AM
	RYwdSNccD6TTSUjax1oR5XUiXoTOiDq46bkzDlzcctLsIxWDKLjBn9aGiKsYx3RU
	vim8NNK8PYQEkJbHOSVu1uGuEuiRjCKqyz0O8Lz0UhMPorS1GU0gvBxzBdUuMU3s
	s0o8Ap6zB4lj35Ay6KPeZryfkv3A5GC1CKcbhGXQB1kUquMXrxKJkX4nzNwzGFrZ
	Iy7/Xp3pVdyDO91tbxO1E1IKsqLqFqnbjLK7mRLATRsNL+RdITR1Sy2gecfyYY3j
	rFruOQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0rk1wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 13:48:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dd729008d7so343241cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 06:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894520; x=1759499320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWKAboNxmC/SVuUy6iZnuitUhacsSjdsbUrvric+Plw=;
        b=acpAeUCSGCNHCCvKcwRay1TxpYgRKUasmqlH1gj5l/Ab0k9nmf95K1gli8UA6+TUuw
         AKpty8bK8J++tFEpeROnBhT0YSylF9uJJZCUrhIjNwqyQV7Qm2GKkpwTCBZZsccGjdV9
         gu3bUlUwN09U5GnLZYgcG1SouvbVWOROtPafFYnSw7U81rQIMG6cwS/UpYngFzDSYQUk
         uJJP6oWX5UjrkCesZPeelC9rE9lwcsMuPJVY8hsKLBxyxMLtRzMT1t+DB6nk6yEcNV1y
         SlIF6ldBbtecvJ7RsUb6tnyUCzoOqggFpBsgyEKdch7MSX/Q7ZUrW2F75OKWv10D39eR
         8x2g==
X-Forwarded-Encrypted: i=1; AJvYcCX+Nv+7Ykk4KRuv/UL5GBlikgof9e+CJCjoehHL5fEH443DjL4qAYj1F6nT43Z/p1a0gIUYmedzlUCsy4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIGv20KWd+aGJxtu4P+cEz2FtWgL+3CuWeDAoRgvEPcZNMpM+a
	pkQHiTpqQkPFUua7iueMbJvugbiy4PaaTy33vkVRYsrjd7ssOrrFl2/hJtin88gvXSiJvcnyw+H
	/pxXhEoy/UNrVFd4k0OCkQAkNnTnlJUm7aUhdr/Hfsn8A19C2+z/L8KLvCcR+z4InLds=
X-Gm-Gg: ASbGnctZDxzVmETSPhcrOQ86vMWfvrY2ZewJFZFYMxDUS5H18nAZtXZDGbLP4/JTCC1
	nsygJvmZ6LwoE8rweBHEmlrOi9cQks8sz8PTLFFGhQrzOmj1FwarXNXbMAm0DVmk8rUGU8HmdrU
	g/6xMCki5bwdeCaf+FZ8ap3L6oPGUTiJriAQZiIR9rYXVYdKqWn3eYeux0YLes5ZbALoGmn66lW
	NZRo7AxwCXRQokkqZdTXqjYI8Vk/cgHuO8Ci4fZoCCAlyYcNw+ps/tSavLQNm6adGyTeKMEw9ho
	spUiHZ3W5DzjuWhxNZzbyZDuqCxnQBogyWsQxCkqyev2VERFJQYtO9vtLHGhtCnVkJ52QcMryiH
	r9Yzo5OZxWM7k01QXduB9OQ==
X-Received: by 2002:a05:622a:1886:b0:4d9:c572:f9b3 with SMTP id d75a77b69052e-4da4b6160bdmr65890671cf.9.1758894520068;
        Fri, 26 Sep 2025 06:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhNBBgSVDYXxW58rzQ0pj1r5lmIfPVm2D3r3xaPN1V0a9k1ZbVxd4jsMfTaN5cvjszpC5bFQ==
X-Received: by 2002:a05:622a:1886:b0:4d9:c572:f9b3 with SMTP id d75a77b69052e-4da4b6160bdmr65890251cf.9.1758894519407;
        Fri, 26 Sep 2025 06:48:39 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f79a7sm366342666b.62.2025.09.26.06.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:48:38 -0700 (PDT)
Message-ID: <eea8feec-d097-415a-8b5a-c51edab2dc5b@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:48:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm6350: add refgen regulator and
 use it for DSI
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>,
        Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
 <20250921-refgen-v1-9-9d93e64133ea@oss.qualcomm.com>
 <DCZZV93PMWRZ.1J9IZBZYP5RGM@fairphone.com>
 <4d815ed8-18db-462b-80d9-9768b51a9788@oss.qualcomm.com>
 <mmtoashmdv6cwwwdg7rpbk3kkrjddej6khdzlcyo5qb47lfunm@osemmb3z4m55>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <mmtoashmdv6cwwwdg7rpbk3kkrjddej6khdzlcyo5qb47lfunm@osemmb3z4m55>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dP+rWeZb c=1 sm=1 tr=0 ts=68d699b9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7uUkQgaaTnfZjgSPyt0A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: Vu_qedCRkUGjhcmpDBt7PkLPw4SB36EX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX28dXXqSweSuJ
 jb/BWRy/wFn5+W4vNatAtTEZtZW+njixIvs1XCAaPwin3Am8y2OmaVQjmfAhCPsxBpFUnQ7cLn/
 3EIUCV7rLTz79Gw2QCdXMlF8eXZGMW8dqgMFHcKqQmYqdSiP+A4+HfZdVshyqK9rbTiccd1PIjq
 XlXH4Wi8HTD6Vidxv3DSbx2G8wImgWJZ2MW8pq1KdMDM5rpGBOyAU3PbMBrsh8owKRj/KyaWx0O
 dEYCoUWYzkFpdRHH4DXyIQMeyGxW+K+ZFxRtKrN9DSvPYD/DRZwysyxc1WLaTzl4pxWp11R4JZY
 caz4NZhFWKK2kAsjAln335Wql6WoDYKRuLhOizvqGsgBF7Jy5VKpXiBMcC1Wo7OBo2ZulRDFS0x
 FlO5SVKhDRGqFFV1TNZyFKjDxn7tog==
X-Proofpoint-GUID: Vu_qedCRkUGjhcmpDBt7PkLPw4SB36EX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

On 9/26/25 3:44 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 26, 2025 at 03:27:24PM +0200, Konrad Dybcio wrote:
>> On 9/23/25 9:17 AM, Luca Weiss wrote:
>>> Hi Dmitry,
>>>
>>> On Sun Sep 21, 2025 at 9:09 AM CEST, Dmitry Baryshkov wrote:
>>>> Add the refgen regulator block and use it for the DSI controller.
>>>>
>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>>> index 8459b27cacc72a4827a2e289e669163ad6250059..dd009569a6683a25f13b068e3e0bd8746b2ac501 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
>>>> @@ -1768,6 +1768,12 @@ usb_1_hsphy: phy@88e3000 {
>>>>  			resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
>>>>  		};
>>>>  
>>>> +		refgen: regulator@88e7000 {
>>>> +			compatible = "qcom,sm6350-refgen-regulator",
>>>> +				     "qcom,sm8250-refgen-regulator";
>>>> +			reg = <0x0 0x088e7000 0x0 0x84>;
>>>
>>> Are you sure the size is 0x84? Downstream and hwio_bitra_V1.cmm would
>>> suggest size to be 0x60.
>>>
>>> For sc7280, hwio_kodiak_E5.0.cmm does say 0x84 for refgen.
>>
>> 0x60
>>
>> moreover, I see that there are two refgen regulators..
> 
> There are two refgens on each of the platforms, but I think the other
> one is used in the automatic way. The HPG only tells us about
> programming this one.

OK thanks for checking that

Konrad

