Return-Path: <linux-kernel+bounces-845162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3C2BC3BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 10:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8ED0E4E957F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 08:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A42F291A;
	Wed,  8 Oct 2025 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RccIbxiO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D944223DFF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910433; cv=none; b=o97/UhqX6MSpmssImRabi8m7ntSauwrcIe0ycQeij05v8XflLMcGi1cEXtA5eGVLeusAbW+FcQUEaGoc1seB6q8qNWN47dJDAg9SNHPNBpH1XlbTSwE+DO7hO4w8ZfaIzNi9/4P6ybKq2C8nfouMUgZZLT+hj17mxi/gya35Y5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910433; c=relaxed/simple;
	bh=/5xitTXiQ5eDNNCs1sAfErPkBv/6ZwwQcRGoSXhHsn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQvmciZxpASbDIQ+mO5J2Xbl7p2cu6DN6mz5qdPi5CNL2lTdm9vqZiqZTcvIARzssbNL//ns5yt7LZskQODhW20ptmHAxCTTcSgfGopVNuJP8bo9zUBfg+5I/2ZahToIliASWGFIfWRSCt9mZ2KGi/ftJzTL2VAtsO/mCttSmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RccIbxiO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5987agOw031439
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 08:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OFBsMtCW5P8eEthAK5JuEKPN/rQgShEl32y8lMaMUYM=; b=RccIbxiO+wSUrXG7
	riqHQZmZIfzrflvAq8w10eOLfSbRctyQIO8oJIp77PiBK7lL5oh9R58DALB7pqPB
	L4TeCUX42QRRomR5XzSxnjtrIAiPpN7u6cQ07cftrynrZMR6olXl3BTPW4DYR+Ho
	4L5E5vY8rcnz4+vNi//Q88dh/lKKovR0AEHa2o2ftO0CoR7hlLSM4sqoKi81uA4/
	nhktj/GYKZcw/AuwfOoJIb0gRrUjTMQqKDmMpL7v0RHopgPx3MGWnpFdsMLV1Yi/
	mFz4Zh1qEg3OUJu96jaZgEK9emn0uok6n9Mu53c09fMBl/J1M37sAQAB0DadNPwC
	taV/zA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9e1vw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:00:31 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-879826c55c8so15211066d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759910430; x=1760515230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OFBsMtCW5P8eEthAK5JuEKPN/rQgShEl32y8lMaMUYM=;
        b=nmdWRXiznaA/5FmrUZrsWtwqtAxkSbs+z5jxgogYTpjgaQa9z5qTXG+RO2LMwfbk2R
         fSdI64jV8JF/egJKBWxQzzFeFqyyKdlc3AmyaJoGgFgm+XcsUkQz7R15HtsNPb/rIE1q
         UpgeF1Zuo/IxE0aMYJ+VE74ZJvQ6UYoQi8YY7ytgCHV9CCFGXPKXTrbzfqmj0J+AjbUE
         wVdkkHonlrH0iDLPabO67OIktZKz8CDzahW91ljv9i9WcmbnCupH9t/dFg/xiGoSwUYn
         otcBJlQyYX0aab51jgFJ5TvpZO9nKwLCGAypygqC5x7MsSaWGg5gqzB92MJs+JNcQAkp
         MJjg==
X-Forwarded-Encrypted: i=1; AJvYcCUBijEiekMjtXwy35q0FW2TdgffAhnKRDlhdScW2Sj+3DPawblzzzCmbDREOtG7XUMSt5EhV+AdFVMlQTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6pksJAa7SwGbCph42WaParSgOCNzbpSY79JmRAv+CH03OJ/Kb
	K2l5Pip5PkLPz3/x8E8Vc8bfbw+xZmcA0Npe8Y1y2lL9Z44akHt8uf7lpT7OeNPikfM9x3/kVN4
	YH6n7goLUT/YxmsJtV6OnLaYI6BknBVlttzMwRS5ARu9tC0sw2ja9Qd1uEKRvbfXnQCg=
X-Gm-Gg: ASbGncu7UuwiYdC7YKvUqmIV26MaqLLZxnGT3zritZYoRSLlvAqgKrQPZlWddWMPe86
	hMe0lQQWTgcQydmpXDNS0hTbVCHcF0GqEB5c4f6lUBtGyeGFX/e1y2ofGYFlvWuZlRszSPt61px
	WNwP4hDHVBEMzxf5kzFH84kyENvfigpMD//7xq7vVU5LzGGNDaZn7Ay98pJivdMsA3FqoEMMlGE
	zvp+xIbrNDISLwB7fPgnn1ObsUeSiV4yy70yXHMo1jwZufRc6p5DnRmhXJLHi9tVVJSM4xr52jL
	Xb5UdX4tghF7TU/GIqGqol27LgR04FUOK2dSCO5zDf8MpurXeG3zwgWoB6X0FnX4f+a5/K14LE6
	o9CVsZlRFEjvKpm2pjgnwGcqb2J4=
X-Received: by 2002:a05:6214:240c:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-87b2ef94b05mr19467846d6.8.1759910429993;
        Wed, 08 Oct 2025 01:00:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI7CFIzMjiswdfQ2gg99EIIpUQZ3va0hQlGmy6utcIOqmtXbh7OWljL6IiZ8lPAjtXu1zVkQ==
X-Received: by 2002:a05:6214:240c:b0:81f:3abf:dc1f with SMTP id 6a1803df08f44-87b2ef94b05mr19467286d6.8.1759910429070;
        Wed, 08 Oct 2025 01:00:29 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788112bbdsm14092770a12.41.2025.10.08.01.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 01:00:28 -0700 (PDT)
Message-ID: <73e72e48-bc8e-4f92-b486-43a5f1f4afb0@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 10:00:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
 <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
 <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
 <4d586f0f-c336-4bf6-81cb-c7c7b07fb3c5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4d586f0f-c336-4bf6-81cb-c7c7b07fb3c5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e61a1f cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=w91pQayDMOQRg3Yv5IMA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: OGeCp8pk1Os8nCoOjXqwJ1f-0cCK_Txd
X-Proofpoint-ORIG-GUID: OGeCp8pk1Os8nCoOjXqwJ1f-0cCK_Txd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX9jrO8OvbZtiE
 ULljSG/pFzyiq6UBk607BbEjvSZ5e3qstM2dC7epYhYOtAQTovaKAEdhp5q0PFXpi6Xmkjr4p+D
 dU/3lCuX51qSjhY0Yjav5Shis0N/gG8Tv9wvKjump7JRtNPsrsf6JH6c3j86HBk8Sb4YOfkurDN
 ZFVdDQX6NG0T1tt8zziOUanjxh7+Vgh43Z7evVofDMCT+uugeiJ3qLpLo73uRWegU7/danVsruA
 xxlc7hgSs4uibg6dEN9h+XdI+E4esBs4jsXHjXNj7C+dYL+EuuVLfxaADFLkGRI/o1LhQ8ur6oy
 mvf6TuebviSOz7bfgBQk/kRXu7HJjrsqsoYTBsF6fkQnB6xmI/cZM2U8DvzTF8Kq3wb1ORfsdHg
 j0NN1NbHEEnahIdMS7OI9IX7V0ZjAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 10/8/25 6:41 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 10/2/2025 5:07 AM, Bjorn Andersson wrote:
>> On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
>>> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
>>> and x2 lane.
>>>
>>
>> I tried to boot the upstream kernel (next-20250925 defconfig) on my
>> Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
>> is crashing during boot as PCIe is being probed.
>>
>> Is this a known problem? Is there any workaround/changes in flight that
>> I'm missing?
>>
> Hi Bjorn,
> 
> we need this fix for the PCIe to work properly. Please try it once.
> https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com/

This surely shouldn't cause/fix any issues, no?

Konrad

