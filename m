Return-Path: <linux-kernel+bounces-835712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD19BA7DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19CF33BE48E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4CE1D5AC6;
	Mon, 29 Sep 2025 03:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G+49I59T"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D7A92E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759116572; cv=none; b=ng8MgyKsZGkc8dUkA/w4p75KJqIt+PsQBvXNKjDS7WAm/jV10oM8rmLrhJABkusG4NJ8thqnVuAy9ONNEcU9+EAFJ+NbqHqIwW/PdVseM0ddmx2JhKGNNCTOPp4y71l5YuiezTFlL83QgyxrNKhjJdErpd979fE2GYmx7tRIp2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759116572; c=relaxed/simple;
	bh=K8qraHqJNe7HsPyyEq7xTjrGmMVphQmcAw3lwXikDig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j3H1pOmCuZbnS74wKHSbxjJ4LlvMwkfpC1oxSQqH1GKKHg4/BptJNu5q7NZ1uej87ldlE/S4SwCuRaEceXj68UpjfkUqt5y5r1rDE5dMH55DyOK5SKaXbUJFkM7DS30gIwoDjNa0a6+0OUJoQho4aR5nvEoRKClHtr13Z9k4kpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G+49I59T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SLpgSR005609
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tq//cuc7SMTQHHVY0AzFeuDQRLm9oa7w2WnkI/6+LUI=; b=G+49I59TIJkvVCwE
	4/zOHbCem5aEgWSIk3094WTdjHuxKRuqh6+caIPXH/X44Qv7GQMbf1zUhAsCKbCU
	J3OmgQasGQZ+W8VaGYZEhn8jLNvR4D4hjBoDdQ0EclSYPkTxN4vMBzhjHqhUPrK5
	FREJvBDn7wSgBE8RHWV1dKkGUlQmhbo0CCKgDNRdZd8DJZAel0+QDGS7S2PhXzWn
	6ksz9oo8RDNxw63rNW631AQuTXWwvFERc2cflRWdNjcFqnQKkveQ8jMRv3Tcg7GN
	ULuZCIRIOpssDBvpE7DPff3XnyNnGC1jX/4M9pxA+Hjh0sN1wWSn26M8YwejMSdU
	isBOlw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vqut4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:29:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-272ed8c106eso26067415ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759116570; x=1759721370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq//cuc7SMTQHHVY0AzFeuDQRLm9oa7w2WnkI/6+LUI=;
        b=EpH9xk0AIT+C5WyPVrF22+rInL6ci2SAY1iIia6V796gXEw5ns9cXZ/Cjt/IetD7Jb
         NjZMF7pUpPgIzoTCVbvtakF65Uyw5UJUvHsz+8jovhsf4qYPl/XApF0yy/YjqmVGOT6/
         rPsFckpPpvVJ+bwsOAAYa5Mgu1zV5uZZGpsgFXE6X0BGJseeS3jfD/V0GjEQ4a+fasQ5
         9OjTIBL5NpFbGhMknInD6s6d3pO20stJEMD86fG5R0fLhOXS7OLM0ODXpC1TFkSALwI4
         AJ1nbKZUJ4dRaFsKD2UeBnh/apl7+JWgr6U6SQ2iGy4QL3IsA6LbGpK4KgXfK1Gbiu4k
         zuzg==
X-Forwarded-Encrypted: i=1; AJvYcCVPX2TBMeoVvHVB/q4nSpXCkuZRkOcn++FB6pL+pwtVZNHcNUt8UD4jZfTH3Fw1XXTv5QTs1M5XRxY6JmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT2y8jCRGJoItvs9PcHIT95GebeST+FICe8R1/ImYpzXI59Exd
	dIj8pVQCcmvx4Htcx9cuLzdpOdlEiWfSTf9Qss40wi3XTnHnOaxBnSRjJFlDqs8IQfjy4t2/GG7
	usBS0E5Ipu1QasG80/4r6GYe8UeV2zjUYo70JFlavhLBFl8zSqPPDl0Ik6mA2oMJnHYc=
X-Gm-Gg: ASbGnctgGzFa6pL4vmvAjjSgUfKzRuzu2N121DMVZhR2LinyOu0Lz/z/N8mE1wsd9Wz
	QAL0cP7N6YoYPv22X7uqxIErx2V4kvkJtM9pay14RMG5xv6zY4ScRBv2m/9LbO9xyLLjjjKrc30
	pSE8bo7GQ4jRH2JtNWgK0BscPVUM3Sk4rIXp8QUkruWq5cHLU06PCRGY2ryss7sdyyBBvxaKbXW
	bQxMQPDB5KnSj3wQEuELS+7ijXbUwiF3NZzQYhsea8LtyivrxDiWfEr7vvdHo42WLD321JPTf1c
	exEyW1SCeH9BF4yT7Gi0tbRy+xyaTpipbXfqalFKog4rpCzLGY11AB5itfGcYgsFuLqKrrXU3jL
	jXLrzgPYRpzLlPe5PbGPFozuJQZcN6HqGnfc=
X-Received: by 2002:a17:903:2304:b0:266:7871:37dc with SMTP id d9443c01a7336-27ed4a7c891mr159681135ad.36.1759116569793;
        Sun, 28 Sep 2025 20:29:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8MHcv+P4/9S2bmGgri5K2DWPbMAKrUh2NahyouEA2enzL8OQZ6v2JXrX75gRKi4c10r+pLw==
X-Received: by 2002:a17:903:2304:b0:266:7871:37dc with SMTP id d9443c01a7336-27ed4a7c891mr159680855ad.36.1759116569339;
        Sun, 28 Sep 2025 20:29:29 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed68821desm117107765ad.91.2025.09.28.20.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 20:29:29 -0700 (PDT)
Message-ID: <dc33ba92-26ab-4e5d-bcec-b04ace0e6764@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 11:29:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] arm64: dts: qcom: kaanapali: Add QRD board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-16-3fdbc4b9e1b1@oss.qualcomm.com>
 <adxbl5cejcng4iukb5xeriyi3e5xzeqn6xvqmro7o3y5f6tlio@qwxwv64uxvfj>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <adxbl5cejcng4iukb5xeriyi3e5xzeqn6xvqmro7o3y5f6tlio@qwxwv64uxvfj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1a5v3ZCMZR_jqt8GXrTs5u7lbQuJJx5x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX+O8+/e86cIEd
 GXwWBhGk1YxfOCvKqvVtdf+WDSdMKWuzZb4R9ZwZQY9tgyGhrQFg/Hmb7F2Wazj6LazPjEtSgbp
 MsuhiGp4Oc16fYSdpvqwPzl01jj5HfLGHwpQpO3HNHzwv/pymUr2s+FoDht5fjikk9VHENkeeQp
 L6uQIC1ih7IKVjoeqEUmG3dM4yCptjRcGikwso057tl9uwr29uZAS7QSEWqc48NJJWOghNM7uxo
 9XcRsejqzuU655XAz/WpqWwhOtTo8woyNMuAfYIzJ1drD1EhMDqLZWGcU3DLONyISSza04seIoJ
 IUi+i/+k8A8kOXXofNXDFA/UhJJXprSPuqN5Vvq4o9B/XHrB8IM/CTzV90pdh0vhBt2ODZ37akc
 Arib5WgfOBgbOZck+iiNfONRfX3s8A==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68d9fd1a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=hcQ5UqVBHLjJEJv-LccA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 1a5v3ZCMZR_jqt8GXrTs5u7lbQuJJx5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017



On 9/25/2025 10:15 AM, Dmitry Baryshkov wrote:
> On Wed, Sep 24, 2025 at 05:17:33PM -0700, Jingyi Wang wrote:
>> Add support for Qualcomm Kaanapali QRD board which enables booting to
>> shell with uart console, UFS, PMIC peripherals, bus, SDHCI, remoteprocs,
>> USB, PCIE, WLAN and Bluetooth.
>>
>> Written with help from Jishnu Prakash (added rpmhpd nodes), Nitin Rawat
>> (added ufs), Jyothi Kumar Seerapu(added bus), Ronak Raheja (added USB),
>> Manish Pandey(added SDHCI), Jishnu Prakash(added PMIC), Qiang Yu
>> (added PCIE), Yijie Yang(Added WLAN) and Zijun Hu(Added Bluetooth).
>>
>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile          |    1 +
>>  arch/arm64/boot/dts/qcom/kaanapali-qrd.dts | 1212 ++++++++++++++++++++++++++++
>>  2 files changed, 1213 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 7edfa5fa00fc..da9ef255073c 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp449.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp453.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-rdp454.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= kaanapali-mtp.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= kaanapali-qrd.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= lemans-evk.dtb
>>  
>>  lemans-evk-camera-csi1-imx577-dtbs	:= lemans-evk.dtb lemans-evk-camera-csi1-imx577.dtbo
>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
>> new file mode 100644
>> index 000000000000..5900812c74a5
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
>> @@ -0,0 +1,1212 @@
>> +// SPDX-License-Identifier: BSD-3-Clause
> 
> Please sort the nodes in the file. You got two entries for tlmm, for
> example.
> 
will fix

Thanks,
Jingyi

>> +&usb_1 {
>> +	dr_mode = "peripheral";
> 
> Is it?
> 
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_1_hsphy {
>> +	vdd-supply = <&vreg_l4f_0p8>;
>> +	vdda12-supply = <&vreg_l1d_1p2>;
>> +
>> +	phys = <&pmih0108_eusb2_repeater>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&usb_dp_qmpphy {
>> +	vdda-phy-supply = <&vreg_l1d_1p2>;
>> +	vdda-pll-supply = <&vreg_l4f_0p8>;
>> +
>> +	status = "okay";
>> +};
>>
>> -- 
>> 2.25.1
>>
> 


