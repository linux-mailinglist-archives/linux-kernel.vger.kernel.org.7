Return-Path: <linux-kernel+bounces-789180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2210EB391FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80ABE464F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3382EFDAF;
	Thu, 28 Aug 2025 02:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kbi20Lr+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7412EA741
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349873; cv=none; b=XQy/3jEpFLCOUo1AstiT1j8Fv5ZQvexcrkfkpjmr7L2flyGBH6ynfwWXN4Kesgp+H8gOX5pNlHQtdXzE6TepyZQitfDVJVfJthuxv8AVswJhFPl4dZ+I8Zu1gqxTyKwHizjX7BPKEv7oh+R/cM1hlBn0mrR2DTRPBUd40gXri8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349873; c=relaxed/simple;
	bh=tCept4cbc/MaNNvuOftpkH1x/HrsKm53+aYvSBoxkr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmeaqADN6CGlNGVEjpledoaXNYBtsDCsHkPqnNnQTmAWOjSUTccJfEc4fnMULsyNQbMWVIAiO9CVSdMh3KA8taGSjLvcCTwYWI27aIKDP6XzsqnB7Jz2JVq9UPHpBRg/IZB9fQimuPfxoV+WHMefG3MvSFHH9CA1mAZYPPw6z2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kbi20Lr+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGHAaP030209
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JVszMljYD5j4gBrasjeb/5znK9oOZEjvYSTgQBHRx44=; b=kbi20Lr+BaxvV3fv
	HX4n2PRqgU/FATOMnc8aKpUuAqPAeg/2ZWe+vGIuaBASeJeGK2toncdhk6J6RZWY
	I9bnOJbp8gnw8ye1PH2WEQTYz+ypH51ichPEUABM9ezu7Ri68qNmCliSmwWrkLEI
	cfTk0sUpJXhoRXqzIsGNrDFmHWOZxTl9Tauu6hN1IVCNePkNP53ZIxgsQtsNdtXd
	6wQFpzi5fohkpqEbxzbCch2XjagV0cGo7+daIVN5inZtXFwWw/xHj/ZrODTiUcvQ
	aFzwcCjNE316aB6HEWJTKP8uTzOAEHX+O921hlShBYCk2Xf0+zlLwva+D1B1LYAg
	yffWHQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5unxg0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:57:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457ef983fso10360485ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756349869; x=1756954669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVszMljYD5j4gBrasjeb/5znK9oOZEjvYSTgQBHRx44=;
        b=MyrmN9WvbLdv5l5ml46/eP5u+RXqbwACxBdO5YOFnKCrE/gkr9QUOFp4wKwTKHsRMP
         eUXTe1n7i5yTguoz/VgFIfrVniKZqdTstPVCnYIKrfESID/BxtMMq/s8BLl3L0FQeqLA
         wjrJKJodWK+ZPhLg3FAe4x/cXmvtiVt7ilSguUv8F+m5uyQDoa0zA+c94yT3sONawl6F
         UCxGP0VLb7qmZZk6IsTOWfxa38agRjrfWyMAExaeFHDfqb4oWZVdPxKfiQUrwcAWn5bN
         GWLOxXIyaa0xMg2Md3RQbkP059hWWRGi4mJVCk432ZAf0UrPDrWuQQzvAu+9D6rPd5WK
         F3/A==
X-Forwarded-Encrypted: i=1; AJvYcCVKgnSTugHRXqEY1a7UXkWhxd7KLSZZ/T8s2yUFqWTvYRJ9LhC4y2AUnby3ZMeOtqY8+XRlNL6Uki3o87w=@vger.kernel.org
X-Gm-Message-State: AOJu0YylKWZrELnqmkNCuejmB2yB+a2fnurC/Ae9scSOtQgwhMEOZ14O
	KdX7jiVHpC3c4hW3ULvuLKnoWyF026/O/SUxbS5jtbBRG6vTD3U/ZppEqFmdVyt4cIPR6A4Eax6
	Z6/GsHISWuPy+o5FWxFi5tR9Y3Tvzh1Xoe8eQBoNW1rdpN+O0s5h9UHst3T/tMhLMHuY=
X-Gm-Gg: ASbGncvwrCVjV50mCCLPpwNQBcnRDs3a2qEG4SRpoIYrnyIlUpY2IAneD8pZeUOiFMa
	w48JUG+yRXBgoPTciOpGQHNXgkiXA3uDjC+YWjYqaaP762F0NmMvlrSbQ7mU8ShL6ZDCqh+2Owc
	Od2cZ0fl7ayv8mQlDAHk59TU/DhhjaGI5GCu2CNYhZ4dCxE/PYLgGrTqoUf87SqU6Nr8GNxscVC
	+uRS4xyCrpOA9ZWT2YuXO+HtLYGp4AyKTGS8oVViIrAS/uW8YhtyXR78bXAe1HFwzv401oYnyDD
	/f0wxfu6av2+MZpHe6ZR/fqHN6Agh6GORWoQY4FnDH1N6uRtfYlaEKhXa1Xsfrt0aRVXzUK9e2a
	o0ITPsZwvKZkkoztb/jgTCXbdAHJa63Fpohw=
X-Received: by 2002:a17:902:d58b:b0:248:bcc5:d1b2 with SMTP id d9443c01a7336-248bcc5d379mr42830435ad.32.1756349868596;
        Wed, 27 Aug 2025 19:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPDTyJMIGDxlyKpgyZ1liFR82SkKrEtzGC4gPqxT5AbPz+li0JlRxHkrYbz7/XOZEMKrf6vg==
X-Received: by 2002:a17:902:d58b:b0:248:bcc5:d1b2 with SMTP id d9443c01a7336-248bcc5d379mr42830225ad.32.1756349868142;
        Wed, 27 Aug 2025 19:57:48 -0700 (PDT)
Received: from [10.249.30.180] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm11600288b3a.41.2025.08.27.19.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 19:57:47 -0700 (PDT)
Message-ID: <0c2a4877-d63b-4650-b7d4-a06a2730c73c@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 10:57:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiangxu.yin@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Li Liu <li.liu@oss.qualcomm.com>
References: <20250827-add-display-support-for-qcs615-platform-v7-0-917c3de8f9ca@oss.qualcomm.com>
 <20250827-add-display-support-for-qcs615-platform-v7-2-917c3de8f9ca@oss.qualcomm.com>
 <yutyrfb73wbxlweoq3mc6ezyqr56snzmznw3k6mcbc56fpfayg@3h5jwymlo3ol>
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <yutyrfb73wbxlweoq3mc6ezyqr56snzmznw3k6mcbc56fpfayg@3h5jwymlo3ol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3ZEea8y6Ns-4BP7kxdKUeGn2rYLl3-b9
X-Proofpoint-ORIG-GUID: 3ZEea8y6Ns-4BP7kxdKUeGn2rYLl3-b9
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68afc5ad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=qAPg_OCVEOE_nEQcmFUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX5O6U62rmep3l
 5Vy8khqi4zUHhXerUhRszUvVOZaD5Vag0gN0P2OWNjmG2ZTLz+piKK+dEPs0lksMsRz1ufBK3cm
 A4yPAyC3i3rE+T1O9wW8l7xEhJkx1E7jGZm7Lhk10Cxhkep2RmAWXYwIj1NUzGFMdBbjdijaD7X
 rQdHG95uiqUROWt44JUMXhDr3+Jt6L+p6zDZkyrngGGqrwmuGsLtxgbCeEpkSYeM2eXEgg91QKv
 MrWV/dq9oqR8PQ/ezf5zw1x50jb8kgVPBT/SVC2DkzrgAKVyBX5XjtlIvg42b4VqtXWhckqYDI8
 tKIku8L/u50qN7Jt77C600m0PuDvm8Nx/C3ou6GeBYQnwCtoTL+oWqBkf35NSM62VTDd03KbGbU
 2lHZC2zb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031



On 8/28/2025 4:01 AM, Dmitry Baryshkov wrote:
> On Wed, Aug 27, 2025 at 09:08:39PM +0800, Fange Zhang wrote:
>> From: Li Liu <li.liu@oss.qualcomm.com>
>>
>> Add display MDSS and DSI configuration for QCS615 RIDE board.
>> QCS615 has a DP port, and DP support will be added in a later patch.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
>> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs615-ride.dts | 150 +++++++++++++++++++++++++++++++
>>   1 file changed, 150 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> index e663343df75d59481786192cde647017a83c4191..f6e0c82cf85459d8989332497ded8b6ea3670c76 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>> @@ -39,6 +39,76 @@ xo_board_clk: xo-board-clk {
>>   		};
>>   	};
>>   
>> +	dp-dsi0-connector {
>> +		compatible = "dp-connector";
>> +		label = "DSI0";
>> +		type = "mini";
>> +
>> +		port {
>> +			dp_dsi0_connector_in: endpoint {
>> +				remote-endpoint = <&dsi2dp_bridge_out>;
>> +			};
>> +		};
>> +	};
>> +
>> +	vreg_12p0: vreg-12p0-regulator {
> 
> I should be more carefull when doing reviews. I thought that it was
> pointed out already and didn't some of the obvious things...
> 
> First of all, the nodes are sorted. By the name, not by the label.
> Second, there are already regulators in this file. Why are the new nodes
> not following the existing pattern and why are they not placed at a
> proper place?

Initially, we referred to 
https://patchwork.kernel.org/project/linux-arm-msm/patch/20250604071851.1438612-3-quic_amakhija@quicinc.com/ 
as a reference, but its node ordering seems a bit unconventional.

Would this revised ordering be acceptable?

...
+ dp-dsi0-connector

vreg_conn_1p8: regulator-conn-1p8
vreg_conn_pa: regulator-conn-pa
regulator-usb2-vbus

+ vreg_12p0: vreg-12p0-regulator
+ vreg_1p0: vreg-1p0-regulator
+ vreg_1p8: vreg-1p8-regulator
+ vreg_3p0: vreg-3p0-regulator
+ vreg_5p0: vreg-5p0-regulator
wcn6855-pmu
...

> 
> 
> [.... skipped all defined regulators ...]
> 
>> +	};
>> +
>>   	vreg_conn_1p8: regulator-conn-1p8 {
> 
> Tadam! It's even a part of the patch.
> 
>>   		compatible = "regulator-fixed";
>>   		regulator-name = "vreg_conn_1p8";
> 


