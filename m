Return-Path: <linux-kernel+bounces-842709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 28637BBD5CF
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E219349D1B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436982620E5;
	Mon,  6 Oct 2025 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n7uz1c01"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD2248891
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759739810; cv=none; b=s6IGCfVw8XIMyMHBvAYzJ0k5w3vjJjYXrTJxcNlLYWkyNEPcH+g+a4G5gtwwlpjGhek+W1h4xmUxIxbUyAnp/ETzXZsTC4tD20CAmMb4yEICiKQ82xhlaykMJL3hqcRewoHqcQs1qiqVlielFGdwNbjx2p9vIAXOSTqV63sG1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759739810; c=relaxed/simple;
	bh=3xJ7Z8oCc7s7mq9s3oXcMYfek0obhqDRgFqn5utKAjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NoZ7F+2ZXP/zthzdR9QqfEA/IPmBZrqlwCQIsEtLknCo0u3cZ/jLmv5KYGnB5zyJkQ7lpfHyF+6O19MdqK4xVwxWHUgT326Muw9OlQ555POhu3SL2Zu+ix5FCR33ovoaMeG9bjT27i5/BlzHLaEyOScClGwG/I8BaB3hmo9RVhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n7uz1c01; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NwWsE017153
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 08:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8346oKcNdc8O5mk8XD1GS+ABgJlZ0Nmd9Pq2hDG+C9c=; b=n7uz1c01dD2fH1S1
	n7QQoxOfLUV2LDSHj+OsVEEc4xzrT1Z3I51Zi2sX7NvvfS0C+pFqv7lX3ZWlvTYw
	x9/KoaKsv+o5C7OyNNODNzW2uzBCWYhiS2jGtvn9Y7K3BWnn3PUn3y/79QB+KDxN
	Kh1cMI37rtCU0SQebLkv0FihWCnhTxEor1re2o0rkNUR5gl0mLb2WGFm3n5ims8I
	XBH36nuFqrOk2wYnG5h7mdsgmXCIbIpbIpQ5yBkO27oRdh7PaDcKA1ZCMpvTk6JI
	WLgjYy6hE9qBwSCasgFFL3O9rNKzV+WOhCVYD5BauemCZg606+E1d31xxfAxFBGe
	bYLESw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk6ue96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:36:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-879e3de728aso88233685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759739807; x=1760344607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8346oKcNdc8O5mk8XD1GS+ABgJlZ0Nmd9Pq2hDG+C9c=;
        b=jEsfrI9Dofu6LoPl03FPfEEF+vBrixDhM5CtjCuj0dh30INVmbmdLrPl6bOOjy9Kfj
         6JlhOwhTSFo/kOKTtyHQAfAUHdfC+2XFyNtU3m9ooeaMyTb2qpgf098/dlLMAy/05af2
         A7vkF0YMIr+Oc2lDAcFuo0ARuXcYP31DT3eG/sEpSM1VZBzwu+WAznONPz0uio+OwBtZ
         mU21RW52xSpmYMbeiOINI+tXvZDBTx7/skrBj80uccL+/V9bQtNzEO54qHgsI9Mr57iC
         fi3CaAFch0uDmrcmG0Y0dkRD9z6T50T/PK1FRnqnpa6qhOdfjEEhyolkyra4XKM2jhXM
         QW9A==
X-Forwarded-Encrypted: i=1; AJvYcCWgaA/RkcyBzVWmV3Px1z4v7S0vFaWu6Mscb0ktG3d+CY8sxH5WP8XiUwADSXGho/afHy3weqxB7iSUePI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEjbWmjS3tTjgueafmzqZ8GYU33SFLjvK3nroJs//5lr3rfSB9
	RUgM7H3L4qQj9Xk0vHA4uPoXmvk4GwGXMArFKSqGGDt4rr4i0u7+Gee6Bw1f8zuxaEi/nR92YyG
	0J+VzDp5RuhuOEda//IzTqdtW9H7MnvYLRDCAQ5SE8B0JD6g0x58R+3Sn5+D/GdvKfrE=
X-Gm-Gg: ASbGncvON6XxdKT++SImQnsCv4BQpgNoRLT9Oqp5KGqs1iGjOnxQe/lDvFR0KL/6GjP
	r1kF1JpynOr7jS84kumKFL8mSa1uNhMJMpDBmKrEhRc5pYaiUAq7QMjDY/oj0YTh4Zd6FmCG2kG
	vl0l6ajqEkFpZaLdQoF4Lp83FLu+7BdalWqsBOLHnnq2eYqfh5amqll5rVoSLgkWpZ1/rxlnEEl
	PIw3Gvweglob86hvTM2iKGNB2tVXaFtl+4JqauKEiNr7G1DDZOYVAJ/9b0MTfP1X3C2e0LRkI21
	iH1BhQ3PM7jLwtfNp6PUfCK1NctunAwUcRRMYL7V4rjH5G1ptwvGRCiIyUloRzsBAaX510nRZr9
	RZ9g0M84h3E3Lj4dsfdDRpKnS8tU=
X-Received: by 2002:a05:620a:45ac:b0:815:9dcd:986b with SMTP id af79cd13be357-87a346d149amr1024823685a.6.1759739806804;
        Mon, 06 Oct 2025 01:36:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPrqe0FEK5A2rK0WqG2bUVqVAbMyKAAgMNM0yWU0D/lPD6AGWyTfFRy3QhqVeiDkZA8LrxUg==
X-Received: by 2002:a05:620a:45ac:b0:815:9dcd:986b with SMTP id af79cd13be357-87a346d149amr1024821985a.6.1759739806366;
        Mon, 06 Oct 2025 01:36:46 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b2basm1094364466b.51.2025.10.06.01.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:36:45 -0700 (PDT)
Message-ID: <c7639504-e605-4dcc-90c6-4993ada0e271@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 10:36:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] arm64: dts: qcom: sdm845-lg-judyln: Add lab/ibb
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-10-b14cf9e9a928@postmarketos.org>
 <38c70e06-f7bf-4ca6-8fe9-2a4012017cff@oss.qualcomm.com>
 <64a732cdc3fe9381e2f716be9e965fbc905c1416@postmarketos.org>
 <sarhhzxs77gthpap3vsxidvut2bihtmtyjecjbo7dgvglwfd6s@yt2w4on4f5zw>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <sarhhzxs77gthpap3vsxidvut2bihtmtyjecjbo7dgvglwfd6s@yt2w4on4f5zw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfX/Kf9vKeAyFMh
 lyORFEqI8KfzVUkTHX0LpWiUP20pvSGpyxi0via2mOmDeNl6SBoQAjaQlwxD/kO9HKwysolAREo
 NuVUpAl1Sggb6rIDJUcLIHdVn31cAwYzGAxM0Vmw+0dtWKD+QiflzfsgPv4oLq8cAe6vdeNNalg
 ccmAh4Hm/Kr8c+XtkiAxiHH0nw7rJJtkCNa/RDMIdyLC1Y/J81G4hU/4x5Z+4gj6GvkI1C5racH
 XcorfOtgm3LLPnDLVezCySGa768I6aGKUntpcf9uo9BYMSJ4Kyxb5/TeQ/d4XYXsJ27ohPI7XrX
 Ks7GFEGYiDF+6X6TSvh/UpfdOdmRDk4On3PNKXi4Wk/7aRrYIrwX0IrTFrxceAK7dEQsarpSWZR
 2QcWE7/JPSBGlnCnRm/0Rk/EKDBV8w==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e37f9f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=ruIub6WMR363QC8emKcA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: ptDbIBdyQS2VGI1zw4hf3ACYDz4jwJO-
X-Proofpoint-ORIG-GUID: ptDbIBdyQS2VGI1zw4hf3ACYDz4jwJO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On 10/3/25 11:55 PM, Dmitry Baryshkov wrote:
> On Thu, Oct 02, 2025 at 04:55:44AM +0000, Paul Sajna wrote:
>> October 1, 2025 at 9:09 AM, "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com mailto:konrad.dybcio@oss.qualcomm.com?to=%22Konrad%20Dybcio%22%20%3Ckonrad.dybcio%40oss.qualcomm.com%3E > wrote:
>>
>>
>>>
>>> On 9/29/25 7:05 AM, Paul Sajna wrote:
>>>
>>>>
>>> This patch will allow any values between 4.6 V and 6.0 V to
>>> be set on your phone, with the kernel defaulting to 4.6 V at
>>> boot and staying there until (if?) any driver requests that to
>>> change.
>>>
>>> Your panel probably expects a *very* specific pair of voltages
>>> and any deviation may cause unpredictable consequences, including
>>> magic smoke if you happen to go over a certain limit.
>>>
>>> You should most likely hardcode that specific expected voltage here
>>
>> These are the values used in downstream android dts 
>> https://github.com/LineageOS/android_kernel_lge_sdm845/blob/efa8458f79dffeb380d43b38b9403407f87d9f05/arch/arm64/boot/dts/qcom/pmi8998.dtsi#L484-L485
> 
> Downstream frequently further constraints the regulators. Could you
> please check the boards's dts file and the drivers (SDE)?

Or you can read back the values at runtime.. presumably even
/sys/kernel/debug/regulator/foo should have the up-to-date info

Konrad

