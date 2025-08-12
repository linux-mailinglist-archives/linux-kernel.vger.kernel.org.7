Return-Path: <linux-kernel+bounces-764311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A92B2B2218A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D409B72108D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6DF2E2DE7;
	Tue, 12 Aug 2025 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SgNbkgDq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585E2E3385
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987501; cv=none; b=TJOSgQH/c44svEHdi5jINJpoYucFFOXJKZn9A1ikRfCKXECPRL8eIp6LHKQ/CxFKGOyuPX7B+m1C7QrKjc5t7p9Ypz3RQUIaQAhH8Ag2kMCGmYwsGAKa5YHxzaKS+AW2vjX6sJ53Q7Jy52U05bve2WD5r6YSx2XslgFnp1GSQec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987501; c=relaxed/simple;
	bh=3FmUf3Hp30CS50cj34xwa1ruTjcKGUB3eCltwPgVm10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=su6yFpOOgntPHCCCWH+fLtgXU6OmIMuynUNLqgMs0ClekRxnqxXI6J116JjNjabSblNord7tk/3Fk8zSrF4pwhFw2FrMGvr2D2j+/GsnZ/R5DtH0cd9w0rBWEXF4+OzguXZW5RYjGd+TMJJqG6C1QX8LFeXhI8LZgAirOWSBI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SgNbkgDq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5nQlf024316
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GWWmZRGTBwubXompLpnOIPrbDAFgCGljYAqe2x5V7LM=; b=SgNbkgDqi7XDEWln
	RZr9DtJhRQpkMIQ5zjVNGLh+FVDF90W6U5RfWZPcG3/dBZuXr+V1Xevvyl5WYipg
	e6hc171zifFPw7sZ86EXhisHppXmm3jLNdFct3Mdi+jdT6w/1rpmJzh8uI2Emd5E
	xacGeF/n4bxZdd337sULWgy9EWhsygD7qe1CAzKB+K4HDU3HGDtufNjSOQPIPfA2
	8bMeRSz64+zHIsnnGwgU/rGdCQM1cnqdxlADMSFoFZPouj6JReE2LR7/MCIrf9P3
	mMigss7rehYm6kdb/kN9LbdhBJ/aG6EnycSBoVQhEqWFOZZe5DtKvXz2byxGD18K
	i/nEvg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4bdkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:31:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bcfe2a8a4so5340693b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987498; x=1755592298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWWmZRGTBwubXompLpnOIPrbDAFgCGljYAqe2x5V7LM=;
        b=YS+01S04sZtx+hjV1g7Yc4NDTFZIAGpH1N0BK0a4k4IM4ZznPTcrIymqCA6+BmArp2
         zMBvW4HlZFFubddLen62yyhjJXg0IWrP/GzZOkFWLXk8VUPSxrLIuE0ad+VjMElrAkSd
         sANLPEFWfINzwHqOgkW+nlqSKFkl5zuY4/5YTMDNT6InyX9nzSxEDZo/rzBcHot7sMcV
         AJf01l1YIV3MrCisxqrJObQecG4Z7++hWqy77yvwrOESoggho5yFs3sOmbrdybhFf0Sf
         ISSxRJyx8pb4SEvsIZzZn2afzmNAquLYp2k3u0EZPaYh37do+iQHmhP3EN2nLWd7HQr/
         Z3Fg==
X-Forwarded-Encrypted: i=1; AJvYcCV7r4mVbHvHgr8enIZNJSj+MwC9YvjApLy081r7ik84pPY3Z+Lq44k+q9Oe9SEgJ35/4MJWE39U65MwXxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsVZHHAQaK+MhKB+2NnOrNsnavsIYnKG+pvk2zSBTX8SZbtzGg
	TVVN8wlLfynTPhx/jEW+SCC0c9ILkwR9uheeOfZN9rYRTLPSk+6jm17M4MeCu5WY7U+v8WUcLHT
	TL5SiIM219YDYenSyGkJhpldt5emmik5tyti146CvBcptNCZkMc8xNHfzj2dnGhHQLjU=
X-Gm-Gg: ASbGncuJq8eEoH3sJhqCaMrlvtbqj+c1qo9XMFoYM1mw3enn5gvqwoq9sbnO4NKu4rd
	UcqVK7NGyvq/wY50cXyTJDFq51votVPfkAKBbHVf3jT1AYP+YcWPScGyfnPcALTpjihPYBTGa7i
	6a/BbwHTds+LLIkWqYAwvyT23Du9T+Y6qZZh64Ets+JlHwGgh6xR3Dp4Qg+I8pWCSGIlWe9dGWv
	OC2kwh83XIb0FMjwazVBVSMzCKnPM1rr9P52tWnbJd2ormitg4V5LVzSbCILEK2Drtpm2GMuB32
	yWq07l1IBWkWDtZyUmgMnjBidCFIfI1VLlnbruZyb/S1tOQKnlGnjsAnj3SLmOsVJBzHEghOdbT
	sfdjBHil+zMrKHdI8XYwswFNlKuTB
X-Received: by 2002:a05:6a00:b86:b0:76b:f318:2d41 with SMTP id d2e1a72fcca58-76e0de53d0bmr3499995b3a.7.1754987497666;
        Tue, 12 Aug 2025 01:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMlyo0ZIuqdKYZz9q+kCc6x7EFMtEPl2fYK55x280gUgeOGPCcKX8cqv6uh3bg01xS6rsZvQ==
X-Received: by 2002:a05:6a00:b86:b0:76b:f318:2d41 with SMTP id d2e1a72fcca58-76e0de53d0bmr3499949b3a.7.1754987497144;
        Tue, 12 Aug 2025 01:31:37 -0700 (PDT)
Received: from [10.133.33.66] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm28833238b3a.18.2025.08.12.01.31.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:31:36 -0700 (PDT)
Message-ID: <e9c9005f-dab3-4bed-999d-9a7563f5f2cd@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 16:31:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
        mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
        bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
        kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
 <20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com>
Content-Language: en-US
From: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
In-Reply-To: <20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qk4O7nm3cvzbxVMswVA_YV8x9Ge2_zkD
X-Proofpoint-ORIG-GUID: qk4O7nm3cvzbxVMswVA_YV8x9Ge2_zkD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX0PnuorGy3vpt
 EGuFx4V30DfMyDWjKPUIW8MTtY1VP3f8F9ncES8CocdNj6Cjpg//T4mW1Oe8m+y3pLFFxdtDe2G
 VzBNa8liaYFKQ82QeWL/YyOpr2ltkgRjkMR8pR6GKwGPnpGM+E509IVrBTdRaoyH1CWk8FERPjw
 dulImHLmyGtibUO1wJwRZhtAGLHe1+/Vy0kPHeRj2xHZkMkjqSqXKHt69QuGFNOUNvXgI3glwUm
 hndvLRSOz1C3PcYmcDyoQjxrh/nLD69TNKL+wNlWIhpbbyNERf+vdEWqFG3VxC5gUcNrcy50Lo8
 VzfrlldMZhfD9Ua/pvzy/GJPScHRfeV7ayWwLoYrnG9g/Mg6bVhxoCe4/rGXSArbEZBehkWi0IB
 qP0ku+nQ
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689afbeb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=FKzoDJ5KnSRyQqape44A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068


On 7/25/2025 6:22 PM, Ziyue Zhang wrote:
> The gcc_aux_clk is required by the PCIe controller but not by the PCIe
> PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
> be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
> gcc_phy_aux_clk.
>
> Fixes: fd2d4e4c1986 ("dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> index a1ae8c7988c8..b6f140bf5b3b 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
> @@ -176,6 +176,8 @@ allOf:
>           compatible:
>             contains:
>               enum:
> +              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> +              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>                 - qcom,sc8280xp-qmp-gen3x1-pcie-phy
>                 - qcom,sc8280xp-qmp-gen3x2-pcie-phy
>                 - qcom,sc8280xp-qmp-gen3x4-pcie-phy
> @@ -197,8 +199,6 @@ allOf:
>             contains:
>               enum:
>                 - qcom,qcs8300-qmp-gen4x2-pcie-phy
> -              - qcom,sa8775p-qmp-gen4x2-pcie-phy
> -              - qcom,sa8775p-qmp-gen4x4-pcie-phy
>       then:
>         properties:
>           clocks:
Hi Maintainers,

It seems the patche get reviewed tag for a long time, can you give this

series further comment or help me to merge them ?
Thanks very much.

BRs
Ziyue

