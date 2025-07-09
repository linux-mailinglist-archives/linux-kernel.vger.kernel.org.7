Return-Path: <linux-kernel+bounces-722789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A686AFDED0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 06:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187897A178B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCBD2676C5;
	Wed,  9 Jul 2025 04:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q7eXCplE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F6E1865EE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 04:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752035319; cv=none; b=Uss+j4LWFFprbKPgwLx3g40hknvPgmsKIW6GNBdGLSCJZbYmMygURztpRltGEVzi30vKHxu1OB/d8sGR76wYXGgY9vTzNTXYO+CuV5s4qdIupLHZWIBU6y2QWDFjwNpqTEuXoiA8N/tAx018Ok1IGdV2YlW0JEByg81SGOggKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752035319; c=relaxed/simple;
	bh=nGDSMdGiSbt3wON2yfyjNDeV5z0MkUjSja5IO9PLcNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k73ouBLyKFWUfcIncb0GFgAsyM3LeH/OtJXHqCsMH6FSRI9INq+aT3ZmA8THNCjooGXJu/1jb0fkg91AeeECuVEo5LtGGFeGytUwWa+e/DKRbNcB4njfNF2INEkr//TK5t+ysCbHBZGcLvVS7H2iyVNZJYht70EJF0GRwWeKqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q7eXCplE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568J5Ul2031720
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 04:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	46kHjVSek0uSdgdCzU896+4gvfYavkSNrHpJbnFkc+o=; b=Q7eXCplEJXdX5i8l
	4a7Wyd5WNQCCewVOASQfUiqhZcdsGIC9z8qF+5UWBZgeSULL99PaPpqPfIBuIoYF
	2EZZ+0MH3R+eJa1BhedIWQpdNBOANg/TKEX+RHfIJGKEm1iGSfqkDlMHuW/hJReh
	kqggoXl9ZosLkTwnaIZ+a5R4R0qqe7oa+7APFhUiBQGMddEHrjoSbLurzJCRdnFT
	K0lq9i6jq76Zho9H+ebCcjmiGoIjP9lZgivfrKlTQYboqzdaKiHBJ2CMdX+4Xrum
	WDlPv+seXzcoC994pH9piuE8q3ylyFx3vdVKRQf7AggFNzOXNHLk7CxnbZcirwBB
	ft7F1Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pw7qt7mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:28:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-749177ad09fso2040009b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 21:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752035316; x=1752640116;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=46kHjVSek0uSdgdCzU896+4gvfYavkSNrHpJbnFkc+o=;
        b=iWuIUTvfIcL/dacWXj4r/FSe6xky8clZUu5m80yo0Q0U1w9KsUnOPxoBnZvahcllOH
         i8ambi4r+IbNXl0uv0XabRILBv8NLZ1HrDKMDSe3VDRGtnXfKUAI6De2nsNuFSwNmmEW
         MMvmQV+OmN/itghC0lexrvgV9aZzZDMhItg3pRIWVpfCRNyXkEDj9rPpp6Fg4RsOVtT9
         eagfSdyqu9aFfL1hRXTtL4tuvV/wFqpm2SAZyu1Sv7ogu0BCg6Nbb18w9qdZgrSnoYJ5
         njmiVtOgv2Sf4krtkR9OJMni/UuXcmQpQY02MM0Ma/StcVjKV8HmdXik4T1NG2Sa5ycv
         6OEA==
X-Forwarded-Encrypted: i=1; AJvYcCXYlq+J5s5nal+UVVVEHBUU/bFSbgHELjeTQMPN0T9jiu4VnHSmHuP02581ucyzacFvvqU93gmRYdi7I40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBPgRJRIxrXqnXwRfbjCedlF76hrRUbIkdJOOHCxUfoTliPzH
	KUcGM9bbJn4QbX0TeQOjmJjuonwe8NbYQegRT9erPQ03TCg+s1521dLlwIfqIJbIOX1xsI2I0Ut
	WQfgmrm4G61ZzXARHefhKZ/yT6smiJZqRaIIzbXh826O4rHoxR6Y4sXKiVFv5cFa6Vw4=
X-Gm-Gg: ASbGncv7g/tAyPK68wI0bnosuZ2GzX2fSHn4hT5nHJTNbzJlymkti4vKA9pXX8RcjBu
	xcAKS4PIkZv9xRr2xNpiVkDO6FTucUYMLXi9ihBFx+s/Wiu7fy2GqSp5kZ5i61NDhSR8Tu/ofdz
	ybZTjNTiWcB4h00f83s9UxR1YNZa367xPXzKbM6MnCVZiIUAJfq8m2VRekVzJHytGZML2TMKAxF
	9bm7OX55UDEFmUQBfG3JlddhH4w2HV6TSn5KgdTxgixCKbv1GhEgi/jBPxfacSovc6WwK0Bx2/B
	FfrBmL/0MxaVf8V56sq1Ub8cKYtIeRpG6vlNhg7v8aO2zRlfpyz9wJSlaxRoLeI=
X-Received: by 2002:a05:6a20:ce4d:b0:215:df90:b298 with SMTP id adf61e73a8af0-22cd865ae90mr1458530637.26.1752035316358;
        Tue, 08 Jul 2025 21:28:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1XrTBoe3AdLJKGcotRecgsSopH6Gfr07q95OqUr4/vqz2YgYImVe+KEbGNSUtTurtM2DibA==
X-Received: by 2002:a05:6a20:ce4d:b0:215:df90:b298 with SMTP id adf61e73a8af0-22cd865ae90mr1458495637.26.1752035315826;
        Tue, 08 Jul 2025 21:28:35 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450dcfsm13036210a12.2.2025.07.08.21.28.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 21:28:34 -0700 (PDT)
Message-ID: <dd2fab47-d451-43d2-b2d5-36d957c5aa46@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 09:58:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: ipq6018: Add the IMEM node
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
 <20250708-imem-v2-3-692eb92b228e@oss.qualcomm.com>
 <bdb5e19c-dbab-4ea3-9a6d-a4ac795fb43a@oss.qualcomm.com>
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <bdb5e19c-dbab-4ea3-9a6d-a4ac795fb43a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAzNiBTYWx0ZWRfX5XVGpNhx6i7s
 4mw2c2YQX7ly40TK0GWeANzBPBYqSdQEl6EWdmY9uWQJFT9vUBTETrTA7Sn08SFXcYRYjEf5KYk
 DlcoEZKG+s/MPMu297EqihiUelKkc2qQjB8bYrM5Z1QQxFH5UJK5e3kOwDv2d2GKM8ZzthIgjhX
 /6SNPB/OFrSEown3BaxR85kuTiQzZbPagGH6Gp8a7JaK2w0UObsbWiDLVNh8WSGn41hrgrZ3/Yu
 BM1dzkuJiKBcSHQrp9E2QSGm2CftgaEAENlHJi3iok1AcNBSxGd+SBAbXIvPS6+JIvOCW3W9ohM
 dk9HwXvcb2MxDAZxmPtkT0tIQaxFIOgDEdQwUjK4O7CjMneswIgAtjNivbmGLyZrdlY5vSsVV8a
 SM/5awE6qOc/985rcPDf5vSg5asyvdlyDhsOKkYyD+E4aWzWa66/OsFENn8KNgcQ1ESeBmVB
X-Proofpoint-GUID: cjllhNAyD1VT_uw-U_EPsPaGsUGIDMw2
X-Proofpoint-ORIG-GUID: cjllhNAyD1VT_uw-U_EPsPaGsUGIDMw2
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686deff5 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=CWjMFFrlLJj86FlfhvIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=922 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090036


On 7/8/2025 7:49 PM, Konrad Dybcio wrote:
> On 7/8/25 7:39 AM, Kathiravan Thirumoorthy wrote:
>> Add the IMEM node to the device tree to extract debugging information
>> like system restart reason, which is populated via IMEM. Define the
>> IMEM region to enable this functionality.
>>
>> As described, overall IMEM region is 32KB but only initial 4KB is
>> accessible by all masters in the SoC.
>>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Rounded off the size to 0x8000 (Konrad)
>> - Represent the reg's address space in hexadecimal format (Krzysztof)
>> ---
>> In 'ranges' property 0 is used instead of 0x0 to align with the existing
>> format.
>> ---
>>   arch/arm64/boot/dts/qcom/ipq6018.dtsi | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> index bfe59b0208415902c69fd0c0c7565d97997d4207..3b9e40045906b26b94e2d2510b0570d3eaf084ce 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
>> @@ -659,6 +659,15 @@ qpic_nand: nand-controller@79b0000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		sram@8600000 {
>> +			compatible = "qcom,ipq6018-imem", "syscon", "simple-mfd";
>> +			reg = <0x0 0x08600000 0x0 0x8000>;
>> +			ranges = <0 0 0x08600000 0x8000>;
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +		};
> On this platform, shouldn't it be 0x6860_0000?

Actually, that's from the RPM perspective. From the ARM side, the 
address is 0x0860_0000. The hardware docs show the RPM view by default, 
so please switch to the ARM view.

>
> Konrad

