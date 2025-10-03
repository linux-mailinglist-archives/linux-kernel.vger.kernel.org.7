Return-Path: <linux-kernel+bounces-841771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5FCBB833B
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F9464ECC91
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8062C0323;
	Fri,  3 Oct 2025 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Csy55Eek"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023429B8D0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527117; cv=none; b=RhPTRJxgHra1O3Feuu5pNp2rdrM6+W5ffylH/0kBl5UGOnez/bpK1d7JZvftXj9UfexgP0+Eq9FfqBAt486SqaYZ8i3UjiFK4OJcqhW2289otxVRkHSRirJZi8aCd4HuZYbB1kTRPbOkr3K7RuimysriUCJmIhhSx/Il9bx1/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527117; c=relaxed/simple;
	bh=wm9ZU493L7nyZfSKRNprptA6DzCCwoVPpIC7wpQR9KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPb2lc8mQ3A+VouCA7JDxV2OXh3XLwQWVbxZlggFz26WWseawE8HAzQzdH+M3SXV2eiq4kwfaXcPl5RPP9L2Ac6Pw11uuXwww3WZ0fFoXm/qmZTWOFQ+X924g8LxMXM/nEtnIv68JBfEd8cZJ4bSIspDWnHkUOKiLwc0LSZRxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Csy55Eek; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5939W7C8004869
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 21:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=oaNyogpft37KQqjCqwX1Jc8A
	KV+C13HugtmRlZYmt2M=; b=Csy55EekRWLAgtg/vag9/RrMegNMhD65SN7kfmSQ
	TEyTyl4lyOcak/TOB2Qy8ezSOlmb0TnWl15RXKy8gDaDx3Yv6lkMajRu5N9oTPCL
	7pm9VZnTjSb1QBY3GrHEkgyjVWdwOL1sTwHYYOT5GJ3A65MejLpebIa6yBFhQkxO
	3x3n53HgbHDYo6lwo4B4EirAahH3lkXthVIsQw5nmrTHv4QSrpkGKmbQsVB0v3Gb
	mAIovm+ZA+oGGD6vNixLjhtDvatlQLZkO+hEXTkxNZ+EpIAwG8Ta1ystdYY/miyl
	AtsyIYN6Z9IkXAqdlsEr1NyruSqS2TjroaBkDmINuidNAA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fyrfdhde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 21:31:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e1015c48c8so71727881cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 14:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759527114; x=1760131914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaNyogpft37KQqjCqwX1Jc8AKV+C13HugtmRlZYmt2M=;
        b=c8omXsAWxinWSgNz5pU+HqvMriAomtdlhrqIXwbcXrxRGcKNDhemi+F/oNJX8FO8Ib
         cKQLsfv28/vdQiAWJNJw1ZPYpRW7cr452DY+zPS7QCLRGHjLKaIZzxwozjPgWlzgTh+i
         aU+Co2PCQSFjgi3Uwcy75ZbEZS+jHR9mmtURDMM1HarkjQC3J44Tdqr1PBBPPw9a8JKM
         n+EywbhMSUTqN51LuPvXfiPqUG8L6hrN1X3R2HAXAHYKSrTM/Au3qXh0Ajwomvxfd9ux
         y2NeTtpeOYjZxmoKPrbEOB3H0QMXyObIMDtC3NtfAQOlDFu69XRAZ6k9eQkZeyXOvRaW
         1uFw==
X-Forwarded-Encrypted: i=1; AJvYcCWTZBeAXTM4yA6hUyI7Kk6FlXlgNsnUFQNPc6qyABKEbijYbuG4vO45Vx2qCBrtVZEM9Ytvj+OeZTloeCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFSc3tbUIvX3K2QDW+SuyAH+uaLQjb8KfZDpEA2qg0RthbwU5
	UtWIUe4FIUHGgfkIWeL44NcoIE3RAS5KZw+Gpkqg5y9Y3RhE7QIrvXDzyQAXg9zn6AyoWDqx0N5
	t94kSTBoR9JwwN4qyrbPrdKT+Cx7J4npqg3F/SOc6yGVPK69isZarGMDsZmcOac6Gq7U=
X-Gm-Gg: ASbGncsEgB1ig/ZQTODsQXpEur/NpRJbrvmFv0lZE0HekIHlLQV6Ch413s2IfSMIQvb
	4I7ITPXsNZ96hK/8rCRtYpnE8a0cihUnAkBFjMa/vuNtH8q1ZCr4hGXcbbZYZ+6bat1WC4hKG0d
	fFkm33DOAX0A2rGvnZtXlqJzu7/R0mwoSYPEMue1oiCkE5K5KZTrpVRp/Hy9ChHukSeIc7j4jfE
	JXeaoUGHpMFjL2maz23pg0rO8MTjIsWaoVPxtsR6+DSM9B76kIY3BZ5Vhp8W2QndUwNW6yMpQJ8
	7KjDyvIPq+NRGWuuNJMprs6a3p857ikJ8xXI6UiDMsdW1w3UxBPmOTfIJ2fom4kmix4Ty8X63Sx
	7tV7LmyIDdLYXDeroi/WxshxMaA75Etx94AQKtIy4EANxLsOnXvqnnsYbgQ==
X-Received: by 2002:ac8:7f89:0:b0:4b7:a1b6:cf29 with SMTP id d75a77b69052e-4e563c5e765mr134806771cf.41.1759527113954;
        Fri, 03 Oct 2025 14:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8uln0Wko2wLLU40Gc9Vh/f3dVBHUalTsis+iK+YSQPZfzQaGN1q6miGwZWTtBH0BVOLKuFQ==
X-Received: by 2002:ac8:7f89:0:b0:4b7:a1b6:cf29 with SMTP id d75a77b69052e-4e563c5e765mr134806201cf.41.1759527113281;
        Fri, 03 Oct 2025 14:31:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b01124b4dsm2186492e87.13.2025.10.03.14.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 14:31:51 -0700 (PDT)
Date: Sat, 4 Oct 2025 00:31:48 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Paul Sajna <sajattack@postmarketos.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
Subject: Re: [PATCH v3 03/11] arm64: dts: qcom: sdm845-lg-judyln: Add battery
 and charger
Message-ID: <fsqrhnuqmckxldsjejmdszlcfineaglt57g3vgm7fxwz2y45pw@avd5pf5beo7r>
References: <20250928-judyln-dts-v3-0-b14cf9e9a928@postmarketos.org>
 <20250928-judyln-dts-v3-3-b14cf9e9a928@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928-judyln-dts-v3-3-b14cf9e9a928@postmarketos.org>
X-Proofpoint-ORIG-GUID: CUTcV1Fq7C9h_XrtZmsJhuIEys-FKUcg
X-Proofpoint-GUID: CUTcV1Fq7C9h_XrtZmsJhuIEys-FKUcg
X-Authority-Analysis: v=2.4 cv=etzSD4pX c=1 sm=1 tr=0 ts=68e040ca cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=Gbw9aFdXAAAA:8
 a=PAAiZjNMvmahcd2zdhMA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDE3NSBTYWx0ZWRfX+WQMnYd2rvkH
 m1NGGTs1cdtplcoUNYFnci1ZslZg2omUBHY10IVo+8noKDqG3scJSV80Ill91qCT0bD9B2tI0xn
 m1dtkd1B4L99EAHYwT/5ufX2Y3iJ7BaXeVMn/rX3sLKNcdVIfqGgfuPzMJSFZ1ERNRskpoROEm9
 geIhYMCrumDwHdCqmJ8ym+oFU+bgnJdsoYkKuJPBoSmsnxDfGGne5qVHkmiFNo7bqhsWNrmWSt3
 ZO9BBtmkV42+haFkrGwTNGgEzhk3IxoXRZzH7WnXoSBqcDttvlUJIXf+RQkSWKApW2Gz5zey0DO
 0o6zL3FPpee9DkjD5b3wdty690ItKAg1zllAbMdYTwRNT6FM9DP+CxYS3qF9/R6DCLqQcQFmKZp
 drIRngn4bhh6cenCzUf1PN/3c0jcEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509290175

On Sun, Sep 28, 2025 at 10:05:26PM -0700, Paul Sajna wrote:
> From: Christopher Brown <crispybrown@gmail.com>
> 
> Values based on lineageos kernel
> 
> https://github.com/LineageOS/android_kernel_lge_sdm845/blob/lineage-22.2/arch/arm64/boot/dts/lge/sdm845-battery/LGE_BLT39_LGC_3000mAh.dtsi
> 
> Signed-off-by: Christopher Brown <crispybrown@gmail.com>
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> index f91578ce7195dc3bfd1ba0a722fb48f950816246..df65b0e32b195d2f668883542cfcabbb9bde8204 100644
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
> +		voltage-max-design-microvolt = <4400000>;
> +	};
>  };
>  
>  &adsp_pas {
> @@ -57,6 +65,11 @@ &mss_pil {
>  	firmware-name = "qcom/sdm845/judyln/mba.mbn", "qcom/sdm845/judyln/modem.mbn";
>  };
>  
> +&pmi8998_charger {
> +	status = "okay";
> +	monitored-battery = <&battery>;

Could you please move status after all other properties and insert an
empty line before it?

> +};
> +
>  &tlmm {
>  	thinq_key_default: thinq-key-default-state {
>  		pins = "gpio89";
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

