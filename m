Return-Path: <linux-kernel+bounces-831725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6AAB9D690
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094BE326A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638C02E7BAE;
	Thu, 25 Sep 2025 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Syk9qAre"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC62E5B32
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758775740; cv=none; b=EFXN44S9IcXeeiv2VgXq6Y1j2Cvm4f+6veW8sDE7iefj5S4NeMckHNYf44BgD1Wa1NkcNb38FTiM+mvpPwft3isJ4rlKocEAfRc2+z56D5Ev6GTC5muFY6R8gSg+38l3NC27VpuObq3+O2UIuRis4EHvJsRrWhwIMUiLdoEb+tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758775740; c=relaxed/simple;
	bh=s9FpdGOs8PnBwkz48+q+M2ShltlanLs7DUrxUEIDWIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnZ8+xyrLSh9u4qg5AZ4Xsxe3kI2zuGM5s8O/axd5N7NYBLAa2s2EiZ+NFbeHCUCntzzpC3n8rCVOlkbtC+peEgwkcj/I4K5dNK2snCIPqzAbwp+ZBWrr2vh5rk4QaQ/tRiM7zQ6/P7J/2zU79jMqkrPq2qjqqVYYr16NcnlQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Syk9qAre; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4a8pn026654
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4LU6IeO1zXtpAmB/Z0x5SiX+9EHhyKCQGpK7EzCxiG0=; b=Syk9qAreokVlRZKo
	f7SjZ90/wbmBegbK475fhrZj1xu1iSzzmRMwHeECsRXm9vTryOSsxm8IdUB8+ch0
	rX+fk5OcxoqXlGAW+T0i450T4fE4bU9pTEtZG9NJzhfu8IdsFoxOmkRwTbBglp/t
	los4DfwvKdK0vP7hftLGeT1ifr8riiANeSradJalQX0kGhd57F71CZre8Bl+dwwH
	A1UxZ+hdv4uQQ9Nyqait8AG+Skq7eGt/3MctSsD4KK5L6ebj/xbqCaSiGMCiqQu7
	+6XbOVv8qwV65aTCH3WdkGd1IefRGa3miTHp3kYW83AqtDNMMod6Ewjqlx1RvzZg
	ktOjDQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup00tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:48:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3305c08d975so579240a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758775736; x=1759380536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4LU6IeO1zXtpAmB/Z0x5SiX+9EHhyKCQGpK7EzCxiG0=;
        b=OCrT5pRIiUno04Trpv8WatqeiLO95cZjHVuJ6oTSxuM295XOFSn3P53aLCI+8MCBkI
         hUQ+shMxorXjKFARwCKJX1qPc3TSUNtxwkdEv4Ah+rN6RGlaUsCJQP+Jv/5MoDoi5E7G
         L5aJXffBRglN8tPdOY9TPfAmV/wLzi7VVfc2QnwhJWT+1KkMhy5+TX8t/9fAQkYHuhjN
         uGWV+PULBAR2e9tpAosZ0WHq7A8Ri5GwtsLTlOdKAJr1LrZiT0M9ep0lGb7gi5Wh2ran
         NwOQzqAEveFcMFW183Ovps2pZNxk+hyWEIzyAVPdBhojYYEcDylpdBcHzLFzvIiUniTZ
         vXsA==
X-Forwarded-Encrypted: i=1; AJvYcCVfNEKOi69uk+NDX1G2WC4jTgZeMhvzhV/t0oWrrEM5xAATfsJOZHneYBXAhLDJ57Se0AxFooX6k/R+t/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPH86f/kqsF5UdO91f4oqYKw94BC2R2hX0KbHUXKKDtpt0Ftk
	MAANjKinghsPJF/dpS6ssxziTUXOPqWlns9wom5jiyXo7h263G9gdGUzkXv6OcXBGqWIg7nsgC8
	KC9P1HokVy57UPeNYGpVkQSayog52lNhMg2LPz68KZJBEzaTL9tMpj1RjUqU9s4ptBYI=
X-Gm-Gg: ASbGncv7D7WV81daASDw0Qmhrnazk/UeQfQL/lWoK2bqYPNZK3oB2tW/thDdmq3+lxd
	sPs7SyLCxVRV38JQYwLxW3UsxZ4FqXTxMmeoNngHpDkShY29ayeXeO+JdXqZfv5Q5VMCW6ZLtaC
	xp5Ol0TpaFXLvKXeyQXk6XwOVtFPYp4z2CcpQuif4tf4A9dr6choRbLpBvQCFz1EhBy2+o6cCU9
	IsmjX/ypxslUbf2No0WwieCZIFNk6OdlYookiI+1nDq3Pl50djzd9nWN2OoxocVu5ZN6TVS64U6
	2lCDf6dgtK5AkgPoY6zhnwJ5iCnFdPH9kVl87lcoAmUIPKKS0Enm5zFE7B8wuWZVddw=
X-Received: by 2002:a17:90b:38ce:b0:327:83e1:5bf with SMTP id 98e67ed59e1d1-3342a2da541mr1678275a91.28.1758775736011;
        Wed, 24 Sep 2025 21:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVWgEtqOn5boD43PWaFWdVBdM9sKcuzskhvCnQ25tJGjyIKpXs4nP0mBgSM4AQTvBtl8bvJA==
X-Received: by 2002:a17:90b:38ce:b0:327:83e1:5bf with SMTP id 98e67ed59e1d1-3342a2da541mr1678246a91.28.1758775735495;
        Wed, 24 Sep 2025 21:48:55 -0700 (PDT)
Received: from [10.217.216.93] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53c9862sm899243a12.14.2025.09.24.21.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 21:48:55 -0700 (PDT)
Message-ID: <f255d360-64b2-4880-a069-81c73095577f@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 10:18:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc: Update the halt check flags for pipe
 clocks
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250924-glymur_gcc_usb_fixes-v1-1-a90568723e64@oss.qualcomm.com>
 <9455818f-3f6f-4985-8389-fccc7852b569@oss.qualcomm.com>
Content-Language: en-US
From: Taniya Das <taniya.das@oss.qualcomm.com>
In-Reply-To: <9455818f-3f6f-4985-8389-fccc7852b569@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d4c9b9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=muTqSOK3q4JbPMG3l9AA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX9Fqrhc6f7UQS
 g3OoK7/Mx3u/hpEDviXEbbZTZGzb/q4rvRd67Yli71WL1b+OiGOjKkOCcQNrxmaZPDaX3AWL8E2
 gjooH2eTejhpFz84sGbimEaNZU6Ic1CSLL91PsbHrp/6VCBOf4Ni8qiLfwKmWmdP6nwXYR2aVix
 VrYOiuhRTqvsc8eusx7NsErYYyF314IQzHIxTTLzMsKJA3iv84G9o+CpQnxr3QLDfQXlYY7kRKX
 OHPqRKv/L0ZXIKhM4haP+wIyqefXnBaY/CvSdSRfqoSt3x8H+GEqqzIF4Q7E1dDyR+yzeLT2pGB
 bz06+gxPaTNVGVWdb9jGol9yZDjCyxcz5kb4h8aihHuvHIOacu3hT6vZfc1vpv+H0ZHHhDzN62L
 JEq/vlED
X-Proofpoint-GUID: zq_fHXlZHKXpy3p3LxELSFRykWmn-_1g
X-Proofpoint-ORIG-GUID: zq_fHXlZHKXpy3p3LxELSFRykWmn-_1g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042



On 9/24/2025 2:55 PM, Konrad Dybcio wrote:
> On 9/24/25 9:17 AM, Taniya Das wrote:
>> The pipe clocks for PCIE and USB are externally sourced and the should
>> not be polled by the clock driver. Update the halt_check flags to 'SKIP'
>> to disable polling for these clocks.
> 
> "This helps avoid xxx is stuck at 'off' warnings, which are benign,
> since all consumers of the PHYs must initialize a given instance before
> performing any operations"
> 

Thanks Konrad, will update the commit message.

>>
>> Fixes: efe504300a17 ("clk: qcom: gcc: Add support for Global Clock Controller")
>> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
>> ---
> 
> The patch subject must say 'gcc-glymur: instead of just 'gcc:'

Missed the SoC name.

> 
> Otherwise LGTM, I've been carrying a similar fix on x1e, as it
> (obviously) turned out to be necessary for the usecase
> 
> With that fixed:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

-- 
Thanks,
Taniya Das


