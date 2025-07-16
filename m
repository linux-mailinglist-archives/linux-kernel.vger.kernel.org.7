Return-Path: <linux-kernel+bounces-733576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B7B07689
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526594E7070
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC02F3C30;
	Wed, 16 Jul 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MnE6UyyH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763DD28C2CA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670964; cv=none; b=JM4hn3ezlkZYmOVPpU+xaKnZYZghlGloAjopaL7eZ43/M7es2uiO3/kD6uJQm0V+aHfjJW5HYyTg5ePL3uMscADB90CZI5rMisdKVn+TR+9fdNqmhdkZE2dm0jUNomEDybV2Ep8mBZNOc1QkcF4RWD3zShIhAoWwfD9TYU7ZId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670964; c=relaxed/simple;
	bh=2n+yEqRmpHWX55ymaGQwEcO5PTCabHBKt4em2S2nQWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srTGFDqSxdCy71GHL4UqnEmD2Von+uu+YAT5QRLx7nPpyxi2SJ0k1x2WiDTJim+99NWIqv0YSrYIRDmyScQvq6kAWsGT9wKTdRSFhpiGl0hYy0l6SyeoDxOYakBeqeWlrkaypl97QGSCngLCBiqOSEMo5U/B2Y2sQS/2h0fOsZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MnE6UyyH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G62E03015317
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nbwfXFuBFxnOjI7T6twSdJDR/3cB26VOmjbK5IrO4Xc=; b=MnE6UyyHfZ0YXRqu
	8J0WeRFTtmcikbH0hEoZyJRjqI3QIUZngUYM91lRGunMI4FJn6dhbkQv/Dpul2Vd
	qkgTdU3G6ijnHg4sIT2BKIv2Z4Coy7ZlYqkEKRDbi9J7bujWhN6TQMGyedP1YawE
	lkXib5WzzRG9ajf9tEePxrWoYZ+m+5leNPTBHOfbZNH5PM04gG9220GL+x/7A8xA
	U8ksYoeCqCfimPkl/mMc42Aa3aClMk2SICAx0llxIiK+pCYEFclF53M2X29ZHBwR
	JTHa1B6jebloBlsXZX409RKhRlAXbgRVoBkcQaBBA7QxWBQwOg4hG42HlYSeMjmw
	l0vQjg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dypvt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:02:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fd5e07066eso16963716d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752670960; x=1753275760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nbwfXFuBFxnOjI7T6twSdJDR/3cB26VOmjbK5IrO4Xc=;
        b=YPVrFLF2zCHVsfCOQH1n9EAG57Zge06MsJFNW+HQocJpYlkp9Q7iy9kXQO0Jflsgny
         saivCKoMuP+G0+6UH6bLhARsnhzIlhUjd8LeV4LjgFCZIzTV8fdI5sr7KQ+GRz4T83oj
         Kwky8CU8zNeSXpZoslukip2mu+0VGoQr7MMDQoAvk0Oq4fsgTK46gjEra3BfIfNv+Cun
         Wr2bq+8afKwIiYTOoEJCreSeoK3BuYFOx6ZYh0tnF4i+LUx36O20wPCtuFn39TucnVhz
         MiZEBed8NhfgtIyilwVyI4j6WxRrYx3gSIUrQ7hnTcONu+uVcnjQ4xWwSAAEZ0w3UKl0
         YLVw==
X-Forwarded-Encrypted: i=1; AJvYcCXpM8uJoFR42GCQX9J51wv16OJhh3OIQcmzWDhzb67aKguyD6ONXPQYYzZoHSBwk9rmZqfgT3joUEpATGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynNM8ZvT8d+40A/oe6xqdxHNXf/LMlYFWEgDfxLtKxRuZcSYWV
	S1GH3hwUCIo4WYq1Fq/ND3IP0vAMzlL8Wifo7pipTYWWWlVC8bSdonxElkeKCIMJVD9mFnEdF51
	uUFbW8vx+rFschVy43XBKpxiPp6ACUdQA+Igdp5tb/bnrYmPnm5xeoZ5CHFizpCaXOr5wiiuOL+
	Q=
X-Gm-Gg: ASbGncs5fT6jmtwHIOf9KV5fBNYRkWP7UHphsxpQ3aoAa2CD1mN9Sdi/syjX9irWzlv
	pqSHueOC5Bf8KoO3WGRMdxgh1gwa9/IyWjsvkoV44fLIf64GkrFVH6OtkWy91iZBCJkIVeXpMml
	abKIfAuFQ9hLs/DWLMYl6EoZFnQOgtBCCVqT1dhusUnJmNmaT9RLolcxhRJcNEAcVPS0ztZgkZN
	j5OJKZV17afOIgWXYuxY9gV/j3N6qcdwwyxCaNul91InTnPcCYiaXhq/lCdM60C1l+Ej1MAMISY
	Ns/UmRMhHtZMy5Ha0AowSAxZQQtS2LDp/S0225OAh5TDFTcSV7Xp4DFULAAMGnnXHcvBEHgTCho
	pE460HmoRySYWC59hWqGS
X-Received: by 2002:a05:620a:f0f:b0:7e0:1602:a4f9 with SMTP id af79cd13be357-7e342b735admr177286785a.14.1752670960201;
        Wed, 16 Jul 2025 06:02:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7HT9MPyzsZ1m459bgHi8F8nr4lOxvRazSKaZ/G/h/LdCB+WOUXISiLr7eVmDce1y+UDGzHQ==
X-Received: by 2002:a05:620a:f0f:b0:7e0:1602:a4f9 with SMTP id af79cd13be357-7e342b735admr177284285a.14.1752670959667;
        Wed, 16 Jul 2025 06:02:39 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bc2sm1190983766b.135.2025.07.16.06.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 06:02:39 -0700 (PDT)
Message-ID: <4a189f35-66f1-4c1e-a9f5-e9ed01544538@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 15:02:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: Add support for Dell Inspiron
 7441 / Latitude 7455
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Laurentiu Tudor <laurentiu.tudor1@dell.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250716003139.18543-1-val@packett.cool>
 <20250716003139.18543-4-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250716003139.18543-4-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sk9tHPIUZEXxHqPM8_RaE5_l_JVZopfx
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6877a2f2 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=iLNU1ar6AAAA:8
 a=EUspDBNiAAAA:8 a=M8z6rC266kevX9ldIuUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDExNiBTYWx0ZWRfX9FT8BEIcmIOr
 9bUxKcQWpCbW3MEaignw8ZZmGOd++p6bMRCt9zaArgz5IaMxm6sIap/vgc8vNLeg9cgr+R5fY7t
 MW7Fr/WRZ3FXWU1lC4zn/kQaDteGdX/EP13L1m0ICFMfUIgtTkm79g9elDfhtuNwgHpuRLwdRw9
 4hb3WU/h+Rjxap0cv22NzsCakfus2tD3a13Owtny8YW5nnpAGDHNX5kT1w6fDbIKt0VnCy3vnW9
 MJT+1Z2xSEe2ntduHh07Ct7T6Rdoc711+5X7v2C25oedMTzWXtbaxTTXOWlxng+M2JcrwQi6Hna
 JHpYJkC1Ke1d1xrr8LOzDDuc2H5wu9Gu1f7dFQaysIhhl2VGk6/DS1L+30bMIo1N0xN39lJHAdj
 nN3oAeD7i/bBA7rhh7iD2AiarZuBPEoEy1LSb6P+hLv7C/ao3rDEkiy4FMCr3L5YzT59WOHZ
X-Proofpoint-GUID: sk9tHPIUZEXxHqPM8_RaE5_l_JVZopfx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=991
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160116

On 7/16/25 2:26 AM, Val Packett wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Add device trees for both SKUs of the X1E80100 Thena laptop:
> - Dell Latitude 7455
> - Dell Inspiron 14 Plus 7441
> 
> Works:
> - Wi-Fi (WCN7850 hw2.0)
> - Bluetooth
> - USB Type-C x2 (with DP alt mode)
> - USB Type-A
> - USB Fingerprint reader
> - eDP Display (with brightness)
> - NVMe
> - SDHC (microSD slot)
> - Keyboard
> - Touchpad
> - Touchscreen
> - Audio (4 Speakers, 2 DMICs, Combo Jack)
> - Battery
> 
> Not included:
> - Camera
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Co-developed-by: Val Packett <val@packett.cool>
> Signed-off-by: Val Packett <val@packett.cool>
> Reviewed-by: Laurentiu Tudor <laurentiu.tudor1@dell.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

