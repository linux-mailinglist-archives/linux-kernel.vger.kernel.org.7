Return-Path: <linux-kernel+bounces-878123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D39BC1FD65
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1F7D4EADC2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA190319617;
	Thu, 30 Oct 2025 11:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Uq3eLJh9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hM0sMtCY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7B82F1FC7
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823950; cv=none; b=YFzh4br3AVOvEVpsFsvx4AKy2TPFyq/oQLlQP46DT1yP6siS9wydYRZyIpxJEh995ZhbiqSPret10tLTUgB19byoT1cfxCbClRdDSKNYR9bITtw4Cv5LI1Xwt+rIj+mPTVPCLqYzxrWb1GMvFJuCqpnGsubsAuKyqk5OWrMCj+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823950; c=relaxed/simple;
	bh=lf2SZXPHOeNKfnR+2AGHeP0WDmv17afwkbv4+3+gA8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccmXC8Vxyj7dSWHFalzaf2GuAGQ/FVcCTXstrmcj9/FzPBubGzkaS0ZHKpg0En9VRXHmGQdu9J8FaoO3KF2sSm3LpMG78NpMPmWPbVZVISFT3iuJHo2+LY9hKZb87RmVGEmdtzrIicQMlyJ9gxcK05dlufhcyU/DhomNArUs/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Uq3eLJh9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hM0sMtCY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7VGoP1655983
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YNULkZggaBVWafuH6G2UI48mTzyPJboSv12GQ652rF4=; b=Uq3eLJh9ra6dJgB8
	dG4OIxQmZZlTKSlBq7XkdfbuzNTwrhA25TyyDfC7sI8w1uhUHyun2tCTk/GjmB9h
	O0Cjn+MJVOt7uLg+BxoZz4i+QTanLGrQpRFfqoY5QUkXYemjF91rz3qoDtXzkEjk
	VPvSdW8YEz4mbibu9xHJU01kgQeZL6FVUPAgjUGaJc2gQAZsQRxFkpG9XNDaZ8Vf
	RKHQgs+Fk8tFSJQ9BjZe3vWVTCu6/fLcruYAAy0hFLGRW9ljbBIl4B3VeAfbHz0/
	tJhCUNqm9vATl1exoKHMrl4uhikFRhm72BL5Rtbd4uF4XaCRhixgoAbYMOmWcsP1
	ltPTMA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tptt5f5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:32:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e890deecf6so1490521cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761823947; x=1762428747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNULkZggaBVWafuH6G2UI48mTzyPJboSv12GQ652rF4=;
        b=hM0sMtCYU5Socks/0tRuc+nLVvw6HdQzA/whBhvx52+SAGz0DHSNsEryVrWsJ26ZXB
         y53W7uQVxupPGKT5G0Na23huBETkaZiA99aHZIUR9YwSfdw8tTvobkICUcZVCBFb0JZt
         WFciYXF5rH9XL+Pz5ruYNh211tHzjDCfSOjpictwnB+NEEoIc4Q5Ei+3ucS5YD5TJbom
         +ArkxZGT768mwO8lQyfz0lXPp2O/HIJQkAQyoZnTW+ATEY3RDNmsdmRpyZTE05R4eOPu
         9Iq7pbPGf7VQYt8TGfjDMnieU0BMkPIfKhreugRdvTVdHNz19RuL80MHjP/TaivUb7XJ
         pqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823947; x=1762428747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNULkZggaBVWafuH6G2UI48mTzyPJboSv12GQ652rF4=;
        b=WYNixBMOPL7G0/K3FnCtQArDOs8Vuau4sgjqLum3ooqmPdBZmCKLPOyBuER2An9HgH
         H1k7pmZ041B1pquPJbQNia9komWWgr4kAJv11M/V4RlUGZNt90omyj64HTSxJHxvrjB8
         xskmuJVr+ehtkELjhV6eeISdnJLO3uuz9ysHaxJwM8LFW9wnom0RrjnjvLk/GzgWJXux
         PiWWQ1vSDJRmFPFIUYYx3RmctHBW9CTOrqVyCwbyiS9Q7koOBn/Gw/Gkf91LP0Av11gt
         7nzrqCt+E8MplLM4nfT+rzLCavnKK/X+/x5srn82MNS0oDaxXDO78YtVFKebSz8m+n7D
         o5mw==
X-Forwarded-Encrypted: i=1; AJvYcCXnXUDRGBhJG7a/quDv8K9dFi/8jGAuKS2taz1ds8SUQCUvpg3isqZUcfVgqfUhBR+hhw6lc6hHVmLaHzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxffc8v5ECnIW2E2A68+EyDZ4nc0pwo1R5Zyks2hiQH+9kVtwcw
	BdoHfWleKRnwXQjZF4cMRaqBFIhSXB1J1hTojhfGibkqnX35YHgDwjdVMrG7s1TX3TGf2l1iSvn
	0pu5Lc7jvjEH4D2TcdfYbf3kp4CmViQ5cB03hxsTD3Vle2kOiShhGG4YEaNQHbrTVYZk=
X-Gm-Gg: ASbGncuShNS3BpWwl8LtL/rgN43Vh1nvroeLr/i6DMqeEEWnsab5nTod2673ffP0DLY
	zU+InYD4JqaBwYiB2NfJlJJfrb6RVz4YveUEX3t3h25PFGXFWJlHFiJM2SSSl/MPRZMPWdMHPqh
	Obzkn9a+j9QxP6IBJyt7HX9URWf6ZgKav7g0bbVOJUA8+DvBqo55F54xDWZospfJLZM3ujuMdge
	tY7SLLqE5qUXRDCLJjArvIq8rpjHy9+TIQHQM1liHNnWAl+YBWHXKCZJzWuX1mxaw3SNj8ty/ZO
	j+stLf7khK61EqwhNaDqS0DDpvhhHaiG708l3QieiKrbZHy70henyAq2THNdNNiu/BSfAnzOYm/
	cAeOE5e2xeQyje0aJ6ZzbhrOykAswX7jP+FsZsVwH0MWaH07uganKGFjI
X-Received: by 2002:a05:622a:93:b0:4eb:7dac:7b8d with SMTP id d75a77b69052e-4ed15b96605mr50153101cf.6.1761823946368;
        Thu, 30 Oct 2025 04:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGllTvEh/j7ZHlMm91hXr1OxceGb0VIuQkkd1NhOxJeediP+Nlwluw0PKrGl2uJiszadcidLA==
X-Received: by 2002:a05:622a:93:b0:4eb:7dac:7b8d with SMTP id d75a77b69052e-4ed15b96605mr50152721cf.6.1761823945826;
        Thu, 30 Oct 2025 04:32:25 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef6be28sm14649254a12.2.2025.10.30.04.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:32:25 -0700 (PDT)
Message-ID: <8d32460d-894b-472a-a262-4c6a60fbcef1@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 12:32:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: Add support for Pixel 3 and
 Pixel 3 XL
To: david@ixit.cz, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: phodina@protonmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
        Casey Connolly <casey@connolly.tech>,
        Joel Selvaraj <foss@joelselvaraj.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, Vinod Koul <vkoul@kernel.org>
References: <20251030-pixel-3-v2-0-8caddbe072c9@ixit.cz>
 <20251030-pixel-3-v2-2-8caddbe072c9@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251030-pixel-3-v2-2-8caddbe072c9@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA5NCBTYWx0ZWRfX+dXtlY/51BBO
 w9686J5yxYYXJm8xl10ccm0J60rkRRNAgTLfDHYr4IAR2SbST02hHAxU+4Z5BvuBfWfLOwNOXQK
 onBL/oILvSx6N01yy4QuN2DhSDryAmlL+LOkwN0Wo5UqaUUZpK2rACBXnk1n2EjeC8jkMRrtZuM
 uLtQ8AfM9oHc3qvhmnWsePtozUpU8o5KsbGSdCl4y9OoTwfMxdSG6zHZ63kDhaxfSXSK3gqadzS
 iwGjbPvj5Nd8wg3mZtDBWZ0U2Uds9D7/c0s6bHFpEQSE56ib/owavgrrpSxG7hrkbAauGuu746x
 RgsmADeyKEFySUd+VNY7J3hTTCFov2/WYUL39hm0TRm66qbo+yUgIruUlYysG8pMFGU4fy36qaT
 ChAxiQAUvcPfwykZnfyuGOdwO9760g==
X-Proofpoint-GUID: sAMm_uMY30eA48IW8Kqsdmzz6jqKLk_H
X-Authority-Analysis: v=2.4 cv=MuRfKmae c=1 sm=1 tr=0 ts=69034ccb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=aBSXULQCl1RkmNN2VsYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: sAMm_uMY30eA48IW8Kqsdmzz6jqKLk_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300094

On 10/30/25 8:24 AM, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> This adds initial device tree support for the following phones:
> 
>  - Google Pixel 3 (blueline)
>  - Google Pixel 3 XL (crosshatch)

[...]

> +#include <dt-bindings/arm/qcom,ids.h>
> +#include <dt-bindings/dma/qcom-gpi.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "sdm845.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
> +
> +/delete-node/ &mpss_region;
> +/delete-node/ &venus_mem;
> +/delete-node/ &cdsp_mem;
> +/delete-node/ &mba_region;
> +/delete-node/ &slpi_mem;
> +/delete-node/ &spss_mem;
> +/delete-node/ &rmtfs_mem;
> +
> +/ {
> +	chassis-type = "handset";
> +	qcom,board-id = <0x00021505 0>;
> +	qcom,msm-id = <QCOM_ID_SDM845 0x20001>;
> +
> +	aliases {
> +		serial0 = &uart9;
> +		serial1 = &uart6;
> +	};
> +
> +	battery: battery {
> +		compatible = "simple-battery";
> +
> +		status = "disabled";

You added support for both non-proto boards based on this platform,
there is no usecase for you to disable the battery, remove this line

[...]

> +	reserved-memory {
> +		cont_splash_mem: splash@9d400000 {
> +			/* size to be updated by actual board */
> +			reg = <0x0 0x9d400000 0x0>;

Don't define it here then

Normally the bootloader allocates a bigger buffer here BTW
(although it shooould be reclaimable without issues)

> +			no-map;
> +
> +			status = "disabled";

ditto

[...]

> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		label = "Volume keys";
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&volume_up_gpio>;

property-n
property-names

in this order, please

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;

Could you add a comment (like in x1-crd.dtsi) mentioning what these
pins correspond to? Usually it's a fingerprint scanner or things like
that

> +
> +	touchscreen_reset: ts-reset-state {
> +		pins = "gpio99";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +
> +	touchscreen_pins: ts-pins-gpio-state {
> +		pins = "gpio125";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	touchscreen_i2c_pins: qup-i2c2-gpio-state {
> +		pins = "gpio27", "gpio28";
> +		function = "gpio";
> +
> +		drive-strength = <2>;

stray \n above

> +		bias-disable;
> +	};
> +};
> +
> +&uart6 {
> +	pinctrl-0 = <&qup_uart6_4pin>;
> +
> +	status = "okay";
> +	bluetooth {

Please add a \n above, to separate the properties from subnodes

[...]

> +&mdss {
> +	/* until the panel is prepared */
> +	status = "disabled";
> +};

Is it not the same as on the little boy, except the resolution?
(don't know, just asking)

Konrad

