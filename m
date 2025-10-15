Return-Path: <linux-kernel+bounces-854321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FD7BDE199
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC548343129
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A931BCB2;
	Wed, 15 Oct 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fXa2dftG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353F930DD16
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760525647; cv=none; b=qVo4Mb1Ygjl5NwfA3YexNq1QwKcGlgt9CVBlPCgeAcWyWttnfmCwuWDdu9Nu4OSYR4h0meFwxvTc/fcv3myyo1S6N+pnF75FxyzBPuCmMEBpddJVayfNfTXLNJcOTWLgedO4TjTY18N5rwOMT192Mp5n735YxjEwtTXMZsZtzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760525647; c=relaxed/simple;
	bh=MbXfnKMiKPD634gmC7bM2JdzXeP/4dF+XYw/yV19hGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QcR+gh8QAcql0q/YvfPF7UZL2xApZElWgzBu4ZAknR6EcJDAnZLsSf0gwigISa/r61J7QnBN/wrhXn3VrLaZ4BnN6UEw7q9kDX26ho3EUQ++RLqCyhbWmr6rOMo1mgnaagmlDxj4vuyZxcUua9IMvZVb5NiCu0uN71g7Ht4xjN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fXa2dftG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2s81v004435
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ytoLl0rwr/qVPKTq0TG/t4qw9GJbq9gcztEQZCkXQn8=; b=fXa2dftGNZpo7L5m
	JR5o4M9LMmnNQIBRt5OL1TXhnnsaOza6nKpBt161X+LTrvHXGtpzwAAUKn5pvi/l
	rZHxvtGFiQvEfQ/L4uQxxtiHn67k4L3iHRXNkEfpqFDII9jmIDUBUtWYyz65LWlP
	Iv2kKtDWT79i28NxnNbi/iwaXSs4wVtQkfzBBZQnfC7QbGxFGOFentXoVu+q6H+d
	nc/7bzkejNFARlazGR4teEIeMogDYTnP8hBe9F/sD6JDZPLUEQnzmUd8H2vyQVaM
	21eyva8giuwRxcLZIu95pXnunPSP/pm4FmCVgrwd+/hDdfCVOpztZyA5lnW2fIO2
	D/61qQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1agdx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 10:54:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b522037281bso8279126a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760525645; x=1761130445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ytoLl0rwr/qVPKTq0TG/t4qw9GJbq9gcztEQZCkXQn8=;
        b=wyFG4Lj34hzq1oOjbGBzh6SgsneL+LjTcUHA+WqD1QdeUDS/15ssqh0GJh8QAZ9FLK
         ZC9VOZcFEXJ3G8FEGQtw6ykxk/mZcmZtUH8GiTdg58sJYfmmV8HHtCWsPxZTRqqBgQ3S
         gahyx/gc5D36zrYon8p2sc3usoU/t25PQygPhq59a5rnnM0q62zAzH3y/PqyjzrHwp4V
         jDorlCFIr7vLeUqJwjimuwtEv4k7/8HXOg2BMDPRfCr74ugnvl4kB9rKA3BRbt3+xp6l
         HNZ1Jm1SvhkuHf7ZMoowQ2IOEINtuQFaBs29ojsFTNoiNfFD0vBrJ+JJOaT0G1b8jcuB
         OYnw==
X-Forwarded-Encrypted: i=1; AJvYcCWzobGbP4p66WyGco0Brwpyc2LwliXiPQ2Szg48gs2X4ll6t+XGAOU492c/edtnRk2HAUPMdgCL4v5qJXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9qBQr/IuhuYRL8IA27qv8s+n0Flwg+XfVw4Vr/aUp2/NMx32i
	WFaEh6fy3yK1GhIJIqUSotwgFI66TGkTHz5wtQCGfCCTIAIaO3qrqb1e6LMGyuaSiXoFeJPhbpU
	x5qBwIk+e47GF2iJI8e8rJMLwNOkMxTv2ZDjeaIgdLTuEyOlpPRoFUEgiREvOl14sp+I=
X-Gm-Gg: ASbGncsuFT9PPIMUkO8jVwFWNyeVqg1MPO5LZ1ZFdkB/cGZ0WO/u2CdclEjTeOtuW2s
	INMlqyk0WzDySRLrDg5bl4YQn8fS1HKLkNZE7/q7pIzaS9GbuetGZbrx5E4TPkdtZbVe8r75BRC
	B5+nlsv0UA24Rj4Vaea4isbJPeXZge3xj68czmuwhYKOgzCqB6dnQU63bTCijAPyGnIIH8R31Fs
	xjiwOjq+zarSJjHK/qT0PbpGoGEV0txvSP7OvKq2oOe0rfH1s1KJk8HrAl6Flx91xyK1GJKyqy0
	9oMwn/A2kjNKMa6mHDnqzibUQtl5Ftug7VGb8Ht101DQ6HC4Yi5ArnK1OV1LJqbpqnu49xE=
X-Received: by 2002:a05:6a20:a128:b0:32b:721d:37ea with SMTP id adf61e73a8af0-32da81303d1mr38253399637.16.1760525644695;
        Wed, 15 Oct 2025 03:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMZ2LsLEh0Qr1mBvJggyLP38lECWomJIQg5Rfi0tsF1jrllNMdpOSuP9+V7wgwuseQXiJsGA==
X-Received: by 2002:a05:6a20:a128:b0:32b:721d:37ea with SMTP id adf61e73a8af0-32da81303d1mr38253375637.16.1760525644265;
        Wed, 15 Oct 2025 03:54:04 -0700 (PDT)
Received: from [10.218.44.34] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df66ab0sm14552514a12.35.2025.10.15.03.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 03:54:03 -0700 (PDT)
Message-ID: <026dffcf-f674-4481-b86d-07c28933c97b@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 16:23:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] arm64: dts: qcom: glymur: Add QUPv3 configuration
 for serial engines
To: Abel Vesa <abel.vesa@linaro.org>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-4-24b601bbecc0@oss.qualcomm.com>
 <bkenlzhh5fwspxkrq5jdcpfaxtc5hxg7w6sb6i46ohicdomed2@r2zvqvffmegt>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <bkenlzhh5fwspxkrq5jdcpfaxtc5hxg7w6sb6i46ohicdomed2@r2zvqvffmegt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68ef7d4d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=eQg-hl6CXMczGQ9MqUoA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: bgEjbcfKXCd9wbRKXkF18qNaQhzbSYM0
X-Proofpoint-ORIG-GUID: bgEjbcfKXCd9wbRKXkF18qNaQhzbSYM0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfXxAnDoZZSIDsx
 gCxOywQg9KOrwzyDZCuyE8pzEVx7/5g3TL6VU5Tb6qWIRRIogFI3WU5B2mtS2y2MmQH8v5O4beK
 N3qW2Fwl8CEjdmFPIcVXKp5R9BVC7FNmxwNF9ybXxFB4cLmNJ6BVX0bLgSoqySbEqZcAqMiuMiU
 gCiBVwA69ruGCHnQ5PjzglHi5tgOfTersvEJNKamAZXEoLCr54xRPolv/uZKDUFDLsdZytKJrF6
 bX51QRt/DKa7/9qm6tTZWKBCANZnh9cKJbdrX6uUKJgTaM2OphH+0V+Vxlwl2UDvWAkwqsHfsbe
 /4A5wktUPvuJWODCXmoC6RuHc+Xta4Nrwm+phFE0FrFcZgqo3fjMx4djitPD58b128WyyYQU0Sc
 +ncYEnfCvoaFlmotKqHfEkp35aNGyQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035



On 10/11/2025 4:46 PM, Abel Vesa wrote:
> On 25-09-25 12:02:12, Pankaj Patil wrote:
>> From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>>
>> Add device tree support for QUPv3 serial engine protocols on Glymur.
>> Glymur has 24 QUP serial engines across 3 QUP wrappers, each with
>> support of GPI DMA engines.
>>
>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/glymur-crd.dts |   43 +
>>   arch/arm64/boot/dts/qcom/glymur.dtsi    | 3041 +++++++++++++++++++++++++++++--
>>   2 files changed, 2936 insertions(+), 148 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
>> index f1c5a0cb483670e9f8044e250950693b4a015479..8674465b22707207523caa8ad635d95a3396497a 100644
>> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> 
> [...]
> 
>> +			qup_i2c22_data_clk: qup-i2c22-data-clk-state {
>> +				sda_pins {
>> +					/* SDA */
>> +					pins = "gpio88";
>> +					function = "qup2_se6";
>> +					drive-strength = <2>;
>> +					bias-pull-up = <2200>;
>> +				};
>> +
>> +				scl-pins {
>> +					/* SCL */
>> +					pins = "gpio89";
>> +					function = "qup2_se6";
>> +					drive-strength = <2>;
>> +					bias-pull-up = <2200>;
>> +				};
>> +			};
> 
> Re-write all of these like the following:
> 
> qup_i2c22_data_clk: qup-i2c22-data-clk-state {
> 	/* SDA, SCL */
> 	pins = "gpio88", "gpio89";
> 	function = "qup2_se6";
> 	drive-strength = <2>;
> 	bias-pull-up = <2200>;
> };
> 
> Just like we did on X1E80100.

Sure, that makes sense, as the same properties apply to both the SCL and 
SDA pins.


