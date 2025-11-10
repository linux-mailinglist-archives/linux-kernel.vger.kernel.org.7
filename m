Return-Path: <linux-kernel+bounces-892601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 681DEC456DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C62F4E37AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD4B2FD1BE;
	Mon, 10 Nov 2025 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m+Z3Lf1G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZZvxji+y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1CD2FD1C1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764518; cv=none; b=sPkSbv2njywCI5olD0pD8QHt76DylJVh6BXuXDMJq/l4fMlJ1DtSOizMVpmz841LPK5aV8QRhM2qoNHFPbBX4prBwYPnDOezPygOc0wBvPRbFCvbvUSTT/l9GHQLfxAjpmvlUYL4phoatBFNd0sXueY2mmAMjwb3gpLsaPi8Jzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764518; c=relaxed/simple;
	bh=laOBFdZdF6kgt1Nl/qfybsoYbD7vZYVLOcK+XoJFrlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8PaZbSxJQNpZVXf5Zsq6lNTNIg4UOOXnXFVoNKUfdj/ypwvcSvKj61Op3fUTxqf7Adr3MUMhsP8rtfScyl9pIeJBfmdP5I7tkHwdH8lGTRg0EgAmjA2d5RO2mifTx6fcr4d9uhEkg+b2zeam6dW4krVzV58ooCr4qzUSgaYg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m+Z3Lf1G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZZvxji+y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8B7Xc1364963
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	np8BFd2leJr9qp9c1WrvYL7Km/AP9ghIZ2N7cPw8mDY=; b=m+Z3Lf1GIEjWZ4tK
	bQ0BeYSlUfphMJmp7pY26yG1u3b0SLaCuKFIB4//xs4/SJJ8XYJ/2ltqMjQY7JnT
	SfBdnsLSDj/l/3flDQQEFOudY6sssOWhE5kVIcFxqsRGIiaVYdABfKb6fTBiq1AN
	kIwF9hZ5NvQ7FhMEueUsHhxTA1Grg9H54cTehRO5HQ6/3bgvKaPRE6yfyKadcStF
	ljoNmumLR6vIUzaFzEcRqN1Ecp8XyJ8ZTchoJFViY22a6/FbBuzVFyXAogecfd0V
	L6u+FtI8kLIJX08p5Xaw9FNNsz1xk3Pij1fgHbKpdIE6//EN8adVVntdiqVK6Yam
	607zhA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ab2nxhb2j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:48:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295ac7012acso15892675ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762764514; x=1763369314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=np8BFd2leJr9qp9c1WrvYL7Km/AP9ghIZ2N7cPw8mDY=;
        b=ZZvxji+y/8sR+S6VfL9onAH1MUqUa5ZH/pNYZntxUKlRa7FzLfiK+veitL+cY5rAwb
         d4cLw64/8jxh1V43afa3n9XFd5dkWg4MAfbQp8JT6eHrmC/1dfePYq2adc4UKBVJOthB
         jHTKzOwqxzNgJx/IsBPUfnfT+N9L2UvAvbVdtiXyYjvgRH1lRIvt85pOjDy3oGQwiQ9V
         amVEWc0lqBjbEMnb8ZWHQWebVIyWzNb2jOS6wzOwa/2f4InTSSxIVxJb2czcqkZQFI9w
         3HPUGsK37ruENWJbyeBVExbMU7zLWzcIlWRHy51SUXAli+2NPHD8RobUtAX6LOwY/8nz
         AjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764514; x=1763369314;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=np8BFd2leJr9qp9c1WrvYL7Km/AP9ghIZ2N7cPw8mDY=;
        b=Z85eBIZZEJ2QAcKckvRHjNGUvpglO1yji9W59Fl12dzqCjsO6KOSkJpIuHwATuVcDH
         FB/O8IosSaEOHiAElwd1P16KhMQN8RW8Q02HQGrg8DqcvC4zH85z6XArROUrrAgHT7d2
         tQAxPa0TNFq2O/pJhf/V0Kk5/iwo/YD/qKUl3DTBqrRFlP3OE0LFXtZL8Fsp4ktNAWzf
         ea62iwfucCT49KiKibhv7fvef6t+C7Zb9ZHeuT4bI7T4GaVNkwk+c/X+I5F1dNqJdpqI
         24MgeYxKEAj9/14+mEj0+oVQRPn6oWU3wp0BZHesB4lUptQvvNwbBWjdB7u5j8CbF3f6
         e+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk8LjvADb/fEyEX42sJd0Zel2ta9J4oAXJsJY/WVwW94rFnrD7cZuoHH5HcfsmLM3OS8bLx8QoZ7tJy7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fol7eA/sFgRFMDojAxqvnxjg/3x5KWaoKzbJftVer8fN6Qgt
	X8QH3HsUeTMjZn5qByfwgZy654Ti49R1brTd2jCrL/anDPYxVX2GKpOWJSuJe3L6NSeN/e2cviZ
	brsNR3fVLnDk55QXBqRpgt/F2/McuyKRYYQBolWYGvhjI5lGnpPyIX0/i8X3mtMsLBA==
X-Gm-Gg: ASbGncuWyP/NZUy+7lHgtvuyJFD85AQNkxTIeauJuE6QAMVb4+VbKZE3eIZGr74PPQm
	rAL5BDZTUBdxCo/2KrsItWlkcKE9oLZ6w0w/9hkfUqqXcPQE/qvHi0ifru54ef9FK7+HgPdg0BM
	MsYdWDUyPfale1fZMrVPke+GMvZqQjvbb7+rxGmS9lHJ8Pxzl4fizn08nOfcdPbhVUSea6xHr3U
	GiQmcF0JKTVOKtd3tTZCqTzyYRGsXJ437Gph0jZffTkCz2BRn9gNVCUrQqAUkYliN3dH/jlnn6v
	GBQnnrzTUzvmOAqySfSFRX1alyhb6flHR1ldBsYhqe/TIPZJ6TyqyFRRUTZ51ypNxpoU4cVbjf7
	xHjfHZG8gze5APgpuq3HB5ELwkkoH
X-Received: by 2002:a05:6a20:9188:b0:334:946c:8ef4 with SMTP id adf61e73a8af0-353a2f3d9c7mr4957149637.6.1762764514259;
        Mon, 10 Nov 2025 00:48:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYN++oAFbO2ZWEA5lhEp/eZEf4Ohql2dsdu6uheNC/E3zbINXVL4iwByQ7NReQxBPEV/6kPA==
X-Received: by 2002:a05:6a20:9188:b0:334:946c:8ef4 with SMTP id adf61e73a8af0-353a2f3d9c7mr4957139637.6.1762764513730;
        Mon, 10 Nov 2025 00:48:33 -0800 (PST)
Received: from [10.217.216.168] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffd3f6easm12380935a12.21.2025.11.10.00.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 00:48:33 -0800 (PST)
Message-ID: <1765edf6-cacc-4829-9ac6-2b9dd98ccc40@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 14:18:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 4/4] arm64: dts: qcom: sm8750-qrd: Add SDC2 node for
 sm8750 qrd board
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com,
        quic_pragalla@quicinc.com, quic_sayalil@quicinc.com,
        quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
        kernel@oss.qualcomm.com, Abel Vesa <abel.vesa@linaro.org>
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
 <20251026111746.3195861-5-sarthak.garg@oss.qualcomm.com>
 <99f951e8-b6e8-4b92-b55b-341a2f3f070a@kernel.org>
From: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
In-Reply-To: <99f951e8-b6e8-4b92-b55b-341a2f3f070a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mfrrAbUPD7n9zyEHpqmtWgZ0MVy7LtXL
X-Authority-Analysis: v=2.4 cv=DJSCIiNb c=1 sm=1 tr=0 ts=6911a6e2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=nosftV4G4FSUV_QDBQQA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: mfrrAbUPD7n9zyEHpqmtWgZ0MVy7LtXL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA3NyBTYWx0ZWRfX11H+IzEq6SMU
 Gjp2wddJKcootRTz3rrMDxfbPra4wsiGQ50i0wyA0jHwy/S07kCNHDQYlManv/j8+PiVABlcruo
 Aq1zhAT03vGml1X5Tn8TDScDJnCOR7en2BGMNVhqufIO2KcHLYybH+sa+16mL2D4RrXc1T9bO7y
 WbA6PpamdHZcfL3WeWRxyLnK2AGRkLggle28fJ2NodlOFiGun07zaIY1AWcavb4PU20YwgKDPar
 wVLyfYFTYE8pmbCcrYFWal3Mo4mx5zWgGYW3MsAEDhytz+ioei76F6gP2arHJPJ4Omdya83UZaU
 ak/89EwNXu74ofSzHS16eUO4XEnlAjgp5XtOc4ThmBXI5Z73BsXcZ3nQaxCovkMUdZObUzoOS3Z
 3JPit3H3Hw5mNFGrHIFaN4JDmEcuPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100077


On 10/27/2025 8:04 PM, Krzysztof Kozlowski wrote:
> On 26/10/2025 12:17, Sarthak Garg wrote:
>> Enable SD Card host controller for sm8750 qrd board.
>>
>> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
>> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> index 13c7b9664c89..c2ab39744a0c 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
>> @@ -1031,6 +1031,29 @@ wcd_default: wcd-reset-n-active-state {
>>   		bias-disable;
>>   		output-low;
>>   	};
>> +
>> +	sdc2_card_det_n: sd-card-det-n-state {
>> +		pins = "gpio55";
>> +		function = "gpio";
>> +		drive-strength = <2>;
>> +		bias-pull-up;
>> +	};
>> +};
>> +
>> +&sdhc_2 {
>
> That's random order. Please follow the order as expressed in DTS coding
> style. This file already has broken Qualcomm style, but you do not have
> to bring additional mistakes.
>
> Best regards,
> Krzysztof


Sure will update in V4.



