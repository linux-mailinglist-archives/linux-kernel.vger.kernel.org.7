Return-Path: <linux-kernel+bounces-832230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8A6B9EB3C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29084A793B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7962F0669;
	Thu, 25 Sep 2025 10:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oX9j66kR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AEC2F9DBA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796422; cv=none; b=I2Yn0hvIXdWSVpcG1218RqlnFrucSePIwhJ05zKleZwfldG0Ma2u/HRyZzc6NMC1s+U6GqVbWOt2KNUw4bfiAIJ/fxaURoPkzPUngFl1jH/MsMO0r8GxcwD7E0C4gyBp9sp7LaYAdb3iNVnQP1UEQHqG+YZi06xTVE3w0Ac+Fck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796422; c=relaxed/simple;
	bh=zej+0XcA4O/KYcb+DxmZqeXEO1sCOIfJbhlYjGA0ZhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSYgpmtGvKIYypMxgrYmo7ottJwRhx2oCWvqVLpF/A31EueiworGQ3RtJ0Emwx0gJ6pHE6u8e7DHCjbwP1IHrd9r0TybFEN6RyUny9YtfMrwYttviSc9TYZk8wfkfoqtNF3I9oAMLlMCkoCyQZ6HG4yD962maorZjyVCn1w+QIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oX9j66kR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9ZIK2019945
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UFRsyLmJIufwOkTJA/XGc096S5ZP7JZFqnfjB1m0eAQ=; b=oX9j66kR0DA/C7uL
	WK94bNc7c3fmG5aGmUyB37OJkNWcMTJA9sDRcFMuoGcYYBLk0GZGb3d+np9si8RB
	05eIQhISocD1HBqn4685OBFFQ7Xo1NLPqa9SJgrqUb7G9HbGq0azdBq190HCyv9q
	JrQQ61iQsJDeqBTK2StKjNYDQBqQHBeXpu/aF/gK4qH85bXM/MxaDenO3uh5Ngld
	WyZGyzrxE/YkuXAGSGqP+CqgPE0fh0Y1fqVCtJXDxNUNxSwIDtg/Lk5UchEz/gWI
	sjo908l3SLgTjM+E/EKDghyCryQiB/hvEmPvXTZOwIWLK+Cntzqr5TF9fTnTWpgA
	ZKuuBw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe102f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:33:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-819d2492a75so40102385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796419; x=1759401219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFRsyLmJIufwOkTJA/XGc096S5ZP7JZFqnfjB1m0eAQ=;
        b=kOcWsZJsfMAC/gd+1gPuAV017OeYtjW1LOr7on/7nD21Xk3KcVISmZTsGeXbzXw8dx
         aEhQo4AtsYXEp1aTHaoPjLBoAloguYhtsWiaRFKbasRK8ch+x9YLLY/dzLhQuXVlvTGT
         ReC0PFIxA0jRwnX2cr/UFBkOvDeC7TVEaA1RCazQKpo/zelQdBlifJUWXCIwcpgCLjTF
         IljBqa/TPC/KvjhQzV3vIuRghDAe9xqy/OjEK7QmV30B+9boDdqExwm3hV+WRQZtP02b
         cMRZiOuH1d8QnxKkwjNEBQ13GrVLw2/DsWmOc3IATSPpvrMcIagCKuhX66tF8W3SATj2
         SHgw==
X-Forwarded-Encrypted: i=1; AJvYcCVDnABRx8NnSSSyW5+JicgSapg7ncsJJ4XkBVIjDVUKg/xq4yaE1dmIJIjpsDW+ggDxsekYIrD4nus2pps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSibFR5WuzMhrRabpspRv+nrwIhA3i8t4jAF4Dla4EoWdRLCM
	aBDH8KLsyskKtvnAmkdUKJQvJllCDkwA0KOHo45QmCv/OxQReJ6U6qVWK+ZFJ855YSoKI3vtY/i
	5OqRweVRwEz3cuPgja6vt4sbV8mXOZPnMei35vCw8E5jhh+M3vXKT3StvBgYxheSMxCE=
X-Gm-Gg: ASbGncuNOxSpJa90u+6nQEO2vll1G/GVfW6uvejGC1H8aV87176oiKGtEU2W/9JZdfr
	gGbRXLMRHsTBTh90q569ocZcr14f1DtnEYYxYaYdXNDN992fBiwVCwzZ10acjUcdhMDJawQ92l3
	mF2KvOnlYgFJMl2kild4AjTrSr6XnXEpHgxZ4vdmmcg/vbGzYSmqegpXksbaS1OXUjosVmFQwj6
	5wdwAW4p3dJLpfuaf2KRYchepUkQaaKmrq8/In5KHIrRCy4Pl0ohf1ORlotyQVA5EGPmQNrl5w+
	guLmgeTorm6uZ3jzEfssaz6tVzB32/i8OfhdvO9Tikdo0MyQyFufRgPU3bCdNzOlsKzR42DYaCN
	cCR/2/MEqQ5J52Hxl8cyKFw==
X-Received: by 2002:a05:620a:7002:b0:84e:90fc:9bcf with SMTP id af79cd13be357-85adeb4c7d6mr258399285a.1.1758796419454;
        Thu, 25 Sep 2025 03:33:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHua7CpFGuTkLb23y689m09dwFCWAXFmDLjmnYAHIVDng1NKtA47v+/EAkxhQQoBdLLeIRjjg==
X-Received: by 2002:a05:620a:7002:b0:84e:90fc:9bcf with SMTP id af79cd13be357-85adeb4c7d6mr258396385a.1.1758796418723;
        Thu, 25 Sep 2025 03:33:38 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d11ecsm137737366b.21.2025.09.25.03.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:33:38 -0700 (PDT)
Message-ID: <3c886104-937f-4d2e-ade0-fd525d56dabc@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:33:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] arm64: dts: qcom: glymur: Add display clock
 controller device
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-22-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-22-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ouCbnQlYp3o8amBXEnVNFrLUYYHoGqSR
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d51a84 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=KtVf0pUd8HSTWu7jDnYA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: ouCbnQlYp3o8amBXEnVNFrLUYYHoGqSR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX1msN1Q7MAO39
 2z4qht8twHNaP7vdkrNAuaRGO2zVu0i7NrgYq1VWgn1Dbp7VkEekCWmfsUNOw6Z0VIPPdCIetvl
 VZXSMew4WQYhENTG4w2x6ckvIdsjH9TKsn+1lBYIQ/F/7iO0tdWfgZx/toHg/e46+pE77erZJ6I
 XdtT/BdmfQui6jwI/BW8cfG78mxLAQHpwVzUwWvrrDgmyg18i/OfY21Rtk16bF0O6yGVSwFndXX
 mgJrf5CI1LpqVo/TZrmN/OCLV4rapqOyjy+5CPebfcDcLPZedZudjYQwV1UWEhAIp7rDwlaFFL4
 jzIt+XZrEZ4nAWZKJmdHto5sFa22xoFlf+xa5W0eZHnq9fHDQqokPwgjAotU5OjD/meaXetMp47
 kvTcQk4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Taniya Das <taniya.das@oss.qualcomm.com>
> 
> Support the display clock controller for GLYMUR SoC.
> 
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

[...]

> +		dispcc: clock-controller@af00000 {
> +			compatible = "qcom,glymur-dispcc";
> +			reg = <0 0x0af00000 0 0x20000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +				 <&sleep_clk>,
> +				 <0>, /* dp0 */
> +				 <0>,
> +				 <0>, /* dp1 */
> +				 <0>,
> +				 <0>, /* dp2 */
> +				 <0>,
> +				 <0>, /* dp3 */
> +				 <0>,
> +				 <0>, /* dsi0 */
> +				 <0>,
> +				 <0>, /* dsi1 */
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
> +			required-opps = <&rpmhpd_opp_turbo>;

Really odd!

Konrad

