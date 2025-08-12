Return-Path: <linux-kernel+bounces-764371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE24AB22223
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C101888903
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DEA2E6128;
	Tue, 12 Aug 2025 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oe9JsDNZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3A2E611D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988922; cv=none; b=G5q4fmGe+8L4eMLVibAwBrtm7OZgYwrE4lNhWsNJpYBtRhU8BPiTAJP/SRKmL+N185Pb3oA48pLaslPdV7tiZSOSafGHtvrfVB8mODX6w42OD1LE+vIMT6uK/s1A7Os4yN+o2ilRyXFZMiBtJxaSNlt2IM6NpdUDga4m3pkHAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988922; c=relaxed/simple;
	bh=xSs6dS+KyRDNFjNfeFIgB59xgPp98X9tQpRjtakfgRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsQifQm/PrK4lW0qpc+UII1X1vwrI9igaHjWSoY8OG3/Zzex8ivo1crvGA6DJKQKLtXAkf+J5g/DXMRrGTmzw17JoIHvKqnNZalea1PzGIl6wHRw8NG/v69U4b1JCDdLfQYtKBarG7LfBTaPSTJpoBrWLBgZCxRsWfn/FV82Ndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oe9JsDNZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C6s03s005506
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ebzLashfQv7DGHl2pjGLWaRMjZRcLyKDg5E66/KXdh4=; b=oe9JsDNZUHdy5vFJ
	PdStn1nMaBC7PB3A0D5Qvl+Ps/yy8wI+I+E31mAKnZccBAVI2HKidilkjMQ5JA4A
	B8ohSVBrvYXSRFCi8AZ1iRGkEsZyC9Q1cYCMZaULUbnMw+au0/xsgNBd78U02r0D
	r5yyrz3MpMVTYgff8/WmNZlREMmI/eXHYDlvD0zAudyfmawHYUZTcCPlWqP3ZlHK
	KlbT0EDWLpSO2qD8BlfDSda5AcCrVgYMKD3sbf+KhwP2rdQXCiXZM4ss8Op4/RwK
	JDDxfvg8bDZhRmEvQ/LWcvcgJsydvIAyop4RutGezTdlVAGQAEZ+1tSPCEu4zqa8
	t2mjAQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6kad6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:55:20 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bcd829ff1so5038127b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988920; x=1755593720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebzLashfQv7DGHl2pjGLWaRMjZRcLyKDg5E66/KXdh4=;
        b=plzHm/tmJMmreqiAqWO6D9HpyNaq4yDjIMJgx6WpYZOjRZE21h8cxAuJFYytYfXJhc
         w968oefT3a6stkvJ57lijyhll34i3KYHhJLuIgD+KOxNGiWNc12gAh+gy7xs3s7ZWROh
         OUtb1I54SmvR/o4CzuELYr09+IOcxBMYP88K66SMWH16nO/1fHkbyJ+dUw8YYVq0EfH1
         yPnTyhtZ7TqPUaAjSwKcl0SpBuwnijYZZ/f+QN234lwOXWCBB4MN7EA/Ja2CxOfl6V9D
         vpW5Y13J+gFchHUiTCZCZ5DrUzOm6UkODHIg4YWyHHGJNzpu2PLk1JCwFV7Kw1l2wGuz
         A0zw==
X-Forwarded-Encrypted: i=1; AJvYcCV015NCbm8mekXwmrp0OzLDPP5HymwdCFsNv1NBD5PFolSEQgz91HUk0hPR3Oh5htb8Q+muZ1AdZSbwx9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbYErSI/gTIylbA7QHJQ4ZeFGN6DTYfqUd3s+kTLEf2IqDjiTZ
	nRJLpKjALwBjuOLgByFtmr4F1IHx8dGTDZsRa3i2MVP/Xee0xjd/vCiy6WOj05VUOvlXPTSJYa6
	g+pp/3REelg2NQlALBWyFNO2CS/ZAIr9ocPrcP9l+qPESCFp3wsjWuUdnY+GbxdRF3ik=
X-Gm-Gg: ASbGncthV1APrzn2XD1QkbZIuCYEEybwDwGAKKl43HVUidHNQHWtoYsBFimvv+ESc1k
	7PlY/r2B+nTDkEfbHjiMoA6x8XPnKnkBlnlrYbTM2ouFb6jWSbjPU1SJAAWtS8b/Z/e4KA1ujkY
	IpnBWRM4pnuXvPvJSc9OdZeZXm7vyg9AStsgkvs+vn5xt4NoK/okBIjPXU+QER62GwGMYUzz3b+
	lvy6l9oz4yyUbdM9QKSRz6Xsmzba5x6ZjazpCYXJInCcXMaCdl4CyLkUQqmMtajSp1UDU1B3SsI
	EzscpoSnQvPqMWU3sTjR++M43LnLXgSfbM5ut+f96yZmgCU6Hg0VVgvOaYP6xBHFVnO2
X-Received: by 2002:a05:6a21:9988:b0:23d:781f:1516 with SMTP id adf61e73a8af0-240551604f0mr25082525637.22.1754988919646;
        Tue, 12 Aug 2025 01:55:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlnXmlEPEhmClJA7oU3TLCmpGyzifixg3hvVecLC6bS5LjgZJzR0qSooNP83dnLrlUeNXW9A==
X-Received: by 2002:a05:6a21:9988:b0:23d:781f:1516 with SMTP id adf61e73a8af0-240551604f0mr25082483637.22.1754988919136;
        Tue, 12 Aug 2025 01:55:19 -0700 (PDT)
Received: from [10.217.217.159] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b424ca987desm19854361a12.40.2025.08.12.01.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:55:18 -0700 (PDT)
Message-ID: <d56920b0-0bbb-4951-aa02-152da6b9f9d2@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 14:25:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
To: Bjorn Andersson <andersson@kernel.org>, Taniya Das <quic_tdas@quicinc.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20250702-qcs615-mm-cpu-dt-v4-v5-0-df24896cbb26@quicinc.com>
 <20250702-qcs615-mm-cpu-dt-v4-v5-2-df24896cbb26@quicinc.com>
 <vxeadjzwywqjjqm7elg5pltq3jtnv7fprquhdoydhxnjihpsw7@tlqoq5wpgcr3>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <vxeadjzwywqjjqm7elg5pltq3jtnv7fprquhdoydhxnjihpsw7@tlqoq5wpgcr3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX8nZWgztiCPLv
 6dobANevjD2onmqejn776CxWa+zUf2Oj5j8tZb3gyo/zvHtcAa/hj57Yn8lvkYTPW+6cvrpn3r/
 ntok7goI/fNaH8Zfm2sI3Rz5LUn04z9fuzGFAhNjYAFgf5aptJtKSyLCf2QDhCLp6W0L5vSI1Zp
 ZuAd9kPVnSaW3yDMNDSYE2mIgBNiomq2IP+v1yUTG3Kwibk2WUOwFjjj4QJ7oPaTO/Kd30D+/2P
 K1P1KcW9t9bxb09juvdnJh2TBFV75DfFuLqQ2imEBtRuBYVlzhraHVMaP+p/t7OoqzjvxYs4F2C
 Svtx7jTe4uWNS+fhAsOTotWn5cEssbFpJOrbV203wsdCHlFSq5pkNQnnr5ar0Q1r0VDKF/XAUH6
 iXvm54TO
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689b0178 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=Kl_B17VGIN1bcdT5aTYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: FoNgc1MIfKWjoF-95VoL0eOka8nyoDMB
X-Proofpoint-ORIG-GUID: FoNgc1MIfKWjoF-95VoL0eOka8nyoDMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075



On 8/12/2025 9:15 AM, Bjorn Andersson wrote:
> On Wed, Jul 02, 2025 at 02:43:10PM +0530, Taniya Das wrote:
>> Add support for video, camera, display and gpu clock controller nodes
>> for QCS615 platform.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> ---
> 
>   DTC [C] arch/arm64/boot/dts/qcom/qcs615-ride.dtb
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@100000: 'clock-names' is a required property
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gcc.yaml#
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: clocks: [[43, 0], [45, 2]] is too short
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@5090000: Unevaluated properties are not allowed ('clocks' was unexpected)
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-gpucc.yaml#
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: clocks: [[43, 0], [45, 29]] is too short
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
> /home/bjorn/sandbox/kernel/db845c/arch/arm64/boot/dts/qcom/qcs615-ride.dtb: clock-controller@af00000: Unevaluated properties are not allowed ('clocks' was unexpected)
>         from schema $id: http://devicetree.org/schemas/clock/qcom,qcs615-dispcc.yaml#
> 
> 
> The missing clock-names in clock-controller@100000 predates this series.
> Sorry for merging broken patches in the past, please fix that as well.
> 

Bjorn, would you prefer that I add the clock-names property to the GCC
clock node to resolve the warning, or should I instead remove the
required: clock-names entry from the qcom,qcs615-gcc.yaml schema?

Let me know which approach aligns better with your expectations.

-- 
Thanks,
Taniya Das


