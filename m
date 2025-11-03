Return-Path: <linux-kernel+bounces-883279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 045ABC2CE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7725D4F33EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6183112D3;
	Mon,  3 Nov 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QowW6fGk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GiDqBzt/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB630CDBA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184873; cv=none; b=SBn6tCSyzLaEtvLbSCTT0BJWAd72S/zc4R8vXC/1erD5AOwmh/828PoBfmynIxKT4vg51SM9tM0HG9Az81VI3lE+m73HPnalZZYjPDzbFcJteNL3JkV1aK+k5Xaap14IJfdJoRlkm57mtpyCSQdel6ogvG6gbPBhEQK+YzHiqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184873; c=relaxed/simple;
	bh=NFYQCVMbdGRjI7lhW+EHLwBDHsi4WxpkmWWRI/GqzaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQJhrTngayCern8i7yt4bhPgfIEA0Oswz4lHLo2FL91SZ4avAWy4gC1UI4JcE3ge77aRdhe3+UAIymi5piBP6DNn6fIEiXKx0/JvOVgLWbAsZ0oPVC9WrXprAZxO7nX6UUlFE8KcLqY2w2bGWnvjHxIuQi8Ni6AZGv3C+oHD/ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QowW6fGk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GiDqBzt/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3ELGiZ3303997
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 15:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VEdddyNMXf9bAmgkTFPebTtuBuKfvPe2l8q8U4p7MCE=; b=QowW6fGkgsB9Z5/2
	PWIufPo4/+TACHSvEexD/v/Hg6XPIClelBviwdThttuKxysNEIdL0QRL7lqej1PS
	L4uF60ioS6/IERzHebiFXPLiiGd0dEpmdkKfQPKDLTmf2SQidIR6dV7D0Q8dpXiS
	roFSkaMA6dhalysRq1NJOlOPV3xsaB/kp/I7vv1StdqTlsp5Mn61zhkMaz09UI/9
	vlpNek2HfXcQJS59tvEHYPtwgbmWwjfr7cAGravUiKVfey9LBK2XcLuo29qAIxTw
	anHQ1PPC8kTUUMYJkkoZg/6icRiQGUHcGjP8fn5OTZYTLkXDPHkE5uLXvVzMVxZ9
	chjh0Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6x33r89q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 15:47:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b99763210e5so1288099a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762184870; x=1762789670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VEdddyNMXf9bAmgkTFPebTtuBuKfvPe2l8q8U4p7MCE=;
        b=GiDqBzt/IhJ70hh63ZGGIG18lPxuUjfvOH78viTI+utpw6j8f3kxaCDh+K6seU1skr
         QmcpqAHpL+yUpkCjJhGt2BhVxL8VIrlN6Z0fSMcE6yVaqv7Yg+90OpQAz0LkEIYrOKdr
         Zh2oEGK5wL2JkZ+2xbTkTc6eUaWwFh1nGWCkc0e54ZfBBD0+CcyE5qiqtUyE1HdCHC29
         JMNTe26UdJmoJpl+cYvepFxOheNqSpEBnj2EG17JDGeIEirHIoJ5qQ4nbSZwaIWKPF7K
         SOCBhRQFyr920w4hPPYI7cxgfjfI3Y5Z6tBBnrI3JdlWANZ0UTmR28kRBs4qYKKhJJ39
         LolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184870; x=1762789670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VEdddyNMXf9bAmgkTFPebTtuBuKfvPe2l8q8U4p7MCE=;
        b=Ppm0VnlpfXAhuL0nkatfNHTfp9FyLFaD4TMW6ypcgaf1/bcP1KWG5KUNRS/hVUzTEw
         ZeH7U8poPSVSRPif3rUPJON3zK8pyLrNeWelyTiuBiRMXIrR9AeWbYm7ovvuULTpFIWz
         efHB2OhiLaLCSnd4fbDEFIh5QG0twiF97ygt6vGlIFGcFJABbsZfxj7a8CQRyldcZ942
         tK4h+KUuLY7T6H1sjbVxhL4X2PThzl0KXFXOOR2NjZqgsqzVgq45o2Vqws3wk52I8mEx
         YfYNUgi2dBJ4st2PAr4x4PW1ZytjoZmmaYuPBUCrEkFPXDnWmzztEurmRQ/5r0I4G6si
         GJjA==
X-Forwarded-Encrypted: i=1; AJvYcCVkur/VMU2rAtA72JNAFHq4hIV4YvDr02nwru0o+VpGByIQiVFB2/UHnk5WYi6CQlKG3emH7dTP2MaR/+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQyOoKjdB6YbxCJtIZl9KQNXlU6D4NFd3K4QadulGBCy/pkNBn
	6jAJ2R0W3IWRxIZfQpoRbl0zQQzF6VGOd87wASIxoNYXEwwUI8mSU1NJTtj62DyQTP2pz5B7aso
	P0uDN1pi3/c68NmvFK4ME55V/Go4cnq/9tNH/+pNxFOfpKtbOz7dQMz9l5g6U9LVO8FQUS/319k
	E=
X-Gm-Gg: ASbGncvtXVHhLuwxulLpZTndCSCW7dKMrb7VnpVBN63UHPT4oAs6X9kP76tYM4J0E4b
	FV3L/nsDHpE/yyJLFZbKiA38bHJEzCYaUqHuFBXLu5rEBRCcPr9pmkFBlZaQO7BPNBFYB8DSxYO
	2RJVeC7GpzUmXXMYXMidWcMfkkzvScDC3B5DHI8r25DRKdfh4Kqq/MykYyuGaOMh+0Rbpq7v7ZC
	jjnTBsghKoyj3h9AyBRx8McW8xejBiTaPxvrMgZTpdX2JmeTNRBqSwXCNH36vx3cA0OKanErf/P
	mq5BivIGfRiiU3B09F2Uy9Het4/ZtX31aODsSRIDv/GrTFWHFFp9w0UQt1OBDYsKwuuMSy9SwM1
	0Mrcd8extaKpFOYxOwTxhTMVAzjlzLOBy
X-Received: by 2002:a05:6a21:e082:b0:334:992d:ecfa with SMTP id adf61e73a8af0-348caf8cbddmr16648048637.18.1762184870135;
        Mon, 03 Nov 2025 07:47:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVpXmVWyIKzUo/+2Ptc1oSkNmXSNsyiqRtgK+DMx6ft4GMD7jdlBQaRDEOEAjveI5820O8qQ==
X-Received: by 2002:a05:6a21:e082:b0:334:992d:ecfa with SMTP id adf61e73a8af0-348caf8cbddmr16648008637.18.1762184869615;
        Mon, 03 Nov 2025 07:47:49 -0800 (PST)
Received: from [192.168.1.3] ([122.173.8.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b9a87ad1022sm4982176a12.8.2025.11.03.07.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 07:47:49 -0800 (PST)
Message-ID: <e70cfecc-b2c7-4f09-8d87-6a7e0160769b@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 21:17:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 1/3] arm64: dts: qcom: sm8750: Add USB support to
 SM8750 SoCs
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251101174437.1267998-1-krishna.kurapati@oss.qualcomm.com>
 <20251101174437.1267998-2-krishna.kurapati@oss.qualcomm.com>
 <f2724aed-c39c-4793-9522-bae08ea97a05@oss.qualcomm.com>
 <ev5gosxqguzdbufy72gcjmt4m4z6kc67jcaznrhvvjldcps4g5@fntcevrjpqsh>
 <fe210f0b-692b-4c45-afc4-fc2bc5e57854@oss.qualcomm.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <fe210f0b-692b-4c45-afc4-fc2bc5e57854@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yImbluBXRxlWqCWD7b7g93Pq8ED2Tp3u
X-Authority-Analysis: v=2.4 cv=Z5Xh3XRA c=1 sm=1 tr=0 ts=6908cea6 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=MMhBVnj8KrYykaS7KrQ2pg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=bnGsvWLoHIYXS6adUUcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: yImbluBXRxlWqCWD7b7g93Pq8ED2Tp3u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE0MiBTYWx0ZWRfX+9UI7+Ta9pOE
 X3GSXNoqc1OXpVkiJyULK1sPxOlEzB/wb0G5lGc64CIKwLpNmZzAgv/NuFK/LjZaz5XUDc5V/0/
 fTIGvuptY+n5Zp1U9xgqE/kjglElFvJXjGHKJQXShipMnMkUPyT7OafkCsj0OjtvBpF7akKMOov
 E06eaWwQGCxSWx9PNIccvpS2qEfvIhsQtqJeBLOFPT3h+GdS2s9n7oD8Nj1k4C+KzwTcN5NNF1V
 O2l0dB9NJF00WDMB4hzMUGV27eqFV3duxX/VpR88t2ws9ZIxaCmhSPprNtZPTHYNbVe8a/aQeUq
 snY+sM8Z44qJ+2QN8FTD2it4yvsieeqbwKV4NXCwFrnvZAvUBRm1MyeI0+n2x3/I7GzHwrCau8O
 cH4/AXrdejM+SSd2TlKmEfFKVsBIQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030142



On 11/3/2025 8:40 PM, Akhil P Oommen wrote:
> On 11/2/2025 9:23 PM, Bjorn Andersson wrote:
>> On Sun, Nov 02, 2025 at 12:43:07AM +0530, Akhil P Oommen wrote:
>>> On 11/1/2025 11:14 PM, Krishna Kurapati wrote:
>>>> From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
>> [..]
>>>> +			power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
>>>> +			required-opps = <&rpmhpd_opp_nom>;
>>>
>>> Probably I am missing something, but which power domain associated to a
>>> rail is scaled to NOM corner here?
>>>
>>
>> That would be the parent of the GCC_USB30_PRIM_GDSC, which should be the
>> CX rail. We currently have a NOM requirement here just in case we're
>> going to operate a SuperSpeed link, and the driver doesn't scale.
>>
> 
> This is a bit concerning. There are other subsystems which share CX
> rail, including GPU. So a hw spec violation on USB may impact these
> subsystems which would be pretty hard to root cause to USB.
> 
> @Krishna, do you plan to fix this with a follow up patch?
> 
>>
>> That said, your question is very much valid, because on SM8750 GCC
>> doesn't specify CX as a power-domain of &gcc, this vote goes into the
>> void.
> 
> So the fix is to just add the VDD_CX power domain to the gcc node and a
> gcc driver change to enable "use_rpm" flag?
> 

Will check with the team internally and post a patch.

Regards,
Krishna,

