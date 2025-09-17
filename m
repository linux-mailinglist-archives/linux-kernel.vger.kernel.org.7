Return-Path: <linux-kernel+bounces-820898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A97B7F982
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65D32B63E29
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6FB337EB4;
	Wed, 17 Sep 2025 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aDE9hsU1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90C732E731
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116877; cv=none; b=bQv3AbCJQvbZw5Kw/2BubqSeQhpFIa/tvNtJnVKeF24qqkPXm2N9oMU/b3CohF7GW8MiStCK94f5k8VrT3vZbw8GTQ5+oUcxnVBK8kgalh5cwBNPZ7F1zaRFgf0PzYCKcHe87i2ZMNSZF5IkRQ2PB8sE/hVo11e+tkB0kFqg0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116877; c=relaxed/simple;
	bh=MzFGOutoYt1u673iCsgwNEzNEgLxa+k0fELIU9WCi8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kj8gZPkJJViCWhk5KfwordbxqmzE4SB3xfEglePSzmjcx6qc06/drIs26SiRp1ZHvUFvNnjU+fPhNvHf+TvsyLy451CxgNF8Xc99bil12Ex4AmvlpJ4iO3kXBQUbZHPQVQtfKzag7CACHlzTQKevOOJq3t7FewFkvVG3w3hgfSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aDE9hsU1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XZlL029494
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CBJZNZje5f65kXA5ABF2fDUbiaHgo6XpvXLG+bxugt8=; b=aDE9hsU1LHnCf+Qj
	HKTResbl2z/fA+L2y38v4NkgTZpytOhE6xsfGrlWet+pk+7sQ8qSc/QDs99mVfR+
	DmJz1AJai6e/FB6sIrB6OcP3VJibGdSnAK7LCsnTY3uqePw9bWBI6kzhZ0y+mNJP
	7AkW6wOGQoohFJmyY96izd2zuhlH5yX0f/Isp5i1IM4TcK+Ky1NX4JWsQACbSL+C
	hfCPUcFkM7SLpdeBU+jc7yglojOyX8NWXis1/3ZWmWpsjb4iVIkIznCGUPIFpQor
	odJyvAHCe47sCzU1DtaDXFcyTOKy+YzDo/YtkLxCeFcJ8oeBGoWGSXQQMcUBkWPb
	4RaRHw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0tjcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:47:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471740236dso976102a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116874; x=1758721674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBJZNZje5f65kXA5ABF2fDUbiaHgo6XpvXLG+bxugt8=;
        b=ANuso+lal6Hh3sqsTYvPMAzMInY/909YRvqDn6HmoZYOx4ffIDtUOo1N93DuOJ6vv2
         956ex43JCJseDmxrYzjOq6ebpVFHF+Iyfx6MfTnPCG1WIRUd3Ptqrj0vS7rx5WVvSKCn
         Iwsf1MG5heP7q6eKW3cv1ud0NkyABCgGIYgneepi8lqKUf++SFUEiM3Y7n3umWxgjAdV
         2ZasTzgR0uVUv20dqLds+JGQ+XDm2UL6458G4ylvWcSsS57d8i/AtT5YyxUS0kKgXLWL
         1A23ITIsj3JzscjWFzOMbx5cHLCnQSXLMAxU9vgIO0tvUbiV8Ove0bwAaFK91O4PV3Ea
         KoRw==
X-Forwarded-Encrypted: i=1; AJvYcCWeQVn8aNunQB8apwRMWdv78Hr1YvMK4Si24+pmZk1JncgW5jA9F4DhpguSaE7gZ7KbIctLsN88+ss5UCk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzycx8JN41Q1cLbO8k6FtUFTockF+RCnISz2LgEj8TvjqHbrkLP
	CuGjDBcfPYXrJcFhw1HpASwCs05naPopr63e8F00l7+x+Yan3/4KnwLwiVOUFH5XK+/rg4KlYne
	dNv6YIbk26JRDHfhFr372VVsuIGnExZISNw0/zs1k2d7ETu1ALfLJpK9N5VG0vokf/aw=
X-Gm-Gg: ASbGnctd9gRTfc5hi3Aiq7H0c5VZRS3lqcxayZ8TRuAZmt8hQaZ7YChDlu3N1EkFLjU
	2NxqWb08ysBzTS6D4ro6fjyA+OdD3YfJTGnPRKi1PM85zdYuY6Rl7aFjnM4nUJNGyV8nbWeRPmh
	0n+ctK7I1GVdka5W7Njw3JLStb/kYcoMsYRjtb3YLx8f56JiWNkRoLKWv1vuLPAhhCRMI6l8xYn
	ag4c+GU0Jqc76F+cI209PInBwUKVT1mfOCZlilg4eEvu+pcvnERaaQJwPJd8qZo6gjlD7VfOSAg
	DSDWQTe8q3ptzQUTYoc+b0lLqtqw0rqWXpE5gn68llM2CyNiXoS3h6Qh/iv6NJrnvy0kqqSS/8N
	8gIfBo3THgG5xQadjgfTeQQ==
X-Received: by 2002:a17:903:1cb:b0:267:af07:652f with SMTP id d9443c01a7336-26813f04a6fmr16160675ad.10.1758116873966;
        Wed, 17 Sep 2025 06:47:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVnj3jvNMYZm/R8iewoXkP2B8yyk/dgGljWHpmy5iEGR0yjloOTBnAcCN3Wa0WQTQ9wgm0VA==
X-Received: by 2002:a17:903:1cb:b0:267:af07:652f with SMTP id d9443c01a7336-26813f04a6fmr16160345ad.10.1758116873372;
        Wed, 17 Sep 2025 06:47:53 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26978675b49sm639595ad.29.2025.09.17.06.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:47:53 -0700 (PDT)
Message-ID: <772be3c8-751b-4f96-8ed1-fc8033babe74@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:47:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] arm64: dts: qcom: sdm845-lg-judyln: Add battery
 and charger
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-3-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-3-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4rTZSFl5qBEam4nniJGMR1DTLH9OfhUC
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cabc0b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=kjk3cvycGUJv83FPpe4A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 4rTZSFl5qBEam4nniJGMR1DTLH9OfhUC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7uieOLxGs7Si
 cKINBBRnCpCDBmze4j1isxsJfVQJfOu3RLeNFu/6SN49vgsHUE/T6YksZv5/TmGzDq7oiUanZwh
 Mikda72+V93+CTVTURcRtrHmMMIe6NuC7f3M+SKLxl+Wk2tQgfQWwc/8/JkH+EQIVbuEBjDVvLX
 3p3XGSKzdfCe6Zs1UoB5s6A+NSxcPWyN8diCZN7dH+7bgUJOMnwP34n3j3dOPu3sQmPnbs6ZSFk
 rWf1ADu0pgDP+FClzZ3aAOmcNVjJcnKTzY/nobOIeGYCzKw5B2YqxWPltHR/I2fq0PYQdgHWmVW
 LMKnn2HZsIoSx4YKD+0huFsiBnA/7ttxL9u641x0XdszVFwd9A8e8kujkE9H+01QR8LGrBQw86M
 MbmY/R/H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 3:09 AM, Paul Sajna wrote:
> From: Christopher Brown <crispybrown@gmail.com>
> 
> Values based on lineageos kernel

A link for reference would be nice to see

> 
> Signed-off-by: Christopher Brown <crispybrown@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> index 49225e4fa80e5f45a36964d5d733dc238e4413f8..be488891d0ab01c5bfd3762514fbf1c3bbf6845a 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> @@ -37,6 +37,14 @@ key-thinq {
>  			interrupts = <89 IRQ_TYPE_LEVEL_LOW>;
>  		};
>  	};
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +
> +		charge-full-design-microamp-hours = <3000000>;
> +		voltage-min-design-microvolt = <3200000>;

3.2 is rather low.. are you sure?

Konrad

