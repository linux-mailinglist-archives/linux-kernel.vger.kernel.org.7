Return-Path: <linux-kernel+bounces-764565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49570B22494
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8DA3B4949
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073302EBB87;
	Tue, 12 Aug 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C+p1DqYm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C092E92A8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994441; cv=none; b=pWMnI/jtcSo57oXZt/iP0hfBXA5geE4/rAoO0Pl+TmbvuxySm+ZrDQiH+HOAmDU6E20mhRy6jN6UWfEfoHgP4y3FhvT40uWaNFcUWYgBWlnNhSX5JyvkjDoFp4Qni1C2CZpiYxho3t8SWw5GMHUWe/oIDdwGvFXncp4dnuTFfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994441; c=relaxed/simple;
	bh=p6XJ2Ia1ZWj9X46ugQeYG4h7CM0YCYpi+GVyAiwcBag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHfynb6BwND+Egpm1VrG3l+COtS88Ikr3+lplvRsmdDduHpwbSzG/IYfkOoflZ2o8oqRBugIUmZfD5FpnItruigmZBqVHJTnqj+W1WbjmjqosWoMgTvvPTJuXX3IQVnk8VCGLdzCLuECk9Y7+DD3ZkPjPfS9AllNr5BvDEvzy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C+p1DqYm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C7VjTR007595
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C9vCp9m+qHfHd3sxSOOc74EeHEbwHcJ/Vc8rKeqTxWw=; b=C+p1DqYmbrJU/Coh
	bokhX1Hwqe+djWwDbWYX16FTHV52bz+TPAG1ISJJx9RagMCEfE6NwyQ4whxAvhbM
	p1wwopY6ag5xi8uvABmqHSLWe/eRltRVQnOKvrrjwyt8uaExrI4PPLzCLckYv2M0
	WU3fAZ38r9xeDgp6WhiCTML9ypUd7a5oXxDRy3C+cMGM30kyrgR2fl3PKtEojDrq
	kqdFOYrt/cKIex/DgTFQMGnUMCGTlIlQmt6NGAeC/fhmYwRicYRQJD5H03IOHW0b
	ubCflHD5qMRRSG2HVgJjBvlhy7TAH29DKKZ72BVkQwHBkRpzYMuLVUtlAFPp06E3
	wNQnog==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6kkjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:27:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b07ae72350so13623681cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 03:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754994438; x=1755599238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9vCp9m+qHfHd3sxSOOc74EeHEbwHcJ/Vc8rKeqTxWw=;
        b=DsCjgEPOPdTysYpHZ3s6p6pfDlu51RpqL/IcHQCBQd1ZnFks5NT3guyDnjv7twxkGj
         X8jngppsJZ+pz9b5BtJgoXl3pZisVC8f9W9/XweTCodBLZW/eARh9OkIr75z78tqhS12
         OAXIkKiGnCB0DIiVG6uccCEuyYaxW+ktbVvpn17t6HxpzMhz665BYhvBRBSveu9yCVu6
         /wJPX1C4gM6sVz6s36Nelyq6nQBCJnozUrvGpanhiJouCqQMTcrnnMgZkIfzr0T5Tozl
         JbzJN06APxHNCFPdtytSW9cZtYSqpTFXdrFb0KnblyefJYoMwq5lQsCELJYLu2vSbmM6
         yeqg==
X-Forwarded-Encrypted: i=1; AJvYcCWF+M/hiOjB2H+g0i5wxCPHFn5wsTaqo97vDhbG0FEmuKaucS+SbBbt1E26IA+0dKl3QY6wOB2FDBVMgDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rWwh1/fBia2P4e55MtYsdkIPGW7VUiKxG7ELLm5YI96pD4MX
	NzEmW4cpU5xCWxb+7KjFYB2U7uyRZPr/HFDr43MBBHT4emwfNWxjsX31i78SYIPgxT9/i+Z3K9d
	oI7yH6cKwbDnp0EByNSZwg+uVOIcqwjUcCcHfz/GdHM6cUnOfNALUui/wjGV6SHdGuFY=
X-Gm-Gg: ASbGnct8pWYvtr1VaCTQl0mg3rOwh+Q+xHszmNZEEG6yipVMsRcMWndA9vUhWtjHhz/
	+osHp3QULuM4b6L04EuYvz8L1ArjZ+cpcqim0LDe62o9j2IumZvF5hfbBZmS/hUhUj8azOShr65
	73hCRvWPe6npZ6ViRBr4XcySHf+e+NydTR7ExkgdJrwMkCVWMo/PbLcLwumlOBYZFfdWk+6zfi+
	iZmP17+v6asYKxX5IfZLsMvbalMiQtqZBtpEz1tJELfSlhR6dfE5c0qL3WJq71Wq3bTOubQXPAg
	Tv4MiX1UpcVSNx5AZ76mSoNTabVsJIeBKAKCPlFtYUPaYqLiwM+jqco0jMPhyt/H+WAEdjG86a0
	+LMlC4s5Bf5/llenTQg==
X-Received: by 2002:a05:622a:1a26:b0:4ab:6de9:46ae with SMTP id d75a77b69052e-4b0f6267d03mr2669011cf.13.1754994437728;
        Tue, 12 Aug 2025 03:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcHGbLJllfiL6T0pXR0Qe7084myDh4JmZG4tqCEOLzDDsKtMH0MRvtexCeFrKzOU71x8TNjA==
X-Received: by 2002:a05:622a:1a26:b0:4ab:6de9:46ae with SMTP id d75a77b69052e-4b0f6267d03mr2668781cf.13.1754994437236;
        Tue, 12 Aug 2025 03:27:17 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af9f4796e23sm444380766b.26.2025.08.12.03.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:27:16 -0700 (PDT)
Message-ID: <0bda8e0e-4f86-458f-b55e-c5b0d6cd5c30@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 12:27:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: display/msm: qcom,mdp5: drop lut clock
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250809-msm8976-no-lut-v1-1-f5479d110297@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250809-msm8976-no-lut-v1-1-f5479d110297@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX7h9M2EhbEAl8
 h0Ky45Y7dJuXMXAqvKaxT398ZkHstDJQAR14EbhM2bBH2hV5PjBiZAfpsDzk/3rgw46SFrnClLf
 KE02k0SmNmd2NWWF5alEyk/62STHOHR+PonhZFK3EOeZ0fTwa8Z63yF7zG1M4stbqEnLJaLd7qh
 OHnUG60yxxPq2i0DN23uDm1raPafUDt56nni63DKsw01YUbTkmJWrc+V8fPof3mlRcWtsLZ+LJx
 DQPBABcmNMafr7XepzqwRY+pqEc1yzAWL7G0HIh4VLCSa8wrhkrmkwrPYS9qjuiCSf225Rdw1aV
 WMoSSnW7WQ706cHV0m6L7MiWQ1AYPxILwqIXqEgPhHf86wFOWMSa902gf277dm6NuA35JNa9j4g
 3jjRNXXn
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689b1707 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=vZF-wXTcH1iwIe0ERPwA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: Dj1PsSv6_Q9eqDpfydtrOF97tRxb7EL9
X-Proofpoint-ORIG-GUID: Dj1PsSv6_Q9eqDpfydtrOF97tRxb7EL9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

On 8/9/25 10:36 AM, Dmitry Baryshkov wrote:
> None of MDP5 platforms have a LUT clock on the display-controller, it

8974 and friends seem to bind it to the GDSC

although on msm-3.4:

arch/arm/mach-msm/clock-8974.c
4197:static struct branch_clk mdss_mdp_lut_clk = {
4203:           .dbg_name = "mdss_mdp_lut_clk",
4205:           CLK_INIT(mdss_mdp_lut_clk.c),
4609:   {&mdss_mdp_lut_clk.c,                   MMSS_BASE, 0x0015},
5118:   CLK_LOOKUP("lut_clk", mdss_mdp_lut_clk.c, "mdp.0"),
5387:   CLK_LOOKUP("lut_clk", mdss_mdp_lut_clk.c, "fd8c2304.qcom,gdsc"

Konrad

> was added by the mistake. Drop it, fixing DT warnings on MSM8976 /
> MSM8956 platforms. Technically it's an ABI break, but no other platforms
> are affected.
> 
> Fixes: 385c8ac763b3 ("dt-bindings: display/msm: convert MDP5 schema to YAML format")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
> index e153f8d26e7aaec64656570bbec700794651c10f..2735c78b0b67af8c004350f40ca9700c563b75f8 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,mdp5.yaml
> @@ -60,7 +60,6 @@ properties:
>            - const: bus
>            - const: core
>            - const: vsync
> -          - const: lut
>            - const: tbu
>            - const: tbu_rt
>          # MSM8996 has additional iommu clock
> 
> ---
> base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
> change-id: 20250809-msm8976-no-lut-4b5100bcfb35
> 
> Best regards,

