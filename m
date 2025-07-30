Return-Path: <linux-kernel+bounces-750678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A911CB15F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B1547854
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB8028DEE0;
	Wed, 30 Jul 2025 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="no08RDIX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D7E285CB0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875844; cv=none; b=HJa6CMgJMc7d9neUGqgW7gdjXPZpXeCptda71HgXj4u95ltb7E9tps1TIPP0dLNBd6m0/qJPwyNRCviESRqq7zaPmLhT0MI3ykcpZUPvOA4G8mamuzDoKYDuKI2eCLyhBDtKeugg6/07QjquyDvHSK/vEQ1E0RBrdnnfj0XfsBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875844; c=relaxed/simple;
	bh=rqMDN1zsU+hG2T+8Qrx8DABFTddtjXkccCiS/zqyOMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jml9Skg2RLfFzmHMcdAEvx0nYQHHA4zV7nGsIvG7q2Qn7OwxHjTTEY7tFspZe0ItPo1Kh6p8cWnisP+sWReADQteFi5eIEbHeO8856IULG3TVx27+pwWwmqPOrQfBnkGAU75pObgUcxtLILfTrPKdDqtn8tj2bmjEU7+Qi1IivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=no08RDIX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5bPnc005055
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M/EzCyvpAgY9MISP3q6AYvXfzSQXL1fb+0xMy9C+URs=; b=no08RDIXnjW66Vvh
	r1nFy1viiCiZPngKxuzMtC+VC+9kFNswgBWYNlWW6rbuJS/KORp+qTL2M8Sy6cio
	+OhHaFfA618XCZJWXEOLoo7EiQftp3n9MWQ2dxmcSHkIXT32mysK7kUW8k/DNLyx
	jwdbMQTT4wp+15Rqt7WEoNozzZFHTHFUeHpbBNHaDr+SjQptw2fhXDVHctpz2mnX
	e5XFCgieWvAPtVGZ5Y8LwNkQluN+Yql4B9vHc31Qx2ZiN8UwN0EAtbGEt6E3VWPQ
	MUq7KWbhANpxDEqzZzaUoVX6wyND6GcO2I1JEzJq3Jf8lbq/9DorA6OQbE6NOSHn
	QOgy5Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyu3x4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:44:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ab3bd0f8d5so17942441cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753875841; x=1754480641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/EzCyvpAgY9MISP3q6AYvXfzSQXL1fb+0xMy9C+URs=;
        b=iwQ79IHO8aAlkJmd0C9vx7AXRIkCm+RcdoPQTVy1NB7Tl2SnEHISs2HXj0CT2qotnu
         J22t7Wow9eYrs/rJSjXakg3TZrAjnkFnVWp3o96VSLepzoXmx/9ysjRrNmUXaGWOq8Gr
         ACGGIMTefLCJh61g1AxvqvOsEBZ4Uo3oZxB22SDJuNUf94ozJ6nsj29vDrE4eC2rk1cB
         3mhD6zJeXdDVtQ6e5LoXYXTcoGqezlArV0CqzGJdsI6vHGviwCyI4YnJPhH6ak+JTwtW
         rDJNSMpsX3xfBZgt1NCnQQxte9yQtib2Ipqhj0YuQAlpdXCwT/cP3T2LMkDnQ3HVcYzw
         h1xA==
X-Forwarded-Encrypted: i=1; AJvYcCWEpjydp2FHK62pb/RGjysAiFBOjbZSyU5LGWbTsrDvHitWZ3MnLH0lSxxcoHzACE/Lh61P0rEVpApvasM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwppTx/2s1S5a3BzhW7l4L2VqJavFU9/OvBEN0FQOYiaVr5rx
	ciTxK7QjL8EBK+akEXnxBjBQu/LjaYyL+xznIUHAFTTOVpHMQCXiWd9G80KCIhjYa3cSfeym8qu
	hzWNIWlUdUcZyu6zIlYwNbLlGrvj7XxbIqF6YCUO12z/aOg7b8pQ6Ue0IH7rckar5ZuM=
X-Gm-Gg: ASbGncuCGdc5JweA1LBvqeAnoqP8J9/bsRejOG8Ju9CbpT3f3D5bPP+MRQBq5VTDuLd
	JfpWEYwu9Ur+NXlLXAWjSbbya7m2gxpVZGiHxpx9yvplIQYrk3Qdo2KLCOIVjyZ/xJN5eqyf15u
	RMdhTfFTRGBT77CPmdkNVpZ+kUxfkjrLnLj599MNpfSrvHc+tPzpIRYkkKALgpMp7zn6idPtE73
	OrAVGPtl/ZQfYyHL6TGNyWvdWQD83xr8jw7lBTSPmLnSvVAtehJJQuhf2PQj+8HESQ3oNFQEM1F
	wKEsWROEjPyyOzsHjLZwyzyArBQcUKF2px7brRVltFAqB5nBSA1VpLpY1n8zUPnC7r06Akjqavs
	xJkLFYhE21IzWov1VHg==
X-Received: by 2002:a05:6214:21a6:b0:707:5f89:c024 with SMTP id 6a1803df08f44-707672d915fmr18487696d6.8.1753875840960;
        Wed, 30 Jul 2025 04:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg0l5wUfzsorjVdOSrfYgTfwtN05JUWVtVu03ziGY1Ru7n0D3X3xNhoGQNRqCipIcN1LEceg==
X-Received: by 2002:a05:6214:21a6:b0:707:5f89:c024 with SMTP id 6a1803df08f44-707672d915fmr18487476d6.8.1753875840532;
        Wed, 30 Jul 2025 04:44:00 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af903532dcbsm85565366b.88.2025.07.30.04.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 04:44:00 -0700 (PDT)
Message-ID: <9597ab85-6c91-4e76-b160-0257bc4c5412@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 13:43:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: add i2c nodes
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        kathiravan.thirumoorthy@oss.qualcomm.com
References: <20250711111418.3980520-1-quic_mmanikan@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250711111418.3980520-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ybbqdpo1d-CLB5Jke0LqWhDFFMUs9q2h
X-Proofpoint-ORIG-GUID: Ybbqdpo1d-CLB5Jke0LqWhDFFMUs9q2h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4MyBTYWx0ZWRfXxUJnoAS08rDm
 UJZCwsUXl0Hl/QoaXKlpvh53yTQqfLc1o5GWMbzKPoWpNaCiQVDN7EXGv66uWEOk1Kxu2jQuAf6
 /sk/0i1LBl6KBhx4shnfggEqMV9uFCZNBXeEGQNZ5lo3QSoFB98AcBnS/zGPUx+2Srv0Iu1sR9z
 Nho6ge1/Tic4a8L5kRvbH81peqBrEPFGd3v6V3uaxwy4DI9A2pT/mWFNkBcJxmE4KsGTljIThhi
 44aBuglzon7u5xyzLxQPTDmxzpbshjq2RB6ZKH9SsQ8BT+LHEEJueyHT9l/x8VGwc1llUi7DZzd
 SOczvQuYWJm9uRRUu6gWK5npSf7Fk5rHsPJK84Qx4SgFwzsDGEt0U53d3zIBaQ9Nrq0z9p3wke8
 rC1cHDdBwrr6XxquvJfQyIwR3ttoUJJJmOf1/MbUeilV9mLJCIiQlFEI0tyfH5/Taw6VJ8n3
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688a0582 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=eP2xjSEA0m29zfKqGnQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300083

On 7/11/25 1:14 PM, Manikanta Mylavarapu wrote:
> Serial engines 2 and 3 on the IPQ5424 support I2C. The I2C instance
> operates on serial engine 2, designated as i2c0, and on serial engine 3,
> designated as i2c1. Add both the i2c0 and i2c1 nodes.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5424.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 66bd2261eb25..858b9c714a13 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -425,6 +425,28 @@ uart1: serial@1a84000 {
>  				interrupts = <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  
> +			i2c0: i2c@1a88000 {
> +				compatible = "qcom,geni-i2c";
> +				reg = <0 0x01a88000 0 0x4000>;
> +				clocks = <&gcc GCC_QUPV3_I2C0_CLK>;
> +				clock-names = "se";
> +				interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>;
> +				assigned-clocks = <&gcc GCC_QUPV3_I2C0_CLK>;
> +				assigned-clock-rates = <64000000>;

This is very wrong, the in-driver handling should be enough.
If not, add an opp-table.

Konrad

