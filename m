Return-Path: <linux-kernel+bounces-857214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 430B7BE6356
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7D074F31D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96525393B;
	Fri, 17 Oct 2025 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7CiWD4X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0201DF996
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760671656; cv=none; b=s0KsvlnY4V9wAXi/GDPa0v5YLe5v9FkllncDBIDvJPA/y/bRnYqgbUwZHyfR6lHDiUigtdgOwbwQQ9bL5nFb0ynqFtZCqUQ7jiBbVCXlQWr0j/DPvlrSjSxgYt1eIr4yyXjLU2cLv+uVmxZzyGyEVHvAEr9GcnlOiuA+UDQ5O+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760671656; c=relaxed/simple;
	bh=bpxlvObGWZqlXhfi4AkPZMu6AjrfNg8tFGT5e+6zURE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7affB/nsH5xg9vqnsD8i/OtOaQUXSh9HPj0XgDKfGocPUj9Pi5j1ggFMueS6sc7ihHsFEFE3ywAjdebyEydyIZGqmYH1FLanfJH7Uk2c9kBspVYLv7yyTFHrRftG0J/U348Tk3E+Ox/+6eGsziO2Y29TgwT3GaLtWOYDOBLAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7CiWD4X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLP42025233
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/89NhQKdqoqte+xpicQhKtPZGxqewp0bE+hnVypDqXQ=; b=j7CiWD4XczloLFYf
	uQx26OVr+Du/JH01q7B/GVcvRHccunIjpiE55veS1fKcp4E446GtmNt124MNEqQW
	Rse+DjfwmKz75fOvsuc/eLtW6UPXoXs4kqOPLtlJd5H4ozKjKV9LVBdBe24qYJdk
	OE9Pc+R+kfl6KyfNNSEuTE8kc5QuSNKMMh0MarkwSt7w5PS0n+6ZZ+EoxXhZAcU9
	ddgihQhzrdTZlwMuifO3JvxBvvA/+ngrV4c9/OB9P4iOfKzbdzw25wIFLmpk97+Z
	pzZVpe5xqmVlt5VH3htaUuhjzdEWGx5qwFyZN2bI/r0zw64I+b19VHewYX4PeJn/
	ECYiWg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdkjnk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 03:27:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-290bcced220so10903735ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760671653; x=1761276453;
        h=content-transfer-encoding:fcc:content-language:user-agent
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/89NhQKdqoqte+xpicQhKtPZGxqewp0bE+hnVypDqXQ=;
        b=NuXGPrU8YpStAXOeosCerBQI0wRtYUhiflAX8XsmCF6omIs4Qepb+sAmJ0C8W3SIXn
         ugcZL9tK2wm0o2K8HEAFD6Ki3Prr83Y/IP5LBn6mDrlgWrcgJ9WorgCIoJSlmOqV1hF9
         I+AnLDQMByIgr3jubUPSjm3/NCyR9hWKZ1e4Dv/yZEM2FEfQTUqKNydpPqRvpCQJ22JH
         y32p5baO5jj3p9TpAfqu2kGaT4Pltm/J7hGEfVbhcq6nN4gHhNj9D/S5Iq5pbRDV7xNE
         2uNOaZ6RvzAysMJOVpA9/ToZrfzAHbpfCZ53+WOtErhfaih0WIq92T7DKD07uQ9ccB0k
         1ufQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiGlrIdk05U5/cAAl67GT2c0ZpDdqhljugQtJWsdqzyil4n+p+KJ9kUR0eAtH67uGz9tEibpF1KfSb5Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDC3QkLTjQOguPQYfdIUvSKI4ThyiXgZDB4yeLPz/biT3jD7m
	dohJT9stfVKRp63qQDRyTMeIzhhOSE0TjYUXGYxgj/sp9FP147U8GW10rqHwChE7T/1iJfCbkLg
	EfG+qJjV31Bi3IdjxOx2/P/s8pVi0iTeW1Tpx8yRjP05EMTP8CjRJsj5T9lN/s9GPeIY=
X-Gm-Gg: ASbGncvvxNo9/7WRTGfyTlD5PbXY7QlJJpGiua/M6XGIm4yOqlZu16CcarIhTLBsuwq
	u4P0iSkqxVQ5RSi/jgoRydJVofnsdaLXvCK15sPUBjIbasIyThXwhcu3Pq9U/biyz5gGp5ahQTZ
	AgcD2Setla90nTCd4JsAZb7Tv4jloJ+kG1c7j2OIjt9WS6zIo+1mcfsm7FhSUA/ClU37+TnDOYi
	T2sTBQODEDZzWmqwDEUR4D4XgoSs0n4+VAX/mNJ44X96S0a5vkdYqzjElSp1R9xpqP1XYZRA6Fm
	yzQ3jVPBneTC/+p9fZNQPMQn3LnE+IBVLWOlQ2OpKjTJ/Pqj6cRpflVJXYey1FukKzE0xLfhGCS
	skMgJ8Z5akkaJpB8+LUfu1wAna+Ak
X-Received: by 2002:a17:903:2343:b0:290:a3b9:d4c3 with SMTP id d9443c01a7336-290cb7594d6mr24632365ad.56.1760671652956;
        Thu, 16 Oct 2025 20:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9L7F90cxwCk31VMkjU5gCAsBpLq95tQORQNvi3x3FLHAzsKadq8hknCImdNDErBQ2m48CHQ==
X-Received: by 2002:a17:903:2343:b0:290:a3b9:d4c3 with SMTP id d9443c01a7336-290cb7594d6mr24632095ad.56.1760671652548;
        Thu, 16 Oct 2025 20:27:32 -0700 (PDT)
Received: from cbsp-sz01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33be54cad3esm104753a91.12.2025.10.16.20.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 20:27:32 -0700 (PDT)
From: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: lemans: pmic: enable rtc
Date: Fri, 17 Oct 2025 11:26:26 +0800
Message-ID: <794c77bb-db9b-4b34-b632-62ea56616213@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0dd6a528-d204-4073-a4b6-76356e71c5fc@oss.qualcomm.com>
References: <20250925-add-rtc-for-lemans-v1-1-17fc56451c84@oss.qualcomm.com>
 <0dd6a528-d204-4073-a4b6-76356e71c5fc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;
 attachmentreminder=0; deliveryformat=0
X-Identity-Key: id1
Fcc: imap://tingguo.cheng%40oss.qualcomm.com@imap.gmail.com/[Gmail]/Sent Mail
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 2nh4qrm69_kYbn-zI0d5PVkNr6m20uMc
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68f1b7a6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rOiIU-5ZP3SxAgHWUzgA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 2nh4qrm69_kYbn-zI0d5PVkNr6m20uMc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXz1l+ClHSUCqv
 A15miroVUreM+/+cw+uBFX8z0+RZ/lDgZqiLP4kLx83rycNfsF7Z1/aZmQSW2Pd/r2kWsduhzOt
 A4cEALUGJqxoLHhM0gBMJYs9yY+aY0z7/l8dWttoy0sRqlpcHhvq5X2u1/YfudhpRwUwDuJ8Y8Y
 eEfhwKsn3vpL5YlPts5uInLp1Rt6LoQrm5rl/y3v2niPvJf63r5B5Es+cbFRjQvP8yB6sB+jgxZ
 qKSPgbENEkbrBS3cYaDJVZOF5UyT9+rIomT2eUvQlsTFvDXV5sWUNApKgsp6oX//eg/xOfrtTrF
 XwHvqioVk6B9rfVRFJ2TXxuaCJ1Ht7kSL65C3Z1omy8NByT/giNJ90MHcTr/rekP4wehEF60/Hn
 cFrg2CdYtqGskDXTvtbIRLduWnkJqw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

=0D
On 9/25/2025 7:34 PM, Konrad Dybcio wrote:=0D
> On 9/25/25 9:48 AM, Tingguo Cheng wrote:=0D
>> Add RTC node, the RTC is controlled by PMIC device via spmi bus.=0D
> subject: "arm64: dts: qcom: lemans-pmics: foo"=0D
>=0D
> (following the style for the directory)=0D
Posted v2 to modify this.=0D
>> Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>=0D
>> ---=0D
>>   arch/arm64/boot/dts/qcom/lemans-pmics.dtsi | 7 +++++++=0D
>>   1 file changed, 7 insertions(+)=0D
>>=0D
>> diff --git a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi b/arch/arm64/boo=
t/dts/qcom/lemans-pmics.dtsi=0D
>> index 1369c3d43f866de9d8cd5cd4985241b99c0a0454..9e0d05c1b39ce229d5d4310e=
a1df1bf02e689178 100644=0D
>> --- a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi=0D
>> +++ b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi=0D
>> @@ -132,6 +132,13 @@ pmm8654au_0_pon_resin: resin {=0D
>>   			};=0D
>>   		};=0D
>>   =0D
>> +		pmm8654au_0_rtc: rtc@6100 {=0D
>> +			compatible =3D "qcom,pmk8350-rtc";=0D
>> +			reg =3D <0x6100>, <0x6200>;=0D
>> +			reg-names =3D "rtc", "alarm";=0D
> 1 reg and name a line, please=0D
Posted v2 for this: =0D
https://lore.kernel.org/all/20251017-add-rtc-for-lemans-v2-1-0aaf174b25b9@o=
ss.qualcomm.com/=0D
 >> +			interrupts =3D <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;=0D
> Do we not need "qcom,no-alarm" on lemans?=0D
=0D
No, it's not needed on lemans. "no-alarm" is only needed on compute =0D
targets where windows TAD feature will support it.=0D
=0D
>=0D
> Konrad=0D

