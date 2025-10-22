Return-Path: <linux-kernel+bounces-865534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D451BFD68C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DB79567B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EAA29B8FE;
	Wed, 22 Oct 2025 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JuYJQ8qD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FFD29B224
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151069; cv=none; b=A/tdzc9x2E+hj5w/FM5S5Ldhmv8vH1Ud0fj3lBRK5MFssYLqSil5eLIa1cvLsn3b1WdedokKOEc6YGgvqHmKcms94yRyuVR3QuHm0iUpkiYwk1OurWVrPSI7PidmG3Ddo4eYg6fZuXdJKpj2fJISvezCFPcZ0odwpMLRGeFcZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151069; c=relaxed/simple;
	bh=Wp81GXNND1wh0U/9s1mWBF/bhNhNGUm8w8X0YEP7PN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE1TbNqHKh87jTeaLzmFtWxT49N7Ul8aL59Zi9Fo072O1fM3SIfVrvHcimZX5r5BeTCaZD7Cy/aZuwFFAL/Jl7/eIWAp2TsKDjOYud8xhFO5KYTy4P9ZkdJ7Im191qvAqeu4+Ojo/2QN08ZF0C6VTXI5Tbhjlla/ueY/bS3BML0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JuYJQ8qD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MA9N3X002534
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7pD8+/3i8mH4YAFD2vcdS7fmM7cM/hpU5EdelDxdTU=; b=JuYJQ8qD35fiYRZm
	UMIJfR+oFwFQsFqisGFDdPpfc8nvX8Wn11Ta9qiJmEfhKtMrjG/BBzkAQckpvMQN
	j67p+fSpkezld1rLvXZQz2unRg+UdSHOzkotJoCUN5HZ1g5Db8bDuhp5z+EpmZ54
	N7KCwVKZ7vgl05ciHFkt6P3O3R1OIXfTVBfCU0oeGGCkjGIhVnTewQzKYtSBPr33
	v19PYN3yciLpxIRBkSdJCJUTEUETZpQMZvKeSXOA/Se2eNVfGVMB667BHXo2FQVf
	rD4j3afLL70RBSDSCc7vLe2g+xisqJgkqjcyFrCYaRQkvMIUanJNgCAbFRcg6cD9
	J7joXg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wb0q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:37:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-826b30ed087so21450696d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151066; x=1761755866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7pD8+/3i8mH4YAFD2vcdS7fmM7cM/hpU5EdelDxdTU=;
        b=afEufQ6mgXFdE3fHSHwWZFsiEmX3KWw9gPTRUxCgckeajR7fXy9pOhl2VaDArdaL7m
         1oD+drmsft72l8w3KG3W2PMthG6iyfegYFBQsVmbYxYg7FRDun9kXK2CM/U7iYTpY7cE
         NDd0TqZOrpUniGWDzyYYFUqqjo8ZmspRkE78Y3y6JFx6jbcsooTvrJxAbH7EZVahQs56
         YJpQvphpcg8zXY11kmqqZiSwAf+ilYxN6Z/XHY5E9y1eWtN19zaEF/ZwlC87JIV68HZZ
         9gUm87BdUJEKwUvoUJArUhLPrw/ksVXS+DDZJd4ajsRXXoTwqDT1TJZfze8wlm1EGQro
         pQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVoRyRQOr1K2eMOqkdZmhvuUHplxazeQ+3J8JG7xxGXh44zwDq+02MSpdZFPF3t6q2Fzzi6lFJocR9up0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyajBJxtaYeomtCfJYNSc5o8ziO5seXAg9XaWPJXOr581r4jfE0
	CK8cNTdJaQ3HR00e5kv18WUJItR+wL2MtdmP19GIDqrtPqm7/B+rWNaCik9I2hCsWFJAntI7uj/
	i+pTVw+ZRpq70ki/Vj6LDQiGDJ63IfBGo+3W3IFAZBrGj/oigbjjhHSLCaBsWDFrxMrU=
X-Gm-Gg: ASbGncvqhEHOkhcL+xx3J+SixCKwqteQPxvfcenZizORxzoXyd0QZ3HjUwWwfRolblT
	kPBF0x7tSVcRgJ0jRouM1CVA5GtUk46vesF0GKYMauhWlA2U2ooT8A6hRPRH/UjqoVUAIWcn3WX
	fCI4iYOj90wl49AOh+n9UlvTBcMr7Pz1Lv6B4aP5iML5Cq5GQS1rPV/trBIF3uDkiAjWlyVgXXK
	pvK18V2c2o/mOSwOWTNBBhyRooDxCdKJ15LwkZvOPLuiITRgodCW+/tTQXQUsPddQ4xJtm8TIiS
	4mhIEdqZdMULYn/Ei/gqOG/muujpbugYq2sttK9yE+zIjETy+/RL3G+lCI61KZ3OC1UUm2P4cSU
	ZIIZ+/EX4fm00X4ehRjNgxn3MIMlMZAMi8GFgetRqxfHUsSuFAyDwW9qR
X-Received: by 2002:a05:6214:f04:b0:789:e48a:fc05 with SMTP id 6a1803df08f44-87de71558bcmr59531026d6.6.1761151065464;
        Wed, 22 Oct 2025 09:37:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERyQqnqCN17TiFnnIPLzVxcq0nEWVQWZk7kbvp4BBdWHyCyaz+jWM4LC9xAGgeQALkVVWWcw==
X-Received: by 2002:a05:6214:f04:b0:789:e48a:fc05 with SMTP id 6a1803df08f44-87de71558bcmr59530626d6.6.1761151064778;
        Wed, 22 Oct 2025 09:37:44 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab560esm12216643a12.12.2025.10.22.09.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:37:44 -0700 (PDT)
Message-ID: <f0f1219b-672e-4793-8501-ea31e7cc9575@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 18:37:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] PCI: qcom: Use frequency and level based OPP
 lookup
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20251013-opp_pcie-v5-0-eb64db2b4bd3@oss.qualcomm.com>
 <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251013-opp_pcie-v5-5-eb64db2b4bd3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EsznQwXk514kTvwb6GX7Q1C97zQszsT3
X-Proofpoint-GUID: EsznQwXk514kTvwb6GX7Q1C97zQszsT3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX40OWJLykvlyv
 I8ahOzz9uheDtes7U9qvvWoUPJ5V8ev+rh3r2/dkULM2FaRY5pD2Ea7YvmSh47+yDB/AAdowIfW
 0chbSqyPXQGR4LCq4vokhCLLDeAMaGQJP8A+MZ9dSzh1h0ExbqJo36dbRdD4iKmHex3XQa8094B
 xuDgUqrcNrI+8uhZ/8kTI269lH50kN0MmhiFlisrbE9oRlY7daB3GmWO0cMR7z5X4hy9/xXh6WK
 eqgleDAV+ZvTgJ5tNES2ziYDMrdJa7MOrikgHGrb89GeNu//cuw9tGVOBJuQEY+tSXPCoO1A0WW
 N76YvwAvVpga3kilLjcNPLZ37dP11+MJCvYXn02PSkZifCK1ojLhageG+GeNrPTpuL3Z6XoouMa
 WXqGlDUGluij6PiTwQnsloO2X9v6GQ==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f9085b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=M-jGJTmE-ygQmRKCDXMA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/13/25 12:53 PM, Krishna Chaitanya Chundru wrote:
> PCIe link configurations such as 8GT/s x2 and 16GT/s x1 may operate at
> the same frequency but differ in other characteristics like RPMh votes.
> The existing OPP selection based solely on frequency cannot distinguish
> between such cases.
> 
> In such cases, frequency alone is insufficient to identify the correct OPP.
> Use the newly introduced dev_pm_opp_find_key_exact() API to match both
> frequency and level when selecting an OPP, here level indicates PCIe
> data rate.
> 
> To support older device tree's where opp-level is not defined, check if
> opp-level is present or not using dev_pm_opp_find_level_exact(). if
> not present fallback to frequency only match.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eba496bc99ca82051dee43d240f359..03b3a1d3a40359a0c70704873b72539ffa43e722 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1565,6 +1565,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  {
>  	u32 offset, status, width, speed;
>  	struct dw_pcie *pci = pcie->pci;
> +	struct dev_pm_opp_key key;

You need to zero-initialize this, or it'll explode the second
struct dev_pm_opp_key {} grows

Konrad


