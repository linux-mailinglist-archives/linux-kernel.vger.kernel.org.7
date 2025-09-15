Return-Path: <linux-kernel+bounces-816421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E77B573AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2E43B1A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D6A2F0C7E;
	Mon, 15 Sep 2025 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjDW9m28"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1FA2F0692
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926414; cv=none; b=nMozvfqOylclqeSbmNNitL/6xhdtH+TaKIhBr7HP7UUsrNTls/k6I+62gzw2nAMUq5Ls7snFEpWjd6JkR4zXmeCRE6b+hHwWk8SXrncZLF7HlM/PwB/gka0eVKN8z1ezD+rGe2DWQY1XpwNh8C9CZpF/mWKIH1xavki83ArYCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926414; c=relaxed/simple;
	bh=S45awvN3cTWhpX5IDC+70SRwYupcAKA+kaIquVzT3Ss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmHOECfA2ZMGe9XvXybvqLcMd0a64eaDeevP4u3iH1Kb2dix5cfNY8oLXqdw4/ivc0mfBr88j+X39n8kaaC7T++KIIqbmLJb7CY25DE9gFGQNdicqhtxo6OSFYeVZQ1dLNsocAqqmEdytFIjDGL3jvEOV9yz9l4hJwTVx9MdFo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OjDW9m28; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8Fsp7018204
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4r+niUOvJYA1UJcr4thXBmObSCAsqKRkY4krHVU3u4A=; b=OjDW9m28GwytyRU+
	+frj56qkSewdYLjfyBbcECnbRTIrTJz7dure5ZZsuqECBxj+cgzesUYht6K1wNma
	9U1ZsOIuQhARfVC8Wo6s2updMH9g5zOK6DvRiiYUwtgKm80hiqM11HxLTMTSHA7V
	mQ8Yd2IBu+s6T+Lqm7FfkhY9LTUukWnN4RFLEsgIWoxTRKtFsbhCw6zxCbBQ/EQy
	KEfO0WljHFaF/Cu/b4IdAKvJnqyledhNUbHes6z1cBpFlpXCzPzrvG+84mZW9NKz
	4qIQUbVZKtsi3vUHaJGNP2Iu/FSVNDXbpiujpuVg49e4a6q8/G+TL67wf5pOnaq+
	KJ1NaQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u543tt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:53:32 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2665e11e120so7178275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757926411; x=1758531211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4r+niUOvJYA1UJcr4thXBmObSCAsqKRkY4krHVU3u4A=;
        b=X8/+Qv/MRIDW85Ub+arvowxi72PRPV9P78113eJISOgIjzji1sQw2UoWIfFcN/Rik/
         sdUpwD+7/LiAQlUyD097cyyou31mGfw5EWA56N8LmtjZEwuupT67UQGXYicXMv5IDDRh
         lLFaJENu6m2vwepV4JaKu4znhBEvClP0EtqgHWbyT/duBibalb1l7F5sVhAghZTICPqO
         o5vJGl04e1cyPh5l5P/H2RhoM2EkVBJ439BslMmGhXCijcV/I1/UiKBfNO2F4P7t3UqZ
         jZAm8S1fQHJZy/SXKjvydpZTkhRJViJ+DGXjRp6DTwTHigw8b2XyBqiyX5EVXMYkxsjw
         wykw==
X-Forwarded-Encrypted: i=1; AJvYcCWgjnLSGJj3fBvEUxazi7y+z7U3Lr0OqVgSIj0vtT1NSXI18s0VmkjXfDTXAXtWdvCnadZofIOZvgALK/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXlT8CRDgxyVDcGIA7m7LVR8gpYellQ7CUwTwkuBjzskJF55vw
	detSrS6AcNi4D0CxZG5CUNGQDKKfo4eOBrLy28sEFWhBTybBeQOg+MM32KX9gY76MTqgwr8+XHj
	Gesv4eD4/Ls+6akb+2qrw1vl7p0e17hcg3bbgLaHG8Wa8srFE/E4Z434wPAOCenOEOJP3ZvqQAm
	RsIA==
X-Gm-Gg: ASbGncuBo5O0yLhjZ8dJKoFgCZ+vpTFXQUzPZRpFE0c5MOgq3vFiDTflXcIUXF/75Tq
	khJuhEApP3WD+djCT57fWJ0aCQU1vIt1gT1WP95vJQ5Czwwyp6K0w7Lx9zjucvNUqRf8WU30+ue
	LJI0f7h86oUCk2eVWFox7d1mEOFQZLpBXIrszBddH1dmc/CBW19U6Isy/NcvgB5InVa7ZUzC+5B
	IjrIq/fbXq0pTmyBV0XNUxI5+NuT/nLsFlN2mNKgVXTBXdqGh/PuAFdi309WGVmQ80epaoZTJlz
	gemyde1swXcOuz9xSM9Em/dRUR19Sy3gR8EZZtprt6341RTzm85JH1U2vgczRacQK5sWM0ne+r5
	GoN35TkNFXkpzWD8okSbtV7s4YIdlPqMZCQ==
X-Received: by 2002:a17:903:1b10:b0:252:50ad:4e6f with SMTP id d9443c01a7336-25d27038fcdmr157648175ad.54.1757926410986;
        Mon, 15 Sep 2025 01:53:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENt7QnFAil5iZOk4qDkCOqaK4rvUzqvImltsyILTqsN/ETeoEWfmXbCYerWe4mkBUy5D/vIA==
X-Received: by 2002:a17:903:1b10:b0:252:50ad:4e6f with SMTP id d9443c01a7336-25d27038fcdmr157647825ad.54.1757926410508;
        Mon, 15 Sep 2025 01:53:30 -0700 (PDT)
Received: from [10.133.33.238] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-262ce653f1asm53418595ad.63.2025.09.15.01.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 01:53:30 -0700 (PDT)
Message-ID: <9d46a3de-77e5-4f21-a2c8-85f25d15f079@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 16:53:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/4] arm64: dts: qcom: x1e80100: add video node
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wangao Wang <quic_wangaow@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250910-hamoa_initial-v11-0-38ed7f2015f7@oss.qualcomm.com>
 <20250910-hamoa_initial-v11-2-38ed7f2015f7@oss.qualcomm.com>
 <aMPdoa6wVEW9q9Sn@linaro.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <aMPdoa6wVEW9q9Sn@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JSgWJtZNseocWGgNfQeuyltpz1KJ7BCQ
X-Proofpoint-ORIG-GUID: JSgWJtZNseocWGgNfQeuyltpz1KJ7BCQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX793Ye4tVOKQG
 +8wJHHbXm6EnxYrq9QiSLrZ+RQ+rFu7B9Jg/ykHkuOrQndhS0j3ZcmEcaaQz2tRjP+d5DmOchbC
 VFdaHFDTt/tnQa+CMQFkvV1rk7U53zTjDiFmgZ4ArJ2cvwfH8MV8Lh8GJ0LjMIeSe1iJFzBjRsE
 ZixsIj2qHUz2kGjVwIPrupJPchi+lKVnM6xjeteZf4EXsKf7kgBZX6ugmIrHgTifvKB09K/CpYH
 IFj3ZMgj8iXMXYCFLac5LlUhuRBvXxttVNpMXTDzKz7qftToRHHWfJ1Q9t7+2bTNePxOHwytLzO
 XNJ5lcpy+l1n/U+iGU31hJiJRwN1Rs4hvGlXBaMmkFfevh1altFZxrNau9i5gfsm0iGQmBRVmHc
 oYlMGHIi
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c7d40c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Tt4CGEpwzN_lfr499RoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031



On 2025-09-12 16:45, Stephan Gerhold wrote:
> On Wed, Sep 10, 2025 at 05:02:10PM +0800, YijieYang wrote:
>> From: Wangao Wang <quic_wangaow@quicinc.com>
>>
>> Add the IRIS video-codec node on X1E80100 platform to support video
>> functionality.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Wangao Wang <quic_wangaow@quicinc.com>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 82 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 737c5dbd1c80..4a450738b695 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -5186,6 +5186,88 @@ usb_1_ss1_dwc3_ss: endpoint {
>>   			};
>>   		};
>>   
>> +		iris: video-codec@aa00000 {
>> +			compatible = "qcom,x1e80100-iris", "qcom,sm8550-iris";
>> +
>> +			reg = <0x0 0x0aa00000 0x0 0xf0000>;
>> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
>> +					<&videocc VIDEO_CC_MVS0_GDSC>,
>> +					<&rpmhpd RPMHPD_MXC>,
>> +					<&rpmhpd RPMHPD_MMCX>;
>> +			power-domain-names = "venus",
>> +					     "vcodec0",
>> +					     "mxc",
>> +					     "mmcx";
>> +			operating-points-v2 = <&iris_opp_table>;
>> +
>> +			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0C_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0_CLK>;
>> +			clock-names = "iface",
>> +				      "core",
>> +				      "vcodec0_core";
>> +
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
>> +					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
>> +					<&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>> +			interconnect-names = "cpu-cfg",
>> +					     "video-mem";
>> +
>> +			memory-region = <&video_mem>;
>> +
>> +			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
>> +			reset-names = "bus";
>> +
>> +			iommus = <&apps_smmu 0x1940 0x0>,
>> +				 <&apps_smmu 0x1947 0x0>;
>> +			dma-coherent;
>> +
>> +			status = "disabled";
>> +
>> +			iris_opp_table: opp-table {
>> +				compatible = "operating-points-v2";
>> +
>> +				opp-192000000 {
>> +					opp-hz = /bits/ 64 <192000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs_d1>,
>> +							<&rpmhpd_opp_low_svs_d1>;
>> +				};
>> +
>> +				opp-240000000 {
>> +					opp-hz = /bits/ 64 <240000000>;
>> +					required-opps = <&rpmhpd_opp_low_svs>,
>> +							<&rpmhpd_opp_low_svs>;
> 
> You need &rpmhpd_opp_svs here for one of the OPPs, because this
> describes not just the requirements for the derived clocks but also the
> requirements for the PLL itself. sm8550.dtsi has the same.
> 
> I didn't realize that you sent a DT patch for qcom,x1e80100-iris, so
> I sent my own patch yesterday [1] that was just waiting for the
> dt-bindings to land in linux-next.
> 
> Have you talked to your colleagues in the video team before submitting
> this patch? I'm pretty sure they could have pointed that out during
> internal review. They also have access to my patch (which has been
> shared in a public branch for over a year now) and knew I was going to
> send it as soon as the binding lands in linux-next. I just wish we could
> have coordinated this better to avoid the duplicate work. :/
> 
> I suggest that you add a dependency on my patch series or postpone
> enabling IRIS support for a follow up patch, it's better to have it
> separate from a new board addition.
> 
> Thanks,
> Stephan
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20250911-x1e-iris-dt-v1-1-63caf0fd202c@linaro.org/

You're right. I checked with my colleagues, and I’ll remove it from my 
patch series and list yours as a dependency.

-- 
Best Regards,
Yijie


