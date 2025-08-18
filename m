Return-Path: <linux-kernel+bounces-772989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE205B29A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8055E4B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247E278E79;
	Mon, 18 Aug 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MjLmYYl7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5995C277CBD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500014; cv=none; b=ZuCn03BiT+0gR4qG/A++Otc+27T7w0Q8orBogTQJ7rDZkjytT6AkFSyvj7eiOsYA4PUlFFdlLRVjuTao5CoSnQRDW5SDzr95SXMOQrVzGmszJazE6zf4NmnDGqtH9UVLx5r/iI9UpgcXGBvrQMHcD7PuC16z8Ir0L/UVSb/SWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500014; c=relaxed/simple;
	bh=EinHQ+DSGbJ3pcgkQafq1Ku/ePXDAA7sMkuDT8sNcik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIfSTe8ul78TeCjzktO227BzClfenDf88XARdDc1u/l6ExW2kSpmu/vVY9nbBeL/wOT6gUu8d4BbXAvDM6FkbAVbr98+cU5jHIBh79ZYmGH0hkxP17lCxfm+9dfNbhRVQG40xG1sySvGZS+3e07SOUAaifTDacY8Sr2VEnoAdV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MjLmYYl7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HNfrb9030261
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J8ulHSBYS2RPj5dpKiV9mZ+6G9RRs1klwA3DWPRwV2Q=; b=MjLmYYl7UiAjpN1x
	FwVeRfAJ77j8gKfc3dSyDgr2FnCSBwR6Kg7bXthHF2WGE4eQS7+QGk1HdxVEN2w7
	AE1ehXkRjMfve9g3wGXlvUs5L7cSiyHY+6WnZLtnzvRog42wT0FjCLFr1873NoFK
	sqnNnwDcQDDT/Oq3RBBDn1NR0CQ74J5D2Z+S5yRj105iBKuy7sXqd1wtBgno4c4H
	mvbsi8LzzUSv8RwQCE4JWybXweboQVrkmUiyW6u3dQnaXziBEcSCiS+B/nPS+eub
	IKyrPB4Gv1jYItXKJIgvXbZoKqVw6AfZeMkU3K8rXNp4VIM6Pa0osOwYcijetbnP
	Eubnkg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhjybkrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:53:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445806eab4so38153515ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755500009; x=1756104809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J8ulHSBYS2RPj5dpKiV9mZ+6G9RRs1klwA3DWPRwV2Q=;
        b=Ps8vPEoLzIfW2y8XpqDTvz0/PA/5M+UPqRReF4rOkXwDANwB0CNW7b2c4O82nSn/7B
         dSwu1gG5aAmBNj4+Hkl1++0sK7cgd2lfpBjyFBZzwAMQlwggM0a61tvD3gSq70l7Yxhv
         Dhn/YRZi2fGI/Go7FyJ8liVcnzSQOsacNWkGE2aVIsQp620QjdeD8ZrSME2I41YVshEr
         GSY5ts5Wsu0VVDIl3vnVVavNj1eVztUel94UXrAHjboAgeIhDxsRC94oR0kRsgtNkNXN
         C04t+u8p/hdKvMy+A/tuJY0hQyIsNICTPDWvdBWWfS6xZELC5COOGk083+Ej5AjQL+b6
         KDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgxVlxM+u9MhJmENCkDC/8uaJXrGP6saYl0d8k3QaCz3MK4qaAgGP8ysm/jNEYLTZsI0/5IW1ybo3bs6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx450SelkReBf1i/txxW3b4mymlenX29j4SAobw1kS0wLUjRKse
	1zvqn27SPc6QxGO+rs2sMzX1CaNCxh3ZvrBQIWa8NFi47BsnEEUvYPzYvfLEYhp4mESXC3rYHjn
	5eRpDHVaNx1FDKj70hoz6OgBY2GOuIvbjt7VG1WHu/4Bthw4yoGiQC5YxayDIPih326Q=
X-Gm-Gg: ASbGncvbgl4ag6bYHhcGf2biZwIMJmJScEX1QplGgu3BE+Xs/mBC1sIVISX1dtEWvnF
	FazewZpwIt3tt+xhv1Ive2G1EjeY5T+q6X1IAouDXuf+7BdRr66VXyOdvtG2QybrFS31jjfQriQ
	W94l6YTA0RfWfGWPhy/GydJStciruhoXHIzsX+QN6O/Nio1qJYUPXlJ1DdZ5CtZT7FM/1LXjZHD
	GZnsMNdMiZfOAKpDwqcxaeM5gfo1LlCkW3sXj5naYqITw7o0S161G1cufqTkzLKNntjXbyJVLXV
	8mSSKqTVt4w7I4x1SuKS1IebtPJysDAZtWs0cqEh3RBcqv0F/aFqyJSOsl//yWs1xgOMdILFOIV
	HxXp7
X-Received: by 2002:a17:902:ce89:b0:240:1bba:fc7d with SMTP id d9443c01a7336-2446d8ac792mr188538285ad.33.1755500009053;
        Sun, 17 Aug 2025 23:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT5Pt7gz6aj1Of1k780efYDT8e9XXEtt8qMHpKItHgK7LXJKm3SLl9VhFlh0djlPVc8CtUfw==
X-Received: by 2002:a17:902:ce89:b0:240:1bba:fc7d with SMTP id d9443c01a7336-2446d8ac792mr188537905ad.33.1755500008638;
        Sun, 17 Aug 2025 23:53:28 -0700 (PDT)
Received: from [10.218.15.248] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5769a9sm70671905ad.151.2025.08.17.23.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Aug 2025 23:53:28 -0700 (PDT)
Message-ID: <c8dc3383-be77-4075-9e04-f5ea693e37a2@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 12:22:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] arm64: dts: qcom: qcs615: Add OSM l3 interconnect
 provider node and CPU OPP tables to scale DDR/L3
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar
 <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
 <20250804061536.110-3-raviteja.laggyshetty@oss.qualcomm.com>
 <bsrhqkrzdapg72o6h6yx3pw6fjeseolt7zmq5fpvfhhdg7ktyv@zz3ueam6lcqh>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <bsrhqkrzdapg72o6h6yx3pw6fjeseolt7zmq5fpvfhhdg7ktyv@zz3ueam6lcqh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p4tAeL72Tt5z876SX3WGgXHEMdODYXDY
X-Authority-Analysis: v=2.4 cv=ZJHXmW7b c=1 sm=1 tr=0 ts=68a2cdea cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GIfAjeyzppbQgaMxSMoA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: p4tAeL72Tt5z876SX3WGgXHEMdODYXDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyOCBTYWx0ZWRfX0UMQPXD1kV34
 dyPZjcDSvTDK9LAedVMRWPsK5WJuEj7uKBSakvaRpqc02TSDeVUB06qpizBHjmjAf17XyiQoJ0J
 yQHSWtsIYgMnMkBUV9JXBZW2jA/oOEQTk/Pcju41s88Ln75TQXJN+aNQbH+V1bmAWVva+Cn8r0t
 SZJr7Uiodd4cLEvofGuxkdLbaij/dvdCO1n+njZ3ajWELc0luxaxvXXKBtYo/8yPVK5BYGr/0Tb
 k2FqC+Gr0toYEj1hFzJN/WqrpHhi3hddW33pw8j/GmbFDZII4JpyS5s+KhFVxvFxTLJLq+RP8Ek
 RXqAEB3qj11HaxmQMC9InQzMFaQdMu2u9SWkOvlJjtRsMeQ5fV6FgHVnW4aauut1WsVPVAtMRjt
 GE+lkkMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160028



On 8/4/2025 11:58 AM, Dmitry Baryshkov wrote:
> On Mon, Aug 04, 2025 at 06:15:36AM +0000, Raviteja Laggyshetty wrote:
>> Add Operation State Manager (OSM) L3 interconnect provide node and OPP
>> tables required to scale DDR and L3 per freq-domain on QCS615 SoC.
>> As QCS615 and SM8150 SoCs have same OSM hardware, added SM8150
>> compatible as fallback for QCS615 OSM device node.
>>
>> Depends-on: <20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com>
> 
> Yuck. It's not a way to define dependencies.

Will add the dependency using b4 --edit-deps instead of Depends-on

> 
>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> 
> And the comment regarding SoB chain wasn't addressed.
> 
>> ---
>>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 148 +++++++++++++++++++++++++++
>>  1 file changed, 148 insertions(+)
>>
>>  			};
>>  		};
>>  
>> +		osm_l3: interconnect@18321000 {
>> +			compatible = "qcom,qcs615-osm-l3", "qcom,sm8150-osm-l3", "qcom,osm-l3";
>> +			reg = <0 0x18321000 0 0x1400>;
> 
> reg = <0x0 0x18321000 0x0 0x1400>;

I will fix this in next revision.

Thanks,
Raviteja

> 
>> +
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
>> +			clock-names = "xo", "alternate";
>> +
>> +			#interconnect-cells = <1>;
>> +		};
>> +
>>  		usb_1_hsphy: phy@88e2000 {
>>  			compatible = "qcom,qcs615-qusb2-phy";
>>  			reg = <0x0 0x88e2000 0x0 0x180>;
>> -- 
>> 2.43.0
>>
> 




