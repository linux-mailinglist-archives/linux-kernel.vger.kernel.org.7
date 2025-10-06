Return-Path: <linux-kernel+bounces-843096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B12BBE661
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 16:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABEB83BE744
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 14:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29B52D641F;
	Mon,  6 Oct 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ct9bawa9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FD1DE887
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759762155; cv=none; b=RHk/BGqdwPKu43fJVNNt9MVFAjXbY1Wou0IxDcNIRJUlZK5iQKqXQwN9RKDqlJ2g7YM1lYm6jKofHbcIuoPZ/P06oh0fD2iLlSAU1saLMxdwy26fl1smKHwg0z7aI0aUwWyYrWU3MBTxJdK+4WxcYra1PpjD5zXaSbkKTaz+7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759762155; c=relaxed/simple;
	bh=DDdvduZCW2Z8nIJhc94MFo1mRsBdxFtkFQo+vs858Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szHsm2mlX7CJxXp72jVVXYuct41W27i/juZokfpw4m3ZT3hf5xYEU07FCndupK6o+H3ABfcct8wEDscAgvQa6VAnUGggVuJUaT2xuVynCa8PovQyRMaRlDNIeJpp5ejiOYjbh6867+c0Jv7UdzYSbCn4MMc8dLjfENt8cFFDwHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ct9bawa9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5962gKZC015772
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 14:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BlE28KeTREk/lFa1EGLi+mQhvzWeHGPa3L+Ltm12oA8=; b=ct9bawa9MKiXxQWs
	adMkZkOWEpv+XlRF3fhy3/MgRXxYy+XYNWljAao8TLy6MG1YecClgGv8847AFoMb
	kjTzvAwFCXdHePEctHH6vtZlDRnosDMVstbP1oOmVcgw/4OMb07masaFPyKk8mtL
	PA2B7E0/FZ+Y65WOfcYluWHA0127mAMcwoFfvXq8YHjecZUzPfUzFaJVuRQNwA8t
	xF4etEC1qlS6Rm5G271eImmbo62a/5Shjyu3HQdMBPnhXkfh/xLqCtovZ7KPOypc
	lFWH+iuvAH1WIOho4+Qk+RYpVpH7MmdAD5mIbWo2RC8Dyg+yADfLn6QeCwkO6Cxs
	miPKcA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49k6bfk9pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 14:49:12 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-84fb3e80002so12718586d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 07:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759762151; x=1760366951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlE28KeTREk/lFa1EGLi+mQhvzWeHGPa3L+Ltm12oA8=;
        b=MbbuGGQz1cBTvcMM5DLxVXwZXzSnh+N4UJCrLLcOit0BiEZijMHwkcXSH7z/Bxv07T
         dPFAvppcZOMRef3AUZUORsdUBFDqu6aDH4kYKjlXxETWjuGC/2p3ZkCyMqCVPljjkGQo
         zA63vLup3m/W590ZH/AAQ4qtqx3VH/7gaU91qSBDcf0jY/3m/Vfx+mtmvl4XB0emKWU9
         q8lZwK/mJKRlMzq73tvlnkfVgKiYGSYJHPjIvSXDHsBMXPMrmV0xTYKiCVqxHfIJEvpZ
         s3R1fTIbeQsYGZ/edp29VUE4o20pUr9rW9D+Nm1gRvPAauRKTwzkL0r4OvNSqRd/olTo
         XE4A==
X-Forwarded-Encrypted: i=1; AJvYcCX+SEhvI1Uq93NCryGygCaL2PLUtMX2l8fuJVpgr13V+aQTd15N7alyQj9gQZwytl37gp48qZyFJ50pXtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYWIAeKbiNnVCFGJwsXC1ULatVWPw/+sod+/o5SnapKyKxF2g
	Fn29LLUMvzu72Q0a2cHgEL+ob8eYjTQjh6a49ZAJxS2/09jYOL3rD/GzB2walqStH/5ter07g2G
	RmnH3w+tGYGSvZcBzXUlid53MIaqXb0zLL3hRzurAtonSNP3DxFuMQ/DwZKcXRM04kC8=
X-Gm-Gg: ASbGncsHa1AkW1B44ol+BqlDkXlLeL1LsV2jbUt9LqCkGC3LqTwAAEqjt2pR4/4FN4G
	O67UrkxSXAD4QXUOWXnHkpZ9yERlQYycBB/LyFL2OCAxJxkVjPteMvn6vkJLSZZpD0MfH+nvEpt
	bIrHzpuMoCpv1kS6NzLh+p+WpY8Q5M/eMkgYkkmgUn2XXInVmgW2oO3kJ1CXkY9QhNhYMz//c/0
	hAmO40L1f59MCpKuJZ/JNyTjwZVbSEWetigr2F4BrV+WgSIbRBVhA1wgjhqMLQCMZkSjySaOanl
	kvqNl9kUSODeiA2rC5MhcLI2uhi74TZFDhtQ1PDdFZ54MYPDbyup0hmC3wshrIWZfkMRW2YRAKX
	fN6Oz082doE6JrMSQqqCM2gn6JoY=
X-Received: by 2002:ac8:5916:0:b0:4cd:3f47:9786 with SMTP id d75a77b69052e-4e576a5d012mr107775331cf.7.1759762151130;
        Mon, 06 Oct 2025 07:49:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsDo4zO8lELfurbcAIQw2WuxQVGEUp+4FMuw0QWdzjCHovaEMKDgTH+6sh93R5GKV6EobpzQ==
X-Received: by 2002:ac8:5916:0:b0:4cd:3f47:9786 with SMTP id d75a77b69052e-4e576a5d012mr107774921cf.7.1759762150515;
        Mon, 06 Oct 2025 07:49:10 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865f74002sm1169018366b.42.2025.10.06.07.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 07:49:09 -0700 (PDT)
Message-ID: <8a5eecdd-d80f-4955-8ab7-cf6fd991a3b7@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 16:49:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-shift-axolotl: fix touchscreen
 properties
To: foss@joelselvaraj.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250919-shift-axolotl-fix-touchscreen-dts-v1-1-60e26ad4e038@joelselvaraj.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250919-shift-axolotl-fix-touchscreen-dts-v1-1-60e26ad4e038@joelselvaraj.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mSxcTlX2i3l1yc91fQR4GTjaXoydgi1l
X-Proofpoint-ORIG-GUID: mSxcTlX2i3l1yc91fQR4GTjaXoydgi1l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDEzNSBTYWx0ZWRfXzUYojz/WR+gd
 q99MHeGXO8k1M4+aOE2dfOkFahRr7xawMsT8v38NSFxDzpD1k+3SwtBiID2+NvvYivzgp+V9MtA
 GOlRH++gSQ8Qv9G0qAWVFKeg4KINpJzwpTEWOmQz8pqdxw2Yfgg6rZ/rHHRtAH+lJ3kLOHkirgw
 PCSoWg0TSEyy/Cw6Eh1dakcXWT4hsWgJbtfwwyk61Adr36wyeQmNrIiN0nYwOi9sCNCA2HffVBH
 DOoinHHWlNQQkRNt3YpDaq4ux52YilHsD+sUjtdcUx9mrTyzc22QNGQZ0Q4RAff7RytJSpS7pj+
 a629RnnlMJBBwcxQwgNwlNRzmFVhNte2jPqGDGnjhQCFTj35tnkSEaIHyQh3319Lm/+a2ForOkV
 uCFms7fAis+opk8DW+csww9iMClWBw==
X-Authority-Analysis: v=2.4 cv=Hr572kTS c=1 sm=1 tr=0 ts=68e3d6e8 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=WFa1dZBpAAAA:8 a=pbvAuR7eWiNa6Kevsk8A:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=MZguhEFr_PtxzKXayD1K:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040135

On 9/19/25 11:02 AM, Joel Selvaraj via B4 Relay wrote:
> From: Joel Selvaraj <foss@joelselvaraj.com>
> 
> The touchscreen properties previously upstreamed was based on downstream
> touchscreen driver. We ended up adapting upstream edt_ft5x06 driver to
> support the FocalTech FT5452 touchscreen controller used in this device.
> Update the touchscreen properties to match with the upstream edt_ft5x06
> driver. Also, as mentioned, the touchscreen controller used in this
> device is ft5452 and not fts8719. Fix it.

This is a little difficult to read, breaking the paragraph somewhere
would help.

> 
> Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index 89260fce6513937224f76a94e1833a5a8d59faa4..d4062844234e33b0d501bcb7d0b6d5386c822937 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -434,20 +434,19 @@ &i2c5 {
>  	status = "okay";
>  
>  	touchscreen@38 {
> -		compatible = "focaltech,fts8719";
> +		compatible = "focaltech,ft5452";
>  		reg = <0x38>;
> -		wakeup-source;

All the changes look good given your commit message, but you dropped
this wakeup-source property without explanation. It's fine to do so
if it's intended, but please mention it if so

Konrad


