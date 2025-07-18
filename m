Return-Path: <linux-kernel+bounces-736316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26643B09B75
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB8858575A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354941F542A;
	Fri, 18 Jul 2025 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mNDBnRIy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F31DE4FF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820438; cv=none; b=krvoMKcDuhzpN0xJ0FS1By+N8NqTwo55pWc0dsXl4jrgO7639Wn11SnrBQe9Urz/OLB/9pRIuS004hL8I/6kQBQkMlkgiv6RwV1M/uZqRrkMpGzDEvEUkRD0c+7/UcVova2G0wwkaZBqFftHDBLubeiEsvJQQTzb0MD2grbI+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820438; c=relaxed/simple;
	bh=Kxlj3P3benQG+2FHABBKDzawQDsEvKMoOxiEZZi77TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fntk77Inc1jisK5pmzpt2mH6E7lhhNeqrTTbeFsA50+jlRLsMfNNfeaGNq7hm4mCEARc+sh92ZEUkgtrV0w+uO6qlE29soudQoKMbN+SKJEXH9v3og5Mn3AI6utn+X572Ssznw39QsioLRpplvGv9LX6Wi3agTXp9B0meUuNhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mNDBnRIy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HLWSY0028129
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:33:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8YdNKjpaXT688LWeZhfIGj5+PYEMt2+1/go9Rjxhs4k=; b=mNDBnRIyl/SBPF3+
	/3ApWqiUAtS5GrkgEMN3Jf2Q2bYbxo5L+IjZZPY/1ph9m5WuT2n7jQvnE42OWG8F
	h9tDjgGgGP1ZfDdjTrbe1ldjfP/EXvO/VU5QDjvs+ieqTcACNivI2tgXnuF9XYwk
	YlruX7DvzK6jHq8aga4aZepQ4KcGT/nVbLDxJzUa8TWNeDCY9slF+f0ARlEWNId+
	WIjbcnte2AZCtfTdkM7X4iNgE4gePVi8tVV8KjcZzrDi5Ha3Z5BvWwcigrec7kzE
	+L/g4rJQ9lwetTtHkHfSpH0Zu/tap+K2YkNIOyfdE5MH5bqa9yc30Vq6Bq64xlNw
	aLufZA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh62nd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:33:56 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b1ffc678adfso1386334a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752820436; x=1753425236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YdNKjpaXT688LWeZhfIGj5+PYEMt2+1/go9Rjxhs4k=;
        b=Ij2We06n99kTmXrFPAtCQTYxXJPmOQrSBldWyCWupo3PSFL7esNLIYEtrYWO3DPV9e
         XVSHrWimLnuXM1zk+B9AifnN5WlHWyBYKMC1ah8RDIeWBlX2K7o5PH40M05u6fykGAlq
         w+I9QqsGWmIJmj7yNTET9tw3A6+e1V1Fhhqz9vAP0Hn/raavPOzfLXWiJV/lVLBcdlK9
         G4CnIGRMrMHpYrTSRv5rBqmzu+6ABfTsDbbuB/QzFA3Ouv94z9gz4wSvDDwTFBSCmN7Q
         TWoNuJwaLzRtEFAfTZ7mUY4PKyt6Nd7BQGO59Wz2+YYVthkfGdv0OYm0PCmwk7tXTufG
         5YuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwe4D4j0SiUrG84k5G0v1jOHW02tYxAqUBWIuMuPy1Z3pG5/s+Ewe1D//XYTpKJ6YzWRHx3W+4kEM7CEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXHmryrGNJFXjq4FTlOFDgoTIqGKHGwZjMQU76pWaEw6cBjM7l
	O4jOVoLoGyZ72xahW3hPGza6UTCB+T+pg0u2JywuwvTNDCF5/Ig9bAL2xgHUUqOTlFXXEbe9Sjn
	IVVnUf9PnYVV7w8S5d4P4UZaXuZAC3UFCWmdnxEV39Md7PsEAzzKPDU0kRDuYbLxw3eQ=
X-Gm-Gg: ASbGncvvfR0oLoPqqPAnvW769IkjB+WC5iK27eiJX5Zd6C6SGZIwOAmI65kd7QQ3I0m
	iyJWK6F4ih7awVPfBRR94gKTkoJFr/mzk3khE5xeFhNOoEf5PaVavQhm3zvmKelPz3Dxr43XHia
	L0w8aAiwL+rtWaDN7GIz2kRZeY1RH5ZWvv3ixKuWv1h7r3QVAnYx3uOk5n74pp8tULOwuwbdBoz
	vqnPkXMwRPwyuip7qVBE8sAoOFC9VpdljlGTio1Ry0RzHZ5CZNpQ0bOVIpc0c0P7hS/vZ1rmxy1
	GDY34QOlly3HdRh7KRzU8tSAgvHXBFv8gqgbTmgBbddz6+RMIxzmiA8YdMAWf3Tl/209dHdf+yL
	vL5ai5MkVwSB6JicqyeXQw93Rrb8=
X-Received: by 2002:a05:6a20:7491:b0:215:df3d:d56 with SMTP id adf61e73a8af0-237d7d59f5dmr16155847637.21.1752820435354;
        Thu, 17 Jul 2025 23:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAK/W8gg/yU1O6D3eju/+esy68Zw1apyrzUq36ajkL4EYmGLpPS8QNcWJNk3M0FanCRGAijQ==
X-Received: by 2002:a05:6a20:7491:b0:215:df3d:d56 with SMTP id adf61e73a8af0-237d7d59f5dmr16155808637.21.1752820434908;
        Thu, 17 Jul 2025 23:33:54 -0700 (PDT)
Received: from [10.133.33.15] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc66679sm563798b3a.134.2025.07.17.23.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 23:33:54 -0700 (PDT)
Message-ID: <822af9fe-5db0-4620-8f08-9232c608d443@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 14:33:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-3-f6f5d0f9a163@oss.qualcomm.com>
 <b4nxjsx4fu4xmookpxukumw36wlcpzelh6axjucqe4lyswptm4@kczsldalq53n>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <b4nxjsx4fu4xmookpxukumw36wlcpzelh6axjucqe4lyswptm4@kczsldalq53n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6879ead4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=DGOirDVRF9kFrzJQLnUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: iGp59jzdJ-RDFFtv3aKAlX7kMHBgcgjc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA1MCBTYWx0ZWRfX4Pq5ZkrVn31N
 8j6n6043kQ1ZyDJ76jBBp6tV/Hv6erFUgCEye6QdExCQCVMdCdVsabMBouBwXRO9R9qQb8dGmN1
 JTarpA78xebee4Sttxpy9dARMtieYG8tvH1+I8agK+T0Dv88HO7SrjYcnNctb8QIXdqanSZm0Zp
 naUi5y77XyAMZ42gr5Sx3llhH8lADIEexYTZWJ5xEm/s13W0WesB7QGFRKpFqMYtF7rlQ2HO6Y+
 cAMve+DjoiteeCLTZaGrw+XNEdneqEJ3O+sb6INTD1NFjWwjbYWa8Cw0+hUaVoV3lm8h1ltD8RJ
 xGGnZkWCP0E+IY5GVPk1DKA9iCXfUwgsjxjDF3Bqj9B9q7VvfKfSKWFjPvbwaQNKfNV5qTgRC2l
 f8ZxUlyG3WTo5HUOBHI8YorIKga3Wfv5A7XSsvOegXHXAkjAXm2FX4Y/5raVxZgqzWHT83Q3
X-Proofpoint-ORIG-GUID: iGp59jzdJ-RDFFtv3aKAlX7kMHBgcgjc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180050



On 2025-07-18 02:52, Dmitry Baryshkov wrote:
> On Wed, Jul 16, 2025 at 05:08:41PM +0800, Yijie Yang wrote:
>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>> on Chip (SoC) — specifically the x1e80100 — along with essential
>> components optimized for IoT applications. It is designed to be mounted on
>> carrier boards, enabling the development of complete embedded systems.
>>
>> This change enables and overlays the following components:
>> - Regulators on the SOM
>> - Reserved memory regions
>> - PCIe6a and its PHY
>> - PCIe4 and its PHY
>> - USB0 through USB6 and their PHYs
>> - ADSP, CDSP
>> - WLAN, Bluetooth (M.2 interface)
>>
>> Written with contributions from Yingying Tang (added PCIe4 and its PHY to
>> enable WLAN).
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 607 ++++++++++++++++++++++++++++
>>   1 file changed, 607 insertions(+)
>>
> 
>> +&remoteproc_adsp {
>> +	firmware-name = "qcom/hamoa-iot/adsp.mbn",
>> +			"qcom/hamoa-iot/adsp_dtb.mbn";
> 
> Is there a significant difference qcom/x1e80100/adsp.mbn ? If not, can
> we use that firmware?

I believe there are differences in firmware between it and the EVK, even 
if they’re minor. Therefore, it's better to maintain a dedicated folder 
for each board and move the code to the carrier board.

> 
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_cdsp {
>> +	firmware-name = "qcom/hamoa-iot/cdsp.mbn",
>> +			"qcom/hamoa-iot/cdsp_dtb.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
> 

-- 
Best Regards,
Yijie


