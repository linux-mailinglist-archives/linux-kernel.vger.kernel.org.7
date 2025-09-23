Return-Path: <linux-kernel+bounces-829272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB625B96AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A668A4A0306
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D992266B56;
	Tue, 23 Sep 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pCinNdp0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6616DC28
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642754; cv=none; b=kDZAeFY2LBty/srlOVeM+9yGsisV8Ayp8CPve7X6yacyPIyNUtqn9wW5I/B2CJlnYkLpoFGTPsFkLC4UivxlzsB8fovPShHaVhPkHwL4obsxiXxVUDx2phK2HoaCgpCy1iUBHGL3CSCf2xKkIVLvo3NKH0/aUfEb7XNpA6xubT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642754; c=relaxed/simple;
	bh=CcpwlYGznwOeaJS/CyloewOqXqfoX9eS8cXkrWgOiE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3Er28qrBhnE4ezScJcWuuilnJaHG2YR3pBX/D1OJ7WJ61lD5czEGGOPjW9hfg2W/4MYTDQkLIZt7WNZeIHsX9haHIRFmQIzLuJqblpgfWScwWPJGIAxLiXVU5wcV6Dj4f+15BlPvOGR0WCX8aGouni0uPKhKvR6oSWCTrZehOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pCinNdp0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NF6XOd026349
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jnk1sjZqjciZj1NSs1no/CPobCh/tOcCuUO4swDNXRs=; b=pCinNdp0eSGl93PM
	AOAFUXYkdAKh9WWDaXUeMLb4SMbdw713sW+aBMr09W4+PgEL5VP9SQVIieuIQNAz
	EIZX2DkpEO6GRmBhFVS8bc15EpnfRIyztBybvPAjAIye/t7lfNdVRreNOEcXKnhX
	dwvqkbd4Zw8WK8mvsF/33QRMsqnsjWqAf4aEDwF3AqnrF/TxmFzMaiLIFCx893z+
	eNJTxTPRDqIb6iJsGnOJEc9oYihq7kNa92TEqqwJB/wgbcFoWzb5BE96VfGJ+NJl
	4hHugFWbed7E70FYEFXDD8iCA+DEkWmkfchw3IOGD1OXCmnyC8cXhq+zmOmS6RUU
	rYl1pA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyesfh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:52:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244570600a1so155255ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642749; x=1759247549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jnk1sjZqjciZj1NSs1no/CPobCh/tOcCuUO4swDNXRs=;
        b=nGe0YRPNXhxGphF6E6BZ4e1sHSQdJYWUEf87AhTIWWtdRPRVEndzAmHEJ8XnYuQWHC
         y7jYiBBLdOG5FSpK9h2FjkEzPInV1mZdQS9yLYy8LShuP3SeE6E4JIArRE/kLzXcWDsQ
         XpivR0a+nJUmtlOfVh8CfM4zOQbFdpK6f9P8+j9pibddnPQ3xAhCa4VWUM+6KmbmpuED
         bu068cWdwYimfZ81Hgi1pCs/NV+P7FLMDp7RdCjmN4T2r2GpIYgji4k7vrZJDQ4wAeAb
         Si0AP9hfHo3mWcpeT5vFUvoC+bNlPFEEaEj5D5igDuereEKcgvV8GxP1JNfATgsnatIm
         UUIg==
X-Forwarded-Encrypted: i=1; AJvYcCVW9+4PEX+fdyhCXr4KRYSMwjO/bLeXoIYMnJS1rC+X/NqKaaiHDRin+fgzNOjAAG6iOzmu2O4+dG38ywM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOQK12iz2noGfvz7bB8clOoBwMBM/K35n6LWaTYI4nJ8zB05Wb
	m1s8jWWZBC0SraQolPDz3hxL6jm2c0eiFeetYFEKMaQ5im9kfTXmlQBhICNWVH5+sxflLwgkRem
	KEsvU0Nf9vJ9PqfJJRuAetUgCdfgKXHVIQsoYM9w3hWZ6s/06/L7SjSvoZIv+RtdWnk8=
X-Gm-Gg: ASbGncuK6dkgPaTzUByTBzeSFOmW+QhT+3edmRLyzlRdPKXnY5va2AJoS8BPF6r323K
	tC6RqrmivtqwiBfb4ocFLnbRBxrOpgnQop0T1nq4bxXLC5q4yAIxTt+U4Ga+zbhWIRgN4VScrlz
	MG/APfsugevZluGj1CCFoxPElX3I9Cl8D1e9TgwQrRge6Trb9oYDKgyXRLSCO3WavXhtSwE2CaZ
	PcfMjuBqh9KqwgGFvl0NYYMspzKBfi+6AzPQ1lyans813xAE15NDSswrab3RF0eA4w+lccnv5AK
	xhYtL4tYiT095A9CygnLtTOV9ZG67w36tLk3Nx/ErKfMwctcD/bAbpbWH9/Iu/wwDgXvV+Befdj
	N
X-Received: by 2002:a17:902:ec86:b0:264:8a8d:92e4 with SMTP id d9443c01a7336-27cd63d00cbmr36675835ad.2.1758642748603;
        Tue, 23 Sep 2025 08:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY0gUezkzMH9Q3U378qYMV2WlHC0rAlDu3HjPX3f+WdGE++O8MRSpNyCPTDPF0+I3PqGqDkA==
X-Received: by 2002:a17:902:ec86:b0:264:8a8d:92e4 with SMTP id d9443c01a7336-27cd63d00cbmr36675235ad.2.1758642747958;
        Tue, 23 Sep 2025 08:52:27 -0700 (PDT)
Received: from [192.168.0.104] ([49.205.253.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033c922sm161153415ad.131.2025.09.23.08.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:52:27 -0700 (PDT)
Message-ID: <23174908-5dc4-f4d2-3f3f-1225f999a227@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 21:22:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] arm64: dts: qcom: qcs6490-rb3gen2: Add firmware-name
 to QUPv3 nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, luca.weiss@fairphone.com,
        mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com
References: <20250923143431.3490452-1-viken.dadhaniya@oss.qualcomm.com>
 <cr2ehxr4udit6ddzp3pspsdrhtf4rpl5fzo6jakw2uo3gm7r6a@v3hwvkya62hx>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <cr2ehxr4udit6ddzp3pspsdrhtf4rpl5fzo6jakw2uo3gm7r6a@v3hwvkya62hx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rRGdd9gpHfA39C33FGrQMvNXVhrPpUpz
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d2c23e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=RtG+38I8ePlRmB+m5sTI6w==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=DAzQPIN5ulxls2xLjgIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX1pVwi7YWTqDl
 GiRDx7bXmd4SUnDybWkulsyJouNmSPX4/QtlxOZefYs/jfMlX8K4yMPC9cSc0l2Q72zy9qv4H5K
 VP0Yk3H9TEgoqRiPUalHKOpYVx9K0Jm9WtU9Rg3STMEwhZgqVDEqAAr4Esst1C5sfRzrRc1a6m+
 NgyWLgMAQGoQm1WJWAv55I0lPvM4s9BL/hOg/3ErFOsWcsnnvZm7Sqixq07xABTMJ9Et1lUU8rX
 1bbrGXDMhZz02WMyM52gdWFiCL1Y8aT5IoyN921VjgBuyDngDsqomWtH8nwVjwFFSqtiPEZfjQ3
 u4StUj6JrKQVF4QhraeaBvqtfurjmd+8Fkd4/vzsluObKsMU19G22+Bd4gPec0CEvbNVdqS4w7N
 lBeVBQQj
X-Proofpoint-ORIG-GUID: rRGdd9gpHfA39C33FGrQMvNXVhrPpUpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004



On 9/23/2025 8:43 PM, Dmitry Baryshkov wrote:
> On Tue, Sep 23, 2025 at 08:04:31PM +0530, Viken Dadhaniya wrote:
>> Add firmware-name property to qupv3_id_0 and qupv3_id_1 to specify the
>> QUPv3 firmware ELF (qupv3fw.elf).
> 
> Please start by describing the problem you are trying to solve.

Sure, I’ll update it and send v2.

> 
>>
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 18cea8812001..4e361580ddf1 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -1009,10 +1009,12 @@ &qup_uart7_tx {
>>  };
>>  
>>  &qupv3_id_0 {
>> +	firmware-name = "qcom/qcs6490/qupv3fw.elf";
>>  	status = "okay";
>>  };
>>  
>>  &qupv3_id_1 {
>> +	firmware-name = "qcom/qcs6490/qupv3fw.elf";
>>  	status = "okay";
>>  };
>>  
>> -- 
>> 2.34.1
>>
> 

