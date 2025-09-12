Return-Path: <linux-kernel+bounces-813724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5DFB549F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B548216DD58
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1513C2EBBBD;
	Fri, 12 Sep 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iAaTSjso"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C042EB5B9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673333; cv=none; b=iW0A5a79iAIyEnDaj32Ek4pqrvRLxz1d5aVG16T94w7YOp2+Q83DvAcN8YUhPB/37+TWn/t5mLlYL52uiD+207juEJFlPgNTaYKAphA8sglDHdop3Ym8UFraz/DRO7rdAlWgxnw4bSUpI+Zo5B5Cogwl3WlyTU7q95c1Xt02tZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673333; c=relaxed/simple;
	bh=F2J/WOMUIDKt0odwsujIr9y4bdRgOyT0k3wbiJ4PmnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/9hEpJ3ns4T2/BIJbxmrbLtH6c1cC+aXXr1kWPigC3GGijBNA7e/EBYvs/BAIxYJBIEvdPPs29VZEwCpLzMZctWwzDokxXPxdhoWpP6H9LfEs1s7Z/R/MizB79Z/D2DVoMLIuapuxfiZuKX/5ToQcMfsWsrFvIV4gWIDf25uy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iAaTSjso; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fGoB019748
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eO/e+l/CKShPfSEcMaT0/WcOzQwZszBr5+oyAnsYffU=; b=iAaTSjsoQl2M7MbT
	x+OZy9YORdZ1DTrBo7kMyQVQUDWHAsM9D64LbmKYdQb5E2K8f7lUG3B8YTzBeJ8E
	lpAfzaS7TvnFIGSOcco6XSPUaZ7d2lgH1ApIJiuoRmyZt4nC+Ijz/NYNJBEEB9zH
	fncLyDnSSsgYr7ADor3XpDr/6e/EvhXap6SYT4xKNyOu+5XlerV+qHDhy+e8Uoyh
	tpfgmx4cQ+YQyAeKxR//RPBFL7Mv7CWXX7V9bGP8WLgLEfu1hS6FFpfe8Q51QOvN
	BDhhZT8L9vToyfTywV+abR844WnI9Qnr86BslZSgEpTzWEr5lD8hvJjUAhEma0dw
	2Fa9Wg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t387m5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:35:31 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-71f2e7244c7so3368806d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673330; x=1758278130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eO/e+l/CKShPfSEcMaT0/WcOzQwZszBr5+oyAnsYffU=;
        b=QSKOTpZct0jTxsgUdr9EO4L2eL4zg9nSmOaCIl7e5hgobSMO4n34/vvob3AapjpQvs
         H6fS48WAvh+eJiFH3VokaWrKg47tU7efwmvISNQltPBqfHHZpjiIygiBayVwjNz/Ls9X
         6mQgs5RXDdDqNInl8UpiCXRAaPFu6/w0+9brRvG1+PebAkoFu6Xgn/4nRYivpYozSg/m
         TKWj1Htzf1ewWqsftY7c1jHJEJhLvdlXPFJnc2bGsAbiajDkge3IXysUVPfxhEfsIv4N
         Et9BA126IRLuwDJEZQcrGtqmhOwMm69GNJ9vIrlIwIfQOzAgvSBmG7y8A3K30Q/DvE8+
         4fgQ==
X-Gm-Message-State: AOJu0YzZXaSD09isyc1KknXAlLDecDJuajzpmtyI6wccrKjOIrqjSQzN
	utiJqqh5aiaqKE852Bmf+3v9Zn+Y13nbdmPuMksBcC1YirTduB/Y9EMLvYVDlTC+pcrxTydqPof
	Zud1R36Qs5r5y8UYUzneZc/bUlfSlxHzLaoOi90RnbbOCDpDufjq7+Jz+gA2h4zFpj+Y=
X-Gm-Gg: ASbGncu5X+3Uqw0Sz1PeNQ5OTMlykRfefw/HTVSSxyHLB35zElTBX8XMT67iTeLTkSk
	NhlbOeu+vUfCh0R4iKkBDO/R5k9oh4LWLQc0hkHbssgeEf50ttv6PglqNiAdGOJcxNQSETcufHD
	AOqYofBMaSepM1u5vfCxh2hmbC2A5YOqrSaaALwQun/0uqC90bioxrfIZfd2jtRLIJz4I++YZ85
	c8R32MIFqfN/lnR3nwUPPSUgJN1bUuWQdm/Osto/ueAnxm/k1pMLXZvlx6aTksn8OrAWnAkh2/P
	28AyBI710kFoPV/5cAAB1Dtnp23q0Efl6s79drb/hsKJf6VNlFcHbx88UAvsJ8okgVKhWXTwGl3
	cUdkTWq4tnVkwuozWrcX37w==
X-Received: by 2002:ac8:5f8f:0:b0:4b4:907a:f4dc with SMTP id d75a77b69052e-4b77d0663admr18554391cf.8.1757673329614;
        Fri, 12 Sep 2025 03:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfE9aSX5jRYmSD+qAkDx8+iMqyOs0HY4gOzw34wCBSpdGtsMNfwQNLGwNQ2O+3yFtZ66JIKQ==
X-Received: by 2002:ac8:5f8f:0:b0:4b4:907a:f4dc with SMTP id d75a77b69052e-4b77d0663admr18554201cf.8.1757673329103;
        Fri, 12 Sep 2025 03:35:29 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da388sm344070166b.22.2025.09.12.03.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 03:35:28 -0700 (PDT)
Message-ID: <0f8caa5e-7d3e-43cc-9ada-612f5839b407@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 12:35:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sdm845-starqltechn: remove
 (address|size)-cells
To: Dzmitry Sankouski <dsankouski@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250909-starqltechn-correct_max77705_nodes-v2-0-e4174d374074@gmail.com>
 <20250909-starqltechn-correct_max77705_nodes-v2-2-e4174d374074@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250909-starqltechn-correct_max77705_nodes-v2-2-e4174d374074@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: xAp3_E50T6LcEREPGZsKwJPkW53raxJ2
X-Proofpoint-GUID: xAp3_E50T6LcEREPGZsKwJPkW53raxJ2
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c3f773 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=v0bTi9dDIlVGPmSQrtoA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX8IJMguTsb9hV
 2Fq33pRKj9ZQZ0ZsgmTd+TPgbDXPTX1gVovwHFfDnj1Fd0fTkI9jsVVqh25w9OcX6qqDoPZ0pWL
 GMAUH84i32+N6s+rIjE7Z3BHGsFKSPqJDSICdQFSvkCFhrAO6V0qKzlz6b7EckBjmKBC4uwUrJ2
 UE8WNauZO7ko99jzpvobgKTi9G88b57C9l2u2hXbbrKcOdmFqQzPpUqI+yBZrMve9RMBwsDg8CC
 NIKwlWETsnKV/xkVxVF9rnvxAVgxXxV40Fa/DalEVFsTRwxK5x27lo81TNpeK6Rp4A+ZfD9sVVX
 3d9elYB/P441x4lfa1natybWMpvQrMAYJa2Gyrmabhi0SkKBQGa9gD6cSOmQlLmE2DF+psxPqvU
 D9MyU+ME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066

On 9/9/25 9:22 PM, Dzmitry Sankouski wrote:
> Remove address-cells and size-cells because unused.

"""
Drop the unused address/size-cells properties to silence the DT
checker warning:

pmic@66 (maxim,max77705): '#address-cells', '#size-cells' do not
match any of the regexes: '^pinctrl-[0-9]+$'
"""

Konrad

> 
> Fixes: 7a88a931d095 ("arm64: dts: qcom: sdm845-starqltechn: add max77705 PMIC")
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> index 9eeb4b807465..8a1e4c76914c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
> @@ -591,8 +591,6 @@ pmic@66 {
>  		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>  		pinctrl-0 = <&pmic_int_default>;
>  		pinctrl-names = "default";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  
>  		leds {
>  			compatible = "maxim,max77705-rgb";
> 

