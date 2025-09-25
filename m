Return-Path: <linux-kernel+bounces-832298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E50B9ED9A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C694A7AC250
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB8F2F5A33;
	Thu, 25 Sep 2025 11:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UaHLNbYI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445A1D6AA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798124; cv=none; b=b68++34PMxusoO0M5strYG0lQejb89zOTbVWxNvKD4nkw/9Tk1M8Y4Q8r7S2VjuY7epIliFvHkR+qMiiQO6/Cv/9GrCCP6B5fiaIYUDgqR0yhD6DwB2KmyEAv7Z1nw9XmRYuucvmr8JSkcv1U7xEiu/KzbmLYCqgu+dctce3IOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798124; c=relaxed/simple;
	bh=lyqvYkaj60Ar7s+jyDByOfyVX7oJIz27/Tgp2lKRwyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5C+WVkWweJnAf3l8DCKSU+AxrXlACXiVRbaTIQUYVQjmzrvKGYDEZ8C9rD2krYvsoc+//vDmoHIL+kOAO3JSROvG3xqBcNeySt4sjS8eu3lPJKP0Fejc3H1iSLt20fzfC2Ei2QD8xlPL1jjAydImxWulMvUa7Pin0RqnkZfPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UaHLNbYI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9YPcd019923
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uoboDRGVeObKR91G3EO3aEnY8YgnQu8Hx+ipZZBWW9I=; b=UaHLNbYIpjYG/4wn
	quPNAWqtEhVSvsEzGl1GkBOBf6skkFbgERjI7EXKST7okCHpgHtWkNHO+7h8JeGl
	UjG1qAsUIKa0AYHzX3JVeW9Yi4H1YnB00WbyN80qMmn5Q9TnwBOUl2XgjpZRdoGj
	8kLDX8QJLE+sjRFYydm9yr3492/Z/k2hu4GvMFuJ/4i/do3MEA1pFSBbZiYkhb+x
	9or1Vtp1PNpMiQy8TgqJcrAjpXMi3lAzTk98FdooinCUn78/PfR9jFD12Hs1HU4C
	VX6BNedjwID2pk02u7Ds3vjUnLyMsqKQATKIfJ6RGy1ilVmiDB5+Bez/NKOPNi4m
	vYBZQQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe12cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:02:01 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-58ff35db2ffso28803137.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758798120; x=1759402920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uoboDRGVeObKR91G3EO3aEnY8YgnQu8Hx+ipZZBWW9I=;
        b=A88vO+cz0ZY1t0WhVH6zXCHHCzAFQdfTWej5Cr91QkMs/6BBUszhlNl1C7Z3MgT8Es
         vIyuD4Qn9ivge6XaV0npXG9B/IS8aEpWcOrOfvitTSpZCPDT4lEQg4j71AyaBmk+njl+
         ZgTnBs7BXj+7eJewcDjBhyPJ97qHZJgiaNLNZ88Mx5w3gsoxJxHXPf69IcZOW1wKvyes
         xJMT/9nC9mx6PjfTyS1VAAcbmj0iU4e7xjujVgsYPFSZa/a2/vLAfwWBaFEwFHSdYIr4
         dg3J44Cn3sB/8lpP78NbNMxIFcIDYBc/K7JYtIbIioZ7cpjFvdyft/Sp/hBe76q13dTA
         dHPA==
X-Forwarded-Encrypted: i=1; AJvYcCUCqTgR04/BDpb6flXrynw7WLHwqE1WYcSZ36S6L2pXJ3TBTjCWUP/evRNvmU5bnCVlY62kBmMU5jAN7iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpT85OAgRFl5VnizEMoLBlyTVuMkfFY0r4hDygUVOUX09nVQd
	jhT//M1dX+EPdGWY3s02a5mWGL1UuPRYTXlHf5UxXjCiRPb+ouTo5q5LWrq+ul9gN6RcXTLkHHv
	oXGtjz3fXk648VsT12DlTtGoFZ4vodrMO63et8emPQQFaKe12vTnfElim1kxKWvip4J4=
X-Gm-Gg: ASbGncsdIvgz3N0TRd+4kPHeWfxIZfKiU9biCwH4uRyz/zpYF08B+mRnv1r20nSNYIA
	ajm+FTmvHOwx1yNBCx2QfKhZjWuz1b8cW9au+5osex7QSo/JCQzgI/pnqJWfoH4EiakV/YZxhVW
	D5j2cMZAzof3viOTiwg3z6XHxvjaafNX9oBCsXxQ5QgLFW2949uGG8NSS2Bn+DsWSswNjkgTrct
	7aZ2S/Wn7JA9LlUPnK/VaJKtiApSPVkZQoAItYcnrbZMeZ7GEIk4vrx/Bx95kAmdNsOM0CuKWRt
	vZO36w4s+ygnZet6JZouzZuqzF2Z0L9xXClnWdf21WOgTat0Whppo62Wst2bog603LWu8usgmbS
	eyUWavx9Zjfgz/ZfJlXDr1g==
X-Received: by 2002:a05:6122:5206:b0:544:6d56:eef1 with SMTP id 71dfb90a1353d-54bea256d02mr371010e0c.2.1758798120534;
        Thu, 25 Sep 2025 04:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUnV9/bgYJlti2LIjsmZdaGX4KyPswd967D0dRbVBEJzWZibflvSmHCF+zSid3IwWgYek4Lg==
X-Received: by 2002:a05:6122:5206:b0:544:6d56:eef1 with SMTP id 71dfb90a1353d-54bea256d02mr370965e0c.2.1758798119699;
        Thu, 25 Sep 2025 04:01:59 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab31bdesm70750585e9.11.2025.09.25.04.01.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:01:58 -0700 (PDT)
Message-ID: <a49f3f75-c882-4635-9be3-a433b7fe32c8@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:01:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/24] arm64: dts: qcom: glymur-crd: Add RPMH regulator
 rails
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-9-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-9-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: jtjYL7CP2-qo8aRzxJuzgl1k31bXaiFE
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d5212a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=mWQtOVyK00dPacU1zP8A:9
 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: jtjYL7CP2-qo8aRzxJuzgl1k31bXaiFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX/1n+v/D7L90x
 DKW8F53ujayfTx0gBUlws/7Tst0Zazk8x2II4xTvw5YWun/XTpilzjkB/moQaR74BA42ZWw1kbS
 9eTqpduTw2YiFYxdIYDXa58snXvVITeJc8d1LMTFlDy/iIChZ08IC91+Fhus9Z7ItV+LsgjlawH
 vPUOdqHdjtmUkvuG3UWNt8sPOJwSqxBsiyB0S3hUEi+OL0t4XulJ088VrA/iCSp9j5kJ8WLm8g3
 bO53ixZyDKvIM5ysZEoLx69EbQJtNHBVdfS2++RhmWzRpHumhOZLo/5zcru77+bAlyzyxLqy8Up
 TZXvHnDNJ6LEJyJQjm4J/IQ0ZifhKPsFHJvOwKr4Bio1O9iBxKYEhUZRb2q+ZsJLLAhLqpj/JQj
 05nRkC9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> 
> Add RPMH regulator rails for Glymur CRD.
> 
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

[...]

> +	regulators-1 {
> +		compatible = "qcom,pmcx0102-rpmh-regulators";
> +		qcom,pmic-id = "C_E0";
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +
> +		vreg_s1c_e0_0p3: smps1 {
> +			regulator-name = "vreg_s1c_e0_0p3";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_s8c_e0_0p3: smps8 {
> +			regulator-name = "vreg_s8c_e0_0p3";
> +			regulator-min-microvolt = <300000>;
> +			regulator-max-microvolt = <1200000>

Both of these regulators, having no consumers, will be parked to 0.3 V
(the lower bound)

There are other similar cases in this patch

Does the board still boot with all the expected functionality with only
patches 1-9 applied?

Konrad

