Return-Path: <linux-kernel+bounces-740687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70DB0D7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF9CAA3A44
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0286138FA6;
	Tue, 22 Jul 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AR+9BUjt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39AC23814C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182592; cv=none; b=aN3+bX5KR2YSZkrNy2scoVpPnxiBgNs2eP0SRQ5hoOVX40CHYtYYywi0zF5jMEzo2MmFAFDKujsV7wR7n+7e5mlWUkILpIokjVr1tc5XtJ+PpSJ5gjb7Wsy9U0KWPw9oZryTGOXMioQtLzfSB6MNrH4zhb/b31/ZHtWnSK5JgVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182592; c=relaxed/simple;
	bh=k9gFtccRyZr3PS8hCFyCod0WF7T3hNE9whlMC9ZlnIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cw71GUbT2QDS0wpWr75ZxpeZbdQbAymErhr0ksfFUgnPYwY9v6emXTpqf/4HWMGxN4ZrcF0FwVLMZwvfPCNrBJti9Al4F4Cd3FEWKSU3TvXyWgoHcb+pglg/QB0S+evjfO4qrAyhsbikDFChcUvd8oglxBtnk4Vqyun2FPviKdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AR+9BUjt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7GI8i015134
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gAEx0UL7M6QTs1enGqcTXToDd6xrcRNncYT7Y34n7eA=; b=AR+9BUjtkbv3ZCZc
	D4X4weVbG8gewbUA7B2lFORSbsXjiU5mjtrvvZY7A7y7v9dA9Oe7tRqzH8Np2B2b
	ByAt4+DGxsxWGmKUaUOJv0y30aDx2KLpqf/DcpgPz5T9FxUDeUVMKv9E/vqRXwTA
	LldA7ygu1awZRnxFRZ3A4Ehx5xzNX3W99H1z7DIa1CH6nuJXCkImvHlQldeKissI
	TDwdw+PoIk2mGKvQJogJ3Y2jVRF4LNn7CsPfV+Wm7M7GC7pWZgJkVxvZabvBpCmz
	PeM5MykFblvC3k5TzDnSTD0TA/qeJ55KFDSA8sDZ8k8ztCB7C/vWzyMDSnZK00BQ
	uaHI9A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804n9yjmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:09:49 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-75ab147e0f7so2716389b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753182589; x=1753787389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAEx0UL7M6QTs1enGqcTXToDd6xrcRNncYT7Y34n7eA=;
        b=AjT9sqYUF0FkqDLFm2ma17ix7cCMqqEaLT4nX932DdQTulGuRNEnAaq6/UyqDhdrH0
         RAMKzaPLrtusbLL75CWRhepupo9VdQgPMXAO/33YidMKbFtPgCdUl5KPQSCwnmbSa/uC
         fCTa6ia8BIVTuKoZeql/ZE6YmQTG0Ph2kxnSR1KVXt28tud5975N1zKPrD3gxOTc0lgw
         KtlDpDaPPRbWdX3sAcBauswfdEuUjmV3zwxHs5Gz9dg6rCmXuuOhmLNfo2aChu9I0uiM
         Oi1zU/XjcEn0MsvyImqyfp/GcN7gr0T4RaSWCLc08pUkYy0zYzy9QGk78AlD7Fz1q8/D
         CWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUh3/K0lJ6w+/1gfARPQnjLsvBvKPdbe11PerEcORXoO88An7sdzBt8VR+8dWcE571PmOnk8ngaogno4BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyY+MF+TPU/Kd65KgDPikM2FFCjQMQQclppIKvoqdoN7eN3ad7
	QofZv15XSD7pWQygSzwisyEl70SlwqpibLtkDusyA55mSBWKHvHhF5b3EA+gDXnZTlKeATGrOJG
	OZtBzVrIVgAiT1VQG8XS5Rf00zH+/Up/knE8sdiiBt8jm9qbHDha8Lm8fpVfZeM0c1n4=
X-Gm-Gg: ASbGnctJDd1toIAH3vb1MLQP0Ehwq6kjo7SR5/prNGVkXRuPHGoZsA/xBIOTJvB+Vxh
	W0w73Lf0Xt9ET6lxU/RNCA15uuS9jBQJvI02CknRsaTJ26p1BV2YfB2jU7gBCug9bw0JLVT6e2j
	FFE6o/bBkxCMcXsf0eshoagqE56TSQKcVrG03Lape9uxDxcrh1A4PZ+LEVlhzuw1ZgS3KjzfPz9
	uNeLwC7w2heriFeNbPWmLZkDzQdlyTYulONLQo1emvx7Ko0O3SkwGlp4tkJR30E1tYmMJdY8NiH
	wTziN57akOnO/7dZsOEkBx2zneyjeXGtiH741dcYjRWn4gvK1wg8NOyGfXLsA71zk5ZUk98Qz1f
	+/AE8Q8+xE5GlyX3wJzFp0nhTBPo=
X-Received: by 2002:a05:6a00:22d0:b0:748:e1e4:71ec with SMTP id d2e1a72fcca58-756ea1dd768mr33061675b3a.12.1753182588975;
        Tue, 22 Jul 2025 04:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGPE5z6+2o8KZBtdCBcTaB+oemBzNsmBRfF42GZlFz41/nEi+spOtCS0/0Ga4FlVQ6AZctyg==
X-Received: by 2002:a05:6a00:22d0:b0:748:e1e4:71ec with SMTP id d2e1a72fcca58-756ea1dd768mr33061629b3a.12.1753182588421;
        Tue, 22 Jul 2025 04:09:48 -0700 (PDT)
Received: from [10.133.33.46] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e27a8sm7486514b3a.21.2025.07.22.04.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 04:09:48 -0700 (PDT)
Message-ID: <ef0a9869-0688-43e7-b2d6-95286a590075@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 19:09:43 +0800
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
 <822af9fe-5db0-4620-8f08-9232c608d443@oss.qualcomm.com>
 <rsybfhs6bb46putaytvp4tikauvhynhsam6aufxaflo6vkvzwh@qrh7sm3g7i73>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <rsybfhs6bb46putaytvp4tikauvhynhsam6aufxaflo6vkvzwh@qrh7sm3g7i73>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aBOZPKi6K6FAMTCBEf2PutxjJm2XDGmV
X-Proofpoint-ORIG-GUID: aBOZPKi6K6FAMTCBEf2PutxjJm2XDGmV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MSBTYWx0ZWRfX0hp/jcWVh7OY
 blt1ZZYU9KeNpdFo8fLsYZkJ6s9rJg3qu75TFitq76EZszFgKBGrPYRsoCN8h56j463G5FdZHgu
 DBQEf6Y/ugtpe7TyPt9KsBxmfH/O3PATZnNOAGheoLW6tSCqUwPbdCVw12dyYTEYgbTNgzUSQz1
 UDZiUA3cFA/SHGnlNw68fe55DgdBSZBCPDmMEjVQZBVuFKfWbjMWH5zHjzxEfhExTur9tBWFpUr
 JU+h/3qF3IhN3F/kHsVphh8HMndiMur0fhE1IFJ5AEIXDNRXx/v2i73rUyc9BPZzEGrPyGc7UZc
 1KbpgwNgFMOLNxkGms3smrt60pZ0NwIkiJb+TfBUezHwbBvxNj/xajsx6lUv3NvRlTdXA6qHgTr
 STOFt2NrcTkf26ZqQlC3Vuvo9fkzvFpWBCtDDdbd+EE7tEd1ILn/1K7iXCOdiqq8HTgUT+v+
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687f717e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=udvmD9vXOxOWEHquDVAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220091



On 2025-07-18 17:26, Dmitry Baryshkov wrote:
> On Fri, Jul 18, 2025 at 02:33:50PM +0800, Yijie Yang wrote:
>>
>>
>> On 2025-07-18 02:52, Dmitry Baryshkov wrote:
>>> On Wed, Jul 16, 2025 at 05:08:41PM +0800, Yijie Yang wrote:
>>>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>>>> on Chip (SoC) — specifically the x1e80100 — along with essential
>>>> components optimized for IoT applications. It is designed to be mounted on
>>>> carrier boards, enabling the development of complete embedded systems.
>>>>
>>>> This change enables and overlays the following components:
>>>> - Regulators on the SOM
>>>> - Reserved memory regions
>>>> - PCIe6a and its PHY
>>>> - PCIe4 and its PHY
>>>> - USB0 through USB6 and their PHYs
>>>> - ADSP, CDSP
>>>> - WLAN, Bluetooth (M.2 interface)
>>>>
>>>> Written with contributions from Yingying Tang (added PCIe4 and its PHY to
>>>> enable WLAN).
>>>>
>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi | 607 ++++++++++++++++++++++++++++
>>>>    1 file changed, 607 insertions(+)
>>>>
>>>
>>>> +&remoteproc_adsp {
>>>> +	firmware-name = "qcom/hamoa-iot/adsp.mbn",
>>>> +			"qcom/hamoa-iot/adsp_dtb.mbn";
>>>
>>> Is there a significant difference qcom/x1e80100/adsp.mbn ? If not, can
>>> we use that firmware?
>>
>> I believe there are differences in firmware between it and the EVK, even if
>> they’re minor. Therefore, it's better to maintain a dedicated folder for
>> each board and move the code to the carrier board.
> 
> Then it's not a 'hamoa-iot'. It should be 'qcom/hamoa/iot-board-name'.
> Please submit the firmware to linux-firmware and also move existing
> x1e80100 firmware to the 'hamoa' subdir, maintaining the compatibility
> x1e80100 -> hamoa symlink.

After looking into the firmware, it appears this board can use the same 
one as the others. I’ll keep the path consistent and avoid making major 
changes in this patch set.

> 
>>
>>>
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&remoteproc_cdsp {
>>>> +	firmware-name = "qcom/hamoa-iot/cdsp.mbn",
>>>> +			"qcom/hamoa-iot/cdsp_dtb.mbn";
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>
>>
>> -- 
>> Best Regards,
>> Yijie
>>
> 

-- 
Best Regards,
Yijie


