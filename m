Return-Path: <linux-kernel+bounces-816240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E585AB5716B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A039F3AF506
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917942D5957;
	Mon, 15 Sep 2025 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0cqSq+B"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A51A2D29D9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921243; cv=none; b=sOyWrgU987qvKNHEQvBBNs/PyE1U98oBW70RTFn4iUZs+z+xmM5rneZ1N5wfgZqmp79qQsEsVzjzQKxLrwJ5Up5hUN5Gl5kXJ8wywYIczj8FASma0irMgtSwuHLm9zpE3aYaDXJ2tJGNxnF2g/FZnEjpJnQTX+1LUZlr6poDW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921243; c=relaxed/simple;
	bh=3w6Tj3yZ5WcfNFwd5OXpqNPXWKjkPuKxVPbx2R2aOMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDbp8JHr/sgk++KsN6nzWvboV4jzxnSW+A+bBGS53cv5AnVmXTNrPp7pLshljJsD058NmkRpe374olEYqG+glrXWVz8G4vT9DM+O+cV7CIZNYrW588Lv/1O0AzwIlJ3TbI2A94YEDvsCtze2/qANsM2qw7e5EPZ07JvSXndW3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0cqSq+B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F7ICVl020279
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eGu4W1lBn0ee9x5u/lYEsjYwHwIwgyWNttS2IO7E5dM=; b=T0cqSq+B4KlNDPGP
	wuojkAkT03/SS/Cln0yCgCRfM5cIHh6QJbNuaVmeG4SlnAMF1gfgPWB/l7uto+Ik
	PrOkU6s5EiuoJzmpcdbE2gD8JqQyy61QE4BuAbE6Gb1WVciR6OzhVm6FkmfQ8XnA
	6h/JwtIjFete+U6/Ud45SaIw4ta9KD8t/HxoYO36g1hRBUqSUj0JmLr3v+w/GGN0
	x7/mIdIfHD8+mZRjHt/BEzXv7vEWEKI7HHx7/mn8tY6qTmLCzmgrWbgoN6iQCp5s
	AdIqHswzen7hqgJUqUt98Z2xlbNCTgqHfgs5qIRPDwCzyrkIDTzO4S98RH0iXPTM
	eWrlIQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqptpg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:27:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-780e20b83b3so4034556d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 00:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757921240; x=1758526040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eGu4W1lBn0ee9x5u/lYEsjYwHwIwgyWNttS2IO7E5dM=;
        b=dOphGw39r3gwI8tqwI6TRTdpb5zXdbwpTwOW8SKEO00ceE0WI1IBnnrjBPSpDU08rJ
         qp8mbj1DmEhOePaV4h1f5i5e2fAWGAeVUUHnv1kqgorA1lwit+zXE27BMwLWYYjB0gZl
         gVpMRniyVbrwlq8qegcPFqLeZvT4GZMdR++ZPu80mitRM8hoTsO3ewuHBgCLKm5lv2v7
         aVqIAkof9T4njemM/Bw7dPP/qfYBXyjWPQ+RzYEX7YgVwKe+LLcwv8PzW8A/PfV6PK23
         Vt3y5HDOh+MkX7iHozg6ZFOQ4VF8D74HTEdci4J1k/j+wE5MyKXW6337bXdYAv68B4Dy
         vxSA==
X-Forwarded-Encrypted: i=1; AJvYcCVHHKABCtcpVgfVyESo/NMsnu5K/T+wgg+X3oMS9Y6WbeXpL49tyjNWlc7NbQMl6Wy3es/nXV2L09huF88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjj4cmUwrA7XLLxFbPd3OrMxIrpCpn9Hbdolc5Hn4Jx2HjTlrX
	r1WURlrZ9YKl3JDllhT9TDsElp9tx0WrcBAxiKR14BWd+/3Pz9QwuXwPi0OaHjOxojrMi2gJbfY
	OHKt5Cn2HOCvqTPuNt+2Fs/X/4/w1jHVsf5InIjhLMDTTY6pytkYr9Uzps93G5P/CZ+o4yQd5KA
	4=
X-Gm-Gg: ASbGncuS6YG6b/bXwrnWlDkQRfeA2yJbnjA8rIdyKbr3EoLJE8JXCNS9LkZpkMBCLH4
	lR/NtwEvhboOShZwBzNrQi6ZddStJp97dhmMEaILciZFgoeKdALwDWFOCuZWyVXrCchI8cFcThO
	OApYkc5lpTSf9uNMKyLThcx8Ij4udGDOT1fJw8o0UbLOQ46xZZiMP9Sxk/OFiG1u1iqIV/KicxQ
	BTPkpqRqG+2JA/MXgX+1GJhwb/brQgGIqXu9lMNWRvIwOJsKq8Sbp0dOfK3zUs1GPvVo+aD3Txd
	uoaQ06ztNZ58yMpQLzLuJYhiTn4Kb/iMm5A7XwhVCom6Ir1jJCcLK4Ecek3vL3K8Z2IUtGIueB2
	XREQqHFYuae4tusXwcITWFw==
X-Received: by 2002:a05:622a:110c:b0:4b5:db7d:da77 with SMTP id d75a77b69052e-4b77d0a01f3mr106924911cf.13.1757921239915;
        Mon, 15 Sep 2025 00:27:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtobAvdlCKx4ucK/uBFF0UnOD1F2RQQxMsuY4by3yh/9zwQPo5Yuz4Oqwbh1x74LJLsPuMYw==
X-Received: by 2002:a05:622a:110c:b0:4b5:db7d:da77 with SMTP id d75a77b69052e-4b77d0a01f3mr106924811cf.13.1757921239456;
        Mon, 15 Sep 2025 00:27:19 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd413sm904627166b.71.2025.09.15.00.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:27:19 -0700 (PDT)
Message-ID: <b3c169b5-607c-40ae-9ca1-0977b6f526c2@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 09:27:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH DNM v2 5/5] arm64: dts: qcom: qcs6490-radxa-dragon-q6a:
 Enable USB 3.0 and HDMI ports
To: Xilin Wu <sophon@radxa.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>
References: <20250914-radxa-dragon-q6a-v2-0-045f7e92b3bb@radxa.com>
 <20250914-radxa-dragon-q6a-v2-5-045f7e92b3bb@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250914-radxa-dragon-q6a-v2-5-045f7e92b3bb@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WRwj_UNJaTsT_AC7udXwdqIVH3OZLEm_
X-Proofpoint-ORIG-GUID: WRwj_UNJaTsT_AC7udXwdqIVH3OZLEm_
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c7bfd9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=ksxQWNrZAAAA:8 a=Sl3xjKqUaxPrt8roMgEA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX0YikoHwmQ0TL
 /pn4zCpMqaqHDHXu73b8u3MDHadgmFnPiRJSrUYWuQ/QM+Q4Y92BitJmdctKaREEtpbw6guUDXX
 iRW8GtPKf75N372P4veyem3RW5JTdKi04upFEzKSJau4l4ox65L6MYEm9kmrUE79bt6chEqdtIQ
 9Rf//x25grJo7mEG78LU4iZyP5b0WjYXWIjn5JhxCBH8e47XDX2jwCIbQRQTfqb8gx+XHz/kVQs
 IrwuvSvot/TbYcOEG2byCB+z/a6biHN9fGMGdpyKK30fHLvbZ/rKmLqHNT/YoHrcPQ2PLSQV4MW
 rkop//7zqKBSceoJHMvNpvt4E0V/Br+hlTC/he10pkIc2vgp2JS65vT4hQSubyQ4IMjqUktWFAR
 NINJoJ1H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On 9/14/25 5:57 PM, Xilin Wu wrote:
> This board doesn't feature a regular Type-C port. The usb_1_qmpphy's
> RX1/TX1 pair is statically connected to the USB-A port, while its RX0/TX0
> pair is connected to the RA620 DP-to-HDMI bridge.
> 
> Add and enable the nodes for the features to work.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> 
> ---
> 
> This change depends on the following patch series:
> https://lore.kernel.org/all/20250908-topic-x1e80100-hdmi-v3-4-c53b0f2bc2fb@linaro.org/
> ---
>  .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 152 +++++++++++++++++++++
>  1 file changed, 152 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> index 3bf85d68c97891db1f1f0b84fb5649803948e06f..12bc9a0fcfbfeaabf6ede351f96c61193a8261c0 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
> @@ -78,6 +78,71 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	usb3_con: connector {
> +		compatible = "usb-a-connector";

Looking at https://docs.radxa.com/en/dragon/q6a, I see two of these.

I suppose there's a (dumb) hub inbetween - check sdm850-lenovo-yoga-c630
for reference if that's the case

Konrad

