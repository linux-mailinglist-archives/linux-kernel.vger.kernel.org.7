Return-Path: <linux-kernel+bounces-846256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8444BBC766F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 07:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D1FF034CDE3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 05:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B9625CC7A;
	Thu,  9 Oct 2025 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j9xw5nlr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88E823D7C0
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 05:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759986743; cv=none; b=U7K9XTV6paxobzsgNBo4OTIrUmVvjikXT44aOHgTa4xzlZ/B7kPodgyXP9kUEKFPbxvBJvRdGUuUEGhqgG3D9v4aGQqLTkgFG+eDhRjX1j0du1kvjRfOWylAhV52ehNLTJnqTwWrFg6Z3CoUaxHnH2t4WbSok8Ls2PotPDHUv3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759986743; c=relaxed/simple;
	bh=k41Lfe5Dcn96f8gUJJ8sMLMPw6rwlMYlfzmlMxfn/64=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P8fXH9GrmbJsUQ7xv3LjVMra/MXyxRuVeZWs3Ers40j3YB0GPo97fCUTCNVEkTUD80qZBkduMIMnoPmAJaegbTY95VnIZQYXcgRHADQbhZzS6E3lPwyh/nB65Wp1X8jbs3xiYz995bngfq0SCW5wwF4pXRtH6YVhHmY05aFqcrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j9xw5nlr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5HPQ012818
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 05:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SpRCq5hxTIkMivPd9aj2d6SWJ/aa5OSoLIzqlFyOuX0=; b=j9xw5nlrS7w7Peha
	Yjcm2jg037QSz9Cdz0NkxcMdurxV8l15WkI2DLoINmJGBMqrJjuq1YeoZ8O1P8QC
	0YRkAQpo952xXGUVxcObNzFZOjcAnegJGWKaKD5NhGD+nR2wOiEXPvgSFxURvsn/
	dvnxrqAa6CnaOpzDy3lXVbEvxxRTDxVTnfUqCqYbVRr3o5F+/lpmQgpBd6yS93N4
	gOm/EDRRgXYZ4H6K15GO/1xbdjxQkyQfQDt1yxM7xHaDxq7anvIjs6LC/ZKXG7t9
	w3AEiDEeNa7emQrQTo32KO4DL9cN/iQVSX87scf/cALw1E+SImvvRAijYLHml9Oj
	Za5rmw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j1hjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:12:21 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28d1747f23bso9845975ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 22:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759986740; x=1760591540;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpRCq5hxTIkMivPd9aj2d6SWJ/aa5OSoLIzqlFyOuX0=;
        b=XvhJ4aob6u8vyIBwkPMhgLhfvj2QpUBUEKUJeDQkMDad+skhXlBY6pHjG8/9jzS1Wx
         VyOGfxO2xwW69E+IBlch0s2htOFi6MbmcbTJJOZhO48QDtDYnuP0dAmnbs2wmYgVVme9
         UhDxoyd504+WqseVgwUOQE4gEqydu00Cpp72sxGHQm+BmU4I5/73hmnhg01gb1NHybH+
         Csz0CgFi7e2+LzxKkxvRPyTOQgLNZJ1bC1jD1qtxsd0xsRJyNY+CHZmt8SkalEumSOpO
         KOF0W8NP/fUplUXMYTFHOfbqS+6ewucS1rKAuDppAal4ZIirZxC9JMxcUjz9qYSf7lWr
         qzWA==
X-Forwarded-Encrypted: i=1; AJvYcCX3eRIihGBNqoSV7D5J0OLIQ38Fd7SYj8xM5QO/PyffypbSE69WObjr7JLswLUTnS+epIjxxjoENcL0BpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHds99n+vQvHfQ+ZnZ++gkc/WRDU84lWCPVinHMPSeRYTeDHv
	Qf1NOYFUDRBqMU8lwgjATBWO3W0IdNiQp+SruOtEKqBE4BbRupq4hKjFl+fdWgivuc41rHsx9Ux
	2DH2rNh8Rmj6BwDDTCPtZVJ5EHSacgITbB9VWDULS+vqJM07i19a4QFhi1xqfFvngNSI=
X-Gm-Gg: ASbGncsbCDd/a8Ijudc+tC//iWw+iEl5NIx54ypn2wgTBpHSg+DVaW4NngaPAivarPq
	mGWjpw416f6KPcKCO0MGln2vIAbMgrfcCi77Ve9cBYCqv7C44Ivfh9YwS2+rQsYLVwOR6Ejsjeu
	+e1q3bEFXIKcjtDdaLVrc7rfmBCXW2b+fJVv2+XDZJm+1rEgGMnMLtxPvMHrZ8trpG0dmwwBBT1
	+4LtY0NyFOeo/p0/2ArBrjoLBbQrzt2q/u2rr1HY+CRqGhflldHIID6Vh0FiIXBo4c/kw3VlBcO
	A9Y3piGa5qsgUAbhUURG/QaGxGcOHssfOvb4wUWgUmR9Ipuo35tb/Alo0QV2K1bzXO/U1VBo0w=
	=
X-Received: by 2002:a17:902:e952:b0:262:4878:9dff with SMTP id d9443c01a7336-290273567a8mr83058955ad.12.1759986739926;
        Wed, 08 Oct 2025 22:12:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHoy6wYSRGBBV1JSmS3QPASPTJ1tUJOiLp062epi1A7qQiWfVzluYaEiSDgNYaPZafLI0kcg==
X-Received: by 2002:a17:902:e952:b0:262:4878:9dff with SMTP id d9443c01a7336-290273567a8mr83058595ad.12.1759986739410;
        Wed, 08 Oct 2025 22:12:19 -0700 (PDT)
Received: from [10.217.217.147] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6c7bsm14950135ad.3.2025.10.08.22.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 22:12:19 -0700 (PDT)
Message-ID: <8465759d-8d50-48c6-b5e9-26e08045304c@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 10:42:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/24] arm64: dts: qcom: glymur: Add display clock
 controller device
From: Taniya Das <taniya.das@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Content-Language: en-US
In-Reply-To: <a0a70337-6474-4568-9006-dda66371fe7e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bky8iDaK1J4chmj8Ia5ulbGx1ILBPoIU
X-Proofpoint-ORIG-GUID: bky8iDaK1J4chmj8Ia5ulbGx1ILBPoIU
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e74435 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=Rl_jRUjo-d1ZQ1p_6G4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX96xgMkU4jNzR
 y7tPytFWA9i7VN7V+Vekzy2OHodViS/gBd/hvufTvDeBVcj0tNa2bTXmsbB2faTghZRK2o0gjQD
 IlRX9A7fQgDtHLdp9aG302alC04MJ5OTdo63cRHPY0YqRDEpggk7NeF6Hs4BCbVqH7h5dFNEFlF
 /oyAqb83J2636JzSJIJFb+M3R1G67+0yWy83in48+fgIz00bae/BCcfMDcxfEOlwD5RzqnYTkF1
 i/1QAL3Tvnm73wtnEdRDHaBG9SOC/LzGsR+ivjmc6jSpNYS5Dppjira7a50zAwH3NDK7FT7iOeu
 38idxTZpeB/BraD8pptl7lO0oiD3bKb7x5BkUP6I1fPByfJjTKkgwFc1Ny/tGTO2wlJm3hLfKZp
 SqcnwSaYCOUrde0IOc3/VpxEone6Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 9/29/2025 9:24 AM, Taniya Das wrote:
> 
> 
> On 9/25/2025 4:03 PM, Konrad Dybcio wrote:
>> On 9/25/25 8:32 AM, Pankaj Patil wrote:
>>> From: Taniya Das <taniya.das@oss.qualcomm.com>
>>>
>>> Support the display clock controller for GLYMUR SoC.
>>>
>>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +		dispcc: clock-controller@af00000 {
>>> +			compatible = "qcom,glymur-dispcc";
>>> +			reg = <0 0x0af00000 0 0x20000>;
>>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>>> +				 <&sleep_clk>,
>>> +				 <0>, /* dp0 */
>>> +				 <0>,
>>> +				 <0>, /* dp1 */
>>> +				 <0>,
>>> +				 <0>, /* dp2 */
>>> +				 <0>,
>>> +				 <0>, /* dp3 */
>>> +				 <0>,
>>> +				 <0>, /* dsi0 */
>>> +				 <0>,
>>> +				 <0>, /* dsi1 */
>>> +				 <0>,
>>> +				 <0>,
>>> +				 <0>,
>>> +				 <0>,
>>> +				 <0>;
>>> +			power-domains = <&rpmhpd RPMHPD_MMCX>;
>>> +			required-opps = <&rpmhpd_opp_turbo>;
> 
> The SVS level didn't work when Abel tried out. I will check with Abel again.
> 

Abel offline confirmed LOW SVS level worked for him and I will update
the level to use "rpmhpd_opp_low_svs".

>>
>> Really odd!
>>
>> Konrad
> 

-- 
Thanks,
Taniya Das


