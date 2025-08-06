Return-Path: <linux-kernel+bounces-757170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0A8B1BE94
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 04:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98AC167D00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4119ADBA;
	Wed,  6 Aug 2025 02:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BVhk0sxl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AE71422DD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 02:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445889; cv=none; b=DhehogHw0iMVd6+kTHZAsGe7SxWjJ7P4wtCc4C9hnsAMLhQMgXo1vjsTCNVoQF2qjPoXwDJX/Byxc/Xr6umfFJmaWc8c4EVPe2TOVSZGSGrw2G6NkQUBbFG+eTHCv9nATkkw+UAAHeY0Z1v/jpYuaNiMxhQut2yjo/1MsW9DH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445889; c=relaxed/simple;
	bh=0cJicQ091J9OjMWSKDQJTGpw8UIKWd/RWbHq1EwTwPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2GGP0wc7MLgyIuYyySUy6FiFgUT/FTjqLV6znDDHj31Y9VJTPSXNFpuPbvDH/TOag69bdEJe73yFBdZepsgiznKi685neDH7SqJsIPMAWUeOdrC+lXRG0cGz0+YFwK9feuO2AWpO9rni353oKNAorMJnN8UR/ag4wOi/sbmnd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BVhk0sxl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761exQx023669
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 02:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yXGg1mUHTujtbt8jVsUDVGPI6WRp9uB3EeCifdpRU6U=; b=BVhk0sxldBZH73/d
	C/y8O1w+pWkzETua99lW4xgP2j9hWJmg5HaR+NoCBlhYMZPYCTW/vuJiUjDcNx7n
	eHpkDV9wjJHHFVTMp7k8/0a2e8wExoGG8v/G6ZXFcjTLj0jp8TWUOkj54sGwWkJ8
	5CNaAM25V3aGE0xpceyiiL99vphyvpIJwin5sUMpowIQSSFnxxW67+nNUUvHD99O
	V2x3YeuUyGK4f4lG3C9XZRARtNBNgHNjnzzUUKaWVUFMuJJKb+T+3aB5kK5dgBOy
	UX5FUJs1mFoJFh9hLS5MU+nF4qvN+eYVisSQtMigocb7x6KCBKOMTXSvPmhQ1aG4
	jFvc2Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpya91xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:04:47 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bed3183ecso3569571b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 19:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445886; x=1755050686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXGg1mUHTujtbt8jVsUDVGPI6WRp9uB3EeCifdpRU6U=;
        b=hPAOzNhYNzel/51VAbjVwlsEVofabJxK2Ym73XGnbNdko9cQLDyb0O7JQwbJ83FevK
         /lt0x45I8U77y0tLuOV9NTK5a4exyOozMHLFQz/X4crvktJVkn2BYkODiQTTK3kk0Lu0
         JePpnRRPfkiWKJf2u5G61RzIJxelTXXrHBnY9Fvo3q9o08wuwsytKpOwl3Aw3L6aunoz
         apcUpZDfFmWWYS5b9hXvkWQPIbfIgEylagdmnSfJIKiUnzKJxTowBF0a4Lrspkn3K2vp
         mpqiTED5R6YXYbTqRbVy5TGF/E6dOUSaifSl9zWZ4ZgG9uS0tg+MsT63hSSSlqmQd+3i
         s36Q==
X-Forwarded-Encrypted: i=1; AJvYcCXk5PIbkKiCBqsXlzK3I85QO8ncLY/8twh40qE+jr4baa+hYFqkPwPaN5ytNXD4PHuTJ60ma+jUumbm2lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGFLnUtmDGyuAUS7L7yPb2K86g/XAA0J2BpquzfQ3N0FJTDknO
	6jJkTzUhVBNuYkfHGmcYDOouNukDLpBvbPEPxQJBp32GXK0EBQInbCJICK4S6LHX9HZudwV7geW
	OXehr3zJ6IBmH3TEtgUuQQ19bd8v+Ro/U9iKHsIpYCWpDps29+RzYXh4vbNkXJWzCpgA=
X-Gm-Gg: ASbGncsmi+lASO+3na/yUPjmS8moIuoDMpYRx4sN9oLx0/qrLUlqAkrNT4QSfJHUuVI
	t2pLRDsYiN5aV4jR6O+vvzz1RbPeGaewkrssfDhm/kVMiV82Cy4seSgje02aq1Bn8DiFiMnvTYy
	LbQB9KxU6JKNndcTbFFUrYK5IB7c11+5ssvy4+S3e8+9iVZ0zWZ5cs8HNCcyDQ5nXqwnbdA9J8f
	3NFMq3MrYAsuwZMPH7MdP3WPNUPLmpZdHQA0x+T/oGxoAhfQUSn5Zndi4DPGlHee8RabEjAW7jK
	61g9z+xnGjTsJSJU8SqAcn+puNLw6HEokWlgWV6LBw9/Xs/fm1oKlWs19YnyZcwj7MUAuzNTrvs
	JDQ+YC5G4PG+QbutoBNNSX4qFjtGS0Sk=
X-Received: by 2002:a05:6a00:2e94:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-76c2a2813bbmr1482711b3a.3.1754445886541;
        Tue, 05 Aug 2025 19:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqDV5H8Jprm7TFGMMrpbU5LGfL2JFi875JtBI0da+l/0ajF1L/WkClXKDwmz9eIB2FWpjkoQ==
X-Received: by 2002:a05:6a00:2e94:b0:74c:3547:7f0c with SMTP id d2e1a72fcca58-76c2a2813bbmr1482674b3a.3.1754445886088;
        Tue, 05 Aug 2025 19:04:46 -0700 (PDT)
Received: from [10.249.10.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd174sm14118221b3a.63.2025.08.05.19.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 19:04:45 -0700 (PDT)
Message-ID: <784d4807-9137-4160-a8f4-832831b5f751@oss.qualcomm.com>
Date: Wed, 6 Aug 2025 10:04:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] arm64: dts: qcom: Add display support for QCS615
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>,
        Li Liu <quic_lliu6@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>
References: <20250718-add-display-support-for-qcs615-platform-v5-0-8579788ea195@oss.qualcomm.com>
 <20250718-add-display-support-for-qcs615-platform-v5-1-8579788ea195@oss.qualcomm.com>
 <1f6fc7ce-5826-4f59-89d7-ac691a3ae785@oss.qualcomm.com>
 <7e4d9dfe-428f-4374-9be7-97123cf36e5a@oss.qualcomm.com>
 <c93ab714-93e0-4b4b-b059-c48d4c689c1d@oss.qualcomm.com>
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <c93ab714-93e0-4b4b-b059-c48d4c689c1d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R8phXw5FL9di2yxBWw_tiBnTfviNuUQs
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=6892b83f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=uzlMTK-j72Ye4Gqdn10A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXwEzO/KYctkm5
 4nNMzOHrhJHl5JgEuAqXFZ+IBK85obuWQLxYK+NU65f9EkszIZh5GuBdaLnblnsXoc2DrLN2CY9
 jl4UF8P2FzmjwADZIGnb718BKAzsl5+l/tICFjJS06+KggAPC6REAiva2jk1CmS8LRZEZmvKYPz
 haNoTG5A5nJ0Zzr2mbETHgysytKZoh8JVbfCSWuseRgIf6+nPzEBLBw/qGqQ7FQcD50xKlcwO6T
 PJcmxtt2aYF+wetYho7UG9dSveQk107m01g6cZ13w8mcWfHaefqMJLhpV8L3JYmu/nPHUJW8DKw
 k6yvTXtA2vKgpEpJZJLwCa97nrdkFHFrgAVs+L/MFFhWw17eDorKS50dI8goTNNzSRgAxTDtxyK
 VMjT8XNq
X-Proofpoint-GUID: R8phXw5FL9di2yxBWw_tiBnTfviNuUQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009



On 8/5/2025 8:26 PM, Konrad Dybcio wrote:
> On 8/5/25 2:24 PM, Fange Zhang wrote:
>>
>>
>> On 7/29/2025 7:17 PM, Konrad Dybcio wrote:
>>> On 7/18/25 2:56 PM, Fange Zhang wrote:
>>>> From: Li Liu <quic_lliu6@quicinc.com>
>>>>
>>>> Add display MDSS and DSI configuration for QCS615 platform.
>>>> QCS615 has a DP port, and DP support will be added in a later patch.
>>>>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>> Signed-off-by: Li Liu <quic_lliu6@quicinc.com>
>>>> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
>>>> ---
>>>
>>> [...]
>>>
>>>> +
>>>> +            mdss_mdp: display-controller@ae01000 {
>>>> +                compatible = "qcom,sm6150-dpu";
>>>> +                reg = <0x0 0x0ae01000 0x0 0x8f000>,
>>>> +                      <0x0 0x0aeb0000 0x0 0x2008>;
>>>> +                reg-names = "mdp", "vbif";
>>>> +
>>>> +                clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>>>> +                     <&gcc GCC_DISP_HF_AXI_CLK>,
>>>> +                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
>>>> +                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
>>>> +                clock-names = "iface", "bus", "core", "vsync";
>>>
>>> 1 per line please, everywhere> +
>> Got it will fix it in next patch>> +                assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
>>>> +                assigned-clock-rates = <19200000>;
>>>
>>> Is this necessary?
>> test pass without this, so will remove them in next patch>
> 
> You need to leave a \n before you start typing your reply, otherwise
> the email text gets messed up (like above)

Got it, sorry for the mess>
> Konrad


