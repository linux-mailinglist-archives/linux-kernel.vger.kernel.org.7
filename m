Return-Path: <linux-kernel+bounces-868345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF8EC05004
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D866719A8887
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBED302176;
	Fri, 24 Oct 2025 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N+9kQP6K"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB39302152
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293644; cv=none; b=lA3OqnfWqPvhTQ5RMgMEG59TfP/dn9ixSQex2X+Ucu1Pb1jy6Mwub1Og//f7M4Ff5u/7+4EkwimFTP2N40++b6fhO+1qPH58Ia4Xbugfs7InBCqn/BF2DCatHDUCh7BeHg+zhyshEsaDdD64XZLbVesjDyW1CiYfk9t3aLx55Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293644; c=relaxed/simple;
	bh=4LQY3pdZ96rnqQXgBIRUHW9rIPYIt55eL9zhEIQ1qs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0A7RAnRVnx1qtNZwxWXTYCcs1cr6ufKPVn3PI3FdXTndaw7YUyjCsavvvd7RR8PxC+eieF1ZdEXtnH7il4Xr3oc8kq9PYYPMcxYR5ipznWIRQNcqzsA0O8T9JDd6OvOXvSZhNAAJyQXLdDWhDiwJ/j81jVWUF5fXA08Pui8LkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N+9kQP6K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3MHs9021692
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EzKZx0KdaXQPdMY8n8YdZTFhqr+6LBjxgD7f+bSFhX4=; b=N+9kQP6K3q05ylN0
	1rj4qkXLo/nbcCi5iNDpsxHs0aJDWzafnV9TR8HUdGIiZzSeVFnpX61zQG7IaHUT
	lgLYgCT+6kYqlDuiIRckPEpMyCn7a12cFprp9xdtroCp+raUfRQ0KRDsL1auHQB6
	I4XeysUiaXwzs7ffctWnvmJzBPhhCqHwRLVEivh5sOkSDgflaTQuHPp2AAmMvlic
	0EYamGSrvt8dneXsHlB3HqbW9OCLSBtEARN+i5USPMJiFqyPaG6r/DudQOVvdSje
	GMML/ErnCvRY6jZEBJAPgaY/mEEjJkqYDdDNddiDdyVwa+jdj2BBo2xJmCZcS6ga
	/A740w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y5x8ng6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:14:00 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c28cecb4cso5420056d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761293640; x=1761898440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzKZx0KdaXQPdMY8n8YdZTFhqr+6LBjxgD7f+bSFhX4=;
        b=PUhHk7F0BYEFhJgmdSOESoZSFxBbYPzNaMJEWRuoV5ffChitO09FiOfyVIcsn+0dfP
         GlcOxo52KFSdGrMY90WYkdubA/dlHIk3HXoT2Rpmkk4WjabRrI2UIYLRD9IZo6NaboBj
         shpnmKntLSr6zelYKUTIXG0ksFZ11pfG5c81qakTK11itaofxgPoBhoHhnPq47wcVDgF
         k9t5CpFICsDM/de20bk+0LmrDEEt83ff6MtvIi49GIiOuslF6zzXaLD1gIcYJES304L3
         3TqEH3OkWVmGOb9zsYl7Ea0NzrTIIDMAR/l+NhUzm9hBnQ6n3izJV20aY8qwP5ITyjI8
         RQ1A==
X-Forwarded-Encrypted: i=1; AJvYcCWL3pczg7IMwQQ8iY5xKNCUWVaw40/zEvFOQQzd495W7nAIdqYee9V9Xdr8gkMLu85NI8veDlQYaEUgxJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD23ggYjLs3BuUXr59MrVfzYPg8Qw44qST4+uQVuoESUkyijk9
	MjWMx2DW2HvELme+7hoDJ23x8hsTbR06XpV1TPaeGl9NDA+to9ixakGa6kjrkBJz1Gued3z3W5q
	wTb8SVh0ZDY9bto8Mcy8grSJT91TQ6Bdx+vFtVGR640ixtKo+j8bXtJAwD0+x2cycu6aOOrAkkJ
	s=
X-Gm-Gg: ASbGncssWPQJfv5lNV5OfyDWjvVf0og1PWC6juw+Sdf9i3k3YSHC14VhDfY8b1HoHxa
	lRv9eY7nLUZ8ECMRJ2GlUCdyc6f1QKlRNEpgIAo3t4kvbmUKZKEajEbgpaRAiyJbvSRTunLMhAa
	YGXXsnvD35FGKoIlTe8b90Bganfrn5CkESihgQ4QzjLWizjcB2Vc3PhMmrwfjs0rksPTghEZesy
	WCb1LCTb40Jovko8m/F0PUKv0OcMCMo9G7gmRAx9ttVwK15f5Yjz3qN7/KxHUex1C//apHKzgTm
	M82LcHBGQw3XoSDWz0pwWAZ1wAMtOOIFI6aWsWvOBFEfD+DrJGXj4vhan26LOjhA5avXcSbdLlR
	VlfGsHliBA8GFvVS+g8BKq8/mfypU/kGUwPwb7i18jDrX/7tPVN0VXLIO
X-Received: by 2002:a05:6214:1ccd:b0:87d:c7db:7897 with SMTP id 6a1803df08f44-87de70be59fmr111017266d6.2.1761293639871;
        Fri, 24 Oct 2025 01:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkuQteOXxBMGqxcPQtHgaZ3r3sh4noI2NNA0gmaTaiHoQCDysA26yJKDtBnRE/gNxqBULdog==
X-Received: by 2002:a05:6214:1ccd:b0:87d:c7db:7897 with SMTP id 6a1803df08f44-87de70be59fmr111017056d6.2.1761293639396;
        Fri, 24 Oct 2025 01:13:59 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3f316cccsm3683716a12.24.2025.10.24.01.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 01:13:58 -0700 (PDT)
Message-ID: <cc7399ed-db57-42cf-a944-6213a8df8491@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 10:13:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] arm64: dts: qcom: sm6150: Add gpr node
To: Le Qi <le.qi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20251024023720.3928547-1-le.qi@oss.qualcomm.com>
 <20251024023720.3928547-2-le.qi@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024023720.3928547-2-le.qi@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7atK-zz2jN6hqipPLdJzqpeUUEQRXlts
X-Proofpoint-GUID: 7atK-zz2jN6hqipPLdJzqpeUUEQRXlts
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2NCBTYWx0ZWRfX9aMr0ck+oG5a
 4B/OBRkjb0Qtg+VZSw5oRPKaIZeM4UN5tFqYo4wefi252thisliBXi8CwfEMKUOASM0k1LoGqvk
 /hZXtzhPHX74G+YqKog3um1CAkwZMqphqwK1TfZQsqVw0CinPdd8Ggalf/dwNWDIbUSphia+59b
 TqDY1Dbwk4U/WXCwG+5siWnaiv1xXkvhxj6QsiipRgnfHghVDMcFkhGFKvVkbagSx8OupybdvKZ
 K0H9nuikJpYK90D1wVsWbyb9F+2Hs7KpXFuz3CZM+lSuuocZQMyWJWR4yTqeAD9RoAp8N08YrHV
 xRlXezbWVEeY+id7EDjRhAXS2KgvAxSuPPpBzyItwRDrsANUgW4Ql/1OnzDjegcI/dLKF7iLP8h
 6FOGR65l1vYpT/2Uv5yF3hWmKi9J4w==
X-Authority-Analysis: v=2.4 cv=UOTQ3Sfy c=1 sm=1 tr=0 ts=68fb3549 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=GhKeX4-ZSDom7ex7ThkA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220164

On 10/24/25 4:37 AM, Le Qi wrote:
> Add GPR(Generic Pack router) node along with
> APM(Audio Process Manager) and PRM(Proxy resource
> Manager) audio services.

This is a really weird
way of breaking your message that makes
it difficult to read

(stick to something more like 72 characters, please)

> 
> Signed-off-by: Le Qi <le.qi@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm6150.dtsi | 36 ++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
> index 3d2a1cb02b62..ec244c47983e 100644
> --- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
> @@ -16,6 +16,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/power/qcom,rpmhpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/soc/qcom,gpr.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -4246,6 +4247,41 @@ compute-cb@6 {
>  						dma-coherent;
>  					};
>  				};
> +
> +				gpr: gpr {
> +					compatible = "qcom,gpr";
> +					qcom,glink-channels = "adsp_apps";
> +					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +					qcom,intents = <512 20>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +
> +					q6apm: service@1 {
> +						compatible = "qcom,q6apm";
> +						reg = <GPR_APM_MODULE_IID>;
> +						#sound-dai-cells = <0>;
> +
> +						q6apmbedai: bedais {
> +							compatible = "qcom,q6apm-lpass-dais";
> +							#sound-dai-cells = <1>;
> +						};
> +
> +						q6apmdai: dais {
> +							compatible = "qcom,q6apm-dais";
> +							iommus = <&apps_smmu 0x1721 0x0>;

I see that the documentation mentions a mask of 0x0 (like you did
here), but downstream does something funny here:

iommus = <&apps_smmu 0x1721 0x0>;
qcom,smmu-sid-mask = /bits/ 64 <0xf>;

with the latter value being consumed by the driver manually and when
it binds some sort of DMA_BUFs, the effective SID (ID & mask -- notice
there's no bitflipping of the mask part here unlike in the SMMU driver)
is prepended to the address:

smmu->pa |= ((sid & mask) << 32);

We can then check that the SMMU driver reads the SMR mask as a 16b field,
meaning the result is (sid & 0xffff) and not (sid & 0xf).. 

If we take the hardcoded-downstream mask and compare it with the HSR,
we can notice that all the streams in the 0x172X range correspond to
LPASS_ADSP, so perhaps it's a design choice that the DSP end only cares
about the least significant digit

TLDR this seems to be all OK

Konrad

