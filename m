Return-Path: <linux-kernel+bounces-846454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADB3BC80D3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C21C3B5693
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104E27A903;
	Thu,  9 Oct 2025 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j6qfo6vi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9E4A01
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998635; cv=none; b=RYKjU4owefi1pkF6WXjgNlxGtslZu09sATUryxm2kEKOv51ckdu/zkvoQF93XgPJ02MAlrDakq73RkLBwln7tHCcHsoD/IwDQmvoIz1qMCWfNfln05oYAyyaSE7R0UuYg6dfQliGmdABFw8lBXBr+nMe8VjUKx8bJCDZ+XPF4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998635; c=relaxed/simple;
	bh=Yik1lCD+6pysTAtwdHRwwvFfBNMr818rNdMLqahUX4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGnbM8olcjV8y5w5jdpur9QUOIeqatfFOqRocJNyS/bv30t0AaR7vXkOYIS/2Mv+Kiu85fxqjORnd6PWnRdY35cMPmXWQipWJA/19jNmlsX6GQXKaTo+FQHKCnXuuRFU+/iu3nJpjMzKYRFqNFXWqbCll50qTt/9YA/ObHJt4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j6qfo6vi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EJ4F023279
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 08:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7HTgaT4ZswdTpx8zdvGpuveahmBL/mFIrkaXl3UDcPo=; b=j6qfo6viKW2KIP+Z
	91nAc1f1Tbqingi58MPXav6NVX262j0KkFyMcSryctzY8COqSJti8ml80odhdg1f
	BVSHKA8gZUqXR1tnsI3vM77Oz4L/FUhgxQMtByFQVUb4SZRBjpmLYXQp2Y3KGv3c
	FzZLOrb++esxWDmzJ3I7dFNS14DuICil83ouIRVV32DTi3HFl1UpI8aivzN7HHM5
	SzdN8ht+6cLBu1yU7ZByTZ4+6i/CKifgrYJmJZxQpv5NgytFMgb0NNz8b0PW7oov
	XImmKEv22dShRyyI+zmlwV9OPwYL+1kwfjj5D1xgi2CF1OdfwbdET95cglT5d+Xs
	sv9IZw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m230y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:30:32 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-879826c55c8so2699826d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759998631; x=1760603431;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HTgaT4ZswdTpx8zdvGpuveahmBL/mFIrkaXl3UDcPo=;
        b=AyiS9ewK7dqRihwYNagcWbTHdAbRa+cssD/473SKOHbmX/JkOX7d+ESvxxYKtXoqIG
         VheQvcmwzLMBvCmwXCPXbrX3hb6kckhD/Lh71Ym4mcwB43fUrSXXSj1xr2mPpQv1IKGW
         MyhGr3/vlZWTfP8mPLVtm2bqHa68SGnOf0Sw5MYVFi5L1l00gPQAeifYiaEOb2sSDvIT
         zc/SXz7ONUm4g1OxjxOeytsFh5uPq5FiR+PEeEQmLKHFh+/VJqFj/CHiDMq0wFUHrio3
         CxfV+JErUDa4//6PutFDjjsoiry9YMRotAMeWxJg+Jnsjw155/TJ/hVTGBHl0RofWu3n
         bbJg==
X-Forwarded-Encrypted: i=1; AJvYcCWwruuI3eD3zmeIMY+Be0vPxyLpZTSCdHoa7i0W5rv6SspGT9XzZf0vVzN9Gjdp/a3/hTIvyk8WJNFsBZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrhY48ITq1zNdoj4oexulQp1Ts2oL8KyFuF4WqMJE6kuO9yqJH
	4AuJDyAo8+9GfIEoSbnKqliUo2zBFsKpulSDzMKsWkpsk/NBRSfq6n7t30b+sqCr6s0bDLxRxZQ
	xL0VCMj2ENAgoWSAOdO+XUOeoi1pSSpyQ2WNm1XFtVkcUTEbd+zwzxB3ywWQgmPTy+ZfgGuAHme
	g=
X-Gm-Gg: ASbGncuOoxGVS1INCPl8uSaTCCNT1Iqp8KHuofAzR9K82HhmJkBp3p26bvZ5aHEPzTC
	tJH7PbQn4+iG9FG4otDGmtL1gMV+a1NTrjo1TKgE9ycR0ih7N2wfm4T/Zh+egAbaECqU02NvuQ2
	C5ecW4Do8ZdrycqlNpY1UdCdGwH6ATPdrV1/AQOsT6FZfE9GTnsOClvcWUnkGf0nHEV9lHjExJh
	j+kVXWDnyg1ceGBhTZ86h0ogQqN4YfhHFN8XdJUURl767GpVthQVEHBSqfWkkHGmcSQ4iCm3Exm
	zPmi629+s4wRGEq1+BIopMvMtdo4acQwvJh6pm6iVZGEJxEcxNeuItLJ2GLemswkovGl2KHLUPb
	wXKWEI3rIS32anQlDBQNn39KF1K0=
X-Received: by 2002:a05:6214:1044:b0:87b:b675:c079 with SMTP id 6a1803df08f44-87bb675c186mr12246826d6.3.1759998631029;
        Thu, 09 Oct 2025 01:30:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxlPJRCpbLQ6ivOfg2hVAFykebyx7Vvi70Xjr7c1nZL6mafrBDfwdqfN+PARl4iBAAaoCM1w==
X-Received: by 2002:a05:6214:1044:b0:87b:b675:c079 with SMTP id 6a1803df08f44-87bb675c186mr12246586d6.3.1759998630513;
        Thu, 09 Oct 2025 01:30:30 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f3cdbe65sm1852980a12.21.2025.10.09.01.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:30:30 -0700 (PDT)
Message-ID: <5b46bf0e-f91d-4b65-9365-059c33b54661@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 10:30:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] arm64: dts: qcom: glymur: Add display clock
 controller device
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-22-24b601bbecc0@oss.qualcomm.com>
 <3c886104-937f-4d2e-ade0-fd525d56dabc@oss.qualcomm.com>
 <a0a70337-6474-4568-9006-dda66371fe7e@oss.qualcomm.com>
 <8465759d-8d50-48c6-b5e9-26e08045304c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8465759d-8d50-48c6-b5e9-26e08045304c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzh6bLHFjhmqs
 5mtvRmLIAmCyhrxOHq2KxkfeWx51r2FkVMByLKMgQATKm8T2rNjofGEi5wbUM+zfEjdQpSf9zLF
 v4S8B74iTEpNtXqL4dm6iGazNKOKWXXyNCs8sNenxA3iuVvVNTqmWa8XZB/QRehBil6wYpj+jtZ
 Xjm6ax9dPd50divRJc0+kbOOjLWOQ7/Wz2tpqKPV8s1Jnja7ekW7dB57K/OSkW494gk7bKgCr9S
 Cyd9OSpXHd1wooQsIUgptob02KIC3125TXUwuqDnevx68/ixXQenUdXHSGtg2ak27VYwl0RmIbo
 v4XqwEIbC5rXa1dzuI9UY8Hxcg1r8iHsyJ/759t8FTEXFMM74w9cEl4PvEm7H60fYIbftEd7FSP
 qzVlBzlSi1Ey8agKL5kPVdbjyp8aWA==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e772a8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=TbWexrlifh4ZZoSOPjcA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: x1rCvlSK5WnVQhxkmtoc2mkrmGlq9ayN
X-Proofpoint-ORIG-GUID: x1rCvlSK5WnVQhxkmtoc2mkrmGlq9ayN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/9/25 7:12 AM, Taniya Das wrote:
> 
> 
> On 9/29/2025 9:24 AM, Taniya Das wrote:
>>
>>
>> On 9/25/2025 4:03 PM, Konrad Dybcio wrote:
>>> On 9/25/25 8:32 AM, Pankaj Patil wrote:
>>>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>>>
>>>> Support the display clock controller for GLYMUR SoC.
>>>>
>>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +		dispcc: clock-controller@af00000 {
>>>> +			compatible = "qcom,glymur-dispcc";
>>>> +			reg = <0 0x0af00000 0 0x20000>;
>>>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>>>> +				 <&sleep_clk>,
>>>> +				 <0>, /* dp0 */
>>>> +				 <0>,
>>>> +				 <0>, /* dp1 */
>>>> +				 <0>,
>>>> +				 <0>, /* dp2 */
>>>> +				 <0>,
>>>> +				 <0>, /* dp3 */
>>>> +				 <0>,
>>>> +				 <0>, /* dsi0 */
>>>> +				 <0>,
>>>> +				 <0>, /* dsi1 */
>>>> +				 <0>,
>>>> +				 <0>,
>>>> +				 <0>,
>>>> +				 <0>,
>>>> +				 <0>;
>>>> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
>>>> +			required-opps = <&rpmhpd_opp_turbo>;
>>
>> The SVS level didn't work when Abel tried out. I will check with Abel again.
>>
> 
> Abel offline confirmed LOW SVS level worked for him and I will update
> the level to use "rpmhpd_opp_low_svs".

Thanks!

Konrad

